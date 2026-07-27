Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FB3C531FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woFWE-0005i2-MU; Mon, 27 Jul 2026 03:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1woFWC-0005hd-4m
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:12:56 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1woFWA-0004mn-JX
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:12:55 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38dd55ad76cso2189713a91.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 00:12:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785136373; cv=none;
 d=google.com; s=arc-20260327;
 b=GH9iYfnD6CmWTPoBYjiLfJTbriSfnN3I5bJJzMLPszN86UW5szWpUJK6icAFlqA/th
 /FYcaW1cWmiEXB9zvRQ7sC+9qTF/eGvh58IYpGn5N5DPohfgijNEdkcZyj3nswQNRqfw
 +Dp27k28ggpomcRfbyzZ9eSYU8dDPayTHmULdLNKckkmCq2omtJZu3L6QzYg960AMWJ5
 NsloCUdhZbJVV9yKt0faW28OgpZ/eisJ8xA7A4LAWyRgBvx1WZehRpACQLyYV2fbr8yc
 vspEveE+XoCv4rfW9j7+7vl0/EZj6ZkJ1Rw/jQZh2FNbWAQdUpLzE8xtmu6ASpcKhufq
 ZBtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1Vxm1zARiEr0oajkp8vZOzT8zXhQUhyQg37lB6aBmRA=;
 fh=KnxVq+/dNMGR5XtbHr3cm7WMCtMcRbEU6z8PkW8LG2I=;
 b=lKJSvbyaUoCgT5+On6Jl46uA+ViyKzTgf19ZY0jAXKRxOTcCd0ncyB/TmpE9RCFt0q
 FKHtLWyS+z6xDOYta+RQTTfOCf2BPAif9euGHkCHbCMSVXXSLaf/sPAXB+IsQOI21IiP
 Yk2z+JBpx49qkdt4GDO1gPtxutYmZIaeQBxiXS5/T75T1a0pD3IWJLDXQRlYPiXbApNG
 IIfy1A4RCApmIuSmfE88j7pqBFuUtuV9mqZZ7SSrMOq+3rB3rmM/7x6CzfucAcVFGvWv
 6Nws18PuwaQQ6/8U3IlMzzgkXkMLNuwm7bNeQle6MxMw4nC6h3KLccCHi0Z+JnsWqJkU
 GoKg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785136373; x=1785741173; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1Vxm1zARiEr0oajkp8vZOzT8zXhQUhyQg37lB6aBmRA=;
 b=eQD4aZoSb5ynnLmsNcj04BapvgeW6UqolsiMjphiatTymt0NvYKHwK4UwwPqfowdR7
 Eke7elGSB++nkKTVs/WiIenv8wZ/NnlKm6C47btl/HFNmYu1NiFABNm4n4RZbMaP1srg
 4Mj82O3hw5CTKhzfiBgn1VkNqh6frjhm3LyvZ4dELH9esAzat/KQY5Zgc6GBdg9B45/a
 NAfNTZjtp1ZpaBloPFIvBP7vPXWSCclSBeVEfsa1u3SpgPm3Ls4iUWF0vJYVePagV6mj
 Tbwg8828FgmsXdZHN4cFgeCDEEqwf1QMLFM6/fUdVD2qQ336iiFRWrToi0Wtim2r/9t5
 fe4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785136373; x=1785741173;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1Vxm1zARiEr0oajkp8vZOzT8zXhQUhyQg37lB6aBmRA=;
 b=SYkafU38gXzi6w0THvZcJlKg7YTT7/Ke+dICZdty8eccFRc3BnK2dKCbOgdP2k71CW
 tTi7S5ooHqgygnFMbIXoHOQiAv+3IjMJGbsOpVO8r1+r5IvgTYdCsCTKUM9PnijYcdHn
 wfuSggcLMvCdUpe7ublHNovlZIdWkCUxYuweD8M8mgdZQFziMhyBMDOvcA3Rt7tSGnQa
 oZt1jvzurPu2oR042WslhjyEB/DB92CqSdvWv+8SX20H8PjcPRh6PxxXakTJnZacUBww
 bKGhmZsc/oXYrCAMXViWw6PKBrEpzxIvcdEX1fP3Vi+fW2v9U6eYDXhpRHYzr8zpZZIR
 DBlQ==
X-Gm-Message-State: AOJu0YwDXqb/Q1zMWW9W6KoityXICKs5uErsDSZ0RqPTnFHGl1TrClte
 vyY4NPV1zz/0uWd+if1UdQke3rnxLG/R8DOd5oqnC0zcMZdDV3Jed/P4g4gRuR+H+HHpwFfow1k
 FBsjJSmX1KzPwJbewg1NHCtCRs4kvWsg=
