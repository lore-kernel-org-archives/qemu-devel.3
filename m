Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028BCCA0EE3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 04:20:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjt7d-0002xe-TG; Fri, 30 Aug 2024 00:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1sjt7b-0002q7-IK
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 00:20:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1sjt7Y-0002B0-IK
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 00:20:27 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U2fgc3000961;
 Fri, 30 Aug 2024 04:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=TA3a2oO+5g9s7sVLvP6QaWeeUmAI/ze1giJwcgwDCic=; b=
 YqlsdWBj1tgD9eFs9RMInC0Y9UCJ0+U0+FYfBeBd4E6pj33CrmMHQ3E7DwWhvT6U
 usYQKVF/9XBqwEgPTLjHMYn6mHRsT+gPxUd912iSt4B4FA5K34tiqBwA2MiipeXa
 NLp+C2PoGAn/YStkO6kwj4jFibn67ryWMLZ0dXo1LRAEYkUXnjAxizHJ7u63kIyi
 lUGRryxjxJKTjw3wHnwwIqWcPtefjA8Hf0yAQlv8qjbN1h+qN49VTxA94pLYb1Z5
 CnFDrCE+tiSs4X8ImAuD0DDVyGCwICjffiE2bBOvt9svijzLMPZVNi7qdSDsaLLV
 VJLU5GsYmUn0QpzvS4dkHA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41ax0grs1u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Aug 2024 04:20:20 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 47U2wnIF034791; Fri, 30 Aug 2024 04:20:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4189swv245-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 30 Aug 2024 04:20:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDDVqWQWixpgpqLe+9+MMOj/JAvy8tUafF/QGssu9Y+kXlv1FUiQFqg6Lrshy2d64+KT4eLE+lMiHFbHtSZwVuXrD3ys9S2Sm+2mfVM/7GBSuh54pZ2olwja0E8nv6XvpC5KvMKxHRAswUsTLUErp1T4g6UXD2EFSBqjrjR2eQCaHg2P1bdsfyADnKtoHsUIhj993aEJvZdhSf8mMOdVd9pRXvRgzs26vbU4FJzPzD5vogNAMivQLTxj+TmOwR1TLzEld2uLR7O2oDUHFFEMGctO12fzBskDPEVdD/ccXdPR3or+WqQkAW5iTx+sPGwMbAeYB/9EV9TR2S6W3rzYlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TA3a2oO+5g9s7sVLvP6QaWeeUmAI/ze1giJwcgwDCic=;
 b=jHWiTqVSMx1hRdGqxaQ0bjKl29ofwNnYmrCNHdzeUsRjhZOs2vppYiBaOjU4giUoHbK1q9cx+rLQ6qpDxd4voDFQ7t1V5883CqlFLQWUEaqM1ys+yHL6MUm19J9eaQo5u3klvcxow6lKbKHZJMnwLg3P8xgcugHNAt+LKQKXd78A4O3lNMCwoKO7QibW25W+ewpmKQhFPP7LYZDpgF/xnnWaDOf0qRxJZzhT7Uzijl0Dk1xsW7FBUViViyXOYEcSB07mggV5/zixZcGdJVuy+JULiaMFcIsQegjOxAqj8/gS6wpcjwwoY3G0lJl1ng4eV0Ao68HBNzf3nwXfrO5YuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TA3a2oO+5g9s7sVLvP6QaWeeUmAI/ze1giJwcgwDCic=;
 b=Y3Pmo78kg198YpB2ZADxgs/OM0t/YH5pcW4wL4QkEx65gqpW231Kx1BJVRMC6UrdMGpUdf5Aw3z6q7zkqxbqYHTgYJNzX5DmQbB7C6fxaeX7dWSE/K+jbCaPz7BcPRh8zR1x4QOtmORmDC3HxwFC4UjHxD/InnbNpzYtNol3H34=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CY5PR10MB6070.namprd10.prod.outlook.com (2603:10b6:930:3a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 04:20:16 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86%4]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 04:20:14 +0000
