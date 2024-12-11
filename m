Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E82BEE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPRw-0000Ea-0G; Wed, 11 Dec 2024 11:20:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRr-0000CK-Uu
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:28 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPRq-0007gJ-1v
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:27 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38637614567so2143481f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934024; x=1734538824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q41LJZFRzxatWl3ymykPA+glM4cmXQHmBtmZ8EVJ7Yg=;
 b=oS01Cv2PeLR20IGgJvf1ZfMcVzMB1SOkd6W9mB0qrS8yM3pcjU5d/zLMAxxJWDUmmp
 O5mzdCWGq1DNVxRkUoUH+S+JxCA0XAUA5WvTu2Q65WV7yl2/ixT+ugwwv6PWwPdjGTvE
 kbgOpP9QQFE+szbsrGgJReshsDyFVwmqJdSOB16SeGH/r2GDTZ54dx9qF6PWxnDS2U7x
 adoS1QzS3LSN1vyMrU0XDJbTcmXEpZOfSCjdDCQ1s7N0tfP9bsJ/xhq4LfmitnWv/PsW
 nxxfbDkH/F9JgNmo5nhtCKmOHyshPEzSOQwOVOj18NraxHkxPNh6+/IPsr8YahBU5ESe
 fecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934024; x=1734538824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q41LJZFRzxatWl3ymykPA+glM4cmXQHmBtmZ8EVJ7Yg=;
 b=lhxFcvnBoaIpJrmH0jSZsu3w5EPJZH7XA4hgPQ8ucGu8JFM4y7F9tt+FlgsOvPMW6Z
 T7NJdseZpfskG1BrGT+Gx55RSCNrX4kzIIjD/4va1Hf9VeOoEMV7b9t96JfiurSPDwIq
 BsoYL85qTOuvxZv18uvU44sXRaLkZD3A/5MtnW0H7A0GVD1lWnvnSrtUPLKGDVsgSApW
 lwLagAhWJKmyitP6aRRf3ZEJhvW6YJ8buAhcKvyutN7v8h534FAL5j20BNlbi557khb0
 a4E+dcwi80S1iXDRO202aqf6DvP0En8A/k135wYAKXUUX8SKEH7ACZ9pJVUzBX1KZ5dt
 cX7A==
X-Gm-Message-State: AOJu0YwMX87Unk6LDsX8pHS6eWgOoVv/lIjpc7qBQqUbZrkEyYOHgwk5
 San1PiJYmHABVe4bZDIxEleOTDuBUdZlkcNoQHyTQHOcMQflxtmUS2l5XnVQW1bBTO2BBA1y3KD
 X
X-Gm-Gg: ASbGncsOPBJ8d4gJTYez0QXnE46JQrj2NOhEkO+xPfSVSh+rrz9F6a7yozIbno/NWsn
 X52qdNHM4mthpUh/jNVJiHKQLNpJYF7EPFy1I5XQGr1GONT6T/KxL8zK5RBzFf6DFNEMfSG3CK/
 swXkqfHB8kcpAK5ghkg6j9eHVVgF2JynGa5+XeoT0jXFPGN59yKaIYmpqZzZGdW1w+BQCc7upSh
 ec8FA1OzWxluIAS30WTjDY4/ph7bXk1BzvWOyaGRORimFSqsDq5uvyXySra
X-Google-Smtp-Source: AGHT+IF6yG8Dbxn7WO8xMckPDEI7e9Lg8HZUfKJ2JNsGaEd7teknIksC1eXnU+6aR83qMgO9pC+dEw==
X-Received: by 2002:a05:6000:440f:b0:386:373f:47c4 with SMTP id
 ffacd0b85a97d-3864ced2f29mr1901185f8f.49.1733934024602; 
 Wed, 11 Dec 2024 08:20:24 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:23 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/72] target/mips: Set FloatInfZeroNaNRule explicitly
Date: Wed, 11 Dec 2024 16:19:05 +0000
Message-Id: <20241211162004.2795499-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

Set the FloatInfZeroNaNRule explicitly for the MIPS target,
so we can remove the ifdef from pickNaNMulAdd().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-9-peter.maydell@linaro.org
---
 target/mips/fpu_helper.h       |  9 +++++++++
 target/mips/msa.c              |  4 ++++
 fpu/softfloat-specialize.c.inc | 16 +---------------
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/target/mips/fpu_helper.h b/target/mips/fpu_helper.h
index 7c3c7897b45..be66f2f813a 100644
--- a/target/mips/fpu_helper.h
+++ b/target/mips/fpu_helper.h
@@ -28,6 +28,7 @@ static inline void restore_flush_mode(CPUMIPSState *env)
 static inline void restore_snan_bit_mode(CPUMIPSState *env)
 {
     bool nan2008 = env->active_fpu.fcr31 & (1 << FCR31_NAN2008);
+    FloatInfZeroNaNRule izn_rule;
 
     /*
      * With nan2008, SNaNs are silenced in the usual way.
@@ -35,6 +36,14 @@ static inline void restore_snan_bit_mode(CPUMIPSState *env)
      */
     set_snan_bit_is_one(!nan2008, &env->active_fpu.fp_status);
     set_default_nan_mode(!nan2008, &env->active_fpu.fp_status);
+    /*
+     * For MIPS systems that conform to IEEE754-1985, the (inf,zero,nan)
+     * case sets InvalidOp and returns the default NaN.
+     * For MIPS systems that conform to IEEE754-2008, the (inf,zero,nan)
+     * case sets InvalidOp and returns the input value 'c'.
+     */
+    izn_rule = nan2008 ? float_infzeronan_dnan_never : float_infzeronan_dnan_always;
+    set_float_infzeronan_rule(izn_rule, &env->active_fpu.fp_status);
 }
 
 static inline void restore_fp_status(CPUMIPSState *env)
diff --git a/target/mips/msa.c b/target/mips/msa.c
index 9dffc428f5c..cc152db27f9 100644
--- a/target/mips/msa.c
+++ b/target/mips/msa.c
@@ -74,4 +74,8 @@ void msa_reset(CPUMIPSState *env)
 
     /* set proper signanling bit meaning ("1" means "quiet") */
     set_snan_bit_is_one(0, &env->active_tc.msa_fp_status);
+
+    /* Inf * 0 + NaN returns the input NaN */
+    set_float_infzeronan_rule(float_infzeronan_dnan_never,
+                              &env->active_tc.msa_fp_status);
 }
diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
index 2023b2bd632..db9a466e05b 100644
--- a/fpu/softfloat-specialize.c.inc
+++ b/fpu/softfloat-specialize.c.inc
@@ -489,21 +489,7 @@ static int pickNaNMulAdd(FloatClass a_cls, FloatClass b_cls, FloatClass c_cls,
         /*
          * Temporarily fall back to ifdef ladder
          */
-#if defined(TARGET_MIPS)
-        if (snan_bit_is_one(status)) {
-            /*
-             * For MIPS systems that conform to IEEE754-1985, the (inf,zero,nan)
-             * case sets InvalidOp and returns the default NaN
-             */
-            rule = float_infzeronan_dnan_always;
-        } else {
-            /*
-             * For MIPS systems that conform to IEEE754-2008, the (inf,zero,nan)
-             * case sets InvalidOp and returns the input value 'c'
-             */
-            rule = float_infzeronan_dnan_never;
-        }
-#elif defined(TARGET_SPARC) || \
+#if defined(TARGET_SPARC) || \
     defined(TARGET_XTENSA) || defined(TARGET_HPPA) || \
     defined(TARGET_I386) || defined(TARGET_LOONGARCH)
         /*
-- 
2.34.1


