Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8D2C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 20:33:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7InP-0006Ww-Lw; Thu, 17 Sep 2026 16:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x7InM-0006W6-Px; Thu, 17 Sep 2026 16:33:24 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1x7InH-00043f-Li; Thu, 17 Sep 2026 16:33:24 -0400
Received: from [192.168.10.153] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68HKWmJU079126
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 18 Sep 2026 05:32:48 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Z+I8qDUqdlcK/RDN6POw95TTMdSQWX34RhKsuAE7+X4=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1789677168; v=1;
 b=pu2Ecje+utzBFqMb78h2ST7oEVvjAZK5AE1akLmc73BETUjcQBAUZeQJllT2/0NS
 lpuOZucUSrQkco7o41yPjKjDd9/FmUUsgNSV2zTLSCeZIGiu1vLvl60tq84eS9Ux
 dDRx90TT+AkF+C+xd8L1mc2yj0v+Bk9CfJ/PbktB8w3wM6Ps+AD6xdrzkuLDt7Gl
 lLmBSAOb+7mea6894fC8h10plIQOIT3rmMorYu30Ntkg7BaboEn4hwv1eccwbUAp
 cbuoOCCJHhrfJWb7+SSlVDAQG1VF7Vw3tEe3TQMESWeSxmskylXMULCwucKmvwjI
 VDUihMRLVR8klhdtQJNP0A==
Message-ID: <405a1525-8c2c-4fbe-b7d1-8bbcd384b84c@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 18 Sep 2026 05:32:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v8 01/10] target/arm/emulate: add ISV=0 emulation
 library with load/store immediate
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Lucas Amaral <lucaaamaral@gmail.com>
References: <20260916100021.73825-1-mohamed@unpredictable.fr>
 <20260916100021.73825-2-mohamed@unpredictable.fr>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260916100021.73825-2-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026/09/16 19:00, Mohamed Mediouni wrote:
> From: Lucas Amaral <lucaaamaral@gmail.com>
> 
> Add a shared emulation library for AArch64 load/store instructions that
> cause ISV=0 data aborts under hardware virtualization (HVF, WHPX).
> 
> When the Instruction Syndrome Valid bit is clear, the hypervisor cannot
> determine the faulting instruction's target register or access size from
> the syndrome alone.  This library fetches and decodes the instruction
> using a decodetree-generated decoder, then emulates it by accessing the
> vCPU's register file (CPUARMState) and memory (cpu_memory_rw_debug)
> directly.

Interesting.

