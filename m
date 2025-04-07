Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C70C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 08:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1i7R-0000Pf-FP; Mon, 07 Apr 2025 04:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1u1i7N-0000Kp-Df; Mon, 07 Apr 2025 04:46:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1u1i7I-0005jt-IG; Mon, 07 Apr 2025 04:46:09 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 536Kdo14022054;
 Mon, 7 Apr 2025 08:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4TyK0Q
 wJ85lv3M3aLjfQaoBPQgmBi3RE0FIAtvV3sq8=; b=anjVIjFlNAsYY/1LMGPXGK
 kvZJlU0MjGcQiqhFqura3A/cIUUX/dq0MnYHjQlYZTD/D4SyAINW8BO9+gD44W6/
 PEPNI6xhIpYRlWjZr3eO/nVZUPKIdMKJ7TACuEDddD1MzBpB/x3SfLB5eWbWObBZ
 aBr6LOFgOdAMSvX9Zdm701J4//JTgAhyNeAEkPH++Jo9PmVW/uBYD3cEpFaxk8wn
 3X/gHiS+rY6xpBeG+CT9btCf9R9RrUmgcQuUMWTchphGHkEkYMWUw0waVJpOnwpt
 pPNq7yv2cQGU0VS3toAUZeuqXVj3e7klTAEj6vR4Mv7IDxfYaZdieyyBx5P0qD0Q
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45v0u0j95n-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Apr 2025 08:45:58 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5378cV24001970;
 Mon, 7 Apr 2025 08:45:58 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45v0u0j95m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Apr 2025 08:45:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5375n4jm025510;
 Mon, 7 Apr 2025 08:45:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ugbkmyjx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 07 Apr 2025 08:45:57 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5378jraM57475360
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 7 Apr 2025 08:45:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9923F2004B;
 Mon,  7 Apr 2025 08:45:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8462420040;
 Mon,  7 Apr 2025 08:45:51 +0000 (GMT)
Received: from li-e7e2bd4c-2dae-11b2-a85c-bfd29497117c.ibm.com (unknown
 [9.124.220.105])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon,  7 Apr 2025 08:45:51 +0000 (GMT)
Date: Mon, 7 Apr 2025 14:15:49 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 Vaibhav Jain <vaibhav@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] vfio/spapr: Fix L2 crash with PCI device passthrough
 with L2 guest memory > 128G
Message-ID: <20250407141331.a3e0c24b-fb-amachhiw@linux.ibm.com>
Mail-Followup-To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, 
 qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 Vaibhav Jain <vaibhav@linux.ibm.com>, 
 Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>
References: <20250404091721.2653539-1-amachhiw@linux.ibm.com>
 <1beef03c-ac75-4f25-8b39-0abf01384549@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1beef03c-ac75-4f25-8b39-0abf01384549@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _sXX6R3n_4JtwZSHHehLeEPN1zskN9kt
X-Proofpoint-GUID: SdpINmdfbP4q43w-TaKw5TjvmpYuphwQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_02,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound
 score=100 lowpriorityscore=0
 clxscore=1015 spamscore=100 priorityscore=1501 mlxscore=100
 impostorscore=0 phishscore=0 malwarescore=0 mlxlogscore=-999 bulkscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504070056
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi Cédric,

Thanks for looking into this patch. Please find my response inline:

