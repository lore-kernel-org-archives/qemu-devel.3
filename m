Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85486C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 11:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Nd8-0004UA-6x; Tue, 21 May 2024 07:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1s9Nd6-0004Sc-MW
 for qemu-devel@nongnu.org; Tue, 21 May 2024 07:26:04 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1s9Nd3-0005gb-Us
 for qemu-devel@nongnu.org; Tue, 21 May 2024 07:26:04 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44LAGsKw014103;
 Tue, 21 May 2024 04:25:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 proofpoint20171006; bh=HC1hvkJyUfSIxj7i6f1TyvoC8VHJGtDa0I7KZr1M4
 /k=; b=wokkVJNJ5QbzWsbaS68tVTqzAU/F/CPRkLeItNYU8Wl9KaTMT7BbFEUEF
 Kf5tb4wQ5iEnQRHwHRISz56p5yQfIi7bmTCTLP5RkR7zJsrxV5G1rME0dD0WA07N
 VWOJTfkJa+/69cqIBKfaqux+EszDze8ZrUYGnIw/tycDJizuGdsAJj8c5T5dhJRc
 QHeWD5LQ3ryVSgJ6/FYUmkYNcf1idMofFsspQHaIqJD7Gi8yhflZ68tREaD8w2CH
 RFQXyJJT51hwJyFWMTxyNVfL2fNnuKgxUxDkHrIe8vgGhN/CZRS8OUXzDKFNXSh6
 PQAenB4yelUHrC1Xq+I8mi12YnU4w==
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3y6uux5q42-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 04:25:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IREoIU/4M6kwLcuvMZZVFMmFJNiFL4rR9StDFxH2w2dHwOOxDqpnnA0qb5YA9FPImA1tL5/TpS8i9ARWq3eVWIft0v5YruC1mHSDvM2w+dggzg91ZVdw76gdwkCX3fb9ja+M1MpeEYrWQbD+ECX9c//rMR+UL8BQyo3LYTXYTJIdSpZaxib7hsoR+VB/gLt8O6KIWjqpNZjo10+leOyt1gB4cJEBvODuOpVNAW0PUsBgHvwpEmHTwVNIsbxUE+raClWWkh6WhKATgFpXoC9hdW0ssZiCcw0UgFDICBN/tZ1XoyGVTMLGK55OnwsJ+ECndy1TSylflL8GaH3YzFxxtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HC1hvkJyUfSIxj7i6f1TyvoC8VHJGtDa0I7KZr1M4/k=;
 b=jWxQIQBnn2AXkIoqcAK6N3eYhK7mexQMjabpx4xROJ1pb+VZM88OeZrqPXnr/ROx7SKPpl7AGCEL+rDU7pRQzeTkgNlGYlB4xEUcmRFC/ddU/QdPQ2xEItHOHaV2ycgbWqLV6LBQN4lB6NsWiDuElPHjMkvqfcfEJ5+wg5ZywOXbnDQk7OWxrVZeMt3zIKpn1xQ+MXuvf2GVrkThxG85V6Bl9P2AsiaSe2us+NFn0sOTJORz52QF3YJaEvEPqgC6n1BMcxOkUgdl2tRhIrUVmsVyJprj2e4J/o3zuq+JdKGwkv3OHE+5BX0tRdsAPxaLvoh+dwzVo+VR48H1NxDfsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HC1hvkJyUfSIxj7i6f1TyvoC8VHJGtDa0I7KZr1M4/k=;
 b=sIaFK3PcwQhImUmyRVrWhBtE7otUl4qumGn/c+ZTZwHkqfdTYOiinciyWV2YRq4iCb0Rc4H3RpzpaEYUIQA+EEqJPiCrdBVAvEkrV5TspoMILiQgDZ+xFnYs8pJBWvRQM07FH8AoHwvdv8zq0i4JHvTfQyp6jKiajmSMxYZQlajYY2i+ioWTHLucVAQ/GJZodgrdx1A90Qx+WQuNGZ5bx9RI2SngsC+IIxMhztERKNEAFers5DAsqorS8k9YlHn4NVZCYGwsYLldeiWnmEbESCnCgiodH9vl4gRaDw5AUJKhaK7wdQ8rz5tdXFSU9t/Ehg7OijLAbgfrwwfj2YAFNA==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by SA6PR02MB10477.namprd02.prod.outlook.com (2603:10b6:806:409::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 11:25:56 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::dccf:e607:1488:eced]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::dccf:e607:1488:eced%5]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 11:25:56 +0000
