Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E8C5C9833F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkl0-0002cY-7W; Sun, 27 Sep 2026 05:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkH-0002Rt-8V
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:29 -0400
Received: from mail-pj2-x0c.google.com ([2607:f8b0:4864:39::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkF-0007Q4-Lx
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:28 -0400
Received: by mail-pj2-x0c.google.com with SMTP id
 98e67ed59e1d1-3a0df0bb2d6so606740a91.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499626; x=1791104426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0GnIX6SgDIjusXMLUKT9H4fidyb32flXqymC+/BxShQ=;
 b=rbGP+PwVVV4XdiItnuUNVQYpBB+/qQMrrCdTyC0/F9RwgZ/PJcb87XtryzeZEcKh3K
 LCWOcl7vDsg5P+n2siaQaRk5IsEnpHCtgttl8M+JDnPr3+5Zg9KrcNNRBZL3FZP112Gk
 os2XLLbe2kG2FxoqogkQAIAbo2/Fy4cn9uLdmuFhVIQlgVNeevW0W9mHt2OXNDErzZdr
 97G1pCMu11qmjAukbgGYYZJEBodumZI6bIiEemXyAOyVzRYQi3wxvQuLV0SWdECM9EIi
 ezXkNiaooQ4NUvAz5lZJrh9cfJ9CaWWFk9pcqHh0+A1g7QlVyp9obB5NTtGhs7PDrZOs
 JyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499626; x=1791104426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0GnIX6SgDIjusXMLUKT9H4fidyb32flXqymC+/BxShQ=;
 b=k5lpscjcZkCDIX62qdFF0eZhnIN1j7fxOuHMerDyCWZ99RzAPDLbqdzYcVGnjNMLhb
 g8EzDR7iPSO1QjmGW2TbuVurpm3UwDIMf1aiurZBhAKvvPniiW+ab91DkntehxNv7Cti
 hy00ogjOHDVPvbsZhiw2wPItFKh7UMDFJ9ad8brJqtv+IouBWY4dUpHWbiWoZdo2kHBa
 Sm5PyOP5+7KDAjJTzM4ZSVOLOaUFIiKl4w2tucTUyhdNYZJ+GLGKwyO5J8TGZ6NKmOEx
 0OvRifdE4R1hs0B25XSiUTxQ6xtgSDG2/YszZLxl9BguL4D+OXKaEVwSY5ZQq+JsVqku
 GwJw==
X-Gm-Message-State: AFq9FYJ3DZvNBuWf6ACbxF0ma98pZIN6JifixqUdSP2F65wIKWSRWoZb
 sbS2z0wGEBckm0WwCyZbxj7EQABdHiN/DUvc6ifjJfsW8MM4Wpywq6KzuuZv7RHExaFO+lvnFWC
 AtfKA
X-Gm-Gg: AYBFou1eGVqYMm6Bc9d8AXvOJqag3ByqmVSDUUJmm+ZMtsmodT9YOhRa+Zothzbsgg0
 3wGMRXSmQMHmLaQBj+kkh53vTtlZ8f7nTlYzfpozIlmcMdEuDn+C8dwkZCrgF2O4yLL6+ElNext
 ArC6trlDNAL2TRNBokQwifImEOwwLnniD04e1eik+fKW6eL+Z+GPPAwp8j6O0UrvQ0DvNUSAsvM
 ED5xb7yv524txLrOuCdrR4+KMlMIzdtFybheQYyJpaUszRYNJeyleUoK13BOX/jH8tvQBTehEe1
 C4qYKTJJLoAEJ2+gDBeDMVJ2UX238f+K01slU8q1JFVcAefz8qAA1f2U8kU1KlhzQAPBe1G+Jj7
 ReLXoPpNzWtBf8qyiHHQ2hdhPfb6ZR6fC2Q2Zr90pftFTJ5u/yurx6j9bVAeEkfRlPO6+jR6QJx
 Dhri7rCFbFLQo/sR293dNfniSFL884WhfCJMqcDZ2odoGiC/IgXXqvb8xrTg+vvd9QC5xvY7897
 MnhFZniVYfVCa/ViV9f5s5g5TYfQQ==
X-Received: by 2002:a17:90b:398c:b0:3a0:aead:5607 with SMTP id
 98e67ed59e1d1-3a0aead59c6mr6280158a91.11.1790499626195; 
 Sun, 27 Sep 2026 02:00:26 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 015/101] tcg: Generic expansion of tcg_gen_subi_*
Date: Sun, 27 Sep 2026 01:58:45 -0700
Message-ID: <20260927090011.10724-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0c.google.com
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
index 8444044ed57..ff15e3b88ae 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -124,7 +124,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
-void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -225,7 +224,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* 64 bit ops */
 
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
-void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 51d5ec6e06a..55249c4dd6f 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -7,3 +7,4 @@ DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(sub, TCGV, TCGV, TCGV)
+DEF3(subi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2865de65d39..9bcf79ccbfc 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -399,6 +399,11 @@ void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
 }
 
+void tcg_gen_subi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_gen_addi(type, dst, src1, -src2);
+}
+
 /* 32 bit ops */
 
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
@@ -410,11 +415,6 @@ void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
     }
 }
 
-void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_gen_addi_i32(ret, arg1, -arg2);
-}
-
 void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     tcg_gen_op2_i32(INDEX_op_neg, ret, arg);
@@ -1537,11 +1537,6 @@ void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
     }
 }
 
-void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_gen_addi_i64(ret, arg1, -arg2);
-}
-
 void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_op2_i64(INDEX_op_neg, ret, arg);
-- 
2.53.0


