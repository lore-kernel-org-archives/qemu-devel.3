Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E9BF94CB8
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 00:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFL2g-0001tv-Dw; Tue, 21 Apr 2026 20:02:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wFL2f-0001te-ND
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 20:02:09 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wFL2e-0003LG-5Q
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 20:02:09 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ba388bc0a9dso853683266b.1
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 17:02:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776816126; cv=none;
 d=google.com; s=arc-20240605;
 b=KUT+GO3QFUZyTzRtdBEY+oa3J7xlwc2YRB3Hi+G7O+uYVT5v59puOL86FFs7G754cN
 Aa5t58s69B8zyy9ifxIwhWq+Vc83YLaKxiesh2CP9fa/lltHzofUthbj0w9H9aOA4i9O
 Y8K7GNOj9x3g4wnktmQpUjQmiC7oWE+wQNrIVtoAGrYYi+UikQ/Iv8ZvvtAPRkCGvZ1Z
 j6bHbcexSfdAK1Fd60F0VGwN/sfL9r6x2Zgx/r0GSsr2g6UU2TgTspJ12EjxdLo7Yzcx
 th9ffa7Lf7VXtlrKyvIezLnR331CfipGaJRp7KZvK7clVj08feUDQFTnCAGhOzP27te6
 hunw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4GMnvMgPoPIPJSzxHbcY/A3zsDlmols0y0fDIQhH1nQ=;
 fh=UtBZNt6Y6N8SDSGGMxyoFI04MddI+MyqrqBbP2A8k94=;
 b=jbyIaneHswFMuMZ91NpKAitGnAU9MePdC6cLKKvMOLVylBfYDlfoNRTu39uSdZ2Ctj
 1Y2TGPtTEM5PLoyxkLV50vElaYNaUu/zxMs8FtrVK6dtiUQXBYwXTOKIb7yKrDQquBga
 TJr/sNb+Ryihh0t+PFDiNO6q/3Ch8iccLPE3sNZ5UumPbR7XLphKe4xBq+wIewl+jOhQ
 82xNFRBcnekyTrBlegLLCJ6XXEAeEJWwAY7bGjHcNVUiSfWG2sTF19iivgkRxg8Lex0S
 ThTOoirG5b2tjuqN16yjITbZA3bYU62ojKa2by8f0KVTPecXiFtri3jGXwnN7G5sumRC
 XKUA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776816126; x=1777420926; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4GMnvMgPoPIPJSzxHbcY/A3zsDlmols0y0fDIQhH1nQ=;
 b=ryVtc/FYCDH+fAuD5X6/+Jmf2Rq6j7jkhydimiUYv2mgKsEqZjvEQ/EdLFVk/X9gXL
 ECtI+P48d068zVWvnsX9CJqvfTX3RNINVye3zZ4ab8pmH/Qx8U2WYjupwoqb3x6Y7fXq
 Cok9dgDoTzS10tOIasRDJcRgEezo1f1nQ1NiyLlVxty3I9PXLOea2i/x5vMf7IqrN99t
 8hYbqMnosRNR4XMGONGNyeB8z/XkuBiQs6YbB1XZFSOPOtAHv0BevvxKBKpskm1vuduU
 IOigTlkCWaIEKZdMVOtgZO5QtcGkbzvcRktkgG6VvMgjLvqllgyQ71/VEJI1pwMDrVyL
 hW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776816126; x=1777420926;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4GMnvMgPoPIPJSzxHbcY/A3zsDlmols0y0fDIQhH1nQ=;
 b=nPzFj35mvGQiUY1yluR129ZvjPURsmC4ilTRHZSnKUjyaxC4v9sgzkFajhpaTE0d/U
 JijWu8dHR4D6Nm9YzXNPkqL23dP1KQPn06XT9eulx6XCs7dIh7+eyyMQ7OD6nEpm4709
 /xFqnHWSVzqcjCtsy1K0EZ517/qZNG/DV21WPBuihhQmAwhFyGP2m9pcjj5p6MGRAjJ0
 HziWF2pfVaGSPtRc4jd/fI4qEYYxM0Xb2QQAwGnnuIujOh1t5YvzXdLkDhGRFRKI0bOj
 iLctDdm6rQ3Y8xbv4goZcqJ166thjmqtX1eW1Fv5G2uUFStTlwgK92PcePWpvjLP3ZKD
 24Sw==
