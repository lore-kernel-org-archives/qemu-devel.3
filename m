Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD76CCA470
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:56:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lRA-00009H-5h; Thu, 09 Oct 2025 03:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lR8-00007u-Bt
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lR2-0004TN-Sl
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uB+V3u/aPrqwLddsF879FaTd8eb+vL09HILtMavahqo=;
 b=NQAZWp3aTGU3fh6sWZLkEWi2fOB1FeXdaST5AAxuNkzDHAAmm7W6LycyQ5Jrr0dR/myHzl
 70qHKrYOKCs0e/PtUO+3ZzxhSTn2RlkQrZ5IDcRsYrkLVNbXXYextGcJtv2MV/EUsvIERO
 NTXfQzfJXnby3Yqwv9Bc9ZSboTQSX8I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-jjLBk_oXP5icr2sr-qk49w-1; Thu, 09 Oct 2025 03:51:33 -0400
X-MC-Unique: jjLBk_oXP5icr2sr-qk49w-1
X-Mimecast-MFC-AGG-ID: jjLBk_oXP5icr2sr-qk49w_1759996293
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-41066f050a4so386717f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996291; x=1760601091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uB+V3u/aPrqwLddsF879FaTd8eb+vL09HILtMavahqo=;
 b=ESaabvqGJeunSGgX9IPpIkblYLpWAFbZekD3xsRlBolFs9iIOsMAfCck45kgh3liI1
 GVmQoOU2yKqvrNrLmeg/bZxFDN7sFVPf+pfPW2ZfqEoNXKm8Pmiifu2kEdD4C0u+pIFf
 fph2qqdgQ5rZwBBXD6t/sxIdHXqF9ECC/DLGomKOmz5pzJbUMwX1Uepa8xT7wEnJxJhp
 /8Z2cWfqZ5W46ZprhUwyjhKCt9LY9sEObidlaycBqJf/DNgeIwotDm3H6/w8HuMSfxbx
 3ZCbV4mGzQXqBBttSkYJHTonE7MFlQ8QhMMvCghfPcDE/QIo6cQy4JEwS5Ab8kAa+LlE
 xhKw==
X-Gm-Message-State: AOJu0YyMBo0w+e3XTCjeDD9FUH9cbPRGCyGBDj9tuKeh5Qf0dVuKE537
 y3YLubaNVE4sVqaYChcV+UsLfkjKwJu0pBL8xE6/smsNxDkmFEceYCqm3q1HFlcX6ixfAG9k9XR
 cOOV8JjM+Xvj38b0fDA128IpOoaCwoZpQ1K9LLDy3F1xjwxS2xjhXCNfMr0iQ/GmOKnM5r7Ebqa
 uKCDCBhxjthd9Hr/HZawLm8TYby9lACxPbATMydMM23do=
X-Gm-Gg: ASbGncvY1edoI7h7uhUIg57fHcb3rq7BZtudhEDY95kuRaKdROB0Q4VUtw15JJfflSB
 DBGXiANsIvvBfeVd11iokQ7QMWao/Pd6RQ5Fdp28L8XAvS2aOLpt4N5nPge7yUCitHb/3DenCi+
 F7McUv5BJ/nE8UDudtARmqSDqhje4OCcgdh3Vv9pGFW8nxZyaE0jJXqiNGREmqvNIY+09QZVJLK
 qeenMMfkG2Xbq2k1FW5jiqyaKqQ9lrg9qzLejJqnJtqn3MJo5vvvVe5e+vHVFl9rBpCq154vmON
 lAxF6PJP6oEblEogq9DYeq6S0nCAI4eznXl3x/9VcIAk0wAIi78fe8c0VWPdJAlGAww2xtmjZxd
 U4sHzx1OV9RapZioO7EFwklSra3cD4NaVKv7vJkvNo1QdC73X
