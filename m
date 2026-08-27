Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341E5C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 17:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzdZh-0007Fr-RT; Thu, 27 Aug 2026 13:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzdZf-0007Fc-Mx
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:07:35 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wzdZc-0003dc-K1
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:07:35 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49a97714f5dso12995335e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 10:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787850450; x=1788455250; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+cWhzFYQdU7YpqEssW5mrnOahGTgQ7shWZD7nXJK3Y4=;
 b=s7CGpT7tGcxA+4CbB6elgc1PULIRRceH2QZzBUfEUYullFJtXVMdC2NNMuc6wJC02b
 dGE5Rp2N4lxwdPD3cHbNyLmnbaaknDpd0hyPsRiHJEaFoPeeAQ5HtRFoluAWJh5jyFl6
 cneUbKdEWECZ+pLb6zFy6ybXsw4+g5j153U65Ul4riQ9ZCZLevKaab8tMFc0mG9BwSk9
 +lY5AkyQd51vnUQhOp+C3vrAJ/4K5vjJWuK9MPFZp/fbzaGq8kYAHe33RSL5pSj0ikum
 2onayFZGnXv4vOnwXPS3wz2FwgabDFSwXkQxQ2Nud+uKLadXRHs2aFdjbAyJLqeagom7
 hbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787850450; x=1788455250;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+cWhzFYQdU7YpqEssW5mrnOahGTgQ7shWZD7nXJK3Y4=;
 b=mcszl8sZNNwzy0nAnj9feYZZkhLGLfUX7wmkn7KuQMDzFbuGnFytVj3N1onJfYgJQJ
 PCjYwMa/s1oUdvQ9TRdgpzPzcFeFkDE/4taFmfjqOm10qfVtCYLl5gVk9uUK9PRedfrA
 YXAEdGCWJpLnw5+pyuhL7VZKSb5zdZ+kGJRsIz6F6ltX4PFfD2Lb2yG8RrcWF1cnJ6kG
 PuVvnKmbG4OVBM0oTYc1H/C2cGhGBwx8i63F045s8GhC1HfBA5evVzz2uTsIdS6v7AOy
 BPB0MIJgZUpRgP5g+VijwF6UCZkIlOmo38LhvnnwCVcfbLXo8Zj6NOqz5wiMew/oHWdE
 /pLw==
X-Gm-Message-State: AFuF++k7EcSDyvrVAgh8cH8ER49bAJFL3wUhgQUaq1M0p33VYL7rVleC
 0XoHmInxyxutqpPIcpIUnDsu5Ro/ir/Eg6gbUvIC7jYiRQUJXZ+YTltfuoOXOygHw5Y=
X-Gm-Gg: AR+sD13LvUh56Y9cZeZe3bFp53UfM907bJv7khHLrof2/KCZArmIcWosAQCGGgtptTA
 +snPxLO/2k6SmwGo4VYKuy0/wPAfqXAfp+8S+qPVBYGwZN4bOe2e9QgF6EdvQ73yJ0TEk6sHhKG
 ck4YMx/LESK8NnrRR5QYH5MlShNdeRb9jicIEFdgGFZh/6/h1AkAz+JykkwooAuRdj1TPTtBius
 K3wiD+3HllNpi3GzT3fd7a50yxfQyEPmKNpqFetac2XmOZ4tDn79EoCt627oL+PrCgsJe7BSUBR
 iHpx5cKN2OAvwe9Iwn2zOC+ItldZyVtwRada2ONCNz9jsxSlUKk01K1I7lSifSJtwYo2SkjTXr8
 /P+hPa+RbjFWe5iJ7qYRlhlsuzxw55s3RXy9IsUDIfMG3Bxx6n7I2TWc91s1jx1Dwn6Zw8yvzsT
 unEgX+J9ZW54wkkrby5gpogPL4xjLcpNaCwY2JA69kXf3vVpE/i8p9BUkDD/08tw==
X-Received: by 2002:a05:600c:1e0f:b0:49b:9113:e04a with SMTP id
 5b1f17b1804b1-49b91c19c77mr9385545e9.1.1787850450225; 
 Thu, 27 Aug 2026 10:07:30 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dd56826bsm78925125e9.4.2026.08.27.10.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 10:07:29 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 51B925F882;
 Thu, 27 Aug 2026 18:07:28 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  akihiko.odaki@gmail.com
Subject: Re: [PATCH] virtio-gpu/virgl: free BHs and timers on renderer reset
In-Reply-To: <CAJ+F1CJ-tFV4Yc8Gvp7huyQjLZJW5FE5fKb4QEqf+wSB8DNA-Q@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 27 Aug 2026
 20:31:49 +0400")
References: <20260827154355.3346449-1-marcandre.lureau@redhat.com>
 <877blb5ysl.fsf@draig.linaro.org>
 <CAJ+F1CJ-tFV4Yc8Gvp7huyQjLZJW5FE5fKb4QEqf+wSB8DNA-Q@mail.gmail.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Thu, 27 Aug 2026 18:07:28 +0100
Message-ID: <871pbj5w6n.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> On Thu, Aug 27, 2026 at 8:11=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>>
>> marcandre.lureau@redhat.com writes:
>>
>> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >
>> > virtio_gpu_virgl_reset() does not free the bottom halves or timers
>> > allocated by the previous virtio_gpu_virgl_init() call. A subsequent
>> > virtio_gpu_virgl_init() overwrites the old pointers, leaking the
>> > previous allocations.
>> >
>> > Fixes: bd9258917fbf ("virtio-gpu: Destroy virgl resources on virtio-gp=
u reset")
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >  hw/display/virtio-gpu-virgl.c | 6 ++++++
>> >  1 file changed, 6 insertions(+)
>> >
>> > diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-vir=
gl.c
>> > index 0b79aef8d1f5..8bf6417c6514 100644
>> > --- a/hw/display/virtio-gpu-virgl.c
>> > +++ b/hw/display/virtio-gpu-virgl.c
>> > @@ -1425,6 +1425,7 @@ void virtio_gpu_virgl_reset_scanout(VirtIOGPU *g)
>> >
>> >  static bool virtio_gpu_virgl_reset(VirtIOGPU *g)
>> >  {
>> > +    VirtIOGPUGL *gl =3D VIRTIO_GPU_GL(g);
>> >      struct virtio_gpu_simple_resource *res, *tmp;
>> >
>> >      /*
>> > @@ -1443,6 +1444,11 @@ static bool virtio_gpu_virgl_reset(VirtIOGPU *g)
>> >
>> >      virtio_gpu_virgl_reset_async_fences(g);
>> >
>> > +    g_clear_pointer(&gl->cmdq_resume_bh, qemu_bh_delete);
>> > +    g_clear_pointer(&gl->async_fence_bh, qemu_bh_delete);
>> > +    g_clear_pointer(&gl->print_stats, timer_free);
>> > +    g_clear_pointer(&gl->fence_poll, timer_free);
>> > +
>>
>> Don't we need some ptr checks in virtio_gpu_gl_device_unrealize so a
>> reset followed by an unplug doesn't causes segs chasing now NULL
>> pointers?
>
> Good point, actually we should be safe, since render_state < RS_INITED.
>
> But those qemu_bh_delete().. can we make it safe to call with NULL?

That seems sane as it will be on the exit path. I wouldn't tolerate
NULL for any of the other qemu_bh functions though.

> timer_free() was fixed already.
>
>>
>>
>> >      return true;
>> >  }
>>
>> --
>> Alex Benn=C3=A9e
>> Virtualisation Tech Lead @ Linaro
>>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

