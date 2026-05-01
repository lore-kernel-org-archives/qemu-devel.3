Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739B3CCFA13
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIlav-0004sI-Dv; Fri, 01 May 2026 06:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wIlat-0004rs-Sk
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:59:39 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wIlar-0006s4-JN
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:59:39 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ba699316b42so260942566b.3
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:59:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777633175; cv=none;
 d=google.com; s=arc-20240605;
 b=abE/j/LQegtfzyp1WtbNvSex0VJO/JooJ1lORG/SUO9giL+zw22w97keR7cSWsjotd
 6+oAPxDJTWLtq62QZzgxlF7QvRuvpZyK4xcgGBWvsnSK6m1J7pcYLTx1U9GXblKA96Mm
 UecA668AN9WmIZIH+KJVMTssoKj6qGJ7ZzHYjd9enZa/Oqi2o060cf4VFQn/ySvkjsz/
 GdLoRWt7sAZS6ZPari+Ub4AWoiAJBkTOcDYwT83CX7OMzAlKpjwrSbk3AUAEoA0CFAWC
 PEnTHXfyebSI262/Aece7eBPE7nt2+zdgioFSUFnr6JrlCJf6fqfrPRI+63oHMIZ7ZAt
 MBWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JN4HT2LsadJ4dC4qSNjvf7Tbm8tvGgEj/j/vBDaKhsU=;
 fh=Cno60qpHbbucIpSfV2RAOovVW+nwpVE0adnFTCScgLY=;
 b=YOAXrlO7gpgZJcGZxOeeGcJxlY7wLuqUHDWS2zfLjoKJyBCGJ9YLbc5AATRzmkGCZI
 PPukK5FmJkZmZ4pduz8ffVRoFcm/yNXWW/yyc1BUMJkZz3Xf6F5Dum7MXZZdJmS6X5fE
 dU7d9oH1sZQppGCPiFb8udkiZnlI8oFWufXgrINm97DbPA8+e2xVVX20QKNpfV4PgddJ
 kZQSC8bckrEadVBD0nZN2UKN2ob3Aiehdqavy0ZnP1LKwqG5o1tcJdRKwQabIEOB4JKq
 BKVlGaVA0MS2acFNgEICwRrrIbhC58r//1BdeVvf8YQQrJRSJZyFPALAzXnysH10qeGS
 l3bA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777633175; x=1778237975; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JN4HT2LsadJ4dC4qSNjvf7Tbm8tvGgEj/j/vBDaKhsU=;
 b=BRZREG6pCVKkUCYsPxrAKbTcs94hEjiO/4AWRm6qBWRaH5TlTK7Q3zIHDyK9mab2/y
 65THq1TUEn2QBxln04nltweh9GDrkWvdrbnTqRKEGHoZ8eYHtHDwYb4p1x7b+u2LcyRc
 tH58dsX3DlxbSVo2T29DHohkijIbwWDO7sPpf1iTlffw58otKTMAiWV0LU1+tYEeLWwy
 pYbUcFVW0BdWE0ynz8WD7wmzqx/5Rarzhyx+LYB5oI8txXJIvRfe+B/t2YkDfJ6P9JEg
 1km6szULOO3pBbnSwcmR3nZoPZWNS6DDKvchJlLpRkgvEj1D3oBZlMClLIR0TCXi14x9
 uYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777633175; x=1778237975;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JN4HT2LsadJ4dC4qSNjvf7Tbm8tvGgEj/j/vBDaKhsU=;
 b=hS2NnsbP9bZY5p/OqCo6FqzHNIYlp+1pvqVFLwj8fWNafDpPDgx1+tiRw+vgPxWDZA
 Qq2c4HLepCNj/hnzUWuK5503go7YfITZLLM2zGXiXiaDMM66T1DwfzUaaAgj7YAgaNnp
 wc6L5oPDjyOoEMd3liHrM+6FjWHB3j1uHLVRzbtO8CKK64fghjb6rIix8hh27myqf0oK
 UpNYxlInbpsTP0hn1k0KxT0DTSiZOZJLATABnFBwnasmT6roMMTcjoYFcU99Rb3OWuIJ
 /Yo6c+pJbQiooionyUXJroIyyLwcgXSH8/hpcF3dfUfDd66CzIApH/4PDGRgTHahNZLT
 W7IA==
