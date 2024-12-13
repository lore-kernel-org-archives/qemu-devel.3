Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72D5E77183
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:34:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9Y6-0008Mc-1h; Fri, 13 Dec 2024 12:33:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9XA-00072C-8B
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:00 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9X7-0001Wv-Ei
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:58 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so11937005e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111176; x=1734715976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eaX6KljypzYLDCkXE/78gtp4RnXR8b1xmtguoFNogMg=;
 b=Unnyc63jgLBZPO42xV5hX0GP9aWCTxw8wOakQSJU8jJuyGECA2XK4PjjmXP2/SjkzD
 sFU4rhHuOXjwJfYzt6cV/q27Dy4PHbhNu0+VhDQNkzSHtakxSBFCA2EI3RU4wvHF08jB
 4pdFWqww0QkH/zOkNJPADxXY+ILIsf3ZjLrmi/f4+8+OuG4M9qIkZeeHyrrhaE4yUs3v
 +nR3FwAroitqJwWFZlERnWVS4eu9OabcFM8JJe7L/6Mf/P60naR2/21wwbH/rLQpMwRy
 yr0R3jkWRhjdD3Y5oyYUcCkbLdhveZM4yEYSnvbaVG7AnjnpbKBihsFyaOB5LT9Z2nf/
 hI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111176; x=1734715976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eaX6KljypzYLDCkXE/78gtp4RnXR8b1xmtguoFNogMg=;
 b=Rz+1k+zVMAemzYBb7pevzgRcatg9RRVd5fjFerKiqlJoaKgxl6E5nbfUdMAmDXwhNE
 DtNzcyA77mabkmWoK1g5aKoGliHIZENtzVTutvLo0E92iBfqGMl5nqP638YSYJuAk3ba
 r/1T/rCgsVueJQPou/vPvocHlLZLC/ACbulM4m+XAJR+QFlcEUH6V8xHSESFlptrObv9
 21iQ0cQKMHhQn4NQ7Ov5vJuW0Ov1fZkf2mOhhYCITFjEcKaXvmfy67gC90cYo3oR6+d3
 lwP0gM8zDCGGy/u6+IXkPoDOvIYjSIZD3+NXaJ5WclYHU5FUDLdZgquksNRdBUoxl2X8
 fgCA==
X-Gm-Message-State: AOJu0YwglsJjfHmOzGGPYoPrNJ/1OGDVCXK5TL0vl+qPos3fNmVu4GYi
 oXGJMFyJwHVQ5ha8aBvFfLOu8wd3Ng6UL5quC7adlMKWCFuydJctv+qsMVxYgjEQ5Ue+Svw3eYa
 A
X-Gm-Gg: ASbGncsXhEqa2NguHgRqs9yly+502S7Yy7uhIKQY/aR6nGQmpxoq2+knOLSp34fzRnN
 QUq4bH2LGivaFikhJ3knd4k+0z/kV943AM8asUBbPSB2G9lkEqukJylrNbSOWT95WqbkYpcS8K/
 eNK9uuk/Tz4KVXpLWKThusHmCDMaRyZmS+2mYFaXAp4kGk5yZZzl5dljiMr7teY9POzF+sLEfF8
 2mylImPBytRIghwaar7l8+gj/njSGu/w14hpwVmzxTtr2NpqMflyKDlbtxOAQ==
X-Google-Smtp-Source: AGHT+IEhRgm1llJMVtMrjwlOCZ6x9j2Jxt5gAI8aAUy+YBY5GOUQKRVWuLREC8xmBKav/ftZk0DCkw==
X-Received: by 2002:a05:6000:4709:b0:386:3803:bbd8 with SMTP id
 ffacd0b85a97d-3888e0c4d35mr2809601f8f.59.1734111175963; 
 Fri, 13 Dec 2024 09:32:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:55 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/85] target/arm: Fix decode of fp16 vector fabs, fneg, fsqrt
Date: Fri, 13 Dec 2024 17:31:27 +0000
Message-Id: <20241213173229.3308926-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

These opcodes are only supported as vector operations,
not as advsimd scalar.  Set only_in_vector, and remove
the unreachable implementation of scalar fneg.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20241211163036.2297116-24-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index a99f3d0d135..3c1784593a4 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10816,10 +10816,13 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
         break;
     case 0x2f: /* FABS */
     case 0x6f: /* FNEG */
+        only_in_vector = true;
         need_fpst = false;
         break;
     case 0x7d: /* FRSQRTE */
+        break;
     case 0x7f: /* FSQRT (vector) */
+        only_in_vector = true;
         break;
     default:
         unallocated_encoding(s);
@@ -10877,9 +10880,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
         case 0x7b: /* FCVTZU */
             gen_helper_advsimd_f16touinth(tcg_res, tcg_op, tcg_fpstatus);
             break;
-        case 0x6f: /* FNEG */
-            tcg_gen_xori_i32(tcg_res, tcg_op, 0x8000);
-            break;
         case 0x7d: /* FRSQRTE */
             gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
             break;
-- 
2.34.1


