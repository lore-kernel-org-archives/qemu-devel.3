Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0C4C54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 22:39:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHVbX-0002qi-NL; Tue, 20 May 2025 18:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uHVbV-0002qQ-Nd
 for qemu-devel@nongnu.org; Tue, 20 May 2025 18:38:34 -0400
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uHVbT-0007gF-He
 for qemu-devel@nongnu.org; Tue, 20 May 2025 18:38:33 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id E7E43A43020;
 Tue, 20 May 2025 22:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF62C4CEE9;
 Tue, 20 May 2025 22:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747780709;
 bh=BmOq8rpqDQLyK0C3YiqhCqqAPipozd/fIQCPzQNvjTE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aFuGUHublLOBgL1Uy976z43CzbjpqYIU7bS0oWYp+FN7of61iM9IhkLrJ3/EzL2C8
 pQBwDRoybv2nXEp87yW2ZxKtttP8JufIManGUsWsR9Yrl2j+IM1LpqQFz4CRt3B23n
 0awbIx7FYoZMjyB3hsCEYzuwT0FNDOQJaWSOrZOmLlNnrmHL8++6BlavbeRmS1ZXLv
 MM58MFpyzADDHqqzJ7owptagR5DrZ5M3QL2Ppe9rvui0XT2RX9WJlOOsp/MCSMbWJz
 AokY5V497f0hPUGMvx1AyVEMy506TjyBVUZhTlnDB7j9x3xPMSw871tEIYKzCX9o89
 +AHgdu9goEPIg==
Date: Tue, 20 May 2025 22:38:28 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 22/25] target/i386/mshv: Integrate x86 instruction
 decoder/emulator
Message-ID: <aC0EZHBoP_ez_ShX@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-23-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520113018.49569-23-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=147.75.193.91; envelope-from=wei.liu@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, May 20, 2025 at 01:30:15PM +0200, Magnus Kulke wrote:
> Connect the x86 instruction decoder and emulator to the MSHV backend
> to handle intercepted instructions. This enables software emulation
> of MMIO operations in MSHV guests. MSHV has a translate_gva hypercall
> that is used to accessing the physical guest memory.
> 
> A guest might read from unmapped memory regions (e.g. OVMF will probe
> 0xfed40000 for a vTPM). In those cases 0xFF bytes is returned instead of
> aborting the execution.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  accel/mshv/mem.c            |  72 ++++++++++++++++++++
>  accel/mshv/trace-events     |   3 +
>  include/system/mshv.h       |   4 ++
>  target/i386/mshv/mshv-cpu.c | 127 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 206 insertions(+)
> 
> diff --git a/accel/mshv/mem.c b/accel/mshv/mem.c
> index 2bbeae4f4a..ee627e7bd6 100644
> --- a/accel/mshv/mem.c
> +++ b/accel/mshv/mem.c
> @@ -54,6 +54,78 @@ static int map_or_unmap(int vm_fd, const MshvMemoryRegion *mr, bool add)
>      return set_guest_memory(vm_fd, &region);
>  }
>  
> +static inline MemTxAttrs get_mem_attrs(bool is_secure_mode)
> +{
> +    MemTxAttrs memattr = {0};
> +    memattr.secure = is_secure_mode;
> +    return memattr;
> +}

This function can be dropped. Its call site can be written as

      MemTxAttrs memattrs = { .secure = is_secure_mode };

