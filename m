Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D519C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 05:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1zk6-0000d5-QU; Thu, 03 Sep 2026 01:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1zk5-0000cB-EB; Thu, 03 Sep 2026 01:12:05 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6997dc6e7=Alistair.Francis@wdc.com>)
 id 1x1zk3-0001v1-0y; Thu, 03 Sep 2026 01:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788412323; x=1819948323;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=yEkQ7LWHZCtVzUf0POCB2ufvn5ZjiqiJDq5UgjN/MO8=;
 b=MfhuzJKpFGgWKHMnDqSS1pP/M5BK8rAIe8MoRC/BYhtAPIVDxCx9PVrh
 dUTP+rkL4I4QB7jSU+hXTVjAgpGS6zvQi67BBrtNqM9ALKSlzl+7wlEHG
 UJmvwqBbJKXX7uCXimqE+Y/Rhbs4o6tXkESCRTaS5liNhWjpoBChKaUFa
 OAERKLR68hF9QIaXk118GQTXis90L7t2E3weepV5+QIeoOreN7krsudkN
 WrlXM4DlHSYBrOykXXMsOk7YI2GEZuS6eweA/dRbqITxOHOTZR0ij+JXy
 BFjsdHBJk6a9Rf2zHvEcGaloUXRg1MB97ldJgVL4NT5t6MNFa+aQVdrI0 w==;
