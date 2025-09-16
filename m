Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EADCAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 16:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyYrz-0008KG-Co; Tue, 16 Sep 2025 12:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uyYrx-0008JU-Gh
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:49:29 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uyYrv-0006Qn-Pf
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:49:29 -0400
Received: from localhost.localdomain (unknown [167.220.208.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id 8A7C3201551B;
 Tue, 16 Sep 2025 09:49:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8A7C3201551B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1758041365;
 bh=GNvEdABJC9xe0qg4a0j5/4PfMmfD9Jb00/tcuA/GGnE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=H950Zq02g1OZZIW32TvB92XV22R7Zx3hhP76HfKkmmE7wcyNPLN2ojcwK2ouZul5v
 BMsMUh2zKmaLupUbQpOsbYdAF3+kelI8LAceFxcvL97Ai9EVtIEV7R+w9XBCeAMPx2
 p8Ft6WRI6QQhGEep5uEh+/zKP+F7AH82jB8l04Bw=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 02/27] target/i386/emulate: Allow instruction decoding from
 stream
Date: Tue, 16 Sep 2025 18:48:22 +0200
Message-Id: <20250916164847.77883-3-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
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

Introduce a new helper function to decode x86 instructions from a
raw instruction byte stream. MSHV delivers an instruction stream in a
buffer of the vm_exit message. It can be used to speed up MMIO
emulation, since instructions do not have to be fetched and translated.

Added "fetch_instruction()" op to x86_emul_ops() to improve
traceability.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/emulate/x86_decode.c | 27 +++++++++++++++++++++++----
 target/i386/emulate/x86_decode.h |  9 +++++++++
 target/i386/emulate/x86_emu.c    |  3 ++-
 target/i386/emulate/x86_emu.h    |  2 ++
 4 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
index 2eca39802e..97bd6f1a3b 100644
--- a/target/i386/emulate/x86_decode.c
+++ b/target/i386/emulate/x86_decode.c
@@ -71,10 +71,16 @@ static inline uint64_t decode_bytes(CPUX86State *env, struct x86_decode *decode,
         VM_PANIC_EX("%s invalid size %d\n", __func__, size);
         break;
     }
-    target_ulong va  = linear_rip(env_cpu(env), env->eip) + decode->len;
-    emul_ops->read_mem(env_cpu(env), &val, va, size);
+
+    /* copy the bytes from the instruction stream, if available */
+    if (decode->stream && decode->len + size <= decode->stream->len) {
+        memcpy(&val, decode->stream->bytes + decode->len, size);
+    } else {
+        target_ulong va = linear_rip(env_cpu(env), env->eip) + decode->len;
+        emul_ops->fetch_instruction(env_cpu(env), &val, va, size);
+    }
     decode->len += size;
-    
+
     return val;
 }
 
@@ -2076,9 +2082,10 @@ static void decode_opcodes(CPUX86State *env, struct x86_decode *decode)
     }
 }
 
-uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
+static uint32_t decode_opcode(CPUX86State *env, struct x86_decode *decode)
 {
     memset(decode, 0, sizeof(*decode));
+
     decode_prefix(env, decode);
     set_addressing_size(env, decode);
     set_operand_size(env, decode);
@@ -2088,6 +2095,18 @@ uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
     return decode->len;
 }
 
+uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
+{
+    return decode_opcode(env, decode);
+}
+
+uint32_t decode_instruction_stream(CPUX86State *env, struct x86_decode *decode,
+                                   struct x86_insn_stream *stream)
+{
+    decode->stream = stream;
+    return decode_opcode(env, decode);
+}
+
 void init_decoder(void)
 {
     int i;
diff --git a/target/i386/emulate/x86_decode.h b/target/i386/emulate/x86_decode.h
index 927645af1a..1cadf3694f 100644
--- a/target/i386/emulate/x86_decode.h
+++ b/target/i386/emulate/x86_decode.h
@@ -272,6 +272,11 @@ typedef struct x86_decode_op {
     };
 } x86_decode_op;
 
+typedef struct x86_insn_stream {
+    const uint8_t *bytes;
+    size_t len;
+} x86_insn_stream;
+
 typedef struct x86_decode {
     int len;
     uint8_t opcode[4];
@@ -298,11 +303,15 @@ typedef struct x86_decode {
     struct x86_modrm modrm;
     struct x86_decode_op op[4];
     bool is_fpu;
+
+    x86_insn_stream *stream;
 } x86_decode;
 
 uint64_t sign(uint64_t val, int size);
 
 uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode);
+uint32_t decode_instruction_stream(CPUX86State *env, struct x86_decode *decode,
+                                   struct x86_insn_stream *stream);
 
 void *get_reg_ref(CPUX86State *env, int reg, int rex_present,
                   int is_extended, int size);
diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index db7a7f7437..4409f7bc13 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -1246,7 +1246,8 @@ static void init_cmd_handler(void)
 bool exec_instruction(CPUX86State *env, struct x86_decode *ins)
 {
     if (!_cmd_handler[ins->cmd].handler) {
-        printf("Unimplemented handler (" TARGET_FMT_lx ") for %d (%x %x) \n", env->eip,
+        printf("Unimplemented handler (" TARGET_FMT_lx ") for %d (%x %x)\n",
+                env->eip,
                 ins->cmd, ins->opcode[0],
                 ins->opcode_len > 1 ? ins->opcode[1] : 0);
         env->eip += ins->len;
diff --git a/target/i386/emulate/x86_emu.h b/target/i386/emulate/x86_emu.h
index a1a961284b..05686b162f 100644
--- a/target/i386/emulate/x86_emu.h
+++ b/target/i386/emulate/x86_emu.h
@@ -24,6 +24,8 @@
 #include "cpu.h"
 
 struct x86_emul_ops {
+    void (*fetch_instruction)(CPUState *cpu, void *data, target_ulong addr,
+                              int bytes);
     void (*read_mem)(CPUState *cpu, void *data, target_ulong addr, int bytes);
     void (*write_mem)(CPUState *cpu, void *data, target_ulong addr, int bytes);
     void (*read_segment_descriptor)(CPUState *cpu, struct x86_segment_descriptor *desc,
-- 
2.34.1


