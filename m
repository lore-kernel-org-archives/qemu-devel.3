Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1558E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPhm-0001I4-Ea; Wed, 11 Dec 2024 11:36:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPha-0000rc-AW
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:36:43 -0500
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPhY-0002GZ-Kn
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:36:42 -0500
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6d8adbda583so77407136d6.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934999; x=1734539799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vsh0HImK6qshuStlPGIutoWf36EbUwjPxmaEEmMfZGk=;
 b=ZBs/2ZDzLBQMOCkSaOpM8cYq5D4xd+GrkbtanuDM8+OHXGJjGqlNxkMfLMeTcZCFeC
 g/uknhTQYyX+/w8MvgQ0d2tAE+qR39cKCOXHTmI4eQsDrP7wMcHj+nJ3MLCpx7iOQ/pb
 AQY1RxxS+0++SBoZ3nItf9qN6ciLFHmevw8Tru56A4trgsii2XHuiBSAMU8HyyrmuEsU
 UmWBfrOdMv70o8ZRu1s3izIwDMjOPEwvGmhzeu5PYVgDlL+Cm9SEd3iqGbHZqrJ/c8W7
 Vqw/ZXsBn8UjrItSQD2PLv1GpzRz1Qj5BbMdbX0FV7+FQRyQF19lp280BktZbsq9orZa
 UvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934999; x=1734539799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vsh0HImK6qshuStlPGIutoWf36EbUwjPxmaEEmMfZGk=;
 b=ZeWqFVmj7hqx5YlqIIkmWp7/FZ4rBRYTE1BLgmpXW7YSao5m26fGMnVKyV02SfUW68
 JqDRaHNlopywfNnFati88QomXn5ikC9aXgLrF+mmVeSFN9OPyk6Lw2GfWGGjJ3jaGs2u
 T/Ds4230HeVJ2k6lWKKItG3ftVvC8aM1cgIf7YTHu796tFpHWzmyWpO3nDI8XHSEXWDx
 2O1y1yDdTke7G9diAH2/TpKzRopnjuaAYm2IPegsGBBXHCBYBUvCeeK+q66ZK1ym+Bdr
 GBCGZShjrm/U7alyenPxVNc8omzOCHWkpV64JGMUuGpivnMEJgHUzxJVLwQzMlShnmlh
 NnRw==
X-Gm-Message-State: AOJu0YzFRWKDKo/ZPUpLVRWZnyA0YzEM374PrkueYOLJjaHUNgjkSh0s
 ZU0TD6C23/3lUH01iAFkVM97HaMdmZ42ue9aqM2+o+WK0S8cn6idWdRUrppHfj7gl7uQ7A9Duvv
 ykfbHFLvi
X-Gm-Gg: ASbGncvaCHSblrlKaf1b5rhjJw51vb+QlqSWDD0m0r+2hb4+5y6M5EW1TWK4YoH5o3b
 IsBzmgr+mTTIVdaPSmxtywKHGsAZdW7NldVP96cwMqgAY93ZRdJ9A27EPtsMzqyS4XGo/TC/MB7
 ESagdyo/2sRB/Q/1YCLdqAH7WXFiApf8q5VLBaTqm0EJYRHrgvGAyjOSO4Evizmf1YzKKgiaZjg
 EXr1zt5W/S1u87QWxClANnGZTA0Zzu30gIDU3FuniQC32zyyc+brxaNyG27fQ==
X-Google-Smtp-Source: AGHT+IGhCPpOTMTS/PO9iZbl9/NXM/vtmCh+kIwTOw1uXRvs2xoAKLAeXJwmZXp24doSpW0hx318mw==
X-Received: by 2002:ad4:5f8f:0:b0:6d8:9dad:e14b with SMTP id
 6a1803df08f44-6d934aec1e4mr63335726d6.13.1733934999742; 
 Wed, 11 Dec 2024 08:36:39 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da675214sm71856276d6.11.2024.12.11.08.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:36:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 58/69] target/arm: Convert FCVT* (vector,
 fixed-point) scalar to decodetree
Date: Wed, 11 Dec 2024 10:30:25 -0600
Message-ID: <20241211163036.2297116-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf33.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


