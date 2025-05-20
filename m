Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3384BC54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 22:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHVM2-0005Be-Ld; Tue, 20 May 2025 18:22:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uHVM1-0005B0-8D
 for qemu-devel@nongnu.org; Tue, 20 May 2025 18:22:33 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.liu@kernel.org>)
 id 1uHVLz-000478-4r
 for qemu-devel@nongnu.org; Tue, 20 May 2025 18:22:32 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 65B89A4EF1A;
 Tue, 20 May 2025 22:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC73CC4CEE9;
 Tue, 20 May 2025 22:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747779749;
 bh=iY4Xhy4+QpvNZirJrJRtAnHSGZWcJgHPknSgORe1FBM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aTmVfC2O6d7qcw2qQcpniCdax6Jo76I6Bwd88tzACv65+GvlfwfLfrnE+WU5pEysl
 WSFnwz1g5TuvO3GWKM6taT852JCmDflDHWCP7/bn2khsWSMter1aiWvNTL0b2nooj3
 y1F7Ag1zmXZB2b0iPJ94Jk9dhkOAs3le3w3EyUHpHYlea5iXGeUD76OXdSuZ578ZeR
 ZXZidFX4MKcVxFOAQjih5LuhlDcn3+h5Dy0t4ZZVaDOF8NM2ICSRymtbZo0Qno2hCX
 T0DDvs0O2Xvr5Rs4LqcyNuJaRij70tKJgB+sblfuLL482Mo1GLCYmazmIo0JDN3ERh
 J+Q9V7DMl0+wA==
Date: Tue, 20 May 2025 22:22:27 +0000
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
Subject: Re: [RFC PATCH 18/25] target/i386/mshv: Implement
 mshv_arch_put_registers()
Message-ID: <aC0Ao4TQnV6ZE6Aa@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-19-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520113018.49569-19-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=wei.liu@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, May 20, 2025 at 01:30:11PM +0200, Magnus Kulke wrote:
> Write CPU register state to MSHV vCPUs. Various mapping functions to
> prepare the payload for the HV call have been implemented.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
[...]
> +static int set_special_regs(const CPUState *cpu)
> +{
> +    X86CPU *x86cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86cpu->env;
> +    int cpu_fd = mshv_vcpufd(cpu);
> +    struct hv_register_assoc *assocs;
> +    size_t n_regs = sizeof(SPECIAL_REGISTER_NAMES) / sizeof(hv_register_name);
> +    int ret;
> +
> +    assocs = g_new0(struct hv_register_assoc, n_regs);
> +
> +    /* set names */
> +    for (size_t i = 0; i < n_regs; i++) {
> +        assocs[i].name = SPECIAL_REGISTER_NAMES[i];
> +    }
> +    populate_hv_segment_reg(&env->segs[R_CS], &assocs[0].value.segment);
> +    populate_hv_segment_reg(&env->segs[R_DS], &assocs[1].value.segment);
> +    populate_hv_segment_reg(&env->segs[R_ES], &assocs[2].value.segment);
> +    populate_hv_segment_reg(&env->segs[R_FS], &assocs[3].value.segment);
> +    populate_hv_segment_reg(&env->segs[R_GS], &assocs[4].value.segment);
> +    populate_hv_segment_reg(&env->segs[R_SS], &assocs[5].value.segment);
> +    populate_hv_segment_reg(&env->tr, &assocs[6].value.segment);
> +    populate_hv_segment_reg(&env->ldt, &assocs[7].value.segment);
> +
> +    populate_hv_table_reg(&env->gdt, &assocs[8].value.table);
> +    populate_hv_table_reg(&env->idt, &assocs[9].value.table);
> +
> +    assocs[10].value.reg64 = env->cr[0];
> +    assocs[11].value.reg64 = env->cr[2];
> +    assocs[12].value.reg64 = env->cr[3];
> +    assocs[13].value.reg64 = env->cr[4];
> +    assocs[14].value.reg64 = cpu_get_apic_tpr(x86cpu->apic_state);
> +    assocs[15].value.reg64 = env->efer;
> +    assocs[16].value.reg64 = cpu_get_apic_base(x86cpu->apic_state);
> +
> +    /*
> +     * TODO: support asserting an interrupt using interrup_bitmap
> +     * it should be possible if we use the vm_fd
> +     */
> +

Why is there a need to assert an interrupt here?

> +    ret = mshv_set_generic_regs(cpu_fd, assocs, n_regs);
> +    g_free(assocs);
> +    if (ret < 0) {
> +        error_report("failed to set special registers");
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int set_fpu_regs(int cpu_fd, const struct MshvFPU *regs)

Please change regs to fpu.

Thanks,
Wei.

> +{
> +    struct hv_register_assoc *assocs;
> +    union hv_register_value *value;
> +    size_t n_regs = sizeof(FPU_REGISTER_NAMES) / sizeof(enum hv_register_name);
> +    size_t fp_i;
> +    union hv_x64_fp_control_status_register *ctrl_status;
> +    union hv_x64_xmm_control_status_register *xmm_ctrl_status;
> +    int ret;
> +

