Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507CBCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN3K-0003Uz-PI; Wed, 07 Oct 2026 04:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xEHta-0007bd-Pf
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:00:56 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xEHtU-0005OR-GW
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:00:38 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.46])
 by linux.microsoft.com (Postfix) with ESMTPSA id 0D3CE20B716F;
 Tue,  6 Oct 2026 09:48:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0D3CE20B716F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1791305333;
 bh=/020cZP/SxmAv3MJqbdOEp/uZAEilcUIUL9EIhRvPUU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=esL5t01Bjqg5v2kKsornLr4SWta3LuxI0nVnj2sNRdSgOzG+o6VUKfHW/htkEYN8W
 zOJ2LMI/yly6mefwDNloZGQ/XtR47CIWr8IIz/pE4MrEliXtRbThxwoDvuZMO3lCO0
 y5KB5qm8Cdovwc0i4gOV7oZqWCPTKuHFYtRY+se0=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 08/11] target/i386/mshv: Fix cpu feature-leak from host
Date: Tue,  6 Oct 2026 18:49:02 +0200
Message-Id: <20261006164905.776466-9-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006164905.776466-1-magnuskulke@linux.microsoft.com>
References: <20261006164905.776466-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 4f113da02d..f2b5641231 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1079,7 +1079,7 @@ static void collect_cpuid_entries(const CPUState *cpu, GList **cpuid_entries)
     CPUX86State *env = &x86_cpu->env;
     uint32_t eax, ebx, ecx, edx;
     uint32_t leaf, subleaf;
-    uint32_t max_basic_leaf, max_extended_leaf;
+    uint32_t max_basic_leaf, max_extended_leaf, max_subleaf_7;
     uint32_t max_subleaf = 0x20;
     uint32_t leaves_with_subleaves[] = {0x04, 0x07, 0x0d, 0x0f, 0x10};
     int n_subleaf_leaves = ARRAY_SIZE(leaves_with_subleaves);
@@ -1117,14 +1117,31 @@ static void collect_cpuid_entries(const CPUState *cpu, GList **cpuid_entries)
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


