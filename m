Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9160C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 15:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl8lD-00062R-6w; Thu, 20 Feb 2025 10:46:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tl8lB-000626-2t
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:46:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tl8l8-0003s4-NE
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740066401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VpgfrzZKHe9MJAEx8kiEytURWOTZ749xYRAZLvcNEyc=;
 b=P2bDH094V6qofdQOz7f7bPmTPLEJBJM5ZZF6FdZw7IdbY8D/J/+oMne0AGoCqJqG90/8VS
 XQ+twRuCzPxMZsDAp7J+JoZmsK/EveLxnEKXT698j7fR5RgIT9fhiKkrRPL6b+6K84Kjzc
 nqqjSlFjObph5T4jwPQigvi9K4XDUy4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-gMkIrsUTOaSkaa_lWU0UyQ-1; Thu, 20 Feb 2025 10:46:38 -0500
X-MC-Unique: gMkIrsUTOaSkaa_lWU0UyQ-1
X-Mimecast-MFC-AGG-ID: gMkIrsUTOaSkaa_lWU0UyQ_1740066398
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5d9fb24f87bso2582020a12.0
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 07:46:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740066397; x=1740671197;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VpgfrzZKHe9MJAEx8kiEytURWOTZ749xYRAZLvcNEyc=;
 b=Kewl5z+/ztUoQ6KdXudtffwrPY9AmlC0lcoMgJqr0EhduDQRQ09i9Sxx+s6opat7cB
 KP57lxsH0x7MGdZBJs9Iv1n/LlEOqFC3OoYxWHb2NwtZG87csPkogb3hs7O4k3IbOK1y
 CW5yPZfWgm+/tNULiGPSagMoTktK8+YGoo7mdi22I3pO8c41wBTPHHSlbv76GJVoQy3s
 WxXT/MpvVl501R/Lf6qBHXBrZeXG6KSPfJMEIdWr0SrIkt4fjfSR0WbhOwqPS2au7UZn
 675T0Lp3Skpj/cdos1LyxahGHfbw6m9Ace/fqE+nmukPZr5UAI81illBUKI/r32mC7oI
 fOag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdRONgfB3PXAL+15ERoMtrK2Gjz2l7c+Rkb0lYIVEm54i5CDf1lj2fCI6r/vnZ7PztxFClDDOj44vM@nongnu.org
X-Gm-Message-State: AOJu0Yx0fy0riGdU5kNRdsPlJjrB6mS0/2APJ4OSXyoxRtpQLL88O8xV
 F4jXHqjEeKHSvF7sA6eL4iMkgojs+VlbqTgndyTh6kUgfSyKoWlM/OJubSrc1qdzx1t66HuqOJ9
 1sC283bZJIaAw5rRFfZiVPJK7NXKs3z7BwS3HGOCVVIbAOREnjprc
X-Gm-Gg: ASbGncsnok/24+sSOs5zasL/xy7sYP1GxUIvFgIkWK8GG+jhpq6/v3IAp9kYJsv3P3G
 qe8U87kKx4m3i49ROh6kBubqpGw8cSrIYIFPbFvzpCyIHgMeaWOUer6ENYPSJ8mO2bodmBtC/Yv
 wR+Xyf3GNjSzy2XMhvjwYabAhGq+Xw3CThSTkAzI1wMrVlAEAl3xAdTppxGEEeW4/mG1Em/0o+9
 +5fkARa2dK5GO3764BYgVNxN7Ama15B7FzdhW42J17eDMo6HTA2eR9rqMU/YxawQaLX+w==
X-Received: by 2002:a17:906:3148:b0:ab7:e41d:34b6 with SMTP id
 a640c23a62f3a-abbccf0839bmr684412866b.28.1740066397503; 
 Thu, 20 Feb 2025 07:46:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxKUDNUn3FzxmOebehayLlo1ohXWZo4+3ua2GQ0Q89azPlWrlBfZ0OePwP3x916TrXn5rgbw==
X-Received: by 2002:a17:906:3148:b0:ab7:e41d:34b6 with SMTP id
 a640c23a62f3a-abbccf0839bmr684409666b.28.1740066397081; 
 Thu, 20 Feb 2025 07:46:37 -0800 (PST)
