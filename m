Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAA0C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHMv5-00037D-Ie; Tue, 20 May 2025 09:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHMv4-00036z-7w
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:22:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHMv0-00077E-IZ
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747747325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8uFtiOfYuwlDzvIMgcR0sbYOTbvly9Qyq0vccyjqmoI=;
 b=WDnEhfykwPqlSYa1m9WCqTudWje47n6tKgJU8D8XSQm/lSu14oayn0S3gnYKaExeehxz+t
 1hriUGKe1NaCxSu9Usa3eRq1Rlr6RUa6ukAexrmyPRYU1e5qCWXpV2Lb4HPCtdn7HTAczC
 V4vnNK0fR9EjPJUiYHHICDDLxvSGQUY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-Yt6RnF4QMzS6lPk1xghSYQ-1; Tue, 20 May 2025 09:22:03 -0400
X-MC-Unique: Yt6RnF4QMzS6lPk1xghSYQ-1
X-Mimecast-MFC-AGG-ID: Yt6RnF4QMzS6lPk1xghSYQ_1747747322
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-acb61452b27so473732566b.2
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 06:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747747322; x=1748352122;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8uFtiOfYuwlDzvIMgcR0sbYOTbvly9Qyq0vccyjqmoI=;
 b=Br5xqksrBdfVv0Y8SJbQMkjZS2oLu6qbPd8B//ZbWMZBE6zVxaAYt0dTf3LccrPQ22
 KZcsqjFpVMzKdCmEJWEviwUhcq0phvCwuvSPMmfSdYpF7plPqqe3tyJ17Fg2a4D1PV1/
 JVeoDsMmjp4qkEqY1xt5n6e1mlh/l4mHkQRND2DY+5JPoFqDGFIeacnnQH8r9BUsfstx
 3U4asPblJF2IzUxrCjCE2KBaWUtH0WU/JzS4m8cp8eDwrpR7U+VVu38Y5bn0pdCOF/gA
 ppbT9NT/tNDOjhLrbPgkDRmfwBPFLbJ+j/3tRw09LHn/UuQVRsgEhQTyULNtfCp+fK9D
 5DDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJKUn/dOJzDj7N9aD9eTn3YmVKl/NBe8QPTccdbQOJ4+XGXgUbgUWBnD715Un5TeTB1sYNuzC7LZa3@nongnu.org
X-Gm-Message-State: AOJu0YyASCHeOSG5WesZYwnyuQYzren6ndLkAAOUgJpiwvdSrUopKs3h
 rJG+d2ttR9W0SYntQhLJjf7SOCGraHPfMSNQUyuCfVAHPtfhv8xX61AHgwjdqH/zjfiKD7FkTr1
 tGN/piapYwdytpGxe5MmUYHfqduvnsDOstKjHBcxl1drDNJyK1Ytc39rJ
X-Gm-Gg: ASbGncvcdZwUcOg3GKNHpoS2ctTbmgsid8QH+YZcBdZEsO6+JLcGJI5tK1Tqs2DKvMW
 Gu/cUs3/0k2YctkPUJ/cHnZ7N7d13aDIbYZlJb0E8BEFJp8y8Fn0WiVLBoQIetXXbSbPH08/yB6
 w1zxDOaoYalR4mH6kgBLJCDDLImpL2GhiSuo5lq1YZ5shBGerh9AZLrFcjpNMHM6KDqAPpqo9EU
 5v8HXw5xVxQj7H08UFkG4+9bau8AwwZ/g8e5s+dVfiq8wutdXnfzPXH+6CE1YfUIFvaIAPGvk7g
 TIbjdh7rPYKAow==
X-Received: by 2002:a17:907:c807:b0:ace:cdfc:40aa with SMTP id
 a640c23a62f3a-ad52d4b2782mr1228495966b.19.1747747321669; 
 Tue, 20 May 2025 06:22:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEylemFOvNl4zEsblIgOK1gJnA3rozL+eVgmnpIiZzFt5+kaj6QT2L4sQTM+MVJ4fekBJAR0w==
X-Received: by 2002:a17:907:c807:b0:ace:cdfc:40aa with SMTP id
 a640c23a62f3a-ad52d4b2782mr1228491666b.19.1747747321164; 
 Tue, 20 May 2025 06:22:01 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ad52d047c30sm726039866b.6.2025.05.20.06.22.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 06:22:00 -0700 (PDT)
