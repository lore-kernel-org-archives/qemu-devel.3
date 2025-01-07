Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694BFE77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 05:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV2Wi-0000l2-Q5; Tue, 07 Jan 2025 00:53:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tV2Wg-0000kq-Mc
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 00:53:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1tV2Wd-0005Gj-6j
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 00:53:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736229189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eCSoK2vEw/HxLT4joUmOFNx4HRFOqRIZI8sIWv9VT1c=;
 b=h51yAc/mBxnbH4tYVh4tnIiR+yyYHzWr7sy0qDM4iPX7yDuw+Kyf6clm81VqJ1CUsmY2z/
 DjUBabcZJ5D2+slk80SJ4zJb7UeXg4uyZUyrZr3S95y+oKzP0xxI/q7E2lwOdltvWx3bg0
 JcKtzwbuUfYtKQw1V4XizHYi4oQDG2g=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-B6hUBT9AMaOQwWVin5OmcA-1; Tue, 07 Jan 2025 00:53:06 -0500
X-MC-Unique: B6hUBT9AMaOQwWVin5OmcA-1
X-Mimecast-MFC-AGG-ID: B6hUBT9AMaOQwWVin5OmcA
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5d89a53fc46so1836518a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 21:53:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736229185; x=1736833985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eCSoK2vEw/HxLT4joUmOFNx4HRFOqRIZI8sIWv9VT1c=;
 b=MbwWyYALVgx6e7+A8fTk8micEvEGXNOkPuBlHoXrm3WjLuQoWIHBLLLNq6BhdlXZIS
 0BuzM7+jUVqNiW6Tc1yrSmA3uNsJwkBrgyAtkUhtuaZfaXCyFpN0idtfvSMcaPaV/bNA
 YkF651qFoW6d+uI/PYSGfkkEInKkaUD1LDecLMGaCXvWgw2OIduuF5196NHXEDUEFJc6
 pAbZsTG5eHmS9wPiT58k3Go0e5NcS+HaSgXQ3PiX7vcrs4Xykj6aQeS1B3isZF8fBvNh
 y0QP+SlyE72+onYHczPcdKkDOOoWu1q0XRzvMfJ//jESri1SvZD1wFeJ2S9qUFxC/QLS
 OirA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTJPb42OqhQGVAObHTjZa1RFG1EN3dUmHjS9QubaaKD65BIvzMh/pBN58WALxoi0KbtFqJk5Fxgq9D@nongnu.org
X-Gm-Message-State: AOJu0YwdsS/UWscROBBmu18ky7gn41xuz3eHNJBxy8pei7wk9WPHiAQG
 sjdrUD3/6rsI3czhjf4WZcSqXSCl/LdQVYbFN3vQCbJrmPAs9RMT3ezbIJYaT0hleptQYXvJFfm
 c+TVdfnaYpRisqd8cg3jWgRBE6/iBQlMykAwcGcgHxRHProyGCOsPLhtTqqw3Al+6B3DIpi0XSJ
 Hj8VySSqXSci6cqTgNN8jALrA+0Ac=
X-Gm-Gg: ASbGnct3/PqzHj9+QYdlwPHZDGmOL6JfDxQ+xFtC4fkLs/t37VlZMFp+yc9bSrXGzUE
 xcGAyrsRmTouxnBq19O9SyaFtofIoRv6VW5+vx1c=
X-Received: by 2002:a17:907:9724:b0:aa6:9624:78f1 with SMTP id
 a640c23a62f3a-aac28c14948mr4988052266b.9.1736229185457; 
 Mon, 06 Jan 2025 21:53:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFASpKOkCQX3qsIK0Ta99ZfuWKYG94WdnDOUoSb3pFysl3G8nO0P0EA7ECoOs7xqvHZ8wUcTdWgXBcCwP2Gcwc=
X-Received: by 2002:a17:907:9724:b0:aa6:9624:78f1 with SMTP id
 a640c23a62f3a-aac28c14948mr4988051266b.9.1736229185028; Mon, 06 Jan 2025
 21:53:05 -0800 (PST)
MIME-Version: 1.0
References: <20250104-virtio-v3-0-63ef70e9ddf3@daynix.com>
 <20250104-virtio-v3-3-63ef70e9ddf3@daynix.com>
In-Reply-To: <20250104-virtio-v3-3-63ef70e9ddf3@daynix.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 7 Jan 2025 13:52:27 +0800
X-Gm-Features: AbW1kvaY77Vv0f46rpWD4iNDp1PEAySAcjDi9zu-qGpun2KAnMvOdCyvUClYwGs
Message-ID: <CAPpAL=yTtuO-0oRHmae7WdnwWdmekbmJdPi0D=RA8KBzCHqttg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] virtio: Convert feature properties to OnOffAuto
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
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Content-Type: multipart/mixed; boundary="000000000000d34c87062b175b28"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

