Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98527D743FC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwHh-0001WZ-An; Wed, 20 Nov 2024 20:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHg-0001W1-9J
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:04 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHe-0004Wa-HL
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=8jA/Gzvjxlok8TB/HYwf/iXFNHMSXCKjyKHLZ6z242c=; b=ADrb7mSEOSMIKwW
 ynHHvZl4lpTy3OtLNngQ4RzIs09wmv40/g6bvEKkX5XsUvl0jWCXYEo8YKNTX+1K55bn78uG6j52U
 +BlpzhX7HXBt979imJwuR4pplJg5AzkacymN8PF/k3DVn7vmfkvAkaMol+ij0ycCbhta65QHMpS33
 mA=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 04/43] tcg: Add gvec functions for creating consant
 vectors
Date: Thu, 21 Nov 2024 02:49:08 +0100
Message-ID: <20241121014947.18666-5-anjo@rev.ng>
In-Reply-To: <20241121014947.18666-1-anjo@rev.ng>
References: <20241121014947.18666-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This commit adds a gvec function for copying data from constant array
given in C to a gvec intptr_t.  For each element, a host store of
each constant is performed, this is not ideal and will inflate TBs for
large vectors.

Moreover, data will be copied during each run of the generated code
impacting performance.  A more suitable solution might store constant
vectors separately, this can be handled either on the QEMU or
helper-to-tcg side.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 include/tcg/tcg-op-gvec-common.h |  2 ++
 tcg/tcg-op-gvec.c                | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/tcg/tcg-op-gvec-common.h b/include/tcg/tcg-op-gvec-common.h
index 39b0c2f64e..409a56c633 100644
--- a/include/tcg/tcg-op-gvec-common.h
+++ b/include/tcg/tcg-op-gvec-common.h
@@ -331,6 +331,8 @@ void tcg_gen_gvec_dup_mem(unsigned vece, uint32_t dofs, uint32_t aofs,
                           uint32_t s, uint32_t m);
 void tcg_gen_gvec_dup_imm(unsigned vece, uint32_t dofs, uint32_t s,
                           uint32_t m, uint64_t imm);
+void tcg_gen_gvec_constant(unsigned vece, TCGv_env env, uint32_t dofs,
+                           void *arr, uint32_t maxsz);
 void tcg_gen_gvec_dup_i32(unsigned vece, uint32_t dofs, uint32_t s,
                           uint32_t m, TCGv_i32);
 void tcg_gen_gvec_dup_i64(unsigned vece, uint32_t dofs, uint32_t s,
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 80649dc0d2..71b6875129 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -1835,6 +1835,36 @@ void tcg_gen_gvec_dup_imm(unsigned vece, uint32_t dofs, uint32_t oprsz,
     do_dup(vece, dofs, oprsz, maxsz, NULL, NULL, x);
 }
 
+
+void tcg_gen_gvec_constant(unsigned vece, TCGv_env env, uint32_t dofs,
+                           void *arr, uint32_t maxsz)
+{
+    uint32_t elsz = memop_size(vece);
+    for (uint32_t i = 0; i < maxsz/elsz; ++i)
+    {
+        uint32_t off = i*elsz;
+        uint8_t *elptr = (uint8_t *)arr + off;
+        switch (vece) {
+        case MO_8:
+            tcg_gen_st8_i32(tcg_constant_i32(*elptr),
+                            env, dofs + off);
+            break;
+        case MO_16:
+            tcg_gen_st16_i32(tcg_constant_i32(*(uint16_t *) elptr),
+                             env, dofs + off);
+            break;
+        case MO_32:
+            tcg_gen_st_i32(tcg_constant_i32(*(uint32_t *) elptr),
+                             env, dofs + off);
+            break;
+        case MO_64:
+            tcg_gen_st_i64(tcg_constant_i64(*(uint64_t *) elptr),
+                           env, dofs + off);
+            break;
+        }
+    }
+}
+
 void tcg_gen_gvec_not(unsigned vece, uint32_t dofs, uint32_t aofs,
                       uint32_t oprsz, uint32_t maxsz)
 {
-- 
2.45.2


