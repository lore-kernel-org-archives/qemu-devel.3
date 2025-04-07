Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA78C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 14:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1nUm-0004jF-5e; Mon, 07 Apr 2025 10:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1u1nUb-0004iB-Hi; Mon, 07 Apr 2025 10:30:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1u1nUZ-0007M1-Ls; Mon, 07 Apr 2025 10:30:29 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537CSLPH032692;
 Mon, 7 Apr 2025 14:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=D76q6r
 mJVZl93f6uzhGGC+NmFzeO8uL5L2QKzu9QGJ8=; b=oGoq89qwxu3MB7SirsVN2w
 /DYkhoJWdMUCNZD1dicbNGX4fbhh87BcPBPtpOuSRmjkAcHrT/TeJIJReG8BWzBc
 WZhAJpUoU/cNQNd7pNlGSCbGoH8p1PBLAwqyTireqA290/1ZSvp1Zl/ZqsKGlXbr
 igNkmuefAoFxsmFu3sIVzn8Z2Y6/LyyfqhbrRSvqCPSrMuci5RzdSf78AkI5u61+
 JcB067N9HGwyhUZ/da8vUqib3YnxpxgBdxqRcoP1tv/YhPjYcQww5m76CDgiiily
 YbS0qiWW9ED2NpyLuQtzoQHrYjHgVYjMrKiIh/xOQtNw/MzZl6Je3CF3pvpmf8yQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ver78nhb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Apr 2025 14:30:25 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 537E8t3h007760;
 Mon, 7 Apr 2025 14:30:24 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ver78nh6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Apr 2025 14:30:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 537AX1Sh017825;
 Mon, 7 Apr 2025 14:30:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2ke00h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Apr 2025 14:30:23 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 537EUKUb57606608
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Apr 2025 14:30:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6A61220043;
 Mon,  7 Apr 2025 14:30:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01A412004B;
 Mon,  7 Apr 2025 14:30:18 +0000 (GMT)
Received: from li-e7e2bd4c-2dae-11b2-a85c-bfd29497117c.ibm.com (unknown
 [9.124.220.105])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon,  7 Apr 2025 14:30:17 +0000 (GMT)
Date: Mon, 7 Apr 2025 20:00:15 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Amit Machhiwal <amachhiw@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH 1/2] vfio/spapr: Enhance error handling in
 vfio_spapr_create_window()
Message-ID: <20250407195900.3f9fcc7f-2b-amachhiw@linux.ibm.com>
Mail-Followup-To: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 Vaibhav Jain <vaibhav@linux.ibm.com>, 
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
References: <20250407142337.1272599-1-amachhiw@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250407142337.1272599-1-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DVa3d-5xJ94bh-oyM90sTtT7lhOSp8vu
X-Proofpoint-GUID: 6_DFJ-bWvKEudcip-kAnXWipz44ZrpkO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_04,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound
 score=100 suspectscore=0
 phishscore=0 mlxlogscore=-999 clxscore=1015 impostorscore=0 adultscore=0
 mlxscore=100 spamscore=100 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504070102
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Please ignore this patchset as I missed to add version information in it. I'll
resend these patches shortly. Sorry for the noise.

Thanks,
Amit

On 2025/04/07 07:53 PM, Amit Machhiwal wrote:
> Introduce an Error ** parameter to vfio_spapr_create_window() to enable
> structured error reporting. This allows the function to propagate
> detailed errors back to callers.
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
>  hw/vfio/spapr.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 1a5d1611f2cd..4f2858b43f36 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -232,7 +232,7 @@ static int vfio_spapr_remove_window(VFIOContainer *container,
>  
>  static int vfio_spapr_create_window(VFIOContainer *container,
>                                      MemoryRegionSection *section,
> -                                    hwaddr *pgsize)
> +                                    hwaddr *pgsize, Error **errp)
>  {
>      int ret = 0;
>      VFIOContainerBase *bcontainer = &container->bcontainer;
> @@ -252,10 +252,10 @@ static int vfio_spapr_create_window(VFIOContainer *container,
>      pgmask = bcontainer->pgsizes & (pagesize | (pagesize - 1));
>      pagesize = pgmask ? (1ULL << (63 - clz64(pgmask))) : 0;
>      if (!pagesize) {
> -        error_report("Host doesn't support page size 0x%"PRIx64
> -                     ", the supported mask is 0x%lx",
> -                     memory_region_iommu_get_min_page_size(iommu_mr),
> -                     bcontainer->pgsizes);
> +        error_setg(errp, "Host doesn't support page size 0x%"PRIx64
> +                   ", the supported mask is 0x%lx",
> +                   memory_region_iommu_get_min_page_size(iommu_mr),
> +                   bcontainer->pgsizes);
>          return -EINVAL;
>      }
>  
> @@ -302,16 +302,16 @@ static int vfio_spapr_create_window(VFIOContainer *container,
>          }
>      }
>      if (ret) {
> -        error_report("Failed to create a window, ret = %d (%m)", ret);
> +        error_setg_errno(errp, -ret, "Failed to create a window, ret = %d (%m)", ret);
>          return -errno;
>      }
>  
>      if (create.start_addr != section->offset_within_address_space) {
>          vfio_spapr_remove_window(container, create.start_addr);
>  
> -        error_report("Host doesn't support DMA window at %"HWADDR_PRIx", must be %"PRIx64,
> -                     section->offset_within_address_space,
> -                     (uint64_t)create.start_addr);
> +        error_setg(errp, "Host doesn't support DMA window at %"HWADDR_PRIx
> +                   ", must be %"PRIx64, section->offset_within_address_space,
> +                   (uint64_t)create.start_addr);
>          return -EINVAL;
>      }
>      trace_vfio_spapr_create_window(create.page_shift,
> @@ -334,6 +334,7 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
>                                                    container);
>      VFIOHostDMAWindow *hostwin;
>      hwaddr pgsize = 0;
> +    Error *local_err = NULL;
>      int ret;
>  
>      /*
> @@ -377,9 +378,9 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
>          }
>      }
>  
> -    ret = vfio_spapr_create_window(container, section, &pgsize);
> +    ret = vfio_spapr_create_window(container, section, &pgsize, &local_err);
>      if (ret) {
> -        error_setg_errno(errp, -ret, "Failed to create SPAPR window");
> +        error_propagate(errp, local_err);
>          return false;
>      }
>  
> 
> base-commit: 53f3a13ac1069975ad47cf8bd05cc96b4ac09962
> -- 
> 2.49.0
> 

