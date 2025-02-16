Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF20EC021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 00:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjS6g-0007mI-VG; Sat, 15 Feb 2025 19:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS6K-0007eY-5n
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:36 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS6B-0006Hr-Ow
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:35 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-220c665ef4cso48861225ad.3
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 16:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739664086; x=1740268886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ArewPxzX2L3g8+NIrXN+9y4T1awyV4Vx9ORorXETkQs=;
 b=kPUSOGRxGNhMkyGdJlq5lElnWpmdGLVho7flvtsJoIsf6CEQun5yS5DizUE1yB4yvU
 zAhF/HcjRyx+NSAf01E3YVYpK8tD/LKbsJSh6mW/hykeH5iAQtwvh5hM3fDDEcpxviCN
 72Rsr2bt9640aqcEWiB9LC9cMx764AdgPicwnt5iJCHdwsZuYbTUV76fL0cd7HiONPkU
 kzQug9Ap6hT/5qqwYFUgoz9huAzKmu9r8ZmMeYoAQLUw0RdHioipYgwE9N0AJkh6yI74
 94pyY6DdcL6gt5u8Zr2GJBzyXwmgXkH3JE9ooig4Q0trNUSpFjnlSCgG9exz98gv4HlF
 mh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739664086; x=1740268886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ArewPxzX2L3g8+NIrXN+9y4T1awyV4Vx9ORorXETkQs=;
 b=PIB0NNc9wgG69osAz3KRopq4a8izSno9qwEZRkOuIs4YyjJ+wUCzpInjEKoeEvk/fn
 ru+wHjPexqurYvHeZU2kiNLzSjr3sfYXMJwtCGtzzO9/wbSLPCvAua9NBYJpl47irU45
 zm3q0CTImh3h1139YDAyGjS4LCpviA/u2goWW4SRWXZ5u1+Gf39e6oWUPa1Eg2d9GOU/
 gyw1YbV4/PHi4bhEtSsVY4mpmAiYISYDEAPps7zrW+9xDoqLHD4GqBhJQrrHm0oO/dnC
 P0aKhMrlwXzvFtGlxvxbkZykcpLUs0EehWghiL1/m6Sv4+zEEROxazZ4k0ezVXjIJIyo
 pv5A==
X-Gm-Message-State: AOJu0YzIxYUZqNGcPAoF7x8okAXdj0HuXRvcH5Y3GB7rfYCRb2y8I/22
 LuaYv2UWD3CQTw9++Blz1toNJfo9DJsMiHBzCVgYVVx2JEn9yJK8PGrhk1uEGY9En7FlPly+Bf5
 M
X-Gm-Gg: ASbGncvt4s6M/rqbAsUWaEHNoBm7eWWg9ObAbSSFYRTPr7OT2M7aISlyihPrdsjpxPV
 1xZo892GmRFQO4B28Yt+r98P+qTpshp6kQR1AgXWy9mLh1Yez2XrU0blSTNNDxMMaCMvzyssVHB
 ss/n8fb2uLNksFgQhFMwoiiIuFfuIF908YCBWppnhZ69UXXuflHNvgBR+5Bgx9ouWZLks7SA1Tf
 eIpqcEAYwqxUo1JpJJyVawvt5e4CrA9HOPdwLuvUDQDJcss2q98Cpclr0cTdF+kKKrzOIoF6iND
 YvVdgIvmGHfn6wvvtFmqw0dpQ196Rxm5I1bvhQFYV8yR2o0=
X-Google-Smtp-Source: AGHT+IFkVCPedCwJZd4/1Xcafr+HkPrN7dADOJNNfFBFgBjtRzBpdHw94p1N+LDTxoK9pWXhDVo2lA==
X-Received: by 2002:a17:902:ce82:b0:216:725c:a137 with SMTP id
 d9443c01a7336-2210405a4c5mr71024615ad.28.1739664085561; 
 Sat, 15 Feb 2025 16:01:25 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366729sm48960315ad.79.2025.02.15.16.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 16:01:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/24] tcg/sparc64: Use 'z' constraint
