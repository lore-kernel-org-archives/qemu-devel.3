Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15E3C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a84-0000zJ-Tk; Sat, 12 Sep 2026 22:39:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7t-0000BH-5o
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:30 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7p-00016x-5M
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:28 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cc4be0e5351so1563780a12.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267163; x=1789871963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cWYVLRU/fhFxnZHKLR/te0Zhy6vPraVqY3BQNvFc01E=;
 b=Fte4JTpuMT3/bSpgDK0vVvJ/NGKZqFvEtuHhpRr/1CAWN9tix850OXnwSnJg3xFR0Q
 hptxoOw9M75IwirPUSL+jams1QgDTmKt5a666wewCyMIgAmlstPRRRRNhp2zmQ2oEnME
 f/G6mDegVeT96v465HvU4oesd+z/RIKTXADQHSGAJi+ELfXHDkmnYMfR85zhMlnMfDWR
 HXFFaBMn0jEf2xCfRfNUYUu/jqS3cBDwzAI2Oq6ljAJnw+16AO9VoTYfaZJifCnovf/Z
 8GiTbpaducvD5FG31ZkGP1Zsjkig37+opi+6f+bIC3Dg5ontZwxfTxu9QPIFaMeg6L0G
 O5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267163; x=1789871963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cWYVLRU/fhFxnZHKLR/te0Zhy6vPraVqY3BQNvFc01E=;
 b=g5zwOLKGNBkcFnWN73orHLbmY8Jutsxq+H/qvBoNNRgBdRx94r7v0rbrp4Eljhi5xM
 h4Mzj+khZz7lYDCH5q6BjTEBMzS+G63YKbt/feHACKIGSxp1OO0kiPB7kHtif/PCA9Fe
 aVu/uiBLmk14hTu9y7ekmbKNh4bH8qTT6ExWOhWx4drXvIHhQf5E+2J9l3ykMwXcT8cT
 aeU2ZX0ocwd5NmjOMxYr7ZohxM+3BD0B4JgVuUSa7en3fcICJhZWKlyliFSyl5TPeO1x
 VvE56LTZ+BBNEDCWUx9EwPGXhII0jgnFtAdk0TX5/1ZFRaUPcwQl9K2DM6djYxUbYBO9
 sV+A==
X-Gm-Message-State: AFuF++liPNDJt04HET08Zeohfi8tib52/LhDZmxbzelccvBz9Fg/hm60
 EZ5b4GqYGVoDhycpgAMUJLpjsp0e3SUC3ifDAgYvTQb45ib6Q0vVrxTrgamwFc0++IVza8iWucN
 9Ez+ZEqs=
X-Gm-Gg: AYBFou1sKoDrDQgY4gYol65ce6RDIe+rFPQMRSiAtgirkpK7YlIV8IGwqcCCUJ1Is9R
 RzK4S3By6bB1SN+/sCqH5pRiDOH9zM4xXkXJ/4oDCQm0M7njCUQOE43T78A3W29gQ3cjNcm2LpO
 NwNGfkQoAedggc4WKvkXrF+D9yRKqUTPR8eyzS/FBX0I34coTGUOruwTDOhcyGTq+qv8xFcNJc3
 vADhpe3xWXF4mafLwxx3/JMCZfzqXChpjg613LfyJ8foeHlxbU8mI5EQk2LAsBTvnDG2p7Qrf8i
 wc3+1CKwSbpnf6Xa3oBhNjxCq9YevxehMgVrYsKyClxDDwoGOFiFOIYRE67fImy1tZ5FbijW6xr
 Mt5+8O80R87ULHg583kAWUQAcuuwvl3GcYXUGo15KGV+psw7ZVzdcdwJ5mhFB3AgtzD2qK6+LsZ
 fCDMu6PQaX9xFVZVexGRQvy1zXwvr+sbYeU/euDZWNboC7DG01iq2YdGFeWq8dssh3FaQSjIB9f
 /G0FqmR
X-Received: by 2002:a17:90a:710:b0:39d:c3bb:98e7 with SMTP id
 98e67ed59e1d1-39dc3bba118mr4821955a91.6.1789267163073; 
 Sat, 12 Sep 2026 19:39:23 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.39.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:39:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 38/86] tcg: Generic expansion of tcg_gen_brcondi_*
Date: Sat, 12 Sep 2026 16:37:49 -1000
Message-ID: <20260913023837.741866-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 20 ++++++--------------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 2817089b62c..68bcb297b33 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *);
 void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
                          TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
@@ -218,7 +217,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *);
 void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
                          TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index d2bbf9ba017..63e87c8313b 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -6,6 +6,7 @@ DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
+DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 70e2443f562..2bb5427f668 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -477,6 +477,12 @@ static void gen_brcond(TCGType type, TCGCond cond, TCGTemp *src1,
     }
 }
 
+static void gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
+                        int64_t src2, TCGLabel *l)
+{
+    gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -741,15 +747,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *l)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_br(l);
-    } else if (cond != TCG_COND_NEVER) {
-        tcg_gen_brcond_i32(cond, arg1, tcg_constant_i32(arg2), l);
-    }
-}
-
 void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
                          TCGv_i32 arg1, TCGv_i32 arg2)
 {
@@ -1540,11 +1537,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *l)
-{
-    tcg_gen_brcond_i64(cond, arg1, tcg_constant_i64(arg2), l);
-}
-
 void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
                          TCGv_i64 arg1, TCGv_i64 arg2)
 {
-- 
2.53.0


