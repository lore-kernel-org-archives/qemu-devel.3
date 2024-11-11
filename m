Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FC1D3ABEB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 18:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAZCz-00050S-LG; Mon, 11 Nov 2024 13:32:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tAZCv-0004zr-Fm
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 13:32:13 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tAZCp-0007om-Pu
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 13:32:09 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-720d01caa66so4503661b3a.2
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 10:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1731349924; x=1731954724; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a6IW97VMMcTRy6uPbq92wAl9qdSYNBvFTAJHq34lYNE=;
 b=nesAVgK1VGVInXZiNaYC+3tJj24Bu+9LlFQ0C6F9t7OMdZ5s+TqAfUPSDPx5vczLTD
 W/CBkB0NlzVhyGpzeCZ74vvN6QKt5nwPhX0SrO5k17m57mn6CM540f8SuMX+B97fbQtY
 cbQfnxSKn3XM1wAIokTtJdohrQmjXhaB399rvf0sBbdcFmpQaofJmVlaT2B+JoMDc9lx
 vKNsDk8g9UT1IdcRJ/zdh7CJjT6svSU1Z2wydUsy+K+JxZ3gdgQNG+YkV/Cikuj4hr4+
 J0nMaYzJiJLtFkNy+587C5mZ/RnUzoswVwfgfelSI7g42C9pTJvZ7li527lC/ltf730o
 M3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731349924; x=1731954724;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a6IW97VMMcTRy6uPbq92wAl9qdSYNBvFTAJHq34lYNE=;
 b=v2KPMFljDQSwvhRQURDsOsBmp17BDhyaQajy+s0Jky/OocRPF2OetUy2V+CvebxLgV
 UhFwYplOgasp3uKIcg5TuLukG7eIZ5uTs4IEXap1Tp81JyI43xsKWsXXw80/+8hp7T9p
 1mWONoIowpEykhgp/63gQmMGhgmQBw9ot14/7HpNtZapCa2X2kIQ1fdvfKo9CD9c4LAx
 XwkJTSa1u5qImxm1M0W0jhUOAMNYBGLV2OIwk/4PCzIJ/8Zg5OccOycS9aOlUXo+qCFW
 Oatl3Yn6qErpapvpDW6BC5cZ9ffu4eTLqZ7WpKVcvg4Cb8de1RwkP+/+GcEHck+HfUaG
 iqzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWJDTKtaBwp/JpcpI4JkvVx1xBF2Ln0gYtY2VcygnfuD5xqVX1X2i06eSZtGS3uH0bmVtAu4xKQJMW@nongnu.org
X-Gm-Message-State: AOJu0YwVya3iNCp1XPCId0JI34ZRzO/IRVFxBY4bmdujEwp4WMfQrA+L
 aumD67s7fBt/yEByl2/lXqxvC+zlE3y50maet8CtF0c7Q+jyXAWk+txu7Bp8fBI=
X-Google-Smtp-Source: AGHT+IEyxPbr59J7PYot4PiAXbq2FW+jROc9tjlmb2en0MIUuqO7YfflXWNB+zP9eI8d9yIrSnhrjA==
X-Received: by 2002:a05:6a00:18a1:b0:71e:db72:3c87 with SMTP id
 d2e1a72fcca58-7241336007bmr18459528b3a.20.1731349924449; 
 Mon, 11 Nov 2024 10:32:04 -0800 (PST)
Received: from [192.168.68.110] ([189.79.22.174])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7240785f8c6sm9427340b3a.35.2024.11.11.10.32.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 10:32:04 -0800 (PST)
Message-ID: <1293b3ab-6f61-4471-8f46-6abf103a635d@ventanamicro.com>
Date: Mon, 11 Nov 2024 15:31:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] target/riscv: Check memory access to meet svuket
 rule
To: "Fea.Wang" <fea.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>
References: <20241108085239.2927152-1-fea.wang@sifive.com>
 <20241108085239.2927152-5-fea.wang@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241108085239.2927152-5-fea.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
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



On 11/8/24 5:52 AM, Fea.Wang wrote:
> Follow the Svukte spec, do the memory access address checking
> 
> 1. Include instruction fetches or explicit memory accesses
> 2. System run in effective privilege U or VU
> 3. Check senvcfg[UKTE] being set, or hstatus[HUKTE] being set if
>     instruction is HLV, HLVX, HSV and excute from U mode to VU mode

typo: s/excute/execute

> 4. Depend on Sv39 and check virtual addresses bit[SXLEN-1]
> 5. Raises a page-fault exception corresponding to the original access
>     type.
> 
> Ref: https://github.com/riscv/riscv-isa-manual/pull/1564/files
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>
> ---
>   target/riscv/cpu_helper.c | 57 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 57 insertions(+)
> 
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 0a3ead69ea..725c049f7a 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -857,6 +857,57 @@ static int get_physical_address_pmp(CPURISCVState *env, int *prot, hwaddr addr,
>       return TRANSLATE_SUCCESS;
>   }
>   
> +/*
> + * Return 'true' means no need to do svukte check, or need to do svukte and the
> + * address is valid. Return 'false' means need to do svukte check but address
> + * is invalid.
> + */

