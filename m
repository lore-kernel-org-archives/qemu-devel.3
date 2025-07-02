Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F8AC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 15:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWzUc-0000gc-U4; Wed, 02 Jul 2025 11:35:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uWzUW-0000bN-Hn
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:35:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uWzUO-0006l7-1L
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 11:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751470508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vnoQGA+anaExPPn8GdU9KFJTUDtCi8eUA5AnwOdtbcE=;
 b=bn1IPeMYnlSq25kDVElwv0JuM77xgkOdAN5G4LT5sRbU1D0SGIzrWWONw/uJj6p7Jm6jAJ
 P8cDoupezUfPPq0OCBJ/8NyKU4oeAU6CyCXBG8T+ldMtqYAgCPeL284dUfxGdirFpYnoSE
 bA7MhOluYop0NmslFdaL24N8CgteAsI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-4VnOHB99PCauhfvC9-rL4w-1; Wed, 02 Jul 2025 11:35:07 -0400
X-MC-Unique: 4VnOHB99PCauhfvC9-rL4w-1
X-Mimecast-MFC-AGG-ID: 4VnOHB99PCauhfvC9-rL4w_1751470506
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4e713e05bso2308010f8f.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 08:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751470506; x=1752075306;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vnoQGA+anaExPPn8GdU9KFJTUDtCi8eUA5AnwOdtbcE=;
 b=qu/JA9KG9lsgpDC8lXuZ1a86H2IdPSCMa2eXmtxn1JBeBxs9+Htt2O1Q/+jgzkKjDO
 +nuScuRuf/3x6bN8UGF9nozg+MvYYyxuFdQ94zydZHFks4tJuJMSmP8I6lct02TYPxSz
 EOrv0D3b+X64J+2xlewqLCUbXojkgvvN+5MffXU8bupCeDKX702+HrnMs/k2HCwSvkcQ
 n9Q6GDm6NfDUQn658cfheRvIWi533KLFaLOH7UYEYugO3EszvVptiVsopy8Iz60BrGuK
 lyAmTeRhRv1czyOHaEpvaRRV1K7MNWIbv5H4uVS3u7eSP0+hwOGjgApk9RSlbtgoGuYO
 aw6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXayhacBh/9uHJhrYhWYnQoER3CgRkQLeqp+7w8ZkVwvA1pltth5FaC/ntwRZfvZy9T/2uY8Asdhd8a@nongnu.org
X-Gm-Message-State: AOJu0Ywn/tpx6+ZHB6IIaKdDfsg5uwSV6P+H28ZmDDrwckdUFL7fYPVc
 uxkzB/gYcI/FVpp1pRDMkUpShVjzT+WBzK9+TXfksEwoJJvQPSyM0uSxycrb+7NrXo9aktO6Kjl
 Hj2fZla8np0Ydtg5l9HiE+mCa0U8Cw7TRCo69VUplB/HMG85i5QWaPCEQ
X-Gm-Gg: ASbGncuppgEEKDCUoeX4ohIHwi6+5ndLJo5k99I1RKKbsz2R85l6AC7BvD5cz9lR8K9
 NxwFhJB581zQHKkTF5ius+8Nc0pY4eaeeA7wPehfFEANng5RQMfL1H7jndrxoQslQOtM/pC4UQJ
 vGZPfvzljKcse98I8CKckcTjviDl1HKQyaxupY4BZKRyY25qeRcqg6eQ35GwclTRUrDf/Wxaoj9
 ddAIuTpb8QobSxYeGp/tFVvGpsToaHLgVv+n5lbsvmvykkq0567+dS9kUZ+QDzSp3G07C1Z+eVK
 gVLhrmDGRqMVUpItw/sRoE6JrS+tweR9/zaNEDCsajdr1MGeruSdZTztn1ui
X-Received: by 2002:a05:6000:717:b0:3a4:eec5:441c with SMTP id
 ffacd0b85a97d-3b2013efefemr2374585f8f.47.1751470505817; 
 Wed, 02 Jul 2025 08:35:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDi3iMX2MfrIQuv7jkqp3hsHiMWJOn+besROMMjYajuwDlujrlF0TbylyMpz3Az6gWlXmyYA==
