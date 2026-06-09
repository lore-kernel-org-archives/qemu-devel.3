Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDBE8CD6E79
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWsKb-0002tR-J0; Tue, 09 Jun 2026 05:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ewanhai-oc@zhaoxin.com>)
 id 1wWsKZ-0002su-6j
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:01:07 -0400
Received: from mx2.zhaoxin.com ([61.152.208.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ewanhai-oc@zhaoxin.com>)
 id 1wWsKW-0006Ny-TZ
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 05:01:06 -0400
X-ASG-Debug-ID: 1780995648-1eb14e680eba550001-jgbH7p
Received: from zhaoxin.com (zxmail.zhaoxin.com [10.28.208.166]) by
 mx2.zhaoxin.com with ESMTP id yty3qPU1YxVu3J8f;
 Tue, 09 Jun 2026 17:00:48 +0800 (CST)
X-Barracuda-Envelope-From: ewanhai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.208.166
Received: from ewan-server.tailb932da.ts.net (ewan-server.tailb932da.ts.net
 [10.28.24.2])
 by zhaoxin.com (8.30) with ESMTP31da6c6485e89d1230eb1cb1fbbf5085
 Tue, 09 Jun 2026 17:00:47 +0800
X-Eyou-Smtpauth: ewanhai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.24.2
X-Eyou-EnvelopeSender: ewanhai-oc@zhaoxin.com
X-Eyou-From: Ewan Hai <ewanhai-oc@zhaoxin.com>
From: "=?UTF-8?B?RXdhbiBIYWktb2M=?=" <ewanhai-oc@zhaoxin.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com
Subject: [PATCH] target/i386/cpu: don't assert on out-of-range CPUID 0x1f
 subleaf
Date: Tue,  9 Jun 2026 17:00:46 +0800
X-ASG-Orig-Subj: [PATCH] target/i386/cpu: don't assert on out-of-range CPUID
 0x1f subleaf
Message-Id: <20260609090046.2376016-1-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <ewanhai-oc@zhaoxin.com>
X-Barracuda-Connect: zxmail.zhaoxin.com[10.28.208.166]
X-Barracuda-Start-Time: 1780995648
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1920
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -0.76
X-Barracuda-Spam-Status: No,
 SCORE=-0.76 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=FROM_EXCESS_BASE64,
 FROM_EXCESS_BASE64_2, PR0N_SUBJECT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.159796
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
 0.01 FROM_EXCESS_BASE64     From: base64 encoded unnecessarily
 0.20 PR0N_SUBJECT Subject has letters around special characters (pr0n)
 1.05 FROM_EXCESS_BASE64_2   From: base64 encoded unnecessarily
Received-SPF: pass client-ip=61.152.208.219;
 envelope-from=ewanhai-oc@zhaoxin.com; helo=mx2.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FROM_EXCESS_BASE64=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

encode_topo_cpuid1f() asserts count <= CPU_TOPOLOGY_LEVEL_SOCKET, but
count is the subleaf index passed straight from the guest's ECX;
cpu_x86_cpuid() does not clamp it for leaf 0x1f. On a TCG vCPU exposing
0x1f, any CPUID(0x1f) with ECX > 5 aborts QEMU. SeaBIOS already trips
this during POST (its cpuid() helper leaves a stale ECX from the
EFLAGS.ID probe), and guests reach it too,the kernel walks 0x1f
subleaves in a loop and /dev/cpu/*/cpuid forwards arbitrary subleaves.

Per the SDM, CPUID never faults and a subleaf past the last topology
level returns the invalid encoding (EAX=EBX=0, ECX level type 0, EDX the
x2APIC ID), exactly as the legacy 0xB leaf already does. Return that
instead of asserting. KVM is unaffected.

Affected models: SapphireRapids (v4+), GraniteRapids (v3+), SierraForest
(v3+), ClearwaterForest (v3+), DiamondRapids and YongFeng (v3+).

Fixes: 822bce9f58df ("i386/cpu: Decouple CPUID[0x1F] subleaf with specific topology level")
Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
---
 target/i386/cpu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8929a75c7c..e035e4cf45 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -427,7 +427,14 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
     unsigned long level, base_level, next_level;
     uint32_t num_threads_next_level, offset_next_level;
 
-    assert(count <= CPU_TOPOLOGY_LEVEL_SOCKET);
+    /* Out-of-range subleaf: SDM mandates the invalid encoding, no fault. */
+    if (count > CPU_TOPOLOGY_LEVEL_SOCKET) {
+        *eax = 0;
+        *ebx = 0;
+        *ecx = count & 0xff;
+        *edx = cpu->apic_id;
+        return;
+    }
 
     /*
      * Find the No.(count + 1) topology level in avail_cpu_topo bitmap.

base-commit: cc329c491768b2d91eb0b0984f3baa0bf805776d
-- 
2.34.1


