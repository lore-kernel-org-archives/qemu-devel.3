Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C106DC3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 09:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u252S-0007Yi-8V; Tue, 08 Apr 2025 05:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1u252P-0007Xa-OI; Tue, 08 Apr 2025 05:14:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1u252K-00060x-St; Tue, 08 Apr 2025 05:14:32 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537LbRrV001033;
 Tue, 8 Apr 2025 09:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=h/f71N
 vn7FsSJa/NAxA8RaLfwxS/BRbGfnh40oozJSg=; b=h3Vj+czBpCP/gdh+jt4BDc
 zJGgpcgDI6IRsJ9fGlHpIRP6ALmRqzVAqrhkHgSr5eCZBzc/e5CtnhfLaCeCvJVg
 lp96tYLkfs/GO+1v9rWhuszUStm4MB92CbDwJ5OdIxLeEe6ni+r1Q4a5yv0fAUWd
 zyLv6KOH6KWJOBILxJG27p8JXzgJwnTEX1i/SoUkLV/66hEGeZpl7cTFYW0Comcu
 xSe+H1Yu3F2cePyPfxnjuUYBsYXWvzCYzvQPPq7ruQP08H26x5DCweJJkqUrPEW+
 I5HcD8+Q2b3EV8609HS8K2ni7YASAlAIwffRNqTR+ATqhde+uQKKQExCJSMjOsbQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ver7d9c6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 09:14:24 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53892OgV030509;
 Tue, 8 Apr 2025 09:14:24 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ver7d9c4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 09:14:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5388NxFH025510;
 Tue, 8 Apr 2025 09:14:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ugbksvb8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Apr 2025 09:14:22 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5389EJN846072304
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Apr 2025 09:14:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E816B2004D;
 Tue,  8 Apr 2025 09:14:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A9E5120043;
 Tue,  8 Apr 2025 09:14:16 +0000 (GMT)
Received: from li-e7e2bd4c-2dae-11b2-a85c-bfd29497117c.ibm.com (unknown
 [9.109.198.22])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue,  8 Apr 2025 09:14:16 +0000 (GMT)
Date: Tue, 8 Apr 2025 14:44:13 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v2 1/2] vfio/spapr: Enhance error handling in
 vfio_spapr_create_window()
Message-ID: <20250408135041.9eaee011-8a-amachhiw@linux.ibm.com>
Mail-Followup-To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, 
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 Vaibhav Jain <vaibhav@linux.ibm.com>, 
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>
References: <20250407143119.1304513-1-amachhiw@linux.ibm.com>
 <10a60957-21a1-4254-885b-21829d9746e6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10a60957-21a1-4254-885b-21829d9746e6@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: g93zRypVenaAz4Kuqh6BkxZjubXV1-gq
X-Proofpoint-GUID: D5mzNNkMoZJA1MjB1LKnEDWCC9fZQepY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound
 score=100 suspectscore=0
 phishscore=0 mlxlogscore=-999 clxscore=1015 impostorscore=0 adultscore=0
 mlxscore=100 spamscore=100 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080064
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

Hi Cédric,

Thanks for taking a look at this patch. Please find my responses below:

On 2025/04/08 08:29 AM, Cédric Le Goater wrote:
> Hello Amit,
> 
> Please use --cover-letter for the next spin.

Sure, will do.

