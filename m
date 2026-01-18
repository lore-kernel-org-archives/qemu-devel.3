Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29E1CA5FE1
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhauB-0004zX-Ig; Sun, 18 Jan 2026 17:05:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhatp-0002rY-Td
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:34 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhatn-0000tV-Or
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:33 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a09757004cso33074655ad.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773930; x=1769378730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qmAp6PNa9duSslOM86Ejx4hWWn+4Ohddq0ga5kua76c=;
 b=G6bmK8iQa3cNfnXfBXj5/zujx9w+fDgZ8BEAnydVgbhEAXTgKyfNAJmsYmywSdW+CH
 IgMfdnRKBt1LgeaXBmleIRGF6I6d3EfLn+HAjOrPhvebmhxAJ73IT5/7BmNGWmpXuUwk
 gPBW1m4SDx6IwITvx0sjGoeqdp8oS8jhryUTsk7m6W/uicqQQ/IJG/ZjaiaOAOHc6t5D
 ylexRhuy44bhHxpyKZG4ztEgpHow5mPuIWdpv/98KIgpKdQQ5i6rbCYtauGuxYrMCP9r
 /oflwyCegKCNAC/4z7NlUl7NvSgUJsprJsq1aYuISlHuHySTEjDeGt4Z50BAig3vy0P9
 1rFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773930; x=1769378730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qmAp6PNa9duSslOM86Ejx4hWWn+4Ohddq0ga5kua76c=;
 b=tH6/oUy3aeikrDXh01ufOHL1qnPMaUn69BjYBokAEN5DkLn7V7eJY7/u//PcySZBfB
 devFWZlzSj+HKteD6B8WeGTGwasT+2c+YLAe4FmiNhD5sDVH2pVNtHf/rAEHPoSog94Z
 l5v+5RqHbBQUBKUdp3QIBimp2dYKaM6Z9MW3fM4S5lDUNV0kTflzckJw1DwnXlJFXa3F
 rabuX9fpcA1CPKENBKM417XjByZ1c0GCzygjbR0qAUYRhiOv/BqOd6AC0/W5ki898cdx
 t9gMGsCQx6BIVkfK/x1lktmrZO47m16bHaKQrN2MtPT4mnjH8kU4bcmFOzIYfL/2e02r
 sbig==
X-Gm-Message-State: AOJu0Yz8FlwqxB4cWe0DyD2HFAbWPFN1LuOvfrzW8xdDf1+AFAnag4KM
 CYx/mNLWY0TtZ+pLB0AEmTxJFMypp9ziAq6CC3WhF/eCytEW9fb0IJq5PbfiRGZ3Qxvcro/XnjM
 WmGPUN4n5Mg==
X-Gm-Gg: AY/fxX4uexuiR+2pMgrPnaq1JMhiAwdyT2ilB1woqHwdHPO3WMcVE9hRPgwkL7pvIcV
 LNZg+AIoHw//j1NtQc/TSHKGBDT6P17v1SB+B7h5YrLGG+VuRCzwIT6Lrcu8hhcdAzev4EkUJw0
 oVrVNL1mybm/2c0VXa+hs44oIPWFBi0CmlJXoDPs/dYncCM1r58prvSihzMlQwXr81J02PRje+O
 EkQpS5D2fqVnFzDT7J43kPQrqfRcpCZ4CKZfViGDx3h599b0foMOCpd22XuvjKK3RWSi4c7RMyL
 G7X7G1von9a39DHeu16ebiugYrYGWuQxOGXgWSxxTN8dr8WIrDF2bH7xhArqBNV7NWJ/jX0M4d3
 d7kmUhR7F3vJCIXZGXhdxRj9kjdG1mU+suFwuW66KOX2bVfDTZKPfapy0i7P9hLD+sW9itcSyMb
 AyikvpAgdBjrE4Q+ibpA==
X-Received: by 2002:a17:903:124f:b0:29d:7b9b:515b with SMTP id
 d9443c01a7336-2a717518f89mr86924745ad.20.1768773930402; 
 Sun, 18 Jan 2026 14:05:30 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:05:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 29/54] tcg: Drop TCG_TARGET_REG_BITS tests in tcg-op-gvec.c
