Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FA8E64A80
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIRPz-0002tv-ER; Tue, 03 Dec 2024 06:50:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tIRPu-0002qE-7o
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:50:11 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tIRPs-0002O8-K1
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:50:09 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5cece886771so9580565a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 03:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733226604; x=1733831404; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a0U68q73lW+pS6rFsjZzAewbIGZOTioH4eI5YcSNmaM=;
 b=NWRIRoOb2E9Fd+vM6I9dudlbZt6Cac3+rOe7AqH0+cwPSqQ/27QdhvB6lLFUZbhVqx
 Ou7umnCfcUL0l8uCvNtaX1tr6HSKdxTS5nT9VjcJyK4IiCSax514qPtWEenDmvAA83Yy
 3GA8zIKZdbwbCuDdq0WO3UVkeRU9r3AIYrkx9GA3Rzm3hlgSJOapL9DBMFGJiJ66qNtF
 3piaPqXGBLW/mV4ZjNuQ05uRB09ikdq1XwcQZOPj1xVuW0MSL8z2/Dky/RwwWC4fUq5E
 z8IyAFg4Zy777C/v4iV+9LiV0gU4RqC46MPPeMbWD+3jJuIu1QZvOcoR/Xb9x7cdYiBg
 Axew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733226604; x=1733831404;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a0U68q73lW+pS6rFsjZzAewbIGZOTioH4eI5YcSNmaM=;
 b=JoC+OJUUXqDlvJcMiAueY+SapvyL8DXonF/CpiQcvcX+N9gUOng8BklYyqU8Y++9ku
 EDZs5+amKQZu/I5YthCr59AFNKgaC/pU2lLmkQkdXXPk1EQvJx3a2JGJskGiHYp4Xirt
 ZXoymHBradHVEIB0QVgwG5w2eXbYz2sgNe5E8p02y1wNgDMZ/nLcrrukg64rtvUame4d
 +016xheXYanCefSY6ZhhNxn7fW4wdUkTVE+IGtp/sXKlzlHpdZslYeH2O4Tfg5lmn4K9
 EAo9x0HQsWJADQl0HQlf8J8p2QF+Y0tS7XSifjZB9LCxCP5lfErWoOjb4Wyd35Y6+Lpb
 Fhiw==
X-Gm-Message-State: AOJu0Yw5A9u8kvOB7CA3QuaiatrYISZiWNecd5HL+As0ZyB/Qr9IdLgu
 CwbqYerIiT8WFwFM1IWPgUMYkDVcoi+5o52A0zgCVgKNTU3GoOz6EHzf7Jpj22KpQq1TNJHda4K
 YjVJIxonWcbjC3ss+7X6V0sna1U/EYyph5Sw37w==
X-Gm-Gg: ASbGncuINiVbz5M5LZ6+64nsqAGt2l59qv9dl8PCA29OUJqKtDdVjkCCVsJGYvWIQmC
 bDllTOz3k2USugR8OtPMvWAzIZt8a0aKQ
X-Google-Smtp-Source: AGHT+IG9dFH1Eb7MOUTeFN1SRRudcD1dIuScX3yF0L0sDVI5lqPkJiYNsn3RfRU8hX+6OaWaf/U0gjl+l7PVrjijk1M=
X-Received: by 2002:a05:6402:4409:b0:5d0:b1c4:7081 with SMTP id
 4fb4d7f45d1cf-5d10c22f097mr2426610a12.4.1733226603063; Tue, 03 Dec 2024
 03:50:03 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-43-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-43-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Dec 2024 11:49:52 +0000
Message-ID: <CAFEAcA8CbQXg7D22SCyqT0oJAPZ1g7_yWJENZX3wKBOmp4r58Q@mail.gmail.com>
Subject: Re: [PATCH 42/67] target/arm: Convert handle_rev to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Sun, 1 Dec 2024 at 15:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This includes REV16, REV32, REV64.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

> @@ -10070,10 +10003,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
>      TCGv_ptr tcg_fpstatus;
>
>      switch (opcode) {
> -    case 0x0: /* REV64, REV32 */
> -    case 0x1: /* REV16 */
> -        handle_rev(s, opcode, u, is_q, size, rn, rd);
> -        return;
>      case 0x12: /* XTN, XTN2, SQXTUN, SQXTUN2 */
>      case 0x14: /* SQXTN, SQXTN2, UQXTN, UQXTN2 */
>          if (size == 3) {
> @@ -10276,6 +10205,8 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
>          break;
>      }
>      default:
> +    case 0x0: /* REV64 */
> +    case 0x1: /* REV16, REV32 */

REV32 is case 0x0, not 0x1, per the comments deleted above.

>      case 0x3: /* SUQADD, USQADD */
>      case 0x4: /* CLS, CLZ */
>      case 0x5: /* CNT, NOT, RBIT */
> diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
> index 4f8231d07a..2531809096 100644
> --- a/target/arm/tcg/a64.decode
> +++ b/target/arm/tcg/a64.decode
> @@ -73,6 +73,7 @@
>
>  @qrr_b          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=0
>  @qrr_h          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=1
> +@qrr_bh         . q:1 ...... . esz:1 ...... ...... rn:5 rd:5  &qrr_e
>  @qrr_e          . q:1 ...... esz:2 ...... ...... rn:5 rd:5  &qrr_e
>
>  @qrrr_b         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=0
> @@ -1657,3 +1658,7 @@ CMGE0_v         0.10 1110 ..1 00000 10001 0 ..... .....     @qrr_e
>  CMEQ0_v         0.00 1110 ..1 00000 10011 0 ..... .....     @qrr_e
>  CMLE0_v         0.10 1110 ..1 00000 10011 0 ..... .....     @qrr_e
>  CMLT0_v         0.00 1110 ..1 00000 10101 0 ..... .....     @qrr_e
> +
> +REV16_v         0.00 1110 001 00000 00011 0 ..... .....     @qrr_b
> +REV32_v         0.10 1110 0.1 00000 00011 0 ..... .....     @qrr_bh
> +REV64_v         0.00 1110 ..1 00000 00001 0 ..... .....     @qrr_e

This doesn't look quite right -- in the decode table in C4.1.96.21,
2-reg misc REV32 is opcode 00000, like REV64, not 00001 like REV16.

--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1660,5 +1660,5 @@ CMLE0_v         0.10 1110 ..1 00000 10011 0
..... .....     @qrr_e
 CMLT0_v         0.00 1110 ..1 00000 10101 0 ..... .....     @qrr_e

 REV16_v         0.00 1110 001 00000 00011 0 ..... .....     @qrr_b
-REV32_v         0.10 1110 0.1 00000 00011 0 ..... .....     @qrr_bh
+REV32_v         0.10 1110 0.1 00000 00001 0 ..... .....     @qrr_bh
 REV64_v         0.00 1110 ..1 00000 00001 0 ..... .....     @qrr_e

should I think be the right fixup.

thanks
-- PMM

