Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F46D743FD
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 01:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDwHg-0001WE-J5; Wed, 20 Nov 2024 20:47:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHf-0001Ve-1n
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:03 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tDwHd-0004WN-4d
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 20:47:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=II26gCWf23z5pgLLS6uEpV6LzQJG3dH6fmuJ7BDdgmg=; b=BzuvtGtp0TClplo
 mfMKPTAL6TLmv1o53RXWJIt2c5QuHc0LC6PZnXC+QlyaVAh8BVzoCupiKo33iSZFIA1Cb08wFfFfW
 T65MsQM6JZcPDNnXUP+XyC0N8aTCI1wpwwZde+5wFfyebiGdDUOc2ZzWRqK5fmjZfc0YeI0A3bX3A
 Gk=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, ltaylorsimpson@gmail.com, bcain@quicinc.com,
 richard.henderson@linaro.org, philmd@linaro.org, alex.bennee@linaro.org
Subject: [RFC PATCH v1 02/43] accel/tcg: Add bitreverse and funnel-shift
 runtime helper functions
Date: Thu, 21 Nov 2024 02:49:06 +0100
Message-ID: <20241121014947.18666-3-anjo@rev.ng>
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

Adds necessary helper functions for mapping LLVM IR onto TCG.
Specifically, helpers corresponding to the bitreverse and funnel-shift
intrinsics in LLVM.

Note: these may be converted to more efficient implementations in the
future, but for the time being it allows helper-to-tcg to support a
wider subset of LLVM IR.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 accel/tcg/tcg-runtime.c | 29 +++++++++++++++++++++++++++++
 accel/tcg/tcg-runtime.h |  5 +++++
 2 files changed, 34 insertions(+)

diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 9fa539ad3d..6372fa3f6f 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -23,6 +23,8 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
+#include "qemu/int128.h"
+#include "qemu/bitops.h"
 #include "cpu.h"
 #include "exec/helper-proto-common.h"
 #include "exec/cpu_ldst.h"
@@ -57,6 +59,21 @@ uint32_t HELPER(remu_i32)(uint32_t arg1, uint32_t arg2)
     return arg1 % arg2;
 }
 
+uint32_t HELPER(bitreverse8_i32)(uint32_t x)
+{
+  return revbit8((uint8_t) x);
+}
+
+uint32_t HELPER(bitreverse16_i32)(uint32_t x)
+{
+  return revbit16((uint16_t) x);
+}
+
+uint32_t HELPER(bitreverse32_i32)(uint32_t x)
+{
+  return revbit32(x);
+}
+
 /* 64-bit helpers */
 
 uint64_t HELPER(shl_i64)(uint64_t arg1, uint64_t arg2)
@@ -74,6 +91,13 @@ int64_t HELPER(sar_i64)(int64_t arg1, int64_t arg2)
     return arg1 >> arg2;
 }
 
+uint64_t HELPER(fshl_i64)(uint64_t a, uint64_t b, uint64_t c)
+{
+    Int128 d = int128_make128(b, a);
+    Int128 shift = int128_lshift(d, c);
+    return int128_gethi(shift);
+}
+
 int64_t HELPER(div_i64)(int64_t arg1, int64_t arg2)
 {
     return arg1 / arg2;
@@ -94,6 +118,11 @@ uint64_t HELPER(remu_i64)(uint64_t arg1, uint64_t arg2)
     return arg1 % arg2;
 }
 
+uint64_t HELPER(bitreverse64_i64)(uint64_t x)
+{
+    return revbit64(x);
+}
+
 uint64_t HELPER(muluh_i64)(uint64_t arg1, uint64_t arg2)
 {
     uint64_t l, h;
diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index c23b5e66c4..0a4d31eb48 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -2,15 +2,20 @@ DEF_HELPER_FLAGS_2(div_i32, TCG_CALL_NO_RWG_SE, s32, s32, s32)
 DEF_HELPER_FLAGS_2(rem_i32, TCG_CALL_NO_RWG_SE, s32, s32, s32)
 DEF_HELPER_FLAGS_2(divu_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
 DEF_HELPER_FLAGS_2(remu_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
+DEF_HELPER_FLAGS_1(bitreverse8_i32,  TCG_CALL_NO_RWG_SE, i32, i32)
+DEF_HELPER_FLAGS_1(bitreverse16_i32, TCG_CALL_NO_RWG_SE, i32, i32)
+DEF_HELPER_FLAGS_1(bitreverse32_i32, TCG_CALL_NO_RWG_SE, i32, i32)
 
 DEF_HELPER_FLAGS_2(div_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
 DEF_HELPER_FLAGS_2(rem_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
 DEF_HELPER_FLAGS_2(divu_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(remu_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
+DEF_HELPER_FLAGS_1(bitreverse64_i64, TCG_CALL_NO_RWG_SE, i64, i64)
 
 DEF_HELPER_FLAGS_2(shl_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(shr_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_2(sar_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
+DEF_HELPER_FLAGS_3(fshl_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
 
 DEF_HELPER_FLAGS_2(mulsh_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
 DEF_HELPER_FLAGS_2(muluh_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-- 
2.45.2


