Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5FBC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhLc-0003YM-4t; Fri, 04 Jul 2025 10:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIJ-0005G7-Dw
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:43 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIG-0005hU-3j
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:37 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2ef8df09ce9so650191fac.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638893; x=1752243693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+5o41MPLL6siTUnGgQzMRLhBRZ8WRwHHp5dQcfQlvV4=;
 b=s6XUyBs2B7WJuiMhew3/1377AYD0le9WDaDvRtFfpPjzN4d52xbxSdXEKhGY445/kb
 y2O1pHK8qhfIWONiQlbC8dczJCZuS73Y7gO3JlP8I4/90rVErZbmw8gn2hg6Z31W5oCe
 GkbbXJn/FZulV22x6PLbWMUSILH+RgNB2RBpRv+dBrF1j5KN0sR/j90To968PAVJiUz0
 jv3xIVO260BMWyYr2stA3Arr3x5lzpkEXknhzFvwWOmDHl34fx8QSORFznpFPfUjYd4j
 J6V4G/oz4f5MiAgujCbWiZt/GlB+MACPG1kL1N69u52vcQNEY4keEbBCTYfZloJO6ey0
 QImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638893; x=1752243693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+5o41MPLL6siTUnGgQzMRLhBRZ8WRwHHp5dQcfQlvV4=;
 b=Apkui7krSfCikpfNgv8WfkD67NVNdxCviHqpMo4gVnja0o7ZAIXNQKHIXxO4h8lNId
 0bvh0e+PulKwr1/5EZZrnFongTLows0QLrQ2miAucDFVxI3XTW4BJSYqBQ0udkkV/J+n
 MW4F5NXS//Z8Xp2zAx4IYqxvwlPNAC1sBFE6Fd6wwSMF8EJl/psrUbbt+OLx+9JiNgib
 7/GXT2pgpkt7Oku6hQgZpRqLzAIpD8UuK/XU0Gji4bfOJmyDbyPALEFpotRiCL34Vo0K
 eANbWlJaHTxCFoOIoUiEs96MpWt8g8XoLrC3r6TPbxhfw41y3pyOfZOM/AccAEsFpOq1
 PJBQ==
X-Gm-Message-State: AOJu0YyKob6n6eZFMsMFroTCa+mSxwB1LjLfDoRP2bEmhB181CiIQ+te
 2SJi4tkiMYis88mlIXeql512NsaXo9oQIDag6u8FsHTx2l/DwfsUXuY09G6BkAniuw5Opl9e+kG
 Y37QMkZc=
X-Gm-Gg: ASbGncuyA9rvpxt/3qb6WHXcqoFuAaDlBKi7twXN6HVCrtXzbtqmonVfrxmuPUdxmgV
 hqNh/aMst/lAKmnNBaHlfLpjK0Wxt+kgdWhJZhgSpR8tZCsgjwcGP++qow7wevzMbbkQmyz+f1G
 dz487Dn9XSmiujIxU1VcNV6wVHAKSwXMv1Wm7ZfPo3rX+fIv54ZQL4lOjg09GwUgE6Ws7TO1y/t
 XydHdwW8w6ikdooDNY7P4WVY73MosYXx7+DnvrsKAPxWaz810LS+UdFcZK5UAxYvNAfffpXpNM+
 LQ/K2x8ZIc6xgYBVV8nZG62egM3duDt7lhh8Qcqph+UGpTSXeG34DyFJfPg8QZCehUKHwJyOlfC
 ND7AhnKYa1qqkl1ikT2/ptR66EuJEHp1KS+b4mhWhwS3Ves+vK+ACCD5a1eA=
X-Google-Smtp-Source: AGHT+IGZWW4Lpo0gpAvB8NIOGD+rwwWmOjq06xCm4l4/OgvAB/9FfIE8WBvg9rigoGUTaIP0FNKx8g==
X-Received: by 2002:a05:6870:220c:b0:2d4:ce45:6990 with SMTP id
 586e51a60fabf-2f7969bc3f9mr1720258fac.7.1751638893263; 
 Fri, 04 Jul 2025 07:21:33 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 017/108] target/arm: Implement SME2 ZERO ZT0
Date: Fri,  4 Jul 2025 08:19:40 -0600
Message-ID: <20250704142112.1018902-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/syndrome.h          |  1 +
 target/arm/tcg/translate-sme.c | 26 ++++++++++++++++++++++++++
 target/arm/tcg/sme.decode      |  1 +
 3 files changed, 28 insertions(+)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index 3244e0740d..c48d3b8587 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -80,6 +80,7 @@ typedef enum {
     SME_ET_Streaming,
     SME_ET_NotStreaming,
     SME_ET_InactiveZA,
+    SME_ET_InaccessibleZT0,
 } SMEExceptionType;
 
 #define ARM_EL_EC_LENGTH 6
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index e8b3578174..246f191eca 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -27,6 +27,19 @@
 
 #include "decode-sme.c.inc"
 
+static bool sme2_zt0_enabled_check(DisasContext *s)
+{
+    if (!sme_za_enabled_check(s)) {
+        return false;
+    }
+    if (s->zt0_excp_el) {
+        gen_exception_insn_el(s, 0, EXCP_UDEF,
+                              syn_smetrap(SME_ET_InaccessibleZT0, false),
+                              s->zt0_excp_el);
+        return false;
+    }
+    return true;
+}
 
 /*
  * Resolve tile.size[index] to a host pointer, where tile and index
@@ -130,6 +143,19 @@ static bool trans_ZERO(DisasContext *s, arg_ZERO *a)
     return true;
 }
 
+static bool trans_ZERO_zt0(DisasContext *s, arg_ZERO_zt0 *a)
+{
+    if (!dc_isar_feature(aa64_sme2, s)) {
+        return false;
+    }
+    if (sme_enabled_check(s) && sme2_zt0_enabled_check(s)) {
+        tcg_gen_gvec_dup_imm(MO_64, offsetof(CPUARMState, za_state.zt0),
+                             sizeof_field(CPUARMState, za_state.zt0),
+                             sizeof_field(CPUARMState, za_state.zt0), 0);
+    }
+    return true;
+}
+
 static bool trans_MOVA(DisasContext *s, arg_MOVA *a)
 {
     static gen_helper_gvec_4 * const h_fns[5] = {
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 628804e37a..dd1f983941 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -22,6 +22,7 @@
 ### SME Misc
 
 ZERO            11000000 00 001 00000000000 imm:8
+ZERO_zt0        11000000 01 001 00000000000 00000001
 
 ### SME Move into/from Array
 
-- 
2.43.0


