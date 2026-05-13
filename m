Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5716DCD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 20:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNGV3-0002EI-VO; Wed, 13 May 2026 16:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNGUn-0002DV-1S
 for qemu-devel@nongnu.org; Wed, 13 May 2026 16:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNGUk-0005gM-3p
 for qemu-devel@nongnu.org; Wed, 13 May 2026 16:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778705272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dr6eLwXWHBATbIHqAN//chc2fQ4W5AWfG/Fwalg8pFE=;
 b=gHlzak/CaPp5/KbvMdemi7BouoHeUgjq7tm2e1yn4RJzbwjQtkSrW7ogeoa+t39aL8AF3B
 wfRSOB1dyKD4P5M3SWU4nPLfTtuCc1U18YUBBAlDWCciptGxht1WtI89/pPl7a1hOiYP9b
 oq6DLsis8r11lreAiOvjiDtzUFlccZ4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-Me7cRdCnNrqL_II1g0s_-Q-1; Wed, 13 May 2026 16:47:50 -0400
X-MC-Unique: Me7cRdCnNrqL_II1g0s_-Q-1
X-Mimecast-MFC-AGG-ID: Me7cRdCnNrqL_II1g0s_-Q_1778705270
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d5d1c2289so74992251cf.2
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 13:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778705270; x=1779310070; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dr6eLwXWHBATbIHqAN//chc2fQ4W5AWfG/Fwalg8pFE=;
 b=OLilAAJdKjtIgJLg6qo6rl+xlKnIj9taxfdxMbyNhaeljyme3i72Kkfs/B2XTDP9IB
 umWq1/aIZPrPAaT4dWuJFb42eOhw7ryAGoHU0BoeWBkoV4PFkU6BTIOrOkWj6MSQJ+yv
 uLt0fDy0q3RPpsQsRl79/WNaADpnvDWiuJ0piFgqQ7X1FBTnYqi6JzA1cDjsiVh8MShW
 xBlY+TqiwxIhjut5Htn+z0wbqQRZQmzwJuc5DveXjthl9WY/Dfkhy8hxsqqGJlsYvoaK
 vyRvZB7NUa+iTI90wqmXXSARxhEL16syI2yjLbMqby0JEoXTKEjrpGMTbZBQTGTH9Lb0
 9P2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778705270; x=1779310070;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dr6eLwXWHBATbIHqAN//chc2fQ4W5AWfG/Fwalg8pFE=;
 b=L9MH3hubC62rDB6JfXZZR+oDcNxRvWzPRte9OL5Loq1QVXIp7b5QZepl+TF4oLnAyz
 uw0IE1mvzNfr7zZyPZR81/zuSU2F3xJf/YiEdtuYbEjQt6kVIX+Kb4sSAtVd7Z/FDTQ0
 uBqNDPaCopJyUltMdxpGtf5TE/kb3s2gDS5wZg3etle/4Gv2npEjGjrB3YJwaiiWvxVd
 PNSZHnSb9C8n3MSpJ4sD6uoma23yQ9A1rzu/HB5P4HVTVlG4GnNx/JYHvSC4Pn6ek2aL
 8hbB+eDNTcYa3npanOQLhmCo29N2642pnZdGk5UAQ/i4HQampVSpqwXfrUqK/DkbOPRb
 2sTQ==
X-Gm-Message-State: AOJu0YzGJtoxFDodgm6jPDlYQciC9EdFAfqvZ1DwoGzEj1sy11b/sKSl
 8TOcJcSDNvCfo0nwcQpFLFmn06138Y4wQP3qAinZe9weK/kBWWSDiobT+H7KFCzkgSOWwHaEWFt
 SHQ6zOsbynrPC3ATqnd8BDGPDDw3j8SigR36Ogj9LdJoGpC0SnRmZIcVg
