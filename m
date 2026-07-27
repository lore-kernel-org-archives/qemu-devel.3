Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CB9C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 20:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woRsY-0003VE-SO; Mon, 27 Jul 2026 16:24:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1woRsV-0003U2-L0
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 16:24:49 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1woRsR-0000V4-L8
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 16:24:46 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2cace91f112so35554005ad.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 13:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785183881; cv=none;
 d=google.com; s=arc-20260327;
 b=mqhacb9BsjlmrNtXGui9xmu4Dokh9gvk2WHEdB0mOpY4/CeUM/YbkwCklaUxneF2s3
 /kkNeZ0njP1SNR5R/LiFVFllw60IPW0DSdJoHH/leIo1Vby5d/FFHLMkznUnrqnft2TJ
 JN3xjfRsFuM+lbq9GeDJCzKc8Wnas19HKxwXPLIYxrq1uwNSEOTLXQgvhf5XArylWu4M
 xEviBNSrJu6feqKayX1coupT2BZckA21GukqRFkRFyl5mb9KKlq/2yyFfggbhZ2Ux+yE
 ELsZTk/Lea0gAsrIQGMPRizyhqcvQsKZhqUGzoIeDyCLkkx6+dlX5XfYLtn1yoQTWH9U
 fJOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GTAus8knj/ztD7plr0l7KvraKrtsFVzRjOZdyomYarw=;
 fh=hPQEyk07PHbgenbBaZbJwNnJpq+1NFLqLI2lI6i0R4E=;
 b=FoFpd1vodmbNPlZu9VphcizGpgMJxJUi5BtAVRVeRb6FAild45eNpFoDeoxnHezHjo
 o+OziMICvgngexgpYUGrRbNljJxpRIeeQWIp3ttDaSUMALOOiqessu+lxfUvttmMLVZN
 cYAG3us/mH7Iwzqbx3JF8NjBcgv3B8h51rfnIukpHRG/ojNfAkwI5wiCYM2xDV8+0oJV
 AcPYqO9VbJtG3NanvdGzLUYuZnGnIPF7VKbbHpprEOBg6cWPuKbjv/1nhvCR7BKlbiRP
 xI+jbRi0QqdOgn2xWOQd/TfUfMs1Fbrc9ZxBni78DBqMu5710JjkSjD8drW3ah9WXbYk
 QMow==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785183881; x=1785788681; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GTAus8knj/ztD7plr0l7KvraKrtsFVzRjOZdyomYarw=;
 b=BxeK/ZrNrs2rZORRiVJJI9yf5cl/tlEqsMe5L2tEXxuuF7sTYwx+fiaypNoyZZDmSv
 r4iDRUAehwE/NcgKZGb+1t1w+kU9VQxcMwU6T6g0oAlQyGDQ2yDVRUUFxKbinJwxxsuE
 vQi2otpRW0+4//d9YMkItouT0McTp7aQ/MQUmGwXJ7IUuMJZYBKAHtzUyKJPYS6PirKw
 UcUBMCn8F9hI4fL45keQSfCuAeR42r/hLpyH2EHNMEBdlAXmMBrTsEGGyAz+jZIs+YN7
 518XIFYivTkea1JXEqBtxMK/SnuORl28T4RvF9Leud9iwTl28mPtyaS2elKgnIXTruqU
 t1GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785183881; x=1785788681;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GTAus8knj/ztD7plr0l7KvraKrtsFVzRjOZdyomYarw=;
 b=LL4UiKwNP/vBZgLzdQG2ojY+Enmbo1Mw5EWUc02UjJtZXbs7N35paGSIvZsqLFkVyt
 gKqQ4WAo39dMDhzIyFJBVKxOQ0Bj7al4PKwQjOgMktHh+S9GZEn3LD6e+ELN8rDEFE5f
 VjQQdgmUOZJmDK8YIwmN5J5/J5mqIm+802gvX8UwsUjEHanuOyALwM1umz/jUOqR3lZw
 roEXfZ8h/d1dlu424/l6HIpIeTvnCOWC4iSSVXCFUjAnFwijBs8QnaWJIngvEUf/kFOq
 zMmKchPsqfuZzBYg4qtpZ38OpIOapgeRPzHJCxrQAUYwdiS8m851PiZzua19hp36xmVN
 pbJg==
X-Gm-Message-State: AOJu0YycGbrRrt66xAo6BnvygD6soB9sv26yZC5rvfMCYDnyl3P+5TVG
 LzwUISgpPD8zCImtzavifUH96wXzGIjpre7YNyuG74jBJhDg7stFmXhbBt1rb2+bL3mBnFC6GwC
 9bZDEaze87C2JWtjjciCff8mJaXzVm30=
X-Gm-Gg: AR+sD12UaC3s4Jw2MdhiFtFYr2cLCKlRp86BFOFjYQHCkNax/UUXS/lcsVt+rKNXXOG
 BT+ji36MFPO4FByEqGb8dcpFh/2vhG0kiGvQXWZ6/T3oujLgSxEh4kjzqnhaTJNfmqRDZ8fso/q
 K48VLyDRpT6iTuTJuZhQfqV90Cy8rg6/txUmTZduXKdykvJup347O11P+3JT5XQdrMgf3PItemR
 mEiXbD8TNiRwrSZvb2YBcqiyUwJLN0PvrwDDze9TF83wFU3ycOF9MmbE9d998eXTLleUNsIyVu8
 MKILGMmDvMN7P+CfDw==
