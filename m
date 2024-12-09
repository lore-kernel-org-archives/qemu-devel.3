Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259A9E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 20:39:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKkVT-0006Pf-6z; Mon, 09 Dec 2024 15:37:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKkVB-0006GL-6O
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:37:09 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tKkV8-0003E2-Kk
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 15:37:08 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aa629402b53so669894766b.3
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 12:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1733776624; x=1734381424;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o+++OhUvZkOaxfpw+rWVgz3w1Q+zW3e1baRIfvJZtEo=;
 b=ms/8y+uyLFnYoqR8L9fXwGnwmzK29Nz8m7ptjM4I67vxgzbErvf3ffDtAzrNnGWoZw
 YK3dmV9lXpjFLdl5cC1CEojASAMbvqJ/C47USS6e+T3I28TAnxm/XIC3sZzBD2ZJxHLd
 ne3rduxCTEQ3FJWnMJYue4t0oxGJGkveK2QAxIqDFmdZvEsLh8wTh4L/kK9bSmevQ2WL
 cHiq+7rE9YePk4mLfwTLnYFzct4ZiZHTOkY5ETge7ofLg7S6EyQBHURuAQDZql1bjX+7
 AP6SyHaD8YU+dE9SMuBs2YbFPQMEgS6K21z8XSxZ3oBqqdd4Zn1PA2g3urQgJaPTjQL5
 Wy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733776624; x=1734381424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o+++OhUvZkOaxfpw+rWVgz3w1Q+zW3e1baRIfvJZtEo=;
 b=wHooHuV8Funbp+1b4I+AzqBbZ8fIMD1dIFtYMn8HKY6N03Y7y/Nj1KTM6o+aA3IRog
 mh8msE1Wuv1bGFDuUvbYy31jjeMt187WFbhVQK2TvqhEfqasaGvzlQn0JgDB1qMKh1Hw
 Ew9fYjaDIEkeTQuFXxc8xPe0c5mXnlF358suiLjXW1BSRWis/Tex/CU4M+qA7thHIP5I
 X1v0GyUocZQMwSnOSXIswE9v59VnUDXjlOv/qqViBalHBVDYWJSLM6HNlTH/5rPH65Rf
 T+64ay9HFaa/1/c5UjvZEGts4vebLBzEHwCS3vagbQ/hZ72cyKFBds9/7NV3WcWwcau+
 x5PA==
X-Gm-Message-State: AOJu0YzCdFFPdxyvUOHxD6qEPNP1tM+gmWW7min0U9co99bgbSTn3/xD
 NQtrN2jGfpQba+oG+df74FknKLO0wd7UitMIhHz3zGxHqkBzbO+sFPmTbvHSqD53HpjkcKGBMZs
 Y/w==
X-Gm-Gg: ASbGncthHUDVKWMaVUmVEknwz+0yLhPzHBRKfN7STYSFdAbF1bzZn14dbGpWhX3idZS
 9Sb6oNiwn48E3NYLz39fb35jXvTyvbTwcj2KrVEr01RnjfwJUQ6wKM9KAmNXDFo4p+0LofAVrr/
 vHbzx0PKGfTUNBV5ZyeurSzS6ym8Gou8+XJo7Vovyhc51Omt4azRtdHhaAsmRaRBefeyvb/kN2G
 jYKQA1WrQtB78rcQo4gl876dBNLX83xAlLhW9uTwabtzO07jMdQmVXE70uxalz5h6+VTAU9iYBB
 cgTZDH4AANOSqj6msMvUQpgDOhaZXg==
X-Google-Smtp-Source: AGHT+IHv8BT2W08XVUJFbJlufdVJBUD/yYahMz4RRJKZpaFOo3Lq0o9noBsWAWneNSDHwtn6K7ejqA==
X-Received: by 2002:a17:906:3cb2:b0:aa6:59ee:1a19 with SMTP id
 a640c23a62f3a-aa659ee1a91mr847399366b.60.1733776623883; 
 Mon, 09 Dec 2024 12:37:03 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa692e4e9d5sm141783566b.129.2024.12.09.12.37.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 12:37:03 -0800 (PST)
