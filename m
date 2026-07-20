Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE95C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlleC-0007hD-67; Mon, 20 Jul 2026 06:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wlleA-0007gc-98
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:54:54 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wlle7-0001oX-Qo
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:54:53 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c9e607d81fcso4020097a12.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 03:54:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784544888; cv=none;
 d=google.com; s=arc-20260327;
 b=Oc9Mlq4R6p4WRIBK7hZp629jA4RpmV7W/OdbXmhrk5Gr4J0bzQcliFu0vbCfs5bVpY
 Bj5ELWWZovM73vAdUpPl6MlHTsaMZX7BzoZ3eTnTxB+KjFxNg2vud1UkmJSa/AmM84ps
 Ie/MUTK3fByPnKDtdJteErBnRZoVTN93QMvhOyXvOl2z1QJ166uNWh2a8t/Ug/zf2NM9
 7dDruBTgmFjHk8U+UDvtEPq2T33OWumEmkyT3BmI9KBkl+RSkC2WGlxuOP6jL2uRnpUz
 +Zjj2JRPJvhiOCG+vg0CqZQdU3UqvFmqOMUStmNINsngtipZCsXkb6PVf3uujxKVlfKB
 PQEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e0J3amJNzBt/bTDtoxHfGJSjcIQOYrEVeGdDY7iVmmY=;
 fh=jphA33mXjfv1kLONa36yvM3BklFNssEDmd7RBMRjU3s=;
 b=rDf7c05pFIWCX73f8NmOIG1WPdKdY2d/N/+0yRNTbg7r2X0/vREZDHJJxWUGAOv3an
 7lJKkDv9I+NWaw7kHNqbRTP1o7y5VeR4PHCHFxISd1ZUxGTRbPULUrzsBzcAR6L5KuWW
 KnS8vq6T7aGOvsgZ70Ao/BIO6Ycgbu7NV19eCCzal2/ywaXrQJQCeuhgduSGTnhu7qfj
 CztGfDEjsxoZIDmZtP0NqGlH/LnvG0l+G3MFshGGPGigTy9Ip5XMgE+MkbYYlPs+bg1A
 rUup53jACVfNFlmeFdLphJPzPgYoONIzg1iN936SAgfNOMw6LfcvzkT8b/7gYJlqpc7n
 mQNw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784544888; x=1785149688; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e0J3amJNzBt/bTDtoxHfGJSjcIQOYrEVeGdDY7iVmmY=;
 b=BRD1lBIHY8y3Wa/7ZpyGFS8HF/kVGJVzsfHW/tiQjkvRW7hcyhoCqpHXZaCSO+LuNn
 3PqWWWsZacewcmTe0pbAEcADbsQ236qyRLTVVWaPPRC/97jHFWPVLDbZcapSMA1mo0n/
 symn6GANJCEeqtY61OnZSR1eeBK2ATigyO/J7+V0HQvTLfN2YN2M5R6f4rvfaTXp4DxU
 IdgvUYkb8X7lCWcOidiCW6eSCKddH0F92K2SyQntX2ISgRW3waStlkAY8TebY2SHxTho
 YQtOY1OgsC7DVFxJ4twCWNsdbNManR8ou2u1mCmUjxm9dH1M1kIsKJktGVng3zZv/iAZ
 0OOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784544888; x=1785149688;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e0J3amJNzBt/bTDtoxHfGJSjcIQOYrEVeGdDY7iVmmY=;
 b=S2nNZ6qrwBLqiLAbtiMVXgWIpk9iTXWBfEDxHWJDCHmJIajIcR6bWtZA2cWzEekCEF
 BvtsMB0R+rarrJ8Py2ILZsNHU2UDshbDfNL5BSxRFfYo5x77H2gV6D8e0aCSKlqqMetY
 RMORSIyX+KRYRK4jn2+NBJ1UJhlTNFau0mbp92+YsT6Mv3ZwhZLqO9Mg23PazmE5qeeQ
 mrN4CXlpBd54ReeFlpfKCHBs++tNdtpxdbMtvYVx8fDgjlAo3na3rSTwLroHToZvst3+
 VmHBoEjjLzt8WpiL/xwUxBFnFMA7TNfIeSZRluVZ0VlemiB/mWIjzmGCzDEeJFlu7ESL
 jqwQ==
