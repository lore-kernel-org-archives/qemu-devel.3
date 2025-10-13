Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A86CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 21:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Pj7-0000Zr-6D; Mon, 13 Oct 2025 17:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v8Pj5-0000XJ-DS
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 17:05:03 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v8Pj3-00064x-Kp
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 17:05:03 -0400
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-4248b34fc8eso53060235ab.3
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 14:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760389500; x=1760994300; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qJlodgU76jHmm7eGPven/8OZLS4zcIHo/iDqEn3rpfY=;
 b=QFXnzyp+KhPte6HUSwkSEaC5IvjBb2v2sPFXK4az9MsgNoeaJ5/G40UtMyb/Hch6dm
 vV6YqIMdg/EMZi6Mhx+Q7BAGstJtLCv9dZ0Brfqp+rrPDFEpG2rD8DuenVLYg2cJov/S
 dBkCLEsyb3CM8B2roE6zkEvcaV18bU3OxjeWbd3OdwRYd3AnPEG0fhluPl53uk/V6xmT
 UeZvKGkXTRjbXHqSwlIYQLhC0y7nezdxDnzC7HHoi/b37HfEd1DTDX3sugwIdAdSEYg+
 DegqmaGT+YkRKLrrFKQvVxoNE2/bUZNl9k2YWrlz7Lvfi5y7k6AjR52JqQzcayIY5UnU
 jE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760389500; x=1760994300;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qJlodgU76jHmm7eGPven/8OZLS4zcIHo/iDqEn3rpfY=;
 b=LYpWHAKA59hmzPrj2COr2L9TXIhzaS9Dsg+Mhiui4OHCMeIR1oi7dWyBSLJU1aAYFE
 WF0dznX/6VpvBM9PfaNg/WmIEdBdnnIzmTreOpKYIFZ6qNXi8tdpyGNLEvbwrXzcbjRY
 3dh+mCdpGDeKCgRIzuv1M9yGUrBMu9/sYFIs+rmJshQqpbV9EQ/lBgpV2M4Pvk6TCTun
 H05itzAh/x4KwI4PP5p34RbjAc3C0MxHJ5cJvtRAtTHXnBI5Yr10kH0i7rBSSg+txZq0
 AXJPul2rbSzamYUANSpNTzK4sPNwjcRAdz2giGqGz9oaVEW+CB3hDLexnrf2OQaIuS8B
 a1+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1a3CgcXw8xaA21NRqTWNNVsIIaOcfsVjhJ7J0VDBYl8XoBE9BS85VNaJ1J+eyeUzx19X/dtPzYzHd@nongnu.org
X-Gm-Message-State: AOJu0Ywx3jaU6kgk5in6d2/rCfRtCAwt17KRB8jQ0rS0POfjGrzfUXm6
 JY2vYlR4QUqiMGEQUKI+bt8P+5XSK+6ynq2RBanb9LQIwVUgon+xxIOwsNpxz5Td/gd34VS3Ga3
 0EQfP7RXSo/edRYBXAZUiwGMCnDlEsgA=
X-Gm-Gg: ASbGncuib68mpo9G6bCAy2AfGSoCkrxls01VSkxOacOJj4FASOn5jShYHvqbU4fU8k8
 pQYcoXOL00sfTnZqQe+MukgIDxkLIRflCt3OF84BOMD9UzXA/Ug6Kv9Vqaw1ec/SBjoz9wvlv7I
 WowbVjpwHLjlZZWC00oG19WJCisdadD9gztO64I361xZtOO0GxCIyU68ehZtga3iHFcK/ViImgr
 dtgT8xzRGLTRrbX+NZa3k8GMw==
X-Google-Smtp-Source: AGHT+IGDPy+8wxUlS/GJ3HhPlNNHeC9rrgGxZrsP6pWyHuBtDp8c0VtcvqDJkNaleFMhZQoPPUdO0MUyS4mFOWVmu4c=
X-Received: by 2002:a05:6e02:2195:b0:42f:991e:17ea with SMTP id
 e9e14a558f8ab-42f991e1878mr164965775ab.2.1760389500297; Mon, 13 Oct 2025
 14:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20251011232404.561024-1-vsementsov@yandex-team.ru>
 <20251011232404.561024-24-vsementsov@yandex-team.ru>
In-Reply-To: <20251011232404.561024-24-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 13 Oct 2025 17:04:47 -0400
X-Gm-Features: AS18NWAzuZVGbLfDKr4TQ93gqRuP4AWOraUNYM8jEwdT-eobNauiDVbnItOsp44
Message-ID: <CAFubqFtNsh1AcPYfiHsxRpYZzw4Zkgai8BpvRBOyf_h9SUcBjQ@mail.gmail.com>
Subject: Re: [PATCH v2 23/23] vhost: add some useful trace-points
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net, 
 qemu-devel@nongnu.org, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>

