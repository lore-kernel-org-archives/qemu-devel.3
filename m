Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7011CA5FC5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 01:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC5qu-0004eh-AD; Wed, 30 Sep 2026 21:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC5qk-0004df-17; Wed, 30 Sep 2026 21:44:44 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=727d860e1=Alistair.Francis@wdc.com>)
 id 1xC5qh-0006xK-OV; Wed, 30 Sep 2026 21:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1790819079; x=1822355079;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=QBtOGTl85jT+W5DAmDJKeDYedDvQD6ozcfNnGTnKlkE=;
 b=hNMJUj/WpGfgBtQY4QvyqwxEsxHbrCX3X57BHW4rs0G6TXSQYyBXfXXg
 VPllLUClsBxDb2rt0SQAtbMSKu4umrV9lfJXYVRjElvZM88QuVq3lCH4i
 /41Udw5IR+pK4QukjZXcU+Wn9imcuWDsILb6qlc5/UhrmgZ/Yb1XPvKif
 jSk5BIWZwzhanMSuqjGS7InfMuzUK9cK12RY38/33byjELZelYX/cVEFS
 TOf/5GCiIuIW6MYIEwz9UnnQ1lSwHBGiEinXwTr2qLA18tAyhcnHRgawq
 c+Sm9kEDeizYSfSQ8rNuvZS6jV+kdyrYFmBt1pFQxnak8LFVIO28nAbxz Q==;
X-CSE-ConnectionGUID: KuIzxKOATuSpz8yF8F4cJQ==
X-CSE-MsgGUID: 1mADX+NHQ5WKsEwG2bL/lA==
X-IronPort-AV: E=Sophos;i="6.27,133,1786982400"; d="scan'208";a="155393001"
Received: from mail-eastus2azon11010012.outbound.protection.outlook.com (HELO
 BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.12])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Oct 2026 09:44:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTZ027XBnRy6uEP9VScZY6Ww406KgX69iR9EZGWRH2b7qzbZb9aQ6UO/oKvST0hjfMlEgAYl4aXs9ehfTU5Zbn0GNLv2d8s4aVrxlUlBKq0ImlcxVOc6mhWmLpbr61X/VpvhMJsynOWcQ+muiS/l6AwzHL+gMG+ltOcNlw/IYjAgs94c3G3BJoTqsi5PnQ9kN2dk300h/kyzR0tKhe/V4g5qZR+OmhewifiUXX7tGCiiM4jh7dK/B11gIk2SRs5z9RaFF007rjb7cqy3O6SjIl4ON2iQ9oIO39qjxC4BUjtmLkKopUBwAm/8AhJdW4uawSicKWhMMvGnN+LpBBgn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBtOGTl85jT+W5DAmDJKeDYedDvQD6ozcfNnGTnKlkE=;
 b=Kj/LXTjvnZdnwzy+2oHOMaj3RYmdpOkSBeEvm3v42B8EQk7xAYz7bORW69gutup0uyrqiXIwjS6QHcgxZcDK5pmygG6gG1msH8ZjW8Or2w/sxDtYr2efMphei5loqSkfU2A56vB2Li7bmkweud9xhQdX69lat+DlodBMODDzN66PjE+JznzpZIrnnNqnWM3dzf3gMQKY4JmPBbwzPrY2NHqmX/7wQ5ASrf/2wnLmQJyVssRTdHorrjL8pMK9KFH7qIGk5kCx/76XOeB2eGiIckdOR2aucgSWpmlY9YNbDQ9/b+I1CtX/QSxhPrdcGGkBLzX4zcSpDAofGFr0LvvCVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBtOGTl85jT+W5DAmDJKeDYedDvQD6ozcfNnGTnKlkE=;
 b=HhTbhUjHJY5SYJZZDCOM1k5a44qAnUMOkffgo2BFAlnweDd5UwZ+A8rs0BUl8HmgaUC6wBDW6hG9gGnzaBjDdIDUnSlr0JY/qWqOzzJ2m6BRpHgmoQuak+8PayWILEL2cM0JRIrYcEyuRiTUuqZxwuIq46qDIROV9lz/WEEPdg4=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by CO6PR04MB7811.namprd04.prod.outlook.com (2603:10b6:5:35e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 01:44:33 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%6]) with mapi id 15.21.0451.026; Thu, 1 Oct 2026
 01:44:33 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "palmer@dabbelt.com" <palmer@dabbelt.com>, "qemu-riscv@nongnu.org"
 <qemu-riscv@nongnu.org>, "daniel.barboza@oss.qualcomm.com"
 <daniel.barboza@oss.qualcomm.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 1/7] target/riscv: Document riscv_cpu_update_mip()
