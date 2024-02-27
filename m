Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FDEAC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 12:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rew9E-000096-4M; Tue, 27 Feb 2024 07:01:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rew9A-00007x-9P; Tue, 27 Feb 2024 07:01:20 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rew96-0001NV-Pd; Tue, 27 Feb 2024 07:01:19 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-29954bb87b4so2862642a91.2; 
 Tue, 27 Feb 2024 04:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709035275; x=1709640075; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+32pfY+ZxWPOpX+DNCg+oV9JCFLSfgK3vPS7O14Hloo=;
 b=Etk+WaS2oasU1Dq/VeY2A+z9LdbBJLwncOHJ22xEzLDSt8tSNiOm1KhnRO42Tzi43D
 tO/wIVFxB4GQIyDxDGjljvCBpwTNb4f+COf8aHQZ3anaKmbe4U+rCZLUNf2TKGIeE1sw
 S2PaU+zSjKEVslDAcZRTQ3qJY6SrrzqFevzX59ihreYTYafg6b0JhnQwTnce5amI/Evz
 LoFZ5uanV5hZQKxLFK33D+D3QSl31pUjhyJUn4vQ1v7nZwq8fOc4z9O7SZba8QAo0iRo
 VZDCbnEDg9Ih61l1edKHXEviAZUNZhtBWQB8vWgathMWivzS1nBBEVu4NO2GamRRiWNz
 k5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709035275; x=1709640075;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+32pfY+ZxWPOpX+DNCg+oV9JCFLSfgK3vPS7O14Hloo=;
 b=Dzustda88yWbmdQUPFx0phlZT0fW3qTwZeugbSMaRh2/mMwFD7AErij8kcWfHjlMxO
 6Ad+TBAkFdrvZmiUczv2FZBvghFt/i41LGnhbeagNbhZcfE+Ew1E4mDSHD2meGYCLYn/
 G2KOT4jPay+DCmhzerXm4tc83pb6vWsugLzNrdu5wt+a69k+jVYLWqjGrXbPj+R98PCp
 3tAOtXHR0Lw4ErAI4eHstuVNoCxDlSUvbgZVi0SQJdV/zEX3eGd27/W8H7+uUXsWGQgT
 O/TD8Vq2UZ1c0VSwXZh20R/nkLMKd2m4TlI8VgyTcnawHt8kVY6HQSmFiiJLduzZR16x
 le4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzOqqEJPYySg6DYrIxVKsH31Rjn/GqWzhPT+jGPHDKmDgEfpEKs9zjEWjh50O5qP6ddsXUCICrj+CYHeHL2bD4lWFWh6Y5EEY1gGA5NO70uI6cLmkdiKuGdeY=
X-Gm-Message-State: AOJu0Ywxp97NbntJGTQalrgvH70+9m7Z31QoaVo272KiSuOpDeRYvs40
 Y7hJ+sbiufkmkuExWvLkhPBaht1As3W5QTc4Adfmno2i0PXWMF7x
X-Google-Smtp-Source: AGHT+IFXxSmovrSMPAM264GSNZZOlbrDS9ikZK7ZIwbjit+zTgnz6DERnJ+FuRAIjFexJXgnsrcF1Q==
X-Received: by 2002:a17:90a:6c61:b0:29a:7efc:471b with SMTP id
 x88-20020a17090a6c6100b0029a7efc471bmr7045048pjj.38.1709035274751; 
 Tue, 27 Feb 2024 04:01:14 -0800 (PST)
Received: from localhost (110-175-163-154.tpgi.com.au. [110.175.163.154])
 by smtp.gmail.com with ESMTPSA id
 gx20-20020a056a001e1400b006e0949b2548sm5716490pfb.209.2024.02.27.04.01.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 04:01:14 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Feb 2024 22:01:07 +1000
Message-Id: <CZFUFVA72347.2XPCPLI34U6MX@wheely>
Cc: <pbonzini@redhat.com>, <kvm@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v8 1/2] ppc: Enable 2nd DAWR support on Power10 PowerNV
 machine
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Shivaprasad G Bhat" <sbhat@linux.ibm.com>, <danielhb413@gmail.com>,
 <qemu-ppc@nongnu.org>, <david@gibson.dropbear.id.au>,
 <harshpb@linux.ibm.com>, <clg@kaod.org>, <groug@kaod.org>
