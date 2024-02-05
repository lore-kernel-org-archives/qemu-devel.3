Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE25C48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 03:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWpus-0005hX-PI; Sun, 04 Feb 2024 22:45:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWpuq-0005gf-D3; Sun, 04 Feb 2024 22:45:04 -0500
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWpuo-0005wT-Hw; Sun, 04 Feb 2024 22:45:04 -0500
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7d5c514944fso2742404241.1; 
 Sun, 04 Feb 2024 19:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707104701; x=1707709501; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dwZJ8g3H8jf92vVV68XSO/qe/RJMIgagMBO/0VPXpAA=;
 b=XMGz3ZvW57f20TETTJHM1LK3G02LnUiL50ZvdIlT/t+3y3Y3brH2CjZgckF6uesM6w
 KbSou2VMGMG+TXZ2N1zRroaV4TcabdiKic8SKn7gPGNW+swKiWyPj1Roh0GW1+xkWEj9
 FBVcpZDLDpDGIEXppWS/v6fqJa7iDCikUlrhDIFi8m+EmNh9A3M5Tfwqo2EC26Jz9soD
 GLOVDrtp87Blj1127DGyGfSBiasNIgiUEgEfdUkhm+bRmYg3zlXfrGr0XXtgkml2CDn8
 RwX0GL5etOt6Brm3kgIxs/AezdJYMlGne/1fnk4OeUakWmdsaUy8VZqNyuvJfG3PELDJ
 aaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707104701; x=1707709501;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dwZJ8g3H8jf92vVV68XSO/qe/RJMIgagMBO/0VPXpAA=;
 b=W/8zo9UQ2HVbHBCD2rwBVVTyL12R7Mhn7uiX1/BbqvTdp/E5zAj+Lwy6s0cUCufjL8
 hLs/3xwgV1ZhTRyNgZp3WbA6ZJcZBKk2sFG78L6gqq78RFUB4TooYBAGLOxIPTFBUyCQ
 QdzpIvYUM3mmHGP9KamWkMvkTu64lxMXyP2f9si66x0CSbCNa4tb2xHWweGDf7KKvYP2
 GHdcfRJ+5+YWM6cewU6PpGl/PjC0oemfZkTt/IIrhAIEjK0SAj9s+GzOezs6AoI4akrV
 6Vhs5bKpjYZ49wldAR1JUTJSgm0cBwJEg+BWIRLwY52aoPN1D9zBYR12+iqs9PrDHvdK
 sxbg==
X-Gm-Message-State: AOJu0Yw59Ug7ZiCFWzIpYT8LYgDLhX4hBxplehGmS9z+Qt021t/ofbjG
 fFEfwLkNXCGSPq5NveomUoTHBjh4ivXxA6+l5YmIlcdbwmamUYUk/UHFmSPmq18kyIXIakh1ZuY
 U+eB3s61cRVrslMmTQcch3la/dbY=
X-Google-Smtp-Source: AGHT+IFx/wUFRUZtXFPZPFHmUecj9d+sT+drqf9st2l3wLCXhizx4KD6Kycj3t2whOeHkkUqCUNCPrOTjhGw3gch/jM=
X-Received: by 2002:a05:6102:515:b0:46d:210a:78a0 with SMTP id
 l21-20020a056102051500b0046d210a78a0mr1976295vsa.0.1707104699942; Sun, 04 Feb
 2024 19:44:59 -0800 (PST)
MIME-Version: 1.0
References: <20240124-squatting-getup-a16a8499ad73@spud>
 <20240124-swear-monthly-56c281f809a6@spud>
In-Reply-To: <20240124-swear-monthly-56c281f809a6@spud>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Feb 2024 13:44:33 +1000
Message-ID: <CAKmqyKNuT-46MpHN4LmoYD1H4PJPRzFTqOp27Jv18=BB+2abFg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] target/riscv: use misa_mxl_max to populate isa
 string rather than TARGET_LONG_BITS
To: Conor Dooley <conor@kernel.org>
Cc: qemu-riscv@nongnu.org, Conor Dooley <conor.dooley@microchip.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jan 25, 2024 at 12:04=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> A cpu may not have the same xlen as the compile time target, and
> misa_mxl_max is the source of truth for what the hart supports.
>
> The conversion from misa_mxl_max to xlen already has one user, so
> introduce a helper and use that to populate the isa string.
>
> Link: https://lore.kernel.org/qemu-riscv/20240108-efa3f83dcd3997dc0af458d=
7@orel/
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> I dropped the tags since I added the helper
> ---
>  target/riscv/cpu.c     | 9 ++++++++-
>  target/riscv/cpu.h     | 1 +
>  target/riscv/gdbstub.c | 2 +-
>  3 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ad1df2318b..4aa4b2e988 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -307,6 +307,11 @@ void riscv_cpu_set_misa(CPURISCVState *env, RISCVMXL=
 mxl, uint32_t ext)
>      env->misa_ext_mask =3D env->misa_ext =3D ext;
>  }
>
> +int riscv_cpu_max_xlen(CPURISCVState env)
> +{
> +    return 16 << env.misa_mxl_max;
> +}
> +
>  #ifndef CONFIG_USER_ONLY
>  static uint8_t satp_mode_from_str(const char *satp_mode_str)
>  {
> @@ -2332,7 +2337,9 @@ char *riscv_isa_string(RISCVCPU *cpu)
>      int i;
>      const size_t maxlen =3D sizeof("rv128") + sizeof(riscv_single_letter=
_exts);
>      char *isa_str =3D g_new(char, maxlen);
> -    char *p =3D isa_str + snprintf(isa_str, maxlen, "rv%d", TARGET_LONG_=
BITS);
> +    int xlen =3D riscv_cpu_max_xlen(cpu->env);
> +    char *p =3D isa_str + snprintf(isa_str, maxlen, "rv%d", xlen);
> +
>      for (i =3D 0; i < sizeof(riscv_single_letter_exts) - 1; i++) {
>          if (cpu->env.misa_ext & RV(riscv_single_letter_exts[i])) {
>              *p++ =3D qemu_tolower(riscv_single_letter_exts[i]);
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 05e83c4ac9..aacc031397 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -511,6 +511,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, =
int size,
>                          MMUAccessType access_type, int mmu_idx,
>                          bool probe, uintptr_t retaddr);
>  char *riscv_isa_string(RISCVCPU *cpu);
> +int riscv_cpu_max_xlen(CPURISCVState env);
>  bool riscv_cpu_option_set(const char *optname);
>
>  #define cpu_mmu_index riscv_cpu_mmu_index
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index 58b3ace0fe..f15980fdcf 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -218,7 +218,7 @@ static int riscv_gen_dynamic_csr_xml(CPUState *cs, in=
t base_reg)
>      CPURISCVState *env =3D &cpu->env;
>      GString *s =3D g_string_new(NULL);
>      riscv_csr_predicate_fn predicate;
> -    int bitsize =3D 16 << env->misa_mxl_max;
> +    int bitsize =3D riscv_cpu_max_xlen(*env);
>      int i;
>
>  #if !defined(CONFIG_USER_ONLY)
> --
> 2.43.0
>
>