> +
> +static int handle_unmapped_mmio_region_read(uint64_t gpa, uint64_t size,
> +                                            uint8_t *data)
> +{
> +    warn_report("read from unmapped mmio region gpa=0x%lx size=%lu", gpa, size);
> +
> +    if (size == 0 || size > 8) {
> +        error_report("invalid size %lu for reading from unmapped mmio region",
> +                     size);
> +        return -1;
> +    }
> +
> +    memset(data, 0xFF, size);
> +
> +    return 0;
> +}
> +
> +int mshv_guest_mem_read(uint64_t gpa, uint8_t *data, uintptr_t size,
> +                        bool is_secure_mode, bool instruction_fetch)
> +{
> +    int ret;
> +    MemTxAttrs memattr = get_mem_attrs(is_secure_mode);
> +
> +    if (instruction_fetch) {
> +        trace_mshv_insn_fetch(gpa, size);
> +    } else {
> +        trace_mshv_mem_read(gpa, size);
> +    }
> +
> +    ret = address_space_rw(&address_space_memory, gpa, memattr, (void *)data,
> +                           size, false);
> +    if (ret == MEMTX_OK) {
> +        return 0;
> +    }
> +
> +    if (ret == MEMTX_DECODE_ERROR) {
> +        return handle_unmapped_mmio_region_read(gpa, size, data);
> +    }
> +
> +    error_report("failed to read guest memory at 0x%lx", gpa);
> +    return -1;
> +}
> +
> +int mshv_guest_mem_write(uint64_t gpa, const uint8_t *data, uintptr_t size,
> +                         bool is_secure_mode)
> +{
> +    int ret;
> +
> +    trace_mshv_mem_write(gpa, size);
> +    MemTxAttrs memattr = get_mem_attrs(is_secure_mode);
> +    ret = address_space_rw(&address_space_memory, gpa, memattr, (void *)data,
> +                           size, true);
> +    if (ret == MEMTX_OK) {
> +        return 0;
> +    }
> +
> +    if (ret == MEMTX_DECODE_ERROR) {
> +        warn_report("write to unmapped mmio region gpa=0x%lx size=%lu", gpa,
> +                    size);
> +        return 0;
> +    }
> +
> +    error_report("Failed to write guest memory");
> +    return -1;
> +}
> +
>  static int set_memory(const MshvMemoryRegion *mshv_mr, bool add)
>  {
>      int ret = 0;
> diff --git a/accel/mshv/trace-events b/accel/mshv/trace-events
> index 06aa27ef67..686d89e084 100644
> --- a/accel/mshv/trace-events
> +++ b/accel/mshv/trace-events
> @@ -15,3 +15,6 @@ mshv_commit_msi_routing_table(int vm_fd, int len) "vm_fd %d table_size %d"
>  mshv_register_irqfd(int vm_fd, int event_fd, uint32_t gsi) "vm_fd %d event_fd %d gsi %d"
>  mshv_irqchip_update_irqfd_notifier_gsi(int event_fd, int resample_fd, int virq, bool add) "event_fd %d resample_fd %d virq %d add %d"
>  
> +mshv_insn_fetch(uint64_t addr, size_t size) "gpa=%lx size=%lu"
> +mshv_mem_write(uint64_t addr, size_t size) "\tgpa=%lx size=%lu"
> +mshv_mem_read(uint64_t addr, size_t size) "\tgpa=%lx size=%lu"
> diff --git a/include/system/mshv.h b/include/system/mshv.h
> index f854f9b77d..622b3db540 100644
> --- a/include/system/mshv.h
> +++ b/include/system/mshv.h
> @@ -201,6 +201,10 @@ typedef struct MshvMemoryRegion {
>  
>  int mshv_add_mem(int vm_fd, const MshvMemoryRegion *mr);
>  int mshv_remove_mem(int vm_fd, const MshvMemoryRegion *mr);
> +int mshv_guest_mem_read(uint64_t gpa, uint8_t *data, uintptr_t size,
> +                        bool is_secure_mode, bool instruction_fetch);
> +int mshv_guest_mem_write(uint64_t gpa, const uint8_t *data, uintptr_t size,
> +                         bool is_secure_mode);
>  void mshv_set_phys_mem(MshvMemoryListener *mml, MemoryRegionSection *section,
>                         bool add);
>  /* interrupt */
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 081132e0c9..a7ee5ebb2a 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -995,11 +995,138 @@ int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd)
>      return 0;
>  }
>  
> +static int translate_gva(int cpu_fd, uint64_t gva, uint64_t *gpa,
> +                         uint64_t flags)
> +{
> +    int ret;
> +    union hv_translate_gva_result result = { 0 };
> +
> +    *gpa = 0;
> +    mshv_translate_gva args = {
> +        .gva = gva,
> +        .flags = flags,
> +        .gpa = (__u64 *)gpa,
> +        .result = &result,
> +    };
> +
> +    ret = ioctl(cpu_fd, MSHV_TRANSLATE_GVA, &args);
> +    if (ret < 0) {
> +        error_report("failed to invoke gpa->gva translation");
> +        return -errno;
> +    }
> +    if (result.result_code != HV_TRANSLATE_GVA_SUCCESS) {
> +        error_report("failed to translate gva (" TARGET_FMT_lx ") to gpa", gva);
> +        return -1;
> +
> +    }
> +
> +    return 0;
> +}
> +
> +static int guest_mem_read_with_gva(const CPUState *cpu, uint64_t gva,
> +                                   uint8_t *data, uintptr_t size,
> +                                   bool fetch_instruction)
> +{
> +    int ret;
> +    uint64_t gpa, flags;
> +    int cpu_fd = mshv_vcpufd(cpu);
> +
> +    flags = HV_TRANSLATE_GVA_VALIDATE_READ;
> +    ret = translate_gva(cpu_fd, gva, &gpa, flags);

Please check the exit structure. IIRC it provides an initial
translation. If you don't cross a page boundary, that's probably enough
for what you need. This is going to save you a lot of transitions across
two boundaries (user -> kernel, kernel -> hypervisor).

> +    if (ret < 0) {
> +        error_report("failed to translate gva to gpa");
> +        return -1;
> +    }
> +
> +    ret = mshv_guest_mem_read(gpa, data, size, false, fetch_instruction);
> +    if (ret < 0) {
> +        error_report("failed to read from guest memory");
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int guest_mem_write_with_gva(const CPUState *cpu, uint64_t gva,
> +                                    const uint8_t *data, uintptr_t size)
> +{
> +    int ret;
> +    uint64_t gpa, flags;
> +    int cpu_fd = mshv_vcpufd(cpu);
> +
> +    flags = HV_TRANSLATE_GVA_VALIDATE_WRITE;
> +    ret = translate_gva(cpu_fd, gva, &gpa, flags);
> +    if (ret < 0) {
> +        error_report("failed to translate gva to gpa");
> +        return -1;
> +    }
> +    ret = mshv_guest_mem_write(gpa, data, size, false);
> +    if (ret < 0) {
> +        error_report("failed to write to guest memory");
> +        return -1;
> +    }
> +    return 0;
> +}
> +
> +static void write_mem_emu(CPUState *cpu, void *data, target_ulong addr,
> +                          int bytes)
> +{
> +    if (guest_mem_write_with_gva(cpu, addr, data, bytes) < 0) {
> +        error_report("failed to write memory");
> +        abort();
> +    }
> +}
> +
> +static void read_mem_emu(CPUState *cpu, void *data, target_ulong addr,
> +                         int bytes)
> +{
> +    if (guest_mem_read_with_gva(cpu, addr, data, bytes, false) < 0) {
> +        error_report("failed to read memory");
> +        abort();
> +    }
> +}
> +
> +static void fetch_instruction_emu(CPUState *cpu, void *data,
> +                                  target_ulong addr, int bytes)
> +{
> +    if (guest_mem_read_with_gva(cpu, addr, data, bytes, true) < 0) {
> +        error_report("failed to fetch instruction");
> +        abort();
> +    }
> +}
> +
> +static void read_segment_descriptor_emu(CPUState *cpu,
> +                                        struct x86_segment_descriptor *desc,
> +                                        enum X86Seg seg_idx)
> +{
> +    bool ret;
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
> +    SegmentCache *seg = &env->segs[seg_idx];
> +    x86_segment_selector sel = { .sel = seg->selector & 0xFFFF };
> +
> +    ret = x86_read_segment_descriptor(cpu, desc, sel);
> +    if (ret == false) {
> +        error_report("failed to read segment descriptor");
> +        abort();
> +    }
> +}
> +
> +static const struct x86_emul_ops mshv_x86_emul_ops = {
> +    .fetch_instruction = fetch_instruction_emu,
> +    .read_mem = read_mem_emu,
> +    .write_mem = write_mem_emu,
> +    .read_segment_descriptor = read_segment_descriptor_emu,

You can remove the _emu suffix from all the handler functions.

> +};
> +
>  void mshv_init_cpu_logic(void)
>  {
>      cpu_guards_lock = g_new0(QemuMutex, 1);
>      qemu_mutex_init(cpu_guards_lock);
>      cpu_guards = g_hash_table_new(g_direct_hash, g_direct_equal);
> +
> +    init_decoder();
> +    init_emu(&mshv_x86_emul_ops);

If I'm not mistaken, the name mshv_init_cpu_logic suggests this function
is called every time a CPU is initialized. There is no need to
repeatedly initialize the emulator.

The code snippet should be moved to either the initialization function
of the accelerator or the initialization function of the VM object.

Thanks,
Wei.

>  }
>  
>  void mshv_arch_init_vcpu(CPUState *cpu)
> -- 
> 2.34.1
> 