X-Gm-Gg: Acq92OE9nwcn+Vne+wWQmDr1CIVw/LQYv0va0vX3pnWJHYXsHz/SMaskYurxvzj+RPQ
 fxp2cg8/NSvZcVS9yLEfG2SrIAa3pKop8IHl4/+vakwADiU+ysZ+T+Qa/Pths7NMw0IhAt15lra
 +QwLVIIVIy7tzQopEWLX+Ndv2FwdyMpVhAN7uADfkxaaNhFR5pVYF+9umojE6CH9IyBXAHez/x+
 waB5m8f3KriOtDG4yPDwprGfF9R9lioXldJQLjTIymGDW5bqTaLr83rUlrw9UBxqUCnHctq1Hsb
 BZERCJw18jkyCAEbggleK0Td4GavmstrIr6iphhaSvHqRa2ns8xQ+yTlcsjOlLuJfFsjdF4nby9
 V+MoXWIVIzSLRY+gou3BO7aaodLmhsovD7Uu77KXrDwPG88g=
X-Received: by 2002:a05:622a:17c6:b0:50d:8c24:20f2 with SMTP id
 d75a77b69052e-5162f574f4emr65271781cf.30.1778705265226; 
 Wed, 13 May 2026 13:47:45 -0700 (PDT)
X-Received: by 2002:a05:622a:17c6:b0:50d:8c24:20f2 with SMTP id
 d75a77b69052e-5162f574f4emr65271411cf.30.1778705264695; 
 Wed, 13 May 2026 13:47:44 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8c90c358539sm5514876d6.41.2026.05.13.13.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 13:47:44 -0700 (PDT)
Date: Wed, 13 May 2026 16:47:43 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v4 13/13] RFC: hw/virtio: start virtio-mem guest_memfd
 regions as shared
Message-ID: <agTjb3M8ElUAlfp1@x1.local>
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
 <20260504-rdm5-v4-13-bdf61e57c1e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260504-rdm5-v4-13-bdf61e57c1e1@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 04, 2026 at 04:30:19PM +0400, Marc-André Lureau wrote:
> In TDX guests, virtio-mem plug/unplug/re-plug fails because
> kvm_set_phys_mem() unconditionally sets KVM memory attributes to
> PRIVATE for all guest_memfd regions. On re-plug, the PRIVATE->PRIVATE
> transition is a no-op, so KVM doesn't re-AUG pages and the guest's
> TDG.MEM.PAGE.ACCEPT fails.

Know little on TDX, please bare with me..

I saw KVM does a seamcall to ADD or AUG whenever a new EPT pte is set, via
this path:

        __tdp_mmu_set_spte_atomic
        set_external_spte_present
        tdx_sept_set_private_spte <------

On unplug, I'm expecting with your prior patches, gmem pages will be
truncated properly, so they'll be all gone.

