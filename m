Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1AA4EBFD1C
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 09:03:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCDC4-0002zQ-52; Mon, 13 Apr 2026 05:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wCDBz-0002z6-7r
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 05:02:51 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wCDBw-0004OL-7f
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 05:02:50 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35f9ab079bdso561855a91.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 02:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1776070966; x=1776675766; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gb0aen+HfLufr9KOgmTBTBmnsTBMLfNSRGkag2aucNw=;
 b=X56RXcmCPYhAlbeVBcnfTaXVw7IXE2Y44ELfmQ5tCeEUmYe8am9rxgD2LTFshrdXsG
 cOHLNDXVSAmfCjRVkngG9++huKTI77Ev71/vsPrrV2IoDcKbpE3TZ89tRi9ZUtYsLzaB
 yfBdHJUtF4FdafxB2IZn5NfBFPuGIhDmX37BM8b8yBN9W/QxZ+f6SHOOAQYWnaVtuPSt
 hj6GeDcV3zlwdFrkB57LtSih1AS4Xyx4M5UNRdLnnGB5mrueR7jC+q2QVRedlgtnz8iC
 mEJvUziv33gQjC5UcOR503hkpf94YVv377Y4TpsIWXBpvKe0Ggx592gZsEa8UlR0BwTk
 0O+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776070966; x=1776675766;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Gb0aen+HfLufr9KOgmTBTBmnsTBMLfNSRGkag2aucNw=;
 b=OfYS0JXRFShxLxd0/6bOyigjp6jGCZwlAxrRxdiR4wRjn3AMAUTkVonCzGABSyveXU
 Tero05AtXNSuqnXAsPapqvBPngdArXGnPnPBbhJ69D81cmmkk1chLsbIgfcgFs3RFMwo
 XKrFwwWM1hvmi0c/HyKXT164MtDBzwgRyKMV2e0sbFlWrIXVr9epdQb47tWYzUWk7dBi
 Ki/bZEaaO53s8XqTW1Ob+mBHlH3ZnmsQfj/Y/PTtPjnYnSiihy44Uyhr4on5JzLrj+DY
 q071RKSddz7qtbeuAQyPIynB5DcGZlOtB/Zby4Td66kdmQG6+C3dtIixLmshC7JMQxVj
 yQfw==
X-Gm-Message-State: AOJu0YyU5iRZvrgDjSnWSt2p5MmU14AFFZbHZeeMAz+Su3//WW04g2hM
 cQGU9rrXZkk0P6cLn1DM/AkZsXGuWC7/S6o6KqOGj8ZpLwQniDfKd9/kLkrNFFXao6rLyzJp7cu
 CIP3ma3mWpPa2pYlnzjNTvqGg9eLOJ6SV6pWAIAdMM1cA0N40wOlNJ1u7zKCqNeGK15JkDJlnD0
 018dK+lh8sKmp5+uxYUksw1sCbA5zpW2cuDjjkADqyhYf3zstn
X-Gm-Gg: AeBDies7OPiR5tl2NybwbrMbRqyTagHWkfKfvAvEwwm7Z0U0FD4e8+RAw/TPS/ZGOWJ
 qukm6q5gG047BySyTKjc22NzsMcQXCw72NC9tANHOrBv6h9qiYAG6b0BgbPmq/GY287y3/g5U+K
 p3vcqPXpoAlSI1QOAG82QWSlfEFY3M9TaTJ8JLoUPE8l+lTt3xjjGsdAreMInl/mZj+2OG9Fehd
 olYMvT08FXHqNNW2EbfuERC47Y/jrTmYjDBvoGPb6ch4ZoIhEGt2aKYCv8tqy133f0QjTWosbA+
 xxs0ohAIqf8bSvE/mtaIM8N7mNbi2sE5DTgvwMr6kt8rPInm9zsCYeP/akYM0dz/l3QGfum8+y4
 OWtM8b7i6aQiNkWzIU5Y6gmho6UgUNAZ3M6f9aeoRzO9EPGSOKfVSVObbO1a0FacQQK/ptcpoz4
 uMGgf6PN/w+EhxW8vmCwb/BAwvI24wJSuEd3Oz4Hj7F3qytm7ShQ3czP+dYL0t3Xr50++qgN/x
