Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786D8CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 23:42:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Xb7-0005Zb-DZ; Thu, 16 Oct 2025 19:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9Xb6-0005ZR-DS
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 19:41:28 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v9Xb4-0002p7-72
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 19:41:28 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-63c1006fdcfso2341041a12.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 16:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760658083; x=1761262883; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=szGxHxKOPJImLc1PjGnA88xgibt2D3DfORNKrvy/uTc=;
 b=iuVeFwSOfqR21VDmoZqB0CbQxNwYr9AVsYnzHmTxsfzNPyn378xzi8hF2Y5DFOqGZR
 4K1jgzkJB0ZNSnpC0lDqGyhW+nF48zgYOUVyNHpoXKvbjNG8F0YfEDmFSan6UnXpOtmb
 MX36+icfi5mOiU9Uuj7FBZu4Jed3cM/nt0mQ4PaII4yuN2x7IfMGBYo22fgS2ahwxJMa
 DDyjPURQfwkRORZMFlj+4kV8IRI7Sl5SG3A4reFet/cUwCKt31rw9JrRai84VytIkiDl
 c5IFQSoHsqtV+BJYK60V2OoGzEIhBIrbuBE7dfDbDXAobzBA2GkArJ9Ho6VxeY15gdvU
 HKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760658083; x=1761262883;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=szGxHxKOPJImLc1PjGnA88xgibt2D3DfORNKrvy/uTc=;
 b=vqnohCfL6/AQzsAl6s3YigO4Ue9a9oBR/9d99HxLIXOXrOGZ1SlMq8OaI6A5ydwftg
 nZIojBZICQOnzkG5rnDi3Jp8rHgvdLdDmZ8y20TpjhrPKKaRxGjarvM/iY9oPdA6/feV
 mRUBaeH5t6b0AFOz03OV5dgxhEOLUHwyTgVjOhmsZo6XYGSZdsXahbW588u+Dd2wF3ej
 IyLpyJe9B7v+Q5UuDVgza5gmm4UvuEmQi9L4Ot8geHNXLFd3lp6llvDqE5O5fRV2TMef
 K1nE7yo+3rWcUYijXD6AjYEu4AcSL2Lcgb1l7DwGwABkDA+r06K3m2MloGhodb3RzMre
 bmCA==
X-Gm-Message-State: AOJu0Yy2j8fGqCl4dQlda7Pv9sYqQ1oKp/fCYa8bfOeRz0PrUI5xRnBh
 iHd+CvbapJgHySbnQxmS6B5wIcN6mUKAgtFV3bgw3Sysm6MgQurUQ56NZkeQfQDkptb/H1rgaXD
 FNsOZq1GUNkQphZbnTrbp0Rn71j+LVoI=
X-Gm-Gg: ASbGncsFlc+E5cArDLPYte/IPMhB3DUBKNAZQmgA+6PJBkgXe/KBhkPavEvqpBRvpjC
 1wjxnKZjeFCfbSxUsNF0LXtenQ7FpxMSqKjPH11EPz+XCA9RgkDaqyWMy8GWUlcubYRF0T6B2Pt
 qWrj4mlfjbewqmnl+aaH3A3BZ0Fxv84PgEM9Y/t6hhlOpwI8L2lAuNPAC0y7SH8o3O3SwGoWhlN
 YNb/E3jVnQqpt1bKZIRC2figTHzqkAmDFzm3iLJn5HtXFA3S6iM04wIaKp9Nu02sAkTADRRL4fW
 2K96aZHzx96ZdS1FQWSOk4DIXg==
X-Google-Smtp-Source: AGHT+IFbNV4/lpY2hkijC2Fc8bOXZZ13D1PVBHSoFtGIt9CkXXZ/9De7wtkKx5xIrJToANXXCO9qUhtna2Gkp6yN9qU=
X-Received: by 2002:a05:6402:4316:b0:63b:fbb7:88bc with SMTP id
 4fb4d7f45d1cf-63c1f628bcamr1475063a12.5.1760658083138; Thu, 16 Oct 2025
 16:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20251014203512.26282-1-anjo@rev.ng>
 <20251014203512.26282-35-anjo@rev.ng>
In-Reply-To: <20251014203512.26282-35-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 17 Oct 2025 09:40:56 +1000
X-Gm-Features: AS18NWCTE-GfrNP2-ZBtoKnO8W6R3KXer5dFjlznBkjeyjYojfLedCby9ADOomg
Message-ID: <CAKmqyKN91tpwX8+0UpV9MxPS6u6X2B4PywEO8Fh_uOYW--GFWw@mail.gmail.com>
Subject: Re: [PATCH v3 34/34] target/riscv: Make pmp.h target_ulong agnostic
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
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