Thread-Topic: [PATCH v4 1/7] target/riscv: Document riscv_cpu_update_mip()
Thread-Index: AQHdUQN7C7lnYkrC2E6ZnUrS2PeOQbbn6sgA
Date: Thu, 1 Oct 2026 01:44:33 +0000
Message-ID: <9bba6e12b453b2f731b34cbc0d7a709e36189391.camel@wdc.com>
References: <20260930174508.81497-1-philmd@oss.qualcomm.com>
 <20260930174508.81497-2-philmd@oss.qualcomm.com>
In-Reply-To: <20260930174508.81497-2-philmd@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.62.0 (by Flathub.org) 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|CO6PR04MB7811:EE_
x-ms-office365-filtering-correlation-id: bde520f9-08aa-4ad0-6c13-08df1f5d8b14
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|10070799003|19092799006|1800799024|376014|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: LYaMBrcR/ps85NM7uYtWaYc2PcMBBhm47OYvQ7AA3pwiI0taDK3ers3hra3GTTgYRMWbc7QdQEOrLyJ5xfyjYokEk7IK/MxxvYf21t6tt2P0oGpdIkMMuEWRTvMld6ioO21OavY341gGbYRwxdXUizDFxHInfiuTUzSqKzhozEFs3/JnoC64OWWbAnQ6SjPx4MKcyMFB3pN6/RAUrzMT3kIH8bWvzbSBve/PkxL+8AQIldrvs5yEQZwOQl4ZyG4Kgog9hMekWh3Qz4c81zSsFhceIkjHDQI+oYqnZ3RWgMlJKcMLlb89si1pnVSu5s62WtHPoMByt6Tc/CDD9dokB880sZsdVz3JbiwMFNIKgZ5AxF1mx5aZH+i53mq98Gqsp1K2awiXAqfPMhqvv+122BKUAswCRj6x2Hbay/rmMQW2ujym0iG9AhRq+xiNg9JtNsBQkig+iD3te3xuS+sssEFjllgQaHcMP8YF8bJJ4uf5WddhVCHLrQeIThaqrnRcZrhDAxXm6TDNAPVus3wmcZzlE3V5fSD4B9cZ1YOBfp4p4OqOJXXCloCyFwR9xR3GlIIXn81BxKqUycgQlZmK2Rgz0dmSfE6i6AtRxlxjApfEVVUmKbXC2ow8XORENpCEG3S44IrRx+nISclhMtotHAzUlTnX71ZDhjh5TNsfAm3IN5TBGjJfjR0UIACQn9Qln9UsEvWybJ57z5Qz0v9ljvLLKFJPw4nCxGHZjbHUIN0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(19092799006)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGM2a0tSejhJM3FhLzdmb2paM0V5amZSN1dETzM0VGl2UUlyNEQ1ZzVvRnpt?=
 =?utf-8?B?Z2MwaGR1RFdoVCt1UlYweFE4by9PL3E5ZDN3R3hLUGlTT0FxTVA3ZGc5QjRa?=
 =?utf-8?B?OHdpUFRHK3o3NmhXMlFtaFpoQXJIemZ0cnFOT0xBMVJxMXNHWUNOVjV6OHBZ?=
 =?utf-8?B?ck1qWXRIa29ucm01d3hJVmwzeXI4anlLSVBJRXJZOC9LWXZJamN1cmIvb0VP?=
 =?utf-8?B?cXpWRGZzdHZYOTVVem9jdzhyeGlsSzJvSTlabTRTcHZHV0JDVVdYRWdDOHp3?=
 =?utf-8?B?N1dyUmo2RjZtZUVYRDY3Y3lObENyRnNBQnFQZ2NaMm1SNUd5NW5NQXRjcTR1?=
 =?utf-8?B?MldsRUNZNXgrcGRzbmNMb1VTUHFSTlFpblFZdXlFQUNGVCtseGliTEZvMW1k?=
 =?utf-8?B?S1JPQWM4S2ZsYndGK0Y4NS9lQ1FMMXV3Qm9SYXQxRytoZ1pUWFJDMzRuL2dp?=
 =?utf-8?B?YVZxdVI1c0RqUkw5VFQzYTZpdmNnNDJJc2ZPYTB0dHk3dXpjcEhoRkZvc1ZZ?=
 =?utf-8?B?ZUlKVTE4U1RHbmo0OXI0Q1haVGU0ZTBGeDN0Ni81ZGxNSUg4WWFGM05ScExL?=
 =?utf-8?B?UmVXcllMSkRCb1pZeDRybjJ4Q2xrZUhiekZCQ0ZLZ2wrb0dyd0JZTXVjMS9j?=
 =?utf-8?B?bEw2emxnSmMvZlpJSkNiVHEzSWhIWWQzdmRFelB2cXdiZnhXaHZlOUhhQ3l2?=
 =?utf-8?B?Njk4TW9YU0Z0dHA3bFc1WGZsd0Fnc1hUbTVxaDlMRDAzVVhGOFNuTG1kRkx4?=
 =?utf-8?B?KzFpV3VoR1loVTc1ZmovUWhELzY1Zis4cVBrSDBOSUppNlQyQUplWFZqbnhw?=
 =?utf-8?B?cDFicUxaOTlOWlY2cHdtbCsvNVdWeDFrZEZ0MVBnejgwcHEwSnpiMEVja1d0?=
 =?utf-8?B?bDE5VGtaS1IwVkg3aWMzNm5JVEQwZHAxZXR3ajVsVFY1RjIrdTB0K2ZLaTRQ?=
 =?utf-8?B?ck5EeXNvZVd5UFFjVHN2Q1lUY25rcG51bWwvV3oyNjg3WGNJUkJGMG1ET0Rl?=
 =?utf-8?B?cm52RjhBQ1V6SGNMeklZQTUxS3NkY21XVnFlV2lDZzdNZFhoRkJ2M2ZVVHhC?=
 =?utf-8?B?SHlMcGx0ZUJrOTUybFgrMjJENUFuTHBNT2pWYWhMR3BHR0JXVnJGLytwUm1h?=
 =?utf-8?B?Y1J5VkRVcmM4R2RPbHNuTGNCVHFpV3VQSXdPbXZ5OHJMUWNnTVQ3YzdjRGVS?=
 =?utf-8?B?KzBPTk1VVlRINjQ1eFQ1OENXeVNLRkFzYzl5RXY2am9RZ2l2d3ZEcHloUHBQ?=
 =?utf-8?B?QUt0Szg3WXV5MU5FSzFIYmw1cCtaZ0IyMlkrTlcrMmpxSmlZaGRiajE0Smcz?=
 =?utf-8?B?SVBKY1AxQWRZbUNVdkRqTjBJS3p6QTN2eHNRN25tUmwzUTBWUUdRTHdySExa?=
 =?utf-8?B?b29RdnlFQ09oMnBCVzc5RHVGNC9aSHkxNlMvWWdwQ1hVMlJDZDVsWlMwcy81?=
 =?utf-8?B?bGhHdGlTTUFEb0x5SVc0SjcrVTREaElYVGgvWHBJVG9YUmVBVm5YdUhOZEIx?=
 =?utf-8?B?aTIyK281UXdEaTJBZE5LZXlYb2RrK0EwVy9seGI2SDl5M3JXWis0Tm9Vampa?=
 =?utf-8?B?K3MwQm1OcmFkRGpINVpreC94QlNwWVVBcTl6c0NJckNIZVBXcWNkekxuc3Bi?=
 =?utf-8?B?NDVPNWYxWFhTWFVIbHF4cDZGVklqNmdRNFQxcDhQY1JGeGd1K2hZZmlNU05q?=
 =?utf-8?B?M0dseGxWVFZyaS9zMTJXTUZyZmRuRUFQRlI0YVEwWVlZbmtxUWVNS3IyTDRX?=
 =?utf-8?B?UmJ5ZGF4eFZORW1SeTE4dkVvYjc5eE1xUnp6OWozQUtHTjdXSG1pUTJKMCtj?=
 =?utf-8?B?TWUrQzJDa2diVnFHMklpaFArYnR5VTNEYUdCa0xaUFVORDIwNlFtYWdxWVRH?=
 =?utf-8?B?a1p3eTVkelhsZmMyaDZFVktZUlVSTmpNMG8reVVmaXpNVVZXWUlIZHE4djRs?=
 =?utf-8?B?NlpHSzJkcWdmT1JUQ2ZqWnVJUHRWR1N2Y3hueGl3WWRKa3ArNy93bHQ5YTgx?=
 =?utf-8?B?K0oydEljZ2kvZUhmUEhyZWtsQXMzUXMwMGFiWnV4YkNIVDczV1dZNnVXekQv?=
 =?utf-8?B?OTV6UG5jdDdaMkc1K3dMWTVDenlWM3d2SWZGT2RxaDlrVmhvS1ZCZktpMU8v?=
 =?utf-8?B?aERpN0RuNDJnSnI4dUIrU1BPdC9ZczNaWmFReGw1K1Zad093Z2t2ZDRTK2pz?=
 =?utf-8?B?RHdWL1cyLzduM3RlQVNqY0V3UFJQK0toTXBkaDBkR0FqM0JkU3gvSUZERjkr?=
 =?utf-8?B?UDVIendrYnVsc0pJZm9LK2cwS1ZEZUprTWxBa0RaUS9NdU0xRFZFSDV2RWE3?=
 =?utf-8?B?akVRL1kxa2lMZXFsMGpTUmt0bmU5azNNdXd1ZUg5RXlpZEdvdlFPUjBJdFNU?=
 =?utf-8?Q?8tJqamAWak/uE8kqRKzWYJC8EtuHmX3j7Fe1kYdZcuNQ+?=
