Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08E6C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 10:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3tHW-0007x7-JK; Tue, 08 Sep 2026 06:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x3tHV-0007wy-SM
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 06:42:25 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x3tHU-0006Xz-4Y
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 06:42:25 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-cc1c73645a1so3293103a12.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 03:42:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788864143; cv=none;
 d=google.com; s=arc-20260327;
 b=OrGAt2szn2URFaOhWv48A2xNlpsDky6vKbKT4Ok3kaVdXsSRb9UNwXRjLNIpZI9JtU
 b1+1pKUdsuV8KAh4eQrPEedRhdZdA6XezPEi4D/d93m9n+aa2EkxwgNEDmgC7rnaGL9c
 YgvAoP/WjhNAHrHy2vZ+IMLcQ+InMn7QRqUwGKVu2J4t2LDmcrCblTkNuf7exMAOittr
 2jtqt9MpcJwgNBjEEDb4TUcorAfMC6EsPQHeYFOWapTuvm4cxOqxtiSS7lUjaU4HW62i
 QxXRaGE2aBtYAEO/sP/cUV9EgVFlhmPk20wFHTCMwQym+5dSyVhK9YrHt0TVhJHjLyCg
 fy8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ztjZsUu44y0f/4p96FTJaM3hmA49E2j0y+WomfOPWQQ=;
 fh=HLSuPskybtIIysCDrrCUGCclYLaEEdtpVmqnrjAgGtQ=;
 b=sSPe9BcNXQ9ty6+EMVynrCEpN6erLpWO7vzAoclic4noD1tEnHb5m0ECmQ+PJrToYY
 4QWqcrG9BLWrU+o0rG3KK3TTDZTt7mqmP+N7fEuynEjRCQYOj1d7H/0DALAmjy0q3Jx8
 mHeE7NUMx1gdnaRHR8rma5ivHxPmn4JpZDScKg0yMCyS+0D+jIAVZJA2JD6GkhuIQQcY
 bGCPRXFgiCm6zPc0WVRcrVkGPGadO/5c71CYP1FcC30AnyNYJmYwJClzcpZAzRGJ9ybm
 zD3qLV3c2nnrXa8Nl00DcmcDMPt4Qh90j3wVNi+LmUMeeV2Qn1t1nb3dbvcF7gOe4NcZ
 diog==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788864143; x=1789468943; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ztjZsUu44y0f/4p96FTJaM3hmA49E2j0y+WomfOPWQQ=;
 b=HpSawMBq0kgd0hvoMRXHfPn/1SNHiNJeQGk8tpQsg8pT3RkGJQ1StkDdsPgl4cxFoj
 lFNHMZaeaqN6lcSQNwXY776o3kqgeksY05Ml28sVa9ZqUAGf3HRucQp6g/QkePNgMF+n
 PaVRBCkNhuLv2/EOoii+wZ/X31RN8XiUNSBjlqjZOev3T/K9T63YC/3JS5aVC/oRvlZl
 UoAuyDpoMAHauwNrtSkHdbBdKv33Beot+MH+qlS0GEhpNmGKcAnK/ZEhA1O2ixStsGLb
 EGH8K0yPaFe1Orinkkm/kz9wYWUq7D1bjNzL8tJQ4rBRLblhQqpltlyOO5GsCxcpjkGN
 G8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788864143; x=1789468943;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ztjZsUu44y0f/4p96FTJaM3hmA49E2j0y+WomfOPWQQ=;
 b=mj/c6D0AObq6zrdJIDtSTpBAGppTVi7I4DkRRUuoSKtnsthUlF1HfWsG+0ImOnnCjd
 kV16egu4GFKzQzJQ/HhmYMBYFV7FrhDMee5ma88+n1DMQIYt5RK5BPeJi6CvmNM5pCwC
 z2BjQiOls6p4l6/ybv0xBnPsZrTZD8BA1A8kcsULCG9dCFADkO2kb3LbEFqnHqDQ0r0R
 sG6yG+0DDwoblZpO7SIM48k6d0KH0WIObkTDiWnWsroczsFxonFcoitoE6zf7YO3e8kL
 EMWLlptV75KKlPSRm59yMoqWQUJAnypoQ2jjR9nVDQWdMeYKNCW3RkEEjXHMIcDrkcA2
 yDcQ==
