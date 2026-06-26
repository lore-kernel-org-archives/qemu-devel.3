Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C41CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 00:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcupZ-0006ZU-3T; Thu, 25 Jun 2026 20:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcupX-0006Yr-4T
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 20:54:03 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcupV-0007ka-9C
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 20:54:02 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-697564cb69eso738737a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 17:54:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782435240; cv=none;
 d=google.com; s=arc-20260327;
 b=UbBolbU7bxRPCCgNPGg8wKXtm/el+jgOUisUwjGledAsjVMF4O791peGW2I0fctFS3
 1O+DnYB4gGMVXQ6xxckMNBrFdpxDcNQAAp9L3wtzH+3FaYegaXAnooWr6l+tBpM07gQH
 R/z3E5RHy7+shkKzOhOiKxwzrxelJOLCgSR/fRVEYEPemXn9Ax9TidSXIePIzowo375W
 us0SFRTUCL4NAymGFaIykX/RWR30MahxT21NqQtXnEH+bWFtkuX0zFxmYkPdXtQKUrn9
 leacsJDXZVczzIvqrblWdgP/wBndta5ai5AJD3P7mdnmuGATMIXqWi3IxlvLsz8rqscf
 gx7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rOdMdfXQPoci905bSj2iPr8W+p1mL0QD37a9hNQws1M=;
 fh=9/4tzqKjgzJcjmYJcCvfm+LbcgW0ATp/rdwAYjKmbVo=;
 b=lpUKuljUgYG5ZkKNxeb7J/WKfTYCP8/U7A9H7YfGZr01rHMT9dDelhkDt/UVvUx0rh
 AYvcilXfjjIoAyRnDK8HIRl2syzZYwUl/rUY/54cBisi86bC8kIRoyRlRhlmrUfwpl3J
 mwRHEq4iXRJLLQjWplflyobJ/41lc4X3BaBtIWbt34MLdn84FghE9oHdC1xG170H54Sg
 0Scfxgaj2BDGrklCIqsW7KQl6dZvfXvEEv8/xO5y4oSQWx2v0PtQajoK2XL/SOz1Ow6i
 +opLe1szCZxg33sw9+Y71famvQP+b8rHN9kv9yWShWaiYnmSk0jnakVtBmkFCoDQ8GMS
 pj5g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782435240; x=1783040040; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rOdMdfXQPoci905bSj2iPr8W+p1mL0QD37a9hNQws1M=;
 b=GslkxSFX9VPupN4qMxmn/9wvJTi8aznDqGpH2Xe0MurhMoxzgFVna575op0ZhkqWWQ
 gT5LWtV1tHi+Uf50haq8h+C1Lw7vij9pRwDrOXCljJ+YegOlZCtNRafAB74yg2pHg+8Z
 MX2826FMo26XZT1ItCWfmIGbX+JZjBBrahYkAjQy9IfI7a/RNwBRcJcv9yZTVyx9F66z
 s5axstBg0Rsnz2WVdCLR8e/svVhYX1c1vP0qTszGahdSwQH/hK2wwj1O+9vHxtlV604n
 vZ5so9jyzoiw30ZNtRhonllL78Iy8rh8c06/v8O/x41cv9O4T889Tm3++M34twco0+l3
 pcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782435240; x=1783040040;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rOdMdfXQPoci905bSj2iPr8W+p1mL0QD37a9hNQws1M=;
 b=jhk4PaZEXDcKdx5b5sONGJKgBcX6+FgaLa/ofPyWaKH1qiAH6L83xdKAdZyRtCpqhr
 JTOEQ8Mrf5O+PI/UAuyI6pe37+BPyXUghXOelgDNz/3O9XBsYFjt1lj5AXXrLhGMKaKO
 U0w+n9quA7b37ltNFkQCJLLEnu8844g6MCSswgvXKb6PGeo70QGb9TZ7CowTuqb+Tj2F
 Uw9rp2AKFDaDgRl48DLaZkLpRaejUF4znpq2nVFBM1x7sKqg3rCbosBeG00SF0qX+TJ/
 b2e3k8D8MqyauuYfeNVdf5OqtlT3vWKHcOZbBQmcWdY8IxVHNMqqZ8bHyRjOHdI5OjwY
 u0eA==
X-Gm-Message-State: AOJu0YzTjT/QmrJtcpGpgCJvy8SBMn7uDcwwrT0IBvegrLiatIv64Mt5
 gF7D0omTEKEMEqmaQm3jsf7lCfKYF92DvyIVUsRWRvrqfMAM2QbOnG/hAvT52K2+nsAg5P5TxPe
 4AIyiDhAXCRiMSi+IqNILl20L63v6vEY=
X-Gm-Gg: AfdE7cmV3CyDwcqml1UTrmFFp9PcSbhuOxJIsPqZi4pIFrIA0yFYPgapFbCla5m/xOQ
 QbxVQTFh0lTexVk60SfCRibC/Sl6cGrhjOov9VO4mKciP/fZYHN2ieXW8b7xar8LJrHVzg9dnt/
 Rao1sOu2KOIObzeczv7H8g+U9Jr1kCT103EdNcF+6ftH3eHjOYbni4XFGJmg5Tx2owLorgDA5yM
 nb9ba6MsI5w3hM0TYBnA0qkLEaLA5bl+xt9dswNFCaETxNu/ZwdTxHjWsaUq2CPGh2RAgRPIfkf
 wRPBbPV+gPSYWU3ZptC5hVXUC7s=
