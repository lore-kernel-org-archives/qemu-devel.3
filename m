Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E870C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we7FH-00044e-4c; Mon, 29 Jun 2026 04:21:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1we7FF-00044V-OD
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 04:21:33 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1we7FD-00017f-Vh
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 04:21:33 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4703bc0a99aso863046f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 01:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782721290; x=1783326090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LcwiTare4cCPuoxtrI2Yv3936j8iiv+q+apxHxfxjy8=;
 b=LmHPbC1iVDbjLXZZ9qhoxhz4GH1actu3znosAX/JVmXj/CRLZAuGegMObki8k7kTy6
 YV1uKK2tEpNo1xXOZ5mMrGXZ3Zhanvm5V8nHfORcKWwPP4vOKBQZY0s6Cw/De/OIxCHp
 IlnDVg3xrjo4+F2uClPWWsup0VCBr1UoSTWXxeCmzjkWJfBC739mBPAckWvKXbiRvMWk
 CPJeOJ6cue5Ca6IpF4GWawkCZ5kQ4dbIcaZSIAw+zYEnzXlWSjFI4QlfidRRWehSUozU
 ZJ47iVtpcwtZJWg2uN/7xVg7ANE8EZAfuBqJJ10FZkd47zBHWBDLD0xhBu56ImB1zgd5
 B4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782721290; x=1783326090;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LcwiTare4cCPuoxtrI2Yv3936j8iiv+q+apxHxfxjy8=;
 b=g2d+IYTpydPuOCfSAVf66KrYY0zEqmOPC4xm+wnasW3OV6libHWlnMKCMczizZtIJn
 tXccmoUnnl7RGgY2XEzctq3QCKJRkVFP/Oj1+A+4vHWVfN4gMKsk5il937MGMEdYXIcv
 oyhW4TTkltDWTPqDx/pqnx2DrdyAjsrISbYVy0HGBFEk//562X7fsoM6whoKdCeeUJdy
 WgVS4kdv3tdklFtdGn/sX5GyuEUNP2oQu0gcUXVeCFJsno6LH5v8nUL9RjcEDa5XhimP
 nHxKhrJbJfCP50oHyT37SXgizLYTEtvaT3CrdN3qcYmZog9S3GcxC0iXpo88NiGT/UEa
 e62g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrcbkSdeSV0sOwjruGe746YcAldhXvgLO0ZsMv03WtatiHxXMqZSCbrxD8J9V3m6ZcIsm07qnnFNjxz@nongnu.org
X-Gm-Message-State: AOJu0Yxar7SDBo1gK1XDAzgSrfLXl5+wLF4Dv1h9ad768lrhaOZ6jajy
 FtzoMR7sm+IafmH/1/YWTdSYMAZgXtfag9sSVl4DvbQxd0rhwoqtkRjeNixzwD++wHs=
X-Gm-Gg: AfdE7cnuoJ6aXwmvIzXl46vDdvPSjN65p4wGQedFBvTIONNxfPjNGijYycMH+h9tWya
 fbEqqKykwUUp6ViLPXt+nS9q0HSZjQoNX4vJRL10LCniMpSarMctbfO3rE6Coi+qaHCWUv2DTn6
 hnZrwbE5IJltv5gmWY67OeRfWJrzOmP+4GBPcUBskaSHcQvdq/zzMlLvgaj5VooaJweOM89duXc
 72YjKbGvhsLkuV8jOIhfcw3GMNvhtXEC/Dmn4JXHj1753YWP1AK+4TDcMnrO7wWS2uiLM8oTA3G
 AX7k7pOK7CEXFyjtMYbm6xyEGWaN+AKvUhEBr9td8be4Wnydo/vQxLWAMdPXluFITfcCpWMHRA5
 t+hHI7zMENgjE+wp/EG8KBib4Qv07uPq3YkHBl+wN5oKKkwKJcCzYfw50gW64pWqjmQ5RYQ5yyi
 hfyDSJw7zFDPeHdamDscv1xkW0VRhXK1Xn88f+w0RL8xWQqvbNdZxQTsulp4G+BylvVjRSltOtF
 iPqeJfOCt4jSD8scbzuccqHEb5sSMNrAnCqsVHIx9oisMwzUj6mCjrSqt+lgrj4yfnUsiLerHEF
 aPOOynOhhA8DnT3g/lhUdcs=
X-Received: by 2002:a5d:5e09:0:b0:46d:d6b2:3957 with SMTP id
 ffacd0b85a97d-46dd6b239c0mr25747832f8f.44.1782721289938; 
 Mon, 29 Jun 2026 01:21:29 -0700 (PDT)
