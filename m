Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D43FCD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 00:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmFA-0008LN-3o; Sun, 17 May 2026 20:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmF8-0008L0-TP
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:54:02 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmF7-0002tG-E1
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:54:02 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bce386d5b85so256517666b.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 17:54:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779065640; cv=none;
 d=google.com; s=arc-20240605;
 b=dfe2nLQUANaeqgPR2Ss7E1OCNzBbAr3J8wqurPrDbP7/rf/nXlS5q7AJaF0K11MkNz
 172rEd1yVirif691wLaATSa5y46I+qRjxmjvd4EV4q2nW/PR1l98Dv8U9XxmVIwD57jo
 QEHqDVtdjZFYPm7KKkI6cgQfDLeFgHVFlo/tiAp1h0EWJdnMCTR2yK8BH+27gu7ZcNw2
 7ggOwpNTEgsln/ukxCmHG+uwPDkIvTWN56RhgMW2L/VPdcHwNbNBz6PLJNXPe2WptFt9
 ekOSdcDx3vHKlZ6RquUnKjDF9cdyWRreLdPVXuFFX7a+YAfFE2BG75WI6dlFiPZtxWoR
 GLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=C8C72PZRBmFuQDjGjr+ttXBXmCETR23Y/HVybO24ry0=;
 fh=OWEzxzQQH6i0CXrK7Il7AIoLdlIq6Z1/sAdwj53zKLQ=;
 b=MUDXM/wCgqGGWIYEFGhhzhp43sIftkJ3dVn+Fgvvtb1flOa7TjdsLzG9c8cMXVhbYj
 tCWTwDBywnnkSAcDXhZ7KocIy/r7A+2ltIzyjEWALV8ClIdEOL16qr6RfeHjO6AOonzX
 ahDGqkt5ajJ+PlNId/3AikvBgn8msLHbTCiOkw8gHmDT9efNH6HqWaoPGQ3JA3MvG/qF
 K8ZnAN8HJR7t5YfECHN2osOw2neyKGY4dMP4uv3sp4kBDYdVf5Fl5XKvBGbUAvDCNt0k
 +3523u86Znh0DKvCu0dkUQk/LqCE5AuafTeLaJPcRPnB9AzlRmwd76MQb/xImBZE+GNP
 Xkxw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779065640; x=1779670440; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C8C72PZRBmFuQDjGjr+ttXBXmCETR23Y/HVybO24ry0=;
 b=XiT68LZdhssv7TRba5IdGYmyj6g08ivxsVSR3xeQR4VXg5Oy2aOiI7B7eKnQzpjOUc
 uLbMYiBwWBgJ8C7WBjnGxZzz7lRnfdEDntQI7s0uWL8gY8uLnqRq3Flz7w9/dick7/Yz
 QjOVeZzxC5vIbbDQyah9YFGqf6bCjI07fdhNO7R77G5Pnapo9lW3S5YD9EOg7FqBv4+Y
 Rq04Yo2ms21bl0mL7HZ3TADcBfk8qa+pLp+zMC3pfyItvackTCHBYkr61vbykcQXzH9l
 oou7GlwX1sn5SIw8La3X/33J7r2yAeIW2w9hCOMF4Jca10UK7NEfl/mmta914zA8SjUe
 j7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779065640; x=1779670440;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C8C72PZRBmFuQDjGjr+ttXBXmCETR23Y/HVybO24ry0=;
 b=sx4WxSGFSGw4ykt9YIzW1My8wkzCRE/mfMqM4vQHjqgO90UiTUDoi6HqJwtIS4zOVG
 2n3EA2j3Lc4QgS+lZdN9yp7HMg3aEoEQVUIUYvjHFdEdo3cMuOLm22xnr4af8jw3St1v
 Wnr8gY5EC2kSTTL1keIoHPkS09qZujF20EbGqLoR+19zMucqPEChSQ/fW8bmZ/meJ2dT
 Ed+pjDgVgZRb8XQkDlVu4IyldU7yMHCsx7ym9gmwO2gkq0SQFUv6Wt60yku3t0uFMLGp
 LBMhwgjqKK9p+OEjkbj7loHuc1lNq3odbn/8gJ0ZQvxxC28ZC+PzLb7Dpw0NGjpqNAA/
 sGQg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TF8Ax3w2axyzK32eu9+DLd9ysv/9LzDU7B0ABHwdIqa2rh1x2tzV10djqMkqbYCLDcUddRZMB5+YU@nongnu.org
