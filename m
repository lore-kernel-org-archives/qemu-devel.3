Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C98CCCF2C9
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9eg-0008L4-He; Sat, 17 Oct 2026 15:01:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9dx-00067M-Il; Sat, 17 Oct 2026 15:00:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9dv-0004GT-Sj; Sat, 17 Oct 2026 15:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263421; bh=t3Y7hPWOb7S5GvmzRzlZql2w9QrWwtr+vAgksoJgcdY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=A5GeMqH0N8aOVHJ9JnHZlAFDeNYrjJzohfk+hqXUTbFcwEEk//PqMHYVKOrtq1i/q
 UPuBO3rWb9ddHSzXBUoFUMXYiGWQ64sgSmQAGgpvdOdNsyBQ9xIAt30bWqf+UMM8qB
 L0kpED1bkbHV0VCx6W2HUrlRoUkILXMHkEyGgJnw2gyHN9Dzhag00mqRGLCjziTgEr
 oQ0nl0Y+KFJOAkwiW3uXZxvISXLbIoxQaltZOvl3n6lSvwB4lZXCI43XceUy6bypgS
 kBtQ2Oc1KNqQlX4WTRUJk7LC5RPlXHyJsT0yG9Ipz4CPqo59/NW1mtiAdInj0MtsCR
 zlPjkbOs1RAOw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 37ACC1DE6D6;
 Sat, 17 Oct 2026 21:57:01 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 12E3C44339E;
 Sat, 17 Oct 2026 21:56:59 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Artemii Mashanov <ralerrdirsardx@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 51/63] target/i386: fix immediate stack adjustment
 for RET and RETF
Date: Sat, 17 Oct 2026 21:55:07 +0300
Message-ID: <20261017185528.722197-51-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
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

From: Artemii Mashanov <ralerrdirsardx@gmail.com>

The imm16 operand of RET and RETF specifies an unsigned 16-bit count
of additional bytes to release from the stack.

Previously, gen_RET() and gen_RETF() stored this operand in an int16_t.
For example, 0xcaf5 was interpreted as -13579 instead of 51957.

Use uint16_t for the adjustment in both functions to preserve the
immediate's unsigned value.

Tested locally with near and far returns in both 32-bit and 64-bit
modes. Each combination covered the form without an immediate and
immediate values 0x0000, 0x0001, 0x7fff, 0x8000, 0xcaf5, and 0xffff.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2599

Signed-off-by: Artemii Mashanov <ralerrdirsardx@gmail.com>
Link: https://lore.kernel.org/r/20260924200420.21068-1-ralerrdirsardx@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 21b6c3e5bccfc07d2719f6de27c40df5af283748)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index af1cea92be..4b657500ec 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -3585,7 +3585,7 @@ static void gen_RDxxBASE(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_RET(DisasContext *s, X86DecodedInsn *decode)
 {
-    int16_t adjust = decode->e.op1 == X86_TYPE_I ? decode->immediate : 0;
+    uint16_t adjust = decode->e.op1 == X86_TYPE_I ? decode->immediate : 0;
 
     MemOp ot = gen_pop_T0(s);
     gen_stack_update(s, adjust + (1 << ot));
@@ -3596,7 +3596,7 @@ static void gen_RET(DisasContext *s, X86DecodedInsn *decode)
 
 static void gen_RETF(DisasContext *s, X86DecodedInsn *decode)
 {
-    int16_t adjust = decode->e.op1 == X86_TYPE_I ? decode->immediate : 0;
+    uint16_t adjust = decode->e.op1 == X86_TYPE_I ? decode->immediate : 0;
 
     if (!PE(s) || VM86(s)) {
         gen_lea_ss_ofs(s, s->A0, cpu_regs[R_ESP], 0);
-- 
2.47.3


