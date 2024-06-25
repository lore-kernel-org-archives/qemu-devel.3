Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31EEC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 09:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM2n3-0007g6-5z; Tue, 25 Jun 2024 05:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sM2n1-0007fH-6l
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 05:48:39 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sM2my-0003E9-6L
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 05:48:38 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2c2c6277ef3so4021650a91.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 02:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1719308914; x=1719913714; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6UmzqdyUh2HhY12DmOBbdCBiZttJu4k0dI3aAGt34M4=;
 b=Etgp2ThJP3wm6GfEL04wA97IUMsdp+jGfBTZv7f6Ryq6GSAL6vpCnjeFzaqOen7T6W
 KX4ravxXohbRsjlsbBNv+eiKRH8QCX/9q+iNVVikrAFUdVM5Zk6Wsq2vU4Jz0/lq/UDm
 1mBpFhlXIOv01hDY0//pOQEKbjA8cVY2npjdJtJ+qm12SQuFDfA3So05WhQOs0HV0+km
 BLNF4LoAyTUE659rDECiFK0dQaFkPuBBsqivg8mvCwGAeDWBEJQ1XBZ6BlKooLnS8j/c
 4xds8BCpI5KSkhc+J1WthWFbTmETvL9SeCx4cc7R7Dn8MKWKWsA7NkuRUqCuJzdp1Nnc
 3nMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719308914; x=1719913714;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6UmzqdyUh2HhY12DmOBbdCBiZttJu4k0dI3aAGt34M4=;
 b=cQjs2TAV+AR15y8NhHYD6pty0axMPWr0lERUE4OjaWQo6T/mnN/De7ACYh8LQlqKw7
 CPmtfN4iIV8dqRH6L0a2MvAvC0ObDNDcJkqQqw9cpyhhqXHfKYvbkaafPvIrZjDZrpZD
 nrpUBB+dYuy/DU23tzzCnUjAqcqkVckJTMUhoFD5DVz0gMZRj2mhyC+n36PlhIM/MVCG
 tfMZMUqRwv2qdGua55RijbmXSPpQmXE+1SAUKWBzQmNVZpSvdPiGbPZbkcTqHunc2xLP
 EKzeXQvHtSkM/Ya9DK07orZvD26mxL6SiQujVPw8DxDpEVx+FyA/bRR7Sroh+cP4W2R3
 45wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5B5nJ+0vnUfYcE8f+SxO2r9NIhuZDQW5P/rpVzvBfKMerExdt9FuP44k//Ug7iLAasBaGVbHw4FecwFEonxI8+yC7D1A=
X-Gm-Message-State: AOJu0Yw53JiteRXQDrVWXEkli4BYDOJiN62dHngzNrNF3Y+J89Jk9OD9
 Xy5lcLVkN7b/e5GOUohJKUZ+D6VQSyEXWeElQCOUPYzSyb3CwYhNz/3dniIKgow=
X-Google-Smtp-Source: AGHT+IF7XwLcdDU8s3VE4ApssoYHjoxOs+yo3MedCL3MZ9dCTSP8JOaMpkx2sDMWmi/I8rL+dGd23g==
X-Received: by 2002:a17:90a:a395:b0:2c8:946f:5fe7 with SMTP id
 98e67ed59e1d1-2c8946f6240mr3543514a91.17.1719308913906; 
 Tue, 25 Jun 2024 02:48:33 -0700 (PDT)
Received: from [192.168.100.252] (59-124-168-89.hinet-ip.hinet.net.
 [59.124.168.89]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c7e53e7bf0sm10318753a91.19.2024.06.25.02.48.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jun 2024 02:48:33 -0700 (PDT)
Message-ID: <17803f4f-145e-4314-81ca-7f19c614afb6@sifive.com>
Date: Tue, 25 Jun 2024 17:48:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] target/riscv: Add support to access ctrsource,
 ctrtarget, ctrdata regs.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, beeman@rivosinc.com,
 tech-control-transfer-records@lists.riscv.org
References: <20240619152708.135991-1-rkanwal@rivosinc.com>
 <20240619152708.135991-7-rkanwal@rivosinc.com>
Content-Language: en-US
From: Jason Chien <jason.chien@sifive.com>
In-Reply-To: <20240619152708.135991-7-rkanwal@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=jason.chien@sifive.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Rajnesh,

