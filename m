Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E3AC27C5E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 11:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEp9E-0006g2-8O; Wed, 05 Jun 2024 07:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sEp9C-0006fH-Cd
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:49:42 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sEp99-0000pS-Ak
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:49:41 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f612d7b0f5so5799545ad.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 04:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717588177; x=1718192977; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1ztj/lmCdpN18Qn1t8Kr1GAocGTszKNjqIX02r3tjsw=;
 b=MDj74r7TEwKn8dfpRtiRKTh3TKaGOuR7xTCxMFV9QjNrvsPVMr8tNRKXkbx+E2m19h
 mskzATPoZI10W586qGBE199K94dwn2j7BQK0HGmGrG5WsZnhWaNDP9N3ZV+gAEu7fVMW
 bMuO7E4ShekmGS5HNJjhcdYhrD5XBpHM7AvIeExREat3V5q2pmO5GHh/yFZHQoS8KykB
 FsQ7m6M9AljIWU9IA1qvKtTKGAncENxhIdZzV85awlKEYR/+W6/AXaHplpwruSyIM4V4
 SrW8NQ9xzyId4yH9r66mFfqyIPksLJDYOpSbLGLeCsSdMaKdMndSAf2wm0Pz1u93jMEV
 FCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717588177; x=1718192977;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1ztj/lmCdpN18Qn1t8Kr1GAocGTszKNjqIX02r3tjsw=;
 b=WQJIupVRZJ/yzDj568F/RC99Fvw3nCaIlJ1HzUPPvdQr1Y3llsDUvy5vU6QABMlChK
 EWXUJh9l7Bz56tuMGzTLCthNlC1W5be9ydoS6ZmcAXlHrO0e1WmNmWAR6gANyvrV6ZRZ
 dZSaCA5igNML9/I+sJNNFyADysZ3EHKe5ZWL2rTMx6uWSZLAGg+t3Tw6W4xuO7gLSieB
 rINhpCjugV9VFCdlsq45qIFXS4gxYEge349SbsOgi5P5FK/pnjrj3Cu0Mp1q5TTdekU+
 dw8w7xUtiwyeJoFcW7/uCW3BkmIZZgzzhZd+HEPD4vEQBGRwEzb6M1tV4o3opgreJe+N
 WwqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdmMbxfdIYvET8o7a0+Ej3+A0Rz/aY1zF8OZnxBWfNdVcuYRujqpyCz7PtpapDcplCa+MUyn1nT96ulGiqlANAGfHPMjg=
X-Gm-Message-State: AOJu0YwVA0zElpFbsoEBNYEuDRwmdxvD0EEzIAnNvogcaZrpBlbQCu1H
 N83QhQk1NPSraSMTjpOnX8jcqKgmAB2XRkhFoPg1Ol+1DF6UJZHUJIbhwHh1m7s=
X-Google-Smtp-Source: AGHT+IEXEZ5C+j8SvlMKabXYbxOkq06KSbWDFUS4yrcS+I/8jPzplQN0k2Qh+/nhDEmVoeN1IVMhkA==
X-Received: by 2002:a17:902:ea86:b0:1f6:38ba:ef56 with SMTP id
 d9443c01a7336-1f6938c50f7mr65697035ad.18.1717588177012; 
 Wed, 05 Jun 2024 04:49:37 -0700 (PDT)
Received: from [192.168.100.252] (59-124-168-89.hinet-ip.hinet.net.
 [59.124.168.89]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f63241e085sm100162435ad.299.2024.06.05.04.49.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 04:49:36 -0700 (PDT)
Message-ID: <072c16a6-2f06-4b57-aac9-7651ddb578ce@sifive.com>
Date: Wed, 5 Jun 2024 19:49:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/8] target/riscv: Support generic CSR indirect access
To: Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, kaiwenxue1@gmail.com
References: <20240217000134.3634191-1-atishp@rivosinc.com>
 <20240217000134.3634191-5-atishp@rivosinc.com>
Content-Language: en-US
From: Jason Chien <jason.chien@sifive.com>
In-Reply-To: <20240217000134.3634191-5-atishp@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=jason.chien@sifive.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The predicate functions should contain the access control by the 
state-enable CSRs, which is not presented in this patch. Do you mind 
that I take over the indirect CSR access control part? The Signed-off-by 
will be kept.