X-Received: by 2002:a05:6000:717:b0:3a4:eec5:441c with SMTP id
 ffacd0b85a97d-3b2013efefemr2374564f8f.47.1751470505295; 
 Wed, 02 Jul 2025 08:35:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52cbasm16526311f8f.62.2025.07.02.08.35.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 08:35:04 -0700 (PDT)
Message-ID: <131c53a1-ab58-460f-a47c-facfc256a7bb@redhat.com>
Date: Wed, 2 Jul 2025 17:35:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 18/38] vfio-pci: preserve MSI
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-19-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1749569991-25171-19-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 6/10/25 17:39, Steve Sistare wrote:
> Save the MSI message area as part of vfio-pci vmstate, and preserve the
> interrupt and notifier eventfd's.  migrate_incoming loads the MSI data,
> then the vfio-pci post_load handler finds the eventfds in CPR state,
> rebuilds vector data structures, and attaches the interrupts to the new
> KVM instance.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/pci.h              |  2 +
>   include/hw/vfio/vfio-cpr.h |  8 ++++
>   hw/vfio/cpr.c              | 97 ++++++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/pci.c              | 54 ++++++++++++++++++++++++--
>   4 files changed, 158 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
> index 6e4840d..4d1203c 100644
> --- a/hw/vfio/pci.h
> +++ b/hw/vfio/pci.h
> @@ -217,6 +217,8 @@ void vfio_pci_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
>   void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
>   void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
>   bool vfio_pci_intx_enable(VFIOPCIDevice *vdev, Error **errp);
> +void vfio_pci_msix_set_notifiers(VFIOPCIDevice *vdev);
> +void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr);
>   
>   uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
>   void vfio_pci_write_config(PCIDevice *pdev,
> diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
> index 8bf85b9..25e74ee 100644
> --- a/include/hw/vfio/vfio-cpr.h
> +++ b/include/hw/vfio/vfio-cpr.h
> @@ -15,6 +15,7 @@
>   struct VFIOContainer;
>   struct VFIOContainerBase;
>   struct VFIOGroup;
> +struct VFIOPCIDevice;
>   
>   typedef struct VFIOContainerCPR {
>       Error *blocker;
> @@ -52,6 +53,13 @@ void vfio_cpr_giommu_remap(struct VFIOContainerBase *bcontainer,
>   bool vfio_cpr_ram_discard_register_listener(
>       struct VFIOContainerBase *bcontainer, MemoryRegionSection *section);
>   
> +void vfio_cpr_save_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
> +                             int nr, int fd);
> +int vfio_cpr_load_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
> +                            int nr);
> +void vfio_cpr_delete_vector_fd(struct VFIOPCIDevice *vdev, const char *name,
> +                               int nr);
> +
>   extern const VMStateDescription vfio_cpr_pci_vmstate;
>   
>   #endif /* HW_VFIO_VFIO_CPR_H */
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index fdbb58e..e467373 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -9,6 +9,8 @@
>   #include "hw/vfio/vfio-device.h"
>   #include "hw/vfio/vfio-cpr.h"
>   #include "hw/vfio/pci.h"
> +#include "hw/pci/msix.h"
> +#include "hw/pci/msi.h"
>   #include "migration/cpr.h"
>   #include "qapi/error.h"
>   #include "system/runstate.h"
> @@ -40,6 +42,69 @@ void vfio_cpr_unregister_container(VFIOContainerBase *bcontainer)
>       migration_remove_notifier(&bcontainer->cpr_reboot_notifier);
>   }
>   
> +#define STRDUP_VECTOR_FD_NAME(vdev, name)   \
> +    g_strdup_printf("%s_%s", (vdev)->vbasedev.name, (name))
> +
> +void vfio_cpr_save_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr,
> +                             int fd)
> +{
> +    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
> +    cpr_save_fd(fdname, nr, fd);
> +}
> +
> +int vfio_cpr_load_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr)
> +{
> +    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
> +    return cpr_find_fd(fdname, nr);
> +}
> +
> +void vfio_cpr_delete_vector_fd(VFIOPCIDevice *vdev, const char *name, int nr)
> +{
> +    g_autofree char *fdname = STRDUP_VECTOR_FD_NAME(vdev, name);
> +    cpr_delete_fd(fdname, nr);
> +}
> +
> +static void vfio_cpr_claim_vectors(VFIOPCIDevice *vdev, int nr_vectors,
> +                                   bool msix)
> +{
> +    int i, fd;
> +    bool pending = false;
> +    PCIDevice *pdev = &vdev->pdev;
> +
> +    vdev->nr_vectors = nr_vectors;
> +    vdev->msi_vectors = g_new0(VFIOMSIVector, nr_vectors);
> +    vdev->interrupt = msix ? VFIO_INT_MSIX : VFIO_INT_MSI;
> +
> +    vfio_pci_prepare_kvm_msi_virq_batch(vdev);
> +
> +    for (i = 0; i < nr_vectors; i++) {
> +        VFIOMSIVector *vector = &vdev->msi_vectors[i];
> +
> +        fd = vfio_cpr_load_vector_fd(vdev, "interrupt", i);
> +        if (fd >= 0) {
> +            vfio_pci_vector_init(vdev, i);
> +            vfio_pci_msi_set_handler(vdev, i);
> +        }
> +
> +        if (vfio_cpr_load_vector_fd(vdev, "kvm_interrupt", i) >= 0) {
> +            vfio_pci_add_kvm_msi_virq(vdev, vector, i, msix);
> +        } else {
> +            vdev->msi_vectors[i].virq = -1;
> +        }
> +
> +        if (msix && msix_is_pending(pdev, i) && msix_is_masked(pdev, i)) {
> +            set_bit(i, vdev->msix->pending);
> +            pending = true;
> +        }
> +    }
> +
> +    vfio_pci_commit_kvm_msi_virq_batch(vdev);
> +
> +    if (msix) {
> +        memory_region_set_enabled(&pdev->msix_pba_mmio, pending);
> +    }
> +}
> +
>   /*
>    * The kernel may change non-emulated config bits.  Exclude them from the
>    * changed-bits check in get_pci_config_device.
> @@ -58,13 +123,45 @@ static int vfio_cpr_pci_pre_load(void *opaque)
>       return 0;
>   }
>   
> +static int vfio_cpr_pci_post_load(void *opaque, int version_id)
> +{
> +    VFIOPCIDevice *vdev = opaque;
> +    PCIDevice *pdev = &vdev->pdev;
> +    int nr_vectors;
> +
> +    if (msix_enabled(pdev)) {
> +        vfio_pci_msix_set_notifiers(vdev);
> +        nr_vectors = vdev->msix->entries;
> +        vfio_cpr_claim_vectors(vdev, nr_vectors, true);
> +
> +    } else if (msi_enabled(pdev)) {
> +        nr_vectors = msi_nr_vectors_allocated(pdev);
> +        vfio_cpr_claim_vectors(vdev, nr_vectors, false);
> +
> +    } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
> +        g_assert_not_reached();      /* completed in a subsequent patch */
> +    }
> +
> +    return 0;
> +}
> +
> +static bool pci_msix_present(void *opaque, int version_id)
> +{
> +    PCIDevice *pdev = opaque;
> +
> +    return msix_present(pdev);
> +}
> +
>   const VMStateDescription vfio_cpr_pci_vmstate = {
>       .name = "vfio-cpr-pci",
>       .version_id = 0,
>       .minimum_version_id = 0,
>       .pre_load = vfio_cpr_pci_pre_load,
> +    .post_load = vfio_cpr_pci_post_load,
>       .needed = cpr_incoming_needed,
>       .fields = (VMStateField[]) {
> +        VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
> +        VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, pci_msix_present),
>           VMSTATE_END_OF_LIST()
>       }
>   };
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 4cda6dc..b3dbb84 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -29,6 +29,7 @@
>   #include "hw/pci/pci_bridge.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/qdev-properties-system.h"
> +#include "hw/vfio/vfio-cpr.h"
>   #include "migration/vmstate.h"
>   #include "migration/cpr.h"
>   #include "qobject/qdict.h"
> @@ -57,13 +58,25 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
>   static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
>   static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
>   
> +/* Create new or reuse existing eventfd */
>   static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>                                  const char *name, int nr, Error **errp)
>   {
> -    int ret = event_notifier_init(e, 0);
> +    int fd = vfio_cpr_load_vector_fd(vdev, name, nr);

Since this is a "complex" initialization, I would prefer it to
be done ...

> +    int ret = 0;
>   
> -    if (ret) {
> -        error_setg_errno(errp, -ret, "vfio_notifier_init %s failed", name);

... here :

        fd = vfio_cpr_load_vector_fd(vdev, name, nr);

> +    if (fd >= 0) {
> +        event_notifier_init_fd(e, fd);
> +    } else {
> +        ret = event_notifier_init(e, 0);
> +        if (ret) {
> +            error_setg_errno(errp, -ret, "vfio_notifier_init %s failed", name);
> +        } else {
> +            fd = event_notifier_get_fd(e);
> +            if (fd >= 0) {
> +                vfio_cpr_save_vector_fd(vdev, name, nr, fd);
> +            }
> +        }

Instead of preserving the ending return, could you please rework the
if statements to return asap. I think it would clarify the routine.

>       }
>       return !ret;
>   }
> @@ -71,6 +84,7 @@ static bool vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>   static void vfio_notifier_cleanup(VFIOPCIDevice *vdev, EventNotifier *e,
>                                     const char *name, int nr)
>   {
> +    vfio_cpr_delete_vector_fd(vdev, name, nr);
>       event_notifier_cleanup(e);
>   }
>   
> @@ -394,6 +408,14 @@ static void vfio_msi_interrupt(void *opaque)
>       notify(&vdev->pdev, nr);
>   }
>   
> +void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr)
> +{
> +    VFIOMSIVector *vector = &vdev->msi_vectors[nr];
> +    int fd = event_notifier_get_fd(&vector->interrupt);
> +
> +    qemu_set_fd_handler(fd, vfio_msi_interrupt, NULL, vector);
> +}
> +
>   /*
>    * Get MSI-X enabled, but no vector enabled, by setting vector 0 with an invalid
>    * fd to kernel.
> @@ -580,6 +602,15 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>       int ret;
>       bool resizing = !!(vdev->nr_vectors < nr + 1);
>   
> +    /*
> +     * Ignore the callback from msix_set_vector_notifiers during resume.
> +     * The necessary subset of these actions is called from
> +     * vfio_cpr_claim_vectors during post load.
> +     */
> +    if (cpr_is_incoming()) {
> +        return 0;
> +    }
> +