X-Mailer: aerc 0.15.2
References: <170679876639.188422.11634974895844092362.stgit@ltc-boston1.aus.stglabs.ibm.com>
 <170679877410.188422.2597832350300436754.stgit@ltc-boston1.aus.stglabs.ibm.com>
In-Reply-To: <170679877410.188422.2597832350300436754.stgit@ltc-boston1.aus.stglabs.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri Feb 2, 2024 at 12:46 AM AEST, Shivaprasad G Bhat wrote:
> Extend the existing watchpoint facility from TCG DAWR0 emulation
> to DAWR1 on POWER10.
>
> Signed-off-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> ---
>  target/ppc/cpu.c         |   45 ++++++++++++++++++++++++----------
>  target/ppc/cpu.h         |    8 +++++-
>  target/ppc/cpu_init.c    |   15 +++++++++++
>  target/ppc/excp_helper.c |   61 ++++++++++++++++++++++++++--------------=
------
>  target/ppc/helper.h      |    2 ++
>  target/ppc/machine.c     |    3 ++
>  target/ppc/misc_helper.c |   10 ++++++++
>  target/ppc/spr_common.h  |    2 ++
>  target/ppc/translate.c   |   12 +++++++++
>  9 files changed, 115 insertions(+), 43 deletions(-)
>
> diff --git a/target/ppc/cpu.c b/target/ppc/cpu.c
> index e3ad8e0c27..d5ac9bb888 100644
> --- a/target/ppc/cpu.c
> +++ b/target/ppc/cpu.c
> @@ -130,11 +130,13 @@ void ppc_store_ciabr(CPUPPCState *env, target_ulong=
 val)
>      ppc_update_ciabr(env);
>  }
> =20
> -void ppc_update_daw0(CPUPPCState *env)
> +void ppc_update_daw(CPUPPCState *env, int rid)

What's rid? Register ID?

Looks pretty good I think.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick

