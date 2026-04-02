Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A251112246
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 01:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w86Z8-0006FW-9I; Wed, 01 Apr 2026 21:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w86Z5-0006EN-BT
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 21:09:43 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w86Z3-0007hJ-LM
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 21:09:43 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b9382e59c0eso53287566b.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 18:09:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775092179; cv=none;
 d=google.com; s=arc-20240605;
 b=JzWsl7DCei/YU0o34E08UHfIB8HOTnD583B922u7DTCt0W/SYhm2u/DCCLl/ZYjkxA
 EYTtSmJpUfEoE5KmPZjvNyakOk1KOJAe/Kwut1Q9c5d9+eKHFMYpa63XEYYzts1vLdiR
 AmNmOEPTruOVi0AeZ7muCwAjjw5H+aJfSafgsYIASTBHbZ7b7ur5Qz9fDYaU/AR5AuIV
 YX1suEaJtPIiQErADw/C+5tVNaQ4+VpD4vce0bPfdlBap2X15oMbGI5FUjKBUWxLKXPw
 ONY5y5inAH7Cv1ORfaIr24ZEdvW73fBtlyoi2WKzkmTLv2xpVkqNtfZjYr44qc3jE7aP
 Ppew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1zZ8YW9O2BGGc90wQ5TJ9eQhbFntPrWX23y7UWXgGCw=;
 fh=cKlZQNqGqu5Ke7cd/xNYXJu0/deycT8i50Y0xttk3OA=;
 b=LtlNJFPBmv/fcA5CA0i1xCgdf3nBT8/VfIcr+SCgGPCD4xoP7ifwYO919LnHzys1cx
 glTkU6qX4vB5LNe+tBl5V2LbnomAyZFVfi5+x4o+0Vf3Y7HQEgLHkUMhd13nly4h+QMg
 kkFbju6Cam+7UWIieOU3Qe88eIScQFaBnAU7VEq6mGIcwb62ZcNtgSbiqP2351TzYzVX
 qWMdxd7cQ++y+koVkraPs8IHkHvJi/ePAlFhcoPDho2WT5wApPvQvC+PrDqHZD9UH9Nh
 bGIxRKNH8aimL5baJmlk8R61ifk+BFHDv4DSDdimMb7GV/2Hrkb07cjMyvqdvNTrh5lo
 +Fcw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775092179; x=1775696979; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1zZ8YW9O2BGGc90wQ5TJ9eQhbFntPrWX23y7UWXgGCw=;
 b=REr/iG8sXRa98bbnPFl8KByhhVLsn+ZDj1PxvTz7n3q/CzawaWV5bjBQqTzKpvUtEM
 jHKEVVSxuAzMs3yPn7Q7SZa+eKF6ZrwJa3qrqEgEkomyL/X1IGcnOd5qXddSJFXTvZCq
 zSmlaUF3IzVDLwwgoUvhup/mHYdQ/6hmoPXBhxOhmoXNSJNZPs3caOS7E8ed1IZI5Ypn
 zDZTWOzEooEI5MVzjzP+c1m4O0xP/MhrOfpW6rObbEWMFu02/EJpY55AWVCMqcosVkdz
 sTmHg/TiQX/+77bq0NIjSXzeBW7ZQtYawLAf67R02QumaRe23RMZVtejdAFaTBUzWnTg
 s0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775092179; x=1775696979;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1zZ8YW9O2BGGc90wQ5TJ9eQhbFntPrWX23y7UWXgGCw=;
 b=og9HvvoR0UfG2OU7UT2EJElsAdMsvP8L0/jmW/+DIdXVZmRUnG5fR1axQqPqCSBUnq
 LsTLmcsK8iHeWz35Fcnw4h0/6SvemoALrIFoc3rm9FgbuTTezQUEZ06GtlDr+Vmixc3O
 RlPa3EM1dgcTXlKFdYeXWqd4VZGKeU1+gGcfszozXzAzyVxAfsyq5ge/ukb64U6OBK6x
 gV6HZ5kwRoZk6RU+6sGKYnzJ6kHqoOmeD5CSq6m7SJ19Oqsgtf/GubRZPWCSJ73IrMco
 GYmscmcVSf2SN6N6GnDaek3xAMZBBWKOPvTGBHrDiPYMn/JY4Ox+Pt8i/ar5gPyUDMvl
 KSYA==
X-Gm-Message-State: AOJu0YweNoxez3QrufXfEp3Rn8TiAnU4lFKNExfr5cKRnyI3MgqkYh/z
 HG0bYuGCOs8OKlc9x5WkFuuIivwTt7aqp4y5M3iIcPPOgF5rnZ1mkdCNgX7QrZOeQqNg0g9B6Wg
 p/qeRWHTeov9tF3kFrnv0KEshtW3Bc75tSVBH
X-Gm-Gg: ATEYQzza/zcWTOLVdsoObU8aL4bjOgxtF9XEEALU/MTRu+buxadz3MkEdD9V+etweb5
 KiS74ISaw+ZgXOAnXRpDeXUGgzv7nO7FcGJTyjMYZrbD/NiAoY4LwP7w0aWeHo3EieaBfe4opLw
 QgS1m8bpqRrJ5vLP7WCMSyCiyCMV7E8D5vxE6fqqmP3RJNGVXsYhv4eJPfYF9B2ZnK3rwqcvM7D
 fnAsAwbaikKWdbDm7SpD1MOciKl4Btz/7dZt8areF2ED2WCAsMGoVys94KZtmBh2qicInyz8h9t
 hg7/fk9YwqFcfZ37GjjfF+YW4GVvA76eRN5aBg==