X-Gm-Message-State: AOJu0YyJEqW3WlP8KqMa0Uqr0GedbnQTs54j+A/icJKLiyieu41MuCDq
 CFp4RrbA7BwvTpsNWoD9wtHTh6MgkqEssHP0AkAPVLZ5D7v2J4xfHBeZYieUCNjGG74RoXlJydm
 OIoQqx0q7L+f18IwF/FfErXuwe0iI/F4=
X-Gm-Gg: AfdE7ckoPWhNfoNRWI1ACZdp1aWKsOop1jopz8JQ4Zsqha+Qi1FUeac2bdXlVVfiNwT
 ShA5dLI94y/rDsjUj/kzc5U4URFX+VXesvUBr2diLH2wG+rU4DecIejXhc9+B+N/XNMM48fyesm
 6fe1wH+vn2jUx33ap2R3BWUVsWHybQ+73OSLxCbFibFcUqMJfrnxqZ8laqvdDiaYNm8U5Z7Ho6x
 eBjZRxXM78Bc+sOstUyIpplPSmPBP0+CbFO3DN22m955d++oZmOVpA9xGuwLv2psycvxpNC3XjZ
 RPlEm+EUjwNLbwfLrbSG+V3V0tb2
X-Received: by 2002:a05:6a21:512:b0:3b5:a008:683c with SMTP id
 adf61e73a8af0-3c3ada190c4mr12370205637.45.1784544887961; Mon, 20 Jul 2026
 03:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260719-bpp-v1-1-9b91946d6cf3@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260719-bpp-v1-1-9b91946d6cf3@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 20 Jul 2026 14:54:35 +0400
X-Gm-Features: AUfX_mwmrCSys1xHMC96mE6PHcDd_oolS5Z0s89QqbifzwtMzv-j3UqA4jPxUKo
Message-ID: <CAJ+F1CJQbXpguAi-rnYsC+8BoZ29XwLXBwU90pwnAE2mv353Aw@mail.gmail.com>
Subject: Re: [PATCH] hw/display/virtio-gpu: Remove the bytes_pp field
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x52e.google.com
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

Hi

