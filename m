Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553A9CA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 05:14:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC97R-0006RD-63; Thu, 01 Oct 2026 01:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC97C-0006Py-5f; Thu, 01 Oct 2026 01:13:54 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC97A-0000rJ-AR; Thu, 01 Oct 2026 01:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790831632; x=1822367632;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=eM5W6lIyprDSz+PN/nechw533+T2Obft0e437iQWdIA=;
 b=P9j38bJ+A+Sn0nTBF/6Rcow+uoXUTrLusOxUE9WtLeVXToOlbD3e+Alz
 camznA6MbDGY6giL4QcDENPH5W7Ut4U+diL55HzdhecTACXndPbtn8SR7
 bGBVJ8gs8PW34GY/ylZb2aV1uieA3ClR9RX9PaOZtrIa3FFkAlcSbzQ73
 1VrSSVKyw6Yi/DqXh0w0LW8VgoP8F8vMXMlYiupcj2Twd88vf0CPi4yoD
 gzkSIjIrResurBGWODTCf8oTb3GWy3fCNB5hA8C7O2kjLI26f2Le3PDj+
 XZ8ag1KFhPXy6csRtujW442TLwRn0HFrTPzWqPSKyJb/4v013cMd5Vr27 Q==;
X-CSE-ConnectionGUID: fxksNsGKTT+esyDSt05Uaw==
X-CSE-MsgGUID: +din1OJ9R8eHxTK+cshSzg==
X-IronPort-AV: E=Sophos;i="6.27,134,1786982400"; d="scan'208";a="157946169"
Received: from mail-northcentralusazon11010066.outbound.protection.outlook.com
 (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.66])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Oct 2026 13:13:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcQ0H8eDywjNXYBOh7y/xmXPUtHdIB9o0axIOon43046S49pOAzKA5rm0fWvRkontVyyRQjJlop8aIWwJ7BSLl4yjOnaA2qkJ5+YhYGylv+WAeMJaOUYR0A+0ZOaU8yulPmI6BSqCAIiV/mUv9dIJOV0U48FJtvFP+td9f5kSvJS9sveGBRTK9E1Yo7RqjUah7Vj7gE+W5Ff9VxsY6qu5FNs3XN69k34C1g9O4KRXLv6628YWB00d6sfUtrlCRskuon49mb3QF21LS1ndOcoc4jhO5ekVxjtBNvsHFgS9xbWVBgoLz4t8INwevETPG7r3GylVKQfLLsIm0GKGCPz7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eM5W6lIyprDSz+PN/nechw533+T2Obft0e437iQWdIA=;
 b=hGPluwxmoBUyp5Ay919LweJfzqEt28SNIoVTobVdFGL5clgQ53tABT1hkoBNV4T5ucqe4cA2qGcJoyC5IPT9tnGvfuxH3rJzmSwKc7p9hlE7kHl5MFAqu0MihJutZrIDyKOjDYu+fb+12xc/+J1pS55Km/7MF6myw5Gb+pXDbTglHW6n1YPR53JTfDJDKxtBLirVgbIczEy4NJjS2QJYnq4LKLCyYouTJT8zrs0aK3kiiGtQ5/6xl/lOTBHhgowWOG1JMfzamUS8nPAs3F605U2qVh+VitmaRl3v8ZRWaAJkoSxugMyuv1fzP06hh5/wYYfnb2WAPILoX4ql6Bds7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eM5W6lIyprDSz+PN/nechw533+T2Obft0e437iQWdIA=;
 b=FoMZTTMX3I/ofJv/SPHu0xDXDzpHb6akSH0PtVBzcS+4euW6RbTQw3uTVo8IogFem9vc8ZiWz2c3JX9j6YVnUIadVhCw2MFnACkPGzsno1iSDemX6Gold6rStuzSgQYQRC1T//g8JI0kBIrjAsJgrQrGIy0/MT+gqV8eqku9FhE=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by DM6PR04MB7114.namprd04.prod.outlook.com (2603:10b6:5:243::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 1 Oct
 2026 05:13:45 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 05:13:44 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "tgamblin@baylibre.com" <tgamblin@baylibre.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2 1/2] target/riscv: extract check_sfence_vma() from
 helper_tlb_flush()
