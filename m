Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CACFB5EAA
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 03:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w349R-0004RI-6r; Wed, 18 Mar 2026 23:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w349P-0004Qg-Dv
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 23:34:23 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w349N-00045i-7M
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 23:34:22 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b97905516faso58952666b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 20:34:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773891259; cv=none;
 d=google.com; s=arc-20240605;
 b=PjXAapljH4pnk/qp+X9ykeBHbmRXZatRX7PxJncraTXaptigO6T1AHQz0qgRyUzluK
 BuND7ilKVTjgUcGiIkDH+voI1TtDhPVCHKH/+axZ2FPp9e6saPwC9TCCxouM7dCjYg+s
 68S+md94oUf92SkTnN1i9ZpWEX2eZsx1IiO+3XhShJauViC5mjwRnFCjU3eBU0ptReAv
 4nWk5zroOvBWRRsIyf27I4HQ3egXelBVlzv9VGtNu0z2r6n7Tc7/qU6JQdxA4V2npGKk
 Dji5RKX5LDrZdFhhw7nv323rdBNfM51sQc9hBTvJfkqyyN/4DNvJorYtsqCZndiindie
 1vOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2e3MC/Pfl7fjBsOsF+PAPBESAcUkz2WRPYT3gkEh88s=;
 fh=rBjBKsEzs1JIYGyQCUy7R8m0YYLVbZbBPtXybSKKRhw=;
 b=LfLKK7wHGLgRLdHc1FBQ1gvYHGsv6D8YHD14iCgScr80tpd1W1XanmyKzScXCH716p
 0XGbLdbh6SB13fjyvWO3XLU8lBLCJPbNwdIOIaXXYmiX2ZU7Ll0mrPpGXvkKPYOWoaJd
 9fifTo1cn2bU7vzrizXeCh1V/x7mxf/ju9bHdbnwV02CuBa+M+SxzPwppWg6X1sFlH6Q
 jvGjfy+ZUcuPaQLf/14IAvpLuXFq6S02+v6W7ixD/Jk6v4V53k0IKs60OjqN/bkVLqtB
 XlRbghZ0IgdV2jxI1ayS5kDbs5ALMovjBWFla02NptFicULLGTa4TVFYn8PpVoxC8mMX
 K9ag==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773891259; x=1774496059; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2e3MC/Pfl7fjBsOsF+PAPBESAcUkz2WRPYT3gkEh88s=;
 b=Y66YB6MKNmj6dIbX9yB48QmyudZww9vsWPDZJH1MWl0Vf6xSaBWiI75JXLM3OoZfDr
 GkVgyUWzG45XhEAyJd39dNf3zH62VKMYXxX/L4eDnUFW5vdnirdm5ih4XZc8JznQOGOo
 mleXztszj56S0cUiJ2iu1KlEV9UTlcg3WtYVyZD3f5lCa6JLp29WH5SMN6uQuPh8OD93
 uCCfl77sTLawBEklISVAH+2Eb3rW4FGp9enYv4LtaZKWabtQhYLrlCZMKjSa1KanIQNO
 a44GKPGXyAvJmB6v8yyXhuO6XUkagsHPGj0vX1i6y3jOPKU/+dObz4jIaeTk3LAU6qmF
 jWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773891259; x=1774496059;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2e3MC/Pfl7fjBsOsF+PAPBESAcUkz2WRPYT3gkEh88s=;
 b=kjk3OgSKgCCFrwtpPc4ri0Ph9iOPvfgHS+0v18/ZJiFrXxBXm8xlWBKc7N5eHw8Kh0
 h9Q83WaZjnrNXy6zBa4+vLmoBtuZzVZ7h2CpJc/fLE3PErQTfR/Y/gCzBIvM3KF6+bcx
 xZ7Bsy3fhoARHxunOMB22jfmuIrjjnGimx/GjB8OGyWA8Fuy2B/rckMSwN2Dlqkwls6P
 iNk3y3CJ3AF+Ccqix6ShEgIBOGTx2Pf53sFw8qgXaCg+xQi5xnCoNUUw8144bmV6KTTG
 qNb01f6AHK6zor5Xd6jbyO/iYdeAGG8NtoHTZ0ACC8uYIAw9dHChJuh+Shx7KXtXZAJy
 uiQQ==
