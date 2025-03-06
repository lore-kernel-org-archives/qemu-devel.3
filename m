Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA88BC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 03:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq205-0001Yp-4V; Wed, 05 Mar 2025 22:34:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq203-0001Ya-UV; Wed, 05 Mar 2025 22:34:19 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq201-0002nX-0g; Wed, 05 Mar 2025 22:34:19 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-86b2cc89e4aso162694241.1; 
 Wed, 05 Mar 2025 19:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741232054; x=1741836854; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YghJWPgOkVw3V15Axb49yHBROOeuI2BD/N6R+VPIlng=;
 b=h+N99tsKNX9/fo/JMW6Ydl64AObfEhS7AmDpxmyKCo4JT0ZVi1RuvHLQ6n9d8IOrwr
 pdWmC4fAqIVkE6yAjR/GSNoIjYjzYnHIOrm3mtR9ebAVw33tVFSE9lBOndxdnI9VHhZl
 Ly89vzthNM8UKMBpCmhZAsb1PqVabKuwsBsof7gOAA75c/oDDb0ly42Imj9xUL3ZvFux
 SaYAZ5Cp3x7dZdv2JNrChZlRPlyT3MGmvGHAQNWYcEX8bWMCS+Gk34438ApScZ8K9QZZ
 2bdl+WUdo57klQppzAwK+NOQNumH+UixUot+DtWo3twWnVvhwrHqRvCHsZKBkqt57KGM
 WEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741232054; x=1741836854;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YghJWPgOkVw3V15Axb49yHBROOeuI2BD/N6R+VPIlng=;
 b=qKItcurO3rBWFuaMBBRjNa5znfrh1wLxMjum9e7VuQcp9lgbfCIxFQnKSfmuv+DV5K
 fKmSMOhQqwnXeWTbbaz6SYa0pdrVjxFyy28FFJKmJBcefwMKX1+bSiR2W8XmEYoiP5Ln
 3LXlThmrJc0Lv5zur1gU8x5vFYmlLDDVX8qCE1f5diYoOohqTdWnKEvVyZLhIcpfNDKH
 vuT3IlrHiaqnq+akokfUsFNhu4rjcoZ2XG2A4Viax8RAFfO7pC/aHL5fN/gRgaNxXmIA
 7/AFn7ifqAnrHaZzXP6L29W19wtWmDr6jfJSrFXPfi4Rdaq5d2TLlCqfH4dzHNlTXE+v
 b6Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcu8HZd4IrdJ1hwhOixMIRYO4fkJ1NsPrlljz8znnqfkiPDLQ7MUocZxB3H9fxwhje6kinzKifSIGl@nongnu.org
X-Gm-Message-State: AOJu0Yz/LMwKVtMil1FkVfTOS65tI56ZLi21nxPp7sgPjjUVOkzERrlS
 i8NDD/0SCmbqW00ZWK1rekGmDwrCX3u6O11tYUAq5lW1//NbrQ9gvqJTcW+WyiJaf6RYnZ1GRIZ
 k3+l5StZIyec5KVzEqEM4G+H5Ne0=
X-Gm-Gg: ASbGncuz5qaKLQ22YeqNbbEQd2xh13BNG3Gy3FsZceVgww7BmEEFQPEM3Q1gjuR+E/p
 deqNIGkXZ6BfzltEanQtfPmqtUYo/OK8TZgAzmPr8Ar9ACZN3cx7IiEtZcxEaI6vbJj9z6bimYi
 e/qYO3G7OffNQsPLBtBEb9ky4IpWz37gd71Z/1oMIOJJJbw91GB1cr8Cc+
X-Google-Smtp-Source: AGHT+IFTo+NLvUHshhOY/4muJCV9BUpxmB70811zEmlXQ0mJjntgTO6enlCLPy+o6hV2eHMorfnclNfd7YjI4n9xWbk=
X-Received: by 2002:a05:6102:54a4:b0:4c1:a15c:ab5c with SMTP id
 ada2fe7eead31-4c2e2906669mr3636799137.20.1741232054327; Wed, 05 Mar 2025
 19:34:14 -0800 (PST)