X-Received: by 2002:a05:6402:2551:b0:697:f2e4:3ef2 with SMTP id
 4fb4d7f45d1cf-69810aefab3mr764099a12.14.1782435239578; Thu, 25 Jun 2026
 17:53:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
 <20260624000632.2149359-6-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260624000632.2149359-6-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jun 2026 10:53:32 +1000
X-Gm-Features: AVVi8Cdu66_1Xo6lhtzJ3mOcm1eTly6jlox8qMG8eSOrL3_CsX0GRSA6qI4iMdU
Message-ID: <CAKmqyKN7gnDnGpudLUtfZUwAOe+dGWR2Ufti=0YpL9MHJZ4JcQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/24] target/riscv: tidy up riscv_sysemu_ops
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 fritchleybohrer@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
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

On Wed, Jun 24, 2026 at 10:08=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> monitor_get_register at this moment has a TCG exclusive implementation
> for RISC-V, even though the callback is supposed to be arch independent.
> Until we address how KVM is going to implement it we need to filter it ou=
t
> in cpu.c.v
>
> Same goes for get_phys_addr_debug - it has a TCG only implementation and
> KVM can't use it for now.  It would also need to be filtered out, but
> since we're at it, let's convert it to the newer 'translate_for_debug'
> API too.  Same restrictions apply.
>
> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c            |  6 ++++--
>  target/riscv/cpu.h            |  3 ++-
>  target/riscv/monitor.c        |  2 ++
>  target/riscv/tcg/cpu_helper.c | 14 ++++++++++----
>  4 files changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4e96bbeb60..319825882a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2669,11 +2669,13 @@ static int64_t riscv_get_arch_id(CPUState *cs)
>
>  static const struct SysemuCPUOps riscv_sysemu_ops =3D {
>      .has_work =3D riscv_cpu_has_work,
> -    .get_phys_addr_debug =3D riscv_cpu_get_phys_addr_debug,
>      .write_elf64_note =3D riscv_cpu_write_elf64_note,
>      .write_elf32_note =3D riscv_cpu_write_elf32_note,
> -    .monitor_get_register =3D riscv_monitor_get_register_legacy,
>      .legacy_vmsd =3D &vmstate_riscv_cpu,
> +#ifdef CONFIG_TCG
> +    .translate_for_debug =3D riscv_cpu_translate_for_debug,
> +    .monitor_get_register =3D riscv_monitor_get_register_legacy,
> +#endif
>  };
>  #endif
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index f0c78c1474..70b8729bd7 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -665,7 +665,8 @@ void riscv_cpu_do_transaction_failed(CPUState *cs, hw=
addr physaddr,
>                                       MMUAccessType access_type,
>                                       int mmu_idx, MemTxAttrs attrs,
>                                       MemTxResult response, uintptr_t ret=
addr);
> -hwaddr riscv_cpu_get_phys_addr_debug(CPUState *cpu, vaddr addr);
> +bool riscv_cpu_translate_for_debug(CPUState *cs, vaddr addr,
> +                                   TranslateForDebugResult *result);
>  bool riscv_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
>  void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env);
>  int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint64_t interrupts);
> diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
> index 3e89dcaf7c..7aacd1d89c 100644
> --- a/target/riscv/monitor.c
> +++ b/target/riscv/monitor.c
> @@ -245,6 +245,7 @@ void hmp_info_mem(Monitor *mon, const QDict *qdict)
>      mem_info_svxx(mon, env);
>  }
>
> +#ifdef CONFIG_TCG
>  static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
>                                   target_ulong *val, bool is_gprh)
>  {
> @@ -379,3 +380,4 @@ int riscv_monitor_get_register_legacy(CPUState *cs, c=
onst char *name,
>
>      return -EINVAL;
>  }
> +#endif
> diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.=
c
> index 59edcdd370..a893472c4e 100644
> --- a/target/riscv/tcg/cpu_helper.c
> +++ b/target/riscv/tcg/cpu_helper.c
> @@ -1771,7 +1771,8 @@ static void raise_mmu_exception(CPURISCVState *env,=
 target_ulong address,
>      env->two_stage_indirect_lookup =3D two_stage_indirect;
>  }
>
> -hwaddr riscv_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
> +bool riscv_cpu_translate_for_debug(CPUState *cs, vaddr addr,
> +                                   TranslateForDebugResult *result)
>  {
>      RISCVCPU *cpu =3D RISCV_CPU(cs);
>      CPURISCVState *env =3D &cpu->env;
> @@ -1781,17 +1782,22 @@ hwaddr riscv_cpu_get_phys_addr_debug(CPUState *cs=
, vaddr addr)
>
>      if (get_physical_address(env, &phys_addr, &prot, addr, NULL, 0, mmu_=
idx,
>                               true, env->virt_enabled, true, false)) {
> -        return -1;
> +        return false;
>      }
>
>      if (env->virt_enabled) {
>          if (get_physical_address(env, &phys_addr, &prot, phys_addr, NULL=
,
>                                   0, MMUIdx_U, false, true, true, false))=
 {
> -            return -1;
> +            return false;
>          }
>      }
>
> -    return phys_addr;
> +    *result =3D (TranslateForDebugResult) {
> +        .physaddr =3D phys_addr,
> +        .lg_page_size =3D TARGET_PAGE_BITS,
> +        .attrs.debug =3D 1,
> +    };
> +    return true;
>  }
>
>  void riscv_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
> --
> 2.43.0
>
>