X-Gm-Message-State: AOJu0Yzug/MmrIF9ocUOM6HH3FfewLY1obt2wSJSLb1Y8Qy9vQ016jG2
 mj0XmvL9RXijb8L3fCGhx0ffpAEgxa+s9D72of6rmQrpp3Gel5xu/iwC2sjIBQMVu6uEPwx38Sa
 jOn4RDWHHo5SbW3tbL4NueBuSnMSGgYk=
X-Gm-Gg: AeBDietNpO0w+BRVb13ryTpGp1M0CV3Hlp976B46/qBb0vNblObGhKXT0/hCoIdzASv
 4SyZHqUNLU1WZvjL9APPvVIp+FiHbqa32dQHFN3HeqT1wcc6rZWrRE8VS7S2Qt40n4L3RwPrkyy
 6qUS7XcNL/fH9wdG/FgBcPKiX5SfvK0tXcZHeDXHrpGhZ5QoteWPWrAA+OCp0coUSgHdZazDejm
 nogRHkZTAyHjtHETt3uMab5EJo9fgsxkmjd3PmrkaUvzFjXCupHNaPvUR7olmXsbkKGb5ig/dHX
 IdQYEwC34BguDYaseoTCmC/uwBxJxk5vVJ5i5o496QC/Bv8f
X-Received: by 2002:a17:907:3e20:b0:ba7:34cb:388b with SMTP id
 a640c23a62f3a-bbad60212fbmr433226066b.42.1777633175117; Fri, 01 May 2026
 03:59:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
 <20260501101505.3485916-24-peter.maydell@linaro.org>
In-Reply-To: <20260501101505.3485916-24-peter.maydell@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 1 May 2026 06:59:21 -0400
X-Gm-Features: AVHnY4IT8ijLJfKrtg3FopYSAh_fxCGAwbt5oeeTb-twJdcTxnHBan6Cs7mCgh8
Message-ID: <CAJSP0QUuu8Vt403H1BpsuPFcuCA4WWbvoTu_GHUg7OrbBBPdPw@mail.gmail.com>
Subject: Re: [PULL 23/28] hvf: sync registers used at EL2
To: Peter Maydell <peter.maydell@linaro.org>, mohamed@unpredictable.fr
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x62d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, May 1, 2026 at 6:18=E2=80=AFAM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> From: Mohamed Mediouni <mohamed@unpredictable.fr>
>
> When starting up the VM at EL2, more sysregs are available. Sync the stat=
e of those.
>
> In addition, sync the state of the EL1 physical timer when the vGIC is us=
ed, even
> if running at EL1. However, no OS running at EL1 is expected to use those=
 registers.

Hi Mohamed and Peter,
Please take a look at the following CI failure:

In file included from ../target/arm/hvf/hvf.c:497:
../target/arm/hvf/sysreg.c.inc:187:1: error: static assertion failed
due to requirement '!(HV_SYS_REG_MDCR_EL2 !=3D (((((1 << 28) | (19 <<
16) | ((3) << 14) | ((4) << 11) | ((1) << 7) | ((1) << 3) | ((1) <<
0)) | 13510798882111488ULL)) & 65535))': not expecting:
HV_SYS_REG_MDCR_EL2 !=3D KVMID_TO_HVF(KVMID_AA64_SYS_REG64(3, 4, 1, 1,
1))
187 | DEF_SYSREG_EL2(HV_SYS_REG_MDCR_EL2, 3, 4, 1, 1, 1)
| ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../target/arm/hvf/hvf.c:489:3: note: expanded from macro 'DEF_SYSREG_EL2'
489 | QEMU_BUILD_BUG_ON(HVF_ID !=3D
KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_ARGS__)));
| ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
/private/var/folders/q_/v_6k8zks62lb0q_8f10mvn8h0000gn/T/cirrus-ci-build/in=
clude/qemu/compiler.h:74:30:
note: expanded from macro 'QEMU_BUILD_BUG_ON'
74 | #define QEMU_BUILD_BUG_ON(x) QEMU_BUILD_BUG_MSG(x, "not expecting: " #=
x)
| ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/private/var/folders/q_/v_6k8zks62lb0q_8f10mvn8h0000gn/T/cirrus-ci-build/in=
clude/qemu/compiler.h:72:51:
note: expanded from macro 'QEMU_BUILD_BUG_MSG'
72 | #define QEMU_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
| ^~~~
1 error generated.

