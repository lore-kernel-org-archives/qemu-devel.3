Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6667C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 22:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9teX-0000MD-DM; Tue, 29 Apr 2025 18:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u9teV-0000Lv-C9; Tue, 29 Apr 2025 18:42:11 -0400
Received: from mx0a-002c1b01.pphosted.com ([148.163.151.68])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.levon@nutanix.com>)
 id 1u9teT-0003KG-4H; Tue, 29 Apr 2025 18:42:11 -0400
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
 by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TCtBaq020781;
 Tue, 29 Apr 2025 15:42:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=YSdoDs180mNiS7KDZpcVQxZ3r8m3P6fouN2A24WLx
 gc=; b=e2rxJigzpOB7CkxJZBQsRzU1FN4MN2GBdASl8knK6gHln+1Wy9Wfc0PZz
 C7dxhYUiaYvl87Kg6pYGhKYSuNI0bx9wra3uwIdOsagrIqwUBCuoYZBWV5xaUMqr
 swI0YrKwIdxgIJDFx+IcOd1Pm2LWoV/WpuNyXUHWZe3tipvOT5zSJYlvNQawdwL/
 ah+vixqtFdhsRpoHtP+yJWAFIM7YGNzyU3qmFTlbxBxnOsjtBGbzyN3hk02+CzHc
 g5Gzv85fXBLnCyqEhnePVeC5mz9TuP/0v72HU5b+LthdMC9NVC3BlgqD0m7JrdyP
 FMNoWPlLMBDxLA7pnzIk7jI6C3yAg==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazlp17013079.outbound.protection.outlook.com [40.93.6.79])
 by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 468ud8famh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 29 Apr 2025 15:42:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebqp0lEHnaPPcRN35fSM6R965iAkaZqFwUpWFPEoen4WJGBxLZWVE835BW6tMYwaBWBKBGfryhpddsMig0+7m6Z/Em0XGCEENvC3/xCuGDHJD3HyVPb1eHGNj6EplS31M9XawRvAECuvDrIeB1G2UB1BAMn7HaSSQ9IxkI9zo73qNTgRI050flGCnQi6UclxezcPGndZ4dd7GQh/128BY3thZILS12dRUEX4Jk2Gx1d92zFH/hmOW9vRe+C3MKMTYcmvMggrPqZLxx79YNtaXw0MeftsD0rf7Rraf1/dPROu1n8pwFdl5Xhn94Cq20bP/LkOHowDoYS3PuGCA6bzlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLCqtt8QC8u+5VzgZ4UCu0o77t8PRV+0MvwN/Mv4RMk=;
 b=oA6LvUlhzMRz0RsZj1hyjqPMVW7LH2eMqs/llzXQgDRd+f7A7LrgYbze+q14v/FD0Al2uXcahr0oa+BVOhJOIp/OB9Th56ykgxy4hVU4AKFDHl2kwbzFm9Uu9jbRj7M6P8cm5iJe5ZZYnUGkzZEfynAUSI2ZcAnZ9o8lKgcraKTjmeZp8vFpBtAQta4NnOqApDPeJYLgHsB9zfbpVxlKo00c1Ldc/YctH42a7/nZbblqYQMLv1SpsSksgkhmGM+Y2A1RU9XcmArDI4KH+eiEFBxcuVvplQKy/rYXwItg/4qYcexsoUD8a4iIMq8XK4wOOx6z3Ukxv77vWEcjpgBegg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLCqtt8QC8u+5VzgZ4UCu0o77t8PRV+0MvwN/Mv4RMk=;
 b=mBdv4Yh4/IqpNXtfd2jsUC3qZBGcj+iowIMJlJad5xvuSAoNqSNQ53du2j1ND4wpeOiRXpe9bUE5yzqkqQpcnWFTZRuBhTo2fK6/JJJCCxFK83OkOLcrwtRWg16fTvEL0YHOu8iqO8sj2+Bhv/fIO7cF1jKCErFud0U5uNCvkLkCeHdqDKZPWsqapZC+oJF5aWkEhy2nGAuZC8ZtWQw/Do4V47iAFtgDpucxZ0Xce3iOeOHiihTY+rj5eUJPBa0ZaSTg7hoCF6ks9mo3XALq3v+EVfNZ2PXa/FIg4TsRZHrQFdkcbzCtbRNdkRIQ6zz66tukHrThKi2Dgw6ltAHEEA==
Received: from CH2PR02MB6760.namprd02.prod.outlook.com (2603:10b6:610:7f::9)
 by SA6PR02MB10430.namprd02.prod.outlook.com (2603:10b6:806:408::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 29 Apr
 2025 22:41:59 +0000
Received: from CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51]) by CH2PR02MB6760.namprd02.prod.outlook.com
 ([fe80::fd77:ea65:a159:ef51%6]) with mapi id 15.20.8699.012; Tue, 29 Apr 2025
 22:41:59 +0000
