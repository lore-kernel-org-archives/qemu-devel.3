Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79B0CCFA13
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Nov 2025 13:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vI5CF-0007AS-RV; Sun, 09 Nov 2025 08:11:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vI5CA-00074h-SK
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 08:11:02 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vI5C7-0003lb-MC
 for qemu-devel@nongnu.org; Sun, 09 Nov 2025 08:11:01 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b71397df721so231866466b.1
 for <qemu-devel@nongnu.org>; Sun, 09 Nov 2025 05:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762693857; x=1763298657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wPE/pQq7RK0600Mdpn+48ddfGD07E0zJwssj6DjqdqY=;
 b=fTMrdt6a9MuzElkls+Lr+O2X9k6Wlw6U75hWqhoRHruueahP6pxIFd0koapT5EWUzS
 sJfSOV4sQpTcfo6EjY6xsIp66jWSBOVGfI2k4rtl8VIYggASrBRgXRbiq5taXkDbXlGw
 F+E7bsI3FcY8FYHSNxOPhxtetSJ4A2EquB2/Eu9Arm8FT/X2jjSphtF5dFd/0HO9N3kw
 vHfkyS/5r1hWRU81XVANva2FPIwadm7dldtoO7nx4bau3JEIT6BgcTmopPYLL+74O0KH
 wn/h6kZAok7lcgq9lMh+Drsy9/s8LVL1ZkS4Kv9WOJ+SnOJykOOURieVC3tDieEMB0hn
 xa/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762693857; x=1763298657;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wPE/pQq7RK0600Mdpn+48ddfGD07E0zJwssj6DjqdqY=;
 b=FWQwOl6VeZ9BAH9wX1GQih2q/jcbbZ1C5ZKE7l8WHl421IwYDXJK4OPg5Vkr1ijJfl
 k8O1Fx1nceO5HxhfXFdJp7iuqkJ5yg+M9/xte73G0w82l5l9QyhbVL5ldeLpDh4RYGgY
 AFVdAa+PtNqOVdTqN2uWB3+W5rZyGehsJizVqvLbI+6s059PvZsbZETRyrtZT5nLCY7P
 Z69sqaU3R/hswlrEfH0DGiC6V9pWbsmclTlAzVFYChAl3APIii613HtyIF098nO4Q1lw
 kcpiDqmZzorVKAq7u7h7+LQDNKjXtq2CKvnOxpfilwNV4yB4elgx+VV72IhrYXRbccxo
 VPbA==
X-Gm-Message-State: AOJu0Yytitno/3bpCCB/wuoSyMaZiEPwlrumWtMLpvAvwkHkdoKkZLt0
 SD3EmsMccZgKoYF+qx/NQfyHGmj2UZkshiSI9UW2mg+F5tLPzc9bemKvZBeSQA==
X-Gm-Gg: ASbGncvCPqDaD7rYvTtNB/QCgS92noxluECztRgamaspIF9OL7hkbN6s7PvsV6zZHru
 Ow8SX/Ol/qdZs+DfNDweidzHBD6khxVT4AdEWqtl2psiemO0klbbI7kKGbTf+1wlC0rZWnHyw7r
 U46EeZr5eD69Pfkga2V0cwu9ChsPkd8LW1TVfhW8FTZkfg0dSiyreiqZyHKvXiuazLYBm5XRTkT
 dN1pQBW7oaUS45h1ZNpvwTmU5qdu/8jIdNFGZAS2m9ba+M8ZUuvWItyxEpW7ivDZb0EViGTqYpH
 BOiIIMn7qGh0nd0YbpRzopX3elg7MWoSqmsXNAHFMyfcMQz68VTZlvg2zyYGRhhfOBrHCH1PyUc
 fRi8G4jXWzYXmLssI8nWVyHfHDKUjGYDCQJwqschzEL8uw+tD2mly+893XP2dwYHKi4aoo/nzP2
 pypyqXztcaHHu1ILLb/FOLm2DwBcwf9sOy9Q06SpXsfqTq/st9By79BniLzKElm05U6EWO6QfD4
 +n7Gdr58AdABRqX/T8VsmVb
