Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56A4C61DE4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 05:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Gxq-0002M9-GR; Tue, 01 Sep 2026 01:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6977d653a=Alistair.Francis@wdc.com>)
 id 1x1Gxk-0002LS-Hj; Tue, 01 Sep 2026 01:23:14 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6977d653a=Alistair.Francis@wdc.com>)
 id 1x1Gxh-0005fQ-If; Tue, 01 Sep 2026 01:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1788240189; x=1819776189;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=0eh1dnQcZuGIMo5b2eG6NLfrvDzf5sJCy0JFd9R2d4Y=;
 b=d7p1ydPr325A3SS3lxygDAZlKQ6yeq+yq4gDn9TWN0ELWMYV8YHSD6TZ
 KK204P/8iyqfwxifjeV5HznU/CVzr3TqU0nziBOyqGK8BY6EQw1PLT2i4
 vDH38m6EssZE4pKjdrie7JiFzxhT9tDBk5MBF1kALFpxhwHiCiYxwtUqE
 KUgrsKZ4EFO5X87gqpkque0vWRhGpZoM4+VtxbM1aR+hFvG2tTawql65l
 eRMEHGHA4N3Bc1wRy8Xb0xFP4zEZulRZlIPr4UdXQk5ApWSQli1G4CnaL
 bsTVqrBcuirVO+tCvNXiQ//YhqY69MIxjEJYIR0s8O9RVvwIidIPoh2Mn Q==;
X-CSE-ConnectionGUID: wkXksLVrQl+V3wfMWhuCew==
X-CSE-MsgGUID: aVtE0Yj1TiWMPgFHbljVyw==
X-IronPort-AV: E=Sophos;i="6.25,255,1779120000"; d="scan'208";a="150471666"
Received: from mail-westusazon11012069.outbound.protection.outlook.com (HELO
 SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.69])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 01 Sep 2026 13:23:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NllXFNyVckUhrdj/d2tl3wPmmQzAHKBTPEGHatWuC19MD8VYCHfxQD73OVh7wpqPaOX+8johJl5CtEaxzs0xZ+LpDjbId12v9PasGDk3zs6/j+PBO9spHLTkwytVYiMVsQivAQ36oZqZDBTtCAlDSFRfiCiO5QjARKCCgEyz+D6BnU35YaWotug3cuhyj4Fis393XWQvV0g7fczZFP4ByrxFf0IVrkEieCaPAOIgrtwOvrXjp9gqzy9ICPzPVgqPAM5pfNsuXH3wLIrHxKIAtmwHbJjN81wvaXPErFNgM/ZILobMS41HojygUzRUa36eqj2qkJCqYnU/zsBXB4Oydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eh1dnQcZuGIMo5b2eG6NLfrvDzf5sJCy0JFd9R2d4Y=;
 b=RlZpX+gI/NNQiO8EdTG1Wxz6103eIng25r0gUwjksMGWf4ES01dZk5Ln7ygvGcFqHIBe+AOTn018z10pP4LyCMt80GiHWj6q6zL0dmYGtyFPNJTwkEuO8xkHZjUfeTdBCoK1vpvVOF9fKN3pFoklTsWKDmh6s1ifUvNja5LdVgPpa+uXEzYKCXJJyAewX/vdXKkWJLBgOHyPTKqoFq4ghbPyFYas/ouVbM1MzTyNwZTbgxAH4c3g/vtGg6laQ1XWwsmhhgcLEWkNCTydLzrklpyHKoohRP3KoAaopFGirIp2K476l+L1g8AkMzuIamds6f7Phtg/NIi+mqkmCcMSrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eh1dnQcZuGIMo5b2eG6NLfrvDzf5sJCy0JFd9R2d4Y=;
 b=tm9B8jjCYNc41sO0/7EdZ/WeJTfdG1nxShAbuo+o/deXNNK9Q/xdcW//L/ma8z1ms+FoQKu4NDiWeWFIpeEtXdD353tmVUVvhxKAjui4w9ed6Hc2NPiuXoKKpopMrnfalNkRqmjwyOF0xhT0JdA0xui16moizbj/CAnKKw0O/0o=
Received: from BY1PR04MB9561.namprd04.prod.outlook.com (2603:10b6:a03:5b6::11)
 by PH0PR04MB7302.namprd04.prod.outlook.com (2603:10b6:510:1d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 05:23:04 +0000
Received: from BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888]) by BY1PR04MB9561.namprd04.prod.outlook.com
 ([fe80::3869:e494:2fa8:9888%5]) with mapi id 15.21.0382.007; Tue, 1 Sep 2026
 05:23:03 +0000