> 
> This patch establishes the framework and adds load/store single with
> immediate addressing — the most common ISV=0 trigger.  Subsequent
> patches add register-offset, pair, exclusive, and atomic instructions.
> 
> Instruction coverage:
>    - STR/LDR (GPR): unscaled, post-indexed, unprivileged, pre-indexed,
>      unsigned offset — all sizes (8/16/32/64-bit), sign/zero extension
>    - STR/LDR (SIMD/FP): same addressing modes, 8-128 bit elements
>    - PRFM: prefetch treated as NOP
>    - DC cache maintenance (SYS CRn=C7): NOP on MMIO
> 
> This library uses its own a64-ldst.decode rather than sharing
> target/arm/tcg/a64.decode.  TCG's trans_* functions are a compiler:
> they emit IR ops into a translation block for later execution.  This
> library's trans_* functions are an interpreter: they execute directly
> against the vCPU register file and memory.  The decodetree-generated
> dispatcher calls trans_* by name, so both cannot coexist in the same
> translation unit.  Decode patterns are kept consistent with TCG's
> where possible.
> 
> Decodetree differences from TCG:
>    - &ldst_imm adds a 'u' flag to distinguish 9-bit signed vs 12-bit
>      unsigned immediate forms.  TCG uses %uimm_scaled to pre-scale
>      the unsigned immediate at decode time; here imm:12 is extracted
>      raw and the handler scales it.
> 
> Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
> ---
>   target/arm/emulate/a64-ldst.decode | 129 ++++++++++++++++
>   target/arm/emulate/arm_emulate.c   | 237 +++++++++++++++++++++++++++++
>   target/arm/emulate/arm_emulate.h   |  30 ++++
>   target/arm/emulate/meson.build     |   8 +
>   target/arm/meson.build             |   1 +
>   5 files changed, 405 insertions(+)
>   create mode 100644 target/arm/emulate/a64-ldst.decode
>   create mode 100644 target/arm/emulate/arm_emulate.c
>   create mode 100644 target/arm/emulate/arm_emulate.h
>   create mode 100644 target/arm/emulate/meson.build
> 
> diff --git a/target/arm/emulate/a64-ldst.decode b/target/arm/emulate/a64-ldst.decode
> new file mode 100644
> index 0000000000..c887dcba7d
> --- /dev/null
> +++ b/target/arm/emulate/a64-ldst.decode
> @@ -0,0 +1,129 @@
> +# AArch64 load/store instruction patterns for ISV=0 emulation
> +#
> +# Copyright (c) 2026 Lucas Amaral <lucaaamaral@gmail.com>
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +### Argument sets
> +
> +# Load/store immediate (unscaled, pre/post-index, unprivileged, unsigned offset)
> +# 'u' flag: 0 = 9-bit signed immediate (byte offset), 1 = 12-bit unsigned (needs << sz)
> +&ldst_imm       rt rn imm sz sign w p unpriv ext u
> +
> +### Format templates
> +
> +# Load/store immediate (9-bit signed)
> +@ldst_imm       .. ... . .. .. . imm:s9 .. rn:5 rt:5   &ldst_imm u=0 unpriv=0 p=0 w=0
> +@ldst_imm_pre   .. ... . .. .. . imm:s9 .. rn:5 rt:5   &ldst_imm u=0 unpriv=0 p=0 w=1
> +@ldst_imm_post  .. ... . .. .. . imm:s9 .. rn:5 rt:5   &ldst_imm u=0 unpriv=0 p=1 w=1
> +@ldst_imm_user  .. ... . .. .. . imm:s9 .. rn:5 rt:5   &ldst_imm u=0 unpriv=1 p=0 w=0
> +
> +# Load/store unsigned offset (12-bit, handler scales by << sz)
> +@ldst_uimm      .. ... . .. .. imm:12 rn:5 rt:5        &ldst_imm u=1 unpriv=0 p=0 w=0
> +
> +### Load/store register — unscaled immediate (LDUR/STUR)
> +
> +# GPR
> +STR_i           sz:2 111 0 00 00 0 ......... 00 ..... .....    @ldst_imm sign=0 ext=0
> +LDR_i           00 111 0 00 01 0 ......... 00 ..... .....      @ldst_imm sign=0 ext=1 sz=0
> +LDR_i           01 111 0 00 01 0 ......... 00 ..... .....      @ldst_imm sign=0 ext=1 sz=1
> +LDR_i           10 111 0 00 01 0 ......... 00 ..... .....      @ldst_imm sign=0 ext=1 sz=2
> +LDR_i           11 111 0 00 01 0 ......... 00 ..... .....      @ldst_imm sign=0 ext=0 sz=3
> +LDR_i           00 111 0 00 10 0 ......... 00 ..... .....      @ldst_imm sign=1 ext=0 sz=0
> +LDR_i           01 111 0 00 10 0 ......... 00 ..... .....      @ldst_imm sign=1 ext=0 sz=1
> +LDR_i           10 111 0 00 10 0 ......... 00 ..... .....      @ldst_imm sign=1 ext=0 sz=2
> +LDR_i           00 111 0 00 11 0 ......... 00 ..... .....      @ldst_imm sign=1 ext=1 sz=0
> +LDR_i           01 111 0 00 11 0 ......... 00 ..... .....      @ldst_imm sign=1 ext=1 sz=1
> +
> +# SIMD/FP
> +STR_v_i         sz:2 111 1 00 00 0 ......... 00 ..... .....    @ldst_imm sign=0 ext=0
> +STR_v_i         00 111 1 00 10 0 ......... 00 ..... .....      @ldst_imm sign=0 ext=0 sz=4
> +LDR_v_i         sz:2 111 1 00 01 0 ......... 00 ..... .....    @ldst_imm sign=0 ext=0
> +LDR_v_i         00 111 1 00 11 0 ......... 00 ..... .....      @ldst_imm sign=0 ext=0 sz=4
> +
> +### Load/store register — post-indexed
> +
> +# GPR
> +STR_i           sz:2 111 0 00 00 0 ......... 01 ..... .....    @ldst_imm_post sign=0 ext=0
> +LDR_i           00 111 0 00 01 0 ......... 01 ..... .....      @ldst_imm_post sign=0 ext=1 sz=0
> +LDR_i           01 111 0 00 01 0 ......... 01 ..... .....      @ldst_imm_post sign=0 ext=1 sz=1
> +LDR_i           10 111 0 00 01 0 ......... 01 ..... .....      @ldst_imm_post sign=0 ext=1 sz=2
> +LDR_i           11 111 0 00 01 0 ......... 01 ..... .....      @ldst_imm_post sign=0 ext=0 sz=3
> +LDR_i           00 111 0 00 10 0 ......... 01 ..... .....      @ldst_imm_post sign=1 ext=0 sz=0
> +LDR_i           01 111 0 00 10 0 ......... 01 ..... .....      @ldst_imm_post sign=1 ext=0 sz=1
> +LDR_i           10 111 0 00 10 0 ......... 01 ..... .....      @ldst_imm_post sign=1 ext=0 sz=2
> +LDR_i           00 111 0 00 11 0 ......... 01 ..... .....      @ldst_imm_post sign=1 ext=1 sz=0
> +LDR_i           01 111 0 00 11 0 ......... 01 ..... .....      @ldst_imm_post sign=1 ext=1 sz=1
> +
> +# SIMD/FP
> +STR_v_i         sz:2 111 1 00 00 0 ......... 01 ..... .....    @ldst_imm_post sign=0 ext=0
> +STR_v_i         00 111 1 00 10 0 ......... 01 ..... .....      @ldst_imm_post sign=0 ext=0 sz=4
> +LDR_v_i         sz:2 111 1 00 01 0 ......... 01 ..... .....    @ldst_imm_post sign=0 ext=0
> +LDR_v_i         00 111 1 00 11 0 ......... 01 ..... .....      @ldst_imm_post sign=0 ext=0 sz=4
> +
> +### Load/store register — unprivileged
> +
> +# GPR only (no SIMD/FP unprivileged forms)
> +STR_i           sz:2 111 0 00 00 0 ......... 10 ..... .....    @ldst_imm_user sign=0 ext=0
> +LDR_i           00 111 0 00 01 0 ......... 10 ..... .....      @ldst_imm_user sign=0 ext=1 sz=0
> +LDR_i           01 111 0 00 01 0 ......... 10 ..... .....      @ldst_imm_user sign=0 ext=1 sz=1
> +LDR_i           10 111 0 00 01 0 ......... 10 ..... .....      @ldst_imm_user sign=0 ext=1 sz=2
> +LDR_i           11 111 0 00 01 0 ......... 10 ..... .....      @ldst_imm_user sign=0 ext=0 sz=3
> +LDR_i           00 111 0 00 10 0 ......... 10 ..... .....      @ldst_imm_user sign=1 ext=0 sz=0
> +LDR_i           01 111 0 00 10 0 ......... 10 ..... .....      @ldst_imm_user sign=1 ext=0 sz=1
> +LDR_i           10 111 0 00 10 0 ......... 10 ..... .....      @ldst_imm_user sign=1 ext=0 sz=2
> +LDR_i           00 111 0 00 11 0 ......... 10 ..... .....      @ldst_imm_user sign=1 ext=1 sz=0
> +LDR_i           01 111 0 00 11 0 ......... 10 ..... .....      @ldst_imm_user sign=1 ext=1 sz=1
> +
> +### Load/store register — pre-indexed
> +
> +# GPR
> +STR_i           sz:2 111 0 00 00 0 ......... 11 ..... .....    @ldst_imm_pre sign=0 ext=0
> +LDR_i           00 111 0 00 01 0 ......... 11 ..... .....      @ldst_imm_pre sign=0 ext=1 sz=0
> +LDR_i           01 111 0 00 01 0 ......... 11 ..... .....      @ldst_imm_pre sign=0 ext=1 sz=1
> +LDR_i           10 111 0 00 01 0 ......... 11 ..... .....      @ldst_imm_pre sign=0 ext=1 sz=2
> +LDR_i           11 111 0 00 01 0 ......... 11 ..... .....      @ldst_imm_pre sign=0 ext=0 sz=3
> +LDR_i           00 111 0 00 10 0 ......... 11 ..... .....      @ldst_imm_pre sign=1 ext=0 sz=0
> +LDR_i           01 111 0 00 10 0 ......... 11 ..... .....      @ldst_imm_pre sign=1 ext=0 sz=1
> +LDR_i           10 111 0 00 10 0 ......... 11 ..... .....      @ldst_imm_pre sign=1 ext=0 sz=2
> +LDR_i           00 111 0 00 11 0 ......... 11 ..... .....      @ldst_imm_pre sign=1 ext=1 sz=0
> +LDR_i           01 111 0 00 11 0 ......... 11 ..... .....      @ldst_imm_pre sign=1 ext=1 sz=1
> +
> +# SIMD/FP
> +STR_v_i         sz:2 111 1 00 00 0 ......... 11 ..... .....    @ldst_imm_pre sign=0 ext=0
> +STR_v_i         00 111 1 00 10 0 ......... 11 ..... .....      @ldst_imm_pre sign=0 ext=0 sz=4
> +LDR_v_i         sz:2 111 1 00 01 0 ......... 11 ..... .....    @ldst_imm_pre sign=0 ext=0
> +LDR_v_i         00 111 1 00 11 0 ......... 11 ..... .....      @ldst_imm_pre sign=0 ext=0 sz=4
> +
> +### PRFM — unscaled immediate: prefetch is a NOP
> +
> +NOP             11 111 0 00 10 0 --------- 00 ----- -----
> +
> +### Load/store register — unsigned offset
> +
> +# GPR
> +STR_i           sz:2 111 0 01 00 ............ ..... .....       @ldst_uimm sign=0 ext=0
> +LDR_i           00 111 0 01 01 ............ ..... .....         @ldst_uimm sign=0 ext=1 sz=0
> +LDR_i           01 111 0 01 01 ............ ..... .....         @ldst_uimm sign=0 ext=1 sz=1
> +LDR_i           10 111 0 01 01 ............ ..... .....         @ldst_uimm sign=0 ext=1 sz=2
> +LDR_i           11 111 0 01 01 ............ ..... .....         @ldst_uimm sign=0 ext=0 sz=3
> +LDR_i           00 111 0 01 10 ............ ..... .....         @ldst_uimm sign=1 ext=0 sz=0
> +LDR_i           01 111 0 01 10 ............ ..... .....         @ldst_uimm sign=1 ext=0 sz=1
> +LDR_i           10 111 0 01 10 ............ ..... .....         @ldst_uimm sign=1 ext=0 sz=2
> +LDR_i           00 111 0 01 11 ............ ..... .....         @ldst_uimm sign=1 ext=1 sz=0
> +LDR_i           01 111 0 01 11 ............ ..... .....         @ldst_uimm sign=1 ext=1 sz=1
> +
> +# PRFM — unsigned offset
> +NOP             11 111 0 01 10 ------------ ----- -----
> +
> +# SIMD/FP
> +STR_v_i         sz:2 111 1 01 00 ............ ..... .....       @ldst_uimm sign=0 ext=0
> +STR_v_i         00 111 1 01 10 ............ ..... .....         @ldst_uimm sign=0 ext=0 sz=4
> +LDR_v_i         sz:2 111 1 01 01 ............ ..... .....       @ldst_uimm sign=0 ext=0
> +LDR_v_i         00 111 1 01 11 ............ ..... .....         @ldst_uimm sign=0 ext=0 sz=4
> +
> +### System instructions — DC cache maintenance
> +
> +# SYS with CRn=C7 covers all data cache operations (DC CIVAC, CVAC, etc.).
> +# On MMIO regions, cache maintenance is a harmless no-op.
> +NOP             1101 0101 0000 1 --- 0111 ---- --- -----

