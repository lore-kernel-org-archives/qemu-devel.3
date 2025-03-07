Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B49C28B28
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdna-00081a-6T; Fri, 07 Mar 2025 14:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuwe@linux.microsoft.com>)
 id 1tqdnM-0007zN-41
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:55:44 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuwe@linux.microsoft.com>) id 1tqdnK-0005ib-3q
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:55:43 -0500
Received: by linux.microsoft.com (Postfix, from userid 1031)
 id 4AB142038F3F; Fri,  7 Mar 2025 11:55:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4AB142038F3F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1741377336;
 bh=FZmm7Arvwo6yz+fCYEZ+cN2f/QxcM9KlwRwPHLMST9k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sou2N9MqfqHyfLv8DGhaFo0K7mC8eNGH6T4DUvjyGPx4WDMQ+V/JN3sBjunUxr9Us
 S4yTv7ziCoCtUDioTyIzjEcIy1u7MFdBK4VMy3wjpemIuPI9zkdOzWfEuYfQbV23gJ
 gTkBsF5r1GFiny0IM+oFOgnTtFOFbTGMWSKF/ivM=
From: Wei Liu <liuwe@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com, liuwe@microsoft.com,
 muislam@microsoft.com, ziqiaozhou@microsoft.com,
 mukeshrathor@microsoft.com, magnuskulke@microsoft.com,
 prapal@microsoft.com, jpiotrowski@microsoft.com, deviv@microsoft.com,
 Wei Liu <liuwe@linux.microsoft.com>
Subject: [PATCH v2 05/14] target/i386/hvf: use emul_ops->read_mem in x86_emu.c
Date: Fri,  7 Mar 2025 11:55:16 -0800
Message-Id: <1741377325-28175-6-git-send-email-liuwe@linux.microsoft.com>
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

No functional change.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
---
 target/i386/hvf/x86_emu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index e59a73e00d5c..7b816b5a1dab 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -184,7 +184,7 @@ void write_val_ext(CPUX86State *env, target_ulong ptr, target_ulong val, int siz
 
 uint8_t *read_mmio(CPUX86State *env, target_ulong ptr, int bytes)
 {
-    vmx_read_mem(env_cpu(env), env->emu_mmio_buf, ptr, bytes);
+    emul_ops->read_mem(env_cpu(env), env->emu_mmio_buf, ptr, bytes);
     return env->emu_mmio_buf;
 }
 
@@ -510,8 +510,8 @@ static void exec_outs_single(CPUX86State *env, struct x86_decode *decode)
 {
     target_ulong addr = decode_linear_addr(env, decode, RSI(env), R_DS);
 
-    vmx_read_mem(env_cpu(env), env->emu_mmio_buf, addr,
-                 decode->operand_size);
+    emul_ops->read_mem(env_cpu(env), env->emu_mmio_buf, addr,
+                       decode->operand_size);
     emul_ops->handle_io(env_cpu(env), DX(env), env->emu_mmio_buf, 1,
                         decode->operand_size, 1);
 
@@ -620,7 +620,7 @@ static void exec_scas_single(CPUX86State *env, struct x86_decode *decode)
     addr = linear_addr_size(env_cpu(env), RDI(env),
                             decode->addressing_size, R_ES);
     decode->op[1].type = X86_VAR_IMMEDIATE;
-    vmx_read_mem(env_cpu(env), &decode->op[1].val, addr, decode->operand_size);
+    emul_ops->read_mem(env_cpu(env), &decode->op[1].val, addr, decode->operand_size);
 
     EXEC_2OP_FLAGS_CMD(env, decode, -, SET_FLAGS_OSZAPC_SUB, false);
     string_increment_reg(env, R_EDI, decode);
@@ -645,7 +645,7 @@ static void exec_lods_single(CPUX86State *env, struct x86_decode *decode)
     target_ulong val = 0;
 
     addr = decode_linear_addr(env, decode, RSI(env), R_DS);
-    vmx_read_mem(env_cpu(env), &val, addr,  decode->operand_size);
+    emul_ops->read_mem(env_cpu(env), &val, addr,  decode->operand_size);
     write_reg(env, R_EAX, val, decode->operand_size);
 
     string_increment_reg(env, R_ESI, decode);
-- 
2.47.2