X-Received: by 2002:a17:90b:1a90:b0:35f:b5df:453 with SMTP id
 98e67ed59e1d1-35fb5df0dcbmr3331646a91.22.1776070965670; 
 Mon, 13 Apr 2026 02:02:45 -0700 (PDT)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com.
 [74.125.82.41]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b45d1ab540sm38530655ad.40.2026.04.13.02.02.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 02:02:45 -0700 (PDT)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-12c1a170a50so3720080c88.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 02:02:43 -0700 (PDT)
X-Received: by 2002:a05:7022:3d12:b0:128:bf5f:7073 with SMTP id
 a92af1059eb24-12c34ee9ef0mr7092659c88.24.1776070962192; Mon, 13 Apr 2026
 02:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
 <20260408140635.42546-4-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20260408140635.42546-4-zhiwei_liu@linux.alibaba.com>
From: Frank Chang <frank.chang@sifive.com>
Date: Mon, 13 Apr 2026 17:02:30 +0800
X-Gmail-Original-Message-ID: <CANzO1D27b_t1D=WxOTJQ9_iMfCSWqVeZ6CRuDDz-U4aTQ2ioOA@mail.gmail.com>
X-Gm-Features: AQROBzDds8bPtyCaNw6XuCbTBEf1tg_rCDa0v1nOW5jmFYrYICbw9gwL8Q3q8ig
Message-ID: <CANzO1D27b_t1D=WxOTJQ9_iMfCSWqVeZ6CRuDDz-U4aTQ2ioOA@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] target/riscv: Integrate SMMPT checks into MMU and
 TLB fill
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, chao.liu.zevorn@gmail.com, 
 palmer@dabbelt.com, alistair23@gmail.com, daniel.barboza@oss.qualcomm.com, 
 liwei1518@gmail.com, Huang Tao <eric.huang@linux.alibaba.com>, 
 TANG Tiancheng <lyndra@linux.alibaba.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=frank.chang@sifive.com; helo=mail-pj1-x102d.google.com
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

Hi Zhiwei,

