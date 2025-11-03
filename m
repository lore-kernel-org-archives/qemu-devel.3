Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB1FCCFA06
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 07:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFoxX-0005Un-2s; Mon, 03 Nov 2025 02:26:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1vFoxU-0005Ue-KU
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 02:26:33 -0500
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1vFoxP-0003cX-J6
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 02:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
 t=1762154787; x=1793690787;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=duTyrcxiqX/Vde3Kw6dqijUabtSmqlLIb0yGVBJVUYA=;
 b=lV2i/fI+9nQNtlsf1z/YcghxcGvP6IS3YJKYeiqQqiJcf7pcxGdDn4WE
 YmFrhA6Dlx9/pe+C0iiXmnYWphbfzJX8zYS3J3lO8Sv6kgxOUL7sVZjUG
 UT7mcKF5RM6Myuc+3QYvmFGwS/AvkLoqrh7MPYGPLJOi5u8pamSbwf8FY
 B6YPO5524x/0C/yw4bstT+LKk5iIOhvm3S4TS+R9Ih7b0X1mcHvoCes/l
 9uhqQl1YBC54lK9fd+ymSj7NQWPYyy5erFcOM3ZAcvW+waORJRQhwr291
 zW4VC/lF7JbbF+DS51mI43f14t1rTT78h4D/B1Ruzw1V1n8YxE3AzRAL3 A==;
X-CSE-ConnectionGUID: oPPncjk6RhayGBhkCoNr6A==
X-CSE-MsgGUID: 0KI1XpwPQfawS7aXjSHlhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11601"; a="172698018"
X-IronPort-AV: E=Sophos;i="6.19,275,1754924400"; d="scan'208";a="172698018"
Received: from mail-japaneastazon11010046.outbound.protection.outlook.com
 (HELO TY3P286CU002.outbound.protection.outlook.com) ([52.101.229.46])
 by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2025 16:26:13 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUSIG6QCFGomWFngCawEMNG/MSM3sVgUP9846beUWd2R/YucQJmTUBuW254ou2AngfZ03y5PRiohwt71JxkZMjKtloIJtzfWRK7XjDAVq+I8AZt2doUx1DAcmYXkmOCIMT64hNs+DPt0nZbi2DSKp9dOOwkiYV/Jbffq187hk1GkVMyi2dZSl/Y/v6ifpXdkW9WRUvtu/SIX1fRupniTzRSY6UPqEfVbJZ2nE9oOle/CWAYQiqG7bAl5qHH0nEafruaVaho6bKVti0h1m4LlDSEI+ZE6Wg75DXrrqZVX0E30TvG7p2qW6EyiEzou9vh5SXl/t3HC0XS4Xj7AcGgasw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duTyrcxiqX/Vde3Kw6dqijUabtSmqlLIb0yGVBJVUYA=;
 b=stkxjHGWTsawojFnYBoGn/en/ZBcSgViax+EQ+cJrt3YoaXKpDOcp2EOcgJ77JaUIdqmUCIoLAIWcyMRrXSxnLtbZCxp20l1IbXqTEeuEiw05/6+CL+dS/ZP0F4odVvqsTjD2U3IPYcSXFulU51bkaEwKD6OiNFJlwry+SKG2GbDG8Q1/FrVSJIL/3BnrLxbgJGewXsBVtaBlrRyb8x8TyQ13Zqmpl/R2JGbMbVvFw69tL6CLAW5Fg0wvHcxdJ2m8o/O2URGsV3smo1Vr/nzA6L4KzhCaEvTT2svVXBbZmWMgPT8NjWQY/1xXkc0Pcv+axTi1qi992fF7E2uGJW9fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duTyrcxiqX/Vde3Kw6dqijUabtSmqlLIb0yGVBJVUYA=;
 b=NcyWcwBrOLZyinDkfajb9v+fGtIDYtu2vkTdE+kZiX4GOgsXUyaG+g49FIkWaFp1Gy+lh/DWwZdvUsAsKrWprzIcIZ0M1x6QIwO3rwa2v0MmDU0J317xmC4CzwP8QlGnOVWSoHiyc0W0LbMGCgREeBISkom6z+Ir3cM+Mss6LjjVcmaxHLUhoIf4cuePhAyPB/JDCkcCSavotvgNQ6eGzcLlATsM+FDuw91zwVxHpKPJccIKZ3hAQR1M8s70TQNmDO62W2mD3kSUqhhEJzvk83F5dN5dsPTWI2TKC/5A4D7+RH689GZPpInMdItbpN/QUOzqIevl/WFcr2L3k0aenQ==
