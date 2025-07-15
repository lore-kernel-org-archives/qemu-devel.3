Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DDDC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 09:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubbxA-0005mq-TL; Tue, 15 Jul 2025 05:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ubbwz-0005k7-TG; Tue, 15 Jul 2025 05:27:49 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1ubbwv-00057e-MH; Tue, 15 Jul 2025 05:27:49 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhDK63pJ4z6L5BN;
 Tue, 15 Jul 2025 17:24:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id EA0561402ED;
 Tue, 15 Jul 2025 17:27:39 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 15 Jul
 2025 11:27:39 +0200
Date: Tue, 15 Jul 2025 10:27:37 +0100
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <linuxarm@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>,
 <shameerkolothum@gmail.com>
Subject: Re: [RFC PATCH v3 03/15] hw/arm/smmu-common: Factor out common
 helper functions and export
Message-ID: <20250715102737.0000576a@huawei.com>
In-Reply-To: <20250714155941.22176-4-shameerali.kolothum.thodi@huawei.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-4-shameerali.kolothum.thodi@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 14 Jul 2025 16:59:29 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> Subsequent patches for smmuv3 accel support will make use of this.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Various trivial things inline.  In general looks fine.

J

> ---
>  hw/arm/smmu-common.c         | 48 ++++++++++++++++++++++--------------
>  include/hw/arm/smmu-common.h |  6 +++++
>  2 files changed, 36 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index ab920717cf..0f1a06cec2 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -847,12 +847,28 @@ SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num)
>      return NULL;
>  }
>  
> -static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
> +void smmu_init_sdev(SMMUState *s, SMMUDevice *sdev,
> +                    PCIBus *bus, int devfn)

It's trivial Tuesday.  Fits on one line.  Maybe fine to keep it like this if you
are going to modify this in later patches and this reduces the churn.


>  {
> -    SMMUState *s = opaque;
> -    SMMUPciBus *sbus = g_hash_table_lookup(s->smmu_pcibus_by_busptr, bus);
> -    SMMUDevice *sdev;
>      static unsigned int index;
> +    char *name = g_strdup_printf("%s-%d-%d", s->mrtypename, devfn, index++);
> +
> +    sdev->smmu = s;
> +    sdev->bus = bus;
> +    sdev->devfn = devfn;
> +
> +    memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
> +                             s->mrtypename,
> +                             OBJECT(s), name, UINT64_MAX);
Wrap was odd on original code, might as well tidy it up though as have a
little more width now.

    memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
                             s->mrtypename, OBJECT(s), name, UINT64_MAX);

> +    address_space_init(&sdev->as,
> +                       MEMORY_REGION(&sdev->iommu), name);
And this one.

    address_space_init(&sdev->as, MEMORY_REGION(&sdev->iommu), name);

> +    trace_smmu_add_mr(name);
> +    g_free(name);

Use g_autofree perhaps.

> +}
> +
> +SMMUPciBus *smmu_get_sbus(SMMUState *s, PCIBus *bus)
> +{
> +    SMMUPciBus *sbus = g_hash_table_lookup(s->smmu_pcibus_by_busptr, bus);
>  
>      if (!sbus) {
>          sbus = g_malloc0(sizeof(SMMUPciBus) +
> @@ -861,23 +877,19 @@ static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
>          g_hash_table_insert(s->smmu_pcibus_by_busptr, bus, sbus);
>      }
>  
> +    return sbus;
> +}
> +
> +static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
> +{
> +    SMMUDevice *sdev;

Why have this first?  Original order had it last.  I don't really care but
some sort of system is nicer than none.

> +    SMMUState *s = opaque;
> +    SMMUPciBus *sbus = smmu_get_sbus(s, bus);
> +
>      sdev = sbus->pbdev[devfn];
>      if (!sdev) {
> -        char *name = g_strdup_printf("%s-%d-%d", s->mrtypename, devfn, index++);
> -
>          sdev = sbus->pbdev[devfn] = g_new0(SMMUDevice, 1);
> -
> -        sdev->smmu = s;
> -        sdev->bus = bus;
> -        sdev->devfn = devfn;
> -
> -        memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
> -                                 s->mrtypename,
> -                                 OBJECT(s), name, UINT64_MAX);
> -        address_space_init(&sdev->as,
> -                           MEMORY_REGION(&sdev->iommu), name);
> -        trace_smmu_add_mr(name);
> -        g_free(name);
> +        smmu_init_sdev(s, sdev, bus, devfn);
>      }
>  
>      return &sdev->as;
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 80d0fecfde..c6f899e403 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -180,6 +180,12 @@ OBJECT_DECLARE_TYPE(SMMUState, SMMUBaseClass, ARM_SMMU)
>  /* Return the SMMUPciBus handle associated to a PCI bus number */
>  SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num);
>  
> +/* Return the SMMUPciBus handle associated to a PCI bus */
> +SMMUPciBus *smmu_get_sbus(SMMUState *s, PCIBus *bus);
> +
> +/* Initialize SMMUDevice handle associated to a SMMUPCIBus */
> +void smmu_init_sdev(SMMUState *s, SMMUDevice *sdev, PCIBus *bus, int devfn);
> +
>  /* Return the stream ID of an SMMU device */
>  static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
>  {


