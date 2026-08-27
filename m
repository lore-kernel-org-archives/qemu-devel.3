Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97138C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 16:32:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzd1M-0002jf-9V; Thu, 27 Aug 2026 12:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wzd1K-0002fn-2F
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 12:32:06 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wzd1I-0003qf-9Q
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 12:32:05 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2cfbbdfa60bso475955ad.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 09:32:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787848322; cv=none;
 d=google.com; s=arc-20260327;
 b=E9Hkt+rSTG5AL1mlOcvGubFEdJcDNawnbNBE/MoiT64M9XgblcVVbgFRl8/H2UD0a9
 8NQaaHY0o6m2OomZSkTumt3RR01xfjqzCsA6vreXd9HD1ZugESCEC/7unq4l5P+QXPQv
 nE1JFvz4jDku+GMvODnRt5FxH12Hfgg2CyzPz+DuCzMx464EL6geuMjEFUI76VkUCRPU
 Wkjsn/7Oz3LDACWdQ+LZGYyw82AL8pFAYRpkvkGb6qoEXLBiPeklvrx8f2Y+qKLsjvc7
 97wNebCkfuzWsEXuF1p/UqNyUVIac4U0lf33oso7W/wsHrOpJV9MSWi7t2y2TsDimttp
 UdnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=c2oxALRqjk+G+OZunhaXWZu2z4aYlpbgEsVBKKhFO8o=;
 fh=iBp5jtZZnbUXCTHESVhjBz0oKrPau2LepWbEcsuEIIU=;
 b=jOMM2Rr9w5qUHiMPXgXKqPfE7sPqWqFDbKsnYSbe11c8RzhZCPDnygi5KMFcqMeCpW
 3Ftv6ginCWSAB9Hfxrd0G/qO2DwUcfVETz7HvTjOMhQb9zDoybqqUO3vs7gqBM3gSW+F
 faC0QYR1xCUCPy7bNKwpAJR+9nia0Q1+MfUpEekjZ0XaZLKHsivlHWbYPf7TsGloq/sY
 U/RKRoWWaXKoRA1hpQSxfifBWXm8vhibeEIShbq2CEEiCT6UZAoRV5xZzGnl3r1B6QVq
 uP2y1rMu81Gu3bFhTM8md7yFzHonmO9IxobPN9RD15nN/s+IAIqZft51DEPDHWGtPFl/
 yyFw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787848322; x=1788453122; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=c2oxALRqjk+G+OZunhaXWZu2z4aYlpbgEsVBKKhFO8o=;
 b=mCpKBcXqrtWrPkvnxIzWZSe7dnmjN95tm1Xv6CcNbomDJo86WTw629kgrxpfGqVMut
 VlB0IODgsSK52QUsdqC/MfQrJY3s78A3VdDWMf8hNVRI+1owDtCsh3aLFtNwhmrXNgu6
 4LbCtDvmawhqrZzWT9awYouxEnAcX6QVQBuNpxrx+0Qk332jMQS+32tMozPeSbsBOKKJ
 vsJ9Ffid6tMiJzva3drEPBjIXSGY5tkB/kU44k1fNQ6K91wkDahTuBDgkI+krlOUhOYg
 bpnuHKZiZAf2kXcp7S44yzDxl/+CjV2TBYg1wg7rU9ejQpauO+Qk539i3e+nFj9/TfQK
 wyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787848322; x=1788453122;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c2oxALRqjk+G+OZunhaXWZu2z4aYlpbgEsVBKKhFO8o=;
 b=KmEXJFF2zvDzxeEOIzT5H1olajidSmtpPRZO5eRCFwTSM+7gcyHgDAwyimUApg08qC
 UKW8bGhU2fRUbzAr3d57Z4PhGf915yC/2CBmeXSgFLaNEeCREqzkfMgCWAy0/nZBMIRL
 jM77MQTHAgUXuwe7qeTpglZe9Mp6ukagnJ7DIvlI767aEguPUMF2P2y/hPFsBLysIBVN
 T0YqMy+Z+jVkpuNO7/LdDRZsiJ3fmiv8t+S++OT/RNChfcdDlGypomlylWJYgHSsxcGt
 OB6vOlB1nttc50/o3paNEwkARW6Y0dzrmOfMSRAMT27Vmr8nYnvxncmE/bYZX0eObVuu
 PbiQ==
