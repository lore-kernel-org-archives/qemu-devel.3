Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AB7CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 14:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSbKE-0005Zs-4m; Thu, 28 May 2026 10:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSbKB-0005Zd-UY
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:03:03 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSbK5-0000nV-66
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:02:58 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7dbcb505578so14645787b3.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 07:02:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779976976; cv=none;
 d=google.com; s=arc-20240605;
 b=UikR6d4yvRG+52hJSSTOqGd7Nb755kGZBJ/N9txs0gmJzoyYvUm1V1SJWM2kKoy2r1
 Opw0ufkhsk9E0VYZmbfVCTC5T18bN2ir34dMdrVo/cmhTbRP4FMtemKL+oqK/suqLZ2l
 fcfe57Ov8w3E0v8rr4eFd+Q1qZCgUw9BE2ixzpM7vpWTRa6SYCF0ZvNnJdlFrabXfMNb
 w3sKMtFIbKHkFdV4zSc/m5qLFZH9SLjOOzFfQZ1MMG1BDLoNsukNhQjrR5vFyueub84Z
 4JzrHTfx57g6GfMDJdH2SNZpgkYWip44FHhjjosuINSdp3WUz2SWe5RTxnHO2+hTfMdB
 Ebhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=u2UlvLkU8QmOGAzcIPF1CoBUsarDoTA5l7nW5ux5rGk=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=g50rSvs5Bnf8sadW+naVU0JUvHECSL/UzYXCdmvQnkDBU/EUW3K8ltTlHtEP50Alfh
 ko9YxE5Usev4WVDpXUtXdf56g7n5gc6MZNvBK8q231c1P/UuVrHLBojmR02rJQWv1kI2
 8QeQGMpE4rJGtYvTkmoWgUfpAadobQgEi827Eqve75rqIeCyXzKb6i6W+mD1d0lLSHi1
 NuBcSb2TMTE4ynvroyyKLZFRQpF2IcAcTguuqSjVQBB0dDVezlBNQBcM+o7PAYTbp5Q0
 Jf0G5lHjHjkPQYf2wbrC/387Nz+Nt8St73glPWrH9xG77J/QZQGP9GqmvkLna/5gFlqZ
 c3AQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779976976; x=1780581776; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u2UlvLkU8QmOGAzcIPF1CoBUsarDoTA5l7nW5ux5rGk=;
 b=AzayyP6mUU6RNCc9HZAOpQRIYCPlO5CL66stocKv4nphNdpjw3Grx1VkaQQrdgGkaL
 uqebLHr+cEHA1rvwHZzOnGSZu/fWyod33DhZ0LxZ6w2upkl/0ByPxqO2ijSjLEXkl7c8
 99ADYFNur9DdfuB87rdUj6gYK3YBo59c6RkoD2G6toqSjfd6oVAKKA3Ap7Rg0Vhosw7w
 RoEXBZnnLWgKFjjz200475Kc7tklOrsKF55e3IesmF6X/4EVmQKviAm65AIhBNL8JjKD
 DjCvqB4UpqSsoSY+GrYP0LKNUQlV1RCi/Bs73PZrtR57J78vg70uRjqnJj7xSDRROKg8
 jQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779976976; x=1780581776;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u2UlvLkU8QmOGAzcIPF1CoBUsarDoTA5l7nW5ux5rGk=;
 b=PzWB1QSSNhL2urGttjdDFbQVoCX4Y8/kbDYyAHzgrtuti9mKGjP23LgzYWVl8y66G4
 K1RF1QcrjeJ4pKeF6uCEsGBOHakeM5nA/crbZtmfmro+rQcAESoUT4Vun7gRKrD6/0Wd
 V7Qu5cRFr+09oU2upysJxhD4iy9+SpzIZ+luzoxcqFRsaaJKxN1lHoZtq2kM1XcFOciE
 UISmGbeFaH2E7U0wiOByhPHvI/lLQRl1gk9uh9gmQrgnblmxoBObyiLbvNwkno66sFku
 YYh2myhYbwy/dAyUt3D61S+hcj1JrQdMd4B0S7q6sQcQ8i2T0HS2MhI3fNxYNQgWoexu
 VO3A==
