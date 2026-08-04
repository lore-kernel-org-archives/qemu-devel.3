Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B2DEC55822
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 19:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrKUZ-0004Cy-IY; Tue, 04 Aug 2026 15:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wrKUY-0004Cf-JC
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 15:07:58 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wrKUW-0002SQ-U9
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 15:07:58 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c9e30214d8fso101858a12.3
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 12:07:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785870475; cv=none;
 d=google.com; s=arc-20260327;
 b=josm0hums7vv8fSqjn+xyYHP8mF0DpdamTc51BWIBKn2UPdYKygUDSZ5QnXESMJ/dI
 hAQkXGQK87YszrCpMot8A7A5s6WZTX3JEf0r/98x3srDlXRbWU2C7OBFiUd6XPxyqI4f
 OjHnsu2HUuHvybjq/+Et/QdBRxNdgZdeAbEEDczw9oG/PruvnTEe434GrMp23x3V+jEz
 EfS52NxDgeHAZvZiqiGCST/oDzbW9LGBRDi0fiUZ1S1ondkb5xFh0UJGu4haHEUVYzyH
 W4Q1nvlvQxKje3/UNo4EVpKb/geZVhFINCyETKY1bdmbozdYkbmFGtD4HCrpGKVlJ6gV
 /iLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pP8i8NYB09c7tS03hr3DsHvzmnNn59UsH3jnOmwLlmo=;
 fh=kaw2L4sHZvDPseqVdaN6Q7uejyTgUs0egLM0FoE7CYs=;
 b=oGvz7GQxSh7YXJLK25XfqsivEbtRCmlEGEDSQtLvn+V1/dq7sbsfKJzL8h5N7mFQT4
 DecPmABuvhu/zP6HfkUWCemosugEWcthgu/hBtbm4ewoWLoN8x1/YN27D4WfuwU/0Ccq
 pPw5wxzm1bRse5Bl/3vjDHBZR0Tt0YAHtVKmyNdv7Wonci5TI+y1X7TldhLQpaZiKCR8
 ayFE0sW71PCy4Fw5+orgsmsB4exuNoFaJgZYbVfGUoD59kHIYe1qqFWk0moGExkbJg77
 DQM5I+ralrBBu5lr7stcB6mP9PZUxWrxfZI8saMjeuUzvxxnXqo6jP8mbkCPqqQqDXhm
 cvbw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785870475; x=1786475275; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pP8i8NYB09c7tS03hr3DsHvzmnNn59UsH3jnOmwLlmo=;
 b=dywv+Z1GhOUvtYosiO7XazEqi4JvL3HMXivY8s9ydlB30SOS5SSOM+zjSNMIHU5HHD
 6mmsozTCBp22q57tEaK0dP5SjjxdpAj4Jai1pWrDN9owEDWgzAmppI5oNFpirFnJyEeX
 LE4yU4PoOlKMCu8Fiz9ubM6yU/Uw2sVs2B5fwvIRlSmAqWhZPfIj7vyCAL398uCqZ1pX
 cGoB2kveI+2dlrzTEyp3rG64p2lHc1RiAvOog4HxjmeA4xoHBjjZkh1gw9bp6Y1MVHTt
 0+AZbqofJm3PY5Dz/II8xvfoES9de78wyO2iF31K4OxTc/Jd0ru0/EMWKVdQbYk6HqMK
 +UXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785870475; x=1786475275;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pP8i8NYB09c7tS03hr3DsHvzmnNn59UsH3jnOmwLlmo=;
 b=D3OHMYUkb8TN+38HB8eOo/th6G5yaNyU/gghH5hDWXQ1l91bL8Hr33hF1P9glUd867
 t5jGZKtgmd+qdMQ1aovan9by+NgVMdyw+D9OZbid5rIyPvzrhV++ow5dhiEuOCu7zAvv
 iqkWvWUpSKQvnpJcbmDAwoyYSj7gwOYuka8tO/FYYCXFvZta6+bCtTj4fxPIC4M4Uwyq
 Novtk6NcOC1idu4dSfQZRlCNXriR9/hAZ5tV/XKu/iW6ABuRjURNxqJuGRHP6nqXfGiO
 r8Qb2/FUoULtROS7qBq3TNkuHF6AE30Ba7ScglwrtNCGo0MunDt8WqyIAjdLCpj2eTqh
 hzqg==