x-ms-exchange-antispam-messagedata-1: LTU7bVa1rlF0q5zHsxD6KSgTp5VqAfZVa4o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <135AE87EF224DA4392C09D3BFF8D6A5B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: epuFpf1xf6G8or0kIIZ8s6SiKP0ss/c6yxi7rBeiPyHuLM3oD9jy+e20rqQojDXex3BTDPowMSZOtX07bFUC9UGpznAqs4F7nFkFNuCxlA/Kpbr7wXhJSl004djC7unXXERyHic/0mMun8P7fNOWHdgot4qOKPU6gm/kTUkO/Nfk7LWwWxpoJNvhvOduJ0CFwPwsiX5wxTtQe+QbggC+0kmCnESLNs7q3b0gU7+ac9epozR6+zihAfK1KOMk780B+MzIh4jGJUB7LKpSuuCdBpqr5Q466hf2tk9O1r1VgnPgXVh3T2wi+RCOpoPnY+rsmUCs8krHmz5zhDIaQT62wQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: d6ITVzI++NCVT5RNNvILxnM2YOi+Lmx1ikc8hnAM8nfYO7tCG5aFqt9a50QKRu5fHerejsMFemCdyuIU/zJxj5EhzfLsBO7SLcZYawIJBGBEFsNRBXmHMd7IOfdJq/WUhp8LgeSAzNyMVtQpSXT2UXWWNU8xAJnVDcPfbchm2cwu5ABDXzde3zoul788wLVbMLbDNEAFkmn60J24EPLrkI/R+HwweuMahyL6LnFPsj6HgJ7yADCtNRNyGbqW1ol68cWOODbeuDGrtuSm0Z7CKaIB5W+o6MPnZ7dbuNEEL8Ny7wqZ/DHgXIIfnXXhUqyiCOHELV+c/WFl/r7SrOoMXgpSO+6RFxhUg6xQ0WcY0TiEhY4smaKK/vhzhAb+3ub+ivMWTasE/1XlUrOV3Np0inAtAKXEk0dVqeAX1uTZQG35gCbEQrHZJYX0M4y+1+SayAZ/iMz2aw1oWlzeBrSD0PdCvbkAmgDXIT+iISkyVOAJRBIbTLvRVDtFwZqML1nZnH6lNOJwXC+6Mo1zbRhjllV8r+bbtN3aeyl8Gav9m7qCph4nFG29mSd53J2krl+2UL30TPXINylBlEgC/qprh7n1b1GzBnPNSIYamqaUKSuN9f+QVRKGhpND+tz2srQZ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde520f9-08aa-4ad0-6c13-08df1f5d8b14
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2026 01:44:33.5427 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sqh4rdgf8B7vIG+bBh9gk/qDoN10a16aM9BzyA8iLKBHAczWYztRm4Z3IizPf/AxgkEopHyWnZuIL8dEh5yPGklxPjfrp9tbkV9ZvPJictg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7811
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=727d860e1=Alistair.Francis@wdc.com;
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

