Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA9DEF36B97
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 01:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB0vY-0001GL-Bx; Thu, 09 Apr 2026 21:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB0vX-0001Fx-0R
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 21:44:55 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wB0vV-0003Rz-9K
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 21:44:54 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b9c62fc8debso245513766b.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 18:44:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775785491; cv=none;
 d=google.com; s=arc-20240605;
 b=Q7eHXk0jBkC35hDwYBGUWrwTkGJWpDXKY5ARV1BOwfU7+hol9P6QFbwXykv3TrzgTv
 lpXYJT0EBZEUcGRqOFSzZTBCnkc8NuKPa13f5fMJU+WMBhDtgWEJEaRTGrwAZpqW18hR
 18NW0SVSFdD5HXHvWH0z2C8uWS0dLAKfIbnCC4NpUtl+BEZMxQ0lmfxZM+NAGJKmEGM6
 OErmRgf+jLXnRpAfXOcQWKD4Bzbw/O6aGBcO20inKQwB8xMmx2L7kDjin5HsPNMV/L4C
 Unkd7qCKg6MBhhSpz+S31PYO2avGeGMLodmLC/3LLRrBerTTKgJgck+9+g45d770N7py
 SfUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rZT+Mb1jCSjAhDsPiDZFx9jrAuemWWHuzZDGyhWH3zY=;
 fh=cWfiSq/oFyTN/DKvcJSgQUgJ4u5YSKmpf6by/WUOfgI=;
 b=CP4BCPMYBuQEB+1ql/kBaLz2SLTaAinu5iQFbPKsa/whcOIuZYIoCOYgy6ho/ARQ0q
 tLyfE8DvPcAsKGUUm1QZt+KKu9n/YN/99lkK98J6eSFcTbTWy2rjw2Sgkv+oTq4ff0TK
 rVrkWL7fdjoMBZHh/futiaDf6LbGtjt//YUL2UcF+PpO+g2SDoSbH/PlQntFyca8L7yk
 avIHr9XdfOhQPQLTtnErbeum84oP/UUAnGKhIVlpF3Lcb7BjM3CwGPkAQfV0H9n5jkf/
 umb77VuA1PAQ6vdginn59q1TO9qlnslwo7Y3gCygYQ9SSUkYc/mDRZXZayNziqS/UFcG
 kiBw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775785491; x=1776390291; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rZT+Mb1jCSjAhDsPiDZFx9jrAuemWWHuzZDGyhWH3zY=;
 b=DbO1tveAHH3vVVhr693YbvSXPGM1b8dA9DEJSNYquns5o1ZuTHuqsIPFnDpvXsy5ot
 QHS/tiIck8NydBlacrpQ6ce1H2XSD3BMhFGEaxb6jNF5XpYbarNwCId4Jrk1ll3Mzg1f
 6LxJKBYue8lr4P1SAvQiTN4hwt17H3k+Kvbz+KmR1ogMce3tJt70yR+K8rJENvicT0qc
 YIIrlnDklL2be++iY7Yf0Uvp/KaEDQlt7IfQgJ4v9RXssFvOmHe5DTC5ebE8/nZ6Y8cu
 jLJeq80NSbCYw/Vrb9L7M011FXD2pXCecqLsOXLPah6umNiSldCHW2C+Phh1diW9KaAT
 ITtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775785491; x=1776390291;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rZT+Mb1jCSjAhDsPiDZFx9jrAuemWWHuzZDGyhWH3zY=;
 b=cmcdbRfo9dc4bnXzDc/iX68bKXxZEH/PhpujQrTxlzpPN9qfgqSDJmydBGJB3Zy5yb
 dQIzmS8iZqNaZs7zmBp7ttASNZsmueCqaAPk7UTHJEXNEvCT96oaSqbFBBwD2WZXB7yw
 i4UEvECTk+vQrz1M+Jv5pBLLUaDKk+BIc05lsSoVt86iWQsIbpiNuqrl7f5xfHV66cJI
 y57j+BdXFS1yWmz7rLM0VyWtC0a1/NHlD76SVHsi+RIIh1wKMcaQVglmkoE03uaSl0XA
 LkdxLcS2yUwf0dAs2RnAc/rCGHLLbL5PG3/vnNCN9kCAR2I+8iSHFVqVl1UJeqld4zwG
 Mc3w==
X-Gm-Message-State: AOJu0YwSu2jj3TevFoscsQzM8Wpsxity4PLJnpjXG91XZqc9rnCTKVOA
 8KPNo8Vh687ARu8c38asz2Sb2FDpZ459kd4nrbnBpd1lfjMwwJ6No+BB+kO+Ro3KWssOHgUDyEi
 m5BcE2WK/uLXQ1IU/YsnFVuYW6r22CYE=
X-Gm-Gg: AeBDievLaIiPw9jpfR6bQgqYA0QwTMbG7amU/zlU/pQ6VO20wvE44Y0LsNCbRBGLeNG
 xvGdQFkAbmQEIw7E3jHcshokh+Er5P1Q5bTcwe9vzKW/BYfTzLbIrQjeyNdIO75IekxvUouSiYm
 2NfNC9fcyaez3jLSCAGJz4h+1j6Im0TNPaS5/29NVzBnFYdtCItjYYKVMBZY0IVrM8zZOQytyR4
 XuhC5y6PzSr+zg8izKu3IdOQe+7SS/J9Wlq/jP7m1uMxJ4tXtpCBnHfsuKXvB4dvP8hDuMHcFu7
 CBsCaodLogbyt9K3PCJTm1Pm6rWu7OOcTKKeyw==
X-Received: by 2002:a17:906:9fc5:b0:b98:443:6f33 with SMTP id
 a640c23a62f3a-b9d72ad9d36mr72862466b.51.1775785490988; Thu, 09 Apr 2026
 18:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
 <20260408140635.42546-4-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20260408140635.42546-4-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Apr 2026 11:44:24 +1000
X-Gm-Features: AQROBzDpV_iVh4rrqz5172hZNcPEZIsOOP4YVkq2NszBw73rYTcuF86betU_J4Q
Message-ID: <CAKmqyKMykD0tYkFnARggVLkS68arKps17tETcpH0coPL1k_FBw@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] target/riscv: Integrate SMMPT checks into MMU and
 TLB fill
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, chao.liu.zevorn@gmail.com, 
 palmer@dabbelt.com, daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com, 
 Huang Tao <eric.huang@linux.alibaba.com>,
 TANG Tiancheng <lyndra@linux.alibaba.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Apr 9, 2026 at 12:08=E2=80=AFAM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
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

We should only log if the extension is enabled

Alistair

