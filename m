Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB95C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 07:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkGf0-0001fa-BM; Thu, 16 Jul 2026 03:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wkGes-0001fH-Ge
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 03:37:26 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wkGeq-0001P6-QF
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 03:37:26 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-ca88130e09aso4180361a12.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 00:37:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784187443; cv=none;
 d=google.com; s=arc-20260327;
 b=b/I0kvM6v6KSTupzWC0z11FwMSR0uw77tg2MogM7wx5YZCc/epNeZ1l46XWDNYRRwW
 /ckncqJ2HqNgPn5eCVgNl2xFz+kZB/Y5+HKZa6Ef6Tj13CNhui27iLS5vtg0JtN4xV0V
 EN8Ky3UyMXUcLZ7kUwK1/v4h5n3Bpd/6qSaSHzXnQkbxFaTHbdnqjKaPH4vJN/aFCz99
 aOSLotSCjci/nVtb4tChEYu8vzsbv88gEAZjHKmNORf2BSnve0Ac4luyqvfk+OJKOV7z
 KCr09FU+Jh96Xxrnr82BUxnZc+Cebq/0IB1WPvM+HL8g2Q/MxSo7zTvn+qAD3lTCLTIW
 k0rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=v0hIqEizCiEnY/ojnsTfQitWhnX+yHmlYLyB3z5q8YQ=;
 fh=fWOTDz5YDRO8gq4Ddplx48s4Kmwze/7hZKKkVfzrGlw=;
 b=OI831qotl4udJVLUolLNsn4intqSU3PP5pZrWW8wc2imJ+gi95yFZL6Tv1EH9oOBCi
 SL0ycwpRK7y1IzYHsw5R543Z/6MGBkk/3LRObu4BKVGVOcP2bwp//Q2zg1Iw/h4StpWL
 48ixIf8Rkp3SJyBZDR7bwtlDE1jyXuf1DIpnUr9eYbKW0fsTSLikiNgfsjs4KQp65omR
 Oe/cuUIZtowGgL/egatwWljx0mnHGmTp3oy6nKYA8xHSL/ZehqOjUPS4yqirCtbd2Wuv
 NZYasSNVjyoVXKM6GuW5Zc9H0cj6mCD7iLElp+9smQgkLhC6YNu3sWHcWikCmhZR6k4T
 xg5g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784187443; x=1784792243; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=v0hIqEizCiEnY/ojnsTfQitWhnX+yHmlYLyB3z5q8YQ=;
 b=rQMu/ykyUFz2Ifsi7VHT99XG5QZzQqo8Dy8kBwLMZWE9suaciGykdxRj7ZPXWOqcoE
 dd0IInrTiFS57DjXacxNwSNQm5x/qSPJpQGwL9bW1y9SONHTgD4bLbTMNotsNew3/aBy
 +Zr594LcJDaGDBOmj8IgWWRajUe28ITBmN0bQEad0Ks8fksjfaDLBQ5jyxxb5JRdqfo4
 rUvuVFCj5fFAuZmwWDnprdIbGfNK8X9bvwd0OVtdqeaeJDMpsqCiTKHihvTelGE07g0F
 hF3D9nJuIOa5tbmSLs0A8m7uOeGyEqRDUMRRDVhVrhiH0hQ9dpKNpV/6fbQ+aBfDyGPm
 BVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784187443; x=1784792243;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v0hIqEizCiEnY/ojnsTfQitWhnX+yHmlYLyB3z5q8YQ=;
 b=ZO7uAr+FsT5dZSWY9zcEm0AS0+s/R+n6ZUzR4n8eKFT1o/i2wb5Q08cM+0izGJj8yV
 orkIGvHxbNoLHmcNDEY61il8teAsBtxfrnpkmChQPrMIakEHzeg8W/m27u2jkgPRLU9Q
 IBjGdpSxnnmu4Z+C4C9jeESEsczqFM33nFxDiUYdYGShMipeWUzLBLPU6nRuwmv0qlE0
 zvO36liKWW3ZGypTsIsqlbMM61QmU8ddHHy7E8jiaNwEGiZjJrTEV66SvhnPV+KVLXUD
 TNpqsvmPIvzOkOJt5YVkSQzckVXDruWdICjLXLDBXp26CkuP4YANHcj35Qpwqxk/+fmo
 +/kg==
X-Gm-Message-State: AOJu0YyRwO7OYqEexEjWtD9V29u8Pd8u6wslkIv9BtxbcAwplKwQ/FtN
 Dc3rQcCNJ8dIHeO0oZUn+pDxaVV/ZsqW7Kfp/2/i+mfYjJDA0Bb2Pr2Qo9FuWBpKMadAv5koVF7
 FcZot5SBB/3dR1zYAiqqQlPc6lnE5BXc=
X-Gm-Gg: AfdE7clpPQ6U6uAzf6CQWSaEP5sn12v7qkyIxH/72Wf22re3rdocP7zQI6STXwN6Q9g
 fIqbluXpcMZiku0O1pgDFO69Yd+xK6nIC2qb7nDoTHZO8qPyFxD6tcDrIxnj0Zf+HV8ScAK9RyE
 sk1skq62VIgJr8yasDXpgvhBgpDwHiffPxpeElNNbjmEzDwVfIHEhpX+o4UtdI+hzvYCw5B8aj2
 CpSi+dqyUdXam/E4yPs+KFeUVdQF49SQdMBRssP6P1BK4Q3mUv6gt9ZKzRc6i6UJGT6HMD1v4aw
 BQdXL2Arxb0vykppmFq93ZIgGHva