From: phil@philjordan.eu
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 06/11] i386/hvf: APIC access exit with fast-path for common
 mov cases
Date: Mon,  9 Dec 2024 21:36:24 +0100
Message-Id: <20241209203629.74436-7-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241209203629.74436-1-phil@philjordan.eu>
References: <20241209203629.74436-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::62e;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

The implementation of the EXIT_REASON_APIC_ACCESS vm exit handler has so far
been essentially the same as a regular EPT fault handler, performing a full
simulation of the faulted instruction. The code path has also not been used at
all because the APIC base address setter in Hypervisor.framework was never
called. This change improves the former.

In particular, the APIC_ACCESS exit provides us some additional metadata which
in many cases allows us to avoid a full instruction emulation.

There is no need to walk the memory hierarchy, because exit_qual contains the
APIC MMIO offset. It also tells us whether it's an MMIO read or write. So
we can detect common mov instructions and directly call the relevant APIC
accessor functions.

For more complex instructions, we can fall back to the usual instruction
emulation.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/intc/apic.c               |  4 +-
 include/hw/i386/apic.h       |  2 +
 meson.build                  |  1 +
 target/i386/hvf/hvf.c        | 18 +++++++-
 target/i386/hvf/trace-events |  9 ++++
 target/i386/hvf/trace.h      |  1 +
 target/i386/hvf/x86_emu.c    | 84 ++++++++++++++++++++++++++++++++++++
 target/i386/hvf/x86_emu.h    |  2 +
 8 files changed, 117 insertions(+), 4 deletions(-)
 create mode 100644 target/i386/hvf/trace-events
 create mode 100644 target/i386/hvf/trace.h

diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 4186c57b34..add99f01e5 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -788,7 +788,7 @@ static void apic_timer(void *opaque)
     apic_timer_update(s, s->next_time);
 }
 
-static int apic_register_read(int index, uint64_t *value)
+int apic_register_read(int index, uint64_t *value)
 {
     DeviceState *dev;
     APICCommonState *s;
@@ -936,7 +936,7 @@ static void apic_send_msi(MSIMessage *msi)
     apic_deliver_irq(dest, dest_mode, delivery, vector, trigger_mode);
 }
 
-static int apic_register_write(int index, uint64_t val)
+int apic_register_write(int index, uint64_t val)
 {
     DeviceState *dev;
     APICCommonState *s;
diff --git a/include/hw/i386/apic.h b/include/hw/i386/apic.h
index eb606d6076..47946e5581 100644
--- a/include/hw/i386/apic.h
+++ b/include/hw/i386/apic.h
@@ -20,6 +20,8 @@ void apic_designate_bsp(DeviceState *d, bool bsp);
 int apic_get_highest_priority_irr(DeviceState *dev);
 int apic_msr_read(int index, uint64_t *val);
 int apic_msr_write(int index, uint64_t val);
+int apic_register_read(int index, uint64_t *value);
+int apic_register_write(int index, uint64_t val);
 bool is_x2apic_mode(DeviceState *d);
 
 /* pc.c */
diff --git a/meson.build b/meson.build
index 147097c652..0846c09bdb 100644
--- a/meson.build
+++ b/meson.build
@@ -3606,6 +3606,7 @@ if have_system or have_user
     'target/arm/hvf',
     'target/hppa',
     'target/i386',
+    'target/i386/hvf',
     'target/i386/kvm',
     'target/loongarch',
     'target/mips/tcg',
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 3f1ff0f013..2a13a9e49b 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -75,6 +75,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/accel.h"
 #include "target/i386/cpu.h"
+#include "trace.h"
 
 static Error *invtsc_mig_blocker;
 
@@ -666,8 +667,21 @@ int hvf_vcpu_exec(CPUState *cpu)
             store_regs(cpu);
             break;
         }
