Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BDDCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 12:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0g4b-00033t-QZ; Mon, 22 Sep 2025 08:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v0g4a-00033G-7l
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:55:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v0g4V-0000fl-87
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758545709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HYkxlL4bsiukOS5zuavn/QKSj71arWHTHCcBtubbIuQ=;
 b=ToltXn86elCEghSnoxShqC70WnL6STg8itqHex/BAskPxJkz7wZTtKDYAJ7wQVP7zYLhdP
 CgwPM0vLSFP/fAXBFRlDM9JEjDcjVsHPGcSqN2ugPi/tT0w1FLhVZi8SiEaH8hF7gIfvxK
 2PJKRpgPOZLmuFShfOvYEiKE9UfkIZQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-J1Q5mgJgONiI-1d5gtjDRA-1; Mon, 22 Sep 2025 08:55:05 -0400
X-MC-Unique: J1Q5mgJgONiI-1d5gtjDRA-1
X-Mimecast-MFC-AGG-ID: J1Q5mgJgONiI-1d5gtjDRA_1758545704
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e19f00bc2so3870815e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 05:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758545704; x=1759150504;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HYkxlL4bsiukOS5zuavn/QKSj71arWHTHCcBtubbIuQ=;
 b=TUwShZGiP5SafXFcXEGnJdrMQJryDiU6qnnhbEUh94pbEY3kcdeSxsFbvbhhbie5/S
 DdFdgPZkG2CdDEI0jBTpBijmLUX3KFGvm3ejTUQOYtROh3IHqfROVe8I2iPM1SgTW+GZ
 7NvGWGysAbn29/CVuYqorLNcKXWW5Urq7r/heYira6hwqj0mFuDe1EYCIlvLOoouXCPr
 W3GrUBmnMWvj1T5l/EcJ43kxgG7o96n07eRmC6m0/nFtWtVDSB2E5Fxi7Kt0vMHMgVKK
 nM+J5rI84oNfJks2M1hN72EOFzSU64sLQetGOlBZN+oNW4Rgoo8Iqqy2CAGZoZUFL537
 C1uw==
X-Gm-Message-State: AOJu0Yxkn6GVfk6nvHacnFRnX2AxZrEn4P8ZkZyNfpWoT44yJTbtllO1
 94XOJHnHaCgCon2Nd43sjnRxSOCYYV++6OSAlQsWaacNe3OVqcqsSvP8jS/4qZnNu2lQHDVD5s1
 AmPYhECaz5Q1YQFIldGnI+idliU/7/o0x7zMVK2P4YFO3Qw4EF7Dh3Qai
X-Gm-Gg: ASbGncvuSA9/vIWfkVGcf79kNXVD/HqKOhiQsjO1dxOt3Nuv7TUA0J/WolP7bTgVXjV
 FBMz8jF5msFHwSr7uoauUtBY4KgmpWwBDXohf7xhXR+Gr0mvl96AS+liEGCuJQPOzscRC4LpCo5
 mpr/I2he9Io+/WsQ3YGYUgohF65S5LuSvaaqSapIJtTTl9nmptcO4jAJ4FLJCOd1+J1ECAmN33Y
 eo7oieRPHatbYUdUbqTgQ9szBx16j75E9uLw/D/VKCr5P1VfxkCu9zGY/8RSO06cvLYRHc7P5JT
 9A/Cy/9537btB1lcRyOAcepBqvJT5B4MW0w=
X-Received: by 2002:a05:600c:a47:b0:45d:d86b:9e64 with SMTP id
 5b1f17b1804b1-467e78caa3emr121879255e9.15.1758545704417; 
 Mon, 22 Sep 2025 05:55:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA1C0LrohPZhqjeh+Cw7Shy10ASG3hCbNlRx1Q8H5J7y+x0jhHYJGSIlbCKf1a+fLH2ZJWqw==
X-Received: by 2002:a05:600c:a47:b0:45d:d86b:9e64 with SMTP id
 5b1f17b1804b1-467e78caa3emr121878935e9.15.1758545703860; 
 Mon, 22 Sep 2025 05:55:03 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3fac7463f2fsm6528680f8f.39.2025.09.22.05.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 05:55:03 -0700 (PDT)
Date: Mon, 22 Sep 2025 08:55:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Luigi Rizzo <lrizzo@google.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v6 09/14] qmp: update virtio features map to support
 extended features