T24gV2VkLCAyMDI2LTA5LTMwIGF0IDE5OjQ1ICswMjAwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxt
ZEBvc3MucXVhbGNvbW0uY29tPg0KDQpSZXZpZXdlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxp
c3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KDQpBbGlzdGFpcg0KDQo+IC0tLQ0KPiDCoHRhcmdldC9y
aXNjdi9jcHUuaCB8IDE0ICsrKysrKysrKysrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDE0IGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcmlzY3YvY3B1LmggYi90YXJn
ZXQvcmlzY3YvY3B1LmgNCj4gaW5kZXggOGM4ZmZlOTRjZDguLmUzNGMwYzY3NmQ1IDEwMDY0NA0K
PiAtLS0gYS90YXJnZXQvcmlzY3YvY3B1LmgNCj4gKysrIGIvdGFyZ2V0L3Jpc2N2L2NwdS5oDQo+
IEBAIC02ODQsNiArNjg0LDIwIEBAIGJvb2wgcmlzY3ZfY3B1X3RyYW5zbGF0ZV9mb3JfZGVidWco
Q1BVU3RhdGUgKmNzLA0KPiB2YWRkciBhZGRyLA0KPiDCoGJvb2wgcmlzY3ZfY3B1X2V4ZWNfaW50
ZXJydXB0KENQVVN0YXRlICpjcywgaW50IGludGVycnVwdF9yZXF1ZXN0KTsNCj4gwqB2b2lkIHJp
c2N2X2NwdV9zd2FwX2h5cGVydmlzb3JfcmVncyhDUFVSSVNDVlN0YXRlICplbnYpOw0KPiDCoGlu
dCByaXNjdl9jcHVfY2xhaW1faW50ZXJydXB0cyhSSVNDVkNQVSAqY3B1LCB1aW50NjRfdCBpbnRl
cnJ1cHRzKTsNCj4gKy8qKg0KPiArICogcmlzY3ZfY3B1X3VwZGF0ZV9taXA6DQo+ICsgKiBAZW52
OiBDUFVSSVNDVlN0YXRlDQo+ICsgKiBAbWFzazogTWFzayBvZiB0aGUgTUlQIGJpdHMgdG8gdXBk
YXRlDQo+ICsgKiBAdmFsdWU6IE5ldyB2YWx1ZXMgZm9yIHRoZSBiaXRzIHNldCBpbiBAbWFzay4N
Cj4gKyAqwqDCoMKgwqDCoMKgwqDCoCBVc2UgQk9PTF9UT19NQVNLKCkgZm9yIGJvb2xlYW4gdmFs
dWVzLg0KPiArICoNCj4gKyAqIFNldCBvciBjbGVhciB0aGUgTWFjaGluZSBJbnRlcnJ1cHQgUGVu
ZGluZyByZWdpc3RlciAoTUlQKQ0KPiArICogYml0cyBzZWxlY3RlZCBieSBAbWFzay4NCj4gKyAq
DQo+ICsgKiBOb3RlOiBWU1RJUCBpcyBub3QgbWFpbnRhaW5lZCBpbiBNSVAsIHNvIGl0IGlzIGln
bm9yZWQgaGVyZS4NCj4gKyAqDQo+ICsgKiBSZXR1cm5zOiB0aGUgdmFsdWUgb2YgbWlwIGJlZm9y
ZSB0aGUgdXBkYXRlLg0KPiArICovDQo+IMKgdWludDY0X3QgcmlzY3ZfY3B1X3VwZGF0ZV9taXAo
Q1BVUklTQ1ZTdGF0ZSAqZW52LCB1aW50NjRfdCBtYXNrLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDY0X3QgdmFsdWUp
Ow0KPiDCoHZvaWQgcmlzY3ZfY3B1X3NldF9ybm1pKFJJU0NWQ1BVICpjcHUsIHVpbnQzMl90IGly
cSwgYm9vbCBsZXZlbCk7DQo=

