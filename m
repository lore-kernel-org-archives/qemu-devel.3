Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF68C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 08:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA2oJ-0001wt-Ok; Wed, 30 Apr 2025 04:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uA2oH-0001vR-NN
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 04:28:53 -0400
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1uA2oF-0003qj-4f
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 04:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1746001731; x=1777537731;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=V2HNe8ASOGZEifKHGF30s81bjGa7vqoroAwUS/5x8fg=;
 b=w/T1L5vTDXvXb2zMVQH5UT+KLpAUz/DOQR7CBOxmN+0q0LEih79jlJvQ
 ZPddRKpkJmSP/JkjTs/khj2bkILOd89VlIda5LGCupg6owu9jEdIkT4tE
 5s39bqAkoCyF91omhkoxHdBq7cfXvrAnzIFCcMEhZ7PHDCcxGjxYoIMiM
 oqimb7YQIlXrokQJd4srNNzb5eGCGehmWW/N/6TsSj1IhSlPueZpNi6LT
 ptdpymSWJZCr8E0vsPscwoUqYLTyYfoZnEcIIxebeCy6bsyoSG0AWGDgx
 T4i7uLZ7B2zS1zPToBDO8mogRLZmmLatuSzYO3cjNPnlLA0JnX0qjWqKe Q==;
X-CSE-ConnectionGUID: RAXlfDPMQryhNt+QO/WBjQ==
X-CSE-MsgGUID: RDC7DoMCRGGdTB07DQBaxQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="154759922"
X-IronPort-AV: E=Sophos;i="6.15,251,1739804400"; d="scan'208";a="154759922"
Received: from mail-japaneastazlp17010002.outbound.protection.outlook.com
 (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.2])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2025 17:28:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMPt+8rhnxUE5Po8LGxWHIH991tTWNbEQx76aQZjBg/Dh9Ava+8uDiBhoyyA8FkGOlBNAh7PjghxlRr+cLTS232tAAtz5hG3AbNmVSHxDLh9fDRg50Q+EWK7kJ7ejrTtd29MNylTFGsd7IRfRBrJKilxIFBcZoV5sWruRxm+hfVDSjpyYYr8mUXrPPiQ4XqF72D/wj/wxrG8/lRZtIlpf5a/uFbBp563/KxEQrBzWSHZYuJfedtqWkAiJL/szabgCz0uK2Ftk+TCsUZrum6B1GN2p/S86pT1c3lFwmGNXgS2lJ07HCxjDrPEHOWY1pHmom8vCvDmVT/5gS3L09q2YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2HNe8ASOGZEifKHGF30s81bjGa7vqoroAwUS/5x8fg=;
 b=R3AvTj8Yxevm0CUa10c3S02l+rAGW2FsF2bIjgYcQqk6FxdfkJwwW8QYbje+dulJyHTLiQzvZzAvxSEIxnsktnSyDt+CNxv+Gb09ITzIPA4rLW25dKds1Ifnud6ShNJtOw504S2K3GQcsMOpFDTBHFKTwWiyb9LJcJfgMBYnsIHVTqe3Rj2x6rH67EdV9ex6JOhjPOVqmC9NSmzWQ9TA38JopzxM1t2k7/Hzl7EHlE8uCAPbExbbCMDJ5w6KEfQVqiN4nexHifXVMq1PnWKkRHpL1y4pdGt9tV4rHHGjRq7yxDJVt1tBXFb2WS6jH4v518CBXebnI9JQ24oVTkz/0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by TYWPR01MB10065.jpnprd01.prod.outlook.com (2603:1096:400:1e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Wed, 30 Apr
 2025 08:28:36 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%4]) with mapi id 15.20.8678.027; Wed, 30 Apr 2025
 08:28:36 +0000
To: Peter Xu <peterx@redhat.com>
CC: Fabiano Rosas <farosas@suse.de>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Jack Wang <jinpu.wang@ionos.com>, "Michael R . Galaxy"
 <mrgalaxy@nvidia.com>, Yu Zhang <yu.zhang@ionos.com>
Subject: Re: [PATCH] qtest/migration/rdma: Add test for rdma migration with
 ipv6
Thread-Topic: [PATCH] qtest/migration/rdma: Add test for rdma migration with
 ipv6
Thread-Index: AQHbnr3GPFM2rsTaa0SkDCwflcGbZrO7WJ6AgAC9noA=
Date: Wed, 30 Apr 2025 08:28:36 +0000
Message-ID: <78c811ed-d6a2-4811-9ac8-48c5c93a2fed@fujitsu.com>
References: <20250327021234.264161-1-lizhijian@fujitsu.com>
 <aBFAIflmJns_nVIm@x1.local>
