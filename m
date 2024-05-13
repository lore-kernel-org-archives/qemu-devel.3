Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C63C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 12:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Uih-0002hA-0e; Mon, 13 May 2024 08:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=xtei=MQ=kaod.org=clg@ozlabs.org>)
 id 1s6Uib-0002ga-Jk; Mon, 13 May 2024 08:23:50 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=xtei=MQ=kaod.org=clg@ozlabs.org>)
 id 1s6UiZ-0003GR-1A; Mon, 13 May 2024 08:23:49 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VdJYn6GvKz4wxt;
 Mon, 13 May 2024 22:23:41 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VdJYk2lG3z4wyl;
 Mon, 13 May 2024 22:23:38 +1000 (AEST)
Message-ID: <30e9ce3e-08d4-4ab4-b734-d7a7fb0639a9@kaod.org>
Date: Mon, 13 May 2024 14:23:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: container: Fix missing allocation of
 VFIOSpaprContainer
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>, harshpb@linux.ibm.com,
 npiggin@gmail.com
Cc: danielhb413@gmail.com, david@gibson.dropbear.id.au,
 alex.williamson@redhat.com, qemu-ppc@nongnu.org, zhenzhong.duan@intel.com,
 qemu-devel@nongnu.org
References: <171528203026.8420.10620440513237875837.stgit@ltcd48-lp2.aus.stglabs.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <171528203026.8420.10620440513237875837.stgit@ltcd48-lp2.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=xtei=MQ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Shivaprasad,

On 5/9/24 21:14, Shivaprasad G Bhat wrote:
> The commit 6ad359ec29 "(vfio/spapr: Move prereg_listener into
> spapr container)" began to use the newly introduced VFIOSpaprContainer
> structure.
> 
> After several refactors, today the container_of(container,
> VFIOSpaprContainer, ABC) is used when VFIOSpaprContainer is actually
> not allocated. On PPC64 systems, this dereference is leading to corruption
> showing up as glibc malloc assertion during guest start when using vfio.
> 
> Patch adds the missing allocation while also making the structure movement
> to vfio common header file.
> 
> Fixes: 6ad359ec29 "(vfio/spapr: Move prereg_listener into spapr container)"
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
>   hw/vfio/container.c           |    6 ++++--
>   hw/vfio/spapr.c               |    6 ------
>   include/hw/vfio/vfio-common.h |    6 ++++++
>   3 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 77bdec276e..ecaf5786d9 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -539,6 +539,7 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>   {
>       VFIOContainer *container;
>       VFIOContainerBase *bcontainer;
> +    VFIOSpaprContainer *scontainer;

We should do our best to avoid any direct use of ppc related attributes
in the common VFIO code. This comment also applies to VFIO_SPAPR_TCE*
which are still there because the clean up is not finished. So, this
proposal will have to be reworked.

The first step is to finish the QOMification of VFIOContainer, so
that the VFIOContainer instance is created in vfio_connect_container()
with :

     container = qdev_new(iommu_type_name);

This means reworking this part (and vfio_set_iommu()) :

     ...
     container = g_malloc0(sizeof(*container));
     container->fd = fd;
     bcontainer = &container->bcontainer;

     if (!vfio_set_iommu(container, group->fd, space, errp)) {
         goto free_container_exit;
     }
     ...

VFIOSpaprContainer can then implement its own .init_instance() handler
to allocate/initialize attributes required by the pseries machines.

While doing this, please try to reduce the use of ->iommu_type which
is a design shortcut. I would like to completely remove it at some
point.

Thanks,

C.







>       int ret, fd;
>       VFIOAddressSpace *space;
> 
> @@ -611,7 +612,8 @@ static int vfio_connect_container(VFIOGroup *group, AddressSpace *as,
>           goto close_fd_exit;
>       }
> 
> -    container = g_malloc0(sizeof(*container));
> +    scontainer = g_malloc0(sizeof(*scontainer));
> +    container = &scontainer->container;
>       container->fd = fd;
>       bcontainer = &container->bcontainer;
> 
> @@ -675,7 +677,7 @@ unregister_container_exit:
>       vfio_cpr_unregister_container(bcontainer);
> 
>   free_container_exit:
> -    g_free(container);
> +    g_free(scontainer);
> 
>   close_fd_exit:
>       close(fd);
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index 0d949bb728..78d218b7e7 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -24,12 +24,6 @@
>   #include "qapi/error.h"
>   #include "trace.h"
> 
> -typedef struct VFIOSpaprContainer {
> -    VFIOContainer container;
> -    MemoryListener prereg_listener;
> -    QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
> -} VFIOSpaprContainer;
> -
>   static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *section)
>   {
>       if (memory_region_is_iommu(section->mr)) {
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index b9da6c08ef..010fa68ac6 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -82,6 +82,12 @@ typedef struct VFIOContainer {
>       QLIST_HEAD(, VFIOGroup) group_list;
>   } VFIOContainer;
> 
> +typedef struct VFIOSpaprContainer {
> +    VFIOContainer container;
> +    MemoryListener prereg_listener;
> +    QLIST_HEAD(, VFIOHostDMAWindow) hostwin_list;
> +} VFIOSpaprContainer;
> +
>   typedef struct VFIOHostDMAWindow {
>       hwaddr min_iova;
>       hwaddr max_iova;
> 
> 


