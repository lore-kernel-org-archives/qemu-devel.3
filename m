Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6B3C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyp6S-0000Rw-MR; Tue, 25 Aug 2026 07:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp6R-0000RP-Es; Tue, 25 Aug 2026 07:14:03 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp6P-0008EF-OS; Tue, 25 Aug 2026 07:14:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787656396; bh=lFuGmlhYYSKDBPFo5JyzGwQuXuM19c8eAo7qUbROai8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LIpg+ULq6FNsjJXSNgcDo3BVl9rmq1C/8T7ggB+qQigx9RR2JNG0iVP1RHJK+XXxt
 RbxeCwoIhI0flKEhpz3GmQjqFTMYRegb20VVqd9KWI7Rfv0rdKTxSGdinXClrvr1lz
 ITp24iJh+tSIHtfQ/q9IbpdXxbxDCA6M+mBz7NTUT55LUZ0XUkFEG5awM5ajqiN4Lx
 QCrBf/VHdCYTBsmb89DNoMiqwWo6mMcXzgAXZ61tYJPnZUMObf5q0szEuxnI29IRQP
 oZe8E1+zmz3X9vNvCub4G79ndYo6i3BxT5M++iltC9IDBHLd+GmPSb4C6pOaIgBdpJ
 yZ1wn3hFOA57A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 140251CE4A7;
 Tue, 25 Aug 2026 14:13:16 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2BFCC416273;
 Tue, 25 Aug 2026 14:13:53 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6C90E32591; Tue, 25 Aug 2026 14:13:15 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Simon Scherer <scherer.simon89@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v3 139/166] target/i386: fix incorrect decoding of
 EXTRQ_i
Date: Tue, 25 Aug 2026 14:11:35 +0300
Message-ID: <20260825111206.482723-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260825141147@cover.tls.msk.ru>
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

From: Simon Scherer <scherer.simon89@gmail.com>

The decoding of the extrq instruction with an immediate operand (EXTRQ_i) is
incorrect. Per the AMD manual the instruction encoding looks as follows:

EXTRQ xmm1, imm8, imm8   66 0F 78 /0 ib ib

The /0 indicates that the "Reg" field of the ModR/M byte must be equal
to 0 and the XMM register operand is specified by the "R/M" field.
However, qemu incorrectly uses the "Reg" field to extract the register operand.

This patch instead extracts the XMM register operand from the "R/M"
field.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3611
Signed-off-by: Simon Scherer <scherer.simon89@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20260625155613.192643-1-scherer.simon89@gmail.com
[Check for the reg field to be 0.  Make decoding of REPZ+66 consistent
 between 0F 78 and 0F 79. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit ce0ee66044be066cbbf076a7530fe4e8f638f847)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index ea03b18b9ed..b12fb77559a 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -479,23 +479,33 @@ static void decode_0F77(DisasContext *s, CPUX86State *env, X86OpEntry *entry, ui
 
 static void decode_0F78(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
-    static const X86OpEntry opcodes_0F78[4] = {
-        {},
-        X86_OP_ENTRY3(EXTRQ_i,       V,x, None,None, I,w,  cpuid(SSE4A)), /* AMD extension */
-        {},
-        X86_OP_ENTRY3(INSERTQ_i,     V,x, U,x, I,w,        cpuid(SSE4A)), /* AMD extension */
-    };
-    *entry = *decode_by_prefix(s, opcodes_0F78);
+    static const X86OpEntry opcodes_0F78_f2 =
+        X86_OP_ENTRY3(INSERTQ_i,     V,x, U,x, I,w,        cpuid(SSE4A)); /* AMD extension */
+    static const X86OpEntry opcodes_0F78_66 =
+        X86_OP_ENTRY3(EXTRQ_i,       U,x, None,None, I,w,  cpuid(SSE4A)); /* AMD extension */
+
+    entry->gen = NULL;
+    if (s->prefix & PREFIX_REPNZ) {
+        *entry = opcodes_0F78_f2;
+    } else if (s->prefix & PREFIX_REPZ) {
+        /* undefined */
+    } else if (s->prefix & PREFIX_DATA) {
+        int op = (get_modrm(s, env) >> 3) & 7;
+        if (op == 0) {
+            *entry = opcodes_0F78_66;
+        }
+    }
 }
 
 static void decode_0F79(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
+    entry->gen = NULL;
     if (s->prefix & PREFIX_REPNZ) {
         entry->gen = gen_INSERTQ_r; /* AMD extension */
+    } else if (s->prefix & PREFIX_REPZ) {
+        /* undefined */
     } else if (s->prefix & PREFIX_DATA) {
         entry->gen = gen_EXTRQ_r; /* AMD extension */
-    } else {
-        entry->gen = NULL;
     };
 }
 
-- 
2.47.3