X-Received: by 2002:a05:6a21:398e:b0:3bf:6c04:a813 with SMTP id
 adf61e73a8af0-3c6c802f95amr1095785637.52.1785183881407; Mon, 27 Jul 2026
 13:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260725122734.1775774-1-marcandre.lureau@redhat.com>
 <0d321266-8d73-4cb3-80c8-c5b05a34d2e2@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <0d321266-8d73-4cb3-80c8-c5b05a34d2e2@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 28 Jul 2026 00:24:28 +0400
X-Gm-Features: AUfX_mxzelLCOcTO2bIHHAGF1K8glJZfyb-qfnlph4SXpvKWLY0C87rnY76igzA
Message-ID: <CAJ+F1C+_zoQFnR8oXfTSTOv5HfQUkYLk3cWhve1B=2Xi0VbWQQ@mail.gmail.com>
Subject: Re: [PATCH v2] hw/display/virtio-gpu: fix offset wraparound in
 scanout_blob_to_fb
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, akihiko.odaki@gmail.com, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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

On Sun, Jul 26, 2026 at 11:03=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/07/25 21:27, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > virtio_gpu_scanout_blob_to_fb() computes the framebuffer offset from
> > guest-controlled offsets[0], r.x, r.y and stride using uint32_t
> > arithmetic. When the sum exceeds UINT32_MAX, silent wraparound lets
> > the guest steer the scanout to an arbitrary in-bounds region of the
> > blob instead of the intended rectangle.
> >
> > Compute the offset in uint64_t, reject values exceeding UINT32_MAX
> > (the width of fb->offset), and only store into fb->offset once both
> > range checks pass.
>
> The calculation of offset can still overflow uint64_t. All supported
> formats use four bytes per pixel, so
> the maximum mathematical value is:
>
>      UINT32_MAX + 4 * UINT32_MAX + UINT32_MAX * UINT32_MAX
>
> which exceeds UINT64_MAX.

The code rejects stride > INT_MAX, that should make the sum maximum
below UINT64_MAX

>
> This is reachable through virgl_cmd_set_scanout_blob(), whose
> rectangle checks use wrapping uint32_t additions. For example:
>
>      width =3D height =3D 16
>      stride =3D r.y =3D blob_size =3D UINT32_MAX
>      r.x =3D 0x7fffffff
>      r.width =3D 0x80000001
>      r.height =3D 1
>      offsets[0] =3D 3
>
> Both rectangle sums wrap to zero, while the mathematical offset is
> exactly 2^64. Consequently, offset becomes zero, fbend becomes
> M, and both bounds checks pass. The non-virgl caller retroactively
> rejects this geometry. The virgl caller fails to reject it.

That's a separate fix though, open a security issue?

>
> >
> > Fixes: 32db3c63ae11 ("virtio-gpu: Add virtio_gpu_set_scanout_blob")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3871
> > Based-on: <20260719-bpp-v1-1-9b91946d6cf3@rsg.ci.i.u-tokyo.ac.jp>
> > ("[PATCH] hw/display/virtio-gpu: Remove the bytes_pp field")
>
> Please remove Based-on: from the patch message when sending a pull
> request. You can put the tag in the footer. For example:
>
> https://patchew.org/QEMU/20260719-bpp-v1-1-9b91946d6cf3@rsg.ci.i.u-tokyo.=
ac.jp/
>
> Regards,
> Akihiko Odaki
>
> > Reported-by: Cyber_black <Cyberblackk@proton.me>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>> --=
-
> > v2:
> >   - no OOB, dropping CVE, make commit message adjustments
> > ---
> >   hw/display/virtio-gpu.c | 14 ++++++++------
> >   1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index b21ac8dace08..bc45cfb194f0 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -785,7 +785,7 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_gp=
u_framebuffer *fb,
> >                                      struct virtio_gpu_set_scanout_blob=
 *ss,
> >                                      uint64_t blob_size)
> >   {
> > -    uint64_t fbend;
> > +    uint64_t fbend, offset;
> >       uint32_t bytes_pp;
> >
> >       fb->format =3D virtio_gpu_get_pixman_format(ss->format);
> > @@ -815,18 +815,20 @@ bool virtio_gpu_scanout_blob_to_fb(struct virtio_=
gpu_framebuffer *fb,
> >           return false;
> >       }
> >
> > -    fb->offset =3D ss->offsets[0] + ss->r.x * bytes_pp + ss->r.y * fb-=
>stride;
> > +    offset =3D (uint64_t)ss->offsets[0] + (uint64_t)ss->r.x * bytes_pp=
 +
> > +             (uint64_t)ss->r.y * fb->stride;
> >
> > -    fbend =3D fb->offset;
> > -    fbend +=3D (uint64_t) fb->stride * ss->r.height;
> > +    fbend =3D offset + (uint64_t)fb->stride * ss->r.height;
> >
> > -    if (fbend > blob_size) {
> > +    if (offset > UINT32_MAX || fbend > blob_size) {
> >           qemu_log_mask(LOG_GUEST_ERROR,
> > -                      "%s: fb end out of range\n",
> > +                      "%s: invalid fb bounds\n",
> >                         __func__);
> >           return false;
> >       }
> >
> > +    fb->offset =3D offset;
> > +
> >       return true;
> >   }
> >
>
>

