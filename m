Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B8CCA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:15:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQf1-0001dC-Hm; Fri, 22 Aug 2025 08:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQez-0001cQ-6n
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:21 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.caveayland@nutanix.com>)
 id 1upQex-0000h3-18
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:14:20 -0400
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 57M8ANuC713908; Fri, 22 Aug 2025 05:14:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=oMENsTxKAzt+cZ2f4vsSr6hMerF2FMMiy3ZsC8SQD
 Ac=; b=WMOh1VDsXb9wDUk9fnu2RkfZkgHygcL8LdGenj1I4fhCtfygWUkuSqrxi
 0l9EJ77z28OMycLH+YqH3L2XlvUms4+kD8Lm6dRCgiloWjtYi1uxtqvgzQ7KsH6+
 74bhr8j74r9YYgZmlP0d/QzdNGLdW1I6tAs0KWKF1yOwrQQZTRtSQEF5yYZXGWdX
 zxrkBOmf4mGgMeJmzPXLPsTfUgX+iI7bT7EU23nAcHTuuRW2F1+q+g9XXK4H2nEX
 OnmKo0C6b+JKp/mgFKWeFTzZSkTpxfL9Dx/xME28Zkt2AZA1kFpOYijV+lHDaQFW
 1FdRoC6O+ZoKL/pOJbHSvr1n0y96A==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2123.outbound.protection.outlook.com [40.107.237.123])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 48mye6qgdt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 22 Aug 2025 05:14:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BtWQaaNlooIR7s3imlpd8zwZVH3+FQ3Fgx22yrqgeduoNj22m/9gHnGNNqGSm8t9ydJ90ThKrCPWrZ5St+33SYIdAJm0BQwIlEI9kpTjfrjKzHLnD/R2EfoHLz0RjZIDKKnOk1w1nMs2RDx+Wh0uaXhVclt+XDoQKkUyGbsPUPLqJiFwGiERVw40JeB+XprYoTZCgpXK+EUF23k0a9cyqLwtg4zpWa41DFcLiPnBgBydpmqix6x4FcQXytjSTbtP7GwgU9lPXcwmNSZbxtqn1sLt+MmzczHJ2uhSCqnEjDzOoZ37z3hdkqixuJhE2LMKkM2K0sPawwt/RUHTxQ5KXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMENsTxKAzt+cZ2f4vsSr6hMerF2FMMiy3ZsC8SQDAc=;
 b=Ebzq7XfCHOoH4e2sGzTOCgweyQ+fCs7LzLh0l2RJ2Vx09bApFOpz3NWBu2chWmzT788a2zSkNTBOU8zyyoNQGJzv5kHWagKFblHI3QGlU0u4sfq2GBsUlz9i47mpECVJolX6ssJ0VRSOP3YI/E/6WqaruJeqoShAenPKKBfM/zECOHl+D2w1NtUrzvM8eoOjtg1HN/UswkdG7+qKnbXjmw9XBEqPX4BFhm6/y7nWN75Q9eIMTdLOP8s/7kMikl6eoXrF6cwQ5Oo2qnVBmcOSP/cslfJlfpwGI1ZlChg+h5S8r8SoaOzfeyrHmYU1YhMeMu22w1Pmz5cEQ/Dstl8cQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMENsTxKAzt+cZ2f4vsSr6hMerF2FMMiy3ZsC8SQDAc=;
 b=UjtEGs3m11gk0jX5omaD6XQ3izZy7VEx+eGgLc1XF/2mVnFY6GWQAdNg47IxLRw1pYx0KbcS3dAun6r2x7YdFtLwKXt38E4zw/sq3u8bnHDwknzhRk3npTJC52C8eMo3f0CLoGSceDd5gG2YgrUfzMx4q9OAaSum/olLPMgXjHkzuiz03d9bwwjjfHTRwVjI7vXgfhseq/rIv/edQdwID7dNSSzwonD55qVNf7g8Ixi1BNhBojqEJeTFdRm11RM1rWANxKyPMQcM3Qm0pUcOVHxT7VKJJ2mZl/c9/iG2jkdhs5hgDnQButaUXVytj5Gq40SV1uilnou+1cOi7vtG0g==
