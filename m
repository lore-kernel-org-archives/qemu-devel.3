Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DFCC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73m8-0005hE-4L; Thu, 17 Sep 2026 00:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k8-0003Cw-1I
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:05 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73k3-0006o1-JI
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:03 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-396ccd5cef0so283111a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619330; x=1790224130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+0AwflT075ewSE4Vk6dBtxknupuv8fypEdtdVnsEwKM=;
 b=cPZdTod0TVXlgQcbufxuNd1UowjvHZLk/jcSBySzT745ia+x1ttnegH81VuWt6QsuG
 xj0aWUsUHObTXS88EKCFIJazL7NEXJXDEVmxT5LZvnXtEqQq5QdDjgdDd5jdOzWqK3r3
 PqBAeRf52KGqqmnSx5K8C7Qm0Hp9fJZWlXKaiP4eeVFKZFYVhh1zxoaiOqQQiELyKtVD
 kQkynbbaig0q2J1OMdzJYRceBgO95Bqs0bU+2XGb7yszsCt+ZKYTyFLcvhDt5IhPMrSk
 lVIzIoFRPx5yURwfcxpPP/ECOzLUOE5NfDgJsa9F2YZ3btnat1nhdGlDjUfkxGZnb/Wt
 0h9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619330; x=1790224130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+0AwflT075ewSE4Vk6dBtxknupuv8fypEdtdVnsEwKM=;
 b=j2pg5JHhFSXAeqIjUSLUxtm/llGo0nn6b8XRCry8964E7u5B1Aum26MNWtM7ErQWbq
 DaZDWfblcimGfMpnZHKM0G9Eg+lH5WCuVy107FBRo8g5xpvxMbBJjEtzYqI3M9vIivl9
 q4h81i7Ip7xY13QmkDI5BEoHxTMZRm21K/8U5cMCqA3S5e3/bv2wYtCF48K9yumvu+ex
 NG2QV9cNciXr63O9KPYMxA1onOnI9XXEMJYkWEay3a+j+B5uBDWhD9i6D+acSLORi9MW
 veZrBoSs5mx7BjfdGFODlXniPoPd0DmUiltCR565JU9FjXTnKlTNjxsY/29YP1y7CKfc
 qRYw==
X-Gm-Message-State: AFuF++n0TDzGpQmpbv/6T97v6bXGzExeoF6kSkK+QTbD4S5HasHxTRND
 Gamz1ST+ve+RDMk1u8OIGDuXYKQI3w3CE5A0Lef4SyDMrWkABj8Z7YPwUg60AllAS61I35x4Mav
 ynL1Z/1M=
X-Gm-Gg: AYBFou1aRRNO8VBTkNOfonvA61yls+GRS6e9hCHqhIr6rDNyvzow0O5FnrXlRQZNRIz
 W9R62skiNZHN49BTrLS4DwzjyitrhYMUqOk49BcnXerWr0VTam38d5pfVq/x9VGdwte+RDFE+AP
 sxE082+zPZHjK2KQS1Eg7BqmafSCyRmiFO5w+gu91rOzyUt7/OLAj7JRybak6b0m4H5v9qyy6Ss
 0LtkRkVDm+7BM0btvlkoHIUhaIhvpuRdvP3GZ1Ow4sSq3i/O9dO6IOrUYdwX8xSIGPVXZgAPgLJ
 yKxYzYagflFxmtQtjA7JhLHrq6cGyL6TJPrPYCFzyNFQhQpgRiLElj+rT+RfXZtLmY4pzzLGTeu
 lJRBzLpWMklNMQ07c9Vw1/eFtZ4ln7h7kYCG2MfSWPMb9Vnp1TA7TgdwG/gpF1MRRWzMxsSIcLR
 ojH3fq5LhQZycrybwQQMIgW8icHiXkgm3emVoJ6y4a2psa3tW0p7csKGLfrx6x8z6DLBq4NStnl
 WRN1EaopiMtTEKnBA==
X-Received: by 2002:a17:90b:4d0d:b0:39d:f189:48d6 with SMTP id
 98e67ed59e1d1-39e1e27b244mr11091295a91.4.1789619330165; 
 Wed, 16 Sep 2026 21:28:50 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 022/101] tcg: Generic expansion of tcg_gen_shr_*
Date: Wed, 16 Sep 2026 18:27:04 -1000
Message-ID: <20260917042823.542588-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
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
index 5115b07ef22..9bb5dd22496 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -313,7 +312,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 15cbb6c341a..3f928d4cb8f 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -9,6 +9,7 @@ DEF2(movi, TCGV, TINT)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
+DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 19e2c6c713f..6f6ab0a0e5e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -448,6 +448,11 @@ static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
 }
 
+static void gen_shr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_shr, type, dst, src1, src2);
+}
+
 static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -549,11 +554,6 @@ void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_shr, ret, arg1, arg2);
-}
-
 void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1527,11 +1527,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_shr, ret, arg1, arg2);
-}
-
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_sar, ret, arg1, arg2);
-- 
2.53.0