The cache-maintenance wildcard silently discards DC ZVA, the Data Cache 
Zero by Address instruction. It matches e.g., dc zva,x2; trans_NOP() 
then reports success without memory access. A stage-2 fault while 
zeroing MMIO mapped as Normal memory reaches this path with CM=0, and 
callers advance PC without performing the zeros. At minimum this must 
remain unhandled unless implemented correctly. ARM ARM DDI0487L.a 
C5.3.32, printed pp C5-996–997, explicitly specifies CM=0, byte stores, 
and an alignment fault for Device memory.

> diff --git a/target/arm/emulate/arm_emulate.c b/target/arm/emulate/arm_emulate.c
> new file mode 100644
> index 0000000000..02fefc30bf
> --- /dev/null
> +++ b/target/arm/emulate/arm_emulate.c
> @@ -0,0 +1,237 @@
> +/*
> + * AArch64 instruction emulation for ISV=0 data aborts
> + *
> + * Copyright (c) 2026 Lucas Amaral <lucaaamaral@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "arm_emulate.h"
> +#include "target/arm/cpu.h"
> +#include "exec/cpu-common.h"
> +#include "exec/target_page.h"
> +
> +/* TODO: assumes LE guest data layout (sufficient for HVF/WHPX, both LE-only) */
> +
> +/* Named "DisasContext" as required by the decodetree code generator */
> +typedef struct {
> +    CPUState *cpu;
> +    CPUARMState *env;
> +    ArmEmulResult result;
> +} DisasContext;
> +
> +#include "decode-a64-ldst.c.inc"
> +
> +/* GPR data access (Rt, Rs, Rt2) -- register 31 = XZR */
> +
> +static uint64_t gpr_read(DisasContext *ctx, int reg)
> +{
> +    if (reg == 31) {
> +        return 0;  /* XZR */
> +    }
> +    return ctx->env->xregs[reg];
> +}
> +
> +static void gpr_write(DisasContext *ctx, int reg, uint64_t val)
> +{
> +    if (reg == 31) {
> +        return;  /* XZR -- discard */
> +    }
> +    ctx->env->xregs[reg] = val;
> +    ctx->cpu->vcpu_dirty = true;
> +}
> +
> +/* Base register access (Rn) -- register 31 = SP */
> +
> +static uint64_t base_read(DisasContext *ctx, int rn)
> +{
> +    return ctx->env->xregs[rn];
> +}
> +
> +static void base_write(DisasContext *ctx, int rn, uint64_t val)
> +{
> +    ctx->env->xregs[rn] = val;
> +    ctx->cpu->vcpu_dirty = true;
> +}
> +
> +/* SIMD/FP register access */
> +
> +static void fpreg_read(DisasContext *ctx, int reg, void *buf, int size)
> +{
> +    memcpy(buf, &ctx->env->vfp.zregs[reg], size);
> +}
> +
> +static void fpreg_write(DisasContext *ctx, int reg, const void *buf, int size)
> +{
> +    memset(&ctx->env->vfp.zregs[reg], 0, sizeof(ctx->env->vfp.zregs[reg]));
> +    memcpy(&ctx->env->vfp.zregs[reg], buf, size);
> +    ctx->cpu->vcpu_dirty = true;
> +}
> +
> +/* Memory access wrappers */
> +
> +static int mem_read(DisasContext *ctx, uint64_t va, void *buf, int size)
> +{
> +    if (((va & ~TARGET_PAGE_MASK) + size) > TARGET_PAGE_SIZE) {

This and the corresponding write guard rejects valid accesses crossing a 
4 KiB boundary.

With patch 3, ldp x0,x1,[x2] at x2=0xff8 demonstrates this for an 
aligned pair—even wholly inside a guest’s 16 KiB page. 
cpu_memory_rw_debug() already processes accesses in translated chunks. 
ARM ARM DDI0487L.a B2.8.2 and B2.8.2.1.1 explicitly define pair 
alignment using the individual element size.

Regards,
Akihiko Odaki

> +        ctx->result = ARM_EMUL_ERR_MEM;
> +        return -1;
> +    }
> +    int ret = cpu_memory_rw_debug(ctx->cpu, va, buf, size, false);
> +    if (ret != 0) {
> +        ctx->result = ARM_EMUL_ERR_MEM;
> +    }
> +    return ret;
> +}
> +
> +static int mem_write(DisasContext *ctx, uint64_t va, const void *buf, int size)
> +{
> +    if (((va & ~TARGET_PAGE_MASK) + size) > TARGET_PAGE_SIZE) {
> +        ctx->result = ARM_EMUL_ERR_MEM;
> +        return -1;
> +    }
> +    int ret = cpu_memory_rw_debug(ctx->cpu, va, (void *)buf, size, true);
> +    if (ret != 0) {
> +        ctx->result = ARM_EMUL_ERR_MEM;
> +    }
> +    return ret;
> +}
> +
> +/* Sign/zero extension helpers */
> +
> +static uint64_t sign_extend(uint64_t val, int from_bits)
> +{
> +    int shift = 64 - from_bits;
> +    return (int64_t)(val << shift) >> shift;
> +}
> +
> +/* Apply sign/zero extension */
> +static uint64_t load_extend(uint64_t val, int sz, int sign, int ext)
> +{
> +    int data_bits = 8 << sz;
> +
> +    if (sign) {
> +        val = sign_extend(val, data_bits);
> +        if (ext) {
> +            /* Sign-extend to 32 bits (W register) */
> +            val &= 0xFFFFFFFF;
> +        }
> +    } else if (ext) {
> +        /* Zero-extend to 32 bits (W register) */
> +        val &= 0xFFFFFFFF;
> +    }
> +    return val;
> +}
> +
> +/* Load/store single -- immediate (GPR) (DDI 0487 C3.3.8 -- C3.3.13) */
> +
> +static bool trans_STR_i(DisasContext *ctx, arg_ldst_imm *a)
> +{
> +    int esize = (a->sz <= 3) ? (1 << a->sz) : 16;
> +    int64_t offset = a->u ? ((int64_t)(uint64_t)a->imm << a->sz)
> +                          : (int64_t)a->imm;
> +    uint64_t base = base_read(ctx, a->rn);
> +    uint64_t va = a->p ? base : base + offset;
> +
> +    uint64_t val = gpr_read(ctx, a->rt);
> +    if (mem_write(ctx, va, &val, esize) != 0) {
> +        return true;
> +    }
> +
> +    if (a->w) {
> +        base_write(ctx, a->rn, base + offset);
> +    }
> +    return true;
> +}
> +
> +static bool trans_LDR_i(DisasContext *ctx, arg_ldst_imm *a)
> +{
> +    int esize = (a->sz <= 3) ? (1 << a->sz) : 16;
> +    int64_t offset = a->u ? ((int64_t)(uint64_t)a->imm << a->sz)
> +                          : (int64_t)a->imm;
> +    uint64_t base = base_read(ctx, a->rn);
> +    uint64_t va = a->p ? base : base + offset;
> +    uint64_t val = 0;
> +
> +    if (mem_read(ctx, va, &val, esize) != 0) {
> +        return true;
> +    }
> +
> +    val = load_extend(val, a->sz, a->sign, a->ext);
> +    gpr_write(ctx, a->rt, val);
> +
> +    if (a->w) {
> +        base_write(ctx, a->rn, base + offset);
> +    }
> +    return true;
> +}
> +
> +/*
> + * Load/store single -- immediate (SIMD/FP)
> + * STR_v_i / LDR_v_i (DDI 0487 C3.3.10)
> + */
> +
> +static bool trans_STR_v_i(DisasContext *ctx, arg_ldst_imm *a)
> +{
> +    int esize = (a->sz <= 3) ? (1 << a->sz) : 16;
> +    int64_t offset = a->u ? ((int64_t)(uint64_t)a->imm << a->sz)
> +                          : (int64_t)a->imm;
> +    uint64_t base = base_read(ctx, a->rn);
> +    uint64_t va = a->p ? base : base + offset;
> +    uint8_t buf[16];
> +
> +    fpreg_read(ctx, a->rt, buf, esize);
> +    if (mem_write(ctx, va, buf, esize) != 0) {
> +        return true;
> +    }
> +
> +    if (a->w) {
> +        base_write(ctx, a->rn, base + offset);
> +    }
> +    return true;
> +}
> +
> +static bool trans_LDR_v_i(DisasContext *ctx, arg_ldst_imm *a)
> +{
> +    int esize = (a->sz <= 3) ? (1 << a->sz) : 16;
> +    int64_t offset = a->u ? ((int64_t)(uint64_t)a->imm << a->sz)
> +                          : (int64_t)a->imm;
> +    uint64_t base = base_read(ctx, a->rn);
> +    uint64_t va = a->p ? base : base + offset;
> +    uint8_t buf[16];
> +
> +    if (mem_read(ctx, va, buf, esize) != 0) {
> +        return true;
> +    }
> +
> +    fpreg_write(ctx, a->rt, buf, esize);
> +
> +    if (a->w) {
> +        base_write(ctx, a->rn, base + offset);
> +    }
> +    return true;
> +}
> +
> +/* PRFM, DC cache maintenance -- treated as NOP */
> +static bool trans_NOP(DisasContext *ctx, arg_NOP *a)
> +{
> +    (void)ctx;
> +    (void)a;
> +    return true;
> +}
> +
> +/* Entry point */
> +
> +ArmEmulResult arm_emul_insn(CPUArchState *env, uint32_t insn)
> +{
> +    DisasContext ctx = {
> +        .cpu = env_cpu(env),
> +        .env = env,
> +        .result = ARM_EMUL_OK,
> +    };
> +
> +    if (!decode_a64_ldst(&ctx, insn)) {
> +        return ARM_EMUL_UNHANDLED;
> +    }
> +
> +    return ctx.result;
> +}
> diff --git a/target/arm/emulate/arm_emulate.h b/target/arm/emulate/arm_emulate.h
> new file mode 100644
> index 0000000000..7fe298394f
> --- /dev/null
> +++ b/target/arm/emulate/arm_emulate.h
> @@ -0,0 +1,30 @@
> +/*
> + * AArch64 instruction emulation library
> + *
> + * Copyright (c) 2026 Lucas Amaral <lucaaamaral@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef ARM_EMULATE_H
> +#define ARM_EMULATE_H
> +
> +#include "qemu/osdep.h"
> +
> +/**
> + * ArmEmulResult - return status from arm_emul_insn()
> + */
> +typedef enum {
> +    ARM_EMUL_OK,         /* Instruction emulated successfully */
> +    ARM_EMUL_UNHANDLED,  /* Instruction not recognized by decoder */
> +    ARM_EMUL_ERR_MEM,    /* Memory access failed */
> +} ArmEmulResult;
> +
> +/**
> + * arm_emul_insn - decode and emulate one AArch64 instruction
> + *
> + * Caller must synchronize CPU state and fetch @insn before calling.
> + */
> +ArmEmulResult arm_emul_insn(CPUArchState *env, uint32_t insn);
> +
> +#endif /* ARM_EMULATE_H */
> diff --git a/target/arm/emulate/meson.build b/target/arm/emulate/meson.build
> new file mode 100644
> index 0000000000..e5455bd206
> --- /dev/null
> +++ b/target/arm/emulate/meson.build
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +gen_a64_ldst = decodetree.process('a64-ldst.decode',
> +    extra_args: ['--static-decode=decode_a64_ldst'])
> +
> +arm_common_system_ss.add(when: 'TARGET_AARCH64', if_true: [
> +    gen_a64_ldst, files('arm_emulate.c')
> +])
> diff --git a/target/arm/meson.build b/target/arm/meson.build
> index 0369f96b4c..1963c0ec21 100644
> --- a/target/arm/meson.build
> +++ b/target/arm/meson.build
> @@ -61,6 +61,7 @@ arm_common_system_ss.add(files(
>     'ptw.c',
>   ))
>   
> +subdir('emulate')
>   subdir('hvf')
>   subdir('whpx')
>   


