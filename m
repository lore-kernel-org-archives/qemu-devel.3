Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11A0C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAklP-0003qy-42; Sun, 27 Sep 2026 05:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkn-0002ZY-DG
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:01:03 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkki-0007Tv-Hw
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:01:00 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-398cb5615deso1777299a91.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499648; x=1791104448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nLZm8imcHYP3MmNyyrT/6Tgh8krLzRwA9UuKRdi5XAA=;
 b=Nx7V+gDVOUjGr6GscpmnrkF4itogskPPu2MHm6Ow19KIUZ6cUaQ7azGSMNje3f/hRa
 l6v42eUAzKLuJUwXZUO80orvWPbOr3it0NMe2/ynbaSFJtTg3rTv2BHKYn/HvifwSEdH
 pxkWqDBh/86CEHg9owM1wPmbDTk/xRroASarjUBh0jZwkmbmp+Vm1Ak51SIaMWmTa50N
 +7K9PW/vk8DSbX0TL7qCjTdNxr8NsfrkRU2rGuUIANa5Gh0okGMypf+hYT6fWCnVPB3V
 n8c/cLO0saT+PGyGuMifgF3bKi9Ofk6Ine5Lz1d79NaebRyQt2rqlYnF6kfs8IRR0Ij6
 cfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499648; x=1791104448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nLZm8imcHYP3MmNyyrT/6Tgh8krLzRwA9UuKRdi5XAA=;
 b=fBOoBNVQ1oEWPlJcoDvaFwl6aTeZxgBRlkchf586yvAxSIDk6Pd9u1++hmRlllnzLy
 rLynEhQt1R14yuXeeOIjOE+wrb//JRKALRDnFTlNtLY5H1CXBYe/GlVStijoBoyYSlKs
 lsclGXjiVOQ5n4FkB43x3HKGUBjmZ0qojyLMIq4elYgPytwo2f9bz73toiawV2uyliA2
 LUFoMKuZWYnL57rwAx+DtoTZJUzeUkbcnHCgq6/sKj7U7E3/T3mhtZ9xMxMiTwYpy6IG
 D3TKrRNCPMOUqfC5mINKiPscshbNj6AoB3eia6MnEawIPdjlh/Y7JIEaMQeZyfe5e6CF
 Y4XQ==
X-Gm-Message-State: AFq9FYLmYZV/PBRg4h5G0zyiL1nyr4Cgvxc2WhvfL9v3xR/DyHl1n3KV
 qmDMFpX2LCwYcS1gfqrygtc/aVYsOkzGpo4P179rG9LqVYXTZ9AIKj2K6JhrJe4UODjbHXbXYTx
 F78vR
X-Gm-Gg: AYBFou1CdOKvv5sfZZKUPlhk23QZpSsjg3+ndDWWA/NwQBqa+1dUNKp2z/QNsdk9ddp
 YNH9D74H9RCtF56HjbBZNBipMhjXz1P5ACCqoW6wz2qZFYhu1jOn6HlnmPLJl3qOz5zz87J8vEW
 HFbo8uG7evnIy4qzq0xgaDwkLw8A5ceHMy3Ieyxenpr2AClzcZM3ytcXF26Ld8BOMnGdZrqI74c
 J04aTEZHZ0m0s0URfxBkmxMDm0GpgT2CZCZJZnnHnyaPFLj9Hj5sBCwBnBogJzHJorlHbm3U3S7
 lxk804VVM3wPbwQQ0UbXlYBa+UQ1QnssKTDudZNgqtGo0eLlamotD+ZkwSY5h2blyovgxZ70ByU
 lpsnbM9MqgNv31bT7eUoPC1ScshHziH3GZFl/QnSp24xXUTrMSq14By8WUXYroLITQj0H0lZNXh
 KvfqAJeHJmsGAekVTWbUKFE9vrzVSTfyoDiKShwBJj4LYpckfYJQv3iYgWsnz3A84PY4wxjPzrj
 uxdA0K8CRSH2FWvUfNtmuS9dLJ8LQ==
X-Received: by 2002:a17:90b:4acb:b0:398:b1eb:136c with SMTP id
 98e67ed59e1d1-3a098d43e23mr8696967a91.9.1790499648174; 
 Sun, 27 Sep 2026 02:00:48 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 036/101] tcg: Generic expansion of tcg_gen_divu_*
Date: Sun, 27 Sep 2026 01:59:06 -0700
Message-ID: <20260927090011.10724-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 tcg/tcg-op.c                 | 42 ++++++++++++------------------------
 3 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e1457b3f584..ce31b0d971d 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -203,7 +202,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 50d725b72c5..1b108d9f147 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -7,6 +7,7 @@ DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
+DEF3(divu, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 0304f8e15cf..a4bdf1143e6 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -426,6 +426,20 @@ void tcg_gen_div(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_divu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_divu, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_divu, type, dst, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_divu2, type, 0)) {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        tcg_gen_op_ttttt(INDEX_op_divu2, type, dst, tmp, src1,
+                         tcg_constant_internal(type, 0), src2);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -645,20 +659,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_divu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5_i32(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
-        tcg_temp_free_i32(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I32, 0)) {
@@ -1539,20 +1539,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_divu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5_i64(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I64, 0)) {
-- 
2.53.0