Message-ID: <6460accd-9926-4743-a66e-d74e5241c79c@nutanix.com>
Date: Tue, 21 May 2024 16:55:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: More doc updates needed for new migrate argument @channels
To: Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>,
 QEMU Devel Mailing List <qemu-devel@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>
References: <87ttjf1jk8.fsf@pond.sub.org> <87fruznjqf.fsf@suse.de>
 <31a8bb06-5270-4fbb-b8f1-39cd06687c34@oracle.com> <ZjU26faJBrt9Gb-G@x1n>
 <87le4nsfjb.fsf@pond.sub.org> <Zjj57JdLfXxT7R6G@x1n>
Content-Language: en-US
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <Zjj57JdLfXxT7R6G@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::8) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|SA6PR02MB10477:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d88dfad-963c-4acc-c995-08dc7988c80f
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGwyRXlNK1p4VWxiWTFWOTBwV24zTjdOWEdQaEFkclpORHp1cU1ScTBWTnlG?=
 =?utf-8?B?c2hHZkVZZFZSaVpTU1dDYVpydXpLYVFMRExZY01HNnFFbTRoS25UQ3V2VS94?=
 =?utf-8?B?OHM0OGJxQXU2aVRUemo3aFVVeGpZcVhaMFpiRHR4YWdZME5ZQ3Q4ZU1pK3Mz?=
 =?utf-8?B?Mmp4NGhyYWR0bTFadVcvMHNURXFwWmtuTUxzNEZmVXBNUXlNQkxaUHg1SG9t?=
 =?utf-8?B?RDFPbDJFNnF3b2tOdlMwdVhaaFhhTGMrSklZenhlQllSbUZEcGQxY2RZdldC?=
 =?utf-8?B?TkNQRU1iMjFRaXg1MWFJOXdlNHk2bnNjVjRWZ2h4Y3QvS1IzeDZFbytHbmVu?=
 =?utf-8?B?dkRFbUh4a2ZKSVZ5dmlESWdqZkJyWEI5WE12Tmtyc3VXeXc3ekthNm9tSGor?=
 =?utf-8?B?T3J3c3Fzd1RiL1RRYjl4M3JHTENGQVpXQWQrZXZTOW9sN1pHOU5zaU5Xa1Ay?=
 =?utf-8?B?Sll5aUE3OVBNL2NFZG0yZXJ6N1dWL3Q3UVYwU05RZVgzZVY4cVRGZXpnbHlJ?=
 =?utf-8?B?UVhRbUhUUWpZeHJJQ2J4eGYwb1FPbWdhYm5aekxlSG1TWHV5N09NSDIwMzQ0?=
 =?utf-8?B?bjE5eUFSRmlBRDZPVlV1TFp3TCtEaGZjaFBtTklPQVFiaVdRK3BRTTFUV2JN?=
 =?utf-8?B?MEFCTXphV0dob3gzQ1M5c2FIdC84WU9VQzE1RDRDS2QwQkFpeDEvck9uaVVL?=
 =?utf-8?B?dFplV2FPeEw1MkpOcnAvRnJnSTBxMm1laVlrSThOWkttNVVLcDVRWXR1dzg5?=
 =?utf-8?B?MGcvQm9BRlIvT1gxTDhERnhzZkp0OU9iZzRwMHJCOUIwZW00UUZDVTJIVVJR?=
 =?utf-8?B?Ni9sY3RyeTVvblRXY3MyclhUa3VqeWUwSm5wSzRuOGtmdVozaXYydDdESHY4?=
 =?utf-8?B?VlF5NmNabjVra3hsbVkrR0hRWlJ5ci9yUHlIc1J2K1VhQUNyL3UzSXEyQWZC?=
 =?utf-8?B?aGFjV0hKUk12ZEdGY093RTlYV1Y1eFU0YTVSVXM4cFRnQS9xbnRjcGI0d290?=
 =?utf-8?B?ZTFSOW1FeC9pT0E3VmNmekE3NGNHMFF2SXdjV1RmUmJwUmpLcDRScW5BVFJQ?=
 =?utf-8?B?UnhwN0JmYUgzRUFDWFBDVy9rVGtxNWRmeTROL3gwYTErOWQ3Ry9JSW93STN2?=
 =?utf-8?B?WVFXMFBYZ1JSMVlTSGpocnYyMm8vVHpoN0ZoL0d2clJ0SlpNMVQ4ZTNZcWw3?=
 =?utf-8?B?UHlNQlZaRDJKY1dRcHRMK2EzZmtJQ0l5aFRzU0lzRUlCOFJOUVFTajU3ck1P?=
 =?utf-8?B?UUplUUdjTGNNY3J3UmhHaWdmalZRdnowZ2QzeXNEam1RZThCbXY2NWpoeU9v?=
 =?utf-8?B?ZzJvSUZzU012TjhNWHdSMmNGTFhXVDdObWZreXBnTndkTWZBaXAwT0h5aktJ?=
 =?utf-8?B?clVWQVd3OXBtbjlEY2VEWUdETlRzMTJ0eU5ycExJUHV2Vm5ndUxyK25CMjhV?=
 =?utf-8?B?Yi9uRytlVHMxaUtDYkJidmFPS3k2NUdFTS9ZSHdlMTdWRC9mWVh6akhiRzRT?=
 =?utf-8?B?NUhnK1FUVHdPUnhhamFkMVhKOW42MGxERFdkUnZPRUZYcHhsQjJYdGhtNzBr?=
 =?utf-8?B?d1hZNDg2eHNHTXA0SGFWM21DYk90aXRxZXI3RkZxVC9mLzNKM1k1aXcwL3lL?=
 =?utf-8?B?MjdHY0k3MGptOWY1ek5XWndFUStzOUNXYkxFQVUwOXFKQXNFdEVGWU5Gc3Zm?=
 =?utf-8?B?QTdWbHdJVDhoMWQ2V0t5dXdUank1aWlJZVZ4NTArSlU1RDlPcnh5N1pnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnZnUTJwRnAwcUpGTzdoc2tQclJhSUxvbG1KYlZQbnZMSWx0ZzlJbEhLQ2lq?=
 =?utf-8?B?Q1dBV1p2eWJWZ09CditmSWhaY2hXSUtiQUhnS2lwcU1iQ0dGUDQ4NFF6eGFK?=
 =?utf-8?B?dTJNV0cwbitlU2UxM3ZYMkJaeFhrVUNBOEU3WkdaL2p4ZGJhTnBBZC9MdWVZ?=
 =?utf-8?B?Uk8rODFRL0RvTk9FYlhJWWwyS1U0elg5T0ErTkJYR3ltT0JmWFE4Y09zOWp4?=
 =?utf-8?B?Z2I5UTRGSjNDeEFLbXQvOUdOakFITXVGTldPWmliTEw5bE1mYWFjNTNrS2xK?=
 =?utf-8?B?NTVXTU9YbWJDMEFIRU96djdiclZmU3JyeG9nNXRJcFIyUmpiOERGNXE5U1Zx?=
 =?utf-8?B?d0s5bnVRbDRTS08rczZwZ0EyTklObVI5bC9ZWEZPNVlxNGhiREFoemY4S3B1?=
 =?utf-8?B?c0JzRkhMRDBLZXpBMURtTDFHUktpQXROOGltZVFOeElyWnlmSEx1WWFqamFZ?=
 =?utf-8?B?cFFNSkJ4a043UUlnZWNHUk5XN2o0b3RtQjlBc3ZMWTJpZWhvRUZxaFIwbzJF?=
 =?utf-8?B?TjNLc1BVQ2wvaDRCR2F2UGxKcGlEa0VyNE1vRzdqTHFzSkc5TGkrdjNBaHlM?=
 =?utf-8?B?RER1K0tEWVM4TVUzRE44djNITTk0SWxKWjRZejN2SWczZTh3WWphM3dHbGEy?=
 =?utf-8?B?Z21XeFNaZmlnOHIrYmI2QWtvSm9hN2dWYjVVMVpJRkJoMmdYVHVSVlZocTZJ?=
 =?utf-8?B?Y1ZYRUdkV09zWUtsTTVxOFBCbFdOSkhiNEwrL2pSUDVQREw3T3lGdkhiWWVr?=
 =?utf-8?B?OHA1dzFPUzQ3WmE2REZEZ2wxbnAxZHBsSmJEUml0anhqMWUwNVVkck9SY2Va?=
 =?utf-8?B?Vjh4bXFndXBvOUpwUFpmdVcxQWxIeWRVaVIvMTAxOWpYeXFGQXBPQXNvSVdZ?=
 =?utf-8?B?eUtjS3A5MjNidk9kaEZ0cnVWa2tSTHhDTWpFN0tFdmU0NzU1WC9MVzR1TCtk?=
 =?utf-8?B?M01BT2lWakVrVTBOWGcvWVROY0lwNnNSMDdFRE01blRHaEFqZUJRUC9pcm9D?=
 =?utf-8?B?clNtSjZxcTZ1OFRRNzFnTk9rNFRtUkNiYXl1bkgzVnZlZWNvRWhwcGNaWTlO?=
 =?utf-8?B?VFh3R0sxQzNXSEdtTDcrNzg4RDRDR0ZlbXhHZERWZW9BeXIxU3U0Ry83YytL?=
 =?utf-8?B?VDRMYWRHcXcxSlFDc2lsMUw0YWd4a1VmRFppRUt5azNQNkl6YlVJNzh5anJV?=
 =?utf-8?B?OXhUZ2t5WWxFZFBOTThud2RzU0RnOTR3MzBLUDBoTUJ0d1lDWlE3N2lZWXdX?=
 =?utf-8?B?RzFoaENpcW03MHVRVyswdVUxTmhCVmhSR0NsczZZV2V0dGozRlMxMWpyK3V5?=
 =?utf-8?B?WDJkaHRTQ2lEcW9PMFRFbDdUbitpemtkR0t1MCsycTJRV2VXN2FQM3ZzUURs?=
 =?utf-8?B?bDlJeGN1QXJWcVhkVWpwOWRWcTFjcFNMbWlvQUVVV2JsMlZEdlAzZXE0bXZN?=
 =?utf-8?B?cG1FeFYvbHhqcW5oK0tuQ3ArZ3pvZC9XZ0hkd0pHM29zUXF1VGhJUDU0NWFw?=
 =?utf-8?B?TGdMb2lHQlJtUklPaUplbmN3U3JwdWwyZ0xNZ2N4MkgyeEpZR3pmb3BxRHk3?=
 =?utf-8?B?Y3lNNnBHSUlVNkRkME4vbGJ0SVJERDh4MGF5Z1FHN3U1N1pTbDYybGRZZlha?=
 =?utf-8?B?cE1GNWY2aW5DRHRMQ0hKUUdmdDZlbGorU0lGTkl4eEtLR2N0b2g5Q3E1emNQ?=
 =?utf-8?B?S1VONVRyRldnM3h4cEZqbWxKTm1mSGM0Z0MvbUFSWHdlM3J5Zm1HUnd5aHFT?=
 =?utf-8?B?Mk5DTnhHL0JOcWdteWdTV3RJRktURTVFUzc2NThwczhDVzllWUplSC82aEg0?=
 =?utf-8?B?aFg2blZDZ0dyVUtmR09IUnZjV3JwTFAyU0prRkVGcTIyZ0Zib1M3TUVKQTVQ?=
 =?utf-8?B?WTRFUmw2eXZaTFV2VkQvQXVBOVpNM3JUNDVtaUg4M3Z5RXFWOG12cjVlZ293?=
 =?utf-8?B?MzFHQWh6NGJFbUowcEU4K05sZzhRYk5JWHlwZkhLWjR0TC9NV0t4WXFQZUFC?=
 =?utf-8?B?RmJLMEZRdG9RcG9tdW1ZcmJDVXlwdDJQY1pwblIzMWkvRTlzNENLL1NyR2lo?=
 =?utf-8?B?Yys4TXc0NDBOT1NhTE56UFU3bUI4cGtlK3AyYUZmL0N0TG43czU2Tk5nckRI?=
 =?utf-8?Q?6AjFErJnMVR/n3Yo9WzlpPx1k?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d88dfad-963c-4acc-c995-08dc7988c80f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 11:25:56.1719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRc6EjmMDKdr1yOncQn46K097z52YBreW/K3DEt9eQtE6T38CJwrZp5+LOTPVd5RdUR93tsLUoTDFvScLk+DkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10477
X-Proofpoint-ORIG-GUID: nhgCF6Q8V2JtNG29wHEUvzwtWDYBrWBL
X-Proofpoint-GUID: nhgCF6Q8V2JtNG29wHEUvzwtWDYBrWBL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_07,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 06/05/24 9:10 pm, Peter Xu wrote:
> !-------------------------------------------------------------------|
>    CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> On Mon, May 06, 2024 at 06:58:00AM +0200, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>>
>> [...]
>>
>>> I also copied qemu-devel starting from now.
>> My bad, I messed that up!
> Het, do you want to send a patch?
>
> Thanks,
Hi Fabiano, Peter. Sorry for joining late to this discussion.
Was out of touch for quite sometime from the qemu upstream community.
Will definitely try to send a patch for the 'channels' documentation
changes soon in Qemu, as discussed above.

Regards,
Het Gala

