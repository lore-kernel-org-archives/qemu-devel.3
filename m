Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C313DE6F09F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 15:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY4fS-0000KJ-Gq; Tue, 23 Dec 2025 10:51:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vY4fC-00008R-Oi
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:51:08 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vY4fB-0005Us-9E
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:51:06 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 17C3860143;
 Tue, 23 Dec 2025 15:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048CAC116C6;
 Tue, 23 Dec 2025 15:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766505063;
 bh=DjWpiI5N5cWwn+jQ86+vd53iDYlr5d2zwhULpb1iG0s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=T9VAMNRCrTRNlbJ1XWGaiqHrQKfI3D4OsBvQZorj9eQyECChHpUgN1fXmv7Q9V9kl
 Nyv8z4/QRZRmyemdZPK5AOxGhTs58b1d9ZJqsjOkvpxecOzFIC+Dcbgz3SF0+gZcS1
 r0JH0pOAXRFHB6P2gzaxa0v6WDMq4iuuCN2hfr9h0+8k4bdWY3q2od0ay1YDfdg2/v
 G7i3zBKvnQaF6g737HSZuP/nn+KBmwuDkMke0gTGIIsCskevuDpA+/xFbFdSqt7ezj
 ejdxJqU69Hn3rCxkqDBTNjrheINDtHPj1Rmwf6V+M9bDNwL3xx7qy1tJ9mXzWoJlos
 aT7RCJh+iuVJA==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fam Zheng <fam@euphon.net>
Subject: [PULL 12/12] target/hppa: add 64 bit support to gdbstub
Date: Tue, 23 Dec 2025 16:50:31 +0100
Message-ID: <20251223155031.7110-13-deller@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223155031.7110-1-deller@kernel.org>
References: <20251223155031.7110-1-deller@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Sven Schnelle <svens@stackframe.org>

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 target/hppa/gdbstub.c | 62 ++++++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 21 deletions(-)

diff --git a/target/hppa/gdbstub.c b/target/hppa/gdbstub.c
index 0daa52f7af..777f4a48b9 100644
--- a/target/hppa/gdbstub.c
+++ b/target/hppa/gdbstub.c
@@ -21,16 +21,25 @@
 #include "cpu.h"
 #include "gdbstub/helpers.h"
 
-/*
- * GDB 15 only supports PA1.0 via the remote protocol, and ignores
- * any provided xml.  Which means that any attempt to provide more
- * data results in "Remote 'g' packet reply is too long".
- */
+static int hppa_num_regs(CPUHPPAState *env)
+{
+    return hppa_is_pa20(env) ? 96 : 128;
+}
+
+static int hppa_reg_size(CPUHPPAState *env)
+{
+    return hppa_is_pa20(env) ? 8 : 4;
+}
 
 int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
-    CPUHPPAState *env = cpu_env(cs);
-    uint32_t val;
+    HPPACPU *cpu = HPPA_CPU(cs);
+    CPUHPPAState *env = &cpu->env;
+    target_ulong val;
+
+    if (n >= hppa_num_regs(env)) {
+        return 0;
+    }
 
     switch (n) {
     case 0:
@@ -133,24 +142,35 @@ int hppa_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         val = env->cr[30];
         break;
     case 64 ... 127:
-        val = extract64(env->fr[(n - 64) / 2], (n & 1 ? 0 : 32), 32);
-        break;
-    default:
-        if (n < 128) {
-            val = 0;
+        if (hppa_is_pa20(env)) {
+            val = env->fr[n - 64];
         } else {
-            return 0;
+            val = extract64(env->fr[(n - 64) / 2], (n & 1 ? 0 : 32), 32);
         }
         break;
+    default:
+        val = 0;
+        break;
     }
 
-    return gdb_get_reg32(mem_buf, val);
+    if (hppa_is_pa20(env)) {
+        return gdb_get_reg64(mem_buf, val);
+    } else {
+        return gdb_get_reg32(mem_buf, val);
+    }
 }
 
 int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    CPUHPPAState *env = cpu_env(cs);
-    uint32_t val = ldl_p(mem_buf);
+    HPPACPU *cpu = HPPA_CPU(cs);
+    CPUHPPAState *env = &cpu->env;
+    target_ulong val;
+
+    if (n >= hppa_num_regs(env)) {
+        return 0;
+    }
+
+    val = ldn_p(mem_buf, hppa_reg_size(env));
 
     switch (n) {
     case 0:
@@ -267,16 +287,16 @@ int hppa_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         cpu_hppa_loaded_fr0(env);
         break;
     case 65 ... 127:
-        {
+        if (hppa_is_pa20(env)) {
+            env->fr[n - 64] = val;
+        } else {
             uint64_t *fr = &env->fr[(n - 64) / 2];
             *fr = deposit64(*fr, (n & 1 ? 0 : 32), 32, val);
         }
         break;
     default:
-        if (n >= 128) {
-            return 0;
-        }
         break;
     }
-    return 4;
+
+    return hppa_reg_size(env);
 }
-- 
2.52.0


