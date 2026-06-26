Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E45BCDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 01:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcvEM-0007cX-19; Thu, 25 Jun 2026 21:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcvEK-0007cH-9k
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:19:40 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcvEH-0005R7-Ee
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 21:19:40 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-69532288224so878758a12.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 18:19:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782436776; cv=none;
 d=google.com; s=arc-20260327;
 b=miho7GfPHEsExXPn90DD7zkAOs5m4hNWHSpTi/Gt++ffBGMWauShFP0VbO9nWDzLJU
 pSxTt06nHQ1xAmqEnZCjoaMKm/qFK7k6ujdjrxopWAhfgyazucBOE43O9/ETY7s9OYqY
 uJhEDybO034dQK0NuiBNyOAW+NyqOZQpI4ad60ulV9Eo8wtLgSWTq9iQ41u5HLTz3V/X
 j4R/TbiF5ryJ7+6QizcjsXhx2xtf/a+VT3UStaPbj+ILBwy9Nk9EuKbUQDaU9lWkoM+r
 w1JBQWnV1aW0rinr4HCnvZ0R2z0JYUmuAxencpmOQIw8e8aMQ1/BDCfQST9pGfCHdOrW
 9Waw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WrGnpYL99r6KB3L4qRmfenqUH5OVxv5FZZI52Lxenfg=;
 fh=9/4tzqKjgzJcjmYJcCvfm+LbcgW0ATp/rdwAYjKmbVo=;
 b=ItaSfGKoyeu6ijRRSXS5Ho3HXsuqrjkXHIrO391Wo6ECXAuE74WMbcUVSpJ+qWqJ+d
 BTmNYhtHNNOTrHB03uv6o3spoCTsa1zi3irD3Neu/H+pNjAXvjRsa9kA0nj6fRrrfrdR
 +pm4HCM+IQCItbSfMie4u70N9azezaHnon7fZfSGSXvULPDwXBvEcMe5qUGpqeIbX7LE
 Dh04WyS//rYFDtC2vumpUBOaBzNunYhRljVa7mo3c+QIGltszIK7H0viqpZrBGvweFec
 QyCzpBzPJVabjx30vQC+9kZ1E4eDfjEa7fNw15AI7TwF5aIzbvNGFbxLY7xyLdUAXn0x
 M05w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782436776; x=1783041576; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WrGnpYL99r6KB3L4qRmfenqUH5OVxv5FZZI52Lxenfg=;
 b=UWk3KXLnO+oUS1awvJO1BR9wu2dz6FVigCcVt7jxvGA1SF+mf1/60amIzUOIItBqF5
 6GEzXGBtfcMjX6W4a6o0Uq86NeafsSJFwNd+Vn4jw6RUAjQbalUy3cJi2H5IPZM2Wqy0
 YSUP36x8YTXxDHZ8xUaxJOy6V+HoKjj8ZnP34Xo8A6CBb2lx2JbCUICuK1hCryuIEo62
 xBnbWSm2We5JiAanq7I4BCpcwQtslDdDeA+yOosdtKlrcN/em/9iGVzbuJq+j7nrdpdl
 +YVu6zqrNksy53+f4UL4S2ywAtf4DQlXwqYg3CNwiyvb4j03OFxoKKxorMXw8y+SnuQd
 8ifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782436776; x=1783041576;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WrGnpYL99r6KB3L4qRmfenqUH5OVxv5FZZI52Lxenfg=;
 b=sfDBeSPazI81v/jyWlhIYzgk2pUTwsS8IOI4tmlURYN8KLFWDu+d06db6AocRmv413
 9RpwmDWkFAbMN5fbcYaovnzdAkQFeW/+vuS2+czTFY/R+jgX/d16xSItqLVKUk4k5mqN
 wuktttlX/MYkNPZEy43BtP3QWthLAbAz5y+H3IVTOU/xyyT9ZaFWQ6g3dXBDf5MauFJe
 lT5DTnoKqr9YZnB9P4bxWrKycJcKCWq+ZcdVD/qNqFdf4iNjAGHlxESXKqJkfbY/0eUm
 /SOrUo+lRGzQNBdaZTS/18U6DpjFxH0fKH5Y50n2kAZTAn6YWDEPSHoMHAJntZWpBq3/
 rlxg==
X-Gm-Message-State: AOJu0YwEm3H+GqjzXW9neZMVHkmjkDrJp9mFTlCYD5+7W9hLS9btP88g
 1a9fh/N833z+WmVxA9n8vZSHAsGeuAuVVbp9ZWSSHLd8xJXE3kHylc27zWzUUvho0ZWep2c8CnZ
 yJvmI+PchxeMhK6rG9bfhNXYuliwnH/c=