Received: from redhat.com ([2.55.163.174]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abb98ed07afsm824946866b.102.2025.02.20.07.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 07:46:36 -0800 (PST)
Date: Thu, 20 Feb 2025 10:46:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Luigi Rizzo <rizzo@iet.unipi.it>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Lei Yang <leiyang@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v5 4/4] virtio: Convert feature properties to OnOffAuto
Message-ID: <20250220104248-mutt-send-email-mst@kernel.org>
References: <20250208-virtio-v5-0-4376cb218c0f@daynix.com>
 <20250208-virtio-v5-4-4376cb218c0f@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208-virtio-v5-4-4376cb218c0f@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Sat, Feb 08, 2025 at 04:51:10PM +0900, Akihiko Odaki wrote:
> Some features are not always available with vhost. Legacy features are
> not available with vp_vdpa in particular. virtio devices used to disable
> them when not available even if the corresponding properties were
> explicitly set to "on".
> 
> QEMU already has OnOffAuto type, which includes the "auto" value to let
> it automatically decide the effective value. Convert feature properties
> to OnOffAuto and set them "auto" by default to utilize it. This allows
> QEMU to report an error if they are set "on" and the corresponding
> features are not available.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

> ---
>  include/hw/virtio/virtio.h | 38 +++++++++++++++++++++-----------------
>  hw/core/machine.c          |  1 +
>  hw/virtio/virtio-bus.c     | 14 ++++++++++++--
>  hw/virtio/virtio.c         |  4 +++-
>  4 files changed, 37 insertions(+), 20 deletions(-)
> 
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 638691028050d2599592d8c7e95c75ac3913fbdd..b854c2cb1d04da0a35165289c28f87e8cb869df6 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -113,7 +113,8 @@ struct VirtIODevice
>      uint16_t queue_sel;
>      /**
>       * These fields represent a set of VirtIO features at various
> -     * levels of the stack. @host_features indicates the complete
> +     * levels of the stack. @requested_features indicates the feature
> +     * set the user requested. @host_features indicates the complete
>       * feature set the VirtIO device can offer to the driver.
>       * @guest_features indicates which features the VirtIO driver has
>       * selected by writing to the feature register. Finally
> @@ -121,6 +122,7 @@ struct VirtIODevice
>       * backend (e.g. vhost) and could potentially be a subset of the
>       * total feature set offered by QEMU.
>       */
> +    OnOffAutoBit64 requested_features;
>      uint64_t host_features;
>      uint64_t guest_features;
>      uint64_t backend_features;
> @@ -149,6 +151,7 @@ struct VirtIODevice
>      bool started;
>      bool start_on_kick; /* when virtio 1.0 feature has not been negotiated */
>      bool disable_legacy_check;
> +    bool force_features_auto;
>      bool vhost_started;
>      VMChangeStateEntry *vmstate;
>      char *bus_name;
> @@ -376,22 +379,23 @@ typedef struct VirtIOSCSIConf VirtIOSCSIConf;
>  typedef struct VirtIORNGConf VirtIORNGConf;
>  
>  #define DEFINE_VIRTIO_COMMON_FEATURES(_state, _field) \
> -    DEFINE_PROP_BIT64("indirect_desc", _state, _field,    \
> -                      VIRTIO_RING_F_INDIRECT_DESC, true), \
> -    DEFINE_PROP_BIT64("event_idx", _state, _field,        \
> -                      VIRTIO_RING_F_EVENT_IDX, true),     \
> -    DEFINE_PROP_BIT64("notify_on_empty", _state, _field,  \
> -                      VIRTIO_F_NOTIFY_ON_EMPTY, true), \
> -    DEFINE_PROP_BIT64("any_layout", _state, _field, \
> -                      VIRTIO_F_ANY_LAYOUT, true), \
> -    DEFINE_PROP_BIT64("iommu_platform", _state, _field, \
> -                      VIRTIO_F_IOMMU_PLATFORM, false), \
> -    DEFINE_PROP_BIT64("packed", _state, _field, \
> -                      VIRTIO_F_RING_PACKED, false), \
> -    DEFINE_PROP_BIT64("queue_reset", _state, _field, \
> -                      VIRTIO_F_RING_RESET, true), \
> -    DEFINE_PROP_BIT64("in_order", _state, _field, \
> -                      VIRTIO_F_IN_ORDER, false)
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("indirect_desc", _state, _field, \
> +                                  VIRTIO_RING_F_INDIRECT_DESC, \
> +                                  ON_OFF_AUTO_AUTO), \
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("event_idx", _state, _field, \
> +                                  VIRTIO_RING_F_EVENT_IDX, ON_OFF_AUTO_AUTO), \
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("notify_on_empty", _state, _field, \
> +                                  VIRTIO_F_NOTIFY_ON_EMPTY, ON_OFF_AUTO_AUTO), \
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("any_layout", _state, _field, \
> +                                  VIRTIO_F_ANY_LAYOUT, ON_OFF_AUTO_AUTO), \
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("iommu_platform", _state, _field, \
> +                                  VIRTIO_F_IOMMU_PLATFORM, ON_OFF_AUTO_OFF), \
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("packed", _state, _field, \
> +                                  VIRTIO_F_RING_PACKED, ON_OFF_AUTO_OFF), \
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("queue_reset", _state, _field, \
> +                                  VIRTIO_F_RING_RESET, ON_OFF_AUTO_AUTO), \
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("in_order", _state, _field, \
> +                                  VIRTIO_F_IN_ORDER, ON_OFF_AUTO_OFF)
>  
>  hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
>  bool virtio_queue_enabled_legacy(VirtIODevice *vdev, int n);
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index c23b39949649054ac59d2a9b497f34e1b7bd8d6c..0de04baa61735ff02f797f778c626ef690625ce3 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -38,6 +38,7 @@
>  
>  GlobalProperty hw_compat_9_2[] = {
>      {"arm-cpu", "backcompat-pauth-default-use-qarma5", "true"},
> +    { TYPE_VIRTIO_DEVICE, "x-force-features-auto", "on" },
>  };
>  const size_t hw_compat_9_2_len = G_N_ELEMENTS(hw_compat_9_2);
>  

