Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60976C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Jq-00014F-6y; Fri, 28 Aug 2026 18:45:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jo-00012w-OR
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:04 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jn-0004Nh-7f
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:04 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so1517077a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787957102; x=1788561902; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k7apDi5G/qgt0uMemM+43oBLUrsOqwhkU7pSrCFTWHc=;
 b=GhxucXPOkjW2jbfqUrprWJ31C00sNarSq+X6Pef7MeUlzkRcjV3D4RVpl59b5M8ghq
 1kZkXOy+16hAkFoks5ioS8sDR/ahEanDyKxlH2rNq+qfjlLmWAW2R7dd0169LphpqAbQ
 d2zC1IC4O7eju0yXxXNDZurrMPOW/ER1BX+ST0hGDikNM/ieRz7FVaqBmii35NGt2XHm
 5kIbPQZQ9ecg8HYhTlxGB5RJhVfIhM4/gpGbsT8liQqjsYhjKf3sH3OyfGW/JBujxHVZ
 iVAPhkrw3qyuMA7tWU0G95SoTJUkIgrCSLCAlWmrejHj1dB7KIDJTYBAiN16fpXyCxPW
 o58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957102; x=1788561902;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=k7apDi5G/qgt0uMemM+43oBLUrsOqwhkU7pSrCFTWHc=;
 b=IpMTRAuNclYG5FXHsOREqXnKXlY8g/7ff6HVLR2W5qX35NxhfGdA+vHOd5kR2awwf7
 Lzjjo7Xa1LNcs1MlO9BS7Kf8WacHULRiobK8/JgGFUWtzT2LkA3gTePQQqmrbNMpmY3f
 fE65P0fnkO8w/Bdi5CKu+3RQBdohS6x6Idq649UpkLG5VjtV0PvQtMwFZDVpIXWxcLwG
 5FEJHDXxRVAo6X6wsquQ94hx/zSZw/Ti7IGm3TnqyPNDto1dGF4SKEdUWflLGRG2oXv2
 kDrd1iBwAk5ydN2QCZaHrFZgCqZwycdRIYemV9gtToVUmA/t/qCMVqTzYRA2gaMZP7qG
 61tQ==
X-Gm-Message-State: AFuF++lMln/XQMAy3DwDNa5ghskO+Omu9JXZsArg7tuOHvKoxW1EWT2x
 tmfiWtcPzdeeTGw+7j7q/mcgOMNoiTUvXhHFMA87QE/FbFnA/zdzY47OhM+JstZJGovp8T3Ax47
 /EqqZSlA=
X-Gm-Gg: AYBFou1pUzxbCAAaNFBpWEHgda5VYfVYrUoHO+CDclPt/8gDQkGuWamZZIq6t1/DbCt
 +T7P7yR27fFUy/oPL0TA7bF/92QMU9NS61rABJeUp/PvlMkSOyhMrxQVymZQGB3N6tOn2oGjrKf
 3LzqKR2HCHOoCxZtjeTow5NVRDXfYT3e0m4M9eWmNCV7ntuxatM9dYk0YwncIBo9VVO4sgNXdW5
 kfdz9Wg58NvHfu5Bjnbrf7+35Z/5+UcoYbMy+7HWFmKc3sRFZ54NDh2Z60wgtwZFpcKyhAjAIho
 xZ0E2o+nJdDEdvz2UpTdenxriEcWizA6lBDuUz6Xn6HzXST1JFWnteoX27zUCVt/C5P5/Ixd4bW
 DcwArUEFpl1imwy1P1CYPGkiafQC/UnrjCz7jP7cKX5qEGhjDPLm2wd1uemNR0Je6F/gKmRonmT
 K3fofNyWQ/boImhP3gTvoVTHdS4a2hcCkTU6eJF6Rz3nPTB1dg7F99kn3kbrClKKEFM6GcPOIkf
 9M+UW5sLegUVYzRctlX
