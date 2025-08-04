Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7239FC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 22:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj46O-0003Sl-OU; Mon, 04 Aug 2025 18:56:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uj46L-0003Mp-Jk
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 18:56:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uj46H-0000AO-JP
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 18:56:16 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-459d4d7c745so18176815e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 15:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754348168; x=1754952968; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AnhC+5NQgPXUfTdBtxtORy1XGkja1Cfkwjx/YqHHv3w=;
 b=jrzz2pIf4NLBZiaWlHSu8OYcvuRhavQrxbL4s+IeHCVg/C7YptGRLNE/3lQcmXxYQe
 CKZlaKDPGSm9hmo7iNhTE8SfZfV6QBB1Rjy+epEJda5oZuUw2NB9GMTy4gYMRcsocpMz
 RX7WXnDUTuvCKzw/hqBDxDZuimTfbkeG576DZmBka6mNGu7Rvwp4M544n0bTYOsa2pyz
 PEe3mfP8cnhSC8cl72H8bcm8GInVO6p/OLs1Hyu2IgLavvfBO2HoJpPODGdFjQju7TsO
 YF0x7+0Z1Rs6u7Ek+Jk4AI+12pxZ6X64cqHalLn2xsDC+iRpZ6cQ7Y32G8YwR1R2tXxk
 j9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754348168; x=1754952968;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AnhC+5NQgPXUfTdBtxtORy1XGkja1Cfkwjx/YqHHv3w=;
 b=PtNGoc1MJps6XJyBPG0i9QrOVDCjf3EHEq9GZS5uqp70FQXyqskbFH7hN/0+03q0Uz
 lY/nl+HT9cNGb3YV9WrgQRaE+U8C7yuO6ug/Y/l6csmuwc2ZyHAutkts0ac6Lc9Gx57W
 qYMcNqDYnJCU36LKOn0cVvhHGtyIWI9ANsO7LpLxw6R7ycDQCf+ET45/gkYffzho/mkO
 Tj1tChqrwofiQatczFv74ytH0ikQ61nACvHgSNRKjzg6lGFUz4Zd8n4O8C7ztSMJ+fWn
 yoOqqBuwpu83JiCyI84fE45KBQ9zEZD0qZWHS9fl5m1h77qcyTWwGIr5KTNcnS7zLmW2
 QF1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIJwpfdbUELpSWC3yyXWnNTcp0oJ7/FJnaINaB56X/LU5nqb6dOe2dXcHIE4S5/xoYzNlu8OOJbWQG@nongnu.org
X-Gm-Message-State: AOJu0Yxpq3oxEzQErO7qANmSt3uEJUhNoaJNdFTP2UrN3xqAZXIRp6t9
 bZxnRDcnQs7tT8Hd6yze9Fn78/vRrRsO9we/F5g2BGOlnj9fs0GVeoX4K6x4rN2f1JA=
X-Gm-Gg: ASbGnct8qBKCnWPsaaweokU1kfs/LgjkzWLWsirT/KdwU3I/E58G652WJFoIlfBrbRA
 ijD9SERxrJx+PnOh7FWWUubNPM+TzxBBYOGgUKOS/Qn5WLGTIURIUql8QwbykaAGJInip1Ruo9j
 nV16UDrxkMsd/iL/pPbKvYQzm/8gbbdJn7YRLwU4KBETYUEJEZQcn3JxEdvG03GZ1Wv08RFDsfX
 vso3dygETPmpYq2nl59J2Hzg4jUlYDKVUpmFwEwW/I6vL4X5Z0RXLri/LdQw2VYuFMZ3vl/eHxp
 dfa9Duqo7p+bAH8tWeS3Za51a4h85OJDZ55LnfB3B8oTnna+scuntiaf+ly8HTekC5pGLm3xTB2
 ly+0QWhon718G/xz6C4iCSDQsIxiDuR8Z0u0S572uqxErwVUtKTgIIIzmMsLEjejDkA==
X-Google-Smtp-Source: AGHT+IEuv+erl0EU2HVvC0kfVWNbC8gMnW6DHnMH00132oN2EmQyvYVLVx/OlXqkCVe0HzhNfssjZQ==
X-Received: by 2002:a05:600c:354e:b0:453:6ca:16b1 with SMTP id
 5b1f17b1804b1-458b6b47baemr84506915e9.26.1754348167925; 
 Mon, 04 Aug 2025 15:56:07 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e0cd2c90sm12240625e9.17.2025.08.04.15.56.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 15:56:07 -0700 (PDT)
