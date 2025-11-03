Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D21ECCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 07:33:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFp3h-0007eW-KQ; Mon, 03 Nov 2025 02:32:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1vFp3b-0007dS-Q8
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 02:32:52 -0500
Received: from esa4.fujitsucc.c3s2.iphmx.com ([68.232.151.214])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1vFp3V-0004dp-Du
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 02:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1762155165; x=1793691165;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=TJQ8tkrlsGNDC9CEh7/V1orZFn+USt3OqwSqRYUyDAo=;
 b=PC/uB793sy48X0Iv6i0EFyg2VN5qWhqQryhyZU0vdfNTnC/U4K4SVCHN
 UyKdqQlVYtlnamQK4uY1lHTd6+GLHxffp4kGEkI3rDGLUkvVrJhjldwLy
 VyWk3ZJ7nPXinnnLn5uyzEQN5at9nFBmI5JF36oZQh7ZR/1XKS9WIhHfG
 dFwjtkVbKOQalcsQ6TH/J5cNaR7TGO+AXc7CovuiFEBKGtJr5cIVFD+r2
 bBxo8KWIrXXbH/xYuOKncNQeZtMuo3bMOd7JEBk/nVKWaK3a1i01L/S8G
 2Gdts8frQRVBRPn3Nxi+RYc9odTmk9D+SYzljvXSXbccYsIVGadQT4F96 Q==;
X-CSE-ConnectionGUID: IryO3qj0Q1yR5JnCk9bMgg==
X-CSE-MsgGUID: eujBLEl9RQi/ZS2nDLTeqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="85753887"
X-IronPort-AV: E=Sophos;i="6.19,275,1754924400"; d="scan'208";a="85753887"
Received: from mail-japaneastazon11010012.outbound.protection.outlook.com
 (HELO TY3P286CU002.outbound.protection.outlook.com) ([52.101.229.12])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2025 16:32:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tZe/EmUNzgak1bqk6+iQBZF76ReBfl2I8tPOHQJWuqIITrNCpiPPNzEHTihLZA+LUy4KYpm1NK3jySMV8Keb8a06Sp4rbd7j1YQGqdg/TsLsqaS5el5VmkygW1lsXpoPUwZ2Da5v3Anq2ZZhXN9bFCptje+NhXl8pSBfx+7XcyK9L5eyKiSx+xSmTc70Zl8SbtPtH0shLCFjSa+qQH25qat7RRdtilO3YIVPqDzQ40aexsxdyb6fxYF5JF4t3nERI/2zdHN1wgpb5b07bvnMBtRwEN6UBr+7MOEJFIJbTwWMn26bplTrPbk/q3PqCGZnbyhlqXzsG/9poM/O9OpY2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJQ8tkrlsGNDC9CEh7/V1orZFn+USt3OqwSqRYUyDAo=;
 b=Z1/Q5SxFKjabLvEsVwDT9i+YgrGy/1Q75yexQdJKImnLbPlZD9d2SfoIGS4WxuOE7tpxtynkFIykaEPbhzcVG+w+q5ODrXyKZgIM67Ykw2lD93iMPXr6wHMxV4ibaZjRLafknuuXd3nplOztn1+PUckMmAejNlqnlI6HWTQhQiQ9bdWocdQGNUtrpGZBWN6hoLvGUw7pgTARDS81Mf+i4E8va3NEJ1qtIpeIQDle2pa2zevsxgHUNQsrLie0P6Zg7ScwWj1LXE6d+KTPrlRTb1ScZ+oGt6AAdbr+h95mfqsSy4/TarcL93zuv7vhzpUj9V3FYvSxs3a/BBbTwuYAUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJQ8tkrlsGNDC9CEh7/V1orZFn+USt3OqwSqRYUyDAo=;
 b=Uvl43F0s2twRCaA7Uq49da2KQc5TivKFfnScQ7eJNcdXcH9pKY3lSSvX82god91ELMiqeDJYM35Gl0zphth3fCy7Ny9ybf3TUhkjkWRFXRhu7vNm011frGrR/ZHbhpc9idzbg4EHMNAOkLALLetjvORPeT315f5dgKEE0qCKf63X4tAL2VyCEX3vV6/rXrLfNHEXikJaU3REEvpIaC05nhM+ZJpsqUXI6Ex7fatwFkLteI/wkJJKOSE7IuqqcSg/OdIH31GqSbsT/JvGhy5tsMCwS6gdnokDT/mRv0aLl81cwv+/jgG01NKzs8Q/KIEEIs3ADjEC6CZX35uMSoUBhg==
