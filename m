Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C44606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 02:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OVCdq02P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQbwF-0006vw-J3; Mon, 09 Nov 2026 21:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guoren@kernel.org>) id 1xQbw6-0006bd-9d
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 21:50:14 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guoren@kernel.org>) id 1xQbw4-0004Y9-6l
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 21:50:13 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2BFC9636A4
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 02:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F2D1F008BE
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 02:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794279008;
 bh=3zbBDorW18pGxfA+56aRKlmSuwQe3evaU/AhhR9Vni8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=OVCdq02PUnzA4ODSgn27ZgfyJLFVmQs6b8rA8/KtvgeVYy968ShOTIiWa3wjByzUR
 Yu8HTsSt3fNwvU9pUEiGHTW2kVMRjgen3x/zBguYPrj7G0WMzFBgqFIHTZSgmREMuC
 3Rxz5G+x6RI1UqQuZw0bE6SIkpPG0XTg7SSXjooGfaTcHCATfm9EFUCxxzS7ph4xTK
 2CCUTB2Tpv8TkjGbhJhL/2MBbwMaqGjMkNCo93M9Hjxy6Zpx6hJUx3RmqL9eDrR+1t
 X9JrHcFw+5OGoXBaNW3sCdUMdlkpOWiJZVbQFG+bn9r6ybTIOukfG17AYsHkf6fVfb
 akzwWX0AloetA==
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-49412eb1474so973000f8f.3
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 18:50:08 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErEqosvSHZLq6Wv3vPc9IgtMqs24SemOErg7TGLt4P4N9lqoQQK8dIOI+FxzSD6yk2Kf7NtZZ9yEF1l9@nongnu.org
X-Gm-Message-State: APuU4Z+Cmsbb2w7CuvGT2QP0Ov8z2yY/5M6fpQ2TDYr/A1bcIgL5H8Rc
 OjommJMbG332rVmwVxpyvsNst9Y3JG92K/DuQ4eKpXUsrl0/nI5lbWuTylvFpz2c+/9yWAY3s5s
 vwX8HueOfd/KzTOsEHibOoIcwbDKagrw=
X-Received: by 2002:adf:e195:0:b0:48e:75a1:1e38 with SMTP id
 ffacd0b85a97d-49831cd14b8mr1811348f8f.56.1794279007468; Mon, 09 Nov 2026
 18:50:07 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261109135633.64867-1-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20261109135633.64867-1-fangyu.yu@linux.alibaba.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 10 Nov 2026 10:49:54 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS4rqVk5r-mJ49AFH5VWTh=FiB6VO3o=VkaDkyzFpCjMQ@mail.gmail.com>
X-Gm-Features: AclHuK_uvJxmT4WkPCul46UIbZjgk1YEGhOErIogpq6gCjfBjKhXTzo0jHCXlhA
Message-ID: <CAJF2gTS4rqVk5r-mJ49AFH5VWTh=FiB6VO3o=VkaDkyzFpCjMQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: fix exception PC for WFI
To: fangyu.yu@linux.alibaba.com
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=172.105.4.254; envelope-from=guoren@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 9, 2026 at 9:56=E2=80=AFPM <fangyu.yu@linux.alibaba.com> wrote:
>
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> trans_wfi() advances env->pc before calling helper_wfi(), which may
> raise illegal or virtual-instruction exceptions through GETPC().
Yes, this is the problem. Good catch!

> With CF_PCREL, restoring the instruction PC uses env->pc's page base.
> If the next instruction is in a different page, the exception PC is
> restored one page too high. This affects both a WFI ending exactly at
> a page boundary and one crossing it.
>
> Keep env->pc pointing at WFI while helper_wfi() can raise an exception,
> and pass the instruction length to the helper. Advance env->pc only on
> the normal single-step or halt paths.
>
> Fixes: 356c13f94dbf ("target/riscv: Enable PC-relative translation")
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  target/riscv/helper.h                              | 2 +-
>  target/riscv/tcg/insn_trans/trans_privileged.c.inc | 4 ++--
>  target/riscv/tcg/op_helper.c                       | 6 +++++-
>  3 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/helper.h b/target/riscv/helper.h
> index 1cffcad580..b36e3532aa 100644
> --- a/target/riscv/helper.h
> +++ b/target/riscv/helper.h
> @@ -135,7 +135,7 @@ DEF_HELPER_1(mret, tl, env)
>  DEF_HELPER_1(dret, tl, env)
>  DEF_HELPER_1(mnret, tl, env)
>  DEF_HELPER_1(ctr_clear, void, env)
> -DEF_HELPER_1(wfi, void, env)
> +DEF_HELPER_2(wfi, void, env, i32)
>  DEF_HELPER_1(wrs_nto, void, env)
>  DEF_HELPER_1(tlb_flush, void, env)
>  DEF_HELPER_1(tlb_flush_all, void, env)
> diff --git a/target/riscv/tcg/insn_trans/trans_privileged.c.inc b/target/=
riscv/tcg/insn_trans/trans_privileged.c.inc
> index e22df6fbe7..3ca55b9842 100644
> --- a/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> +++ b/target/riscv/tcg/insn_trans/trans_privileged.c.inc
> @@ -167,8 +167,8 @@ static bool trans_wfi(DisasContext *ctx, arg_wfi *a)
>  {
>  #ifndef CONFIG_USER_ONLY
>      decode_save_opc(ctx, 0);
> -    gen_update_pc(ctx, ctx->cur_insn_len);
> -    gen_helper_wfi(tcg_env);
> +    gen_update_pc(ctx, 0);
> +    gen_helper_wfi(tcg_env, tcg_constant_i32(ctx->cur_insn_len));
>      ctx->base.is_jmp =3D DISAS_NORETURN;
>      return true;
>  #else
> diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
> index f9c79fe6b9..3f71258858 100644
> --- a/target/riscv/tcg/op_helper.c
> +++ b/target/riscv/tcg/op_helper.c
> @@ -625,7 +625,7 @@ void HELPER(ctr_clear)(CPURISCVState *env)
>      riscv_ctr_clear(env);
>  }
>
> -void HELPER(wfi)(CPURISCVState *env)
> +void HELPER(wfi)(CPURISCVState *env, uint32_t insn_len)
Yes, WFI can be either a 16-bit compressed instruction or a 32-bit
instruction. The helper is runtime code and has no other way to know
the instruction length, so it must be passed in order to correctly
advance env->pc on the non-exception path. This approach is
reasonable.

>  {
>      CPUState *cs =3D env_cpu(env);
>      bool rvs =3D riscv_has_ext(env, RVS);
> @@ -639,6 +639,10 @@ void HELPER(wfi)(CPURISCVState *env)
>                 (prv_u || (prv_s && get_field(env->hstatus, HSTATUS_VTW))=
)) {
>          riscv_raise_exception(env, RISCV_EXCP_VIRT_INSTRUCTION_FAULT, GE=
TPC());
>      } else {
> +        env->pc +=3D insn_len;
> +        if (env->xl =3D=3D MXL_RV32) {
> +            env->pc =3D (int32_t)env->pc;
uint64_t pc;
Yes, RV32's pc is sign-extended and stored in uint64_t.

Reviewed-by: GUO Ren (XuanTie) <guoren@kernel.org>

--=20
Best Regards
 Guo Ren

