Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553B6C531D0
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 17:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wng1A-0005OV-Mc; Sat, 25 Jul 2026 13:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wng17-0005OA-92
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 13:18:29 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wng15-0001vp-7v
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 13:18:28 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2cedda2ce6fso12314285ad.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 10:18:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784999906; cv=none;
 d=google.com; s=arc-20260327;
 b=CR7/LxYQH44gpL4xsXWFcgNJdv+AJHaCnX2wDGaYf358KcyyL53WAEzEY4NRepF+h1
 m/KnK7na5wyEr1XUf7IK33TGaT6RnkR871wkwI0A1lrSm3s4drpg7EFPk3YUDZ2t9LY3
 OCBdLmXTjdPmFI9ZgNldau9h/JtFj5Y+G4vT7ZUaAA3S9qNie+1rGQdeKC6p69zn03x7
 xI0LsnhHVq7sRaCLIe3+B9x+BviS2K1fH4CwZH7TcY8WWvmrJhNCq/hGsuoPVX0b9CFe
 jjlx1Opsm8DAs9o3YN4V3kEDlAzZ/+DvE/oH61ML/oiSv+xmAijZ+wburhBT8Gjmogt8
 Xlyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qMCVj187Lp7SNs9TkitO9UnQkLLIX6iObbec67t5aYs=;
 fh=X9A6eY/ija5Ujfbh81uH1b2L+MC6vvRonNCW8EmVA0k=;
 b=GObO2wAkEI6lNHdQyENyjvjn5iJgCY9qae34LXlGKFKutCfdfSl1930ENgPauDBBPu
 jy2R4K7LRaSThcYHF5WCKO+J+Am4ME4yzlV4kJAa60991Oi9sEPDLYIpBpgiot+e+So0
 DczCaL2oJNdAiK+v5XbUjBe+XFISJrIOkY0MJAWSnnRLdcVV6KcEPtGfJ22r9GIM5Jfp
 NuSxQB6NMLogQdYd5MoNPsvc5pRtaZqpIuTeVIbbEF7r0qq7T9EUKhx3MjPwhXn9CHWJ
 95hmeMHGccClwu1YG0dZx298AW9zdI0Jsgp8b1iPJR0sOo9gqr90fxMWsf0j0M7W7/0D
 nZgw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784999906; x=1785604706; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qMCVj187Lp7SNs9TkitO9UnQkLLIX6iObbec67t5aYs=;
 b=PsgCyc+ZuzwRCidq6eR+DnadPHa2SqDoMGv2k1mJy+eewaZ4hc4kVOcOR58+3FaNHE
 v3caBfdwcBq3XkPNrpINtUOMx0n2fXchmlcOPooFIbrsw79DHCGteZGZMwNv9XhIePjl
 7DH7tWejAuwg77lkjqmFfSkcAkLe2psim3hNR3ZrZvOJD4e4q3TFpCYm9z8vcN2b2sL7
 uD1DGJ/21mmUGddMMxTDvNexGaNSHEQsOxJOyCJNLzWQupUWT0ctj8DmpydYsbhLI425
 HTpqFu+zKwappDUwb2pzAqyDTNWVMuUMgqmkhuhBgMF5HAd+9BQi+kYVxl5PkP0IE3t1
 cadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784999906; x=1785604706;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qMCVj187Lp7SNs9TkitO9UnQkLLIX6iObbec67t5aYs=;
 b=VfD5I34nFDMMFz14mJ0/gzpJLipmuBD5kCz40RYLNdE3FuFZDv4tZYu+j947cVRrNH
 4dZHQST9P1tCpqFDt9su0dw1r37bJLdps7anX8xj+3h3GEdmCEU2DxQca7dG6Blfdm9C
 dD4KKIiq6FSe0HxCG/+8W/9YYFTJuZ7iX6ECqysjZAekNMzLBfD9AaYmo+LnrBdsXyGp
 Kzy70McR7mNsBiGBfDnaEKW1aSWjojpiNWntibBLJW8/cNe7+3lzW9YPh3O76O3ahn6W
 +ANR3wX3f+DusPS2KEKK2Z/08ctcZQhHn1oZ2obV7zb+bA3AhMw2ychl6U1FXKYCnigG
 Fs8Q==