X-Gm-Message-State: AOJu0YxS2BJLANgpn0GJYTKzH79QcMXW/rWLSpk/YqgPHQiRwMgRaDYQ
 /6drpu0KVF1imYzT67R+rK/QbxZVCjQMvZwGuzLeMjoLxdjtL6yT/iVfVkT+LmYthrl+8AMX3jm
 1Yffaml8USzuYJBwx4jF9qy7KgHnGGq6ak0qJrYtAMw==
X-Gm-Gg: Acq92OGFCS2HCNEeZaCrKBbjUVKdR3JZ8GLSRicDK2MZoe8GOFZT47jI9PdzEMvI3Zl
 /Mr94T2vR5PPYw0jgJfPBdMbdR34PtKsbkWPYa9wnHUWnPHXBI/WFvsYcOlAufn4jG81v+dqKmb
 GMJ4uZPr+9z0c2jYU0ZhQd6gzMMqUClKiFEdgS2t4lFBAHa/mWg5TwVEPH9C9+65DlVzjqMIlsJ
 Y6AomfpUQkITcWYmfD5WpoOLjutok1wvafhn7mJZklpQz6jSGPhbZ4lPz5foHoIVB5QcPNXxn3O
 v67FMXJq7HDJknIHdCPwbQ5ZIeKvfOIjmVQcCOJV/Ey3VvlcBm9SYr6LT6YsJIb4Qn5td/sqRNR
 u9A==
X-Received: by 2002:a05:690c:f15:b0:7dc:a5a8:89d with SMTP id
 00721157ae682-7dca5a81a7cmr23147497b3.10.1779976975374; Thu, 28 May 2026
 07:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260518174750.660258-1-richard.henderson@linaro.org>
 <20260518174750.660258-4-richard.henderson@linaro.org>
In-Reply-To: <20260518174750.660258-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2026 15:02:43 +0100
X-Gm-Features: AVHnY4LVwZ33ITOAl2fYr-DypodGFLApEvA6PfRNGjtEWFiXCkhQokdKX5TBodU
Message-ID: <CAFEAcA9PEAKVBEdH_ZEzSc_nsVrho9KZ9YwP6stK5fEJ4qSk=Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] target/arm: Implement CB (immediate)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Mon, 18 May 2026 at 18:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 41 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/a64.decode      |  2 ++
>  2 files changed, 43 insertions(+)
>
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 293aa43cc9..c4a016f36c 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -1816,6 +1816,47 @@ static bool trans_CB_cond(DisasContext *s, arg_CB_cond *a)
>      return true;
>  }
>
> +static bool trans_CB_cond_imm(DisasContext *s, arg_CB_cond_imm *a)
> +{
> +    static const TCGCond cb_cond[8] = {
> +        [0] = TCG_COND_GT,
> +        [1] = TCG_COND_LT,
> +        [2] = TCG_COND_GTU,
> +        [3] = TCG_COND_LTU,
> +        [4] = TCG_COND_NEVER,  /* reserved */
> +        [5] = TCG_COND_NEVER,  /* reserved */
> +        [6] = TCG_COND_EQ,
> +        [7] = TCG_COND_NE,
> +    };

Maybe worth a brief comment
 /* Note that CB imm and CB encode the condition differently */

?

> +    TCGCond cond = cb_cond[a->cc];
> +    TCGv_i64 t;
> +
> +    if (!dc_isar_feature(aa64_cmpbr, s) || cond == TCG_COND_NEVER) {
> +        return false;
> +    }
> +
> +    t = cpu_reg(s, a->rt);
> +    if (!a->sf) {
> +        TCGv_i64 tt = tcg_temp_new_i64();
> +
> +        if (is_signed_cond(cond)) {
> +            tcg_gen_ext32s_i64(tt, t);
> +        } else {
> +            tcg_gen_ext32u_i64(tt, t);
> +        }
> +        t = tt;
> +    }
> +
> +    reset_btype(s);
> +    DisasLabel match = gen_disas_label(s);

Var decl at top of function.

> +
> +    tcg_gen_brcondi_i64(cond, t, a->imm6, match.label);
> +    gen_goto_tb(s, 0, 4);
> +    set_disas_label(s, match);
> +    gen_goto_tb(s, 1, a->imm9);
> +    return true;
> +}

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