X-Received: by 2002:a17:90b:5405:b0:38e:67e1:15b with SMTP id
 98e67ed59e1d1-396d0de4c19mr18190924a91.6.1787957101344; 
 Fri, 28 Aug 2026 15:45:01 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-398a2f5187fsm427594a91.1.2026.08.28.15.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:45:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH 11/16] tcg/x86_64: Implement INDEX_op_lea
Date: Fri, 28 Aug 2026 15:44:46 -0700
Message-ID: <20260828224451.1564072-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828224451.1564072-1-richard.henderson@linaro.org>
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/x86_64/tcg-target-con-set.h |  1 +
 tcg/x86_64/tcg-target-has.h     |  4 ++--
 tcg/x86_64/tcg-target.h         |  2 ++
 tcg/x86_64/tcg-target.c.inc     | 11 ++++++++++-
 4 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/tcg/x86_64/tcg-target-con-set.h b/tcg/x86_64/tcg-target-con-set.h
index 458d69c3c07..5af8c1cb2cd 100644
--- a/tcg/x86_64/tcg-target-con-set.h
+++ b/tcg/x86_64/tcg-target-con-set.h
@@ -46,6 +46,7 @@ C_O1_I2(r, r, r)
 C_O1_I2(r, r, re)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, rO, re)
+C_O1_I2(r, rz, r)
 C_O1_I2(x, x, x)
 C_N1_I2(r, r, r)
 C_N1_I2(r, r, rW)
diff --git a/tcg/x86_64/tcg-target-has.h b/tcg/x86_64/tcg-target-has.h
index 6ffae51f923..4f06b395de4 100644
--- a/tcg/x86_64/tcg-target-has.h
+++ b/tcg/x86_64/tcg-target-has.h
@@ -105,7 +105,7 @@ tcg_target_extract_valid(TCGType type, unsigned ofs, unsigned len)
 }
 #define TCG_TARGET_extract_valid  tcg_target_extract_valid
 
-#define TCG_TARGET_lea_sh_valid(type, sh)          0
-#define TCG_TARGET_lea_imm_valid(type, imm)        0
+#define TCG_TARGET_lea_sh_valid(type, sh)          ((sh) >= 0 && (sh) <= 3)
+#define TCG_TARGET_lea_imm_valid(type, imm)        ((imm) == (int32_t)(imm))
 
 #endif
diff --git a/tcg/x86_64/tcg-target.h b/tcg/x86_64/tcg-target.h
index 7109722f240..3444bcdca0a 100644
--- a/tcg/x86_64/tcg-target.h
+++ b/tcg/x86_64/tcg-target.h
@@ -80,4 +80,6 @@ typedef enum {
     TCG_REG_CALL_STACK = TCG_REG_ESP
 } TCGReg;
 
+#define TCG_REG_ZERO  TCG_REG_NONE
+
 #endif
diff --git a/tcg/x86_64/tcg-target.c.inc b/tcg/x86_64/tcg-target.c.inc
index ec397e287c0..a41252782e1 100644
--- a/tcg/x86_64/tcg-target.c.inc
+++ b/tcg/x86_64/tcg-target.c.inc
@@ -3331,8 +3331,17 @@ static const TCGOutOpStore outop_st = {
     .out_i = tgen_st_i,
 };
 
+static void tgen_lea(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
+                     TCGReg a2, unsigned sh, tcg_target_long imm)
+{
+    int rexw = type == TCG_TYPE_I32 ? 0 : P_REXW;
+    tcg_out_modrm_sib_offset(s, OPC_LEA + rexw, a0, a1, a2, sh, imm);
+}
+
 static const TCGOutOpLea outop_lea = {
-    .base.static_constraint = C_NotImplemented,
+    /* Allow "lea imm(, a2, sh), a0" via TCG_REG_ZERO constraint */
+    .base.static_constraint = C_O1_I2(r, rz, r),
+    .out = tgen_lea,
 };
 
 static int const umin_insn[4] = {
-- 
2.53.0


