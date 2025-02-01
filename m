Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB34C0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGXz-000666-C0; Sat, 01 Feb 2025 11:40:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXn-00061W-TN
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:32 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXl-00014h-Fn
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:31 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso18601585e9.1
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428028; x=1739032828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4NQtpB/FauH0rtbCX6r0pw974wudG+5NfUJow/nkqw0=;
 b=p7EAfEVyymPhv9f5gIsSuL/c3uJ2d0jO4h/CRlrV9tG1dG2/UgREw7SDuQnRIMX1hv
 L+xXq7ebcMN4nzxUxSrvD6Az+T9RSlEpNFv1BayrdI6IzvfCEE029W6iu8C6PEL7VGAL
 7QcJLD229gl5rNx3BfkufMGQTsQBSPfUbqOg8LgMain4qEJaYOaiXP3Cauxdu+An1fxn
 MBZUhhm9Cw3c+oPGER+k4cNcdpHHv1a2B1YB9tDmMQW3MKO80Y0Ovzm4WkShyHW0TYbG
 K6tUXaBWyqa1TYnlEFY01aGtMyoCsyoTMzh5SXtmZUV4oNMN1TJ0heY7+vLCWVoCJxe6
 /q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428028; x=1739032828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4NQtpB/FauH0rtbCX6r0pw974wudG+5NfUJow/nkqw0=;
 b=YDb2XgGa55rTRxd9TzuXTrSz4h5IF4rYEI8uV1M8/ZU44FcLx3XlDz1ZpsFI94Ya4D
 qFJAr8x4xnRHuvsUgCMHk/Lp2+bs2wH5+JbS43pb+amzU6bkWsYjm1tIwptPuCYS1OdS
 8wLvz7njJcQ0p5dDScdicIXV1KxrZKZPkA/MJfxEbaDSeOTeeT0Bldte0bl/mR7iZOkk
 W7Ifqd4/qLRAo6nwvKzlWc6UuoBKWwrv/72Wt0kszUpgO/ebnwvuJfKYC8+Km63ylY41
 OX4RCXBr+u5T+c4r6lap7DPGfi9ir1KorfMyoyp5NN68Di13tPV4sK0tGuI9hdqUWw+l
 QJDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEIX1GUK1LvCG5YE7z8zu79jYhVfy5ZBboVaISiUJMYYikQKhwZRrnXOHDZd2z6rWDPZ5S3EAkmg8T@nongnu.org
X-Gm-Message-State: AOJu0YzSWsJW/fvmQN86MxNatHldeRb5H1t4zZ1OnE/LfwfiwrJ1Vm1y
 6rK5HSZgd7h8QAgqdIrUbsf/YcEeLmM4YwrEF7BfLrsnUwNMJ4QBMBHzqwTofvw=
X-Gm-Gg: ASbGncvz+DDKcDvEeK4q858pDI9y0KuZQDMJLDIXG0symtUkmtk0HTLB9z8JyCUA4Pn
 WPnr2lVbSvdodgx5OEl7tIedj6FY21lPecATTqbbfAYriSw6tF2s1Lk7jgJjLNNTtxeOoksPlin
 +dpoodXZ+qmwdN5JUEGxHDhBfnSnaxgyGkN3ExHGc5/Wo9np2VFL6GQJ9Ac3X7JxiuUHEBWBcar
 Of2uVvxnaBnZ+TFUgKZSZXWv1xUfUSndZS/5nHYGULct11caFTDlBGBGBCumlCtlDf/F65zgrwf
 rLUY5RpyW3h2VJKliDDX
X-Google-Smtp-Source: AGHT+IFgVt+AayM+4lh85Y1Et851Itva9n2Na7JRAMBaQf66IAGk0J7BexnIDq3JEVSE0nGmdwdv3w==
X-Received: by 2002:a05:600c:91c:b0:434:9e17:190c with SMTP id
 5b1f17b1804b1-438e15522bfmr91679435e9.0.1738428028045; 
 Sat, 01 Feb 2025 08:40:28 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 09/69] target/arm: Adjust exception flag handling for AH = 1
Date: Sat,  1 Feb 2025 16:39:12 +0000
Message-Id: <20250201164012.1660228-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

When FPCR.AH = 1, some of the cumulative exception flags in the FPSR
behave slightly differently for A64 operations:
 * IDC is set when a denormal input is used without flushing
 * IXC (Inexact) is set when an output denormal is flushed to zero

Update vfp_get_fpsr_from_host() to do this.

Note that because half-precision operations never set IDC, we now
need to add float_flag_input_denormal_used to the set we mask out of
fp_status_f16_a64.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/vfp_helper.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 62005e19524..57100e95378 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -78,7 +78,7 @@ static void arm_set_ah_fp_behaviours(float_status *s)
 #ifdef CONFIG_TCG
 
 /* Convert host exception flags to vfp form.  */
-static inline uint32_t vfp_exceptbits_from_host(int host_bits)
+static inline uint32_t vfp_exceptbits_from_host(int host_bits, bool ah)
 {
     uint32_t target_bits = 0;
 
@@ -100,6 +100,16 @@ static inline uint32_t vfp_exceptbits_from_host(int host_bits)
     if (host_bits & float_flag_input_denormal_flushed) {
         target_bits |= FPSR_IDC;
     }
+    /*
+     * With FPCR.AH, IDC is set when an input denormal is used,
+     * and flushing an output denormal to zero sets both IXC and UFC.
+     */
+    if (ah && (host_bits & float_flag_input_denormal_used)) {
+        target_bits |= FPSR_IDC;
+    }
+    if (ah && (host_bits & float_flag_output_denormal_flushed)) {
+        target_bits |= FPSR_IXC;
+    }
     return target_bits;
 }
 
@@ -117,7 +127,7 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
 
     a64_flags |= get_float_exception_flags(&env->vfp.fp_status_a64);
     a64_flags |= (get_float_exception_flags(&env->vfp.fp_status_f16_a64)
-          & ~float_flag_input_denormal_flushed);
+          & ~(float_flag_input_denormal_flushed | float_flag_input_denormal_used));
     /*
      * Flushing an input denormal *only* because FPCR.FIZ == 1 does
      * not set FPSR.IDC; if FPCR.FZ is also set then this takes
@@ -129,7 +139,8 @@ static uint32_t vfp_get_fpsr_from_host(CPUARMState *env)
     if ((env->vfp.fpcr & (FPCR_FZ | FPCR_AH)) != FPCR_FZ) {
         a64_flags &= ~float_flag_input_denormal_flushed;
     }
-    return vfp_exceptbits_from_host(a32_flags | a64_flags);
+    return vfp_exceptbits_from_host(a64_flags, env->vfp.fpcr & FPCR_AH) |
+        vfp_exceptbits_from_host(a32_flags, false);
 }
 
 static void vfp_clear_float_status_exc_flags(CPUARMState *env)
-- 
2.34.1


