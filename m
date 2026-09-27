Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D7BC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkkJ-0002Sg-2v; Sun, 27 Sep 2026 05:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkB-0002Pu-40
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:28 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkk8-0007Oe-Hm
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:22 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396cccbba91so989576a91.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499619; x=1791104419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=47puM7envmbLsBYn4NN2JvYgQw7NFohb4tsZxNlNnyg=;
 b=Rp8zTzOMPClhimVn7fjcxZ4LMX4MvBnUAUAKfS+wtahT2y3xN6vQrq816BF8/CZpLp
 iXV5ykM2ZFunWDMFC2/BS+CDJbHgrfGNQiQ9UvBprQoVzkFjA8uTvVRHZntJ+0GkkKcH
 AyIJtJBVjg3fEUbwINyHtLYGbtkMeZYCH0cYhPnquhicguCk0irlweQjZ4FY+M9hcsRD
 7EvCg3FP+urhPE1c0wfOZl4DW43Lp7EuCzd14Or995KMAZmGbBGPC2qjEpyNKNRzrsfN
 p3LvqGDUNcJQFZojdnK/ssH90dv76Fa73AF03LlEim1ztLhOp6lv+115L8Vqk4Uqe0pA
 QmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499619; x=1791104419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=47puM7envmbLsBYn4NN2JvYgQw7NFohb4tsZxNlNnyg=;
 b=RTpdhXZTjVWLDB8lurIrH8ab0XBSbyN768k/iFNEX4idG4c9Edl7MpzATaOqfyXJKd
 IrQ6SiLt6kPxABH6Ssk61rg6tJDItE4vUICBt+P8t2ywxSfp9j6tDzpRgeuzVIS/Xtym
 wEpPx8ZDjX6VyFXSh9BmLUdvw9keLdIEkBCemTKVz6oO175YLbrEUKslUIEjigz1xU4L
 rf0wt1xVzGThDo1G0k47sDQQw2+aWyVWqN+GXfeNWn/CrgsDIfz7iyXXUZc5dWbpsJQ9
 /eFSEgXBJyEY+YXNi2EqalkWcNnTOWSOJyTHfg1xCv9R4VpeHzgwHvQdZAOgoUB+bPPG
 x/ng==
X-Gm-Message-State: AFq9FYIoJ1wmPRIGonSBljVlxtAo8YhUeh5t90wRAnVvi+IfFjhVwVi9
 PnEuPLdusfAKo53F5SE+S0NL2anePcSzrPTjNnmpca+Uv1K5OMHyFvwivMI2ghkU+c1/mIYAno/
 ssp40
X-Gm-Gg: AYBFou2STB3Eh9vwQTQPVEmQ12k/YKfEgSFv6vAk936wNPSckbXvbgG/9YvvMllMYs/
 uymhW0YxX0TE1Wql6uhM7BTJJ7pVGa5qMp/upGbKrUNyHlzX2j3WCqyJiy9PAGINAJm3pbqWp0T
 PLg81PirBbPSX+Cl5beUSOKdSRyFZjOpzzKhqe/AeO+5ECiIjf1XPPAKexmsX09qmx29sQmeENJ
 o45RXU9SKLvUTwJWOpAvYldK2y/c/K4oBU3CX3rdybXfdqetOl1mqcdOQMr8NcuCx4/z+pbtuSy
 95eTgX2Nr42birEALs+3lGUsZPj/CaUfj1bSRdSqpEe8WnMnBbSuTBn/MKcJun4cTD3C0ZSSdA2
 XGiQWgLSUPcQgLWn6cniUv3chnR6Y9JgaVYh4mIfVs20W6bu6C43BnKgAiCMUIib719scxF/wxF
 lgc6v8mMnWfCfifmCwGpSppYCmsySSiU3S3bki9g5nFIxtk3WmOyvZRIhSqBUGtsfZpG/wPe3uG
 y8XpyvfLLXqdq69wezKS3rkSUnhYjh7Yvy9Wtcw
X-Received: by 2002:a17:90a:10c1:b0:3a0:a18e:bc9f with SMTP id
 98e67ed59e1d1-3a0a18ecca5mr5438860a91.40.1790499618859; 
 Sun, 27 Sep 2026 02:00:18 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 006/101] tcg: Use QEMU_ALIAS to define most tcg_gen_*_ptr
Date: Sun, 27 Sep 2026 01:58:36 -0700
Message-ID: <20260927090011.10724-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

Now that we've dropped 32-bit host support, TCGv_ptr
is always TCGv_i64.  Do not drop the type difference,
as that's still helpful conceptually, but define the
functions as aliases, exactly sharing code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h | 99 +++++--------------------------------
 tcg/tcg-op.c                | 18 +++++++
 2 files changed, 31 insertions(+), 86 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 9b321f959c0..1e826b62574 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -497,95 +497,22 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 
 /* Host pointer ops */
 
-#if UINTPTR_MAX == UINT32_MAX
-# define PTR  i32
-# define NAT  TCGv_i32
-#else
-# define PTR  i64
-# define NAT  TCGv_i64
-#endif
-
 TCGv_ptr tcg_constant_ptr_int(intptr_t x);
 #define tcg_constant_ptr(X)  tcg_constant_ptr_int((intptr_t)(X))
 