Received: from OS3PR01MB9851.jpnprd01.prod.outlook.com (2603:1096:604:1ee::6)
 by TY3PR01MB11499.jpnprd01.prod.outlook.com (2603:1096:400:377::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Mon, 3 Nov
 2025 07:32:29 +0000
Received: from OS3PR01MB9851.jpnprd01.prod.outlook.com
 ([fe80::3724:ab64:b652:a6b3]) by OS3PR01MB9851.jpnprd01.prod.outlook.com
 ([fe80::3724:ab64:b652:a6b3%5]) with mapi id 15.20.9298.006; Mon, 3 Nov 2025
 07:32:29 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Hailiang Zhang <zhanghailiang@xfusion.com>, Kevin Wolf <kwolf@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Zhang Chen <zhangckid@gmail.com>, "Dr . David Alan
 Gilbert" <dave@treblig.org>, Prasad Pandit <ppandit@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, Juraj
 Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 05/13] migration/rdma: Change io_create_watch() to return
 immediately
Thread-Topic: [PATCH 05/13] migration/rdma: Change io_create_watch() to return
 immediately
Thread-Index: AQHcQ4nGxguxq/g4XkKl3KgUNdQIZbTgoO8A
Date: Mon, 3 Nov 2025 07:32:28 +0000
Message-ID: <c8df389d-630a-403c-8509-5c7db7f99a2e@fujitsu.com>
References: <20251022192612.2737648-1-peterx@redhat.com>
 <20251022192612.2737648-6-peterx@redhat.com>
