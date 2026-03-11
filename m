Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F44112589B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0PN3-0003Gm-8Z; Wed, 11 Mar 2026 15:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PMx-0003D2-Ic; Wed, 11 Mar 2026 15:37:23 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0PMu-0000Mu-H3; Wed, 11 Mar 2026 15:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257668; bh=M6opmQWek9i4k2a3jmuHHkaT2owoodzgFfXuXulARNg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=p+r34zxwov4aS//O2Y5L1OLA2xxDnQBpWfbHUm6gscMWBj1BdUjzPgIjKfTbrxu5l
 dPycrUwtF1cdxv4gU9PySOlOhprpKP4crjcC8QzXm1JPtEDDsHbLYKcOLQTIPwUNr+
 3Zl2yEJz18jXSr13X5WZd0PpxTKsJYrTLKBnFdpBAtkM+5SmrCnSLxCX6AVc1Z7hcG
 JwuwShGyT+WIn+riZjc6+vDL4gvqsgeT6UZroAOGG0rb8NKZGXSOGBXYL5KJ6M4diE
 ymlhZSlqcwf4WkrGKPeD4R0JEVTnj1MS/dHfTdryF6QnCRNrQas2cvKmF7mVzD4F2l
 LBm7mgtgRe85w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 39EB7192102;
 Wed, 11 Mar 2026 22:34:28 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 74EF737C467;
 Wed, 11 Mar 2026 22:35:06 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 Justin Forbes <jforbes@fedoraproject.org>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 26/53] hw/i386/vmmouse: Fix hypercall clobbers
Date: Wed, 11 Mar 2026 22:34:19 +0300
Message-ID: <20260311193449.1096110-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Josh Poimboeuf <jpoimboe@kernel.org>

Fedora QA reported the following kernel panic:

  BUG: unable to handle page fault for address: 0000000040003e54
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  PGD 1082ec067 P4D 0
  Oops: Oops: 0002 [#1] SMP NOPTI
  CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.19.0-0.rc4.260108gf0b9d8eb98df.34.fc43.x86_64 #1 PREEMPT(lazy)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20251119-3.fc43 11/19/2025
  RIP: 0010:vmware_hypercall4.constprop.0+0x52/0x90
  Code: 48 83 c4 20 5b e9 69 f0 fc fe 8b 05 a0 c1 b2 01 85 c0 74 23 b8 68 58 4d 56 b9 27 00 00 00 31 d2 bb 04 00 00 00 66 ba 58 56 ed <89> 1f 89 0e 41 89 10 5b e9 3c f0 fc fe 6a 00 49 89 f9 45 31 c0 31
  RSP: 0018:ff5eeb3240003e40 EFLAGS: 00010046
  RAX: 0000000000000000 RBX: 000000000000ffca RCX: 000000000000ffac
  RDX: 0000000000000000 RSI: 0000000040003e58 RDI: 0000000040003e54
  RBP: ff1e05f3c1204800 R08: ff5eeb3240003e5c R09: 000000009d899c41
  R10: 000000000000003d R11: ff5eeb3240003ff8 R12: 0000000000000000
  R13: 00000000000000ff R14: ff1e05f3c02f9e00 R15: 000000000000000c
  FS:  0000000000000000(0000) GS:ff1e05f489e40000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000040003e54 CR3: 000000010841d002 CR4: 0000000000771ef0
  PKRU: 55555554
  Call Trace:
   <IRQ>
   vmmouse_report_events+0x13e/0x1b0
   psmouse_handle_byte+0x15/0x60
   ps2_interrupt+0x8a/0xd0
   ...

It was triggered by dereferencing a bad pointer (RDI) immediately after
a VMware hypercall for VMWARE_CMD_ABSPOINTER_DATA in the vmmouse driver:

  ffffffff82135070 <vmware_hypercall4.constprop.0>:
  ...
  ffffffff821350ac:       b8 68 58 4d 56          mov    $0x564d5868,%eax
  ffffffff821350b1:       b9 27 00 00 00          mov    $0x27,%ecx
  ffffffff821350b6:       31 d2                   xor    %edx,%edx
  ffffffff821350b8:       bb 04 00 00 00          mov    $0x4,%ebx
  ffffffff821350bd:       66 ba 58 56             mov    $0x5658,%dx
  ffffffff821350c1:       ed                      in     (%dx),%eax	<-- hypercall
  ffffffff821350c2:       89 1f                   mov    %ebx,(%rdi)	<-- crash

Reading the kernel disassembly shows that RDI should contain the value
of a valid kernel stack address here (0xff5eeb3240003e54).  Instead it
contains 0x40003e54, suggesting the hypervisor cleared the upper 32
bits.

And indeed, Alexey discovered that QEMU's vmmouse_get_data() and
vmmouse_set_data() are only saving/restoring the lower 32 bits, while
clearing the upper 32.  Fix that by changing the type of the saved data
array from uint32_t to uint64_t.

Fixes: 548df2acc6fc ("VMMouse Emulation, by Anthony Liguori.")
Reported-by: Justin Forbes <jforbes@fedoraproject.org>
Debugged-by: Alexey Makhalov <alexey.makhalov@broadcom.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/c508fc1d4a4ccd8c9fb1e51b71df089e31115a53.1770309998.git.jpoimboe@kernel.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3293
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 48c8916aec4319efc60324d9d971831a8a1d6350)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index 3896159b05..07184a8d56 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -72,7 +72,7 @@ struct VMMouseState {
     ISAKBDState *i8042;
 };
 
-static void vmmouse_get_data(uint32_t *data)
+static void vmmouse_get_data(uint64_t *data)
 {
     X86CPU *cpu = X86_CPU(current_cpu);
     CPUX86State *env = &cpu->env;
@@ -82,7 +82,7 @@ static void vmmouse_get_data(uint32_t *data)
     data[4] = env->regs[R_ESI]; data[5] = env->regs[R_EDI];
 }
 
-static void vmmouse_set_data(const uint32_t *data)
+static void vmmouse_set_data(const uint64_t *data)
 {
     X86CPU *cpu = X86_CPU(current_cpu);
     CPUX86State *env = &cpu->env;
@@ -197,7 +197,7 @@ static void vmmouse_disable(VMMouseState *s)
     vmmouse_remove_handler(s);
 }
 
-static void vmmouse_data(VMMouseState *s, uint32_t *data, uint32_t size)
+static void vmmouse_data(VMMouseState *s, uint64_t *data, uint32_t size)
 {
     int i;
 
@@ -221,7 +221,7 @@ static void vmmouse_data(VMMouseState *s, uint32_t *data, uint32_t size)
 static uint32_t vmmouse_ioport_read(void *opaque, uint32_t addr)
 {
     VMMouseState *s = opaque;
-    uint32_t data[6];
+    uint64_t data[6];
     uint16_t command;
 
     vmmouse_get_data(data);
@@ -247,7 +247,7 @@ static uint32_t vmmouse_ioport_read(void *opaque, uint32_t addr)
             vmmouse_request_absolute(s);
             break;
         default:
-            printf("vmmouse: unknown command %x\n", data[1]);
+            printf("vmmouse: unknown command %" PRIx64 "\n", data[1]);
             break;
         }
         break;
-- 
2.47.3


