Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF8CCD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 12:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rutha-0004pv-U2; Thu, 11 Apr 2024 08:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ruthZ-0004pn-RJ
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 08:38:49 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <het.gala@nutanix.com>)
 id 1ruthW-0003Ts-Le
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 08:38:49 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43BCIQIA029269;
 Thu, 11 Apr 2024 05:38:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 content-type:message-id:date:subject:to:cc:references:from
 :in-reply-to:mime-version; s=proofpoint20171006; bh=ikDONTlCnjIj
 GgJtZOmN6Sl1rrbxYDG/P3N3seb6GrA=; b=Gn2DGmAo+NtQOrXsFDEl/mZ3nBjx
 CvXsXx4AYfvl1XzBj4xRHZP7E/X5+zrWMbOfIklG5/YGFYSLhgc0pDgkvd0c39YK
 f9BqJDO7y1ZXa2Yw2xDPqF0RrBgT5DpER3ndG1Xee6lAkmdM8khoenKV17PaOPxy
 pVmOElNelwBIvnmO3SQI5E2Rok5sVXRs1/S1uhhz4mmL52pSyrAE3tQnoMakNnRp
 /+HTHDgzDNbXlNMc2IFoN3AUXetOuX2am1VMvPeA4dTy4pT4txVkiTJzz9nb48Yd
 U0czpOosp37RtOp7CTlu8enVoZhkOHMhW9Vp/xjRRn841y57CjhNgu48dA==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3xct2k5pfv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Apr 2024 05:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzYCygFpw9hJWIxfOIlUoK2k7WEIYhq/MidpWW6wWHO4HERNHWNuJAwHCNO5ecoPTzuTET38EeAoqPQTY5vcoM9Aucf132d/5qcq+4vuIz5eaMOkpuEazd/n1MK1r7NwU1P1OHzzVvZygeHOnXb74LLtgqpbl2zp6PPmKocN7pGaMHLw2e7RmKbcKImWLZzdct27guUmXGDa2Vo2j17WEFv0RolaMlOc8Uk3xD7WwJTTbWhGKfIuQpa2HgASxD8q9mvt9UTgkBSD6kMkS0EWXOXmLtswsYsaBYCGJ8oWvqW8sYeuPidMaks4fbHX6orDJYnJgnYUOupPLwJQz4UcDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikDONTlCnjIjGgJtZOmN6Sl1rrbxYDG/P3N3seb6GrA=;
 b=cLZ3SeNwg19ApYDXiUlxL4Q612X2k58N3XNDnW9h5VmPhX5W4iLaQm4ApuoZ/IHrG1Qzba+6T38tcBRM+yIV7wREWIq83N5tXnAmcz0kyCySHi1/EyXlmGzAaR4jwbi4JrGE8c5lmh17sGd2O4l6BewPiHwUjI6PAUEkQ1uEae2aDPDbiaLsj1CgYSdi1fg4Z7DqmGor8KvXoEJf90WTUloCAuPCSRqS9bSy6XbAC0Z8b8CQS9NrBvdugLUpM77A3rfNNe0myUCXX2t+FXgLaIRAlTZVtaBXbzuV4zSqepEfGE5rz+AejPmxJSXzgtIDtZtOuA4GnPLeyILr5vYKDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikDONTlCnjIjGgJtZOmN6Sl1rrbxYDG/P3N3seb6GrA=;
 b=khs5lAdzFvBrt8TyeYQ9i8ewCCsUwX4PEYAsFA0gT66TvO/oF7KDzYHtpXzrdPFvMMJxCgd4pSdZQ/rZ3oH+C/wld4+90QauWpgVFgEQi+XPu1+uolq7sbx738niI8MfHsX9V1qLSyWjYldxR5a4qbwfn4jCWWs+JtF62CDSgMV4HAyk7QSsiFs4cD7tsb0/wRAjDZLpbk7mtzGfhH7ta8fDFtweT+YZS6Oi5y3TneSiM+udOmJBR9SagyVnw2oX1bQjlbakydIRZ6xvCw/uZWouDxZ+UzQee+kNe02AfmohmvRLTGaxtcRrRdFnsgttpI4Lopl15aRiFFDaiFn9Lw==
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com (2603:10b6:a03:55f::16)
 by DM8PR02MB8139.namprd02.prod.outlook.com (2603:10b6:8:1c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 12:38:41 +0000
Received: from SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0]) by SJ2PR02MB9955.namprd02.prod.outlook.com
 ([fe80::225c:2edd:87e:7cf0%7]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 12:38:41 +0000
Content-Type: multipart/alternative;
 boundary="------------COSiWkA4J0NkYKs14eHaSSnX"
Message-ID: <1e7125a6-f849-4130-b4c9-74a295bcfc01@nutanix.com>
Date: Thu, 11 Apr 2024 18:08:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] tests/qtest/migration: Add channels parameter in
 migrate_incoming_qmp
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 peterx@redhat.com, prerna.saxena@nutanix.com
References: <20240410111541.188504-1-het.gala@nutanix.com>
 <20240410111541.188504-4-het.gala@nutanix.com> <87y19ltl4o.fsf@suse.de>