I think this function is doing a bit too much while not doing everything we need.
For instance, we're still doing some checks in get_physical_address() prior to
calling it.

I would put all the svukte logic in two functions:

- 'do_svukte_check' would check all dependencies for the svukte check per se
- 'check_svukte_addr' would do the addr check if we need to do a svukte check


An example:



/* Returns 'true' if a svukte address check is needed */
static bool do_svukte_check(CPURISCVState *env, bool first_stage,
                             int mode, bool virt)
{
     bool ukte;

     /* Svukte extension depends on Sv39. */
     if (!(env_archcpu(env)->cfg.ext_svukte &&
           first_stage &&
           VM_1_10_SV39 == get_field(env->satp, SATP64_MODE))) {
         return false;
     }

     /*
      * Check hstatus.HUKTE if the effective mode is switched to VU-mode by
      * executing HLV/HLVX/HSV in U-mode.
      * For other cases, check senvcfg.UKTE.
      */
     if (env->priv == PRV_U && !env->virt_enabled && virt) {
         ukte = !!(env->hstatus & HSTATUS_HUKTE);
     } else {
         ukte = !!(env->senvcfg & SENVCFG_UKTE);
     }

     if (!ukte) {
         return false;
     }

     /*
      * Svukte extension is qualified only in U or VU-mode.
      *
      * Effective mode can be switched to U or VU-mode by:
      *   - M-mode + mstatus.MPRV=1 + mstatus.MPP=U-mode.
      *   - Execute HLV/HLVX/HSV from HS-mode + hstatus.SPVP=0.
      *   - U-mode.
      *   - VU-mode.
      *   - Execute HLV/HLVX/HSV from U-mode + hstatus.HU=1.
      */
     if (mode != PRV_U) {
         return false;
     }

     return true;
}


static bool check_svukte_addr(CPURISCVState *env, vaddr addr)
{
     uint32_t sxl = riscv_cpu_sxl(env);
     sxl = (sxl == 0) ? MXL_RV32 : sxl;
     uint32_t sxlen = 32 * sxl;
     uint64_t high_bit = addr & (1UL << (sxlen - 1));

     return !high_bit;
}


And then on get_physical_addr():


     if (do_svukte_check(env, first_stage, mode, virt) &&
         !check_svukte_addr(env, addr)) {
         return TRANSLATE_FAIL;
     }


Feel free to use these functions (compiled tested only) if you want. Thanks,

Daniel


> +static bool check_svukte_valid(CPURISCVState *env, vaddr addr,
> +                               int mode, bool virt)
> +{
> +    /*
> +     * Check hstatus.HUKTE if the effective mode is switched to VU-mode by
> +     * executing HLV/HLVX/HSV in U-mode.
> +     * For other cases, check senvcfg.UKTE.
> +     */
> +    bool ukte;
> +    if (env->priv == PRV_U && !env->virt_enabled && virt) {
> +        ukte = !!(env->hstatus & HSTATUS_HUKTE);
> +    } else {
> +        ukte = !!(env->senvcfg & SENVCFG_UKTE);
> +    }
> +
> +    if (VM_1_10_SV39 != get_field(env->satp, SATP64_MODE))  {
> +        /* Svukte extension depends on Sv39. */
> +        return true;
> +    }> +
> +    /*
> +     * Svukte extension is qualified only in U or VU-mode.
> +     *
> +     * Effective mode can be switched to U or VU-mode by:
> +     *   - M-mode + mstatus.MPRV=1 + mstatus.MPP=U-mode.
> +     *   - Execute HLV/HLVX/HSV from HS-mode + hstatus.SPVP=0.
> +     *   - U-mode.
> +     *   - VU-mode.
> +     *   - Execute HLV/HLVX/HSV from U-mode + hstatus.HU=1.
> +     */
> +    if (mode != PRV_U) {
> +        return true;
> +    }
> +
> +    if (!ukte) {
> +        return true;
> +    }
> +
> +    uint32_t sxl = riscv_cpu_sxl(env);
> +    sxl = (sxl == 0) ? MXL_RV32 : sxl;
> +    uint32_t sxlen = 32 * sxl;
> +    uint64_t high_bit = addr & (1UL << (sxlen - 1));
> +
> +    return !high_bit;
> +}
> +
>   /*
>    * get_physical_address - get the physical address for this virtual address
>    *
> @@ -894,6 +945,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>       MemTxResult res;
>       MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
>       int mode = mmuidx_priv(mmu_idx);
> +    bool virt = mmuidx_2stage(mmu_idx);
>       bool use_background = false;
>       hwaddr ppn;
>       int napot_bits = 0;
> @@ -901,6 +953,11 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>       bool is_sstack_idx = ((mmu_idx & MMU_IDX_SS_WRITE) == MMU_IDX_SS_WRITE);
>       bool sstack_page = false;
>   
> +    if (env_archcpu(env)->cfg.ext_svukte && first_stage &&
> +        !check_svukte_valid(env, addr, mode, virt)) {
> +        return TRANSLATE_FAIL;
> +    }
> +
>       /*
>        * Check if we should use the background registers for the two
>        * stage translation. We don't need to check if we actually need