Atish Patra 於 2024/2/17 上午 08:01 寫道:
> From: Kaiwen Xue <kaiwenx@rivosinc.com>
>
> This adds the indirect access registers required by sscsrind/smcsrind
> and the operations on them. Note that xiselect and xireg are used for
> both AIA and sxcsrind, and the behavior of accessing them depends on
> whether each extension is enabled and the value stored in xiselect.
>
> Co-developed-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
> ---
>   target/riscv/cpu_bits.h |  28 +++++++-
>   target/riscv/csr.c      | 146 +++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 169 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 0ee91e502e8f..3a66f83009b5 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -176,6 +176,13 @@
>   #define CSR_MISELECT        0x350
>   #define CSR_MIREG           0x351
>   
> +/* Machine Indirect Register Alias */
> +#define CSR_MIREG2          0x352
> +#define CSR_MIREG3          0x353
> +#define CSR_MIREG4          0x355
> +#define CSR_MIREG5          0x356
> +#define CSR_MIREG6          0x357
> +
>   /* Machine-Level Interrupts (AIA) */
>   #define CSR_MTOPEI          0x35c
>   #define CSR_MTOPI           0xfb0
> @@ -225,6 +232,13 @@
>   #define CSR_SISELECT        0x150
>   #define CSR_SIREG           0x151
>   
> +/* Supervisor Indirect Register Alias */
> +#define CSR_SIREG2          0x152
> +#define CSR_SIREG3          0x153
> +#define CSR_SIREG4          0x155
> +#define CSR_SIREG5          0x156
> +#define CSR_SIREG6          0x157
> +
>   /* Supervisor-Level Interrupts (AIA) */
>   #define CSR_STOPEI          0x15c
>   #define CSR_STOPI           0xdb0
> @@ -291,6 +305,13 @@
>   #define CSR_VSISELECT       0x250
>   #define CSR_VSIREG          0x251
>   
> +/* Virtual Supervisor Indirect Alias */
> +#define CSR_VSIREG2         0x252
> +#define CSR_VSIREG3         0x253
> +#define CSR_VSIREG4         0x255
> +#define CSR_VSIREG5         0x256
> +#define CSR_VSIREG6         0x257
> +
>   /* VS-Level Interrupts (H-extension with AIA) */
>   #define CSR_VSTOPEI         0x25c
>   #define CSR_VSTOPI          0xeb0
> @@ -847,10 +868,13 @@ typedef enum RISCVException {
>   #define ISELECT_IMSIC_EIE63                0xff
>   #define ISELECT_IMSIC_FIRST                ISELECT_IMSIC_EIDELIVERY
>   #define ISELECT_IMSIC_LAST                 ISELECT_IMSIC_EIE63
> -#define ISELECT_MASK                       0x1ff
> +#define ISELECT_MASK_AIA                   0x1ff
> +
> +/* MISELECT, SISELECT, and VSISELECT bits (AIA) */
> +#define ISELECT_MASK_SXCSRIND              0xfff
Could you rename ISELECT_MASK_SXCSRIND to ISELECT_MASK_CSRIND to keep 
the naming consistency with ISELECT_MASK_AIA?
>   
>   /* Dummy [M|S|VS]ISELECT value for emulating [M|S|VS]TOPEI CSRs */
> -#define ISELECT_IMSIC_TOPEI                (ISELECT_MASK + 1)
> +#define ISELECT_IMSIC_TOPEI                (ISELECT_MASK_AIA + 1)
>   
>   /* IMSIC bits (AIA) */
>   #define IMSIC_TOPEI_IID_SHIFT              16
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 89a1325a02a5..a1c10f1d010a 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -287,6 +287,17 @@ static int aia_any32(CPURISCVState *env, int csrno)
>       return any32(env, csrno);
>   }
>   
> +static RISCVException sxcsrind_any(CPURISCVState *env, int csrno)
Could you rename sxcsrind_any() to csrind_any() to keep naming 
consistency with aia_any()?
> +{
> +    RISCVCPU *cpu = env_archcpu(env);
> +
> +    if (!cpu->cfg.ext_smcsrind) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return RISCV_EXCP_NONE;
> +}
> +
>   static int sxcsrind_or_aia_any(CPURISCVState *env, int csrno)
>   {
>       if (!riscv_cpu_cfg(env)->ext_smaia && !riscv_cpu_cfg(env)->ext_smcsrind) {
> @@ -355,6 +366,17 @@ static int aia_smode32(CPURISCVState *env, int csrno)
>       return smode32(env, csrno);
>   }
>   
> +static RISCVException sxcsrind_smode(CPURISCVState *env, int csrno)
Could you rename sxcsrind_smode() to csrind_smode() to keep naming 
consistency with aia_smode()?
> +{
> +    RISCVCPU *cpu = env_archcpu(env);
> +
> +    if (!cpu->cfg.ext_sscsrind) {
S-mode CSRs are defined in Smcsrind as well. If both Smcsrind and 
Sscsrind are disabled, return RISCV_EXCP_ILLEGAL_INST.
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
A virtual instruction exception should be raised here for attempts from 
VU-mode to access siselect or sireg*.
> +    return smode(env, csrno);
> +}
> +
>   static int sxcsrind_or_aia_smode(CPURISCVState *env, int csrno)
>   {
>       if (!riscv_cpu_cfg(env)->ext_ssaia && !riscv_cpu_cfg(env)->ext_sscsrind) {
> @@ -383,6 +405,17 @@ static RISCVException hmode32(CPURISCVState *env, int csrno)
>   
>   }
>   
> +static RISCVException sxcsrind_hmode(CPURISCVState *env, int csrno)
Could you rename sxcsrind_hmode() to csrind_hmode() to keep naming 
consistency with aia_hmode()?
> +{
> +    RISCVCPU *cpu = env_archcpu(env);
> +
> +    if (!cpu->cfg.ext_sscsrind) {
VS-mode CSRs are defined in Smcsrind as well. If both Smcsrind and 
Sscsrind are disabled, return RISCV_EXCP_ILLEGAL_INST.
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
> +    return hmode(env, csrno);
> +}
> +
>   static int sxcsrind_or_aia_hmode(CPURISCVState *env, int csrno)
>   {
>       if (!riscv_cpu_cfg(env)->ext_ssaia && !riscv_cpu_cfg(env)->ext_sscsrind) {
> @@ -1926,7 +1959,12 @@ static int rmw_xiselect(CPURISCVState *env, int csrno, target_ulong *val,
>           *val = *iselect;
>       }
>   
> -    wr_mask &= ISELECT_MASK;
> +    if (riscv_cpu_cfg(env)->ext_smcsrind || riscv_cpu_cfg(env)->ext_sscsrind) {
> +        wr_mask &= ISELECT_MASK_SXCSRIND;
> +    } else {
> +        wr_mask &= ISELECT_MASK_AIA;
> +    }
> +
>       if (wr_mask) {
>           *iselect = (*iselect & ~wr_mask) | (new_val & wr_mask);
>       }
> @@ -2065,6 +2103,59 @@ done:
>       return RISCV_EXCP_NONE;
>   }
>   
> +/*
> + * rmw_xireg_sxcsrind: Perform indirect access to xireg and xireg2-xireg6
> + *
> + * Perform indirect access to xireg and xireg2-xireg6.
> + * This is a generic interface for all xireg CSRs. Apart from AIA, all other
> + * extension using sxcsrind should be implemented here.
> + */
> +static int rmw_xireg_sxcsrind(CPURISCVState *env, int csrno,
> +                              target_ulong isel, target_ulong *val,
> +                              target_ulong new_val, target_ulong wr_mask)
Could you rename rmw_xireg_sxcsrind() to rmw_xireg_csrind() to keep the 
naming consistency with rmw_xireg_aia()?
> +{
> +    return -EINVAL;
> +}
> +
> +static int rmw_xiregi(CPURISCVState *env, int csrno, target_ulong *val,
> +                      target_ulong new_val, target_ulong wr_mask)
> +{
> +    bool virt = false;
> +    int ret = -EINVAL;
> +    target_ulong isel;
> +
> +    ret = smstateen_acc_ok(env, 0, SMSTATEEN0_SVSLCT);
> +    if (ret != RISCV_EXCP_NONE) {
> +        return ret;
> +    }
> +
> +    /* Translate CSR number for VS-mode */
> +    csrno = sxcsrind_xlate_vs_csrno(env, csrno);
> +
> +    if (CSR_MIREG <= csrno && csrno <= CSR_MIREG6 &&
> +        csrno != CSR_MIREG4 - 1) {
> +        isel = env->miselect;
> +    } else if (CSR_SIREG <= csrno && csrno <= CSR_SIREG6 &&
> +               csrno != CSR_SIREG4 - 1) {
> +        isel = env->siselect;
> +    } else if (CSR_VSIREG <= csrno && csrno <= CSR_VSIREG6 &&
> +               csrno != CSR_VSIREG4 - 1) {
> +        isel = env->vsiselect;
> +        virt = true;
> +    } else {
> +        goto done;
> +    }
> +
> +    return rmw_xireg_sxcsrind(env, csrno, isel, val, new_val, wr_mask);
> +
> +done:
> +    if (ret) {
> +        return (env->virt_enabled && virt) ?
A virtual instruction exception is raised for attempts from VS-mode or 
VU-mode to directly access vsiselect or vsireg* in riscv_csrrw_check(), 
we don't need to check again here.
> +               RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
> +    }
> +    return RISCV_EXCP_NONE;
> +}
> +
>   static int rmw_xireg(CPURISCVState *env, int csrno, target_ulong *val,
>                        target_ulong new_val, target_ulong wr_mask)
>   {
> @@ -2096,8 +2187,21 @@ static int rmw_xireg(CPURISCVState *env, int csrno, target_ulong *val,
>            goto done;
>       };
>   
> +    /*
> +     * Use the xiselect range to determine actual op on xireg.
> +     *
> +     * Since we only checked the existence of AIA or Indirect Access in the
> +     * predicate, we should check the existence of the exact extension when
> +     * we get to a specific range and return illegal instruction exception even
> +     * in VS-mode.
> +     */
>       if (xiselect_aia_range(isel)) {
>           return rmw_xireg_aia(env, csrno, isel, val, new_val, wr_mask);
> +    } else if (riscv_cpu_cfg(env)->ext_smcsrind ||
> +               riscv_cpu_cfg(env)->ext_sscsrind) {
> +        return rmw_xireg_sxcsrind(env, csrno, isel, val, new_val, wr_mask);
> +    } else {
> +        return RISCV_EXCP_ILLEGAL_INST;
>       }
>   
>   done:
> @@ -2480,7 +2584,7 @@ static RISCVException write_mstateen0(CPURISCVState *env, int csrno,
>        * TODO: Do we need to check ssaia as well ? Can we enable ssaia without
>        * smaia ?
>        */
> -    if (riscv_cpu_cfg(env)->ext_smaia) {
> +    if (riscv_cpu_cfg(env)->ext_smaia || riscv_cpu_cfg(env)->ext_smcsrind) {
>           wr_mask |= SMSTATEEN0_SVSLCT;
>       }
>   
> @@ -2569,7 +2673,7 @@ static RISCVException write_hstateen0(CPURISCVState *env, int csrno,
>           wr_mask |= SMSTATEEN0_FCSR;
>       }
>   
> -    if (riscv_cpu_cfg(env)->ext_ssaia) {
> +    if (riscv_cpu_cfg(env)->ext_ssaia || riscv_cpu_cfg(env)->ext_sscsrind) {
>           wr_mask |= SMSTATEEN0_SVSLCT;
>       }
>   
> @@ -4866,6 +4970,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_MIREG]    = { "mireg",    sxcsrind_or_aia_any,   NULL, NULL,
>                          rmw_xireg                                       },
>   
> +    /* Machine Indirect Register Alias */
> +    [CSR_MIREG2]   = { "mireg2", sxcsrind_any, NULL, NULL, rmw_xiregi,
> +                       .min_priv_ver = PRIV_VERSION_1_12_0          },
> +    [CSR_MIREG3]   = { "mireg3", sxcsrind_any, NULL, NULL, rmw_xiregi,
> +                       .min_priv_ver = PRIV_VERSION_1_12_0          },
> +    [CSR_MIREG4]   = { "mireg4", sxcsrind_any, NULL, NULL, rmw_xiregi,
> +                       .min_priv_ver = PRIV_VERSION_1_12_0          },
> +    [CSR_MIREG5]   = { "mireg5", sxcsrind_any, NULL, NULL, rmw_xiregi,
> +                       .min_priv_ver = PRIV_VERSION_1_12_0          },
> +    [CSR_MIREG6]   = { "mireg6", sxcsrind_any, NULL, NULL, rmw_xiregi,
> +                       .min_priv_ver = PRIV_VERSION_1_12_0          },
> +
>       /* Machine-Level Interrupts (AIA) */
>       [CSR_MTOPEI]   = { "mtopei",   aia_any, NULL, NULL, rmw_xtopei },
>       [CSR_MTOPI]    = { "mtopi",    aia_any, read_mtopi },
> @@ -4987,6 +5103,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_SIREG]      = { "sireg",      sxcsrind_or_aia_smode, NULL, NULL,
>                            rmw_xireg                                          },
>   
> +    /* Supervisor Indirect Register Alias */
> +    [CSR_SIREG2]      = { "sireg2", sxcsrind_smode, NULL, NULL, rmw_xiregi,
> +                          .min_priv_ver = PRIV_VERSION_1_12_0                },
> +    [CSR_SIREG3]      = { "sireg3", sxcsrind_smode, NULL, NULL, rmw_xiregi,
> +                          .min_priv_ver = PRIV_VERSION_1_12_0                },
> +    [CSR_SIREG4]      = { "sireg4", sxcsrind_smode, NULL, NULL, rmw_xiregi,
> +                          .min_priv_ver = PRIV_VERSION_1_12_0                },
> +    [CSR_SIREG5]      = { "sireg5", sxcsrind_smode, NULL, NULL, rmw_xiregi,
> +                          .min_priv_ver = PRIV_VERSION_1_12_0                },
> +    [CSR_SIREG6]      = { "sireg6", sxcsrind_smode, NULL, NULL, rmw_xiregi,
> +                          .min_priv_ver = PRIV_VERSION_1_12_0                },
> +
>       /* Supervisor-Level Interrupts (AIA) */
>       [CSR_STOPEI]     = { "stopei",     aia_smode, NULL, NULL, rmw_xtopei },
>       [CSR_STOPI]      = { "stopi",      aia_smode, read_stopi },
> @@ -5069,6 +5197,18 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>       [CSR_VSIREG]      = { "vsireg",      sxcsrind_or_aia_hmode, NULL, NULL,
>                             rmw_xireg                                         },
>   
> +    /* Virtual Supervisor Indirect Alias */
> +    [CSR_VSIREG2]     = { "vsireg2", sxcsrind_hmode, NULL, NULL, rmw_xiregi,
> +                          .min_priv_ver = PRIV_VERSION_1_12_0                },
> +    [CSR_VSIREG3]     = { "vsireg3", sxcsrind_hmode, NULL, NULL, rmw_xiregi,
> +                          .min_priv_ver = PRIV_VERSION_1_12_0                },
> +    [CSR_VSIREG4]     = { "vsireg4", sxcsrind_hmode, NULL, NULL, rmw_xiregi,
> +                          .min_priv_ver = PRIV_VERSION_1_12_0                },
> +    [CSR_VSIREG5]     = { "vsireg5", sxcsrind_hmode, NULL, NULL, rmw_xiregi,
> +                          .min_priv_ver = PRIV_VERSION_1_12_0                },
> +    [CSR_VSIREG6]     = { "vsireg6", sxcsrind_hmode, NULL, NULL, rmw_xiregi,
> +                          .min_priv_ver = PRIV_VERSION_1_12_0                },
> +
>       /* VS-Level Interrupts (H-extension with AIA) */
>       [CSR_VSTOPEI]     = { "vstopei",     aia_hmode, NULL, NULL, rmw_xtopei },
>       [CSR_VSTOPI]      = { "vstopi",      aia_hmode, read_vstopi },

