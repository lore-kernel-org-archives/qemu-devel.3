Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0A7CCFA1A
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Nov 2025 07:44:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHdcJ-00027j-52; Sat, 08 Nov 2025 02:44:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>) id 1vHdcH-00027I-Al
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 02:44:09 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zzyiwei@gmail.com>) id 1vHdcF-0003EA-Pv
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 02:44:09 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b403bb7843eso268736566b.3
 for <qemu-devel@nongnu.org>; Fri, 07 Nov 2025 23:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762587845; x=1763192645; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j9O8GlRehhbzVWE0PurorkwTSk3ZqFUUwWBAHoY6NqQ=;
 b=Eu9WXv/Co+nyBWmMC7zKj+k6/EWcxlT9JF/qTCE0sib0p0mIHEuzK+uNgeXij0OA8X
 +Wr8IQfIjaOYFRYghJmmpZDP83dB4zSewR0dhmDLYbPRdHL1Ysbjp0XzRW9p+Zysi9Bq
 oPLRUslBkdSNXTNefzWtNK7CMcaAT5Z4CActxpxgxTqp+mA0h/c7zY2mGP2cWJv+NALJ
 Dn5fBzx/3FINdhIwzXuffSKylUD7eOJJntjLPZExdozxDD7ME9Qk2ZfJ7HupF4olnwCM
 12vTkU4hVoANpoLgXij6CO23Z7APpakWIMcwTPzXiMtPpBt/AU8G16rvtq/2EufiNpA1
 zVJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762587845; x=1763192645;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j9O8GlRehhbzVWE0PurorkwTSk3ZqFUUwWBAHoY6NqQ=;
 b=DwJjZAMjMqS7r98RIPvdqo/MoaX7ostB5JG7zOAq2PHbD6n9sok2d20ASdAzNFAik0
 YFpSrFyfHzGXPaV4lbX9kr3JPjZaelOvpWOJx4bOJZO58ztE6av6yYxWhJ19NfuPpC8G
 S5zRLZ++BAbAQOV68RNDZ1ap7iJNbhLooAxACqdcL751zV3yoky54Wp4S1ux+LK4Uw0U
 +wJ3uHDrpZH4UKFK6uC0SPOuuXRAFbIXa90ADTKYpe1rBL4wYjxZqFdT6DmWddHMam4G
 C6mNsrr+AeL0slgPclReE9ZDlN4rk0rKxeBeWShTIGzAb1ITJt1J+ze0oSE0gY/HsS2c
 LZug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqJIrmQaw+RrBE2cG4xr9avqHzq8TnWZXpRd1zH0DxZaySULww8/NjI56TjRFmhnYkfkxCjdhyTpyE@nongnu.org
X-Gm-Message-State: AOJu0Yzr7Df3FLoMs0uV1sK43jJGEPtCcnqgsRF1YZZERUpo+w0GU/nz
 aAPNC0kIrPDgTxPMc7QIo7u798FYqpTlSVA5cx7z95LF4NmKv3Wbx9nZyWBPKh+NAH0+KKIxWrc
 c5tXcevbpAs6xYyWkurdx+ICnHFgO2Zk=
X-Gm-Gg: ASbGncv6wVEAx7TUYOOaRXdtcfjHzOOM7R35Ps3bPDcMQrFkmdm2bcTXQA3aqd0CJkl
 WJbPG+aEbyg8KdXOetTmkHzUyAmAXrqO80k+/aU50vRjD8ZO6cxcjAd8+gBOgegrx6IussR37tv
 rS8I3izlHbZ93mNa08AJpL3R/f5CHAnpy8kiql6fqfvewr7fuT7elAKgS4BY5kCH4uwM0M0DxKU
 Jr1qI5L1WqbkGH5nbdhlxiWbp91YvprAhy0t/EKXZRjTmxaLDv7qVScrFPb1W2Vsdl2PQ==
