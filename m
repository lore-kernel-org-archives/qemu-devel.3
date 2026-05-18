Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7D2CD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 01:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOmM0-0001Vf-7E; Sun, 17 May 2026 21:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmLy-0001VV-RA
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:01:06 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOmLw-0005Zi-G4
 for qemu-devel@nongnu.org; Sun, 17 May 2026 21:01:06 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bcda7765d64so567706566b.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 18:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779066062; cv=none;
 d=google.com; s=arc-20240605;
 b=X0ARvYQjjoXv8VA+gjMeYT5n1mpI051O3aPj+zPYqK3BJHnSmtXtb5GnPn5vF9nCgb
 ynPMq+WPX3VOR79i3FXvxgVCFVfl42ccvW0u3aVZrPJRxbi6w0qimkAYXrRj/p/ihu4/
 i+0/kVSTWTbsl/5PIkwA8QA3RdhnbwIjYbuaLrfWI9w+9/XYavDHgU+sbzHV3MMIEkM3
 rDLBvKKpZj3mE+Oe69oA8LbgZ8VvbsD/Y/idzXbmNj/b/vDLiWsINCwod1/KC1bJQ8T8
 Ohlcj8WDP2ALNG64UAky3F09d4dLste2z5ytNELEh4SKeO4ScpWuN1xnRFUVJgigqrF0
 ApWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hGaGEVzlCJWpLCuIKSc+CtYnC+j8+3KlsSvTu0kPsd4=;
 fh=Ofc/7yYflL5fzGU4DVTgtdXtCN7XZwZQ8r7NIaePuJA=;
 b=iLGcP2bUaM1KlLJ1zPfiqJvLcR4i6GoZ1Bt1AqNzc+HJXdrxgb06FifeQAJOtY6zjC
 wV9EBRXQjWPO26TSIfrJPhxi07k6/ou+l2CNcjOF7Ic+8fD+ayt7x9cXobRj87mv2weC
 K5xRVqS8PW+A8d0DncDcKm1OkxSEVU+RB9vzjR78qWudjD6y+yRunZprBXHjtXj14QII
 c1XM/P91edBhERlpdIyKjO2IC0jg875XUJjMdMVs7PC4e8dTv7EOqf1Nmjs3SjOldq89
 n35Wb1jUefd7+F7yubBmcsgv0hUbWqRAhYMBFjolbLXgnzcVGIHPOvpFAt5kAGtAJfCV
 OdQQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779066062; x=1779670862; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hGaGEVzlCJWpLCuIKSc+CtYnC+j8+3KlsSvTu0kPsd4=;
 b=s7OjSvqo/wlyJasvfqWfJdZyjPmNxIAUdj5Y7yKiDgQdJUE2z+VU83icS0HTZHZiAH
 Yvv1HSBYpLg+Zi2rp59RjSRMyVPufENvtpKG6qekKIFHaEzX4bvHTR158ke6WC+YZVkB
 3Ssz4VsZ2Nop9Mfw9Qzp9VPG07iqV/0Zuz/KDwJZn34Yu8GnzH/e2zgAGWEuFWGk4lLz
 FtuTpocZSbKeW7FMEFSvsLNGQQ8GVMNgmoFf0vKu1r3RPapBaLwGRLoMMjyWPJ29g6Dc
 uUMuNjx/CmJi2OAXwDo7gSbWVJRe5Sl6Hj1Sq1t+4IZSsoS6EKSNN1/dXVxnQt33vOzt
 +hOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779066062; x=1779670862;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hGaGEVzlCJWpLCuIKSc+CtYnC+j8+3KlsSvTu0kPsd4=;
 b=n7IhlRw2CL9GIkq5unHt/sHp82cX3X8q8cHq4qwQeT2M9gF9CvybuhzubsfRjZyoh9
 gy1OOORFin4l2Pdr5fSEJecoR8LrkvEmI8k+SJp9T7+GFFkaAWVtqwO1+rLHt7aEznG/
 oOP9/iF4xGmY24pq6cEMmLTZf1dEt4CcvYbrNLtR+MRuV0kj6yl1RHcAIo3tCMRgOa8J
 JJahzRJGDIvABhdqLqAjO9BOw3Z2+z+Xfb0tALdrWDVtHFu0AaJ58RNJUSOdB5L4G/ey
 cBFEX1uXyxkjWaeT6jkqmhfFYwuj4LfZfdBRvuHwF9R5SdTytorzvfPlj/7ZmOhTVSaG
 iYqA==
