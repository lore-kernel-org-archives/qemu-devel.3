Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226A3CA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 12:20:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyr8u-0001dF-BX; Wed, 17 Sep 2025 08:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uyr8r-0001cO-5f
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 08:20:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1uyr8o-0008Pi-Nc
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 08:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758111604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vuu8b8Kza+pFJVzlVBAMWaF4heF4L6Hxwkyvsz1d+P8=;
 b=HnPUXve3uspCUXNHlBMs4L7qROX1IswGKbzxXYbgP0bXrcEB+CPv7bMvx2TMEzre1UqhX+
 GKrIhvauDTbusnRdhgrH2qi0LFIedxLLiX4U1ZnLuCjK0E5fNOqhXuMT13xU+0CmuUkdBd
 b8IervBqSs2BeJ1XOPAsSw4vIA/056c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-KAOZjUSFMvWUc5a0J6gaag-1; Wed, 17 Sep 2025 08:20:03 -0400
X-MC-Unique: KAOZjUSFMvWUc5a0J6gaag-1
X-Mimecast-MFC-AGG-ID: KAOZjUSFMvWUc5a0J6gaag_1758111602
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45de18e7eccso35141635e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 05:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758111602; x=1758716402;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vuu8b8Kza+pFJVzlVBAMWaF4heF4L6Hxwkyvsz1d+P8=;
 b=SZtbk7sTt/EkLd1yHmTmbrICbTvLvd08K/c2BVTgVROEcdrLtLLEQ+lDuHhWNtsZvT
 mBg6bnRShl9oNvFUx1w/Gg6LHkEHZ6klb0t/hjnK5nCphqneEzgZ3hUvaht2Pg0zx7+2
 HgDbGa9Cxfbsxc4TrMv6DP4BkjVM4fFhtT17RLUech50Ef9NVnDzSRWlqh8bb8hP0CdD
 ueMAwOBSA3sZs+hqP3v0shMVT7/E/1CHpAmXZZ7VoXROu2NJ1Is8F4utbRJHNn4ojwZG
 H7U+P3+2pOabJ16XJsWmBuETjx8lOv9t/yCRXO2Kix1pD5gEnUgrXW1arbXf/4bFV27W
 sAmQ==
X-Gm-Message-State: AOJu0YyWV1XZH7+bqE2DGZlg5LmCPEJBzROxuYFrUocuE9SohE+nz3/G
 FYEVfiwFjyXV3fyngGWwCRwecQ8MDcpm8DHWNHQ4+aLMGNL3/gZILNkqs8r9KmQRXTAjb8jvhpd
 FobIB1MpoDkKhvEsIQvOw49xRcOwd1gxQun1DoQ+36ZHVYL5UgMGrgUkc
X-Gm-Gg: ASbGncvE3N4G5bHFUifdG+Mnug/tTBDMSV42lCtPYt/1eS70YP7as4Tv/JjZJ97wRHH
 dYwNqtdwwWkHz0IzXvA+hT/NsDdbGMN6BAhC0yHkkznrkYzzjhI3R9k5dA0ei0QuuEkILI3z7kL
 H9+suRbA1ysmdaClSBym9J6Zp1j38ETUlcv6tdc6eMtUU7DpkEu8w81w0MwhQGZ/xkVkUvGekgV
 N388hhrbDd57zIsDL/oAJ/k86lXEXuZlZ1ETXRqtSMg8kmTARPEcfi3Nkk2ixKxOpFxuNe5tdAh
 govYClUqu2zpsrQb7n1RzMDnEp4LdzB78lRRnX12l9/W
X-Received: by 2002:a05:600c:1c9b:b0:45d:d9ab:b85a with SMTP id
 5b1f17b1804b1-46201f8b09fmr17706715e9.7.1758111602348; 
 Wed, 17 Sep 2025 05:20:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwZnipNtRPedPzgLlRA2Bb0Fwb2vjeXkEz3pBzvXcG6EOlQq+8HRmI/5KWYeLreO1Ec5Ngsg==
X-Received: by 2002:a05:600c:1c9b:b0:45d:d9ab:b85a with SMTP id
 5b1f17b1804b1-46201f8b09fmr17706315e9.7.1758111601803; 
 Wed, 17 Sep 2025 05:20:01 -0700 (PDT)
Received: from sgarzare-redhat ([5.179.183.148])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-462d525fdb2sm12852305e9.13.2025.09.17.05.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 05:20:01 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:19:51 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6 06/14] virtio: add support for negotiating extended
 features
Message-ID: <nszuwj7p6zgfhbaz5yyc2kid4noqoi2egetah52lix4kxjmhly@echi6d4st6b7>
References: <cover.1757676218.git.pabeni@redhat.com>
 <ff35cd27b9af410ca1175e97ef4b9c073c93b907.1757676218.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ff35cd27b9af410ca1175e97ef4b9c073c93b907.1757676218.git.pabeni@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Sep 12, 2025 at 03:06:57PM +0200, Paolo Abeni wrote:
>The virtio specifications allows for up to 128 bits for the

I'm not really sure about this, IIUC the spec doesn't set any upper 
limit. From 
https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-140002

     2.2 Feature Bits
     ...
     42 to 49, and 128 and above
         Feature bits reserved for future extensions.

