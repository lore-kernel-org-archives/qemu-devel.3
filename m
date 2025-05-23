Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3638C54ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 21:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIZlg-00039w-B7; Fri, 23 May 2025 17:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stdcalllevi@yandex-team.ru>)
 id 1uIUZk-0006HF-QK
 for qemu-devel@nongnu.org; Fri, 23 May 2025 11:44:48 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stdcalllevi@yandex-team.ru>)
 id 1uIUZi-0000ZQ-A2
 for qemu-devel@nongnu.org; Fri, 23 May 2025 11:44:48 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:2b89:0:640:9815:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 76F8D613C2;
 Fri, 23 May 2025 18:44:39 +0300 (MSK)
Received: from dev-vm2-nested.ru-central1.internal (unknown
 [2a02:6b8:c0e:501:0:fca5:0:123])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ViSnaZ0FfqM0-SZi5ZzzK; Fri, 23 May 2025 18:44:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1748015079;
 bh=iWz0ReyH+SKNmPaGDhMX0bWIwvt8gZviHfnomndUJSc=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=sTwBEjn/dW8AhUwtn7NsK4RzATPJHv3WSr3H5GVjmvC/MODF/0Bz1h/iLmnazDeK8
 Y2kc+UP/51MT6bzh0+RzNafWJmUBj4bRl1LeM0wggQ+UTN+r+6X9WOoDNdi0MP8iyr
 VYA4s8bvOg2sUfqs2renxfOb6tgqWXVa9aAqmx/Q=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Kirill Martynov <stdcalllevi@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kirill Martynov <stdcalllevi@yandex-team.ru>
Subject: [PATCH] x86/cpu: Handle SMM mode in x86_cpu_dump_state for softmmu
Date: Fri, 23 May 2025 15:44:31 +0000
Message-ID: <20250523154431.506993-1-stdcalllevi@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=stdcalllevi@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 23 May 2025 17:17:23 -0400
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

Certain error conditions can trigger x86_cpu_dump_state() to output CPU state
debug information e.g. KVM emulation failure due to misbehaving guest.
However, if the CPU is in System Management Mode (SMM) when the assertion
in cpu_asidx_from_attrs failure happens because:

1. In SMM mode (smm=1), the CPU must use multiple address spaces
   with a dedicated SMM address space
2. On machine types with softmmu, address spaces are hardcoded to 1
   (no multiple address spaces available)

The assertion occurs in cpu_asidx_from_attrs() when trying to
access memory in SMM mode with insufficient address spaces.

Fix this by:
1. If number of address spaces is 1 always use index 0
2. In other cases use attr.secure for identified proper index

This prevents the assertion while still providing useful debug
output during VM shutdown errors.

Stack trace of the original issue:
#0  ... in raise () from /lib/x86_64-linux-gnu/libc.so.6
#1  ... in abort () from /lib/x86_64-linux-gnu/libc.so.6
#2  ... in ?? () from /lib/x86_64-linux-gnu/libc.so.6
#3  ... in __assert_fail () from /lib/x86_64-linux-gnu/libc.so.6
#4  ... in cpu_asidx_from_attrs (cpu=cpu@entry=0x5578ca2eb340, attrs=...)
   at ../hw/core/cpu-sysemu.c:76
#5  ... in cpu_memory_rw_debug (cpu=cpu@entry=0x5578ca2eb340,
   addr=addr@entry=2147258348, ptr=ptr@entry=0x7f5341ca373c, len=len@entry=1,
    is_write=is_write@entry=false) at ../softmmu/physmem.c:3529
#6  ... in x86_cpu_dump_state (cs=0x5578ca2eb340,
   f=0x7f53434065c0 <_IO_2_1_stderr_>, flags=<optimized out>)
   at ../target/i386/cpu-dump.c:560
#7  ... in kvm_cpu_exec (cpu=cpu@entry=0x5578ca2eb340)
   at ../accel/kvm/kvm-all.c:3000
#8  ... in kvm_vcpu_thread_fn (arg=arg@entry=0x5578ca2eb340)
   at ../accel/kvm/kvm-accel-ops.c:51
#9  ... in qemu_thread_start (args=<optimized out>)
   at ../util/qemu-thread-posix.c:505
#10 ... in start_thread () from /lib/x86_64-linux-gnu/libpthread.so.0
#11 ... in clone () from /lib/x86_64-linux-gnu/libc.so.6

Signed-off-by: Kirill Martynov <stdcalllevi@yandex-team.ru>
---
 target/i386/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c51e0a43d0..2616a61c87 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2507,7 +2507,7 @@ void cpu_sync_avx_hflag(CPUX86State *env);
 #ifndef CONFIG_USER_ONLY
 static inline int x86_asidx_from_attrs(CPUState *cs, MemTxAttrs attrs)
 {
-    return !!attrs.secure;
+    return cs->num_ases == 1 ? 0 : (!!attrs.secure);
 }
 
 static inline AddressSpace *cpu_addressspace(CPUState *cs, MemTxAttrs attrs)
-- 
2.43.0


