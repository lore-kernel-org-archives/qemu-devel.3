Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A7CCD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuLs-0004nF-ER; Tue, 12 May 2026 17:09:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuLD-0001a5-MB; Tue, 12 May 2026 17:08:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuL9-0002gF-DR; Tue, 12 May 2026 17:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619301; bh=CFdcyFhJMpa4dPXVqM5/4n6Qp9NEAF+U6RtvdELjvEU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mCf6OWJdiHDUXanGeWYQpYVyWIBsxhzszXacZZh8rLH98XFq3V5g6tBZMXMUSH/Qa
 QJSzm4LTHhf5e2iKZQX0r1Jcq8haEessMrzlWPaeBYeJWd/laqWZ9IcjeGSs0iroZO
 icIcLmXcO0EnzQtZw75zlfl5DxgBNc6t/sjE3CRR4+HtjZB8Kjyw/8Wj3m8kT5OfAT
 QcQkaji9w/9kQBr+TL5R2W+lT18UqHW3W1RhjlGj7veVJANttunfXhqKonUQBeaDl4
 9qq3HK97fLdl1a0BSasJJTpEuG8Rd3Y23nyOzXBHioFkwWrISjXu091jeBhdSGLJDk
 WHuNbOskgr0JA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 62F871AA356;
 Tue, 12 May 2026 23:55:01 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6FCB53ABCC6;
 Tue, 12 May 2026 23:55:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 025/117] linux-user/i386/signal.c: Correct definition
 of target_fpstate_32
Date: Tue, 12 May 2026 23:53:27 +0300
Message-ID: <20260512205503.361097-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

Our definition of the target_fpstate_32 struct doesn't match the
kernel's version.  We only use this struct definition in the
definition of 'struct sigframe', where it is used in a field that is
present only for legacy reasons to retain the offset of the following
'extramask' field.  So really all that matters is its length, and we
do get that right; but our previous definition using
X86LegacySaveArea implicitly added an extra alignment constraint
(because X86LegacySaveArea is tagged as 16-aligned) which the real
target_fpstate_32 does not have.  Because we allocate and use a
'struct sigframe' on the guest's stack with the guest's alignment
requirements, this resulted in the undefined-behaviour sanitizer
complaining during 'make check-tcg' for i386-linux-user:

../../linux-user/i386/signal.c:471:35: runtime error: member access within misaligned address 0x1000c07f75ec for type 'struct sigframe', which requires 16 byte alignment
0x1000c07f75ec: note: pointer points here
  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
              ^

../../linux-user/i386/signal.c:808:5: runtime error: member access within misaligned address 0x1000c07f75f4 for type 'struct target_sigcontext_32', which requires 8 byte alignment
0x1000c07f75f4: note: pointer points here
  0a 00 00 00 33 00 00 00  00 00 00 00 2b 00 00 00  2b 00 00 00 40 05 80 40  f4 7f 10 08 58 05 80 40
              ^

and various similar errors.

Replace the use of X86LegacyXSaveArea with a set of fields that match
the kernel _fpstate_32 struct, and assert that the length is correct.
We could equally have used
   uint8_t legacy_area[512];
but following the kernel is probably less confusing overall.

Since in target/i386/cpu.h we assert that X86LegacySaveArea is 512
bytes, and in linux-user/i386/signal.c we assert that
target_fregs_state is (32 + 80) bytes, the new assertion confirms
that we didn't change the size of target_fpstate_32 here, only its
alignment requirements.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260305161739.1775232-1-peter.maydell@linaro.org
(cherry picked from commit 0376e9c2dd1f46dd779ebc85f40f7a8cfa46ed6f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/i386/signal.c b/linux-user/i386/signal.c
index 0f11dba831..b646fde431 100644
--- a/linux-user/i386/signal.c
+++ b/linux-user/i386/signal.c
@@ -60,10 +60,33 @@ struct target_fpx_sw_bytes {
 };
 QEMU_BUILD_BUG_ON(sizeof(struct target_fpx_sw_bytes) != 12*4);
 
+struct fpxreg {
+    uint16_t significand[4];
+    uint16_t exponent;
+    uint16_t padding[3];
+};
+
+struct xmmreg {
+    uint32_t element[4];
+};
+
+/*
+ * This corresponds to the kernel's _fpstate_32. Since we
+ * only use it for the fpstate_unused padding section in
+ * the target sigcontext, it doesn't actually matter what fields
+ * we define here as long as we get the size right.
+ */
 struct target_fpstate_32 {
     struct target_fregs_state fpstate;
-    X86LegacyXSaveArea fxstate;
+    uint32_t fxsr_env[6];
+    uint32_t mxcsr;
+    uint32_t reserved;
+    struct fpxreg fxsr_st[8];
+    struct xmmreg xmm[8];
+    uint32_t padding1[44];
+    uint32_t padding2[12]; /* aka sw_reserved */
 };
+QEMU_BUILD_BUG_ON(sizeof(struct target_fpstate_32) != 32 + 80 + 512);
 
 struct target_sigcontext_32 {
     uint16_t gs, __gsh;
-- 
2.47.3