MIME-Version: 1.0
References: <20250221162036.61521-1-paolo.savini@embecosm.com>
 <20250221162036.61521-2-paolo.savini@embecosm.com>
In-Reply-To: <20250221162036.61521-2-paolo.savini@embecosm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 13:33:47 +1000
X-Gm-Features: AQ5f1JpIK1uvzlrsVup-NvgeUEh2DcJg3G3U5GwD-txbPJDnBBs8ysbGc4iGRck
Message-ID: <CAKmqyKPJP4+fDvZzhnfKTXCaiPbUFU5-Sy01LuA0=95_z7rL+w@mail.gmail.com>
Subject: Re: [PATCH 1/1] [RISC-V/RVV] Expand the probe_pages helper function
 to handle probe flags.
To: Paolo Savini <paolo.savini@embecosm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, 
 Nathan Egge <negge@google.com>, Max Chou <max.chou@sifive.com>, 
 Jeremy Bennett <jeremy.bennett@embecosm.com>, 
 Craig Blackmore <craig.blackmore@embecosm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
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

On Sat, Feb 22, 2025 at 2:21=E2=80=AFAM Paolo Savini <paolo.savini@embecosm=
.com> wrote:
>
> This commit expands the probe_pages helper function in
> target/riscv/vector_helper.c to handle also the cases in which we need ac=
cess to
> the flags raised while probing the memory and the host address.
> This is done in order to provide a unified interface to probe_access and
> probe_access_flags.
> The new version of probe_pages can now act as a regular call to probe_acc=
ess as
> before and as a call to probe_access_flags. In the latter case the user n=
eed to
> pass pointers to flags and host address and a boolean value for nonfault.
> The flags and host address will be set and made available as for a direct=
 call
> to probe_access_flags.
>
> Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>

Do you mind rebasing this on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next ?

Alistair

