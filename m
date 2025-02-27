Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B112C197BF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 03:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnUYn-0007tI-1u; Wed, 26 Feb 2025 22:27:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnUYl-0007sy-D4; Wed, 26 Feb 2025 22:27:39 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnUYj-0005X9-1l; Wed, 26 Feb 2025 22:27:39 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2fc1843495eso814326a91.1; 
 Wed, 26 Feb 2025 19:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740626855; x=1741231655; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GtGmvabqvG7R4tF49ELlLiPLkwO0jEQoHMdWez5qohE=;
 b=PQD0PxlLCc9+IXGAzN+Av5ZBAtImQUe7cbbLoVkjOk6sxsVlmDrE8t9FoMN9iwVRL6
 Uqwh84XWmjSIYVlf9vEO0zmyCZ8AfqnHc6sKCPxVxaVPDsWyWTqdj0jyE1/Rs8MzlDGp
 9xhlFlGxUx/hZZb0TNuOnmuP6bdMj/L50QmLzoMmdY2sVUiUwIZwWa8KKIda4qbjqrkB
 FLg9EErU5rG6D0ZBlJKgiCO2Vitj8rhPqxLy+r4qbANUFtqT9Uc3Wpf2Fy5bRuH6AvVM
 UgDhmW2w3BqDYPhPwZfgwPnVTPGvdPB6Rt2uzE0jmBVy7BZ/l2aGKhNUru52BNkayB2e
 y3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740626855; x=1741231655;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GtGmvabqvG7R4tF49ELlLiPLkwO0jEQoHMdWez5qohE=;
 b=JUA/vXYm8KTqTt914IW+O7FnpKGyxFY+g+2UmdHVKgpSJT8B4PG19b6FaL4l07AhWf
 7ClBYNzpbp5BsPILnPtY/ClHE0dJG1CXo4PC+8eAyBhDBWdvLs1ArDJqT3Pvql251YNC
 5T7ow/stL+6HbgQlbIiqduipv5G9l92VhBNkbqIuvNn0LB0s6c5p4hDxHIbGYXUTEu33
 C0BHnRFjQPCMCksLPS2ypLV4xKkjNT+BuxHdKsu23coRjOtMfWGFMFI5eJsjlcumlqNL
 cGQEyy6+Xn4OLyGQda5ezT1WwNXqtpZ2XL+k6vF/W8oACk8vXZhuFBukO6m/58MbvkI2
 NaYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDbCy2cHa+PjX2wOkJ++VQ7FRj+7SuEqOMdMqW4QGP8vosMYTpJqbcKFWPTdG01++vpwIdG7rmmtWd@nongnu.org
X-Gm-Message-State: AOJu0YxOCzLULD3fzhT8+GDuqfqp5RL2mMcjTuMBxsrpbskQ00cOMAkz
 NHCkPGKu72xmEG/XoHO2hjb6So9Bs75irXz8NvAGAETyXzHqbxI6ibyWeQ==
X-Gm-Gg: ASbGnct5pNCRt2H69gy7RDV3G0R7bZKf1nQjrTipLyR40L/Y9bIPQ9K2Vqlaey2b4d4
 PZx3aCwwc+ryaZdLHhslcROaKo1R9Vs/BTyShuYaX+TPSThMm7yTmdNNFrsn6lvcrJExNdvC4Yu
 8TA3jQVNwzsyoUzKqHl5+taOqmo7dbu/FOmlo+I1KBnquhV+FhMCbR3lRCm/jZmseWT1wW41JVm
 iljS27KcM2apWQLwF0vE4MePZ6EUhvSvr9giGMrZiR0oppS5nA+B9y54mA/eLNPPsOHLQiV/fPX
 kUdM2Kcp3JVjjIOdSg==
X-Google-Smtp-Source: AGHT+IEX3Etrjc29q9gpP73j9zZ04SJ3uV2wcYy8Z07c9BVozsklfMpedQP7aRQ67BX+mc2tApE5jg==
X-Received: by 2002:a17:90b:1a88:b0:2ee:aa95:6de9 with SMTP id
 98e67ed59e1d1-2fce7b237cemr40982418a91.33.1740626855063; 
 Wed, 26 Feb 2025 19:27:35 -0800 (PST)