This test could be moved in vfio_msix_vector_use().

The rest looks fine.


Thanks,

C.



>       trace_vfio_msix_vector_do_use(vdev->vbasedev.name, nr);
>   
>       vector = &vdev->msi_vectors[nr];
> @@ -686,6 +717,12 @@ static void vfio_msix_vector_release(PCIDevice *pdev, unsigned int nr)
>       }
>   }
>   
> +void vfio_pci_msix_set_notifiers(VFIOPCIDevice *vdev)
> +{
> +    msix_set_vector_notifiers(&vdev->pdev, vfio_msix_vector_use,
> +                              vfio_msix_vector_release, NULL);
> +}
> +
>   void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
>   {
>       assert(!vdev->defer_kvm_irq_routing);
> @@ -2962,6 +2999,11 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
>       fd = event_notifier_get_fd(&vdev->err_notifier);
>       qemu_set_fd_handler(fd, vfio_err_notifier_handler, NULL, vdev);
>   
> +    /* Do not alter irq_signaling during vfio_realize for cpr */
> +    if (cpr_is_incoming()) {
> +        return;
> +    }
> +
>       if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
>                                          VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> @@ -3029,6 +3071,12 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>       fd = event_notifier_get_fd(&vdev->req_notifier);
>       qemu_set_fd_handler(fd, vfio_req_notifier_handler, NULL, vdev);
>   
> +    /* Do not alter irq_signaling during vfio_realize for cpr */
> +    if (cpr_is_incoming()) {
> +        vdev->req_enabled = true;
> +        return;
> +    }
> +
>       if (!vfio_device_irq_set_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
>                                          VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);


