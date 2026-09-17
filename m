Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF643C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73kG-0003HP-2b; Thu, 17 Sep 2026 00:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73jg-0003A2-G7
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:28:36 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73je-0006m9-M2
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:28:36 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso536676a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619313; x=1790224113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=47puM7envmbLsBYn4NN2JvYgQw7NFohb4tsZxNlNnyg=;
 b=BcDzT8zgtBMS86FEffOyR0VSTX9GDU/6OYXgPpt6FPNK6KCeiPeF4rc+fR09eGHoq3
 MWPu6u90Ds+LeWyY1AryMqEboJKMTbQstwuXTuOwjdxOqsGRZRwjZGJEB48GCcidtrMM
 cu0KOUirBOQI2uwmLWpyAzBV3w+uV1U410k2Bppl0hWued0CBNOVyB+b6bfw4CipdyVI
 iJ55vi03Hs/RwJT+nBBr+Jf7VNJ7S8IOmnhMWwNL7vrOR3BxR+9xfjLcFdlGSzdf5We4
 zVhCgRNXYsEibIrvzOw9dYBve8xA5AjmH/cpBnZyk7MfYJDBpwpmgRmNiOvWZJ2mFvrx
 BmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619313; x=1790224113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=47puM7envmbLsBYn4NN2JvYgQw7NFohb4tsZxNlNnyg=;
 b=2MYbKxj0gq5zd2DYTIJNGEJB4eaL7HIngH3wyzo4Xlx8J5dEDUjOwKUkQvhVn8b7Gc
 anqIB3VySpC0hjr4vpbt0dAM72Crzn+bOrKFN1MiqTtAg6Y4ko8OFftBlThdVF7EF8x1
 mekdOl9HuoeX8kBA5Ll4RI/RXG5KUspZj061vf54lScyhukkKpdI+M8hhof3k3mROovr
 F3JOcYaWw6sl5jaS407KdA74h8d7YiIp0Eg4RHucg6BGdi2nuqpmMavUP2LE/rNUDX4I
 EkK/TLWv87nh1eMKcKEBj5bwTqHwaklxbDnZcuLNRWyLHcwrWVI30eZ/chEzT6ANuo1M
 dyhQ==
X-Gm-Message-State: AFuF++mkSP+Kz/nOzVg8BsI17/+jaEGbCR+B5KS46eln6WWaq1uA/6Bj
 n5+XXz43tmMTA805L31zUZK1SSGOQ91qo8vZW7tjeu00M2hH6KLBSd457jp/53FGlzGhA2e1Wj8
 uxWkNgRE=
X-Gm-Gg: AYBFou3mN1UWtmtYLFwPh8d7VIQAjg/5tT61uOuiOA07pw7zBC05d1KuJ8c9gN2kPca
 g7hVR6h/MfiA7Iq/tEEYvsr469LO3OXrylaGeENfebFAJBC1QZM/0sBQ513GTQo4xEtLTl5cPXG
 xKOB7pFT0sEo6jN5w9XgYROBOHvg3OMvOf8/pBRllF+RxAeqz9D4FddYIZhh3hM6v2CtTghGXyS
 vSMN0SDIPm7MOm/iL+QWBP7YY8IEHziejhi4wPsvpcJ2HJ62xFSK3cV8OCKIKTi6lccL+8smYlt
 16bN73aiYTEP46gb9QkwwmJINAbFzJACvxmvp3DWcsR/fCJ2UrfdwpYnQy1h/ZJrSnqXk16UkRW
 vHy90Mz10JBPxH7HP0MauWL8ahkWg2J9nQCfaJ4jIl0ExloZRIYBfNGeTYNL/eMJyXwfnmrM+AP
 tFcHXI+NCIYqc6moGS72cf0CYOm3ub1jhgxYXPnU+7cjT+u4hLAKzjRx792jpIEkMHkQT4irC4N
 23Vh5s=
X-Received: by 2002:a17:90a:ac0d:b0:39e:396d:b0b6 with SMTP id
 98e67ed59e1d1-39e396dc527mr1856355a91.2.1789619313068; 
 Wed, 16 Sep 2026 21:28:33 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 006/101] tcg: Use QEMU_ALIAS to define most tcg_gen_*_ptr
Date: Wed, 16 Sep 2026 18:26:48 -1000
Message-ID: <20260917042823.542588-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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