On Sun, Jul 19, 2026 at 3:36=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> virtio_gpu_do_set_scanout() validates the stride field of struct
> virtio_gpu_framebuffer against the bytes_pp field, but bytes_pp in the
> migration stream may be inconsistent with the format field, which
> pixman_image_create_bits() uses when it accesses the framebuffer.
> That validation is therefore incomplete.
>
> To avoid the trouble of synchronizing the two fields, remove bytes_pp,
> and always derive its value from format. Removing bytes_pp is safe
> because no released version of QEMU uses its migrated value.
>
> Fixes: 7b5574225429 ("hw/display: check frame buffer can hold blob")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> Based-on: <20260715201055.2465320-1-marcandre.lureau@redhat.com>
> ("[PATCH] hw/display/virtio-gpu: validate stride against width on scanout=
")

rebased and applied on my next fix PR
thanks

> ---
>  include/hw/virtio/virtio-gpu.h |  1 -
>  hw/display/virtio-gpu.c        | 27 +++++++++++++++++----------
>  2 files changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index f69fc1946273..6f889ee84a16 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -65,7 +65,6 @@ struct virtio_gpu_simple_resource {
>
>  struct virtio_gpu_framebuffer {
>      pixman_format_code_t format;
> -    uint32_t bytes_pp;
>      uint32_t width, height;
>      uint32_t stride;
>      uint32_t offset;
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index e00fb6effa50..660191d15f78 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -617,6 +617,11 @@ void virtio_gpu_update_scanout(VirtIOGPU *g,
>      scanout->fb =3D *fb;
>  }
>
> +static uint32_t virtio_gpu_format_bytes_pp(pixman_format_code_t format)
> +{
> +    return DIV_ROUND_UP(PIXMAN_FORMAT_BPP(format), 8);
> +}
> +
>  static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
>                                        uint32_t scanout_id,
>                                        struct virtio_gpu_framebuffer *fb,
> @@ -625,6 +630,7 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
>                                        uint32_t *error)
>  {
>      struct virtio_gpu_scanout *scanout;
> +    uint32_t bytes_pp =3D virtio_gpu_format_bytes_pp(fb->format);
>      uint8_t *data;
>
>      scanout =3D &g->parent_obj.scanout[scanout_id];
> @@ -646,10 +652,10 @@ static bool virtio_gpu_do_set_scanout(VirtIOGPU *g,
>          return false;
>      }
>
> -    if (fb->stride < (uint64_t)fb->width * fb->bytes_pp) {
> +    if (fb->stride < (uint64_t)fb->width * bytes_pp) {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: stride %u too small for width %u at %u bpp\n"=
,
> -                      __func__, fb->stride, fb->width, fb->bytes_pp);
> +                      __func__, fb->stride, fb->width, bytes_pp);
>          *error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
>          return false;
>      }
> @@ -708,6 +714,7 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
>      struct virtio_gpu_simple_resource *res;
>      struct virtio_gpu_framebuffer fb =3D { 0 };
>      struct virtio_gpu_set_scanout ss;
> +    uint32_t bytes_pp;
>
>      VIRTIO_GPU_FILL_CMD(ss);
>      virtio_gpu_bswap_32(&ss, sizeof(ss));
> @@ -733,11 +740,11 @@ static void virtio_gpu_set_scanout(VirtIOGPU *g,
>      }
>
>      fb.format =3D pixman_image_get_format(res->image);
> -    fb.bytes_pp =3D DIV_ROUND_UP(PIXMAN_FORMAT_BPP(fb.format), 8);
> +    bytes_pp =3D virtio_gpu_format_bytes_pp(fb.format);
>      fb.width  =3D pixman_image_get_width(res->image);
>      fb.height =3D pixman_image_get_height(res->image);
>      fb.stride =3D pixman_image_get_stride(res->image);
> -    fb.offset =3D ss.r.x * fb.bytes_pp + ss.r.y * fb.stride;
> +    fb.offset =3D ss.r.x * bytes_pp + ss.r.y * fb.stride;
>
>      virtio_gpu_do_set_scanout(g, ss.scanout_id,
>                                &fb, res, &ss.r, &cmd->error);
> @@ -748,6 +755,7 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gpu_=
framebuffer *fb,
>                                     uint64_t blob_size)
>  {
>      uint64_t fbend;
> +    uint32_t bytes_pp;
>
>      fb->format =3D virtio_gpu_get_pixman_format(ss->format);
>      if (!fb->format) {
> @@ -757,19 +765,19 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gp=
u_framebuffer *fb,
>          return false;
>      }
>
> -    fb->bytes_pp =3D DIV_ROUND_UP(PIXMAN_FORMAT_BPP(fb->format), 8);
> +    bytes_pp =3D virtio_gpu_format_bytes_pp(fb->format);
>      fb->width =3D ss->width;
>      fb->height =3D ss->height;
>      fb->stride =3D ss->strides[0];
>
> -    if (fb->stride < (uint64_t)fb->width * fb->bytes_pp) {
> +    if (fb->stride < (uint64_t)fb->width * bytes_pp) {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: stride %u too small for width %u at %u bpp\n"=
,
> -                      __func__, fb->stride, fb->width, fb->bytes_pp);
> +                      __func__, fb->stride, fb->width, bytes_pp);
>          return false;
>      }
>
> -    fb->offset =3D ss->offsets[0] + ss->r.x * fb->bytes_pp + ss->r.y * f=
b->stride;
> +    fb->offset =3D ss->offsets[0] + ss->r.x * bytes_pp + ss->r.y * fb->s=
tride;
>
>      fbend =3D fb->offset;
>      fbend +=3D (uint64_t) fb->stride * ss->r.height;
> @@ -1219,8 +1227,7 @@ static const VMStateDescription vmstate_virtio_gpu_=
scanout =3D {
>          VMSTATE_UINT32(cursor.pos.y, struct virtio_gpu_scanout),
>          VMSTATE_UINT32_TEST(fb.format, struct virtio_gpu_scanout,
>                              scanout_vmstate_after_v2),
> -        VMSTATE_UINT32_TEST(fb.bytes_pp, struct virtio_gpu_scanout,
> -                            scanout_vmstate_after_v2),
> +        VMSTATE_UNUSED_TEST(scanout_vmstate_after_v2, 4),
>          VMSTATE_UINT32_TEST(fb.width, struct virtio_gpu_scanout,
>                              scanout_vmstate_after_v2),
>          VMSTATE_UINT32_TEST(fb.height, struct virtio_gpu_scanout,
>
> ---
> base-commit: 499039798cdad7d86b787fec0eaf1da4151c0f05
> change-id: 20260719-bpp-803a3544fb79
> prerequisite-message-id: <20260715201055.2465320-1-marcandre.lureau@redha=
t.com>
> prerequisite-patch-id: 2c43dfa5d6a955e0fa3e3ca39ce3038968d85e7a
>
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
>


--=20
Marc-Andr=C3=A9 Lureau