In-Reply-To: <aBFAIflmJns_nVIm@x1.local>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|TYWPR01MB10065:EE_
x-ms-office365-filtering-correlation-id: 63b99c24-1b25-44b0-49d4-08dd87c100aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018|1580799027; 
x-microsoft-antispam-message-info: =?utf-8?B?dmNWUmFvaG1yRXVybHFJb2luOVVmOTNrNXhzc0hVdFdZUUxBeGRjQ09JcGlR?=
 =?utf-8?B?SUVlZ3JCVllyV3E0UFk3c1oyVmVTYWp1ZDMzRm53Z05yZUlYaVNLeGhVRzI0?=
 =?utf-8?B?c0ZiWFArMEFYeHBLTGR4T0k4TFE5N0w3dGNuR3Vub0NkMnZGYjFlaHVRalpG?=
 =?utf-8?B?TkVEdlR6eU5obzNCN2s2RjY4akI1UHMxaS93Y21IYnBwRjlIbERYU0JPK3pG?=
 =?utf-8?B?QlFHdlQwUmZRV2QrWGhRMmRVNDJJOWM4VXpCT0JzNmV0b2xqZXVUMHBrTWwx?=
 =?utf-8?B?bTlramVyaDA5VGtlSTE1dHkvZi9sK2k3cmcxMUlEUXUvaXIwdzNNR3Z3MUhk?=
 =?utf-8?B?SGxkVjhtaVdLcjhuQW1CUWJETENvSUIzdzZTRTE0ejJrZDVZUDJuSThWRG92?=
 =?utf-8?B?MnZ2WWpGUlNiZ0UxZFA1RmQ3ZlM3MVJ6Wm5ObEloYTYydkhrYmtHSEgrN3BZ?=
 =?utf-8?B?b2pWYlNCVUQ5SXpZdGkvQ1dEREdyanpEVnJtaU9jOXlyRnFkRFdmeHB1dkF0?=
 =?utf-8?B?V2srdFI0RE9NeEMrMXordkxiU1I4bmdvc0hrYVY5Q2gzTXZvUm5Ha1RQSkZ2?=
 =?utf-8?B?dUtHeUx3U28yZW9FRnhKUkJkbE9iUGpDS1V5cFZIZE1iSTFZTlBDWDd1cFk5?=
 =?utf-8?B?VzJ4UE9hYU51OVc4Q3U3dEMyU1ZCSnlyOGFVYWpUZ1dCZ1gwQTlacWJSaGhU?=
 =?utf-8?B?SlRPVWNHd0lwNkZLczhvNFVtZHZqMVowdTJtamhrK0FIdjYyRlRTOW9haWly?=
 =?utf-8?B?Y3VGbHU4N2x4Z0tFenUraXU3SENyRlcrWHlZaFpseFBQNSs3bEkxQXh5czdz?=
 =?utf-8?B?dU1UN0p3RC8vSXY0ekcwZ0JhMGV6SnFPSEpVYTJGdWYvY0FsMmw4S0Rvb3Jv?=
 =?utf-8?B?anBkNHQzcHBSUThJTmxCbzFOT2M0UEVsanlKd0NtSFpNQktlSlovTGllWW5K?=
 =?utf-8?B?VExCOGdnM0hoVXZZdHl5R0RDVWp4Skg5TkVBczlRbVFhOFdCQnVTbUFGS0lr?=
 =?utf-8?B?MHg5Q2g2dzFTVU8zSkwybC9nZFkvRkdOdUhWOUN4NHdHVW1XVW5wbmVDWEo2?=
 =?utf-8?B?d2FtSkZ5UXI3UFJDMXFBU1VyRUQvTGZBV1p1VndQUXM5N0tVRENIUG5rMytY?=
 =?utf-8?B?ejB0ZkNQYzh2ZFUzZi9Lc21mQ2xJWlkxdk1VZTRnbjlzSHBYRFRadFRqYWdY?=
 =?utf-8?B?N3BQTXgwUUR2M0MyQ1FLQXpNMExoUkJjTThFanF4M2lsU3hDM2VUT2Nyb1lq?=
 =?utf-8?B?VUxMSVF4Y0tuRWdKVFJrRFdYNnJwZzdYRSthM045Tzg0Z1B0MHU3VHk2djFj?=
 =?utf-8?B?cHRLTjZSaG1obDYvNzluaktXaHJkeDh2N1JkeFdvenRUVThyVFhBV01ISDN5?=
 =?utf-8?B?R29aWHJLZVk3ZFAwa1NWZEoyK1NVNmM0VUh3ZS8wbllIdHJZYXJTS1l2N250?=
 =?utf-8?B?UTBhTHRKOGIxTHFreVE4U3FTR2loUWh4QkFBVmtZdWpOYjZvck9NMExJczNa?=
 =?utf-8?B?dXdvLzZUNG1NQjBIRTZsaUlVZkF6cWZvdjRWQlRlak9RK1RuMXo3QlVHM1ho?=
 =?utf-8?B?aDhxVW5nMDVKMWRkdWtVOUF0NFcxL0N3b1hTTGlod3hqTzRiZXNETFZjeCtt?=
 =?utf-8?B?U0VkZFJ3Z3lvcWYyaXJDMC93WkhIZHB6bnN5dTAveklXRXlpMDlOMWQvWlVz?=
 =?utf-8?B?azc0RXJVcGNoa2JuNFZGNmlhTlVNQmRDYjg2dmNLU2ZZbGMyMmhpOURjRU5n?=
 =?utf-8?B?M0t2aERSdWtJR21JbnUyM0o4OVN0TFUva2JaRnhpODZQb05nengzSENCdHA0?=
 =?utf-8?B?cDZEYlowUVZaTzRVcmVTTDFVQXpUZ0JTWTYwUUxEUkh1RUw3bHc2Z2w5Vkxs?=
 =?utf-8?B?WjVqMnFDMGpUcHVkdmp5cE80QlBoUmlEd0t6dmlDUDloQThaL2JvbURGdjhR?=
 =?utf-8?B?Mk5udFk2Y3FhQnF2cVpLR3RkQmdtQlpRbFd6Ykl4dlV6RlIxcW14a3h4Qkh3?=
 =?utf-8?B?R2xPTEk3M2Q4ZVRBT2hrRzFvMHd5dmNYTHA5d3krb0FJT2VrVmg5dG15KzF5?=
 =?utf-8?Q?ABgTEC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TY1PR01MB1562.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(1580799027); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V1puOEdTQmtIbEFHVHpxUGdaajlHOW1DbkZ2QzdaQWI1ZDVhTXBnSTNqci9V?=
 =?utf-8?B?RzVKNlFvS3YzdFM5NisyZ2FJZXhxczNpRXdlbmFnN2xkVjUzaWhSdi9GbUd1?=
 =?utf-8?B?ZFgxdnRsTTZUekxXajR0b1kyMmZTTVlBNjJidllTOUcrWVI2QjRFNTY2TFhi?=
 =?utf-8?B?MWFDbmdjUWU1NHk2MTEra0psOEoxNllIdEpHbXFSVndKUVlUMVVCSUdSTytU?=
 =?utf-8?B?Z2h3bzRpNVJNN3ZHQ2dOWjhrUXNQNGh5dmhqU1QvMDVzYTN1cTdnUGd5bGhp?=
 =?utf-8?B?QklVeXJuM3VyREM4eGp1NTJFaDFJUzdqU2NSdWMrZzYySUpjbWRuZnZHUzdQ?=
 =?utf-8?B?VlpVVVZ1eEQzN1RBY3NLUFF3ZFFES2JNbm5CY0REODRxajlNTGtHck95NUlM?=
 =?utf-8?B?L1lUVlhyUDcxQVRobDdIb3ZIcXROZVRlVVgzV2UrYlNuMnF3TEFHOGErQWJP?=
 =?utf-8?B?OWpCSmYyR0VtT1lsYUVLb0sxeUVia3FnZ1g2bFdhN3d4K2dzU29BTUkxbVJI?=
 =?utf-8?B?OElrTW1RQW13dVFkOG9KTVZHcEcvUlVhbldSNHVGMVZHT3dCODlWWVZ5V1hw?=
 =?utf-8?B?dkttbkRuZWVpTFljbTNZQ2wxNjF5MlBQTEQ5NVhDOU9VOExLRDh2WHEvdlk4?=
 =?utf-8?B?YjV0UFk0OVh3Y0pzN2RDMU1JWmdGVU5vYU9XeUV2bysrUlM4a0FBNXFiN3JL?=
 =?utf-8?B?V2oxS1UxVzBVK3Y2WElpY0tNZzZWbk9id2Z5eWxMbkVFTEJzQWdwdEdDenpP?=
 =?utf-8?B?TXRWYlRWMlJWTEFEQk11cGw5TkxGckRtUVpieUd6VVZVTmowUy9VdkwxdGdy?=
 =?utf-8?B?Z3J2YzZlTVR6ZW9XWkVtcU5qV2phbkg0MnBVR2VtTFNzaCtERzIrOW8zZHNz?=
 =?utf-8?B?bEVBVjMrMDd0THdvWkZrSy9Nam5QbXhtRnBqQzRoaFZHcTZvVkt0U1J3b3hi?=
 =?utf-8?B?dXlaT0Vkd1pkcU11QjcxUFdTUTBpWnhUTXFFdTNhQVJhOHRSTzdFTmFSQ2Rh?=
 =?utf-8?B?Mmw3d1B5d0h1RTdhSThTTjhiako5Y0Npb1Q4Tkk1QTg0QVY1Y3ZTMTdJeC9X?=
 =?utf-8?B?WGxPV21scWJCc2JkY3FXbHNRanA0NGRISDR1ZTNqMkludW51OE1wOHl3SnFG?=
 =?utf-8?B?VGx4Y3lITTdGMzZUSHRCKzhCcXlncW9lVFlyci9la2FQdW44VjYxeGZCczM3?=
 =?utf-8?B?K1ozcEo4Y1FrU2RVQytmZ21WRmlmb0RnSDdJdTg1ZEZZTHE1ZDlBUWVnVmxj?=
 =?utf-8?B?TXBFZTViR2NzK3lESTBrWms3RDlYNkRqemtSQmRpWFhEdFNtZWpQQkRYZHY1?=
 =?utf-8?B?Uy9yN01aVVRZUjNPVHZNMkNjNzVVelkzVmI5MFoxeUE5UDJvNCtUUTEvd3Nk?=
 =?utf-8?B?d3lpTGpSdWVGNE93YzZzcnBuV1F5NFhEWnRQSGpxenBwdjlMVll4VE5OdHZT?=
 =?utf-8?B?OWlJVVgzWmQ3aElrUDlPV2t0UnA1dEEwaDBwTG1od2RpQmxvOVhxU2Y1ZXRy?=
 =?utf-8?B?eEE3MjdDV2dQYVRWMmo5K2VIdXM5dDZ1QkJTWHh0aGVIUDRTNjgxbmlVVWVj?=
 =?utf-8?B?OVd5dHhZZHAxRkpDZVllNEkvZWRiVWoxN09UNXZSc1dXTXgyNTBRcC84Q3lv?=
 =?utf-8?B?ZTVKcXNvdGkxRnNJYWxUNGJtcjdBZHlpbjVEREptWGgvWmdNa2JlR0RDeDkw?=
 =?utf-8?B?aW1kdmsxNnJHMUIrNFZodVVEWklzYS9rTS9BY3NIcDMwZ29UVGZpTFBTdkZt?=
 =?utf-8?B?dHdDekVtL1ZQOU9VT25qQXNHakxDZ0dRekRZUmNxS2g4ZndYWmZENlAyWng5?=
 =?utf-8?B?blczYmRsZitRYnVWM01Ya0xXU1NqOTBZenVQNHJqaFplWGFmWWZRNlo0TExo?=
 =?utf-8?B?Wm15UCt0Y1pyeWdWU2NQVHZzSmJVVmgxTkpUWnNmTWtjZzF4Vzc2elROc050?=
 =?utf-8?B?YVZEczh0cFpkTk1KVmpiUExVM0gxZDlURHNMQ0FWUnRGY1c5T0F1STJhOUFa?=
 =?utf-8?B?Tkxkakt2RjNvWGhWRnZqa0hQWjVleXZQZjlLTFIyZ25ZZWcrQjd4N3F3N0Zz?=
 =?utf-8?B?cHZ1Rkt3OUl0SElTU1dONnpmU1RVNmlwOHYvd0hKdEF4d09SbVk1VUZSZnVn?=
 =?utf-8?B?b2V3OStDUkJlMGVjVDNjWUJ3TUlPRVJjd3hEV0FPM1N2anFGWmdGZzRDTlFv?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F6349B0C4D8964A97B875B5AFA52CF3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: n0X8RCevgLpYLzu2P9H8grXfHvu8TBrwvL41F+vFSegus0IdeyQX+ZHh8VfUwUTKiKrE/oNkdmlatcMoQIbb5YoLstE5dpwa7+/Xry52OJNmzgumNH23sERiISm3R8KEGfdRizXi35mxIzLUvEZcnTSJohr2g+PjrjkZMBlxs8NJvaALURAdYL+MnnL5OzRLMIiKXdKWbaqAYuI9Ih24AkjoHeL0RtmNdXybXYcY7KRfb3JoDUvMRgNCpGCCcH51FwgLiEINz/q1z4Vzo7IChT9UNBUAWPifHtEtYpSP7cQY3Hb4QO4DbSHzfTBah9LTEvQc2PtPnz3lhuzwBBwl0VuBsezbGY+FDSdsBpy9FFIyhCWo+QSDwj891iPyyHcDWlVsYN3AsjHHZRIdbz2EsOf8dglhDvUiis9C0vu+Y9sMH3/7IiBIENcMp2BYyr8nx9QeeWPQwX7QK+nzILORlcSTK3zDJqv7ZOqch0UJGRspv5UlCDsPhmfrW/fUEp9LGqtc4VEAn+d6H/iYEgIcDXmyOKIR9vxe/b0LtNs9OnI7ZrkCkr+FEu2TyS3Ticzf12Rv8NSpb+lUChe6flWeCJVnSi1jigz4Ksnxv2khRAQL97i0bkVUvhXel5YLvbCp
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b99c24-1b25-44b0-49d4-08dd87c100aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 08:28:36.6032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3DjTqjpZEKoH5d8WfoXLyI+41HwgwUu/rcYqCrEiJk1H3wigde85E1epQYxCG+b6NUZ+zLdCJCkt4dXUIn98Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10065
Received-SPF: pass client-ip=68.232.156.107;
 envelope-from=lizhijian@fujitsu.com; helo=esa15.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
