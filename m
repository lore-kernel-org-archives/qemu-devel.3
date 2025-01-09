Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2062CE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 10:08:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVpRo-0003yb-3r; Thu, 09 Jan 2025 05:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tVpRm-0003yL-FD
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:07:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tVpRk-0007US-5F
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 05:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736417241;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pr0SRpfso4c4/HtRFHD5QReubWWYiEvTKa20yaF4baU=;
 b=Twk84OjtxZlkkDObom3kVsQoULFs4eXWRDeqptYKn4P2JNLotQVzt7xNmjVfPJQeUAv6+y
 oGQqBjE80hKAwkhSRJKrxbkRscCdASCpErjg20wI4U30XMB74LfK123sR5xaOaHxDP9dfW
 dnjR1jvg/aapQVhhq/Pkx47gEjrKFu0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-0trA8YIrORSZ-eArBzYpRA-1; Thu, 09 Jan 2025 05:07:19 -0500
X-MC-Unique: 0trA8YIrORSZ-eArBzYpRA-1
X-Mimecast-MFC-AGG-ID: 0trA8YIrORSZ-eArBzYpRA
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ab2d052894bso24702566b.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 02:07:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736417238; x=1737022038;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pr0SRpfso4c4/HtRFHD5QReubWWYiEvTKa20yaF4baU=;
 b=EhGJV/TgnzB1oXZO2KJIijl5pernInzx6O24Gr22zeGG+YOHbmcz9EmlpKYH3hyzvH
 OvLxkw2y/gaM9betIP6jEMGlnmXZdU/tAnwqdGLu5oh+whmwxx7I04dCU151dtk7jwTG
 YwhxQTEvyJ3v9ntAHr4t1mJPB5TPD1q5x6eEzOYVMUe/sFDQ+eOR2dGPgcb+0nzfbmO6
 bPfkC1qknuv7AQxwta8QsBBL4zz4GbwctRZzjXiSE89EOFBYU6hAj0k2y+L8dM5YV2Fi
 676df3XZmxY1dvbd7FttPjp/dsZS4pSLxoQINt01J1VXpwrqmPgsOxvFw0VjgspaOqf6
 Dr5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeG/lvQGdOb1RPokc8e3ck9pIyd3XY1k/L4k+Kkz4ZW8ZWUeNBNhz65lSal94grfpHF0uio52Eecxp@nongnu.org
X-Gm-Message-State: AOJu0YxJg/F3s+G2uIkx/zpQDDCOZef0kuR278++cOvTsJbAh5KNQDlD
 HtsT0aPMWo2M4zjakBLomM/1TegFOQPGNR8o1aHyDelwqUxETolN2DNVGvRYn7njepsezjCy9uP
 PgpdgGnzCiw8kYoKizab6kzNjb1rZE3kaGAy7PXbrE91Zz6UKHQHRnZC2leUNHXgMNVn4cOkm7J
 xIqxFEjaM5lBI2DLHxRsylNPlf0qg=
X-Gm-Gg: ASbGncvHgCTDz3eg7rT6uL78sXrY7U/JS3cssd3HplK0elwfyFxzo1hb1t5YuM9rPfF
 /R364IMiM7WsqqPuXaqIkDhY9g/2a06JPCTCoJsk=
X-Received: by 2002:a05:6402:1ed1:b0:5d0:d208:4cad with SMTP id
 4fb4d7f45d1cf-5d98a105e8emr1584612a12.2.1736417236946; 
 Thu, 09 Jan 2025 02:07:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5LKnxDz5QItEj1CoXAP10Tfy/SVaxn9OnAV1pHnBdeZVoGdLQSZADX/fHMLqCn2driVUAJQvRjCO+833AAHE=
X-Received: by 2002:a05:6402:1ed1:b0:5d0:d208:4cad with SMTP id
 4fb4d7f45d1cf-5d98a105e8emr1584583a12.2.1736417236554; Thu, 09 Jan 2025
 02:07:16 -0800 (PST)
MIME-Version: 1.0
References: <20250108-virtio-v4-0-cbf0aa04c9f9@daynix.com>
 <20250108-virtio-v4-4-cbf0aa04c9f9@daynix.com>
In-Reply-To: <20250108-virtio-v4-4-cbf0aa04c9f9@daynix.com>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 9 Jan 2025 18:06:39 +0800
X-Gm-Features: AbW1kvZd79yLTZnVj1T60rMuawRcDsantjHjkARrGDic9O2h7t8V0mEifeYbiUA
Message-ID: <CAPpAL=y9-qYf0z2UXhjPpytFizk9oDvU0yDSUV0urovE9670Bw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] virtio: Convert feature properties to OnOffAuto
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Luigi Rizzo <rizzo@iet.unipi.it>, Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster <armbru@redhat.com>, 
 Michael Roth <michael.roth@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I tested this series of patches v4 with virtio-net regression tests,