X-Gm-Message-State: AOJu0Yx3onxsFa9y8NRDex42XEeD1zQ/kde6QKa/zxdpcJZRpDIVe94h
 Gg2Qf3HghhjKm3j9p+pGhduEo95yrdLa53S66wrzLDHzQ4F2PUWFF4aWpD7sP4BMwkXEBcZdFEs
 K+mVttSxzliP3KxMvKIxz0vUwHJyWuUk=
X-Gm-Gg: AR+sD12HA5I4T5+TihZZQ0yHHgzwynqFOPvqXf9qgTRisr5D0/EkvpgKAqDwm8/NLaZ
 xY7Tkoya86gfDVi24+ydIJU7zvW+dy1EMQp8uWVb9Oz9LisrCuQcUmiz04doldTQzJ2+ivl5OFc
 usnjrTwx89hzlH0JnZqv0R1KjxT5dfhyoOpJHjpiPosEDuYwV5K0EhOnZOK98x0RHMTopftkDf9
 4hV8BDWs3R/Qxf0SI/kFX47Di5QU/emoR883GJLlPHC5mnEdPmQNBDQfdBXL0ofMk9Z5shPMT3O
 ZUZFmUqiBoDMPiR4Sg==
X-Received: by 2002:a05:6a21:310e:b0:3bf:83f3:b810 with SMTP id
 adf61e73a8af0-3c67da8d608mr2714366637.29.1784999905508; Sat, 25 Jul 2026
 10:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260710134720.2317856-1-marcandre.lureau@redhat.com>
 <20260725114028-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260725114028-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Jul 2026 21:18:13 +0400
