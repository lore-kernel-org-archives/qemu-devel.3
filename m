Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0089CFC504
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdH9-0000Ip-Es; Fri, 21 Nov 2025 21:23:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdGz-000064-KJ; Fri, 21 Nov 2025 21:22:49 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdGB-0004er-7V; Fri, 21 Nov 2025 21:22:46 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 20BD416C6FE;
 Fri, 21 Nov 2025 16:51:57 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7A77B32199B;
 Fri, 21 Nov 2025 16:52:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 38/76] target/x86: Correctly handle invalid 0x0f 0xc7
 0xxx insns
Date: Fri, 21 Nov 2025 16:51:16 +0300
Message-ID: <20251121135201.1114964-38-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In the decode_group9() function, if we don't recognise the insn as
one that we should handle, we leave the 'entry' pointer unaltered.
Because the X86OpEntry struct has a union for the gen and decode
pointers, this means that the top level code will call decode.e.gen()
which tries to use the decode function pointer (still set to
decode_group9) as a gen function pointer.

This is undefined behaviour, but seems to be mostly harmless in
practice (we call decode_group9() again with bogus arguments and it
does nothing).  If you have CFI enabled then it will trip the CFI
check:

../target/i386/tcg/decode-new.c.inc:2862:9: runtime error: control flow integrity check for type 'void (struct DisasContext *, struct X86DecodedInsn *)' failed during indirect function call

Set *entry to UNKNOWN_OPCODE to provoke the #UD exception, as we do
in decode_group1A() and decode_group11() for similar situations.

Thanks to the bug reporter for the clear description and analysis of
the bug and the simple reproducer.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3172
Fixes: fcd16539ebfe2 ("target/i386: convert CMPXCHG8B/CMPXCHG16B to new decoder")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251021173152.1695997-1-peter.maydell@linaro.org>
(cherry picked from commit 4f503afc7eb503997fedad84f24e2cdf696a7a0e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index a50f57dbaa..f4192f1006 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -335,6 +335,8 @@ static void decode_group9(DisasContext *s, CPUX86State *env, X86OpEntry *entry,
         *entry = group9_reg;
     } else if (op == 1) {
         *entry = REX_W(s) ? cmpxchg16b : cmpxchg8b;
+    } else {
+        *entry = UNKNOWN_OPCODE;
     }
 }
 
-- 
2.47.3