Received: from PH0PR02MB7159.namprd02.prod.outlook.com (2603:10b6:510:16::8)
 by SJ0PR02MB7725.namprd02.prod.outlook.com (2603:10b6:a03:322::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 12:14:15 +0000
Received: from PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88]) by PH0PR02MB7159.namprd02.prod.outlook.com
 ([fe80::6cf9:b35c:b143:bb88%3]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 12:14:15 +0000
From: Mark Cave-Ayland <mark.caveayland@nutanix.com>
To: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Subject: [PATCH v6 08/19] hw/i386/pc_piix.c: remove nvdimm initialisation from
 pc_init_isa()
Date: Fri, 22 Aug 2025 13:11:54 +0100
Message-ID: <20250822121342.894223-9-mark.caveayland@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822121342.894223-1-mark.caveayland@nutanix.com>
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR03CA0009.eurprd03.prod.outlook.com
 (2603:10a6:208:14::22) To PH0PR02MB7159.namprd02.prod.outlook.com
 (2603:10b6:510:16::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR02MB7159:EE_|SJ0PR02MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f2cdf46-9ba7-42fb-4933-08dde1756981
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0JsQVI2M0tYVi92Z3Z1eVE2aXdjMzI1eGdVL3lJU05MUy9HR09YaDRCTW1B?=
 =?utf-8?B?aWNoVmsrK25Uazd6SjVpR1l4U1hCcmw2OU8vczRPZ1UydjEyUUVWRVA5NE9w?=
 =?utf-8?B?NVJtNGlJU2ZGb3VWOVlMZklJR2ZsSXJLQ0FQZFdVS1MwNTU1QnMwclo0R1N2?=
 =?utf-8?B?b3ZPNmtGME1hcjZEbGNDK1ZheTdabDZrTHl0SUtjUE1UekZmdzRRdUcyb1Rr?=
 =?utf-8?B?OVp5V2VlclJFVVdJTU1mQVlJYnFlcytsS0dyRVJ2dXBJQ0Zka3o3TXJrcWEy?=
 =?utf-8?B?UHR3emFUczhoY3BNS0NmcndjcnU2N2ZwNkF2Z0tRSytYZThhR0dEZ0Q0dTQ5?=
 =?utf-8?B?OFpZSTV4T29ua2dISkV3SVE5cEJYTy8vdkRheDhKVW9tMHduc3NLN2xVak05?=
 =?utf-8?B?cVJjUmdRK1dKcFoydFVzWHV0SHd0emJsSUgzU2RoRVNrcTJkK0FyOE9Ub3JN?=
 =?utf-8?B?NG9KNXpTWVBickZ2MC9GVWF0WldWYndwak1FSjZPYXlTeW9iSWpoTWVKU1U4?=
 =?utf-8?B?LzEyT1BkZXNycTcvOW1SRUwrbmJkZFJDLzM2WnJOaFNXOHRoRlcwcFRxQXFi?=
 =?utf-8?B?MGx4cUxKL3hDNFFtMW9zd2k3QkxmSy81Vng2NExINFQzSkRETEFLVjhJYk9k?=
 =?utf-8?B?OVhCWVB2ZWxWekZTc3ltQjNiZVpnbXJvTDFNS3ovamlSUDBoenVTVnk5a1NH?=
 =?utf-8?B?cTJqdHNWRUE4SndnbUZ0dGpvS3Rua2lVMDdRMlpERG9XRGN3TjBLWTJyRTdt?=
 =?utf-8?B?cnFRN1E3V242elJjKzlkcnUxTlBFVVRxSlc5Y0Jqelo2VWdZT2tsRHVFd3Rz?=
 =?utf-8?B?SlN6OS9FR2NwNHBIQ1hSNG94Y1M4Z1RMd1c5aGRMeEZiSEF0NTBjZWFoVndr?=
 =?utf-8?B?cGtYMjNtbXRDQmJiZTRYNkNZRkVQdWFNbDRqMDRabnV4YTVobDhOSDVJdlI2?=
 =?utf-8?B?OWExWnZVNWprN3hUM21OUmtTNnp2c1FDd0NhcXFCYi9idVFHLzhiQnVWOHdC?=
 =?utf-8?B?WHJzSFl5dHNsYUR3N2ptMVBiQWN6MTVqL2d3bk5ERDJhdTI2dXFBTm5aSW1j?=
 =?utf-8?B?a0lSdnUreklNRmM4V0xHckZ1OXBaUTVuaHF2YjJXU1dZai91aVp1UThhdGxS?=
 =?utf-8?B?bUhKRW94dlZTRGtlN0pYMTBMYU52aFkwdjJ5dWFseGcvejRCRDhIbEZKOW1w?=
 =?utf-8?B?UjZoRXltVDY1Nlp2ZzdibWFqYjU1YTNzNjNybS9BUGpnTEdOdzJhVTVsckhJ?=
 =?utf-8?B?eC92U2U2bE1wdFNPbHRSWDZ6aHVHZ2pmMCtkN2Y4cm1qSUo3aHhydjNQYzZB?=
 =?utf-8?B?c1pIbk4vcmJlNTluODd4WUtya2dOVHFVbUkySUdvYVlJZThEN2JuYU9KOXZi?=
 =?utf-8?B?dFlUSktKdWRmbkNKSWRpSWp4VHgxa05UN1d5cTZhUEh2cG16UWd2czdVaXdN?=
 =?utf-8?B?QjJDTUg4MVpyOVhtOExBY1d1WDNZdDliVDY1b3JJTEh3dmFGdUpvTnRxTHBa?=
 =?utf-8?B?QVAwNEEwK1VMbUxGSSt1MHRETy8rS1RVOGhvTFlIZEFuZVFxQ1RXZVV1dzBN?=
 =?utf-8?B?Z1lqWi9DRElRYzhUTGVOcElRWWtmTkIwOE14N1FpVC9zSXhNR3lxTjJpUVZq?=
 =?utf-8?B?OVJ5dFM5NUZwWk11dHdRMlcwM09kbkhNcjcrTkkxWEY0WExaOFc3VjZ4QTJU?=
 =?utf-8?B?TEtITEdYKzN3M2dvdnd1N1NGZ2xSOTZ2cjRpN0xSaGRUMk1BOVdNajIwOFBw?=
 =?utf-8?B?YVB0WGIvZFBCaGZLNkh1bzI5b1piY252d011Y3ZteFdtUkZ0dExPMGRpRHBp?=
 =?utf-8?B?MnZyTnQ5VFJkU2pnVWt2MGRmNklQUjc1YkhHd1FHTkJLZnlEQzJ2a0FMa2tt?=
 =?utf-8?B?UkpFOTJvcW9aTXkwR2lib1dvTG9WZ1l1MTVpdC9vNGg2RnkyT2xkT2dnb1VE?=
 =?utf-8?Q?V73Y8vTRthg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR02MB7159.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yjc3QmNmMldZVmRXeHF3b3hXWUVhUmFkbXZLTUx6R0VhREJONkZRRVB1dWxE?=
 =?utf-8?B?NEJsbGE1V1pWT2ExcHR6dXIrNkxXbC81RDBaNWEwWEh4a1J6cUlLVUc3WEpi?=
 =?utf-8?B?Vm8xckcvSk9xd2NqMlJmQ2VEekZIN3BrbW1mUXREbFZxeVduSzh3UkRZYXg4?=
 =?utf-8?B?aHJTN3dkMG8vVkJ4NHVoeVgyTHdtdVZlSUtGY0NMQWRidmp1MWU4cEk4Z0VT?=
 =?utf-8?B?cFZnQUw3Z2UzbkZCYlpDQmpaSnBrSGUyVGk0TXRBbGZWekduZTZCcU5WRjYr?=
 =?utf-8?B?d3MrUHc3MVQra2FvT2RKL2h4eTN2OUkwdTZabnRGcG9aOGRwSnVBb0lMK0Nw?=
 =?utf-8?B?b1Nqem13azhtZHVoOHRTZENON3ZTRERjcTl6M3FrMGFvUUFkNnQ2RWNXdENj?=
 =?utf-8?B?Sk1xb1pZaHVCSEw3UmFQQXZLNEJ4NitGd1NhdnZBYlhYSmkwQ0haZ21DVkhU?=
 =?utf-8?B?MDRZbWpXbDJuWFd5cTNQTGI4dVZlVE41bGh3RU9paVJ0R3NLdGxLdllHNG9j?=
 =?utf-8?B?Qmk4aVVWREh4MHIzUGNsV2ZUaklhTmM5dVgyZXA5WVVjRE1sZVZXS1JEanp5?=
 =?utf-8?B?VDRxcWcvRzBiNE9GSkE1MGJCeW5RTkpwdEhkSnduWWx6cTRQa2JzdWUrTVRI?=
 =?utf-8?B?YkZCRG10SDhKZnFEUXRCaUtJU0dMeFpINk0yVmIxRnJWbkFobnAzT0tvMU5B?=
 =?utf-8?B?U0NEd3J6RllSb2paMnY1Q0lGNmM0R0RGVVAyNVJydXJvTThHZUZLcS9wZzRN?=
 =?utf-8?B?eURIOUxoa0lFWStoUTdIMEt2OFNkZkdvZllveGFEV1JTQ09yaDFzOTF4NldD?=
 =?utf-8?B?M21wUmV2bytZWXhRU3hDelNWaWJBYVBjVkVkb0VqYUVHTGNRakZWT1FOei9M?=
 =?utf-8?B?UVM5cFhYalBoZE5iaFkyQWhyQ2dDWkJpdkdqUXBjQXl1RUFyQk83cTRxYkdO?=
 =?utf-8?B?YndJcHBHS0w4Y1Y5bk9jeEJaNDBSWGV5VjVMa0FINDRPRENiM1pxUEtkdFp1?=
 =?utf-8?B?QVd0c3FMUzl5N0dxamJVWGVYbUJraHhoTlBYMWl4SWJIcDYzNm5QNm1UdUFV?=
 =?utf-8?B?eW52Uk1SeGlvNGNBSHJvdzMvTnBBZ0JZRFBQZUJLa3NrbDlwSXBqVDAwNnU0?=
 =?utf-8?B?WXZkRmczbVEra3g0STFpQzhnbjlSVWRCSXorRUtaUzJlREZQd0djY1RnUlZw?=
 =?utf-8?B?ZkF1QjhuN2Q4OFlSZE5Mc0VLOW5qY25KbGd2ZlNneUFtaVFEMWpRVGZuU2hy?=
 =?utf-8?B?TWwySmg0QnVJaUc0WnRRMmdRQWg0SitMQ3VTbUdQOG1NMUtnTjByZ1B0UnVR?=
 =?utf-8?B?WGRyeWNONkcweUVVVW1HWndCYkNPOU15Wjg5cFRUV05OU1dReDgwSEZpYWhY?=
 =?utf-8?B?Yld5NUNpamxhWHlLWFZ5SWxmL0Y4eWttQ203RjBaTnBBZVp5MnE3QzBMSFhm?=
 =?utf-8?B?ejhuOFVpRk9XWHpwYm9JTDJETFYrMkczclhKajJzN2hOdisxVGNPYmN4NHFR?=
 =?utf-8?B?TWdSc2FGS1lVQ01BZWpESVQzLzZ6aHJkQVJIZVZLSlJtNDJqek5wL0Z2VVlR?=
 =?utf-8?B?RWtWTytpVEtTWGJ0ZjZ6TUlLQzlKTE5UVHB4cnVORHhVK2pRK2I4YjByY3BN?=
 =?utf-8?B?SHR6a1MyUmFYc1d1ekw1RzZJZ3hQdkxRUStqaFErdWhuMkxIODVmZlhUYitj?=
 =?utf-8?B?ZGdmVTVadkwyRGxYVCsrUnFRcWNYaDRScnljajNnZXdyNXZQS0R1ajBBOFhR?=
 =?utf-8?B?bjZYbDFjb1p5NGJVa2EyUGJGc2dXcXlqRG4remdhc3RyZWxiNUZEUHQwbGlZ?=
 =?utf-8?B?Z1ZIRjFmWHhFbTkzbmxpL3FIOHdWeGRPNE9nRkZsV01pRktPZkkyc25IYkdT?=
 =?utf-8?B?VmsrbHFLMCtRNVg4MjhiY3p5YVFnU2RoVWs1MHRqNktaeHphOStxTUJVdzdM?=
 =?utf-8?B?WFhubVlWMG9kelhjaklad1IxZ0FHb1NwdDNIVkJwVVZBYm1EQ3lkdTRrME01?=
 =?utf-8?B?dVFsbENqWG5NVEVONTZUS1hWMHBpcVp2RndYVUY1RHBad08zQzdSS3YyOEtj?=
 =?utf-8?B?K0wxekIzcDY0ejhpaWJROENFVFY2eVIxTFpQSllrNGpXWHJ2SW8zSzRxRkhh?=
 =?utf-8?B?YVh0R0tIUFNOeENpVUk2L0Frck9yM0h1T3ZVLzA5N1RtZjNuUmJMdW1zTytH?=
 =?utf-8?B?L1E9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2cdf46-9ba7-42fb-4933-08dde1756981
X-MS-Exchange-CrossTenant-AuthSource: PH0PR02MB7159.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 12:14:15.5820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GjhJGTYD0A6UOVv6z7eC96WGxvH3CxEH6YQIu/ebqi6yAROkO6eWfqPJTQBID68GS7SHCNf8tgqizMJV0UKBKXlWKeZ5fokyuFEwtVYT6x8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7725
X-Proofpoint-ORIG-GUID: hJqLuYdOrRp_Jm7ceiu1DvbhOJipiB66
X-Authority-Analysis: v=2.4 cv=QLwxhgLL c=1 sm=1 tr=0 ts=68a85f19 cx=c_pps
 a=sXP4CBoXI4FFEMmoTRPjnQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=KKAkSRfTAAAA:8 a=XL6wrB0Zc_gxRR1ig4QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: hJqLuYdOrRp_Jm7ceiu1DvbhOJipiB66
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDExNCBTYWx0ZWRfX/zXBZaGr8Mwx
 b+DJGOWRi7T0rU6DQ8AldfTrSymdhsOuTlg82fYCoGmEwhAFxZ0QdQoh50sqQ0yPG3axEu34zeK
 3/LGn48lkeGOdSofCf2VSWQwLNGbTlDW4BXpgA97uko+stbJOdlG3DPX76CgA+7lyyXYEUCJwa/
 eD4iNhZSDin292tLuVY8fs3hXMhHHYVDWRokmGj0qToqWajIjqGUVk7ZxlJ7vDYdkro0QEu5WDf
 Bi0ryuOCR2xMOawDJYrajq106KIJr+YbbgBjmpFjm5xi+RC/t6zBsXaOwlXe7IR6FkqKaCgEmS+
 ahzW1G5lV3CE+NmXYwbnU77kX8xG0OmFZU3I2tpcp/njBWyZHVI4eR/DD718ZhcsdVoE2JajygY
 y9XClz506x9FNEHNE/Pjz7smyUKgyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12;
 envelope-from=mark.caveayland@nutanix.com; helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

NVDIMMs cannot be used by PCs from a pre-PCI era.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 129a3e2524..816124c027 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -592,12 +592,6 @@ static void pc_init_isa(MachineState *machine)
         }
     }
 #endif
-
-    if (machine->nvdimms_state->is_enabled) {
-        nvdimm_init_acpi_state(machine->nvdimms_state, system_io,
-                               x86_nvdimm_acpi_dsmio,
-                               x86ms->fw_cfg, OBJECT(pcms));
-    }
 }
 #endif
 
-- 
2.43.0


