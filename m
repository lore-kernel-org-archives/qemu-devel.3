Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE379C61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyp6V-0000TY-PN; Tue, 25 Aug 2026 07:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp6U-0000TD-Ug; Tue, 25 Aug 2026 07:14:06 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyp6S-0008F2-W9; Tue, 25 Aug 2026 07:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787656396; bh=aqJkoR3SG5TGWsDFqEEDy1XUwjKQlxrJ2OVUJfQuefA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=huw0xEyvvxEkdVN35sATB8umF8V1l7GDuRAmbBxrGZwykxnhAKliOOj8kd7GuDq45
 pbOBfLQnJFkReW3E1VP1b8mss2KPxWDmVwRKTIBRVyeLWKrhrWamMcr/TiFyUWqKoA
 Zn5f5RQgEuWOIN2rP0cPCI1CkLsyEZD4FgoNtNTfg9uoByJv07SNR6+TSCglY4PiFb
 rQnqp70ddVheugULacMyB27ql6XUIHq8AOQ0bxSVmu+WHb8SEoFiyXf+Y4MdSxGWWY
 dIBh738STqGTY0+uEGLK1ex1IZ/i7xGwAiQqFzAKhgODFWuURc95p2z3U6WSV1pWh2
 DerJ2Q9utf5Iw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 212951CE4A9;
 Tue, 25 Aug 2026 14:13:16 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 37599416275;
 Tue, 25 Aug 2026 14:13:53 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 72C5732595; Tue, 25 Aug 2026 14:13:15 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Andrey Polivoda <apolivodaa433@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v3 141/166] target/i386: allow transition to
 virtual-8086 mode only if CPL == 0 and CPU is not in long mode
Date: Tue, 25 Aug 2026 14:11:37 +0300
Message-ID: <20260825111206.482723-7-mjt@tls.msk.ru>
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

From: Andrey Polivoda <apolivodaa433@gmail.com>

According to the pseudocode for the IRET instruction in both the Intel 64
and IA-32 Architectures Software Developer's Manual and the AMD64 Architecture
Programmer's Manual, a transition to virtual-8086 mode is allowed only if all
of the following conditions are met:

1. The new EFLAGS.VM bit is set to 1.
2. The Current Privilege Level (CPL) is 0.
3. The CPU is in protected mode (and not in long mode).

Currently, QEMU performs only the first check. This omission allows a
transition to virtual-8086 mode from long mode, and also enables the guest's
userspace to trigger this switch.

During a legitimate transition, the EFLAGS register is updated in a way that
allows modification of sensitive fields, such as IOPL and IF (which is expected,
as only privileged code should be able to initiate this transition).

However, due to the lack of appropriate checks, an unprivileged guest userspace
process can now force this transition and freely modify these fields.
This allows the userspace to:

1. Disable interrupts, preventing other processes from running on the CPU.
2. Gain direct hardware I/O access by elevating EFLAGS.IOPL to 3.
3. Crash the guest kernel by setting CS and SS to resemble segments with RPL = 0
   and triggering an exception. Since the kernel is unaware that the process
   entered virtual-8086 mode, it will misinterpret the exception as originating
   from kernel space.

This patch fixes this bug by adding the missing CPL and long mode checks before
jumping to the `return_to_vm86` label.

Fixes: 90a9fdae1f1a ("more ring 0 operations")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3583
Signed-off-by: Andrey Polivoda <apolivodaa433@gmail.com>
Cc: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20260622082119.11903-1-apolivodaa433@gmail.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 36f634fe4ab6b266031164ab8d1160e6d11addda)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index 07ff1cb47eb..8158d6175e2 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -2046,7 +2046,8 @@ static inline void helper_ret_protected(CPUX86State *env, int shift,
             new_cs = popl(&sa) & 0xffff;
             if (is_iret) {
                 new_eflags = popl(&sa);
-                if (new_eflags & VM_MASK) {
+                bool allow_vm86 = (cpl == 0) && !(env->hflags & HF_LMA_MASK);
+                if ((new_eflags & VM_MASK) && allow_vm86) {
                     goto return_to_vm86;
                 }
             }
-- 
2.47.3