>  {
>      CPUState *cs =3D env_cpu(env);
> -    target_ulong deaw =3D env->spr[SPR_DAWR0] & PPC_BITMASK(0, 60);
> -    uint32_t dawrx =3D env->spr[SPR_DAWRX0];
> +    int spr_dawr =3D !rid ? SPR_DAWR0 : SPR_DAWR1;
> +    int spr_dawrx =3D !rid ? SPR_DAWRX0 : SPR_DAWRX1;
> +    target_ulong deaw =3D env->spr[spr_dawr] & PPC_BITMASK(0, 60);
> +    uint32_t dawrx =3D env->spr[spr_dawrx];
>      int mrd =3D extract32(dawrx, PPC_BIT_NR(48), 54 - 48);
>      bool dw =3D extract32(dawrx, PPC_BIT_NR(57), 1);
>      bool dr =3D extract32(dawrx, PPC_BIT_NR(58), 1);
> @@ -144,9 +146,9 @@ void ppc_update_daw0(CPUPPCState *env)
>      vaddr len;
>      int flags;
> =20
> -    if (env->dawr0_watchpoint) {
> -        cpu_watchpoint_remove_by_ref(cs, env->dawr0_watchpoint);
> -        env->dawr0_watchpoint =3D NULL;
> +    if (env->dawr_watchpoint[rid]) {
> +        cpu_watchpoint_remove_by_ref(cs, env->dawr_watchpoint[rid]);
> +        env->dawr_watchpoint[rid] =3D NULL;
>      }
> =20
>      if (!dr && !dw) {
> @@ -166,28 +168,45 @@ void ppc_update_daw0(CPUPPCState *env)
>          flags |=3D BP_MEM_WRITE;
>      }
> =20
> -    cpu_watchpoint_insert(cs, deaw, len, flags, &env->dawr0_watchpoint);
> +    cpu_watchpoint_insert(cs, deaw, len, flags, &env->dawr_watchpoint[ri=
d]);
>  }
> =20
>  void ppc_store_dawr0(CPUPPCState *env, target_ulong val)
>  {
>      env->spr[SPR_DAWR0] =3D val;
> -    ppc_update_daw0(env);
> +    ppc_update_daw(env, 0);
>  }
> =20
> -void ppc_store_dawrx0(CPUPPCState *env, uint32_t val)
> +static void ppc_store_dawrx(CPUPPCState *env, uint32_t val, int rid)
>  {
>      int hrammc =3D extract32(val, PPC_BIT_NR(56), 1);
> =20
>      if (hrammc) {
>          /* This might be done with a second watchpoint at the xor of DEA=
W[0] */
> -        qemu_log_mask(LOG_UNIMP, "%s: DAWRX0[HRAMMC] is unimplemented\n"=
,
> -                      __func__);
> +        qemu_log_mask(LOG_UNIMP, "%s: DAWRX%d[HRAMMC] is unimplemented\n=
",
> +                      __func__, rid);
>      }
> =20
> -    env->spr[SPR_DAWRX0] =3D val;
> -    ppc_update_daw0(env);
> +    env->spr[!rid ? SPR_DAWRX0 : SPR_DAWRX1] =3D val;
> +    ppc_update_daw(env, rid);
> +}
> +
> +void ppc_store_dawrx0(CPUPPCState *env, uint32_t val)
> +{
> +    ppc_store_dawrx(env, val, 0);
> +}
> +
> +void ppc_store_dawr1(CPUPPCState *env, target_ulong val)
> +{
> +    env->spr[SPR_DAWR1] =3D val;
> +    ppc_update_daw(env, 1);
> +}
> +
> +void ppc_store_dawrx1(CPUPPCState *env, uint32_t val)
> +{
> +    ppc_store_dawrx(env, val, 1);
>  }
> +
>  #endif
>  #endif
> =20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index f8101ffa29..18dcc438ea 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1236,7 +1236,7 @@ struct CPUArchState {
>  #if defined(TARGET_PPC64)
>      ppc_slb_t slb[MAX_SLB_ENTRIES]; /* PowerPC 64 SLB area */
>      struct CPUBreakpoint *ciabr_breakpoint;
> -    struct CPUWatchpoint *dawr0_watchpoint;
> +    struct CPUWatchpoint *dawr_watchpoint[2];
>  #endif
>      target_ulong sr[32];   /* segment registers */
>      uint32_t nb_BATs;      /* number of BATs */
> @@ -1549,9 +1549,11 @@ void ppc_store_sdr1(CPUPPCState *env, target_ulong=
 value);
>  void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val);
>  void ppc_update_ciabr(CPUPPCState *env);
>  void ppc_store_ciabr(CPUPPCState *env, target_ulong value);
> -void ppc_update_daw0(CPUPPCState *env);
> +void ppc_update_daw(CPUPPCState *env, int rid);
>  void ppc_store_dawr0(CPUPPCState *env, target_ulong value);
>  void ppc_store_dawrx0(CPUPPCState *env, uint32_t value);
> +void ppc_store_dawr1(CPUPPCState *env, target_ulong value);
> +void ppc_store_dawrx1(CPUPPCState *env, uint32_t value);
>  #endif /* !defined(CONFIG_USER_ONLY) */
>  void ppc_store_msr(CPUPPCState *env, target_ulong value);
> =20
> @@ -1737,9 +1739,11 @@ void ppc_compat_add_property(Object *obj, const ch=
ar *name,
>  #define SPR_PSPB              (0x09F)
>  #define SPR_DPDES             (0x0B0)
>  #define SPR_DAWR0             (0x0B4)
> +#define SPR_DAWR1             (0x0B5)
>  #define SPR_RPR               (0x0BA)
>  #define SPR_CIABR             (0x0BB)
>  #define SPR_DAWRX0            (0x0BC)
> +#define SPR_DAWRX1            (0x0BD)
>  #define SPR_HFSCR             (0x0BE)
>  #define SPR_VRSAVE            (0x100)
>  #define SPR_USPRG0            (0x100)
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 23eb5522b6..c901559859 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -5131,6 +5131,20 @@ static void register_book3s_207_dbg_sprs(CPUPPCSta=
te *env)
>                          KVM_REG_PPC_CIABR, 0x00000000);
>  }
> =20
> +static void register_book3s_310_dbg_sprs(CPUPPCState *env)
> +{
> +    spr_register_kvm_hv(env, SPR_DAWR1, "DAWR1",
> +                        SPR_NOACCESS, SPR_NOACCESS,
> +                        SPR_NOACCESS, SPR_NOACCESS,
> +                        &spr_read_generic, &spr_write_dawr1,
> +                        KVM_REG_PPC_DAWR1, 0x00000000);
> +    spr_register_kvm_hv(env, SPR_DAWRX1, "DAWRX1",
> +                        SPR_NOACCESS, SPR_NOACCESS,
> +                        SPR_NOACCESS, SPR_NOACCESS,
> +                        &spr_read_generic, &spr_write_dawrx1,
> +                        KVM_REG_PPC_DAWRX1, 0x00000000);
> +}
> +
>  static void register_970_dbg_sprs(CPUPPCState *env)
>  {
>      /* Breakpoints */
> @@ -6473,6 +6487,7 @@ static void init_proc_POWER10(CPUPPCState *env)
>      /* Common Registers */
>      init_proc_book3s_common(env);
>      register_book3s_207_dbg_sprs(env);
> +    register_book3s_310_dbg_sprs(env);
> =20
>      /* Common TCG PMU */
>      init_tcg_pmu_power8(env);
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 2ec6429e36..32eba7f725 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -3314,39 +3314,46 @@ bool ppc_cpu_debug_check_watchpoint(CPUState *cs,=
 CPUWatchpoint *wp)
>  {
>  #if defined(TARGET_PPC64)
>      CPUPPCState *env =3D cpu_env(cs);
> +    bool wt, wti, hv, sv, pr;
> +    uint32_t dawrx;
> +
> +    if ((env->insns_flags2 & PPC2_ISA207S) &&
> +        (wp =3D=3D env->dawr_watchpoint[0])) {
> +        dawrx =3D env->spr[SPR_DAWRX0];
> +    } else if ((env->insns_flags2 & PPC2_ISA310) &&
> +               (wp =3D=3D env->dawr_watchpoint[1])) {
> +        dawrx =3D env->spr[SPR_DAWRX1];
> +    } else {
> +        return false;
> +    }
> =20
> -    if (env->insns_flags2 & PPC2_ISA207S) {
> -        if (wp =3D=3D env->dawr0_watchpoint) {
> -            uint32_t dawrx =3D env->spr[SPR_DAWRX0];
> -            bool wt =3D extract32(dawrx, PPC_BIT_NR(59), 1);
> -            bool wti =3D extract32(dawrx, PPC_BIT_NR(60), 1);
> -            bool hv =3D extract32(dawrx, PPC_BIT_NR(61), 1);
> -            bool sv =3D extract32(dawrx, PPC_BIT_NR(62), 1);
> -            bool pr =3D extract32(dawrx, PPC_BIT_NR(62), 1);
> -
> -            if ((env->msr & ((target_ulong)1 << MSR_PR)) && !pr) {
> -                return false;
> -            } else if ((env->msr & ((target_ulong)1 << MSR_HV)) && !hv) =
{
> -                return false;
> -            } else if (!sv) {
> +    wt =3D extract32(dawrx, PPC_BIT_NR(59), 1);
> +    wti =3D extract32(dawrx, PPC_BIT_NR(60), 1);
> +    hv =3D extract32(dawrx, PPC_BIT_NR(61), 1);
> +    sv =3D extract32(dawrx, PPC_BIT_NR(62), 1);
> +    pr =3D extract32(dawrx, PPC_BIT_NR(62), 1);
> +
> +    if ((env->msr & ((target_ulong)1 << MSR_PR)) && !pr) {
> +        return false;
> +    } else if ((env->msr & ((target_ulong)1 << MSR_HV)) && !hv) {
> +        return false;
> +    } else if (!sv) {
> +        return false;
> +    }
> +
> +    if (!wti) {
> +        if (env->msr & ((target_ulong)1 << MSR_DR)) {
> +            if (!wt) {
>                  return false;
>              }
> -
> -            if (!wti) {
> -                if (env->msr & ((target_ulong)1 << MSR_DR)) {
> -                    if (!wt) {
> -                        return false;
> -                    }
> -                } else {
> -                    if (wt) {
> -                        return false;
> -                    }
> -                }
> +        } else {
> +            if (wt) {
> +                return false;
>              }
> -
> -            return true;
>          }
>      }
> +
> +    return true;
>  #endif
> =20
>      return false;
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 86f97ee1e7..0c008bb725 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -28,6 +28,8 @@ DEF_HELPER_2(store_pcr, void, env, tl)
>  DEF_HELPER_2(store_ciabr, void, env, tl)
>  DEF_HELPER_2(store_dawr0, void, env, tl)
>  DEF_HELPER_2(store_dawrx0, void, env, tl)
> +DEF_HELPER_2(store_dawr1, void, env, tl)
> +DEF_HELPER_2(store_dawrx1, void, env, tl)
>  DEF_HELPER_2(store_mmcr0, void, env, tl)
>  DEF_HELPER_2(store_mmcr1, void, env, tl)
>  DEF_HELPER_3(store_pmc, void, env, i32, i64)
> diff --git a/target/ppc/machine.c b/target/ppc/machine.c
> index 203fe28e01..082712ff16 100644
> --- a/target/ppc/machine.c
> +++ b/target/ppc/machine.c
> @@ -325,7 +325,8 @@ static int cpu_post_load(void *opaque, int version_id=
)
>          /* Re-set breaks based on regs */
>  #if defined(TARGET_PPC64)
>          ppc_update_ciabr(env);
> -        ppc_update_daw0(env);
> +        ppc_update_daw(env, 0);
> +        ppc_update_daw(env, 1);
>  #endif
>          /*
>           * TCG needs to re-start the decrementer timer and/or raise the
> diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> index a9d41d2802..54e402b139 100644
> --- a/target/ppc/misc_helper.c
> +++ b/target/ppc/misc_helper.c
> @@ -214,6 +214,16 @@ void helper_store_dawrx0(CPUPPCState *env, target_ul=
ong value)
>      ppc_store_dawrx0(env, value);
>  }
> =20
> +void helper_store_dawr1(CPUPPCState *env, target_ulong value)
> +{
> +    ppc_store_dawr1(env, value);
> +}
> +
> +void helper_store_dawrx1(CPUPPCState *env, target_ulong value)
> +{
> +    ppc_store_dawrx1(env, value);
> +}
> +
>  /*
>   * DPDES register is shared. Each bit reflects the state of the
>   * doorbell interrupt of a thread of the same core.
> diff --git a/target/ppc/spr_common.h b/target/ppc/spr_common.h
> index 8a9d6cd994..c987a50809 100644
> --- a/target/ppc/spr_common.h
> +++ b/target/ppc/spr_common.h
> @@ -162,6 +162,8 @@ void spr_write_cfar(DisasContext *ctx, int sprn, int =
gprn);
>  void spr_write_ciabr(DisasContext *ctx, int sprn, int gprn);
>  void spr_write_dawr0(DisasContext *ctx, int sprn, int gprn);
>  void spr_write_dawrx0(DisasContext *ctx, int sprn, int gprn);
> +void spr_write_dawr1(DisasContext *ctx, int sprn, int gprn);
> +void spr_write_dawrx1(DisasContext *ctx, int sprn, int gprn);
>  void spr_write_ureg(DisasContext *ctx, int sprn, int gprn);
>  void spr_read_purr(DisasContext *ctx, int gprn, int sprn);
>  void spr_write_purr(DisasContext *ctx, int sprn, int gprn);
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 049f636927..ac2a53f3b8 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -593,6 +593,18 @@ void spr_write_dawrx0(DisasContext *ctx, int sprn, i=
nt gprn)
>      translator_io_start(&ctx->base);
>      gen_helper_store_dawrx0(tcg_env, cpu_gpr[gprn]);
>  }
> +
> +void spr_write_dawr1(DisasContext *ctx, int sprn, int gprn)
> +{
> +    translator_io_start(&ctx->base);
> +    gen_helper_store_dawr1(tcg_env, cpu_gpr[gprn]);
> +}
> +
> +void spr_write_dawrx1(DisasContext *ctx, int sprn, int gprn)
> +{
> +    translator_io_start(&ctx->base);
> +    gen_helper_store_dawrx1(tcg_env, cpu_gpr[gprn]);
> +}
>  #endif /* defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY) */
> =20
>  /* CTR */