X-CSE-ConnectionGUID: MZepZ98qRjCNM7pt+VaqIg==
X-CSE-MsgGUID: koOZAxG5SESqDO1gUPzOjQ==
X-IronPort-AV: E=Sophos;i="6.25,258,1779120000"; d="scan'208";a="150643139"
Received: from mail-westus3azon11012035.outbound.protection.outlook.com (HELO
 PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.35])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 03 Sep 2026 13:11:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAXb6rYfJzoOJ6Qj0bY3Ie41riy7vuke+5WMCFskr+9e/TAJ7AR8ogzJgiPM+dXJpRj6F9lzlb4NjJWdatiZ5DqKdtbXXY0ARJwA5Pa/7GZor192v7FEj1jsBOPXQ30Yjd1S6VOxyZPqwGYCT/2D/xYviEu9BQb8ed6KQnZHx73r5t6rfQP06ssoI+nciZBVb8Y+TpY1LqZgIP4PbG+B1GKLidjcNlaa/P0PLmjk8aQd4q454ZTwa7JIbBhk6NeWrtD4Ukcq+1ewP2psR1bXZkhQwbL+5EMQXklAGhVf5wz5Y84CRcSjlQokpd56g25Maf53vhioHCB9he2Gh57nRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yEkQ7LWHZCtVzUf0POCB2ufvn5ZjiqiJDq5UgjN/MO8=;
 b=hRjfcaYjkfYMkfvuT3HzhH7G60Qhmo/8VJl238LZBvzW8pH8rUzMBnaJNY58PnF+mNma/tvv1S3LMJx/znfdKH4hVFZmiFf6m3YgDVSzBxvYJsAo/qe0sNZ/pqD70tc3VtoG9toFxyLljC3hFUbvaGRtzWzm+dORTQIetlzlfttgeANmL6o8C0cJCmxekHaBnnv/AQzZi+nMk8izt2PRdlEO3xmjZQGyAaqsT1Z129e/GbNO+JgkjkiNdO03kxgjZPho2dDs9/WVzyC+wANY9k54wg5V7ysd6CzZgBfmNcEhNUHUTRywdbmXvphOkiipEBmG8dHKLsWnopjTnlcMSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEkQ7LWHZCtVzUf0POCB2ufvn5ZjiqiJDq5UgjN/MO8=;
 b=vHDVmLH8iA4++wdO2J58k4HJmc5dufLNMOYLx6fFKCQR2fSyDJfE5yA0cS2sH1UEI5DJfdXW6Jo1TL5HuyfnsZCbbY0Z2x9Z5r+c7P8/hZ2rkXxA/UU72zOH3/ovDQd5sAJRIJQakXuPvboQWAASd4WQGDY95i9qPOXsl5mhVuY=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by BY5PR04MB6390.namprd04.prod.outlook.com (2603:10b6:a03:1e2::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 05:11:56 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 05:11:56 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "anjo@rev.ng" <anjo@rev.ng>, "bin.meng@windriver.com"
 <bin.meng@windriver.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "heiko@sntech.de" <heiko@sntech.de>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, "daolu@rivosinc.com"
 <daolu@rivosinc.com>
Subject: Re: [PATCH v5 1/1] target/riscv: Add Zihintpause support
Thread-Topic: [PATCH v5 1/1] target/riscv: Add Zihintpause support
Thread-Index: AQHdLaHv1MlZgpyp4UiSDGnVnpH7+7a8ajWA
Date: Thu, 3 Sep 2026 05:11:56 +0000
Message-ID: <59968b453cd958a23aa39ad23d456b925acc3dcc.camel@wdc.com>
References: <20220725034728.2620750-1-daolu@rivosinc.com>
 <20220725034728.2620750-2-daolu@rivosinc.com>
 <0f89046e-6889-42a4-a967-0bfaaab869db@oss.qualcomm.com>
In-Reply-To: <0f89046e-6889-42a4-a967-0bfaaab869db@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|BY5PR04MB6390:EE_
x-ms-office365-filtering-correlation-id: 28e40e0b-bf58-40f1-e2a1-08df0979dff3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|23010399003|10070799003|1800799024|19092799006|376014|366016|38070700021|6133799003|56012099006|11063799006|4143699003|10067099003|3023799007|18002099003|22082099003;
x-microsoft-antispam-message-info: EBB40U91WHDccucswKlBKuyYNFY3KT0RUsEgjo5ASjeu6c2wN2vKTuU3kSaRZxbruYgI1/vtt9fPt1bsb2W4r1QhCzJQOV9FlhaiZZLrPlBeg0jAP+GaZMZm0GE9U/SE4jqW81MKRFcvm+y7NNw5fykN5AZyj7KEENWDKXUX7d5LcQWHif1CXxo+6IOEznrNgwHwdTUFr5hqu367cDPv7TZVX/MJXme7xovOFayMDXoxn1F1tisVeDo/br1wl8z1K8WqgiFcAjsf3ABOo9qMvHlBZ7ITzuszlJnndmRUxPd/SltwMrFpTGse6eFVTDmeVzRWA0LbTgPlFhmpNMWSCtlIDd3+FHRGDc9+Hb5lcZ2NIVh12UMnCo3mbtoGSbI+j9QNBwdGb0+MC9fgPKxFrBCgILVUFvkQeBTn95h7yEEQZf3ucdW8tt77XdstHSoe+9zzHo7IHpxRDhuUQYWgn+sTBBSPDEsxQa0C6Au3y/hnKCb3EiXZvUnBs24dXDiNkXMkuK2TtTqMa0W3Q1/wOSwTKnkOHDqf8eVXLWoAVLX1i83XSyAQQRZy+HxojKLJOB/mF1ODnO1lzxds/UiWg7dKxJVmfbOJEaaYLvJvYlRVcD0P9V1Fm+1zANB2HMr33X5eolZAMxjq/dr8QQ+Exg+PJpZacu7nWJW1b/DgnZhffxPlwzSaJnMb1Eh8pPrGaZNikHH/QCwDtLVsvsKuCQTw6N06AnhaZMQu+njbHC0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(10070799003)(1800799024)(19092799006)(376014)(366016)(38070700021)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlVwNWZWSFBVRUhTczRKYndQZDlrTXhRTmMyR1FyNkNPaVU1RlJZUjBEemI4?=
 =?utf-8?B?Ni9xdlpDV3U2bGYrNlRhVE9KaUZmNFFsOVpoUDU4UjdKNldGek9BMDVGNGg3?=
 =?utf-8?B?c3lvcEhyNHkvYWkrNVlKblJLVEJrR0tUMk00Y3VjdldKcTY5QVVDMGJBOTIx?=
 =?utf-8?B?Sk9OTVpYQmlyeEJLWWlIckt2V2k1ZGU3SDFMN3F0UStWVlhDc0pLWW9JMGlr?=
 =?utf-8?B?UVdyc28yakozaFNQd3o5TFpSK3VVTzlJQ210eVB3aHlvakNQNjNqMUNJTFFO?=
 =?utf-8?B?QWZvbUZHMDRtMS9icVFIZU54S0FkMmV1cDJLZGFZUHFmemNrTEVaQW1HeE5M?=
 =?utf-8?B?bVVQdkY4U0dOcXM1MjlzSkVrMmRHUldQUUVIZjNEdkFVa1FJZ3NIeE1OaVdM?=
 =?utf-8?B?ZGs2SWtOTjF5Mm9HK3ZXUjcyYXd5MUJFNzdKSTlsSHFsMUt2MU4yRWxDSThQ?=
 =?utf-8?B?bkNQS1VFQXJZOFoxc3RCSURCNFYyRTNMV1ZzcWQ0UnFGb3RoR0drT1dCS0Nv?=
 =?utf-8?B?bGxYUHBEdTA5eVBzdDkzUnU3bThaWkw4N1ZqUW5QeGptWHdzQUtQV2hVNGlP?=
 =?utf-8?B?TU9OTVAvT3hlNUd5bFFEMjhsMHJMb0N6MDJITGt0RWNrUHlsUlk2VkJ4d2Np?=
 =?utf-8?B?Z3NmclNjelh2S1k4bkNEMGRmZ2pwTmJveGdremxLeVRFV3Z5Q3VUUURVb3o2?=
 =?utf-8?B?aUZBdWZ0bHVzWGRiUEpUUlJqSWxXb1ovLzZZSUlRVG5haE16NVNEd21SWnhT?=
 =?utf-8?B?UFh4czhRYXVUQjNIaUxKWEZkbUhFcnBNaHVWNURqMjFGeVp3cG5Wbk9FZWF3?=
 =?utf-8?B?UXR1dU8zSC9uV3FsY0FwTmo4bDN3SFdBLzA3aStYdDd1MHJlalArdHBoZU8w?=
 =?utf-8?B?ZXQvaHRHSlpadnlPbjBPSER5OHh4bHpiTXNuMDdycnVoMHVENE5WSVN2Q0xp?=
 =?utf-8?B?c0pWdjI2OHVpcG9WK0FtWEdMZHdsTlVoWHpDOXBQK2JaZldtM3pBNnI4azlV?=
 =?utf-8?B?aFB4WWVxWHNEdUFJSlBWczhaRE1GT1hoeDBQaDZicFpZRjgzOVBtRzFJNU5B?=
 =?utf-8?B?aEFMY2t5ZDZCb2NDaHNlZVNCNEFMNVFaTHl3cWhXaW1RQjZ4TEdwUjM0dDNy?=
 =?utf-8?B?bWVseVlIQlNxZEtBMFNIU3NXeXA2RjgwTVVBZUpWWllJbVpFcm12bnpxT0JG?=
 =?utf-8?B?Z2crV1dmbVJNaGoxZm9VVU1SdFJ2M05kTWRNK2cxckZSN011VFFNM1ZzL2Jj?=
 =?utf-8?B?VUpkaEhScE9WdVQvRDZna3hvZTFHaW9IWkt6MVhPK0hHNyt1cFowYkJpTFZ3?=
 =?utf-8?B?aFF2ZUJxcHZhMnNNREFuQ2dUeWpyNDR6OGNhZ2ZNc004TFZzRGxURThWRWgx?=
 =?utf-8?B?ejhibW55NGgremVtc3RLeXBMdDVMbHlLSlJ4TFdLRUplUXlKaW4rY1ZNbGFT?=
 =?utf-8?B?ZmZTWEtJZlQvRkM0VE0vTlBVWVZFd1l1WnRpYWNVZXhhQ0tMcGJ3QXhSc20v?=
 =?utf-8?B?aVNMMGlnVytCYUhITzJjYmRDY3U4dkhBMUVPOUxVd21adEVEeEFjeUhLYjh3?=
 =?utf-8?B?Zm4wdHJ6MW54YnpMRm1GNmVOWlRZY2xsejVPZ05wNWZtVGlXTEtCc2RET3hn?=
 =?utf-8?B?UHJkN3NwTm9EcTZGVk4yUURwN2FObE10S0tsQ2l5UFJqS3NOMTBGUklBTENY?=
 =?utf-8?B?cUxiNzh1SEJBVkluWi95NzgrSTNGSUZDcDFvajFmUWgxQURCMThlZEZnNytj?=
 =?utf-8?B?cXoxQiswSGU1WlF0UlZZdk9xSFhaNHpkeHAzOUhMUUdxMTgyYXB4Z2dVSzM3?=
 =?utf-8?B?VmxZZ2hjM3JzMTRuWnVBMXJHVFA0amdyalk2WTJVRytNWTk1T1dTWmJsYXY0?=
 =?utf-8?B?NHprbWx0VGh5U08vOXlHSmIyZmdCWThMYlpaQ0FOTUxXcDFZZDA2S3Vud0xE?=
 =?utf-8?B?WkhwNkdjbitYQTdHdldyVmdmMFpWaUlJNmM0R2hSbDZCZTdscnhTTUlQLzFP?=
 =?utf-8?B?QTZ3dWJUN0FFdk10MklZakJvRGJHaDhrM0I5QjlxT20zVWVlQlFLVEpPMk1F?=
 =?utf-8?B?QnF1U2EwMStMN3AvMFdDN1JDSjl3WmZCaUJRd0VDMkRTbFBOUS93anZFdTdH?=
 =?utf-8?B?RkhVbHU2b0VwRkRVYmZUTjI2bDV1b2s4dmZKaHAwVXoxRzF6TktqUkVVMGF0?=
 =?utf-8?B?SEN4YXdMaUszN1VmcysyK3FwWmZGcGR1Z0ZFSno1UjVOS3FtZ3JLQzIwM04x?=
 =?utf-8?B?SmVyTmlPekM2bFd2TytQU2tEaVRXWXk5a3JiNXY2NXhPOTlIR2E4dHJxWnl5?=
 =?utf-8?B?QWx1NmxpQXVWR2ZaUWd4WjljdkYwczIyTGp1SWZGZWd4dnZNWkNIaUJxWDc3?=
 =?utf-8?Q?a4yZ8OlFiFaEJ4VnmA1UdAVirJ1zF2EfwqHF++6GXgw3w?=
x-ms-exchange-antispam-messagedata-1: j/CB99JmiFBNj3/ARNEHUWy2um+q7ej7iLY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2743529362F8D84393CE977500CBA118@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: zasdtBmukHtad/QYoz/nLEu7mZtLRjvtjwA+r145mF9M6BnXa1Wxbn/+GKgKWi7t8daJm+kBbjO9nWgPoXjjGab7hzkFFryj2Pq5iIEGi6aYTCzK4S5Kd2gb/mdlZoPPcUK8VYUQ3Ko6XN8a2E83JuLSOCmYjFVQ74QmsGmvNzcgxnponDVTHehXRni6JUW3TdLAhRWnAGuGdMwjMKzJz3WV++PZI4W4OYT6L527CHo3ywUH0qjAQ3xeaCg8uO3DanLYxlwm3G1v5AqLhDgCq+n+X5n6+Ruj81PW6ZW+Wz9ph3udj93ikuSCTmHHfeCBz4yJBb1auQROIUVaqfJYWQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +AIvVWlNxC3l24QV6LoGv4Th6rruxTLjosyl+Xes9KcaRV01U7GsMbJXubmIL6p69hWuKRlD0PbVZoBc7v0ZfsDcubj+cyzyH9/836ltAbcWABwrncDtWXbGcbFn25a2hAYe1DRvQRBbgj/FcTGTHfJX/Tertz/swfiX92le8d6drZG6mEDDtKe0MtLMpGh/9YsKM691Fg+5rBSiJI6K2n7xr7gV8/LkM6Eao5e+inSAoUDOve6Vm/SgGsfpV5OckfABqpEYP0q/pylv1LfGTqUSMrLAoS9ZXTtgJWFd7pnNEDrRFjMLWEQxo9g6fJmfDRz3WTllYNKhq2LhVjtlViTRABFoVvRz4f+ujEPMe9az5LvqLSNN9PaKOrDchyC8C4DZMtpTwX+xBUJz2Bp238iYvi0A5aULu3rp0q8OKnVNP4RT6aIkt/nlYHJvCD19vGOAqMLRhBIpENNoXLK72UelNe4KuZnO5ZEyPoh8ECv5YJAnEDIbXChZH15KAXD+rkg7AT7pyc1j+EFDmkkXarcMYInbu0UvWM4OOgxaoxuu53p8QzzDgTzUOfHIEp6qu6xKorNHy6DoNibYyCRp359Q5rfd81KM6FHW+z1j5c1YjYoQ6owfvgjKcFo4fHW8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e40e0b-bf58-40f1-e2a1-08df0979dff3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 05:11:56.2397 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2xTyxCTJuvEWGRTYR1RxEWcSZstQm2kiBYXz7B1RcHz7eku5HQagJIOi9AFw4HiHZ/gt5Vp4syRBMDee8dsg7UC3h6f9FcuCEx03MAcNXJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6390
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=6997dc6e7=Alistair.Francis@wdc.com;
 helo=esa4.hgst.iphmx.com
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

T24gU3VuLCAyMDI2LTA4LTE2IGF0IDE5OjA4ICswMjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gKG5vdyBjb21taXR0ZWQgYXMgNDY5NmYwYWI1YzQzNmVkNTM1NjdjZTZiYWVj
NjdjOTIxZDliNzBhZSkNCj4gDQo+IE9uIDIwMjItMDctMjUgNTo0NywgRGFvIEx1IHdyb3RlOg0K
PiA+IEFkZGVkIHN1cHBvcnQgZm9yIFJJU0MtViBQQVVTRSBpbnN0cnVjdGlvbiBmcm9tIFppaGlu
dHBhdXNlDQo+ID4gZXh0ZW5zaW9uLA0KPiA+IGVuYWJsZWQgYnkgZGVmYXVsdC4NCj4gPiANCj4g
PiBUZXN0ZWQtYnk6IEhlaWtvIFN0dWVibmVyIDxoZWlrb0BzbnRlY2guZGU+DQo+ID4gUmV2aWV3
ZWQtYnk6IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBEYW8gTHUgPGRhb2x1QHJpdm9zaW5jLmNvbT4NCj4gPiAtLS0NCj4gPiDC
oCB0YXJnZXQvcmlzY3YvY3B1LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgIDIgKysNCj4gPiDCoCB0YXJnZXQvcmlzY3YvY3B1LmjCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPiA+IMKgIHRhcmdldC9yaXNjdi9p
bnNuMzIuZGVjb2RlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDcgKysrKysrLQ0KPiA+
IMKgIHRhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5zX3J2aS5jLmluYyB8IDE2ICsrKysrKysr
KysrKysrKysNCj4gPiDCoCA0IGZpbGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkNCj4gDQo+IA0KPiA+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvaW5zbl90cmFu
cy90cmFuc19ydmkuYy5pbmMNCj4gPiBiL3RhcmdldC9yaXNjdi9pbnNuX3RyYW5zL3RyYW5zX3J2
aS5jLmluYw0KPiA+IGluZGV4IGNhOGUzZDFlYTEuLmM0OWRiZWMwZWIgMTAwNjQ0DQo+ID4gLS0t
IGEvdGFyZ2V0L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNfcnZpLmMuaW5jDQo+ID4gKysrIGIvdGFy
Z2V0L3Jpc2N2L2luc25fdHJhbnMvdHJhbnNfcnZpLmMuaW5jDQo+ID4gQEAgLTc5Miw2ICs3OTIs
MjIgQEAgc3RhdGljIGJvb2wgdHJhbnNfc3JhZChEaXNhc0NvbnRleHQgKmN0eCwNCj4gPiBhcmdf
c3JhZCAqYSkNCj4gPiDCoMKgwqDCoMKgIHJldHVybiBnZW5fc2hpZnQoY3R4LCBhLCBFWFRfU0lH
TiwgdGNnX2dlbl9zYXJfdGwsIE5VTEwpOw0KPiA+IMKgIH0NCj4gPiDCoCANCj4gPiArc3RhdGlj
IGJvb2wgdHJhbnNfcGF1c2UoRGlzYXNDb250ZXh0ICpjdHgsIGFyZ19wYXVzZSAqYSkNCj4gPiAr
ew0KPiA+ICvCoMKgwqAgaWYgKCFjdHgtPmNmZ19wdHItPmV4dF96aWhpbnRwYXVzZSkgew0KPiA+
ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7DQo+ID4gK8KgwqDCoCB9DQo+ID4gKw0KPiA+
ICvCoMKgwqAgLyoNCj4gPiArwqDCoMKgwqAgKiBQQVVTRSBpcyBhIG5vLW9wIGluIFFFTVUsDQo+
ID4gK8KgwqDCoMKgICogZW5kIHRoZSBUQiBhbmQgcmV0dXJuIHRvIG1haW4gbG9vcA0KPiA+ICvC
oMKgwqDCoCAqLw0KPiA+ICvCoMKgwqAgZ2VuX3NldF9wY19pbW0oY3R4LCBjdHgtPnBjX3N1Y2Nf
aW5zbik7DQo+ID4gK8KgwqDCoCB0Y2dfZ2VuX2V4aXRfdGIoTlVMTCwgMCk7DQo+IA0KPiBMb29r
aW5nIGF0IHRoaXMgYmVjYXVzZSBJJ20gYXVkaXRpbmcgdGhlIG92ZXJhbGwgZXhjZXB0aW9uDQo+
IHNjaGVkdWxpbmcuDQo+IA0KPiBUaGlzIGlzIGEgY2xldmVyIHdheSB0byBxdWlja2x5IHJldHVy
biB0aGUgaW5uZXIgdmNwdSBkaXNwYXRjaCBsb29wLA0KPiBidXQgZG9pbmcgc28gd2UgY2FuIG5v
dCByZWFjaCB0aGUgb3V0dGVyIGxvb3AgdG8geWllbGQgdG8gYW5vdGhlcg0KPiB2Y3B1LA0KPiBz
byBJIHdvbmRlciBpZiB3ZSBzaG91bGRuJ3QgdXNlIEVYQ1BfWUlFTEQgaGVyZS4gVGhlIHByb2Js
ZW0gaGFzIGJlDQo+IHVubm90aWNlZCBiZWNhdXNlIG1vc3Qgb2YgdXMgdXNlIE1UVENHICh0aGUg
ZGVmYXVsdCkgd2hlcmUgRVhDUF9ZSUVMRA0KPiBpcyBpcnJlbGV2YW50LCBidXQgSSBleHBlY3Qg
dGhpcyB0byBiZSBwcm9ibGVtYXRpYyBvbiBzaW5nbGUgdGhyZWFkZWQNCj4gcm91bmQgcm9iaW4g
VENHIChhbHRob3VnaCBub3QgcmVwcm9kdWNlZCkuIEkgbm90aWNlZCB0aGF0IHdoZW4NCj4gd29y
a2luZw0KPiBvbiB0aGUgaHlicmlkIGFjY2VsZXJhdG9yIHByb2plY3QgLS0gd2hpY2ggaXMgbm90
IG1lcmdlZCB5ZXQgLS0gd2hlcmUNCj4gd2UgdXNlIE1UVENHIGFuZCBFWENQX1lJRUxEIGlzIHJl
dHVybmVkIGJ5IGh3IGFjY2VsZXJhdG9ycy4gSSdtIGhhcHB5DQo+IHVzaW5nIHRoaXMgc2ltcGxl
ciBoZWxwZXIsIGJ1dCBzaW5jZSB0aGlzIGlzIGEgYmlnIGxvZ2ljYWwgY2hhbmdlIGFuZA0KPiBJ
J20gbm90IGZhbWlsaWFyIHdpdGggUklTQ1YgSSdtIGFtIG5vdCBjZXJ0YWluOg0KPiANCj4gwqDC
oCArdm9pZCBoZWxwZXJfcGF1c2UoQ1BVUklTQ1ZTdGF0ZSAqZW52KQ0KPiDCoMKgICt7DQo+IMKg
wqAgK8KgwqDCoCBDUFVTdGF0ZSAqY3MgPSBlbnZfY3B1KGVudik7DQo+IMKgwqAgKw0KPiDCoMKg
ICvCoMKgwqAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9IEVYQ1BfWUlFTEQ7DQo+IMKgwqAgK8KgwqDC
oCBjcHVfbG9vcF9leGl0KGNzKTsNCj4gwqDCoCArfQ0KDQpJIGRvIHRoaW5rIEVYQ1BfWUlFTEQg
d291bGQgYmUgZmluZSBoZXJlLg0KDQpUaGUgUEFVU0UgaW5zdHJ1Y3Rpb24gaXMgbGFyZ2VseSBs
ZWZ0IGFzIGltcGxlbWVudGF0aW9uIGRlZmluZWQsIHNvDQp0aGVyZSBpcyBhIGxvdCBvZiBmbGV4
aWJpbGl0eSAoYSBub3AgaXMgYWxzbyBvaykuDQoNClRoZSBSSVNDLVYgc3BlYyBpbmNsdWRlczoN
Cg0KIiIiDQpNdWx0aXRocmVhZGVkIGNvcmVzIG1pZ2h0IHRlbXBvcmFyaWx5IHJlbGlucXVpc2gg
ZXhlY3V0aW9uIHJlc291cmNlcyB0bw0Kb3RoZXIgaGFydHMgd2hlbiBQQVVTRSBpcyBleGVjdXRl
ZC4gDQoiIiINCg0KYW5kIA0KDQoiIiINCkEgd2ZpIG9yIHBhdXNlIG1lY2hhbmlzbSAoYXQgbGVh
c3QgcG90ZW50aWFsbHkpIGFsbG93cyBlbmVyZ3ktc2F2aW5nDQpzbGVlcCBvbiBNQ1VzIGFuZCBj
b250ZXh0IHN3aXRjaGluZyBvbiBoaWdoZXItZW5kIENQVXMNCiIiIg0KDQpXaGljaCBzb3VuZHMg
bGlrZSBhIEVYQ1BfWUlFTEQgc2hvdWxkIGJlIGZpbmUNCg0KQWxpc3RhaXINCg0KPiANCj4gPiAr
wqDCoMKgIGN0eC0+YmFzZS5pc19qbXAgPSBESVNBU19OT1JFVFVSTjsNCj4gPiArDQo+ID4gK8Kg
wqDCoCByZXR1cm4gdHJ1ZTsNCj4gPiArfQ0KPiA+IMKgIA0KPiA+IMKgIHN0YXRpYyBib29sIHRy
YW5zX2ZlbmNlKERpc2FzQ29udGV4dCAqY3R4LCBhcmdfZmVuY2UgKmEpDQo+ID4gwqAgew0KPiAN
Cg==