Received: from localhost ([1.146.90.134]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea6990030sm360027a91.44.2025.02.26.19.27.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 19:27:34 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 13:27:28 +1000
Message-Id: <D82WPYZ2R1DS.2JC91G6HRY0U7@gmail.com>
Cc: <qemu-ppc@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>,
 "Sourabh Jain" <sourabhjain@linux.ibm.com>, "Mahesh J Salgaonkar"
 <mahesh@linux.ibm.com>, "Hari Bathini" <hbathini@linux.ibm.com>
Subject: Re: [PATCH 4/6] hw/ppc: Implement saving CPU state in Fadump
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Aditya Gupta" <adityag@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250217071711.83735-1-adityag@linux.ibm.com>
 <20250217071711.83735-5-adityag@linux.ibm.com>
In-Reply-To: <20250217071711.83735-5-adityag@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon Feb 17, 2025 at 5:17 PM AEST, Aditya Gupta wrote:
> Kernel expects CPU states/register states in the format mentioned in
> "Register Save Area" in PAPR.
>
> The platform (in our case, QEMU) saves each CPU register in the form of
> an array of "register entries", the start and end of this array is
> signified by "CPUSTRT" and "CPUEND" register entries respectively.
>
> The CPUSTRT and CPUEND register entry also has 4-byte logical CPU ID,
> thus storing the CPU ID corresponding to the array of register entries.
>
> Each register, and CPUSTRT, CPUEND has a predefined identifier.
> Implement calculating identifier for a given register in
> 'fadump_str_to_u64', which has been taken from the linux kernel
>
> Similarly GPRs also have predefined identifiers, and a corresponding
> 64-bit resiter value (split into two 32-bit cells). Implement
> calculation of GPR identifiers with 'fadump_gpr_id_to_u64'
>
> PAPR has restrictions on particular order of few registers, and is
> free to be in any order for other registers.
> Some registers mentioned in PAPR have not been exported as they are not
> implemented in QEMU / don't make sense in QEMU.
>
> Implement saving of CPU state according to the PAPR document
>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>  hw/ppc/spapr_rtas.c    | 200 ++++++++++++++++++++++++++++++++++++++++-
>  include/hw/ppc/spapr.h |  83 +++++++++++++++++
>  2 files changed, 281 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
> index 9b29cadab2c9..0aca4270aee8 100644
> --- a/hw/ppc/spapr_rtas.c
> +++ b/hw/ppc/spapr_rtas.c
> @@ -348,9 +348,12 @@ bool is_next_boot_fadump;
>  static bool fadump_preserve_mem(void)
>  {
>      struct rtas_fadump_mem_struct *fdm =3D &fadump_metadata.registered_f=
dm;
> +    struct rtas_fadump_section *cpu_state_region;
>      uint64_t next_section_addr;
>      int dump_num_sections, data_type;
>      uint64_t src_addr, src_len, dest_addr;
> +    uint64_t cpu_state_addr, cpu_state_len =3D 0;
> +    void *cpu_state_buffer;
>      void *copy_buffer;
> =20
>      assert(fadump_metadata.fadump_registered);
> @@ -413,9 +416,174 @@ static bool fadump_preserve_mem(void)
>          }
> =20
>          switch (data_type) {
> -        case FADUMP_CPU_STATE_DATA:
> -            /* TODO: Add CPU state data */
> +        case FADUMP_CPU_STATE_DATA: {

I would split these out into their own functions if they grow more than
a few lines.

> +            struct rtas_fadump_reg_save_area_header reg_save_hdr;
> +            struct rtas_fadump_reg_entry **reg_entries;
> +            struct rtas_fadump_reg_entry *curr_reg_entry;
> +
> +            uint32_t fadump_reg_entries_size;
> +            __be32 num_cpus =3D 0;
> +            uint32_t num_regs_per_cpu =3D 0;
> +            CPUState *cpu;
> +            CPUPPCState *env;
> +            PowerPCCPU *ppc_cpu;
> +
> +            CPU_FOREACH(cpu) {
> +                ++num_cpus;
> +            }
> +
> +            reg_save_hdr.version =3D cpu_to_be32(1);
> +            reg_save_hdr.magic_number =3D
> +                cpu_to_be64(fadump_str_to_u64("REGSAVE"));
> +
> +            /* Reg save area header is immediately followed by num cpus =
*/
> +            reg_save_hdr.num_cpu_offset =3D
> +                cpu_to_be32(sizeof(struct rtas_fadump_reg_save_area_head=
er));
> +
> +            fadump_reg_entries_size =3D num_cpus *
> +                                      FADUMP_NUM_PER_CPU_REGS *
> +                                      sizeof(struct rtas_fadump_reg_entr=
y);
> +
> +            reg_entries =3D malloc(fadump_reg_entries_size);
> +            curr_reg_entry =3D (struct rtas_fadump_reg_entry *)reg_entri=
es;
> +
> +            /* This must loop num_cpus time */
> +            CPU_FOREACH(cpu) {
> +                ppc_cpu =3D POWERPC_CPU(cpu);
> +                env =3D cpu_env(cpu);
> +                num_regs_per_cpu =3D 0;
> +
> +                curr_reg_entry->reg_id =3D
> +                    cpu_to_be64(fadump_str_to_u64("CPUSTRT"));
> +                curr_reg_entry->reg_value =3D ppc_cpu->vcpu_id;
> +                ++curr_reg_entry;
> +
> +#define REG_ENTRY(id, val)                                     \
> +                do {                                           \
> +                    curr_reg_entry->reg_id =3D                   \
> +                        cpu_to_be64(fadump_str_to_u64(#id));   \
> +                    curr_reg_entry->reg_value =3D val;           \
> +                    ++curr_reg_entry;                          \
> +                    ++num_regs_per_cpu;                        \
> +                } while (0)
> +
> +                REG_ENTRY(ACOP, env->spr[SPR_ACOP]);
> +                REG_ENTRY(AMR, env->spr[SPR_AMR]);
> +                REG_ENTRY(BESCR, env->spr[SPR_BESCR]);
> +                REG_ENTRY(CFAR, env->spr[SPR_CFAR]);
> +                REG_ENTRY(CIABR, env->spr[SPR_CIABR]);
> +
> +                /* Save the condition register */
> +                uint64_t cr =3D 0;
> +                cr |=3D (env->crf[0] & 0xf);
> +                cr |=3D (env->crf[1] & 0xf) << 1;
> +                cr |=3D (env->crf[2] & 0xf) << 2;
> +                cr |=3D (env->crf[3] & 0xf) << 3;
> +                cr |=3D (env->crf[4] & 0xf) << 4;
> +                cr |=3D (env->crf[5] & 0xf) << 5;
> +                cr |=3D (env->crf[6] & 0xf) << 6;
> +                cr |=3D (env->crf[7] & 0xf) << 7;

Shift values wrong here I think... Use ppc_get_cr()

> +                REG_ENTRY(CR, cr);
> +
> +                REG_ENTRY(CTR, env->spr[SPR_CTR]);
> +                REG_ENTRY(CTRL, env->spr[SPR_CTRL]);
> +                REG_ENTRY(DABR, env->spr[SPR_DABR]);
> +                REG_ENTRY(DABRX, env->spr[SPR_DABRX]);
> +                REG_ENTRY(DAR, env->spr[SPR_DAR]);
> +                REG_ENTRY(DAWR0, env->spr[SPR_DAWR0]);
> +                REG_ENTRY(DAWR1, env->spr[SPR_DAWR1]);
> +                REG_ENTRY(DAWRX0, env->spr[SPR_DAWRX0]);
> +                REG_ENTRY(DAWRX1, env->spr[SPR_DAWRX1]);
> +                REG_ENTRY(DPDES, env->spr[SPR_DPDES]);
> +                REG_ENTRY(DSCR, env->spr[SPR_DSCR]);
> +                REG_ENTRY(DSISR, env->spr[SPR_DSISR]);
> +                REG_ENTRY(EBBHR, env->spr[SPR_EBBHR]);
> +                REG_ENTRY(EBBRR, env->spr[SPR_EBBRR]);
> +
> +                REG_ENTRY(FPSCR, env->fpscr);
> +                REG_ENTRY(FSCR, env->spr[SPR_FSCR]);
> +
> +                /* Save the GPRs */
> +                for (int gpr_id =3D 0; gpr_id < 32; ++gpr_id) {
> +                    curr_reg_entry->reg_id =3D
> +                        cpu_to_be64(fadump_gpr_id_to_u64(gpr_id));
> +                    curr_reg_entry->reg_value =3D env->gpr[i];
> +                    ++curr_reg_entry;
> +                    ++num_regs_per_cpu;
> +                }
> +
> +                REG_ENTRY(IAMR, env->spr[SPR_IAMR]);
> +                REG_ENTRY(IC, env->spr[SPR_IC]);
> +                REG_ENTRY(LR, env->spr[SPR_LR]);
> +
> +                REG_ENTRY(MSR, env->msr);
> +                REG_ENTRY(NIA, env->nip);   /* NIA */
> +                REG_ENTRY(PIR, env->spr[SPR_PIR]);
> +                REG_ENTRY(PSPB, env->spr[SPR_PSPB]);
> +                REG_ENTRY(PVR, env->spr[SPR_PVR]);
> +                REG_ENTRY(RPR, env->spr[SPR_RPR]);
> +                REG_ENTRY(SPURR, env->spr[SPR_SPURR]);
> +                REG_ENTRY(SRR0, env->spr[SPR_SRR0]);
> +                REG_ENTRY(SRR1, env->spr[SPR_SRR1]);
> +                REG_ENTRY(TAR, env->spr[SPR_TAR]);
> +                REG_ENTRY(TEXASR, env->spr[SPR_TEXASR]);
> +                REG_ENTRY(TFHAR, env->spr[SPR_TFHAR]);
> +                REG_ENTRY(TFIAR, env->spr[SPR_TFIAR]);
> +                REG_ENTRY(TIR, env->spr[SPR_TIR]);
> +                REG_ENTRY(UAMOR, env->spr[SPR_UAMOR]);
> +                REG_ENTRY(VRSAVE, env->spr[SPR_VRSAVE]);
> +                REG_ENTRY(VSCR, env->vscr);
> +                REG_ENTRY(VTB, env->spr[SPR_VTB]);
> +                REG_ENTRY(WORT, env->spr[SPR_WORT]);
> +                REG_ENTRY(XER, env->spr[SPR_XER]);
> +
> +                /*
> +                 * Ignoring transaction checkpoint and few other registe=
rs
> +                 * mentioned in PAPR as not supported in QEMU
> +                 */
> +#undef REG_ENTRY
> +
> +                /* End the registers for this CPU with "CPUEND" reg entr=
y */
> +                curr_reg_entry->reg_id =3D
> +                    cpu_to_be64(fadump_str_to_u64("CPUEND"));
> +
> +                /* Ensure the number of registers match (+2 for STRT & E=
ND) */
> +                assert(FADUMP_NUM_PER_CPU_REGS =3D=3D num_regs_per_cpu +=
 2);
> +
> +                ++curr_reg_entry;
> +            }
> +
> +            cpu_state_len =3D 0;
> +            cpu_state_len +=3D sizeof(reg_save_hdr);     /* reg save hea=
der */
> +            cpu_state_len +=3D sizeof(__be32);           /* num_cpus */
> +            cpu_state_len +=3D fadump_reg_entries_size;  /* reg entries =
*/
> +
> +            cpu_state_region =3D &fdm->rgn[i];
> +            cpu_state_addr =3D dest_addr;
> +            cpu_state_buffer =3D g_malloc(cpu_state_len);
> +
> +            uint64_t offset =3D 0;
> +            memcpy(cpu_state_buffer + offset,
> +                    &reg_save_hdr, sizeof(reg_save_hdr));
> +            offset +=3D sizeof(reg_save_hdr);
> +
> +            /* Write num_cpus */
> +            num_cpus =3D cpu_to_be32(num_cpus);
> +            memcpy(cpu_state_buffer + offset, &num_cpus, sizeof(__be32))=
;
> +            offset +=3D sizeof(__be32);
> +
> +            /* Write the register entries */
> +            memcpy(cpu_state_buffer + offset,
> +                    reg_entries, fadump_reg_entries_size);
> +            offset +=3D fadump_reg_entries_size;
> +
> +            /*
> +             * We will write the cpu state data later, as otherwise it
> +             * might get overwritten by other fadump regions
> +             */
> +
>              break;
> +        }
>          case FADUMP_HPTE_REGION:
>              /* TODO: Add hpte state data */
>              break;
> @@ -455,6 +623,34 @@ static bool fadump_preserve_mem(void)
>          }
>      }
> =20
> +    /*
> +     * Write the Register Save Area
> +     *
> +     * CPU State/Register Save Area should be written after dumping the
> +     * memory to prevent overwritting while saving other memory regions
> +     *
> +     * eg. If boot memory region is 1G, then both the first 1GB memory, =
and
> +     * the Register Save Area needs to be saved at 1GB.
> +     * And as the CPU_STATE_DATA region comes first than the
> +     * REAL_MODE_REGION region to be copied, the CPU_STATE_DATA will get
> +     * overwritten if saved before the 0GB - 1GB region is copied after
> +     * saving CPU state data
> +     */
> +    cpu_physical_memory_write(cpu_state_addr, cpu_state_buffer, cpu_stat=
e_len);

Check docs/devel/loads-stores.rst, address_space_* is preferred to check
for failures. It also says devices should operate on their own address
spaces and that doesn't really apply to spapr since the "virtual
hypervisor" doesn't really fit the model of a device...

Perhaps look at h_enter_nested which uses CPU(cpu)->as.

> +    g_free(cpu_state_buffer);
> +
> +    /*
> +     * Set bytes_dumped in cpu state region, so kernel knows platform ha=
ve
> +     * exported it
> +     */
> +    cpu_state_region->bytes_dumped =3D cpu_to_be64(cpu_state_len);
> +
> +    if (cpu_state_region->source_len !=3D cpu_state_region->bytes_dumped=
) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "CPU State region's length passed by kernel, doesn't mat=
ch"
> +                " with CPU State region length exported by QEMU");
> +    }
> +
>      return true;
>  }
> =20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index a80704187583..0e8002bad9e0 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -792,6 +792,9 @@ void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
>  #define FADUMP_HPTE_REGION      0x0002
>  #define FADUMP_REAL_MODE_REGION 0x0011
> =20
> +/* Number of registers stored per cpu */
> +#define FADUMP_NUM_PER_CPU_REGS (32 /*GPR*/ + 45 /*others*/ + 2 /*STRT &=
 END*/)