In-Reply-To: <20251022192612.2737648-6-peterx@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9851:EE_|TY3PR01MB11499:EE_
x-ms-office365-filtering-correlation-id: 90ea9713-2ab1-4f24-8d1d-08de1aab24b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|1580799027|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?M3VUWkNwK3dJTFFsZ3htQjNxK0xLS2N1MXFwdEV6V28xZ2VCTnk2V3pxQzd5?=
 =?utf-8?B?b3BVNXhtYlJHK25QRTFQSUxIMkdhVkNxMW5NaENqZThEeG9KbFZzYWZBVHpz?=
 =?utf-8?B?aUtkb0NnNVhJYVBFYVdTRFJWNnBsOXRndTVSSFdvZ1d6NlMxS205TjJtMEJI?=
 =?utf-8?B?TUt6S2Rnb3Z2a0NKNUZaSE1MenBtSEdWcnJCRGhiSjVXQnRCQUtyNEJucEQ4?=
 =?utf-8?B?ZHpLM0FuaDhnUjh2RUFUK3RjcklGcmRIL3lMRWNudE9lMHh1QXZXUzFWeUdJ?=
 =?utf-8?B?V3h5czJISjczeHFOR3piQXRBSU9OTHJqcVZaWDJVd2xrRTFDUWROMnNEQzFH?=
 =?utf-8?B?NW1jNEJNWEk4L3ZDR3lyalBYOXk0UEdUS3hmcnJlYVRZRWtBaC9GbXViUDlI?=
 =?utf-8?B?ZDUvSDhBYU1CWnRiOUFlRGp4Ukt3ZVNEWHhxa040NlljdGI3b0RKU0N4Nm9h?=
 =?utf-8?B?UnA4OEFtUlo5cFRtaVNodkcxbkRQT1JwQU4wQnFZZzhsbC9kdmdYYjJsb3FU?=
 =?utf-8?B?cENuYU12V0grUkpNd2w2UnJMaWlaWUVwak1DMHdCNlJMU2ducGZuQzc3RUVP?=
 =?utf-8?B?Vk5TMlFWTUpNeFFYSU5ndjArOW85VDc4TnhWTGUyd0FQS2poZTZyUTFHQVRU?=
 =?utf-8?B?UWpEdFpGb1MwOCtHMDJRUktNSUxNdkFFTEsxbk13eDJySTlmb0VGaDVOSk1G?=
 =?utf-8?B?TDlIMi9TUUt6NWdDN1JJdUlENTRuV2QxY3lSUjhUK2tnRGZmZk16dGlKRW83?=
 =?utf-8?B?ZjFOKzJ1dlNkNGE1azhEMnQxYWNhT0VueWFLcDFIN1ZzeGZlaU9BL3g1Sktq?=
 =?utf-8?B?UC9iT0srcEsraDI0S3d5OE5aYUJ6cnpmN28zNk1ybHRCQWZNbW9palc5bS9K?=
 =?utf-8?B?NEc4SDRJdy9VekhFUFkvQWtaZDhabElBQ29qaEI5Q2grZi8wMlQrc1RSTkZU?=
 =?utf-8?B?YktpaWU1Y0c5cGxCdnNNQld1NlVGdkVqNlplWnlhK0p0NHQ4dUFkTmlubk5Z?=
 =?utf-8?B?U042aWNLRU1IdURHdHRidHdsK2RlbHBKR2lLU01yWnQ4MWZBTm1rUDExSkp2?=
 =?utf-8?B?L2NIT2d0VDY2TW1JMlgzY1dHNVJkOWdCWWdnejZBVVVQYWNLRlVMYVFZRVJr?=
 =?utf-8?B?aVcxQms1SnI3RWlEc3lIS2RKR1NiSllrZGl0MGc2RWMrWTNmSmhPMXhsc0t3?=
 =?utf-8?B?L1pLeG4vMk5YUmFOaUJOTEFlTU85elhTSXFZN2hLNmdLa21sOEgvZ1Mrem4r?=
 =?utf-8?B?K0NZbGs5VVlzcC8yb2I2VWc0bmM5OHZ6bkdqcW1xbHhlSndlM1d6Ylh2b3lE?=
 =?utf-8?B?NDRxWi9IdnIxQnJrblJOV1d2a2g4SytUdU56eXF5a1RnT1BRM1p0R2puZktI?=
 =?utf-8?B?VmlQNHA1dVliZitlMzVkWXhlUmpCRVZOVUYwVWpKVjNIRjA4YTdoOWRObHRM?=
 =?utf-8?B?SXZ1djdFSCtOeloyQmhsWElRVHBRRGtCeDJ0VFZ6a3R6SGpqbzlNR3FubVdo?=
 =?utf-8?B?Ulk3cnVsTFVyTkJKd3lrSHRuK3FKbjRZMXRFMlpmS1NoT0RmZVBycDFXSTda?=
 =?utf-8?B?WFE2VEJ0WTd1ZGNjL3g5bStXbWluM2gxWWFmTEpPQ2JCWjZsekkyK0kzYUt3?=
 =?utf-8?B?S0JCVE8wWkx3VDBwc0R1d3VkdXdOcUJjenc3cloySUNHTkcvcDhPOEhGSlZU?=
 =?utf-8?B?elRQeTJGQkdJTjB4OVppWmU5bmd1MVMyQTFtZ2V3MFVVd0xmVTJHNTRENXlC?=
 =?utf-8?B?aUlQNTU4N3N1TzlKRks0VjFIcXQ2TU9rbjVsRU1vTUtDNS8vSXlMVFNhRnJS?=
 =?utf-8?B?RzQ2cWtTTjJJUHNJTHdBak5JZWRLUnBTRnhHbjJna0lwak5NZlYybW14UWhS?=
 =?utf-8?B?dm9QR211c2pRb2VCRnJ1TU5xWEtHOVhPd1k3ZDJKOTVRTmZUd09YL3pPcGsx?=
 =?utf-8?B?b01lUkVFRERHWkZsS2FGaStlTlErb3VFUnNVdW1tcFBSVitGcHBxUmJJbTlD?=
 =?utf-8?B?Zmp4d1FCNFFVdFVhL0hVUEF3TU5pbURwczFJckNFeVFyckxOL3NuaUdPZG1x?=
 =?utf-8?B?VmI0RnZhd1E1dWFMWFJXSkJleENSS0UyM0N1dz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB9851.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(1580799027)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3pHVnZjL0k4cE5tbW9KcHhYTU8vNkdjNGJHQldFRnBXY0wyNWpLSWdXYlUr?=
 =?utf-8?B?N0RTaDhIUEMyYzVPNG1RZUFhSys2YldOSzRhV1YwdTlFSlg2UTJtS3NnR2U0?=
 =?utf-8?B?bVU1aENOdmgzS29ndUszU0ZXV1RFYXNqV0Q2NUMyTG53a3dXQ2NvVlI2ODBh?=
 =?utf-8?B?ditSN2FxTzZKbFJ5UzYyMWhyQ3I1UUkvdnl0dklnckt1dVlQQzZwemNNeW1D?=
 =?utf-8?B?SXFpZHkyaEJndFpOU0FTLzB3QmhWTTNtbmFHNmJjUWVkQ2NsR1lDL1YxdXV6?=
 =?utf-8?B?SWRjM2Nwdmo4YUFUbWRGRkJZQzdSbndqOWRJS3lGMXpsRC93ZUdvbWFMaEVv?=
 =?utf-8?B?aGRwc0RHK0JmZUpwWEM1eHRyTElnT2pkaWxnQkE3andtMXQzUWhFN2ZyNHhU?=
 =?utf-8?B?UnVmd1dtVy9pdzZyNmFZN3dwdVpEVmtmTFNnclA0K0Z1QTF0UHpOTVh4MFor?=
 =?utf-8?B?N0ltMUY4OXVUdCtqSEsyTlBwUVd0YnpqS1pGWklhbVYxazFvY2YrUU5zdGtQ?=
 =?utf-8?B?RWFpcFRqOXViTlgvS2VpZlZObG9tWUtZWWEwV1g5WFo1QXdUZ2JSUUpXQ1Uv?=
 =?utf-8?B?QlozY04yWjdQNlF0N1kreXhRdGhsMFdGcjBENDJQeUVLQXZqL0R4WjdIeVY3?=
 =?utf-8?B?c0h0ekJaOFdKYkpNTUVUSmxoWTdGQXdIdEF3MXRpWTVLbDE1N2I4bVI3MmEw?=
 =?utf-8?B?NFRQb1hLQjUwNnhUT1kwRjFBbitRemV4K0IxRWFjY3pLclorZGp3c1d2THBr?=
 =?utf-8?B?WHorYXh5QjBLbjBTL1NlMkNTYlpwVXliNlBWWXdMenhHN1UySG9LcGdpYVh3?=
 =?utf-8?B?bHFMRkZoMU92VVRLcGl1dEhJbGtYcmt1ZUtRSFlaYjUrNFVUS3hOcExQakNI?=
 =?utf-8?B?NlBNUFdOTHE5V1huUWlPbUFsVzRuNWJkNkYvVEZHY3Z5c05PQmtZbjNEaVN4?=
 =?utf-8?B?d01zZEUwQTdSMXNCTjd0b2Y3Z1NqS25TZHVLY0JwaTZuMnhLMzd1T3hYaXpN?=
 =?utf-8?B?cG1TMlJOZEUvZXVIQS9PbVBlR20zQ0xibUVIdDZzT3lKL1RXc2ZaY0d2cGZH?=
 =?utf-8?B?WUZhRDhGcDhpZUI0TFFoT1lPclhSQmNNa0hwV2tPbTZJT1lmVy9pYjNrVHd4?=
 =?utf-8?B?aVBkKzFQVlR0a3hCN2R6Y1d4R3lZenBmdExTN25wZHVTZXE4MVdvNU1GNCsw?=
 =?utf-8?B?bTVGMUZuTk9jUXdiUHZ5MWh4K3o0ZU1MT1RkSlYySEJ0RHBlUmVOL2dPRXpV?=
 =?utf-8?B?SFJ6S0ljVVRXVCtNcjdsZUVJWWtGSyt3dFlzZWYwQTNlOUk0VXA4d3Rwd1M5?=
 =?utf-8?B?S25HR0ZVTWlOR05QbVFkc3p5QzNFOHg0bVRyWjVhck8wU1Jrak9UaFBzR2Rs?=
 =?utf-8?B?K0FUVlo2TU1NOVgxaDdZbUlNOElPMDZqVjRRYzVJTndweHBpY1VyN0V6emtl?=
 =?utf-8?B?SkNiajNkZzZDTGhiSHFTalUySENQQmhpcmczakpyMW9wa0ZsNFQrSXFXQjFo?=
 =?utf-8?B?OVA2QmtvSHNDTldZRkJPOGQ1bjljcGVxdUZ0L0xrM3JNSVEzWDBuSzA2VjZo?=
 =?utf-8?B?eWlQMjFScUZyTjRBWVVzNXlNL0w5K0pqNy9UWDhDYVFwaWdxRGdJQ1lsdzIy?=
 =?utf-8?B?UlFiY3B3Y3Faa05EUnpUQ0gyVUJINjAyMTFyemsxc3IzQ0QrTExCZTNpNWQ2?=
 =?utf-8?B?SnFPN3dMZnBlQ1E5WExjak5uNzc2SnI5WUdHSU5mM011bS9kd3l4V0h6VkZa?=
 =?utf-8?B?b3dBTVU4MDRqcS9nS0RZdGI1aGJlSytYbXRkb3FFVXl2MFVMT3piY3RNTW5O?=
 =?utf-8?B?V1czdkR5VFZVTFFZdGl0ekhwdVZ1VVJ0dHlXaDZaWENsTGtodEdWcEF0RWdN?=
 =?utf-8?B?UUl1S3FDdFlybDRKKy9MRStTbWVLRE9mR2hJYTB2OGMyYlFSRm9wcWllbUsx?=
 =?utf-8?B?SW1JaTlFUDVtYzdYMVNyVUZCVTZUb0lDV1VXdDdTaDNja3JGUnUxTVpiUlM2?=
 =?utf-8?B?dUFGdytUMmUwWml4QXA2VUFFY0pqckRTOVBhdEZPTHcrc2Vyc2ZjWnNuUExL?=
 =?utf-8?B?Zmc0ZVk2VVRmNEdQcTR3aUxSaE5wclFvdnk3c3pha28weTJsSFAzckdxNEkx?=
 =?utf-8?B?RDMrdUF3bFF5d25TSmtnd1RCSFBRMzZ0b3dCUkVPamxEbXJrNUpEWlc2NlNB?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F67DEA5FC0A9FC4094050A1BBD2633C0@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jyCpSAIkORkEEBIPAHZtx9AYaOmKEvBc7aGQlLl3OiKAOzLuEhWJTCD1G0ucOlq3gJtn/owO6A2/ekncsUEOFTkO2AK6bsl0xSDcw/hUeMr0giJqPf1H+IRCY7vjG/gJmfPPWrpxRYQMya7yubIosMVrwa3q29iYrdqJN5mLWnwlgCakeATpdESM33+1P+kmAnYKoZXQyRbj0ZhZM/pJQrWnvLS6CeDQNiJedsHxXDHj/Gq0RNFjQOqUhk7XD7HugWx27WMfiqxqfuYCauz35vFTOT8gETaj6+0L60jSFoWCGon3q1STcdt3qlpMeIKhde0k+4FX/iek4mNEOFsLGgrb44hcGxs0X/S7pDpT7A65Zrb0XW8++c0AidyLhHnHQ1HGGvHwBj/SVLrAcJwJgyqUexNwwFwOKhU4DnA93ggxu5h2I71sPXMwLr/I00+zPXAX/WxzvvOF5pydXBYUVn4wqa85azj1HmtrDeNosWreHIDQCi3+xzULxl1fa8GHDc+g2abQTxXAknZ2/TrcpJUzBpZALZxs2EsNWptmB9bLC8CmSqNzM+SQnt4OrtRmlJsrbRWlZcPOe9kWkPWgmz9+2hkyIOYcg57rYwjVRcGD5OhrLTri0keGTeJtzx9H
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9851.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ea9713-2ab1-4f24-8d1d-08de1aab24b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 07:32:29.0191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ypLvygSR2L+/VJ94pMHLmuP52zRKkJ05retO1SUYM6Up8qi40P+gvdVYjDt7brBXMOvC6bYVJzFmv146kpf2WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11499
Received-SPF: pass client-ip=68.232.151.214;
 envelope-from=lizhijian@fujitsu.com; helo=esa4.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCk9uIDIzLzEwLzIwMjUgMDM6MjYsIFBldGVyIFh1IHdyb3RlOg0KPiBUaGUgb2xkIFJETUEn
