Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AF3606A32A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=NtXDLK5P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUPNR-0001wr-Np; Fri, 20 Nov 2026 09:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xUPNP-0001wG-5u; Fri, 20 Nov 2026 09:14:07 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xUPNM-00015h-LG; Fri, 20 Nov 2026 09:14:06 -0500
Received: from example.com (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id 06F5F20B7166;
 Fri, 20 Nov 2026 06:13:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 06F5F20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1795184040;
 bh=79dthtpfs5AW3i9gHD5s59W4rTW4Y+syAm2p7hWih20=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NtXDLK5PzE4UwMSzDL/GVhIMPFiFS7Rgannbuc0WNtq+9LCTYjaildY+VCGxOJWrd
 0SPy+b9YXe1Eezn7f5RSorOg389wTVb5Dl4RdmRYsdc7Xf9JGmTDHFYDqmvnD3Qu5S
 OnSb1p1LLmpk3vQkNkkcFRg1nmFgzDE0Qay1pX1M=
Date: Fri, 20 Nov 2026 15:13:56 +0100
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Aastha Rawat <aastharawat@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anirudh Rayabharam <anirudh@anirudhrb.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v6 10/14] target/arm: extract MMIO emulation logic for
 HVF & WHPX
Message-ID: <awBVpDKOg8wO6vbh@example.com>
References: <20261001-mshv_accel_arm64_supp-v6-0-aefe5e76a0e3@linux.microsoft.com>
 <20261001-mshv_accel_arm64_supp-v6-10-aefe5e76a0e3@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-mshv_accel_arm64_supp-v6-10-aefe5e76a0e3@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 01, 2026 at 10:52:55AM +0000, Aastha Rawat wrote:
> - Move common MMIO emulation code from HVF and WHPX backend to
>   arm_emulate_mmio() in helper.c.
> - Update HVF and WHPX to use the new helper and shared types.
> 

Generally, this is a patch with some potential for undesired fallout
and we need testing on the consolidated platforms (WHPX and HVF)
and/or close scrutiny from the maintainers. Maybe we can send this
one as an individual patch?

> Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
> ---
>  target/arm/helper.c        | 62 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/arm/helper.h        | 16 ++++++++++++
>  target/arm/hvf/hvf.c       | 57 +++++++++++++++++++-----------------------
>  target/arm/syndrome.h      | 47 +++++++++++++++++++++++++++++++++++
>  target/arm/whpx/whpx-all.c | 45 ++++++++++++++-------------------
>  5 files changed, 169 insertions(+), 58 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index ff0b766b73d..5b14f0bff72 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -34,6 +34,8 @@
>  #endif
>  #include "cpregs.h"
>  #include "target/arm/gtimer.h"
> +#include "target/arm/helper.h"

This will introduce a dependency on TCG, which might be undesirable:

target/arm/helper.h -> exec->helper-gen.h.inc -> tcg/tcg.h