> +
>  /* OS defined sections */
>  #define FADUMP_PARAM_AREA       0x0100
> =20
> @@ -845,6 +848,86 @@ struct rtas_fadump_mem_struct {
>      struct rtas_fadump_section        rgn[FADUMP_MAX_SECTIONS];
>  };
> =20
> +/*
> + * The firmware-assisted dump format.
> + *
> + * The register save area is an area in the partition's memory used to p=
reserve
> + * the register contents (CPU state data) for the active CPUs during a f=
irmware
> + * assisted dump. The dump format contains register save area header fol=
lowed
> + * by register entries. Each list of registers for a CPU starts with "CP=
USTRT"
> + * and ends with "CPUEND".
> + */
> +
> +/* Register save area header. */
> +struct rtas_fadump_reg_save_area_header {
> +    __be64    magic_number;
> +    __be32    version;
> +    __be32    num_cpu_offset;
> +};
> +
> +/* Register entry. */
> +struct rtas_fadump_reg_entry {
> +    __be64    reg_id;
> +    __be64    reg_value;
> +};
> +
> +/*
> + * Copy the ascii values for first 8 characters from a string into u64
> + * variable at their respective indexes.
> + * e.g.
> + *  The string "FADMPINF" will be converted into 0x4641444d50494e46
> + */
> +static inline uint64_t fadump_str_to_u64(const char *str)
> +{
> +    uint64_t val =3D 0;
> +    int i;
> +
> +    for (i =3D 0; i < sizeof(val); i++) {
> +        val =3D (*str) ? (val << 8) | *str++ : val << 8;
> +    }
> +    return val;
> +}
> +
> +/**
> + * Get the identifier id for register entries of GPRs
> + *
> + * It gives the same id as 'fadump_str_to_u64' when the complete string =
id
> + * of the GPR is given, ie.
> + *
> + *   fadump_str_to_u64("GPR05") =3D=3D fadump_gpr_id_to_u64(5);
> + *   fadump_str_to_u64("GPR12") =3D=3D fadump_gpr_id_to_u64(12);
> + *
> + * And so on. Hence this can be implemented by creating a dynamic
> + * string for each GPR, such as "GPR00", "GPR01", ... "GPR31"
> + * Instead of allocating a string, an observation from the math of
> + * 'fadump_str_to_u64' or from PAPR tells us that there's a pattern
> + * in the identifier IDs, such that the first 8 bytes are affected only =
by
> + * whether it is GPR0*, GPR1*, GPR2*, GPR3*. 9th byte is always 0x3. And
> + * the the 10th byte is the index of the GPR modulo 10.
> + */
> +static inline uint64_t fadump_gpr_id_to_u64(uint32_t gpr_id)
> +{
> +    uint64_t val =3D 0;
> +
> +    /* Valid range of GPR id is only GPR0 to GPR31 */
> +    assert(gpr_id < 32);
> +
> +    if (gpr_id <=3D 9) {
> +        val =3D fadump_str_to_u64("GPR0");
> +    } else if (gpr_id <=3D 19) {
> +        val =3D fadump_str_to_u64("GPR1");
> +    } else if (gpr_id <=3D 29) {
> +        val =3D fadump_str_to_u64("GPR2");
> +    } else {
> +        val =3D fadump_str_to_u64("GPR3");
> +    }
> +
> +    val |=3D 0x30000000;
> +    val |=3D ((gpr_id % 10) << 12);
> +
> +    return val;
> +}

These two functions could probably go out of line, I doubt they
are performance critical and make them static if not used outside
the file.

Thanks,
Nick