Date: Tue, 29 Apr 2025 23:41:54 +0100
From: John Levon <john.levon@nutanix.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-s390x@nongnu.org,
 Tomita Moeko <tomitamoeko@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PATCH 12/14] vfio: add region info cache
Message-ID: <aBFVspaqahGmud87@lent>
References: <20250409134814.478903-1-john.levon@nutanix.com>
 <20250409134814.478903-13-john.levon@nutanix.com>
 <fd6fa8cc-8e11-47a5-881a-1f0205aac742@redhat.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd6fa8cc-8e11-47a5-881a-1f0205aac742@redhat.com>
X-Url: http://www.movementarian.org/
X-ClientProxiedBy: LO4P123CA0274.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::9) To CH2PR02MB6760.namprd02.prod.outlook.com
 (2603:10b6:610:7f::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR02MB6760:EE_|SA6PR02MB10430:EE_
X-MS-Office365-Filtering-Correlation-Id: 330130c4-b2e0-413c-ea38-08dd876f0d4b
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?wKTYzkLIFmfXe+Z3l0D/pu7Wiw7zMzG0UAYm4oCmEFSHJiYEHBZE5f4VbS?=
 =?iso-8859-1?Q?vp5LdOVy2n+LIPBw3Fa4nUVyVnQWOEsNQsKtp/LLAfMMDMAx8HA8CcW7lA?=
 =?iso-8859-1?Q?PA9MRc655Fx2+i/ZqPjQ43KS6IV967EsmzQricSe0uz56iKCtFqSq9OL+J?=
 =?iso-8859-1?Q?691XUABKYSorHN/Q/ulMammG+0lPsYyu59UUbgFd0PxBKbsGFxrAK0mb4i?=
 =?iso-8859-1?Q?E8zrsuo4quz14UYLnMuUX8Ibzh3NAIaI1Qv4JRyBvq44hsJgHQOQeR1HCa?=
 =?iso-8859-1?Q?cy6djaPKN5ik/gi5ia/cZn5UZHDeCuUcUhBLrH885YsfABPdMD9KNUEV3v?=
 =?iso-8859-1?Q?7qavF8I5t671Kuey4iRTly8Act+14DUkH9XT7QBf5JhxEo/2df28bHeTi3?=
 =?iso-8859-1?Q?kXdPGxkwOMDdmblG8GdiadpLwqKnI554sJpACP229L3aa0+7QjVEjAgVXc?=
 =?iso-8859-1?Q?10/RL+rmBjcKBG4grLKTwwhRTNscEBeGBHiMHD20EbfDpm38XnND/MVB19?=
 =?iso-8859-1?Q?FTD91PyOlhc9kMSangXDJD2rJdRYzy6p7YbTLtb31BvU4gep8uRCFQUi8M?=
 =?iso-8859-1?Q?pGKGjhk1VfF6s6pvdGgoVKKAcdgXOPtxXvc/2P3qM+mF1c2vi20lOLdMJe?=
 =?iso-8859-1?Q?jGb7SXSTw7yJLoaVIroNYkUQTN0G5VsdiT/L7ecSo/a6MTNkWh9PxwTfPP?=
 =?iso-8859-1?Q?gpqbs4560wwG+4QxS82UjBc4NE5j9BnTtY0kqNMcR4Hb4hEaDqXzjIGY2Q?=
 =?iso-8859-1?Q?5TSwGPrjPWUJvbRjNgKTrTunnlvArXpWALinV/4eE9oLo4S8DBUKaAalJ6?=
 =?iso-8859-1?Q?FaDyiaGyZmaBJpzWt5jMtsorvd8gfZTTP4VmDUt1AqQC3ACJyMJ8StC+do?=
 =?iso-8859-1?Q?6k/rUHVTRCbWEH5r6xB+6dGDC8iUSWQcWXh0YZWiSF5UCDiF9AqJFupzWr?=
 =?iso-8859-1?Q?qX7EBsB6hiVv6qUvxK/9D02psAdnhNHpCK/mZN+zWiToZkNwsNhNxw+py+?=
 =?iso-8859-1?Q?I3y1C1R4feum8j6W4vQJU88UMbaVHnxFib1nKlxmT7qiQm+n6caZP7Uih5?=
 =?iso-8859-1?Q?bZKQJgO/v7M9XZT0/I0OSFuXOI7J0b2t0AsvO41cvChZqkLYf1OC6ZBXOI?=
 =?iso-8859-1?Q?gVvGFDI/Uro8Y5puEOlLcpoaeZIFY1IJ5iSBY9dplMFYHiriZGFmQTlCos?=
 =?iso-8859-1?Q?fcMx2FLN8SYCimLbB5h8FlnF7oZrerFeheUUbQ+1h31X3wMaD5Ead8qCyu?=
 =?iso-8859-1?Q?p+6/075OsjnfTwI2RvmKnwXsOIFt1WWSzj0LOi1atUPCoj8t/S2vEdvV88?=
 =?iso-8859-1?Q?DqVGhHv6Btr6xgzoJ0g2n6UvDltjyQp/QNkIv1xLmk0r5G52og/KAaMh7u?=
 =?iso-8859-1?Q?wlzBYCvQU5uslNn9nPzRsPTIIc/RAiK150bXmDqY05uUf2Fc6QHtl3Dl3Z?=
 =?iso-8859-1?Q?fOKbI1/cf6wriXY7J8FtaZVM/H4UvyImgGhU065mcnOlokPPMtthbKhOYh?=
 =?iso-8859-1?Q?I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR02MB6760.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?N0qfq71NSWrTtacFTDhDfa5HHWmndPZGMj1E8CB0Zu6xOfe0iahBRlxA8J?=
 =?iso-8859-1?Q?sb39HCzTOfUSXAjlO1RBcn3hBOrzs2BFjVdAvDBzV88hPSoQyzgRX/XUR2?=
 =?iso-8859-1?Q?gNoinLJB5rq5piRA6TvzbLkCIYVZdRqUoCveIK3mwNN9krkzi/XoVAfhGt?=
 =?iso-8859-1?Q?4Z6slKqesPSKiQPL6bW0fVhivZ41CMU4BeVAjlHbtjXtHLBThwBgObYVys?=
 =?iso-8859-1?Q?EDquW7RIOsCxGZ+acge7zyHg2iY3f72lGvIgfGyq2Fec8/Q7syjnRqdQXB?=
 =?iso-8859-1?Q?gfgiKGzF/hYPAydTPKykYNGwgWs2M4uUeeGYAiU6hdxxoaeZm2yBixECbL?=
 =?iso-8859-1?Q?ffPXJrAWxZJ0l10J+20yr9zGV6tr62qu+qDBMOnBfs0XM//k7eRet9ThSu?=
 =?iso-8859-1?Q?QzVKGbADrWUCiixsAb7b+8p7lQHATAf/eSFryikULO9jNUYZ1jTJ6tBWC5?=
 =?iso-8859-1?Q?vZZ4l+qld3WMzRihf6Bm9EVJHe5T0eoj4wJ4SdJGAIVa4r1q9DI8JnzZVP?=
 =?iso-8859-1?Q?e1BZ+ZplK8mJBxKC5QeY//3eNhJxFdZmH4XEuHG66nkpNtBN/aseo3tS/r?=
 =?iso-8859-1?Q?QfEtMSGF00R0tE9BwkNYI7z+QASBAbs6SADOST8fR+CYT1FtF/UnGWou9w?=
 =?iso-8859-1?Q?7oxiw3g37EzzITwwhGF5fdlwytxf4apCr0xaeBMKoyesnZ67BjLZnWCyY9?=
 =?iso-8859-1?Q?sU3h0vpXjydV8fK//ODnl/MgOWk7cI9FV59oPlUxJ5cuYbf6vf34wnJc4E?=
 =?iso-8859-1?Q?G8zjwGftdjKrFMf0ZpRqJtHP2yoy16QnVs+AtEblKMeSGk5sIZGWlD6CBR?=
 =?iso-8859-1?Q?5A0/6hoK5z7D0Nr+C+tjZTd1qiHK1R0BMq/jf3XZdPYTbZPbmCMex8riPz?=
 =?iso-8859-1?Q?cxUc7KYziERXNzWwb/Dng+oTfbuTzTpAbpv7eAbPdXzSQDAZql1tzl9l1D?=
 =?iso-8859-1?Q?Jd3KTNIf4sYlh7ARvoi+iIf8hvIdG5NmH8/gfsN8gl9bZau+C95pUVpBsP?=
 =?iso-8859-1?Q?t1Gn2cjFA2Y70TWGEUMny7bRtq1s2dvWxGVuqBWpBDaaBS+SgI+8IJ2akm?=
 =?iso-8859-1?Q?szkUg/oMuJBNTrjJW+5ncCVM4lPdFioQKwauAKLlerpCslfWyORMqMzWNd?=
 =?iso-8859-1?Q?BCpM99CL8u2EXb5ARtTL0e1OFPIu0wRpAUzJwZa0QSJb9sJwS9ur56mjja?=
 =?iso-8859-1?Q?QMxVcfPeY+Y9mrK9E8EftFubtWNBvc3WDQsdCVl0M+6ms7H+8626N5soph?=
 =?iso-8859-1?Q?+f8pGZDm9vKm1Sq+5aOLsuQJZqVSfnghWO2zq+nXGnKykbhoT01ZoL2/g7?=
 =?iso-8859-1?Q?YNFlLq64K2B+K/WILj8OqNSYxSKVevc6GXvhQOlAxpt51qPXhK7rMSHDqA?=
 =?iso-8859-1?Q?NQW6qIzVphl0XasugSNMP0OkJ0nZrM0+OIUG6mBT0+u+iUmHtFxl4Cjjd1?=
 =?iso-8859-1?Q?DZQeeggIyJBKVf2ACFhKtwz9FLAP9Jw++icRzhy3aSnWD83MzEh5gnmXN1?=
 =?iso-8859-1?Q?sLg3T5bH68uFseOadvX60bwpaKH1cv/c0yaz9NuQxMNIzcDheWeNNl+Fhv?=
 =?iso-8859-1?Q?4c03rGBacqNEx6OmFYaeVYlM533W69FVGc15UxXo0U8qunH2Qrjxx5y3rS?=
 =?iso-8859-1?Q?9o/kHv5TxbxWAL9WRHkQEUAK9fZzNHn5TZ?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 330130c4-b2e0-413c-ea38-08dd876f0d4b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR02MB6760.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 22:41:59.2522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hb4482ErBDcr39K9IdfOnFnKodXLhJDnihV2ULuqwSLqkXt0bwMXwQrJ2XgOO12aHMx8l9xE2UWrViNlaTzlzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR02MB10430
X-Proofpoint-GUID: n1i3Gl_HIrTmFCMBtLVyC3qy-kOzctOr
X-Authority-Analysis: v=2.4 cv=IugecK/g c=1 sm=1 tr=0 ts=681155b9 cx=c_pps
 a=K1+iGLXgNHoxMcL4Lb8acQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=XR8D0OoHHMoA:10 a=0kUYKlekyDsA:10 a=6mCx4M2ZX_vFk3heEUMA:9 a=3ZKOabzyN94A:10
 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDE2OCBTYWx0ZWRfX9LD4pT1BTyad
 yM+rDph5R/LdF1IVHRtwo9n6Nn7rhpW2GWxiB1Ao/NZkI8dV5If4LuPGn0h+ve7C1hyqXd7NMjH
 6+nhaIhQ/GDblGrC51cCKYl22P9StPHXjW0Yu7j72I8zseGwnz0bbuoXKQjIXv73xOvIH18jCxy
 Y17XEdHpeRrd20W4ntEM0Ps9ZHH9JwE7gt7AS/90MGD8p0zX1joTMngRyeFUQhztn0Ulwx6+r/J
 /rnQbgw4PFspu5Ygr+MZhBoLwrNEiwL5rnEZMt6kHxeMtrh4uwqAgfUsQussyNOY6ho6YOjwTsk
 QDLipytyvwBUOrCGmbbsF84ts+lWdWMTD9sXRyStblGRwIakGhM278/q6LLx1xG3PXNJjFMOJCV
 VEKIfC1/Kt9jO7km5VxJU0isISaC+wodYy0FHKbl7GNVQslZ41K92UThU8KSWLtXWyjG9fBN
X-Proofpoint-ORIG-GUID: n1i3Gl_HIrTmFCMBtLVyC3qy-kOzctOr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.151.68;
 envelope-from=john.levon@nutanix.com; helo=mx0a-002c1b01.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

On Mon, Apr 28, 2025 at 05:39:46PM +0200, Cédric Le Goater wrote:

> > +static void vfio_device_get_all_region_info(VFIODevice *vbasedev)
> > +{
> > +    struct vfio_region_info *info;
> > +    int i;
> > +
> > +    for (i = 0; i < vbasedev->num_regions; i++) {
> > +        vfio_device_get_region_info(vbasedev, i, &info);
> 
> if the vfio_device_get_all_region_info() routine queries *all* region
> infos to fill the ->reginfo[] cache array, why do we also need the
> lazy cache filling method in vfio_device_get_region_info() ? This looks
> redundant to me. I would rather have vfio_device_get_region_info()
> operate on the cache only.

I realised I'm not confident about doing this: in theory, a vfio device region
could later become valid based on some change in operation (and hence get region
info would then subsequently work post setup). Instead, I'm going to drop the
"get all" and operate only in caching mode, does that sound OK?

regards
john

