Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACEFC531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 09:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnYEQ-0006Iz-49; Sat, 25 Jul 2026 04:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wnYEN-0006Ij-9s
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 04:59:39 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1wnYEL-0006RD-3b
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 04:59:39 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-69e08ad526cso1254859a12.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 01:59:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784969973; cv=none;
 d=google.com; s=arc-20260327;
 b=dSfe65f0hyyh8+30jqvmQxHZcRRon1NmQ6hWhmmQsjeeluu9THOUmxmoVVUYNLRnQf
 NQi+DgAHXjlyWD2fFpOQPgYkZPijq2BHPgnb7klbCKjnAKrL+69TEaSx5WGHbOzTbMyW
 GpaRkb27I9dwWUzMSF5BSiUTJeoUxiazV3OTj++dRTqHazagiwUKQgUQrT/8Z9Qr2V17
 V0hiTDurALCxfjD5Fu/NjGyWGgK+lH2hz3nM7m/l1P06fY4xl1ynwXS2PYN3QecH2nvm
 aYq6p1f7Na4VI794W1ScSaCt+1oc0kH402uaMV81hLuBU3y6AhwW8XMiolf8Dt8tgycv
 QA5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SaR5GTruW5pCDdvC1s8t5CXwRKSaP5OkNMKaeuIiAmI=;
 fh=mM3cwr0trVVyIJ7OtROl52jeq+dz/SSmH4xm/2yHE5w=;
 b=IFik1xwQs4m7QnNhMYv1upP2X+BGuH5SzeB9cxdVBbrHAyhBC0rGvUc6o96Zs2Qfn8
 rM023HHrO+XQMgj7fnaHmbKNgJyYWM21o6OZ0be03LyxuoSbAfXK4K6BJ0J4yqHKN9uf
 rRCJD9wdjBAy9tVdoyeTQ1OvN07MXJei25nN+OfI8zijDDMZ8Ad6zdm2XUttKJ/XqiU4
 zJ7+OWCKYuwPk7kxaJhGwYSrtn297OBh7yWr9he/MAnnnNrnPqQCcA8LgV7ZGGYSt/7X
 1SihqL3xOANxO9igjTagKdZTaZ3Ckyy74AT5o7p2nv9Z43LKl3zEu6/3W1JI85uCKpuP
 1b8w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784969973; x=1785574773; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SaR5GTruW5pCDdvC1s8t5CXwRKSaP5OkNMKaeuIiAmI=;
 b=A/i4OUN0IJOmcQslaDxuiFntMGWCiLUG0vUcFIdWff41lO675WXArjuW9jOSsmH9hn
 7X2jFzRENg3Nb19cl5j3Azvc9ouy6GrUqigme/g0ESdL0IqsjrqpUz1FsekG9KtoUsZa
 omdu55p27853aHcWJ718cPo92UoLr2ZijFc38+qnduW2ksX8i5N8YwE7OlCk6T4NtuSY
 7fLmQopH1IaFJSs/+qELPUkVRX7ZGdoQgObPIPxquobn5P3VWmgzfTdmSwoiBnWODo55
 LHh0p/AkGeXi17ai5xLLmN6WM/kckIembwzifen9CUxdB6jvYL2E+t1JXPTiA5/DMdvH
 hR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784969973; x=1785574773;
 h=content-type:cc:to:subject:message-id:date:from:reply-to
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SaR5GTruW5pCDdvC1s8t5CXwRKSaP5OkNMKaeuIiAmI=;
 b=f156Ga4NfcMn3oht3Iwj6sWk0+qSsfkBkcc2COh28usaTXPN2+KXYAX0aNPYKN/ymV
 PmpqYmHZkVy0P6kQjRWzkbmPY1/JiNN+1+70aBOCs+zoAo+CrJmuoJfvrz1lBGmaLKKn
 jS8CW4+XiBE+c1/X0T+1gF+QfEmSzj0s1Os2ul1rvfATwt4rk4TDHvxJmp0kt/Q5RZOH
 N+5WBSN6LXWbtT+tBjfBK11toaktaLmzWjjjRDjOjhLe3ExKh7vflgURZ0OLEfLmOVQx
 qT3o+qZbMGB0O1BB9cMLPbfTJaaoe2/tQqELZaEgPZzPauxfqLNLUadplFPz19a4U2/i
 MFGQ==
