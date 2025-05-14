Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061FCC3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 19:03:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFHNb-0006qN-BP; Wed, 14 May 2025 15:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFHLU-0004A7-9i; Wed, 14 May 2025 15:00:52 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uFHLR-0007FG-VF; Wed, 14 May 2025 15:00:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EA93A121D8B;
 Wed, 14 May 2025 22:00:31 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id EFDD420BA7D;
 Wed, 14 May 2025 22:00:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.1 01/23] target/i386: Fix model number of Zhaoxin
 YongFeng vCPU template
Date: Wed, 14 May 2025 22:00:13 +0300
Message-Id: <20250514190041.104759-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-10.0.1-20250514114019@cover.tls.msk.ru>
References: <qemu-stable-10.0.1-20250514114019@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

From: Ewan Hai <ewanhai-oc@zhaoxin.com>

The model number was mistakenly set to 0x0b (11) in commit ff04bc1ac4.
The correct value is 0x5b. This mistake occurred because the extended
model bits in cpuid[eax=0x1].eax were overlooked, and only the base
model was used.

Using the wrong model number can affect guest behavior. One known issue
is that vPMU (which relies on the model number) may fail to operate
correctly.

This patch corrects the model field by introducing a new vCPU version.

Fixes: ff04bc1ac4 ("target/i386: Introduce Zhaoxin Yongfeng CPU model")
Signed-off-by: Ewan Hai <ewanhai-oc@zhaoxin.com>
Link: https://lore.kernel.org/r/20250414075342.411626-1-ewanhai-oc@zhaoxin.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 280712b78781c43511d6286d40f9a518a4de25ff)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1b64ceaaba..3fb1ec62da 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5621,6 +5621,18 @@ static const X86CPUDefinition builtin_x86_defs[] = {
         .features[FEAT_VMX_VMFUNC] = MSR_VMX_VMFUNC_EPT_SWITCHING,
         .xlevel = 0x80000008,
         .model_id = "Zhaoxin YongFeng Processor",
+        .versions = (X86CPUVersionDefinition[]) {
+            { .version = 1 },
+            {
+                .version = 2,
+                .note = "with the correct model number",
+                .props = (PropValue[]) {
+                    { "model", "0x5b" },
+                    { /* end of list */ }
+                }
+            },
+            { /* end of list */ }
+        }
     },
 };
 
-- 
2.39.5