X-Gm-Message-State: AOJu0YyRBbohh9ekcZl0uBkRtAgo+mre5NQh3xKOS4a5FTMqaCGJLbsP
 PmonoxY0IvKGPnoKUJyp7QdRhsEZeUsZbXz4rWv+p1bSrHNZqYruoWB7OVVEESN9RRygElSlthb
 eTd3JSC/P0+guuq+/voW2lBbl/ZutT8k=
X-Gm-Gg: ATEYQzwRWOcBwXQrLi/1BV2oUhwHsWCEJgAraqVoFQ1EcoQ+1PXqWAo37OtXAvFrqpJ
 62Lg3jFOytHGffcxtxccl6lfysve8TBucpFgcYzbbpSKroZxF9felldNlB0813UnhNpwS8QSvF5
 6oovm5i4jJ9FLqoexR3uHy8f7SNK4xkldHy+4Jd9QtREpkzoRU0PYkqR6UKo5nt83p30iB43z/R
 ZhDnoAqfy61n4pvIqCqBvdhU7GrX2xzY0FZhg075t7FbIXyr0MjG7KGlZrQ5H3VZh8hkeUTUH4Q
 oubTUFrkDwB2o934x+72rLtdpVRYykRN8wZLzQ==
X-Received: by 2002:a17:907:d711:b0:b97:4e42:23ed with SMTP id
 a640c23a62f3a-b97f48bb872mr341824466b.9.1773891258851; Wed, 18 Mar 2026
 20:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260318024234.2772480-1-jim.shu@sifive.com>
In-Reply-To: <20260318024234.2772480-1-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 19 Mar 2026 13:33:52 +1000
X-Gm-Features: AaiRm51VJDUYOM61ftW2FEBdFnrkUgtNlmDFiXYbhn89dJN5-57nGo8n2rOhQnk
Message-ID: <CAKmqyKMiJLzbMu1pwqoZbOwp2ofEEZ7KANeJ6Vuzb8kCoO+r1w@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix scountovf CSR behavior in VS-mode and
 M-mode
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Mar 18, 2026 at 12:44=E2=80=AFPM Jim Shu <jim.shu@sifive.com> wrote=
:
>
> From Sscofpmf spec [1]:
> - In M-mode, scountovf bit X is always readable.
> - in VS mode, scountovf bit X is readable when mcounteren bit X and
>   hcounteren bit X are both set, and otherwise reads as zero.
>
> [1] https://github.com/riscv/riscv-isa-manual/blob/main/src/sscofpmf.adoc
>
> Signed-off-by: Jim Shu <jim.shu@sifive.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 5064483917..a75281539b 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1599,6 +1599,7 @@ static RISCVException read_scountovf(CPURISCVState =
*env, int csrno,
>      int mhpmevt_start =3D CSR_MHPMEVENT3 - CSR_MCOUNTINHIBIT;
>      int i;
>      *val =3D 0;
> +    bool virt =3D env->virt_enabled;
>
>      /* Virtualize scountovf for counter delegation */
>      if (riscv_cpu_cfg(env)->ext_sscofpmf &&
> @@ -1609,8 +1610,19 @@ static RISCVException read_scountovf(CPURISCVState=
 *env, int csrno,
>      }
>
>      for (i =3D mhpmevt_start; i < RV_MAX_MHPMEVENTS; i++) {
> -        if ((get_field(env->mcounteren, BIT(i))) &&
> -            (env->mhpmevent_val[i] & MHPMEVENT_BIT_OF)) {
> +        if (env->priv < PRV_M) {
> +            if (!get_field(env->mcounteren, BIT(i))) {
> +                /* no mcounteren in S/HS-mode */
> +                continue;
> +            }
> +
> +            if (virt && !get_field(env->hcounteren, BIT(i))) {
> +                /* no hcounteren in VS-mode */
> +                continue;
> +            }
> +        }
> +
> +        if (env->mhpmevent_val[i] & MHPMEVENT_BIT_OF) {
>              *val |=3D BIT(i);
>          }
>      }
> --
> 2.43.0
>
>