On 2024/6/19 下午 11:27, Rajnesh Kanwal wrote:
> CTR entries are accessed using ctrsource, ctrtarget and ctrdata
> registers using smcsrind/sscsrind extension. This commits extends
> the csrind extension to support CTR registers.
>
> ctrsource is accessible through xireg CSR, ctrtarget is accessible
> through xireg1 and ctrdata is accessible through xireg2 CSR.
>
> CTR supports maximum depth of 256 entries which are accessed using
> xiselect range 0x200 to 0x2ff.
>
> This commits also adds properties to enable CTR extension. CTR can be
> enabled using smctr=true and ssctr=true now.
>
> Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>
> ---
>   target/riscv/cpu.c         |   4 +
>   target/riscv/csr.c         | 148 ++++++++++++++++++++++++++++++++++++-
>   target/riscv/tcg/tcg-cpu.c |   6 ++
>   3 files changed, 157 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 30bdfc22ae..a77b1d5caf 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -193,6 +193,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
>       ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>       ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
>       ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
> +    ISA_EXT_DATA_ENTRY(smctr, PRIV_VERSION_1_12_0, ext_smctr),
> +    ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
>       ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
>       ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
>       ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
> @@ -1473,6 +1475,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
>       MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),
>       MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),
>       MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
> +    MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),
> +    MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),
>       MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
>       MULTI_EXT_CFG_BOOL("zicsr", ext_zicsr, true),
>       MULTI_EXT_CFG_BOOL("zihintntl", ext_zihintntl, true),
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 0b5bf4d050..3ed9f95a4f 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2278,6 +2278,13 @@ static bool xiselect_cd_range(target_ulong isel)
>       return (ISELECT_CD_FIRST <= isel && isel <= ISELECT_CD_LAST);
>   }
>   
> +static bool xiselect_ctr_range(int csrno, target_ulong isel)
> +{
> +    /* MIREG-MIREG6 for the range 0x200-0x2ff are not used by CTR. */
> +    return CTR_ENTRIES_FIRST <= isel && isel <= CTR_ENTRIES_LAST &&
> +           csrno < CSR_MIREG;
> +}
> +
>   static int rmw_iprio(target_ulong xlen,
>                        target_ulong iselect, uint8_t *iprio,
>                        target_ulong *val, target_ulong new_val,
> @@ -2323,6 +2330,124 @@ static int rmw_iprio(target_ulong xlen,
>       return 0;
>   }
>   
> +static int rmw_ctrsource(CPURISCVState *env, int isel, target_ulong *val,
> +                          target_ulong new_val, target_ulong wr_mask)
> +{
> +    /*
> +     * CTR arrays are treated as circular buffers and TOS always points to next
> +     * empty slot, keeping TOS - 1 always pointing to latest entry. Given entry
> +     * 0 is always the latest one, traversal is a bit different here. See the
> +     * below example.
> +     *
> +     * Depth = 16.
> +     *
> +     * idx    [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E] [F]
> +     * TOS                                 H
> +     * entry   6   5   4   3   2   1   0   F   E   D   C   B   A   9   8   7
> +     */
> +    const uint64_t entry = isel - CTR_ENTRIES_FIRST;
> +    const uint64_t depth = 16 << get_field(env->sctrdepth, SCTRDEPTH_MASK);
> +    uint64_t idx;
> +
> +    /* Entry greater than depth-1 is read-only zero */
> +    if (entry >= depth) {
> +        if (val) {
> +            *val = 0;
> +        }
> +        return 0;
> +    }
> +
> +    idx = get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);
> +    idx = (idx - entry - 1) & (depth - 1);
> +
> +    if (val) {
> +        *val = env->ctr_src[idx];
> +    }
> +
> +    env->ctr_src[idx] = (env->ctr_src[idx] & ~wr_mask) | (new_val & wr_mask);
> +
> +    return 0;
> +}
> +
> +static int rmw_ctrtarget(CPURISCVState *env, int isel, target_ulong *val,
> +                          target_ulong new_val, target_ulong wr_mask)
> +{
> +    /*
> +     * CTR arrays are treated as circular buffers and TOS always points to next
> +     * empty slot, keeping TOS - 1 always pointing to latest entry. Given entry
> +     * 0 is always the latest one, traversal is a bit different here. See the
> +     * below example.
> +     *
> +     * Depth = 16.
> +     *
> +     * idx    [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E] [F]
> +     * head                                H
> +     * entry   6   5   4   3   2   1   0   F   E   D   C   B   A   9   8   7
> +     */
> +    const uint64_t entry = isel - CTR_ENTRIES_FIRST;
> +    const uint64_t depth = 16 << get_field(env->sctrdepth, SCTRDEPTH_MASK);
> +    uint64_t idx;
> +
> +    /* Entry greater than depth-1 is read-only zero */
> +    if (entry >= depth) {
> +        if (val) {
> +            *val = 0;
> +        }
> +        return 0;
> +    }
> +
> +    idx = get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);
> +    idx = (idx - entry - 1) & (depth - 1);
> +
> +    if (val) {
> +        *val = env->ctr_dst[idx];
> +    }
> +
> +    env->ctr_dst[idx] = (env->ctr_dst[idx] & ~wr_mask) | (new_val & wr_mask);
> +
> +    return 0;
> +}
> +
> +static int rmw_ctrdata(CPURISCVState *env, int isel, target_ulong *val,
> +                        target_ulong new_val, target_ulong wr_mask)
> +{
> +    /*
> +     * CTR arrays are treated as circular buffers and TOS always points to next
> +     * empty slot, keeping TOS - 1 always pointing to latest entry. Given entry
> +     * 0 is always the latest one, traversal is a bit different here. See the
> +     * below example.
> +     *
> +     * Depth = 16.
> +     *
> +     * idx    [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E] [F]
> +     * head                                H
> +     * entry   6   5   4   3   2   1   0   F   E   D   C   B   A   9   8   7
> +     */
> +    const uint64_t entry = isel - CTR_ENTRIES_FIRST;
> +    const uint64_t mask = wr_mask & CTRDATA_MASK;
> +    const uint64_t depth = 16 << get_field(env->sctrdepth, SCTRDEPTH_MASK);
> +    uint64_t idx;
> +
> +    /* Entry greater than depth-1 is read-only zero */
> +    if (entry >= depth) {
> +        if (val) {
> +            *val = 0;
> +        }
> +        return 0;
> +    }
> +
> +    idx = get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);
> +    idx = (idx - entry - 1) & (depth - 1);
> +
> +    if (val) {
> +        *val = env->ctr_data[idx];
> +    }
> +
> +    env->ctr_data[idx] = (env->ctr_data[idx] & ~mask) | (new_val & mask);
> +
> +    return 0;
> +}
> +
>   static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,
>                            target_ulong isel, target_ulong *val,
>                            target_ulong new_val, target_ulong wr_mask)
> @@ -2473,6 +2598,25 @@ done:
>       return ret;
>   }
>   
> +static int rmw_xireg_ctr(CPURISCVState *env, int csrno,
> +                        target_ulong isel, target_ulong *val,
> +                        target_ulong new_val, target_ulong wr_mask)
> +{
> +    if (!riscv_cpu_cfg(env)->ext_smctr && !riscv_cpu_cfg(env)->ext_ssctr) {
> +        return -EINVAL;
> +    }
> +
> +    if (csrno == CSR_SIREG || csrno == CSR_VSIREG) {
> +        return rmw_ctrsource(env, isel, val, new_val, wr_mask);
> +    } else if (csrno == CSR_SIREG2 || csrno == CSR_VSIREG2) {
> +        return rmw_ctrtarget(env, isel, val, new_val, wr_mask);
> +    } else if (csrno == CSR_SIREG3 || csrno == CSR_VSIREG3) {
> +        return rmw_ctrdata(env, isel, val, new_val, wr_mask);
> +    }

[s|vs]ireg4/5/6 are read-only 0. We should make *val=0 for such cases.

The spec states:
When siselect holds a value in this range, sireg provides access to 
ctrsource, sireg2 provides access to ctrtarget, and sireg3 provides 
access to ctrdata. sireg4, sireg5, and sireg6 are read-only 0.
When vsiselect holds a value in 0x200..0x2FF, the vsireg* registers 
provide access to the same CTR entry register state as the analogous 
sireg* registers.

> +
> +    return 0;
> +}
> +
>   /*
>    * rmw_xireg_sxcsrind: Perform indirect access to xireg and xireg2-xireg6
>    *
> @@ -2484,11 +2628,13 @@ static int rmw_xireg_sxcsrind(CPURISCVState *env, int csrno,
>                                 target_ulong isel, target_ulong *val,
>                                 target_ulong new_val, target_ulong wr_mask)
>   {
> -    int ret = -EINVAL;
>       bool virt = csrno == CSR_VSIREG ? true : false;
> +    int ret = -EINVAL;
>   
>       if (xiselect_cd_range(isel)) {
>           ret = rmw_xireg_cd(env, csrno, isel, val, new_val, wr_mask);
> +    } else if (xiselect_ctr_range(csrno, isel)) {
> +        ret = rmw_xireg_ctr(env, csrno, isel, val, new_val, wr_mask);
>       } else {
>           /*
>            * As per the specification, access to unimplented region is undefined
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 683f604d9f..df75bb190b 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -726,6 +726,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
>           cpu->pmu_avail_ctrs = 0;
>       }
>   
> +    if ((cpu->cfg.ext_smctr || cpu->cfg.ext_ssctr) &&
> +        (!riscv_has_ext(env, RVS) || !cpu->cfg.ext_sscsrind)) {
I see other extensions check dependency with cpu_cfg_ext_is_user_set() 
and an error is reported if the dependent extension is disabled by the 
user. Is it better to put it this way?
> +        error_setg(errp, "Smctr and Ssctr require S-mode and Sscsrind");
> +        return;
> +    }
> +
>       /*
>        * Disable isa extensions based on priv spec after we
>        * validated and set everything we need.

