Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D905AC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 17:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2BRR-0004VC-A5; Thu, 03 Sep 2026 13:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1x2BRQ-0004Ut-9U; Thu, 03 Sep 2026 13:41:36 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1x2BRO-0004Tv-3j; Thu, 03 Sep 2026 13:41:36 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D71CB22059;
 Thu,  3 Sep 2026 17:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788457288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UnFR6Yi6zWP18avxVcqwlQK8jVhjoba6KwlnZwMv2wI=;
 b=Q1oFSysRRTGtQ5pI+UqGhddgJYL+ng2dbc0/I7zWK9xFmj4RZIga/KAfQxE/r7kV5Nwmxi
 rayKnCS5Lpx5RANKUm6KcGXw+IOILAzSCh3Pe3ExsOCk2TTkBqVAkPltw0FhhSKGb6mzeU
 vfzHioMiWU6+dQ0yA59okg/pg++D+7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788457288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UnFR6Yi6zWP18avxVcqwlQK8jVhjoba6KwlnZwMv2wI=;
 b=Mn+EVy27PGeC9DOXcRAGgkenFt2e5txFEwXYkERUTnyJOUA5GdXROpVKQV+U6OCaXoDyij
 8zPhLK+L+LluGLAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788457283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UnFR6Yi6zWP18avxVcqwlQK8jVhjoba6KwlnZwMv2wI=;
 b=OWbzzvc7ddUUcZDcMTLI7YEeYWwBSuFuRzYputTecMhPvAn83TehE+We1AE5EoO6YNAbkG
 TlFCAleW11x+binLq5X9UBNbeS7+wK+8LB74I+K4PtjPKhRIf8kSebFrj0pYoa110dkAAa
 5JhgAUr/qHQEd2n/QDA1MAJBHiqrFg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788457283;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UnFR6Yi6zWP18avxVcqwlQK8jVhjoba6KwlnZwMv2wI=;
 b=0rTAX8aM0+nBm6d2/u4/2eTZZ3QUAjNFYqNa3sYR7eTLKQJfQ4QC6hlUDDTJDZU0iHbKYh
 C06j+bh6n7JkRODA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55830136E6;
 Thu,  3 Sep 2026 17:41:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EhcnCkOxmWrMUwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 03 Sep 2026 17:41:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com
Cc: qemu-devel@nongnu.org, vsementsov@yandex-team.ru, "Michael S. Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic
 <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Richard
 Henderson <richard.henderson@linaro.org>, Ilya Leoshkevich
 <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, "open list:virtio-ccw" <qemu-s390x@nongnu.org>
Subject: Re: [PATCH 04/30] hw/virtio: config save/load: move to new
 migration APIs
In-Reply-To: <20260825213811.3725682-5-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
 <20260825213811.3725682-5-vsementsov@yandex-team.ru>