Date: Mon, 19 Jan 2026 09:03:49 +1100
Message-ID: <20260118220414.8177-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 49 +++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 2cfc7e9409..bc323e2500 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -586,12 +586,11 @@ static void do_dup(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
         }
     }
 
-    /* Implement inline with a vector type, if possible.
-     * Prefer integer when 64-bit host and no variable dup.
+    /*
+     * Implement inline with a vector type, if possible;
+     * prefer_i64 with 64-bit variable dup.
      */
-    type = choose_vector_type(NULL, vece, oprsz,
-                              (TCG_TARGET_REG_BITS == 64 && in_32 == NULL
-                               && (in_64 == NULL || vece == MO_64)));
+    type = choose_vector_type(NULL, vece, oprsz, vece == MO_64 && in_64);
     if (type != 0) {
         TCGv_vec t_vec = tcg_temp_new_vec(type);
 
@@ -612,11 +611,11 @@ static void do_dup(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
         t_32 = NULL;
 
         if (in_32) {
-            /* We are given a 32-bit variable input.  For a 64-bit host,
-               use a 64-bit operation unless the 32-bit operation would
-               be simple enough.  */
-            if (TCG_TARGET_REG_BITS == 64
-                && (vece != MO_32 || !check_size_impl(oprsz, 4))) {
+            /*
+             * We are given a 32-bit variable input.  Use a 64-bit operation
+             * unless the 32-bit operation would be simple enough.
+             */
+            if (vece != MO_32 || !check_size_impl(oprsz, 4)) {
                 t_64 = tcg_temp_ebb_new_i64();
                 tcg_gen_extu_i32_i64(t_64, in_32);
                 tcg_gen_dup_i64(vece, t_64, t_64);
@@ -629,14 +628,16 @@ static void do_dup(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
             t_64 = tcg_temp_ebb_new_i64();
             tcg_gen_dup_i64(vece, t_64, in_64);
         } else {
-            /* We are given a constant input.  */
-            /* For 64-bit hosts, use 64-bit constants for "simple" constants
-               or when we'd need too many 32-bit stores, or when a 64-bit
-               constant is really required.  */
+            /*
+             * We are given a constant input.
+             * Use 64-bit constants for "simple" constants or when we'd
+             * need too many 32-bit stores, or when a 64-bit constant
+             * is really required.
+             */
             if (vece == MO_64
-                || (TCG_TARGET_REG_BITS == 64
-                    && (in_c == 0 || in_c == -1
-                        || !check_size_impl(oprsz, 4)))) {
+                || in_c == 0
+                || in_c == -1
+                || !check_size_impl(oprsz, 4)) {
                 t_64 = tcg_constant_i64(in_c);
             } else {
                 t_32 = tcg_constant_i32(in_c);
@@ -3872,12 +3873,11 @@ void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
     }
 
     /*
-     * Implement inline with a vector type, if possible.
-     * Prefer integer when 64-bit host and 64-bit comparison.
+     * Implement inline with a vector type, if possible;
+     * prefer_i64 for a 64-bit comparison.
      */
     hold_list = tcg_swap_vecop_list(cmp_list);
-    type = choose_vector_type(cmp_list, vece, oprsz,
-                              TCG_TARGET_REG_BITS == 64 && vece == MO_64);
+    type = choose_vector_type(cmp_list, vece, oprsz, vece == MO_64);
     switch (type) {
     case TCG_TYPE_V256:
         /* Recall that ARM SVE allows vector sizes that are not a
@@ -3992,11 +3992,10 @@ void tcg_gen_gvec_cmps(TCGCond cond, unsigned vece, uint32_t dofs,
     }
 
     /*
-     * Implement inline with a vector type, if possible.
-     * Prefer integer when 64-bit host and 64-bit comparison.
+     * Implement inline with a vector type, if possible;
+     * prefer_i64 for a 64-bit comparison.
      */
-    type = choose_vector_type(cmp_list, vece, oprsz,
-                              TCG_TARGET_REG_BITS == 64 && vece == MO_64);
+    type = choose_vector_type(cmp_list, vece, oprsz, vece == MO_64);
     if (type != 0) {
         const TCGOpcode *hold_list = tcg_swap_vecop_list(cmp_list);
         TCGv_vec t_vec = tcg_temp_new_vec(type);
-- 
2.43.0


