Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8838D2ECF5
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 23:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhz0H-0006Fw-Ml; Mon, 19 Jan 2026 18:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vhz0D-0006CD-GX
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 18:49:45 -0500
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1vhz0A-0005L0-Uk
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 18:49:45 -0500
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-65f66d72b3fso3394262eaf.3
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 15:49:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768866581; cv=none;
 d=google.com; s=arc-20240605;
 b=fYISpZQSuAlbr1XNltl9qXDaxudsn/X2xc9YIhpToDfyeXsOeKhAXIz5Fn23X8lTHs
 QFq0SdpgifyZZMVG/nQXlMbUAZeaTDGQOOYk5OcBnEqwaK3TugnQ+xTztuJA1wB6GzLT
 SKc871diFrc6o+vQvFjNBpnpfbP28w6tFJP9phk97ioc20l52vFdIPRhPI2CmqdNAzf4
 ypntxqsyv4VWhqJ8zVuGO1lHjmBFaJysF3DIT6hkDxibm2tE+CXLerHSPSxl9LIABclw
 rw1Cu6wl5XAj/lb9ca6Gn0BFS6vS7/P0tknYozAFJZJoxcbmMgJUcGxnqVwnn9ikHktX
 TLHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tvxlVcD8+4DFY4fVHXFvGn5sZjAGg6EQx9MJ/2mW8vA=;
 fh=CnpQ9w8dxxV0qThAonv4kzh72pl/i26JCorwSyvmGks=;
 b=RVBw3Per9D7aRLRxhxtvpNDPolNK5CJHd+BIzFmqojUQqKhjpRX6+DnBlNsIWP7OV7
 daDc1y3JONXbrhbRA029ZmZbh/iPegbWVwMLlxSPvpsoJTvexSJvw/v2nB6wiVowSG4h
 PmC6JwrSjVnIS0OsAYbZKw7l1XDcTjFCRn1ocB8mRwU2qwTYk/WGPDecACC6AqkHcKZH
 E3ujeQTZisZe7lwEHZmPN1fxeGx3cWhAN+GPmMc2/CiD8L1gGL+S2uwiTo9a+tsUmKUg
 CkSPIY9lG9o90NUJH5FqOebAyrwykm6LkQM3IU3wFYZiAyYfuTDkAAMZN18PeTKMtLI+
 txrA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768866581; x=1769471381; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tvxlVcD8+4DFY4fVHXFvGn5sZjAGg6EQx9MJ/2mW8vA=;
 b=SqJrBS8Mf/7bzGSBleiXl/CiukSCLHpVRibD25b9jUeDjH9SrU/BoFVmOOsFW+Olrl
 MToK95ci4QLKOoUDvXaG8AL3rewV9GPI2y5CWjgOHtmeStbVs7sbh1FX55OPYqf/J8+p
 eXi3u5WNrXslybYgRzh31wkwA97MtQQ5DElfrWd/HmnThPP6eiF74LGBwm8v6JqNiXi2
 1jfS99bSRS7h8J4t1NSFv2SfrjR5MSKM+Ghmix9GgalpwekFGxz2wMpW6rwD/1S0mKYK
 +X6MU37ERl4FOQjOC1P5vOU5NW6PdWngEirNtmFcWeAzFG1GoAyzlJVkWdExNPD5H6dD
 2MYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768866581; x=1769471381;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tvxlVcD8+4DFY4fVHXFvGn5sZjAGg6EQx9MJ/2mW8vA=;
 b=muN+dayGF2sGOG2OvvTqBbL5vq9mCyB9/pLU+U0PIqpi4pWeqZ9E4kAAL7bqIM1U0V
 y8tNsm5Fku75WVyCp3C8biUMRdBr7inIb5l98Wr/FawsAfis8FSzFiCxGpas4+un94mp
 R6F060KybrMSySjpBwAhqyORQDZtK23zXOrtwchYuazwLPuGgyUTn6NSoEW+QaOyEwj8
 lCapuewQA0KZU8CEwnOWeINuMMWWsdfpwtBw+V2s82bgLq81h3e+0VINiWValWTuIEOp
 L7fmNvCmjfNAdtIlbJ46rSUkImqz9wiCovSBOCnHUz9DytRbP0V4Yz6F9bCac3g9UQMr
 c6pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLfUozyvhXCJoKKXw3k03inCwr5SJ1rpxlgnEcPNvleun5DmtpAFaGV4s78IJEMHtmKcb21a3zHUnF@nongnu.org
X-Gm-Message-State: AOJu0Yzl0PEWp5tiRsFj8xi8ju+/NDf0gBFKycDho650Re5ayuQ2ygpb
 XM8mq1o+p5wKrc0rkGzEEAQXy/CVu2V6kre0VpQ+KtgS5iGV1g1UMU0iQo2yMv5+hcrFv1JqsFr
 Uixv1y9jwVouD+NMgpAgG73Igc2b6SOg=
