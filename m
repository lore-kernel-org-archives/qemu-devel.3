Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A2CCAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 17:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyZfK-0002yF-Si; Tue, 16 Sep 2025 13:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uyZfC-0002xG-78
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:40:22 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uyZf9-0006c9-MH
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:40:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=WelLw/bcLuTrLchrzorYYq8EzUjL33RFckeGQ10J0GM=; b=M0qMEruBurfi98EN
 qAQvOBSO3q1rU/xFssFAwZ5i3olN4AoJF+O8eaX8gS6iu4qFKCspJCNk7J686zLtc7LJdH33BJ3OE
 EgO1CECwc34QNymfd3NohZLxOeFmFC4imXnaQk8kB2XKRIPDIpPmxN2UTNquhk925QoYhDSn+gSi7
 YvbdDAalPiBIY+FLMZZaBggkmLLRq2XFi1urqyD+58nZ+YtXe6VOTVKnYini7JEHlXtxK9KVKvT9d
 cGbeEfZXmsJSqXImKN6+kmgjLppkkjBZgSwV6n+VZk5od0XxBEPZTL5zuznks6z71VFEhMono8BeF
 NkC41QR1lRjjrhFZHw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uyZf2-00BQYE-1N;
 Tue, 16 Sep 2025 17:40:12 +0000
Date: Tue, 16 Sep 2025 17:40:12 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Eric Blake <eblake@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 03/27] target/i386/mshv: Add x86 decoder/emu
 implementation
Message-ID: <aMmg_K8N1fKGUV4o@gallifrey>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
 <20250916164847.77883-4-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250916164847.77883-4-magnuskulke@linux.microsoft.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 17:32:49 up 142 days,  1:46,  1 user,  load average: 0.02, 0.02, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Magnus Kulke (magnuskulke@linux.microsoft.com) wrote:
> The MSHV accelerator requires a x86 decoder/emulator in userland to
> emulate MMIO instructions. This change contains the implementations for
> the generalized i386 instruction decoder/emulator.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

Hi Magnus,
  Just some things I noticed.

> ---
>  include/system/mshv.h           |  25 +++
>  target/i386/cpu.h               |   2 +-
>  target/i386/emulate/meson.build |   7 +-
>  target/i386/meson.build         |   2 +
>  target/i386/mshv/meson.build    |   7 +
>  target/i386/mshv/x86.c          | 297 ++++++++++++++++++++++++++++++++
>  6 files changed, 337 insertions(+), 3 deletions(-)
>  create mode 100644 include/system/mshv.h
>  create mode 100644 target/i386/mshv/meson.build
>  create mode 100644 target/i386/mshv/x86.c
> 

<snip>

> diff --git a/target/i386/mshv/x86.c b/target/i386/mshv/x86.c
> new file mode 100644
> index 0000000000..d574b3bc52
> --- /dev/null
> +++ b/target/i386/mshv/x86.c
> @@ -0,0 +1,297 @@
> +/*
> + * QEMU MSHV support
> + *
> + * Copyright Microsoft, Corp. 2025
> + *
> + * Authors: Magnus Kulke <magnuskulke@microsoft.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "cpu.h"
> +#include "emulate/x86_decode.h"
> +#include "emulate/x86_emu.h"
> +#include "qemu/typedefs.h"
> +#include "qemu/error-report.h"
> +#include "system/mshv.h"
> +
> +/* RW or Exec segment */
> +static const uint8_t RWRX_SEGMENT_TYPE        = 0x2;
> +static const uint8_t CODE_SEGMENT_TYPE        = 0x8;
> +static const uint8_t EXPAND_DOWN_SEGMENT_TYPE = 0x4;
> +
> +typedef enum CpuMode {
> +    REAL_MODE,
> +    PROTECTED_MODE,
> +    LONG_MODE,
> +} CpuMode;

These consts and enum look like things that should be in some
shared x86 thing; in fact there are some existing routines
that partially map to some of this.