X-Received: by 2002:a05:6a21:3a43:b0:3bf:a638:4376 with SMTP id
 adf61e73a8af0-3c357001859mr11394266637.21.1784187443323; Thu, 16 Jul 2026
 00:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260713125410.105653-1-marcandre.lureau@redhat.com>
 <252d8148-5abe-41ee-afcd-4cbf81fb79da@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <252d8148-5abe-41ee-afcd-4cbf81fb79da@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 16 Jul 2026 11:37:11 +0400
X-Gm-Features: AUfX_mzAuqJqelNJdZE933JQMUpELasB6vbCEzNwIQzNoF0OwzR-tHn8HRYgb8A
Message-ID: <CAJ+F1C+2iuRN0HuYv9qC7q2XbhURMFTBOchm+hW7ADT=-PMcDA@mail.gmail.com>
Subject: Re: [PATCH] hw/display/virtio-gpu: validate command buffer size in
 submit_3d
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x52d.google.com
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

On Thu, Jul 16, 2026 at 10:01=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2026/07/13 21:54, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > virgl_cmd_submit_3d() passes the guest-controlled cs.size directly to
> > g_malloc() without any bounds check. A malicious guest can set this
> > field to an arbitrarily large value (up to 4GB), causing an OOM abort
> > that crashes the QEMU process.
>
> virtio-gpu-rutabaga has the same problem: it also makes a fatal
> guest-sized allocation before copying the payload.

good catch

>
> >
> > Validate cs.size against the actual descriptor payload size before
> > allocating, rejecting values that exceed what the virtqueue entry
> > can carry.
>
> Unfortunately, this check does not bound the allocation. The descriptor
> payload length is also controlled by the guest, and descriptors can
> alias the same guest-physical range. For example, an indirect descriptor
> table can repeat the following entry: addr =3D A, len =3D 4 MiB
>
> With 1,023 such entries and one response descriptor, iov_size() reports
> 4092 MiB even though the entries refer to only 4 MiB of unique guest
> memory. A cs.size of nearly 4 GiB still passes the proposed
> check and reaches g_malloc().
>
> I surveyed the command formats to find a suitable upper bound, but there
> is no common protocol limit:
>
> For virgl, Mesa limtis the complete buffer to 260 KiB.
>
> Venus places commands in shared rings, so current Mesa submits
> only small control messages directly; its largest fixed outer command
> buffer is 256 bytes.
>
> DRM native contexts are more difficult. MSM, i915, and Asahi request
> sizes grow with the number of BO or resource records, while AMDGPU can
> aggregate multiple chunks. There is no useful common bound below the
> outer 32-bit length, or roughly 4 GiB.
>
> I think QEMU needs a practical policy limit, as it already has
> for the number of virtio descriptors. A possible limit is 4 MiB.
>
> For vmalloc-backed command data, Linux creates one scatterlist entry per
> page, in addition to the command and response entries. With 4 KiB pages
> and QEMU's limit of 1,024 mapped iov entries, the largest such command
> is: 1022 * 4 KiB =3D 4 MiB - 8 KiB
>
> So the existing Linux/QEMU path already stops reliably carrying larger
> inline commands at roughly 4 MiB.

Ok, let's start with that. If it's problematic, we can revisit.

>
> >
> > Fixes: 9d9e152136bd ("virtio-gpu: add 3d mode and virgl rendering suppo=
rt.")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3776
> > Reported-by: admin@fluentlogic.org
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   hw/display/virtio-gpu-virgl.c | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> >
> > diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virg=
l.c
> > index 60c78af06a4..2a07dd2431f 100644
> > --- a/hw/display/virtio-gpu-virgl.c
> > +++ b/hw/display/virtio-gpu-virgl.c
> > @@ -601,12 +601,23 @@ static void virgl_cmd_submit_3d(VirtIOGPU *g,
> >                                   struct virtio_gpu_ctrl_command *cmd)
> >   {
> >       struct virtio_gpu_cmd_submit cs;
> > +    size_t iov_len;
> >       void *buf;
> >       size_t s;
> >
> >       VIRTIO_GPU_FILL_CMD(cs);
> >       trace_virtio_gpu_cmd_ctx_submit(cs.hdr.ctx_id, cs.size);
> >
> > +    iov_len =3D iov_size(cmd->elem.out_sg, cmd->elem.out_num);
> > +    if (cs.size =3D=3D 0 || iov_len < sizeof(cs) ||
>
> A zero-length payload is valid for a fence-only submission, and Mesa
> Venus emits such submissions, so cs.size =3D=3D 0 should not be rejected.

ok

>
> Regards,
> Akihiko Odaki
>
> > +        cs.size > iov_len - sizeof(cs)) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: size out of range (%u/%zu)",
> > +                      __func__, cs.size, iov_len);
> > +        cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER;
> > +        return;
> > +    }
> > +
> >       buf =3D g_malloc(cs.size);
> >       s =3D iov_to_buf(cmd->elem.out_sg, cmd->elem.out_num,
> >                      sizeof(cs), buf, cs.size);
>
>