From:  "Zhijian Li (Fujitsu)" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDMwLzA0LzIwMjUgMDU6MDksIFBldGVyIFh1IHdyb3RlOg0KPiBPbiBUaHUsIE1hciAy
NywgMjAyNSBhdCAxMDoxMjozNEFNICswODAwLCBMaSBaaGlqaWFuIHdyb3RlOg0KPj4gUmVjZW50
bHksIHdlIHJlbW92ZWQgaXB2NiByZXN0cmljdGlvblswXSBmcm9tIFJETUEgbWlncmF0aW9uLCBh
ZGQgYQ0KPj4gdGVzdCBmb3IgaXQuDQo+Pg0KPj4gWzBdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3FlbXUtZGV2ZWwvMjAyNTAzMjYwOTUyMjQuOTkxOC0xLWppbnB1LndhbmdAaW9ub3MuY29tLw0K
Pj4NCj4+IENjOiBKYWNrIFdhbmcgPGppbnB1LndhbmdAaW9ub3MuY29tPg0KPj4gQ2M6IE1pY2hh
ZWwgUi4gR2FsYXh5IDxtcmdhbGF4eUBudmlkaWEuY29tPg0KPj4gQ2M6IFBldGVyIFh1IDxwZXRl
cnhAcmVkaGF0LmNvbT4NCj4+IENjOiBZdSBaaGFuZyA8eXUuemhhbmdAaW9ub3MuY29tPg0KPj4g
U2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPj4gLS0t
DQo+Pg0KPj4gVGhpcyB0ZXN0IGlzIGFkZGVkIGJhc2VkIG9uIFsxXQ0KPiANCj4gSG1tLCB0aGlz
IGNhbm5vdCBhcHBseSBjbGVhbmx5IG9uIHRvcCBvZiB5b3VyIHJkbWEgdGVzdCArIEpha2UncyBp
cHY2IGZpeC4NCj4gRGlkIEkgbWFkZSBpdCB3cm9uZyBzb21ld2hlcmU/DQo+IA0KPiBBdCB0aGUg
bWVhbnRpbWUsIEkgZm91bmQgdGhhdCB0aGUgY3VycmVudCByZG1hIHVuaXQgdGVzdCBmYWlsaW5n
IGlmIEkgZGlkDQo+IHRoZSAic2V0dXAiIHBoYXNlIHRoZW4gcnVuIHRoaXMgdGVzdCB3aXRob3V0
IHJvb3Q6DQo+IA0KDQpUaGFua3MgZm9yIHlvdSByZXBvcnQsIEkgcmVwcm9kdWNlZCBpdCBvbiBm
ZWRvcmE0MCB3aGlsZSB1YnVudHUyMjA0IGFsd2F5cyB3b3JrcyB3ZWxsLg0KDQpJIHdpbGwgbG9v
ayBpbnRvIGl0Lg0KDQoNClRoYW5rcw0KWmhpamlhbg0KDQoNCj4gc3RkZXJyOg0KPiBxZW11LXN5
c3RlbS14ODZfNjQ6IGNhbm5vdCBnZXQgcmtleQ0KPiBxZW11LXN5c3RlbS14ODZfNjQ6IGVycm9y
IHdoaWxlIGxvYWRpbmcgc3RhdGUgc2VjdGlvbiBpZCAyKHJhbSkNCj4gcWVtdS1zeXN0ZW0teDg2
XzY0OiBsb2FkIG9mIG1pZ3JhdGlvbiBmYWlsZWQ6IE9wZXJhdGlvbiBub3QgcGVybWl0dGVkDQo+
IHFlbXUtc3lzdGVtLXg4Nl82NDogcmRtYSBtaWdyYXRpb246IHJlY3YgcG9sbGluZyBjb250cm9s
IGVycm9yIQ0KPiBxZW11LXN5c3RlbS14ODZfNjQ6IFJETUEgaXMgaW4gYW4gZXJyb3Igc3RhdGUg
d2FpdGluZyBtaWdyYXRpb24gdG8gYWJvcnQhDQo+IHFlbXUtc3lzdGVtLXg4Nl82NDogZmFpbGVk
IHRvIHNhdmUgU2F2ZVN0YXRlRW50cnkgd2l0aCBpZChuYW1lKTogMihyYW0pOiAtMQ0KPiBxZW11
LXN5c3RlbS14ODZfNjQ6IENoYW5uZWwgZXJyb3I6IE9wZXJhdGlvbiBub3QgcGVybWl0dGVkDQo+
ICoqDQo+IEVSUk9SOi4uL3Rlc3RzL3F0ZXN0L21pZ3JhdGlvbi9taWdyYXRpb24tcW1wLmM6MjAw
OmNoZWNrX21pZ3JhdGlvbl9zdGF0dXM6IGFzc2VydGlvbiBmYWlsZWQgKGN1cnJlbnRfc3RhdHVz
ICE9ICJmYWlsZWQiKTogKCJmYWlsZWQiICE9ICJmYWlsZWQiKQ0KPiBxZW11LXN5c3RlbS14ODZf
NjQ6IHdhcm5pbmc6IEVhcmx5IGVycm9yLiBTZW5kaW5nIGVycm9yLg0KPiBxZW11LXN5c3RlbS14
ODZfNjQ6IHdhcm5pbmc6IHJkbWEgbWlncmF0aW9uOiBzZW5kIHBvbGxpbmcgY29udHJvbCBlcnJv
cg0KPiAuLi90ZXN0cy9xdGVzdC9saWJxdGVzdC5jOjE5OToga2lsbF9xZW11KCkgdHJpZWQgdG8g
dGVybWluYXRlIFFFTVUgcHJvY2VzcyBidXQgZW5jb3VudGVyZWQgZXhpdCBzdGF0dXMgMSAoZXhw
ZWN0ZWQgMCkNCj4gDQo+IFNvIHJ1bm5pbmcgdGhlIHRlc3QgYWxzbyBuZWVkcyByb290PyAgSXMg
aXQgcG9zc2libGUgd2UgZml4IHRoZSB0ZXN0IHNvIGl0DQo+IGNhbiBhbHNvIGJlIHNtYXJ0IGVu
b3VnaCB0byBza2lwIGlmIGl0IGtub3dzIGl0J2xsIGhpdCB0aGUgImNhbm5vdCBnZXQNCj4gcmtl
eSIgZXJyb3IgKGV2ZW4gaWYgaXQgc2VlcyB0aGUgcmRtYSBsaW5rIHNldHVwKT8gIE5vdCBzb21l
dGhpbmcgdXJnZW50DQo+IGJ1dCBkZWZpbml0ZWx5IGdvb2QgdG8gaGF2ZS4NCj4gDQo+IE9UT0gs
IHJ1bm5pbmcgdGhlIHRlc3QgdXNpbmcgcm9vdCBhbHdheXMgd29ya3MgZm9yIG1lLg0KDQoNCj4g
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29t
Pg0KPj4gLS0tDQo+PiAgIHNjcmlwdHMvcmRtYS1taWdyYXRpb24taGVscGVyLnNoICAgICAgfCAy
NiArKysrKysrKysrKysrKysrKysrKysrKy0tLQ0KPj4gICB0ZXN0cy9xdGVzdC9taWdyYXRpb24v
cHJlY29weS10ZXN0cy5jIHwgMjEgKysrKysrKysrKysrKysrKystLS0tDQo+PiAgIDIgZmlsZXMg
Y2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvc2NyaXB0cy9yZG1hLW1pZ3JhdGlvbi1oZWxwZXIuc2ggYi9zY3JpcHRzL3JkbWEtbWln
cmF0aW9uLWhlbHBlci5zaA0KPj4gaW5kZXggMDE5YjlhZDkzMi4uYzM1ODM5MmI3MiAxMDA3NTUN
Cj4+IC0tLSBhL3NjcmlwdHMvcmRtYS1taWdyYXRpb24taGVscGVyLnNoDQo+PiArKysgYi9zY3Jp
cHRzL3JkbWEtbWlncmF0aW9uLWhlbHBlci5zaA0KPj4gQEAgLTgsNiArOCwxNSBAQCBnZXRfaXB2
NF9hZGRyKCkNCj4+ICAgICAgICAgICBoZWFkIC0xIHwgdHIgLWQgJ1xuJw0KPj4gICB9DQo+PiAg
IA0KPj4gK2dldF9pcHY2X2FkZHIoKSB7DQo+PiArICAgIGlwdjY9JChpcCAtNiAtbyBhZGRyIHNo
b3cgZGV2ICIkMSIgfA0KPj4gKyAgICAgICAgc2VkIC1uICdzLy4qW1s6Ymxhbms6XV1pbmV0Nltb
OmJsYW5rOl1dKlwoW15bOmJsYW5rOl0vXSpcKS4qL1wxL3AnIHwNCj4+ICsgICAgICAgIGhlYWQg
LTEgfCB0ciAtZCAnXG4nKQ0KPj4gKw0KPj4gKyAgICBbICQ/IC1lcSAwIF0gfHwgcmV0dXJuDQo+
PiArICAgIGVjaG8gLW4gWyIkaXB2NiIlJDFdDQo+PiArfQ0KPj4gKw0KPj4gICAjIGV4aXN0aW5n
IHJkbWEgaW50ZXJmYWNlcw0KPj4gICByZG1hX2ludGVyZmFjZXMoKQ0KPj4gICB7DQo+PiBAQCAt
MjAsMTEgKzI5LDE2IEBAIGlwdjRfaW50ZXJmYWNlcygpDQo+PiAgICAgICBpcCAtbyBhZGRyIHNo
b3cgfCBhd2sgJy9pbmV0IC8ge3ByaW50ICQyfScgfCBzb3J0IC11IHwgZ3JlcCAtdiAtdyBsbw0K
Pj4gICB9DQo+PiAgIA0KPj4gK2lwdjZfaW50ZXJmYWNlcygpDQo+PiArew0KPj4gKyAgICBpcCAt
byBhZGRyIHNob3cgfCBhd2sgJy9pbmV0NiAvIHtwcmludCAkMn0nIHwgc29ydCAtdSB8IGdyZXAg
LXYgLXcgbG8NCj4+ICt9DQo+PiArDQo+PiAgIHJkbWFfcnhlX2RldGVjdCgpDQo+PiAgIHsNCj4+
ICAgICAgIGZvciByIGluICQocmRtYV9pbnRlcmZhY2VzKQ0KPj4gICAgICAgZG8NCj4+IC0gICAg
ICAgIGlwdjRfaW50ZXJmYWNlcyB8IGdyZXAgLXF3ICRyICYmIGdldF9pcHY0X2FkZHIgJHIgJiYg
cmV0dXJuDQo+PiArICAgICAgICAiJElQX0ZBTUlMWSJfaW50ZXJmYWNlcyB8IGdyZXAgLXF3ICRy
ICYmIGdldF8iJElQX0ZBTUlMWSJfYWRkciAkciAmJiByZXR1cm4NCj4+ICAgICAgIGRvbmUNCj4+
ICAgDQo+PiAgICAgICByZXR1cm4gMQ0KPj4gQEAgLTMyLDExICs0NiwxMSBAQCByZG1hX3J4ZV9k
ZXRlY3QoKQ0KPj4gICANCj4+ICAgcmRtYV9yeGVfc2V0dXAoKQ0KPj4gICB7DQo+PiAtICAgIGZv
ciBpIGluICQoaXB2NF9pbnRlcmZhY2VzKQ0KPj4gKyAgICBmb3IgaSBpbiAkKCIkSVBfRkFNSUxZ
Il9pbnRlcmZhY2VzKQ0KPj4gICAgICAgZG8NCj4+ICAgICAgICAgICByZG1hX2ludGVyZmFjZXMg
fCBncmVwIC1xdyAkaSAmJiBjb250aW51ZQ0KPj4gICAgICAgICAgIHJkbWEgbGluayBhZGQgIiR7
aX1fcnhlIiB0eXBlIHJ4ZSBuZXRkZXYgIiRpIiAmJiB7DQo+PiAtICAgICAgICAgICAgZWNobyAi
U2V0dXAgbmV3IHJkbWEvcnhlICR7aX1fcnhlIGZvciAkaSB3aXRoICQoZ2V0X2lwdjRfYWRkciAk
aSkiDQo+PiArICAgICAgICAgICAgZWNobyAiU2V0dXAgbmV3IHJkbWEvcnhlICR7aX1fcnhlIGZv
ciAkaSB3aXRoICQoZ2V0XyIkSVBfRkFNSUxZIl9hZGRyICRpKSINCj4+ICAgICAgICAgICAgICAg
cmV0dXJuDQo+PiAgICAgICAgICAgfQ0KPj4gICAgICAgZG9uZQ0KPj4gQEAgLTUwLDYgKzY0LDEy
IEBAIHJkbWFfcnhlX2NsZWFuKCkNCj4+ICAgICAgIG1vZHByb2JlIC1yIHJkbWFfcnhlDQo+PiAg
IH0NCj4+ICAgDQo+PiArSVBfRkFNSUxZPSR7SVBfRkFNSUxZOi1pcHY0fQ0KPj4gK2lmIFsgIiRJ
UF9GQU1JTFkiICE9ICJpcHY2IiBdICYmIFsgIiRJUF9GQU1JTFkiICE9ICJpcHY0IiBdOyB0aGVu
DQo+PiArICAgIGVjaG8gIlVua25vd24gaXAgZmFtaWx5ICckSVBfRkFNSUxZJywgb25seSBpcHY0
IG9yIGlwdjYgaXMgc3VwcG9ydGVkLCIgPiYyDQo+PiArICAgIGV4aXQgMQ0KPj4gK2ZpDQo+PiAr
DQo+PiAgIG9wZXJhdGlvbj0kezE6LWRldGVjdH0NCj4+ICAgDQo+PiAgIGNvbW1hbmQgLXYgcmRt
YSA+L2Rldi9udWxsIHx8IHsNCj4+IGRpZmYgLS1naXQgYS90ZXN0cy9xdGVzdC9taWdyYXRpb24v
cHJlY29weS10ZXN0cy5jIGIvdGVzdHMvcXRlc3QvbWlncmF0aW9uL3ByZWNvcHktdGVzdHMuYw0K
Pj4gaW5kZXggYTEzN2VhOWYyYy4uOWY3MjM2ZGM1OSAxMDA2NDQNCj4+IC0tLSBhL3Rlc3RzL3F0
ZXN0L21pZ3JhdGlvbi9wcmVjb3B5LXRlc3RzLmMNCj4+ICsrKyBiL3Rlc3RzL3F0ZXN0L21pZ3Jh
dGlvbi9wcmVjb3B5LXRlc3RzLmMNCj4+IEBAIC0xMDIsMTIgKzEwMiwxMyBAQCBzdGF0aWMgdm9p
ZCB0ZXN0X3ByZWNvcHlfdW5peF9kaXJ0eV9yaW5nKHZvaWQpDQo+PiAgICNpZmRlZiBDT05GSUdf
UkRNQQ0KPj4gICANCj4+ICAgI2RlZmluZSBSRE1BX01JR1JBVElPTl9IRUxQRVIgInNjcmlwdHMv
cmRtYS1taWdyYXRpb24taGVscGVyLnNoIg0KPj4gLXN0YXRpYyBpbnQgbmV3X3JkbWFfbGluayhj
aGFyICpidWZmZXIpDQo+PiArc3RhdGljIGludCBuZXdfcmRtYV9saW5rKGNoYXIgKmJ1ZmZlciwg
Ym9vbCBpcHY2KQ0KPj4gICB7DQo+PiAgICAgICBjaGFyIGNtZFsyNTZdOw0KPj4gICAgICAgYm9v
bCB2ZXJib3NlID0gZ19nZXRlbnYoIlFURVNUX0xPRyIpOw0KPj4gICANCj4+IC0gICAgc25wcmlu
dGYoY21kLCBzaXplb2YoY21kKSwgIiVzIGRldGVjdCAlcyIsIFJETUFfTUlHUkFUSU9OX0hFTFBF
UiwNCj4+ICsgICAgc25wcmludGYoY21kLCBzaXplb2YoY21kKSwgIklQX0ZBTUlMWT0lcyAlcyBk
ZXRlY3QgJXMiLA0KPj4gKyAgICAgICAgICAgICBpcHY2ID8gImlwdjYiIDogImlwdjQiLCBSRE1B
X01JR1JBVElPTl9IRUxQRVIsDQo+PiAgICAgICAgICAgICAgICB2ZXJib3NlID8gIiIgOiAiMj4v
ZGV2L251bGwiKTsNCj4+ICAgDQo+PiAgICAgICBGSUxFICpwaXBlID0gcG9wZW4oY21kLCAiciIp
Ow0KPj4gQEAgLTEzMiwxMSArMTMzLDExIEBAIHN0YXRpYyBpbnQgbmV3X3JkbWFfbGluayhjaGFy
ICpidWZmZXIpDQo+PiAgICAgICByZXR1cm4gLTE7DQo+PiAgIH0NCj4+ICAgDQo+PiAtc3RhdGlj
IHZvaWQgdGVzdF9wcmVjb3B5X3JkbWFfcGxhaW4odm9pZCkNCj4+ICtzdGF0aWMgdm9pZCB0ZXN0
X3ByZWNvcHlfcmRtYV9wbGFpbl9pcChib29sIGlwdjYpDQo+PiAgIHsNCj4+ICAgICAgIGNoYXIg
YnVmZmVyWzEyOF0gPSB7fTsNCj4+ICAgDQo+PiAtICAgIGlmIChuZXdfcmRtYV9saW5rKGJ1ZmZl
cikpIHsNCj4+ICsgICAgaWYgKG5ld19yZG1hX2xpbmsoYnVmZmVyLCBpcHY2KSkgew0KPj4gICAg
ICAgICAgIGdfdGVzdF9za2lwKCJObyByZG1hIGxpbmsgYXZhaWxhYmxlXG4iDQo+PiAgICAgICAg
ICAgICAgICAgICAgICAgIiMgVG8gZW5hYmxlIHRoZSB0ZXN0OlxuIg0KPj4gICAgICAgICAgICAg
ICAgICAgICAgICIjIFJ1biBcJyIgUkRNQV9NSUdSQVRJT05fSEVMUEVSICIgc2V0dXBcJyB3aXRo
IHJvb3QgdG8gc2V0dXAiDQo+PiBAQCAtMTU5LDYgKzE2MCwxNiBAQCBzdGF0aWMgdm9pZCB0ZXN0
X3ByZWNvcHlfcmRtYV9wbGFpbih2b2lkKQ0KPj4gICANCj4+ICAgICAgIHRlc3RfcHJlY29weV9j
b21tb24oJmFyZ3MpOw0KPj4gICB9DQo+PiArDQo+PiArc3RhdGljIHZvaWQgdGVzdF9wcmVjb3B5
X3JkbWFfcGxhaW4odm9pZCkNCj4+ICt7DQo+PiArICAgIHRlc3RfcHJlY29weV9yZG1hX3BsYWlu
X2lwKDApOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgdm9pZCB0ZXN0X3ByZWNvcHlfcmRtYV9w
bGFpbl9pcHY2KHZvaWQpDQo+PiArew0KPj4gKyAgICB0ZXN0X3ByZWNvcHlfcmRtYV9wbGFpbl9p
cCgxKTsNCj4+ICt9DQo+PiAgICNlbmRpZg0KPj4gICANCj4+ICAgc3RhdGljIHZvaWQgdGVzdF9w
cmVjb3B5X3RjcF9wbGFpbih2b2lkKQ0KPj4gQEAgLTExODksNiArMTIwMCw4IEBAIHN0YXRpYyB2
b2lkIG1pZ3JhdGlvbl90ZXN0X2FkZF9wcmVjb3B5X3Ntb2tlKE1pZ3JhdGlvblRlc3RFbnYgKmVu
dikNCj4+ICAgI2lmZGVmIENPTkZJR19SRE1BDQo+PiAgICAgICBtaWdyYXRpb25fdGVzdF9hZGQo
Ii9taWdyYXRpb24vcHJlY29weS9yZG1hL3BsYWluIiwNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICB0ZXN0X3ByZWNvcHlfcmRtYV9wbGFpbik7DQo+PiArICAgIG1pZ3JhdGlvbl90ZXN0X2Fk
ZCgiL21pZ3JhdGlvbi9wcmVjb3B5L3JkbWEvcGxhaW4vaXB2NiIsDQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICB0ZXN0X3ByZWNvcHlfcmRtYV9wbGFpbl9pcHY2KTsNCj4+ICAgI2VuZGlmDQo+
PiAgIH0NCj4+ICAgDQo+PiAtLSANCj4+IDIuNDEuMA0KPj4NCj4g