Received: from meli-email.org (ppp-2-86-131-154.home.otenet.gr. [2.86.131.154])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473563c2df7sm9535630f8f.24.2026.06.29.01.21.29
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jun 2026 01:21:29 -0700 (PDT)
Date: Mon, 29 Jun 2026 11:19:29 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>, qemu-devel@nongnu.org
Cc: Volker R=?UTF-8?B?w7xtZWxpbg==?= <vr_qemu@t-online.de>,
 Marc-Andr=?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 St=?UTF-8?B?w6lwaGFuZQ==?= Graber <stgraber@stgraber.org>,
 "Daniel P . Berrang=?UTF-8?B?w6k=?=" <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v3 6/9] hw/audio/virtio-sound: introduce
 virtio_snd_pcm_open()
User-Agent: meli/0.8.13
References: <20260626123531.132078-1-alexander@mihalicyn.com>
 <20260626123531.132078-7-alexander@mihalicyn.com>
In-Reply-To: <20260626123531.132078-7-alexander@mihalicyn.com>
Message-ID: <thdwjs.1aoa9zq3o642f@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x436.google.com
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

On Fri, 26 Jun 2026 15:35, Alexander Mikhalitsyn <alexander@mihalicyn.com> wrote:
>From: Volker Rümelin <vr_qemu@t-online.de>
>
>Split out the function virtio_snd_pcm_open() from
>virtio_snd_pcm_prepare(). A later patch also needs
>the new function. There is no functional change.
>
>Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
>[AM: trivial rebase changes]
>Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
>Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

> hw/audio/virtio-snd.c | 60 ++++++++++++++++++++++++-------------------
> 1 file changed, 33 insertions(+), 27 deletions(-)
>
>diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
>index 68d737478f5..d5242a5c761 100644
>--- a/hw/audio/virtio-snd.c
>+++ b/hw/audio/virtio-snd.c
>@@ -429,6 +429,38 @@ static void virtio_snd_get_qemu_audsettings(audsettings *as,
>     as->big_endian = false; /* Conforming to VIRTIO 1.0: always little endian. */
> }
> 
>+/*
>+ * Open a stream.
>+ *
>+ * @stream: VirtIOSoundPCMStream *stream
>+ */
>+static void virtio_snd_pcm_open(VirtIOSoundPCMStream *stream)
>+{
>+    virtio_snd_get_qemu_audsettings(&stream->as, &stream->params);
>+    stream->positions[0] = VIRTIO_SND_CHMAP_FL;
>+    stream->positions[1] = VIRTIO_SND_CHMAP_FR;
>+
>+    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
>+        stream->voice.out = audio_be_open_out(stream->s->audio_be,
>+                                         stream->voice.out,
>+                                         "virtio-sound.out",
>+                                         stream,
>+                                         virtio_snd_pcm_out_cb,
>+                                         &stream->as);
>+        audio_be_set_volume_out_lr(stream->s->audio_be,
>+                                   stream->voice.out, 0, 255, 255);
>+    } else {
>+        stream->voice.in = audio_be_open_in(stream->s->audio_be,
>+                                        stream->voice.in,
>+                                        "virtio-sound.in",
>+                                        stream,
>+                                        virtio_snd_pcm_in_cb,
>+                                        &stream->as);
>+        audio_be_set_volume_in_lr(stream->s->audio_be,
>+                                  stream->voice.in, 0, 255, 255);
>+    }
>+}
>+
> /*
>  * Close a stream and free all its resources.
>  *
>@@ -454,8 +486,6 @@ static void virtio_snd_pcm_close(VirtIOSoundPCMStream *stream)
>  */
> static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
> {
>-    audsettings as;
>-    virtio_snd_pcm_set_params *params;
>     VirtIOSoundPCMStream *stream;
> 
>     stream = virtio_snd_pcm_get_stream(s, stream_id);
>@@ -472,31 +502,7 @@ static uint32_t virtio_snd_pcm_prepare(VirtIOSound *s, uint32_t stream_id)
>         return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>     }
> 
>-    params = virtio_snd_pcm_get_params(s, stream_id);
>-
>-    virtio_snd_get_qemu_audsettings(&as, params);
>-
>-    stream->positions[0] = VIRTIO_SND_CHMAP_FL;
>-    stream->positions[1] = VIRTIO_SND_CHMAP_FR;
>-    stream->as = as;
>-
>-    if (stream->info.direction == VIRTIO_SND_D_OUTPUT) {
>-        stream->voice.out = audio_be_open_out(s->audio_be,
>-                                         stream->voice.out,
>-                                         "virtio-sound.out",
>-                                         stream,
>-                                         virtio_snd_pcm_out_cb,
>-                                         &as);
>-        audio_be_set_volume_out_lr(s->audio_be, stream->voice.out, 0, 255, 255);
>-    } else {
>-        stream->voice.in = audio_be_open_in(s->audio_be,
>-                                        stream->voice.in,
>-                                        "virtio-sound.in",
>-                                        stream,
>-                                        virtio_snd_pcm_in_cb,
>-                                        &as);
>-        audio_be_set_volume_in_lr(s->audio_be, stream->voice.in, 0, 255, 255);
>-    }
>+    virtio_snd_pcm_open(stream);
> 
>     stream->state = VSND_PCMSTREAM_STATE_PREPARED;
> 
>-- 
>2.47.3
>

