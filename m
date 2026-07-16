Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AA6C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 10:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkJU6-0000N1-MJ; Thu, 16 Jul 2026 06:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wkJTi-0000M7-E8
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 06:38:09 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wkJTg-0007PQ-Gz
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 06:38:06 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c85b73ffb52so3736788a12.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 03:38:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784198283; cv=none;
 d=google.com; s=arc-20260327;
 b=LsajsSI5kLpDWx3I7wjeVRCLJwAfnwZWBFFI9G8Ie7CasJudX2UdORN8CBRubF64br
 APONmhGTeBCcXCCzfw9Mxyh1nJYYxEj80vPhI9kh6YW//A6xz/Bsvx5p26hNhfCkKDzh
 Am40dEHnk1CwWhKMeYCN6oeqlWa4YEY9s/W9V6Cij+zHBpSPfzjgjXhaqgFD1lb4Dwd/
 5cDzx4/srpjvNctQeipqCeGWPmjAEScYAVn5sJ5qox7cT/KS12brNwA66A9dKm0PTAZm
 hRCjR84NdS73wYfzA/Dl49aeo1OyyFo10RQgMnpBwwqfiYQvmFnzF+QQkcOVO/FR9pu+
 cbZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=32p2C0PQBVyemZZBfbN/HYFe6jtNxagRr9uqRGk2H8o=;
 fh=fWOTDz5YDRO8gq4Ddplx48s4Kmwze/7hZKKkVfzrGlw=;
 b=PqbJAtiNeWlbJICDSlSVM+Xzsvztt54YeyhkBZyR1VFGOblp1e+wO3vxUvBFtQ992Q
 4KmB49o9kvkgq54FeSU2qugGA3r2AT/L4pSzzQUnz5B8RMNORJw6VD/eEqF0bRaPOJhA
 /AmOS2KiJqQ4l3DyhsigQIOrAz+MNCxANi0BPNpglF/kobLz6iLlTP6A2okbMRS5lgjr
 K8wSyB6P5Uqn/lYCqevFCrh4Ne8D32n98qftQgc8Qs+HzF7w0ofL2YruSdAsmzEO/+va
 /Ky+oQP/GpvMowop+OTkpcuO+/qMKIq7TJAHx9ifTNyNignwjAhICj2r1Bb8uDaTXG7w
 qogg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784198283; x=1784803083; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=32p2C0PQBVyemZZBfbN/HYFe6jtNxagRr9uqRGk2H8o=;
 b=Sawyi7/rv15/ViLKqW19dQWE/LH+aV0XaNnPW4bey2z+VVPviQ240FdUPSrhAwJY+e
 2ATpMMUL5IO4ZbVgufemM57/WuMiNLPP6jYYBvv0mIJoxUDdl906LDfCdX0noPm0Hd8p
 ++o8INLdY02PwcGrRM5aYEc4zKEmnVjW2sX8YYMuKxn+wEA4WQT+7ayqlnO7mKLvRvV0
 CeatYp+eb2csUJQtP9D9GT20RTy6+6p7syBTWExATqms+nqzBdZemXcLVJGhpyp1IgMH
 q08q12kYm+QL5YEEMnaFOl+yeZEnRMmpj0E6DrvnWAz9svLUEvHV8Yv70hQA9ssTuhpK
 DLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784198283; x=1784803083;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=32p2C0PQBVyemZZBfbN/HYFe6jtNxagRr9uqRGk2H8o=;
 b=oTnR+HSay2NiSZrsPU4Pq1MnBZnNqjN3dRD51nmmCH6BGJpHP2zIlfjMwZL9dCO10q
 bpweLs1YEpJyhdqHdzfYagEktMETmRGtlAtjXWghM8R2Z4Jv0LHontMZe+atx/e0hWSJ
 BS55/BCWOB5+eQ7fELmZCuwK3qSYDH/ASeYidfkYoo/ZjFioVpBxNqmxyazgkQSPKk27
 VW9INVgoVclYxcKfbqcfhU4PPM4AZsPpIvt3FK5ykiDkGZ7Tg/Hnn8vQo1lmcG+52VMZ
 3WlBDU+oa2SkKOJ7siVgF8RsAMTfq1wnJUSjQ47OEJSWaqT6i0AHAGNfD3TJ6RDkfx/I
 0Ixg==
X-Gm-Message-State: AOJu0YyJibAgyR1stC6kXMO5z0GBY/xMvNx83X20mq5HKKHBDKS8Vt6k
 iB/RHRZ1aB3Uu7KSbtIIsis7mkRz/exVEoq5wMYQ2Lv6zf9oUBb9TXEl/Qtq1XONZicyMj7und4
 e1uD8lksspaU+jq+V0AF298j6IE+3vpo=
X-Gm-Gg: AfdE7ckmvdcmHI/QUbtYVhfnhKR5QEQqDj9VHPkk085epA2P/pXrku+a+5SLupOj37/
 DBSR/352VoKZZ3Sloy/96kTtv7xQJaOX9yBxlmDQxdZ055kHFskAKErXBOsscSoumjMXPFqRTx3
 0yPY0U20yHHr+Q+DGPPZ4BOHW08sFBS9IanFZq/BDbfUiQEaElbyep4qL5DuHTZraRpGhUiYe9M
 esnEV5Jvmp0fl9RbwKwGOM1pPO5UwXSWAV5XhJu/NGDskpeT2E5yHxHtZSU5kdEnQ9hwu4gQeHb
 HcytsEtj87e890HEHw==
