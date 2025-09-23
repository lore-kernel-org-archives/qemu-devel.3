Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C94ACAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 16:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v15i7-0007rD-Nu; Tue, 23 Sep 2025 12:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v15i6-0007qv-RY
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 12:17:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v15i4-0004zb-PM
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 12:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758644263;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=K958dVo8y6lklIgZajxNrofaYx4S/oW9dCbLbS4byqc=;
 b=GN6qM6zZisLv/mWbc1nJWmuWhkx4r6XUmrtMr7bKgE4h//VXoPxNe1pF/Y8rphmKHD+/6D
 2fE7CuS9B5Y3I/k+HY1lzJfVzHHsybuCas05OhbEQaUnhvf5SePOv5ugolIb0Xin6LkgRH
 gc+9Lw3Re0j6XfRDsylbBNtSHOb/qbE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-sWwJo4kvPVm1RcxuNTByTA-1; Tue,
 23 Sep 2025 12:17:39 -0400
X-MC-Unique: sWwJo4kvPVm1RcxuNTByTA-1
X-Mimecast-MFC-AGG-ID: sWwJo4kvPVm1RcxuNTByTA_1758644258
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E60D1955F6A; Tue, 23 Sep 2025 16:17:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E53D1955F21; Tue, 23 Sep 2025 16:17:35 +0000 (UTC)
Date: Tue, 23 Sep 2025 17:17:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alessandro Ratti <alessandro@0x65c.net>
Cc: qemu-devel@nongnu.org, alessandro.ratti@gmail.com,
 alex.bennee@linaro.org, armbru@redhat.com, mst@redhat.com
Subject: Re: [PATCH v2] virtio: improve virtqueue mapping error messages
Message-ID: <aNLIHOwcGB47qbUY@redhat.com>
References: <20250923130034.486370-2-alessandro@0x65c.net>
 <20250923151127.504186-1-alessandro@0x65c.net>
 <20250923151127.504186-2-alessandro@0x65c.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250923151127.504186-2-alessandro@0x65c.net>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Sep 23, 2025 at 05:09:25PM +0200, Alessandro Ratti wrote:
> Improve error reporting when virtqueue ring mapping fails by including a
> device identifier in the error message.
> 
> Introduce a helper virtio_get_pretty_dev_name() that returns either:
> 
>  - the device ID, if explicitly provided (e.g. -device ...,id=foo)
>  - the QOM path from qdev_get_dev_path(dev) otherwise
>  - "<unknown device>" as a fallback when no identifier is present
> 
> This makes it easier to identify which device triggered the error in
> multi-device setups or when debugging complex guest configurations.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/230
> Buglink: https://bugs.launchpad.net/qemu/+bug/1919021
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>
> ---
>  hw/virtio/virtio.c | 46 +++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 9a81ad912e..f5adc381a4 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -235,6 +235,37 @@ static void virtio_virtqueue_reset_region_cache(struct VirtQueue *vq)
>      }
>  }
>  
> +static const char *virtio_get_pretty_dev_name(VirtIODevice *vdev)

I'd suggest this be  'const char *qdev_get_printable_name(DeviceState *dev)'
and live in  the same header & source files as qdev_get_dev_path.

I used 'printable' rather than 'pretty' as I'm not sure I'd claim
that qdev_get_dev_path() results can be said to be pretty :-)

> +{
> +    DeviceState *dev = DEVICE(vdev);
> +
> +    /*
> +     * Return device ID if explicity set
> +     * (e.g. -device virtio-blk-pci,id=foo)
> +     * This allows users to correlate errors with their custom device
> +     * names.
> +     */
> +    if (dev->id) {
> +        return dev->id;
> +    }
> +    /*
> +     * Fall back to the canonical QOM device path (eg. ID for PCI
> +     * devices).
> +     * This ensures the device is still uniquely and meaningfully
> +     * identified.
> +     */
> +    const char *path = qdev_get_dev_path(dev);
> +    if (path) {
> +        return path;
> +    }
> +
> +    /*
> +     * Final fallback: if all else fails, return a placeholder string.
> +     * This ensures the error message always contains a valid string.
> +     */
> +    return "<unknow device>";

s/unknow/unknown/

> +}
> +
>  void virtio_init_region_cache(VirtIODevice *vdev, int n)
>  {
>      VirtQueue *vq = &vdev->vq[n];
> @@ -256,7 +287,10 @@ void virtio_init_region_cache(VirtIODevice *vdev, int n)
>      len = address_space_cache_init(&new->desc, vdev->dma_as,
>                                     addr, size, packed);
>      if (len < size) {
> -        virtio_error(vdev, "Cannot map desc");
> +        virtio_error(vdev,
> +                "Failed to map descriptor ring for device %s: "
> +                "invalid guest physical address or corrupted queue setup",
> +                virtio_get_pretty_dev_name(vdev));
>          goto err_desc;
>      }
>  
> @@ -264,7 +298,10 @@ void virtio_init_region_cache(VirtIODevice *vdev, int n)
>      len = address_space_cache_init(&new->used, vdev->dma_as,
>                                     vq->vring.used, size, true);
>      if (len < size) {
> -        virtio_error(vdev, "Cannot map used");
> +        virtio_error(vdev,
> +                "Failed to map used ring for device %s: "
> +                "possible guest misconfiguration or insufficient memory",
> +                virtio_get_pretty_dev_name(vdev));
>          goto err_used;
>      }
>  
> @@ -272,7 +309,10 @@ void virtio_init_region_cache(VirtIODevice *vdev, int n)
>      len = address_space_cache_init(&new->avail, vdev->dma_as,
>                                     vq->vring.avail, size, false);
>      if (len < size) {
> -        virtio_error(vdev, "Cannot map avail");
> +        virtio_error(vdev,
> +                "Failed to map avalaible ring for device %s: "
> +                "possible queue misconfiguration or overlapping memory region",
> +                virtio_get_pretty_dev_name(vdev));
>          goto err_avail;
>      }

This part all looks good


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


