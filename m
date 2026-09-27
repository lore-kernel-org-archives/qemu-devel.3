Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAAF5C98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAksF-0006pN-An; Sun, 27 Sep 2026 05:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrH-00026t-Dy
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:47 -0400
Received: from mail-pj2-x0d.google.com ([2607:f8b0:4864:39::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrF-0008FR-Fv
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:42 -0400
Received: by mail-pj2-x0d.google.com with SMTP id
 98e67ed59e1d1-3a0b6200eb0so1603278a91.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790500060; x=1791104860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z+B0hqdtNJw2hTCS/123O1p/aL9KGAye9pteDfVSO3o=;
 b=v+HR2Pu4E1L086STarqro8GDBm4ez+MF6xVrc6P67bHzQvw+c/xV8I3Qjx69hJM6Gc
 OY0169MRQsyPLzSYjaI76na9QEu1As5wf2xzU96lU2exrC7SxFGYTV21xVyLzkkQOr/9
 BGZGA5PZc8yTKohlP3TCxVVKfMQNEtP/d/NYbezgHk0UlGBLgWESsbOXzqrfWbyu6G78
 l8aMk+MtiQnpIZMZFYtUik3ghSuRh8uqZ2exU5UjmedaUrAuSt77/bput0QlpNh+iWNO
 1rpu6wuowsQgp7nMjD2uh/G7KEJSCmoEd6R0wPxaULOb72JvbARZcpQ5a/4e0BdCtBv6
 QB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790500060; x=1791104860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z+B0hqdtNJw2hTCS/123O1p/aL9KGAye9pteDfVSO3o=;
 b=n45ujsMGT08jYEJspuc3ZN1U5tw4Ug7SyticmuDhu9o9cgZmnZ7L5/mwZdsMDh64Y4
 8jDP7SRfFKNg5Xv/riVdX7IORGT1Io/scJrmvTA8G/9FsrZPZMWRNKKeMq4Fch7aNZ0c
 DVOpNKukR75+AkjXZCzME7za7VD38s+WLqoYY9/ZapJntnucNfihpKv8at4mTlZ8vshY
 xBZ34sMyrZgrPY9YkAZq2LowzwNuay7zWvxOS3fx86pvIxXg8GP93Wezk1rCLCPlTr6V
 yryPFJluU1jvQrmdFmKgxTZYBBfgzJnJ60Zlr27R865iC/woCgoZe05kJmFELKcA0uaw
 lUcQ==
X-Gm-Message-State: AFq9FYJ92DhKMlj/9Y8MoLh66UxuChsXzNaS4uxHh3dg7WlhmItUz53y
 v7YfxT36hcIbq4b0Cdcq46QqJ71AFJA7zlE9sPNfU6t8BUmdF+bdq8tkrSFyFaqzd8clTzvmVqz
 b1BKC
X-Gm-Gg: AYBFou2EIZdoEWRPbLxwSHT8CLhodjJ+dEebUQyjiUsARQ60xS0OwixnKbCXJCGbBMS
 jrQwtrsmUgHWEuzf1n9FVNDEfx9ApkgRSAS0g25v+B7YIH1CdZgDiflcxH2zbERbqAdNYXshPDk
 YGFuPRAIsZXR72MQQzAumw9DDYYxButuo/rWlScsZvQGreJtF2KvfXjRVyVXlQdoqQr+haWBimc
 YXqlwkCkGBjCatbHeJkgIbzeI6f39S5W7+nMsPXdbQfu04UgaVpERtSx85bbKgd8t+wLOORyrbi
 Qwcpuom7O716sNJ1wtGtyhJsT9WR1XTjfa9qbGI1oCnAh0GeqGoRbts7VH61qStpI8IZtDTWpug
 eoGkzpjlOJjVNAGDqNb32/4MyU2pAuTiykuHNEtOp2OZDoKxGTi7ud6tJjocv+5DQ6ly7WRwfcD
 wYnSMTxW9JrzPexXP+hQTSfZ28V90RAExoZnz6uWE+o5IuFTwi1FI4RoYry822o3avPWkaKrV4+
 EnEXRQakKHnw8yeQsEZrCjZdceg/r8=
X-Received: by 2002:a17:90b:1643:b0:3a0:345a:3646 with SMTP id
 98e67ed59e1d1-3a0bb62f2d3mr6108657a91.45.1790500059570; 
 Sun, 27 Sep 2026 02:07:39 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e7036e3bsm7144984a91.13.2026.09.27.02.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:07:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 080/101] tcg: Generic expansion of tcg_gen_add2_*
Date: Sun, 27 Sep 2026 01:59:50 -0700
Message-ID: <20260927090011.10724-81-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0d.google.com
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
 include/tcg/tcg-op-common.h  |  4 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 64 +++++++++++-------------------------
 3 files changed, 20 insertions(+), 49 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 9cc941478ba..0a1ff0c5b19 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,8 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -160,8 +158,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 003384b65df..e9f0b971a2b 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -4,6 +4,7 @@
 DEF2(abs, TCGV, TCGV)
 DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
+DEF6(add2, TCGV, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF5(addcio, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index eb59bc37631..0f478e65861 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -346,6 +346,25 @@ void tcg_gen_addi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_add2(TCGType type, TCGTemp *rl, TCGTemp *rh, TCGTemp *al,
+                  TCGTemp *ah, TCGTemp *bl, TCGTemp *bh)
+{
+    g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+
+    if (tcg_op_supported(INDEX_op_addci, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_addco, type, t0, al, bl);
+        tcg_gen_op_ttt(INDEX_op_addci, type, rh, ah, bh);
+    } else {
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+
+        tcg_gen_add(type, t0, al, bl);
+        tcg_gen_setcond(type, TCG_COND_LTU, t1, t0, al);
+        tcg_gen_add(type, rh, ah, bh);
+        tcg_gen_add(type, rh, rh, t1);
+    }
+    tcg_gen_mov(type, rl, t0);
+}
+
 void tcg_gen_addcio(TCGType type, TCGTemp *r, TCGTemp *co,
                     TCGTemp *a, TCGTemp *b, TCGTemp *ci)
 {
@@ -1148,28 +1167,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
-{
-    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_addco, t0, al, bl);
-        tcg_gen_op3_i32(INDEX_op_addci, rh, ah, bh);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_add_i32(t0, al, bl);
-        tcg_gen_setcond_i32(TCG_COND_LTU, t1, t0, al);
-        tcg_gen_add_i32(rh, ah, bh);
-        tcg_gen_add_i32(rh, rh, t1);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
@@ -1657,29 +1654,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
-{
-    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_REG, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-
-        tcg_gen_op3_i64(INDEX_op_addco, t0, al, bl);
-        tcg_gen_op3_i64(INDEX_op_addci, rh, ah, bh);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_add_i64(t0, al, bl);
-        tcg_gen_setcond_i64(TCG_COND_LTU, t1, t0, al);
-        tcg_gen_add_i64(rh, ah, bh);
-        tcg_gen_add_i64(rh, rh, t1);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
 {
     tcg_debug_assert(n > 2);
-- 
2.53.0


