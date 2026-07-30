Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F26C54FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 03:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpH5l-0001im-9H; Wed, 29 Jul 2026 23:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH5j-0001iG-AQ
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:05:51 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1wpH5h-0002qW-Ag
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 23:05:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=N4VjtNGTVCTr3fiohuEIHANGrMrdHqVx/1EQ5lSRyCE=; b=CZy6N2iP0KZW2Dx
 IKM90W85A6e81gynuWJxH2zCHiM2VFp7HQB8NGdH8h4lglM6B52kmqojywe8wwkWXTRvvA5O9ja8U
 5jrdW/s+3sggkAQclxaG85HmcY4DBsT4t7t931s9sIbt7gmJdFpT683s+a79am6HS2x1syb7XLiBy
 eQ=;
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@mailo.com, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 01/50] accel/tcg: Add bitreverse and funnel-shift runtime
 helper functions
Date: Thu, 30 Jul 2026 05:09:35 +0200
Message-ID: <20260730031025.12926-2-anjo@rev.ng>
In-Reply-To: <20260730031025.12926-1-anjo@rev.ng>
References: <20260730031025.12926-1-anjo@rev.ng>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Adds necessary helper functions for mapping LLVM IR onto TCG.
Specifically, helpers corresponding to the bitreverse and funnel-shift
intrinsics in LLVM.

Note: these may be converted to more efficient implementations in the
future, but for the time being it allows helper-to-tcg to support a
wider subset of LLVM IR.

Signed-off-by: Anton Johansson <anjo@rev.ng>
--
TODO: `tcg_gen_*()` variants will be added in the next version, it
slipped through (Richard).
---
 accel/tcg/tcg-runtime.c | 28 ++++++++++++++++++++++++++++
 accel/tcg/tcg-runtime.h |  6 ++++++
 2 files changed, 34 insertions(+)

diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 7c0aab98a8..d42c00736b 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -24,6 +24,7 @@
 #include "qemu/osdep.h"
 #include "qemu/host-utils.h"
 #include "exec/cpu-common.h"
+#include "qemu/int128.h"
 #include "exec/helper-proto-common.h"
 #include "accel/tcg/cpu-loop.h"
 #include "accel/tcg/getpc.h"
@@ -54,8 +55,30 @@ uint32_t HELPER(remu_i32)(uint32_t arg1, uint32_t arg2)
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
@@ -76,6 +99,11 @@ uint64_t HELPER(remu_i64)(uint64_t arg1, uint64_t arg2)
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
index 0b832176b3..197d658b40 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -2,11 +2,17 @@ DEF_HELPER_FLAGS_2(div_i32, TCG_CALL_NO_RWG_SE, s32, s32, s32)
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
+
+DEF_HELPER_FLAGS_3(fshl_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64, i64)
 
 DEF_HELPER_FLAGS_2(mulsh_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
 DEF_HELPER_FLAGS_2(muluh_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-- 
2.52.0