-        case EXIT_REASON_APIC_ACCESS: { /* TODO */
-            exec_instruction(env, &decode);
+        case EXIT_REASON_APIC_ACCESS: {
+            bool is_load = (exit_qual & 0x1000) == 0;
+            uint32_t apic_register_idx = (exit_qual & 0xff0) >> 4;
+
+            if (simulate_fast_path_apic_mmio(is_load, apic_register_idx,
+                                             env, &decode)) {
+                env->eip += ins_len;
+            } else {
+                trace_hvf_x86_vcpu_exec_apic_access_slowpath(
+                    is_load ? "load from" : "store to", apic_register_idx,
+                    ins_len, decode.prefetch_buf[0], decode.prefetch_buf[1],
+                    decode.prefetch_buf[2], decode.prefetch_buf[3],
+                    decode.prefetch_buf[4], decode.prefetch_buf[5]);
+                exec_instruction(env, &decode);
+            }
             store_regs(cpu);
             break;
         }
diff --git a/target/i386/hvf/trace-events b/target/i386/hvf/trace-events
new file mode 100644
index 0000000000..7d0230fb37
--- /dev/null
+++ b/target/i386/hvf/trace-events
@@ -0,0 +1,9 @@
+# See docs/devel/tracing.rst for syntax documentation.
+
+# hvf.c
+hvf_x86_vcpu_exec_apic_access_slowpath(const char *access_type, uint32_t apic_register_idx, uint32_t ins_len, uint8_t ins_byte_0, uint8_t ins_byte_1, uint8_t ins_byte_2, uint8_t ins_byte_3, uint8_t ins_byte_4, uint8_t ins_byte_5) "xAPIC %s register 0x%" PRIx32" taking slow path; instruction length: %" PRIu32 ", bytes: %02x %02x %02x %02x  %02x %02x ..."
+
+# x86_emu.c
+hvf_x86_emu_mmio_load_instruction_fastpath(int cmd, int operand_size, int opcode_len, uint8_t opcode_byte_0, uint8_t opcode_byte_1, uint8_t opcode_byte_2) "slow path apic load: cmd = %d, operand_size = %u, opcode_len = %u, opcode = [ %02x %02x %02x ... ]"
+hvf_x86_emu_mmio_store_instruction_fastpath(int cmd, int operand_size, int opcode_len, uint8_t opcode_byte_0, uint8_t opcode_byte_1, uint8_t opcode_byte_2) "slow path apic store: cmd = %d, operand_size = %u, opcode_len = %u, opcode = [ %02x %02x %02x ... ]"
+hvf_x86_fast_path_apic_mmio_failed(const char *access_type, uint32_t apic_register_idx, uint64_t value, int result) "xAPIC %s register 0x%"PRIx32", value 0x%"PRIx64" returned error %d from APIC"
diff --git a/target/i386/hvf/trace.h b/target/i386/hvf/trace.h
new file mode 100644
index 0000000000..14f15a752a
--- /dev/null
+++ b/target/i386/hvf/trace.h
@@ -0,0 +1 @@
+#include "trace/trace-target_i386_hvf.h"
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 015f760acb..197fa155a0 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -44,6 +44,7 @@
 #include "x86_flags.h"
 #include "vmcs.h"
 #include "vmx.h"
+#include "trace.h"
 
 void hvf_handle_io(CPUState *cs, uint16_t port, void *data,
                    int direction, int size, uint32_t count);
@@ -897,6 +898,89 @@ static void exec_wrmsr(CPUX86State *env, struct x86_decode *decode)
     env->eip += decode->len;
 }
 
