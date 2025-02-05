Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D627C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 16:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfiZz-0007Ku-2v; Wed, 05 Feb 2025 11:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfiZx-0007Kb-3I
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 11:48:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfiZu-0001uD-R2
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 11:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738774117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kiK4v6NWHayapSzHqYjJ8RSnUqAcVJe4bsvv9hkVpVU=;
 b=geo8VNRtrVfpkKnvDqru8OBUnorDQrzhRDlf5siO8HLYhtgHJEEkfrqXQ71BrU6HurAz6g
 xCzFQexlXHIybd4lliwuI24Dp0AtYF4TA27riFkyeY+bsJGi91uHjOMXrkCEX578kdOvkv
 vX7xsP2BjIWkXWZ0t0UHiiUFr9NAO7k=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-tmqXnD0mOG-i_969IvnDpQ-1; Wed, 05 Feb 2025 11:48:36 -0500
X-MC-Unique: tmqXnD0mOG-i_969IvnDpQ-1
X-Mimecast-MFC-AGG-ID: tmqXnD0mOG-i_969IvnDpQ
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b6f2515eb3so676225885a.0
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 08:48:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738774115; x=1739378915;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kiK4v6NWHayapSzHqYjJ8RSnUqAcVJe4bsvv9hkVpVU=;
 b=FKDIrIySrfabEpVfPDGdEqUyYwjNl7Cr1TcnBW33d5DCrNMJVA2PaPE5gHYt08wvz6
 UPWsigI5qja8PAcVH4Ptxn1gmog2Zd03BjfcEuaWG+aS+kn0At+7htXlCA+qd+9AfoUO
 /vCdLsNCcRYJNpZN3DEtoGTuJF3PFS5NdlvDl8Qu8JUoKaPsuxaO0vgGi8sofFxRvPnk
 nPC+aUKVtydQPuoqsphrDVSOHDb1rxr7TOURvmeDPEX37osaPaoULv3VG0HRT52Bl2aM
 mY11DdCssBuOfHfJaugVCsqf9BkMIP1oo/skOauHqcghV43oR+E6PrbLj4T1u11k+R23
 +SxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwa08iABeKyqH9jTdanOMOPoPaUeXwYu+E7W5Hz6DEtRPcnctTGMQW/0ZhfKpT3ZEi4XvGuWzg9anN@nongnu.org
X-Gm-Message-State: AOJu0YztIvLQUeFjFia43HF4VqJtSsmz3BkaD5Q6mdcKEroj3G27k/KT
 OSGMc+S0z1ep7HPYgeijxsS/UpnVh2B8tUw+IZ92T5dcBnpm1EpD8iA5gJcC9+nwbLBdXfhMt2G
 S9uHWYErOId9+Rg8R0SjFMrdPqyZkB1ImIhvbXgLFR9yoFOR7AfZr
X-Gm-Gg: ASbGncvw54CmBoDUCWja7epB+/1ksYVvegl2RuvqjVjcSymxBmO7IxzgkLz+H4oGEZ6
 gNFhrQtCHaLBonlvKZ9MT/VeVhZo0jgePKlOfyCxnvqpUQwpicZD5lRKrrArhGB2qrVjGs6HYHJ
 ssxYU1/+BdTj9png+rUWuKFS9cOK+D16Z30aJLVuTMYkRp54bS8d1NNkyX1IMQpNF87zKbrbLOc
 nbdVGowJx66DRLIBV1ZOmLzNMSOTT/LQi31ZmgdzQdQR3Gd63/Bt6zj81TZxXetVRHKp9Bc4e99
 87dNgMUedlfVumg8H9APLZ+lUeAmNEOxGzYm/9OoVu4=
X-Received: by 2002:a05:620a:2718:b0:7b6:dc0b:8ffe with SMTP id
 af79cd13be357-7c03a041a5fmr624349985a.53.1738774115654; 
 Wed, 05 Feb 2025 08:48:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb8hbdbHrR+t8yWg4Glpi8lN+VjDYzfa8zEyslyYl0APdCjgX+d3aHsOYSJ0fBTJLDd3SVgA==
X-Received: by 2002:a05:620a:2718:b0:7b6:dc0b:8ffe with SMTP id
 af79cd13be357-7c03a041a5fmr624344685a.53.1738774115167; 
 Wed, 05 Feb 2025 08:48:35 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a90571csm765005885a.83.2025.02.05.08.48.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 08:48:34 -0800 (PST)