X-Gm-Gg: AR+sD10cPlMgsXlAeeocH06oLWGW5SA2CXqfTem3dreZdP17u8/ryU5L4ivYVZGVbeb
 I8Rd45lF8xg7pTxcsYsN9uulvp97LNbWvJwGRD4XvYgs95+NuDXkx4Zib2J91I33OLYifC6WPQ2
 WmGghYc+fpdLHCTD+PlyUloHxoQtcSNhRMzfRFbmaTUEBSThy3JRunJgLSAVYscHXscZaslL9fN
 42GoJi0z+RWTxvGgjsR84BC1PtILsn3azrWXvOx0F6Q9bslTycyp8jw9IFTdSiovovoKOVU3DrH
 MIdyY8p+Ln0XoN1rXA==
X-Received: by 2002:a17:90b:58c3:b0:38e:c1ba:4f94 with SMTP id
 98e67ed59e1d1-38f1ea5f8efmr9579017a91.2.1785136372942; Mon, 27 Jul 2026
 00:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260725-virgl-v1-1-58bb51e60da5@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260725-virgl-v1-1-58bb51e60da5@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 27 Jul 2026 11:12:40 +0400
X-Gm-Features: AUfX_mw5GuyPLRUMs0xiWhA5ckD_Cst2yP42HC3RVQ71GeGLQfI2uIpBoQVbiKQ
Message-ID: <CAJ+F1CL9YGQu2MhgFeJFOfFb2-GkfgYdWx2QB0c3VQjHwXK3rg@mail.gmail.com>
Subject: Re: [PATCH] hw/display/virtio-gpu: Avoid leaking migration blocker
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x102f.google.com
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

On Sat, Jul 25, 2026 at 11:15=E2=80=AFAM Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> virtio_gpu_base_device_realize() leaks a migration blocker if a
> check of the output list fails after adding one. Perform the check
> before adding a migration blocker to avoid the leak. This also
> simplifies the code by merging two loops.
>
> Fixes: d3a4969dc5ac ("Support per-head resolutions with virtio-gpu")
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  hw/display/virtio-gpu-base.c | 37 ++++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
>
> diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
> index a68b18482956..946e56b42f61 100644
> --- a/hw/display/virtio-gpu-base.c
> +++ b/hw/display/virtio-gpu-base.c
> @@ -195,6 +195,11 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
>          return false;
>      }
>
> +    g->enabled_output_bitmask =3D 1;
> +
> +    g->req_state[0].width =3D g->conf.xres;
> +    g->req_state[0].height =3D g->conf.yres;
> +
>      for (output_idx =3D 0, node =3D g->conf.outputs;
>           node; output_idx++, node =3D node->next) {
>          if (output_idx =3D=3D g->conf.max_outputs) {
> @@ -207,6 +212,17 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
>                         node->value->name, EDID_NAME_MAX_LENGTH);
>              return false;
>          }
> +        if (node->value->has_xres !=3D node->value->has_yres) {
> +            error_setg(errp,
> +                       "must set both outputs[%zd].xres and outputs[%zd]=
.yres",
> +                       output_idx, output_idx);
> +            return false;
> +        }
> +        if (node->value->has_xres && node->value->has_yres) {
> +            g->enabled_output_bitmask |=3D (1 << output_idx);
> +            g->req_state[output_idx].width =3D node->value->xres;
> +            g->req_state[output_idx].height =3D node->value->yres;
> +        }
>      }
>
>      if (virtio_gpu_virgl_enabled(g->conf)) {
> @@ -229,27 +245,6 @@ virtio_gpu_base_device_realize(DeviceState *qdev,
>          virtio_add_queue(vdev, 16, cursor_cb);
>      }
>
> -    g->enabled_output_bitmask =3D 1;
> -
> -    g->req_state[0].width =3D g->conf.xres;
> -    g->req_state[0].height =3D g->conf.yres;
> -
> -    for (output_idx =3D 0, node =3D g->conf.outputs;
> -         node && output_idx < g->conf.max_outputs;
> -         output_idx++, node =3D node->next) {
> -        if (node->value->has_xres !=3D node->value->has_yres) {
> -            error_setg(errp,
> -                       "must set both outputs[%zd].xres and outputs[%zd]=
.yres",
> -                       output_idx, output_idx);
> -            return false;
> -        }
> -        if (node->value->has_xres && node->value->has_yres) {
> -            g->enabled_output_bitmask |=3D (1 << output_idx);
> -            g->req_state[output_idx].width =3D node->value->xres;
> -            g->req_state[output_idx].height =3D node->value->yres;
> -        }
> -    }
> -
>      g->hw_ops =3D &virtio_gpu_ops;
>      for (i =3D 0; i < g->conf.max_outputs; i++) {
>          g->scanout[i].con =3D
>
> ---
> base-commit: 006a22cb26998998385b104db1ff9466ef2f3153
> change-id: 20260725-virgl-065c44b7bd4f
>
> Best regards,
> --
> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>
>


--=20
Marc-Andr=C3=A9 Lureau

