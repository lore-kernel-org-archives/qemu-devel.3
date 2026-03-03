Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75AEEC1436
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 12:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxOus-0006Fc-3r; Tue, 03 Mar 2026 07:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxOup-0006Ex-HW
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 07:31:55 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxOun-0006nZ-NT
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 07:31:55 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b934fdced05so742378666b.3
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 04:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772541112; x=1773145912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mUQMv8Vv4HFcCDlVSu8iSmC7igRdm8x9sp+swycE85k=;
 b=m5KS9fpps+Mg9J3tH+K32OVqill+Wq73Vj3aRU9CQlUMsEspO+5MWlhniYx9PHQ/aB
 EGXcPBx9ZDZDhkYp+Fml0pwfZS/6RkEsfcqidtDDcLhzuBNRrk+bdtQtymoAPh74pLMH
 4yrZO+3VAXIQA7JkQ45mmq1KBtz/fzi1l5wNwEo1W0thw3PljDzaw6/pGfa+VeXZhj0P
 adxRK+bH72smcrCFuIpQIOXw/Lf2XrZjvIJVCsdUfhWpzCuai75sUF1Oe5LoNhwreKJM
 k0dpvtHoncuwO/MIM3aB7U1xuXdG+cALaMojU/hcdGoSrjU8gkLJyisODCVP0nL/DenW
 +DJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772541112; x=1773145912;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mUQMv8Vv4HFcCDlVSu8iSmC7igRdm8x9sp+swycE85k=;
 b=Zj1sfxHN9hG6zniG826cfEKm7NIzxpx16qX/yHiBnDxb/6TFQMk/SNlEKNMOQkNiFq
 Fdx1ft27tplAdX6yJ+dy4u88eszSkONWIQ2yx6+jBpKGx3Y33WoDT6IRV4ZfVqD04rE5
 eOUjQw5gwPss1k4bOoYZ28glSxtzfJ070kwNyxzSw0lq6vSnNdYEGcu9+xfmQ26fx0bk
 aunKaxm31r0D71wA3P5rVisOe94yIeCMBkMbyCNPgzwNUA7x60B6mZajBx3/smqlyLk1
 +WaEELG361QzpZPFDQrJMBykIJtgPq/pp+yzmcLtxem1W4fpYThrMvzLxxd4IHH138Jn
 9cAw==
X-Gm-Message-State: AOJu0YweEgfwiaHzujThlxLaKtehGF7RXjV5QrLm75r1jiHTIUBvx95B
 AXE0yu5aYJ3EEhilm16f8zJzl9cbTTYhucJXazzfNXd2Cul5KESNrdozgYU15I1bH6k=
X-Gm-Gg: ATEYQzz7awBw3MuzL2NsVtTQF93pm3nCTJh3mG2vxLkFjMrVJ6DhTKkHAaNHTy4Qa8Z
 lYnPs3T+qDEc9M4sByd0sJbO0QNhfMY3QByJGwNDOxkeX6dZB4voQ4CIhtAuhWp9wKi+voP0HSH
 uuLrqdddS4ezugfkhkSlcsZ1Bmmt06miNju3QV1cQVbYEAmfbkD2+F64WarzETbdQw1aTyPQRPd
 AkFJQLiWchqEn+locwBpp4DVSCxS3FcFMOAhqiddx5pg02fXwO2y12a8lcbktRVFz3v9dzNCHTQ
 kNr47mgNhf+GyNLgomiw54jvHHMg0swBSk4T0XilvnW6dIcLH4vTb9K2rgeg33fQtYli78mhDtH
 67aNUIvEvBiavJFOX4SaYkpQoGfIy3ElqkEabhrrrEBzrWGKolQXaMNi8uLcBuV0xwC51bi1VT3
 NNSNj0pLIAyeMe1lke3WDsP+A=
X-Received: by 2002:a17:906:99c2:b0:b8f:7c0a:f942 with SMTP id
 a640c23a62f3a-b93763cbec0mr1057593766b.25.1772541111632; 
 Tue, 03 Mar 2026 04:31:51 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935ab137a1sm595790366b.2.2026.03.03.04.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 04:31:50 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E91A65F811;
 Tue, 03 Mar 2026 12:31:49 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,  Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio-gpu: Do not wait for the main thread during reset
