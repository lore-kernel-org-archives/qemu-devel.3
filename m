Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E598CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 15:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urHgS-0002T6-PK; Wed, 27 Aug 2025 11:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHgQ-0002RU-B6; Wed, 27 Aug 2025 11:03:30 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1urHgN-0004ja-9B; Wed, 27 Aug 2025 11:03:29 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4F16C14C529;
 Wed, 27 Aug 2025 18:02:56 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3AFC1269831;
 Wed, 27 Aug 2025 18:03:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.4 01/59] host-utils: Drop workaround for buggy Apple
 Clang __builtin_subcll()
Date: Wed, 27 Aug 2025 18:02:06 +0300
Message-ID: <20250827150323.2694101-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
References: <qemu-stable-10.0.4-20250827180051@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

In commit b0438861efe ("host-utils: Avoid using __builtin_subcll on
buggy versions of Apple Clang") we added a workaround for a bug in
Apple Clang 14 where its __builtin_subcll() implementation was wrong.
This bug was only present in Apple Clang 14, not in upstream clang,
and is not present in Apple Clang versions 15 and newer.

Since commit 4e035201 we have required at least Apple Clang 15, so we
no longer build with the buggy versions.  We can therefore drop the
workaround. This is effectively a revert of b0438861efe.

This should not be backported to stable branches, which may still
need to support Apple Clang 14.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3030
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250714145033.1908788-1-peter.maydell@linaro.org
(cherry picked from commit e74aad9f81cc2bfee2057086610e21bd98e9c5a5)
(Mjt: 10.0 already requres clang 15+, so it's okay to backport
 this change to 10.0 branch)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 496dac5ac1..33b425dcf3 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -182,19 +182,6 @@
 #define QEMU_DISABLE_CFI
 #endif
 
-/*
- * Apple clang version 14 has a bug in its __builtin_subcll(); define
- * BUILTIN_SUBCLL_BROKEN for the offending versions so we can avoid it.
- * When a version of Apple clang which has this bug fixed is released
- * we can add an upper bound to this check.
- * See https://gitlab.com/qemu-project/qemu/-/issues/1631
- * and https://gitlab.com/qemu-project/qemu/-/issues/1659 for details.
- * The bug never made it into any upstream LLVM releases, only Apple ones.
- */
-#if defined(__apple_build_version__) && __clang_major__ >= 14
-#define BUILTIN_SUBCLL_BROKEN
-#endif
-
 #if __has_attribute(annotate)
 #define QEMU_ANNOTATE(x) __attribute__((annotate(x)))
 #else
diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index 4d28fa22cf..dd558589cb 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -677,7 +677,7 @@ static inline uint64_t uadd64_carry(uint64_t x, uint64_t y, bool *pcarry)
  */
 static inline uint64_t usub64_borrow(uint64_t x, uint64_t y, bool *pborrow)
 {
-#if __has_builtin(__builtin_subcll) && !defined(BUILTIN_SUBCLL_BROKEN)
+#if __has_builtin(__builtin_subcll)
     unsigned long long b = *pborrow;
     x = __builtin_subcll(x, y, b, &b);
     *pborrow = b & 1;
-- 
2.47.2


