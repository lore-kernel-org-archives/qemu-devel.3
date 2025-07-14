Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6254C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 22:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubRiO-0006vD-I6; Mon, 14 Jul 2025 18:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubRWx-0005i2-Dh
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 18:20:16 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubRWt-0002vK-Ch
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 18:20:14 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4537edf2c3cso49942675e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 15:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752531609; x=1753136409; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7MREfJTnMiCwLWnp7lb9ARgJpNsELprk/Ykka5WjB7o=;
 b=ulFsIA9hOs7ZjLlayO7AEiw5xiZ7lyCbnwafZsoLjuufDn3KWDw8UzuJftbNtkmZj8
 YiVS/LtBkoyxAtcuYkp8v4ZKwg3xSQ0fHlV5n10zjOvytMC5RHClpvJ/+LfHtEkCW++7
 RwblBWlZUZtqY8CnfrMAlNEWUKvaMK2Uj9ceSAef6P/xiJtfzd338NQ504eF6b3bgfRJ
 RiyjZjP7lCE12cOLgirrP6+x5FAKWDetLsVBUugCykOb36ognNRiFEF4yOaVhANvdSEk
 JdldWhmj7Or1V1C3lcek8RXU5jRExmhHeUdvfPamA3ydb0aFrYgNkQ1OlAVgj0xQzlFz
 ik9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752531609; x=1753136409;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7MREfJTnMiCwLWnp7lb9ARgJpNsELprk/Ykka5WjB7o=;
 b=rJMBw786sWPZdzohFCtsTEM3IxIHd5JDHS/tc3u8WpxPWWjonnNWm+99cWbXfOk67v
 O2fF4uTuk+iUn0Aab70j/ca+5wzEZd7T58XLWLby+iPuTZisJXsU8Ew7fqsdy1CLExmT
 U8sgnJlutYI97WiYow9w7LqlUCZjM/fTeiUrpM+GIVzlqlNb2jW5V9DGS5JrmeIsly2j
 wodGt0MHOifopLQAZgQ2CJ6D27BA7WQt5lJX8VhS8vNyu+ssM5qMKq5wc55kHUN8v/PF
 NawLiNufWTfBzTQDkDWGql8b9d9cnu0FgrTGafoQQV6VcGa2lTNyUefacwU1Y92BmbAQ
 octw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSeWFBn7GDstSx0p6tOD4zKGjNk+IA0Z7Tc79JC8rI7DrOjUBU4eqJhdzaYGxMcNtRkMFcVkdktYQ0@nongnu.org
X-Gm-Message-State: AOJu0YzYBGbRWBhSFUBTDfBlePlZ0JCFTZmV+DFAwXezvw/pyTfhjNBF
 GLl5BzpYWkMrn3yovwgLQDp6AMJkBJwJDFCvJCmdaobDQmVGOfbDVy5XMjAIdXaVFhM=
X-Gm-Gg: ASbGncvzddjiFEoF9Upqp+FduY7AB5SiceJnpi+vjNX0ZnJ38YtYYiGW580LmOjQksx
 lKEGl8NtNLueei+FUXvqNL6xc9UzcrnWMEzz/l9GUHN3/m3qG2pHCtPLQ9OiVMlDaII183aei3Q
 hzQUkLdvhB+gUBkP+LBD9u9cATYQay4lRJZl2lVMAdI2CpEtvMnsLWLZlkc1HNsQitqNKuk1w9N
 H2k0ZB59zszG3q6uXYzIN5Ou2BtoivO2iB2qAs88ZeedTdjfBQOStyNinF8yZvPK+R9NkTjyfP3
 xNTFqHNPlFNLCX2wWWm/ObpL4i1To1sMvgIJ5UTFU5K4K7x9NRM61gbWOtV2cLnvunvx6kId19P
 7JYXLfzMWPetpXGoJ6Yt/bhGc4pCJTtmtt7qCLFXtgHLQczaUtC5+sDMEpfOZ+2j54Pf4gO0=
X-Google-Smtp-Source: AGHT+IE3IdTd1iakBVfrjpKMEavVGQtF9WkU2f88OlCTRgypq4Gr281unmQE7dPXd01wBT1ToBdVCA==
X-Received: by 2002:a05:600c:620f:b0:453:8bc7:5cbb with SMTP id
 5b1f17b1804b1-4562751b34bmr2485185e9.25.1752531608772; 
 Mon, 14 Jul 2025 15:20:08 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd18a2sm13347770f8f.20.2025.07.14.15.20.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 15:20:08 -0700 (PDT)
