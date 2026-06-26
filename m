Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53735CDE00B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 01:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcuyL-0002Qb-By; Thu, 25 Jun 2026 21:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcuyJ-0002LF-2T
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:03:07 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcuyH-0001dF-DM
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:03:06 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-693c69b97e7so744697a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 18:03:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782435784; cv=none;
 d=google.com; s=arc-20260327;
 b=Bo+hsm45SZVX9QfjZ/NOh0Jo6L0djztEE9GUBtmGsJ4gg1PfM/Gd567aWaWqeIBNHg
 NqyVd9foBcSrm1dz7T3zjkkAA4G59dZiqv7+Ve9nULHctZRb1MkC1u87AVNeGe+oufrU
 29varZU5G4aPoFeLzEllMRutHhsfotx05qcVmLxlRKrG9s2hRW6VbcpNjxAG5RdHEMe7
 FCiLmqEBi/7DJD6tarUWPnpmAliKlJ2EQhNMc0e4LIr0sLP66w7HASxT+LvLfshPq62o
 5BRutEYYrcpoQroKUzV8pnvAWc3aR94qdVeuFn4zD4yzjxe07i+ugORJoAoH2+i1ykmk
 /66Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TfWii4z16A3PbDf4UzlNjQ3WVIEsPEpqvXAlMjsogEk=;
 fh=9/4tzqKjgzJcjmYJcCvfm+LbcgW0ATp/rdwAYjKmbVo=;
 b=Fm1cBA7i+aXEny/Bbcb96O+LzR6044YhHlxfg4AugWpB8XQifugqJmyRpUMH9/HJr8
 drVOw+QrcF+CLOas23B23ORQKAPfF2da3buWpD9dBXD/S5YI0ZtiXB6mjyjK9vX5Uddp
 6hMhGYFoyjAoFkYXJavIbMPswrFtUfeGR2QUzdw9S1/ZtwtZXU7+q1IU7He8pFAKSA0g
 MF5gvXqPmeBVLJwBL6Zz8rqTKC57wK1zmzQQJcl10xKBatVxgFJqfboBx0YIisDBxhXy
 qW9DTPYdE3c6egdRnD5k1fQu5noARR6VgOBCyLK/ApQFvPWx3ZafQZwzwUde7KZdrUVu
 OyTw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782435784; x=1783040584; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TfWii4z16A3PbDf4UzlNjQ3WVIEsPEpqvXAlMjsogEk=;
 b=Q0lbSxfz+GxEf7BnuXyxFrah9/6LLz8mlxXvPLH3OejtGOzGnRXteQ5QuJmADV92m9
 8HH7OSYaT6i0/ocGPq6F7gNlrO1T3tyvSBVhlV/UD9MVCb26ZMEwuu0PeCjpvuh2MSIt
 YYCYsWCanCXeZre6WCRLRb4F9FYgMd4lgBx/p9t29HTMJ42HQiM0W3talzGV4CXeJZQK
 EiNsnGelu+ZLa6/Yx7IDLUcwuw1Kob2D3X3wK7EIgj9xaGjfckqc6T2FBGc3InzSbyUQ
 SVuVhiBsSP6zlHCUm4JDjrg4DZe+vHN7Gdo45QdqbItS8I5GyjvoTiCEnxLbo+jxP3h1
 noAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782435784; x=1783040584;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TfWii4z16A3PbDf4UzlNjQ3WVIEsPEpqvXAlMjsogEk=;
 b=OUj3hulVPgHwwe0ClLzFYGSrx6oMeh257kL8B0vybjyyusGdDoncAI9ytiuL/XDGZh
 kAy7C+mlLcEK9XRoQjnPwy8k30dNJRzNWKcQQASZq10DHauyg29zC9mdAgRnj7QYhIr/
 X4Tzc5s81I9erz5QfX7GEGrYoZdv9RIWzEtSz5NVHqW7SZ8Jkp2fk35aaVuWF3thvxt9
 CNRgqpUnJYE06MRkVS9tEeJ10o4GYQCUq5oURZBL0nvjn2ZBTXNnwLodGfcUpIt4E7Qo
 sbx27PCR8RlBcSe4CYMF0uQrSFSW+ZM4Bv1oWpM+YWhUzbAdMgXxQbGcyI91dM1ewhEi
 uM5w==
X-Gm-Message-State: AOJu0YzFS+dd36tYPoHoaH2kEChD5qgvMQAT123leKH693dyma92TWtK
 9+W/R0haWjNpAVmIwepl2Lufami75/QSsZFHXLiWTZBTwYLuZyRUjjWSE6QMd31uYDvylzsfYpV
 S5Z6uwmEyngtoWTIzab8GU1TLlfxIkPrM+R6txYKkWA==