X-Gm-Gg: AY/fxX4oSQnn6ODMJJMQ3JjJd890VRdSl5NZJSuOFej/mg0h9yT4I9ZGpgfV+bAeuxL
 p4zy8rLFh6THgn0DhCo6f6IDj0xU71UA/UNZIXkgkKuXJPuA6k1JRuKa3uvIc5RiEG7TJldFbA0
 mtghdbNjh4K/TPT44TPQlxn3AlPl20utZjpyP+YqXiCpm2ZpChGyeGCm9ZNe/bA4ooExnRcjrKz
 a9MCNPp0xppcbZbU/Eo12hFF8jrPKkhK7JEBg7ubLF0uw/1Zi3mI+gRt4HxlcDs85ZEXyfk5BFc
 XIHMZlh/bjVIJ66RyaSpxsxhwxM=
X-Received: by 2002:a05:6820:c93:b0:65c:fb6e:7341 with SMTP id
 006d021491bc7-662b00a54e9mr30323eaf.48.1768866580969; Mon, 19 Jan 2026
 15:49:40 -0800 (PST)
MIME-Version: 1.0
References: <20260119185228.203296-1-vsementsov@yandex-team.ru>
 <20260119185228.203296-12-vsementsov@yandex-team.ru>
In-Reply-To: <20260119185228.203296-12-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 19 Jan 2026 18:49:30 -0500
X-Gm-Features: AZwV_Qgc3mKFwJPSMvoWPB5HpSgYhtAsojAUTUmwLYjf11vBh5fIZg6doUJNi1A
Message-ID: <CAFubqFteXcVA-MP+Wkmvze-5GQbaWxurJTfdrOe4LQmO143Y4w@mail.gmail.com>
Subject: Re: [PATCH v4 11/23] vhost: vhost_virtqueue_start(): fix failure path
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net, 
 qemu-devel@nongnu.org, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-oo1-xc2c.google.com
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

Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>

On Mon, Jan 19, 2026 at 1:55=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> We miss call to unmap in cases when vhost_memory_map() returns
> lenght less than requested (still we consider such cases as an
> error). Let's fix it in vhost_memory_map().
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 40440c6d68..1ef9b3ed6c 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -454,11 +454,20 @@ static inline void vhost_dev_log_resize(struct vhos=
t_dev *dev, uint64_t size)
>  }
>
>  static void *vhost_memory_map(struct vhost_dev *dev, hwaddr addr,
> -                              hwaddr *plen, bool is_write)
> +                              hwaddr len, bool is_write)
>  {
>      if (!vhost_dev_has_iommu(dev)) {
> -        return address_space_map(dev->vdev->dma_as, addr, plen, is_write=
,
> -                                 MEMTXATTRS_UNSPECIFIED);
> +        hwaddr mapped_len =3D len;
> +        void *res =3D address_space_map(dev->vdev->dma_as, addr, &mapped=
_len,
> +                                      is_write, MEMTXATTRS_UNSPECIFIED);
> +        if (!res) {
> +            return NULL;
> +        }
> +        if (len !=3D mapped_len) {
> +            address_space_unmap(dev->vdev->dma_as, res, mapped_len, 0, 0=
);
> +            return NULL;
> +        }
> +        return res;
>      } else {
>          return (void *)(uintptr_t)addr;
>      }
> @@ -1312,22 +1321,22 @@ int vhost_virtqueue_start(struct vhost_dev *dev,
>      }
>
>      l =3D vq->desc_size;
> -    vq->desc =3D vhost_memory_map(dev, vq->desc_phys, &l, false);
> -    if (!vq->desc || l !=3D vq->desc_size) {
> +    vq->desc =3D vhost_memory_map(dev, vq->desc_phys, l, false);
> +    if (!vq->desc) {
>          r =3D -ENOMEM;
>          goto fail_alloc_desc;
>      }
>
>      l =3D vq->avail_size;
> -    vq->avail =3D vhost_memory_map(dev, vq->avail_phys, &l, false);
> -    if (!vq->avail || l !=3D vq->avail_size) {
> +    vq->avail =3D vhost_memory_map(dev, vq->avail_phys, l, false);
> +    if (!vq->avail) {
>          r =3D -ENOMEM;
>          goto fail_alloc_avail;
>      }
>
>      l =3D vq->used_size;
> -    vq->used =3D vhost_memory_map(dev, vq->used_phys, &l, true);
> -    if (!vq->used || l !=3D vq->used_size) {
> +    vq->used =3D vhost_memory_map(dev, vq->used_phys, l, true);
> +    if (!vq->used) {
>          r =3D -ENOMEM;
>          goto fail_alloc_used;
>      }
> --
> 2.52.0
>
>