X-Received: by 2002:a17:907:d7ca:b0:b98:3b5d:e148 with SMTP id
 a640c23a62f3a-b9c13786385mr385837466b.11.1775092178716; Wed, 01 Apr 2026
 18:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260401053853.10473-1-sebasjosue84@gmail.com>
 <20260401053853.10473-2-sebasjosue84@gmail.com>
In-Reply-To: <20260401053853.10473-2-sebasjosue84@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Apr 2026 11:09:12 +1000
X-Gm-Features: AQROBzAMdCWTmIdBs8P4svxlvn8igERPKQOhIafH6GqbEUS39ORfSFD1nnIlcV8
Message-ID: <CAKmqyKMA1UQ+inZwibaeBdtcofYJ7+JPk8xR3Y+M_+DuLcfTMA@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/intc: fix heap OOB in ACLINT MTIMER multi-socket
To: =?UTF-8?Q?Sebasti=C3=A1n_Alba_Vives?= <sebasjosue84@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 palmer@dabbelt.com, berrange@redhat.com, qemu-security@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x635.google.com
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

On Wed, Apr 1, 2026 at 11:57=E2=80=AFPM Sebasti=C3=A1n Alba Vives
<sebasjosue84@gmail.com> wrote:
>
> The MMIO read/write handlers index timecmp[] with the absolute hartid
> (hartid_base + offset) but the array is allocated with num_harts
> elements. In multi-socket configurations with hartid_base > 0 this
> causes heap OOB access in the QEMU process.
>
> Fix by using the relative offset for array indexing.
>
> Cc: qemu-security@nongnu.org
> Signed-off-by: Sebasti=C3=A1n Alba Vives <sebasjosue84@gmail.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/intc/riscv_aclint.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
> index 9c1491b..e27e5fb 100644
> --- a/hw/intc/riscv_aclint.c
> +++ b/hw/intc/riscv_aclint.c
> @@ -131,6 +131,7 @@ static uint64_t riscv_aclint_mtimer_read(void *opaque=
, hwaddr addr,
>          addr < (mtimer->timecmp_base + (mtimer->num_harts << 3))) {
>          size_t hartid =3D mtimer->hartid_base +
>                          ((addr - mtimer->timecmp_base) >> 3);
> +        size_t hartid_offset =3D hartid - mtimer->hartid_base;
>          CPUState *cpu =3D cpu_by_arch_id(hartid);
>          CPURISCVState *env =3D cpu ? cpu_env(cpu) : NULL;
>          if (!env) {
> @@ -138,11 +139,11 @@ static uint64_t riscv_aclint_mtimer_read(void *opaq=
ue, hwaddr addr,
>                            "aclint-mtimer: invalid hartid: %zu", hartid);
>          } else if ((addr & 0x7) =3D=3D 0) {
>              /* timecmp_lo for RV32/RV64 or timecmp for RV64 */
> -            uint64_t timecmp =3D mtimer->timecmp[hartid];
> +            uint64_t timecmp =3D mtimer->timecmp[hartid_offset];
>              return (size =3D=3D 4) ? (timecmp & 0xFFFFFFFF) : timecmp;
>          } else if ((addr & 0x7) =3D=3D 4) {
>              /* timecmp_hi */
> -            uint64_t timecmp =3D mtimer->timecmp[hartid];
> +            uint64_t timecmp =3D mtimer->timecmp[hartid_offset];
>              return (timecmp >> 32) & 0xFFFFFFFF;
>          } else {
>              qemu_log_mask(LOG_UNIMP,
> @@ -174,6 +175,7 @@ static void riscv_aclint_mtimer_write(void *opaque, h=
waddr addr,
>          addr < (mtimer->timecmp_base + (mtimer->num_harts << 3))) {
>          size_t hartid =3D mtimer->hartid_base +
>                          ((addr - mtimer->timecmp_base) >> 3);
> +        size_t hartid_offset =3D hartid - mtimer->hartid_base;
>          CPUState *cpu =3D cpu_by_arch_id(hartid);
>          CPURISCVState *env =3D cpu ? cpu_env(cpu) : NULL;
>          if (!env) {
> @@ -182,7 +184,7 @@ static void riscv_aclint_mtimer_write(void *opaque, h=
waddr addr,
>          } else if ((addr & 0x7) =3D=3D 0) {
>              if (size =3D=3D 4) {
>                  /* timecmp_lo for RV32/RV64 */
> -                uint64_t timecmp_hi =3D mtimer->timecmp[hartid] >> 32;
> +                uint64_t timecmp_hi =3D mtimer->timecmp[hartid_offset] >=
> 32;
>                  riscv_aclint_mtimer_write_timecmp(mtimer, RISCV_CPU(cpu)=
, hartid,
>                      timecmp_hi << 32 | (value & 0xFFFFFFFF));
>              } else {
> @@ -193,7 +195,7 @@ static void riscv_aclint_mtimer_write(void *opaque, h=
waddr addr,
>          } else if ((addr & 0x7) =3D=3D 4) {
>              if (size =3D=3D 4) {
>                  /* timecmp_hi for RV32/RV64 */
> -                uint64_t timecmp_lo =3D mtimer->timecmp[hartid];
> +                uint64_t timecmp_lo =3D mtimer->timecmp[hartid_offset];
>                  riscv_aclint_mtimer_write_timecmp(mtimer, RISCV_CPU(cpu)=
, hartid,
>                      value << 32 | (timecmp_lo & 0xFFFFFFFF));
>              } else {
> --
> 2.43.0
>
>

