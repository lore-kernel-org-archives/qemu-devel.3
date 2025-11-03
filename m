Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 630B0CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 22:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG2uJ-00047M-Mk; Mon, 03 Nov 2025 17:20:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vG2uF-00046s-MB
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 17:20:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vG2u7-0003Xr-NL
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 17:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762208387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ox1xPymM2EJSDd6HG9IkVXGWNx+nIR3OZHaC448pfI0=;
 b=MVOUOyDlzVPGxEQSXNpHJoEBarE0VKnaGfX36jCafO7VJahubXEsLj3Au8MDF/QBzW+FW5
 nY03CG71RhGFZDZXcSuXtaqtnEkP7x5O591eLqb+35879W+ZqR3RL4gRQZcdy4QicDTMU4
 JoSqKXHEteEklf+GktuiYjpD8dTsx6g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-BQKBWr2TPjOoCNf_nPx7Fw-1; Mon, 03 Nov 2025 17:19:43 -0500
X-MC-Unique: BQKBWr2TPjOoCNf_nPx7Fw-1
X-Mimecast-MFC-AGG-ID: BQKBWr2TPjOoCNf_nPx7Fw_1762208382
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-429cd08586cso973665f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 14:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762208382; x=1762813182; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ox1xPymM2EJSDd6HG9IkVXGWNx+nIR3OZHaC448pfI0=;
 b=sxeDVGAVC7sBj3FLhecEmTxshTxFV7h4gucX5icJr+NnbfKpmpYynEqoDltz20zVnK
 0/aBkWi2b8JEP+ZTlTavQiNUVQfb3OBXQFIVojeclooyLeJ/QxmxKPvA/OjOQc/h7vHL
 MrdipFxyLMVdJGNrKl8SADHzk4wsK1hBhR4HtBOuT82v9Wi8jb/k11uwJ0hL+4EnpsqD
 XeEbMSf8ZlcFaZkD9EiwbIQdqCxYNb4dluVgjnBes4amrNF10/sw9NNYDBL8vbQMKuUy
 wseczgVzxOO5eLsrE16y27o8CfoaxDAWLoBVkv9kApS5J3AGc02IvjYMhgOgzRcleeCy
 rk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762208382; x=1762813182;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ox1xPymM2EJSDd6HG9IkVXGWNx+nIR3OZHaC448pfI0=;
 b=pKp2ojPp9kMEBCg+y+PFRuaPovc7JzJFJhSt8MNk2216wslgv8uZVStYvFAWP+I2UX
 eA7l/GXq1gueUgQDTXx7oF3/QDEX7pabCLdwjueU5AXEH7uVuCulNywd6PGwfNx1QtZ0
 63DKBDVEk9hNoGyMdQWALyjYSxGXHJVxmM3Oyyf3pQqPCYYJTnkYU6m9YJ3Ovg6UObFN
 qJRw4cN4+mWaM03kLLZhsaGYk5Kx6IsTfhdpeMohQSFNnPtLo/Dko8771RWdCWmKn7ii
 RdgkyPHrX/zboI8FCtdtDlhYk5rGx+lNVwO4+TfrBszSZcyhweaVlzkgpuZFb26D4BYu
 Mt7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSfvpYl4xC21PN2aiC7NRiz4g2tcYbAbQOjHFSmiy73Las/OZylw/mHewXrn0SO+JrUXoqLRsO4Xl8@nongnu.org
X-Gm-Message-State: AOJu0YzbanTuL6phLBY09/nxyksFqGXtDOEbu5zop97lzISrebdf3bqV
 NbUwfxQSVCWwbPk0UOBPTLOs7DJjmfks34qrC46hSaO9RhqM+mqyKDCSkAgYTQq4coyW4HFg9fT
 qwXSvjZ1oh7gi2tGK1Zik6JriTQmJzb6wmozCDBl++Ta/R2D8Oirq/cIh
X-Gm-Gg: ASbGncv6/EoFxZwN5auga9pUh5JvRQnGfyDT/ilFDLYTsxUkG0EufNu9+LtbrBWG6ZE
 hOyYFoTnXH9bop+Gi219yT1sDsK4Q7YAvv+DzRooTnYVh+yCxe2nrZVe6TytMDjVRe8MP94DG4j
 XZX9TqdUP93ns0Dj/YnbqDpGDD+ok2riGHMwdFB+KxiAUq8bMuAGt11b3Knv1hcA12LYcTu0yav
 SIf6bpvjZm/UoTQVFNJeJWKfv/y+B8clQOI8SFLS+Z8lMGlE6fbyk0SiAnE4Jxgrw2PezXXW6WV
 kW+wKikLZAzWG4KlRlFl/l8yYGVJdzmc9u15B0Ok+8qu1tmx+YXJ5wcGXXJTzwA=
X-Received: by 2002:a05:6000:258a:b0:429:cd3f:f43a with SMTP id
 ffacd0b85a97d-429cd3ff771mr4197779f8f.7.1762208381862; 
 Mon, 03 Nov 2025 14:19:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8sTwbBPZn6v9xhi95w1tY8KWotMq1fjgybirOGOKVwNbS5n3P6KO/Mc3yiDtfRdvcyBjJ5Q==
X-Received: by 2002:a05:6000:258a:b0:429:cd3f:f43a with SMTP id
 ffacd0b85a97d-429cd3ff771mr4197767f8f.7.1762208381303; 
 Mon, 03 Nov 2025 14:19:41 -0800 (PST)