X-Gm-Message-State: AOJu0YyGYj/66Zc9z3zWqDoTBjm+dK30KckD4uPA7fEzWgrv8xkcAdgK
 Xetug5hG0wvhV/FljTS58W85FP+wABdumE1jSHlFLwDc/ajWqGg1X6s7s8qtEZP+H33Cyin4Vw9
 ht4Mjijl3tUU71uCVnWwyueKzN69fJpo=
X-Gm-Gg: Acq92OH5Fpi/ZgCvTQFkgaHXFyxtm4RrvJ4GGhb9fsy1ZIKy09JUldlb5Xy05N71ueM
 /MGFSQ9jHg/THHGGk3XZqT9egc0e6MYnLowdK1oKq/1DkxE0rgy3/8j9dNWx2cNwehllt2yOQGB
 awOgoXBhE41iTi1cq8pqRiB8seB0N56SzGuAcTGLbhFDaVdRWW6Wr48zI6cUhCrzSe0OrhfRHDw
 NJE01OIwFBoGpnvuyoZXQXWu/mtu0m7yn1Mbih3e75k0VERf2EvNSP5e2/DoK5tua5dJOTLtmnY
 7TFjT27gyr0ztc/L66whRpe//R5OYAGgLy4jcw==
X-Received: by 2002:a17:907:7248:b0:bd5:2a44:6f29 with SMTP id
 a640c23a62f3a-bd52a4472bcmr451383666b.7.1779066061984; Sun, 17 May 2026
 18:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260515180437.23620-1-anjo@rev.ng>
 <20260515180437.23620-24-anjo@rev.ng>
In-Reply-To: <20260515180437.23620-24-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 11:00:35 +1000
X-Gm-Features: AVHnY4ILT0iyz-VNeeyBo_8Y0XhvvNvRuEmvJ1940vaOWbuDK1XNVthxU8DXjhg
Message-ID: <CAKmqyKPz9yNOAKOoO5-ytp2Q5J2bT7YVQDSAp+Fdf6ksq=GP2A@mail.gmail.com>
Subject: Re: [PATCH v6 23/27] target/riscv: Move CSR declarations to separate
 csr.h header
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x636.google.com
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

