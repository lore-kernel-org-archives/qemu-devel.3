Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C19B606A33C
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=TCss5Gea
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU2OH-0000CE-BR; Thu, 19 Nov 2026 08:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xU2OC-0000BY-A8; Thu, 19 Nov 2026 08:41:24 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xU2O9-0006Oo-Vo; Thu, 19 Nov 2026 08:41:24 -0500
Received: from example.com (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id 5608320B7169;
 Thu, 19 Nov 2026 05:41:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5608320B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1795095675;
 bh=kSP667k5nEQUvRwVG/nGw2/6F04cmTOdSKQVTNp7/Ro=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TCss5Gea8WG8Zw2ymTTltyzlfaEWH9axC5dxJ7yNIVi8zNpA6GaU5nOELVOkxYoHT
 3iH1vEaFA1xDG4g0i2RaWfxCD5i5UOJ5Kmu22ukCJIX2l3kdqt71+Ej94XHzU7hyD8
 fi/qpTSxIe/DlMRss0+zHw7kUpTh0cmYjXjx3SqY=
Date: Thu, 19 Nov 2026 14:41:11 +0100
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
Subject: Re: [PATCH v6 01/14] accel/mshv: extract common CPU register helpers
Message-ID: <av78d3TLGnB94nZM@example.com>
References: <20261001-mshv_accel_arm64_supp-v6-0-aefe5e76a0e3@linux.microsoft.com>
 <20261001-mshv_accel_arm64_supp-v6-1-aefe5e76a0e3@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001-mshv_accel_arm64_supp-v6-1-aefe5e76a0e3@linux.microsoft.com>
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

On Thu, Oct 01, 2026 at 10:52:46AM +0000, Aastha Rawat wrote:
> Move arch-independent MSHV CPU register handling functions into
> accel/mshv/mshv-cpu-common.c. Update x86 MSHV backends to use these
> shared helpers.
> 
> Prefix get_generic_regs() with mshv_ for proper namespacing since it
> is now public.
> 
> Signed-off-by: Aastha Rawat <aastharawat@linux.microsoft.com>
> ---
>  accel/mshv/meson.build       |   3 +-
>  accel/mshv/mshv-cpu-common.c | 151 +++++++++++++++++++++++++++++++++++++++++++
>  include/system/mshv_int.h    |   1 +
>  target/i386/mshv/mshv-cpu.c  | 125 +----------------------------------
>  4 files changed, 155 insertions(+), 125 deletions(-)
> 
> diff --git a/accel/mshv/meson.build b/accel/mshv/meson.build
> index e433187cde0..ebe32921b3d 100644
> --- a/accel/mshv/meson.build
> +++ b/accel/mshv/meson.build
> @@ -1,5 +1,6 @@
>  system_ss.add(when: 'CONFIG_MSHV', if_true: files(
>    'irq.c',
>    'mem.c',
> -  'mshv-all.c'
> +  'mshv-all.c',
> +  'mshv-cpu-common.c'
>  ))
> diff --git a/accel/mshv/mshv-cpu-common.c b/accel/mshv/mshv-cpu-common.c
> new file mode 100644
> index 00000000000..e8ef34689e3
> --- /dev/null
> +++ b/accel/mshv/mshv-cpu-common.c
> @@ -0,0 +1,151 @@
> +/*
> + * QEMU MSHV common CPU register helpers
> + *
> + * Copyright Microsoft, Corp. 2026
> + *
> + * Authors: Ziqiao Zhou   <ziqiaozhou@microsoft.com>
> + *          Magnus Kulke  <magnuskulke@microsoft.com>
> + *          Jinank Jain   <jinankjain@microsoft.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include "qemu/osdep.h"
> +#include "qemu/error-report.h"
> +#include "qemu/memalign.h"
> +
> +#include "system/mshv.h"
> +#include "linux/mshv.h"
> +#include "system/mshv_int.h"
> +
> +#include "hw/core/cpu.h"
> +
> +#include <sys/ioctl.h>
> +
> +int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
> +                          size_t n_regs)
> +{
> +    int cpu_fd = mshv_vcpufd(cpu);
> +    int vp_index = cpu->cpu_index;
> +    size_t in_sz, assocs_sz;
> +    hv_input_set_vp_registers *in = cpu->accel->hvcall_args.input_page;
> +    struct mshv_root_hvcall args = {0};
> +    int ret;
> +
> +    /* find out the size of the struct w/ a flexible array at the tail */
> +    assocs_sz = n_regs * sizeof(hv_register_assoc);
> +    in_sz = sizeof(hv_input_set_vp_registers) + assocs_sz;
> +
> +    /* fill the input struct */
> +    memset(in, 0, sizeof(hv_input_set_vp_registers));
> +    in->vp_index = vp_index;
> +    memcpy(in->elements, assocs, assocs_sz);
> +
> +    /* create the hvcall envelope */
> +    args.code = HVCALL_SET_VP_REGISTERS;
> +    args.in_sz = in_sz;
> +    args.in_ptr = (uint64_t) in;
> +    args.reps = (uint16_t) n_regs;
> +
> +    /* perform the call */
> +    ret = mshv_hvcall(cpu_fd, &args);
> +    if (ret < 0) {
> +        error_report("Failed to set registers");
> +        return -1;
> +    }
> +
> +    /* assert we set all registers */
> +    if (args.reps != n_regs) {
> +        error_report("Failed to set registers: expected %zu elements"
> +                     ", got %u", n_regs, args.reps);
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +int mshv_get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
> +                            size_t n_regs)
> +{
> +    int cpu_fd = mshv_vcpufd(cpu);
> +    int vp_index = cpu->cpu_index;
> +    hv_input_get_vp_registers *in = cpu->accel->hvcall_args.input_page;
> +    hv_register_value *values = cpu->accel->hvcall_args.output_page;
> +    size_t in_sz, names_sz, values_sz;
> +    int i, ret;
> +    struct mshv_root_hvcall args = {0};
> +
> +    /* find out the size of the struct w/ a flexible array at the tail */
> +    names_sz = n_regs * sizeof(hv_register_name);
> +    in_sz = sizeof(hv_input_get_vp_registers) + names_sz;
> +
> +    /* fill the input struct */
> +    memset(in, 0, sizeof(hv_input_get_vp_registers));
> +    in->vp_index = vp_index;
> +    for (i = 0; i < n_regs; i++) {
> +        in->names[i] = assocs[i].name;
> +    }
> +
> +    /* determine size of value output buffer */
> +    values_sz = n_regs * sizeof(union hv_register_value);
> +
> +    /* create the hvcall envelope */
> +    args.code = HVCALL_GET_VP_REGISTERS;
> +    args.in_sz = in_sz;
> +    args.in_ptr = (uint64_t) in;
> +    args.out_sz = values_sz;
> +    args.out_ptr = (uint64_t) values;
> +    args.reps = (uint16_t) n_regs;
> +
> +    /* perform the call */
> +    ret = mshv_hvcall(cpu_fd, &args);
> +    if (ret < 0) {
> +        error_report("Failed to retrieve registers");
> +        return -1;
> +    }
> +
> +    /* assert we got all registers */
> +    if (args.reps != n_regs) {
> +        error_report("Failed to retrieve registers: expected %zu elements"
> +                     ", got %u", n_regs, args.reps);
> +        return -1;
> +    }
> +
> +    /* copy values into assoc */
> +    for (i = 0; i < n_regs; i++) {
> +        assocs[i].value = values[i];
> +    }
> +
> +    return 0;
> +}
> +
> +int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd)
> +{
> +    int ret;
> +    struct mshv_create_vp vp_arg = {
> +        .vp_index = vp_index,
> +    };
> +
> +    ret = ioctl(vm_fd, MSHV_CREATE_VP, &vp_arg);
> +    if (ret < 0) {
> +        error_report("failed to create mshv vcpu: %s", strerror(errno));
> +        return -1;
> +    }
> +
> +    *cpu_fd = ret;
> +
> +    return 0;
> +}
> +
> +void mshv_remove_vcpu(int vm_fd, int cpu_fd)
> +{
> +    close(cpu_fd);
> +}
> +
> +void mshv_setup_hvcall_args(AccelCPUState *state)
> +{
> +    void *mem = qemu_memalign(HV_HYP_PAGE_SIZE, 2 * HV_HYP_PAGE_SIZE);
> +
> +    state->hvcall_args.base = mem;
> +    state->hvcall_args.input_page = mem;
> +    state->hvcall_args.output_page = (uint8_t *)mem + HV_HYP_PAGE_SIZE;
> +}
> diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
> index 3dffe3c5fbf..2e8caad8fde 100644
> --- a/include/system/mshv_int.h
> +++ b/include/system/mshv_int.h
> @@ -107,6 +107,7 @@ void mshv_arch_amend_proc_features(
>  void mshv_arch_disable_partition_proc_features(
>       union hv_partition_processor_features *disabled_features);
>  int mshv_arch_post_init_vm(int vm_fd);
> +void mshv_setup_hvcall_args(AccelCPUState *state);
>  int mshv_get_vp_state(int cpu_fd, struct mshv_get_set_vp_state *state);
>  int mshv_set_vp_state(int cpu_fd, const struct mshv_get_set_vp_state *state);
>  typedef struct mshv_root_hvcall mshv_root_hvcall;
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index f528dd2b9a2..3eee097432a 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -357,103 +357,6 @@ static int translate_gva(const CPUState *cpu, uint64_t gva, uint64_t *gpa,
>      return 0;
>  }
>  
> -int mshv_set_generic_regs(const CPUState *cpu, const hv_register_assoc *assocs,
> -                          size_t n_regs)
> -{
> -    int cpu_fd = mshv_vcpufd(cpu);
> -    int vp_index = cpu->cpu_index;
> -    size_t in_sz, assocs_sz;
> -    hv_input_set_vp_registers *in = cpu->accel->hvcall_args.input_page;
> -    struct mshv_root_hvcall args = {0};
> -    int ret;
> -
> -    /* find out the size of the struct w/ a flexible array at the tail */
> -    assocs_sz = n_regs * sizeof(hv_register_assoc);
> -    in_sz = sizeof(hv_input_set_vp_registers) + assocs_sz;
> -
> -    /* fill the input struct */
> -    memset(in, 0, sizeof(hv_input_set_vp_registers));
> -    in->vp_index = vp_index;
> -    memcpy(in->elements, assocs, assocs_sz);
> -
> -    /* create the hvcall envelope */
> -    args.code = HVCALL_SET_VP_REGISTERS;
> -    args.in_sz = in_sz;
> -    args.in_ptr = (uint64_t) in;
> -    args.reps = (uint16_t) n_regs;
> -
> -    /* perform the call */
> -    ret = mshv_hvcall(cpu_fd, &args);
> -    if (ret < 0) {
> -        error_report("Failed to set registers");
> -        return -1;
> -    }
> -
> -    /* assert we set all registers */
> -    if (args.reps != n_regs) {
> -        error_report("Failed to set registers: expected %zu elements"
> -                     ", got %u", n_regs, args.reps);
> -        return -1;
> -    }
> -
> -    return 0;
> -}
> -
> -int mshv_get_generic_regs(CPUState *cpu, hv_register_assoc *assocs,
> -                          size_t n_regs)
> -{
> -    int cpu_fd = mshv_vcpufd(cpu);
> -    int vp_index = cpu->cpu_index;
> -    hv_input_get_vp_registers *in = cpu->accel->hvcall_args.input_page;
> -    hv_register_value *values = cpu->accel->hvcall_args.output_page;
> -    size_t in_sz, names_sz, values_sz;
> -    int i, ret;
> -    struct mshv_root_hvcall args = {0};
> -
> -    /* find out the size of the struct w/ a flexible array at the tail */
> -    names_sz = n_regs * sizeof(hv_register_name);
> -    in_sz = sizeof(hv_input_get_vp_registers) + names_sz;
> -
> -    /* fill the input struct */
> -    memset(in, 0, sizeof(hv_input_get_vp_registers));
> -    in->vp_index = vp_index;
> -    for (i = 0; i < n_regs; i++) {
> -        in->names[i] = assocs[i].name;
> -    }
> -
> -    /* determine size of value output buffer */
> -    values_sz = n_regs * sizeof(union hv_register_value);
> -
> -    /* create the hvcall envelope */
> -    args.code = HVCALL_GET_VP_REGISTERS;
> -    args.in_sz = in_sz;
> -    args.in_ptr = (uint64_t) in;
> -    args.out_sz = values_sz;
> -    args.out_ptr = (uint64_t) values;
> -    args.reps = (uint16_t) n_regs;
> -
> -    /* perform the call */
> -    ret = mshv_hvcall(cpu_fd, &args);
> -    if (ret < 0) {
> -        error_report("Failed to retrieve registers");
> -        return -1;
> -    }
> -
> -    /* assert we got all registers */
> -    if (args.reps != n_regs) {
> -        error_report("Failed to retrieve registers: expected %zu elements"
> -                     ", got %u", n_regs, args.reps);
> -        return -1;
> -    }
> -
> -    /* copy values into assoc */
> -    for (i = 0; i < n_regs; i++) {
> -        assocs[i].value = values[i];
> -    }
> -
> -    return 0;
> -}
> -
>  static int set_standard_regs(const CPUState *cpu)
>  {
>      X86CPU *x86cpu = X86_CPU(cpu);
> @@ -2040,29 +1943,6 @@ int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
>      return 0;
>  }
>  
> -void mshv_remove_vcpu(int vm_fd, int cpu_fd)
> -{
> -    close(cpu_fd);
> -}
> -
> -
> -int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd)
> -{
> -    int ret;
> -    struct mshv_create_vp vp_arg = {
> -        .vp_index = vp_index,
> -    };
> -    ret = ioctl(vm_fd, MSHV_CREATE_VP, &vp_arg);
> -    if (ret < 0) {
> -        error_report("failed to create mshv vcpu: %s", strerror(errno));
> -        return -1;
> -    }
> -
> -    *cpu_fd = ret;
> -
> -    return 0;
> -}
> -
>  static void read_segment_descriptor(CPUState *cpu,
>                                      struct x86_segment_descriptor *desc,
>                                      enum X86Seg seg_idx)
> @@ -2121,7 +2001,6 @@ void mshv_arch_init_vcpu(CPUState *cpu)
>      CPUX86State *env = &x86_cpu->env;
>      AccelCPUState *state = cpu->accel;
>      size_t page = HV_HYP_PAGE_SIZE, xsave_len;
> -    void *mem = qemu_memalign(page, 2 * page);
>      int ret;
>      X86XSaveHeader *header;
>  
> @@ -2143,9 +2022,7 @@ void mshv_arch_init_vcpu(CPUState *cpu)
>          env->regs_page = (struct hv_vp_register_page *) rp;
>      }
>  
> -    state->hvcall_args.base = mem;
> -    state->hvcall_args.input_page = mem;
> -    state->hvcall_args.output_page = (uint8_t *)mem + page;
> +    mshv_setup_hvcall_args(state);
>  
>      env->emu_mmio_buf = g_new(char, 4096);
>  
> 
> -- 
> 2.45.4

Reviewed-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