Thread-Topic: [PATCH v2 1/2] target/riscv: extract check_sfence_vma() from
 helper_tlb_flush()
Thread-Index: AQHdPJ0/p8Df/noi/UOxFuki5l8kvrboTgaA
Date: Thu, 1 Oct 2026 05:13:44 +0000
Message-ID: <da32823965338403c1c6c1e108101c2a413b8b52.camel@wdc.com>
References: <20260904-riscv_tlb_page_flush-v2-0-defec3f29312@baylibre.com>
 <20260904-riscv_tlb_page_flush-v2-1-defec3f29312@baylibre.com>
In-Reply-To: <20260904-riscv_tlb_page_flush-v2-1-defec3f29312@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|DM6PR04MB7114:EE_
x-ms-office365-filtering-correlation-id: b790eb68-269f-41b1-7b40-08df1f7ac431
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|366016|23010399003|376014|19092799006|1800799024|10067099003|56012099006|11063799006|4143699003|3023799007|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: pXA8uOb3lOc746iBbwIZJykXuFtXUyaXCIFL3Ow9tMBFv1DjK1ddZ4JP+juY1ysNtqROyIAkmgQ4KCM2YzVi0tXhS+n261NvpCqygMfs2HJU3ZFw/2JWMjSwRMGvbN/WOo7R6x+tYciVzGGCS5gGkGBpSSer7tkQL2yLrFTKuP864VeD29c7MaT+IJpdFUYCIiiMIJtYy0VZCPdQ+kb6wjDUxLBscHJRUjO5tGghPjsdWJWGrvOMJl1M6OXj/8OGo1oA+YV9O44flVw+RIziJ1h8Cs24kj9zHbuODMExVmPTqCVISTg9C9wp9RsIl7pdcWwPAgP23ncWBVJtnyAhM8vj+3exRTjJGp9Ql98Fx+tV3Y7BpSXXAkrK6GbtJZiSrc34V/8Ac8k3uND/7bKaSV5wMA//JTfzsR8KVYRytvISKf/671/M4hHTDGxUBkRbHhkVOXPqyMm7nkaKqqA+a8bqhcFdcHpFNLYtZ9mY1mDSwxQZO48THpZt0P2mwtaZBiGdokD9KxoLRIWJByb/hMtPW7ucD7C+lTFEdtB+Irr1poe1e1xmq7w9wTRlA3bOCqQ9R40osQfoqPXX4k8d0u45/oefI4No4nwZhxYNHn5UGZYwMvzT0wenwz02RW9BfON8bz+NVxcmU6cwCpppayJNzdTWXFHc6Rc3yWZNhM05dE7Em84vk83cnnFMJxv/ssSaNamo+42HRnvuEo6OioKJLatjgUiSmvj6xuGf86k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(23010399003)(376014)(19092799006)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(3023799007)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHppaWVxVGdJVi9mc1lIRDRUZlRZR1o3TUdaWU1MNWJnb1dUY2EzZm9Ic1FI?=
 =?utf-8?B?ZUdNa0tDamRMSlpSRUFvYkNPY1NJbmJHZjBFMDJCWWxSRVRySjZ5dE1vUFJG?=
 =?utf-8?B?OHE4ZVBXRjk1d0NwNDFmUVdGTGcraldOSzI0Y3ZsanBiRHNMUFgzWDVuVmFC?=
 =?utf-8?B?RzNrR1RGdWZnYzNQUHZYUTBrcE9CNm5rTzVkdGVjTmhsY3dBdm5QaEFIajBn?=
 =?utf-8?B?SWZDQWY2SFZwRjdSUEJsYW4rbFF2NXZnc2VBb21VQzN4RUlUY1UzV09ic3Y3?=
 =?utf-8?B?MTl2VHMwUWgzZzNKVVZMZkcrYVNLVFN0T1VnSldQcDJkdm80OWdGTWhGTlhP?=
 =?utf-8?B?bEcrZzdnQWQ4SHU2bzFyTUlacVdmRGxsZmVuWE5NR1hsMDRXMmtFZVpKb2dq?=
 =?utf-8?B?TkxqK3YrU2tPVDBFOUVCQkdTbFJCdStBYkdlRlQ3M2VmNk1mbXYwU0Q0UFdm?=
 =?utf-8?B?dlluczB0bG5JcWlnNERlMWhYdmFtdXkzSEdCd3g2cnJIMUV5UUpjUzJaL1g3?=
 =?utf-8?B?ZnRaeVJ3VUgySFNLSkpxL2RxV0FmWGM0RmdhdG1aMVhSQW9QVVpqT3NrcTNk?=
 =?utf-8?B?bkcxVng1a3hyRDBvUzFPN2VVSGRlWWF4TGRZajQ1b1hZVHVtcXVxYmw0Z00v?=
 =?utf-8?B?MmExMytPT3JmSDNEdGJZOWYzVDVNUG9LeGZZRTZ3OVpQVmk4ZHBPTzhuTWxy?=
 =?utf-8?B?TWJIeXpRcDBBdFN1SDBoL2hXMjdrRzBtMUF2UzNvdXJVczVKQ2QwL1JucUN4?=
 =?utf-8?B?bjN5ZTYyZVBUMk1sUm85M1Vjb0gyWS9adVRhMzl5cnZUMjJld2sxUW9zRmdt?=
 =?utf-8?B?YVQxK2hQN2Jjc0hFTW5wbzc4VWdidENxWGc3Ti9GYktmUitoTkp5Uy9wT2la?=
 =?utf-8?B?MkVnc2ZZWjluZnQrS0RtYzA0OXVuZWw4NTZIMWFCWU12RGNQekdjclpYc0ZC?=
 =?utf-8?B?bnF0aDdyekZPNld4bVdhYlgyelZTK2pBZHZ4WUJPK1hzU3NZaDJpRE1wbWJC?=
 =?utf-8?B?R2k1WVd0SGRnWDZaRTZSWDZxUGoyMXVMK01Ta3c2SWlhM3pvamZEYld3RFJH?=
 =?utf-8?B?VEJ4SFNQME1WT0NZQjRMTlNLN2c0R1RNM0dKQkVJTVNvdzdRVEQ5QmJteWUy?=
 =?utf-8?B?M1NxWnpFbWlyR0MzeGNjb1pZcEVXKyt0dmtWRG1RWkNGc3JwZDJZM0VuN0t1?=
 =?utf-8?B?anpUekJkelFaUnEvNTRSbzFlNjFPYTUyMitodVJ3MWpCakFoNllDSFBmWThz?=
 =?utf-8?B?UVB1SzF1cW8zWmc4cy9IaE4zRnNuYnJqb2xhNG14QXBUaEUwZTBhN1cwd0Yz?=
 =?utf-8?B?V2FtT1dEVmw0Wlc5c3g2VzRmOFMvaWJOTGNmVklwdFhaaEFxS0I3ZWliV09B?=
 =?utf-8?B?MlJvVnZLYnJmK21ITmNJU0Zac01jL1FMQ2pYbFpNdi84SW9vQUFZM2xsU1Rw?=
 =?utf-8?B?SDVVb0ZJYTdwSnJuSEJ6RUE1NU1IaENrd3JvM0NpckhWa0V6bDNZWGYxZndw?=
 =?utf-8?B?cTNqVlFmWFBUamdDZGppR3A4akVoNVN2NExQZ1ZYQ2RLRzdnSXdUUXlJdDZx?=
 =?utf-8?B?eUFyQVcxWWhpaDdLS3BSVWZFejJTelY5OXdWV2J0Z1hXNEd3UENjN3lJSHJC?=
 =?utf-8?B?UHdGaG92ZTA4YTRZL2hmRVF0b3EvbzdVeitvZnBNem1rRmQ3QWIvUklidWVJ?=
 =?utf-8?B?eWVvSVZEM1pBN2tjN1BsaGRwSmgyYnNuSHhhYW1nbERxaktlMjlMclhNVkxU?=
 =?utf-8?B?SjMrS1pqZDAyZ3JVbnY3S3pubElHc243SzNyRzJ1UzhVd3U2RmxJczdMSmtr?=
 =?utf-8?B?TjhveUpiRUZWQTNYeG93bnJwTzhCbDdkQ0dlalJSZW82c3Fic2JWS0tHRnZ3?=
 =?utf-8?B?SFNhb0Q5dGdiV2k0WVVOeEsrVUJTZGw0NmNzNWQzbjJXUGVXcE5pWUNwcW9z?=
 =?utf-8?B?MEFrY01ITXhFSktQOU9WTnpoTTBwMG1jYmEzbWowR3JWYm9xMUlQcXJTNEdU?=
 =?utf-8?B?dzhlM1dDd1R0c0JRa0J2dzNscVZQdVhhdjdaeUdLYXdPZ2xBazJuYkJha3dl?=
 =?utf-8?B?eFQvb1JxMXd0TloyVzdVc25SaU1zSVUrMWIyak5BR0RwajhDRmU0YTFJeGVO?=
 =?utf-8?B?dWVneVVhbS9XbllkYkkyTFBhWUx0Vk5HSWxRdzltdTRUaVZzK1MzS0ZGVE9H?=
 =?utf-8?B?S2s4R0tLZXQzQnAwN0N4SlcwRjdQQTNQZFYyQVVITUlDTVNGYVp3NE1QUWow?=
 =?utf-8?B?Z3hwbVNmcllWSGRnaDhoTWVUSUVuMjZESE54ZUdtZ2d6RnoyN1FsK0ZSemda?=
 =?utf-8?B?YU5RZDBhbnpPQ3F2TEQzQTdycXFmQ3hiR0VxcTVNc1pGd216emdmWUlST3VR?=
 =?utf-8?Q?iXtPI3KjoTyz96PPymLCrSvHOrtLkJttpoolCnm5/fskH?=