Message-ID: <f6d3416d-6a16-4685-ba63-a4ea83ea486b@linaro.org>
Date: Tue, 15 Jul 2025 00:20:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-5.1 V4 2/4] target/mips: Add Loongson-3 CPU definition
To: Huacai Chen <zltjiangshi@gmail.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
References: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
 <1591065557-9174-3-git-send-email-chenhc@lemote.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <1591065557-9174-3-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

(this is now commit af868995e1b7641577300d1342ede452ef0c5565)

On 2/6/20 04:39, Huacai Chen wrote:
> Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson-3B
> R1/R2. Loongson-3A R1 is the oldest and its ISA is the smallest, while
> Loongson-3A R4 is the newest and its ISA is almost the superset of all
> others. To reduce complexity, we just define two CPU types:
> 1, "Loongson-3A1000" CPU which is corresponding to Loongson-3A R1. It is
>     suitable for TCG because Loongson-3A R1 has fewest ASE.
> 2, "Loongson-3A4000" CPU which is corresponding to Loongson-3A R4. It is
>     suitable for KVM because Loongson-3A R4 has the VZ ASE.
> 
> Loongson-3A has CONFIG6 and CONFIG7, so add their bit-fields as well.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   target/mips/cpu.h                | 28 +++++++++++++
>   target/mips/internal.h           |  2 +
>   target/mips/mips-defs.h          |  7 +++-
>   target/mips/translate.c          |  2 +
>   target/mips/translate_init.inc.c | 86 ++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 123 insertions(+), 2 deletions(-)
> 
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 94d01ea..0b3c987 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -940,7 +940,35 @@ struct CPUMIPSState {
>   #define CP0C5_UFR          2
>   #define CP0C5_NFExists     0
>       int32_t CP0_Config6;
> +    int32_t CP0_Config6_rw_bitmask;
> +#define CP0C6_BPPASS          31
> +#define CP0C6_KPOS            24
> +#define CP0C6_KE              23
> +#define CP0C6_VTLBONLY        22
> +#define CP0C6_LASX            21
> +#define CP0C6_SSEN            20
> +#define CP0C6_DISDRTIME       19
> +#define CP0C6_PIXNUEN         18
> +#define CP0C6_SCRAND          17
> +#define CP0C6_LLEXCEN         16
> +#define CP0C6_DISVC           15
> +#define CP0C6_VCLRU           14
> +#define CP0C6_DCLRU           13
> +#define CP0C6_PIXUEN          12
> +#define CP0C6_DISBLKLYEN      11
> +#define CP0C6_UMEMUALEN       10
> +#define CP0C6_SFBEN           8
> +#define CP0C6_FLTINT          7
> +#define CP0C6_VLTINT          6
> +#define CP0C6_DISBTB          5
> +#define CP0C6_STPREFCTL       2
> +#define CP0C6_INSTPREF        1
> +#define CP0C6_DATAPREF        0
>       int32_t CP0_Config7;
> +    int64_t CP0_Config7_rw_bitmask;
> +#define CP0C7_NAPCGEN       2
> +#define CP0C7_UNIMUEN       1
> +#define CP0C7_VFPUCGEN      0
>       uint64_t CP0_LLAddr;
>       uint64_t CP0_MAAR[MIPS_MAAR_MAX];
>       int32_t CP0_MAARI;
> diff --git a/target/mips/internal.h b/target/mips/internal.h
> index 1bf274b..7853cb1 100644
> --- a/target/mips/internal.h
> +++ b/target/mips/internal.h
> @@ -36,7 +36,9 @@ struct mips_def_t {
>       int32_t CP0_Config5;
>       int32_t CP0_Config5_rw_bitmask;
>       int32_t CP0_Config6;
> +    int32_t CP0_Config6_rw_bitmask;
>       int32_t CP0_Config7;
> +    int32_t CP0_Config7_rw_bitmask;
>       target_ulong CP0_LLAddr_rw_bitmask;
>       int CP0_LLAddr_shift;
>       int32_t SYNCI_Step;
> diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
> index a831bb4..c2c96db 100644
> --- a/target/mips/mips-defs.h
> +++ b/target/mips/mips-defs.h
> @@ -51,8 +51,9 @@
>    */
>   #define INSN_LOONGSON2E   0x0001000000000000ULL
>   #define INSN_LOONGSON2F   0x0002000000000000ULL
> -#define INSN_VR54XX       0x0004000000000000ULL
> -#define INSN_R5900        0x0008000000000000ULL
> +#define INSN_LOONGSON3A   0x0004000000000000ULL
> +#define INSN_VR54XX       0x0008000000000000ULL
> +#define INSN_R5900        0x0010000000000000ULL
>   /*
>    *   bits 56-63: vendor-specific ASEs
>    */
> @@ -94,6 +95,8 @@
>   /* Wave Computing: "nanoMIPS" */
>   #define CPU_NANOMIPS32  (CPU_MIPS32R6 | ISA_NANOMIPS32)
>   
> +#define CPU_LOONGSON3A  (CPU_MIPS64R2 | INSN_LOONGSON3A)
> +
>   /*
>    * Strictly follow the architecture standard:
>    * - Disallow "special" instruction handling for PMON/SPIM.
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index 25b595a..2caf4cb 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -31206,7 +31206,9 @@ void cpu_state_reset(CPUMIPSState *env)
>       env->CP0_Config5 = env->cpu_model->CP0_Config5;
>       env->CP0_Config5_rw_bitmask = env->cpu_model->CP0_Config5_rw_bitmask;
>       env->CP0_Config6 = env->cpu_model->CP0_Config6;
> +    env->CP0_Config6_rw_bitmask = env->cpu_model->CP0_Config6_rw_bitmask;
>       env->CP0_Config7 = env->cpu_model->CP0_Config7;
> +    env->CP0_Config7_rw_bitmask = env->cpu_model->CP0_Config7_rw_bitmask;
>       env->CP0_LLAddr_rw_bitmask = env->cpu_model->CP0_LLAddr_rw_bitmask
>                                    << env->cpu_model->CP0_LLAddr_shift;
>       env->CP0_LLAddr_shift = env->cpu_model->CP0_LLAddr_shift;
> diff --git a/target/mips/translate_init.inc.c b/target/mips/translate_init.inc.c
> index 6d145a9..a31f229 100644
> --- a/target/mips/translate_init.inc.c
> +++ b/target/mips/translate_init.inc.c
> @@ -802,6 +802,92 @@ const mips_def_t mips_defs[] =
>           .mmu_type = MMU_TYPE_R4000,
>       },
>       {
> +        .name = "Loongson-3A1000",
> +        .CP0_PRid = 0x6305,
> +        /* 64KB I-cache and d-cache. 4 way with 32 bit cache line size.  */
> +        .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP0C0_AT) |
> +                       (MMU_TYPE_R4000 << CP0C0_MT),
> +        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) | (63 << CP0C1_MMU) |
> +                       (3 << CP0C1_IS) | (4 << CP0C1_IL) | (3 << CP0C1_IA) |
> +                       (3 << CP0C1_DS) | (4 << CP0C1_DL) | (3 << CP0C1_DA) |
> +                       (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
> +        .CP0_Config2 = MIPS_CONFIG2 | (7 << CP0C2_SS) | (4 << CP0C2_SL) |
> +                       (3 << CP0C2_SA),
> +        .CP0_Config3 = MIPS_CONFIG3 | (1 << CP0C3_LPA),
> +        .CP0_LLAddr_rw_bitmask = 0,
> +        .SYNCI_Step = 32,
> +        .CCRes = 2,
> +        .CP0_Status_rw_bitmask = 0x74D8FFFF,
> +        .CP0_PageGrain = (1 << CP0PG_ELPA),
> +        .CP0_PageGrain_rw_bitmask = (1 << CP0PG_ELPA),
> +        .CP1_fcr0 = (0x5 << FCR0_PRID) | (0x1 << FCR0_REV) | (0x1 << FCR0_F64) |
> +                    (0x1 << FCR0_PS) | (0x1 << FCR0_L) | (0x1 << FCR0_W) |
> +                    (0x1 << FCR0_D) | (0x1 << FCR0_S),
> +        .CP1_fcr31 = 0,
> +        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
> +        .SEGBITS = 42,
> +        .PABITS = 48,
> +        .insn_flags = CPU_LOONGSON3A,
> +        .mmu_type = MMU_TYPE_R4000,
> +    },
> +    {
> +        .name = "Loongson-3A4000",
> +        .CP0_PRid = 0x14C000,
> +        /* 64KB I-cache and d-cache. 4 way with 32 bit cache line size.  */
> +        .CP0_Config0 = MIPS_CONFIG0 | (0x1 << CP0C0_AR) | (0x2 << CP0C0_AT) |
> +                       (MMU_TYPE_R4000 << CP0C0_MT),
> +        .CP0_Config1 = MIPS_CONFIG1 | (1 << CP0C1_FP) | (63 << CP0C1_MMU) |
> +                       (2 << CP0C1_IS) | (5 << CP0C1_IL) | (3 << CP0C1_IA) |
> +                       (2 << CP0C1_DS) | (5 << CP0C1_DL) | (3 << CP0C1_DA) |
> +                       (1 << CP0C1_PC) | (1 << CP0C1_WR) | (1 << CP0C1_EP),
> +        .CP0_Config2 = MIPS_CONFIG2 | (5 << CP0C2_SS) | (5 << CP0C2_SL) |
> +                       (15 << CP0C2_SA),
> +        .CP0_Config3 = MIPS_CONFIG3 | (1U << CP0C3_M) | (1 << CP0C3_MSAP) |
> +                       (1 << CP0C3_BP) | (1 << CP0C3_BI) | (1 << CP0C3_ULRI) |
> +                       (1 << CP0C3_RXI) | (1 << CP0C3_LPA) | (1 << CP0C3_VInt),
> +        .CP0_Config4 = MIPS_CONFIG4 | (1U << CP0C4_M) | (2 << CP0C4_IE) |
> +                       (1 << CP0C4_AE) | (0x1c << CP0C4_KScrExist),
> +        .CP0_Config4_rw_bitmask = 0,
> +        .CP0_Config5 = MIPS_CONFIG5 | (1 << CP0C5_CRCP) | (1 << CP0C5_NFExists),

I note for Loongson-3A4000 we expose CP0C5_CRCP (CRC32 present) but
since then this feature is not implemented. This is hard to track;
a comment would have been welcomed.

Regards,

Phil.

> +        .CP0_Config5_rw_bitmask = (1 << CP0C5_K) | (1 << CP0C5_CV) |
> +                                  (1 << CP0C5_MSAEn) | (1 << CP0C5_UFE) |
> +                                  (1 << CP0C5_FRE) | (1 << CP0C5_SBRI),
> +        .CP0_Config6 = (1 << CP0C6_VCLRU) | (1 << CP0C6_DCLRU) |
> +                       (1 << CP0C6_SFBEN) | (1 << CP0C6_VLTINT) |
> +                       (1 << CP0C6_INSTPREF) | (1 << CP0C6_DATAPREF),
> +        .CP0_Config6_rw_bitmask = (1 << CP0C6_BPPASS) | (0x3f << CP0C6_KPOS) |
> +                                  (1 << CP0C6_KE) | (1 << CP0C6_VTLBONLY) |
> +                                  (1 << CP0C6_LASX) | (1 << CP0C6_SSEN) |
> +                                  (1 << CP0C6_DISDRTIME) | (1 << CP0C6_PIXNUEN) |
> +                                  (1 << CP0C6_SCRAND) | (1 << CP0C6_LLEXCEN) |
> +                                  (1 << CP0C6_DISVC) | (1 << CP0C6_VCLRU) |
> +                                  (1 << CP0C6_DCLRU) | (1 << CP0C6_PIXUEN) |
> +                                  (1 << CP0C6_DISBLKLYEN) | (1 << CP0C6_UMEMUALEN) |
> +                                  (1 << CP0C6_SFBEN) | (1 << CP0C6_FLTINT) |
> +                                  (1 << CP0C6_VLTINT) | (1 << CP0C6_DISBTB) |
> +                                  (3 << CP0C6_STPREFCTL) | (1 << CP0C6_INSTPREF) |
> +                                  (1 << CP0C6_DATAPREF),
> +        .CP0_Config7 = 0,
> +        .CP0_Config7_rw_bitmask = (1 << CP0C7_NAPCGEN) | (1 << CP0C7_UNIMUEN) |
> +                                  (1 << CP0C7_VFPUCGEN),
> +        .CP0_LLAddr_rw_bitmask = 1,
> +        .SYNCI_Step = 16,
> +        .CCRes = 2,
> +        .CP0_Status_rw_bitmask = 0x7DDBFFFF,
> +        .CP0_PageGrain = (1 << CP0PG_ELPA),
> +        .CP0_PageGrain_rw_bitmask = (1U << CP0PG_RIE) | (1 << CP0PG_XIE) |
> +                    (1 << CP0PG_ELPA) | (1 << CP0PG_IEC),
> +        .CP1_fcr0 = (0x5 << FCR0_PRID) | (0x1 << FCR0_REV) | (0x1 << FCR0_F64) |
> +                    (0x1 << FCR0_PS) | (0x1 << FCR0_L) | (0x1 << FCR0_W) |
> +                    (0x1 << FCR0_D) | (0x1 << FCR0_S),
> +        .CP1_fcr31 = 0,
> +        .CP1_fcr31_rw_bitmask = 0xFF83FFFF,
> +        .SEGBITS = 48,
> +        .PABITS = 48,
> +        .insn_flags = CPU_LOONGSON3A,
> +        .mmu_type = MMU_TYPE_R4000,
> +    },
> +    {
>           /* A generic CPU providing MIPS64 DSP R2 ASE features.
>              FIXME: Eventually this should be replaced by a real CPU model. */
>           .name = "mips64dspr2",