Content-Language: en-US
From: Het Gala <het.gala@nutanix.com>
In-Reply-To: <87y19ltl4o.fsf@suse.de>
X-ClientProxiedBy: MAXPR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::33) To SJ2PR02MB9955.namprd02.prod.outlook.com
 (2603:10b6:a03:55f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR02MB9955:EE_|DM8PR02MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: 586789fc-a482-404f-d73f-08dc5a24514b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EwpqFAq2Q0RP51PYUAi71YFddjDsSjbJQ0iz3K54Y3llFH58+1yJlQnNDwxjxYq5GrB412hjrifW3kfJQi/gM7vK/3Belt93grZf89HLlbX6aI6gH5XJTSzn/2Eb4jlW3HlwwFebgpz5Ttvc+AR3YTwcTXoEVL2t1UFtrc+kxvDvY5QYCwMJmYW4awMil0nG2VgpgJqAumL5IaLfem7puUEJKkkMZu0hnUyPrANHuJ6nKSUuYgKO076a3Nq/oYrLiawEsqHncQPdYJGCSPV6e6U+rG8PUMsHPbc7+6sBzrmHw74O6fs3cNHbViG9alvkngrmriCBfPt3RKvXT97AALzrbK5wnkKgvzdqAtkgwzg9OM9U9RACrzYdajKC5YK3ffK2w4m+V6Jq1ANJyN/atHeKsT359lZIJ/2SRsO+Qt6UsFsq25hTMMz7YJNh2o3zfYg1PyK1e8m9mUMUyqWQVOZ16+GK0NwbgCLk1/tcmaLr4odradlpAiJkq3O+HESvhQdsO7pgYy5zzOlR6XkjPkTaCjBGR8v7sFeCn6f771nfMlwaJue8Xdy7rLem2T6iszxvIM0dADX93ss1gYVHjiZtmlItsCHe9YZF/QF6lcqcnnRAhKCGFeszymtKxM3aM4SNA8uRPuVuNx0jxWiSAOOuubB/SijRj8VXJLkRboM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR02MB9955.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkxGMkNyRDJGQVJNdmxTZ1QrRkYyWmttVDlIQXNIYS9pSVk3emo1dFhMaGZw?=
 =?utf-8?B?VFd4M3dPQ3BHWWNlZFJTV2RjR1VFSU5NVENOUFN2SS9tQmp2OUIybGhpKzJn?=
 =?utf-8?B?QzJBTnZsaFR0aGZZcEhXT0dRckFhWHREUEpiN0ZNZmI3NVAxSE5WQ2dMWkdv?=
 =?utf-8?B?RmpNM1BhUzl6ODdvTGkza2taZG1rcUVEQ0dqNmI5QlpZNzNEOXlURDdyL1Zy?=
 =?utf-8?B?S3NGbXByUWJERzIwMS9WUDY4ZjFvRERsdDczbVdkeHJHNnZBL200R0RZWTBS?=
 =?utf-8?B?VmZFYnpudHBydkhzWGpzSmhpMnczUnh1bUU2dERBbFRtTGpEVU9iTmJXYzZh?=
 =?utf-8?B?T3pNS3dvbm4zT1RxanJqVG4vSEMvMXZNcEMrbGtaYVEyRTlocnJDak84b3Fm?=
 =?utf-8?B?SUJ5Y2dZcUFoYTFCUGJwMnNnSVkyVGM1NnJSTzdvZWVmVWN6ZkF5MUlFbXY2?=
 =?utf-8?B?RVV4UGVveThTMWNDZXdTUkJZWWl2ajY5UUEyQjdRUDZqaWxvSXBrb3ZNMVRm?=
 =?utf-8?B?YmJNSVpxSFpUdldic3p1cWtETFdPSnFabWtHS1BoaG5rbnMyY1dWdHc5Y2Fa?=
 =?utf-8?B?aklYY0FtV0ZZRXRLTEIwTmRQVERlOGNrNHpveXQzODd1U1RubDFweTczbDZt?=
 =?utf-8?B?aXI4MTR3cnAzSmFKM1RGWTd6VUxhWGN3YWZWSk9NTWlvenByNWhqcEVtb0dw?=
 =?utf-8?B?UjQ4dEN0eWNRampRZXQvcWtWN2JoK3NmY2RXK1RFb0l2UG1zR0g5NHFvMjdK?=
 =?utf-8?B?Ky9Ub1hnT3N5b3E2U21TblpSRzkvWmlRYVYvVWk0TnQxZDRmNFFpWUtqTE9p?=
 =?utf-8?B?REpsbzF2UFlFTDVlbjYyTWRNczdTU0ExMVNUZmRsVmxjSGRiRVREWXBleG1T?=
 =?utf-8?B?a0F0a1B6Y3A2ckNjVythcDg0TzJtSGxrVFFQNVl1OFladW82aW9pRnpHS1Iz?=
 =?utf-8?B?bSt6enQyamt6c1R4ZFJWcVl4ZU1sNUlvZ041S3lGOE9YbkRHMm84Qk4xQ2Q2?=
 =?utf-8?B?ZW54MFNvc2VlWUlwRVFnNCtublNwS2FLR3BiWTNwZ0J4M1JpTHRDRXczdHo5?=
 =?utf-8?B?c2M4YXZhNWNNMTZtS3ljdUEzRE9sTWRZQ3NJMmUzRW84QTlER1ZaLzZSSkN6?=
 =?utf-8?B?SVM0dVFOb1VXTU00d0lyYXJHY3NLK1M1QXBUcXZmUy9mRWtNcmNpTDgxbW5B?=
 =?utf-8?B?N09PNlppUVVoMjVtNUgyamZVVTdnTGF1M0gzY3ExMXlyUlpOb1l2dnkxVHJI?=
 =?utf-8?B?S1QrR2h4dG9MbDhsY3pGTjQ2NklDcE5xVjJxWUhWYmRjL09jUzRtTVE4aG9K?=
 =?utf-8?B?b2l3WVVweFZJa1dpTngxaDhqbTlWRE1aT1ExMVRpVGwwZ3JWNndKUThzSHdT?=
 =?utf-8?B?NlBPQXFJc3kreXl3Q0VFTHIwVkNWeXhZMEc4SmZDb2NQNkwxYnlXM3JBbGJ0?=
 =?utf-8?B?ek01V04xLzZ0OGZIaUxyUWVXdkxPL2llUEc4THJOalZEc3RkOUVaU2ZONmVj?=
 =?utf-8?B?TzBCZDlZNksyZG1QWVZIdjI0eFhwMUlnMzFZdG9mYUZBamZGOElrQk9uMVFk?=
 =?utf-8?B?dnVFNkdJVXMwQnQvc1FneFVwZWdoYmp0azM2dU95cFk5Mjh6WHZCZTBqOVpk?=
 =?utf-8?B?ZDRncHlxSkVVUjkyZXJ4eDZvcndFeFY3dU1XZTRBNG9pRUZsYVRQMHVCOERJ?=
 =?utf-8?B?cXVCQ2pDeU00Uk9iVnpjRDlsV3hhb3hkczVidi9NZ1ZrelBHUHhDV2FzWWh5?=
 =?utf-8?B?NUpaeEM1WlFaQUI1dC9udTRHZHYvM29RMVBJa3AwQ0hqQW5IQTliOHd5Ymdq?=
 =?utf-8?B?UjdBeW5FS1JlMTNtZENnNldwVU1UcFJsSEhaR2JnVHBFd1NtcUk0TTQ4VEdB?=
 =?utf-8?B?QXQ4TFVRc2hDeW9BUmNYV0h5MklSTXk2QU5TZlFlaFp2MmVXNThrREE4b2RN?=
 =?utf-8?B?OUZNVU1KZEpUZ05DRVpaS0dxUU1haU1oS1hTZTZpVzZRdXdOMFdNUDRYSlE0?=
 =?utf-8?B?UFNZblBlblR0UWNtREc1Mzc2R0JObG9vclVnaTZ4MlRqU0tzRkN6a1ZVZFZK?=
 =?utf-8?B?MklUMjJlZkJRaFFnRGx5amJEalhSUUJFT1k0dzFkTVNaYUxjUzlELzRXM3g4?=
 =?utf-8?Q?4CvpYbEXsBpJ5qBZRVkMddKEB?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 586789fc-a482-404f-d73f-08dc5a24514b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR02MB9955.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 12:38:41.2103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H/83+D+R74rMUNfLZYH+Ss/H5BxtTyKui8FdxCfe54y9K5WidOrD+MXb9jAA6DqTL7Ly82SYbyrjdWBYF7h4RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8139
X-Proofpoint-GUID: c_sNQA8cYLJ8YK-tqCtiElN0i13K8UxC
X-Proofpoint-ORIG-GUID: c_sNQA8cYLJ8YK-tqCtiElN0i13K8UxC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_06,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=het.gala@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

--------------COSiWkA4J0NkYKs14eHaSSnX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/04/24 6:44 pm, Fabiano Rosas wrote:
> !-------------------------------------------------------------------|
>    CAUTION: External Email
>
> |-------------------------------------------------------------------!
>
> Het Gala<het.gala@nutanix.com>  writes:
>
>> Alter migrate_incoming_qmp() to allow both uri and channels
>> independently. For channels, convert string to a QDict.
>>
>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>> ---
>>   tests/qtest/migration-helpers.c   | 13 +++++++++++--
>>   tests/qtest/migration-helpers.h   |  4 ++--
>>   tests/qtest/migration-test.c      | 12 ++++++------
>>   tests/qtest/virtio-net-failover.c |  8 ++++----
>>   4 files changed, 23 insertions(+), 14 deletions(-)
>>
>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>> index 3b72cad6c1..cbd91719ae 100644
>> --- a/tests/qtest/migration-helpers.c
>> +++ b/tests/qtest/migration-helpers.c
>> @@ -245,7 +245,8 @@ void migrate_set_capability(QTestState *who, const char *capability,
>>                                capability, value);
>>   }
>>   
>> -void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
>> +void migrate_incoming_qmp(QTestState *to, const char *uri,
>> +                          const char *channels, const char *fmt, ...)
>>   {
>>       va_list ap;
>>       QDict *args, *rsp, *data;
>> @@ -255,7 +256,15 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
>>       va_end(ap);
>>   
>>       g_assert(!qdict_haskey(args, "uri"));
>> -    qdict_put_str(args, "uri", uri);
>> +    if (uri) {
>> +        qdict_put_str(args, "uri", uri);
>> +    }
>> +
>> +    g_assert(!qdict_haskey(args, "channels"));
>> +    if (channels) {
>> +        QObject *channels_obj = qobject_from_json(channels, &error_abort);
>> +        qdict_put_obj(args, "channels", channels_obj);
>> +    }
> Do you think it makes sense to have channels take precedence here? It
> would make the next patch cleaner without having to check for channels
> presence. I don't think we need a 'both' test for incoming.

Yes, this hack would silently solve, avoiding the above check.

IMO, it is good to have like to like QAPIs while running a qtest.
If the qtest uses the new syntax then, both 'migrate' and 'migrate-incoming'
QAPIs should use the new syntax. Even though implementation wise, it makes
no difference (qtests run successfully) but it would be good to ensure, 
we have
grammatical correctness.

>>   
>>       migrate_set_capability(to, "events", true);
>>   
>> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
>> index 1339835698..9f74281aea 100644
>> --- a/tests/qtest/migration-helpers.h
>> +++ b/tests/qtest/migration-helpers.h
>> @@ -29,9 +29,9 @@ G_GNUC_PRINTF(5, 6)
>>   void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
>>                    const char *channels, const char *fmt, ...);
>>   
>> -G_GNUC_PRINTF(3, 4)
>> +G_GNUC_PRINTF(4, 5)
>>   void migrate_incoming_qmp(QTestState *who, const char *uri,
>> -                          const char *fmt, ...);
>> +                          const char *channels, const char *fmt, ...);
>>   
>>   G_GNUC_PRINTF(4, 5)
>>   void migrate_qmp_fail(QTestState *who, const char *uri,
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index f2c27d611c..fa8a860811 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -1296,7 +1296,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
>>       migrate_ensure_non_converge(from);
>>   
>>       migrate_prepare_for_dirty_mem(from);
>> -    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
>> +    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
>>   
>>       /* Wait for the first serial output from the source */
>>       wait_for_serial("src_serial");
>> @@ -1824,7 +1824,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
>>        * We need to wait for the source to finish before starting the
>>        * destination.
>>        */
>> -    migrate_incoming_qmp(to, args->connect_uri, "{}");
>> +    migrate_incoming_qmp(to, args->connect_uri, NULL, "{}");
>>       wait_for_migration_complete(to);
>>   
>>       if (stop_src) {
>> @@ -2405,7 +2405,7 @@ static void *test_migrate_fd_start_hook(QTestState *from,
>>       close(pair[0]);
>>   
>>       /* Start incoming migration from the 1st socket */
>> -    migrate_incoming_qmp(to, "fd:fd-mig", "{}");
>> +    migrate_incoming_qmp(to, "fd:fd-mig", NULL, "{}");
>>   
>>       /* Send the 2nd socket to the target */
>>       qtest_qmp_fds_assert_success(from, &pair[1], 1,
>> @@ -2715,7 +2715,7 @@ test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
>>       migrate_set_capability(to, "multifd", true);
>>   
>>       /* Start incoming migration from the 1st socket */
>> -    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
>> +    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
>>   
>>       return NULL;
>>   }
>> @@ -3040,7 +3040,7 @@ static void test_multifd_tcp_cancel(void)
>>       migrate_set_capability(to, "multifd", true);
>>   
>>       /* Start incoming migration from the 1st socket */
>> -    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
>> +    migrate_incoming_qmp(to, "tcp:127.0.0.1:0", NULL, "{}");
>>   
>>       /* Wait for the first serial output from the source */
>>       wait_for_serial("src_serial");
>> @@ -3068,7 +3068,7 @@ static void test_multifd_tcp_cancel(void)
>>       migrate_set_capability(to2, "multifd", true);
>>   
>>       /* Start incoming migration from the 1st socket */
>> -    migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", "{}");
>> +    migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", NULL, "{}");
>>   
>>       wait_for_migration_status(from, "cancelled", NULL);
>>   
>> diff --git a/tests/qtest/virtio-net-failover.c b/tests/qtest/virtio-net-failover.c
>> index 73dfabc272..e263ecd80e 100644
>> --- a/tests/qtest/virtio-net-failover.c
>> +++ b/tests/qtest/virtio-net-failover.c
>> @@ -772,7 +772,7 @@ static void test_migrate_in(gconstpointer opaque)
>>       check_one_card(qts, true, "standby0", MAC_STANDBY0);
>>       check_one_card(qts, false, "primary0", MAC_PRIMARY0);
>>   
>> -    migrate_incoming_qmp(qts, uri, "{}");
>> +    migrate_incoming_qmp(qts, uri, NULL, "{}");
>>   
>>       resp = get_failover_negociated_event(qts);
>>       g_assert_cmpstr(qdict_get_str(resp, "device-id"), ==, "standby0");
>> @@ -894,7 +894,7 @@ static void test_off_migrate_in(gconstpointer opaque)
>>       check_one_card(qts, true, "standby0", MAC_STANDBY0);
>>       check_one_card(qts, true, "primary0", MAC_PRIMARY0);
>>   
>> -    migrate_incoming_qmp(qts, uri, "{}");
>> +    migrate_incoming_qmp(qts, uri, NULL, "{}");
>>   
>>       check_one_card(qts, true, "standby0", MAC_STANDBY0);
>>       check_one_card(qts, true, "primary0", MAC_PRIMARY0);
>> @@ -1021,7 +1021,7 @@ static void test_guest_off_migrate_in(gconstpointer opaque)
>>       check_one_card(qts, true, "standby0", MAC_STANDBY0);
>>       check_one_card(qts, false, "primary0", MAC_PRIMARY0);
>>   
>> -    migrate_incoming_qmp(qts, uri, "{}");
>> +    migrate_incoming_qmp(qts, uri, NULL, "{}");
>>   
>>       check_one_card(qts, true, "standby0", MAC_STANDBY0);
>>       check_one_card(qts, false, "primary0", MAC_PRIMARY0);
>> @@ -1746,7 +1746,7 @@ static void test_multi_in(gconstpointer opaque)
>>       check_one_card(qts, true, "standby1", MAC_STANDBY1);
>>       check_one_card(qts, false, "primary1", MAC_PRIMARY1);
>>   
>> -    migrate_incoming_qmp(qts, uri, "{}");
>> +    migrate_incoming_qmp(qts, uri, NULL, "{}");
>>   
>>       resp = get_failover_negociated_event(qts);
>>       g_assert_cmpstr(qdict_get_str(resp, "device-id"), ==, "standby0");
Regards,
Het Gala
--------------COSiWkA4J0NkYKs14eHaSSnX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 10/04/24 6:44 pm, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87y19ltl4o.fsf@suse.de">
      <pre class="moz-quote-pre" wrap="">!-------------------------------------------------------------------|
  CAUTION: External Email

|-------------------------------------------------------------------!

Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Alter migrate_incoming_qmp() to allow both uri and channels
independently. For channels, convert string to a QDict.

Signed-off-by: Het Gala <a class="moz-txt-link-rfc2396E" href="mailto:het.gala@nutanix.com">&lt;het.gala@nutanix.com&gt;</a>
---
 tests/qtest/migration-helpers.c   | 13 +++++++++++--
 tests/qtest/migration-helpers.h   |  4 ++--
 tests/qtest/migration-test.c      | 12 ++++++------
 tests/qtest/virtio-net-failover.c |  8 ++++----
 4 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
index 3b72cad6c1..cbd91719ae 100644
--- a/tests/qtest/migration-helpers.c
+++ b/tests/qtest/migration-helpers.c
@@ -245,7 +245,8 @@ void migrate_set_capability(QTestState *who, const char *capability,
                              capability, value);
 }
 
-void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
+void migrate_incoming_qmp(QTestState *to, const char *uri,
+                          const char *channels, const char *fmt, ...)
 {
     va_list ap;
     QDict *args, *rsp, *data;
@@ -255,7 +256,15 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
     va_end(ap);
 
     g_assert(!qdict_haskey(args, &quot;uri&quot;));
-    qdict_put_str(args, &quot;uri&quot;, uri);
+    if (uri) {
+        qdict_put_str(args, &quot;uri&quot;, uri);
+    }
+
+    g_assert(!qdict_haskey(args, &quot;channels&quot;));
+    if (channels) {
+        QObject *channels_obj = qobject_from_json(channels, &amp;error_abort);
+        qdict_put_obj(args, &quot;channels&quot;, channels_obj);
+    }
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Do you think it makes sense to have channels take precedence here? It
would make the next patch cleaner without having to check for channels
presence. I don't think we need a 'both' test for incoming.</pre>
    </blockquote>
    <p><font face="monospace">Yes, this hack would silently solve,
        avoiding the above check.</font></p>
    <p><font face="monospace">IMO, it is good to have like to like QAPIs
        while running a qtest.<br>
        If the qtest uses the new syntax then, both 'migrate' and
        'migrate-incoming'<br>
        QAPIs should use the new syntax. Even though implementation
        wise, it makes<br>
        no difference (qtests run successfully) but it would be good to
        ensure, we have<br>
        grammatical correctness.</font><span style="white-space: pre-wrap">
</span></p>
    <blockquote type="cite" cite="mid:87y19ltl4o.fsf@suse.de">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap=""> 
     migrate_set_capability(to, &quot;events&quot;, true);
 
diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
index 1339835698..9f74281aea 100644
--- a/tests/qtest/migration-helpers.h
+++ b/tests/qtest/migration-helpers.h
@@ -29,9 +29,9 @@ G_GNUC_PRINTF(5, 6)
 void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
                  const char *channels, const char *fmt, ...);
 
-G_GNUC_PRINTF(3, 4)
+G_GNUC_PRINTF(4, 5)
 void migrate_incoming_qmp(QTestState *who, const char *uri,
-                          const char *fmt, ...);
+                          const char *channels, const char *fmt, ...);
 
 G_GNUC_PRINTF(4, 5)
 void migrate_qmp_fail(QTestState *who, const char *uri,
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index f2c27d611c..fa8a860811 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1296,7 +1296,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
     migrate_ensure_non_converge(from);
 
     migrate_prepare_for_dirty_mem(from);
-    migrate_incoming_qmp(to, &quot;tcp:127.0.0.1:0&quot;, &quot;{}&quot;);
+    migrate_incoming_qmp(to, &quot;tcp:127.0.0.1:0&quot;, NULL, &quot;{}&quot;);
 
     /* Wait for the first serial output from the source */
     wait_for_serial(&quot;src_serial&quot;);
@@ -1824,7 +1824,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
      * We need to wait for the source to finish before starting the
      * destination.
      */
-    migrate_incoming_qmp(to, args-&gt;connect_uri, &quot;{}&quot;);
+    migrate_incoming_qmp(to, args-&gt;connect_uri, NULL, &quot;{}&quot;);
     wait_for_migration_complete(to);
 
     if (stop_src) {
@@ -2405,7 +2405,7 @@ static void *test_migrate_fd_start_hook(QTestState *from,
     close(pair[0]);
 
     /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, &quot;fd:fd-mig&quot;, &quot;{}&quot;);
+    migrate_incoming_qmp(to, &quot;fd:fd-mig&quot;, NULL, &quot;{}&quot;);
 
     /* Send the 2nd socket to the target */
     qtest_qmp_fds_assert_success(from, &amp;pair[1], 1,
@@ -2715,7 +2715,7 @@ test_migrate_precopy_tcp_multifd_start_common(QTestState *from,
     migrate_set_capability(to, &quot;multifd&quot;, true);
 
     /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, &quot;tcp:127.0.0.1:0&quot;, &quot;{}&quot;);
+    migrate_incoming_qmp(to, &quot;tcp:127.0.0.1:0&quot;, NULL, &quot;{}&quot;);
 
     return NULL;
 }
@@ -3040,7 +3040,7 @@ static void test_multifd_tcp_cancel(void)
     migrate_set_capability(to, &quot;multifd&quot;, true);
 
     /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to, &quot;tcp:127.0.0.1:0&quot;, &quot;{}&quot;);
+    migrate_incoming_qmp(to, &quot;tcp:127.0.0.1:0&quot;, NULL, &quot;{}&quot;);
 
     /* Wait for the first serial output from the source */
     wait_for_serial(&quot;src_serial&quot;);
@@ -3068,7 +3068,7 @@ static void test_multifd_tcp_cancel(void)
     migrate_set_capability(to2, &quot;multifd&quot;, true);
 
     /* Start incoming migration from the 1st socket */
-    migrate_incoming_qmp(to2, &quot;tcp:127.0.0.1:0&quot;, &quot;{}&quot;);
+    migrate_incoming_qmp(to2, &quot;tcp:127.0.0.1:0&quot;, NULL, &quot;{}&quot;);
 
     wait_for_migration_status(from, &quot;cancelled&quot;, NULL);
 
diff --git a/tests/qtest/virtio-net-failover.c b/tests/qtest/virtio-net-failover.c
index 73dfabc272..e263ecd80e 100644
--- a/tests/qtest/virtio-net-failover.c
+++ b/tests/qtest/virtio-net-failover.c
@@ -772,7 +772,7 @@ static void test_migrate_in(gconstpointer opaque)
     check_one_card(qts, true, &quot;standby0&quot;, MAC_STANDBY0);
     check_one_card(qts, false, &quot;primary0&quot;, MAC_PRIMARY0);
 
-    migrate_incoming_qmp(qts, uri, &quot;{}&quot;);
+    migrate_incoming_qmp(qts, uri, NULL, &quot;{}&quot;);
 
     resp = get_failover_negociated_event(qts);
     g_assert_cmpstr(qdict_get_str(resp, &quot;device-id&quot;), ==, &quot;standby0&quot;);
@@ -894,7 +894,7 @@ static void test_off_migrate_in(gconstpointer opaque)
     check_one_card(qts, true, &quot;standby0&quot;, MAC_STANDBY0);
     check_one_card(qts, true, &quot;primary0&quot;, MAC_PRIMARY0);
 
-    migrate_incoming_qmp(qts, uri, &quot;{}&quot;);
+    migrate_incoming_qmp(qts, uri, NULL, &quot;{}&quot;);
 
     check_one_card(qts, true, &quot;standby0&quot;, MAC_STANDBY0);
     check_one_card(qts, true, &quot;primary0&quot;, MAC_PRIMARY0);
@@ -1021,7 +1021,7 @@ static void test_guest_off_migrate_in(gconstpointer opaque)
     check_one_card(qts, true, &quot;standby0&quot;, MAC_STANDBY0);
     check_one_card(qts, false, &quot;primary0&quot;, MAC_PRIMARY0);
 
-    migrate_incoming_qmp(qts, uri, &quot;{}&quot;);
+    migrate_incoming_qmp(qts, uri, NULL, &quot;{}&quot;);
 
     check_one_card(qts, true, &quot;standby0&quot;, MAC_STANDBY0);
     check_one_card(qts, false, &quot;primary0&quot;, MAC_PRIMARY0);
@@ -1746,7 +1746,7 @@ static void test_multi_in(gconstpointer opaque)
     check_one_card(qts, true, &quot;standby1&quot;, MAC_STANDBY1);
     check_one_card(qts, false, &quot;primary1&quot;, MAC_PRIMARY1);
 
-    migrate_incoming_qmp(qts, uri, &quot;{}&quot;);
+    migrate_incoming_qmp(qts, uri, NULL, &quot;{}&quot;);
 
     resp = get_failover_negociated_event(qts);
     g_assert_cmpstr(qdict_get_str(resp, &quot;device-id&quot;), ==, &quot;standby0&quot;);
</pre>
      </blockquote>
    </blockquote>
    <font face="monospace">Regards,<br>
      Het Gala</font><br>
  </body>
</html>

--------------COSiWkA4J0NkYKs14eHaSSnX--