X-Gm-Message-State: AOJu0YxwlmrX5evNhKfJ7d/G+uDEAKLmbpRlblW/kkihyxXW+vzIs4XB
 FTqcvVD3yszVifbsolIgxT8U1fwrsWOiywyyNB8WT/aITVqYoP1l+rvm7qDePpBAP0+OAI60a5T
 8MTblezw2wz1cNu7a547k+IYjHv05n0U=
X-Gm-Gg: Acq92OEL43ZdJ1It+/ncrXPJfp5G/TGL1GgfZH6af7jb7q87rWHoYAJJQVH0vem6lKl
 zkBPrJiLDw+SsDkFFbSeoenMoajnhAp7K6uB2VgN7zMLrLTRnXnmlPe6faE6Iz7bPuXyBendRBG
 xYs2SnABm0ccU8D8+81ZQdJwNpU1Thoxlq5Vt5zwP5lLrNe7bryBw4L9QBAwPR6X2O35741zUXj
 vm405K65C21ppgVhxlRGqHw7SROYaXLzQj1RHovMeGmbLUmTS+u0c9vTvtL9XVnIgo+dMfl3vmv
 qcyviEsVYjmtSS+Ovn9RF2KbxypUGoCDO6ktsQ==
X-Received: by 2002:a17:907:a317:b0:baf:e47:1b6a with SMTP id
 a640c23a62f3a-bd5179305eamr665570266b.24.1779065639544; Sun, 17 May 2026
 17:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260512052240.330815-1-vulab@iscas.ac.cn>
In-Reply-To: <20260512052240.330815-1-vulab@iscas.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 10:53:33 +1000
X-Gm-Features: AVHnY4IFTC-syojsnzg_PE8wldM_HhPGMoaglAcXSJAgoshyNU2l4s7zdp-v1Uo
Message-ID: <CAKmqyKP5xaK0DkM0L94H5P9_XtDfZcq4wmFQbACyaEAm4sCW=A@mail.gmail.com>
Subject: Re: [PATCH v1] target/riscv: clear mseccfg on reset for all dependent
 extensions
To: Zishun Yi <vulab@iscas.ac.cn>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, May 12, 2026 at 3:24=E2=80=AFPM Zishun Yi <vulab@iscas.ac.cn> wrote=
:
>
> Currently, the `mseccfg` CSR is only cleared to 0 during reset if the
> `ext_smepmp` is enabled. However, this register is now shared by
> several other extensions such as `zkr`, `smmpm`, and `zicfilp`.
>
> Fix by clearing `mseccfg` if any dependent extension is present, and
> adjusting the relevant comments.
>
> This vulnerability was discovered and reported by SpecHunter, an
> AI-driven architecture specification analysis tool.
>
> Link: https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-svv=
ptc/pr-134/qemu.txt
> Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ce15a17c37de..3cabfeb1fa7a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -756,10 +756,14 @@ static void riscv_cpu_reset_hold(Object *obj, Reset=
Type type)
>
>      /*
>       * Clear mseccfg and unlock all the PMP entries upon reset.
> -     * This is allowed as per the priv and smepmp specifications
> -     * and is needed to clear stale entries across reboots.
> +     * This is required as per the priv, smepmp, and other security
> +     * extension specifications that share this CSR, and is needed
> +     * to clear stale entries across reboots.
>       */
> -    if (riscv_cpu_cfg(env)->ext_smepmp) {
> +    if (riscv_cpu_cfg(env)->ext_smepmp ||
> +        riscv_cpu_cfg(env)->ext_zkr ||
> +        riscv_cpu_cfg(env)->ext_smmpm ||
> +        riscv_cpu_cfg(env)->ext_zicfilp) {
>          env->mseccfg =3D 0;
>      }
>
> --
> 2.51.2
>
>