Message-ID: <db848b31-540a-4446-98b5-dffecf9edb38@redhat.com>
Date: Wed, 5 Feb 2025 17:48:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 12/26] vfio-pci: preserve MSI
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu
 <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-13-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1738161802-172631-13-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 1/29/25 15:43, Steve Sistare wrote:
> Save the MSI message area as part of vfio-pci vmstate, and preserve the
> interrupt and notifier eventfd's.  migrate_incoming loads the MSI data,
> then the vfio-pci post_load handler finds the eventfds in CPR state,
> rebuilds vector data structures, and attaches the interrupts to the new
> KVM instance.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/pci.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 116 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index fa77c36..df6e298 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -56,11 +56,37 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
>   static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
>   static void vfio_msi_disable_common(VFIOPCIDevice *vdev);
>   
> +#define EVENT_FD_NAME(vdev, name)   \
> +    g_strdup_printf("%s_%s", (vdev)->vbasedev.name, (name))

hmm, this helper could lead to memory leaks if not used as done below.
Being explict would be safer.

> +static void save_event_fd(VFIOPCIDevice *vdev, const char *name, int nr,
> +                          EventNotifier *ev)
> +{
> +    int fd = event_notifier_get_fd(ev);
> +
> +    if (fd >= 0) {
> +        g_autofree char *fdname = EVENT_FD_NAME(vdev, name);
> +        cpr_resave_fd(fdname, nr, fd);
> +    }
> +}
> +
> +static int load_event_fd(VFIOPCIDevice *vdev, const char *name, int nr)
> +{
> +    g_autofree char *fdname = EVENT_FD_NAME(vdev, name);
> +    return cpr_find_fd(fdname, nr);
> +}
> +
> +static void delete_event_fd(VFIOPCIDevice *vdev, const char *name, int nr)
> +{
> +    g_autofree char *fdname = EVENT_FD_NAME(vdev, name);
> +    cpr_delete_fd(fdname, nr);
> +}
> +

please move these helpers to a cpr file. They are not strictly VFIO
related too. So they could me moved outside of hw/vfio.