cyBpb19jcmVhdGVfd2F0Y2goKSBpc24ndCByZWFsbHkgZG9pbmcgbXVjaCB3b3JrIGFueXdheS4g
IEZvcg0KPiBHX0lPX09VVCwgaXQgYWxyZWFkeSBkb2VzIHJldHVybiBpbW1lZGlhdGVseS4gIEZv
ciBHX0lPX0lOLCBpdCB3aWxsIHRyeSB0bw0KPiBkZXRlY3Qgc29tZSBSRE1BIGNvbnRleHQgbGVu
Z3RoIGhvd2V2ZXIgbm9ybWFsbHkgbm9ib2R5IHdpbGwgYmUgYWJsZSB0byBzZXQNCj4gaXQgYXQg
YWxsLg0KPiANCj4gU2ltcGxpZnkgdGhlIGNvZGUgc28gdGhhdCBSRE1BIGlvY2hhbm5lbHMgc2lt
cGx5IGFsd2F5cyByZWx5IG9uIHN5bmNocm9ub3VzDQo+IHJlYWRzIGFuZCB3cml0ZXMuICBJdCBp
cyBoaWdobHkgbGlrZWx5IHdoYXQgNmRkZDJkNzZjYTZmODZmIHdhcyB0YWxraW5nDQo+IGFib3V0
LCB0aGF0IHRoZSBhc3luYyBtb2RlbCBpc24ndCByZWFsbHkgd29ya2luZyB3ZWxsLg0KPiANCj4g
VG8gYmUgZXBsaWNpdCwgaW5jb21pbmcgbWlncmF0aW9uIHNob3VsZCBhbHdheXMgaGF2ZSBtYXJr
ZWQgdGhlIGlvY2hhbm5lbA0KDQpzL2VwbGljaXQvZXhwbGljaXQgPw0KDQoNCj4gdG8gYmUgbm9u
YmxvY2tpbmcuICBGb3Igbm9uLVJETUEgY2hhbm5lbHMsIHdoYXQgaGFwcGVucyB3aXRoIGN1cnJl
bnQgbWFzdGVyDQo+IGJyYW5jaCBpcyB3aGVuIHdlIGhhdmUgbm90aGluZyB0byByZWFkLCBRRU1V
IHlpZWxkcyB0aGUgY29yb3V0aW5lIGF0DQo+IHFlbXVfZmlsbF9idWZmZXIoKS4gIEZvciBSRE1B
LCB3aGF0IEkgc2VlIGlzIGl0IGFsd2F5cyBwb2xscyBvbiBpdHMgb3duIGFuZA0KPiBpdCB5aWVs
ZHMgYXQgcWVtdV9yZG1hX3dhaXRfY29tcF9jaGFubmVsKCkuIEEgc2FtcGxlIHN0YWNrOg0KPiAN
Cj4gICAgIzAgIHFlbXVfY29yb3V0aW5lX3lpZWxkDQo+ICAgICMxICAweDAwMDA1NjJlNDZlNTFm
NzcgaW4geWllbGRfdW50aWxfZmRfcmVhZGFibGUNCj4gICAgIzIgIDB4MDAwMDU2MmU0NjkyNzgy
MyBpbiBxZW11X3JkbWFfd2FpdF9jb21wX2NoYW5uZWwNCj4gICAgIzMgIDB4MDAwMDU2MmU0Njky
N2IzNSBpbiBxZW11X3JkbWFfYmxvY2tfZm9yX3dyaWQNCj4gICAgIzQgIDB4MDAwMDU2MmU0Njky
N2U2ZiBpbiBxZW11X3JkbWFfcG9zdF9zZW5kX2NvbnRyb2wNCj4gICAgIzUgIDB4MDAwMDU2MmU0
NjkyODU3ZiBpbiBxZW11X3JkbWFfZXhjaGFuZ2VfcmVjdg0KPiAgICAjNiAgMHgwMDAwNTYyZTQ2
OTJhYjVlIGluIHFpb19jaGFubmVsX3JkbWFfcmVhZHYNCj4gICAgIzcgIDB4MDAwMDU2MmU0NmMx
ZjJkNyBpbiBxaW9fY2hhbm5lbF9yZWFkdl9mdWxsDQo+ICAgICM4ICAweDAwMDA1NjJlNDZjMTNh
NmUgaW4gcWVtdV9maWxsX2J1ZmZlcg0KPiAgICAjOSAgMHgwMDAwNTYyZTQ2YzE0YmE4IGluIHFl
bXVfcGVla19ieXRlDQo+ICAgICMxMCAweDAwMDA1NjJlNDZjMTRjMDkgaW4gcWVtdV9nZXRfYnl0
ZQ0KPiAgICAjMTEgMHgwMDAwNTYyZTQ2YzE0ZTJhIGluIHFlbXVfZ2V0X2JlMzINCj4gICAgIzEy
IDB4MDAwMDU2MmU0NmMxNGU4YSBpbiBxZW11X2dldF9iZTY0DQo+ICAgICMxMyAweDAwMDA1NjJl
NDY5MTNmMDggaW4gcmFtX2xvYWRfcHJlY29weQ0KPiAgICAjMTQgMHgwMDAwNTYyZTQ2OTE0NDQ4
IGluIHJhbV9sb2FkDQo+ICAgICMxNSAweDAwMDA1NjJlNDY5MTg2ZTMgaW4gdm1zdGF0ZV9sb2Fk
DQo+ICAgICMxNiAweDAwMDA1NjJlNDY5MWNlNmQgaW4gcWVtdV9sb2Fkdm1fc2VjdGlvbl9wYXJ0
X2VuZA0KPiAgICAjMTcgMHgwMDAwNTYyZTQ2OTFkOTliIGluIHFlbXVfbG9hZHZtX3N0YXRlX21h
aW4NCj4gICAgIzE4IDB4MDAwMDU2MmU0NjkxZGI4NyBpbiBxZW11X2xvYWR2bV9zdGF0ZQ0KPiAg
ICAjMTkgMHgwMDAwNTYyZTQ2OGYyZTg3IGluIHByb2Nlc3NfaW5jb21pbmdfbWlncmF0aW9uX2Nv
DQo+IA0KPiBUaGlzIHBhdGNoIG1heSBvciBtYXkgbm90IGhlbHAgaW4gcmVhbGl0eSwgdGhlIHdo
b2xlIElPIHdhdGNoIG1heSBvciBtYXkNCj4gbm90IGJlIHdvcmtpbmcgYXQgYWxsIGZvciBSRE1B
IGlvY2hhbm5lbHMuICBJbiBhbGwgY2FzZXMsIHRoaXMgcGF0Y2ggbWFrZXMNCj4gc3VyZSBhYm92
ZSB3aWxsIGJlIHRoZSBvbmx5IHBsYWNlIHRoYXQgUkRNQSBjYW4gcG9sbCBvbiBJT3MuDQoNCm1h
a2Ugc2Vuc2UgdG8gbWUuDQoNCkFja2VkLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRz
dS5jb20+DQoNCg0KPiANCj4gVGVzdGVkLWJ5OiBaaGlqaWFuIExpIChGdWppdHN1KSA8bGl6aGlq
aWFuQGZ1aml0c3UuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhh
dC5jb20+DQo+IC0tLQ0KPiAgIG1pZ3JhdGlvbi9yZG1hLmMgfCA2OSArKystLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBp
bnNlcnRpb25zKCspLCA2NiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9taWdyYXRp
b24vcmRtYS5jIGIvbWlncmF0aW9uL3JkbWEuYw0KPiBpbmRleCAxM2RkMzkxYzE0Li4wZTVlMDJj
ZGNhIDEwMDY0NA0KPiAtLS0gYS9taWdyYXRpb24vcmRtYS5jDQo+ICsrKyBiL21pZ3JhdGlvbi9y
ZG1hLmMNCj4gQEAgLTI3NzYsNTYgKzI3NzYsMTQgQEAgc3RhdGljIGdib29sZWFuDQo+ICAgcWlv
X2NoYW5uZWxfcmRtYV9zb3VyY2VfcHJlcGFyZShHU291cmNlICpzb3VyY2UsDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBnaW50ICp0aW1lb3V0KQ0KPiAgIHsNCj4gLSAgICBR
SU9DaGFubmVsUkRNQVNvdXJjZSAqcnNvdXJjZSA9IChRSU9DaGFubmVsUkRNQVNvdXJjZSAqKXNv
dXJjZTsNCj4gLSAgICBSRE1BQ29udGV4dCAqcmRtYTsNCj4gLSAgICBHSU9Db25kaXRpb24gY29u
ZCA9IDA7DQo+ICAgICAgICp0aW1lb3V0ID0gLTE7DQo+IC0NCj4gLSAgICBSQ1VfUkVBRF9MT0NL
X0dVQVJEKCk7DQo+IC0gICAgaWYgKHJzb3VyY2UtPmNvbmRpdGlvbiA9PSBHX0lPX0lOKSB7DQo+
IC0gICAgICAgIHJkbWEgPSBxYXRvbWljX3JjdV9yZWFkKCZyc291cmNlLT5yaW9jLT5yZG1haW4p
Ow0KPiAtICAgIH0gZWxzZSB7DQo+IC0gICAgICAgIHJkbWEgPSBxYXRvbWljX3JjdV9yZWFkKCZy
c291cmNlLT5yaW9jLT5yZG1hb3V0KTsNCj4gLSAgICB9DQo+IC0NCj4gLSAgICBpZiAoIXJkbWEp
IHsNCj4gLSAgICAgICAgZXJyb3JfcmVwb3J0KCJSRE1BQ29udGV4dCBpcyBOVUxMIHdoZW4gcHJl
cGFyZSBHc291cmNlIik7DQo+IC0gICAgICAgIHJldHVybiBGQUxTRTsNCj4gLSAgICB9DQo+IC0N
Cj4gLSAgICBpZiAocmRtYS0+d3JfZGF0YVswXS5jb250cm9sX2xlbikgew0KPiAtICAgICAgICBj
b25kIHw9IEdfSU9fSU47DQo+IC0gICAgfQ0KPiAtICAgIGNvbmQgfD0gR19JT19PVVQ7DQo+IC0N
Cj4gLSAgICByZXR1cm4gY29uZCAmIHJzb3VyY2UtPmNvbmRpdGlvbjsNCj4gKyAgICByZXR1cm4g
VFJVRTsNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIGdib29sZWFuDQo+ICAgcWlvX2NoYW5uZWxf
cmRtYV9zb3VyY2VfY2hlY2soR1NvdXJjZSAqc291cmNlKQ0KPiAgIHsNCj4gLSAgICBRSU9DaGFu
bmVsUkRNQVNvdXJjZSAqcnNvdXJjZSA9IChRSU9DaGFubmVsUkRNQVNvdXJjZSAqKXNvdXJjZTsN
Cj4gLSAgICBSRE1BQ29udGV4dCAqcmRtYTsNCj4gLSAgICBHSU9Db25kaXRpb24gY29uZCA9IDA7
DQo+IC0NCj4gLSAgICBSQ1VfUkVBRF9MT0NLX0dVQVJEKCk7DQo+IC0gICAgaWYgKHJzb3VyY2Ut
PmNvbmRpdGlvbiA9PSBHX0lPX0lOKSB7DQo+IC0gICAgICAgIHJkbWEgPSBxYXRvbWljX3JjdV9y
ZWFkKCZyc291cmNlLT5yaW9jLT5yZG1haW4pOw0KPiAtICAgIH0gZWxzZSB7DQo+IC0gICAgICAg
IHJkbWEgPSBxYXRvbWljX3JjdV9yZWFkKCZyc291cmNlLT5yaW9jLT5yZG1hb3V0KTsNCj4gLSAg
ICB9DQo+IC0NCj4gLSAgICBpZiAoIXJkbWEpIHsNCj4gLSAgICAgICAgZXJyb3JfcmVwb3J0KCJS
RE1BQ29udGV4dCBpcyBOVUxMIHdoZW4gY2hlY2sgR3NvdXJjZSIpOw0KPiAtICAgICAgICByZXR1
cm4gRkFMU0U7DQo+IC0gICAgfQ0KPiAtDQo+IC0gICAgaWYgKHJkbWEtPndyX2RhdGFbMF0uY29u
dHJvbF9sZW4pIHsNCj4gLSAgICAgICAgY29uZCB8PSBHX0lPX0lOOw0KPiAtICAgIH0NCj4gLSAg
ICBjb25kIHw9IEdfSU9fT1VUOw0KPiAtDQo+IC0gICAgcmV0dXJuIGNvbmQgJiByc291cmNlLT5j
b25kaXRpb247DQo+ICsgICAgcmV0dXJuIFRSVUU7DQo+ICAgfQ0KPiAgIA0KPiAgIHN0YXRpYyBn
Ym9vbGVhbg0KPiBAQCAtMjgzNSwyOSArMjc5Myw4IEBAIHFpb19jaGFubmVsX3JkbWFfc291cmNl
X2Rpc3BhdGNoKEdTb3VyY2UgKnNvdXJjZSwNCj4gICB7DQo+ICAgICAgIFFJT0NoYW5uZWxGdW5j
IGZ1bmMgPSAoUUlPQ2hhbm5lbEZ1bmMpY2FsbGJhY2s7DQo+ICAgICAgIFFJT0NoYW5uZWxSRE1B
U291cmNlICpyc291cmNlID0gKFFJT0NoYW5uZWxSRE1BU291cmNlICopc291cmNlOw0KPiAtICAg
IFJETUFDb250ZXh0ICpyZG1hOw0KPiAtICAgIEdJT0NvbmRpdGlvbiBjb25kID0gMDsNCj4gLQ0K
PiAtICAgIFJDVV9SRUFEX0xPQ0tfR1VBUkQoKTsNCj4gLSAgICBpZiAocnNvdXJjZS0+Y29uZGl0
aW9uID09IEdfSU9fSU4pIHsNCj4gLSAgICAgICAgcmRtYSA9IHFhdG9taWNfcmN1X3JlYWQoJnJz
b3VyY2UtPnJpb2MtPnJkbWFpbik7DQo+IC0gICAgfSBlbHNlIHsNCj4gLSAgICAgICAgcmRtYSA9
IHFhdG9taWNfcmN1X3JlYWQoJnJzb3VyY2UtPnJpb2MtPnJkbWFvdXQpOw0KPiAtICAgIH0NCj4g
LQ0KPiAtICAgIGlmICghcmRtYSkgew0KPiAtICAgICAgICBlcnJvcl9yZXBvcnQoIlJETUFDb250
ZXh0IGlzIE5VTEwgd2hlbiBkaXNwYXRjaCBHc291cmNlIik7DQo+IC0gICAgICAgIHJldHVybiBG
QUxTRTsNCj4gLSAgICB9DQo+IC0NCj4gLSAgICBpZiAocmRtYS0+d3JfZGF0YVswXS5jb250cm9s
X2xlbikgew0KPiAtICAgICAgICBjb25kIHw9IEdfSU9fSU47DQo+IC0gICAgfQ0KPiAtICAgIGNv
bmQgfD0gR19JT19PVVQ7DQo+ICAgDQo+IC0gICAgcmV0dXJuICgqZnVuYykoUUlPX0NIQU5ORUwo
cnNvdXJjZS0+cmlvYyksDQo+IC0gICAgICAgICAgICAgICAgICAgKGNvbmQgJiByc291cmNlLT5j
b25kaXRpb24pLA0KPiAtICAgICAgICAgICAgICAgICAgIHVzZXJfZGF0YSk7DQo+ICsgICAgcmV0
dXJuICgqZnVuYykoUUlPX0NIQU5ORUwocnNvdXJjZS0+cmlvYyksIHJzb3VyY2UtPmNvbmRpdGlv
biwgdXNlcl9kYXRhKTsNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIHZvaWQNCg==