x-ms-exchange-antispam-messagedata-1: y5VxmS33qfBC+uBACiHYzhHJcwA72CrNtMY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC8FE7596D0B3E448A3B6379B4A35BF5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: S7dx5bOF6eNf/vIH1w3FXi7V2A0E2EhGXl+wUWpo3TSHRNuLLfuSlfZJlJg8iUhXQ8p490yxiBexuBuIDSRNXLhRkOv7LPo1p7/UiWVdx9WUXG1TUXMDGXCKvXqrjEmjvy+rMmToQGDlYXsaDFdyXxxtjrs4ZoGkHRb7/fZNvLTRR/LIYqpnND1a3TgM1E5HY/8+f7ZpKQNFtW2x27rrAeHfCuaAHJ13DDsdepiRg9Mbx2vdz/6MIyYG5Oj5AZYmGZmrB2bk2KP5BjxwB8rcWYQ/BHp0kLJHho7WUwXnNHRUQVC2k7jkesMLUmzimSc1uz6/zyA6I80Jr1hQ8LlH+w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nzklTpJZwjt12ksde+1FB7ZwiDW8/vG9c5jhGpoyYELhgZ0EPdj4msR6nsBPgLdxkzQ9dQTq9bda3UuitqRXvZXvK5RIu/vRRlrz//sRs5Sim06C+A3hZHnLVPHKmuTfjxYZcwaAk94vxaQL8mQJElshK87oclz4lrBjZ04EG7HKxQkWcwVV8x9mxgg64QDtoVMLl2+daq5m4isvyDgJFg5supKXJj2h1Uw/uv8K4Qd+Ry/glvC9JJ1OrMPfsYe8r7jNwaC72SzvzjAE98gH9x3XY+tpnzT/uVQb1C5WEC3m3UF/dRvfIWi6EiWA/GuGGyRJ4DON40YjjWUaciunjYJs50KcUfPOG3u3ylkv2+y/zsgk3BKtLMXl9ZqZuhCncg1eDVFh63KuYBmQimNqOOenJW6PaEuU+6woGEeVCUwp07EskszwiMhvhkj0YpN3iTBD8kNWoqO9gU9nBzQzmXPm2jFfhZVeUl0DuRNyigIImO+G7IEFT8RBZAMmW3VHLMSRbPWgFpBEvyGF933hzh2zQeuZUtzwgs86kdrYaiOPpCTV/q2RXqrTqqLgRW0S1Nu1N9866kHXYLMHG7ms9ALwxbxA4J9RXKsGW9b2w/xRhzoqQRN810EBXgG0BIQg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b790eb68-269f-41b1-7b40-08df1f7ac431
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 05:13:44.7920 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CTmV0R3KACY7+WDb38Bu0UuTftV7bFj0IZDHwuG/8UwKI+K7kfSdErjAl4qKklxv0lCcPZ6Z0tQ2oUatbXxTFf6j1/GbLzP9TrbDQ9RdHa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7114
Received-SPF: pass client-ip=68.232.143.124;
 envelope-from=prvs=727d860e1=Alistair.Francis@wdc.com;
 helo=esa2.hgst.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

