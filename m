Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBFECDE00C
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 00:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcutz-0000S5-9Q; Thu, 25 Jun 2026 20:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcuty-0000RW-8y
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 20:58:38 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcutw-0000VQ-Gb
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 20:58:38 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c121e505e4eso50789466b.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 17:58:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782435515; cv=none;
 d=google.com; s=arc-20260327;
 b=XCtMkrHLhV17jNc5RxEDFL6kjio9AzTLA9c51aQaVmDoi6rJxUVG/nfj089u/TdH9y
 bIqsj0WF7ddyXng2cg2pz9d/lSAucLrdhhiwC3//mae3noFWn2nyRYq120y6Lfbo2Qd/
 6qn+UM8V4tLBcvSH03nulrdXUyah62gH98OFpABINNq20RtDYJDoLRSbTHyO+7hD/aC6
 sjRATJdyKdllJhLml8lj8PMlPG7BE2bOQMnpXT9Oyc62Zo5lz58Fm9j6de5srZp7wLuJ
 XYmRNPuAFgZoGYHAh06Ggy7CXYWgKqQeW0N7hQVaNFlVfJvDaIRY2TWzDzx7TGU4wPBY
 PJSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9MTn+C6QqkjNC+Sk+aG1MFaeUO3oIT2iKO9G6dP6Pyc=;
 fh=9/4tzqKjgzJcjmYJcCvfm+LbcgW0ATp/rdwAYjKmbVo=;
 b=kZth3Nhd+sVCHmytkkkJJdZOyICpFWPXeBCT5fw6/J7Z/0Q7N5PBpM4u19BG0k6U72
 MNqJMW6H9FeSBAIZROwHk438UAiVDMcDQBWekAD9plZ2yuzXchU7kifPDgD9Km1Eh2xt
 G441dIN6yx9RAtzFjq0O1d2S3SFekL8WZNjAc8E7NtWNNceiiXPHm2h/kSlMsf1ZjRtD
 DRb4HEUkqkiVZSIR6050Bl5T1DbU0RvwUEcGdpXBvEXaJegeVq6kMamQayi/wQB1h5wB
 5et+NEQKEW/p2Zl1EHEPPj2z3Kcxn6i8eVLR7XM0tjbIydpxbXzBWL7Is2fIJj0CnlO6
 K/ug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782435515; x=1783040315; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9MTn+C6QqkjNC+Sk+aG1MFaeUO3oIT2iKO9G6dP6Pyc=;
 b=grnc/XUJlJFA7HhGatPSjURg2BpnADhOCEuwsGgU+q7qKQy5kxKqi4roPmbTKz2K8O
 OMZvXa70uDYRpfE1Y2VAxDytw32/RtsST9NTUYJMLiTi70rQ+/nmAFDVYjMEb/rER2qB
 8YV7PQwd+moOZx3YNjSb5hDbDUAlPJbW+Z1/BJS+jyvdXb0rfkUZ6U2+C8OblP18gkgD
 a/NdeTFoxB4dAnRDx4qN0dTG4lIc7yOX/y2OByurMiMgtpROJNHVv5EbCti5Yl6CMLSu
 OM+nxmX3yFcxlFW/0DCTOccg7oNsmpd1aa9apj3fgPkJeN+hq7avgEDtmvtBLoGciXo2
 bEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782435515; x=1783040315;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9MTn+C6QqkjNC+Sk+aG1MFaeUO3oIT2iKO9G6dP6Pyc=;
 b=gEgsRBs5G+OWg7rCHaQuuJbLf82FVaLzwnCX3iszIwdw8ZD4Qc5k6NpWz4uhEXIuz/
 B+C/MDWZhFJiMMRXvQDbwJfX0iXKIXvuiO+5hn8EZP9jxM86qRxWD/bUK/uIjx633Ijw
 gdAd8lBEyX7Bx7FSxodtzyJXuF4ajTGil95oTLG5AK++P7lMbQgUSh+n6V/g3h0iw4on
 Yc4NTOpk2Ek4yBZnpDDkj28BvHmi0HUeSZHQIoUOyWbFrxf+4eXPMlGO2S263jUdx0U9
 xdo12EX/p9W/a1+v3mei6b9W/FljypSXYHqckOlgTy7+Nw7PMpHGYAGRq8rJXeWV4tho
 Z83g==