On Sat, Oct 11, 2025 at 7:24=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/trace-events | 12 ++++++++++--
>  hw/virtio/vhost.c      | 20 ++++++++++++++++++--
>  2 files changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
> index aa1ffa5e94..c2529814f9 100644
> --- a/hw/virtio/trace-events
> +++ b/hw/virtio/trace-events
> @@ -9,8 +9,16 @@ vhost_section(const char *name) "%s"
>  vhost_reject_section(const char *name, int d) "%s:%d"
>  vhost_iotlb_miss(void *dev, int step) "%p step %d"
>  vhost_dev_cleanup(void *dev) "%p"
> -vhost_dev_start(void *dev, const char *name, bool vrings) "%p:%s vrings:=
%d"
> -vhost_dev_stop(void *dev, const char *name, bool vrings) "%p:%s vrings:%=
d"
> +vhost_dev_start_in(void *dev, const char *name, bool vrings) "%p:%s vrin=
gs:%d"
> +vhost_dev_start_out(void *dev, const char *name) "%p:%s"
> +vhost_dev_stop_in(void *dev, const char *name, bool vrings) "%p:%s vring=
s:%d"
> +vhost_dev_stop_out(void *dev, const char *name) "%p:%s"
> +vhost_virtque_start_in(void *dev, const char *name, int idx) "%p:%s %d"
> +vhost_virtque_start_out(void *dev, const char *name, int idx) "%p:%s %d"
> +vhost_virtque_stop_in(void *dev, const char *name, int idx) "%p:%s %d"
> +vhost_virtque_stop_out(void *dev, const char *name, int idx) "%p:%s %d"
> +vhost_dev_init_in(void *dev) "%p"
> +vhost_dev_init_out(void *dev) "%p"
>
>
>  # vhost-user.c
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index d02d1d4c34..f15ef8cff6 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1333,6 +1333,8 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>      };
>      struct VirtQueue *vvq =3D virtio_get_queue(vdev, idx);
>
> +    trace_vhost_virtque_start_in(dev, vdev->name, idx);
> +
>      r =3D vhost_vrings_map(dev, vdev, vq, idx);
>      if (r <=3D 0) {
>          return r;
> @@ -1394,6 +1396,8 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>          }
>      }
>
> +    trace_vhost_virtque_start_out(dev, vdev->name, idx);
> +
>      return 0;
>
>  fail:
> @@ -1412,6 +1416,8 @@ static int do_vhost_virtqueue_stop(struct vhost_dev=
 *dev,
>      };
>      int r =3D 0;
>
> +    trace_vhost_virtque_stop_in(dev, vdev->name, idx);
> +
>      if (virtio_queue_get_desc_addr(vdev, idx) =3D=3D 0) {
>          /* Don't stop the virtqueue which might have not been started */
>          return 0;
> @@ -1445,6 +1451,8 @@ static int do_vhost_virtqueue_stop(struct vhost_dev=
 *dev,
>      }
>
>      vhost_vrings_unmap(dev, vq, true);
> +
> +    trace_vhost_virtque_stop_out(dev, vdev->name, idx);
>      return r;
>  }
>
> @@ -1616,6 +1624,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>  {
>      int i, r, n_initialized_vqs =3D 0;
>
> +    trace_vhost_dev_init_in(hdev);
> +
>      hdev->vdev =3D NULL;
>      hdev->migration_blocker =3D NULL;
>
> @@ -1700,6 +1710,8 @@ int vhost_dev_init(struct vhost_dev *hdev, void *op=
aque,
>          goto fail;
>      }
>
> +    trace_vhost_dev_init_out(hdev);
> +
>      return 0;
>
>  fail:
> @@ -2048,7 +2060,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIOD=
evice *vdev, bool vrings)
>      /* should only be called after backend is connected */
>      assert(hdev->vhost_ops);
>
> -    trace_vhost_dev_start(hdev, vdev->name, vrings);
> +    trace_vhost_dev_start_in(hdev, vdev->name, vrings);
>
>      vdev->vhost_started =3D true;
>      hdev->started =3D true;
> @@ -2133,6 +2145,8 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIOD=
evice *vdev, bool vrings)
>          }
>      }
>      vhost_start_config_intr(hdev);
> +
> +    trace_vhost_dev_start_out(hdev, vdev->name);
>      return 0;
>  fail_iotlb:
>      if (vhost_dev_has_iommu(hdev) &&
> @@ -2182,7 +2196,7 @@ static int do_vhost_dev_stop(struct vhost_dev *hdev=
, VirtIODevice *vdev,
>      event_notifier_cleanup(
>          &hdev->vqs[VHOST_QUEUE_NUM_CONFIG_INR].masked_config_notifier);
>
> -    trace_vhost_dev_stop(hdev, vdev->name, vrings);
> +    trace_vhost_dev_stop_in(hdev, vdev->name, vrings);
>
>      if (hdev->vhost_ops->vhost_dev_start) {
>          hdev->vhost_ops->vhost_dev_start(hdev, false);
> @@ -2212,6 +2226,8 @@ static int do_vhost_dev_stop(struct vhost_dev *hdev=
, VirtIODevice *vdev,
>      hdev->started =3D false;
>      vdev->vhost_started =3D false;
>      hdev->vdev =3D NULL;
> +
> +    trace_vhost_dev_stop_out(hdev, vdev->name);
>      return rc;
>  }
>
> --
> 2.48.1
>