-static inline void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
-{
-    glue(tcg_gen_ld_,PTR)((NAT)r, a, o);
-}
+void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o);
+void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o);
 
-static inline void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
-{
-    glue(tcg_gen_st_, PTR)((NAT)r, a, o);
-}
-
-static inline void tcg_gen_discard_ptr(TCGv_ptr a)
-{
-    glue(tcg_gen_discard_,PTR)((NAT)a);
-}
-
-static inline void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b)
-{
-    glue(tcg_gen_add_,PTR)((NAT)r, (NAT)a, (NAT)b);
-}
-
-static inline void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b)
-{
-    glue(tcg_gen_addi_,PTR)((NAT)r, (NAT)a, b);
-}
-
-static inline void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s)
-{
-    glue(tcg_gen_mov_,PTR)((NAT)d, (NAT)s);
-}
-
-static inline void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s)
-{
-    glue(tcg_gen_movi_,PTR)((NAT)d, s);
-}
-
-static inline void tcg_gen_brcondi_ptr(TCGCond cond, TCGv_ptr a,
-                                       intptr_t b, TCGLabel *label)
-{
-    glue(tcg_gen_brcondi_,PTR)(cond, (NAT)a, b, label);
-}
-
-static inline void tcg_gen_ext_i32_ptr(TCGv_ptr r, TCGv_i32 a)
-{
-#if UINTPTR_MAX == UINT32_MAX
-    tcg_gen_mov_i32((NAT)r, a);
-#else
-    tcg_gen_ext_i32_i64((NAT)r, a);
-#endif
-}
-
-static inline void tcg_gen_trunc_i64_ptr(TCGv_ptr r, TCGv_i64 a)
-{
-#if UINTPTR_MAX == UINT32_MAX
-    tcg_gen_extrl_i64_i32((NAT)r, a);
-#else
-    tcg_gen_mov_i64((NAT)r, a);
-#endif
-}
-
-static inline void tcg_gen_extu_ptr_i64(TCGv_i64 r, TCGv_ptr a)
-{
-#if UINTPTR_MAX == UINT32_MAX
-    tcg_gen_extu_i32_i64(r, (NAT)a);
-#else
-    tcg_gen_mov_i64(r, (NAT)a);
-#endif
-}
-
-static inline void tcg_gen_trunc_ptr_i32(TCGv_i32 r, TCGv_ptr a)
-{
-#if UINTPTR_MAX == UINT32_MAX
-    tcg_gen_mov_i32(r, (NAT)a);
-#else
-    tcg_gen_extrl_i64_i32(r, (NAT)a);
-#endif
-}
-
-#undef PTR
-#undef NAT
+void tcg_gen_discard_ptr(TCGv_ptr a);
+void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b);
+void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b);
+void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s);
+void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s);
+void tcg_gen_brcondi_ptr(TCGCond cond, TCGv_ptr a,
+                         intptr_t b, TCGLabel *label);
+void tcg_gen_ext_i32_ptr(TCGv_ptr r, TCGv_i32 a);
+void tcg_gen_trunc_i64_ptr(TCGv_ptr r, TCGv_i64 a);
+void tcg_gen_extu_ptr_i64(TCGv_i64 r, TCGv_ptr a);
+void tcg_gen_trunc_ptr_i32(TCGv_i32 r, TCGv_ptr a);
 
 #endif /* TCG_TCG_OP_COMMON_H */
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2c88f4f7ca9..b738863ea69 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2730,3 +2730,21 @@ void tcg_gen_lookup_and_goto_ptr(void)
     tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
     tcg_temp_free_ptr(ptr);
 }
+
+/*
+ * We only support 64-bit hosts, so TCGv_ptr always resolves to TCGv_i64.
+ */
+
+void tcg_gen_discard_ptr(TCGv_ptr a) QEMU_ALIAS(tcg_gen_discard_i64);
+void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b) QEMU_ALIAS(tcg_gen_add_i64);
+void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b) QEMU_ALIAS(tcg_gen_addi_i64);
+void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s) QEMU_ALIAS(tcg_gen_mov_i64);
+void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s) QEMU_ALIAS(tcg_gen_movi_i64);
+void tcg_gen_brcondi_ptr(TCGCond cond, TCGv_ptr a, intptr_t b, TCGLabel *label)
+    QEMU_ALIAS(tcg_gen_brcondi_i64);
+void tcg_gen_ext_i32_ptr(TCGv_ptr r, TCGv_i32 a) QEMU_ALIAS(tcg_gen_ext_i32_i64);
+void tcg_gen_trunc_i64_ptr(TCGv_ptr r, TCGv_i64 a) QEMU_ALIAS(tcg_gen_mov_i64);
+void tcg_gen_extu_ptr_i64(TCGv_i64 r, TCGv_ptr a) QEMU_ALIAS(tcg_gen_mov_i64);
+void tcg_gen_trunc_ptr_i32(TCGv_i32 r, TCGv_ptr a) QEMU_ALIAS(tcg_gen_extrl_i64_i32);
+void tcg_gen_ld_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o) QEMU_ALIAS(tcg_gen_ld_i64);
+void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o) QEMU_ALIAS(tcg_gen_st_i64);
-- 
2.53.0