From: Alistair Francis <Alistair.Francis@wdc.com>
To: "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "chao.liu@processmission.com"
 <chao.liu@processmission.com>, "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v5 10/15] hw/riscv/fdt-common, virt.c: add
 riscv_create_fdt_uart()
Thread-Topic: [PATCH v5 10/15] hw/riscv/fdt-common, virt.c: add
 riscv_create_fdt_uart()
Thread-Index: AQHdNy1mHB2cIdxFjkOm3Y84L+sbvra5NZAA
Date: Tue, 1 Sep 2026 05:23:03 +0000
Message-ID: <755cdb46b4960c8eb5e3f631997229fa5882c84f.camel@wdc.com>
References: <20260828203918.350131-1-daniel.barboza@oss.qualcomm.com>
 <20260828203918.350131-11-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260828203918.350131-11-daniel.barboza@oss.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.60.2 (by Flathub.org) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY1PR04MB9561:EE_|PH0PR04MB7302:EE_
x-ms-office365-filtering-correlation-id: db98bb7d-930d-4b46-9748-08df07e91909
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|19092799006|10070799003|366016|38070700021|4143699003|10067099003|11063799006|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info: z89IhL1AHekYa5K5Xl0mXhehhGZwGuxh6A24vFmuBuUuGB4SB55LCTcRAdM3NfQd6QZNiqmmZk4LXrY6g2V1HHwaE4AClWb2vQM0V42bu1KxHnxqlpGxbhAeXFa0T1kpPH2VuFzeN0B/qFunpp97kzu/6RBFI2zm2k/ToBGa6kDI1jrlABKIGf1CrnAcUP047xxA+vMQP1rmwxLnU3ltZknHdFIjBbn296Jq51HAzj6tUgO0iauVE2o5rLhKoYN3teBrw+f9eHuP2ujyPXvYSXEYuzCkSnwC3Bt9lQqS579VxAv4N3V6s1XDBqeoA+EFVRgUnL8wmaD9dPK3jgLqqGTe8RYnjnPJvD0OWV4j7j15xyYxgCS9BRUn/AI1802PEE666EK7j5somlv6hPvd0Y3EnPmnO7tagrtmt9jK2UPxH6/3R5JAUxWGKaAF8sR0DQb0VaygtqWvQ8aUO+hAaDOOA/M5vUAKqEdqRPNikuYSwC/tYOHi+zRMr1febiI1xqbZKtEgoWJesZHdbW6Ukbz5cwXfQTIgD7fZ0KTW/VeyJcwbDl1VFEQe5GuzQQscqIXj3xctrMgzS+Byt23JuXzDz2savba7Ez5DQE1E3/pAcpEU6vafk5EanQGmc/7Z9Qsh29vfQhrMMhk5w0TS7TM5kfB74HipRCQL3t6SRTI23oMqA0fux93FDzJRBO0gQh5V82Puont8OxbSisMAhqZxj3i4ex/1vlPKYMfQw8w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY1PR04MB9561.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(19092799006)(10070799003)(366016)(38070700021)(4143699003)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGllYTdIMFdFby9PM3MrbFd6NjBIUXAvTHBvdW5VRzdkd0QvTlZzQUFjcU5t?=
 =?utf-8?B?SDloUmRyTGVqdVloaUJVZHY2VHJnS3RwNFJGL2dqQzk0a3RDaS9GaWJsdkZ2?=
 =?utf-8?B?dTdSM3hEUHY0MFZBUHY4SzBUVytmZW1lTG5Hcjdsb21ETngxQ1lRdnpmOXpn?=
 =?utf-8?B?MGE3ZFU5SVRGTTJ0QkdZOHFrTHRHY2NJNkJ0TWFmWG5UTHh4SlRXY3BIRGF5?=
 =?utf-8?B?d2FGUHg3WFF4TnhjYlI5NWc1MUlHdGxaL2RKYUNicy8za0hoOGNTb2ozeGFp?=
 =?utf-8?B?YTdYQWdLcDdhM09NMDhWbUtVU0ZmQzVON3VWRDlJSUtrMmFxd1FjS0VqaHdu?=
 =?utf-8?B?RW9iUEJXbGN1azRNa0hsVXBUSjBsVUxMSDNoOFRKcTNxSi9yQWxCSTRVVFNo?=
 =?utf-8?B?UTJNTjhaMTJuYWpkdE1Sb0xNc3hqZTBLZU1VYk9zQXdRT2daTGtKN3hhVFpu?=
 =?utf-8?B?QmRmNjVKNWt1bUduL3Q0Sng1bmU5R0ZqN2pBNjJBWHY4cVVMdWZxdnRxME5v?=
 =?utf-8?B?L3JMWHZqemM2am1GNUoxazlaWXFCL1cyV1Y5ZXRXb1U1MElzTnFZeWt6ZklG?=
 =?utf-8?B?MU1jT3IvTzVQVHRGWkV0QUdzc2FTM0Z5YjdSTUN3alRNSHRNUmFBdEdxMjh1?=
 =?utf-8?B?bTB3dTh2UVBpSE1GY3QzQnJFSG81M0ZkQzdHUnJKMmNOWVNqQlFzVFFMeEFN?=
 =?utf-8?B?OUdaVjlYZGxOTWU5WUpYajlSZFBiNzVlanVUZHgwdHRqMFNkbEU5elQ0aXhk?=
 =?utf-8?B?Mzd0OWEvWExyMGZoSmdaRFcvNkFneWcyTmJ5bm8rbHR1TkNWT2hFNkN0ekVY?=
 =?utf-8?B?YWV4SHNDSTZWSVdFbWwzTmE0WEVzV2dlV0JmNklDOFBxNDZqWWcyZUZscXcr?=
 =?utf-8?B?Tm92VE9sbm5FNTl4MHRHc2dMd3dRa2lHWHlxek9zemY3VXFySlpiN2pJZXNW?=
 =?utf-8?B?RFFUYWorQW5KQmw4N04vZmlvUXB1SVE5di8yVFNCREx1TmpqZnlGaHRLQWNu?=
 =?utf-8?B?TkdBZjVaMWRtRHI4UVY4MWRRUmtNa0Y0bkJRRVpOdXVqZmtZYlhaVmd1MkVo?=
 =?utf-8?B?ZEFYQzNjb1dyVE9OOGE3UGsvRXp6Rnc4bXRNenBaZmhWNklDckpXL2NsNDZ1?=
 =?utf-8?B?aVlWTlBSL3dGL3VXSXpuV3E3YnBMQ280WWMvQkNXbkNnaUZSOW9NOUVhaW1a?=
 =?utf-8?B?MHI2MmtLOVhCZUlZVTBSOGhSTmo4clMzdEJRMUdaSGFrOHNrcVJsWGFWRzR6?=
 =?utf-8?B?NG40SWI5QjJsVmpZZWcraTYxbE5xVGtRaFBQdy91dTF6LzlyVmtqb3FxaHNR?=
 =?utf-8?B?L28vK3Azbno0QnlnL1JmaDJNdVpTOGdtdkZoZmpXbUNkRFMrSXFDK0p2Z0l2?=
 =?utf-8?B?bmg0UnZMSzNtK1dwalo4K25DTE5NMVZNdzVwUzZMQ21WWFlxU0wzWEI5OTRZ?=
 =?utf-8?B?T1hERktOTVZpNWR5T3BNYnNBWFJKVHFlbDdrN2w4ZFpCTlM4LzhoSk1aeVVW?=
 =?utf-8?B?SmpEVTI1WmVSd2dJY21Pa3hURmVPcTNyalB1VlpsL2tsVitqZlJielNwdFlu?=
 =?utf-8?B?dnAxdE52TVAvQjdiOExKSGxqMkxoaThpbFZVRERTeTk0ZkFJK05vbkpqVjha?=
 =?utf-8?B?Rk9vYjBmYkpEYXU4N0ZyUS9BZFZrb3JneWZKUkg5NlpXK01BTHJIekk3S245?=
 =?utf-8?B?ZVI5eUZzUUhMNjVxRUtyVldJUmhvajI3TnRNQ1lsbVh6Z1I3VTNNYnA0K2JF?=
 =?utf-8?B?WWIzUEdoY3NmNHJGdVM2d2xuaFdTNXJmdzhLRlVUTCtJMTN2bUh2TndaMnBo?=
 =?utf-8?B?bXhROUNVR2lrcjEwVU9kL212elc5bWVEZGNZY0ZiYkdCU2xOZEpqczZTbFM5?=
 =?utf-8?B?UVB2d2RhN3ByelpJL01Ddjh1elQzN0hmSlR2YUpBc09WNGRGU3lSVldTRDdH?=
 =?utf-8?B?L0o2em8xMTU2dmZLeTU2Ykx0Z0dtNjZFQmZxK0t0TS9RcXN3VzV0QlkzUFRG?=
 =?utf-8?B?aGM3ZEdKL1I0eWRoM29qQUxZNGhmdWczRWpZR3h5UFhqMWdOZDJhYUNZUmJH?=
 =?utf-8?B?MWJUL3R3RUdzRXk4Um5YU1FuUzhPUVFKWWhjcC91ZjhNTFBscUxGc1RiWUtS?=
 =?utf-8?B?RTFTQXVERFZPMXM0UWo0bHJHTkRaaGZITk84UTdiQXlPWmx3Z2xWT0ROT3ZT?=
 =?utf-8?B?QnYxMmFsTk1Hc0xmNk9MWFNkdng2NkNtd1FFcWExYUt5UnFZOThlZ0o1T3gy?=
 =?utf-8?B?WGZmSHVqOWV0MDB3WmhQS0ZHUzVmRTJ1c0hKSkRsOU1YdlA3U2lISnhSRjNj?=
 =?utf-8?B?eVcyRmpxcFNOUVFUeFlNTEZ3VXpsaXZUbFBaMTl2QURCSWtYWmlRWXhFZ1l6?=
 =?utf-8?Q?HO0Fx8NgxJiJIlK0GUQZJseTQTznjcu2Lp/5SdF/oFV6s?=
