Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444EFC47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 17:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rU9Jv-0004t4-Np; Sun, 28 Jan 2024 12:51:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9Ix-0002lf-8c; Sun, 28 Jan 2024 12:50:55 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9Iv-0000mX-GL; Sun, 28 Jan 2024 12:50:51 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2D62848106;
 Sun, 28 Jan 2024 20:51:29 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B8A746D522;
 Sun, 28 Jan 2024 20:50:37 +0300 (MSK)
Received: (nullmailer pid 812410 invoked by uid 1000);
 Sun, 28 Jan 2024 17:50:35 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Thomas Huth <thuth@redhat.com>
Subject: [Stable-8.2.1 57/71] tcg/s390x: Fix encoding of VRIc, VRSa, VRSc insns
Date: Sun, 28 Jan 2024 20:50:20 +0300
Message-Id: <20240128175035.812352-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.1-20240128204849@cover.tls.msk.ru>
References: <qemu-stable-8.2.1-20240128204849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

While the format names the second vector register 'v3',
it is still in the second position (bits 12-15) and
the argument to RXB must match.

Example error:
 -   e7 00 00 10 2a 33       verllf  %v16,%v0,16
 +   e7 00 00 10 2c 33       verllf  %v16,%v16,16

Cc: qemu-stable@nongnu.org
Reported-by: Michael Tokarev <mjt@tls.msk.ru>
Fixes: 22cb37b4172 ("tcg/s390x: Implement vector shift operations")
Fixes: 79cada8693d ("tcg/s390x: Implement tcg_out_dup*_vec")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2054
Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Michael Tokarev <mjt@tls.msk.ru>
Message-Id: <20240117213646.159697-2-richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
(cherry picked from commit c1ddc18f37108498f45d57afd6bf33a23b703648)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index fbee43d3b0..7f6b84aa2c 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -683,7 +683,7 @@ static void tcg_out_insn_VRIc(TCGContext *s, S390Opcode op,
     tcg_debug_assert(is_vector_reg(v3));
     tcg_out16(s, (op & 0xff00) | ((v1 & 0xf) << 4) | (v3 & 0xf));
     tcg_out16(s, i2);
-    tcg_out16(s, (op & 0x00ff) | RXB(v1, 0, v3, 0) | (m4 << 12));
+    tcg_out16(s, (op & 0x00ff) | RXB(v1, v3, 0, 0) | (m4 << 12));
 }
 
 static void tcg_out_insn_VRRa(TCGContext *s, S390Opcode op,
@@ -738,7 +738,7 @@ static void tcg_out_insn_VRSa(TCGContext *s, S390Opcode op, TCGReg v1,
     tcg_debug_assert(is_vector_reg(v3));
     tcg_out16(s, (op & 0xff00) | ((v1 & 0xf) << 4) | (v3 & 0xf));
     tcg_out16(s, b2 << 12 | d2);
-    tcg_out16(s, (op & 0x00ff) | RXB(v1, 0, v3, 0) | (m4 << 12));
+    tcg_out16(s, (op & 0x00ff) | RXB(v1, v3, 0, 0) | (m4 << 12));
 }
 
 static void tcg_out_insn_VRSb(TCGContext *s, S390Opcode op, TCGReg v1,
@@ -762,7 +762,7 @@ static void tcg_out_insn_VRSc(TCGContext *s, S390Opcode op, TCGReg r1,
     tcg_debug_assert(is_vector_reg(v3));
     tcg_out16(s, (op & 0xff00) | (r1 << 4) | (v3 & 0xf));
     tcg_out16(s, b2 << 12 | d2);
-    tcg_out16(s, (op & 0x00ff) | RXB(0, 0, v3, 0) | (m4 << 12));
+    tcg_out16(s, (op & 0x00ff) | RXB(0, v3, 0, 0) | (m4 << 12));
 }
 
 static void tcg_out_insn_VRX(TCGContext *s, S390Opcode op, TCGReg v1,
-- 
2.39.2