BTW I don't think that's a valid reason to re-post this series. Let's 
only fix it if we have to re-send it for other reason.

Acked-by: Stefano Garzarella <sgarzare@redhat.com>

>device features. Soon we are going to use some of the 'extended'
>bits features for the virtio net driver.
>
>Add support to allow extended features negotiation on a per
>devices basis. Devices willing to negotiated extended features
>need to implemented a new pair of features getter/setter, the
>core will conditionally use them instead of the basic one.
>
>Note that 'bad_features' don't need to be extended, as they are
>bound to the 64 bits limit.
>
>Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>Acked-by: Jason Wang <jasowang@redhat.com>
>Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>---
>v4 -> v5:
>  - reordered virtio_set_features{_ex}() definitions
>
>v3 -> v4:
>  - use new virtio_features macro names
>
>v2 -> v3:
>  - _array -> _ex
>
>v1 -> v2:
>  - uint128_t -> uint64_t[]
>---
> hw/virtio/virtio-bus.c     | 11 ++++++++---
> hw/virtio/virtio.c         | 14 +++++++++++---
> include/hw/virtio/virtio.h |  4 ++++
> 3 files changed, 23 insertions(+), 6 deletions(-)
>
>diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
>index 11adfbf3ab..cef944e015 100644
>--- a/hw/virtio/virtio-bus.c
>+++ b/hw/virtio/virtio-bus.c
>@@ -62,9 +62,14 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
>     }
>
>     /* Get the features of the plugged device. */
>-    assert(vdc->get_features != NULL);
>-    vdev->host_features = vdc->get_features(vdev, vdev->host_features,
>-                                            &local_err);
>+    if (vdc->get_features_ex) {
>+        vdc->get_features_ex(vdev, vdev->host_features_ex, &local_err);
>+    } else {
>+        assert(vdc->get_features != NULL);
>+        virtio_features_from_u64(vdev->host_features_ex,
>+                                 vdc->get_features(vdev, vdev->host_features,
>+                                                   &local_err));
>+    }
>     if (local_err) {
>         error_propagate(errp, local_err);
>         return;
>diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>index bf53c211e5..34f977a3c9 100644
>--- a/hw/virtio/virtio.c
>+++ b/hw/virtio/virtio.c
>@@ -3103,7 +3103,9 @@ static int virtio_set_features_nocheck(VirtIODevice *vdev, const uint64_t *val)
>     bad = virtio_features_andnot(tmp, val, vdev->host_features_ex);
>     virtio_features_and(tmp, val, vdev->host_features_ex);
>
>-    if (k->set_features) {
>+    if (k->set_features_ex) {
>+        k->set_features_ex(vdev, val);
>+    } else if (k->set_features) {
>         bad = bad || virtio_features_use_ex(tmp);
>         k->set_features(vdev, tmp[0]);
>     }
>@@ -3149,6 +3151,13 @@ virtio_set_features_nocheck_maybe_co(VirtIODevice *vdev,
> int virtio_set_features(VirtIODevice *vdev, uint64_t val)
> {
>     uint64_t features[VIRTIO_FEATURES_NU64S];
>+
>+    virtio_features_from_u64(features, val);
>+    return virtio_set_features_ex(vdev, features);
>+}
>+
>+int virtio_set_features_ex(VirtIODevice *vdev, const uint64_t *features)
>+{
>     int ret;
>     /*
>      * The driver must not attempt to set features after feature negotiation
>@@ -3158,13 +3167,12 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
>         return -EINVAL;
>     }
>
>-    if (val & (1ull << VIRTIO_F_BAD_FEATURE)) {
>+    if (features[0] & (1ull << VIRTIO_F_BAD_FEATURE)) {
>         qemu_log_mask(LOG_GUEST_ERROR,
>                       "%s: guest driver for %s has enabled UNUSED(30) feature bit!\n",
>                       __func__, vdev->name);
>     }
>
>-    virtio_features_from_u64(features, val);
>     ret = virtio_set_features_nocheck(vdev, features);
>     if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
>         /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
>diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
>index 39e4059a66..2aeb021fb3 100644
>--- a/include/hw/virtio/virtio.h
>+++ b/include/hw/virtio/virtio.h
>@@ -178,6 +178,9 @@ struct VirtioDeviceClass {
>     /* This is what a VirtioDevice must implement */
>     DeviceRealize realize;
>     DeviceUnrealize unrealize;
>+    void (*get_features_ex)(VirtIODevice *vdev, uint64_t *requested_features,
>+                            Error **errp);
>+    void (*set_features_ex)(VirtIODevice *vdev, const uint64_t *val);
>     uint64_t (*get_features)(VirtIODevice *vdev,
>                              uint64_t requested_features,
>                              Error **errp);
>@@ -373,6 +376,7 @@ void virtio_queue_reset(VirtIODevice *vdev, uint32_t queue_index);
> void virtio_queue_enable(VirtIODevice *vdev, uint32_t queue_index);
> void virtio_update_irq(VirtIODevice *vdev);
> int virtio_set_features(VirtIODevice *vdev, uint64_t val);
>+int virtio_set_features_ex(VirtIODevice *vdev, const uint64_t *val);
>
> /* Base devices.  */
> typedef struct VirtIOBlkConf VirtIOBlkConf;
>-- 
>2.51.0
>