On Wed, Oct 15, 2025 at 6:38=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> The pmp.h header is exposed through cpu.h.  pmp_table_t is also used in
> CPUArchState.  CSR declarations are only used in target/ and are moved to
> csr.h.  In pmp.h, addr_reg is widened to 64 bits and the privilege mode
> parameter is fixed to 8 bits, similar to previous commits.
>
> Note, the cpu/pmp/entry and cpu/pmp VMSTATE versions are bumped, breaking
> migration from older versions.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.h     | 12 ++++++++++++
>  target/riscv/pmp.h     | 20 +++++---------------
>  target/riscv/machine.c | 10 +++++-----
>  target/riscv/pmp.c     | 10 ++++++----
>  4 files changed, 28 insertions(+), 24 deletions(-)
>
> diff --git a/target/riscv/csr.h b/target/riscv/csr.h
> index 552e6c5de5..3752a0ef43 100644
> --- a/target/riscv/csr.h
> +++ b/target/riscv/csr.h
> @@ -78,4 +78,16 @@ void riscv_set_csr_ops(int csrno, const riscv_csr_oper=
ations *ops);
>  /* In th_csr.c */
>  extern const RISCVCSR th_csr_list[];
>
> +/* PMP CSRs, defined in pmp.c */
> +void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
> +                      target_ulong val);
> +target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index);
> +
> +void mseccfg_csr_write(CPURISCVState *env, uint64_t val);
> +uint64_t mseccfg_csr_read(CPURISCVState *env);
> +
> +void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
> +                       target_ulong val);
> +target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index);
> +
>  #endif /* RISCV_CSR_H */
> diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
> index e322904637..f5d6ec2bbf 100644
> --- a/target/riscv/pmp.h
> +++ b/target/riscv/pmp.h
> @@ -22,8 +22,6 @@
>  #ifndef RISCV_PMP_H
>  #define RISCV_PMP_H
>
> -#include "cpu.h"
> -
>  typedef enum {
>      PMP_READ  =3D 1 << 0,
>      PMP_WRITE =3D 1 << 1,
> @@ -50,7 +48,7 @@ typedef enum {
>  } mseccfg_field_t;
>
>  typedef struct {
> -    target_ulong addr_reg;
> +    uint64_t addr_reg;
>      uint8_t  cfg_reg;
>  } pmp_entry_t;
>
> @@ -65,21 +63,13 @@ typedef struct {
>      uint32_t num_rules;
>  } pmp_table_t;
>
> -void pmpcfg_csr_write(CPURISCVState *env, uint32_t reg_index,
> -                      target_ulong val);
> -target_ulong pmpcfg_csr_read(CPURISCVState *env, uint32_t reg_index);
> -
> -void mseccfg_csr_write(CPURISCVState *env, uint64_t val);
> -uint64_t mseccfg_csr_read(CPURISCVState *env);
> +typedef struct CPUArchState CPURISCVState;
>
> -void pmpaddr_csr_write(CPURISCVState *env, uint32_t addr_index,
> -                       target_ulong val);
> -target_ulong pmpaddr_csr_read(CPURISCVState *env, uint32_t addr_index);
>  bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
> -                        target_ulong size, pmp_priv_t privs,
> +                        int size, pmp_priv_t privs,
>                          pmp_priv_t *allowed_privs,
> -                        target_ulong mode);
> -target_ulong pmp_get_tlb_size(CPURISCVState *env, hwaddr addr);
> +                        privilege_mode_t mode);
> +uint64_t pmp_get_tlb_size(CPURISCVState *env, hwaddr addr);
>  void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index);
>  void pmp_update_rule_nums(CPURISCVState *env);
>  uint32_t pmp_get_num_rules(CPURISCVState *env);
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index e86fc58e43..eab3adec4d 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -48,10 +48,10 @@ static int pmp_post_load(void *opaque, int version_id=
)
>
>  static const VMStateDescription vmstate_pmp_entry =3D {
>      .name =3D "cpu/pmp/entry",
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,
>      .fields =3D (const VMStateField[]) {
> -        VMSTATE_UINTTL(addr_reg, pmp_entry_t),
> +        VMSTATE_UINT64(addr_reg, pmp_entry_t),
>          VMSTATE_UINT8(cfg_reg, pmp_entry_t),
>          VMSTATE_END_OF_LIST()
>      }
> @@ -59,8 +59,8 @@ static const VMStateDescription vmstate_pmp_entry =3D {
>
>  static const VMStateDescription vmstate_pmp =3D {
>      .name =3D "cpu/pmp",
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,
>      .needed =3D pmp_needed,
>      .post_load =3D pmp_post_load,
>      .fields =3D (const VMStateField[]) {
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 85199c7387..0839a23086 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -23,6 +23,7 @@
>  #include "qemu/log.h"
>  #include "qapi/error.h"
>  #include "cpu.h"
> +#include "csr.h"
>  #include "trace.h"
>  #include "exec/cputlb.h"
>  #include "exec/page-protection.h"
> @@ -272,7 +273,7 @@ static int pmp_is_in_range(CPURISCVState *env, int pm=
p_index, hwaddr addr)
>   */
>  static bool pmp_hart_has_privs_default(CPURISCVState *env, pmp_priv_t pr=
ivs,
>                                         pmp_priv_t *allowed_privs,
> -                                       target_ulong mode)
> +                                       privilege_mode_t mode)
>  {
>      bool ret;
>
> @@ -331,8 +332,9 @@ static bool pmp_hart_has_privs_default(CPURISCVState =
*env, pmp_priv_t privs,
>   * Return false if no match
>   */
>  bool pmp_hart_has_privs(CPURISCVState *env, hwaddr addr,
> -                        target_ulong size, pmp_priv_t privs,
> -                        pmp_priv_t *allowed_privs, target_ulong mode)
> +                        int size, pmp_priv_t privs,
> +                        pmp_priv_t *allowed_privs,
> +                        privilege_mode_t mode)
>  {
>      int i =3D 0;
>      int pmp_size =3D 0;
> @@ -662,7 +664,7 @@ uint64_t mseccfg_csr_read(CPURISCVState *env)
>   * To avoid this we return a size of 1 (which means no caching) if the P=
MP
>   * region only covers partial of the TLB page.
>   */
> -target_ulong pmp_get_tlb_size(CPURISCVState *env, hwaddr addr)
> +uint64_t pmp_get_tlb_size(CPURISCVState *env, hwaddr addr)
>  {
>      hwaddr pmp_sa;
>      hwaddr pmp_ea;
> --
> 2.51.0
>
>

