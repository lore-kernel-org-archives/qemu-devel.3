Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA513111224B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 01:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w86PS-00015O-Rr; Wed, 01 Apr 2026 20:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w86PQ-00014T-B7
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 20:59:44 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w86PO-0003jJ-KR
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 20:59:44 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso67306866b.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 17:59:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775091581; cv=none;
 d=google.com; s=arc-20240605;
 b=LF3LBdw3pI0FLFjZlHv5MNl53QC8kKTxUTqub2dI66zKP5SR6F4ytz7hoSMnbK0c5u
 K21lYGkYaISGU751PSwAnU5zehuVRWXneQ2ylYhMDkhXfuItcrFSWIAvV1+75WMnUb20
 fNUJgnZN//t+dCz/KKGhO1GMr/2ArQ0zFHujaF9KLYo1iXUNzwwGhlHdNxlVs+Ms0M1Y
 7gqPUESecZFacpLCt65JcSIDab6wtKzChM2Fn/1Id/iMP8w+m3GRmT5dxSO9XauqYJ2p
 /5t/toHHQGXUfzbz0b/GNQ3zz41jREdgb+Y0WVy27MoyHq59StKo+4XuSZdZrsRIv+J4
 lU9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5c2tSPCF9Psa3VdcLhN1zMER21lzsGrGkwopmEuZF0w=;
 fh=cKlZQNqGqu5Ke7cd/xNYXJu0/deycT8i50Y0xttk3OA=;
 b=dxa3k6LYXxnY58VBqSKuX4x3sQjwTVn+opqgqeaDbAozXfIWif05i3uXNOk2QGIpKV
 RtbW8bMd/56iMPDSnVAHC1eTnVhRWDr+8v/EDR72fbtSK4Da7HUmFEWl7mhREeosbych
 mw41mpcL/i4kj1/zRJnu1z9DGnaKtEkS0h0ZACjVK8mLd3RMxytO6eQjjePlhgkNf1Za
 /476jYJzWENECnp/NxeBMvFAsaOy20kt3zD0OAKSdSwL88wuEEcNRcfZxMCZfyfoijL4
 C+RVj7iSod2f1l1inawW+SnU7vxSelxI5NbUXVRdDlhtQJgS/N2e2vLHiZ5M81Hp/BPT
 GDxg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775091581; x=1775696381; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5c2tSPCF9Psa3VdcLhN1zMER21lzsGrGkwopmEuZF0w=;
 b=P2fMq66wWwfnAjzQiKZSS5NxG9acFhLNnct4PGVkD+92B3FFtFS6IzJYoB41nde9Ce
 rEUuAsrJZ5NUZq2QaAh/GNqL2Ua89/RIEbjH3pAiqj6hx0PZunjhwSALq5ATGIY2woFt
 CjM/gQy64aoS5B+gVx5phLFaw0GHD2Ipg/0yWEvIh1rb+inEpb0WOduVE/X1yU0LrMMQ
 oOPUmPVtN5r1pfZdjl+6gBM1nH7eswgIutgjzODo7P7uglz7gQ8AjGt50zGPBruTpEFa
 owy+mxWokJAdnQ5GjHLOj+18TfPdMsTn18GcIpN6/ANJnvnyD2KmhYPtI6XAZ1/pDSfE
 bBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775091581; x=1775696381;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5c2tSPCF9Psa3VdcLhN1zMER21lzsGrGkwopmEuZF0w=;
 b=dTw8v2H+QXn7VmOerDRlgsxNzlrmiA7pcQreDPSxBCKWFpGXSYZrCRFlGI4MsBXYfZ
 k0sh/hZ2Gv2KuHYZr/YjVNsbhTMqk29SYPIOECvXOOXXRgNqXTlVpPIVOLI2yjsJ0LMe
 Peieew4vC/C2bNfmyPFoaOUsEf0YOGQORgg8oXvRKUr/S03bQfCBJQ8sihgKCDO+NW34
 shXpVXfYNXk11YXujlOqQIzPVSJ6MNvjHaJA76Cf20ho9YVZs9X2gP/Fk2AEmQO163PD
 TUXBiE4GKWbQfuEQE1++kX7ONUfwv4AHMeG9j6BRCHCTYnLb3t6K8NvksSR398Jh3fFv
 ebAQ==
X-Gm-Message-State: AOJu0Yx7BIlHvSyKllGcIhFlDhUmKsJbwsdRNd0/s5QtGTejE60/MkAf
 /OdULddrjhdmf6PQ3ZeylLNA1Ed68fy2kLc2SL/rZM2WM3VhtFe8uoefmTkUgiFRMcTt3n8gDTH
 d46GZdb9HkwoylHbrxtpvzO9C5Jyg9Ek=
X-Gm-Gg: ATEYQzyfGgOuRmFCSPsSlE3yn9mxAWlzxjntHlGwkCzJXSDXlqLRWMaNc5w/UMjDOoG
 DSJCE6vSlg3pejZvlY7erIBtAswiKiNDVVrRbukWVkxRcpk9ng+DujNh7LT1/ip6PJGoRgXJoOg
 BzkQqVzcQwx7hX6phiq81QYP0ublUzslb+2D0OVcvg6y7fDoxfS0XdVwHQoiMkyDByo3IIN57bB
 bdfToX4ulxzlmP/T60TM5mCvsDhmxvQP38ZYPzbIImLEbehYuensAo/1VZzrJ+UTXiHIlsE+bK1
 jBL8iQ+la8RyhanvOS5369UHtsKQ1t402hHDUQ==
X-Received: by 2002:a17:907:1ca8:b0:b9b:5fee:4d51 with SMTP id
 a640c23a62f3a-b9c46e25ed1mr20675266b.10.1775091580969; Wed, 01 Apr 2026
 17:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260401053853.10473-1-sebasjosue84@gmail.com>
 <20260401053853.10473-2-sebasjosue84@gmail.com>
In-Reply-To: <20260401053853.10473-2-sebasjosue84@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Apr 2026 10:59:14 +1000
X-Gm-Features: AQROBzC-F_GVumR9l4b8rD6KCFrcOU7STZ472ZKnUkEW1wKXp4oHubL5fUzrmO8
Message-ID: <CAKmqyKN9-ESC+OzNw8ntrdVf3MAMD-mtvaL75o2nv1aKa=OV4w@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/intc: fix heap OOB in ACLINT MTIMER multi-socket
To: =?UTF-8?Q?Sebasti=C3=A1n_Alba_Vives?= <sebasjosue84@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 palmer@dabbelt.com, berrange@redhat.com, qemu-security@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x634.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

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