X-Received: by 2002:a05:6000:2c0d:b0:3e9:9282:cfdf with SMTP id
 ffacd0b85a97d-4266e8d777bmr4026400f8f.41.1759996291130; 
 Thu, 09 Oct 2025 00:51:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGczbXWVL2aWvb6Pxa50DHzHGLyehHz6kU28lBmnHI94yWWpjBN10sij+q8Xgc7Qsj9T2AbjA==
X-Received: by 2002:a05:6000:2c0d:b0:3e9:9282:cfdf with SMTP id
 ffacd0b85a97d-4266e8d777bmr4026374f8f.41.1759996290592; 
 Thu, 09 Oct 2025 00:51:30 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e97fbsm33139531f8f.34.2025.10.09.00.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:51:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 28/35] target/i386/mshv: Implement mshv_vcpu_run()
Date: Thu,  9 Oct 2025 09:50:18 +0200
Message-ID: <20251009075026.505715-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

Add the main vCPU execution loop for MSHV using the MSHV_RUN_VP ioctl.

The execution loop handles guest entry and VM exits. There are handlers for
memory r/w, PIO and MMIO to which the exit events are dispatched.

In case of MMIO the i386 instruction decoder/emulator is invoked to
perform the operation in user space.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250916164847.77883-23-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/mshv/mshv-cpu.c | 444 +++++++++++++++++++++++++++++++++++-
 1 file changed, 442 insertions(+), 2 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 33a3ce8b110..7edc032cea3 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -1082,10 +1082,450 @@ void mshv_arch_amend_proc_features(
     features->access_guest_idle_reg = 1;
 }
 