X-Gm-Message-State: AOJu0Yyx6HX/j8k4r/JcM+VyHyG8Fo/a7tTvlIf029XAl5BDWVpbmRNh
 mgijtgKkxDSFYbSdlX8qkJ5lWOVbotlC4EPTi8V+zCmlWr4Y0Rtakn41LgeKOsETJ3OMHzulbE1
 lUQa54VSZSDGPcQ2dbIzHFl29xw93jvc=
X-Gm-Gg: AR+sD128bU1D8wUUxNlZsRZ7WiVxoZqptQBN2OYVziEe+hPwrcjvlJsd8J6IBW+c/vL
 Ocl6Ga72Dn1rM1lUprPsNM/ESAulxTAuSoBWp40HISch0PWQAzZ7fwQmSNCxCaXa6gCOlhIQle5
 ct6RBozEnUhegWuAiFIuxmOI+GJARuoDkf5qWCJVN2F2zQiyUi8QPcgU7ZY7pNlf8/zORCeeeDk
 ny3x8yC8Lcso0PrZUOY65SYIabolBFKJYuCcsnO5rrl/5H1MaZ6R1L0KMZfKw==
X-Received: by 2002:a05:6402:2345:b0:698:663d:d7bd with SMTP id
 4fb4d7f45d1cf-69fc1106cebmr620216a12.11.1784969972983; Sat, 25 Jul 2026
 01:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <8715acbb9516e67e2a776cda6f9edf105343f788.1784930765.git.mst@redhat.com>
In-Reply-To: <8715acbb9516e67e2a776cda6f9edf105343f788.1784930765.git.mst@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sat, 25 Jul 2026 16:59:20 +0800
X-Gm-Features: AUfX_mwrRHHndWnPbBXKzOVJ-9c1AF3Q3L0w6u_vQ8Qjuwxcnkri7hjV22J24RQ
Message-ID: <CAE2XoE_XSrdqA9yjo71AMKTod0b7x8_pBdyRoYEFn8cZwmEMOw@mail.gmail.com>
Subject: Re: [PATCH] virtio-mmio: fix QUEUE_NUM_MAX
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Zhao Liu <zhao1.liu@intel.com>
Content-Type: multipart/alternative; boundary="0000000000002cacd006576bb56d"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000002cacd006576bb56d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I also faced such issue

Acked-by: Yonggang Luo <luoyonggang@gmail.com>

I Can this be in qemu 11.1?

