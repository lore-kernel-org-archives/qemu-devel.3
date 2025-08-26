Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA816CA0FF2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 16:16:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqwGx-0003oQ-Pm; Tue, 26 Aug 2025 12:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uqwGl-0003gA-Gr
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 12:11:36 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uqwGg-0007la-N3
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 12:11:35 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e95230750ceso54094276.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 09:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756224686; x=1756829486; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=O7kJUl2HyHWeiIs/wOtzDyPGPHNcnUTzf0SB6Hkr2Tw=;
 b=po4URwlcOHaVStiGSbgxnQg6H3c0ebyxbC4wuUTwrCFjn9ot0KwEh8j072wtvOGKTo
 iX5vpv7M05co2osLUZxX+4h0txVBRL20a0o1Mbj0PcV8aXMP2m1HKvQlVLabvcyx0PmU
 CCQh602brl8AmVKf9CrGcADUk3ZsIpVaPgZ6wONU2jvQGraM9aflfK5+oezWjlMTDLaF
 HXlx4n3L25k5tZcqA3Br2ZK/fSnf+LKa2Ez++L6dGh2BnrTsZqeujr2xb7kKVf4Mvnyq
 cUcexEoHzj22f11nbwOywutre18rhX3uV1svqVuBOb/QlQpxd8f92N6lwWOoxzm6j3kn
 QlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756224686; x=1756829486;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O7kJUl2HyHWeiIs/wOtzDyPGPHNcnUTzf0SB6Hkr2Tw=;
 b=bElGEP+zmSC9t/C7B7MbkwrN2KTi914F2CWMxRJ1qfRxMNTrRW0mQF3/NmDOsjSTsY
 NHeGHFVldJWcGSpitZKUfvgZq4RZ46cONRsMkP+2RpXlTLPOj8UbtWt+gatoNdNEuPPl
 SSuHUd1WCXmEUGVCLEWSowf4428NCWHoXOQ0VILcDQfPFdOF2MoycS5EARBK+qo6DOm7
 qoaHcpVWrq8+zxfDXWyKfp9OtsA4MP6so1xU1ZZ3khgENR/qjAcmK5au6zQ+clOgiMEX
 WZfafiAG6NHmj5uOaPhc2mDzvgPK4kF8vs3WCJkq9+jonUHQY3a2n9cn9JiKKPUuqt1R
 +XaQ==
X-Gm-Message-State: AOJu0Yy51HWyQfMF9DGmyCXb8j8t3W2IH89G2HnFR8G2oRNTgyHKecBX
 NtVUHuisuP1pHajpibCwiZGF82jELFg3CDoNq2whoikkdycQ9QVKK1lwlkHPrSPZUUsWldPHSgU
 PYsPGVRmaEEsBkEBKeSoBhIDCsePGpVw/av5L5RPjZw==
X-Gm-Gg: ASbGncvxIJ2NPWPzLe66orR0fUG2DE7luJGHDogpWEhIGjAuY4skigpYf5m7KS20m6P
 mn2wjIuyyPsSH2LQlkf7mfjQVFX1G1mmdcyiUznmXrqb99LZkpFZ39eM+a5UoNcQD/jwC9JPggk
 MaIo3yNr5GZmyvhvdbRK/IGxEATtfkS9V2UAJvxjwHwOMdOM2FFyaYPYeWGZq2hPl1mV3kU4vV4
 4tzjOOfzsXZsvpEQyI=
X-Google-Smtp-Source: AGHT+IHbb3JolvfDuLXQHx9QUpprqqMsHT2lAocXVfm11lFsoGgBdDafvPBLgKElsOcRfCPBS7v8giOBG4Jvn49kjwc=
X-Received: by 2002:a25:aaf0:0:b0:e96:c3a2:995e with SMTP id
 3f1490d57ef6-e96e4792dd5mr1290368276.4.1756224686361; Tue, 26 Aug 2025
 09:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250803014019.416797-1-richard.henderson@linaro.org>
 <20250803014019.416797-6-richard.henderson@linaro.org>
In-Reply-To: <20250803014019.416797-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Aug 2025 17:11:14 +0100
X-Gm-Features: Ac12FXycyYvLKNvj4520RkDABjBoNQ_XWqFfNXrE6Qw3crTmxb81c9sNn73PIcQ
Message-ID: <CAFEAcA9-KHXiLbYvoxjanLgheU5Y9B2LNfz8QZpjO6aHXHUVXQ@mail.gmail.com>
Subject: Re: [PATCH 05/11] target/arm: Implement CTZ, CNT, ABS
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sun, 3 Aug 2025 at 02:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 31 +++++++++++++++++++++++++++++++
>  target/arm/tcg/a64.decode      |  4 ++++
>  2 files changed, 35 insertions(+)
>
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 64a845d5fb..0c78d4bb79 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -8304,6 +8304,37 @@ static void gen_cls32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
>  TRANS(CLZ, gen_rr, a->rd, a->rn, a->sf ? gen_clz64 : gen_clz32)
>  TRANS(CLS, gen_rr, a->rd, a->rn, a->sf ? tcg_gen_clrsb_i64 : gen_cls32)
>
> +static void gen_ctz32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
> +{
> +    TCGv_i32 t32 = tcg_temp_new_i32();
> +
> +    tcg_gen_extrl_i64_i32(t32, tcg_rn);
> +    tcg_gen_ctzi_i32(t32, t32, 32);
> +    tcg_gen_extu_i32_i64(tcg_rd, t32);
> +}
> +
> +static void gen_ctz64(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
> +{
> +    tcg_gen_ctzi_i64(tcg_rd, tcg_rn, 64);
> +}
> +
> +static void gen_cnt32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
> +{
> +    gen_wrap2_i32(tcg_rn, tcg_rn, tcg_gen_ctpop_i32);
> +}
> +
> +static void gen_abs32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
> +{
> +    gen_wrap2_i32(tcg_rn, tcg_rn, tcg_gen_abs_i32);
> +}

I'm squashing in the following trivial fix:

--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8324,12 +8324,12 @@ static void gen_ctz64(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)

 static void gen_cnt32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
 {
-    gen_wrap2_i32(tcg_rn, tcg_rn, tcg_gen_ctpop_i32);
+    gen_wrap2_i32(tcg_rd, tcg_rn, tcg_gen_ctpop_i32);
 }

 static void gen_abs32(TCGv_i64 tcg_rd, TCGv_i64 tcg_rn)
 {
-    gen_wrap2_i32(tcg_rn, tcg_rn, tcg_gen_abs_i32);
+    gen_wrap2_i32(tcg_rd, tcg_rn, tcg_gen_abs_i32);
 }

 TRANS_FEAT(CTZ, aa64_cssc, gen_rr, a->rd, a->rn,

-- PMM