https://gitlab.com/qemu-project/qemu/-/jobs/14176182142#L5618

Peter: Please resend the pull request with fixed patches or this patch remo=
ved.

Thanks,
Stefan

>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Message-id: 20260429190532.26538-11-mohamed@unpredictable.fr
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/hvf/hvf.c        | 61 +++++++++++++++++++++++++++++++++----
>  target/arm/hvf/sysreg.c.inc | 44 ++++++++++++++++++++++++++
>  2 files changed, 99 insertions(+), 6 deletions(-)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 38f88c1a80..ecfe06cd8c 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -467,37 +467,75 @@ static const struct hvf_reg_match hvf_sme2_preg_mat=
ch[] =3D {
>   *
>   * SME2 registers are guarded by a runtime availability attribute instea=
d of a
>   * compile-time def, so verify those at runtime in hvf_arch_init_vcpu() =
below.
> + *
> + * Nested virt registers are handled via a runtime check, so override th=
e
> + * guarded availability check done by Clang.
>   */
>
> +#pragma clang diagnostic push
> +#pragma clang diagnostic ignored "-Wunguarded-availability"
> +
>  #define DEF_SYSREG(HVF_ID, ...) \
>    QEMU_BUILD_BUG_ON(HVF_ID !=3D KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_A=
RGS__)));
>  #define DEF_SYSREG_15_02(...)
>
> +#define DEF_SYSREG_EL2(HVF_ID, ...) \
> +  QEMU_BUILD_BUG_ON(HVF_ID !=3D KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_A=
RGS__)));
> +
> +#define DEF_SYSREG_VGIC(HVF_ID, ...) \
> +  QEMU_BUILD_BUG_ON(HVF_ID !=3D KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_A=
RGS__)));
> +
> +#define DEF_SYSREG_VGIC_EL2(HVF_ID, ...) \
> +  QEMU_BUILD_BUG_ON(HVF_ID !=3D KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_A=
RGS__)));
> +
>  #include "sysreg.c.inc"
>
>  #undef DEF_SYSREG
>  #undef DEF_SYSREG_15_02
> +#undef DEF_SYSREG_EL2
> +#undef DEF_SYSREG_VGIC
> +#undef DEF_SYSREG_VGIC_EL2
>
> -#define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  HVF_ID,
> +#define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID},
>  #define DEF_SYSREG_15_02(...)
> +#define DEF_SYSREG_EL2(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, .el2 =
=3D true},
> +#define DEF_SYSREG_VGIC(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, .vgic=
 =3D true},