On Sat, Jul 25, 2026 at 6:14=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> virtio-mmio reports VIRTQUEUE_MAX_SIZE (1024) as QUEUE_NUM_MAX for every
> queue, regardless of the size the device passes to virtio_add_queue().
>
> This works by accident because QEMU mostly does not care about the ring
> size - the guest is the one allocating memory here.  But this changes
> with in-order vqs where qemu is the one allocating resources.
> Now, specifying a larger vq than allocated causes an OOB memory access.
>
> To fix:
> - for new machine types, report the actual max queue size to guest
> - for old machine types, use a compat property to allocate 1k sized
>   queues
>
> Fixes: 525d82e323 ("virtio: fix queue size validation against allocated
maximum")
> Fixes: CVE-2026-50626
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3882
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/hw/virtio/virtio-bus.h  |  1 +
>  include/hw/virtio/virtio-mmio.h |  1 +
>  hw/core/machine.c               |  1 +
>  hw/virtio/virtio-mmio.c         |  7 +++----
>  hw/virtio/virtio.c              | 11 +++++++++++
>  5 files changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/include/hw/virtio/virtio-bus.h
b/include/hw/virtio/virtio-bus.h
> index 1a2d396156..f80fd71424 100644
> --- a/include/hw/virtio/virtio-bus.h
> +++ b/include/hw/virtio/virtio-bus.h
> @@ -30,6 +30,7 @@
>  #include "qom/object.h"
>
>  #define TYPE_VIRTIO_BUS "virtio-bus"
> +#define VIRTIO_QUEUE_SIZE_OVERRIDE "x-override-queue-size"
>  typedef struct VirtioBusClass VirtioBusClass;
>  typedef struct VirtioBusState VirtioBusState;
>  DECLARE_OBJ_CHECKERS(VirtioBusState, VirtioBusClass,
> diff --git a/include/hw/virtio/virtio-mmio.h
b/include/hw/virtio/virtio-mmio.h
> index 1644d09810..0a9069868c 100644
> --- a/include/hw/virtio/virtio-mmio.h
> +++ b/include/hw/virtio/virtio-mmio.h
> @@ -69,6 +69,7 @@ struct VirtIOMMIOProxy {
>      /* Fields only used for non-legacy (v2) devices */
>      uint32_t guest_features[2];
>      VirtIOMMIOQueue vqs[VIRTIO_QUEUE_MAX];
> +    uint16_t override_queue_size;
>  };
>
>  #endif
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 805148678d..73b4d82b4a 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -41,6 +41,7 @@
>  #include "hw/arm/smmuv3.h"
>
>  GlobalProperty hw_compat_11_0[] =3D {
> +    { "virtio-mmio", VIRTIO_QUEUE_SIZE_OVERRIDE, "1024" },
>      { "chardev-vc", "encoding", "cp437" },
>      { "tpm-crb", "cap-chunk", "off" },
>      { "tpm-crb", "x-allow-chunk-migration", "off" },
> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> index 58c6d46aab..55ceaeef5f 100644
> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -172,10 +172,7 @@ static uint64_t virtio_mmio_read(void *opaque,
hwaddr offset, unsigned size)
>                  >> (32 * proxy->host_features_sel);
>          }
>      case VIRTIO_MMIO_QUEUE_NUM_MAX:
> -        if (!virtio_queue_get_num(vdev, vdev->queue_sel)) {
> -            return 0;
> -        }
> -        return VIRTQUEUE_MAX_SIZE;
> +        return virtio_queue_get_max_num(vdev, vdev->queue_sel);
>      case VIRTIO_MMIO_QUEUE_PFN:
>          if (!proxy->legacy) {
>              qemu_log_mask(LOG_GUEST_ERROR,
> @@ -738,6 +735,8 @@ static const Property virtio_mmio_properties[] =3D {
>      DEFINE_PROP_BOOL("force-legacy", VirtIOMMIOProxy, legacy, true),
>      DEFINE_PROP_BIT("ioeventfd", VirtIOMMIOProxy, flags,
>                      VIRTIO_IOMMIO_FLAG_USE_IOEVENTFD_BIT, true),
> +    DEFINE_PROP_UINT16(VIRTIO_QUEUE_SIZE_OVERRIDE, VirtIOMMIOProxy,
> +                       override_queue_size, 0),
>  };
>
>  static void virtio_mmio_realizefn(DeviceState *d, Error **errp)
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 340bac2607..35f2a50ddb 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2590,6 +2590,17 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev,
int queue_size,
>      if (i =3D=3D VIRTIO_QUEUE_MAX || queue_size > VIRTQUEUE_MAX_SIZE)
>          abort();
>
> +    BusState *qbus =3D qdev_get_parent_bus(DEVICE(vdev));
> +    if (qbus && qbus->parent &&
> +        object_property_find(OBJECT(qbus->parent),
VIRTIO_QUEUE_SIZE_OVERRIDE)) {
> +        int override =3D object_property_get_int(OBJECT(qbus->parent),
> +
VIRTIO_QUEUE_SIZE_OVERRIDE,
> +                                               &error_abort);
> +        if (override) {
> +            queue_size =3D override;
> +        }
> +    }
> +
>      vdev->vq[i].vring.num =3D queue_size;
>      vdev->vq[i].vring.num_default =3D queue_size;
>      vdev->vq[i].vring.align =3D VIRTIO_PCI_VRING_ALIGN;
> --
> MST
>
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000002cacd006576bb56d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I also faced such issue=C2=A0<br><br>Acked-by: Yonggang Lu=
o &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt=
;<div><br></div><div>I Can this be in qemu 11.1?<br><br>On Sat, Jul 25, 202=
6 at 6:14=E2=80=AFAM Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.co=
m">mst@redhat.com</a>&gt; wrote:<br>&gt;<br>&gt; virtio-mmio reports VIRTQU=
EUE_MAX_SIZE (1024) as QUEUE_NUM_MAX for every<br>&gt; queue, regardless of=
 the size the device passes to virtio_add_queue().<br>&gt;<br>&gt; This wor=
ks by accident because QEMU mostly does not care about the ring<br>&gt; siz=
e - the guest is the one allocating memory here.=C2=A0 But this changes<br>=
&gt; with in-order vqs where qemu is the one allocating resources.<br>&gt; =
Now, specifying a larger vq than allocated causes an OOB memory access.<br>=
&gt;<br>&gt; To fix:<br>&gt; - for new machine types, report the actual max=
 queue size to guest<br>&gt; - for old machine types, use a compat property=
 to allocate 1k sized<br>&gt; =C2=A0 queues<br>&gt;<br>&gt; Fixes: 525d82e3=
23 (&quot;virtio: fix queue size validation against allocated maximum&quot;=
)<br>&gt; Fixes: CVE-2026-50626<br>&gt; Resolves: <a href=3D"https://gitlab=
.com/qemu-project/qemu/-/work_items/3882">https://gitlab.com/qemu-project/q=
emu/-/work_items/3882</a><br>&gt; Cc: Peter Maydell &lt;<a href=3D"mailto:p=
eter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt;<br>&gt; Signed-of=
f-by: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.c=
om</a>&gt;<br>&gt; ---<br>&gt; =C2=A0include/hw/virtio/virtio-bus.h =C2=A0|=
 =C2=A01 +<br>&gt; =C2=A0include/hw/virtio/virtio-mmio.h | =C2=A01 +<br>&gt=
; =C2=A0hw/core/machine.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
| =C2=A01 +<br>&gt; =C2=A0hw/virtio/virtio-mmio.c =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | =C2=A07 +++----<br>&gt; =C2=A0hw/virtio/virtio.c =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 11 +++++++++++<br>&gt; =C2=A05 files changed,=
 17 insertions(+), 4 deletions(-)<br>&gt;<br>&gt; diff --git a/include/hw/v=
irtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h<br>&gt; index 1a2d39615=
6..f80fd71424 100644<br>&gt; --- a/include/hw/virtio/virtio-bus.h<br>&gt; +=
++ b/include/hw/virtio/virtio-bus.h<br>&gt; @@ -30,6 +30,7 @@<br>&gt; =C2=
=A0#include &quot;qom/object.h&quot;<br>&gt;<br>&gt; =C2=A0#define TYPE_VIR=
TIO_BUS &quot;virtio-bus&quot;<br>&gt; +#define VIRTIO_QUEUE_SIZE_OVERRIDE =
&quot;x-override-queue-size&quot;<br>&gt; =C2=A0typedef struct VirtioBusCla=
ss VirtioBusClass;<br>&gt; =C2=A0typedef struct VirtioBusState VirtioBusSta=
te;<br>&gt; =C2=A0DECLARE_OBJ_CHECKERS(VirtioBusState, VirtioBusClass,<br>&=
gt; diff --git a/include/hw/virtio/virtio-mmio.h b/include/hw/virtio/virtio=
-mmio.h<br>&gt; index 1644d09810..0a9069868c 100644<br>&gt; --- a/include/h=
w/virtio/virtio-mmio.h<br>&gt; +++ b/include/hw/virtio/virtio-mmio.h<br>&gt=
; @@ -69,6 +69,7 @@ struct VirtIOMMIOProxy {<br>&gt; =C2=A0 =C2=A0 =C2=A0/*=
 Fields only used for non-legacy (v2) devices */<br>&gt; =C2=A0 =C2=A0 =C2=
=A0uint32_t guest_features[2];<br>&gt; =C2=A0 =C2=A0 =C2=A0VirtIOMMIOQueue =
vqs[VIRTIO_QUEUE_MAX];<br>&gt; + =C2=A0 =C2=A0uint16_t override_queue_size;=
<br>&gt; =C2=A0};<br>&gt;<br>&gt; =C2=A0#endif<br>&gt; diff --git a/hw/core=
/machine.c b/hw/core/machine.c<br>&gt; index 805148678d..73b4d82b4a 100644<=
br>&gt; --- a/hw/core/machine.c<br>&gt; +++ b/hw/core/machine.c<br>&gt; @@ =
-41,6 +41,7 @@<br>&gt; =C2=A0#include &quot;hw/arm/smmuv3.h&quot;<br>&gt;<b=
r>&gt; =C2=A0GlobalProperty hw_compat_11_0[] =3D {<br>&gt; + =C2=A0 =C2=A0{=
 &quot;virtio-mmio&quot;, VIRTIO_QUEUE_SIZE_OVERRIDE, &quot;1024&quot; },<b=
r>&gt; =C2=A0 =C2=A0 =C2=A0{ &quot;chardev-vc&quot;, &quot;encoding&quot;, =
&quot;cp437&quot; },<br>&gt; =C2=A0 =C2=A0 =C2=A0{ &quot;tpm-crb&quot;, &qu=
ot;cap-chunk&quot;, &quot;off&quot; },<br>&gt; =C2=A0 =C2=A0 =C2=A0{ &quot;=
tpm-crb&quot;, &quot;x-allow-chunk-migration&quot;, &quot;off&quot; },<br>&=
gt; diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c<br>&gt; =
index 58c6d46aab..55ceaeef5f 100644<br>&gt; --- a/hw/virtio/virtio-mmio.c<b=
r>&gt; +++ b/hw/virtio/virtio-mmio.c<br>&gt; @@ -172,10 +172,7 @@ static ui=
nt64_t virtio_mmio_read(void *opaque, hwaddr offset, unsigned size)<br>&gt;=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&gt;&gt; (32=
 * proxy-&gt;host_features_sel);<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
}<br>&gt; =C2=A0 =C2=A0 =C2=A0case VIRTIO_MMIO_QUEUE_NUM_MAX:<br>&gt; - =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (!virtio_queue_get_num(vdev, vdev-&gt;queue_sel)=
) {<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>&gt; - =
=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>&gt; - =C2=A0 =C2=A0 =C2=A0 =C2=A0return VI=
RTQUEUE_MAX_SIZE;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0return virtio_queue_=
get_max_num(vdev, vdev-&gt;queue_sel);<br>&gt; =C2=A0 =C2=A0 =C2=A0case VIR=
TIO_MMIO_QUEUE_PFN:<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!proxy-&g=
t;legacy) {<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_lo=
g_mask(LOG_GUEST_ERROR,<br>&gt; @@ -738,6 +735,8 @@ static const Property v=
irtio_mmio_properties[] =3D {<br>&gt; =C2=A0 =C2=A0 =C2=A0DEFINE_PROP_BOOL(=
&quot;force-legacy&quot;, VirtIOMMIOProxy, legacy, true),<br>&gt; =C2=A0 =
=C2=A0 =C2=A0DEFINE_PROP_BIT(&quot;ioeventfd&quot;, VirtIOMMIOProxy, flags,=
<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0VIRTIO_IOMMIO_FLAG_USE_IOEVENTFD_BIT, true),<br>&gt; + =C2=A0 =C2=
=A0DEFINE_PROP_UINT16(VIRTIO_QUEUE_SIZE_OVERRIDE, VirtIOMMIOProxy,<br>&gt; =
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 override_queue_size, 0),<br>&gt; =C2=A0};<br>&gt;<br>&gt; =C2=A0static =
void virtio_mmio_realizefn(DeviceState *d, Error **errp)<br>&gt; diff --git=
 a/hw/virtio/virtio.c b/hw/virtio/virtio.c<br>&gt; index 340bac2607..35f2a5=
0ddb 100644<br>&gt; --- a/hw/virtio/virtio.c<br>&gt; +++ b/hw/virtio/virtio=
.c<br>&gt; @@ -2590,6 +2590,17 @@ VirtQueue *virtio_add_queue(VirtIODevice =
*vdev, int queue_size,<br>&gt; =C2=A0 =C2=A0 =C2=A0if (i =3D=3D VIRTIO_QUEU=
E_MAX || queue_size &gt; VIRTQUEUE_MAX_SIZE)<br>&gt; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0abort();<br>&gt;<br>&gt; + =C2=A0 =C2=A0BusState *qbus =3D qde=
v_get_parent_bus(DEVICE(vdev));<br>&gt; + =C2=A0 =C2=A0if (qbus &amp;&amp; =
qbus-&gt;parent &amp;&amp;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0object_prop=
erty_find(OBJECT(qbus-&gt;parent), VIRTIO_QUEUE_SIZE_OVERRIDE)) {<br>&gt; +=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0int override =3D object_property_get_int(OBJECT=
(qbus-&gt;parent),<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VIRTIO_QUEUE_SIZE_OVERRIDE,<br>&g=
t; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &amp;error_abort);<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
f (override) {<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0queue_siz=
e =3D override;<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>&gt; + =C2=A0 =C2=
=A0}<br>&gt; +<br>&gt; =C2=A0 =C2=A0 =C2=A0vdev-&gt;vq[i].vring.num =3D que=
ue_size;<br>&gt; =C2=A0 =C2=A0 =C2=A0vdev-&gt;vq[i].vring.num_default =3D q=
ueue_size;<br>&gt; =C2=A0 =C2=A0 =C2=A0vdev-&gt;vq[i].vring.align =3D VIRTI=
O_PCI_VRING_ALIGN;<br>&gt; --<br>&gt; MST<br>&gt;<br>&gt;<br><br><br>-- <br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=
=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang L=
uo</div></div>

--0000000000002cacd006576bb56d--