X-Gm-Gg: AfdE7cmKT77iBGCLZ1LsDDRujCnX2izIU1FhDUNTHL7CvxxUZAhlMJWFpZCsiAsleFH
 ntZmy8SJVQvyCxffIhLz3O9182LIpNnK21i2K010OQyi26GvUcK915OaAjVOmrIX3QeeUWO8jZy
 LKkCXCWZV4KOKLzEmdwla1VSIjOT8/YQ0eQo1BawX1/yAnS2bzMSLv6LxDP0AYD6PbmrYR8EbGI
 rWRXI5lnUgcUMWfCCqiA8NhhYG2fjuIoj+NDhSD80idAWpBxNfFruJY5GW3f/MjRnSq58hybKYJ
 RoC6y+y+BC+w+kaYURalSM5nZZzVjFxlRk7ukQ==
X-Received: by 2002:a05:6402:510a:b0:697:de29:c802 with SMTP id
 4fb4d7f45d1cf-69810ab88f9mr852104a12.18.1782436775661; Thu, 25 Jun 2026
 18:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
 <20260624000632.2149359-20-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260624000632.2149359-20-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jun 2026 11:19:09 +1000
X-Gm-Features: AVVi8CeX2mVfx3VCgo4AH6ROhtrZybeQ43EtKKrEuhInt6CNi60s2S38GgpyTDY
Message-ID: <CAKmqyKO=1f66bC20+z8c1B4+xdnQz1po3yKq08txrMGE8-ZXSA@mail.gmail.com>
Subject: Re: [PATCH v2 19/24] target/riscv/gdbstub.c: isolate TCG only checks
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 fritchleybohrer@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
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

On Wed, Jun 24, 2026 at 10:10=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> The following functions are TCG only and are broken, if they were ever
> usable in the first place, with KVM:
>
> - riscv_gdb_(get|se)t_csr
> - riscv_gdb_(get|set)_virtual
> - riscv_gen_dynamic_csr_feature
>
> Gate everything with TCG enabled to at least get them out of the way to
> enable --disable-tcg.
>
> As a note for the future: other archs have distincts gdbstub files for
> each accelerator.  There's a strong case for RISC-V to do the same.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/gdbstub.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index f0a5e0d86f..9abbf5bcdf 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -164,6 +164,7 @@ static int riscv_gdb_set_vector(CPUState *cs, uint8_t=
 *mem_buf, int n)
>      return 0;
>  }
>
> +#ifdef CONFIG_TCG
>  static int riscv_gdb_get_csr(CPUState *cs, GByteArray *buf, int n)
>  {
>      RISCVCPU *cpu =3D RISCV_CPU(cs);
> @@ -294,6 +295,7 @@ static GDBFeature *riscv_gen_dynamic_csr_feature(CPUS=
tate *cs, int base_reg)
>
>      return &cpu->dyn_csr_feature;
>  }
> +#endif /* CONFIG_TCG */
>
>  static GDBFeature *ricsv_gen_dynamic_vector_feature(CPUState *cs, int ba=
se_reg)
>  {
> @@ -336,7 +338,6 @@ static GDBFeature *ricsv_gen_dynamic_vector_feature(C=
PUState *cs, int base_reg)
>
>  void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
>  {
> -    RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(cs);
>      RISCVCPU *cpu =3D RISCV_CPU(cs);
>      CPURISCVState *env =3D &cpu->env;
>      if (env->misa_ext & RVD) {
> @@ -351,6 +352,10 @@ void riscv_cpu_register_gdb_regs_for_features(CPUSta=
te *cs)
>                                   riscv_gdb_set_vector,
>                                   ricsv_gen_dynamic_vector_feature(cs, cs=
->gdb_num_regs));
>      }
> +
> +#ifdef CONFIG_TCG
> +    RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(cs);
> +
>      switch (mcc->def->misa_mxl_max) {
>      case MXL_RV32:
>          gdb_register_coprocessor(cs, riscv_gdb_get_virtual,
> @@ -371,4 +376,5 @@ void riscv_cpu_register_gdb_regs_for_features(CPUStat=
e *cs)
>          gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_cs=
r,
>                                   riscv_gen_dynamic_csr_feature(cs, cs->g=
db_num_regs));
>      }
> +#endif
>  }
> --
> 2.43.0
>
>