>   /* Create new or reuse existing eventfd */
>   static int vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>                                 const char *name, int nr)
>   {
> -    int fd = -1;   /* placeholder until a subsequent patch */
> +    int fd = load_event_fd(vdev, name, nr);


>       int ret = 0;
>   
>       if (fd >= 0) {
> @@ -71,6 +97,8 @@ static int vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>               Error *err = NULL;
>               error_setg_errno(&err, -ret, "vfio_notifier_init %s failed", name);
>               error_report_err(err);
> +        } else {
> +            save_event_fd(vdev, name, nr, e);

I'd rather move the CPR related fd handling which is done in
vfio_notifier_init() in a cpr routine which vfio_notifier_init()
would call. This comment applies to all the series. Anything
related to CPR should be handled explicitely :

     if (cpr_in_progress) {
         cpr_do_cpr_related_stuff()
     }

It will ease reading and long term maintenance.



>           }
>       }
>       return ret;
> @@ -79,6 +107,7 @@ static int vfio_notifier_init(VFIOPCIDevice *vdev, EventNotifier *e,
>   static void vfio_notifier_cleanup(VFIOPCIDevice *vdev, EventNotifier *e,
>                                     const char *name, int nr)
>   {
> +    delete_event_fd(vdev, name, nr);
>       event_notifier_cleanup(e);
>   }
>   
> @@ -561,6 +590,15 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>       int ret;
>       bool resizing = !!(vdev->nr_vectors < nr + 1);
>   
> +    /*
> +     * Ignore the callback from msix_set_vector_notifiers during resume.
> +     * The necessary subset of these actions is called from vfio_claim_vectors
> +     * during post load.
> +     */
> +    if (vdev->vbasedev.reused) {
> +        return 0;
> +    }

again, I would prefer some explicit CPR test. Same below.


>       trace_vfio_msix_vector_do_use(vdev->vbasedev.name, nr);
>   
>       vector = &vdev->msi_vectors[nr];
> @@ -2896,6 +2934,11 @@ static void vfio_register_err_notifier(VFIOPCIDevice *vdev)
>       fd = event_notifier_get_fd(&vdev->err_notifier);
>       qemu_set_fd_handler(fd, vfio_err_notifier_handler, NULL, vdev);
>   
> +    /* Do not alter irq_signaling during vfio_realize for cpr */
> +    if (vdev->vbasedev.reused) {
> +        return;
> +    }
> +
>       if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_ERR_IRQ_INDEX, 0,
>                                   VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> @@ -2960,6 +3003,12 @@ static void vfio_register_req_notifier(VFIOPCIDevice *vdev)
>       fd = event_notifier_get_fd(&vdev->req_notifier);
>       qemu_set_fd_handler(fd, vfio_req_notifier_handler, NULL, vdev);
>   
> +    /* Do not alter irq_signaling during vfio_realize for cpr */
> +    if (vdev->vbasedev.reused) {
> +        vdev->req_enabled = true;
> +        return;
> +    }
> +
>       if (!vfio_set_irq_signaling(&vdev->vbasedev, VFIO_PCI_REQ_IRQ_INDEX, 0,
>                                   VFIO_IRQ_SET_ACTION_TRIGGER, fd, &err)) {
>           error_reportf_err(err, VFIO_MSG_PREFIX, vdev->vbasedev.name);
> @@ -3454,6 +3503,46 @@ static void vfio_pci_set_fd(Object *obj, const char *str, Error **errp)
>   }
>   #endif
>   
> +static void vfio_claim_vectors(VFIOPCIDevice *vdev, int nr_vectors, bool msix)
> +{
> +    int i, fd;
> +    bool pending = false;
> +    PCIDevice *pdev = &vdev->pdev;
> +
> +    vdev->nr_vectors = nr_vectors;
> +    vdev->msi_vectors = g_new0(VFIOMSIVector, nr_vectors);
> +    vdev->interrupt = msix ? VFIO_INT_MSIX : VFIO_INT_MSI;
> +
> +    vfio_prepare_kvm_msi_virq_batch(vdev);
> +
> +    for (i = 0; i < nr_vectors; i++) {
> +        VFIOMSIVector *vector = &vdev->msi_vectors[i];
> +
> +        fd = load_event_fd(vdev, "interrupt", i);
> +        if (fd >= 0) {
> +            vfio_vector_init(vdev, i);
> +            qemu_set_fd_handler(fd, vfio_msi_interrupt, NULL, vector);
> +        }
> +
> +        if (load_event_fd(vdev, "kvm_interrupt", i) >= 0) {
> +            vfio_add_kvm_msi_virq(vdev, vector, i, msix);
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
> +    vfio_commit_kvm_msi_virq_batch(vdev);
> +
> +    if (msix) {
> +        memory_region_set_enabled(&pdev->msix_pba_mmio, pending);
> +    }
> +}

move to a cpr file please. We can have a vfio-pci lib/common file
for external users. It will take more work to get the interface right
but it will benefit other proposals. I think vfio-user as more or less
the same needs.


> +
>   /*
>    * The kernel may change non-emulated config bits.  Exclude them from the
>    * changed-bits check in get_pci_config_device.
> @@ -3472,13 +3561,39 @@ static int vfio_pci_pre_load(void *opaque)
>       return 0;
>   }
>   
> +static int vfio_pci_post_load(void *opaque, int version_id)
> +{
> +    VFIOPCIDevice *vdev = opaque;
> +    PCIDevice *pdev = &vdev->pdev;
> +    int nr_vectors;
> +
> +    if (msix_enabled(pdev)) {
> +        msix_set_vector_notifiers(pdev, vfio_msix_vector_use,
> +                                   vfio_msix_vector_release, NULL);
> +        nr_vectors = vdev->msix->entries;
> +        vfio_claim_vectors(vdev, nr_vectors, true);
> +
> +    } else if (msi_enabled(pdev)) {
> +        nr_vectors = msi_nr_vectors_allocated(pdev);
> +        vfio_claim_vectors(vdev, nr_vectors, false);
> +
> +    } else if (vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1)) {
> +        g_assert_not_reached();      /* completed in a subsequent patch */
> +    }
> +
> +    return 0;
> +}
> +
>   static const VMStateDescription vfio_pci_vmstate = {
>       .name = "vfio-pci",
>       .version_id = 0,
>       .minimum_version_id = 0,
>       .pre_load = vfio_pci_pre_load,
> +    .post_load = vfio_pci_post_load,
>       .needed = cpr_needed_for_reuse,
>       .fields = (VMStateField[]) {
> +        VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
> +        VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
>           VMSTATE_END_OF_LIST()
>       }
>   };


I think you can move vfio_pci_vmstate out of hw/vfio/pci.c too. Only
cpr needs it.

Thanks,

C.