Confused why this is on.
If set, this breaks existing setups if they run a configuration vhost
does not support, does it not?
And in particular, aren't some of these features exposed through
libvirt?

> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> index 896feb37a1caa805543e971c150d3673675b9a6b..75d433b252d5337d91616a2847b3dc12e811c2da 100644
> --- a/hw/virtio/virtio-bus.c
> +++ b/hw/virtio/virtio-bus.c
> @@ -50,6 +50,7 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
>      bool has_iommu = virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
>      bool vdev_has_iommu;
>      Error *local_err = NULL;
> +    uint64_t features;
>  
>      DPRINTF("%s: plug device.\n", qbus->name);
>  
> @@ -63,13 +64,22 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
>  
>      /* Get the features of the plugged device. */
>      assert(vdc->get_features != NULL);
> -    vdev->host_features = vdc->get_features(vdev, vdev->host_features,
> -                                            &local_err);
> +    features = vdev->host_features | vdev->requested_features.auto_bits |
> +               vdev->requested_features.on_bits;
> +    features = vdc->get_features(vdev, features, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
>      }
>  
> +    if (!vdev->force_features_auto &&
> +        (features & vdev->requested_features.on_bits) != vdev->requested_features.on_bits) {
> +        error_setg(errp, "A requested feature is not supported by the device");
> +        return;
> +    }
> +
> +    vdev->host_features = features;
> +
>      if (klass->device_plugged != NULL) {
>          klass->device_plugged(qbus->parent, &local_err);
>      }
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 85110bce37443bb46c4159761af112d0dba466b4..83f803fc703da6257608e21476305c8e9c6a8b07 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -4013,11 +4013,13 @@ static void virtio_device_instance_finalize(Object *obj)
>  }
>  
>  static const Property virtio_properties[] = {
> -    DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
> +    DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, requested_features),
>      DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
>      DEFINE_PROP_BOOL("use-disabled-flag", VirtIODevice, use_disabled_flag, true),
>      DEFINE_PROP_BOOL("x-disable-legacy-check", VirtIODevice,
>                       disable_legacy_check, false),
> +    DEFINE_PROP_BOOL("x-force-features-auto", VirtIODevice,
> +                     force_features_auto, false),
>  };
>  
>  static int virtio_device_start_ioeventfd_impl(VirtIODevice *vdev)
> 
> -- 
> 2.48.1


