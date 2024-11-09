Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C57D5E369
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kMy-0002kG-6Z; Sat, 09 Nov 2024 07:15:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kMu-0002dw-MJ; Sat, 09 Nov 2024 07:15:08 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kMs-0004xf-CE; Sat, 09 Nov 2024 07:15:08 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E35F9A162E;
 Sat,  9 Nov 2024 15:08:06 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id AB313167FB5;
 Sat,  9 Nov 2024 15:09:01 +0300 (MSK)
Received: (nullmailer pid 3296141 invoked by uid 1000);
 Sat, 09 Nov 2024 12:09:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.2 05/58] target/i386: Use only 16 and 32-bit operands for
 IN/OUT
Date: Sat,  9 Nov 2024 15:08:06 +0300
Message-Id: <20241109120901.3295995-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
References: <qemu-stable-9.1.2-20241109150812@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Richard Henderson <richard.henderson@linaro.org>

The REX.W prefix is ignored for these instructions.
Mirror the solution already used for INS/OUTS: X86_SIZE_z.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2581
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-stable@nongnu.org
Link: https://lore.kernel.org/r/20241015004144.2111817-1-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 15d955975bd484c2c66af0d6daaa02a7d04d2256)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 30be9237c3..429ed87bb6 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1627,9 +1627,9 @@ static const X86OpEntry opcodes_root[256] = {
     [0xE2] = X86_OP_ENTRYr(LOOP,   J,b), /* implicit: CX with aflag size */
     [0xE3] = X86_OP_ENTRYr(JCXZ,   J,b), /* implicit: CX with aflag size */
     [0xE4] = X86_OP_ENTRYwr(IN,    0,b, I_unsigned,b), /* AL */
-    [0xE5] = X86_OP_ENTRYwr(IN,    0,v, I_unsigned,b), /* AX/EAX */
+    [0xE5] = X86_OP_ENTRYwr(IN,    0,z, I_unsigned,b), /* AX/EAX */
     [0xE6] = X86_OP_ENTRYrr(OUT,   0,b, I_unsigned,b), /* AL */
-    [0xE7] = X86_OP_ENTRYrr(OUT,   0,v, I_unsigned,b), /* AX/EAX */
+    [0xE7] = X86_OP_ENTRYrr(OUT,   0,z, I_unsigned,b), /* AX/EAX */
 
     [0xF1] = X86_OP_ENTRY0(INT1,   svm(ICEBP)),
     [0xF4] = X86_OP_ENTRY0(HLT,    chk(cpl0) svm(HLT)),
@@ -1761,9 +1761,9 @@ static const X86OpEntry opcodes_root[256] = {
     [0xEA] = X86_OP_ENTRYrr(JMPF,  I_unsigned,p, I_unsigned,w, chk(i64)),
     [0xEB] = X86_OP_ENTRYr(JMP,    J,b),
     [0xEC] = X86_OP_ENTRYwr(IN,    0,b, 2,w), /* AL, DX */
-    [0xED] = X86_OP_ENTRYwr(IN,    0,v, 2,w), /* AX/EAX, DX */
+    [0xED] = X86_OP_ENTRYwr(IN,    0,z, 2,w), /* AX/EAX, DX */
     [0xEE] = X86_OP_ENTRYrr(OUT,   0,b, 2,w), /* DX, AL */
-    [0xEF] = X86_OP_ENTRYrr(OUT,   0,v, 2,w), /* DX, AX/EAX */
+    [0xEF] = X86_OP_ENTRYrr(OUT,   0,z, 2,w), /* DX, AX/EAX */
 
     [0xF8] = X86_OP_ENTRY0(CLC),
     [0xF9] = X86_OP_ENTRY0(STC),
-- 
2.39.5