X-Google-Smtp-Source: AGHT+IHaIJgANmaZFjDysDsMC95FTwcNdU3BjAk8pNHaY4Wzd/1N+fBAu5q0s1HhD5/VCBk7HS/TfGUn0IIWVV5EzgI=
X-Received: by 2002:a17:907:7e91:b0:b6d:9576:3890 with SMTP id
 a640c23a62f3a-b72e04ca2a7mr181081866b.45.1762587845342; Fri, 07 Nov 2025
 23:44:05 -0800 (PST)
MIME-Version: 1.0
References: <20251020233949.506088-1-dmitry.osipenko@collabora.com>
 <20251020233949.506088-4-dmitry.osipenko@collabora.com>
In-Reply-To: <20251020233949.506088-4-dmitry.osipenko@collabora.com>
From: Yiwei Zhang <zzyiwei@gmail.com>
Date: Fri, 7 Nov 2025 23:44:10 -0800
X-Gm-Features: AWmQ_bk-YPjkzGevPx2bW2Xa_mREm0xEW2unLPSnLriHWIfLR6cUNCml-0_L6YQ
Message-ID: <CAJ+hS_jowk1yiCbnkXmuGNBdQ2_M4O5bYwPV+YCS0nzednaqAg@mail.gmail.com>
Subject: Re: [PATCH v14 03/10] virtio-gpu: Handle virgl fence creation errors
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Gert Wollny <gert.wollny@collabora.com>,
 qemu-devel@nongnu.org, 
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>, 
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, 
 Julia Zhang <julia.zhang@amd.com>, Chen Jiqian <Jiqian.Chen@amd.com>, 
 Rob Clark <robdclark@gmail.com>, Sergio Lopez Pascual <slp@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=zzyiwei@gmail.com; helo=mail-ej1-x62a.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Oct 20, 2025 at 4:42=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Print out error messages when virgl fence creation fails to aid debugging
> of the fence-related bugs.
>
> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  hw/display/virtio-gpu-virgl.c | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index 94ddc01f91c6..cd8b367f6fa6 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -872,6 +872,7 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>                                        struct virtio_gpu_ctrl_command *cm=
d)
>  {
>      bool cmd_suspended =3D false;
> +    int ret;
>
>      VIRTIO_GPU_FILL_CMD(cmd->cmd_hdr);
>
> @@ -972,14 +973,30 @@ void virtio_gpu_virgl_process_cmd(VirtIOGPU *g,
>      trace_virtio_gpu_fence_ctrl(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type=
);
>  #if VIRGL_VERSION_MAJOR >=3D 1
>      if (cmd->cmd_hdr.flags & VIRTIO_GPU_FLAG_INFO_RING_IDX) {
> -        virgl_renderer_context_create_fence(cmd->cmd_hdr.ctx_id,
> -                                            VIRGL_RENDERER_FENCE_FLAG_ME=
RGEABLE,
> -                                            cmd->cmd_hdr.ring_idx,
> -                                            cmd->cmd_hdr.fence_id);
> +        uint32_t flags =3D VIRGL_RENDERER_FENCE_FLAG_MERGEABLE;

nit: add const qualifier

> +
> +        ret =3D virgl_renderer_context_create_fence(cmd->cmd_hdr.ctx_id,=
 flags,
> +                                                  cmd->cmd_hdr.ring_idx,
> +                                                  cmd->cmd_hdr.fence_id)=
;
> +        if (ret) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: virgl_renderer_context_create_fence error=
: %s",
> +                          __func__, strerror(-ret));
> +        }
>          return;
>      }
>  #endif
> -    virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, cmd->cmd_hdr.type=
);
> +
> +    /*
> +     * Unlike other virglrenderer functions, this one returns a positive
> +     * error code.
> +     */
> +    ret =3D virgl_renderer_create_fence(cmd->cmd_hdr.fence_id, 0);
> +    if (ret) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: virgl_renderer_create_fence error: %s",
> +                      __func__, strerror(ret));
> +    }
>  }
>
>  static void virgl_write_fence(void *opaque, uint32_t fence)
> --
> 2.51.0
>

With the nit resolved, Reviewed-by: Yiwei Zhang <zzyiwei@gmail.com>

