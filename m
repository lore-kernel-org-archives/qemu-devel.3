Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0BBD4A5F7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgagJ-00055l-N4; Thu, 15 Jan 2026 22:39:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgafs-0004xK-Lw
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:07 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgafp-0008G9-DD
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:38:58 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2a102494058so12857995ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534736; x=1769139536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dIX8M3PeuiegMB+HRi2DRYnSj2Vd5HpfS+cGE/3s+Sk=;
 b=oGGvkb8pZWfud1EdWtaFvycUoHpORCM43iLGz0yoFBMopIzvhwwSzUIgdoynn/itKw
 wxpF2h4qaPyc+URJ9SPNdzsek5dKedy2BBWrOSF9l3w5CCb4ZdiBMedpprgC8qZ9YDLZ
 +LooI6SpE9Xg5QLUTE2+h/l5zZFYnWcD8LHxLj3j2a4u8dgIjM+tT+mxUlWx7A8A7NFZ
 Ft2OokDLjGAeXRN+SR83yZhuYVj297fT5z8LxUT7tlhzM53bhcM1qP/XqGFcapPxRERg
 ebV28/KyCPeNBOZEeISncI3Zc3C0NYY6/IqaI4FXjaIqhROPvXIBjs1ySegPMnO2DwHg
 SXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534736; x=1769139536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dIX8M3PeuiegMB+HRi2DRYnSj2Vd5HpfS+cGE/3s+Sk=;
 b=meM3QCOhofCQCkr7Z+PM73UZlcY5iazdabQio/SSTMQMht9/N9DdU31ROiXoWIoUuP
 S7HLfuppRkOgvJLWThhkvPsWIjwUDNJr1Dxvm0vt7o0gnxu5UzX36BSbd1ywj0GTFFMl
 77hbQ7zHNO/Q1Ly9Ees940X1WSZdc0oR72Kc0eE6V3oqntZyfBWtHLa//WeR0Y5JdQJT
 CJBGDcTpvzeSVMhK0SfwC/FvIi/ywTiiP2B5+VEfGLcqekh6xD85HGHpHQ3A9baR4btF
 P+sMg1R8oEhylbud7uFRSAVd/SyAJVwjVG0IPpU6TboRc6lrasxDCFjhf46RIiXCE+2b
 8cug==
X-Gm-Message-State: AOJu0YzwNkv7/EZYqhHDi9AMwyH1FXsTmYc0gHmpWTuWTuDRC5H00s6j
 pMG4yA3uGXA+57FyHsaon1n65mkiyI1COvZEBwU6c0rTPVsGEsKk2QKX1SgFXk16C1/Xpgiuszu
 A5O1Wh81/4w==
X-Gm-Gg: AY/fxX7ZF8iu7Ru/QYDV7we0gHz9CNdjTxjCfCLU2wrLYqIwOcpyfDkikOBXRUbMrfU
 6GnFUePCp9xuWuoWk2CT60J4yQaOaJ/IZPqQv/5qWKLqMIwk3sU9aOzlEo05UDwTiY0vlpWvqX2
 eMIAacjaYyOe2KbaH/ZBMbQvwT6qSSEVubfdtL2fnbSbItNi/H6yR3srA22LzkNuGKT+gI5ZGUt
 pwoyQ4fOVE+2hrfLJFfxZXbkV+8pz8qJm9dKQwYZR23xj6emhDL5n3N731sxcspiakWoDh4s3lE
 DJmwGjCz8852nAvMZLoAbrUOaeAq2jRMke+i1SlmDknTk/3HQJHMPl7SqLOsgAnZjZ5KLnkGe1y
 jmCnxH9h9NP6GYYuqHuzjl3394JikNPd4WO2kdox3CXH3bRZIWNRgRlxPD4KCefGPkMyyFyvj0T
 A8RGM2qPHWH4PiCwX0Vw==
X-Received: by 2002:a17:902:f689:b0:29e:e5e6:247c with SMTP id
 d9443c01a7336-2a700a1abc8mr48501055ad.14.1768534735905; 
 Thu, 15 Jan 2026 19:38:55 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ca9d5sm6527975ad.25.2026.01.15.19.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:38:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 41/58] accel/tcg/runtime: Remove 64-bit shift helpers
Date: Fri, 16 Jan 2026 14:32:47 +1100
Message-ID: <20260116033305.51162-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

These were only required for some 32-bit hosts.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h |  4 ----
 accel/tcg/tcg-runtime.c | 15 ---------------
 2 files changed, 19 deletions(-)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 8436599b9f..698e9baa29 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -8,10 +8,6 @@ DEF_HELPER_FLAGS_2(rem_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
 DEF_HELPER_FLAGS_2(divu_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(remu_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 
-DEF_HELPER_FLAGS_2(shl_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(shr_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(sar_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
-
 DEF_HELPER_FLAGS_2(mulsh_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
 DEF_HELPER_FLAGS_2(muluh_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index fa7ed9739c..f483c9c2ba 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -55,21 +55,6 @@ uint32_t HELPER(remu_i32)(uint32_t arg1, uint32_t arg2)
 
 /* 64-bit helpers */
 
-uint64_t HELPER(shl_i64)(uint64_t arg1, uint64_t arg2)
-{
-    return arg1 << arg2;
-}
-
-uint64_t HELPER(shr_i64)(uint64_t arg1, uint64_t arg2)
-{
-    return arg1 >> arg2;
-}
-
-int64_t HELPER(sar_i64)(int64_t arg1, int64_t arg2)
-{
-    return arg1 >> arg2;
-}
-
 int64_t HELPER(div_i64)(int64_t arg1, int64_t arg2)
 {
     return arg1 / arg2;
-- 
2.43.0