Message-ID: <47ba48ae-e3d6-47a0-9aa4-35c0a14d7c9f@linaro.org>
Date: Tue, 5 Aug 2025 00:56:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/17] whpx: add arm64 support
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>, Ani Sinha <anisinha@redhat.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-10-mohamed@unpredictable.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250804142326.72947-10-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/8/25 16:23, Mohamed Mediouni wrote:
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/whpx/whpx-common.c    |   1 +
>   meson.build                 |  21 +-
>   target/arm/meson.build      |   1 +
>   target/arm/whpx/meson.build |   3 +
>   target/arm/whpx/whpx-all.c  | 845 ++++++++++++++++++++++++++++++++++++
>   5 files changed, 864 insertions(+), 7 deletions(-)
>   create mode 100644 target/arm/whpx/meson.build
>   create mode 100644 target/arm/whpx/whpx-all.c


> +int whpx_init_vcpu(CPUState *cpu)
> +{
> +    HRESULT hr;
> +    struct whpx_state *whpx = &whpx_global;
> +    AccelCPUState *vcpu = NULL;
> +    ARMCPU *arm_cpu = ARM_CPU(cpu);
> +    CPUARMState *env = &arm_cpu->env;
> +    int ret;
> +
> +    uint32_t sregs_match_len = ARRAY_SIZE(whpx_sreg_match);
> +    uint32_t sregs_cnt = 0;
> +    WHV_REGISTER_VALUE val;
> +    int i;
> +
> +    vcpu = g_new0(AccelCPUState, 1);
> +
> +    hr = whp_dispatch.WHvCreateVirtualProcessor(
> +        whpx->partition, cpu->cpu_index, 0);
> +    if (FAILED(hr)) {
> +        error_report("WHPX: Failed to create a virtual processor,"
> +                     " hr=%08lx", hr);
> +        ret = -EINVAL;
> +        goto error;
> +    }
> +
> +    /* Assumption that CNTFRQ_EL0 is the same between the VMM and the partition. */
> +    asm volatile("mrs %0, cntfrq_el0" : "=r"(arm_cpu->gt_cntfrq_hz));
> +
> +    cpu->vcpu_dirty = true;
> +    cpu->accel = vcpu;
> +    max_vcpu_index = max(max_vcpu_index, cpu->cpu_index);
> +    qemu_add_vm_change_state_handler(whpx_cpu_update_state, env);
> +
> +    env->aarch64 = true;
> +
> +    /* Allocate enough space for our sysreg sync */
> +    arm_cpu->cpreg_indexes = g_renew(uint64_t, arm_cpu->cpreg_indexes,
> +                                     sregs_match_len);
> +    arm_cpu->cpreg_values = g_renew(uint64_t, arm_cpu->cpreg_values,
> +                                    sregs_match_len);
> +    arm_cpu->cpreg_vmstate_indexes = g_renew(uint64_t,
> +                                             arm_cpu->cpreg_vmstate_indexes,
> +                                             sregs_match_len);
> +    arm_cpu->cpreg_vmstate_values = g_renew(uint64_t,
> +                                            arm_cpu->cpreg_vmstate_values,
> +                                            sregs_match_len);
> +
> +    memset(arm_cpu->cpreg_values, 0, sregs_match_len * sizeof(uint64_t));
> +
> +    /* Populate cp list for all known sysregs */
> +    for (i = 0; i < sregs_match_len; i++) {
> +        const ARMCPRegInfo *ri;
> +        uint32_t key = whpx_sreg_match[i].key;
> +
> +        ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
> +        if (ri) {
> +            assert(!(ri->type & ARM_CP_NO_RAW));
> +            whpx_sreg_match[i].cp_idx = sregs_cnt;
> +            arm_cpu->cpreg_indexes[sregs_cnt++] = cpreg_to_kvm_id(key);
> +        } else {
> +            whpx_sreg_match[i].cp_idx = -1;
> +        }
> +    }
> +    arm_cpu->cpreg_array_len = sregs_cnt;
> +    arm_cpu->cpreg_vmstate_array_len = sregs_cnt;
> +
> +    assert(write_cpustate_to_list(arm_cpu, false));
> +
> +    /* Set CP_NO_RAW system registers on init */
> +    val.Reg64 = arm_cpu->midr;
> +    whpx_set_reg(cpu, WHvArm64RegisterMidrEl1,
> +                              val);
> +
> +    clean_whv_register_value(&val);
> +
> +    /* bit 31 of MPIDR_EL1 is RES1, and this is enforced by WHPX */
> +    val.Reg64 = 0x80000000 + arm_cpu->mp_affinity;

Preferably:

        val.Reg64 = deposit64(arm_cpu->mp_affinity, 31, 1, 1 /* RES1 */);

> +    whpx_set_reg(cpu, WHvArm64RegisterMpidrEl1,
> +                              val);

(note, your indentation is often off)

> +
> +    return 0;
> +
> +error:
> +    g_free(vcpu);
> +
> +    return ret;
> +
> +}