x-ms-exchange-antispam-messagedata-1: 7368oBllbUj2UVCWkM5cXvAhpnBSHe4xqVA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <299A870AF11CE14FBC60CFC4E7C284AE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ra2JcbcWIIg9uFwWAsBtfaYZ1amXKNoatT1gKoU2E5cq/TCSOd4XpddFM/r0N2yPueE38dQ+/lhgi1U66x7jGdiey/nidteAFQLuyj8G9FtTBRp6JAHBBgyQQ30pIL2VRo9dkJ6jbRGxWVv9jQLrIG84rkxpQdC45EZlkuTZTARAUXvNOtd0VcAj+ukoSpYqNUkfLAPky3DGS6VgelIjxjExsNUGfNqktLMB+mFKDE4TEA7fEduLgyZeTj1zsNy9bXyThcJJTg76E5YkbIlqsWNkmHr1dN/EqcDXqqLVa2omLfGDZofUnjXf4icXhA11MRkOn5/ClV5b6By7IXuiUw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pCqe3U1IiX5wF2F1G89Yth4Z2noJ820lG2ZvQy0lQDTKA5VKdOyTpnhRzpVfngJWiA/auXr4T5Cr4uu9vPSO/7ynJSJJdODT3yy96aAJz7aZmDGSdmf+/6CM1tZxtGeEaCBA0kAO4DHsZAh+QqyPXpF6xPiSdr9woifBBB5xAJK6IkqoeTnroZ/GtBB6yECmcRrD53dbvZFETcSd2oGXKYlesR0ZU3NQL1rxwWkKrH+nQxY4HQ9EsEHYkdIe40PDQmag2TlnpeArXczpBLedEq7x4tym2VDCivTK2AiU2MWUFjzxr/2QZcBKmdY/FWVsfX+sLe782K/YFja9WFqYFGlG9UUMKzeO4ia7T0/ITvkF+S6fH8AZzthVtLBUorQxoVDOoraT1GQpgiizi62Djs2cNfrkCvHHHbl1IuqltuPIVK0KPNaOvOyY5cryrh18vub51hsO1GTw9xRPUmYtYPElJoltloyz15WoZcalEM1gH13DkGhekSdNf0HZ25+RZaAyZIYbspq91pClIOTijSwwnuPewZtYkb6PMIAZfXwQhJN38GORdTh4Yt0Y3DsFhBtZlk8lFTNqIrmO9/qIKWpiwvwvKgBP3noY+hdftY8d05kpaJa7JT1yEhwul5HE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY1PR04MB9561.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db98bb7d-930d-4b46-9748-08df07e91909
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2026 05:23:03.8123 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2yLCEVK4BTA4SAtIxmuY8usQ8ki0rqp5bsWpdt8QnpNvZ7j5EALmsbQEmAXN/tH7/Hwq8qfdVS8HjwAREbuvKBXNbowePZuhMoyQpuKjzNQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7302
Received-SPF: pass client-ip=216.71.154.42;
 envelope-from=prvs=6977d653a=Alistair.Francis@wdc.com;
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

