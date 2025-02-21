Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A55AC021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 14:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTbL-0008Sb-AE; Fri, 21 Feb 2025 09:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuwe@linux.microsoft.com>)
 id 1tlOX4-0006Xo-Qx
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:37:15 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuwe@linux.microsoft.com>) id 1tlOX1-00018Z-9o
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:37:13 -0500
Received: by linux.microsoft.com (Postfix, from userid 1031)
 id 3DF282054593; Fri, 21 Feb 2025 00:36:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3DF282054593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740126990;
 bh=/Q2sCDBVnhdLE0bPHid8ZnDApsB2tBkaKG720JHrJmU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bhLOm8MQdw/+qvNTlGB9D0Wp+N85uWzdR+4vkMVB28DN8NbJEw+o6zF022RfYSS48
 iW9nyMr+tdkgwyH/kMJN8hrLDnqepr9dUXq5i8bwiiQxJ21xiOzc/24aQ3fZWVccty
 t2kxpE7h928g+hb8jOwsEm0x4DjE82mbIUaeTaBw=
From: Wei Liu <liuwe@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com, liuwe@microsoft.com,
 muislam@microsoft.com, ziqiaozhou@microsoft.com,
 mukeshrathor@microsoft.com, magnuskulke@microsoft.com,
 prapal@microsoft.com, jpiotrowski@microsoft.com, deviv@microsoft.com,
 Wei Liu <liuwe@linux.microsoft.com>
Subject: [RFC PATCH v1 19/19] target/i386: move x86 instruction emulator out
 of hvf
Date: Fri, 21 Feb 2025 00:36:27 -0800
Message-Id: <1740126987-8483-20-git-send-email-liuwe@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
References: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=liuwe@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 21 Feb 2025 09:01:15 -0500
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

Move x86_decode, x86_emu, x86_flags and some headers to the new location.
Fix up all the inclusion sites in hvf.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
---
 target/i386/hvf/hvf.c                           | 8 ++++----
 target/i386/hvf/meson.build                     | 3 ---
 target/i386/hvf/vmx.h                           | 2 +-
 target/i386/hvf/x86.c                           | 4 ++--
 target/i386/hvf/x86_cpuid.c                     | 2 +-
 target/i386/hvf/x86_descr.h                     | 2 +-
 target/i386/hvf/x86_mmu.c                       | 2 +-
 target/i386/hvf/x86_task.c                      | 6 +++---
 target/i386/hvf/x86hvf.c                        | 2 +-
 target/i386/x86-insn-emul/meson.build           | 5 +++++
 target/i386/{hvf => x86-insn-emul}/x86.h        | 0
 target/i386/{hvf => x86-insn-emul}/x86_decode.c | 0
 target/i386/{hvf => x86-insn-emul}/x86_decode.h | 0
 target/i386/{hvf => x86-insn-emul}/x86_emu.c    | 0
 target/i386/{hvf => x86-insn-emul}/x86_emu.h    | 0
 target/i386/{hvf => x86-insn-emul}/x86_flags.c  | 0
 target/i386/{hvf => x86-insn-emul}/x86_flags.h  | 0
 17 files changed, 19 insertions(+), 17 deletions(-)
 rename target/i386/{hvf => x86-insn-emul}/x86.h (100%)
 rename target/i386/{hvf => x86-insn-emul}/x86_decode.c (100%)
 rename target/i386/{hvf => x86-insn-emul}/x86_decode.h (100%)
 rename target/i386/{hvf => x86-insn-emul}/x86_emu.c (100%)
 rename target/i386/{hvf => x86-insn-emul}/x86_emu.h (100%)
 rename target/i386/{hvf => x86-insn-emul}/x86_flags.c (100%)
 rename target/i386/{hvf => x86-insn-emul}/x86_flags.h (100%)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 57a8029cfa..aeef3dbde6 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -59,12 +59,12 @@
 #include "hvf-i386.h"
 #include "vmcs.h"
 #include "vmx.h"
-#include "x86.h"
+#include "x86-insn-emul/x86.h"
 #include "x86_descr.h"
-#include "x86_flags.h"
+#include "x86-insn-emul/x86_flags.h"
 #include "x86_mmu.h"
-#include "x86_decode.h"
-#include "x86_emu.h"
+#include "x86-insn-emul/x86_decode.h"
+#include "x86-insn-emul/x86_emu.h"
 #include "x86_task.h"
 #include "x86hvf.h"
 