X-Gm-Message-State: AFuF++kn4obQe7irTbQhEZbtnbMEq5AdGZldY76JmO2A4VyraMThKOCi
 OEZeZKVldYTTso4LEjzGLhim05bzwgSUbuH1vWC03O9xJei9YkEMbcPBAfTlW1kAEg+J6Q/KUt+
 e7qT9FIE9D8ApixWXrkqxhVR+/Jki3CM=
X-Gm-Gg: AYBFou118duRTeDzyc21MWC1DZ0usUjIpc5MTlzdk8wF3t20Z+pVTDQtrmhVzxHgKlW
 SwHPnrxHaYNd930RJMMM13a40VINeqrrmTcAm4uNybE7BQzairB/FPpt7ruKCNOP/lme/KbP+xt
 0UOw9F/AhnBxrQrjU6d4geZi3g/mMPJ404BIz3hOH5Bq9vui4H+DlMFuzkk9M45pYX/FU4eltVd
 PxKblV86O6zi1aysb8n2Z/mM7/LNYh8pUuMUbOUbr35toPp2LLEtFMibrwFG9Wv6hUzzltDkXvB
 kTKgDD/yp+Q9wd1+AIMtzPrVxdkvg2HxqvkydS9DtBlGlw0Ym7pp3WObwv4RGHSPsxkeKFXpor4
 r
X-Received: by 2002:a05:6a21:b97:b0:3da:15a9:a18e with SMTP id
 adf61e73a8af0-3da3a0cc429mr41835228637.23.1788864142542; Tue, 08 Sep 2026
 03:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260904-virtio-gpu-cleanup-v2-0-15b5ae6b0023@redhat.com>
 <20260904-virtio-gpu-cleanup-v2-20-15b5ae6b0023@redhat.com>
 <0699b5e3-23de-4199-9689-c5b98a7c4583@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <0699b5e3-23de-4199-9689-c5b98a7c4583@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 8 Sep 2026 14:42:10 +0400
X-Gm-Features: AcwNN1Xnmyn99ysGHrWmyqwLUzwzhpT-9hA3Gu-FMitlcNimqEH-mINgBH13G3o
Message-ID: <CAJ+F1C+Ymzre7AdX=Gy66YL_OHwAgH9e06qqMNxLCvJNbt0kpA@mail.gmail.com>
Subject: Re: [PATCH v2 20/25] virtio-gpu: consolidate disabling scanout
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Alex Williamson <alex@shazbot.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x52f.google.com
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