X-Received: by 2002:a05:6a21:9210:b0:3b3:1c7b:ff7 with SMTP id
 adf61e73a8af0-3c36c2ece25mr7725654637.46.1784198282760; Thu, 16 Jul 2026
 03:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260716075529.3009491-1-marcandre.lureau@redhat.com>
 <809cedaa-0704-4ff9-954a-8e6e5724494d@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <809cedaa-0704-4ff9-954a-8e6e5724494d@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 16 Jul 2026 14:37:51 +0400
X-Gm-Features: AUfX_mxmTEcLG5lDM3ODOxJEi1TlQBby6Xo34pBkzi8IH4XbelqII8WPJQLH_U8
Message-ID: <CAJ+F1C+pkjmfPb-KoGB=RxL8HpcqSWVQx6ceGYXxvkuKmqfquQ@mail.gmail.com>
Subject: Re: [PATCH] hw/display/virtio-gpu: cap submit_3d command buffer
 allocation
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x530.google.com
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

On Thu, Jul 16, 2026 at 2:35=E2=80=AFPM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/07/16 16:55, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Both virgl_cmd_submit_3d() and rutabaga_cmd_submit_3d() pass the
> > guest-controlled cs.size directly to malloc() without bounds checking. =
A
> > malicious guest can set cs.size to an arbitrarily large value, causing
> > an OOM abort that crashes the QEMU process.
>
> I rechecked and found vhost-user-gpu is also affected. The changes of
> virgl and rutabaga look good to me.

Yes, I did it for vhost-user-gpu too (now outdated):
https://patchew.org/QEMU/20260713125431.107278-1-marcandre.lureau@redhat.co=
m/

I should probably merge them together and resend then.

>
> Regards,
> Akihiko Odaki
>
> >
> > Checking cs.size against the descriptor payload length (iov_size) is no=
t
> > sufficient: indirect descriptor tables can repeat entries aliasing the
> > same guest-physical range, inflating iov_size() to nearly 4 GiB while
> > referring to only a small amount of unique memory.
> >
> > Instead, cap cs.size at 4 MiB. With 4 KiB pages and QEMU's
> > VIRTQUEUE_MAX_SIZE (1024) mapped-iov limit, the Linux virtio driver
> > cannot carry more than ~4 MiB of inline command data, so legitimate
> > submissions are unaffected.
> >
> > Fixes: 9d9e152136bd ("virtio-gpu: add 3d mode and virgl rendering suppo=
rt.")
> > Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfx=
stream")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3776
> > Reported-by: admin@fluentlogic.org
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   include/hw/virtio/virtio-gpu.h   | 8 ++++++++
> >   hw/display/virtio-gpu-rutabaga.c | 8 ++++++++
> >   hw/display/virtio-gpu-virgl.c    | 8 ++++++++
> >   3 files changed, 24 insertions(+)
> >
> > diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-=
gpu.h
> > index f69fc194627..c10bfbd596f 100644
> > --- a/include/hw/virtio/virtio-gpu.h
> > +++ b/include/hw/virtio/virtio-gpu.h
> > @@ -299,6 +299,14 @@ struct VirtIOGPURutabaga {
> >       struct rutabaga *rutabaga;
> >   };
> >
> > +/*
> > + * With 4 KiB pages and QEMU's VIRTQUEUE_MAX_SIZE (1024) mapped-iov
> > + * limit, the largest inline command is ~4 MiB.  Cap submit_3d
> > + * allocations to this value to prevent a malicious guest from
> > + * triggering an OOM abort via an inflated cs.size field.
> > + */
> > +#define VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE (4 * 1024 * 1024)
> > +
> >   #define VIRTIO_GPU_FILL_CMD(out) do {                                =
   \
> >           size_t virtiogpufillcmd_s_ =3D                               =
     \
> >               iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num, 0,       =
   \
> > diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-r=
utabaga.c
> > index 6ff12639012..4d7d7b24592 100644
> > --- a/hw/display/virtio-gpu-rutabaga.c
> > +++ b/hw/display/virtio-gpu-rutabaga.c
> > @@ -351,6 +351,14 @@ rutabaga_cmd_submit_3d(VirtIOGPU *g,
> >       VIRTIO_GPU_FILL_CMD(cs);
> >       trace_virtio_gpu_cmd_ctx_submit(cs.hdr.ctx_id, cs.size);
> >
> > +    if (cs.size > VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: command buffer too large (%u)\n",
> > +                      __func__, cs.size);
> > +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> > +        return;
> > +    }
> > +
> >       buf =3D g_new0(uint8_t, cs.size);
> >       s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
> >                      sizeof(cs), buf, cs.size);
> > diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virg=
l.c
> > index 60c78af06a4..d9e5b011049 100644
> > --- a/hw/display/virtio-gpu-virgl.c
> > +++ b/hw/display/virtio-gpu-virgl.c
> > @@ -607,6 +607,14 @@ static void virgl_cmd_submit_3d(VirtIOGPU *g,
> >       VIRTIO_GPU_FILL_CMD(cs);
> >       trace_virtio_gpu_cmd_ctx_submit(cs.hdr.ctx_id, cs.size);
> >
> > +    if (cs.size > VIRTIO_GPU_MAX_CMD_SUBMIT_SIZE) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: command buffer too large (%u)\n",
> > +                      __func__, cs.size);
> > +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> > +        return;
> > +    }
> > +
> >       buf =3D g_malloc(cs.size);
> >       s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
> >                      sizeof(cs), buf, cs.size);
>
>

