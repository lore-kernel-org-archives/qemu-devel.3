Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445D2C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pKj-00035H-03; Wed, 16 Sep 2026 09:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pK7-0001tv-18
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:22 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pK4-0000Zf-Ow
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:14 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-39b9184fa80so807513a91.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563911; x=1790168711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZwfJtJ3HSNv234iEr+3vfcsQw2Bq02W8dccqh4RK04Y=;
 b=yLv/plQ8VP9Vl7aCS8V+4zzXuZpHHnv1mmecWrbi5BSqVrEZWLBkSlDwsgkVD4o8Wf
 v33t6E/aV/M2BY2AMnGacREkatq4P7r+N7feaeGK3bN+TxZ+rN2ISWNKzinOtM6Qa8Jr
 mo2G/RewiPcAkgc8uTpMg8zVXtUD0fXjUJz4k5q0XA4vBIBp3eY56oQVykYAhIry6MwD
 XSWtLNFMTzmFAHJ24zJcvaZRRlzndQf76+kEMLntYTjddeoakDII5vAUsNNRWQdh2H+/
 H9lxwF7h9PNg1cfIACnxtOB0VXH5vRGB1l9XwK21BK0QCzyXQKOzEKI/SA59iKaPjSQb
 BhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563911; x=1790168711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZwfJtJ3HSNv234iEr+3vfcsQw2Bq02W8dccqh4RK04Y=;
 b=x99MYumlAsW+PNqw7JGB/Hp5XHT/x8ei0g7jEiMnylsm+WGCAa8qtrbJoWBXHO4ISk
 KmdYpLtqXq3/y8S8yjil+jC32GkGakZvXAdZPDEyOs1WSC0nHHWM1a+6HMf/W5CvE9jj
 3aF0UCZ8sdJeOVq0/THFsWSAs+xoZwAeriTaWdMAojQNYW+3PK3ulZSctftW1KOEibqX
 jkv9m7nige1alIkYQwsaUgQ6CfEQq3WazOQNuK3wKbK7ODhj2DRXbYVgCg+MJmI5uupn
 YhahYOi1gOPoz0Pfw/E9lpe3K2E9aChBjyr7SnM8+5/SmaltfsZfBhtTIZH7/XsgMIrm
 VlTA==
X-Gm-Message-State: AFuF++kLc6CgzcIJGACcezPEauwM9u4jiOd8gjxFCMaWw7i6AH49q8Hw
 98nKqvTb84yqoiW/6pI0Hau4qxFFsExMqi2tnw1C9FKDFfIapN04sHIRNPEof7Ptmq0dEMkn6ux
 XNAazqIw=
X-Gm-Gg: AYBFou2Pz5tpI6WPihLUKpFhPnZ+/wZoSTJ+p5b3wqTTF6Vi3tB6GzMrUYqOLSeKgvr
 M8jaHtzH/lrJYBxqVio1aW/Hgn2/H71tSBtBaE7qAQWHcea+GmI5BiEIet4Jxr7OgtBBZM9amU4
 ZU6JjYKAws2Xsn9DS+7Ip4cs3Mb3/1vNFxGfNEFWuAp6Yr0RdA4AqXtUPC2Q8CRkhnNN5LtSkdZ
 pwb5lpauewu8bPqBUzxhrPwrOUVeX5XB//o9GgJBom5YtUKW95J4d6M1+EHXpqlKBqNlEshDjZp
 U5M72DI2QF+pLMpMQMamtKrPVph7p9VzM3dIhvAKoal0CYwufsBGKDT4HnSFzwjW5troKF6n7qP
 AfSpXEqutFKCPcC2Q6XP81mDui5CnOsVz9fXUyDa3CxsGysIkrMH7L9zYPbrW7enhN2bR/n+m53
 H2uOt039BWQnoT6IbqQ+iE6XYvjIXLcKAIOlUbuXP40brpVs7RIwxPyD5g+lWCuPPr8EdilHsyb
 DWN9yI=
X-Received: by 2002:a17:90b:2f0c:b0:39d:f08e:e6e7 with SMTP id
 98e67ed59e1d1-39e1e308bddmr7165019a91.9.1789563910388; 
 Wed, 16 Sep 2026 06:05:10 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.05.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:05:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 38/92] tcg: Generic expansion of tcg_gen_nor_*
Date: Wed, 16 Sep 2026 03:03:13 -1000
Message-ID: <20260916130409.3382710-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
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
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 613e844aecb..1fb10ffd804 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -198,7 +197,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 80d174a6cb1..62dc85ff6a6 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -15,6 +15,7 @@ DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
 DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
+DEF3(nor, TCGV, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f5edd77602a..edc3db83df3 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -542,6 +542,16 @@ static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
     gen_op_tt(INDEX_op_neg, type, dst, src);
 }
 
+static void gen_nor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_nor, type, 0)) {
+        gen_op_ttt(INDEX_op_nor, type, dst, src1, src2);
+    } else {
+        gen_or(type, dst, src1, src2);
+        gen_not(type, dst, dst);
+    }
+}
+
 static void gen_not(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (tcg_op_supported(INDEX_op_not, type, 0)) {
@@ -750,16 +760,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_nor, ret, arg1, arg2);
-    } else {
-        tcg_gen_or_i32(ret, arg1, arg2);
-        tcg_gen_not_i32(ret, ret);
-    }
-}
-
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I32, 0)) {
@@ -1777,16 +1777,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_nor, ret, arg1, arg2);
-    } else {
-        tcg_gen_or_i64(ret, arg1, arg2);
-        tcg_gen_not_i64(ret, ret);
-    }
-}
-
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I64, 0)) {
-- 
2.53.0