For example 'x86_is_real' is declared in target/i386/emulate/x86.h
and defined in target/i386/hvf/x86.c  (hmm that's a bit weird).
So it's probably best to check if what you want already exists,
move it into target/i386 somewhere I guess, and everyone shares it.

(Don't worry, I'm not suggesting you fix all the zillions of places
that open code this type of stuff, but once it's in somewhere shared
that can happen).

> +static CpuMode cpu_mode(CPUState *cpu)
> +{
> +    enum CpuMode m = REAL_MODE;
> +
> +    if (x86_is_protected(cpu)) {
> +        m = PROTECTED_MODE;
> +
> +        if (x86_is_long_mode(cpu)) {
> +            m = LONG_MODE;
> +        }
> +    }
> +
> +    return m;
> +}
> +
> +static bool segment_type_ro(const SegmentCache *seg)
> +{
> +    uint32_t type_ = (seg->flags >> DESC_TYPE_SHIFT) & 15;

A variable ending in '_' is a bit odd for qemu.

Dave

> +    return (type_ & (~RWRX_SEGMENT_TYPE)) == 0;
> +}
> +
> +static bool segment_type_code(const SegmentCache *seg)
> +{
> +    uint32_t type_ = (seg->flags >> DESC_TYPE_SHIFT) & 15;
> +    return (type_ & CODE_SEGMENT_TYPE) != 0;
> +}
> +
> +static bool segment_expands_down(const SegmentCache *seg)
> +{
> +    uint32_t type_ = (seg->flags >> DESC_TYPE_SHIFT) & 15;
> +
> +    if (segment_type_code(seg)) {
> +        return false;
> +    }
> +
> +    return (type_ & EXPAND_DOWN_SEGMENT_TYPE) != 0;
> +}
> +
> +static uint32_t segment_limit(const SegmentCache *seg)
> +{
> +    uint32_t limit = seg->limit;
> +    uint32_t granularity = (seg->flags & DESC_G_MASK) != 0;
> +
> +    if (granularity != 0) {
> +        limit = (limit << 12) | 0xFFF;
> +    }
> +
> +    return limit;
> +}
> +
> +static uint8_t segment_db(const SegmentCache *seg)
> +{
> +    return (seg->flags >> DESC_B_SHIFT) & 1;
> +}
> +
> +static uint32_t segment_max_limit(const SegmentCache *seg)
> +{
> +    if (segment_db(seg) != 0) {
> +        return 0xFFFFFFFF;
> +    }
> +    return 0xFFFF;
> +}
> +
> +static int linearize(CPUState *cpu,
> +                     target_ulong logical_addr, target_ulong *linear_addr,
> +                     X86Seg seg_idx)
> +{
> +    enum CpuMode mode;
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
> +    SegmentCache *seg = &env->segs[seg_idx];
> +    target_ulong base = seg->base;
> +    target_ulong logical_addr_32b;
> +    uint32_t limit;
> +    /* TODO: the emulator will not pass us "write" indicator yet */
> +    bool write = false;
> +
> +    mode = cpu_mode(cpu);
> +
> +    switch (mode) {
> +    case LONG_MODE:
> +        if (__builtin_add_overflow(logical_addr, base, linear_addr)) {
> +            error_report("Address overflow");
> +            return -1;
> +        }
> +        break;
> +    case PROTECTED_MODE:
> +    case REAL_MODE:
> +        if (segment_type_ro(seg) && write) {
> +            error_report("Cannot write to read-only segment");
> +            return -1;
> +        }
> +
> +        logical_addr_32b = logical_addr & 0xFFFFFFFF;
> +        limit = segment_limit(seg);
> +
> +        if (segment_expands_down(seg)) {
> +            if (logical_addr_32b >= limit) {
> +                error_report("Address exceeds limit (expands down)");
> +                return -1;
> +            }
> +
> +            limit = segment_max_limit(seg);
> +        }
> +
> +        if (logical_addr_32b > limit) {
> +            error_report("Address exceeds limit %u", limit);
> +            return -1;
> +        }
> +        *linear_addr = logical_addr_32b + base;
> +        break;
> +    default:
> +        error_report("Unknown cpu mode: %d", mode);
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +bool x86_read_segment_descriptor(CPUState *cpu,
> +                                 struct x86_segment_descriptor *desc,
> +                                 x86_segment_selector sel)
> +{
> +    target_ulong base;
> +    uint32_t limit;
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
> +    target_ulong gva;
> +
> +    memset(desc, 0, sizeof(*desc));
> +
> +    /* valid gdt descriptors start from index 1 */
> +    if (!sel.index && GDT_SEL == sel.ti) {
> +        return false;
> +    }
> +
> +    if (GDT_SEL == sel.ti) {
> +        base = env->gdt.base;
> +        limit = env->gdt.limit;
> +    } else {
> +        base = env->ldt.base;
> +        limit = env->ldt.limit;
> +    }
> +
> +    if (sel.index * 8 >= limit) {
> +        return false;
> +    }
> +
> +    gva = base + sel.index * 8;
> +    emul_ops->read_mem(cpu, desc, gva, sizeof(*desc));
> +
> +    return true;
> +}
> +
> +bool x86_read_call_gate(CPUState *cpu, struct x86_call_gate *idt_desc,
> +                        int gate)
> +{
> +    target_ulong base;
> +    uint32_t limit;
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
> +    target_ulong gva;
> +
> +    base = env->idt.base;
> +    limit = env->idt.limit;
> +
> +    memset(idt_desc, 0, sizeof(*idt_desc));
> +    if (gate * 8 >= limit) {
> +        perror("call gate exceeds idt limit");
> +        return false;
> +    }
> +
> +    gva = base + gate * 8;
> +    emul_ops->read_mem(cpu, idt_desc, gva, sizeof(*idt_desc));
> +
> +    return true;
> +}
> +
> +bool x86_is_protected(CPUState *cpu)
> +{
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
> +    uint64_t cr0 = env->cr[0];
> +
> +    return cr0 & CR0_PE_MASK;
> +}
> +
> +bool x86_is_real(CPUState *cpu)
> +{
> +    return !x86_is_protected(cpu);
> +}
> +
> +bool x86_is_v8086(CPUState *cpu)
> +{
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
> +    return x86_is_protected(cpu) && (env->eflags & VM_MASK);
> +}
> +
> +bool x86_is_long_mode(CPUState *cpu)
> +{
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
> +    uint64_t efer = env->efer;
> +    uint64_t lme_lma = (MSR_EFER_LME | MSR_EFER_LMA);
> +
> +    return ((efer & lme_lma) == lme_lma);
> +}
> +
> +bool x86_is_long64_mode(CPUState *cpu)
> +{
> +    error_report("unimplemented: is_long64_mode()");
> +    abort();
> +}
> +
> +bool x86_is_paging_mode(CPUState *cpu)
> +{
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
> +    uint64_t cr0 = env->cr[0];
> +
> +    return cr0 & CR0_PG_MASK;
> +}
> +
> +bool x86_is_pae_enabled(CPUState *cpu)
> +{
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
> +    uint64_t cr4 = env->cr[4];
> +
> +    return cr4 & CR4_PAE_MASK;
> +}
> +
> +target_ulong linear_addr(CPUState *cpu, target_ulong addr, X86Seg seg)
> +{
> +    int ret;
> +    target_ulong linear_addr;
> +
> +    ret = linearize(cpu, addr, &linear_addr, seg);
> +    if (ret < 0) {
> +        error_report("failed to linearize address");
> +        abort();
> +    }
> +
> +    return linear_addr;
> +}
> +
> +target_ulong linear_addr_size(CPUState *cpu, target_ulong addr, int size,
> +                              X86Seg seg)
> +{
> +    switch (size) {
> +    case 2:
> +        addr = (uint16_t)addr;
> +        break;
> +    case 4:
> +        addr = (uint32_t)addr;
> +        break;
> +    default:
> +        break;
> +    }
> +    return linear_addr(cpu, addr, seg);
> +}
> +
> +target_ulong linear_rip(CPUState *cpu, target_ulong rip)
> +{
> +    return linear_addr(cpu, rip, R_CS);
> +}
> -- 
> 2.34.1
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

