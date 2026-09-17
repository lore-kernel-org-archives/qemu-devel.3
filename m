Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B7CC982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73oF-0003kJ-SU; Thu, 17 Sep 2026 00:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73no-0002Jn-D9
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:53 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nm-0007LA-4O
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:51 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc50bcf87b2so234034a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619569; x=1790224369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=J/MbtGKsg9wpK9YblH40PpWWjYbcv5ll101QsyEncpg=;
 b=Y4MvQtd9Fnl76OKAnwfJUeUSNHxetqTmY4TTd2Lam0lRGkim2PS9+6TwI0f0wgUUZj
 Q/XzoREziPAR/B/B7En+NNHfjdJcj78ojZ9GyX/RRV/Zj+UFbO5cJdi6nqyU2itnUwOT
 QIeAoBAJSBIbEB0/hO8s4pordiU6mlybCl+Lvnf6+VGwGqGOi6/Rfmq/t4eRb4kvikfl
 ahLtVNN0kuBwEklTB3fKf87BLIcPmAl2zo283kHO9IaMLduRlzEKhTyyLBNqiDplzVd1
 pg94LnJFilAkI+Yy1e9NMNYoP2VAY9eslyl324fcrxuvJ7O3pq6uY814J5FmrUDVbvi8
 gl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619569; x=1790224369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=J/MbtGKsg9wpK9YblH40PpWWjYbcv5ll101QsyEncpg=;
 b=dfYpnpLpfBKn6Fs3W4rsxXtVL7lKJfBJT7cDr/SmdA27Q8dcZX9nKUCLdAUkIu1yho
 XooVz5qlLFI7rkVaHYpC1iJWry8oF4tXz4d92Fid82a+3ZQ2CkkdvCbiIu7Iz6QAU5+V
 txCvpc3HVchNq5I8mqVZNxAG7GLxrKM9xYg79wdSNn9AqpPLA1py67oM5jUbr6EBHtQs
 cNZyZsVZbNPmZogXTqkmEt9iX4Kg39n9VZL98WlGzjj5fdpy7y/AL1jmO2shrJ/fgR7u
 xc8fxpKzq2OjcdaYToFlFAtvjPoQo3R0C0LRvfxjT2Im/nKyH0FPUdxRVu79mluTbDjK
 hj4g==
X-Gm-Message-State: AFuF++mBG09rZO81yspP4Y+JUM2tola/VW2TtAuzTHVk+0WZ3AfiwjA2
 HXTBPA7T+OUipLicDaRn1LugrVieIA1ZRD3isJrP7wJfTxVW+Ro9oTKMntLCm2K1JMAxCS9LwJ+
 Ewft+cUc=
X-Gm-Gg: AYBFou0h1bFsEpjKYPhvMDnUvtccvt/NB1aST+H8G3rSGLy/1XE7hmmqqFYvB5iFTma
 YVvJN6QMCURRlUs2Fq0t3A4S+Fmo35sn+ptPlj58AE8Z6GWE6NVUttUWQ8NobDhcElwZF1CPaqo
 +LhtqEOoE66vmwHEe/iMxw0PtsvveTmNZTim70VNlsFazTuSfziCc1s01VT7jqS6xSd7vz2ofaZ
 syfMVpoP1zzn/rvo7v9h5zA8ZwF2FtruxS8hpebnVLVsPichsRmTQGCBpgmqrzJXysgBTglO3Z9
 RrmFhBeu/49nEUuTjX1PscLRJv7SscoSPXEmTU06Y3T3fbFNLscBlw3vKrJutSbvnRU9UOyR1Xv
 5NxIC4stRqK8btIv+2n/PmUN+gav50/t98tJLnIdU/gngKZ4q6ScE9h3jWOpNSXAqDVsD6OsunF
 MT+ItqTtzlMQD7GtCSbV24qW3BXyFl2PV9z9xaEezdYFkiKe2whULcZiSMF9yxGAf0wPg3tFLAw
 ZoMCjw=
X-Received: by 2002:a17:90a:e7d2:b0:398:a145:5d3d with SMTP id
 98e67ed59e1d1-39e1e2daa81mr13858339a91.6.1789619568636; 
 Wed, 16 Sep 2026 21:32:48 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 079/101] tcg: Generic expansion of tcg_gen_ussub_*
Date: Wed, 16 Sep 2026 18:28:01 -1000
Message-ID: <20260917042823.542588-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
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
 tcg/tcg-op.c                 | 29 +++++++++--------------------
 3 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b64b54fcdee..f547dc14365 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
@@ -184,7 +183,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 69df7967c76..48f5acd5dc1 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -62,5 +62,6 @@ DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
 DEF3(umax, TCGV, TCGV, TCGV)
 DEF3(umin, TCGV, TCGV, TCGV)
+DEF3(ussub, TCGV, TCGV, TCGV)
 DEF3(xor, TCGV, TCGV, TCGV)
 DEF3(xori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index afd764ef16d..31c82cfe2fb 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1188,6 +1188,15 @@ static void gen_umin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_ussub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+    gen_sub(type, tmp, src1, src2);
+    gen_movcond(type, TCG_COND_LTU, dst, src1, src2,
+                tcg_constant_internal(type, 0), tmp);
+}
+
 static void gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_xor, type, dst, src1, src2);
@@ -1485,16 +1494,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_ussub_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    TCGv_i32 t = tcg_temp_ebb_new_i32();
-    TCGv_i32 z = tcg_constant_i32(0);
-
-    tcg_gen_sub_i32(t, a, b);
-    tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, z, t);
-    tcg_temp_free_i32(t);
-}
-
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_ld8u, ret, arg2, offset);
@@ -1979,16 +1978,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_ussub_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    TCGv_i64 t = tcg_temp_ebb_new_i64();
-    TCGv_i64 z = tcg_constant_i64(0);
-
-    tcg_gen_sub_i64(t, a, b);
-    tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, z, t);
-    tcg_temp_free_i64(t);
-}
-
 /* Size changing operations.  */
 
 void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
-- 
2.53.0