On Tue, Sep 8, 2026 at 10:46=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/09/04 22:10, Marc-Andr=C3=A9 Lureau wrote:
> > Use the common virtio_gpu_disable_scanout() to reset the scanout state,
> > including GL state if any.
> >
> > Fixes: 7c092f17ccee ("virtio-gpu: Handle resource blob commands")
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/display/virtio-gpu-rutabaga.c | 4 +---
> >   hw/display/virtio-gpu-virgl.c    | 6 ++----
> >   hw/display/virtio-gpu.c          | 7 +++++--
> >   3 files changed, 8 insertions(+), 9 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-r=
utabaga.c
> > index 8a82e96b7461..8697dd6936ba 100644
> > --- a/hw/display/virtio-gpu-rutabaga.c
> > +++ b/hw/display/virtio-gpu-rutabaga.c
> > @@ -312,9 +312,7 @@ rutabaga_cmd_set_scanout(VirtIOGPU *g, struct virti=
o_gpu_ctrl_command *cmd)
> >       scanout =3D &vb->scanout[ss.scanout_id];
> >
> >       if (ss.resource_id =3D=3D 0) {
> > -        scanout->resource_id =3D 0;
> > -        qemu_console_set_surface(scanout->con, NULL);
> > -        qemu_console_gl_scanout_disable(scanout->con);
> > +        virtio_gpu_disable_scanout(g, ss.scanout_id);
> >           return;
> >       }
> >
> > diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virg=
l.c
> > index 79d4c0b569fb..87d1fc3d5f65 100644
> > --- a/hw/display/virtio-gpu-virgl.c
> > +++ b/hw/display/virtio-gpu-virgl.c
> > @@ -618,8 +618,7 @@ static void virgl_cmd_set_scanout(VirtIOGPU *g,
> >               ss.r.x, ss.r.y, ss.r.width, ss.r.height,
> >               d3d_tex2d);
> >       } else {
> > -        qemu_console_set_surface(g->parent_obj.scanout[ss.scanout_id].=
con, NULL);
> > -        qemu_console_gl_scanout_disable(g->parent_obj.scanout[ss.scano=
ut_id].con);
> > +        virtio_gpu_disable_scanout(g, ss.scanout_id);
> >       }
> >       g->parent_obj.scanout[ss.scanout_id].resource_id =3D ss.resource_=
id;
> >   }
> > @@ -1426,8 +1425,7 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
> >       int i;
> >
> >       for (i =3D 0; i < g->parent_obj.conf.max_outputs; i++) {
> > -        qemu_console_set_surface(g->parent_obj.scanout[i].con, NULL);
> > -        qemu_console_gl_scanout_disable(g->parent_obj.scanout[i].con);
> > +        virtio_gpu_disable_scanout(g, i);
> >       }
> >   }
> >
> > diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> > index ae1f87ad68b2..cb096cb349cd 100644
> > --- a/hw/display/virtio-gpu.c
> > +++ b/hw/display/virtio-gpu.c
> > @@ -435,8 +435,11 @@ void virtio_gpu_disable_scanout(VirtIOGPU *g, int =
scanout_id)
> >   {
> >       struct virtio_gpu_scanout *scanout =3D &g->parent_obj.scanout[sca=
nout_id];
> >
> > -    virtio_gpu_release_scanout_dmabuf(g, scanout_id);
> > -
> > +    if (scanout->dmabuf) {
> > +        virtio_gpu_release_scanout_dmabuf(g, scanout_id);
> > +    } else {
> > +        qemu_console_gl_scanout_disable(scanout->con);
> > +    }
>
> GL needs to be always disabled when clearing a scanout.
>

Ok, I removed the else condition.

Are you going to review the remaining 1-23 patches?
thanks


> Having scanout->dmabuf suppresses the explicit GL-disable callback. This
> misses a real reset path:
> 1. Reset a Virgl device displaying a hostmem-mapped blob.
> 2. virtio_gpu_virgl_resource_unref() starts asynchronous unmapping and
>     returns before disabling its scanouts.
> 3. virtio_gpu_reset_bh() installs placeholder surfaces, changing the
>     console to SCANOUT_SURFACE; virtio_gpu_base_reset() clears the
>     resource IDs.
> 4. virtio_gpu_gl_reset() calls virtio_gpu_virgl_reset_scanout(). The new
>     helper releases the retained DMA-BUF, but
>     qemu_console_gl_release_dmabuf() invokes GL-disable only for
>     SCANOUT_DMABUF.
> 5. GTK=E2=80=99s release callback clears the DMA-BUF pointer but leaves
>     scanout_mode and its framebuffer. The queued redraw continues through
>     the old framebuffer path instead of displaying the placeholder, blit
>     in gd_gl_area_draw().
>
> Before this patch, virtio_gpu_virgl_reset_scanout() always called
> GL-disable. Please ensure the disable helper actually disables the
> frontend even when releasing a wrapper whose console has already
> switched to a surface.
>
> Regards,
> Akihiko Odaki
>
> >       qemu_console_set_surface(scanout->con, NULL);
> >       scanout->resource_id =3D 0;
> >       scanout->ds =3D NULL;
> >
>
>