Message-ID: <aa48e55d-2267-42a0-a564-664eaf5e5b7f@redhat.com>
Date: Tue, 20 May 2025 15:21:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 24/25] target/i386/mshv: Implement mshv_vcpu_run()
To: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-25-magnuskulke@linux.microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250520113018.49569-25-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/20/25 13:30, Magnus Kulke wrote:
> +static int emulate_instruction(CPUState *cpu,
> +                               const uint8_t *insn_bytes, size_t insn_len,
> +                               uint64_t gva, uint64_t gpa)
> +{
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
> +    struct x86_decode decode = { 0 };
> +    int ret;
> +    int cpu_fd = mshv_vcpufd(cpu);
> +    QemuMutex *guard;
> +    x86_insn_stream stream = { .bytes = insn_bytes, .len = insn_len };
> +
> +    guard = g_hash_table_lookup(cpu_guards, GUINT_TO_POINTER(cpu_fd));

mshv_cpu_exec() will always run in the vCPU thread, so you don't need a 
mutex.  All of patch 14 can go, in fact.

Paolo

> +    if (!guard) {
> +        error_report("failed to get cpu guard");
> +        return -1;
> +    }
> +
> +    WITH_QEMU_LOCK_GUARD(guard) {
> +        ret = mshv_load_regs(cpu);
> +        if (ret < 0) {
> +            error_report("failed to load registers");
> +            return -1;
> +        }
> +
> +        decode_instruction_stream(env, &decode, &stream);
> +        exec_instruction(env, &decode);
> +
> +        ret = mshv_store_regs(cpu);
> +        if (ret < 0) {
> +            error_report("failed to store registers");
> +            return -1;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static int handle_mmio(CPUState *cpu, const struct hyperv_message *msg,
> +                       MshvVmExit *exit_reason)
> +{
> +    struct hv_x64_memory_intercept_message info = { 0 };
> +    size_t insn_len;
> +    uint8_t access_type;
> +    uint8_t *instruction_bytes;
> +    int ret;
> +
> +    ret = set_memory_info(msg, &info);
> +    if (ret < 0) {
> +        error_report("failed to convert message to memory info");
> +        return -1;
> +    }
> +    insn_len = info.instruction_byte_count;
> +    access_type = info.header.intercept_access_type;
> +
> +    if (access_type == HV_X64_INTERCEPT_ACCESS_TYPE_EXECUTE) {
> +        error_report("invalid intercept access type: execute");
> +        return -1;
> +    }
> +
> +    if (insn_len > 16) {
> +        error_report("invalid mmio instruction length: %zu", insn_len);
> +        return -1;
> +    }
> +
> +    if (insn_len == 0) {
> +        warn_report("mmio instruction buffer empty");
> +    }
> +
> +    instruction_bytes = info.instruction_bytes;
> +
> +    ret = emulate_instruction(cpu, instruction_bytes, insn_len,
> +                              info.guest_virtual_address,
> +                              info.guest_physical_address);
> +    if (ret < 0) {
> +        error_report("failed to emulate mmio");
> +        return -1;
> +    }
> +
> +    *exit_reason = MshvVmExitIgnore;
> +
> +    return 0;
> +}
> +
> +static int handle_unmapped_mem(int vm_fd, CPUState *cpu,
> +                               const struct hyperv_message *msg,
> +                               MshvVmExit *exit_reason)
> +{
> +    struct hv_x64_memory_intercept_message info = { 0 };
> +    int ret;
> +
> +    ret = set_memory_info(msg, &info);
> +    if (ret < 0) {
> +        error_report("failed to convert message to memory info");
> +        return -1;
> +    }
> +
> +    return handle_mmio(cpu, msg, exit_reason);
> +}
> +
> +static int set_ioport_info(const struct hyperv_message *msg,
> +                           hv_x64_io_port_intercept_message *info)
> +{
> +    if (msg->header.message_type != HVMSG_X64_IO_PORT_INTERCEPT) {
> +        error_report("Invalid message type");
> +        return -1;
> +    }
> +    memcpy(info, msg->payload, sizeof(*info));
> +
> +    return 0;
> +}
> +
> +typedef struct X64Registers {
> +  const uint32_t *names;
> +  const uint64_t *values;
> +  uintptr_t count;
> +} X64Registers;
> +
> +static int set_x64_registers(int cpu_fd, const X64Registers *regs)
> +{
> +    size_t n_regs = regs->count;
> +    struct hv_register_assoc *assocs;
> +
> +    assocs = g_new0(hv_register_assoc, n_regs);
> +    for (size_t i = 0; i < n_regs; i++) {
> +        assocs[i].name = regs->names[i];
> +        assocs[i].value.reg64 = regs->values[i];
> +    }
> +    int ret;
> +
> +    ret = mshv_set_generic_regs(cpu_fd, assocs, n_regs);
> +    g_free(assocs);
> +    if (ret < 0) {
> +        error_report("failed to set x64 registers");
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static inline MemTxAttrs get_mem_attrs(bool is_secure_mode)
> +{
> +    MemTxAttrs memattr = {0};
> +    memattr.secure = is_secure_mode;
> +    return memattr;
> +}
> +
> +static void pio_read(uint64_t port, uint8_t *data, uintptr_t size,
> +                     bool is_secure_mode)
> +{
> +    int ret = 0;
> +    MemTxAttrs memattr = get_mem_attrs(is_secure_mode);
> +    ret = address_space_rw(&address_space_io, port, memattr, (void *)data, size,
> +                           false);
> +    if (ret != MEMTX_OK) {
> +        error_report("Failed to read from port %lx: %d", port, ret);
> +        abort();
> +    }
> +}
> +
> +static int pio_write(uint64_t port, const uint8_t *data, uintptr_t size,
> +                     bool is_secure_mode)
> +{
> +    int ret = 0;
> +    MemTxAttrs memattr = get_mem_attrs(is_secure_mode);
> +    ret = address_space_rw(&address_space_io, port, memattr, (void *)data, size,
> +                           true);
> +    return ret;
> +}
> +
> +static int handle_pio_non_str(const CPUState *cpu,
> +                              hv_x64_io_port_intercept_message *info) {
> +    size_t len = info->access_info.access_size;
> +    uint8_t access_type = info->header.intercept_access_type;
> +    int ret;
> +    uint32_t val, eax;
> +    const uint32_t eax_mask =  0xffffffffu >> (32 - len * 8);
> +    size_t insn_len;
> +    uint64_t rip, rax;
> +    uint32_t reg_names[2];
> +    uint64_t reg_values[2];
> +    struct X64Registers x64_regs = { 0 };
> +    uint16_t port = info->port_number;
> +    int cpu_fd = mshv_vcpufd(cpu);
> +
> +    if (access_type == HV_X64_INTERCEPT_ACCESS_TYPE_WRITE) {
> +        union {
> +            uint32_t u32;
> +            uint8_t bytes[4];
> +        } conv;
> +
> +        /* convert the first 4 bytes of rax to bytes */
> +        conv.u32 = (uint32_t)info->rax;
> +        /* secure mode is set to false */
> +        ret = pio_write(port, conv.bytes, len, false);
> +        if (ret < 0) {
> +            error_report("Failed to write to io port");
> +            return -1;
> +        }
> +    } else {
> +        uint8_t data[4] = { 0 };
> +        /* secure mode is set to false */
> +        pio_read(info->port_number, data, len, false);
> +
> +        /* Preserve high bits in EAX, but clear out high bits in RAX */
> +        val = *(uint32_t *)data;
> +        eax = (((uint32_t)info->rax) & ~eax_mask) | (val & eax_mask);
> +        info->rax = (uint64_t)eax;
> +    }
> +
> +    insn_len = info->header.instruction_length;
> +
> +    /* Advance RIP and update RAX */
> +    rip = info->header.rip + insn_len;
> +    rax = info->rax;
> +
> +    reg_names[0] = HV_X64_REGISTER_RIP;
> +    reg_values[0] = rip;
> +    reg_names[1] = HV_X64_REGISTER_RAX;
> +    reg_values[1] = rax;
> +
> +    x64_regs.names = reg_names;
> +    x64_regs.values = reg_values;
> +    x64_regs.count = 2;
> +
> +    ret = set_x64_registers(cpu_fd, &x64_regs);
> +    if (ret < 0) {
> +        error_report("Failed to set x64 registers");
> +        return -1;
> +    }
> +
> +    cpu->accel->dirty = false;
> +
> +    return 0;
> +}
> +
> +static int fetch_guest_state(CPUState *cpu)
> +{
> +    int ret;
> +
> +    ret = mshv_get_standard_regs(cpu);
> +    if (ret < 0) {
> +        error_report("Failed to get standard registers");
> +        return -1;
> +    }
> +
> +    ret = mshv_get_special_regs(cpu);
> +    if (ret < 0) {
> +        error_report("Failed to get special registers");
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int read_memory(int cpu_fd, uint64_t initial_gva, uint64_t initial_gpa,
> +                       uint64_t gva, uint8_t *data, size_t len)
> +{
> +    int ret;
> +    uint64_t gpa, flags;
> +
> +    if (gva == initial_gva) {
> +        gpa = initial_gpa;
> +    } else {
> +        flags = HV_TRANSLATE_GVA_VALIDATE_READ;
> +        ret = translate_gva(cpu_fd, gva, &gpa, flags);
> +        if (ret < 0) {
> +            return -1;
> +        }
> +
> +        ret = mshv_guest_mem_read(gpa, data, len, false, false);
> +        if (ret < 0) {
> +            error_report("failed to read guest mem");
> +            return -1;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static int write_memory(int cpu_fd, uint64_t initial_gva, uint64_t initial_gpa,
> +                        uint64_t gva, const uint8_t *data, size_t len)
> +{
> +    int ret;
> +    uint64_t gpa, flags;
> +
> +    if (gva == initial_gva) {
> +        gpa = initial_gpa;
> +    } else {
> +        flags = HV_TRANSLATE_GVA_VALIDATE_WRITE;
> +        ret = translate_gva(cpu_fd, gva, &gpa, flags);
> +        if (ret < 0) {
> +            error_report("failed to translate gva to gpa");
> +            return -1;
> +        }
> +    }
> +    ret = mshv_guest_mem_write(gpa, data, len, false);
> +    if (ret != MEMTX_OK) {
> +        error_report("failed to write to mmio");
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int handle_pio_str_write(CPUState *cpu,
> +                                hv_x64_io_port_intercept_message *info,
> +                                size_t repeat, uint16_t port,
> +                                bool direction_flag)
> +{
> +    int ret;
> +    uint64_t src;
> +    uint8_t data[4] = { 0 };
> +    size_t len = info->access_info.access_size;
> +    int cpu_fd = mshv_vcpufd(cpu);
> +
> +    src = linear_addr(cpu, info->rsi, R_DS);
> +
> +    for (size_t i = 0; i < repeat; i++) {
> +        ret = read_memory(cpu_fd, 0, 0, src, data, len);
> +        if (ret < 0) {
> +            error_report("Failed to read memory");
> +            return -1;
> +        }
> +        ret = pio_write(port, data, len, false);
> +        if (ret < 0) {
> +            error_report("Failed to write to io port");
> +            return -1;
> +        }
> +        src += direction_flag ? -len : len;
> +        info->rsi += direction_flag ? -len : len;
> +    }
> +
> +    return 0;
> +}
> +
> +static int handle_pio_str_read(CPUState *cpu,
> +                                hv_x64_io_port_intercept_message *info,
> +                                size_t repeat, uint16_t port,
> +                                bool direction_flag)
> +{
> +    int ret;
> +    uint64_t dst;
> +    size_t len = info->access_info.access_size;
> +    uint8_t data[4] = { 0 };
> +    int cpu_fd = mshv_vcpufd(cpu);
> +
> +    dst = linear_addr(cpu, info->rdi, R_ES);
> +
> +    for (size_t i = 0; i < repeat; i++) {
> +        pio_read(port, data, len, false);
> +
> +        ret = write_memory(cpu_fd, 0, 0, dst, data, len);
> +        if (ret < 0) {
> +            error_report("Failed to write memory");
> +            return -1;
> +        }
> +        dst += direction_flag ? -len : len;
> +        info->rdi += direction_flag ? -len : len;
> +    }
> +
> +    return 0;
> +}
> +
> +static int handle_pio_str(CPUState *cpu,
> +                          hv_x64_io_port_intercept_message *info)
> +{
> +    uint8_t access_type = info->header.intercept_access_type;
> +    uint16_t port = info->port_number;
> +    bool repop = info->access_info.rep_prefix == 1;
> +    size_t repeat = repop ? info->rcx : 1;
> +    size_t insn_len = info->header.instruction_length;
> +    bool direction_flag;
> +    uint32_t reg_names[3];
> +    uint64_t reg_values[3];
> +    int ret;
> +    struct X64Registers x64_regs = { 0 };
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
> +    int cpu_fd = mshv_vcpufd(cpu);
> +
> +    ret = fetch_guest_state(cpu);
> +    if (ret < 0) {
> +        error_report("Failed to fetch guest state");
> +        return -1;
> +    }
> +
> +    direction_flag = (env->eflags & DF) != 0;
> +
> +    if (access_type == HV_X64_INTERCEPT_ACCESS_TYPE_WRITE) {
> +        ret = handle_pio_str_write(cpu, info, repeat, port, direction_flag);
> +        if (ret < 0) {
> +            error_report("Failed to handle pio str write");
> +            return -1;
> +        }
> +        reg_names[0] = HV_X64_REGISTER_RSI;
> +        reg_values[0] = info->rsi;
> +    } else {
> +        ret = handle_pio_str_read(cpu, info, repeat, port, direction_flag);
> +        reg_names[0] = HV_X64_REGISTER_RDI;
> +        reg_values[0] = info->rdi;
> +    }
> +
> +    reg_names[1] = HV_X64_REGISTER_RIP;
> +    reg_values[1] = info->header.rip + insn_len;
> +    reg_names[2] = HV_X64_REGISTER_RAX;
> +    reg_values[2] = info->rax;
> +
> +    x64_regs.names = reg_names;
> +    x64_regs.values = reg_values;
> +    x64_regs.count = 2;
> +
> +    ret = set_x64_registers(cpu_fd, &x64_regs);
> +    if (ret < 0) {
> +        error_report("Failed to set x64 registers");
> +        return -1;
> +    }
> +
> +    cpu->accel->dirty = false;
> +
> +    return 0;
> +}
> +
> +static int handle_pio(CPUState *cpu, const struct hyperv_message *msg)
> +{
> +    struct hv_x64_io_port_intercept_message info = { 0 };
> +    int ret;
> +
> +    ret = set_ioport_info(msg, &info);
> +    if (ret < 0) {
> +        error_report("Failed to convert message to ioport info");
> +        return -1;
> +    }
> +
> +    if (info.access_info.string_op) {
> +        return handle_pio_str(cpu, &info);
> +    }
> +
> +    return handle_pio_non_str(cpu, &info);
> +}
> +
>   int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
>   {
> -	error_report("unimplemented");
> -	abort();
> +    int ret;
> +    hv_message exit_msg = { 0 };
> +    enum MshvVmExit exit_reason;
> +    int cpu_fd = mshv_vcpufd(cpu);
> +
> +    ret = ioctl(cpu_fd, MSHV_RUN_VP, &exit_msg);
> +    if (ret < 0) {
> +        return MshvVmExitShutdown;
> +    }
> +
> +    switch (exit_msg.header.message_type) {
> +    case HVMSG_UNRECOVERABLE_EXCEPTION:
> +        *msg = exit_msg;
> +        return MshvVmExitShutdown;
> +    case HVMSG_UNMAPPED_GPA:
> +        ret = handle_unmapped_mem(vm_fd, cpu, &exit_msg, &exit_reason);
> +        if (ret < 0) {
> +            error_report("failed to handle unmapped memory");
> +            return -1;
> +        }
> +        return exit_reason;
> +    case HVMSG_GPA_INTERCEPT:
> +        ret = handle_mmio(cpu, &exit_msg, &exit_reason);
> +        if (ret < 0) {
> +            error_report("failed to handle mmio");
> +            return -1;
> +        }
> +        return exit_reason;
> +    case HVMSG_X64_IO_PORT_INTERCEPT:
> +        ret = handle_pio(cpu, &exit_msg);
> +        if (ret < 0) {
> +            return MshvVmExitSpecial;
> +        }
> +        return MshvVmExitIgnore;
> +    default:
> +        msg = &exit_msg;
> +    }
> +
> +    *exit = MshvVmExitIgnore;
> +    return 0;
>   }
>   
>   void mshv_remove_vcpu(int vm_fd, int cpu_fd)
> @@ -1061,34 +1583,6 @@ int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd)
>       return 0;
>   }
>   
> -static int translate_gva(int cpu_fd, uint64_t gva, uint64_t *gpa,
> -                         uint64_t flags)
> -{
> -    int ret;
> -    union hv_translate_gva_result result = { 0 };
> -
> -    *gpa = 0;
> -    mshv_translate_gva args = {
> -        .gva = gva,
> -        .flags = flags,
> -        .gpa = (__u64 *)gpa,
> -        .result = &result,
> -    };
> -
> -    ret = ioctl(cpu_fd, MSHV_TRANSLATE_GVA, &args);
> -    if (ret < 0) {
> -        error_report("failed to invoke gpa->gva translation");
> -        return -errno;
> -    }
> -    if (result.result_code != HV_TRANSLATE_GVA_SUCCESS) {
> -        error_report("failed to translate gva (" TARGET_FMT_lx ") to gpa", gva);
> -        return -1;
> -
> -    }
> -
> -    return 0;
> -}
> -
>   static int guest_mem_read_with_gva(const CPUState *cpu, uint64_t gva,
>                                      uint8_t *data, uintptr_t size,
>                                      bool fetch_instruction)


