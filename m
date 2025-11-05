Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6858CCCFA0D
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 18:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGiQN-00028T-Bl; Wed, 05 Nov 2025 13:40:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vGiQK-00027b-VV
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 13:40:01 -0500
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vGiQI-0008La-W6
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 13:40:00 -0500
Received: from pps.filterd (m0127839.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A5HrDbu4128591; Wed, 5 Nov 2025 10:39:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=0k3aDvhuQhNrxajQgyK1AdzrgO+sSZbklYIctQQql
 NY=; b=NJPippIoKwbgXzjewmi9XU6RTYzcpWGaz0d1Ez6KZYTUQ6HFvBECTF1fQ
 Eyn7R/SdsCsLreafAugj0Pb3M032oesnyh4ssZGjNKDym7eHpbmNT1GDVPqYF73n
 NkAMqQHoH3pyv88Z6KcHpbWwWbWZEKNFcrcFpp4/1XeZ8Lw1V+jvhwI7erN0IHhV
 x5femoY2g7OI3KluN+jaO95mi3tCp5y2vPSkAhvZ/1Z0PTT8VQqqfraqJxyqc64M
 Eb9E8gJ647qbmMhZLUurOPTeN9w3BqoVYdEVGkIAyAqdoMyyMBjXCpypOvRp2/xM
 UBRmUcZswi3V4BboEQZJqDATg0+9A==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11020102.outbound.protection.outlook.com [52.101.46.102])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4a8bchr3he-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 05 Nov 2025 10:39:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPfNvm1LJzD3JvKVl+UV4XRzc+/2pAU0v4GMz4St7ypduZdEahC1zEAiXqAf5Umg0lyPNAk3QsfwX6bQLaE9+mGDWkh72fS7/MN+jjIbhlvkXeM67c0bg0Hw3T3R39tRr9jOrtBeWqi99sPRJCDuI9DWYKnAfdeDuvMzg5y18v/Nkbec20kx6U7QhmEIJd4fGVd5f5wnSCbQeP1Z8D7zHMtMNy3Oth4QojiBufJsxWTD0LlstSqmXZNpBG+TyPbD1yyAvUQhuaV41jc05rpRlsqN0+8MhH2+sQm5YBBh3D+RO31Ci7Va+vXORqYV8esFDlNadhUwbCrW5fV3KHzotg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0k3aDvhuQhNrxajQgyK1AdzrgO+sSZbklYIctQQqlNY=;
 b=n1sDjWoav/lT6k6DavCJP4a8/1iyuWtYM+AyDFEWZAg/0NLTXFpR5O4o4yFdgxAG3WMRljdRecLF1sBqzFwTxRKs7qqTDk9PlFTNRdeHA1BxiLPmfTenj1eid8zRip8ce1fsBaWBvbjENMWPvd3K4K6HkuxjByLrPg9iSnIBZqS68D3tGQ3+FqmExdsNOY5r6B7OUNr04cr0aKdGYDMAQo8RUt9we0/43aCXCPPBJazRHQTZmvhk/8QeU567c+YZKhbl+F5VwZQUrjhKFIlGAnO3do99BDKTH7HjoNOvHyty7m/ryZw4eDvcKiHntLwNyHatrND/MqvqX4Q4Byg/6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0k3aDvhuQhNrxajQgyK1AdzrgO+sSZbklYIctQQqlNY=;
 b=HunLZYPX81SxCkbUyXktQFtNHGI69lSYsVuVFbe5bfASeiBL/xy5lEVpE8NAQP+2mgAlAKzyJjEt6nl4RUJ6ier2gvMwqUJa0qpYoBVp4mGAPdS6+rRy5mKN3IAWLpKE6kOEWDuyOIY4e2jcWXUN2lcJVTV2RlgqhmkWe6xvCI6tmi5074Ryv+y6tTm3IW3Aln2nqkdAV+/SnSgflohqbn/SczSi2Grc7XW6m40bWy7ldi2HeE58GthQGRsCRcII+O5QTAkbDbSlXD34/e41s6K9jfw+1o9BZQqLzzY70w7lEY9khCwX52fgC6TyvX6bxw/6Pm9IMHh7x9X8ZvknTw==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by IA0PR02MB9630.namprd02.prod.outlook.com
 (2603:10b6:208:40b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 18:39:53 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 18:39:53 +0000
From: Jon Kohler <jon@nutanix.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "ankur.a.arora@oracle.com"
 <ankur.a.arora@oracle.com>
Subject: Re: [PATCH] util/oslib-posix: increase memprealloc thread count to 32
Thread-Topic: [PATCH] util/oslib-posix: increase memprealloc thread count to 32
Thread-Index: AQHcTO4G/V+qXBvm4Uy+K4zBTpaW/LThc90AgAGGrYCAANJkAIAAoE8A
Date: Wed, 5 Nov 2025 18:39:53 +0000
Message-ID: <9EB24253-2E39-460F-BF64-AE44E62B65E8@nutanix.com>
References: <20251103185750.1394036-1-jon@nutanix.com>
 <aQka0DTrVsJrfU5z@redhat.com>
 <545E78A6-6013-45E1-9C3B-7D027FF12E00@nutanix.com>
 <aQsTdMyp6aPmhjDY@redhat.com>
In-Reply-To: <aQsTdMyp6aPmhjDY@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|IA0PR02MB9630:EE_
x-ms-office365-filtering-correlation-id: 44243b7b-def9-4302-95ff-08de1c9ab5e1
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?V2xFcElHbWVqelVHeG1rNnluaWx3SnVoN09Ba2lFOXVHWkYvTGZsazBJNmxs?=
 =?utf-8?B?a0FuL2FiK1RNSVN0ZG10d01DMEZHUWI5ZEE1WlpsTGZUZ0RjUTVhUjZTWlpi?=
 =?utf-8?B?WkFPQ0JOUGNNcEk4Wm53a0R3V050ck1MVHlyeFFPZVA0VWdXZHVwOXpqcisv?=
 =?utf-8?B?WHl1TmdZaU4vcTlUblBXaVVPRUF4eGl3QWY1UXBPQk9TOTJwQjlLc0dZeVVE?=
 =?utf-8?B?Z2hQWEMwTzROeWF5RW5BOWZRNmswYldQajM4c1JFRjlNM1grMnA0VHR1N0ph?=
 =?utf-8?B?Z3ppQTRqZExmQ1B2Qmk1a2ZFbVJHb1JVQ3BHRGFUeWNKaG14UTBHU003c1p2?=
 =?utf-8?B?ekdDT1cwN2UwUU5GQ21lTGdCMmtscjlsN3dWWmxlWU81YldJRjF0NXI3MU5n?=
 =?utf-8?B?eFZMeFUrTENLb2p1b3BwYmR1M29ySnplSk5VWjFIRGdBblkvbFlhRll5TlVL?=
 =?utf-8?B?Uzd2dlB1SWFoeUpSMFVNMnJ2YlVnekZ4OEx4L3V1R1l6NkFEODg1OGN3S3po?=
 =?utf-8?B?T29uSGEzVmZOL0ltM2JYOWJLMjMwa3ZxeXZGSDVwcG5yajlQM0Z4Qmx6aW5I?=
 =?utf-8?B?cWk1TnVoVnliOEFGWElBNkRtajJhRUZjd0NyNUJEbVNLN25qWm1tWmZSNmlW?=
 =?utf-8?B?dUdBMEJvWWlYRVk4d0x4MnBYNHBBVCttRmdGWmx0VWp4VG10UTBKdWl6SFRz?=
 =?utf-8?B?aVlJdXNSbGwvN3JDMEtTV1UzaDR6QnduRkozMlJQZlkyK1h3bnIvdCtZbjVk?=
 =?utf-8?B?b2lxdVBsNG8wb1E2U2IxSVMrTnRQNlF2VEo5d2pqb0UzOXI4QktEeGdGVEJ3?=
 =?utf-8?B?OWgvQm9tNEdhYzZ4R1Z6Y1k1OFhWVEc2KytDeTlHUXh6cWhja01acUtYZE9W?=
 =?utf-8?B?MnNzREgzajM5QkQzNTJFWmZTUDYwTXlySkFzN00xd3I2Q1ArWTNybGQ0cmcr?=
 =?utf-8?B?SzY4YnF4K2x0ek1lS3BuZVVHS0ZaWVlrYzFxL0s0YmF3VDNtTzdra2o2dm92?=
 =?utf-8?B?cWI2TGhsUllBaFREY1k2dG9CNDdobUJiUzJ1VUhYNGh1KzNDM0tIbEpZVWlW?=
 =?utf-8?B?Y2RidTZQWmFPNFQvaC9QNy9nZ0swdzNvdGRralNJTVFUdmJKQ1RBVkRHNlh4?=
 =?utf-8?B?NFdPQmt1M0JMQUpIYWZVNEhHMWlrU3V0MGxPU0RRc2VoeWN5Wi9iRW43cEpr?=
 =?utf-8?B?RVc0bExYU2dOck91RWF4NUZuQWFJSHpNcnY1RkpRSFVwQ1dlc0pJMldWblFt?=
 =?utf-8?B?ejJsbHdaQjlqTVJDRHdIRjBNb3Y0T3VQTFUwUlBDTnZqcWN6OVlaelRsS29p?=
 =?utf-8?B?M25MZzlUVnJrS2FyRVdyWmhiSEJ2SVlIVzhLckRXdnkrTGxiQU5WTVMxUmZK?=
 =?utf-8?B?WEptVXoxREtpbjkzUXNzVzR0eGxZMURiSUpwU3ZaYkhSUTNkdDI3dmYyU3pw?=
 =?utf-8?B?ZFlxN2ppR3ZCQVFGTmdnWU1icjlUaitNdUZHT0RsSXFLSk8vSUYyd1VWbWN2?=
 =?utf-8?B?NWNFakRzei9pSFNpNklGVEZwVWl5d1pOTkFzbEFNNjNFNTB4amErdHhZVmNo?=
 =?utf-8?B?T1pHaEtlUFdtbEpkOUpCVlp2b0FlemFGSmhIRVdiK1hmQjBJN0tSU2JqNWx6?=
 =?utf-8?B?UDN4KzM0S0NvRjN5NFV1NXB5UkZXaStXNTJZZkVJVmMwWVpYYmZnV0Y0NDVj?=
 =?utf-8?B?QlEvNHlZOXJEZy9Ibm9SOEgyaHZaR2I2dXdFK0MwbmpRQUJodGRLWElPT3Zy?=
 =?utf-8?B?T1hOdlN4OWFMWmpXUFRxeU9zRnR3WFpmTzcram1FcjhRcVFhSUtkN0ttVEUy?=
 =?utf-8?B?S1ZOQWhWZjd0NU1PVzlaVFNNTnpnK1hLZGVaWXQ3RzQzS0hidDZiTzgwU3Jy?=
 =?utf-8?B?TGhJQldjNkVUaEFzdHEwdEtna096R1FKZXVQcFh3dThvZWdUQm44aWs3Y2tl?=
 =?utf-8?B?Q3U2eXBXWDhVVk9zSjllNnpzZllEN1hyNXlTN1k5Z0FIbGhaWEZ6dFBwR2hD?=
 =?utf-8?B?YWFtQ3JTejBiUXV3RXFRNmhOTEg5eG5QenZKcHU0cGN6bFBXcW1iT1VBcUVy?=
 =?utf-8?Q?Snl3pm?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV0PR02MB11133.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0FuR1FjSVlQMkxlMEx3c3h2aS9pbGRHTjFhcUJQNDloMzRDNmIyT2hDT1Rl?=
 =?utf-8?B?NnAyM2Y4Y1NrMTJvRFdIT1JBeGp5RFpnS1E0TnNKYjVnc1BlSUZjZjZnSHh1?=
 =?utf-8?B?WFJUak5IT0wzbmY0cXdrVnp0b0t5OUtLRzRtZ1U5cHA1Y01ERXpaRnNweE1E?=
 =?utf-8?B?V2k2N2U0QlRUS3hUVkdCb2VJeHE0ZCtseldHbjlORkxUNWRhZlJoL2RrUGpF?=
 =?utf-8?B?Z0EyRG5FZzA2UHVLNUV5U015a2l5V211aXcvR3ljQUpvVnQ0ME9iOFVjTC91?=
 =?utf-8?B?dWdsWElnTTdtb1NjcDVNOFpnWXhyMStuYVk5N0d3VXNsVmw4YlU1WUpUYVhM?=
 =?utf-8?B?emlVMjEvK2J0bVpiYjdjS1NQYmxYdUUrUnFGYmxtNDRpSVA2alU5eThhSEZH?=
 =?utf-8?B?ZzM4amxPRmRENitIVi8rQnpiZDhLZEZoY3dVZUhld3d0WjArcFU4cHkvSGdC?=
 =?utf-8?B?WjNFaVc1ZU1NYkNlLzlCYUdzWGxVYmwxUDVDcmNWdVc2c2tvcnhqaVMyYzA1?=
 =?utf-8?B?cHk4djAySXZGdWRvd08vWHd4SnBKUHJ2RWppNUE2VDBVcWxRT1FOaVhiK3Nk?=
 =?utf-8?B?Q2U3bmZoR3ljWHpGWmg0R01PL0tUQVRnNkxaUURVWXlTVitWUzFCcW9FYzc3?=
 =?utf-8?B?Q2U4bC9QMlVKeHBJUEVscVh5SDFBOHR0Y2ZuZDA0YnFtK3gyQnRJbncrR1NQ?=
 =?utf-8?B?RDg0T0d1WDMvN2p6aGVIUVY0U2ZIWjU0QWpQTGFvZGpqb0NYa09lTkVVcEc4?=
 =?utf-8?B?TG51SDYrNjdyRStLRmNSbVhUS2FCcFdLZ1JCTjhyVHZhYWJsSjVHZ0d5SXRo?=
 =?utf-8?B?NzY2T3lCUHlPOVcyL2FBNHNhbzJ4NUYrYUJPMGlMNksvMkN3cGU0NVIyS0tM?=
 =?utf-8?B?WTJKRndOOERUNUlSOVB1WVB5L1k4TEF5NUZGampoMGl3bVhITXlnMTkyR1Jk?=
 =?utf-8?B?MnlpU2JRSjErMjF5NjRGdGNjZDAzMGhXMW5DVWZhK3g4VW1ZTWdDemhqM1RR?=
 =?utf-8?B?T0Z3TFpMdnFqckpHbGg2UVNqck1FRUlPbjFUd1lJUTdhVnd4eTJPZVhnZzY2?=
 =?utf-8?B?NWRsVXJZVXY4OHNScnc5WWRYcndXOWdiRHhYUThxOTRyNVlGV1hWcW5iQWhW?=
 =?utf-8?B?WVZJOGdLU2lHcEpwakxlRlRJSGhNWWZuczRPcEFKZkhBTzAzWktsanJHR3hP?=
 =?utf-8?B?cktja2d6REtFN3k0WWRBcnNreVhNcERuYjgwU0VYaVhZelhOa2JRWEJzazlq?=
 =?utf-8?B?MXcvZ0s5UnJuY2wwZC95aU5pL0ZlcmloZjRHWW5VZHdJckJVaDVJV3lrWHdB?=
 =?utf-8?B?QTdCRFREdFJyZ05yOEhDOEZ2SFpzTHh1N2tyTmd5OWo1S0tqcDVJeE5sVkVX?=
 =?utf-8?B?ZUtRSmZYblE1Sy9hbU5OemEyM0ZrK1lLWXZwQUtZWFNXNTRuUHlUUUNjNCtH?=
 =?utf-8?B?V3dSMmd6SWcwc0tUMnVJT0tCOEJHRWUrZ052SFU3YnpZMStGQTZDaVZwaFk3?=
 =?utf-8?B?MmU2UWFodkRQdUhjL3JKVTZIZEJ2c0NLeUtzT3l4L2RrbFA2aG96REMwM055?=
 =?utf-8?B?THF5dEFJdUoyRnNubU9OQmx0bkFyWnFRcnI4VjYvMllxNkxFVDlIV1RURGpG?=
 =?utf-8?B?QWFJTXVTWDZtcGVtNTl4V1ZmTUIyV3hZRkRFU2lxdXJDN3pEK0haQ3F0eFpr?=
 =?utf-8?B?RzRqWlNtN0FVaEJCT1MwOVZSSnpza0ZwY0llb084bHVQWGQzNXJ0ZXlNKyta?=
 =?utf-8?B?eU5LSHBMOVFkZHRqU21PUDVpZnp0encyakFkUHhpdlVBZUw4b3YrbHZSUFZW?=
 =?utf-8?B?blVDenBvbVN0eW9UbmlDaFNTT0JDNFpKSndvZmIrRlZGNUpPR0JOeWdwRXpG?=
 =?utf-8?B?Si96amdpcVIyeGF0UXBQc0hBVlBSQStEMGZFTHFhL1huUURDc0JyR2VZbkJG?=
 =?utf-8?B?Vm0yanA1blFWeDM5OThxTFlpbHdJVkZ5VE9reVpqTG1hWnNmd3FvUXRsV2RD?=
 =?utf-8?B?UHFXa25BZndSWjhQKzRXQXRlMnV0S2c3YVJYdnlhSStsMkNSMHNHa2hnekFQ?=
 =?utf-8?B?MUl2bG1WMTl3ZWNKKzBLMWt4TTdxaHplVjZ1UVQ1NVJBT0FNamZHMURrR0M2?=
 =?utf-8?B?OERqTUdnakJWOXgzaHhySWtmaXl2RFEvcG85SGRVMHh6R2J2OGRNLzVoSm5k?=
 =?utf-8?B?cmZDem5KNHZWM1lZNTBxZGJTQnpMd21lNTkzMzNvc09ZMHZzV1RJYjkyeHRs?=
 =?utf-8?B?NGVtcy9vK3pOYzFCb2pFQkVlaGtBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0D3A2E33F4EDA458CD2BE93F2A8CCC8@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44243b7b-def9-4302-95ff-08de1c9ab5e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 18:39:53.4647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NqavRD2qVwEuNtJkY90q3ySlcaP6qivjFnvhW3xwzcYGpcfXx8fsodPxytbbPCBOZP2JSqPSfTyvFEv0g2oIZ4oLDaCVfdGonUZfGlMjuj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9630
X-Authority-Analysis: v=2.4 cv=NKTYOk6g c=1 sm=1 tr=0 ts=690b99fc cx=c_pps
 a=6N00tFO2at9SeXRP/8dOoQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=20KFwNOVAAAA:8 a=BjIqp4pjILlhFWQ6CCQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: F6Mb61BJI9CiWcHC5sOjFcf0iGPeQjyk
X-Proofpoint-ORIG-GUID: F6Mb61BJI9CiWcHC5sOjFcf0iGPeQjyk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDE0NCBTYWx0ZWRfX03tuOCGdTN7B
 cKFvCWLlwDWrRyaigdh7iyrhthjz7CnYkZ2Ogs5J0YpPwz99uOEDXN9fjY4iegObjzwQHig6dNb
 vqXnhQHaSTS5As6fDU25/EN7oRSESsZtCvRwy8oHB1N+6O5772mKjM+1k/W2v/iQwqOwD1PWbDk
 uJdeL4YcqTIPVe6qc0opmKS6520DAuucIkTOPIqGri1WS61ijCtH248xvCYjPpKpzViuowlaUyE
 TAKdDy3KdGITkWtMt6Hlns0Lvj15491muCo8VYRLIGUwrVOI8y6rGKOVA8mi/O8twq0mphReq7N
 4d54HtFux59HOEnqE9In38P0o6tq5SJOlNORB6yIDxFrFDjpwLO8XFEsTJaOLNwYvfbqeQYOXAQ
 S7rRygNARFZX8Vq0VrpqjpzydNulEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_07,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68; envelope-from=jon@nutanix.com;
 helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4gT24gTm92IDUsIDIwMjUsIGF0IDQ6MDXigK9BTSwgRGFuaWVsIFAuIEJlcnJhbmfDqSA8
YmVycmFuZ2VAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiAhLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4gIENBVVRJ
T046IEV4dGVybmFsIEVtYWlsDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+IE9uIFR1ZSwgTm92
IDA0LCAyMDI1IGF0IDA4OjMzOjA1UE0gKzAwMDAsIEpvbiBLb2hsZXIgd3JvdGU6DQo+PiANCj4+
IA0KPj4+IE9uIE5vdiAzLCAyMDI1LCBhdCA0OjE04oCvUE0sIERhbmllbCBQLiBCZXJyYW5nw6kg
PGJlcnJhbmdlQHJlZGhhdC5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IE9uIE1vbiwgTm92IDAzLCAy
MDI1IGF0IDExOjU3OjUwQU0gLTA3MDAsIEpvbiBLb2hsZXIgd3JvdGU6DQo+Pj4+IEluY3JlYXNl
IE1BWF9NRU1fUFJFQUxMT0NfVEhSRUFEX0NPVU5UIGZyb20gMTYgdG8gMzIuIFRoaXMgd2FzIGxh
c3QNCj4+Pj4gdG91Y2hlZCBpbiAyMDE3IFsxXSBhbmQsIHNpbmNlIHRoZW4sIHBoeXNpY2FsIG1h
Y2hpbmUgc2l6ZXMgYW5kIFZNcw0KPj4+PiB0aGVyZWluIGhhdmUgY29udGludWUgdG8gZ2V0IGV2
ZW4gYmlnZ2VyLCBib3RoIG9uIGF2ZXJhZ2UgYW5kIG9uIHRoZQ0KPj4+PiBleHRyZW1lcy4NCj4+
Pj4gDQo+Pj4+IEZvciB2ZXJ5IGxhcmdlIFZNcywgdXNpbmcgMTYgdGhyZWFkcyB0byBwcmVhbGxv
Y2F0ZSBtZW1vcnkgY2FuIGJlIGENCj4+Pj4gbm9uLXRyaXZpYWwgYm90dGxlbmVjayBkdXJpbmcg
Vk0gc3RhcnQtdXAgYW5kIG1pZ3JhdGlvbi4gSW5jcmVhc2luZw0KPj4+PiB0aGlzIGxpbWl0IHRv
IDMyIHRocmVhZHMgcmVkdWNlcyB0aGUgdGltZSB0YWtlbiBmb3IgdGhlc2Ugb3BlcmF0aW9ucy4N
Cj4+Pj4gDQo+Pj4+IFRlc3QgcmVzdWx0cyBmcm9tIHF1YWQgc29ja2V0IEludGVsIDg0OTBIICg0
eCA2MCBjb3Jlcykgc2hvdyBhIGZhaXJseQ0KPj4+PiBsaW5lYXIgZ2FpbiBvZiA1MCUgd2l0aCB0
aGUgMnggdGhyZWFkIGNvdW50IGluY3JlYXNlLg0KPj4+PiANCj4+Pj4gLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4+IElkbGUgR3Vlc3Qgdy8gMk0gSHVn
ZVBhZ2VzICAgfCBTdGFydC11cCB0aW1lDQo+Pj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+PiAyNDAgdkNQVSwgNy41VEIgKDE2IHRocmVhZHMpIHwg
Mm00MS45NTVzDQo+Pj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPj4+PiAyNDAgdkNQVSwgNy41VEIgKDMyIHRocmVhZHMpIHwgMW0xOS40MDRzDQo+Pj4+
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+IA0KPj4+
IElmIHdlJ3JlIGNvbmZpZ3VyaW5nIGEgZ3Vlc3Qgd2l0aCAyNDAgdkNQVXMsIHRoZW4gdGhpcyBp
bXBsaWVzIHRoZSBhZG1pbg0KPj4+IGlzIGV4cGVjdGluZyB0aGF0IHRoZSBndWVzdCB3aWxsIGNv
bnN1bWUgdXB0byAyNDAgaG9zdCBDUFVzIHdvcnRoIG9mDQo+Pj4gY29tcHV0ZSB0aW1lLg0KPj4+
IA0KPj4+IFdoYXQgaXMgdGhlIHB1cnBvc2Ugb2YgbGltaXRpbmcgdGhlIG51bWJlciBvZiBwcmVh
bGxvYyB0aHJlYWRzIHRvIGENCj4+PiB2YWx1ZSB0aGF0IGlzIGFuIG9yZGVyIG9mIG1hZ25pdHVk
ZSBsZXNzIHRoYW4gdGhlIG51bWJlciBvZiB2Q1BVcyB0aGUNCj4+PiBndWVzdCBoYXMgYmVlbiBn
aXZlbiA/DQo+PiANCj4+IERhbmllbCAtIHRoYW5rcyBmb3IgdGhlIHF1aWNrIHJldmlldyBhbmQg
dGhvdWdodHMgaGVyZS4NCj4+IA0KPj4gSSBsb29rZWQgYmFjayB0aHJvdWdoIHRoZSBvcmlnaW5h
bCBjb21taXRzIHRoYXQgbGVkIHVwIHRvIHRoZSBjdXJyZW50IDE2DQo+PiB0aHJlYWQgbWF4LCBh
bmQgaXQgd2FzbuKAmXQgaW1tZWRpYXRlbHkgY2xlYXIgdG8gbWUgd2h5IHdlIGNsYW1wZWQgaXQg
YXQNCj4+IDE2LiBQZXJoYXBzIHRoZXJlIHdhcyBzb21lIG90aGVyIGNvbnRlbnRpb24gYXQgdGhl
IHRpbWUuDQo+PiANCj4+PiBIYXZlIHlvdSBtZWFzdXJlZCB3aGF0IHN0YXJ0dXAgdGltZSB3b3Vs
ZCBsb29rIGxpa2Ugd2l0aCAyNDAgcHJlYWxsb2MNCj4+PiB0aHJlYWRzID8gRG8gd2UgaGl0IHNv
bWUgc2NhbGluZyBsaW1pdCBiZWZvcmUgdGhhdCBwb2ludCBtYWtpbmcgbW9yZQ0KPj4+IHByZWFs
bG9jIHRocmVhZHMgY291bnRlci1wcm9kdWN0aXZlID8NCj4+IA0KPj4gSSBoYXZlLCBhbmQgaXQg
aXNu4oCZdCB3aWxkbHkgYmV0dGVyLCBpdCBjb21lcyBkb3duIHRvIGFib3V0IDUwLWlzaCBzZWNv
bmRzLA0KPj4gYXMgeW91IHN0YXJ0IHJ1bm5pbmcgaW50byBwcmFjdGljYWwgbGltaXRhdGlvbnMg
b24gdGhlIHNwZWVkIG9mIG1lbW9yeSwgYXMNCj4+IHdlbGwgYXMgY29udGV4dCBzd2l0Y2hpbmcg
aWYgeW914oCZcmUgZG9pbmcgb3RoZXIgdGhpbmdzIG9uIHRoZSBob3N0IGF0IHRoZQ0KPj4gc2Ft
ZSB0aW1lLg0KPj4gDQo+PiBJbiBwbGF5aW5nIGFyb3VuZCB3aXRoIHNvbWUgb3RoZXIgdmFsdWVz
LCBoZXJl4oCZcyBob3cgdGhleSBzaGFrZSBvdXQ6DQo+PiAzMiB0aHJlYWRzOiAxbTE5cw0KPj4g
NDggdGhyZWFkczogMW00cw0KPj4gNjQgdGhyZWFkczogNTlzDQo+PiDigKYNCj4+IDI0MCB0aHJl
YWRzOiA1MHMNCj4+IA0KPj4gVGhpcyBhbHNvIGxvb2tzIG11Y2ggbGVzcyBleGNpdGluZyB3aGVu
IHRoZSBhbW91bnQgb2YgbWVtb3J5IGlzDQo+PiBzbWFsbGVyLiBGb3Igc21hbGxlciBtZW1vcnkg
c2l6ZXMgKEnigJltIHRlc3Rpbmcgd2l0aCA3LjVUQiksIGFueXRoaW5nDQo+PiBzbWFsbGVyIHRo
YW4gdGhhdCBnZXRzIGxlc3MgYW5kIGxlc3MgZnVuIGZyb20gYSBzcGVlZHVwIHBlcnNwZWN0aXZl
Lg0KPj4gDQo+PiBQdXR0aW5nIHRoYXQgYWxsIHRvZ2V0aGVyLCAzMiBzZWVtZWQgbGlrZSBhIHNh
bmUgbnVtYmVyIHdpdGggYSBzb2xpZA0KPj4gc3BlZWR1cCBvbiBmYWlybHkgbW9kZXJuIGhhcmR3
YXJlLg0KPiANCj4gWWVwLCB0aGF0J3MgdXNlZnVsIGJhY2tncm91bmQsIEkndmUgbm8gb2JqZWN0
aW5vIHRvIHBpY2tpbmcgMzIuDQo+IA0KPiBQZXJoYXBzIHdvcnRoIHB1dHRpbmcgYSBiaXQgbW9y
ZSBvZiB0aGlzIGRldGFpbHMgaW50byB0aGUNCj4gY29tbWl0IG1lc3NhZ2UgYXMgYmFja2dyb3Vu
ZC4NCg0KT2sgdGhhbmsgeW91IGZvciB0aGUgYWR2aWNlLCBJ4oCZbGwgc3BydWNlIHVwIHRoZSBj
b21taXQgbXNnIGFuZCBzZW5kIGEgdjINCg0KPiANCj4gDQo+IFdpdGggcmVnYXJkcywNCj4gRGFu
aWVsDQo=