Message-ID: <436fc148-d1ac-17be-09f4-e776661c534a@oracle.com>
Date: Thu, 29 Aug 2024 21:20:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC 1/2] vhost-vdpa: Decouple the IOVA allocator
Content-Language: en-US
To: Eugenio Perez Martin <eperezma@redhat.com>,
 Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, leiyang@redhat.com,
 peterx@redhat.com, dtatulea@nvidia.com, jasowang@redhat.com,
 boris.ostrovsky@oracle.com
References: <20240821125548.749143-1-jonah.palmer@oracle.com>
 <20240821125548.749143-2-jonah.palmer@oracle.com>
 <CAJaqyWegFi5h56HQ2Ga5BsJ-UwMmxF5rQujE6ZAYJKEZaRy65w@mail.gmail.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAJaqyWegFi5h56HQ2Ga5BsJ-UwMmxF5rQujE6ZAYJKEZaRy65w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:74::23) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CY5PR10MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ccc34ea-8477-4729-0498-08dcc8ab0be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Qm5pbXRYK1Nsd1pxTER1eW1uOWIwMy9HRjgvZy9HU3JRMlE2eS9jb1l3ekQ5?=
 =?utf-8?B?YW1MVlcyQXhtaU5RVFBpNEJTTllOMjZNenMzdDRkZkN5bXpjSkE3OVJXM2p1?=
 =?utf-8?B?ZDZUbCtCcTFtdWdKZjFBVHBMTjZiL0Q4YnZ5QzlJbENKVUdHbUNPWnFLOHNH?=
 =?utf-8?B?NjFuRk1TOXo1SUV6eTlqM0tPVmtwRGhjM1lXaVdEM2pDc3pPejA4OTk3Q0pL?=
 =?utf-8?B?Yk9pV2dhOFd2dGpJYXd3SmZBR3pUWEs0VythOXY3dlV1Q3FJeHMxaHJ4SjA3?=
 =?utf-8?B?d0RBcGNoR3JxNUVsUm9mUEpBbDFQbUI1Ynh0YWJndzhyV2hKekdOOFRlT01l?=
 =?utf-8?B?c0dXSmhnLytXNU5oamZRWUxkNUJ5bEk2cmVNUDRxa0lidVgrTllWYjJSaXBu?=
 =?utf-8?B?Sk1OWEhES3h4eWRaOXhrME0xVzFnSWJlaENYVE52SDQrSEJkK0pjKzJhd1d5?=
 =?utf-8?B?ZXQ5VUZRTlBMVk5hcTJDSHEyNEErMWcxalRhNzVTYjEwbmZsWks2S055Q1FI?=
 =?utf-8?B?bFpmK0pCUHUydTVCeXArTENGNUhFVXllUmloVFlzTUQrYlMwNHhacHVtRm5T?=
 =?utf-8?B?dERIVHEwa0d4cTUwSktYQjJ0WCsvR0FMWXJDczh2VEVRSzN2bGQwVm05cExx?=
 =?utf-8?B?VmhvK05jbHpHYmRwcDBsYVljVm85MTByMTBJeFU0N1hlcWl3S296Z0VacHNN?=
 =?utf-8?B?UEFTZFJXOVhlWFhMWWpqUjljZ3RNRGtYcCsya3J0THltNWtwU3VkdlBpUFVr?=
 =?utf-8?B?SEY5SGh0Zk1NMVAxZUU0YlBNVFZHSkVkZXNyazgwQ3Zza1RabGJQenU3Nm1w?=
 =?utf-8?B?b3FLbzJEY0dKT3plT1Q5TkdRYlhjL2hWU1VlL3NjTXZlUVUyU2VZQUlzS2Y3?=
 =?utf-8?B?V2x6WmFCSUcxRHJRZjNyNjErcEpYU2YrWkU1clMvUy9XZTdGam5XSjRidTMr?=
 =?utf-8?B?cVFuK3FxTVN1RitqU0Y1NWczaTlSbDI3TjVXY29pMGpOZ0NzOFNSb1RHSmJ2?=
 =?utf-8?B?MFNSQkhXL2lBMUN6T3VjVTZoS3FPZXlQQ3hZMFlrL2xoK1N0YURtdGRBWTVv?=
 =?utf-8?B?cFBNNTYrL2Q1a3hXbzMxSnR0ZDByWTg3blg3elU4UUhGcWRrMlA1TThrUDVB?=
 =?utf-8?B?U3drT2lmbGFabzVMVlUwNlVvaXhGcjhZMmRkU3BmSmxiTXlqVWg4RFUzV2I3?=
 =?utf-8?B?dzNlMTB1UGxzMzY4S09Uc2dZa1lGWi9MWEU0dWFXNi9HdVkvMVZETU1yWGhW?=
 =?utf-8?B?ekRiZTNYak8wZXhYMzd3M0psbW5oRnJWREtVcTFLRmI3bldITzJNVElZd0pu?=
 =?utf-8?B?VjRBQmllblZVOEpMblI2QXNjdVQvQWtOSkthdS9heWh6RkYyNTFCQzIyU04v?=
 =?utf-8?B?cXJ6RWRVOUNtYlY1QUdyRnkyOFpMZHZ6R1prdEpLUkxKYXNlUUx2UURiMllp?=
 =?utf-8?B?YTBFL0g2ZVVYT3JYQUN3bGpXL1BjUTNsSENoaS9JcnFBNk9PdUJBOUJadGpp?=
 =?utf-8?B?ck1XYmtkLzM3SmMyVHZyWFdoOFgwRGdycG40dVkxWEJONXhXRjM3VEVOU1NR?=
 =?utf-8?B?MDVXOUFzTkg2VTY0d3lWRDFQUVdqSkdnQVA0QUphVytVQU5nUEFaMHBuVzBI?=
 =?utf-8?B?REd6RTQ0cVcxTnAzaVZqKzFiaVBwaWw0NE9hRWhHZkU2cjk0bUlxZUM3YXpt?=
 =?utf-8?B?eVgxV3gvZ1VmbDg1TXpLSko1OUNGdFdwM3orMm92V01Fck1VMTErN1dSM2Nu?=
 =?utf-8?B?MDN6SGlrQkNaMlRJNDJRS0s5SjlycnBiRUJOUHh4VEZQWFR1U3QvTEtxRFFH?=
 =?utf-8?B?OTJUT2xyOTY4Q2ZjQm9kZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0hjdk5oWDZScmZhY0tJNVVnVDMwcHNvQ1JVeVQyS2NuN1h3dS9CQ1ZZYWR5?=
 =?utf-8?B?WmprbVhLSmpWVUJMb284TzNueFVkUEhVV3JxSWwvMmZDRVcwVERqbGt5ZmJi?=
 =?utf-8?B?SVVQYWRtaEVyTG5BdDBKQ282MmRNVU9lcXdLQlU3YTNtSVp5R1IvN1h0dThT?=
 =?utf-8?B?TGs5akUvQWNvZ29rd1pJTGFVc1cxYTFJbDIxWXp3WWlhRzlQTnVFNVdnOTVj?=
 =?utf-8?B?MWRDdE1FVFlqZ2hwL2FkbHpiWjhET3FtUmtLSmhJc2thNXJlWk13MDRKVXJl?=
 =?utf-8?B?NDNMT0g4bHZHRjdPd0JiRXJEelREeDhkcEVzQ0pXWVJicmdVdzBsZ1JPb3hJ?=
 =?utf-8?B?UE5ka3dFeXRINWZEOEFYREV0TU56dGtuUTRib1A3Q01sZUt5eTFYM3hjT0Vx?=
 =?utf-8?B?NHk5Q1ZjZGxlRG9IYVNZd3plWEVzNTFzRGhHMEU2aXZ3eGRZMzhjY3VpeS9y?=
 =?utf-8?B?Ym8zbWhoUFR0MzdpeUxsY3BEOTBEZkVvalkzYUtGbzVmNTBjeHpqVXRFS0hY?=
 =?utf-8?B?bVZmcFJ3enlvU1JiL1FsWllkcnlWSlFoV05rRVM3QktTTDhLMGxnbmdFZVdG?=
 =?utf-8?B?QkxZN0RPRlNUMEVYRFVpS0xRbWJmMUdibUNQb0N0S3N0NWZRbk02NXZKL09S?=
 =?utf-8?B?TndzTEZ4Ky9rMjRYdjBQSDVBbmwraUw4bmFXeHlMc0wwZ1phSTBKaWt2YXNW?=
 =?utf-8?B?U09TcVN4LzVFbHhmWTh0enlUTnN2azRJbk9lMlc0bUcrWDJKYlRwZFBsTkFo?=
 =?utf-8?B?RzJ5WU1VcllNQ2oyTlU2dVJiS01kR3BLMkVoUlQ2RnY0OHRrTVpBWk1rb3Iw?=
 =?utf-8?B?alM1bzNua0hpVVNLK2J4WWlUdlRCcVIvT0E1ZEQxN1VRdC9TZWxUWEFQVDYv?=
 =?utf-8?B?ZzZQOVRKdjUxVE03ajlsa2psZUdMMHZxQ0x3R1pPWVppS29ITXNCTWxkcVJi?=
 =?utf-8?B?cFh1clQzYzBiQWJDTGszRDQ0ajdsSXZDelNveWRGNFJIWXk0c05sSTQwOURs?=
 =?utf-8?B?UFJMR3hTVmRmbjJuaE13WS9DUkliVGxQdDdMNFBDU04xUjd6Um1ObEYxZFF1?=
 =?utf-8?B?SlhRQzdYTWVyUVBaUEhWeWdmK1FFcUppRWJCR1FwampQa0ltRWNheHVpVHhB?=
 =?utf-8?B?SHVVWGdLV2k5WEdIS3Y2bkhDTUhCWG9OemNUMFNDTndOdVkzS2taYVhiekVv?=
 =?utf-8?B?Zysza1dhS2tPemhWK2s5S2k3bUhSMjVndU5XOTZYaXd6emVVejV2VUxPM245?=
 =?utf-8?B?cTNLZk43cktvYzNYRXRmSlZVdk11eStxdVdURmtoVExPTHI0TE1ZL2ttb1Ry?=
 =?utf-8?B?VVZCVkVOUnlza0dWU2QrSnV2a3o1T3FpVWJUOWk5U2Y5ZThhTmk2QkdpN2FS?=
 =?utf-8?B?QU85RnV2Vk9KTG5XTVAzaCt6a2tadDhUWHBTajFaM1p6V0JUanovYWwwcHVk?=
 =?utf-8?B?Ym9nU0o4MEdhc0pQQSt6T3UzbzFHYnd6RHdpeHd3ZFFqZGN2ekdoQkRpd2ZH?=
 =?utf-8?B?NGxUVXJxVC9NbHpHdGgxV0xqL3NzeG96ek9mTEY0K0R0STVtZXF4Z0lxcnlP?=
 =?utf-8?B?WUJHSGhtL1hUeTdTOGRTdmtCOGNKWkJNd0k5M2QzOW9SR08zdnhQWWNQVGsv?=
 =?utf-8?B?STZqYVIxOFhRT2M1aHlCWkZaVmM4eWZxWVE1N0xCSFdLckU5TkRYc3VQVlFz?=
 =?utf-8?B?N3pCZ3FKOHFyamttT1J5L1Rxd01QRTB3VTlzM200Z1ZyZkdNM1loT2lWZHZM?=
 =?utf-8?B?OFFtV1NmcDJHL1kzR0dUVTRSa1YwN2k3aXN2ZGU1N1FoU3dnVjJCWVZzYlBw?=
 =?utf-8?B?K2g0aEk0RHBiNlE5T0FxaTFYYUp0TVpPUnRSakVMMUxkMkFSck1sek1xYUNj?=
 =?utf-8?B?cG0wWjdyd0FFdkJ4ZDVvYVEvZUw4QjZBdTZRQjdKQktPRFFmS043bXBTZ3Zt?=
 =?utf-8?B?S29RQUp5RDYxVHVkNzdVeUVzS0JHSjMvNkY3SXlMK211Q0hNMWMxR1EwSnY4?=
 =?utf-8?B?K0pPaklEQ3RpN1RKbE1xU3FNUTkxOHhXU2tiR1VlakhRZXdjcXBRejVUZ1l0?=
 =?utf-8?B?eVp5M3Z0Mi9iK1BEWkZwWk5hTXZlS3Z5eHVKN1pZYmM5VEhkUklnRGd4em0v?=
 =?utf-8?Q?UsLawACKdb3G5HiEhvb+YsNyu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hn5j6qoF1joKn3fPj1R5X+c98xYUSlH1OLyOp4eqOccBnl/hAG3c9lvQaDrTj/xcQccQgNigNOlS3JDCpbGBtpIsTnHPeZRI2wqe5p8zWsvfTxJQs8mOlW+cVnJfh+RJ6dA5n53yVXvzZ6MTwacHaeVfDsUX9b65XPIEi7XVEkti75JyjYfAcqlo8YoEhNj341hbsnvvxkYtczsnghwNM1MRt2u5xc7PHOpHtHc8vBWswz48GEeJ6eFFd3u2SbgvzGlXjbYZqV83IP6vX1qMYQyTyUogAMxv4LU8d61rxM7wLUl767QmfwJkMpXayDomnLn6OFu79X5LqJgcZceEhGYmaAN06zDoYmiIBbaM0KldT79Tsmk3b5cx903gVAm1jr/jRfl9Deb9OApeDZ1yVd/y9GcfGTdhasO/ApR8HWznnH69dx8NrzYC71MqCw1vrnTmYD97GgVobZYSu57EoHkyj8/PeZSg7VhZ0Mb2WC/mWPQvZsq7BgOfDcI1Zc4FiGiVWR5KNjXiU7SXrV/unsHM7QP5pWhud2FqvBr8V2oWaJksOTose2shIW+bQqWh4QRqD6dgRsN2KTsQ/h5XsdW37stAvNcGu/Z8iwC3B10=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccc34ea-8477-4729-0498-08dcc8ab0be4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 04:20:14.5557 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d71zdw/XyLd+NXNeVIN+Hnf2G21t2o/BDfrm6UcM+WpOpX4Le5MzS5kkyzCSQskx7BtJ0kd3/6VQg3oul64nsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6070
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300029
X-Proofpoint-GUID: Ovu_w2eYVbkpkDJ6-HCsWcLY30JklZmt
X-Proofpoint-ORIG-GUID: Ovu_w2eYVbkpkDJ6-HCsWcLY30JklZmt
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.084,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 8/29/2024 9:53 AM, Eugenio Perez Martin wrote:
> On Wed, Aug 21, 2024 at 2:56 PM Jonah Palmer <jonah.palmer@oracle.com> wrote:
>> Decouples the IOVA allocator from the IOVA->HVA tree and instead adds
>> the allocated IOVA range to an IOVA-only tree (iova_map). This IOVA tree
>> will hold all IOVA ranges that have been allocated (e.g. in the
>> IOVA->HVA tree) and are removed when any IOVA ranges are deallocated.
>>
>> A new API function vhost_iova_tree_insert() is also created to add a
>> IOVA->HVA mapping into the IOVA->HVA tree.
>>
> I think this is a good first iteration but we can take steps to
> simplify it. Also, it is great to be able to make points on real code
> instead of designs on the air :).
>
> I expected a split of vhost_iova_tree_map_alloc between the current
> vhost_iova_tree_map_alloc and vhost_iova_tree_map_alloc_gpa, or
> similar. Similarly, a vhost_iova_tree_remove and
> vhost_iova_tree_remove_gpa would be needed.
>
> The first one is used for regions that don't exist in the guest, like
> SVQ vrings or CVQ buffers. The second one is the one used by the
> memory listener to map the guest regions into the vdpa device.
>
> Implementation wise, only two trees are actually needed:
> * Current iova_taddr_map that contains all IOVA->vaddr translations as
> seen by the device, so both allocation functions can work on a single
> tree. The function iova_tree_find_iova keeps using this one, so the
I thought we had thorough discussion about this and agreed upon the 
decoupled IOVA allocator solution. But maybe I missed something earlier, 
I am not clear how come this iova_tree_find_iova function could still 
work with the full IOVA-> HVA tree when it comes to aliased memory or 
overlapped HVAs? Granted, for the memory map removal in the 
.region_del() path, we could rely on the GPA tree to locate the 
corresponding IOVA, but how come the translation path could figure out 
which IOVA range to return when the vaddr happens to fall in an 
overlapped HVA range? Do we still assume some overlapping order so we 
always return the first match from the tree? Or we expect every current 
user of iova_tree_find_iova should pass in GPA rather than HVA and use 
the vhost_iova_xxx_gpa API variant to look up IOVA?