T24gRnJpLCAyMDI2LTA5LTA0IGF0IDE0OjQzIC0wNDAwLCBUcmV2b3IgR2FtYmxpbiB3cm90ZToN
Cj4gQ3JlYXRlIGEgbmV3IGZ1bmN0aW9uIHRvIGVuY2Fwc3VsYXRlIHRoZSBwcml2aWxlZ2UvaHlw
ZXJ2aXNvciBjaGVja3MNCj4gcGVyZm9ybWVkIGluc2lkZSBoZWxwZXJfdGxiX2ZsdXNoKCkuIFRo
ZSBpZGVhIGlzIHRvIHBhc3MgR0VUUEMoKSBhcw0KPiBhbg0KPiBhcmd1bWVudCBkaXJlY3RseSB0
byBpdCBpbnNpZGUgdGhlIGhlbHBlcl90bGJfZmx1c2goKSBmdW5jdGlvbi4gV2UnbGwNCj4gdXNl
IHRoaXMgZnVuY3Rpb24gaW4gdGhlIGZvbGxvd2luZyBwYXRjaCBmb3IgaGVscGVyX3RsYl9mbHVz
aF9wYWdlKCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBUcmV2b3IgR2FtYmxpbiA8dGdhbWJsaW5A
YmF5bGlicmUuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIu
ZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoHRhcmdldC9yaXNjdi90
Y2cvb3BfaGVscGVyLmMgfCAxNiArKysrKysrKysrLS0tLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQs
IDEwIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdGFy
Z2V0L3Jpc2N2L3RjZy9vcF9oZWxwZXIuYw0KPiBiL3RhcmdldC9yaXNjdi90Y2cvb3BfaGVscGVy
LmMNCj4gaW5kZXggM2U5NDAwNWQyYi4uN2Y2M2YzYWRhNSAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0
L3Jpc2N2L3RjZy9vcF9oZWxwZXIuYw0KPiArKysgYi90YXJnZXQvcmlzY3YvdGNnL29wX2hlbHBl
ci5jDQo+IEBAIC01ODgsMjEgKzU4OCwyNSBAQCB2b2lkIGhlbHBlcl93cnNfbnRvKENQVVJJU0NW
U3RhdGUgKmVudikNCj4gwqDCoMKgwqAgfQ0KPiDCoH0NCj4gwqANCj4gLXZvaWQgaGVscGVyX3Rs
Yl9mbHVzaChDUFVSSVNDVlN0YXRlICplbnYpDQo+ICtzdGF0aWMgdm9pZCBjaGVja19zZmVuY2Vf
dm1hKENQVVJJU0NWU3RhdGUgKmVudiwgdWludHB0cl90IHJhKQ0KPiDCoHsNCj4gLcKgwqDCoCBD
UFVTdGF0ZSAqY3MgPSBlbnZfY3B1KGVudik7DQo+IMKgwqDCoMKgIGlmICghZW52LT52aXJ0X2Vu
YWJsZWQgJiYNCj4gwqDCoMKgwqDCoMKgwqDCoCAoZW52LT5wcml2ID09IFBSVl9VIHx8DQo+IMKg
wqDCoMKgwqDCoMKgwqDCoCAoZW52LT5wcml2ID09IFBSVl9TICYmIGdldF9maWVsZChlbnYtPm1z
dGF0dXMsDQo+IE1TVEFUVVNfVFZNKSkpKSB7DQo+IC3CoMKgwqDCoMKgwqDCoCByaXNjdl9yYWlz
ZV9leGNlcHRpb24oZW52LCBSSVNDVl9FWENQX0lMTEVHQUxfSU5TVCwNCj4gR0VUUEMoKSk7DQo+
ICvCoMKgwqDCoMKgwqDCoCByaXNjdl9yYWlzZV9leGNlcHRpb24oZW52LCBSSVNDVl9FWENQX0lM
TEVHQUxfSU5TVCwgcmEpOw0KPiDCoMKgwqDCoCB9IGVsc2UgaWYgKGVudi0+dmlydF9lbmFibGVk
ICYmDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoZW52LT5wcml2ID09IFBSVl9V
IHx8IGdldF9maWVsZChlbnYtPmhzdGF0dXMsDQo+IEhTVEFUVVNfVlRWTSkpKSB7DQo+IC3CoMKg
wqDCoMKgwqDCoCByaXNjdl9yYWlzZV9leGNlcHRpb24oZW52LA0KPiBSSVNDVl9FWENQX1ZJUlRf
SU5TVFJVQ1RJT05fRkFVTFQsIEdFVFBDKCkpOw0KPiAtwqDCoMKgIH0gZWxzZSB7DQo+IC3CoMKg
wqDCoMKgwqDCoCB0bGJfZmx1c2goY3MpOw0KPiArwqDCoMKgwqDCoMKgwqAgcmlzY3ZfcmFpc2Vf
ZXhjZXB0aW9uKGVudiwNCj4gUklTQ1ZfRVhDUF9WSVJUX0lOU1RSVUNUSU9OX0ZBVUxULCByYSk7
DQo+IMKgwqDCoMKgIH0NCj4gwqB9DQo+IMKgDQo+ICt2b2lkIGhlbHBlcl90bGJfZmx1c2goQ1BV
UklTQ1ZTdGF0ZSAqZW52KQ0KPiArew0KPiArwqDCoMKgIENQVVN0YXRlICpjcyA9IGVudl9jcHUo
ZW52KTsNCj4gK8KgwqDCoCBjaGVja19zZmVuY2Vfdm1hKGVudiwgR0VUUEMoKSk7DQo+ICvCoMKg
wqAgdGxiX2ZsdXNoKGNzKTsNCj4gK30NCj4gKw0KPiDCoHZvaWQgaGVscGVyX3RsYl9mbHVzaF9h
bGwoQ1BVUklTQ1ZTdGF0ZSAqZW52KQ0KPiDCoHsNCj4gwqDCoMKgwqAgQ1BVU3RhdGUgKmNzID0g
ZW52X2NwdShlbnYpOw0K