X-Gm-Message-State: AOJu0YzmeAc7MRV4iaJvILiScWry+tkGyHPnLkOKL0uV2AvHnUeEJ5LV
 BDN3ognO0FXKoe4mY8lJpOYz64vK2FW6Y5QIUCfGkIjU32IdJ10hHby8dYj8b7i/F24IAOh61/T
 1fcUdh88iWJjnH6qwzKKRMKKb04BaOHc=
X-Gm-Gg: AfdE7clsl9Lu+cmGQ0icPBYGfwIi8wuBY0L4RhzcUr33JVZ0pd0PquuxxRIcBoooWgD
 BaWN92zr7kLMg723NQeOhfpOIoOyh8TZxcm0Tj7PTLU6zFyy5rNutY/Ml2E+Et+F6ISLsRZcIK1
 4aNwvGbfbXp0wL5WmbUFRaO1GTCYXN8Bqcw7xzOYZBGk7RTdt2oMNWXcfDtVpI2S2iTAfAdr9b0
 DNO0bEz6UYANtUEF4ZCr9aOa14bAyOesrrG6QALc9rh7h/NHZbI0j9q4YWeCusnb64J2eDGXAO8
 Vu+/IXNEfp2uz9T/5uU9X/PanDc=
X-Received: by 2002:a17:907:6e89:b0:bec:da5b:5a6 with SMTP id
 a640c23a62f3a-c1205e029c2mr310615066b.21.1782435514713; Thu, 25 Jun 2026
 17:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
 <20260624000632.2149359-9-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260624000632.2149359-9-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jun 2026 10:58:07 +1000