X-Gm-Message-State: AOJu0YzwlAe+MxgZ8viGJyUxv+3/oiBgYnFRThnwL8BGjCbhfpQnRVsw
 IGBIiwY2pSc708/9NQBuu/Kvdbtj7z2JHKNoE/VGZIDqs7GlpZqV9iky6FeslbZJv5mfmX4E2Yc
 x6w1B1wC2MSJB23UQN63BltU62cvBtF1ME/wYvac=
X-Gm-Gg: AR+sD11t8xxjghFIEe0VJc+aqwMNEt6eBU2VqwdUB4MS6Z7qsB5cVHdr3XE86JJqI4S
 UV2c4gB+/RBPsJHaEIFytKOyaIFsFC1Cu54C8ZY/vEvV/OLCrNLgPe2BzTR/9ncYcqzz8wzYo48
 7+zgq3soi8GRGVbXyTQYuLzM+uxVKfJQ1+rzHxmUaRce6hzpEIzRlWGRvu03w+FklCz5QSdODOD
 bu2olc9wbFjvLuUL35We3u7hyx3UVob5agbjG3aEXzvGnxygh+sNMR3ez2OhPYLjjWmSiL4iHwc
 G5ozRThx21cpABuA3tpZyu0dUN6cyADtr57fnlEYWJWUrqXDPNGXjoEju21jf9MnI2rk3j0tf5X
 vnjs+RKxJ1Iun
X-Received: by 2002:a17:90b:4d91:b0:38d:dfd1:7a8 with SMTP id
 98e67ed59e1d1-3903c559592mr794090a91.2.1785870474779; Tue, 04 Aug 2026
 12:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260804-fix-v1-0-0c2be5390809@redhat.com>
In-Reply-To: <20260804-fix-v1-0-0c2be5390809@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 4 Aug 2026 23:07:40 +0400
X-Gm-Features: AUfX_mxmBbMp2FvUB9n5v_H5K3-CAwy4IeG1Ee5fb0pU-R0X07SyMRV2gRlmbtE
Message-ID: <CAJ+F1CKrjGRp=oqZbpphn8ZnV9kdChwTGVfb-2D4YaiaSnuO=A@mail.gmail.com>
Subject: Re: [GIT PULL 0/9] Fixes for 11.1-rc
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
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

Hi Stefan

On Tue, Aug 4, 2026 at 11:20=E2=80=AFAM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The following changes since commit b428fe036233cbd15d37e3c027ab6ca4d3661a=
80:
>
>   Merge tag 'pull-target-arm-20260731' of https://gitlab.com/pm215/qemu i=
nto staging (2026-07-31 16:19:04 -0400)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/fix-pr-v1
>
> for you to fetch changes up to 8876b366d7cac1f65978b8f8472725b980a1abfb:
>
>   qapi/dump: add allowed-by-guest feature to win-dmp (2026-08-04 11:18:43=
 +0400)

I see it's already in staging, can you drop it? I need to double check
the CVE#...

>
> ----------------------------------------------------------------
> Fixes for 11.1-rc
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> ----------------------------------------------------------------
> Akihiko Odaki (1):
>       hw/display/virtio-gpu: Always reject invalid scanout bounds
>
> Ankur Saini (1):
>       virtio-gpu: reject requests with short/truncated control headers
>
> Bin Guo (1):
>       hw/display/virtio-gpu: Unmap DMA regions on reset
>
> Denis V. Lunev (1):
>       qapi/dump: add allowed-by-guest feature to win-dmp
>
> Marc-Andr=C3=A9 Lureau (5):
>       hw/display/virtio-gpu: validate blob iov size
>       hw/display/vga: fix panning_buf OOB after text/graphics switch
>       vhost-user-gpu: fix integer overflow in buffer allocation
>       hw/display/virtio-gpu: fix offset wraparound in scanout_blob_to_fb
>       hw/display/virtio-gpu: drop redundant node->value NULL checks
>
>  qapi/dump.json                          |  9 +++-
>  contrib/vhost-user-gpu/vugpu.h          |  1 +
>  include/hw/virtio/virtio-gpu.h          |  8 ++++
>  contrib/vhost-user-gpu/vhost-user-gpu.c | 29 +++++++-----
>  contrib/vhost-user-gpu/vugbm.c          | 11 ++++-
>  hw/display/vga.c                        |  7 +--
>  hw/display/virtio-gpu-base.c            |  4 +-
>  hw/display/virtio-gpu-rutabaga.c        |  6 +++
>  hw/display/virtio-gpu-virgl.c           | 20 ++++-----
>  hw/display/virtio-gpu.c                 | 80 ++++++++++++++++++++++++---=
------
>  10 files changed, 126 insertions(+), 49 deletions(-)
>
>