+static int set_memory_info(const struct hyperv_message *msg,
+                           struct hv_x64_memory_intercept_message *info)
+{
+    if (msg->header.message_type != HVMSG_GPA_INTERCEPT
+            && msg->header.message_type != HVMSG_UNMAPPED_GPA
+            && msg->header.message_type != HVMSG_UNACCEPTED_GPA) {
+        error_report("invalid message type");
+        return -1;
+    }
+    memcpy(info, msg->payload, sizeof(*info));
+
+    return 0;
+}
+
+static int emulate_instruction(CPUState *cpu,
+                               const uint8_t *insn_bytes, size_t insn_len,
+                               uint64_t gva, uint64_t gpa)
+{
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+    struct x86_decode decode = { 0 };
+    int ret;
+    x86_insn_stream stream = { .bytes = insn_bytes, .len = insn_len };
+
+    ret = mshv_load_regs(cpu);
+    if (ret < 0) {
+        error_report("failed to load registers");
+        return -1;
+    }
+
+    decode_instruction_stream(env, &decode, &stream);
+    exec_instruction(env, &decode);
+
+    ret = mshv_store_regs(cpu);
+    if (ret < 0) {
+        error_report("failed to store registers");
+        return -1;
+    }
+
+    return 0;
+}
+
+static int handle_mmio(CPUState *cpu, const struct hyperv_message *msg,
+                       MshvVmExit *exit_reason)
+{
+    struct hv_x64_memory_intercept_message info = { 0 };
+    size_t insn_len;
+    uint8_t access_type;
+    uint8_t *instruction_bytes;
+    int ret;
+
+    ret = set_memory_info(msg, &info);
+    if (ret < 0) {
+        error_report("failed to convert message to memory info");
+        return -1;
+    }
+    insn_len = info.instruction_byte_count;
+    access_type = info.header.intercept_access_type;
+
+    if (access_type == HV_X64_INTERCEPT_ACCESS_TYPE_EXECUTE) {
+        error_report("invalid intercept access type: execute");
+        return -1;
+    }
+
+    if (insn_len > 16) {
+        error_report("invalid mmio instruction length: %zu", insn_len);
+        return -1;
+    }
+
+    trace_mshv_handle_mmio(info.guest_virtual_address,
+                           info.guest_physical_address,
+                           info.instruction_byte_count, access_type);
+
+    instruction_bytes = info.instruction_bytes;
+
+    ret = emulate_instruction(cpu, instruction_bytes, insn_len,
+                              info.guest_virtual_address,
+                              info.guest_physical_address);
+    if (ret < 0) {
+        error_report("failed to emulate mmio");
+        return -1;
+    }
+
+    *exit_reason = MshvVmExitIgnore;
+
+    return 0;
+}
+
+static int set_ioport_info(const struct hyperv_message *msg,
+                           hv_x64_io_port_intercept_message *info)
+{
+    if (msg->header.message_type != HVMSG_X64_IO_PORT_INTERCEPT) {
+        error_report("Invalid message type");
+        return -1;
+    }
+    memcpy(info, msg->payload, sizeof(*info));
+
+    return 0;
+}
+
+static int set_x64_registers(const CPUState *cpu, const uint32_t *names,
+                             const uint64_t *values)
+{
+
+    hv_register_assoc assocs[2];
+    int ret;
+
+    for (size_t i = 0; i < ARRAY_SIZE(assocs); i++) {
+        assocs[i].name = names[i];
+        assocs[i].value.reg64 = values[i];
+    }
+
+    ret = mshv_set_generic_regs(cpu, assocs, ARRAY_SIZE(assocs));
+    if (ret < 0) {
+        error_report("failed to set x64 registers");
+        return -1;
+    }
+
+    return 0;
+}
+
+static inline MemTxAttrs get_mem_attrs(bool is_secure_mode)
+{
+    MemTxAttrs memattr = {0};
+    memattr.secure = is_secure_mode;
+    return memattr;
+}
+
+static void pio_read(uint64_t port, uint8_t *data, uintptr_t size,
+                     bool is_secure_mode)
+{
+    int ret = 0;
+    MemTxAttrs memattr = get_mem_attrs(is_secure_mode);
+    ret = address_space_rw(&address_space_io, port, memattr, (void *)data, size,
+                           false);
+    if (ret != MEMTX_OK) {
+        error_report("Failed to read from port %lx: %d", port, ret);
+        abort();
+    }
+}
+
+static int pio_write(uint64_t port, const uint8_t *data, uintptr_t size,
+                     bool is_secure_mode)
+{
+    int ret = 0;
+    MemTxAttrs memattr = get_mem_attrs(is_secure_mode);
+    ret = address_space_rw(&address_space_io, port, memattr, (void *)data, size,
+                           true);
+    return ret;
+}
+
+static int handle_pio_non_str(const CPUState *cpu,
+                              hv_x64_io_port_intercept_message *info)
+{
+    size_t len = info->access_info.access_size;
+    uint8_t access_type = info->header.intercept_access_type;
+    int ret;
+    uint32_t val, eax;
+    const uint32_t eax_mask =  0xffffffffu >> (32 - len * 8);
+    size_t insn_len;
+    uint64_t rip, rax;
+    uint32_t reg_names[2];
+    uint64_t reg_values[2];
+    uint16_t port = info->port_number;
+
+    if (access_type == HV_X64_INTERCEPT_ACCESS_TYPE_WRITE) {
+        union {
+            uint32_t u32;
+            uint8_t bytes[4];
+        } conv;
+
+        /* convert the first 4 bytes of rax to bytes */
+        conv.u32 = (uint32_t)info->rax;
+        /* secure mode is set to false */
+        ret = pio_write(port, conv.bytes, len, false);
+        if (ret < 0) {
+            error_report("Failed to write to io port");
+            return -1;
+        }
+    } else {
+        uint8_t data[4] = { 0 };
+        /* secure mode is set to false */
+        pio_read(info->port_number, data, len, false);
+
+        /* Preserve high bits in EAX, but clear out high bits in RAX */
+        val = *(uint32_t *)data;
+        eax = (((uint32_t)info->rax) & ~eax_mask) | (val & eax_mask);
+        info->rax = (uint64_t)eax;
+    }
+
+    insn_len = info->header.instruction_length;
+
+    /* Advance RIP and update RAX */
+    rip = info->header.rip + insn_len;
+    rax = info->rax;
+
+    reg_names[0] = HV_X64_REGISTER_RIP;
+    reg_values[0] = rip;
+    reg_names[1] = HV_X64_REGISTER_RAX;
+    reg_values[1] = rax;
+
+    ret = set_x64_registers(cpu, reg_names, reg_values);
+    if (ret < 0) {
+        error_report("Failed to set x64 registers");
+        return -1;
+    }
+
+    cpu->accel->dirty = false;
+
+    return 0;
+}
+
+static int fetch_guest_state(CPUState *cpu)
+{
+    int ret;
+
+    ret = mshv_get_standard_regs(cpu);
+    if (ret < 0) {
+        error_report("Failed to get standard registers");
+        return -1;
+    }
+
+    ret = mshv_get_special_regs(cpu);
+    if (ret < 0) {
+        error_report("Failed to get special registers");
+        return -1;
+    }
+
+    return 0;
+}
+
+static int read_memory(const CPUState *cpu, uint64_t initial_gva,
+                       uint64_t initial_gpa, uint64_t gva, uint8_t *data,
+                       size_t len)
+{
+    int ret;
+    uint64_t gpa, flags;
+
+    if (gva == initial_gva) {
+        gpa = initial_gpa;
+    } else {
+        flags = HV_TRANSLATE_GVA_VALIDATE_READ;
+        ret = translate_gva(cpu, gva, &gpa, flags);
+        if (ret < 0) {
+            return -1;
+        }
+
+        ret = mshv_guest_mem_read(gpa, data, len, false, false);
+        if (ret < 0) {
+            error_report("failed to read guest mem");
+            return -1;
+        }
+    }
+
+    return 0;
+}
+
+static int write_memory(const CPUState *cpu, uint64_t initial_gva,
+                        uint64_t initial_gpa, uint64_t gva, const uint8_t *data,
+                        size_t len)
+{
+    int ret;
+    uint64_t gpa, flags;
+
+    if (gva == initial_gva) {
+        gpa = initial_gpa;
+    } else {
+        flags = HV_TRANSLATE_GVA_VALIDATE_WRITE;
+        ret = translate_gva(cpu, gva, &gpa, flags);
+        if (ret < 0) {
+            error_report("failed to translate gva to gpa");
+            return -1;
+        }
+    }
+    ret = mshv_guest_mem_write(gpa, data, len, false);
+    if (ret != MEMTX_OK) {
+        error_report("failed to write to mmio");
+        return -1;
+    }
+
+    return 0;
+}
+
+static int handle_pio_str_write(CPUState *cpu,
+                                hv_x64_io_port_intercept_message *info,
+                                size_t repeat, uint16_t port,
+                                bool direction_flag)
+{
+    int ret;
+    uint64_t src;
+    uint8_t data[4] = { 0 };
+    size_t len = info->access_info.access_size;
+
+    src = linear_addr(cpu, info->rsi, R_DS);
+
+    for (size_t i = 0; i < repeat; i++) {
+        ret = read_memory(cpu, 0, 0, src, data, len);
+        if (ret < 0) {
+            error_report("Failed to read memory");
+            return -1;
+        }
+        ret = pio_write(port, data, len, false);
+        if (ret < 0) {
+            error_report("Failed to write to io port");
+            return -1;
+        }
+        src += direction_flag ? -len : len;
+        info->rsi += direction_flag ? -len : len;
+    }
+
+    return 0;
+}
+
+static int handle_pio_str_read(CPUState *cpu,
+                               hv_x64_io_port_intercept_message *info,
+                               size_t repeat, uint16_t port,
+                               bool direction_flag)
+{
+    int ret;
+    uint64_t dst;
+    size_t len = info->access_info.access_size;
+    uint8_t data[4] = { 0 };
+
+    dst = linear_addr(cpu, info->rdi, R_ES);
+
+    for (size_t i = 0; i < repeat; i++) {
+        pio_read(port, data, len, false);
+
+        ret = write_memory(cpu, 0, 0, dst, data, len);
+        if (ret < 0) {
+            error_report("Failed to write memory");
+            return -1;
+        }
+        dst += direction_flag ? -len : len;
+        info->rdi += direction_flag ? -len : len;
+    }
+
+    return 0;
+}
+
+static int handle_pio_str(CPUState *cpu, hv_x64_io_port_intercept_message *info)
+{
+    uint8_t access_type = info->header.intercept_access_type;
+    uint16_t port = info->port_number;
+    bool repop = info->access_info.rep_prefix == 1;
+    size_t repeat = repop ? info->rcx : 1;
+    size_t insn_len = info->header.instruction_length;
+    bool direction_flag;
+    uint32_t reg_names[3];
+    uint64_t reg_values[3];
+    int ret;
+    X86CPU *x86_cpu = X86_CPU(cpu);
+    CPUX86State *env = &x86_cpu->env;
+
+    ret = fetch_guest_state(cpu);
+    if (ret < 0) {
+        error_report("Failed to fetch guest state");
+        return -1;
+    }
+
+    direction_flag = (env->eflags & DESC_E_MASK) != 0;
+
+    if (access_type == HV_X64_INTERCEPT_ACCESS_TYPE_WRITE) {
+        ret = handle_pio_str_write(cpu, info, repeat, port, direction_flag);
+        if (ret < 0) {
+            error_report("Failed to handle pio str write");
+            return -1;
+        }
+        reg_names[0] = HV_X64_REGISTER_RSI;
+        reg_values[0] = info->rsi;
+    } else {
+        ret = handle_pio_str_read(cpu, info, repeat, port, direction_flag);
+        reg_names[0] = HV_X64_REGISTER_RDI;
+        reg_values[0] = info->rdi;
+    }
+
+    reg_names[1] = HV_X64_REGISTER_RIP;
+    reg_values[1] = info->header.rip + insn_len;
+    reg_names[2] = HV_X64_REGISTER_RAX;
+    reg_values[2] = info->rax;
+
+    ret = set_x64_registers(cpu, reg_names, reg_values);
+    if (ret < 0) {
+        error_report("Failed to set x64 registers");
+        return -1;
+    }
+
+    cpu->accel->dirty = false;
+
+    return 0;
+}
+
+static int handle_pio(CPUState *cpu, const struct hyperv_message *msg)
+{
+    struct hv_x64_io_port_intercept_message info = { 0 };
+    int ret;
+
+    ret = set_ioport_info(msg, &info);
+    if (ret < 0) {
+        error_report("Failed to convert message to ioport info");
+        return -1;
+    }
+
+    if (info.access_info.string_op) {
+        return handle_pio_str(cpu, &info);
+    }
+
+    return handle_pio_non_str(cpu, &info);
+}
+
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
 {
-    error_report("unimplemented");
-    abort();
+    int ret;
+    enum MshvVmExit exit_reason;
+    int cpu_fd = mshv_vcpufd(cpu);
+
+    ret = ioctl(cpu_fd, MSHV_RUN_VP, msg);
+    if (ret < 0) {
+        return MshvVmExitShutdown;
+    }
+
+    switch (msg->header.message_type) {
+    case HVMSG_UNRECOVERABLE_EXCEPTION:
+        return MshvVmExitShutdown;
+    case HVMSG_UNMAPPED_GPA:
+    case HVMSG_GPA_INTERCEPT:
+        ret = handle_mmio(cpu, msg, &exit_reason);
+        if (ret < 0) {
+            error_report("failed to handle mmio");
+            return -1;
+        }
+        return exit_reason;
+    case HVMSG_X64_IO_PORT_INTERCEPT:
+        ret = handle_pio(cpu, msg);
+        if (ret < 0) {
+            return MshvVmExitSpecial;
+        }
+        return MshvVmExitIgnore;
+    default:
+        break;
+    }
+
+    *exit = MshvVmExitIgnore;
+    return 0;
 }
 
 void mshv_remove_vcpu(int vm_fd, int cpu_fd)
-- 
2.51.0