LIU Zhiwei <zhiwei_liu@linux.alibaba.com> =E6=96=BC 2026=E5=B9=B44=E6=9C=88=
9=E6=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=883:12=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> With the core MPT lookup logic in place, this patch integrates the
> permission checks into QEMU's main MMU processing functions.
>
> A new helper, `get_physical_address_mpt`, is introduced to check the
> permissions for a given physical address against the MPT. This helper
> is then called at two critical points:
>
> 1. During page table walks (`get_physical_address`): The physical
>    address of the Page Table Entry (PTE) itself is checked to ensure
>    the supervisor has permission to read it.
>
> 2. After successful address translation (`riscv_cpu_tlb_fill`): The final
>    guest-physical address is checked against the MPT before the access
>    is allowed to proceed.
>
> This ensures that SMMPT protection is enforced for both the translation
> process and the final memory access, as required by the specification.
>
> Co-authored-by: Huang Tao <eric.huang@linux.alibaba.com>
> Co-authored-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>  target/riscv/cpu_helper.c | 76 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 75 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index e3361fadae..2fab00e9b4 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1161,6 +1161,60 @@ static bool check_svukte_addr(CPURISCVState *env, =
vaddr addr)
>      return !high_bit;
>  }
>
> +/*
> + * get_physical_address_mpt - check mpt permission for this physical add=
ress
> + *
> + * Lookup the Memory Protection Table and check permission for this
> + * physical address. Returns 0 if the permission checking was successful
> + *
> + * @env: CPURISCVState
> + * @prot: The returned protection attributes
> + * @addr: The physical address to be checked permission
> + * @access_type: The type of MMU access
> + * @mode: Indicates current privilege level.
> + */
> +static int get_physical_address_mpt(CPURISCVState *env, int *prot, hwadd=
r addr,
> +                                    MMUAccessType access_type, int mode)
> +{
> +    mpt_access_t mpt_access;
> +    bool mpt_has_access;
> +
> +    /*
> +     * If the extension is not supported or the mmpt.mode is Bare,
> +     * there is no protection, return success.
> +     */
> +    if (!riscv_cpu_cfg(env)->ext_smmpt || env->mptmode =3D=3D 0) {

Nit: env->mptmode =3D=3D SMMPTBARE

> +        *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> +        return TRANSLATE_SUCCESS;
> +    }
> +
> +    /*
> +     * MPT is checked for all accesses to physical memory, unless the
> +     * effective privilege mode is M.
> +     *
> +     * Data accesses in M-mode when the MPRV bit in mstatus is set and
> +     * the MPP field in mstatus contains S or U are subject to MPT check=
s.
> +     *
> +     * In riscv_env_mmu_index, The MPRV and MPP bits are already checked=
 and
> +     * encoded to mmu_idx, So we do not need to check it here.
> +     */
> +    if (mode =3D=3D PRV_M) {
> +        *prot =3D PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> +        return TRANSLATE_SUCCESS;
> +    }
> +
> +    mpt_has_access =3D smmpt_check_access(env, addr,
> +                                      &mpt_access, access_type);
> +    if (!mpt_has_access) {
> +        *prot =3D 0;
> +        return TRANSLATE_MPT_FAIL;
> +    }
> +
> +    *prot =3D smmpt_access_to_page_prot(mpt_access);
> +
> +    return TRANSLATE_SUCCESS;
> +}
> +
>  /*
>   * get_physical_address - get the physical address for this virtual addr=
ess
>   *
> @@ -1355,6 +1409,13 @@ static int get_physical_address(CPURISCVState *env=
, hwaddr *physical,
>              pte_addr =3D base + idx * ptesize;
>          }
>
> +        int mpt_prot;
> +        int mpt_ret =3D get_physical_address_mpt(env, &mpt_prot, pte_add=
r,
> +                                               MMU_DATA_LOAD, PRV_S);
> +        if (mpt_ret !=3D TRANSLATE_SUCCESS) {
> +            return TRANSLATE_MPT_FAIL;

Nit: Just return mpt_ret;

> +        }
> +
>          int pmp_prot;
>          int pmp_ret =3D get_physical_address_pmp(env, &pmp_prot, pte_add=
r,
>                                                 sxlen_bytes,
> @@ -1765,7 +1826,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address=
, int size,
>      CPURISCVState *env =3D &cpu->env;
>      vaddr im_address;
>      hwaddr pa =3D 0;
> -    int prot, prot2, prot_pmp;
> +    int prot, prot2, prot_pmp, mpt_prot;
>      bool pmp_violation =3D false;
>      bool first_stage_error =3D true;
>      bool two_stage_lookup =3D mmuidx_2stage(mmu_idx);
> @@ -1819,6 +1880,13 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr addres=
s, int size,
>              prot &=3D prot2;
>
>              if (ret =3D=3D TRANSLATE_SUCCESS) {
> +                ret =3D get_physical_address_mpt(env, &mpt_prot, pa,
> +                                               access_type, mode);
> +                qemu_log_mask(CPU_LOG_MMU,
> +                              "%s MPT address=3D" HWADDR_FMT_plx " ret %=
d prot"
> +                              " %d\n",
> +                              __func__, pa, ret, mpt_prot);
> +                prot &=3D mpt_prot;

We didn't check the return value of get_physical_address_mpt().
So it might that get_physical_address_mpt() returns TRANSLATE_MPT_FAIL,
but get_physical_address_pmp() returns TRANSLATE_SUCCESS.
The final ret will become: TRANSLATE_SUCCESS.

>                  ret =3D get_physical_address_pmp(env, &prot_pmp, pa,
>                                                 size, access_type, mode);
>                  tlb_size =3D pmp_get_tlb_size(env, pa);
> @@ -1854,6 +1922,12 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr addres=
s, int size,
>                        __func__, address, ret, pa, prot);
>
>          if (ret =3D=3D TRANSLATE_SUCCESS) {
> +            ret =3D get_physical_address_mpt(env, &mpt_prot, pa,
> +                                           access_type, mode);
> +            qemu_log_mask(CPU_LOG_MMU,
> +                          "%s MPT address=3D" HWADDR_FMT_plx " ret %d pr=
ot %d\n",
> +                          __func__, pa, ret, mpt_prot);
> +            prot &=3D mpt_prot;
>              ret =3D get_physical_address_pmp(env, &prot_pmp, pa,
>                                             size, access_type, mode);
>              tlb_size =3D pmp_get_tlb_size(env, pa);
> --
> 2.43.0
>
>

