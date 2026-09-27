Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92739C9833F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkky-0002bk-Dd; Sun, 27 Sep 2026 05:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkO-0002Tx-7N
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:37 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkL-0007R4-S2
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:35 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-396ccdaea75so822207a91.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499631; x=1791104431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7ZIOT5msleyz4GOKF+0htr7qgfHv/fQ1qDfEQMwHhGI=;
 b=dUyM1D5GOy6/ZkfcDTXt2whjgmjPDbb2tf7EBHS1P8biqipBYJJzwyu6jjzILAdAfE
 4eGYcoFBmUWWZBZwqbt4TVEq3Ptgn5qK+p+Mt5H//Zf7npGHDKzXGTBINPHJSVA7LB3v
 H/b29hWkm9VbABCNdjeny8mFS/nyRrmafs5jUWF7HqLyL/s1wSdnqHNJnTwkRqVeAO8M
 AUxiQ5w1fYPElvNJHFh+92agg/B7F9cRGxwdN84IdqdB2yGCSqiMO9aOFDW/P7UWaDdp
 s65tWcXt6HFV0TeOSRdL0oIdvew7UEh6jq44NcdvQ9MZ5FE6+lCOP15Kx6cqT54aGeK4
 MDnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499631; x=1791104431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7ZIOT5msleyz4GOKF+0htr7qgfHv/fQ1qDfEQMwHhGI=;
 b=uSn5+ZHUBsAU0cc/gAoLXZP0xKgi2Lx2iG4s52UhCaIapbHJBhN4BQpyJXBsJvKjHV
 gaZY7wRKq9lDsbpaAJRM7XXwmUy9rEVy/7mOFBHXurWn2/dSAkJ+wjk01o6+DFGqBaOn
 Jl9RXyGIwFkDkJr/uGHMInav0Xj59xVvdW19zrCgzmlDXfq47XAVNmh99ekygdWZYxPt
 DV9mO3b41AOEtIa1MpoqxTPMkYj5NB275lFt+WZwMw0XjwDXuYsOuLGISwEMfxW5cv9P
 uIUKT/2UEb6HRLalylnz3wt4YYqjOOACgE/Sd3x5yop/JFXzJAp5yXjkl4OWP2rJQgeB
 pj/w==
X-Gm-Message-State: AFq9FYKqwxqvZUMrtT7WtWd+pO0TssfFtyM6+k9vtsYNklxdkDplOtwR
 oaMmKJnllsScGshg5uEFjKKM5mejIUD+vdSilPJm9tfprPFQuqIf8ZEBj/pKX235aDENMbYzMco
 4cCJW
X-Gm-Gg: AYBFou2HSy0Mrpb57B7bTceZjYh/i9MUGYSgL78FUISNkSDW5DEMlGWe2oeLkdmpGsj
 HeaxOp9CBBLjpcDKtSpSUveZkiYe6XXkzP+Nj3h+sSMto8SzQ0t+9xluRu6XlxJw0o36hHIB9or
 7B37bwd5Rp++5NXBmmMhoAXRH9ofUau4LBXe7bTOBXz7epXdvG2XwD8SxOOezSf1agFnZ/TYLKw
 wsNo8/J/AU8ehSzF19kjqYMZ3Mti/W1VF9kXdB+N8fonW49MFI8NOa6X+1F4UMFog4eEFyfnJRA
 h9ILhKI5Mj78X4pohgY4A78/1qOe6ERLeiNNAkKlTpRRiSFgJmOLs+joisEMLAEI2Ih2XOFUAGp
 X9WuBc8tHlI1UIGoz0qK5BAHKJIMweOOx59KmdnoY7EwZpucwP9lxOFctxhMjO7lBpAPDj48pn9
 dlKJ9iRVD+526wvauqiXJrNExc7gAouVDCSWqL6j6uHnrd22IBL8tdo2u0NaEVXkFN/LUbOwaOu
 kyT5T450rmR/HVjFx2gp6PyzbdoS766vNF8D3Pj
X-Received: by 2002:a17:90b:1dc7:b0:3a0:b7b4:b65e with SMTP id
 98e67ed59e1d1-3a0b7b4bae2mr3174663a91.2.1790499631008; 
 Sun, 27 Sep 2026 02:00:31 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 020/101] tcg: Generic expansion of tcg_gen_xor_*
Date: Sun, 27 Sep 2026 01:58:50 -0700
Message-ID: <20260927090011.10724-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
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
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index ba333d83958..81854b56f93 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -315,7 +314,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 8dd39290609..ad298b7e306 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -12,3 +12,4 @@ DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
+DEF3(xor, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 5fc7f1d02af..8c3f7dce815 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -428,6 +428,11 @@ void tcg_gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    tcg_gen_op_ttt(INDEX_op_xor, type, dst, src1, src2);
+}
+
 /* 32 bit ops */
 
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -472,11 +477,6 @@ void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_xor, ret, arg1, arg2);
-}
-
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1493,11 +1493,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_xor, ret, arg1, arg2);
-}
-
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_shl, ret, arg1, arg2);
-- 
2.53.0


