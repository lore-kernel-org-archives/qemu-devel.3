Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C708F4368A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDghR-0000NQ-6y; Fri, 17 Apr 2026 06:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wDghP-0000Mj-Ff
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:45:23 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1wDghN-0007j6-ME
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:45:23 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso5013335e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 03:45:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776422719; cv=none;
 d=google.com; s=arc-20240605;
 b=VGnURxvN784H8kdMgkeL4Ko0iL8jN46sGpcRyQylGPnRdiHVHOqVgVfZKlsHUBeJDD
 L8p9PxcdUX+A/GHfJVViPUlhamLaBAwUIpc87UTPfC9iO0621sRjsBYCOjpgAHZDmt+a
 Ts0ogNwRChNqJp22DtHNxXMYB9KfleoN95pWm/AQNdkCH5a+yGCvdYhVSsclKPohPaaT
 FTbmoCBDox8dKpLbu0nNuX+vq3yeV1o0dFDIkQKWGCcCsR3F9wfTGZGRbfZb7hTosECd
 8CLwP6tSvrUwzvzgXv47BnAdi5QxaH5LCQbhjnWnTzEyeE2E/NxZsFIoj5yoqpLzHj+o
 9R/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Yf0JSeCSQzCxz4BOh4B+UxqSMI3NRUZ8Y2ohqqgR3XY=;
 fh=IxRDZG8NwOSR+ModRna/15joIedqUObs31xrk2mqPV0=;
 b=AAEDX6PNTmPNG2i69NpkXuJz9TRovgP51I3Zosn2mkdvRmJ4IGmgFurSzQxBWuZ6we
 mcI8JpRmVTwIrYrmacQP4A2bqZdzKtKaQDLgbo6kBNPjrmN3nHwTDBYAf+7D4cq5Pjr7
 7c46PRUcPj6ZJSm8s09cW3iJHJiRfu9U+wdE5FaP8jMTOvfTOfJDkp80YJ/IoE/RTbA1
 Pm3t87LJ6UuQEtvu3gsjb1xFE6Z6MbN57F0y1VtYM0VpF3iCwm3Hs+SnMvaAGq1jD2kz
 NM6JPkbg9yrjGAJIAjN6OA+2/YQrqT4jvXbau1AmVltDFwCR3EsYh45wKawaGtAEaZjM
 advw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776422719; x=1777027519; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yf0JSeCSQzCxz4BOh4B+UxqSMI3NRUZ8Y2ohqqgR3XY=;
 b=SrE9Qc8SriUqwaxxWAMhg82nqJYFBMg5HVR8xicMM29wImMXR19jZH/m7KxoBqtkNI
 sBOpYgjw4Gv1ZpUb9NV18Ykd+jehVtKjxKNy8EoIglMtJcvFDh7CENLaQN7k12yW1oiG
 8cVv+1m4gzt1hRBtEazRcTmgoTJKp4vwjuWqw0V2ZRFPKnWx0VTzGpZBEL+6NsMxu4va
 lgT9Btnw2WVXGckKPrGHIaIY/tFfkPpenAKx6O2grD54kZQGJkF8qjm+VVMa27J5j+3m
 gyuXsIL1+F0uDrNnyd+6j+Kxu8dLu3xUnuZK2q5Gp1yWVj6guv/dAoVDR80MC1YjMQEK
 4R1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776422719; x=1777027519;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yf0JSeCSQzCxz4BOh4B+UxqSMI3NRUZ8Y2ohqqgR3XY=;
 b=DTbxJqe4tIHfr4y5qtxAy07HSoLGFf+c1rzBQ3ttmkgcF06hJ2qKywZssstgRnYoki
 f5hsu2pm/6b4t+q0thpHfQOZ0hza+HDOiHKFcRTycFqaDpmEEmAvI/nHsIXTY1pHT+YL
 8O5eJNCQX0I/7IwOz8RY0pwYL/N67WrRFeea8quBwwoauPClOH4jrJRXpJpEyhhiDNPq
 mP9X5HiHI1dlmV3tsm/NKRTd5jYqZ09o+1r5XPssyXwhoFFBeZICg1TyZWnxcoedKz6v
 cm2CriwbX0Zbepq8EpbYxUO4PSaxNRdxzRc0pkk/0l5V2U7XGZXoZ9wDHailoDlnOduB
 UekA==