Date: Sat, 15 Feb 2025 16:01:03 -0800
Message-ID: <20250216000109.2606518-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216000109.2606518-1-richard.henderson@linaro.org>
References: <20250216000109.2606518-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Replace target-specific 'Z' with generic 'z'.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target-con-set.h | 12 ++++++------
 tcg/sparc64/tcg-target-con-str.h |  1 -
 tcg/sparc64/tcg-target.c.inc     | 17 +++++++----------
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/tcg/sparc64/tcg-target-con-set.h b/tcg/sparc64/tcg-target-con-set.h
index 434bf25072..61f9fa3d9f 100644
--- a/tcg/sparc64/tcg-target-con-set.h
+++ b/tcg/sparc64/tcg-target-con-set.h
@@ -10,11 +10,11 @@
  * tcg-target-con-str.h; the constraint combination is inclusive or.
  */
 C_O0_I1(r)
-C_O0_I2(rZ, r)
-C_O0_I2(rZ, rJ)
+C_O0_I2(rz, r)
+C_O0_I2(rz, rJ)
 C_O1_I1(r, r)
 C_O1_I2(r, r, r)
-C_O1_I2(r, rZ, rJ)
-C_O1_I4(r, rZ, rJ, rI, 0)
-C_O2_I2(r, r, rZ, rJ)
-C_O2_I4(r, r, rZ, rZ, rJ, rJ)
+C_O1_I2(r, rz, rJ)
+C_O1_I4(r, rz, rJ, rI, 0)
+C_O2_I2(r, r, rz, rJ)
+C_O2_I4(r, r, rz, rz, rJ, rJ)
diff --git a/tcg/sparc64/tcg-target-con-str.h b/tcg/sparc64/tcg-target-con-str.h
index 0577ec4942..2f033b3ac2 100644
--- a/tcg/sparc64/tcg-target-con-str.h
+++ b/tcg/sparc64/tcg-target-con-str.h
@@ -16,4 +16,3 @@ REGS('r', ALL_GENERAL_REGS)
  */
 CONST('I', TCG_CT_CONST_S11)
 CONST('J', TCG_CT_CONST_S13)
-CONST('Z', TCG_CT_CONST_ZERO)
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 527af5665d..7c722f59a8 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -76,7 +76,6 @@ static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 
 #define TCG_CT_CONST_S11  0x100
 #define TCG_CT_CONST_S13  0x200
-#define TCG_CT_CONST_ZERO 0x400
 
 #define ALL_GENERAL_REGS  MAKE_64BIT_MASK(0, 32)
 
@@ -340,9 +339,7 @@ static bool tcg_target_const_match(int64_t val, int ct,
         val = (int32_t)val;
     }
 
-    if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
-        return 1;
-    } else if ((ct & TCG_CT_CONST_S11) && check_fit_tl(val, 11)) {
+    if ((ct & TCG_CT_CONST_S11) && check_fit_tl(val, 11)) {
         return 1;
     } else if ((ct & TCG_CT_CONST_S13) && check_fit_tl(val, 13)) {
         return 1;
@@ -1579,7 +1576,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
     case INDEX_op_qemu_st_i32:
     case INDEX_op_qemu_st_i64:
-        return C_O0_I2(rZ, r);
+        return C_O0_I2(rz, r);
 
     case INDEX_op_add_i32:
     case INDEX_op_add_i64:
@@ -1611,22 +1608,22 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_setcond_i64:
     case INDEX_op_negsetcond_i32:
     case INDEX_op_negsetcond_i64:
-        return C_O1_I2(r, rZ, rJ);
+        return C_O1_I2(r, rz, rJ);
 
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
-        return C_O0_I2(rZ, rJ);
+        return C_O0_I2(rz, rJ);
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
-        return C_O1_I4(r, rZ, rJ, rI, 0);
+        return C_O1_I4(r, rz, rJ, rI, 0);
     case INDEX_op_add2_i32:
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i32:
     case INDEX_op_sub2_i64:
-        return C_O2_I4(r, r, rZ, rZ, rJ, rJ);
+        return C_O2_I4(r, r, rz, rz, rJ, rJ);
     case INDEX_op_mulu2_i32:
     case INDEX_op_muls2_i32:
-        return C_O2_I2(r, r, rZ, rJ);
+        return C_O2_I2(r, r, rz, rJ);
     case INDEX_op_muluh_i64:
         return C_O1_I2(r, r, r);
 
-- 
2.43.0