> +#include "target/arm/syndrome.h"
>  #include "qemu/plugin.h"
>  
>  static void switch_mode(CPUARMState *env, int mode);
> @@ -9455,6 +9457,66 @@ static void arm_cpu_do_interrupt_aarch32(CPUState *cs)
>      take_aarch32_exception(env, new_mode, mask, offset, addr);
>  }
>  
> +/*
> + * Emulate a data abort syndrome for MMIO/guest memory access
> + */
> +int arm_emulate_mmio(CPUState *cpu, EsrEl2 syndrome, uint64_t gpa,
> +                     const struct arm_emul_ops *ops)
> +{
> +    int ret;
> +    IssDataAbort iss = { 0 };
> +    iss.raw = syndrome.iss;
> +
> +    if (!(syndrome.ec == data_abort_lower || syndrome.ec == data_abort)) {
> +        error_report("Unknown exception class 0x%x", syndrome.ec);
> +        return -1;
> +    }
> +
> +    if (!iss.isv) {
> +        error_report("Cannot emulate MMIO. ISS not valid.");
> +        return -1;
> +    }
> +
> +    AddressSpace *as = cpu_get_address_space(cpu, ARMASIdx_NS);

in this patch we have a lot of variable declerations outside of blocks/
fn top.

> +    uint64_t len = 1ULL << iss.sas;
> +    bool sign_extend = iss.sse;
> +    uint64_t reg_index = iss.srt;
> +
> +    if (iss.wnr) {
> +        uint8_t data[8];
> +        uint64_t val = reg_index < 31 ? ops->get_reg(cpu, reg_index) : 0ULL;
> +        val = cpu_to_le64(val);
> +        memcpy(data, &val, sizeof(val));
> +        ret = address_space_write(as, gpa, MEMTXATTRS_UNSPECIFIED, data, len);
> +        if (ret != MEMTX_OK) {
> +            error_report("Failed to write guest memory");
> +            return -1;
> +        }
> +    } else {
> +        uint8_t data[8] = { 0 };
> +        ret = address_space_read(as, gpa, MEMTXATTRS_UNSPECIFIED, data, len);
> +        if (ret != MEMTX_OK) {
> +            error_report("Failed to read guest memory");
> +            return -1;
> +        }
> +        uint64_t val;
> +        memcpy(&val, data, sizeof(val));
> +        val = le64_to_cpu(val);
> +        if (sign_extend) {
> +            uint64_t shift = 64 - (len * 8);
> +            val = (((int64_t)val << shift) >> shift);
> +        }
> +        if (!iss.sf) {
> +            val &= 0xffffffff;
> +        }
> +        if (reg_index < 31) {
> +            ops->set_reg(cpu, reg_index, val);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>  static int aarch64_regnum(CPUARMState *env, int aarch32_reg)
>  {
>      /*
> diff --git a/target/arm/helper.h b/target/arm/helper.h
> index b1c26c180ea..503404112d4 100644
> --- a/target/arm/helper.h
> +++ b/target/arm/helper.h
> @@ -3,8 +3,24 @@
>  #ifndef HELPER__H
>  #define HELPER__H
>  
> +#include <stdint.h>
> +#include <stdbool.h>
>  #include "exec/helper-proto-common.h"
>  #include "exec/helper-gen-common.h"
> +#include "target/arm/syndrome.h"
> +
> +/*
> + * Callback ops for per-register access during MMIO emulation.
> + * Each hypervisor backend provides its own implementation to avoid
> + * syncing the full CPU state for a single-register MMIO access.
> + */
> +struct arm_emul_ops {
> +    uint64_t (*get_reg)(CPUState *cpu, int reg);
> +    void (*set_reg)(CPUState *cpu, int reg, uint64_t val);
> +};
> +
> +int arm_emulate_mmio(CPUState *cpu, EsrEl2 syndrome, uint64_t gpa,
> +                     const struct arm_emul_ops *ops);
>  
>  #define HELPER_H "tcg/helper-defs.h"
>  #include "exec/helper-proto.h.inc"
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index b00a7e1a845..99a66a68812 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -13,6 +13,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/log.h"
>  
> +#include "syndrome.h"
>  #include "system/runstate.h"
>  #include "system/hvf.h"
>  #include "system/hvf_int.h"
> @@ -37,6 +38,7 @@
>  #include "target/arm/multiprocessing.h"
>  #include "target/arm/gtimer.h"
>  #include "target/arm/trace.h"
> +#include "target/arm/helper.h"
>  #include "trace.h"
>  #include "migration/vmstate.h"
>  
> @@ -2338,12 +2340,15 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
>  {
>      CPUARMState *env = cpu_env(cpu);
>      ARMCPU *arm_cpu = env_archcpu(env);
> -    uint64_t syndrome = excp->syndrome;
> -    uint32_t ec = syn_get_ec(syndrome);
> +    uint64_t syndrome;
> +    uint32_t ec;
>      bool advance_pc = false;
>      hv_return_t r;
>      int ret = 0;
>  
> +    syndrome = excp->syndrome;
> +    ec = syn_get_ec(syndrome);
> +
>      switch (ec) {
>      case EC_SOFTWARESTEP: {
>          ret = EXCP_DEBUG;
> @@ -2389,29 +2394,22 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
>          break;
>      }
>      case EC_DATAABORT: {
> -        bool isv = FIELD_EX32(syndrome, DABORT_ISS, ISV);
> -        bool iswrite = FIELD_EX32(syndrome, DABORT_ISS, WNR);
> -        bool s1ptw = FIELD_EX32(syndrome, DABORT_ISS, S1PTW);
> -        bool sse = FIELD_EX32(syndrome, DABORT_ISS, SSE);
> -        uint32_t sas = FIELD_EX32(syndrome, DABORT_ISS, SAS);
> -        uint32_t len = 1 << sas;
> -        uint32_t srt = FIELD_EX32(syndrome, DABORT_ISS, SRT);
> -        uint32_t cm = FIELD_EX32(syndrome, DABORT_ISS, CM);
> -        uint64_t val = 0;
> +        EsrEl2 esr_el2 = { .raw = syndrome };
> +        IssDataAbort iss = { .raw = esr_el2.iss };
>          uint64_t ipa = excp->physical_address;
>          AddressSpace *as = cpu_get_address_space(cpu, ARMASIdx_NS);
>  
> -        trace_hvf_data_abort(excp->virtual_address, ipa, isv,
> -                             iswrite, s1ptw, len, srt);
> +        trace_hvf_data_abort(excp->virtual_address, ipa, iss.isv,
> +                             iss.wnr, iss.s1ptw, 1ULL << iss.sas, iss.srt);
>  
> -        if (cm) {
> +        if (iss.cm) {
>              /* We don't cache MMIO regions */
>              advance_pc = true;
>              break;
>          }
>  
>          /* Handle dirty page logging for ram. */
> -        if (iswrite) {
> +        if (iss.wnr) {
>              hwaddr xlat;
>              MemoryRegion *mr = address_space_translate(as, ipa, &xlat,
>                                                         NULL, true,
> @@ -2438,28 +2436,25 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
>           * TODO: If s1ptw, this is an error in the guest os page tables.
>           * Inject the exception into the guest.
>           */
> -        assert(!s1ptw);
> -
> -        /*
> -         * TODO: ISV will be 0 for SIMD or SVE accesses.
> -         * Inject the exception into the guest.
> -         */
> -        assert(isv);
> +        assert(!iss.s1ptw);
>  
>          /*
>           * Emulate MMIO.
>           * TODO: Inject faults for errors.
>           */
> -        if (iswrite) {
> -            val = hvf_get_reg(cpu, srt);
> -            address_space_write(as, ipa, MEMTXATTRS_UNSPECIFIED, &val, len);
> -        } else {
> -            address_space_read(as, ipa, MEMTXATTRS_UNSPECIFIED, &val, len);
> -            if (sse) {
> -                val = sextract64(val, 0, len * 8);
> -            }
> -            hvf_set_reg(cpu, srt, val);
> +
> +        static const struct arm_emul_ops hvf_arm_emul_ops = {
> +            .get_reg = hvf_get_reg,
> +            .set_reg = hvf_set_reg,
> +        };
> +
> +        ret = arm_emulate_mmio(cpu, esr_el2, ipa, &hvf_arm_emul_ops);
> +        if (ret < 0) {
> +            error_report("Failed to emulate MMIO, syndrome=0x%llx, gpa=0x%llx",
> +                         esr_el2.raw, ipa);
> +            return -1;

I think this introduces a subtle behaviour change for HVF. we return -1
here, and do not advance the PC. I think MMIO emulation can fail e.g.
for probes (non x86 UEFI we see this with TPM afair).

>          }
> +
>          advance_pc = true;
>          break;
>      }
> diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
> index 2a6fa903f27..8b4cc7f7b21 100644
> --- a/target/arm/syndrome.h
> +++ b/target/arm/syndrome.h
> @@ -106,6 +106,53 @@ typedef enum {
>      GCS_IT_GCSPOPX = 9,
>  } GCSInstructionType;
>  
> +typedef union {
> +    uint64_t raw;
> +    struct {
> +        uint32_t iss:25;
> +        uint32_t il:1;
> +        uint32_t ec:6;
> +        uint32_t iss2:5;
> +        uint32_t _rsvd:27;
> +    } QEMU_PACKED;
> +} EsrEl2;
> +
> +typedef union {
> +    uint32_t raw;
> +    struct {
> +        uint32_t dfsc:6;
> +        uint32_t wnr:1;
> +        uint32_t s1ptw:1;
> +        uint32_t cm:1;
> +        uint32_t ea:1;
> +        uint32_t fnv:1;
> +        uint32_t set:2;
> +        uint32_t vncr:1;
> +        uint32_t ar:1;
> +        uint32_t sf:1;
> +        uint32_t srt:5;
> +        uint32_t sse:1;
> +        uint32_t sas:2;
> +        uint32_t isv:1;
> +        uint32_t _unused:7;
> +    } QEMU_PACKED;
> +} IssDataAbort;
> +
> +typedef enum {
> +    data_abort_lower = 36,
> +    data_abort = 37,
> +} ExceptionClass;
> +
> +#define ARM_EL_EC_LENGTH 6
> +#define ARM_EL_EC_SHIFT 26
> +#define ARM_EL_IL_SHIFT 25
> +#define ARM_EL_ISV_SHIFT 24
> +#define ARM_EL_IL (1 << ARM_EL_IL_SHIFT)
> +#define ARM_EL_ISV (1 << ARM_EL_ISV_SHIFT)
> +
> +/* In the Data Abort syndrome */
> +#define ARM_EL_VNCR (1 << 13)
> +
>  static inline uint32_t syn_get_ec(uint32_t syn)
>  {
>      return FIELD_EX32(syn, SYNDROME, EC);
> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
> index 46f0b9524e0..93d89f79ffe 100644
> --- a/target/arm/whpx/whpx-all.c
> +++ b/target/arm/whpx/whpx-all.c
> @@ -28,6 +28,8 @@
>  
>  #include "syndrome.h"
>  #include "target/arm/cpregs.h"
> +#include "target/arm/helper.h"
> +#include "target/arm/syndrome.h"
>  #include "internals.h"
>  
>  #include "system/whpx-internal.h"
> @@ -352,34 +354,23 @@ static void whpx_set_gp_reg(CPUState *cpu, int rt, uint64_t val)
>  
>  static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
>  {
> -    uint64_t syndrome = ctx->Syndrome;
> -
> -    bool isv = FIELD_EX32(syndrome, DABORT_ISS, ISV);
> -    bool iswrite = FIELD_EX32(syndrome, DABORT_ISS, WNR);
> -    bool sse = FIELD_EX32(syndrome, DABORT_ISS, SSE);
> -    uint32_t sas = FIELD_EX32(syndrome, DABORT_ISS, SAS);
> -    uint32_t len = 1 << sas;
> -    uint32_t srt = FIELD_EX32(syndrome, DABORT_ISS, SRT);
> -    uint32_t cm = FIELD_EX32(syndrome, DABORT_ISS, CM);
> -    uint64_t val = 0;
> -
> -    assert(syn_get_ec(syndrome) == EC_DATAABORT);
> +    int ret = 0;
> +    EsrEl2 esr = { .raw = ctx->Syndrome };
> +    uint32_t cm = (esr.iss >> 8) & 0x1;
> +
> +    assert(syn_get_ec(esr.raw) == EC_DATAABORT);
>      assert(!cm);
> -    assert(isv);
> -
> -    if (iswrite) {
> -        val = whpx_get_gp_reg(cpu, srt);
> -        address_space_write(&address_space_memory,
> -                            ctx->Gpa,
> -                            MEMTXATTRS_UNSPECIFIED, &val, len);
> -    } else {
> -        address_space_read(&address_space_memory,
> -                           ctx->Gpa,
> -                           MEMTXATTRS_UNSPECIFIED, &val, len);
> -        if (sse) {
> -            val = sextract64(val, 0, len * 8);
> -        }
> -        whpx_set_gp_reg(cpu, srt, val);
> +
> +    static const struct arm_emul_ops whpx_arm_emul_ops = {
> +        .get_reg = whpx_get_gp_reg,
> +        .set_reg = whpx_set_gp_reg,
> +    };
> +
> +    ret = arm_emulate_mmio(cpu, esr, ctx->Gpa, &whpx_arm_emul_ops);
> +    if (ret < 0) {
> +        error_report("WHPX: Failed to handle MMIO, syndrome=0x%llx, gpa=0x%llx",
> +                     esr.raw, ctx->Gpa);
> +        return -1;
>      }
>  
>      return 0;
> 
> -- 
> 2.45.4