Received: from redhat.com ([31.187.78.75]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429dc1f5ab9sm971619f8f.22.2025.11.03.14.19.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 14:19:40 -0800 (PST)
Date: Mon, 3 Nov 2025 17:19:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: sgarzare@redhat.com, raphael@enfabrica.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>
Subject: Re: [PATCH v3 18/23] vhost: introduce check_memslots() helper
Message-ID: <20251103170946-mutt-send-email-mst@kernel.org>
References: <20251015145808.1112843-1-vsementsov@yandex-team.ru>
 <20251015145808.1112843-19-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015145808.1112843-19-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 15, 2025 at 05:58:02PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
> Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>


This needs a better commit log.
the subject makes it look like it's merely adding a helper
but it is not the case: e.g. errors are now handled
somewhat differently.

Pls document the thinking process explaining why it does not
matter. CB.


> ---
>  hw/virtio/vhost.c | 71 ++++++++++++++++++++++++++---------------------
>  1 file changed, 40 insertions(+), 31 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 34846edf36..56a812b06b 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1572,12 +1572,50 @@ static int vhost_dev_get_features(struct vhost_dev *hdev,
>      return r;
>  }
>  
> +static bool check_memslots(struct vhost_dev *hdev, Error **errp)
> +{
> +    unsigned int used, reserved, limit;
> +
> +    limit = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
> +    if (limit < MEMORY_DEVICES_SAFE_MAX_MEMSLOTS &&
> +        memory_devices_memslot_auto_decision_active()) {
> +        error_setg(errp, "some memory device (like virtio-mem)"
> +            " decided how many memory slots to use based on the overall"
> +            " number of memory slots; this vhost backend would further"
> +            " restricts the overall number of memory slots");
> +        error_append_hint(errp, "Try plugging this vhost backend before"
> +            " plugging such memory devices.\n");
> +        return false;
> +    }
> +
> +    /*
> +     * The listener we registered properly setup the number of required

This comment worked in the original code but not now.

The listener here is memory_listener_register which yes happens to
be called before check_memslots but it is far from obvious.



> +     * memslots in vhost_commit().
> +     */
> +    used = hdev->mem->nregions;



> +
> +    /*
> +     * We assume that all reserved memslots actually require a real memslot
> +     * in our vhost backend. This might not be true, for example, if the
> +     * memslot would be ROM. If ever relevant, we can optimize for that --
> +     * but we'll need additional information about the reservations.
> +     */
> +    reserved = memory_devices_get_reserved_memslots();
> +    if (used + reserved > limit) {
> +        error_setg(errp, "vhost backend memory slots limit (%d) is less"
> +                   " than current number of used (%d) and reserved (%d)"
> +                   " memory slots for memory devices.", limit, used, reserved);
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>                     VhostBackendType backend_type, uint32_t busyloop_timeout,
>                     Error **errp)
>  {
>      uint64_t features[VIRTIO_FEATURES_NU64S];
> -    unsigned int used, reserved, limit;
>      int i, r, n_initialized_vqs = 0;
>  
>      hdev->vdev = NULL;
> @@ -1603,19 +1641,6 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>          goto fail;
>      }
>  
> -    limit = hdev->vhost_ops->vhost_backend_memslots_limit(hdev);
> -    if (limit < MEMORY_DEVICES_SAFE_MAX_MEMSLOTS &&
> -        memory_devices_memslot_auto_decision_active()) {
> -        error_setg(errp, "some memory device (like virtio-mem)"
> -            " decided how many memory slots to use based on the overall"
> -            " number of memory slots; this vhost backend would further"
> -            " restricts the overall number of memory slots");
> -        error_append_hint(errp, "Try plugging this vhost backend before"
> -            " plugging such memory devices.\n");
> -        r = -EINVAL;
> -        goto fail;
> -    }
> -
>      for (i = 0; i < hdev->nvqs; ++i, ++n_initialized_vqs) {
>          r = vhost_virtqueue_init(hdev, hdev->vqs + i, hdev->vq_index + i,
>                                   busyloop_timeout);
> @@ -1674,23 +1699,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>      memory_listener_register(&hdev->memory_listener, &address_space_memory);


So it looks like with your change
this will temporarily register the listener
restricting the number of slots, then check and unregister.

Is this ever a problem?

commit log needs better documentation why.



>      QLIST_INSERT_HEAD(&vhost_devices, hdev, entry);
>  
> -    /*
> -     * The listener we registered properly setup the number of required
> -     * memslots in vhost_commit().
> -     */
> -    used = hdev->mem->nregions;
> -
> -    /*
> -     * We assume that all reserved memslots actually require a real memslot
> -     * in our vhost backend. This might not be true, for example, if the
> -     * memslot would be ROM. If ever relevant, we can optimize for that --
> -     * but we'll need additional information about the reservations.
> -     */
> -    reserved = memory_devices_get_reserved_memslots();
> -    if (used + reserved > limit) {
> -        error_setg(errp, "vhost backend memory slots limit (%d) is less"
> -                   " than current number of used (%d) and reserved (%d)"
> -                   " memory slots for memory devices.", limit, used, reserved);
> +    if (!check_memslots(hdev, errp)) {
>          r = -EINVAL;
>          goto fail;
>      }
> -- 
> 2.48.1