Date: Thu, 03 Sep 2026 14:41:16 -0300
Message-ID: <87h5k68c77.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[14]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, yandex-team.ru:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Stop ignoring the error on save path.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/pci/pci.c                   | 27 +++++++++++----------------
>  hw/s390x/virtio-ccw.c          | 19 ++++---------------
>  hw/virtio/virtio-mmio.c        | 10 +++++++---
>  hw/virtio/virtio-pci.c         | 24 +++++++++++++++---------
>  hw/virtio/virtio.c             | 11 +++++++----
>  include/hw/pci/pci.h           |  4 ++--
>  include/hw/virtio/virtio-bus.h |  4 ++--
>  7 files changed, 48 insertions(+), 51 deletions(-)
>
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index d3191609e28..76d006fa1d7 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -940,37 +940,32 @@ const VMStateDescription vmstate_pci_device = {
>  };
>  
>  
> -void pci_device_save(PCIDevice *s, QEMUFile *f)
> +bool pci_device_save(PCIDevice *s, QEMUFile *f, Error **errp)
>  {
> -    Error *local_err = NULL;
> -    int ret;
> +    bool ok;
>  
>      /* Clear interrupt status bit: it is implicit
>       * in irq_state which we are saving.
>       * This makes us compatible with old devices
>       * which never set or clear this bit. */
>      s->config[PCI_STATUS] &= ~PCI_STATUS_INTERRUPT;
> -    ret = vmstate_save_state(f, &vmstate_pci_device, s, NULL, &local_err);
> -    if (ret < 0) {
> -        error_report_err(local_err);
> -    }
> +
> +    ok = vmstate_save_vmsd(f, &vmstate_pci_device, s, NULL, errp);
> +
>      /* Restore the interrupt status bit. */
>      pci_update_irq_status(s);
> +
> +    return ok;
>  }
>  
> -int pci_device_load(PCIDevice *s, QEMUFile *f)
> +bool pci_device_load(PCIDevice *s, QEMUFile *f, Error **errp)
>  {
> -    Error *local_err = NULL;
> -    int ret;
> +    bool ok = vmstate_load_vmsd(f, &vmstate_pci_device, s, s->version_id, errp);
>  
> -    ret = vmstate_load_state(f, &vmstate_pci_device, s, s->version_id,
> -                             &local_err);
> -    if (ret < 0) {
> -        error_report_err(local_err);
> -    }
>      /* Restore the interrupt status bit. */
>      pci_update_irq_status(s);
> -    return ret;
> +
> +    return ok;
>  }
>  
>  static void pci_set_default_subsystem_id(PCIDevice *pci_dev)
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index d82874ed27e..848ed09e94b 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -1129,29 +1129,18 @@ static int virtio_ccw_load_queue(DeviceState *d, int n, QEMUFile *f)
>      return 0;
>  }
>  
> -static void virtio_ccw_save_config(DeviceState *d, QEMUFile *f)
> +static bool virtio_ccw_save_config(DeviceState *d, QEMUFile *f, Error **errp)
>  {
>      VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
> -    Error *local_err = NULL;
> -    int ret;
>  
> -    ret = vmstate_save_state(f, &vmstate_virtio_ccw_dev, dev, NULL, &local_err);
> -    if (ret < 0) {
> -        error_report_err(local_err);
> -    }
> +    return vmstate_save_vmsd(f, &vmstate_virtio_ccw_dev, dev, NULL, errp);
>  }
>  
> -static int virtio_ccw_load_config(DeviceState *d, QEMUFile *f)
> +static bool virtio_ccw_load_config(DeviceState *d, QEMUFile *f, Error **errp)
>  {
>      VirtioCcwDevice *dev = VIRTIO_CCW_DEVICE(d);
> -    Error *local_err = NULL;
> -    int ret;
>  
> -    ret = vmstate_load_state(f, &vmstate_virtio_ccw_dev, dev, 1, &local_err);
> -    if (ret < 0) {
> -        error_report_err(local_err);
> -    }
> -    return ret;
> +    return vmstate_load_vmsd(f, &vmstate_virtio_ccw_dev, dev, 1, errp);
>  }
>  
>  static void virtio_ccw_pre_plugged(DeviceState *d, Error **errp)
> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> index 559363e4438..ef34b76913e 100644
> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -547,23 +547,27 @@ static void virtio_mmio_update_irq(DeviceState *opaque, uint16_t vector)
>      qemu_set_irq(proxy->irq, level);
>  }
>  
> -static int virtio_mmio_load_config(DeviceState *opaque, QEMUFile *f)
> +static bool virtio_mmio_load_config(DeviceState *opaque, QEMUFile *f,
> +                                    Error **errp)
>  {
>      VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
>  
>      proxy->host_features_sel = qemu_get_be32(f);
>      proxy->guest_features_sel = qemu_get_be32(f);
>      proxy->guest_page_shift = qemu_get_be32(f);
> -    return 0;
> +    return true;
>  }
>  
> -static void virtio_mmio_save_config(DeviceState *opaque, QEMUFile *f)
> +static bool virtio_mmio_save_config(DeviceState *opaque, QEMUFile *f,
> +                                    Error **errp)
>  {
>      VirtIOMMIOProxy *proxy = VIRTIO_MMIO(opaque);
>  
>      qemu_put_be32(f, proxy->host_features_sel);
>      qemu_put_be32(f, proxy->guest_features_sel);
>      qemu_put_be32(f, proxy->guest_page_shift);
> +
> +    return true;
>  }
>  
>  static const VMStateDescription vmstate_virtio_mmio_queue_state = {
> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
> index 7a5d4f35e33..07941319be2 100644
> --- a/hw/virtio/virtio-pci.c
> +++ b/hw/virtio/virtio-pci.c
> @@ -84,15 +84,21 @@ static void virtio_pci_notify(DeviceState *d, uint16_t vector)
>      }
>  }
>  
> -static void virtio_pci_save_config(DeviceState *d, QEMUFile *f)
> +static bool virtio_pci_save_config(DeviceState *d, QEMUFile *f, Error **errp)
>  {
>      VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
>      VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
>  
> -    pci_device_save(&proxy->pci_dev, f);
> +    if (!pci_device_save(&proxy->pci_dev, f, errp)) {
> +        return false;
> +    }
> +
>      msix_save(&proxy->pci_dev, f);
> -    if (msix_present(&proxy->pci_dev))
> +    if (msix_present(&proxy->pci_dev)) {
>          qemu_put_be16(f, vdev->config_vector);
> +    }
> +
> +    return true;
>  }
>  
>  static const VMStateDescription vmstate_virtio_pci_modern_queue_state = {
> @@ -209,24 +215,24 @@ static void virtio_pci_save_queue(DeviceState *d, int n, QEMUFile *f)
>          qemu_put_be16(f, virtio_queue_vector(vdev, n));
>  }
>  
> -static int virtio_pci_load_config(DeviceState *d, QEMUFile *f)
> +static bool virtio_pci_load_config(DeviceState *d, QEMUFile *f, Error **errp)
>  {

This function is returning 0

>      VirtIOPCIProxy *proxy = to_virtio_pci_proxy(d);
>      VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
>      uint16_t vector;
>  
> -    int ret;
> -    ret = pci_device_load(&proxy->pci_dev, f);
> -    if (ret) {
> -        return ret;
> +    if (!pci_device_load(&proxy->pci_dev, f, errp)) {
> +        return false;
>      }
> +
>      msix_unuse_all_vectors(&proxy->pci_dev);
>      msix_load(&proxy->pci_dev, f);
>      if (msix_present(&proxy->pci_dev)) {
>          qemu_get_be16s(f, &vector);
>  
>          if (vector != VIRTIO_NO_VECTOR && vector >= proxy->nvectors) {
> -            return -EINVAL;
> +            error_setg(errp, "load config: unexpected vector %" PRIu16, vector);
> +            return false;
>          }
>      } else {
>          vector = VIRTIO_NO_VECTOR;
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 8230a383aff..0f7c8acead0 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -3077,7 +3077,10 @@ int virtio_save(VirtIODevice *vdev, QEMUFile *f)
>      Error *local_err = NULL;
>  
>      if (k->save_config) {
> -        k->save_config(qbus->parent, f);
> +        if (!k->save_config(qbus->parent, f, &local_err)) {
> +            error_report_err(local_err);
> +            return -EINVAL;
> +        }
>      }
>  
>      qemu_put_8s(f, &vdev->status);
> @@ -3526,9 +3529,9 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
>      vdev->device_endian = VIRTIO_DEVICE_ENDIAN_UNKNOWN;
>  
>      if (k->load_config) {
> -        ret = k->load_config(qbus->parent, f);
> -        if (ret)
> -            return ret;
> +        if (!k->load_config(qbus->parent, f, &local_err)) {
> +            return -EINVAL;
> +        }
>      }
>  
>      qemu_get_8s(f, &vdev->status);
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index f2448e941a0..7c3fdc05630 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -270,8 +270,8 @@ uint32_t pci_default_read_config(PCIDevice *d,
>                                   uint32_t address, int len);
>  void pci_default_write_config(PCIDevice *d,
>                                uint32_t address, uint32_t val, int len);
> -void pci_device_save(PCIDevice *s, QEMUFile *f);
> -int pci_device_load(PCIDevice *s, QEMUFile *f);
> +bool pci_device_save(PCIDevice *s, QEMUFile *f, Error **errp);
> +bool pci_device_load(PCIDevice *s, QEMUFile *f, Error **errp);
>  MemoryRegion *pci_address_space(PCIDevice *dev);
>  MemoryRegion *pci_address_space_io(PCIDevice *dev);
>  
> diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
> index 255ecb2fcb2..1b9867002b8 100644
> --- a/include/hw/virtio/virtio-bus.h
> +++ b/include/hw/virtio/virtio-bus.h
> @@ -41,10 +41,10 @@ struct VirtioBusClass {
>      /* This is what a VirtioBus must implement */
>      BusClass parent;
>      void (*notify)(DeviceState *d, uint16_t vector);
> -    void (*save_config)(DeviceState *d, QEMUFile *f);
> +    bool (*save_config)(DeviceState *d, QEMUFile *f, Error **errp);
>      void (*save_queue)(DeviceState *d, int n, QEMUFile *f);
>      bool (*save_extra_state)(DeviceState *d, QEMUFile *f, Error **errp);
> -    int (*load_config)(DeviceState *d, QEMUFile *f);
> +    bool (*load_config)(DeviceState *d, QEMUFile *f, Error **errp);
>      int (*load_queue)(DeviceState *d, int n, QEMUFile *f);
>      int (*load_done)(DeviceState *d, QEMUFile *f);
>      bool (*load_extra_state)(DeviceState *d, QEMUFile *f, Error **errp);

