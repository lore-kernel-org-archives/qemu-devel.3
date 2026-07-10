Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE72C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi0u5-0002Ob-PZ; Thu, 09 Jul 2026 22:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=64494dccb=Alistair.Francis@wdc.com>)
 id 1wi0u3-0002Ns-A8; Thu, 09 Jul 2026 22:23:47 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=64494dccb=Alistair.Francis@wdc.com>)
 id 1wi0u0-0002PR-UL; Thu, 09 Jul 2026 22:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1783650224; x=1815186224;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=CUMWqjIv4ygZq168WWsgVL247cqo330ZZ9RSSOvHtE0=;
 b=EzhWVodSvzzNLLNqRlM+RkQPR2eOYgKTM3LVnGcfjRdnNVsbKc4GxK+t
 8IdS3kfpWXF4hwWsnCFWHU1fbrJbjy25Zbp+3UJA4rLbLvKrj20awJf7v
 R0sX2Bv8uMCPBSCrGkJg8WlgvvJ+3pA3PsR6CUSqrzRnef+qijecaCdWT
 prz9VT+wtWwrBtuTWvpXytX67d4Lte2rsOJLXxVwHVipJzocBgEMNOKe5
 krwTjpYSAy+2NMCV9vaD2/GxmYVPzMxWScrIXuRuEXtHMO4EnIF6QAirz
 Nkvry4PiAGF0d/qDqm0ALTf0uvafC+tKpZaC+tlljruU2cQrTIm7vkGw1 Q==;
X-CSE-ConnectionGUID: xfSRjbKyQB+lbaLUhC6VrQ==
X-CSE-MsgGUID: DEerYL+hS0ylLDsBCCH21w==
X-IronPort-AV: E=Sophos;i="6.25,154,1779120000"; d="scan'208";a="149206656"
Received: from mail-westus2azon11010011.outbound.protection.outlook.com (HELO
 CO1PR03CU002.outbound.protection.outlook.com) ([52.101.46.11])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 10 Jul 2026 10:23:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nTzu70NYljqjHbJhpDaJc0Qb9FOOz3gB9g8wW3RbbEasWHpvfd+F+VvFmE+e+Ew6GwlzwrGej74mXEW24Y797+204LX6tn5OhdM2uZw5fdFDjT6gq5McxF2buEaURC51ut94kQDfEkr7AGuQl0A6lNkaz6prn/VAZChXkmFxMHrxmM0G3DpqW4gb7FlS/SDbLfTmk2xF/ueAQRHlmwFr6W30rmktmkN2R/xSynXNnTU/2t2cBUp5SmSjXKtPsSEwY7qeOkvQ59BGjehjpAQIp4KKxv4EVVYx8R1DLeDv6ijt0vnpoBuokbjYrWz8yRgsE3sd+LHwNkCQHI6V6JIuMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUMWqjIv4ygZq168WWsgVL247cqo330ZZ9RSSOvHtE0=;
 b=YQemivkMnVEH9Kp5aVx92SI6lctNEN2kg1qg4j0dYfXpDj7SrW68eTvQekSX6DjiagIKcGT4kIBjnlt6ITasbWasuPQYZTwZTM94KUFtaWBEGrYHKGbjm6A2xzRIDe7dQdzh7cdiB8QbCjjIKyysALFu+8jG2OMVp7lsQAukwMZC7nwxehbthw3vBdzBILvcO77bp0RvfW8IaO+Wt9Y95TS1NwdqMGdpJbIMeGhNJ6X0bY2qzzmIb0KqkhnDUD50oVGXMTS4tkWxn56kIFPhcYCd0dNHaf4XJLh0FhSqA7TjAzWkrp2KXoRAIyEuCAWTVjhe1THa5RjHTzHFNwuQmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUMWqjIv4ygZq168WWsgVL247cqo330ZZ9RSSOvHtE0=;
 b=VR8PTufDvV4bmGiHLUNJg/M82brI5XkbOz/T9c3FRhPVZ0+rIg8dWcdPSkyWZPuhZC2CONXtcVBchlGMZDDuGHr83otX7aPQgXWjLmc+pOSa6eQkT0xC4FVm+mrGWPY9arjcCS4pOOIcq7onV83tYLEgRxDSBcMhTqp7q7nPFo4=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by LV3PR04MB9218.namprd04.prod.outlook.com (2603:10b6:408:26c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 02:23:36 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 02:23:30 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "imaginos32@gmail.com" <imaginos32@gmail.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>
CC: "chao.liu.zevorn@gmail.com" <chao.liu.zevorn@gmail.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2] target/riscv: check G-stage write permission for
 VS-stage A/D updates