X-Gm-Gg: AfdE7cklrCKSbYMFrFZipa+whZpLt/NEZac+Z2HuUB64R0HLtx2PWOPKNTS5CRn0zgE
 6A9LeklzKldL5JF+T+A1P62H114pY6rVNcIf9uxouWQPJypQgnecL5hJk/DDZCExk4NkOtXmTGX
 SCyhbqBUSr6l+rbYo/AfWLRnl0N3GEPFw90Gsk51qHrk+Tsw4DHBNGvPbE45wUV0CxvRVWZzrvx
 SCARynVqk13MvSeaYpRK+jsREaGFd229UQ9PrxPZwhnRnSOQhFE8Ci2iAbGb5W2hegxNQv0j66p
 uquBHJqW2PpoCkWRUswXFeI3fVw=
X-Received: by 2002:a05:6402:3585:b0:695:9b77:7c3a with SMTP id
 4fb4d7f45d1cf-69810ae8134mr713753a12.24.1782435783871; Thu, 25 Jun 2026
 18:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
 <20260624000632.2149359-13-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260624000632.2149359-13-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jun 2026 11:02:37 +1000
X-Gm-Features: AVVi8Cezl-gRZtbTkqXnUhFJe8AtkYb6zEJZAXq73aa1uFWzqUlyTQfW2LtXzyw
Message-ID: <CAKmqyKNzBXZsSGTFfbQue1aegWjt_OpdKmRyVipi=2tSU1Kb=Q@mail.gmail.com>
Subject: Re: [PATCH v2 12/24] target/riscv: move valid_vm_* satp arrays to
 cpu.c
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 fritchleybohrer@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x531.google.com
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
> These arrays are used internally in tcg/csr.c and in cpu.c in the satp
> options logic, which is common for both KVM and TCG.
>
> Move it to cpu.c to allow KVM to keep using it in --disable-tcg builds.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c     | 13 +++++++++++++
>  target/riscv/cpu.h     |  2 --
>  target/riscv/tcg/csr.c | 12 ------------
>  target/riscv/tcg/csr.h |  3 +++
>  4 files changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index cba7d2502e..29af0f2be8 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -59,6 +59,19 @@ const uint32_t misa_bits[] =3D {RVI, RVE, RVM, RVA, RV=
F, RVD, RVV,
>  #define BYTE(x)   (x)
>  #endif
>
> +/* SATP bits that are shared between TCG and KVM */
> +const bool valid_vm_1_10_32[16] =3D {
> +    [VM_1_10_MBARE] =3D true,
> +    [VM_1_10_SV32] =3D true
> +};
> +
> +const bool valid_vm_1_10_64[16] =3D {
> +    [VM_1_10_MBARE] =3D true,
> +    [VM_1_10_SV39] =3D true,
> +    [VM_1_10_SV48] =3D true,
> +    [VM_1_10_SV57] =3D true
> +};
> +
>  bool riscv_cpu_is_32bit(RISCVCPU *cpu)
>  {
>      return riscv_cpu_mxl(&cpu->env) =3D=3D MXL_RV32;
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 34c63a3628..82430ecec6 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -971,8 +971,6 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Error=
 **errp);
>  void riscv_add_satp_mode_properties(Object *obj);
>  bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
>
> -extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
> -
>  void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
>  target_ulong riscv_new_csr_seed(target_ulong new_value,
>                                  target_ulong write_mask);
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index 572a39d660..b17be35e56 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -1874,18 +1874,6 @@ static const uint64_t hvien_writable_mask =3D LOCA=
L_INTERRUPTS;
>
>  static const uint64_t vsip_writable_mask =3D MIP_VSSIP | LOCAL_INTERRUPT=
S;
>
> -const bool valid_vm_1_10_32[16] =3D {
> -    [VM_1_10_MBARE] =3D true,
> -    [VM_1_10_SV32] =3D true
> -};
> -
> -const bool valid_vm_1_10_64[16] =3D {
> -    [VM_1_10_MBARE] =3D true,
> -    [VM_1_10_SV39] =3D true,
> -    [VM_1_10_SV48] =3D true,
> -    [VM_1_10_SV57] =3D true
> -};
> -
>  /* Machine Information Registers */
>  static RISCVException read_zero(CPURISCVState *env, int csrno,
>                                  target_ulong *val)
> diff --git a/target/riscv/tcg/csr.h b/target/riscv/tcg/csr.h
> index 73d874ee98..53ba3b4a4d 100644
> --- a/target/riscv/tcg/csr.h
> +++ b/target/riscv/tcg/csr.h
> @@ -69,6 +69,9 @@ enum {
>      CSR_TABLE_SIZE =3D 0x1000
>  };
>
> +/* valid_vm_* arrays are shared with KVM via cpu.c */
> +extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
> +
>  /* CSR function table */
>  extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
>
> --
> 2.43.0
>
>