> 
> 
> On 4/7/25 16:31, Amit Machhiwal wrote:
> > Introduce an Error ** parameter to vfio_spapr_create_window() to enable
> > structured error reporting. This allows the function to propagate
> > detailed errors back to callers.
> > 
> > Suggested-by: Cédric Le Goater <clg@redhat.com>
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> >   hw/vfio/spapr.c | 23 ++++++++++++-----------
> >   1 file changed, 12 insertions(+), 11 deletions(-)
> > 
> > diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> > index 1a5d1611f2cd..4f2858b43f36 100644
> > --- a/hw/vfio/spapr.c
> > +++ b/hw/vfio/spapr.c
> > @@ -232,7 +232,7 @@ static int vfio_spapr_remove_window(VFIOContainer *container,
> >   static int vfio_spapr_create_window(VFIOContainer *container,
> 
> This routine can return a bool since vfio_spapr_container_add_section_window()
> does not check the returned errno.

Sure, I can make this change in next version.

> 
> >                                       MemoryRegionSection *section,
> > -                                    hwaddr *pgsize)
> > +                                    hwaddr *pgsize, Error **errp)
> >   {
> >       int ret = 0;
> >       VFIOContainerBase *bcontainer = &container->bcontainer;
> > @@ -252,10 +252,10 @@ static int vfio_spapr_create_window(VFIOContainer *container,
> >       pgmask = bcontainer->pgsizes & (pagesize | (pagesize - 1));
> >       pagesize = pgmask ? (1ULL << (63 - clz64(pgmask))) : 0;
> >       if (!pagesize) {
> > -        error_report("Host doesn't support page size 0x%"PRIx64
> > -                     ", the supported mask is 0x%lx",
> > -                     memory_region_iommu_get_min_page_size(iommu_mr),
> > -                     bcontainer->pgsizes);
> > +        error_setg(errp, "Host doesn't support page size 0x%"PRIx64
> > +                   ", the supported mask is 0x%lx",
> > +                   memory_region_iommu_get_min_page_size(iommu_mr),
> > +                   bcontainer->pgsizes);
> 
> This can use error_setg_errno(errp, EINVAL, ... ) instead of
> returning -EINVAL.

Sure.

> 
> >           return -EINVAL;
> >       }
> > @@ -302,16 +302,16 @@ static int vfio_spapr_create_window(VFIOContainer *container,
> >           }
> >       }
> >       if (ret) {
> > -        error_report("Failed to create a window, ret = %d (%m)", ret);
> > +        error_setg_errno(errp, -ret, "Failed to create a window, ret = %d (%m)", ret);
> >           return -errno;
> >       }
> >       if (create.start_addr != section->offset_within_address_space) {
> >           vfio_spapr_remove_window(container, create.start_addr);
> > -        error_report("Host doesn't support DMA window at %"HWADDR_PRIx", must be %"PRIx64,
> > -                     section->offset_within_address_space,
> > -                     (uint64_t)create.start_addr);
> > +        error_setg(errp, "Host doesn't support DMA window at %"HWADDR_PRIx
> > +                   ", must be %"PRIx64, section->offset_within_address_space,
> > +                   (uint64_t)create.start_addr);
> 
> This can use error_setg_errno(errp, EINVAL, ... ) instead of
> returning -EINVAL.

Sure.

> 
> >           return -EINVAL;
> >       }
> >       trace_vfio_spapr_create_window(create.page_shift,
> > @@ -334,6 +334,7 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
> >                                                     container);
> >       VFIOHostDMAWindow *hostwin;
> >       hwaddr pgsize = 0;
> > +    Error *local_err = NULL;
> >       int ret;>         /*
> > @@ -377,9 +378,9 @@ vfio_spapr_container_add_section_window(VFIOContainerBase *bcontainer,
> >           }
> >       }
> > -    ret = vfio_spapr_create_window(container, section, &pgsize);
> > +    ret = vfio_spapr_create_window(container, section, &pgsize, &local_err);
> 
> please pass errp instead.
> 
> >       if (ret) {
> > -        error_setg_errno(errp, -ret, "Failed to create SPAPR window");
> > +        error_propagate(errp, local_err);
> 
> no need to propagate if errp is passed to vfio_spapr_create_window()

As per my understanding, for calling error_setg() and friends, the Error **
object has be NULL. If I were to call vfio_spapr_create_window() with errp
instead of the local Error object, that'd result into the below assertion
failure with only the first patch applied and a guest booted with a memory >
128G and PCI device passthrough:

 qemu-system-ppc64: ../util/error.c:68: error_setv: Assertion `*errp == NULL' failed.

This happens because the errp would already be set in vfio_spapr_create_window()
and calling error_setg_errno(errp, ...) in vfio_spapr_container_add_section_window()
would fail as errp is no more NULL. This is the reason I chose to use a local
Error object and later propagate it with errp.

IIUC, what you mean is to pass errp in vfio_spapr_create_window() and just
return from this condition in vfio_spapr_container_add_section_window() but no
need to call error_setg_errno() or error_propagate(). I think that would work.
Please correct me.

Thanks,
Amit

> 
> 
> Thanks,
> 
> C.
> 
> 
> >           return false;
> >       }
> > 
> > base-commit: 53f3a13ac1069975ad47cf8bd05cc96b4ac09962
> 