> +#define DEF_SYSREG_VGIC_EL2(HVF_ID, op0, op1, crn, crm, op2)  {HVF_ID, t=
rue, true},
>
> -static const hv_sys_reg_t hvf_sreg_list[] =3D {
> +struct hvf_sreg {
> +    hv_sys_reg_t sreg;
> +    bool vgic;
> +    bool el2;
> +};
> +
> +static struct hvf_sreg hvf_sreg_list[] =3D {
>  #include "sysreg.c.inc"
>  };
>
>  #undef DEF_SYSREG
>  #undef DEF_SYSREG_15_02
> +#undef DEF_SYSREG_EL2
> +#undef DEF_SYSREG_VGIC
> +#undef DEF_SYSREG_VGIC_EL2
> +
> +#pragma clang diagnostic pop
>
>  #define DEF_SYSREG(...)
> -#define DEF_SYSREG_15_02(HVF_ID, op0, op1, crn, crm, op2) HVF_ID,
> +#define DEF_SYSREG_15_02(HVF_ID, op0, op1, crn, crm, op2) {HVF_ID},
> +#define DEF_SYSREG_EL2(...)
> +#define DEF_SYSREG_VGIC(...)
> +#define DEF_SYSREG_VGIC_EL2(...)
>
>  API_AVAILABLE(macos(15.2))
> -static const hv_sys_reg_t hvf_sreg_list_sme2[] =3D {
> +static struct hvf_sreg hvf_sreg_list_sme2[] =3D {
>  #include "sysreg.c.inc"
>  };
>
>  #undef DEF_SYSREG
>  #undef DEF_SYSREG_15_02
> +#undef DEF_SYSREG_EL2
> +#undef DEF_SYSREG_VGIC
> +#undef DEF_SYSREG_VGIC_EL2
>
>  /*
>   * For FEAT_SME2 migration, we need to store PSTATE.{SM,ZA} bits which a=
re
> @@ -1335,6 +1373,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>  #define DEF_SYSREG_15_02(HVF_ID, ...) \
>          g_assert(HVF_ID =3D=3D KVMID_TO_HVF(KVMID_AA64_SYS_REG64(__VA_AR=
GS__)));
>  #define DEF_SYSREG(...)
> +#define DEF_SYSREG_EL2(...)
> +#define DEF_SYSREG_VGIC(...)
> +#define DEF_SYSREG_VGIC_EL2(...)
>
>  #include "sysreg.c.inc"
>
> @@ -1362,11 +1403,19 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>
>      /* Populate cp list for all known sysregs */
>      for (i =3D 0; i < ARRAY_SIZE(hvf_sreg_list); i++) {
> -        hv_sys_reg_t hvf_id =3D hvf_sreg_list[i];
> +        hv_sys_reg_t hvf_id =3D hvf_sreg_list[i].sreg;
>          uint64_t kvm_id =3D HVF_TO_KVMID(hvf_id);
>          uint32_t key =3D kvm_to_cpreg_id(kvm_id);
>          const ARMCPRegInfo *ri =3D get_arm_cp_reginfo(arm_cpu->cp_regs, =
key);
>
> +        if (hvf_sreg_list[i].vgic && !hvf_irqchip_in_kernel()) {
> +            continue;
> +        }
> +
> +        if (hvf_sreg_list[i].el2 && !hvf_nested_virt_enabled()) {
> +            continue;
> +        }
> +
>          if (ri) {
>              assert(!(ri->type & ARM_CP_NO_RAW));
>              arm_cpu->cpreg_indexes[sregs_cnt++] =3D kvm_id;
> @@ -1375,7 +1424,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>      if (__builtin_available(macOS 15.2, *)) {
>          if (hvf_arm_sme2_supported()) {
>              for (i =3D 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
> -                hv_sys_reg_t hvf_id =3D hvf_sreg_list_sme2[i];
> +                hv_sys_reg_t hvf_id =3D hvf_sreg_list_sme2[i].sreg;
>                  uint64_t kvm_id =3D HVF_TO_KVMID(hvf_id);
>                  uint32_t key =3D kvm_to_cpreg_id(kvm_id);
>                  const ARMCPRegInfo *ri =3D get_arm_cp_reginfo(arm_cpu->c=
p_regs, key);
> diff --git a/target/arm/hvf/sysreg.c.inc b/target/arm/hvf/sysreg.c.inc
> index 7a2f880f78..c11dbf274e 100644
> --- a/target/arm/hvf/sysreg.c.inc
> +++ b/target/arm/hvf/sysreg.c.inc
> @@ -153,3 +153,47 @@ DEF_SYSREG_15_02(HV_SYS_REG_ID_AA64ZFR0_EL1, 3, 0, 0=
, 4, 4)
>  DEF_SYSREG_15_02(HV_SYS_REG_ID_AA64SMFR0_EL1, 3, 0, 0, 4, 5)
>  DEF_SYSREG_15_02(HV_SYS_REG_SMPRI_EL1, 3, 0, 1, 2, 4)
>  DEF_SYSREG_15_02(HV_SYS_REG_SMCR_EL1, 3, 0, 1, 2, 6)
> +/*
> + * Block these because of the same issue as virtual counters in
> + * that caused the revert in 28b0ed32b32c7e5094cf2f1ec9c0645c65fad2aa
> + *
> + * DEF_SYSREG_VGIC(HV_SYS_REG_CNTP_CTL_EL0, 3, 3, 14, 2, 1)
> + * DEF_SYSREG_VGIC(HV_SYS_REG_CNTP_CVAL_EL0, 3, 3, 14, 2, 2)
> + */
> +#ifdef SYNC_NO_RAW_REGS
> +DEF_SYSREG_VGIC(HV_SYS_REG_CNTP_TVAL_EL0, 3, 3, 14, 2, 0)
> +#endif
> +
> +/*
> + * Also block these because of the same issue as virtual counters in
> + * that caused the revert in 28b0ed32b32c7e5094cf2f1ec9c0645c65fad2aa
> + *
> + * DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHP_CVAL_EL2, 3, 4, 14, 2, 2)
> + * DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHP_CTL_EL2, 3, 4, 14, 2, 1)
> + */
> +DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHCTL_EL2, 3, 4, 14, 1, 0)
> +#ifdef SYNC_NO_RAW_REGS
> +DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTHP_TVAL_EL2, 3, 4, 14, 2, 0)
> +#endif
> +DEF_SYSREG_VGIC_EL2(HV_SYS_REG_CNTVOFF_EL2, 3, 4, 14, 0, 3)
> +
> +DEF_SYSREG_EL2(HV_SYS_REG_CPTR_EL2, 3, 4, 1, 1, 2)
> +DEF_SYSREG_EL2(HV_SYS_REG_ELR_EL2, 3, 4, 4, 0, 1)
> +DEF_SYSREG_EL2(HV_SYS_REG_ESR_EL2, 3, 4, 5, 2, 0)
> +DEF_SYSREG_EL2(HV_SYS_REG_FAR_EL2, 3, 4, 6, 0, 0)
> +DEF_SYSREG_EL2(HV_SYS_REG_HCR_EL2, 3, 4, 1, 1, 0)
> +DEF_SYSREG_EL2(HV_SYS_REG_HPFAR_EL2, 3, 4, 6, 0, 4)
> +DEF_SYSREG_EL2(HV_SYS_REG_MAIR_EL2, 3, 4, 10, 2, 0)
> +DEF_SYSREG_EL2(HV_SYS_REG_MDCR_EL2, 3, 4, 1, 1, 1)
> +DEF_SYSREG_EL2(HV_SYS_REG_SCTLR_EL2, 3, 4, 1, 0, 0)
> +DEF_SYSREG_EL2(HV_SYS_REG_SPSR_EL2, 3, 4, 4, 0, 0)
> +DEF_SYSREG_EL2(HV_SYS_REG_SP_EL2, 3, 6, 4, 1, 0)
> +DEF_SYSREG_EL2(HV_SYS_REG_TCR_EL2, 3, 4, 2, 0, 2)
> +DEF_SYSREG_EL2(HV_SYS_REG_TPIDR_EL2, 3, 4, 13, 0, 2)
> +DEF_SYSREG_EL2(HV_SYS_REG_TTBR0_EL2, 3, 4, 2, 0, 0)
> +DEF_SYSREG_EL2(HV_SYS_REG_TTBR1_EL2, 3, 4, 2, 0, 1)
> +DEF_SYSREG_EL2(HV_SYS_REG_VBAR_EL2, 3, 4, 12, 0, 0)
> +DEF_SYSREG_EL2(HV_SYS_REG_VMPIDR_EL2, 3, 4, 0, 0, 5)
> +DEF_SYSREG_EL2(HV_SYS_REG_VPIDR_EL2, 3, 4, 0, 0, 0)
> +DEF_SYSREG_EL2(HV_SYS_REG_VTCR_EL2, 3, 4, 2, 1, 2)
> +DEF_SYSREG_EL2(HV_SYS_REG_VTTBR_EL2, 3, 4, 2, 1, 0)
> --
> 2.43.0
>
>

