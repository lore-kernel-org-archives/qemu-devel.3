Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4EFC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 14:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXMiH-00017I-Uc; Tue, 06 Feb 2024 09:46:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXMiH-000174-BP
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 09:46:17 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rXMiF-0008BO-HB
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 09:46:17 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-55fe4534e9bso5620041a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 06:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707230773; x=1707835573; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oy2y0w18hYt/0SqQFdw8z2ZQCuNGCTXvISsnSPy1zIw=;
 b=v7z0s/I9NxhSPoCzgx2KuH666HO9FL5SKqOS7cjaMUBAMt0+s+1tXfKdFm2HQ+XXbI
 lgLEvwAGiAV76A7d1XtO7Q716FjvpROsSnAcT0Q4lrs1MN1D1tRStdkvGK6+GrVENa4g
 D8w1A79YVqlvbH4hABAgxY5lRqj2XB4kpmZKyBpos8svff2pzAR+Sp2ST8cP53JWA9Pd
 mNhhINsiv9+WF5+N2ylFYA6+gWJVSQufLh+KuUZ0LBEJcbqYr7kRYeFErrbsin1cDrkw
 +ns0wUzJadTPTie+gqGoou8Cv0IIAH1U4YMiO3edQWbCfyNFyxFoq4hNX0/pvBkB+5Y/
 LzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707230773; x=1707835573;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oy2y0w18hYt/0SqQFdw8z2ZQCuNGCTXvISsnSPy1zIw=;
 b=CjbdSurPnw2FtfzMDXNkZVZ3IC84//1ZlUO/tZ1jno6XdtT5VbFYBGrsvsaWXWvVOw
 3ER8d+6cnX+aVa1ZztDRvaT7VGFK+1f/RgNQks1nO34j4Q60mDEQywwfGaD8L/ThARsh
 GiRmvA+emcawyMD5hqtPit3T4qPss0lwm+mcTReJVqRB973m2gv+ZowxKNoiDduhp/aP
 /DEXBThGn/t4lXmTtlvSfI5iggeRfIe9PV/FcQw4wNwgaXTSuFqmHaWslWtAYppVvPXj
 FFgiwxHkFFEEm0lsc3n6YXxVNixnQMZqiBOfiZ66uBPf81VrNmvB+OUhQB4G4uFjJ9HC
 lDGg==
X-Gm-Message-State: AOJu0YxBAq4XlmWBwXXzbVmdRo2BKgyk5+5y9v5J6N/L6dK9EHBTcMzp
 F79koKhr71ynNGxypbLeC6+ja4a5UQB2ZZYS8fzikJGmVUqXxWS2de3C+omwPcF0snFiB4t4EmL
 Kh5huKq72TgMjOMlhDqkdVkiawKknH57Bgntneg==
X-Google-Smtp-Source: AGHT+IEEz9axDkPnZQriacWaF7yK2d4IC08uYK8Ex15b5DlucesXD6fOPPYjJ9U4vcf1pc6NfRfyJMCdT1rw4Zb+AQs=
X-Received: by 2002:a05:6402:1485:b0:55f:9bb6:b205 with SMTP id
 e5-20020a056402148500b0055f9bb6b205mr1983775edv.34.1707230773233; Tue, 06 Feb
 2024 06:46:13 -0800 (PST)
MIME-Version: 1.0
References: <20240206030527.169147-1-richard.henderson@linaro.org>
 <20240206030527.169147-3-richard.henderson@linaro.org>
In-Reply-To: <20240206030527.169147-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2024 14:46:01 +0000
Message-ID: <CAFEAcA-ZNwm=OJ6u+e57kyRFnjyR+Br=ZCbOodbQwBZzrjVnhA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] target/arm: Fix nregs computation in do_ld_zpa
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, gustavo.romero@linaro.org, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 6 Feb 2024 at 03:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The field is encoded as [0-3], which is convenient for
> indexing our array of function pointers, but the true
> value is [1-4].  Adjust before calling do_mem_zpa.
>
> Add an assert, and move the comment re passing ZT to
> the helper back next to the relevant code.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 206adacfb8d ("target/arm: Add mte helpers for sve scalar + int loads")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
> index 296e7d1ce2..f50a426c98 100644
> --- a/target/arm/tcg/translate-sve.c
> +++ b/target/arm/tcg/translate-sve.c
> @@ -4445,11 +4445,7 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
>      TCGv_ptr t_pg;
>      int desc = 0;
>
> -    /*
> -     * For e.g. LD4, there are not enough arguments to pass all 4
> -     * registers as pointers, so encode the regno into the data field.
> -     * For consistency, do this even for LD1.
> -     */
> +    assert(mte_n >= 1 && mte_n <= 4);
>      if (s->mte_active[0]) {
>          int msz = dtype_msz(dtype);
>
> @@ -4463,6 +4459,11 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
>          addr = clean_data_tbi(s, addr);
>      }
>
> +    /*
> +     * For e.g. LD4, there are not enough arguments to pass all 4
> +     * registers as pointers, so encode the regno into the data field.
> +     * For consistency, do this even for LD1.
> +     */
>      desc = simd_desc(vsz, vsz, zt | desc);
>      t_pg = tcg_temp_new_ptr();
>
> @@ -4600,7 +4601,7 @@ static void do_ld_zpa(DisasContext *s, int zt, int pg,
>       * accessible via the instruction encoding.
>       */
>      assert(fn != NULL);
> -    do_mem_zpa(s, zt, pg, addr, dtype, nreg, false, fn);
> +    do_mem_zpa(s, zt, pg, addr, dtype, nreg + 1, false, fn);
>  }
>
>  static bool trans_LD_zprr(DisasContext *s, arg_rprr_load *a)

What about do_st_zpa() ? It's not obvious what the 'nreg'
encoding is in the a->nreg field in arg_rprr_store, but
it's definitely confusing that do_st_zpa() calls
do_mem_zpa() passing "nreg" whereas do_ld_zpa() now
passes it "nreg + 1". Can we make it so the handling
in these two functions lines up?

thanks
-- PMM

