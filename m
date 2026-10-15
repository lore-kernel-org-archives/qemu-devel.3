Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB49FCC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:42:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHLio-0007WF-9X; Thu, 15 Oct 2026 09:42:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1xHLik-0007Vj-Uw
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:42:12 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.vrabel@nutanix.com>)
 id 1xHLig-0008Cg-5m
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:42:10 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F9jLMe4078066; Thu, 15 Oct 2026 06:42:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=zfTg9LjwfWrA8gZqGszowmxawt+2gOY/pZ4+mBF/H
 Vw=; b=V2vRYRUAsDfPDVPfp9rSqiJIng/tRE29JNWq0xIm1VktkTQbOVXeq/npY
 g88GUCR5FIEAOAURT3gQzkhNNk/85LkehFdqJ+h2tPjSRSJL3vkmB9LWDj2iMXCX
 IssMZvz1kZtdkd4THqrfeDAwrDJUSu1bE59huYM0HkytD68QxqDNpIsSoJ61BhE1
 MN/sMZ0Yy7G9RDDp9moq3GndyzYYFiWCvYE7k1CqNuKOdix1vEeRQVf5eiwBNsgw
 jO/TQDzKc4NnGr37jBO4sxoYaXu8SrruBPmeVjx2PRgwXNpcoaW75a/ctuA3ajEC
 dI7s86Xv0lvZYg+wnJuL1BoEhGa8g==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020119.outbound.protection.outlook.com [52.101.201.119])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4habw5auxd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 15 Oct 2026 06:42:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gC5kUhHcG2759ugRkNicV933QpTAhflyEA5sL+8tfiJF5yhsiUfgPvGU6uGPK6F8Qn3WilockqgOQo8gqI6fdWfvzeE2UQ8LzmgwodM8GE2JvJaURONyd059KQMk85zEn5z0p6pBmaViJ3AbyYHxgrbu8EFjr8QncNcZ6SGKU5Fvd73rSXg8eIfM7QFL0gwc9WbTnglfgh5qvDGf9sip8v1TPAk9o891vj3ylGHCIPEfOt+0rSAKg6UUz7uYqSffRIjrUbYw7YhPX8aVTID3WIMmCGYQYIG/e17vLrSQqAIuxeQX7UOVkseEI6XDg2YnMjY3u0s8+hSXuyt1JcRcyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfTg9LjwfWrA8gZqGszowmxawt+2gOY/pZ4+mBF/HVw=;
 b=bId6hlblsA4NOeKGkNK08gN0tWY9ydiw1/1Qt0fGKEZVFVX3Jgkn5mnJwU8hymItxGXd7EONnjIvSzEe2RJbz5mclu1LHlFBzQbITDHorcbklPrwUcop5GJU5K1LbXQOFvzj+W8HRyVnK4eBxbSDE7CVabxMzg3qQZ+HoSa7MH/35OsCScId54+rjNGvknJrEQeIm1vbIKFlCjrDwjWACQR4t8bNP1b5kIluspPx2joKCsBX44m5q7dcylrqqjF3FJCon/wMw7LvEcYeJwPU8AAQcC6PzkpgI4hMqghShOTbjiUWBqVCmaPf4kmAZK4rop5rzuo0oHc4MH1bGOhVuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfTg9LjwfWrA8gZqGszowmxawt+2gOY/pZ4+mBF/HVw=;
 b=PW+ioK3J6+5FrvGQ2lMtNCyNIg7LRtNOe+UhZI2tL29duPHjn2cECqKpmKCBQdmg6sYNWV34FVFyC/4FVtFeSZDy5eiEJL/gc4T3iupi4emRH6Wj5DdUzzhFhuG4AxnMWXCwxW5VEBkIBX2afJdPBZVCI9iTbCos0B9P6pLVLqRbDu3xnb5iOwEPkW393f+hZoDDw2ZBM/vQ59bcG2xBHRVyK0YLlGOTxYAYfXM9JnMj2HCE0WPg/1mjZh9ypg/qyS1xh/oTCa3NcBY+y551iIfgnkQPz2D7nrZtJC91yVsfXw8ff+XNPaP3xSUXQbdsAG4aWoFB6bdiDJARCd7EkQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nutanix.com;
