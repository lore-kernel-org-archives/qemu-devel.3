Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FE4E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL32f-0008Rs-LC; Tue, 10 Dec 2024 11:24:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL32T-0007ur-3d
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:24:48 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL32N-0007YF-UC
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:24:44 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-53e3a37ae07so3469702e87.3
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847877; x=1734452677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OMQODLqfyrvJTt7Lk1K/EtG7UVPb+CtVlPyHLcmR18I=;
 b=IPEGobOF9fKYsiZxFIMaKWDQDmvofUIV+zT/TVRLmK70gUUT3MLAc0avKRatpU1eYh
 LQ6EI7aepX4hEiP+mPtl4g4mIuJha41nBXmq5wtinuyCnsPXOt8JkMsWr/jN7ONBI8cn
 xfJjWJw2H1QW2kpKPPqBUAYR8t4rOOOlFQZ7qsqJXecP3BvQUrCjmBOcSzHSxthqSoAa
 nFW1wM84B2DYdgtbHD7hhk02fF6k+uzAnSOK/owxzs8lbXvq0vmoQHLAb+BtVI+I2NDs
 IPVASApyn9Wp8Z9tfcGwIM5K/S3opO0kQ+w4bTqbx30vg4lau1F9Z9DydoHX+bH2LwLd
 Ek/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847877; x=1734452677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OMQODLqfyrvJTt7Lk1K/EtG7UVPb+CtVlPyHLcmR18I=;
 b=aoOYpjzOW5ReTvjg1s2z2mHiKh0r/GwuH/6FmbIOL1Gud2RLBr3YCxOw1cxyIrU2p8
 41+QJ3OwhHhFIiIwKnVzE4kvKCpXVtZYBqreeqVlLhmE6Z5OB3L2UYH+SZ2vNY9clQ7F
 X+6wf4Eb0hGcmkp0i2G01EdoWEULwy+mZI4lzNSwcShYvFRVKkoyGdFZeC93D25nHvoR
 CMEYy7EDwFgBRdieiCmBACKYJN/aE0lt9DKLFoD1Us6n6d6iU+6xiV2QTV5D4vDKHusR
 VTzSff/8KLnX6zXK8l9zwuadMC8gOV0CQocRS5/7/2uFulRSOGN5q8u5o2fcUbRMI0uj
 /FvA==
X-Gm-Message-State: AOJu0Yx9hjSE6/yz52bx68CYv2JhxY6ygUkI657rc9eXSFpRkfB3xReO
 QRbhYtoVWvSrL3ehD9A8QaiSi4rom7jPZwercLr+aoB9fXl8PexhRSPcs5K9FDDvNH8kCGdhALb
 CKwfV/Mo4
X-Gm-Gg: ASbGnctKAT4TpVOBLDVvKMWj1+GwJH1ZPOOUE+nm2TGwwazA7oAATuwPrQE4mNzDJD9
 367SrbH992W0WUx6Kf65BEeyWYKxEdVkwLhX++hvl2TIftHnjn0hWWPyhesDW2u7oxjqJT0SM/H
 zWXkdqZ1G7zqNS461rVsGv/NMcWe+uRc4gcCMzhPl8dHSahG5+ZoP7Dq+09cERRag7W5S2OqDfQ
 evoc+hbaU5CFtwoMy1z9MOrP23t5v0ttVnw+da7U47qq8GtbeqssdkB38s=
X-Google-Smtp-Source: AGHT+IE+F9m7A9OGLB3Ns7l5pNEQmXv/jbICYJKMz1OD3XuHeSJ3LVWzuxV5DAxX8SDszm8vVFrxeA==
X-Received: by 2002:a05:6512:3a85:b0:540:1d58:da75 with SMTP id
 2adb3069b0e04-5401d58dc6emr3139181e87.14.1733847876750; 
 Tue, 10 Dec 2024 08:24:36 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5402960b0absm26024e87.102.2024.12.10.08.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:24:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 58/69] target/arm: Convert FCVT* (vector,
 fixed-point) scalar to decodetree
Date: Tue, 10 Dec 2024 10:17:22 -0600
Message-ID: <20241210161733.1830573-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x129.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c |  4 +---
 target/arm/tcg/a64.decode      | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 71f1d6f778..894befef4d 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9535,9 +9535,6 @@ static void disas_simd_scalar_shift_imm(DisasContext *s, uint32_t insn)
         handle_simd_shift_intfp_conv(s, true, false, is_u, immh, immb,
                                      opcode, rn, rd);
         break;
-    case 0x1f: /* FCVTZS, FCVTZU */
-        handle_simd_shift_fpint_conv(s, true, false, is_u, immh, immb, rn, rd);
-        break;
     default:
     case 0x00: /* SSHR / USHR */
     case 0x02: /* SSRA / USRA */
@@ -9551,6 +9548,7 @@ static void disas_simd_scalar_shift_imm(DisasContext *s, uint32_t insn)
     case 0x11: /* SQRSHRUN */
     case 0x12: /* SQSHRN, UQSHRN */
     case 0x13: /* SQRSHRN, UQRSHRN */
+    case 0x1f: /* FCVTZS, FCVTZU */
         unallocated_encoding(s);
         break;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f7fcc32adc..f66f62da4f 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1682,6 +1682,25 @@ FCVTAS_f        0101 1110 0.1 00001 11001 0 ..... .....     @icvt_sd
 FCVTAU_f        0111 1110 011 11001 11001 0 ..... .....     @icvt_h
 FCVTAU_f        0111 1110 0.1 00001 11001 0 ..... .....     @icvt_sd
 
+%fcvt_f_sh_h    16:4 !function=rsub_16
+%fcvt_f_sh_s    16:5 !function=rsub_32
+%fcvt_f_sh_d    16:6 !function=rsub_64
+
+@fcvt_fixed_h   .... .... . 001 .... ...... rn:5 rd:5       \
+                &fcvt sf=0 esz=1 shift=%fcvt_f_sh_h
+@fcvt_fixed_s   .... .... . 01 ..... ...... rn:5 rd:5       \
+                &fcvt sf=0 esz=2 shift=%fcvt_f_sh_s
+@fcvt_fixed_d   .... .... . 1 ...... ...... rn:5 rd:5       \
+                &fcvt sf=0 esz=3 shift=%fcvt_f_sh_d
+
+FCVTZS_f        0101 1111 0 ....... 111111 ..... .....      @fcvt_fixed_h
+FCVTZS_f        0101 1111 0 ....... 111111 ..... .....      @fcvt_fixed_s
+FCVTZS_f        0101 1111 0 ....... 111111 ..... .....      @fcvt_fixed_d
+
+FCVTZU_f        0111 1111 0 ....... 111111 ..... .....      @fcvt_fixed_h
+FCVTZU_f        0111 1111 0 ....... 111111 ..... .....      @fcvt_fixed_s
+FCVTZU_f        0111 1111 0 ....... 111111 ..... .....      @fcvt_fixed_d
+
 # Advanced SIMD two-register miscellaneous
 
 SQABS_v         0.00 1110 ..1 00000 01111 0 ..... .....     @qrr_e
-- 
2.43.0


