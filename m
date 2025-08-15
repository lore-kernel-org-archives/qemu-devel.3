Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1C6CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 16:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umwwG-0004Qj-Dm; Fri, 15 Aug 2025 12:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umwwE-0004QE-Oa
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 12:05:54 -0400
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umww8-0002IH-40
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 12:05:50 -0400
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e931cdd710dso1789008276.3
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 09:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755273946; x=1755878746; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nfuIy4XPjF2sZOs3zXjIofe0GTOnjTIVO8Kv2o0tcWQ=;
 b=WdPwSA0k4f5y1N3Y5ymLajTA7pVEgOCdeGtFl7lcNvYWm6YTCIlI7geMOM4+KFWAME
 x4Sgxl3xM17A0KfTYPwz8fOxDvHs4TaGIk5qETtJGY8QB/NvpeumdPNL9KE8vQbF6+gd
 /R8eJKKqED2w1UCmWEmgHCnb3+mHA7AC+MW4F/UiNN8VCoBkd75lNlz+7y4OKsgFOyUy
 eF2uF5yMQBvnZGuMmljgDquKeSDzEwDtR8KW3xL2tKoboQQM38cHhMWnJ6soqztcKPzU
 HAj+CE10ho3zgdiDbonbFM6keFRnrNpg8H1sqWyUR30OBYT+6DANFjXSpFNMP0zOZoLa
 e1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755273946; x=1755878746;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nfuIy4XPjF2sZOs3zXjIofe0GTOnjTIVO8Kv2o0tcWQ=;
 b=E+gFwvR95AIG4zxN2AFg9eeZfHBEz24QT/gXPs+qJ21o6M9k5WWokp7yKPoSY1YIXF
 L6jtChXjEoiTwn2fF1hIXxl8nVsN5+jWwYDL1iVqJilJgMNs7whQzsldj0Gc5RZe0x7G
 1m8hBmD5cpZLyb92Ju4Qhda9vPDWvSfF8BAlDW6vrAD9vEzVuf4uvSeVDWIYcWFeMpGc
 sWsBsqFHljESIm8jOkwqm/uJSC02sq0s35WrFDB8eMROoLgqRyudNDBDlkalsoijOBMs
 nquRNnqNHFzgMV2L/0M2ZKJg3l0C6RHrj9/OlT+sttZzruTw/t9QPXnD/2tFylKAxJXv
 x/3w==
X-Gm-Message-State: AOJu0YxA0pWVQw8sWWOgZPF3SwgThCn3IchO8qpVXO+jN1itr8ZNLvZH
 FRpnba7YRSfTGrbNJJPJcNlXcmBz3+z76x8WCeQ09DhvOmhxtcPUCaJYBbivM7exm+90JbmC/iW
 +ymiaVMxymvccfdzilvpV9niIkWcN9MmL5TyoxaI0xA==
X-Gm-Gg: ASbGnct8iAzv13kMRJu8iq33nOWwBgvPU5aBO109OLu8Zf07KtIdybbN3EZKqOznTXF
 NPxE2ScqOI1S4DKnGuoaZXQrmOkvBHTdiV/fqSWgmJ45v55iMZBLKe0vJLFhlonteS0iNUrqcMz
 Ri0Fzcli9+SoN6czRvQU0GlsWgDWwdwOzsQ4difbCkkd8aAxyNJ5OS6VPb/Ec5mJ60H2X0nTm8g
 bkfu0ZJ7fHFQg8nBq0=
X-Google-Smtp-Source: AGHT+IFr7JZEGfVTwkm5kk4DVl5JP9WkWCKWmlDWcp3f1mbw0IOkEw36sa94FgXXvWDYxiLksd51NenpIE0+b2Kl9aI=
X-Received: by 2002:a05:6902:110d:b0:e90:8278:5ef7 with SMTP id
 3f1490d57ef6-e93324d4f16mr3070085276.37.1755273946204; Fri, 15 Aug 2025
 09:05:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250803014019.416797-1-richard.henderson@linaro.org>
 <20250803014019.416797-5-richard.henderson@linaro.org>
In-Reply-To: <20250803014019.416797-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Aug 2025 17:05:34 +0100
X-Gm-Features: Ac12FXzBo2zIgSoLYwaT2J9GVLQZ_n-Jgr-2fpNb6yVYmfPJaGDSHoXHitNBV4Q
Message-ID: <CAFEAcA_tLzaqeHa7MFf58-h3f1VN4TCe+aavvazknVw0wWNU+w@mail.gmail.com>
Subject: Re: [PATCH 04/11] target/arm: Split out gen_wrap2_i32 helper
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
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

On Sun, 3 Aug 2025 at 02:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Wrapper to extract the low 32 bits, perform an operation,
> and zero-extend back to 64 bits.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index bb92bdc296..64a845d5fb 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -8231,13 +8231,18 @@ static bool gen_rr(DisasContext *s, int rd, int rn, ArithOneOp fn)
>      return true;
>  }
>
> +static void gen_wrap2_i32(TCGv_i64 d, TCGv_i64 n, NeonGenOneOpFn fn)
> +{
> +    TCGv_i32 t = tcg_temp_new_i32();
> +
> +    tcg_gen_extrl_i64_i32(t, n);
> +    fn(t, t);
> +    tcg_gen_extu_i32_i64(d, t);
> +}
> +
>  static void gen_rbit32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
>  {
> -    TCGv_i32 t32 = tcg_temp_new_i32();
> -
> -    tcg_gen_extrl_i64_i32(t32, tcg_rn);
> -    gen_helper_rbit(t32, t32);
> -    tcg_gen_extu_i32_i64(tcg_rd, t32);
> +    gen_wrap2_i32(tcg_rn, tcg_rn, gen_helper_rbit);

...should be (tcg_rd, tcg_rn, gen_helper_rbit);


>  }
>
>  static void gen_rev16_xx(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn, TCGv_i64 mask)
> @@ -8293,11 +8298,7 @@ static void gen_clz64(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
>
>  static void gen_cls32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
>  {
> -    TCGv_i32 t32 = tcg_temp_new_i32();
> -
> -    tcg_gen_extrl_i64_i32(t32, tcg_rn);
> -    tcg_gen_clrsb_i32(t32, t32);
> -    tcg_gen_extu_i32_i64(tcg_rd, t32);
> +    gen_wrap2_i32(tcg_rn, tcg_rn, tcg_gen_clrsb_i32);

Ditto.

This caused the 'check-functional' tests to fail.

-- PMM