X-Gm-Message-State: AOJu0YwLLJlcSSaQBrnKD6daJplRqewnU3cC5epJDL2j95Mwgh7WTuId
 XBUz2qiX7UZ4O8yQ2CkCZt9vC5B9G6BGyp5uzrQCLyN5YuOTPLva8Ob0fe7VCe2QCnXjKOv1PTn
 OxiUcjMqWjqriYH1sf4M8xRgjD/e5bwWajOK7Vv68qQ==
X-Gm-Gg: AeBDiesqjkL9NEQMZWI8PITvfJr1jiBPVd1+W6KzfTOMRWa7m4UAdq+NnlERpfAmnW9
 quy/1X2h9qG38t59LGDYNRVQFzcfw+99O87XAyG7sUI0qENKT5H41/N8zx0L9cLQzI7Yn86LbeV
 f9aTCQ5Lray9h7FRNsm5lownsQAl0wolQkuTc52UR5+ilMpUSXW2FJ0956aaFFBpvvjx+kljFP5
 aq9tySppL7t6A0YRxmnPmCvITgomvzwHvIfL9x77wfw4YYC5gnXfbNnKC1NPrGqBrVLqr0ZUE+9
 O+fQimcAd/5dPR/bXwc+kNKOXlrLsFgU6azIx+eN9ZVYMuyVRnOpaZy+mlmFOiw=
X-Received: by 2002:a05:600c:c082:b0:488:b043:5efd with SMTP id
 5b1f17b1804b1-488fb75f7a6mr25082335e9.13.1776422719207; Fri, 17 Apr 2026
 03:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260417094443.785462-1-alex.bennee@linaro.org>
In-Reply-To: <20260417094443.785462-1-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 17 Apr 2026 13:44:52 +0300
X-Gm-Features: AQROBzDBXmqNyAbsgRoTHa-RBKdXx8C4Gc2zLvKSycMWFoaVsnlaGQV7i0vJYfk
Message-ID: <CAAjaMXYTKf49g6tEyENcZyaNhJ9dWdxJznXMJag6k+tZ9Hmm3g@mail.gmail.com>
Subject: Re: [RFC PATCH] hw/display: don't accidentally autofree existing
 virgl resources
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
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

On Fri, Apr 17, 2026 at 12:44=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:
>
> While sanity checking a create blob operation the use of the auto
> freed res variable could lead to inadvertently freeing an existing
> blob.
>
> Avoid this by in-lining the virtio_gpu_virgl_find_resource() check as
> the value is not needed anyway.
>
> While at it add a comment to the end and use g_steal_pointer to make
> it clearer the object lifetime exceeds the function bounds if we pass
> all the checks.
>
> Fixes: 7c092f17cce (virtio-gpu: Handle resource blob commands)
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: qemu-stable@nongnu.org
> ---
>  hw/display/virtio-gpu-virgl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.=
c
> index b7a2d160ddd..add85bd4e61 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -830,8 +830,7 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU =
*g,
>          return;
>      }
>
> -    res =3D virtio_gpu_virgl_find_resource(g, cblob.resource_id);
> -    if (res) {
> +    if (virtio_gpu_virgl_find_resource(g, cblob.resource_id)) {
>          qemu_log_mask(LOG_GUEST_ERROR, "%s: resource already exists %d\n=
",
>                        __func__, cblob.resource_id);
>          cmd->error =3D VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID;
> @@ -884,8 +883,9 @@ static void virgl_cmd_resource_create_blob(VirtIOGPU =
*g,
>
>      res->base.dmabuf_fd =3D info.fd;
>
> +    /* Now live, cleaned up in virtio_gpu_virgl_resource_unref */
>      QTAILQ_INSERT_HEAD(&g->reslist, &res->base, next);
> -    res =3D NULL;
> +    g_steal_pointer(&res);
>  }
>
>  static void virgl_cmd_resource_map_blob(VirtIOGPU *g,
> --
> 2.47.3
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