On 2025/04/04 01:29 PM, Cédric Le Goater wrote:
> On 4/4/25 11:17, Amit Machhiwal wrote:
> > An L2 KVM guest fails to boot inside a pSeries LPAR when booted with a
> > memory more than 128 GB and PCI device passthrough. The L2 guest also
> > crashes when it is booted with a memory greater than 128 GB and a PCI
> > device is hotplugged later.
> > 
> > The issue arises from a conditional check for `levels > 1` in
> > `spapr_tce_create_table()` within L1 KVM. This check is meant to prevent
> > multi-level TCEs, which are not supported by the PowerVM hypervisor. As
> > a result, when QEMU makes a `VFIO_IOMMU_SPAPR_TCE_CREATE` ioctl call
> > with `levels > 1`, it triggers the conditional check and returns
> > `EINVAL`, causing the guest to crash with the following errors:
> > 
> >   2025-03-04T06:36:36.133117Z qemu-system-ppc64: Failed to create a window, ret = -1 (Invalid argument)
> >   2025-03-04T06:36:36.133176Z qemu-system-ppc64: Failed to create SPAPR window: Invalid argument
> >   qemu: hardware error: vfio: DMA mapping failed, unable to continue
> > 
> > Fix this by checking the supported DDW "levels" returned by the
> > VFIO_IOMMU_SPAPR_TCE_GET_INFO ioctl before attempting the TCE create
> > ioctl in KVM.
> > 
> > The patch has been tested on KVM guests with memory configurations of up
> > to 390GB, and 450GB on PowerVM and bare-metal environments respectively.
> > > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> >   hw/vfio/spapr.c | 35 ++++++++++++++++++++++++++---------
> >   1 file changed, 26 insertions(+), 9 deletions(-)
> > 
> > diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> > index 1a5d1611f2cd..07498218fea9 100644
> > --- a/hw/vfio/spapr.c
> > +++ b/hw/vfio/spapr.c
> > @@ -26,6 +26,7 @@ typedef struct VFIOSpaprContainer {
> >       VFIOContainer container;
> >       MemoryListener prereg_listener;
> >       QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
> > +    unsigned int levels;
> >   } VFIOSpaprContainer;
> >   OBJECT_DECLARE_SIMPLE_TYPE(VFIOSpaprContainer, VFIO_IOMMU_SPAPR);
> > @@ -236,9 +237,11 @@ static int vfio_spapr_create_window(VFIOContainer *container,
> >   {
> >       int ret = 0;
> >       VFIOContainerBase *bcontainer = &container->bcontainer;
> > +    VFIOSpaprContainer *scontainer = container_of(container, VFIOSpaprContainer,
> > +                                                  container);
> >       IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
> >       uint64_t pagesize = memory_region_iommu_get_min_page_size(iommu_mr), pgmask;
> > -    unsigned entries, bits_total, bits_per_level, max_levels;
> > +    unsigned entries, bits_total, bits_per_level, max_levels, ddw_levels;
> >       struct vfio_iommu_spapr_tce_create create = { .argsz = sizeof(create) };
> >       long rampagesize = qemu_minrampagesize();
> > @@ -291,16 +294,28 @@ static int vfio_spapr_create_window(VFIOContainer *container,
> >        */
> >       bits_per_level = ctz64(qemu_real_host_page_size()) + 8;
> >       create.levels = bits_total / bits_per_level;
> > -    if (bits_total % bits_per_level) {
> > -        ++create.levels;
> > -    }
> > -    max_levels = (64 - create.page_shift) / ctz64(qemu_real_host_page_size());
> > -    for ( ; create.levels <= max_levels; ++create.levels) {
> > -        ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
> > -        if (!ret) {
> > -            break;
> > +
> > +    ddw_levels = scontainer->levels;
> > +    if (ddw_levels > 1) {
> > +        if (bits_total % bits_per_level) {
> > +            ++create.levels;
> >           }
> > +        max_levels = (64 - create.page_shift) / ctz64(qemu_real_host_page_size());
> > +        for ( ; create.levels <= max_levels; ++create.levels) {
> > +            ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
> > +            if (!ret) {
> > +                break;
> > +            }
> > +        }
> > +    } else { /* ddw_levels == 1 */
> > +        if (create.levels > ddw_levels) {
> > +            error_report("Host doesn't support multi-level TCE tables. "
> > +                         "Use larger IO page size. Supported mask is 0x%lx",
> > +                         bcontainer->pgsizes);
> 
> While at it, please modify vfio_spapr_create_window(), add an 'Error **'
> parameter to report errors to the caller with error_setg(errp ...)

Sure, I'll include the suggested changes and send a v2 soon.

Thanks,
Amit

> 
> Thanks,
> 
> C.
> 
> 
> 
> 
> > +        }
> > +        ret = ioctl(container->fd, VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
> >       }
> > +
> >       if (ret) {
> >           error_report("Failed to create a window, ret = %d (%m)", ret);
> >           return -errno;
> > @@ -502,6 +517,8 @@ static bool vfio_spapr_container_setup(VFIOContainerBase *bcontainer,
> >           goto listener_unregister_exit;
> >       }
> > +    scontainer->levels = info.ddw.levels;
> > +
> >       if (v2) {
> >           bcontainer->pgsizes = info.ddw.pgsizes;
> >           /*
> > 
> > base-commit: 0adf626718bc0ca9c46550249a76047f8e45da15
> 

