Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6944C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfGut-0002M0-Az; Thu, 02 Jul 2026 08:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wfGur-0002La-G2
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:53:17 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wfGup-0007ld-TA
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:53:17 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.73])
 by linux.microsoft.com (Postfix) with ESMTPSA id 8465920B7167;
 Thu,  2 Jul 2026 05:53:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8465920B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1782996793;
 bh=bq8uv8/M+d7V425XxI+caQVZ9sYvYXSUIzrNxIYMxWA=;
 h=From:To:Cc:Subject:Date:From;
 b=jC4NWi5Z9xbBjx6gRUU6v6owaDEFw5utwwowmGEuajH8SFVpRWGzWs0km+n5F4ft6
 oKbKQEqFtEo0yLk2q8VdsSVg3qSvBZ7KQNTzONT8BoxagtG6ctIrV4tnkid42IlOVt
 wze24UHgA4x52hSuuSW+kqSeCprsGYnM6pT9++2k=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [PATCH] target/i386/mshv: Fix cpu feature-leak from host
Date: Thu,  2 Jul 2026 14:53:09 +0200
Message-Id: <20260702125309.450767-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
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

In the current implementation there are subtle bugs that have to do with
the termination of subleaves, resulting in features reported on the
guest that it should not have according to the model.

If a guest model has fewer valid subleaves stopping too early leaves
unspecified gaps that are filled by the host, resulting in potentially
invalid feature combinations, for example:

The host reports features:

CPUID[EAX=01H].ECX.AVX [bit 28] and
CPUID[EAX=07H,ECX=01H].EAX.AVX_VNNI [bit 4]

In the current implementation we would skip over 7.1 completely, not
registering CPUID responses for the subleaf, resulting in a guest with
qemu64 model (which does not feature AVX), reporting AVX_VNNI as
available (passthrough from host).

We need to walk through the max subleaves of leaf 7 and register them
explicitly (also if they're 0).

A second bug was about the propagation of "terminator" subleaves,
all-zero responses that signal the end. We also want to register this
terminator response , so the guest stops enumerating. In the current
implementation we weren't doing that.

Fixes: 4fa04dd1621
Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 126ca40b48..a3b5f4474f 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -997,7 +997,7 @@ static void collect_cpuid_entries(const CPUState *cpu, GList **cpuid_entries)
     CPUX86State *env = &x86_cpu->env;
     uint32_t eax, ebx, ecx, edx;
     uint32_t leaf, subleaf;
-    uint32_t max_basic_leaf, max_extended_leaf;
+    uint32_t max_basic_leaf, max_extended_leaf, max_subleaf_7;
     uint32_t max_subleaf = 0x20;
     uint32_t leaves_with_subleaves[] = {0x04, 0x07, 0x0d, 0x0f, 0x10};
     int n_subleaf_leaves = ARRAY_SIZE(leaves_with_subleaves);
@@ -1035,14 +1035,31 @@ static void collect_cpuid_entries(const CPUState *cpu, GList **cpuid_entries)
             continue;
         }
 
+        /*
+         * Valid subleaves for are reported in 7.0:EAX. We need to register all
+         * subleaves to the maximum subleaf, even if they are 0. Otherwise the
+         * host will supply its own values for a unregistered subleaf, which
+         * can result in an inconsistent feature set.
+         */
+        if (leaf == 0x07) {
+            cpu_x86_cpuid(env, leaf, 0, &max_subleaf_7, &ebx, &ecx, &edx);
+            for (subleaf = 0; subleaf <= max_subleaf_7; subleaf++) {
+                cpu_x86_cpuid(env, leaf, subleaf, &eax, &ebx, &ecx, &edx);
+                add_cpuid_entry(cpuid_entries, leaf, subleaf,
+                                eax, ebx, ecx, edx);
+            }
+            continue;
+        }
+
         subleaf = 0;
         while (subleaf < max_subleaf) {
             cpu_x86_cpuid(env, leaf, subleaf, &eax, &ebx, &ecx, &edx);
 
+            /* register the "terminator" to the guest, before breaking */
+            add_cpuid_entry(cpuid_entries, leaf, subleaf, eax, ebx, ecx, edx);
             if (eax == 0 && ebx == 0 && ecx == 0 && edx == 0) {
                 break;
             }
-            add_cpuid_entry(cpuid_entries, leaf, subleaf, eax, ebx, ecx, edx);
             subleaf++;
         }
     }
-- 
2.34.1