everything works fine. And the qemu core dump issues that hit it on v3
have gone.

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Jan 8, 2025 at 2:18=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
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
>  hw/core/machine.c          |  4 +++-
>  hw/virtio/virtio-bus.c     | 14 ++++++++++++--
>  hw/virtio/virtio.c         |  4 +++-
>  4 files changed, 39 insertions(+), 21 deletions(-)
>
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 638691028050..b854c2cb1d04 100644
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
>      bool start_on_kick; /* when virtio 1.0 feature has not been negotiat=
ed */
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
> +                                  VIRTIO_RING_F_EVENT_IDX, ON_OFF_AUTO_A=
UTO), \
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("notify_on_empty", _state, _field, \
> +                                  VIRTIO_F_NOTIFY_ON_EMPTY, ON_OFF_AUTO_=
AUTO), \
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("any_layout", _state, _field, \
> +                                  VIRTIO_F_ANY_LAYOUT, ON_OFF_AUTO_AUTO)=
, \
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("iommu_platform", _state, _field, \
> +                                  VIRTIO_F_IOMMU_PLATFORM, ON_OFF_AUTO_O=
FF), \
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("packed", _state, _field, \
> +                                  VIRTIO_F_RING_PACKED, ON_OFF_AUTO_OFF)=
, \
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("queue_reset", _state, _field, \
> +                                  VIRTIO_F_RING_RESET, ON_OFF_AUTO_AUTO)=
, \
> +    DEFINE_PROP_ON_OFF_AUTO_BIT64("in_order", _state, _field, \
> +                                  VIRTIO_F_IN_ORDER, ON_OFF_AUTO_OFF)
>
>  hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
>  bool virtio_queue_enabled_legacy(VirtIODevice *vdev, int n);
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index c949af97668d..bff26b95dd74 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -36,7 +36,9 @@
>  #include "hw/virtio/virtio-iommu.h"
>  #include "audio/audio.h"
>
> -GlobalProperty hw_compat_9_2[] =3D {};
> +GlobalProperty hw_compat_9_2[] =3D {
> +    { TYPE_VIRTIO_DEVICE, "x-force-features-auto", "on" },
> +};
>  const size_t hw_compat_9_2_len =3D G_N_ELEMENTS(hw_compat_9_2);
>
>  GlobalProperty hw_compat_9_1[] =3D {
> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
> index 896feb37a1ca..75d433b252d5 100644
> --- a/hw/virtio/virtio-bus.c
> +++ b/hw/virtio/virtio-bus.c
> @@ -50,6 +50,7 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Erro=
r **errp)
>      bool has_iommu =3D virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLAT=
FORM);
>      bool vdev_has_iommu;
>      Error *local_err =3D NULL;
> +    uint64_t features;
>
>      DPRINTF("%s: plug device.\n", qbus->name);
>
> @@ -63,13 +64,22 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Er=
ror **errp)
>
>      /* Get the features of the plugged device. */
>      assert(vdc->get_features !=3D NULL);
> -    vdev->host_features =3D vdc->get_features(vdev, vdev->host_features,
> -                                            &local_err);
> +    features =3D vdev->host_features | vdev->requested_features.auto_bit=
s |
> +               vdev->requested_features.on_bits;
> +    features =3D vdc->get_features(vdev, features, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
>      }
>
> +    if (!vdev->force_features_auto &&
> +        (features & vdev->requested_features.on_bits) !=3D vdev->request=
ed_features.on_bits) {
> +        error_setg(errp, "A requested feature is not supported by the de=
vice");
> +        return;
> +    }
> +
> +    vdev->host_features =3D features;
> +
>      if (klass->device_plugged !=3D NULL) {
>          klass->device_plugged(qbus->parent, &local_err);
>      }
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 85110bce3744..83f803fc703d 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -4013,11 +4013,13 @@ static void virtio_device_instance_finalize(Objec=
t *obj)
>  }
>
>  static const Property virtio_properties[] =3D {
> -    DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, host_features),
> +    DEFINE_VIRTIO_COMMON_FEATURES(VirtIODevice, requested_features),
>      DEFINE_PROP_BOOL("use-started", VirtIODevice, use_started, true),
>      DEFINE_PROP_BOOL("use-disabled-flag", VirtIODevice, use_disabled_fla=
g, true),
>      DEFINE_PROP_BOOL("x-disable-legacy-check", VirtIODevice,
>                       disable_legacy_check, false),
> +    DEFINE_PROP_BOOL("x-force-features-auto", VirtIODevice,
> +                     force_features_auto, false),
>  };
>
>  static int virtio_device_start_ioeventfd_impl(VirtIODevice *vdev)
>
> --
> 2.47.1
>