> ---
>  target/riscv/vector_helper.c | 57 +++++++++++++++++++++++-------------
>  1 file changed, 37 insertions(+), 20 deletions(-)
>
> diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
> index 772cff8fbe..c0f1b7994e 100644
> --- a/target/riscv/vector_helper.c
> +++ b/target/riscv/vector_helper.c
> @@ -114,25 +114,42 @@ static inline uint32_t vext_max_elems(uint32_t desc=
, uint32_t log2_esz)
>   * It will trigger an exception if there is no mapping in TLB
>   * and page table walk can't fill the TLB entry. Then the guest
>   * software can return here after process the exception or never return.
> + *
> + * This function can also be used when direct access to probe_access_fla=
gs is
> + * needed in order to access the flags. If a pointer to a flags operand =
is
> + * provided the function will call probe_access_flags instead, use nonfa=
ult
> + * and update host and flags.
>   */
> -static void probe_pages(CPURISCVState *env, target_ulong addr,
> -                        target_ulong len, uintptr_t ra,
> -                        MMUAccessType access_type)
> +static void probe_pages(CPURISCVState *env, target_ulong addr, target_ul=
ong len,
> +                        uintptr_t ra, MMUAccessType access_type, int mmu=
_index,
> +                        void **host, int *flags, bool nonfault)
>  {
>      target_ulong pagelen =3D -(addr | TARGET_PAGE_MASK);
>      target_ulong curlen =3D MIN(pagelen, len);
> -    int mmu_index =3D riscv_env_mmu_index(env, false);
>
> -    probe_access(env, adjust_addr(env, addr), curlen, access_type,
> -                 mmu_index, ra);
> +    if (flags !=3D NULL) {
> +        *flags =3D probe_access_flags(env, adjust_addr(env, addr), curle=
n,
> +                                    access_type, mmu_index, nonfault, ho=
st, ra);
> +    } else {
> +        probe_access(env, adjust_addr(env, addr), curlen, access_type,
> +                     mmu_index, ra);
> +    }
> +
>      if (len > curlen) {
>          addr +=3D curlen;
>          curlen =3D len - curlen;
> -        probe_access(env, adjust_addr(env, addr), curlen, access_type,
> -                     mmu_index, ra);
> +        if (flags !=3D NULL) {
> +            *flags =3D probe_access_flags(env, adjust_addr(env, addr), c=
urlen,
> +                                        access_type, mmu_index, nonfault=
,
> +                                        host, ra);
> +        } else {
> +            probe_access(env, adjust_addr(env, addr), curlen, access_typ=
e,
> +                         mmu_index, ra);
> +        }
>      }
>  }
>
> +
>  static inline void vext_set_elem_mask(void *v0, int index,
>                                        uint8_t value)
>  {
> @@ -332,8 +349,8 @@ vext_page_ldst_us(CPURISCVState *env, void *vd, targe=
t_ulong addr,
>      MMUAccessType access_type =3D is_load ? MMU_DATA_LOAD : MMU_DATA_STO=
RE;
>
>      /* Check page permission/pmp/watchpoint/etc. */
> -    flags =3D probe_access_flags(env, adjust_addr(env, addr), size, acce=
ss_type,
> -                               mmu_index, true, &host, ra);
> +    probe_pages(env, addr, size, ra, access_type, mmu_index, &host, &fla=
gs,
> +                true);
>
>      if (flags =3D=3D 0) {
>          if (nf =3D=3D 1) {
> @@ -635,7 +652,7 @@ vext_ldff(void *vd, void *v0, target_ulong base, CPUR=
ISCVState *env,
>      uint32_t vma =3D vext_vma(desc);
>      target_ulong addr, addr_probe, addr_i, offset, remain, page_split, e=
lems;
>      int mmu_index =3D riscv_env_mmu_index(env, false);
> -    int flags;
> +    int flags, probe_flags;
>      void *host;
>
>      VSTART_CHECK_EARLY_EXIT(env);
> @@ -649,15 +666,15 @@ vext_ldff(void *vd, void *v0, target_ulong base, CP=
URISCVState *env,
>      }
>
>      /* Check page permission/pmp/watchpoint/etc. */
> -    flags =3D probe_access_flags(env, adjust_addr(env, addr), elems * ms=
ize,
> -                               MMU_DATA_LOAD, mmu_index, true, &host, ra=
);
> +    probe_pages(env, addr, elems * msize, ra, MMU_DATA_LOAD, mmu_index, =
&host,
> +                &flags, true);
>
>      /* If we are crossing a page check also the second page. */
>      if (env->vl > elems) {
>          addr_probe =3D addr + (elems << log2_esz);
> -        flags |=3D probe_access_flags(env, adjust_addr(env, addr_probe),
> -                                    elems * msize, MMU_DATA_LOAD, mmu_in=
dex,
> -                                    true, &host, ra);
> +        probe_pages(env, addr_probe, elems * msize, ra, MMU_DATA_LOAD,
> +                    mmu_index, &host, &probe_flags, true);
> +        flags |=3D probe_flags;
>      }
>
>      if (flags & ~TLB_WATCHPOINT) {
> @@ -669,16 +686,16 @@ vext_ldff(void *vd, void *v0, target_ulong base, CP=
URISCVState *env,
>              addr_i =3D adjust_addr(env, base + i * (nf << log2_esz));
>              if (i =3D=3D 0) {
>                  /* Allow fault on first element. */
> -                probe_pages(env, addr_i, nf << log2_esz, ra, MMU_DATA_LO=
AD);
> +                probe_pages(env, addr_i, nf << log2_esz, ra, MMU_DATA_LO=
AD,
> +                            mmu_index, &host, NULL, false);
>              } else {
>                  remain =3D nf << log2_esz;
>                  while (remain > 0) {
>                      offset =3D -(addr_i | TARGET_PAGE_MASK);
>
>                      /* Probe nonfault on subsequent elements. */
> -                    flags =3D probe_access_flags(env, addr_i, offset,
> -                                               MMU_DATA_LOAD, mmu_index,=
 true,
> -                                               &host, 0);
> +                    probe_pages(env, addr_i, offset, 0, MMU_DATA_LOAD,
> +                                mmu_index, &host, &flags, true);
>
>                      /*
>                       * Stop if invalid (unmapped) or mmio (transaction m=
ay
> --
> 2.34.1
>
>