Received: from OS3PR01MB9851.jpnprd01.prod.outlook.com (2603:1096:604:1ee::6)
 by TY3PR01MB11499.jpnprd01.prod.outlook.com (2603:1096:400:377::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Mon, 3 Nov
 2025 07:26:09 +0000
Received: from OS3PR01MB9851.jpnprd01.prod.outlook.com
 ([fe80::3724:ab64:b652:a6b3]) by OS3PR01MB9851.jpnprd01.prod.outlook.com
 ([fe80::3724:ab64:b652:a6b3%5]) with mapi id 15.20.9298.006; Mon, 3 Nov 2025
 07:26:09 +0000
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
Subject: Re: [PATCH 04/13] migration/rdma: Allow qemu_rdma_wait_comp_channel
 work with thread
Thread-Topic: [PATCH 04/13] migration/rdma: Allow qemu_rdma_wait_comp_channel
 work with thread
Thread-Index: AQHcQ4nHdLNmVnjV80ySeHBL+xmGQ7TgnyoA
Date: Mon, 3 Nov 2025 07:26:09 +0000
Message-ID: <6dab3848-c0dd-4daa-ba9e-4541dbc86b2b@fujitsu.com>
References: <20251022192612.2737648-1-peterx@redhat.com>
 <20251022192612.2737648-5-peterx@redhat.com>
In-Reply-To: <20251022192612.2737648-5-peterx@redhat.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9851:EE_|TY3PR01MB11499:EE_
x-ms-office365-filtering-correlation-id: cabb91a5-642b-452a-4e36-08de1aaa4259
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|1580799027|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?NzY1SFhoNlFLVEx6RXVWZ1gzMSs4UFlDdS9NaUloaURWcVN4Rks5VUphaHg0?=
 =?utf-8?B?Q3luT2FDdmx5Mks3ZmVHZXJoWjhjWkR6MEJKZGQ0MmJockswY1NTdGVTUEJW?=
 =?utf-8?B?NVluc21pTkRRVGplK2Qzc1pCbkJLK2xwSjhja0tDYndaMjJYSzIyNC9xSjVn?=
 =?utf-8?B?NFNnTk8zK3l4dEJqSlkxYVVNRllUZExCc3RwS2wyRE4zVHNQMit6RjU0Vldx?=
 =?utf-8?B?OHZLejgyM0lCL3cwZlE3TWcwTldDYmZ4STFCWnZQeVlocEF4RGdTMjdzSTU1?=
 =?utf-8?B?SlFNa0FpWjRXbnJCUnVNc280WE1ZSCtIeGZuaFZvYU4vdVB6cHo5M2dETUYx?=
 =?utf-8?B?TDBwUWJVczF5Yy8wL0NmTjNSQkExcUdWV1BWdFVxZXBKT2puTmkyelQvS2Q5?=
 =?utf-8?B?aWlRR3c0RzdjcjE5eGNkYkVIRHM0eVptOEYyUGFIVmFtV0liWUQ0S2ZOK2VQ?=
 =?utf-8?B?NUk5Lzdzb2xuNGV5MDFYL3laTlJoeTlQcCtKVnl2c1BtTVJHZU12TWVQbkUv?=
 =?utf-8?B?UnZOaEdJVHlHZm0xd3YxRTNwelpiWHJ4eXdlQUFjRWoyajNtcm8rYVJsd1Bk?=
 =?utf-8?B?dWJQcGQxVW9VMUNYcU8zMlB4cURpTG02WXBIaTdhTVJ6WVMrTGYxVG04c25N?=
 =?utf-8?B?eDZDNmJPdktNbnppcXhpeFVuSDdRUHMxM05kWGVUM0hkZS83WlFyTCt6NEVt?=
 =?utf-8?B?VnlBYkdUUUI1NGh5S1MwNm9ubk4vcDJHeGRLTzFqK2NYNW5QRE10UkpMbVJR?=
 =?utf-8?B?U01xMkhYYm95ejNPcjZBRGR0MnBxQkFWQ3NLUnIzSUx6ckRjZEJRKzdMZkVQ?=
 =?utf-8?B?c0VleWZZRVE2UVFFMTRZVXhFZFFJbmw0WXdtd1pSUlo3WHFvT21jZFFsQnlm?=
 =?utf-8?B?bzJrdDV1TzRnMHlOa3FnTDF0N0NKVUx6UW9xeUZ2dHc0U0VkektiNnFESFRz?=
 =?utf-8?B?Um56anB3L0E2MHhvbm42Kzl6TWd2cmkrRnA5am43OHh1Z1hTbmFTa2t2NzhB?=
 =?utf-8?B?QldOL2MvTFZsMEZ0RXBoMmFkTCsramdYRVppMnR0cTQ4RnpncWhwc3R2RExH?=
 =?utf-8?B?RXVQUk40Qmd2QUdpcU02cWpEWEZBYnlXck5tSndUTWNqTnlZdEI2REJNN3hL?=
 =?utf-8?B?NHFrNmFPWDMrNVZ2ZXlockFXSERDOTltV0lCYWgvWkVYbHJjYTZCZXc4TjQw?=
 =?utf-8?B?SGt2WkNTTEd5VjBQMncxUXJ2ZjkzZGlJRHM1QU0rYmkzeE5RNzkydnA0c0t4?=
 =?utf-8?B?RXAvaER1ZVdpT21lRitlaHI5Q1oweHlpb2JFU3QvRmtpVUJFTS9tdjBZYmp5?=
 =?utf-8?B?ZFRoNFZjaGNRZWp2eXBPcjV0NVpXQVd5c3ZBeUxncmZNbXR6NjJQWEo3TEFF?=
 =?utf-8?B?QnkxQUJHaTVSeWhVNHY2d3VHcjdTbHExQXgxbXF1dFZ1V3F5TzNBNi82VTVR?=
 =?utf-8?B?c0pxVmJQN3hTVUJGOEZ4UndtbERKVlpCMFhKSFpHc25ob2tLTWY2L0pEeHpO?=
 =?utf-8?B?MThwRURadnVzMElSaThFWEk3MWVuUmMzWFdDU2h1bUJISy9ITDZRNyt5VnEr?=
 =?utf-8?B?VXFzOG1tWEFrK0tJZ0ZwSytpS1pNeHhrUkNjVHF3bit6Qk85OGwvU09qYnhi?=
 =?utf-8?B?MFlnRUh5ME5HQ3dwTit1bkxKL0xNekZadXZIWksvLys3MkhkUWJsYVZsc3Va?=
 =?utf-8?B?NWd5SzZzbDVnZzRWenhXellCVFUrZGtINzl6OTFFcXFBMTdXb1hXVGRoNnMv?=
 =?utf-8?B?VU00QldPQ2tWejVabERvOE53RzdyRzFuUTg3cVh6Q3piVnppOE1UcEMxTTVS?=
 =?utf-8?B?dHRrbVAzWXZMR2c0VGJFeEdYZWRJNUIzcVRLM2FsamlXTkxZS0c0SlNCRXJI?=
 =?utf-8?B?TDRVUW8xQlJRWDRuK2kwaE9xYUVOUERiSWFhSnA4OVNrZEZFazhZVlpwNXlz?=
 =?utf-8?B?Y1Jtc21hTWpSaE1JM2RqNW9BR0RheUIzY1U5RDhiV21ub3RJaldCTytZcUdZ?=
 =?utf-8?B?SGNPaGJTcW80aEpiRDJ3Sm40M3RSWVRkOU40YTUvVTV2ekVubzZNTTZXQnlM?=
 =?utf-8?B?YnArWUpvanBreC9QeTBkNFBDT0JRVGpnNnRPdz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:OS3PR01MB9851.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(1580799027)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlAvdzdtZVc3Z3VuTTY4N21HZHRrVzFQTGpib0ppM21JZTREaWlMS2tMVDNS?=
 =?utf-8?B?WVgxdXZUQ3NCb0ZyWkFvd3FOeDVMNGhNNThNZDI0UVp4aHhPVENBaStPNVBq?=
 =?utf-8?B?NUNEZStkaUxTbXBLb1dPL1RTQmI0VFN4NXVZT2hqdi9ESGZjaTN6dlhYUmRw?=
 =?utf-8?B?MFFzcE43MFFHQS9Jck5wZTZ6RXVCVGR1NDFsaGtHdjFIYlV4dGRua1RhSjZD?=
 =?utf-8?B?cEIxMHNkeFB2T3lXaWd0QVZmUENUaEZ6RUNDRzNXVGNHaGZoSXhDQ1IrejAz?=
 =?utf-8?B?dk1yOHZTN2pCQU1sUlNDQXNVM3ZxNUE4QzdNaFBzc0Vzb2dCOFRLNTZUaXVp?=
 =?utf-8?B?RHhTSURZZ2JmSVZBVDNRV2cxemJHR3YwU3pOY0h4THRIU3hScWoyOElwY2My?=
 =?utf-8?B?UmtVTUxKNExyZjV2TGxlYnFXVmVPNGtzK09yZHVqYU9yYmxWMlgvc1ZwUVQ0?=
 =?utf-8?B?cmw3c01xZVBIeDNFU2d3NTlLUStLR2RpMUU1NTR0aUlsa0pxQ2RRWnVEblFa?=
 =?utf-8?B?RFJGcUVuT0lmWGFTaElMQ0w3TVZWSlFXUVJSaUY4SU82VGRkWG5KOExIMW9P?=
 =?utf-8?B?Uks0dTJyTjk5QnQvblJXUUhRbDNEand4cVdaMzZkZUhDbTZJM1daUG1lOWNQ?=
 =?utf-8?B?M0ZBanNtamsxTkNjRGk0SklsYVJsQzJGZW9FbjUzb3lsVTZTaVhSSW1xVlV1?=
 =?utf-8?B?MEJUWThCaG9KWE92NzR3MFdTZjg5QUIzamtjeEdzUmRoblhDeGRFdjk0WmVU?=
 =?utf-8?B?M3dReHRtVXh2a0w3YlcwYW9SUFpseDFGMHlyY25DYmwyT1dEdTNZcEZWTkQz?=
 =?utf-8?B?WG8xSVpHdm4zOGJmRDg2YWJhc2RlUjRmanRZRXpnaUZKY3l3Z2FGM3hUQjJ0?=
 =?utf-8?B?UjJCTjZGS3NBYjNmMURxNndSdW5MQ09LMGRYNVh6SnBFZ2FJU3F3TU9RMERt?=
 =?utf-8?B?Zkl6YXVhM09md3Q2R2l2RmxWV0QvMk0zK2JNQ2VPaHdlQm5oL2RJeTdCU3dZ?=
 =?utf-8?B?eUFxTzE0cERsRU1SZTQ1WFFFcWdmQ1BYeVBiaFNRYlJtbG1ubGNreG1ZMjVK?=
 =?utf-8?B?UXR0OEpyL1F3djFVSEFFd1IweCtLWCtYKzdTUG1kaTdINHJidDRybHV6RkMz?=
 =?utf-8?B?aWdHRFdQNXFOT3pXNkRkaVU5a2lqU21tVjVmb1hIODFoa0ZqNzcvemZyUXRN?=
 =?utf-8?B?UERMa0pESVE2NTBsWGt1K0tFc2R3bjN1QlpFZFRKZmt2MjZiQU94amxuRHZh?=
 =?utf-8?B?VHNPMCtFK0NnQTdtTytORllTOVdreDJod1lJT1pucW5ZZ3NhVTVLNjlRRnZr?=
 =?utf-8?B?SzA2Q0N4STFQM2dsTzNlRmFxc1pha0c0Nkw4bkdTUElzbDVrQWxieGRnZ21j?=
 =?utf-8?B?WWtFYWorZmVSMjJjZXNleE50TmU4Ulczc0dnRFc0YzkxV1BTOXJ5Tmp4aDd4?=
 =?utf-8?B?dVpRUjRWdmJIbmdrWWo4OC9iVkJhN3dsSlRHa1ZlYjJPTThBOEZ2RjA2eDhH?=
 =?utf-8?B?K0swblE3VlRmZkhOV01aVnN4SFB2Q2p3b0tKRVo3OGZ0dDJDU0xwY3hpSGt4?=
 =?utf-8?B?bUVmbFF0NWxPUGF2QUlDQzcxT0RjbkZIK00wdCthWlRJMDFqb0hvelYyK3ZY?=
 =?utf-8?B?QUppU2VqcHlsNit1Y25hY3hwMjVyczFGTFVXNUkwSEE5VmdCc212ZnIrRG0v?=
 =?utf-8?B?MC8wbnkyaEd2eWVNT0lycnVzZHlQc1Nxd0M2WE5ud0xwcjcvbTRyWHE3UmlB?=
 =?utf-8?B?SHo5bThMOG0zcTEzNDVnaFdGWDk0NUphbFpZc0RMNUluSDJ2Ti9GaVA4TWYy?=
 =?utf-8?B?T2VjbXZDWTVSL0V2UzAzMVhiRDJSdW4xdDFxb2VDbWthSlhGeHNhdGlJbWVv?=
 =?utf-8?B?Sng3WmpUangzQS9KKzh4djJtREUwZ3RJaG1oR2ZIZ2VacHpsWi9mc09GcldK?=
 =?utf-8?B?VGUwZVhOQ1NuZzJQT3FPcEM1VDE1Rm9UeUJibk43ZUVGVitRVVVvZTZUdzVr?=
 =?utf-8?B?UXZ4ajlXQlh3eG1pUldLbzlGTWFGMldNV28rakhzVEg3bWwvTmRrRDhlbG1u?=
 =?utf-8?B?VWdveHFoU1JKYS9SOGtlU3pQTzUrSWV4ZFR6UGtybkhzdGwydmpuVWtPWTNX?=
 =?utf-8?B?NmgydUhvS0E2VnBsL1JqK0hmRVdDekZKcXorV2NwSWtKdkRUYmxGQmlxRVRX?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACB9D7C47A851742BB4A97D122CD0C8E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Dzw1vU8P5fqxqIYSEv5WU3zueNlgVccDve1C0VAqOPnXLuFL7w439ullMbPQ7XUWiQc92QAV80e37nAYrtIeKG8tH92feHU5CV6zpV/yIiRVqkO/kv0qi9m2a4MxTT6VKcLBI2Z15+ZjNeX4fIz7eVvzBju688zLqUJRv9BCEdeSb3EUnXqsEkAyWjh2WejBW04jNlOUFmqMz1seybAf1iNS8ibPniVSLVoeJoBWXgiNtxFyDlmgiquMsm6ek2rUr9jDRGypWDkolknCwAc0mjPAR/eK8nWRD7kdt9f6AJAUlAQk+y8+TvKJnAmZ0fcYoLHcgywHDNza9cpcWTrc0DOmM6bmaD8jndCG0yld85ZDpW7WNR0UYqt0yHUVYF14uUN9X0T4f8Qb0UZ0vHtcy6pkyJrCGvC+wtSWxS+pUSHQoUL0NeGjcoAf+LDkPhbPXuGYXs1xoIVSrJbWWRbl38hh/RY+VLs0TEOnzx0UiB6/jo3ivdnvD3bo2dZxk2Kariocgh2XT+gLjJtsuOhvrtRbkxJAjbwsT+iJMtu4JLOVp1lKuCsaSPMqjgp1BZi2M1TnfYKCQ9z0CzGz6f2OdfulTDxab8ub+1zMgpcVkRI/yL4XAAVxWcKK9oKJ7nCU
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9851.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cabb91a5-642b-452a-4e36-08de1aaa4259
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 07:26:09.2641 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /4xmEDNSmsP3rtyfsP8MKfO3KCEJRfmykbfqsGMFLx9zIf0hgqfL7Xx+HPRvvCVQC2Up6ZQSTPAj3wMjKxBvQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11499
Received-SPF: pass client-ip=68.232.159.88; envelope-from=lizhijian@fujitsu.com;
 helo=esa8.fujitsucc.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

DQoNCk9uIDIzLzEwLzIwMjUgMDM6MjYsIFBldGVyIFh1IHdyb3RlOg0KPiBJdCdzIGFsbW9zdCB0
aGVyZSwgZXhjZXB0IHRoYXQgY3VycmVudGx5IGl0IHJlbGllcyBvbiBhIGdsb2JhbCBmbGFnIHNo
b3dpbmcNCj4gdGhhdCBpdCdzIGluIGluY29taW5nIG1pZ3JhdGlvbi4NCj4gDQo+IENoYW5nZSBp
dCB0byBkZXRlY3QgY29yb3V0aW5lIGluc3RlYWQuDQo+IA0KPiBUaGVuIHdlIGFjaGlldmVkIHR3
byB0aGluZ3MgaW4gb25lIHNob3Q6DQo+IA0KPiAgICAtIERyb3AgbWlncmF0aW9uX3N0YXJ0ZWRf
b25fZGVzdGluYXRpb24sIHdoaWNoIGlzIG5vdCBuZWVkZWQgYW55bW9yZSwgYW5kDQo+ICAgIC0g
SXQgc3RhcnRzIHRvIHdvcmsgaW4gYSB0aHJlYWQgd2hlbiBsb2Fkdm0gdXNpbmcgUkRNQQ0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogUGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPg0KDQoNClJldmll
d2VkLWJ5OiBMaSBaaGlqaWFuIDxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQoNCg0KDQo+IC0tLQ0K
PiAgIG1pZ3JhdGlvbi9yZG1hLmMgfCAxNSArLS0tLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDE0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L21pZ3JhdGlvbi9yZG1hLmMgYi9taWdyYXRpb24vcmRtYS5jDQo+IGluZGV4IGU2ODM3MTg0Yzgu
LjEzZGQzOTFjMTQgMTAwNjQ0DQo+IC0tLSBhL21pZ3JhdGlvbi9yZG1hLmMNCj4gKysrIGIvbWln
cmF0aW9uL3JkbWEuYw0KPiBAQCAtMzU3LDEzICszNTcsNiBAQCB0eXBlZGVmIHN0cnVjdCBSRE1B
Q29udGV4dCB7DQo+ICAgICAgIC8qIEluZGV4IG9mIHRoZSBuZXh0IFJBTUJsb2NrIHJlY2VpdmVk
IGR1cmluZyBibG9jayByZWdpc3RyYXRpb24gKi8NCj4gICAgICAgdW5zaWduZWQgaW50ICAgIG5l
eHRfc3JjX2luZGV4Ow0KPiAgIA0KPiAtICAgIC8qDQo+IC0gICAgICogTWlncmF0aW9uIG9uICpk
ZXN0aW5hdGlvbiogc3RhcnRlZC4NCj4gLSAgICAgKiBUaGVuIHVzZSBjb3JvdXRpbmUgeWllbGQg
ZnVuY3Rpb24uDQo+IC0gICAgICogU291cmNlIHJ1bnMgaW4gYSB0aHJlYWQsIHNvIHdlIGRvbid0
IGNhcmUuDQo+IC0gICAgICovDQo+IC0gICAgaW50IG1pZ3JhdGlvbl9zdGFydGVkX29uX2Rlc3Rp
bmF0aW9uOw0KPiAtDQo+ICAgICAgIGludCB0b3RhbF9yZWdpc3RyYXRpb25zOw0KPiAgICAgICBp
bnQgdG90YWxfd3JpdGVzOw0KPiAgIA0KPiBAQCAtMTM1MiwxMiArMTM0NSw3IEBAIHN0YXRpYyBp
bnQgcWVtdV9yZG1hX3dhaXRfY29tcF9jaGFubmVsKFJETUFDb250ZXh0ICpyZG1hLA0KPiAgIHsN
Cj4gICAgICAgc3RydWN0IHJkbWFfY21fZXZlbnQgKmNtX2V2ZW50Ow0KPiAgIA0KPiAtICAgIC8q
DQo+IC0gICAgICogQ29yb3V0aW5lIGRvZXNuJ3Qgc3RhcnQgdW50aWwgbWlncmF0aW9uX2ZkX3By
b2Nlc3NfaW5jb21pbmcoKQ0KPiAtICAgICAqIHNvIGRvbid0IHlpZWxkIHVubGVzcyB3ZSBrbm93
IHdlJ3JlIHJ1bm5pbmcgaW5zaWRlIG9mIGEgY29yb3V0aW5lLg0KPiAtICAgICAqLw0KPiAtICAg
IGlmIChyZG1hLT5taWdyYXRpb25fc3RhcnRlZF9vbl9kZXN0aW5hdGlvbiAmJg0KPiAtICAgICAg
ICBtaWdyYXRpb25faW5jb21pbmdfZ2V0X2N1cnJlbnQoKS0+c3RhdGUgPT0gTUlHUkFUSU9OX1NU
QVRVU19BQ1RJVkUpIHsNCj4gKyAgICBpZiAocWVtdV9pbl9jb3JvdXRpbmUoKSkgew0KPiAgICAg
ICAgICAgeWllbGRfdW50aWxfZmRfcmVhZGFibGUoY29tcF9jaGFubmVsLT5mZCk7DQo+ICAgICAg
IH0gZWxzZSB7DQo+ICAgICAgICAgICAvKiBUaGlzIGlzIHRoZSBzb3VyY2Ugc2lkZSwgd2UncmUg
aW4gYSBzZXBhcmF0ZSB0aHJlYWQNCj4gQEAgLTM4ODQsNyArMzg3Miw2IEBAIHN0YXRpYyB2b2lk
IHJkbWFfYWNjZXB0X2luY29taW5nX21pZ3JhdGlvbih2b2lkICpvcGFxdWUpDQo+ICAgICAgICAg
ICByZXR1cm47DQo+ICAgICAgIH0NCj4gICANCj4gLSAgICByZG1hLT5taWdyYXRpb25fc3RhcnRl
ZF9vbl9kZXN0aW5hdGlvbiA9IDE7DQo+ICAgICAgIG1pZ3JhdGlvbl9mZF9wcm9jZXNzX2luY29t
aW5nKGYpOw0KPiAgIH0NCj4gICANCg==

