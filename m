Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC25C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 10:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Vye-0000oT-I5; Fri, 18 Sep 2026 06:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1x7VyU-0000oD-6v
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 06:37:47 -0400
Received: from [2a14:640:1:12b5::1] (helo=krgm.moe)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1x7VyS-0002E3-4I
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 06:37:45 -0400
Received: from yuno-loong (unknown [103.47.186.116])
 by krgm.moe (Postfix) with ESMTPSA id 9E9537A11;
 Fri, 18 Sep 2026 16:07:38 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Felix Yan <felixonmars@archlinux.org>
Subject: [PATCH] linux-user/loongarch64: Detect vector stores in
 host_signal_write()
Date: Fri, 18 Sep 2026 18:37:33 +0800
Message-ID: <20260918103733.86966-1-prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a14:640:1:12b5::1 (failed)
Received-SPF: pass client-ip=2a14:640:1:12b5::1; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RDNS_NONE=0.793,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Recognize LSX/LASX stores in the LoongArch host signal handler to fix
internal QEMU crashes when RISC-V vector stores hit write-protected code
pages through host memcpy.

Signed-off-by: Felix Yan <felixonmars@archlinux.org>
Signed-off-by: SignKirigami <prcups@krgm.moe>
---
 linux-user/include/host/loongarch64/host-signal.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/include/host/loongarch64/host-signal.h b/linux-user/include/host/loongarch64/host-signal.h
index d33c3fc03e..eb4308cf09 100644
--- a/linux-user/include/host/loongarch64/host-signal.h
+++ b/linux-user/include/host/loongarch64/host-signal.h
@@ -61,6 +61,10 @@ static inline bool host_signal_write(siginfo_t *info, host_sigcontext *uc)
             return true;
         }
         break;
+    case 0b001011: /* v{ld,st}, xv{ld,st} */
+        return (insn >> 22) & 1;
+    case 0b001100: /* v{ldrepl,stelm}, xv{ldrepl,stelm} */
+        return (insn >> 24) & 1;
     case 0b001110: /* indexed, atomic, bounds-checking memory operations */
         switch ((insn >> 15) & 0b11111111111) {
         case 0b00000100000: /* stx.b */
@@ -69,6 +73,8 @@ static inline bool host_signal_write(siginfo_t *info, host_sigcontext *uc)
         case 0b00000111000: /* stx.d */
         case 0b00001110000: /* fstx.s */
         case 0b00001111000: /* fstx.d */
+        case 0b00010001000: /* vstx */
+        case 0b00010011000: /* xvstx */
         case 0b00011101100: /* fstgt.s */
         case 0b00011101101: /* fstgt.d */
         case 0b00011101110: /* fstle.s */
-- 
2.55.0