Then, qemu does replug -> guest gets that event, start access page -> EPT
violation, KVM resolving page fault with __tdp_mmu_set_spte_atomic() (per
above) and a new page -> triggering AUG (not ADD, since it's post-boot).

Could you elaborate here why AUG is missing in the first place?

Thanks,

> 
> Implement the "start-shared" approach: virtio-mem memory starts with
> shared KVM attributes. The guest converts shared->private on plug (via
> set_memory_encrypted -> MapGPA + ACCEPT), and back to shared on unplug
> (via set_memory_decrypted). This ensures every plug triggers a real
> SHARED->PRIVATE transition, causing KVM to AUG fresh pages.
> 
> Add RAM_GUEST_MEMFD_START_SHARED flag and set it during virtio-mem
> realize for guest_memfd-backed regions. Use
> ram_block_attributes_state_change() to properly update the attributes
> bitmap through the API. Skip setting PRIVATE in kvm_set_phys_mem()
> when the flag is set. On unplug, explicitly reset KVM attributes to
> shared on the host side to handle the case where the guest skips
> set_memory_decrypted().
> 
> See also virtio-comment "[PATCH RFC] virtio-mem: add shared/private memory property details".
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  include/system/memory.h |  6 ++++++
>  accel/kvm/kvm-all.c     |  3 ++-
>  hw/virtio/virtio-mem.c  | 27 ++++++++++++++++++++++++++-
>  3 files changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index 28a75dac4ae..9dbf67efe50 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -277,6 +277,12 @@ typedef struct IOMMUTLBEvent {
>   */
>  #define RAM_PRIVATE (1 << 13)
>  
> +/*
> + * RAM with guest_memfd that should start with shared KVM memory
> + * attributes. The guest converts to private on use.
> + */
> +#define RAM_GUEST_MEMFD_START_SHARED (1 << 14)
> +
>  static inline void iommu_notifier_init(IOMMUNotifier *n, IOMMUNotify fn,
>                                         IOMMUNotifierFlag flags,
>                                         hwaddr start, hwaddr end,
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 97463a683f4..c034e74c8e5 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1737,7 +1737,8 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
>              abort();
>          }
>  
> -        if (memory_region_has_guest_memfd(mr)) {
> +        if (memory_region_has_guest_memfd(mr) &&
> +            !(mr->ram_block->flags & RAM_GUEST_MEMFD_START_SHARED)) {
>              err = kvm_set_memory_attributes_private(start_addr, slot_size);
>              if (err) {
>                  error_report("%s: failed to set memory attribute private: %s",
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 35e03ed7599..b46efe21126 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -19,6 +19,7 @@
>  #include "system/memory.h"
>  #include "system/numa.h"
>  #include "system/system.h"
> +#include "system/kvm.h"
>  #include "system/ramblock.h"
>  #include "system/reset.h"
>  #include "system/runstate.h"
> @@ -479,6 +480,11 @@ static int virtio_mem_set_block_state(VirtIOMEM *vmem, uint64_t start_gpa,
>          if (vmem->dynamic_memslots) {
>              virtio_mem_deactivate_unplugged_memslots(vmem, offset, size);
>          }
> +        if (rb->flags & RAM_GUEST_MEMFD_START_SHARED) {
> +            kvm_set_memory_attributes_shared(start_gpa, size);
> +            ram_block_attributes_state_change(rb->attributes,
> +                                              offset, size, false);
> +        }
>          return 0;
>      }
>  
> @@ -606,10 +612,12 @@ static int virtio_mem_unplug_all(VirtIOMEM *vmem)
>      RAMBlock *rb = vmem->memdev->mr.ram_block;
>  
>      if (vmem->size) {
> +        uint64_t used = qemu_ram_get_used_length(rb);
> +
>          if (virtio_mem_is_busy()) {
>              return -EBUSY;
>          }
> -        if (ram_block_discard_range(rb, 0, qemu_ram_get_used_length(rb))) {
> +        if (ram_block_discard_range(rb, 0, used)) {
>              return -EBUSY;
>          }
>          virtio_mem_notify_unplug_all(vmem);
> @@ -622,6 +630,11 @@ static int virtio_mem_unplug_all(VirtIOMEM *vmem)
>          if (vmem->dynamic_memslots) {
>              virtio_mem_deactivate_unplugged_memslots(vmem, 0, region_size);
>          }
> +        if (rb->flags & RAM_GUEST_MEMFD_START_SHARED) {
> +            kvm_set_memory_attributes_shared(vmem->addr, used);
> +            ram_block_attributes_state_change(rb->attributes,
> +                                              0, used, false);
> +        }
>      }
>  
>      trace_virtio_mem_unplugged_all();
> @@ -859,6 +872,18 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
>      rb = vmem->memdev->mr.ram_block;
>      page_size = qemu_ram_pagesize(rb);
>  
> +    /*
> +     * For CoCo VMs with guest_memfd, use the "start-shared" model:
> +     * memory starts as shared and the guest converts to private on
> +     * plug.
> +     */
> +    if (rb->flags & RAM_GUEST_MEMFD) {
> +        rb->flags |= RAM_GUEST_MEMFD_START_SHARED;
> +        ram_block_attributes_state_change(rb->attributes, 0,
> +                                          qemu_ram_get_used_length(rb),
> +                                          false);
> +    }
> +
>      if (virtio_mem_has_legacy_guests()) {
>          switch (vmem->unplugged_inaccessible) {
>          case ON_OFF_AUTO_AUTO:
> 
> -- 
> 2.54.0
> 
> 

-- 
Peter Xu