X-Google-Smtp-Source: AGHT+IH31vGDPPhj8GHfXMdZ4FByVkH5eeZGJmGKDHhmvOEctW0rd7E+/mCuXsBEULMHgto7z4JVjg==
X-Received: by 2002:a17:906:794e:b0:b72:9815:7e22 with SMTP id
 a640c23a62f3a-b72e0312fedmr460978166b.24.1762693856895; 
 Sun, 09 Nov 2025 05:10:56 -0800 (PST)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-251a-3000-bdbc-21c7-75fc-dd84.310.pool.telefonica.de.
 [2a02:3100:251a:3000:bdbc:21c7:75fc:dd84])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72de4f920bsm525003566b.67.2025.11.09.05.10.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Nov 2025 05:10:55 -0800 (PST)
Date: Sun, 09 Nov 2025 13:10:50 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
CC: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: Re: [PULL 28/35] target/i386/mshv: Implement mshv_vcpu_run()
In-Reply-To: <20251009075026.505715-29-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
 <20251009075026.505715-29-pbonzini@redhat.com>
Message-ID: <CFB6B222-C2AF-4D3F-AFF1-F68BFCA7489B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



Am 9=2E Oktober 2025 07:50:18 UTC schrieb Paolo Bonzini <pbonzini@redhat=
=2Ecom>:
>From: Magnus Kulke <magnuskulke@linux=2Emicrosoft=2Ecom>
>
>Add the main vCPU execution loop for MSHV using the MSHV_RUN_VP ioctl=2E
>
>The execution loop handles guest entry and VM exits=2E There are handlers=
 for