Received: from SA1PR02MB8368.namprd02.prod.outlook.com (2603:10b6:806:1f3::18)
 by DS7PR02MB9549.namprd02.prod.outlook.com (2603:10b6:8:ea::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.23; Thu, 15 Oct 2026 13:41:58 +0000
Received: from SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2]) by SA1PR02MB8368.namprd02.prod.outlook.com
 ([fe80::6ac6:4d2c:c37f:5dd2%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 13:41:58 +0000
Message-ID: <6fa1a07f-afbb-4c65-85e0-ddcebd9bddec@nutanix.com>
Date: Thu, 15 Oct 2026 14:41:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] hw/pci-bridge: Configurable apparent bandwidth for
 the PCIe topology
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260928152431.310363-1-david.vrabel@nutanix.com>
Content-Language: en-GB
From: David Vrabel <david.vrabel@nutanix.com>
In-Reply-To: <20260928152431.310363-1-david.vrabel@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0126.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::23) To SA1PR02MB8368.namprd02.prod.outlook.com
 (2603:10b6:806:1f3::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR02MB8368:EE_|DS7PR02MB9549:EE_
X-MS-Office365-Filtering-Correlation-Id: 887cc563-b797-42cd-3d8a-08df2ac215ad
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|5023799004|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jb7MXEBhE+cyJagIRsZPLusdUeTEdVAPlT2NaKYcVcbYpbvcHK9gOLq0vrJThcLpQdo4ud2xlw/wqz6OHKGVzGAfVXPIfzpHDTJ3IdsMjR4lVrxE353igEqZjIVOYgP7bwfBTIlwauIELygF1AwBMiZRvIWx2k5PUl+QyqwoFx0iqAAOGLbG4sSdKXmoqaHTktiZDBX6yIEHFSeVz65lTA3wnQR987u2xKt+2fudFlwRstVdTV4w5iwJ90iKIu/6eEyDgx+2eIleCf0i0kkTuHCK7+ytoEYqmOxM1jmNbonjiL8xx4kvROrR/AM4/+hjmTerOZ4R7et6GPi9ERB9ahe0kQWtfTUUCGXe1ihEAtMbSjLMZXOmX00DQUBtE3yCHWb+CMNMKOKbo3HonWVN1mprHdh17mbCAIJFN84isqDmUwRLsqXnfhXlF8hbV3yMbZiFOdS5CBKDxUqGZa0PgIeWSbdp+q0uhuX9iyPbFugXJsmwkGOpj4HByX1GuDWGvLPiK/J3eS0/Ih5p8t/4WWtJEaW+RRL0AxWC6IKsnwQW2z4iVZs7sjlVbwGCBXDBqmKz+QERx1wMTVOhsNZ930DanWi/lDzo9iQy+mWYD1EI2+1GIZJ+uypQVJfycoWeAlcHHvYREXOsLE+HGsQsjd7QcXTexzVyaI5tRv/LN9M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR02MB8368.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(5023799004)(6133799003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M040NExKQTYvRHBTQVc5a2ZoaXJIcEE2cGI0VzgxbFM5ZXB3emlsbU42WkYx?=
 =?utf-8?B?L2pxQkh5Z2pSM1dTQjJkUlNXWlhqZCtqRXpnd0x6UFo5NlRVMjd5MjUwVEhx?=
 =?utf-8?B?YjduUzhacXRYeitBVm5UOFpEY2dBRVp3ek00ZkNwNVFJckRqeWs4bFpJcjVT?=
 =?utf-8?B?ZFl4L0k5M0lYd29MTzlZU2Nnek5mcS9FOTBTcEJycHZoL2x2VXZFQ1JmNjFE?=
 =?utf-8?B?SXMyUW9ZUERJT2sza2pDZGlOTW8wdmFDZEVWSEdoc2lCbTVpTjdCWE1XQmJu?=
 =?utf-8?B?M2J0K2hBMWs2U2pxZmwzU05mOU1uY0QyWS85ZFR3WTNWeFExU2orVlI4T2kr?=
 =?utf-8?B?TkJXdVQ5ZTYrZjVOR3h0ZkRqci9aVmZQVkNwdFhvNVgxYnR4UlNycW9wbnUv?=
 =?utf-8?B?eEROYis5V1NQdnkvclBXNEhvekZqb1FZRmxoR2lEV3pKY1IrNmF2TkNXc2NU?=
 =?utf-8?B?VmFXcVdtOTR5Si8vZm5uNFZSZUg1QnpQWUI5UHZ2c3FndFFRdG0yT0V6Y2ZG?=
 =?utf-8?B?TEExTUc5dWQzVUdJdUI0clBBOVNreEcrdUpMb2k0UStsZnAxaVpjaFVxSUdn?=
 =?utf-8?B?SkljdEJQRXhYNWtSSWt6UGthMlFDc0Zidzg4V3Z3aGwzeGZQV0wybnFpMUM4?=
 =?utf-8?B?REE1anJOQU5YVkMvNzRxN0JDYmh0SUV0dzg1bGVwRFdRWDcxS0U1cjVXVFhZ?=
 =?utf-8?B?RnRaVSs3L3ZpSUUreGQyVVY3RituNnhBVlMrSHJQYWN1aTR3cDZwNWR2ZlZV?=
 =?utf-8?B?VDdCcEQ3YkRVaVJtOE1zcTg5aHg3d2dKN3ZTTFFQa2ZUUFI5NWV2UUxvZmNq?=
 =?utf-8?B?OWtpL2lsTVZuVDNTY3MwOWdOeUNRTDlrem0zYUlaeVNEOSsrZDQybGsxeUdj?=
 =?utf-8?B?WEt2ZVR3eEM4Z1gvL0tRVTR2cThVUU1qSXhjYnROWVFNWFh4MnhMa3NEL1pq?=
 =?utf-8?B?STRNTDJxMnpDS0NqbllrbXEyWHNMUmF3RU9OaVV4VnlXTHVQQWxTR1BhWHZX?=
 =?utf-8?B?cGNjQWhjdVlGWk01cmJGbjh4NTJyeEJaNnFDeUJNS0N6VDdlV2Iyem9zOUxL?=
 =?utf-8?B?MVd3dnFIVDlBRlN0aE9EQlZqQURGejByYmlsOCtCVDVWKzl4cm14YVVqU0FS?=
 =?utf-8?B?ckVhMEV1M2ZHZVREeTVSWGxUSnNJdnI0ZWRmZXpXL2JJcHUzUTFPbjZYN08w?=
 =?utf-8?B?QmorZ1o1MDFqbXdoM3ZBVXFLZHNpaHA0UGVFYnFLUEJLUFFTc1AxMkV5MFRu?=
 =?utf-8?B?SG9jT2NoQ3JKcjFYMnVJbEhKajFKcHN2dTh6K3VqS1JSWjVURUhFNU5CbnB3?=
 =?utf-8?B?K1hsYkRYRzNodWkyVEovZGNpbVFLTFVuRlZPRDdyb0M0UGNkYm1FeUxqVXZr?=
 =?utf-8?B?RjlBK29USjhnc0lyRFlOR1hzU2ZkeWppbnpvUHN4dERSU2pUVklQSmFVdkZy?=
 =?utf-8?B?dzJYNG5JdEhKcnY5d01lNHZVVEhvRERwV0RmK0VoKy9tbVJpTGo4bldwMGpx?=
 =?utf-8?B?S2dFWmo0MTF1enExa1RPNFNBU2VMS0ppWFBPSkp0eEpwbmxkYjRIUHZWQ3Bh?=
 =?utf-8?B?SXJqbnN3THdhZmVJTHpyVFBDblFYeTc2MjRvMm5YTk1qMjUyOHBPSFpKc1h6?=
 =?utf-8?B?M3l4OE1XY29CTG4vRVhSQkdUS1g3Y3cwWHBwYk1kQWsvSTRpblRTNXEyMXFw?=
 =?utf-8?B?bXE4aVhlWWdaTDB0endIMk80N0pXdWh1WjhIQU9UaGluRHpXaU1lTURDdFdS?=
 =?utf-8?B?SlRTanV5Mk43dVp3MldyU3RkS0JyRmd3cDRtRnExVGExcy9FVUs0UnlEeFdq?=
 =?utf-8?B?ai84VWRNdGNaQXJPaTUyRko2Q1MwK3Y4WmRFUGdUWGlnRGhDSkhITXpBcFoz?=
 =?utf-8?B?RVRBTTJKRGMrRGphYll5R3JIZGpySDNEcUNTcEhmaGZnSEpORzhUakwrLzZ0?=
 =?utf-8?B?bFRvQkFJS2t6SjUxdmh5ZHFEdWVVaXozdHdocWpXcjdaMFZzZVhjeEpIVkpB?=
 =?utf-8?B?ekZZUjliQ1pzL0JHK0k2T3JON2grcnRZL0lxd280alM0Snh3OVp3MDJDZWZq?=
 =?utf-8?B?ZlJkbHE4aDR6OXI2Ni84bWIzVjFaR3pKVmM0UDZvTTNXZ2FpWFlOKzFnaHZ3?=
 =?utf-8?B?YmVmSUxMa05uWUNNcG9uY2d6SWQ3WUFIRzBVSGxOSlFHRTZxTEUvOTJGYVVK?=
 =?utf-8?B?aEJpUUJEbHpDdGEyeDZCQUhmNlEvaTJLYkRjdzlidjhHcCtKdU5lbWtCMS9u?=
 =?utf-8?B?ZEhlemZpVFJnWSsxUEN0ZlVsZytWclVoVkIvK1lGbXRhdXltTzBtRkFkZGlw?=
 =?utf-8?B?WUU1djBUT0k1QXBFZDY3ZGZoSHBLbkovOWlpWDh6TzlSM2lvRUErdz09?=
X-Exchange-RoutingPolicyChecked: X8Ta5SqPoPfwck7SmTDLpptjyblZadqvcIk/ZXgH8Q38lXgRT/O61hJ8P7c21uO02522vESqUK/mgRipobaSbCkkzXkAOjHvulwMApV+7AEb3UCj3Rd/n81eQSPqLJB+pi0PRjT4Lf6OpyIyq5TgDv5C2K3XCxzxXCgplUMnWodHUCtIIIsgkWRWhw6K9qFQS3i1y/W6vApBPgmXdsL1l3rPsH13tHEXFy4O6AYebLR2/r1vvzm80IAnF0QMemi8wbtrUXuLvkgQnHq19OO1rZRl8UBgHqlGHgqolF2s/o1o6uGOsecDKNQpLT1uFRLFLkQrUmm6Sfwx9V/iLq2/UQ==
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 887cc563-b797-42cd-3d8a-08df2ac215ad
X-MS-Exchange-CrossTenant-AuthSource: SA1PR02MB8368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 13:41:58.8053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ioo/dkDn3DXf0YQSSNfC76B9M9IdbBIUBwC0iLL3KFL77BXqU+qgyxAT8xJ6xOW77Nq1f8JXKvS0pRsOUNQxZI7KIx+ZSiVmTaCsNyaEcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR02MB9549
X-Authority-Analysis: v=2.4 cv=fuVJ914f c=1 sm=1 tr=0 ts=6ad0d828 cx=c_pps
 a=j7k210cWVAfXhyiYu0S74w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VofLwUrZ8Iiv6rRUPXIb:22 a=Ap8k9tRZuQ82DLYWQqG7:22
 a=9HZk_PWzJn7GRsImaA0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 8Dmpp-bdosaoWJOVJaKcpCsKSnhb0jG9
X-Proofpoint-ORIG-GUID: 8Dmpp-bdosaoWJOVJaKcpCsKSnhb0jG9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1NCBTYWx0ZWRfX2nHb92BKTdRL
 MAOXdgLSVX9MTtRPSYEiPOIUj8hvHzkjzxI9p/lP+OkQcusxGCAIOf+Sb7NBTbtiVN2VtHUr1iH
 UbW77Xcg/T6ycsHGjPiGDfyEG90CE7A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1NCBTYWx0ZWRfX5/iZpT/MamEE
 //FtyIuEIonK3B+8O9Q/hF4dHE1jKOtNCZo/FIQ5w2FEfGN9I+LnQkCOv2T2e2qRX2UsukA2oxD
 nfRp5USxCjOAO2tCmUw+lMqXI0u472N1/KRZgjLT8NpuApLBhy5AUFx2SODvPHMrUMsqRKEWtE6
 zx/72EaWBHgAX17fnIotUGqOo2K1zKGPsmylYWz8epToBXcFjElXhrALM6gpGh6ezel+MyFl3Zr
 UV/d+Q18+CpGaN+Yiez4j5QoJvjTgHcHkFynuY9GCJEMZ99REo+eUqzwy+p+WkfMCTiqeFuJr2/
 DUhozcmA2w7s/nh9x4KLsGZ8vVyctDmIDu4Njfnk3yMKxgaZC3Zx77GdpxzoFP9mjSElURFZmke
 EboI8gxYdyfh4C6JuKE0JMoJft+cQbc3Fnqtbwmnrh593YdtU0QA/hyDGmfmCfxlAMJRBqAFtb5
 wENAZEsBIynj/aVOdlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=david.vrabel@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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


ping?
On 28/09/2026 16:24, David Vrabel wrote:
> When a VM has been assigned a number of PCIe devices behind a common
> PCIe switch and the VM intends to use peer-to-peer (P2P) transfers
> between the devices, it is useful to be able to more report the
> apparent PCIe bandwidth so it reflects the real handwidth of the
> underlying hardware. This allows software in the VM (such as NCCL[1])
> to make better decisions about whether to use P2P or not.
> 
> The existing emulated PCIe switch is a vintage TI XIO3130 and only
> support 2.5 GT/s and x1, so we introduces new generic upstream and
> downstream port devices (pcie-upstream-port and pcie-downstream-port),
> inspired by the existing generic pcie-root-port device.
> 
> The existing experimental "x-speed" and "x-width" options are made
> non-experimental, allowing the pcie-root-port and pcie-downstream-port
> capabilities to be configured to match the hardware.
> 
> The pcie-root-port device is updated to default to a Gen6 capable
> device.
> 
> Finally, where a root or upstream port's bandwidth has been limited,
> we also ensure the other end of the link reports the same link status.