Message-ID: <20250922085341-mutt-send-email-mst@kernel.org>
References: <cover.1757676218.git.pabeni@redhat.com>
 <bef09bed78378da9c32d9913eefb83bd42ba8808.1757676218.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bef09bed78378da9c32d9913eefb83bd42ba8808.1757676218.git.pabeni@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Sep 12, 2025 at 03:07:00PM +0200, Paolo Abeni wrote:
> Extend the VirtioDeviceFeatures struct with an additional u64
> to track unknown features in the 64-127 bit range and decode
> the full virtio features spaces for vhost and virtio devices.
> 
> Also add entries for the soon-to-be-supported virtio net GSO over
> UDP features.
> 
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> ---
> v3 -> v4:
>   - cleanup unknown features init
>   - update QMP example and doc accordingly
>   - use new virtio_features macro names
> 
> v2 -> v3:
>   - unknown-dev-features-dword2 -> unknown-dev-features2
>   - _array -> _ex
>   - fixed typos in entries description
> 
> v1 -> v2:
>   - uint128_t -> uint64_t[]
> ---
>  hw/virtio/virtio-hmp-cmds.c |  3 +-
>  hw/virtio/virtio-qmp.c      | 91 +++++++++++++++++++++++++------------
>  hw/virtio/virtio-qmp.h      |  3 +-
>  qapi/virtio.json            |  9 +++-
>  4 files changed, 74 insertions(+), 32 deletions(-)
> 
> diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
> index 7d8677bcf0..1daae482d3 100644
> --- a/hw/virtio/virtio-hmp-cmds.c
> +++ b/hw/virtio/virtio-hmp-cmds.c
> @@ -74,7 +74,8 @@ static void hmp_virtio_dump_features(Monitor *mon,
>      }
>  
>      if (features->has_unknown_dev_features) {
> -        monitor_printf(mon, "  unknown-features(0x%016"PRIx64")\n",
> +        monitor_printf(mon, "  unknown-features(0x%016"PRIx64"%016"PRIx64")\n",
> +                       features->unknown_dev_features2,
>                         features->unknown_dev_features);
>      }
>  }
> diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
> index 3b6377cf0d..502c9ae930 100644
> --- a/hw/virtio/virtio-qmp.c
> +++ b/hw/virtio/virtio-qmp.c
> @@ -325,6 +325,20 @@ static const qmp_virtio_feature_map_t virtio_net_feature_map[] = {
>      FEATURE_ENTRY(VHOST_USER_F_PROTOCOL_FEATURES, \
>              "VHOST_USER_F_PROTOCOL_FEATURES: Vhost-user protocol features "
>              "negotiation supported"),
> +    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO, \
> +            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "
> +            "UDP tunnel packets"),
> +    FEATURE_ENTRY(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM, \
> +            "VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO: Driver can receive GSO over "

This really should be VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM.

Given they all seem to start with repeating the feature name,
why not just add it to the string automatically by the macro?


> +            "UDP tunnel packets requiring checksum offload for the outer "
> +            "header"),
> +    FEATURE_ENTRY(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO, \
> +            "VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO: Device can receive GSO over "
> +            "UDP tunnel packets"),
> +    FEATURE_ENTRY(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM, \
> +            "VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO: Device can receive GSO over "
> +            "UDP tunnel packets requiring checksum offload for the outer "
> +            "header"),
>      { -1, "" }
>  };
>  #endif
> @@ -510,6 +524,24 @@ static const qmp_virtio_feature_map_t virtio_gpio_feature_map[] = {
>          list;                                            \
>      })
>  
> +#define CONVERT_FEATURES_EX(type, map, bitmap)           \
> +    ({                                                   \
> +        type *list = NULL;                               \
> +        type *node;                                      \
> +        for (i = 0; map[i].virtio_bit != -1; i++) {      \
> +            bit = map[i].virtio_bit;                     \
> +            if (!virtio_has_feature_ex(bitmap, bit)) {   \
> +                continue;                                \
> +            }                                            \
> +            node = g_new0(type, 1);                      \
> +            node->value = g_strdup(map[i].feature_desc); \
> +            node->next = list;                           \
> +            list = node;                                 \
> +            virtio_clear_feature_ex(bitmap, bit);        \
> +        }                                                \
> +        list;                                            \
> +    })
> +
>  VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap)
>  {
>      VirtioDeviceStatus *status;
> @@ -545,109 +577,112 @@ VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap)
>      return vhu_protocols;
>  }
>  
> -VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
> +VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id,
> +                                          const uint64_t *bmap)
>  {
> +    uint64_t bitmap[VIRTIO_FEATURES_NU64S];
>      VirtioDeviceFeatures *features;
>      uint64_t bit;
>      int i;
>  
> +    virtio_features_copy(bitmap, bmap);
>      features = g_new0(VirtioDeviceFeatures, 1);
>      features->has_dev_features = true;
>  
>      /* transport features */
> -    features->transports = CONVERT_FEATURES(strList, virtio_transport_map, 0,
> -                                            bitmap);
> +    features->transports = CONVERT_FEATURES_EX(strList, virtio_transport_map,
> +                                               bitmap);
>  
>      /* device features */
>      switch (device_id) {
>  #ifdef CONFIG_VIRTIO_SERIAL
>      case VIRTIO_ID_CONSOLE:
>          features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_serial_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_serial_feature_map, bitmap);
>          break;
>  #endif
>  #ifdef CONFIG_VIRTIO_BLK
>      case VIRTIO_ID_BLOCK:
>          features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_blk_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_blk_feature_map, bitmap);
>          break;
>  #endif
>  #ifdef CONFIG_VIRTIO_GPU
>      case VIRTIO_ID_GPU:
>          features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_gpu_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_gpu_feature_map, bitmap);
>          break;
>  #endif
>  #ifdef CONFIG_VIRTIO_NET
>      case VIRTIO_ID_NET:
>          features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_net_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_net_feature_map, bitmap);
>          break;
>  #endif
>  #ifdef CONFIG_VIRTIO_SCSI
>      case VIRTIO_ID_SCSI:
>          features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_scsi_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_scsi_feature_map, bitmap);
>          break;
>  #endif
>  #ifdef CONFIG_VIRTIO_BALLOON
>      case VIRTIO_ID_BALLOON:
>          features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_balloon_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_balloon_feature_map, bitmap);
>          break;
>  #endif
>  #ifdef CONFIG_VIRTIO_IOMMU
>      case VIRTIO_ID_IOMMU:
>          features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_iommu_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_iommu_feature_map, bitmap);
>          break;
>  #endif
>  #ifdef CONFIG_VIRTIO_INPUT
>      case VIRTIO_ID_INPUT:
>          features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_input_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_input_feature_map, bitmap);
>          break;
>  #endif
>  #ifdef CONFIG_VHOST_USER_FS
>      case VIRTIO_ID_FS:
>          features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_fs_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_fs_feature_map, bitmap);
>          break;
>  #endif
>  #ifdef CONFIG_VHOST_VSOCK
>      case VIRTIO_ID_VSOCK:
>          features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_vsock_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_vsock_feature_map, bitmap);
>          break;
>  #endif
>  #ifdef CONFIG_VIRTIO_CRYPTO
>      case VIRTIO_ID_CRYPTO:
>          features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_crypto_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_crypto_feature_map, bitmap);
>          break;
>  #endif
>  #ifdef CONFIG_VIRTIO_MEM
>      case VIRTIO_ID_MEM:
>          features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_mem_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_mem_feature_map, bitmap);
>          break;
>  #endif
>  #ifdef CONFIG_VIRTIO_I2C_ADAPTER
>      case VIRTIO_ID_I2C_ADAPTER:
>          features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_i2c_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_i2c_feature_map, bitmap);
>          break;
>  #endif
>  #ifdef CONFIG_VIRTIO_RNG
>      case VIRTIO_ID_RNG:
>          features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_rng_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_rng_feature_map, bitmap);
>          break;
>  #endif
>  #ifdef CONFIG_VHOST_USER_GPIO
>      case VIRTIO_ID_GPIO:
>          features->dev_features =
> -            CONVERT_FEATURES(strList, virtio_gpio_feature_map, 0, bitmap);
> +            CONVERT_FEATURES_EX(strList, virtio_gpio_feature_map, bitmap);
>          break;
>  #endif
>      /* No features */
> @@ -680,10 +715,9 @@ VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap)
>          g_assert_not_reached();
>      }
>  
> -    features->has_unknown_dev_features = bitmap != 0;
> -    if (features->has_unknown_dev_features) {
> -        features->unknown_dev_features = bitmap;
> -    }
> +    features->has_unknown_dev_features = !virtio_features_empty(bitmap);
> +    features->unknown_dev_features = bitmap[0];
> +    features->unknown_dev_features2 = bitmap[1];
>  
>      return features;
>  }
> @@ -743,11 +777,11 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>      status->device_id = vdev->device_id;
>      status->vhost_started = vdev->vhost_started;
>      status->guest_features = qmp_decode_features(vdev->device_id,
> -                                                 vdev->guest_features);
> +                                                 vdev->guest_features_ex);
>      status->host_features = qmp_decode_features(vdev->device_id,
> -                                                vdev->host_features);
> +                                                vdev->host_features_ex);
>      status->backend_features = qmp_decode_features(vdev->device_id,
> -                                                   vdev->backend_features);
> +                                                 vdev->backend_features_ex);
>  
>      switch (vdev->device_endian) {
>      case VIRTIO_DEVICE_ENDIAN_LITTLE:
> @@ -785,11 +819,12 @@ VirtioStatus *qmp_x_query_virtio_status(const char *path, Error **errp)
>          status->vhost_dev->nvqs = hdev->nvqs;
>          status->vhost_dev->vq_index = hdev->vq_index;
>          status->vhost_dev->features =
> -            qmp_decode_features(vdev->device_id, hdev->features);
> +            qmp_decode_features(vdev->device_id, hdev->features_ex);
>          status->vhost_dev->acked_features =
> -            qmp_decode_features(vdev->device_id, hdev->acked_features);
> +            qmp_decode_features(vdev->device_id, hdev->acked_features_ex);
>          status->vhost_dev->backend_features =
> -            qmp_decode_features(vdev->device_id, hdev->backend_features);
> +            qmp_decode_features(vdev->device_id, hdev->backend_features_ex);
> +
>          status->vhost_dev->protocol_features =
>              qmp_decode_protocols(hdev->protocol_features);
>          status->vhost_dev->max_queues = hdev->max_queues;
> diff --git a/hw/virtio/virtio-qmp.h b/hw/virtio/virtio-qmp.h
> index 245a446a56..e0a1e49035 100644
> --- a/hw/virtio/virtio-qmp.h
> +++ b/hw/virtio/virtio-qmp.h
> @@ -18,6 +18,7 @@
>  VirtIODevice *qmp_find_virtio_device(const char *path);
>  VirtioDeviceStatus *qmp_decode_status(uint8_t bitmap);
>  VhostDeviceProtocols *qmp_decode_protocols(uint64_t bitmap);
> -VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id, uint64_t bitmap);
> +VirtioDeviceFeatures *qmp_decode_features(uint16_t device_id,
> +                                          const uint64_t *bitmap);
>  
>  #endif
> diff --git a/qapi/virtio.json b/qapi/virtio.json
> index 9d652fe4a8..05295ab665 100644
> --- a/qapi/virtio.json
> +++ b/qapi/virtio.json
> @@ -247,6 +247,7 @@
>  #              },
>  #              "host-features": {
>  #                  "unknown-dev-features": 1073741824,
> +#                  "unknown-dev-features2": 0,
>  #                  "dev-features": [],
>  #                  "transports": [
>  #                      "VIRTIO_RING_F_EVENT_IDX: Used & avail. event fields enabled",
> @@ -490,14 +491,18 @@
>  #     unique features)
>  #
>  # @unknown-dev-features: Virtio device features bitmap that have not
> -#     been decoded
> +#     been decoded (bits 0-63)
> +#
> +# @unknown-dev-features2: Virtio device features bitmap that have not
> +#     been decoded (bits 64-127) (since 10.2)
>  #
>  # Since: 7.2
>  ##
>  { 'struct': 'VirtioDeviceFeatures',
>    'data': { 'transports': [ 'str' ],
>              '*dev-features': [ 'str' ],
> -            '*unknown-dev-features': 'uint64' } }
> +            '*unknown-dev-features': 'uint64',
> +            '*unknown-dev-features2': 'uint64' } }
>  
>  ##
>  # @VirtQueueStatus:
> -- 
> 2.51.0