--000000000000d34c87062b175b28
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Akihiko

I hit qemu core dump when I tested this series of patches with
virtio-net regression tests, and based on the test result this bug can
be reproduced by just booting a guest. For the details of core dump
info please review the attachment.

Regards

Lei

On Sat, Jan 4, 2025 at 3:37=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
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
>

--000000000000d34c87062b175b28
Content-Type: application/octet-stream; name=coredump
Content-Disposition: attachment; filename=coredump
Content-Transfer-Encoding: base64
Content-ID: <f_m5lwsrvn0>
X-Attachment-Id: f_m5lwsrvn0

KGdkYikgYnQgZnVsbAojMCAgMHgwMDAwN2YxYjUwODJjN2FjIGluIF9fcHRocmVhZF9raWxsX2lt
cGxlbWVudGF0aW9uICgpIGF0IC9saWI2NC9saWJjLnNvLjYKIzEgIDB4MDAwMDdmMWI1MDdkNmEz
NiBpbiByYWlzZSAoKSBhdCAvbGliNjQvbGliYy5zby42CiMyICAweDAwMDA3ZjFiNTA3YmU4ZmEg
aW4gYWJvcnQgKCkgYXQgL2xpYjY0L2xpYmMuc28uNgojMyAgMHgwMDAwN2YxYjUwN2JlODFlIGlu
IF9fYXNzZXJ0X2ZhaWxfYmFzZS5jb2xkICgpIGF0IC9saWI2NC9saWJjLnNvLjYKIzQgIDB4MDAw
MDdmMWI1MDdjZWY3NiBpbiBfX2Fzc2VydF9mYWlsICgpIGF0IC9saWI2NC9saWJjLnNvLjYKIzUg
IDB4MDAwMDU1YTY0OGViNWI0MiBpbiBxb2JqZWN0X2lucHV0X3RyeV9nZXRfb2JqZWN0IChxaXY9
MHg1NWE2NTlmNWUwNTAsIG5hbWU9MHg1NWE2NTlmNWRmOTAgIndyaXRlLWNhY2hlIiwgY29uc3Vt
ZT10cnVlKSBhdCAuLi9xYXBpL3FvYmplY3QtaW5wdXQtdmlzaXRvci5jOjE0MwogICAgICAgIHJl
bW92ZWQgPSBmYWxzZQogICAgICAgIHRvcyA9IDB4NTVhNjU5ZjVlMTUwCiAgICAgICAgcW9iaiA9
IDB4NTVhNjU5ZjVjZWYwCiAgICAgICAgcmV0ID0gMHg1NWE2NTg4ZDQ5MjAKICAgICAgICBfX1BS
RVRUWV9GVU5DVElPTl9fID0gInFvYmplY3RfaW5wdXRfdHJ5X2dldF9vYmplY3QiCiM2ICAweDAw
MDA1NWE2NDhlYjVjNDggaW4gcW9iamVjdF9pbnB1dF9nZXRfb2JqZWN0IChxaXY9MHg1NWE2NTlm
NWUwNTAsIG5hbWU9MHg1NWE2NTlmNWRmOTAgIndyaXRlLWNhY2hlIiwgY29uc3VtZT10cnVlLCBl
cnJwPTB4N2ZmZTljMzkyMjMwKSBhdCAuLi9xYXBpL3FvYmplY3QtaW5wdXQtdmlzaXRvci5jOjE2
OAogICAgICAgIG9iaiA9IDB4NTVhNjU5ZjVlMDUwCiAgICAgICAgX19mdW5jX18gPSAicW9iamVj
dF9pbnB1dF9nZXRfb2JqZWN0IgojNyAgMHgwMDAwNTVhNjQ4ZWI2ZTA5IGluIHFvYmplY3RfaW5w
dXRfdHlwZV9zdHIgKHY9MHg1NWE2NTlmNWUwNTAsIG5hbWU9MHg1NWE2NTlmNWRmOTAgIndyaXRl
LWNhY2hlIiwgb2JqPTB4N2ZmZTljMzkxZjM4LCBlcnJwPTB4N2ZmZTljMzkyMjMwKSBhdCAuLi9x
YXBpL3FvYmplY3QtaW5wdXQtdmlzaXRvci5jOjUyOAogICAgICAgIHFpdiA9IDB4NTVhNjU5ZjVl
MDUwCiAgICAgICAgcW9iaiA9IDB4N2ZmZTljMzkxZjM4CiAgICAgICAgcXN0ciA9IDB4NTVhNjU5
ZjVkZjkwCiAgICAgICAgX19mdW5jX18gPSAicW9iamVjdF9pbnB1dF90eXBlX3N0ciIKIzggIDB4
MDAwMDU1YTY0OGViNGY3MCBpbiB2aXNpdF90eXBlX3N0ciAodj0weDU1YTY1OWY1ZTA1MCwgbmFt
ZT0weDU1YTY1OWY1ZGY5MCAid3JpdGUtY2FjaGUiLCBvYmo9MHg3ZmZlOWMzOTFmMzgsIGVycnA9
MHg3ZmZlOWMzOTIyMzApIGF0IC4uL3FhcGkvcWFwaS12aXNpdC1jb3JlLmM6MzQ5CiAgICAgICAg
b2sgPSBmYWxzZQogICAgICAgIF9fUFJFVFRZX0ZVTkNUSU9OX18gPSAidmlzaXRfdHlwZV9zdHIi
CiM5ICAweDAwMDA1NWE2NDhlYjUyYzAgaW4gaW5wdXRfdHlwZV9lbnVtICh2PTB4NTVhNjU5ZjVl
MDUwLCBuYW1lPTB4NTVhNjU5ZjVkZjkwICJ3cml0ZS1jYWNoZSIsIG9iaj0weDU1YTY1OWY1Y2Qx
NCwgbG9va3VwPTB4NTVhNjQ5ZWQwNjkwIDxPbk9mZkF1dG9fbG9va3VwPiwgZXJycD0weDdmZmU5
YzM5MjIzMCkgYXQgLi4vcWFwaS9xYXBpLXZpc2l0LWNvcmUuYzo0MDEKICAgICAgICB2YWx1ZSA9
IDAKICAgICAgICBlbnVtX3N0ciA9IDB4MAogICAgICAgIF9fZnVuY19fID0gImlucHV0X3R5cGVf
ZW51bSIKIzEwIDB4MDAwMDU1YTY0OGViNTRhOSBpbiB2aXNpdF90eXBlX2VudW0gKHY9MHg1NWE2
NTlmNWUwNTAsIG5hbWU9MHg1NWE2NTlmNWRmOTAgIndyaXRlLWNhY2hlIiwgb2JqPTB4NTVhNjU5
ZjVjZDE0LCBsb29rdXA9MHg1NWE2NDllZDA2OTAgPE9uT2ZmQXV0b19sb29rdXA+LCBlcnJwPTB4
N2ZmZTljMzkyMjMwKSBhdCAuLi9xYXBpL3FhcGktdmlzaXQtY29yZS5jOjQzMQogICAgICAgIF9f
UFJFVFRZX0ZVTkNUSU9OX18gPSAidmlzaXRfdHlwZV9lbnVtIgojMTEgMHgwMDAwNTVhNjQ4YzU1
Zjg3IGluIHFkZXZfcHJvcGluZm9fc2V0X2VudW0gKG9iaj0weDU1YTY1OWY1Y2MzMCwgdj0weDU1
YTY1OWY1ZTA1MCwgbmFtZT0weDU1YTY1OWY1ZGY5MCAid3JpdGUtY2FjaGUiLCBvcGFxdWU9MHg1
NWE2NDlmMDFmMzggPHNjc2lfaGRfcHJvcGVydGllcys1MDQ+LCBlcnJwPTB4N2ZmZTljMzkyMjMw
KSBhdCAuLi9ody9jb3JlL3FkZXYtcHJvcGVydGllcy5jOjExNQogICAgICAgIHByb3AgPSAweDU1
YTY0OWYwMWYzOCA8c2NzaV9oZF9wcm9wZXJ0aWVzKzUwND4KICAgICAgICBwdHIgPSAweDU1YTY1
OWY1Y2QxNAojMTIgMHgwMDAwNTVhNjQ4YzU2ZmU3IGluIHNldF9vbl9vZmZfYXV0byAob2JqPTB4
NTVhNjU5ZjVjYzMwLCB2PTB4NTVhNjU5ZjVlMDUwLCBuYW1lPTB4NTVhNjU5ZjVkZjkwICJ3cml0
ZS1jYWNoZSIsIG9wYXF1ZT0weDU1YTY0OWYwMWYzOCA8c2NzaV9oZF9wcm9wZXJ0aWVzKzUwND4s
IGVycnA9MHg3ZmZlOWMzOTIyMzApIGF0IC4uL2h3L2NvcmUvcWRldi1wcm9wZXJ0aWVzLmM6NTcw
CiAgICAgICAgcHJvcCA9IDB4NTVhNjQ5ZjAxZjM4IDxzY3NpX2hkX3Byb3BlcnRpZXMrNTA0Pgog
ICAgICAgIHB0ciA9IDB4NTVhNjU5ZjVjZDE0CiAgICAgICAgdmFsdWUgPSBmYWxzZQojMTMgMHgw
MDAwNTVhNjQ4YzU1ZTc3IGluIGZpZWxkX3Byb3Bfc2V0IChvYmo9MHg1NWE2NTlmNWNjMzAsIHY9
MHg1NWE2NTlmNWUwNTAsIG5hbWU9MHg1NWE2NTlmNWRmOTAgIndyaXRlLWNhY2hlIiwgb3BhcXVl
PTB4NTVhNjQ5ZjAxZjM4IDxzY3NpX2hkX3Byb3BlcnRpZXMrNTA0PiwgZXJycD0weDdmZmU5YzM5
MjIzMCkgYXQgLi4vaHcvY29yZS9xZGV2LXByb3BlcnRpZXMuYzo4NwogICAgICAgIHByb3AgPSAw
eDU1YTY0OWYwMWYzOCA8c2NzaV9oZF9wcm9wZXJ0aWVzKzUwND4KIzE0IDB4MDAwMDU1YTY0OGM2
MmYwOSBpbiBvYmplY3RfcHJvcGVydHlfc2V0IChvYmo9MHg1NWE2NTlmNWNjMzAsIG5hbWU9MHg1
NWE2NTlmNWRmOTAgIndyaXRlLWNhY2hlIiwgdj0weDU1YTY1OWY1ZTA1MCwgZXJycD0weDdmZmU5
YzM5MjIzMCkgYXQgLi4vcW9tL29iamVjdC5jOjE0NTAKICAgICAgICBfYXV0b19lcnJwX3Byb3Ag
PSB7bG9jYWxfZXJyID0gMHgwLCBlcnJwID0gMHg3ZmZlOWMzOTIyMzB9CiAgICAgICAgcHJvcCA9
IDB4NTVhNjU4OWZlMjQwCiAgICAgICAgX19mdW5jX18gPSAib2JqZWN0X3Byb3BlcnR5X3NldCIK
IzE1IDB4MDAwMDU1YTY0OGM2NmNlNyBpbiBvYmplY3Rfc2V0X3Byb3BlcnRpZXNfZnJvbV9xZGlj
dCAob2JqPTB4NTVhNjU5ZjVjYzMwLCBxZGljdD0weDU1YTY1OWY1Y2VmMCwgdj0weDU1YTY1OWY1
ZTA1MCwgZXJycD0weDdmZmU5YzM5MjIzMCkgYXQgLi4vcW9tL29iamVjdF9pbnRlcmZhY2VzLmM6
NTUKICAgICAgICBlID0gMHg1NWE2NTlmNWRmNjAKIzE2IDB4MDAwMDU1YTY0OGM2NmRlMiBpbiBv
YmplY3Rfc2V0X3Byb3BlcnRpZXNfZnJvbV9rZXl2YWwgKG9iaj0weDU1YTY1OWY1Y2MzMCwgcWRp
Y3Q9MHg1NWE2NTlmNWNlZjAsIGZyb21fanNvbj10cnVlLCBlcnJwPTB4N2ZmZTljMzkyMjMwKSBh
dCAuLi9xb20vb2JqZWN0X2ludGVyZmFjZXMuYzo3MwogICAgICAgIHYgPSAweDU1YTY1OWY1ZTA1
MAojMTcgMHgwMDAwNTVhNjQ4OTJjOTk2IGluIHFkZXZfZGV2aWNlX2FkZF9mcm9tX3FkaWN0IChv
cHRzPTB4NTVhNjU4OGQ4Y2QwLCBmcm9tX2pzb249dHJ1ZSwgZXJycD0weDdmZmU5YzM5MjIzMCkg
YXQgLi4vc3lzdGVtL3FkZXYtbW9uaXRvci5jOjcyMQogICAgICAgIF9hdXRvX2VycnBfcHJvcCA9
IHtsb2NhbF9lcnIgPSAweDAsIGVycnAgPSAweDU1YTY0YTA2NjdjMCA8ZXJyb3JfZmF0YWw+fQog
ICAgICAgIGRjID0gMHg1NWE2NTg5ZmQzNjAKICAgICAgICBkcml2ZXIgPSAweDU1YTY1ODhkODlk
MCAic2NzaS1oZCIKICAgICAgICBwYXRoID0gMHgwCi0tVHlwZSA8UkVUPiBmb3IgbW9yZSwgcSB0
byBxdWl0LCBjIHRvIGNvbnRpbnVlIHdpdGhvdXQgcGFnaW5nLS0KICAgICAgICBpZCA9IDB4NTVh
NjU5ZjI2OTEwICJpbWFnZTEiCiAgICAgICAgZGV2ID0gMHg1NWE2NTlmNWNjMzAKICAgICAgICBi
dXMgPSAweDU1YTY1OWQ4ZWEyMAogICAgICAgIHByb3BlcnRpZXMgPSAweDU1YTY1OWY1Y2VmMAog
ICAgICAgIF9fZnVuY19fID0gInFkZXZfZGV2aWNlX2FkZF9mcm9tX3FkaWN0IgojMTggMHgwMDAw
NTVhNjQ4OTJkMTgyIGluIHFtcF9kZXZpY2VfYWRkIChxZGljdD0weDU1YTY1ODhkOGNkMCwgcmV0
X2RhdGE9MHg3ZmZlOWMzOTIyYjgsIGVycnA9MHg1NWE2NGEwNjY3YzAgPGVycm9yX2ZhdGFsPikg
YXQgLi4vc3lzdGVtL3FkZXYtbW9uaXRvci5jOjg2MgogICAgICAgIGRldiA9IDB4MAojMTkgMHgw
MDAwNTVhNjQ4OTNiNzBjIGluIHFlbXVfY3JlYXRlX2NsaV9kZXZpY2VzICgpIGF0IC4uL3N5c3Rl
bS92bC5jOjI2ODUKICAgICAgICByZXRfZGF0YSA9IDB4MAogICAgICAgIG9wdCA9IDB4NTVhNjU4
OGQ3NTkwCiAgICAgICAgX19QUkVUVFlfRlVOQ1RJT05fXyA9ICJxZW11X2NyZWF0ZV9jbGlfZGV2
aWNlcyIKIzIwIDB4MDAwMDU1YTY0ODkzYjk0YiBpbiBxbXBfeF9leGl0X3ByZWNvbmZpZyAoZXJy
cD0weDU1YTY0YTA2NjdjMCA8ZXJyb3JfZmF0YWw+KSBhdCAuLi9zeXN0ZW0vdmwuYzoyNzQyCiAg
ICAgICAgX19mdW5jX18gPSAicW1wX3hfZXhpdF9wcmVjb25maWciCiMyMSAweDAwMDA1NWE2NDg5
M2U0NmIgaW4gcWVtdV9pbml0IChhcmdjPTEwMSwgYXJndj0weDdmZmU5YzM5MjYyOCkgYXQgLi4v
c3lzdGVtL3ZsLmM6Mzc3OQogICAgICAgIG9wdHMgPSAweDU1YTY1ODhkY2VkMAogICAgICAgIGlj
b3VudF9vcHRzID0gMHgwCiAgICAgICAgYWNjZWxfb3B0cyA9IDB4MAogICAgICAgIG9saXN0ID0g
MHg1NWE2NDlmM2MzZTAgPHFlbXVfYWN0aW9uX29wdHM+CiAgICAgICAgb3B0aW5kID0gMTAxCiAg
ICAgICAgb3B0YXJnID0gMHg3ZmZlOWMzOTQyOTcgIntcImlkXCI6IFwicGNpZV9leHRyYV9yb290
X3BvcnRfMFwiLCBcImRyaXZlclwiOiBcInBjaWUtcm9vdC1wb3J0XCIsIFwibXVsdGlmdW5jdGlv
blwiOiB0cnVlLCBcImJ1c1wiOiBcInBjaWUuMFwiLCBcImFkZHJcIjogXCIweDNcIiwgXCJjaGFz
c2lzXCI6IDV9IgogICAgICAgIG1hY2hpbmVfY2xhc3MgPSAweDU1YTY1ODlkZTYyMAogICAgICAg
IHVzZXJjb25maWcgPSB0cnVlCiAgICAgICAgdm1zdGF0ZV9kdW1wX2ZpbGUgPSAweDAKICAgICAg
ICBfX1BSRVRUWV9GVU5DVElPTl9fID0gInFlbXVfaW5pdCIKIzIyIDB4MDAwMDU1YTY0OGRmN2My
NiBpbiBtYWluIChhcmdjPTEwMSwgYXJndj0weDdmZmU5YzM5MjYyOCkgYXQgLi4vc3lzdGVtL21h
aW4uYzo2OAogICAgICAgIF9fZnVuY19fID0gIm1haW4iCg==
--000000000000d34c87062b175b28--