X-Gm-Features: AUfX_mxrgU14Tt_PaKPAR8YFuOQcydp7SsOolL2A6F_-dis6HQKJ40nzJjjlcW4
Message-ID: <CAJ+F1C+aozL0FBehhKQ-e3tMr3JBDR4DoiC4GLahRtHou0VUWQ@mail.gmail.com>
Subject: Re: [PATCH] vhost-user-gpu: fix integer overflow in buffer allocation
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Sat, Jul 25, 2026 at 7:46=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Jul 10, 2026 at 05:47:19PM +0400, marcandre.lureau@redhat.com wro=
te:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > A malicious guest can trigger a heap buffer overflow in the
> > vhost-user-gpu backend by sending a VIRTIO_GPU_CMD_RESOURCE_CREATE_2D
> > with large width and height values (e.g. 65537x65537). The allocation
> > size width * height * 4 silently wraps in uint32_t arithmetic,
> > resulting in a much smaller allocation than expected. Subsequent
> > VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D writes past the heap buffer.
> >
> > The in-tree virtio-gpu device (hw/display/virtio-gpu.c) already handles
> > this via calc_image_hostmem() with uint64_t arithmetic and an overflow
> > check. Apply the same approach to the vhost-user-gpu contrib backend:
> >
> > - Add an overflow check in vugbm_buffer_create() rejecting dimensions
> >   where width * height * 4 exceeds UINT32_MAX
> > - Promote the size arithmetic to uint64_t in mem_alloc_bo() and
> >   udmabuf_get_size()
> > - Check the return value of vugbm_buffer_create() in
> >   vg_resource_create_2d(), which was previously ignored
> >
> > Fixes: CVE-2026-15264
> > Reported-by: "Vulnerability Report" <vr@darknavy.com>
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3940
> > Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> > ---
> >  contrib/vhost-user-gpu/vhost-user-gpu.c |  8 +++++++-
> >  contrib/vhost-user-gpu/vugbm.c          | 11 +++++++++--
> >  2 files changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/contrib/vhost-user-gpu/vhost-user-gpu.c b/contrib/vhost-us=
er-gpu/vhost-user-gpu.c
> > index bb41758e345..ee9858c397c 100644
> > --- a/contrib/vhost-user-gpu/vhost-user-gpu.c
> > +++ b/contrib/vhost-user-gpu/vhost-user-gpu.c
> > @@ -388,7 +388,13 @@ vg_resource_create_2d(VuGpu *g,
> >          cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> >          return;
> >      }
> > -    vugbm_buffer_create(&res->buffer, &g->gdev, c2d.width, c2d.height)=
;
> > +    if (!vugbm_buffer_create(&res->buffer, &g->gdev, c2d.width, c2d.he=
ight)) {
> > +        g_critical("%s: buffer creation failed %d %d %d",
> > +                   __func__, c2d.resource_id, c2d.width, c2d.height);
> > +        g_free(res);
> > +        cmd->error =3D VIRTIO_GPU_RESP_ERR_OUT_OF_MEMORY;
> > +        return;
> > +    }
> >      res->image =3D pixman_image_create_bits(pformat,
> >                                            c2d.width,
> >                                            c2d.height,
> > diff --git a/contrib/vhost-user-gpu/vugbm.c b/contrib/vhost-user-gpu/vu=
gbm.c
> > index 503d0a4566f..710d5452977 100644
> > --- a/contrib/vhost-user-gpu/vugbm.c
> > +++ b/contrib/vhost-user-gpu/vugbm.c
> > @@ -13,7 +13,7 @@
> >  static bool
> >  mem_alloc_bo(struct vugbm_buffer *buf)
> >  {
> > -    buf->mmap =3D g_malloc(buf->width * buf->height * 4);
> > +    buf->mmap =3D g_malloc((uint64_t)buf->width * buf->height * 4);
> >      buf->stride =3D buf->width * 4;
> >      return true;
> >  }
>
>
> I apologise but we are still allocating up to 2Gbytes is that really
> sane? Isn't there a limit on these things? Like the size of the screen?
>
> And width * 4 can still wrap around and then will it really behave
> correctly?
>

By default, builtin-in virtio-gpu has a cumulative max hostmem=3D256mb
(https://www.qemu.org/docs/master/system/devices/virtio/virtio-gpu.html#vir=
tio-gpu-virglrenderer).
For 3d/gpu resources this may be considered very low in today's
usages.

Vulkan 1.4+ requires 8192 in dimensions and has
VK_FORMAT_R64G64B64A64_SFLOAT =3D 256bpp
https://docs.vulkan.org/refpages/latest/refpages/source/Required_Limits.htm=
l#limits-required

So pretty much vulkan 1.4+ requires that a graphics card "accepts" 4Gb
allocations.

I don't think the virtio-gpu spec should impose a maximum limit.

The qemu vhost-user-gpu implementation could benefit from having a
hostmem tracking, similar to the built-in device.

>
> > @@ -53,7 +53,8 @@ struct udmabuf_create {
> >  static size_t
> >  udmabuf_get_size(struct vugbm_buffer *buf)
> >  {
> > -    return ROUND_UP(buf->width * buf->height * 4, qemu_real_host_page_=
size());
> > +    return ROUND_UP((uint64_t)buf->width * buf->height * 4,
> > +                    qemu_real_host_page_size());
> >  }
> >
> >  static bool
> > @@ -293,6 +294,12 @@ bool
> >  vugbm_buffer_create(struct vugbm_buffer *buffer, struct vugbm_device *=
dev,
> >                      uint32_t width, uint32_t height)
> >  {
> > +    uint64_t size =3D (uint64_t)width * height * 4;
> > +    if (size > UINT32_MAX) {
> > +        g_warning("buffer dimensions too large: %ux%u", width, height)=
;
> > +        return false;
> > +    }
> > +
> >      buffer->dev =3D dev;
> >      buffer->width =3D width;
> >      buffer->height =3D height;
> > --
> > 2.55.0
>
>