>memory r/w, PIO and MMIO to which the exit events are dispatched=2E
>
>In case of MMIO the i386 instruction decoder/emulator is invoked to
>perform the operation in user space=2E
>
>Signed-off-by: Magnus Kulke <magnuskulke@linux=2Emicrosoft=2Ecom>
>Link: https://lore=2Ekernel=2Eorg/r/20250916164847=2E77883-23-magnuskulke=
@linux=2Emicrosoft=2Ecom
>Signed-off-by: Paolo Bonzini <pbonzini@redhat=2Ecom>
>---
> target/i386/mshv/mshv-cpu=2Ec | 444 +++++++++++++++++++++++++++++++++++-
> 1 file changed, 442 insertions(+), 2 deletions(-)
>
>diff --git a/target/i386/mshv/mshv-cpu=2Ec b/target/i386/mshv/mshv-cpu=2E=
c
>index 33a3ce8b110=2E=2E7edc032cea3 100644
>--- a/target/i386/mshv/mshv-cpu=2Ec
>+++ b/target/i386/mshv/mshv-cpu=2Ec
>@@ -1082,10 +1082,450 @@ void mshv_arch_amend_proc_features(
>     features->access_guest_idle_reg =3D 1;
> }
>=20
>+static int set_memory_info(const struct hyperv_message *msg,
>+                           struct hv_x64_memory_intercept_message *info)
>+{
>+    if (msg->header=2Emessage_type !=3D HVMSG_GPA_INTERCEPT
>+            && msg->header=2Emessage_type !=3D HVMSG_UNMAPPED_GPA
>+            && msg->header=2Emessage_type !=3D HVMSG_UNACCEPTED_GPA) {
>+        error_report("invalid message type");
>+        return -1;
>+    }
>+    memcpy(info, msg->payload, sizeof(*info));
>+
>+    return 0;
>+}
>+
>+static int emulate_instruction(CPUState *cpu,
>+                               const uint8_t *insn_bytes, size_t insn_le=
n,
>+                               uint64_t gva, uint64_t gpa)
>+{
>+    X86CPU *x86_cpu =3D X86_CPU(cpu);
>+    CPUX86State *env =3D &x86_cpu->env;
>+    struct x86_decode decode =3D { 0 };
>+    int ret;
>+    x86_insn_stream stream =3D { =2Ebytes =3D insn_bytes, =2Elen =3D ins=
n_len };
>+
>+    ret =3D mshv_load_regs(cpu);
>+    if (ret < 0) {
>+        error_report("failed to load registers");
>+        return -1;
>+    }
>+
>+    decode_instruction_stream(env, &decode, &stream);
>+    exec_instruction(env, &decode);
>+
>+    ret =3D mshv_store_regs(cpu);
>+    if (ret < 0) {
>+        error_report("failed to store registers");
>+        return -1;
>+    }
>+
>+    return 0;
>+}
>+
>+static int handle_mmio(CPUState *cpu, const struct hyperv_message *msg,
>+                       MshvVmExit *exit_reason)
>+{
>+    struct hv_x64_memory_intercept_message info =3D { 0 };
>+    size_t insn_len;
>+    uint8_t access_type;
>+    uint8_t *instruction_bytes;
>+    int ret;
>+
>+    ret =3D set_memory_info(msg, &info);
>+    if (ret < 0) {
>+        error_report("failed to convert message to memory info");
>+        return -1;
>+    }
>+    insn_len =3D info=2Einstruction_byte_count;
>+    access_type =3D info=2Eheader=2Eintercept_access_type;
>+
>+    if (access_type =3D=3D HV_X64_INTERCEPT_ACCESS_TYPE_EXECUTE) {
>+        error_report("invalid intercept access type: execute");
>+        return -1;
>+    }
>+
>+    if (insn_len > 16) {
>+        error_report("invalid mmio instruction length: %zu", insn_len);
>+        return -1;
>+    }
>+
>+    trace_mshv_handle_mmio(info=2Eguest_virtual_address,
>+                           info=2Eguest_physical_address,
>+                           info=2Einstruction_byte_count, access_type);
>+
>+    instruction_bytes =3D info=2Einstruction_bytes;
>+
>+    ret =3D emulate_instruction(cpu, instruction_bytes, insn_len,
>+                              info=2Eguest_virtual_address,
>+                              info=2Eguest_physical_address);
>+    if (ret < 0) {
>+        error_report("failed to emulate mmio");
>+        return -1;
>+    }
>+
>+    *exit_reason =3D MshvVmExitIgnore;
>+
>+    return 0;
>+}
>+
>+static int set_ioport_info(const struct hyperv_message *msg,
>+                           hv_x64_io_port_intercept_message *info)
>+{
>+    if (msg->header=2Emessage_type !=3D HVMSG_X64_IO_PORT_INTERCEPT) {
>+        error_report("Invalid message type");
>+        return -1;
>+    }
>+    memcpy(info, msg->payload, sizeof(*info));
>+
>+    return 0;
>+}
>+
>+static int set_x64_registers(const CPUState *cpu, const uint32_t *names,
>+                             const uint64_t *values)
>+{
>+
>+    hv_register_assoc assocs[2];
>+    int ret;
>+
>+    for (size_t i =3D 0; i < ARRAY_SIZE(assocs); i++) {
>+        assocs[i]=2Ename =3D names[i];
>+        assocs[i]=2Evalue=2Ereg64 =3D values[i];
>+    }
>+
>+    ret =3D mshv_set_generic_regs(cpu, assocs, ARRAY_SIZE(assocs));
>+    if (ret < 0) {
>+        error_report("failed to set x64 registers");
>+        return -1;
>+    }
>+
>+    return 0;
>+}
>+
>+static inline MemTxAttrs get_mem_attrs(bool is_secure_mode)
>+{
>+    MemTxAttrs memattr =3D {0};
>+    memattr=2Esecure =3D is_secure_mode;
>+    return memattr;
>+}
>+
>+static void pio_read(uint64_t port, uint8_t *data, uintptr_t size,
>+                     bool is_secure_mode)
>+{
>+    int ret =3D 0;
>+    MemTxAttrs memattr =3D get_mem_attrs(is_secure_mode);
>+    ret =3D address_space_rw(&address_space_io, port, memattr, (void *)d=
ata, size,
>+                           false);
>+    if (ret !=3D MEMTX_OK) {
>+        error_report("Failed to read from port %lx: %d", port, ret);
>+        abort();
>+    }
>+}
>+
>+static int pio_write(uint64_t port, const uint8_t *data, uintptr_t size,
>+                     bool is_secure_mode)
>+{
>+    int ret =3D 0;
>+    MemTxAttrs memattr =3D get_mem_attrs(is_secure_mode);
>+    ret =3D address_space_rw(&address_space_io, port, memattr, (void *)d=
ata, size,
>+                           true);
>+    return ret;
>+}
>+
>+static int handle_pio_non_str(const CPUState *cpu,
>+                              hv_x64_io_port_intercept_message *info)
>+{
>+    size_t len =3D info->access_info=2Eaccess_size;
>+    uint8_t access_type =3D info->header=2Eintercept_access_type;
>+    int ret;
>+    uint32_t val, eax;
>+    const uint32_t eax_mask =3D  0xffffffffu >> (32 - len * 8);
>+    size_t insn_len;
>+    uint64_t rip, rax;
>+    uint32_t reg_names[2];
>+    uint64_t reg_values[2];
>+    uint16_t port =3D info->port_number;
>+
>+    if (access_type =3D=3D HV_X64_INTERCEPT_ACCESS_TYPE_WRITE) {
>+        union {
>+            uint32_t u32;
>+            uint8_t bytes[4];
>+        } conv;
>+
>+        /* convert the first 4 bytes of rax to bytes */
>+        conv=2Eu32 =3D (uint32_t)info->rax;
>+        /* secure mode is set to false */
>+        ret =3D pio_write(port, conv=2Ebytes, len, false);
>+        if (ret < 0) {
>+            error_report("Failed to write to io port");
>+            return -1;
>+        }
>+    } else {
>+        uint8_t data[4] =3D { 0 };
>+        /* secure mode is set to false */
>+        pio_read(info->port_number, data, len, false);
>+
>+        /* Preserve high bits in EAX, but clear out high bits in RAX */
>+        val =3D *(uint32_t *)data;
>+        eax =3D (((uint32_t)info->rax) & ~eax_mask) | (val & eax_mask);
>+        info->rax =3D (uint64_t)eax;
>+    }
>+
>+    insn_len =3D info->header=2Einstruction_length;
>+
>+    /* Advance RIP and update RAX */
>+    rip =3D info->header=2Erip + insn_len;
>+    rax =3D info->rax;
>+
>+    reg_names[0] =3D HV_X64_REGISTER_RIP;
>+    reg_values[0] =3D rip;
>+    reg_names[1] =3D HV_X64_REGISTER_RAX;
>+    reg_values[1] =3D rax;
>+
>+    ret =3D set_x64_registers(cpu, reg_names, reg_values);
>+    if (ret < 0) {
>+        error_report("Failed to set x64 registers");
>+        return -1;
>+    }
>+
>+    cpu->accel->dirty =3D false;
>+
>+    return 0;
>+}
>+
>+static int fetch_guest_state(CPUState *cpu)
>+{
>+    int ret;
>+
>+    ret =3D mshv_get_standard_regs(cpu);
>+    if (ret < 0) {
>+        error_report("Failed to get standard registers");
>+        return -1;
>+    }
>+
>+    ret =3D mshv_get_special_regs(cpu);
>+    if (ret < 0) {
>+        error_report("Failed to get special registers");
>+        return -1;
>+    }
>+
>+    return 0;
>+}
>+
>+static int read_memory(const CPUState *cpu, uint64_t initial_gva,
>+                       uint64_t initial_gpa, uint64_t gva, uint8_t *data=
,
>+                       size_t len)
>+{
>+    int ret;
>+    uint64_t gpa, flags;
>+
>+    if (gva =3D=3D initial_gva) {
>+        gpa =3D initial_gpa;

This assignment is never read and this branch leaves `data` untouched=2E=
=2E=2E

>+    } else {
>+        flags =3D HV_TRANSLATE_GVA_VALIDATE_READ;
>+        ret =3D translate_gva(cpu, gva, &gpa, flags);
>+        if (ret < 0) {
>+            return -1;
>+        }
>+

while this block:

>+        ret =3D mshv_guest_mem_read(gpa, data, len, false, false);
>+        if (ret < 0) {
>+            error_report("failed to read guest mem");
>+            return -1;
>+        }

is only executed in the else branch which is inconsistent to write_memory(=
)=2E Is that intended? If so, do we really need the unused assignment above=
?

Best regards,
Bernhard

>+    }
>+
>+    return 0;
>+}
>+
>+static int write_memory(const CPUState *cpu, uint64_t initial_gva,
>+                        uint64_t initial_gpa, uint64_t gva, const uint8_=
t *data,
>+                        size_t len)
>+{
>+    int ret;
>+    uint64_t gpa, flags;
>+
>+    if (gva =3D=3D initial_gva) {
>+        gpa =3D initial_gpa;
>+    } else {
>+        flags =3D HV_TRANSLATE_GVA_VALIDATE_WRITE;
>+        ret =3D translate_gva(cpu, gva, &gpa, flags);
>+        if (ret < 0) {
>+            error_report("failed to translate gva to gpa");
>+            return -1;
>+        }
>+    }
>+    ret =3D mshv_guest_mem_write(gpa, data, len, false);
>+    if (ret !=3D MEMTX_OK) {
>+        error_report("failed to write to mmio");
>+        return -1;
>+    }
>+
>+    return 0;
>+}
>+
>+static int handle_pio_str_write(CPUState *cpu,
>+                                hv_x64_io_port_intercept_message *info,
>+                                size_t repeat, uint16_t port,
>+                                bool direction_flag)
>+{
>+    int ret;
>+    uint64_t src;
>+    uint8_t data[4] =3D { 0 };
>+    size_t len =3D info->access_info=2Eaccess_size;
>+
>+    src =3D linear_addr(cpu, info->rsi, R_DS);
>+
>+    for (size_t i =3D 0; i < repeat; i++) {
>+        ret =3D read_memory(cpu, 0, 0, src, data, len);
>+        if (ret < 0) {
>+            error_report("Failed to read memory");
>+            return -1;
>+        }
>+        ret =3D pio_write(port, data, len, false);
>+        if (ret < 0) {
>+            error_report("Failed to write to io port");
>+            return -1;
>+        }
>+        src +=3D direction_flag ? -len : len;
>+        info->rsi +=3D direction_flag ? -len : len;
>+    }
>+
>+    return 0;
>+}
>+
>+static int handle_pio_str_read(CPUState *cpu,
>+                               hv_x64_io_port_intercept_message *info,
>+                               size_t repeat, uint16_t port,
>+                               bool direction_flag)
>+{
>+    int ret;
>+    uint64_t dst;
>+    size_t len =3D info->access_info=2Eaccess_size;
>+    uint8_t data[4] =3D { 0 };
>+
>+    dst =3D linear_addr(cpu, info->rdi, R_ES);
>+
>+    for (size_t i =3D 0; i < repeat; i++) {
>+        pio_read(port, data, len, false);
>+
>+        ret =3D write_memory(cpu, 0, 0, dst, data, len);
>+        if (ret < 0) {
>+            error_report("Failed to write memory");
>+            return -1;
>+        }
>+        dst +=3D direction_flag ? -len : len;
>+        info->rdi +=3D direction_flag ? -len : len;
>+    }
>+
>+    return 0;
>+}
>+
>+static int handle_pio_str(CPUState *cpu, hv_x64_io_port_intercept_messag=
e *info)
>+{
>+    uint8_t access_type =3D info->header=2Eintercept_access_type;
>+    uint16_t port =3D info->port_number;
>+    bool repop =3D info->access_info=2Erep_prefix =3D=3D 1;
>+    size_t repeat =3D repop ? info->rcx : 1;
>+    size_t insn_len =3D info->header=2Einstruction_length;
>+    bool direction_flag;
>+    uint32_t reg_names[3];
>+    uint64_t reg_values[3];
>+    int ret;
>+    X86CPU *x86_cpu =3D X86_CPU(cpu);
>+    CPUX86State *env =3D &x86_cpu->env;
>+
>+    ret =3D fetch_guest_state(cpu);
>+    if (ret < 0) {
>+        error_report("Failed to fetch guest state");
>+        return -1;
>+    }
>+
>+    direction_flag =3D (env->eflags & DESC_E_MASK) !=3D 0;
>+
>+    if (access_type =3D=3D HV_X64_INTERCEPT_ACCESS_TYPE_WRITE) {
>+        ret =3D handle_pio_str_write(cpu, info, repeat, port, direction_=
flag);
>+        if (ret < 0) {
>+            error_report("Failed to handle pio str write");
>+            return -1;
>+        }
>+        reg_names[0] =3D HV_X64_REGISTER_RSI;
>+        reg_values[0] =3D info->rsi;
>+    } else {
>+        ret =3D handle_pio_str_read(cpu, info, repeat, port, direction_f=
lag);
>+        reg_names[0] =3D HV_X64_REGISTER_RDI;
>+        reg_values[0] =3D info->rdi;
>+    }
>+
>+    reg_names[1] =3D HV_X64_REGISTER_RIP;
>+    reg_values[1] =3D info->header=2Erip + insn_len;
>+    reg_names[2] =3D HV_X64_REGISTER_RAX;
>+    reg_values[2] =3D info->rax;
>+
>+    ret =3D set_x64_registers(cpu, reg_names, reg_values);
>+    if (ret < 0) {
>+        error_report("Failed to set x64 registers");
>+        return -1;
>+    }
>+
>+    cpu->accel->dirty =3D false;
>+
>+    return 0;
>+}
>+
>+static int handle_pio(CPUState *cpu, const struct hyperv_message *msg)
>+{
>+    struct hv_x64_io_port_intercept_message info =3D { 0 };
>+    int ret;
>+
>+    ret =3D set_ioport_info(msg, &info);
>+    if (ret < 0) {
>+        error_report("Failed to convert message to ioport info");
>+        return -1;
>+    }
>+
>+    if (info=2Eaccess_info=2Estring_op) {
>+        return handle_pio_str(cpu, &info);
>+    }
>+
>+    return handle_pio_non_str(cpu, &info);
>+}
>+
> int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit =
*exit)
> {
>-    error_report("unimplemented");
>-    abort();
>+    int ret;
>+    enum MshvVmExit exit_reason;
>+    int cpu_fd =3D mshv_vcpufd(cpu);
>+
>+    ret =3D ioctl(cpu_fd, MSHV_RUN_VP, msg);
>+    if (ret < 0) {
>+        return MshvVmExitShutdown;
>+    }
>+
>+    switch (msg->header=2Emessage_type) {
>+    case HVMSG_UNRECOVERABLE_EXCEPTION:
>+        return MshvVmExitShutdown;
>+    case HVMSG_UNMAPPED_GPA:
>+    case HVMSG_GPA_INTERCEPT:
>+        ret =3D handle_mmio(cpu, msg, &exit_reason);
>+        if (ret < 0) {
>+            error_report("failed to handle mmio");
>+            return -1;
>+        }
>+        return exit_reason;
>+    case HVMSG_X64_IO_PORT_INTERCEPT:
>+        ret =3D handle_pio(cpu, msg);
>+        if (ret < 0) {
>+            return MshvVmExitSpecial;
>+        }
>+        return MshvVmExitIgnore;
>+    default:
>+        break;
>+    }
>+
>+    *exit =3D MshvVmExitIgnore;
>+    return 0;
> }
>=20
> void mshv_remove_vcpu(int vm_fd, int cpu_fd)