On Sat, May 16, 2026 at 4:04=E2=80=AFAM Anton Johansson via qemu developmen=
t
<qemu-devel@nongnu.org> wrote:
>
> Most of these definitions save riscv_csrr, riscv_csrrw, riscv_csr_read,
> riscv_csr_write are only used in target/.  Move declarations to a
> separate headers which will soon be made internal to target/.
>
> csr.h is temporarily included from cpu.h to not break includes from
> outside target/, this include will be removed in the following commit.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h            |  87 +----------------------------
>  target/riscv/csr.h            | 100 ++++++++++++++++++++++++++++++++++
>  target/riscv/cpu.c            |   1 +
>  target/riscv/csr.c            |   1 +
>  target/riscv/gdbstub.c        |   1 +
>  target/riscv/kvm/kvm-cpu.c    |   1 +
>  target/riscv/mips_csr.c       |   1 +
>  target/riscv/monitor.c        |   1 +
>  target/riscv/op_helper.c      |   1 +
>  target/riscv/riscv-qmp-cmds.c |   1 +
>  target/riscv/th_csr.c         |   1 +
>  11 files changed, 110 insertions(+), 86 deletions(-)
>  create mode 100644 target/riscv/csr.h
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index d7a0b083d1..eb18e1f59f 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -903,75 +903,7 @@ RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
>  RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env);
>  uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
>
> -RISCVException riscv_csrr(CPURISCVState *env, int csrno,
> -                          target_ulong *ret_value);
> -
> -RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
> -                           target_ulong *ret_value, target_ulong new_val=
ue,
> -                           target_ulong write_mask, uintptr_t ra);
> -RISCVException riscv_csrrw_debug(CPURISCVState *env, int csrno,
> -                                 target_ulong *ret_value,
> -                                 target_ulong new_value,
> -                                 target_ulong write_mask);
> -
> -static inline void riscv_csr_write(CPURISCVState *env, int csrno,
> -                                   target_ulong val)
> -{
> -    riscv_csrrw(env, csrno, NULL, val, MAKE_64BIT_MASK(0, TARGET_LONG_BI=
TS), 0);
> -}
> -
> -static inline target_ulong riscv_csr_read(CPURISCVState *env, int csrno)
> -{
> -    target_ulong val =3D 0;
> -    riscv_csrr(env, csrno, &val);
> -    return val;
> -}
> -
> -typedef RISCVException (*riscv_csr_predicate_fn)(CPURISCVState *env,
> -                                                 int csrno);
> -typedef RISCVException (*riscv_csr_read_fn)(CPURISCVState *env, int csrn=
o,
> -                                            target_ulong *ret_value);
> -typedef RISCVException (*riscv_csr_write_fn)(CPURISCVState *env, int csr=
no,
> -                                             target_ulong new_value,
> -                                             uintptr_t ra);
> -typedef RISCVException (*riscv_csr_op_fn)(CPURISCVState *env, int csrno,
> -                                          target_ulong *ret_value,
> -                                          target_ulong new_value,
> -                                          target_ulong write_mask);
> -
> -RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
> -                               Int128 *ret_value);
> -RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
> -                                Int128 *ret_value, Int128 new_value,
> -                                Int128 write_mask, uintptr_t ra);
> -
> -typedef RISCVException (*riscv_csr_read128_fn)(CPURISCVState *env, int c=
srno,
> -                                               Int128 *ret_value);
> -typedef RISCVException (*riscv_csr_write128_fn)(CPURISCVState *env, int =
csrno,
> -                                             Int128 new_value);
> -
> -typedef struct {
> -    const char *name;
> -    riscv_csr_predicate_fn predicate;
> -    riscv_csr_read_fn read;
> -    riscv_csr_write_fn write;
> -    riscv_csr_op_fn op;
> -    riscv_csr_read128_fn read128;
> -    riscv_csr_write128_fn write128;
> -    /* The default priv spec version should be PRIV_VERSION_1_10_0 (i.e =
0) */
> -    uint32_t min_priv_ver;
> -} riscv_csr_operations;
> -
> -struct RISCVCSR {
> -    int csrno;
> -    bool (*insertion_test)(RISCVCPU *cpu);
> -    riscv_csr_operations csr_ops;
> -};
> -
> -/* CSR function table constants */
> -enum {
> -    CSR_TABLE_SIZE =3D 0x1000
> -};
> +#include "target/riscv/csr.h"
>
>  /*
>   * The event id are encoded based on the encoding specified in the
> @@ -1015,28 +947,11 @@ void riscv_cpu_finalize_features(RISCVCPU *cpu, Er=
ror **errp);
>  void riscv_add_satp_mode_properties(Object *obj);
>  bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
>
> -/* CSR function table */
> -extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
> -bool riscv_csr_is_fpu(int csrno);
> -bool riscv_csr_is_vpu(int csrno);
> -
>  extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
>
> -void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops);
> -void riscv_set_csr_ops(int csrno, const riscv_csr_operations *ops);
> -
>  void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
>
> -target_ulong riscv_new_csr_seed(target_ulong new_value,
> -                                target_ulong write_mask);
> -
>  const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
>
> -/* In th_csr.c */
> -extern const RISCVCSR th_csr_list[];
> -
> -/* Implemented in mips_csr.c */
> -extern const RISCVCSR mips_csr_list[];
> -
>  const char *priv_spec_to_str(int priv_version);
>  #endif /* RISCV_CPU_H */
> diff --git a/target/riscv/csr.h b/target/riscv/csr.h
> new file mode 100644
> index 0000000000..fef3cd34cb
> --- /dev/null
> +++ b/target/riscv/csr.h
> @@ -0,0 +1,100 @@
> +/*
> + * QEMU RISC-V CSRs
> + *
> + * Copyright (c) 2016-2017 Sagar Karandikar, sagark@eecs.berkeley.edu
> + * Copyright (c) 2017-2018 SiFive, Inc.
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef RISCV_CSR_H
> +#define RISCV_CSR_H
> +
> +target_ulong riscv_new_csr_seed(target_ulong new_value,
> +                                target_ulong write_mask);
> +
> +RISCVException riscv_csrr(CPURISCVState *env, int csrno,
> +                          target_ulong *ret_value);
> +
> +RISCVException riscv_csrrw(CPURISCVState *env, int csrno,
> +                           target_ulong *ret_value, target_ulong new_val=
ue,
> +                           target_ulong write_mask, uintptr_t ra);
> +RISCVException riscv_csrrw_debug(CPURISCVState *env, int csrno,
> +                                 target_ulong *ret_value,
> +                                 target_ulong new_value,
> +                                 target_ulong write_mask);
> +
> +static inline void riscv_csr_write(CPURISCVState *env, int csrno,
> +                                   target_ulong val)
> +{
> +    riscv_csrrw(env, csrno, NULL, val, MAKE_64BIT_MASK(0, TARGET_LONG_BI=
TS), 0);
> +}
> +
> +static inline target_ulong riscv_csr_read(CPURISCVState *env, int csrno)
> +{
> +    target_ulong val =3D 0;
> +    riscv_csrr(env, csrno, &val);
> +    return val;
> +}
> +
> +typedef RISCVException (*riscv_csr_predicate_fn)(CPURISCVState *env,
> +                                                 int csrno);
> +typedef RISCVException (*riscv_csr_read_fn)(CPURISCVState *env, int csrn=
o,
> +                                            target_ulong *ret_value);
> +typedef RISCVException (*riscv_csr_write_fn)(CPURISCVState *env, int csr=
no,
> +                                             target_ulong new_value,
> +                                             uintptr_t ra);
> +typedef RISCVException (*riscv_csr_op_fn)(CPURISCVState *env, int csrno,
> +                                          target_ulong *ret_value,
> +                                          target_ulong new_value,
> +                                          target_ulong write_mask);
> +
> +RISCVException riscv_csrr_i128(CPURISCVState *env, int csrno,
> +                               Int128 *ret_value);
> +RISCVException riscv_csrrw_i128(CPURISCVState *env, int csrno,
> +                                Int128 *ret_value, Int128 new_value,
> +                                Int128 write_mask, uintptr_t ra);
> +
> +typedef RISCVException (*riscv_csr_read128_fn)(CPURISCVState *env, int c=
srno,
> +                                               Int128 *ret_value);
> +typedef RISCVException (*riscv_csr_write128_fn)(CPURISCVState *env, int =
csrno,
> +                                             Int128 new_value);
> +
> +typedef struct {
> +    const char *name;
> +    riscv_csr_predicate_fn predicate;
> +    riscv_csr_read_fn read;
> +    riscv_csr_write_fn write;
> +    riscv_csr_op_fn op;
> +    riscv_csr_read128_fn read128;
> +    riscv_csr_write128_fn write128;
> +    /* The default priv spec version should be PRIV_VERSION_1_10_0 (i.e =
0) */
> +    uint32_t min_priv_ver;
> +} riscv_csr_operations;
> +
> +struct RISCVCSR {
> +    int csrno;
> +    bool (*insertion_test)(RISCVCPU *cpu);
> +    riscv_csr_operations csr_ops;
> +};
> +
> +/* CSR function table constants */
> +enum {
> +    CSR_TABLE_SIZE =3D 0x1000
> +};
> +
> +/* CSR function table */
> +extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
> +
> +bool riscv_csr_is_fpu(int csrno);
> +bool riscv_csr_is_vpu(int csrno);
> +
> +void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops);
> +void riscv_set_csr_ops(int csrno, const riscv_csr_operations *ops);
> +
> +/* In th_csr.c */
> +extern const RISCVCSR th_csr_list[];
> +
> +/* Implemented in mips_csr.c */
> +extern const RISCVCSR mips_csr_list[];
> +
> +#endif /* RISCV_CSR_H */
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 133ec5cbc3..daad317381 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -23,6 +23,7 @@
>  #include "qemu/log.h"
>  #include "cpu.h"
>  #include "cpu_vendorid.h"
> +#include "target/riscv/csr.h"
>  #include "internals.h"
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 7908ea02a5..6cc3fcd4e3 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -21,6 +21,7 @@
>  #include "qemu/log.h"
>  #include "qemu/timer.h"
>  #include "cpu.h"
> +#include "target/riscv/csr.h"
>  #include "tcg/tcg-cpu.h"
>  #include "pmu.h"
>  #include "time_helper.h"
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index 7abacd0e11..a2bbaf7f07 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -21,6 +21,7 @@
>  #include "gdbstub/helpers.h"
>  #include "cpu.h"
>  #include "internals.h"
> +#include "target/riscv/csr.h"
>
>  struct TypeSize {
>      const char *gdb_type;
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index b047ffa9c0..1f730f337e 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -31,6 +31,7 @@
>  #include "system/kvm.h"
>  #include "system/kvm_int.h"
>  #include "cpu.h"
> +#include "target/riscv/csr.h"
>  #include "trace.h"
>  #include "accel/accel-cpu-target.h"
>  #include "hw/pci/pci.h"
> diff --git a/target/riscv/mips_csr.c b/target/riscv/mips_csr.c
> index 822e25e346..609718f288 100644
> --- a/target/riscv/mips_csr.c
> +++ b/target/riscv/mips_csr.c
> @@ -10,6 +10,7 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include "cpu_vendorid.h"
> +#include "target/riscv/csr.h"
>
>  /* Static MIPS CSR state storage */
>  static struct {
> diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
> index 9edac0533c..3e89dcaf7c 100644
> --- a/target/riscv/monitor.c
> +++ b/target/riscv/monitor.c
> @@ -22,6 +22,7 @@
>  #include "qemu/ctype.h"
>  #include "qemu/qemu-print.h"
>  #include "cpu.h"
> +#include "target/riscv/csr.h"
>  #include "cpu_bits.h"
>  #include "monitor/monitor.h"
>  #include "monitor/hmp.h"
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index c074b24bc9..3dc8c4f6b3 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -20,6 +20,7 @@
>
>  #include "qemu/osdep.h"
>  #include "cpu.h"
> +#include "target/riscv/csr.h"
>  #include "internals.h"
>  #include "exec/cputlb.h"
>  #include "accel/tcg/cpu-ldst.h"
> diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.=
c
> index 8a1856c50e..d1c64c1e7f 100644
> --- a/target/riscv/riscv-qmp-cmds.c
> +++ b/target/riscv/riscv-qmp-cmds.c
> @@ -35,6 +35,7 @@
>  #include "system/tcg.h"
>  #include "cpu-qom.h"
>  #include "cpu.h"
> +#include "target/riscv/csr.h"
>
>  static void riscv_cpu_add_definition(gpointer data, gpointer user_data)
>  {
> diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
> index 49eb7bbab5..a4ea4ce391 100644
> --- a/target/riscv/th_csr.c
> +++ b/target/riscv/th_csr.c
> @@ -19,6 +19,7 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include "cpu_vendorid.h"
> +#include "target/riscv/csr.h"
>
>  #define CSR_TH_SXSTATUS 0x5c0
>
> --
> 2.52.0
>
>

