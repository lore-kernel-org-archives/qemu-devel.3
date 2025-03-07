Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D2BC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdnV-00080s-G4; Fri, 07 Mar 2025 14:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuwe@linux.microsoft.com>)
 id 1tqdnJ-0007yY-Vh
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:55:42 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuwe@linux.microsoft.com>) id 1tqdnH-0005hz-3d
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:55:41 -0500
Received: by linux.microsoft.com (Postfix, from userid 1031)
 id 2113E2038F3C; Fri,  7 Mar 2025 11:55:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2113E2038F3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741377336;
 bh=7gUTKz65BdWqaOVlU2Edtf+4FVAYbqp85kvSHhFlsg0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KYXzTIuZgRUgpFKNHyxrCoy927T39uMHNyP5vuv6/f+r26cIEX8HseA8QACZWIvOp
 VL1fgnSJXKjVYre9cSkHQvfcDFmOiP9u5XJDg1SKCPT/u4Z+6WVwIXZJRGVoi1JekC
 ga8YzwqbAQqK1DCAc0nY6Q+YWNNBsryqpvxSQt40=
From: Wei Liu <liuwe@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com, liuwe@microsoft.com,
 muislam@microsoft.com, ziqiaozhou@microsoft.com,
 mukeshrathor@microsoft.com, magnuskulke@microsoft.com,
 prapal@microsoft.com, jpiotrowski@microsoft.com, deviv@microsoft.com,
 Wei Liu <liuwe@linux.microsoft.com>
Subject: [PATCH v2 02/14] target/i386/hvf: remove HVF specific calls from
 x86_decode.c
Date: Fri,  7 Mar 2025 11:55:13 -0800
Message-Id: <1741377325-28175-3-git-send-email-liuwe@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741377325-28175-1-git-send-email-liuwe@linux.microsoft.com>
References: <1741377325-28175-1-git-send-email-liuwe@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=liuwe@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Use the newly defined emul_ops. This allows the module to be reused
by other accelerator in the future.

No functional change intended.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
---
 target/i386/hvf/x86_decode.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 5fea2dd3cc03..728e15963817 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -21,6 +21,7 @@
 #include "panic.h"
 #include "x86_decode.h"
 #include "vmx.h"
+#include "x86_emu.h"
 #include "x86_mmu.h"
 #include "x86_descr.h"
 
@@ -74,7 +75,7 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
         break;
     }
     target_ulong va  = linear_rip(env_cpu(env), env->eip) + decode->len;
-    vmx_read_mem(env_cpu(env), &val, va, size);
+    emul_ops->read_mem(env_cpu(env), &val, va, size);
     decode->len += size;
     
     return val;
@@ -1893,16 +1894,6 @@ static void decode_prefix(CPUX86State *env, struct x86_decode *decode)
     }
 }
 
-static struct x86_segment_descriptor get_cs_descriptor(CPUState *s)
-{
-    struct vmx_segment vmx_cs;
-    x86_segment_descriptor cs;
-    vmx_read_segment_descriptor(s, &vmx_cs, R_CS);
-    vmx_segment_to_x86_descriptor(s, &vmx_cs, &cs);
-
-    return cs;
-}
-
 void set_addressing_size(CPUX86State *env, struct x86_decode *decode)
 {
     decode->addressing_size = -1;
@@ -1914,7 +1905,8 @@ void set_addressing_size(CPUX86State *env, struct x86_decode *decode)
         }
     } else if (!x86_is_long_mode(env_cpu(env))) {
         /* protected */
-        x86_segment_descriptor cs = get_cs_descriptor(env_cpu(env));
+        x86_segment_descriptor cs;
+        emul_ops->read_segment_descriptor(env_cpu(env), &cs, R_CS);
         /* check db */
         if (cs.db) {
             if (decode->addr_size_override) {
@@ -1950,7 +1942,8 @@ void set_operand_size(CPUX86State *env, struct x86_decode *decode)
         }
     } else if (!x86_is_long_mode(env_cpu(env))) {
         /* protected */
-        x86_segment_descriptor cs = get_cs_descriptor(env_cpu(env));
+        x86_segment_descriptor cs;
+        emul_ops->read_segment_descriptor(env_cpu(env), &cs, R_CS);
         /* check db */
         if (cs.db) {
             if (decode->op_size_override) {
-- 
2.47.2