X-Gm-Message-State: AOJu0YzeLevVFvFRoyy3QPkzw45Y31wzGMyKql2Ae3taaBb3N/1f1cK4
 epUAFW8zVnWd6YlI0bzycKQwg/musJdu9cbD7CY1m/k7y6Q8R/0YP/Mf4vvis6l+fFIqYT9agRV
 kpEbFpEkOPvdJyIerWg7dlStbyk2PSQg=
X-Gm-Gg: AeBDies8TJtwkwfbTG0HOvPF1EZfi5pW71zahKSzb1eCgE36MMKJR42egwx0Frv9iiC
 3kA6BprIFnTKPoaSlTdjc9TT9NQZXrBPz7qIKdkczucYjpnDZ4bH5+VBOAFKqhRpfdPlODD53v6
 c6WGHi6s41O7W3r91736KmAU0tcQrVM6w73Ipnb9oxLumUWZ9/CGpLJekfxUQwNjd3Ywd0z+Y3w
 2Z3UBB+yW3N7z84tFfiZdn8otEPOHleg5KlayBJDDsUekmeMK2skK6lhpxjEbP/9geDGB5uY4/H
 fwHDSKtivrOQHUQ5CiTIj3/FGesZ209A4K+bWWLBHjdsO3ai
X-Received: by 2002:a17:907:3e9f:b0:ba7:3578:f628 with SMTP id
 a640c23a62f3a-ba7357901e9mr615724566b.38.1776816126123; Tue, 21 Apr 2026
 17:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260421075906.2928317-1-frank.chang@sifive.com>
 <20260421075906.2928317-3-frank.chang@sifive.com>
In-Reply-To: <20260421075906.2928317-3-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Apr 2026 10:01:38 +1000
X-Gm-Features: AQROBzDEOco3Bmh2O14i43dhuSa_0qD0QqhTo8Q4jClG-cpou-KTjrfNMrki7fk
Message-ID: <CAKmqyKMOoL94khSzCUb7h9xfCN9H0hkuLGf-BjNTTWjxgbhf-g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] target/riscv: Update MISA.X for non-standard
 extensions
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Max Chou <max.chou@sifive.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
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

On Tue, Apr 21, 2026 at 6:00=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> MISA.X is set if there are any non-standard extensions.
> We should set MISA.X when any of the vendor extensions is enabled.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Max Chou <max.chou@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h         |  1 +
>  target/riscv/tcg/tcg-cpu.c | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 4c0676ed53b..175e877f90a 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -69,6 +69,7 @@ typedef struct CPUArchState CPURISCVState;
>  #define RVH RV('H')
>  #define RVG RV('G')
>  #define RVB RV('B')
> +#define RVX RV('X')
>
>  extern const uint32_t misa_bits[];
>  const char *riscv_get_misa_ext_name(uint32_t bit);
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 0f68560bac1..44d948b5dca 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1194,6 +1194,20 @@ static void riscv_cpu_update_misa_c(RISCVCPU *cpu)
>      }
>  }
>
> +/* MISA.X is set when any of the non-standard extensions is enabled. */
> +static void riscv_cpu_update_misa_x(RISCVCPU *cpu)
> +{
> +    CPURISCVState *env =3D &cpu->env;
> +    const RISCVCPUMultiExtConfig *arr =3D riscv_cpu_vendor_exts;
> +
> +    for (int i =3D 0; arr[i].name !=3D NULL; i++) {
> +        if (isa_ext_is_enabled(cpu, arr[i].offset)) {
> +            riscv_cpu_set_misa_ext(env, env->misa_ext | RVX);
> +            break;
> +        }
> +    }
> +}
> +
>  void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
>  {
>      CPURISCVState *env =3D &cpu->env;
> @@ -1202,6 +1216,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu,=
 Error **errp)
>      riscv_cpu_init_implied_exts_rules();
>      riscv_cpu_enable_implied_rules(cpu);
>      riscv_cpu_update_misa_c(cpu);
> +    riscv_cpu_update_misa_x(cpu);
>
>      riscv_cpu_validate_misa_priv(env, &local_err);
>      if (local_err !=3D NULL) {
> --
> 2.43.0
>
>