+static bool mmio_load_instruction_fastpath(x86_decode *decode, CPUX86State *env,
+                                           int *load_dest_reg)
+{
+    if (decode->cmd == X86_DECODE_CMD_MOV && decode->operand_size == 4
+        && decode->opcode_len == 1) {
+        if (decode->opcode[0] == 0x8b) {
+            g_assert(decode->op[0].type == X86_VAR_REG);
+            g_assert(decode->op[1].type == X86_VAR_RM);
+
+            *load_dest_reg = decode->op[0].reg | (decode->rex.r ? R_R8 : 0);
+            return true;
+        } else if (decode->opcode[0] == 0xa1) {
+            *load_dest_reg = R_EAX;
+            return true;
+        }
+    }
+
+    trace_hvf_x86_emu_mmio_load_instruction_fastpath(
+        decode->cmd, decode->operand_size, decode->opcode_len,
+        decode->opcode[0], decode->opcode[1], decode->opcode[2]);
+
+    return false;
+}
+
+static bool mmio_store_instruction_fastpath(x86_decode *decode, CPUX86State *env,
+                                            uint64_t *store_val)
+{
+    if (decode->cmd == X86_DECODE_CMD_MOV && decode->operand_size == 4 &&
+        decode->opcode_len == 1) {
+        if (decode->opcode[0] == 0x89) { /* mov DWORD PTR [reg0+off],reg1 */
+            g_assert(decode->op[1].type == X86_VAR_REG);
+            g_assert(decode->op[0].type == X86_VAR_RM);
+
+            *store_val = RRX(env, decode->op[1].reg | (decode->rex.r ? R_R8 : 0));
+            return true;
+        } else if (decode->opcode[0] == 0xc7) { /* mov DWORD PTR [reg0+off],imm*/
+            g_assert(decode->op[0].type == X86_VAR_RM);
+            g_assert(decode->op[1].type == X86_VAR_IMMEDIATE);
+            *store_val = decode->op[1].val;
+            return true;
+        } else if (decode->opcode[0] == 0xa3) { /* movabs ds:immaddr,eax */
+            *store_val = RRX(env, R_EAX);
+            return true;
+        }
+    }
+
+    trace_hvf_x86_emu_mmio_store_instruction_fastpath(
+        decode->cmd, decode->operand_size, decode->opcode_len,
+        decode->opcode[0], decode->opcode[1], decode->opcode[2]);
+    return false;
+}
+
+
+bool simulate_fast_path_apic_mmio(bool is_load, uint32_t apic_register_idx,
+                                  CPUX86State *env, x86_decode* decode)
+{
+    uint64_t value;
+    int load_dest_reg;
+    int res;
+
+    if (is_load) {
+        if (!mmio_load_instruction_fastpath(decode, env, &load_dest_reg)) {
+            return false;
+        }
+        res = apic_register_read(apic_register_idx, &value);
+        if (res == 0) {
+            RRX(env, load_dest_reg) = value;
+        }
+    } else {
+        if (!mmio_store_instruction_fastpath(decode, env, &value)) {
+            return false;
+        }
+        res = apic_register_write(apic_register_idx, value);
+    }
+
+    if (res != 0) {
+        trace_hvf_x86_fast_path_apic_mmio_failed(
+            is_load ? "load from" : "store to", apic_register_idx, value, res);
+        raise_exception(env, EXCP0D_GPF, 0);
+    }
+    return true;
+}
+
 /*
  * flag:
  * 0 - bt, 1 - btc, 2 - bts, 3 - btr
diff --git a/target/i386/hvf/x86_emu.h b/target/i386/hvf/x86_emu.h
index 8bd97608c4..6726ca2240 100644
--- a/target/i386/hvf/x86_emu.h
+++ b/target/i386/hvf/x86_emu.h
@@ -31,6 +31,8 @@ void store_regs(CPUState *cpu);
 
 void simulate_rdmsr(CPUX86State *env);
 void simulate_wrmsr(CPUX86State *env);
+bool simulate_fast_path_apic_mmio(bool is_load, uint32_t apic_register_idx,
+                                  CPUX86State *env, x86_decode* decode);
 
 target_ulong read_reg(CPUX86State *env, int reg, int size);
 void write_reg(CPUX86State *env, int reg, target_ulong val, int size);
-- 
2.39.3 (Apple Git-146)