diff --git a/target/i386/hvf/meson.build b/target/i386/hvf/meson.build
index 05c3c8cf18..519d190f0e 100644
--- a/target/i386/hvf/meson.build
+++ b/target/i386/hvf/meson.build
@@ -2,10 +2,7 @@ i386_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: files(
   'hvf.c',
   'x86.c',
   'x86_cpuid.c',
-  'x86_decode.c',
   'x86_descr.c',
-  'x86_emu.c',
-  'x86_flags.c',
   'x86_mmu.c',
   'x86_task.c',
   'x86hvf.c',
diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
index 80ce26279b..d012781d46 100644
--- a/target/i386/hvf/vmx.h
+++ b/target/i386/hvf/vmx.h
@@ -29,7 +29,7 @@
 #include <Hypervisor/hv_vmx.h>
 #include "vmcs.h"
 #include "cpu.h"
-#include "x86.h"
+#include "x86-insn-emul/x86.h"
 #include "system/hvf.h"
 #include "system/hvf_int.h"
 
diff --git a/target/i386/hvf/x86.c b/target/i386/hvf/x86.c
index a0ede13886..3b9d0716fe 100644
--- a/target/i386/hvf/x86.c
+++ b/target/i386/hvf/x86.c
@@ -19,8 +19,8 @@
 #include "qemu/osdep.h"
 
 #include "cpu.h"
-#include "x86_decode.h"
-#include "x86_emu.h"
+#include "x86-insn-emul/x86_decode.h"
+#include "x86-insn-emul/x86_emu.h"
 #include "vmcs.h"
 #include "vmx.h"
 #include "x86_mmu.h"
diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index ae836f65cc..1b7a3579c8 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -24,7 +24,7 @@
 #include "qemu/cpuid.h"
 #include "host/cpuinfo.h"
 #include "cpu.h"
-#include "x86.h"
+#include "x86-insn-emul/x86.h"
 #include "vmx.h"
 #include "system/hvf.h"
 #include "hvf-i386.h"
diff --git a/target/i386/hvf/x86_descr.h b/target/i386/hvf/x86_descr.h
index ce5de98349..2b403b36ce 100644
--- a/target/i386/hvf/x86_descr.h
+++ b/target/i386/hvf/x86_descr.h
@@ -19,7 +19,7 @@
 #ifndef HVF_X86_DESCR_H
 #define HVF_X86_DESCR_H
 
-#include "x86.h"
+#include "x86-insn-emul/x86.h"
 
 typedef struct vmx_segment {
     uint16_t sel;
diff --git a/target/i386/hvf/x86_mmu.c b/target/i386/hvf/x86_mmu.c
index 579d0c3a4c..648ff6f7f2 100644
--- a/target/i386/hvf/x86_mmu.c
+++ b/target/i386/hvf/x86_mmu.c
@@ -19,7 +19,7 @@
 #include "qemu/osdep.h"
 #include "panic.h"
 #include "cpu.h"
-#include "x86.h"
+#include "x86-insn-emul/x86.h"
 #include "x86_mmu.h"
 #include "vmcs.h"
 #include "vmx.h"
diff --git a/target/i386/hvf/x86_task.c b/target/i386/hvf/x86_task.c
index 161217991f..88b1c0a8bf 100644
--- a/target/i386/hvf/x86_task.c
+++ b/target/i386/hvf/x86_task.c
@@ -14,11 +14,11 @@
 #include "hvf-i386.h"
 #include "vmcs.h"
 #include "vmx.h"
-#include "x86.h"
+#include "x86-insn-emul/x86.h"
 #include "x86_descr.h"
 #include "x86_mmu.h"
-#include "x86_decode.h"
-#include "x86_emu.h"
+#include "x86-insn-emul/x86_decode.h"
+#include "x86-insn-emul/x86_emu.h"
 #include "x86_task.h"
 #include "x86hvf.h"
 
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 531a340b37..2c0d779bca 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -24,7 +24,7 @@
 #include "vmcs.h"
 #include "cpu.h"
 #include "x86_descr.h"
-#include "x86_decode.h"
+#include "x86-insn-emul/x86_decode.h"
 #include "system/hw_accel.h"
 
 #include "hw/i386/apic_internal.h"
diff --git a/target/i386/x86-insn-emul/meson.build b/target/i386/x86-insn-emul/meson.build
index e69de29bb2..4edd4f462f 100644
--- a/target/i386/x86-insn-emul/meson.build
+++ b/target/i386/x86-insn-emul/meson.build
@@ -0,0 +1,5 @@
+i386_system_ss.add(when: [hvf, 'CONFIG_HVF'], if_true: files(
+  'x86_decode.c',
+  'x86_emu.c',
+  'x86_flags.c',
+))
diff --git a/target/i386/hvf/x86.h b/target/i386/x86-insn-emul/x86.h
similarity index 100%
rename from target/i386/hvf/x86.h
rename to target/i386/x86-insn-emul/x86.h
diff --git a/target/i386/hvf/x86_decode.c b/target/i386/x86-insn-emul/x86_decode.c
similarity index 100%
rename from target/i386/hvf/x86_decode.c
rename to target/i386/x86-insn-emul/x86_decode.c
diff --git a/target/i386/hvf/x86_decode.h b/target/i386/x86-insn-emul/x86_decode.h
similarity index 100%
rename from target/i386/hvf/x86_decode.h
rename to target/i386/x86-insn-emul/x86_decode.h
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/x86-insn-emul/x86_emu.c
similarity index 100%
rename from target/i386/hvf/x86_emu.c
rename to target/i386/x86-insn-emul/x86_emu.c
diff --git a/target/i386/hvf/x86_emu.h b/target/i386/x86-insn-emul/x86_emu.h
similarity index 100%
rename from target/i386/hvf/x86_emu.h
rename to target/i386/x86-insn-emul/x86_emu.h
diff --git a/target/i386/hvf/x86_flags.c b/target/i386/x86-insn-emul/x86_flags.c
similarity index 100%
rename from target/i386/hvf/x86_flags.c
rename to target/i386/x86-insn-emul/x86_flags.c
diff --git a/target/i386/hvf/x86_flags.h b/target/i386/x86-insn-emul/x86_flags.h
similarity index 100%
rename from target/i386/hvf/x86_flags.h
rename to target/i386/x86-insn-emul/x86_flags.h
-- 
2.39.5 (Apple Git-154)