T24gRnJpLCAyMDI2LTA4LTI4IGF0IDE3OjM5IC0wMzAwLCBEYW5pZWwgSGVucmlxdWUgQmFyYm96
YSB3cm90ZToKPiBBZGQgYSBjb21tb24gdWFydCBGRFQgaGVscGVyIHRvIGJlIHVzZWQgYnkgJ3Zp
cnQnIGFuZCB0aGUgZnV0dXJlCj4gJ3Jpc2N2LXNlcnZlci1yZWYnIGJvYXJkLgo+IAo+IFRoZSAn
dHQtYXRsYW50aXMnIGJvYXJkIGlzIGxlZnQgb3V0IG9mIHRoaXMgcGF0Y2ggYmVjYXVzZSBpdCdz
IGdvaW5nCj4gdGhyb3VnaCBVQVJUIHJlbGF0ZWQgY2hhbmdlcyBhbmQgaXRzIEZEVCBtaWdodCBj
aGFuZ2Ugc29vbiwgdGh1cyBpdCdzCj4gYmV0dGVyIHRvIHdhaXQgZm9yIHRoZSBmaW5hbCBEVCB0
byBiZSBkZXRlcm1pbmVkIGFuZCB0aGVuIHdlIGNhbgo+IGV2YWx1YXRlIHdoZXRoZXIgaXQgY2Fu
IHNoYXJlIGEgY29tbW9uIGhlbHBlci4KPiAKPiBUaGUgIi9jaG9zZW4iIGFuZCAiL2FsaWFzIiBj
aGFuZ2VzIGFyZSBVQVJUMCBvbmx5IHNvIHdlJ3JlIGtlZXBpbmcKPiB0aGVtCj4gb3V0IG9mIHRo
ZSBjb21tb24gaGVscGVyLsKgIFRoZSBib2FyZCBjYW4gc2V0IGJvdGggbWFudWFsbHkgYXMKPiBh
cHByb3ByaWF0ZS4KPiAKPiBObyBGRFQgY2hhbmdlcyBpbnRlbmRlZC4KPiAKPiBTaWduZWQtb2Zm
LWJ5OiBEYW5pZWwgSGVucmlxdWUgQmFyYm96YQo+IDxkYW5pZWwuYmFyYm96YUBvc3MucXVhbGNv
bW0uY29tPgo+IFJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQG9z
cy5xdWFsY29tbS5jb20+CgpBY2tlZC1ieTogQWxpc3RhaXIgRnJhbmNpcyA8YWxpc3RhaXIuZnJh
bmNpc0B3ZGMuY29tPgoKQWxpc3RhaXIKCj4gLS0tCj4gwqBody9yaXNjdi9mZHQtY29tbW9uLmPC
oMKgwqDCoMKgwqDCoMKgIHwgMjkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiDCoGh3
L3Jpc2N2L3ZpcnQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAzNSArKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAtLQo+IMKgaW5jbHVkZS9ody9yaXNjdi9mZHQtY29t
bW9uLmggfMKgIDUgKysrKysKPiDCoDMgZmlsZXMgY2hhbmdlZCwgNDMgaW5zZXJ0aW9ucygrKSwg
MjYgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2h3L3Jpc2N2L2ZkdC1jb21tb24uYyBi
L2h3L3Jpc2N2L2ZkdC1jb21tb24uYwo+IGluZGV4IGQyY2U5M2FkMjguLjAxMDdhYWRhYWQgMTAw
NjQ0Cj4gLS0tIGEvaHcvcmlzY3YvZmR0LWNvbW1vbi5jCj4gKysrIGIvaHcvcmlzY3YvZmR0LWNv
bW1vbi5jCj4gQEAgLTIyLDYgKzIyLDggQEAKPiDCoCNpbmNsdWRlICJody9wY2kvcGNpZV9ob3N0
LmgiCj4gwqAjaW5jbHVkZSAiaHcvcmlzY3YvYWlhLmgiCj4gwqAKPiArI2RlZmluZSBVQVJUX1NU
RF9DTE9DS19GUkVRIDM2ODY0MDAgLyogMy42ODY0IE1IeiAqLwo+ICsKPiDCoHZvaWQgKnJpc2N2
X2NyZWF0ZV9ib2FyZF9kZXZpY2VfdHJlZShjb25zdCBjaGFyICptb2RlbCwgY29uc3QgY2hhcgo+
ICpjb21wYXRpYmxlLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludCAqZmR0X3NpemUpCj4gwqB7Cj4g
QEAgLTc5OSwzICs4MDEsMzAgQEAgdm9pZCByaXNjdl9jcmVhdGVfZmR0X3NvY2tldF9hY2xpbnQo
dm9pZCAqZmR0LAo+IEFDTElOVEZkdFByb3BzICpwcm9wcywKPiDCoMKgwqDCoMKgwqDCoMKgIGdf
ZnJlZShuYW1lKTsKPiDCoMKgwqDCoCB9Cj4gwqB9Cj4gKwo+ICtjaGFyICpyaXNjdl9mZHRfZ2V0
X3VhcnRfbm9kZW5hbWUoaHdhZGRyIGFkZHIpCj4gK3sKPiArwqDCoMKgIHJldHVybiBnX3N0cmR1
cF9wcmludGYoIi9zb2Mvc2VyaWFsQCUiSFdBRERSX1BSSXgsIGFkZHIpOwo+ICt9Cj4gKwo+ICt2
b2lkIHJpc2N2X2NyZWF0ZV9mZHRfdWFydCh2b2lkICpmZHQsIGNvbnN0IE1lbU1hcEVudHJ5ICp1
YXJ0X21lbSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpbnQgdWFydF9pcnEsIGludCBhaWFfdHlwZSwKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBpcnFfcGhhbmRsZSkK
PiArewo+ICvCoMKgwqAgZ19hdXRvZnJlZSBjaGFyICpuYW1lID0gcmlzY3ZfZmR0X2dldF91YXJ0
X25vZGVuYW1lKHVhcnRfbWVtLQo+ID5iYXNlKTsKPiArCj4gK8KgwqDCoCBxZW11X2ZkdF9hZGRf
c3Vibm9kZShmZHQsIG5hbWUpOwo+ICvCoMKgwqAgcWVtdV9mZHRfc2V0cHJvcF9zdHJpbmcoZmR0
LCBuYW1lLCAiY29tcGF0aWJsZSIsICJuczE2NTUwYSIpOwo+ICvCoMKgwqAgcWVtdV9mZHRfc2V0
cHJvcF9zaXplZF9jZWxscyhmZHQsIG5hbWUsICJyZWciLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDIsIHVhcnRfbWVt
LT5iYXNlLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDIsIHVhcnRfbWVtLT5zaXplKTsKPiArCj4gK8KgwqDCoCBxZW11
X2ZkdF9zZXRwcm9wX2NlbGwoZmR0LCBuYW1lLCAiY2xvY2stZnJlcXVlbmN5IiwKPiBVQVJUX1NU
RF9DTE9DS19GUkVRKTsKPiArwqDCoMKgIHFlbXVfZmR0X3NldHByb3BfY2VsbChmZHQsIG5hbWUs
ICJpbnRlcnJ1cHQtcGFyZW50IiwKPiBpcnFfcGhhbmRsZSk7Cj4gKwo+ICvCoMKgwqAgaWYgKGFp
YV90eXBlID09IEFJQV9UWVBFX05PTkUpIHsKPiArwqDCoMKgwqDCoMKgwqAgcWVtdV9mZHRfc2V0
cHJvcF9jZWxsKGZkdCwgbmFtZSwgImludGVycnVwdHMiLCB1YXJ0X2lycSk7Cj4gK8KgwqDCoCB9
IGVsc2Ugewo+ICvCoMKgwqDCoMKgwqDCoCBxZW11X2ZkdF9zZXRwcm9wX2NlbGxzKGZkdCwgbmFt
ZSwgImludGVycnVwdHMiLCB1YXJ0X2lycSwKPiAweDQpOwo+ICvCoMKgwqAgfQo+ICt9Cj4gZGlm
ZiAtLWdpdCBhL2h3L3Jpc2N2L3ZpcnQuYyBiL2h3L3Jpc2N2L3ZpcnQuYwo+IGluZGV4IDcxN2Ew
MWRhOGQuLjNlNDA1MTNkYzEgMTAwNjQ0Cj4gLS0tIGEvaHcvcmlzY3YvdmlydC5jCj4gKysrIGIv
aHcvcmlzY3YvdmlydC5jCj4gQEAgLTQxOCwzOSArNDE4LDIyIEBAIHN0YXRpYyB2b2lkIGNyZWF0
ZV9mZHRfdmlydGlvKFJJU0NWVmlydFN0YXRlCj4gKnMsIHVpbnQzMl90IGlycV92aXJ0aW9fcGhh
bmRsZSkKPiDCoMKgwqDCoCB9Cj4gwqB9Cj4gwqAKPiAtc3RhdGljIHZvaWQgY3JlYXRlX2ZkdF91
YXJ0KFJJU0NWVmlydFN0YXRlICpzLAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3QgaXJxX21taW9fcGhhbmRsZSwgaW50IG1l
bUlkLAo+IGludCBpcnFObykKPiArc3RhdGljIHZvaWQgY3JlYXRlX2ZkdF91YXJ0cyhSSVNDVlZp
cnRTdGF0ZSAqcywgdWludDMyX3QKPiBpcnFfbW1pb19waGFuZGxlKQo+IMKgewo+IMKgwqDCoMKg
IGdfYXV0b2ZyZWUgY2hhciAqbmFtZSA9IE5VTEw7Cj4gwqDCoMKgwqAgTWFjaGluZVN0YXRlICpt
cyA9IE1BQ0hJTkUocyk7Cj4gwqAKPiAtwqDCoMKgIG5hbWUgPSBnX3N0cmR1cF9wcmludGYoIi9z
b2Mvc2VyaWFsQCUiSFdBRERSX1BSSXgsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcy0+bWVtbWFwW21lbUlkXS5iYXNlKTsKPiAtwqDCoMKg
IHFlbXVfZmR0X2FkZF9zdWJub2RlKG1zLT5mZHQsIG5hbWUpOwo+IC3CoMKgwqAgcWVtdV9mZHRf
c2V0cHJvcF9zdHJpbmcobXMtPmZkdCwgbmFtZSwgImNvbXBhdGlibGUiLAo+ICJuczE2NTUwYSIp
Owo+IC3CoMKgwqAgcWVtdV9mZHRfc2V0cHJvcF9zaXplZF9jZWxscyhtcy0+ZmR0LCBuYW1lLCAi
cmVnIiwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAyLCBzLT5tZW1tYXBbbWVtSWRdLmJhc2UsCj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMiwg
cy0+bWVtbWFwW21lbUlkXS5zaXplKTsKPiAtwqDCoMKgIHFlbXVfZmR0X3NldHByb3BfY2VsbCht
cy0+ZmR0LCBuYW1lLCAiY2xvY2stZnJlcXVlbmN5IiwKPiAzNjg2NDAwKTsKPiAtwqDCoMKgIHFl
bXVfZmR0X3NldHByb3BfY2VsbChtcy0+ZmR0LCBuYW1lLCAiaW50ZXJydXB0LXBhcmVudCIsCj4g
aXJxX21taW9fcGhhbmRsZSk7Cj4gLcKgwqDCoCBpZiAocy0+YWlhX3R5cGUgPT0gVklSVF9BSUFf
VFlQRV9OT05FKSB7Cj4gLcKgwqDCoMKgwqDCoMKgIHFlbXVfZmR0X3NldHByb3BfY2VsbChtcy0+
ZmR0LCBuYW1lLCAiaW50ZXJydXB0cyIsIGlycU5vKTsKPiAtwqDCoMKgIH0gZWxzZSB7Cj4gLcKg
wqDCoMKgwqDCoMKgIHFlbXVfZmR0X3NldHByb3BfY2VsbHMobXMtPmZkdCwgbmFtZSwgImludGVy
cnVwdHMiLCBpcnFObywKPiAweDQpOwo+ICvCoMKgwqAgaWYgKHMtPnVhcnQxX3ByZXNlbnQpIHsK
PiArwqDCoMKgwqDCoMKgwqAgcmlzY3ZfY3JlYXRlX2ZkdF91YXJ0KG1zLT5mZHQsICZzLT5tZW1t
YXBbVklSVF9VQVJUMV0sCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgVUFSVDFfSVJRLCBzLT5haWFfdHlwZSwKPiBpcnFfbW1pb19w
aGFuZGxlKTsKPiDCoMKgwqDCoCB9Cj4gwqAKPiAtwqDCoMKgIGlmIChWSVJUX1VBUlQwID09IG1l
bUlkKSB7Cj4gLcKgwqDCoMKgwqDCoMKgIHFlbXVfZmR0X3NldHByb3Bfc3RyaW5nKG1zLT5mZHQs
ICIvY2hvc2VuIiwgInN0ZG91dC1wYXRoIiwKPiBuYW1lKTsKPiAtwqDCoMKgwqDCoMKgwqAgcWVt
dV9mZHRfc2V0cHJvcF9zdHJpbmcobXMtPmZkdCwgIi9hbGlhc2VzIiwgInNlcmlhbDAiLAo+IG5h
bWUpOwo+IC3CoMKgwqAgfQo+IC19Cj4gK8KgwqDCoCByaXNjdl9jcmVhdGVfZmR0X3VhcnQobXMt
PmZkdCwgJnMtPm1lbW1hcFtWSVJUX1VBUlQwXSwKPiBVQVJUMF9JUlEsCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHMtPmFpYV90eXBlLCBpcnFf
bW1pb19waGFuZGxlKTsKPiDCoAo+IC1zdGF0aWMgdm9pZCBjcmVhdGVfZmR0X3VhcnRzKFJJU0NW
VmlydFN0YXRlICpzLCB1aW50MzJfdAo+IGlycV9tbWlvX3BoYW5kbGUpCj4gLXsKPiAtwqDCoMKg
IGlmIChzLT51YXJ0MV9wcmVzZW50KSB7Cj4gLcKgwqDCoMKgwqDCoMKgIGNyZWF0ZV9mZHRfdWFy
dChzLCBpcnFfbW1pb19waGFuZGxlLCBWSVJUX1VBUlQxLCBVQVJUMV9JUlEpOwo+IC3CoMKgwqAg
fQo+IC3CoMKgwqAgY3JlYXRlX2ZkdF91YXJ0KHMsIGlycV9tbWlvX3BoYW5kbGUsIFZJUlRfVUFS
VDAsIFVBUlQwX0lSUSk7Cj4gK8KgwqDCoCBuYW1lID0gcmlzY3ZfZmR0X2dldF91YXJ0X25vZGVu
YW1lKHMtPm1lbW1hcFtWSVJUX1VBUlQwXS5iYXNlKTsKPiArwqDCoMKgIHFlbXVfZmR0X3NldHBy
b3Bfc3RyaW5nKG1zLT5mZHQsICIvY2hvc2VuIiwgInN0ZG91dC1wYXRoIiwKPiBuYW1lKTsKPiAr
wqDCoMKgIHFlbXVfZmR0X3NldHByb3Bfc3RyaW5nKG1zLT5mZHQsICIvYWxpYXNlcyIsICJzZXJp
YWwwIiwgbmFtZSk7Cj4gwqB9Cj4gwqAKPiDCoHN0YXRpYyB2b2lkIGNyZWF0ZV9mZHRfcnRjKFJJ
U0NWVmlydFN0YXRlICpzLAo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3Jpc2N2L2ZkdC1jb21t
b24uaCBiL2luY2x1ZGUvaHcvcmlzY3YvZmR0LQo+IGNvbW1vbi5oCj4gaW5kZXggYTQ1YjA2M2Y2
Ni4uYzhiMjUzNDhiZCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2h3L3Jpc2N2L2ZkdC1jb21tb24u
aAo+ICsrKyBiL2luY2x1ZGUvaHcvcmlzY3YvZmR0LWNvbW1vbi5oCj4gQEAgLTEyOCw0ICsxMjgs
OSBAQCB2b2lkIHJpc2N2X2NyZWF0ZV9mZHRfc29ja2V0X2FwbGljKHZvaWQgKmZkdCwKPiBBUExJ
Q0ZkdFByb3BzICpwcm9wcywKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90ICphcGxpY19waGFuZGxl
cyk7Cj4gwqB2b2lkIHJpc2N2X2NyZWF0ZV9mZHRfc29ja2V0X2FjbGludCh2b2lkICpmZHQsIEFD
TElOVEZkdFByb3BzCj4gKnByb3BzLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCAqaW50Y19w
aGFuZGxlcyk7Cj4gKy8qIENhbGxlciBtdXN0IGZyZWUgdGhlIHJldHVybmVkIHN0cmluZy7CoCAq
Lwo+ICtjaGFyICpyaXNjdl9mZHRfZ2V0X3VhcnRfbm9kZW5hbWUoaHdhZGRyIGFkZHIpOwo+ICt2
b2lkIHJpc2N2X2NyZWF0ZV9mZHRfdWFydCh2b2lkICpmZHQsIGNvbnN0IE1lbU1hcEVudHJ5ICp1
YXJ0X21lbSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBpbnQgdWFydF9pcnEsIGludCBhaWFfdHlwZSwKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCBpcnFfcGhhbmRsZSk7
Cj4gwqAjZW5kaWYK