X-Gm-Message-State: AFuF++luubZl4tzxhVzwIFA3tyHgBS5rtsXfaNcSx7ryxvMseZbvVead
 HiIVQzZB2mQKYVQOj3bEHk/IXG0mFM8AzfR2n+eNpe8XUBh7v/QwUus3LuUQgPN1XClUP+aWBdF
 xEJbRBySxJ4RAzWwYOy6wku3Hw+e/9mg=
X-Gm-Gg: AR+sD13VnJEy29wEE+ZuolnBm10xIxf4jmKxMtucomwBY4lDqMieqb/JAUKCtmRnj/x
 tiW/Hb8nfDMZFOON+o7m1reF0rbJ9CsEaurQTZsLYp3LDBMPFHgNKzoHd+MZ8XW0ESMwXEUasxK
 Koa+zwcRqZ6LDAw8TJPvgaI9eApgereh70E72+OmI6tAAYmpNTeRTpnStuvWZ3gNykaRJDKEHwl
 FsG4sj1qqs4t97nkyUADR5EKoQJb6MQvnnN02pnYG397WiR6anA6WMduye0AMxja2ss7W6IJ0OQ
 PoH0KEoUo4aTGrCVlhN0cfXe+mzOcR6JKhx3C5RwUp/RMd+NlvaCOLONkkOB/nCiMnylIdNpU+x
 f
X-Received: by 2002:a17:902:ce88:b0:2c9:c952:6e9 with SMTP id
 d9443c01a7336-2d74dca2281mr3015885ad.2.1787848322167; Thu, 27 Aug 2026
 09:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260827154355.3346449-1-marcandre.lureau@redhat.com>
 <877blb5ysl.fsf@draig.linaro.org>
In-Reply-To: <877blb5ysl.fsf@draig.linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 27 Aug 2026 20:31:49 +0400
X-Gm-Features: AcwNN1VkK5_4_MHOmV_nipMvIqwqgTOiWI9W3j55KS3XLNxUhSbulWdI40qYLDg
Message-ID: <CAJ+F1CJ-tFV4Yc8Gvp7huyQjLZJW5FE5fKb4QEqf+wSB8DNA-Q@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu/virgl: free BHs and timers on renderer reset
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, akihiko.odaki@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pl1-x631.google.com
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

On Thu, Aug 27, 2026 at 8:11=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> marcandre.lureau@redhat.com writes:
>
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > virtio_gpu_virgl_reset() does not free the bottom halves or timers
> > allocated by the previous virtio_gpu_virgl_init() call. A subsequent
> > virtio_gpu_virgl_init() overwrites the old pointers, leaking the
> > previous allocations.
> >
> > Fixes: bd9258917fbf ("virtio-gpu: Destroy virgl resources on virtio-gpu=
 reset")
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  hw/display/virtio-gpu-virgl.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virg=
l.c
> > index 0b79aef8d1f5..8bf6417c6514 100644
> > --- a/hw/display/virtio-gpu-virgl.c
> > +++ b/hw/display/virtio-gpu-virgl.c
> > @@ -1425,6 +1425,7 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
> >
> >  static bool virtio_gpu_virgl_reset(VirtIOGPU *g)
> >  {
> > +    VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);
> >      struct virtio_gpu_simple_resource *res, *tmp;
> >
> >      /*
> > @@ -1443,6 +1444,11 @@ static bool virtio_gpu_virgl_reset(VirtIOGPU *g)
> >
> >      virtio_gpu_virgl_reset_async_fences(g);
> >
> > +    g_clear_pointer(&gl->cmdq_resume_bh, qemu_bh_delete);
> > +    g_clear_pointer(&gl->async_fence_bh, qemu_bh_delete);
> > +    g_clear_pointer(&gl->print_stats, timer_free);
> > +    g_clear_pointer(&gl->fence_poll, timer_free);
> > +
>
> Don't we need some ptr checks in virtio_gpu_gl_device_unrealize so a
> reset followed by an unplug doesn't causes segs chasing now NULL
> pointers?

Good point, actually we should be safe, since render_state < RS_INITED.

But those qemu_bh_delete().. can we make it safe to call with NULL?
timer_free() was fixed already.

>
>
> >      return true;
> >  }
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