Thread-Topic: [PATCH v2] target/riscv: check G-stage write permission for
 VS-stage A/D updates
Thread-Index: AQHdDIdajV4aiA/i+0yvLJG7BgoQ6LZmDSAA
Date: Fri, 10 Jul 2026 02:23:29 +0000
Message-ID: <8dc3208da0af8ecf733c4dad287090b66bf76fd5.camel@wdc.com>
References: <v1-Message-ID> <20260705140508.17692-1-imaginos32@gmail.com>
In-Reply-To: <20260705140508.17692-1-imaginos32@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|LV3PR04MB9218:EE_
x-ms-office365-filtering-correlation-id: 275ceb17-a53a-40af-9b6d-08dede2a3b69
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|376014|1800799024|366016|10070799003|23010399003|11063799006|4143699003|6133799003|22082099003|56012099006|18002099003|3023799007|38070700021;
x-microsoft-antispam-message-info: jViurRfRqHOxw25E65fKqetQ6gYkKTX6JUq0yXriz6nzxQitVVgco0kZFx5q5Q31GwPdq7JETcaPFOytq8g60Lzm8VyJeef10SkgP0hWQWAK4HF6PfyXvJ9BSDsmcnxMorEjwXe6iARmYf5GOoZRSeBYX7rqIypEaxPM4dzYEQVdqcJzfGeYLFTQGhWIwR/nqFTFkvjxNTX1deXr383GXVZqgve9pyvEsWbB0etR4v9aEb/GanRPGN5t1jYZUIYd4lQoqqeK3AiwA+LdqR/dOQdImnePvmjlTIgMFLglVTOoDd3j+QFB0w1WaEpuW0ne1+U6U1Ar0TPCjMNUXIaqh6V/V3LPbZvWuxneI5IeSpQCjp00047q8F56VcNKyobO2JOMSm5NdcpKWNXPKgsNNUS8MPDM91qNS/DGhcze9jE6ri2iNgVrLd92Slg1OALMZys93VoYiFeSQK3DgzLmh79tFFIIsag7+Y834rTEvwgZr+jWRR1WmwCqS+XhUzNG7xQ9E7ecrv6PyA+BdLr4DJbO5U6udu1RRYPL4pUGbndakbC5AoL98iBkJO31T585jMK4LD5MSNH4z0itMPgWOFvFQDt17O99Un304iCYq+k6i/5kghRyI7M5bUJx9iYB6IFSlOewWrQ1AVRU96TOUanrCCcDPKQXJhJr5nKejgzowGSpNZyZ2DUrN/f52FjoCyF3PAnBmWekvgFQsYply41PWxFwLevSQb+6ODsgqck=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(10070799003)(23010399003)(11063799006)(4143699003)(6133799003)(22082099003)(56012099006)(18002099003)(3023799007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzlUMld1ZDdKZEdpWmdQeWwyNmZKdFU5Y0tocHNvZlRpbGR3RXJHaWJIN09m?=
 =?utf-8?B?SitLZ2FPWnl5TjNMZnNNZ3lPZVI4a1MyQjNFZ05aRWlueUpDN3Ivd2FQK2Ez?=
 =?utf-8?B?dEx6WXBZL0ZxcE5LSkt6alYzUFhRM1RZRkE1aVlkNFRrY3g3bGtFckJsSjMz?=
 =?utf-8?B?bjdJV0hYTlp3YTRtUThlK3IrZmhaL2pBU3k0dyt5TE95bERseEU4NXd6RG1l?=
 =?utf-8?B?UzEvaGtvSjRxdkdKVXhGZ2NlRXBXL0FCR3BiNjA2bXdDUWdPNVQySlZVQlA0?=
 =?utf-8?B?dU12ZTZFU3J5NW1veWVnNFhNc21FUm1tYmdyMFhvdUZxVmw2aUpFMXBtRjZQ?=
 =?utf-8?B?VXJUOU5VRkU5VEs2Z3JKVk1ERzgxS045Uy84VE42Z3J3Sk5MbTM2M0dzbWph?=
 =?utf-8?B?b294S2QwR3hkcWFTL1Z4MHUvM0FsUXMwSHNmT3NFWE1aVmFRYVNQeGNDZGxj?=
 =?utf-8?B?dFg0c3lIaGxXdjcvZE1TNXBYKzg5NWFVQSs4MmdCdk5COEwvSXdKZmlwRHRq?=
 =?utf-8?B?TStLN2hvVzhnS1Zrd09zWks4TUFFZUl6TDhudnFkY21WV2lPMlhJRWpXSm04?=
 =?utf-8?B?dmJqTG9tZ2lXVWcza3V0MHFnYng5c1dkR1NMUWpHYldMYXhFTHVsMDRFVUNI?=
 =?utf-8?B?TkJaTHY4TVQveVVzWEN6MDFpb0tuUkh2L2lIb2F2bVd5S2dQY3RnM3dUYUhY?=
 =?utf-8?B?cFRFTEhLNGxsMDJ4S29qZDNLNmllbytMdUE5MldKemdXZjJ6YThJb1A0andV?=
 =?utf-8?B?SG05TGRUeXA3OXgyYXBYMEwwZUR6WWh5dWdTMlkvT1lPZTB4UFZWM09RWXVa?=
 =?utf-8?B?bmlzZHdGbGwzN2YwSFAwQ3ZLcWJoRi96VGJId0hld1pjUElxSXB2M0dseFZ4?=
 =?utf-8?B?NmlOT0dvaHFNZ1hSOExkZkJ6SVg1OW1SbjR0R0VCWjMwNElYbFNvU3ZBYmU3?=
 =?utf-8?B?ZXZuNWkvdFhINnpRSXd3ZEhDTXdEaW5lSHpHL3k4SlJQZk9wVFhOUnFJQ0tz?=
 =?utf-8?B?T042OHN6dmlBblBQd3hkR3E3RjBsL013WWI3cGZzV2FSYUZoVUt5M2dCU3NV?=
 =?utf-8?B?SE5lSHNSa1FFUzkrSXlWanRMamZkS3BQeExMT3UvTzN5Zm8vbGsraXBHMFBJ?=
 =?utf-8?B?TlhXcFhyQzJNeThEYUdNK3lib0JKZXRBOC9qWU5PcllSVkQ2VzhLV0JuaWdV?=
 =?utf-8?B?ZmJVZzlhak5vc0FVODRGWnF5SEdReGk0YlNxTVY5N0wzVG5Ud1NYUEV6NCtI?=
 =?utf-8?B?MWtlOGVmVGl6QSttV1FPd0lteGNxdWpobThLS29ndmU1MXRKQVkrODFNUnpI?=
 =?utf-8?B?UzVSZG5lSFlYOXowK094V3Q3aS9GR0lDQkJkbExGeS9JVTFjbzJYM3VBS2dL?=
 =?utf-8?B?OTVmcDRBWGI2WGxnVkFUMmRzMmhZRDVKdXNMVXowdyt2RVBMdmc5bUlVZENy?=
 =?utf-8?B?Y1hvWnl1WExCMTRUVVMzczFXZFgrNjRyRC85M1dKbThOL2pBcmtsOTZXZnJ1?=
 =?utf-8?B?d0NseHpqbUFnS1NHYzY3MjdOZ2E1eDlPeldqdzBsNzhXMjZIdHFiWDhXVmZK?=
 =?utf-8?B?N2pPMWNsT0I5T1g5V1pGZDVQOUZnQktjcUQyb1EyZkVhYmQ1dUN0ZGI1Wkow?=
 =?utf-8?B?d0M1OFVWOGRrMTIzcDBkNlo2R2w0cWN1OTRvYmVUa1VPMXFiSmdGczlyQkN6?=
 =?utf-8?B?dUE1U0tya0VIeTYzR1k4RS96RXp0aUxJY1JkVitYdWVvRUo5T2J6RzF0Z3ZG?=
 =?utf-8?B?VG11Q2xxY1IycWhsWjJrNVpHNFRHenhQSW9zSjE1Nm5UK0VCckdzWUx1ODAz?=
 =?utf-8?B?VUZKUkdEcUcwVm5TSGM5VGxTSnBqUFRrZE1BWmtQRDNCRkROL21PNFpZWjk5?=
 =?utf-8?B?QWwwWENySWEyZ2p1VEVBcHl3NFZRclJNbTE5UHI5OUNpbjlJY2VSd2I3V3FP?=
 =?utf-8?B?UFlmblMxZ1hzV0dTaXJ4eTF0dStNNjZEcTRmOWtSU05wNE1WVmllMnRGWHhs?=
 =?utf-8?B?ckloaXJ5dUVDOE51TUlvdEI5eUlMa2xML1BHV3JBWUVZMmp2Mk11d1pUNkRH?=
 =?utf-8?B?aUNSZWk4YjJpRjFNRStMdWorZEQ1ZURydWlqeGxCdDkyNHdrZktVcWtoendn?=
 =?utf-8?B?TWkxZDhmb3I4K0xnWVZQYUxRVGZKb1NzMCs2a0hvVVN5OUJVcTJhT3VlVjFn?=
 =?utf-8?B?RmVuNVZ5M0xIVTZjYkNlVnNXUkVjamNFMkFrT2xUZEpQNlJCMXFPMUpWMTNJ?=
 =?utf-8?B?R1lzNktjajk4K081alNweUUzNW9oZ2JTUWxQVmgwQXp6NDNlL1B3NG9IWkly?=
 =?utf-8?B?M2IyMWswcDkwdHZmeDRlWUVjU1I0VHJKMzNjT1cxcGMzc2huMDVCcTZOcTNX?=
 =?utf-8?Q?/Ky/R1cBpsLHAs3Txz8jImNSeKYQFtUu6iFvCjxdCPhui?=
x-ms-exchange-antispam-messagedata-1: WZuj851dnxP7vq4RcWL/4CKrELVtI4fwF/k=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53609F044688D54384DFD5EC8B1D8B84@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: exRgFef03lmyGHMLOgcHPl5l1mfQDJKA+qg8NPqRYVWhKv0/b4ADJba9iTtm6wQMRzCcvV97PkqDPHna9npFnM7sgcQ0gm0zT6qXKAivLi7HxMBxjT4xmjunTSy+M59CinJvAYlw0zzzS5l7uglhD+jkQzA2yMRsZCAShRovI08emu5S9cCCdpPqu2xdzDBDMtfz1++pJQPFx+MjXFAwPTnlqYqHt7hnXc2Abopu0yNo8u/eGY6amUzqLAuAIPbkzjs8C01FPUpWsGwv25j/9ES3pzPu1+IBU2PieW+o+3SyYd3kqZGeUv7GQYRiST6lsj1HuiIH2HeGlS5TdRoHKQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: L8cLZxEmoGgia0ac9auggzJ6cUGlxvq4Qsjnji7rLbcExBW24Y8M1jQIBTKiXQNPkiEaK2wYE8JXX99u4/UAgmWIo+XEEyVYs1Ceh84zAPcS0IWBsfqMUzQuO63C7kszWw067JW6yVnHSDgmGmsGDKETHkP9SLorPUhWuYKc8qiRRvB9zzPk8LcLc6A8pLAK8z4gqyUiD/4meNL7Ugi+eFmOFhhUXCH3se45/OFmwtmZJrBzDvmsQ4HVVjPC8wnoUmdYmDnsMcFKwnNKVadVAlGA/t/GRFyMKD8V/fvrkBsOmjkuEAK2UlZH/Znmw0oIkhTicJOIo7Ql5aorSQXjEMt9LKvkN2hUIbFEvUK/rAxb9hAp3AEST+jdPoZeQQ3HWy6zrTF+nDrPX3MBQ1JtjW0pdd71yrEJVj581wMP8LdB1RrrF0E9NMY9TPR3N4+rEpAFwIBR85WxNXKNsCKXiM8x5g23QtsUbFQZNOgHv2zqU6QxoKnecBsDNQJQ8plwFXnu1pWnwCXWgvuSeDwbRWYTr3a77aYcgmu8EOZgEJt6ys20xzcQ2Qz7swzfXbgFkwszYYU426IPHCwYLJnCxd0JsgDj/N0aHeyEsGErXF+q4sz6CSWZw8LC7gjuk/+Y
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275ceb17-a53a-40af-9b6d-08dede2a3b69
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2026 02:23:29.9620 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 01XB+VqnbSeta2xmGXP1MONyisX1hJs5oc5T1FgNczkvTmgVGalrJ1Plkl7oqLHFtqM8AiWHqqm+LM6SXiJGkNIwiCH/eNExrP1iu6wZxJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9218
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=64494dccb=Alistair.Francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

T24gU3VuLCAyMDI2LTA3LTA1IGF0IDE2OjAyICswMjAwLCBpbWFnaW5vcyB3cm90ZToKPiBEdXJp
bmcgYSB0d28tc3RhZ2UgKFZTLXN0YWdlICsgRy1zdGFnZSkgcGFnZS10YWJsZSB3YWxrIHdpdGgg
aGFyZHdhcmUKPiBBL0QgdXBkYXRpbmcgZW5hYmxlZCAoU3ZhZHUgLyBtZW52Y2ZnLkFEVUUpLCBh
IHN0b3JlIHRoYXQgcmVhY2hlcyBhCj4gVlMtc3RhZ2UgbGVhZiBQVEUgd2hvc2UgYWNjZXNzZWQg
b3IgZGlydHkgYml0IGlzIGNsZWFyIHRyaWdnZXJzIGEKPiBoYXJkd2FyZSB3cml0ZS1iYWNrIG9m
IHRob3NlIGJpdHMgaW50byB0aGUgUFRFLiBUaGF0IHdyaXRlLWJhY2sgaXMgYW4KPiBpbXBsaWNp
dCBzdG9yZSB0byB0aGUgUFRFJ3MgZ3Vlc3QtcGh5c2ljYWwgYWRkcmVzcywgc28gaXQgbXVzdCBi
ZQo+IHBlcm1pdHRlZCBieSBHLXN0YWdlLgo+IAo+IEZpeCB0aGlzIGJ5IHJlLXJ1bm5pbmcgdGhl
IEctc3RhZ2UgdHJhbnNsYXRpb24gb2YgdGhlIGd1ZXN0IFBURSdzCj4gYWRkcmVzcyB3aXRoIHN0
b3JlIHNlbWFudGljcy4gZ2V0X3BoeXNpY2FsX2FkZHJlc3MoKSB0aGVuIGFsc28gY2hlY2tzCj4g
dGhhdCBHLXN0YWdlIHBlcm1pdHMgdGhlIGd1ZXN0IFBURSB0byBiZSB3cml0dGVuLCBhbmQgcmFp
c2VzIGEKPiBndWVzdC1wYWdlIHN0b3JlIGZhdWx0IHdoZW4gaXQgZG9lcyBub3QuCj4gCj4gUmVz
b2x2ZXM6IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVtdS8tL3dvcmtfaXRlbXMv
MzQyNgo+IFNpZ25lZC1vZmYtYnk6IGltYWdpbm9zIDxpbWFnaW5vczMyQGdtYWlsLmNvbT4KClJl
dmlld2VkLWJ5OiBBbGlzdGFpciBGcmFuY2lzIDxhbGlzdGFpci5mcmFuY2lzQHdkYy5jb20+CgpB
bGlzdGFpcgoKPiAtLS0KPiDCoHRhcmdldC9yaXNjdi9jcHVfaGVscGVyLmMgfCAyOCArKysrKysr
KysrKysrKysrKysrKysrKysrKysrCj4gwqAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygr
KQo+IAo+IMKgdjI6Cj4gwqDCoCBSZXdvcmQgYW4gaW5jb21wbGV0ZSBzZW50ZW5jZSBpbiB0aGUg
Y29kZSBjb21tZW50Lgo+IAo+IMKgVmVyaWZpZWQgYWdhaW5zdCBTcGlrZSwgd2l0aCB0aGlzIHBh
dGNoIFFFTVUncwo+IMKgcmVwb3J0ZWQgdmFsdWVzIG1hdGNoIFNwaWtlLgo+IAo+IMKgU3Bpa2Ug
KHJlZmVyZW5jZSk6wqDCoMKgwqDCoMKgwqAgUUVNVSwgYmVmb3JlIHRoaXMgcGF0Y2g6Cj4gwqDC
oMKgIG1jYXVzZSAweDE3wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtY2F1c2UgMHgxNwo+
IMKgwqDCoCBtdHZhbMKgIDB4ODAwMDAwMDDCoMKgwqDCoMKgwqDCoMKgIG10dmFswqAgMHg4MDAw
MDAwMAo+IMKgwqDCoCBtdHZhbDIgMHgyMDAwMTAwNMKgwqDCoMKgwqDCoMKgwqAgbXR2YWwyIDB4
MjAwMDAwMDAKPiDCoMKgwqAgbXRpbnN0IDB4MzAyMMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBt
dGluc3QgMHg2YTcwNDA3Mwo+IAo+IMKgSWYgSSd2ZSBtaXNyZWFkIGFueSBvZiB0aGUgQS9ELXVw
ZGF0ZSBzZW1hbnRpY3MgaGVyZSwgSSdkIGFwcHJlY2lhdGUKPiB0aGUKPiDCoGNvcnJlY3Rpb24u
Cj4gCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9yaXNjdi9jcHVfaGVscGVyLmMgYi90YXJnZXQvcmlz
Y3YvY3B1X2hlbHBlci5jCj4gaW5kZXggMmRiMDdmNWRmYi4uZWIzNGJhMTllMSAxMDA2NDQKPiAt
LS0gYS90YXJnZXQvcmlzY3YvY3B1X2hlbHBlci5jCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdV9o
ZWxwZXIuYwo+IEBAIC0xMzcwLDYgKzEzNzAsNyBAQCBzdGF0aWMgaW50IGdldF9waHlzaWNhbF9h
ZGRyZXNzKENQVVJJU0NWU3RhdGUKPiAqZW52LCBod2FkZHIgKnBoeXNpY2FsLAo+IMKgwqDCoMKg
IGludCBwdHNoaWZ0Owo+IMKgwqDCoMKgIHRhcmdldF91bG9uZyBwdGU7Cj4gwqDCoMKgwqAgaHdh
ZGRyIHB0ZV9hZGRyOwo+ICvCoMKgwqAgaHdhZGRyIHB0ZV9ncGEgPSAwOwo+IMKgwqDCoMKgIGNv
bnN0IGh3YWRkciBiYXNlX3Jvb3QgPSBiYXNlOwo+IMKgwqDCoMKgIGNvbnN0IGJvb2wgYmUgPSBt
b19lbmRpYW5fZW52KGVudikgPT0gTU9fQkU7Cj4gwqDCoMKgwqAgaW50IGk7Cj4gQEAgLTE0MDcs
NiArMTQwOCw3IEBAIHN0YXRpYyBpbnQgZ2V0X3BoeXNpY2FsX2FkZHJlc3MoQ1BVUklTQ1ZTdGF0
ZQo+ICplbnYsIGh3YWRkciAqcGh5c2ljYWwsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0K
PiDCoAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwdGVfYWRkciA9IHZiYXNlICsgaWR4ICog
cHRlc2l6ZTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwdGVfZ3BhID0gYmFzZSArIGlkeCAq
IHB0ZXNpemU7Cj4gwqDCoMKgwqDCoMKgwqDCoCB9IGVsc2Ugewo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBwdGVfYWRkciA9IGJhc2UgKyBpZHggKiBwdGVzaXplOwo+IMKgwqDCoMKgwqDCoMKg
wqAgfQo+IEBAIC0xNjYxLDYgKzE2NjMsMjggQEAgc3RhdGljIGludCBnZXRfcGh5c2ljYWxfYWRk
cmVzcyhDUFVSSVNDVlN0YXRlCj4gKmVudiwgaHdhZGRyICpwaHlzaWNhbCwKPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmV0dXJuIFRSQU5TTEFURV9GQUlMOwo+IMKgwqDCoMKgwqDCoMKgwqAg
fQo+IMKgCj4gK8KgwqDCoMKgwqDCoMKgIC8qCj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBUaGUgaW1w
bGljaXQgc3RvcmUgdGhhdCB3cml0ZXMgdXBkYXRlZCBBL0QgYml0cyBiYWNrIHRvIGEKPiBWUy1z
dGFnZQo+ICvCoMKgwqDCoMKgwqDCoMKgICogKGZpcnN0LXN0YWdlKSBQVEUgbXVzdCBpdHNlbGYg
YmUgcGVybWl0dGVkIGJ5IEctc3RhZ2UuCj4gUmUtcnVuIHRoZQo+ICvCoMKgwqDCoMKgwqDCoMKg
ICogc2Vjb25kLXN0YWdlIHRyYW5zbGF0aW9uIG9mIHRoZSBQVEUncyBndWVzdC1waHlzaWNhbAo+
IGFkZHJlc3Mgd2l0aAo+ICvCoMKgwqDCoMKgwqDCoMKgICogc3RvcmUgc2VtYW50aWNzLiBJZiBH
LXN0YWdlIGRlbmllcyB3cml0ZSwgcmFpc2UgRy1zdGFnZQo+IHN0b3JlIGZhdWx0Cj4gK8KgwqDC
oMKgwqDCoMKgwqAgKiBhZ2FpbnN0IHRoZSBQVEUgYWRkcmVzcy4KPiArwqDCoMKgwqDCoMKgwqDC
oCAqLwo+ICvCoMKgwqDCoMKgwqDCoCBpZiAodHdvX3N0YWdlICYmIGZpcnN0X3N0YWdlKSB7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IGdwYV9wcm90Owo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGh3YWRkciBncGFfcGFkZHI7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW50IGdw
YV9yZXQgPSBnZXRfcGh5c2ljYWxfYWRkcmVzcyhlbnYsICZncGFfcGFkZHIsCj4gJmdwYV9wcm90
LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwdGVfZ3BhLCBOVUxMLAo+
IE1NVV9EQVRBX1NUT1JFLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBN
TVVJZHhfVSwgZmFsc2UsCj4gdHJ1ZSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaXNfZGVidWcsIGZhbHNlKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZ3Bh
X3JldCAhPSBUUkFOU0xBVEVfU1VDQ0VTUykgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaWYgKGZhdWx0X3B0ZV9hZGRyKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICpmYXVsdF9wdGVfYWRkciA9IHB0ZV9ncGEgPj4gMjsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybiBUUkFOU0xBVEVfR19TVEFHRV9GQUlMOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IH0KPiArwqDCoMKgwqDCoMKgwqAgfQo+ICsKPiDCoMKgwqDCoMKgwqDCoMKgIHBtcF9yZXQgPSBn
ZXRfcGh5c2ljYWxfYWRkcmVzc19wbXAoZW52LCAmcG1wX3Byb3QsIHB0ZV9hZGRyLAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN4bGVuX2J5dGVzLAo+IE1NVV9EQVRBX1NUT1JFLCBQ
UlZfUyk7Cj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAocG1wX3JldCAhPSBUUkFOU0xBVEVfU1VDQ0VT
Uykgewo+IEBAIC0yMzQ1LDYgKzIzNjksMTAgQEAgdm9pZCByaXNjdl9jcHVfZG9faW50ZXJydXB0
KENQVVN0YXRlICpjcykKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogZG9p
bmcgVlMtc3RhZ2UgcGFnZSB0YWJsZSB3YWxrLgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKi8KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0aW5zdCA9IChy
aXNjdl9jcHVfeGxlbihlbnYpID09IDMyKSA/IDB4MDAwMDIwMDAgOgo+IDB4MDAwMDMwMDA7Cj4g
Kwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGNhdXNlID09Cj4gUklTQ1Zf
RVhDUF9TVE9SRV9HVUVTVF9BTU9fQUNDRVNTX0ZBVUxUKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRpbnN0IHw9IDB4MjA7Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB9Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0gZWxzZSB7Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyoKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgICogVGhlICJBZGRyLiBPZmZzZXQiIGZpZWxkIGluIHRyYW5zZm9ybWVkCj4g
aW5zdHJ1Y3Rpb24gaXMK