X-Gm-Features: AVVi8CeSmjkQBS-Kiw7pysrkSe49UyWhAM4Gnqi_qZa9DPcaLSz0_dTQmLiH780
Message-ID: <CAKmqyKMkp4mzgqStLOD-06OKPj5XHvm1=HbgZeZWCktjubczOQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/24] target/riscv: remove csr.h from kvm-cpu.c
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 fritchleybohrer@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62d.google.com
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
> Move riscv_new_csr_seed from csr.c to cpu.c since this function is
> shared with KVM.  With that we can remove the csr.h from kvm-cpu.c.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         | 30 ++++++++++++++++++++++++++++++
>  target/riscv/cpu.h         |  3 ++-
>  target/riscv/csr.h         |  3 ---
>  target/riscv/kvm/kvm-cpu.c |  1 -
>  target/riscv/tcg/csr.c     | 29 -----------------------------
>  5 files changed, 32 insertions(+), 34 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index fe47ae64c9..5d44f993e4 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -21,6 +21,7 @@
>  #include "qemu/qemu-print.h"
>  #include "qemu/ctype.h"
>  #include "qemu/log.h"
> +#include "qemu/guest-random.h"
>  #include "cpu.h"
>  #include "cpu_vendorid.h"
>  #include "target/riscv/csr.h"
> @@ -536,6 +537,35 @@ static void riscv_register_custom_csrs(RISCVCPU *cpu=
, const RISCVCSR *csr_list)
>  }
>  #endif
>
> +/* Used by csr.c and the KVM driver */
> +target_ulong riscv_new_csr_seed(target_ulong new_value,
> +                                target_ulong write_mask)
> +{
> +    uint16_t random_v;
> +    Error *random_e =3D NULL;
> +    int random_r;
> +    target_ulong rval;
> +
> +    random_r =3D qemu_guest_getrandom(&random_v, 2, &random_e);
> +    if (unlikely(random_r < 0)) {
> +        /*
> +         * Failed, for unknown reasons in the crypto subsystem.
> +         * The best we can do is log the reason and return a
> +         * failure indication to the guest.  There is no reason
> +         * we know to expect the failure to be transitory, so
> +         * indicate DEAD to avoid having the guest spin on WAIT.
> +         */
> +        qemu_log_mask(LOG_UNIMP, "%s: Crypto failure: %s",
> +                      __func__, error_get_pretty(random_e));
> +        error_free(random_e);
> +        rval =3D SEED_OPST_DEAD;
> +    } else {
> +        rval =3D random_v | SEED_OPST_ES16;
> +    }
> +
> +    return rval;
> +}
> +
>  static ObjectClass *riscv_cpu_class_by_name(const char *cpu_model)
>  {
>      ObjectClass *oc;
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 70b8729bd7..c0e9098728 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -972,7 +972,8 @@ bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
>  extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
>
>  void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
> -
> +target_ulong riscv_new_csr_seed(target_ulong new_value,
> +                                target_ulong write_mask);
>  const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
>
>  const char *priv_spec_to_str(int priv_version);
> diff --git a/target/riscv/csr.h b/target/riscv/csr.h
> index c791260f83..73d874ee98 100644
> --- a/target/riscv/csr.h
> +++ b/target/riscv/csr.h
> @@ -12,9 +12,6 @@
>  #include "exec/target_long.h"
>  #include "cpu_bits.h"
>
> -target_ulong riscv_new_csr_seed(target_ulong new_value,
> -                                target_ulong write_mask);
> -
>  RISCVException riscv_csrr(CPURISCVState *env, int csrno,
>                            target_ulong *ret_value);
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 39d48a9db4..dcdaf7f2b3 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -31,7 +31,6 @@
>  #include "system/kvm.h"
>  #include "system/kvm_int.h"
>  #include "cpu.h"
> -#include "target/riscv/csr.h"
>  #include "trace.h"
>  #include "accel/accel-cpu-target.h"
>  #include "hw/pci/pci.h"
> diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
> index b460860409..d447204721 100644
> --- a/target/riscv/tcg/csr.c
> +++ b/target/riscv/tcg/csr.c
> @@ -29,7 +29,6 @@
>  #include "exec/icount.h"
>  #include "accel/tcg/cpu-loop.h"
>  #include "accel/tcg/getpc.h"
> -#include "qemu/guest-random.h"
>  #include "qapi/error.h"
>  #include "tcg/insn-start-words.h"
>  #include "internals.h"
> @@ -5577,34 +5576,6 @@ static RISCVException write_mnstatus(CPURISCVState=
 *env, int csrno,
>  #endif
>
>  /* Crypto Extension */
> -target_ulong riscv_new_csr_seed(target_ulong new_value,
> -                                target_ulong write_mask)
> -{
> -    uint16_t random_v;
> -    Error *random_e =3D NULL;
> -    int random_r;
> -    target_ulong rval;
> -
> -    random_r =3D qemu_guest_getrandom(&random_v, 2, &random_e);
> -    if (unlikely(random_r < 0)) {
> -        /*
> -         * Failed, for unknown reasons in the crypto subsystem.
> -         * The best we can do is log the reason and return a
> -         * failure indication to the guest.  There is no reason
> -         * we know to expect the failure to be transitory, so
> -         * indicate DEAD to avoid having the guest spin on WAIT.
> -         */
> -        qemu_log_mask(LOG_UNIMP, "%s: Crypto failure: %s",
> -                      __func__, error_get_pretty(random_e));
> -        error_free(random_e);
> -        rval =3D SEED_OPST_DEAD;
> -    } else {
> -        rval =3D random_v | SEED_OPST_ES16;
> -    }
> -
> -    return rval;
> -}
> -
>  static RISCVException rmw_seed(CPURISCVState *env, int csrno,
>                                 target_ulong *ret_value,
>                                 target_ulong new_value,
> --
> 2.43.0
>
>