Thanks,
-Siwei

> user does not need to know if the address is from the guest or only
> exists in QEMU by using RAMBlock etc. All insert and remove functions
> use this tree.
> * A new tree that relates IOVA to GPA, that only
> vhost_iova_tree_map_alloc_gpa and vhost_iova_tree_remove_gpa uses.
>
> The ideal case is that the key in this new tree is the GPA and the
> value is the IOVA. But IOVATree's DMA is named the reverse: iova is
> the key and translated_addr is the vaddr. We can create a new tree
> struct for that, use GTree directly, or translate the reverse
> linearly. As memory add / remove should not be frequent, I think the
> simpler is the last one, but I'd be ok with creating a new tree.
>
> vhost_iova_tree_map_alloc_gpa needs to add the map to this new tree
> also. Similarly, vhost_iova_tree_remove_gpa must look for the GPA in
> this tree, and only remove the associated DMAMap in iova_taddr_map
> that matches the IOVA.
>
> Does it make sense to you?
>
>> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
>> ---
>>   hw/virtio/vhost-iova-tree.c | 38 ++++++++++++++++++++++++++++++++-----
>>   hw/virtio/vhost-iova-tree.h |  1 +
>>   hw/virtio/vhost-vdpa.c      | 31 ++++++++++++++++++++++++------
>>   net/vhost-vdpa.c            | 13 +++++++++++--
>>   4 files changed, 70 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
>> index 3d03395a77..32c03db2f5 100644
>> --- a/hw/virtio/vhost-iova-tree.c
>> +++ b/hw/virtio/vhost-iova-tree.c
>> @@ -28,12 +28,17 @@ struct VhostIOVATree {
>>
>>       /* IOVA address to qemu memory maps. */
>>       IOVATree *iova_taddr_map;
>> +
>> +    /* IOVA tree (IOVA allocator) */
>> +    IOVATree *iova_map;
>>   };
>>
>>   /**
>> - * Create a new IOVA tree
>> + * Create a new VhostIOVATree with a new set of IOVATree's:
> s/IOVA tree/VhostIOVATree/ is good, but I think the rest is more an
> implementation detail.
>
>> + * - IOVA allocator (iova_map)
>> + * - IOVA->HVA tree (iova_taddr_map)
>>    *
>> - * Returns the new IOVA tree
>> + * Returns the new VhostIOVATree
>>    */
>>   VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>   {
>> @@ -44,6 +49,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>       tree->iova_last = iova_last;
>>
>>       tree->iova_taddr_map = iova_tree_new();
>> +    tree->iova_map = iova_tree_new();
>>       return tree;
>>   }
>>
>> @@ -53,6 +59,7 @@ VhostIOVATree *vhost_iova_tree_new(hwaddr iova_first, hwaddr iova_last)
>>   void vhost_iova_tree_delete(VhostIOVATree *iova_tree)
>>   {
>>       iova_tree_destroy(iova_tree->iova_taddr_map);
>> +    iova_tree_destroy(iova_tree->iova_map);
>>       g_free(iova_tree);
>>   }
>>
>> @@ -88,13 +95,12 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map)
>>       /* Some vhost devices do not like addr 0. Skip first page */
>>       hwaddr iova_first = tree->iova_first ?: qemu_real_host_page_size();
>>
>> -    if (map->translated_addr + map->size < map->translated_addr ||
> Why remove this condition? If the request is invalid we still need to
> return an error here.
>
> Maybe we should move it to iova_tree_alloc_map though.
>
>> -        map->perm == IOMMU_NONE) {
>> +    if (map->perm == IOMMU_NONE) {
>>           return IOVA_ERR_INVALID;
>>       }
>>
>>       /* Allocate a node in IOVA address */
>> -    return iova_tree_alloc_map(tree->iova_taddr_map, map, iova_first,
>> +    return iova_tree_alloc_map(tree->iova_map, map, iova_first,
>>                                  tree->iova_last);
>>   }
>>
>> @@ -107,4 +113,26 @@ int vhost_iova_tree_map_alloc(VhostIOVATree *tree, DMAMap *map)
>>   void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map)
>>   {
>>       iova_tree_remove(iova_tree->iova_taddr_map, map);
>> +    iova_tree_remove(iova_tree->iova_map, map);
>> +}
>> +
>> +/**
>> + * Insert a new mapping to the IOVA->HVA tree
>> + *
>> + * @tree: The VhostIOVATree
>> + * @map: The iova map
>> + *
>> + * Returns:
>> + * - IOVA_OK if the map fits in the container
>> + * - IOVA_ERR_INVALID if the map does not make sense (like size overflow)
>> + * - IOVA_ERR_OVERLAP if the IOVA range overlaps with an existing range
>> + */
>> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map)
>> +{
>> +    if (map->translated_addr + map->size < map->translated_addr ||
>> +        map->perm == IOMMU_NONE) {
>> +        return IOVA_ERR_INVALID;
>> +    }
>> +
>> +    return iova_tree_insert(iova_tree->iova_taddr_map, map);
>>   }
>> diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
>> index 4adfd79ff0..8bf7b64786 100644
>> --- a/hw/virtio/vhost-iova-tree.h
>> +++ b/hw/virtio/vhost-iova-tree.h
>> @@ -23,5 +23,6 @@ const DMAMap *vhost_iova_tree_find_iova(const VhostIOVATree *iova_tree,
>>                                           const DMAMap *map);
>>   int vhost_iova_tree_map_alloc(VhostIOVATree *iova_tree, DMAMap *map);
>>   void vhost_iova_tree_remove(VhostIOVATree *iova_tree, DMAMap map);
>> +int vhost_iova_tree_insert(VhostIOVATree *iova_tree, DMAMap *map);
>>
>>   #endif
>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>> index 3cdaa12ed5..6702459065 100644
>> --- a/hw/virtio/vhost-vdpa.c
>> +++ b/hw/virtio/vhost-vdpa.c
>> @@ -361,10 +361,10 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>>       if (s->shadow_data) {
>>           int r;
>>
>> -        mem_region.translated_addr = (hwaddr)(uintptr_t)vaddr,
>>           mem_region.size = int128_get64(llsize) - 1,
>>           mem_region.perm = IOMMU_ACCESS_FLAG(true, section->readonly),
>>
>> +        /* Allocate IOVA range and add the mapping to the IOVA tree */
>>           r = vhost_iova_tree_map_alloc(s->iova_tree, &mem_region);
>>           if (unlikely(r != IOVA_OK)) {
>>               error_report("Can't allocate a mapping (%d)", r);
>> @@ -372,6 +372,14 @@ static void vhost_vdpa_listener_region_add(MemoryListener *listener,
>>           }
>>
>>           iova = mem_region.iova;
>> +
>> +        /* Add mapping to the IOVA->HVA tree */
>> +        mem_region.translated_addr = (hwaddr)(uintptr_t)vaddr;
>> +        r = vhost_iova_tree_insert(s->iova_tree, &mem_region);
>> +        if (unlikely(r != IOVA_OK)) {
>> +            error_report("Can't add listener region mapping (%d)", r);
>> +            goto fail_map;
>> +        }
> I'd say it is not intuitive for the caller code.
>
>>       }
>>
>>       vhost_vdpa_iotlb_batch_begin_once(s);
>> @@ -1142,19 +1150,30 @@ static void vhost_vdpa_svq_unmap_rings(struct vhost_dev *dev,
>>    *
>>    * @v: Vhost-vdpa device
>>    * @needle: The area to search iova
>> + * @taddr: The translated address (SVQ HVA)
>>    * @errorp: Error pointer
>>    */
>>   static bool vhost_vdpa_svq_map_ring(struct vhost_vdpa *v, DMAMap *needle,
>> -                                    Error **errp)
>> +                                    hwaddr taddr, Error **errp)
>>   {
>>       int r;
>>
>> +    /* Allocate IOVA range and add the mapping to the IOVA tree */
>>       r = vhost_iova_tree_map_alloc(v->shared->iova_tree, needle);
>>       if (unlikely(r != IOVA_OK)) {
>>           error_setg(errp, "Cannot allocate iova (%d)", r);
>>           return false;
>>       }
>>
>> +    /* Add mapping to the IOVA->HVA tree */
>> +    needle->translated_addr = taddr;
>> +    r = vhost_iova_tree_insert(v->shared->iova_tree, needle);
>> +    if (unlikely(r != IOVA_OK)) {
>> +        error_setg(errp, "Cannot add SVQ vring mapping (%d)", r);
>> +        vhost_iova_tree_remove(v->shared->iova_tree, *needle);
>> +        return false;
>> +    }
>> +
>>       r = vhost_vdpa_dma_map(v->shared, v->address_space_id, needle->iova,
>>                              needle->size + 1,
>>                              (void *)(uintptr_t)needle->translated_addr,
>> @@ -1192,11 +1211,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_dev *dev,
>>       vhost_svq_get_vring_addr(svq, &svq_addr);
>>
>>       driver_region = (DMAMap) {
>> -        .translated_addr = svq_addr.desc_user_addr,
>>           .size = driver_size - 1,
>>           .perm = IOMMU_RO,
>>       };
>> -    ok = vhost_vdpa_svq_map_ring(v, &driver_region, errp);
>> +    ok = vhost_vdpa_svq_map_ring(v, &driver_region, svq_addr.desc_user_addr,
>> +                                 errp);
>>       if (unlikely(!ok)) {
>>           error_prepend(errp, "Cannot create vq driver region: ");
>>           return false;
>> @@ -1206,11 +1225,11 @@ static bool vhost_vdpa_svq_map_rings(struct vhost_dev *dev,
>>       addr->avail_user_addr = driver_region.iova + avail_offset;
>>
>>       device_region = (DMAMap) {
>> -        .translated_addr = svq_addr.used_user_addr,
>>           .size = device_size - 1,
>>           .perm = IOMMU_RW,
>>       };
>> -    ok = vhost_vdpa_svq_map_ring(v, &device_region, errp);
>> +    ok = vhost_vdpa_svq_map_ring(v, &device_region, svq_addr.used_user_addr,
>> +                                 errp);
>>       if (unlikely(!ok)) {
>>           error_prepend(errp, "Cannot create vq device region: ");
>>           vhost_vdpa_svq_unmap_ring(v, driver_region.translated_addr);
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index 03457ead66..81da956b92 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -512,15 +512,24 @@ static int vhost_vdpa_cvq_map_buf(struct vhost_vdpa *v, void *buf, size_t size,
>>       DMAMap map = {};
>>       int r;
>>
>> -    map.translated_addr = (hwaddr)(uintptr_t)buf;
>>       map.size = size - 1;
>>       map.perm = write ? IOMMU_RW : IOMMU_RO,
>> +
>> +    /* Allocate IOVA range and add the mapping to the IOVA tree */
>>       r = vhost_iova_tree_map_alloc(v->shared->iova_tree, &map);
>>       if (unlikely(r != IOVA_OK)) {
>> -        error_report("Cannot map injected element");
>> +        error_report("Cannot allocate IOVA range for injected element");
>>           return r;
>>       }
>>
>> +    /* Add mapping to the IOVA->HVA tree */
>> +    map.translated_addr = (hwaddr)(uintptr_t)buf;
>> +    r = vhost_iova_tree_insert(v->shared->iova_tree, &map);
>> +    if (unlikely(r != IOVA_OK)) {
>> +        error_report("Cannot map injected element into IOVA->HVA tree");
>> +        goto dma_map_err;
>> +    }
>> +
>>       r = vhost_vdpa_dma_map(v->shared, v->address_space_id, map.iova,
>>                              vhost_vdpa_net_cvq_cmd_page_len(), buf, !write);
>>       if (unlikely(r < 0)) {
>> --
>> 2.43.5
>>


