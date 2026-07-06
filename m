Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE0DC44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgins-0000tW-S0; Mon, 06 Jul 2026 08:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wgcQW-0002sC-41
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 02:03:32 -0400
Received: from [115.124.28.173] (helo=out28-173.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wgcQR-0005Rt-7X
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 02:03:31 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436462|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00386058-0.000288194-0.995851;
 FP=16568572874340175179|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033068005250; MF=zhang_wei@open-hieco.net; NM=1;
 PH=DS; RN=6; RT=6; SR=0; TI=SMTPD_---.iEEStvD_1783317368; 
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net
 fp:SMTPD_---.iEEStvD_1783317368 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 06 Jul 2026 13:56:08 +0800
From: zhang_wei@open-hieco.net
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v1 9/9] target/i386: Use AMD ucode-rev default for Hygon
Date: Mon,  6 Jul 2026 13:55:30 +0800
Message-ID: <20260706055530.1752094-10-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.173 (deferred)
Received-SPF: pass client-ip=115.124.28.173;
 envelope-from=zhang_wei@open-hieco.net; helo=out28-173.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 06 Jul 2026 08:51:29 -0400
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

From: Tina Zhang <zhang_wei@open-hieco.net>

QEMU currently gives named Hygon Dhyana CPUs the non-AMD default
ucode-rev value, 0x100000000.  That is the Intel/KVM-VMX-shaped
encoding, where the visible revision is in the high 32 bits.

Linux reads MSR 0x8b for Hygon CPUs through the AMD patch-level path,
using MSR_AMD64_PATCH_LEVEL and storing the low 32 bits as
cpuinfo_x86.microcode.  With the old QEMU default, a Dhyana guest sees
microcode revision 0.

Use the AMD/KVM-SVM-shaped default, 0x01000065, for Hygon on this
specific MSR 0x8b default path.  This does not route Hygon through AMD
microcode loading and does not claim that Hygon CPUs are otherwise
identical to AMD CPUs.

Preserve migration ABI through the Hygon vendor ABI fixes property.
pc-11.0 and older machine types leave it off, so they retain the previous
ucode-rev default.  Explicit
user-provided ucode-rev values still override the default.

Add qtest coverage for the new default, the compatibility cases, and an
explicit user override.

Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 target/i386/cpu.c                   |  8 ++++++--
 tests/qtest/test-x86-cpuid-compat.c | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 279c9b3ae7..af1e5f2857 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10232,10 +10232,14 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
     if (cpu->ucode_rev == 0) {
         /*
          * The default is the same as KVM's. Note that this check
-         * needs to happen after the evenual setting of ucode_rev in
+         * needs to happen after the eventual setting of ucode_rev in
          * accel-specific code in cpu_exec_realizefn.
+         *
+         * Hygon uses the AMD patch-level MSR 0x8b encoding, where the visible
+         * microcode revision is in the low 32 bits.
          */
-        if (IS_AMD_CPU(env)) {
+        if (IS_AMD_CPU(env) ||
+            (IS_HYGON_CPU(env) && cpu->hygon_vendor_abi_fixes)) {
             cpu->ucode_rev = 0x01000065;
         } else {
             cpu->ucode_rev = 0x100000000ULL;
diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index b7f8834052..06cbf35d76 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -404,6 +404,25 @@ static const CpuidTestArgs cpuid_tests[] = {
         "486", "xlevel2=0xC0000002,xstore=on",
         NULL, "xlevel2", 0xC0000002,
     },
+    {
+        "x86/cpuid/props/dhyana/ucode-rev/default",
+        "Dhyana", NULL, NULL, "ucode-rev", 0x01000065,
+    },
+    {
+        "x86/cpuid/props/dhyana/ucode-rev/compat-off",
+        "Dhyana", "x-hygon-vendor-abi-fixes=off", NULL,
+        "ucode-rev", 0x100000000LL,
+    },
+    {
+        "x86/cpuid/props/dhyana/ucode-rev/pc-i440fx-11.0",
+        "Dhyana", NULL, "pc-i440fx-11.0",
+        "ucode-rev", 0x100000000LL,
+    },
+    {
+        "x86/cpuid/props/dhyana/ucode-rev/user",
+        "Dhyana", "ucode-rev=0x12345678", NULL,
+        "ucode-rev", 0x12345678,
+    },
 };
 
 /*
-- 
2.43.7