In-Reply-To: <20251029-gpu-v1-1-e3e3c7eebc9e@rsg.ci.i.u-tokyo.ac.jp> (Akihiko
 Odaki's message of "Wed, 29 Oct 2025 12:14:02 +0900")
References: <20251029-gpu-v1-1-e3e3c7eebc9e@rsg.ci.i.u-tokyo.ac.jp>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Tue, 03 Mar 2026 12:31:49 +0000
Message-ID: <87pl5laybu.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:

> virtio-gpu waits for the main thread to destroy resources and replace
> surfaces, but it occasionally results in deadlock, so remove the code
> to wait.
>
> In particular, when running a test case[1] the main thread may wait for
> the vCPUs to pause during shut down while a vCPU may be concurrently
> resetting virtio-gpu.
>
> vCPU actually does not need to perform resource destruction and surface
> replacement synchronously, but it only needs to ensure correct ordering
> among virtio-gpu operations. virtio-gpu-gl already exploits this fact to
> ensure that virglrenderer is reset on the main thread; instead of
> synchronously resetting virglrenderer when the device is being reset,
> it resets virglrenderer just before processing the first command after
> the device reset arrives.
>
> Take advantage of this fact by simply removing synchronization between
> the main thread and the resetting vCPU thread. The request to destroy
> resources and replace surfaces is scheduled earlier than any virtio-gpu
> command that may be queued after resetting ensures correct ordering, so
> we do not need to make additional effort to ensure ordering.
>
> [1]
> https://lore.kernel.org/qemu-devel/20251014111234.3190346-9-alex.bennee@l=
inaro.org/

This doesn't seem to make any difference for me with the current state
of the tree.

>
> Fixes: a41e2d97f92b ("virtio-gpu: reset gfx resources in main thread")
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  include/hw/virtio/virtio-gpu.h | 2 --
>  hw/display/virtio-gpu.c        | 9 ---------
>  2 files changed, 11 deletions(-)
>
> diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gp=
u.h
> index 9f16f89a36d2..77d2214238df 100644
> --- a/include/hw/virtio/virtio-gpu.h
> +++ b/include/hw/virtio/virtio-gpu.h
> @@ -193,8 +193,6 @@ struct VirtIOGPU {
>      QEMUBH *ctrl_bh;
>      QEMUBH *cursor_bh;
>      QEMUBH *reset_bh;
> -    QemuCond reset_cond;
> -    bool reset_finished;
>=20=20
>      QTAILQ_HEAD(, virtio_gpu_simple_resource) reslist;
>      QTAILQ_HEAD(, virtio_gpu_ctrl_command) cmdq;
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 3a555125be60..1294e1d482ed 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1522,7 +1522,6 @@ void virtio_gpu_device_realize(DeviceState *qdev, E=
rror **errp)
>      g->ctrl_bh =3D virtio_bh_new_guarded(qdev, virtio_gpu_ctrl_bh, g);
>      g->cursor_bh =3D virtio_bh_new_guarded(qdev, virtio_gpu_cursor_bh, g=
);
>      g->reset_bh =3D qemu_bh_new(virtio_gpu_reset_bh, g);
> -    qemu_cond_init(&g->reset_cond);
>      QTAILQ_INIT(&g->reslist);
>      QTAILQ_INIT(&g->cmdq);
>      QTAILQ_INIT(&g->fenceq);
> @@ -1535,7 +1534,6 @@ static void virtio_gpu_device_unrealize(DeviceState=
 *qdev)
>      g_clear_pointer(&g->ctrl_bh, qemu_bh_delete);
>      g_clear_pointer(&g->cursor_bh, qemu_bh_delete);
>      g_clear_pointer(&g->reset_bh, qemu_bh_delete);
> -    qemu_cond_destroy(&g->reset_cond);
>      virtio_gpu_base_device_unrealize(qdev);
>  }
>=20=20
> @@ -1565,9 +1563,6 @@ static void virtio_gpu_reset_bh(void *opaque)
>      for (i =3D 0; i < g->parent_obj.conf.max_outputs; i++) {
>          dpy_gfx_replace_surface(g->parent_obj.scanout[i].con, NULL);
>      }
> -
> -    g->reset_finished =3D true;
> -    qemu_cond_signal(&g->reset_cond);
>  }
>=20=20
>  void virtio_gpu_reset(VirtIODevice *vdev)
> @@ -1576,11 +1571,7 @@ void virtio_gpu_reset(VirtIODevice *vdev)
>      struct virtio_gpu_ctrl_command *cmd;
>=20=20
>      if (qemu_in_vcpu_thread()) {
> -        g->reset_finished =3D false;
>          qemu_bh_schedule(g->reset_bh);
> -        while (!g->reset_finished) {
> -            qemu_cond_wait_bql(&g->reset_cond);
> -        }
>      } else {
>          aio_bh_call(g->reset_bh);
>      }
>
> ---
> base-commit: 36076d24f04ea9dc3357c0fbe7bb14917375819c
> change-id: 20251029-gpu-c3f45747f7ba
>
> Best regards,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

