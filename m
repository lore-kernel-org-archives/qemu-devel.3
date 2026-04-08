Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396E610FC450
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 21:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAatA-0004pV-NQ; Wed, 08 Apr 2026 17:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAat9-0004pI-QN
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 17:56:43 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1wAat7-0001WW-9Y
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 17:56:43 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so1138315ad.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 14:56:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775685399; cv=none;
 d=google.com; s=arc-20240605;
 b=ek/2GVCp9S+r7d3VOMPtBWIIR3XbWeHjpAHmtv/9t0cmpOhEtTe2f92FSjDgK7oGPN
 BvmRKYOO2ZDMfl0KzAG+iPNqPBWJ4YaC2KnOVfK2UNdk4Uf82NFLEfjDFpyAc4qgIwZH
 PLlhcNUeD6pRfd/2rvwHc1YcfM8ux8s4LEaYjXcQ/52PNPPpDQ9dWLYHGzpXDQNUjH74
 uEsq+v7Sd8jo/Nj/V5/PS03S156SfhCIEclggRtn1l8cPJtqjm7lCEAkkCugswO8xQPh
 zdKcirY9xnxEH4vqeGxVUwl6FPgo5Bs1fI4LY3+BUHJvtUGLWP7GDYLCb7oznMRKmyVW
 Xjgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=n1VszSyqsIzCOwt1Jzlk/UBamUHXbDlwcWyTttfFv04=;
 fh=seHpsuERei6GoCJPMtZiXpXOw/2EVnvuQ7nSTREwIqg=;
 b=REcDhzK0iqeX4pnj4+KArhcALYH7uXrckmlaEIUzHrlAbzNzCIDveGagXc7B3O4XLH
 zW7jBK30SHowU2bZUSGtYNEB0UlLcW4unml/YS2ktHCAIgGkp5LOo6vnhcCSNFy15jz6
 XBSh3a6wY/N7Kwn3q907E74QsbEi0JcLMbSOniwt+05XnXD1HawrfZahPOxtJ9o33OqO
 jNE54XaN+Hq/t9fj18H5h/oB2LnXVABzofmUzfnYcQO2eUKgRhDvrfTdmyZtb0vXiIy9
 MyCzA5H8G9mnZ36xXhWcmNV1kpMxxuXAfKZk7ZKxAB6f021lUVg0/9aDM9vDr4zJa7CY
 JVHw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775685399; x=1776290199; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n1VszSyqsIzCOwt1Jzlk/UBamUHXbDlwcWyTttfFv04=;
 b=eZzA0uh75NOi6b7mJ7WAEhG8hMuUuSdgV1TfWvu3UDDgHPsn4vI+2B64W/ClIb7Yle
 a/zNrkXcctpiyAOG6KXU1v69al8Oxs7TDykyYhDuSShMXF+8Bxu7LQ+73RtD9y6szq78
 /VJxZZ7fA91wCdRs3NOqxhh8zoBzLJIWr9zlEETnLdbYDuV2K1/eoH9qst68aNG9jR9i
 w3npkftSPsp720qnyaPpEfttkgdiGg0kHCOWT1B7dbfxo52vkTQIg06agaw8Dol2K+g7
 i2Nn/4pQxOd2htKYf3C0SyzjFU36e+TpXn/Oxxaz3pOHge24sGmA7csKMHx2wRDREhSH
 re/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775685399; x=1776290199;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n1VszSyqsIzCOwt1Jzlk/UBamUHXbDlwcWyTttfFv04=;
 b=so5WRPAfhjkvMazUY27muiGtoLYI0rx83OOtqH7dr81WzNFnKSgM4C1x9NFt+HavOt
 qgyQHf114TFCPkMupi6jOgCIKZyQlH5vrnIxR5+IHvUt4R6vwsu7cSEIEziYsKn2M5O+
 nJsY3x4mN9YO5f/5y+r22J9WiwXGI16u8wmU3AK9yXftY8t1CjquAuryQjLukRh5wAo5
 srQrNPOoyYVhmDZ8Xc8ubSmgeJ88+EThQmrYO+dDsOkg95VrUn9oE+0c/30xwGhuVFoD
 gTUVPzsK+3lsTv8V/EI/7K2vzuVtOwsqYgZaPz/jAVmCR1mFVqgFy0EwANzUuhG54RA6
 g6ww==
X-Gm-Message-State: AOJu0YyJbJIpMFkLXrKeNJJ2UjoW9m772UuwJ2jkTI5YyxCW1NHF/hxI
 FoXSXW9NlHq2NxiIcNvCutaVnncf0HD7b8mct+Ks0RktGQqq9WYKCqzl4Ib3x41ETqZxHibFdnD
 hh0gFr/9RD4ysOgH6yNY7r0lnu4HKL4A=
X-Gm-Gg: AeBDiesdJH0sboX4mSYrpp2XR43lGLBSp7979KSK7ie3rksGPIbKT37CcbQLJ0Ze4O2
 4SGRON7+KZDwMeqLnWt5ivfw/+Z8wwmiFg3a+YDhczVIRezO/0X0Vm23NvS+aaL1cQWOhywcZnp
 f+pjpsks0m1ElpduSnhGXvTH0Ak5IAA0PPwyfOJEcHkfuwCg1Q4QCYGPvCuv2PnsG/O0bEDpLXY
 v633pB49kwd1qYasovmmLhViD9Nh5Nn63SkaRj9BQ4V1SjE8ZbgrXoVYOXLW/+vUuOLX4h4MC8V
 YiR5Gb9azL9R+tffdXUEAWFsUG+aTOf4CtL9P4s=
X-Received: by 2002:a17:903:1ae6:b0:2b2:54db:3e93 with SMTP id
 d9443c01a7336-2b2c736f057mr8904655ad.23.1775685399230; Wed, 08 Apr 2026
 14:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1775665981.git.matheus.bernardino@oss.qualcomm.com>
 <bd05d9aa88d98453e25e5f3189f1a5d7bdbbc9af.1775665981.git.matheus.bernardino@oss.qualcomm.com>
In-Reply-To: <bd05d9aa88d98453e25e5f3189f1a5d7bdbbc9af.1775665981.git.matheus.bernardino@oss.qualcomm.com>
From: Taylor Simpson <ltaylorsimpson@gmail.com>
Date: Wed, 8 Apr 2026 15:56:26 -0600
X-Gm-Features: AQROBzCmBu6f_hY4tJaYUK9XEEJBfMtw-OAKocoB4r-sP3r2y1AvM5lIRHiHKkM
Message-ID: <CAATN3NqVHaLtTYc46YKvHo6V8U4LZc9b7w6COnLNR4_3wmePdA@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] target/hexagon/cpu: add HVX IEEE FP extension
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, ale@rev.ng, 
 anjo@rev.ng, brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com, 
 philmd@linaro.org, quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: multipart/alternative; boundary="000000000000743c55064ef9f969"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000743c55064ef9f969
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino <
matheus.bernardino@oss.qualcomm.com> wrote:

> This flag will be used to control the HVX IEEE float instructions, which
> are only available at some Hexagon cores. When unavailable, the
> instruction effectively only set the destination registers to 0.
>
> Signed-off-by: Matheus Tavares Bernardino <
> matheus.bernardino@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h             |  1 +
>  target/hexagon/translate.h       |  1 +
>  target/hexagon/attribs_def.h.inc |  3 +++
>  target/hexagon/cpu.c             |  1 +
>  target/hexagon/translate.c       |  1 +
>  target/hexagon/gen_tcg_funcs.py  | 11 ++++++++++
>  target/hexagon/hex_common.py     | 35 ++++++++++++++++++++++++++++++++
>  7 files changed, 53 insertions(+)
>
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 85afd59277..77822a48b6 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -127,6 +127,7 @@ struct ArchCPU {
>      bool lldb_compat;
>      target_ulong lldb_stack_adjust;
>      bool short_circuit;
> +    bool ieee_fp_extension;
>  };
>
>  #include "cpu_bits.h"
> diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h
> index b37cb49238..516aab7038 100644
> --- a/target/hexagon/translate.h
> +++ b/target/hexagon/translate.h
> @@ -70,6 +70,7 @@ typedef struct DisasContext {
>      target_ulong branch_dest;
>      bool is_tight_loop;
>      bool short_circuit;
> +    bool ieee_fp_extension;
>      bool read_after_write;
>      bool has_hvx_overlap;
>      TCGv new_value[TOTAL_PER_THREAD_REGS];
> diff --git a/target/hexagon/attribs_def.h.inc
> b/target/hexagon/attribs_def.h.inc
> index 9e3a05f882..c85cd5d17c 100644
> --- a/target/hexagon/attribs_def.h.inc
> +++ b/target/hexagon/attribs_def.h.inc
> @@ -173,5 +173,8 @@ DEF_ATTRIB(NOTE_SHIFT_RESOURCE, "Uses the HVX shift
> resource.", "", "")
>  DEF_ATTRIB(RESTRICT_NOSLOT1_STORE, "Packet must not have slot 1 store",
> "", "")
>  DEF_ATTRIB(RESTRICT_LATEPRED, "Predicate can not be used as a .new.", ""=
,
> "")
>
> +/* HVX IEEE FP extension attributes */
> +DEF_ATTRIB(HVX_IEEE_FP, "HVX IEEE FP extension instruction", "", "")
> +
>  /* Keep this as the last attribute: */
>  DEF_ATTRIB(ZZ_LASTATTRIB, "Last attribute in the file", "", "")
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
> index ffd14bb467..8b72a5d3c8 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -54,6 +54,7 @@ static const Property hexagon_cpu_properties[] =3D {
>      DEFINE_PROP_UNSIGNED("lldb-stack-adjust", HexagonCPU,
> lldb_stack_adjust, 0,
>                           qdev_prop_uint32, target_ulong),
>      DEFINE_PROP_BOOL("short-circuit", HexagonCPU, short_circuit, true),
> +    DEFINE_PROP_BOOL("ieee-fp", HexagonCPU, ieee_fp_extension, true),
>  };
>
>  const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS] =3D {
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 633401451d..fa8f615a9e 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -988,6 +988,7 @@ static void
> hexagon_tr_init_disas_context(DisasContextBase *dcbase,
>      ctx->branch_cond =3D TCG_COND_NEVER;
>      ctx->is_tight_loop =3D FIELD_EX32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP=
);
>      ctx->short_circuit =3D hex_cpu->short_circuit;
> +    ctx->ieee_fp_extension =3D hex_cpu->ieee_fp_extension;
>  }
>
>  static void hexagon_tr_tb_start(DisasContextBase *db, CPUState *cpu)
> diff --git a/target/hexagon/gen_tcg_funcs.py
> b/target/hexagon/gen_tcg_funcs.py
> index 87b7f10d7f..b752ec883c 100755
> --- a/target/hexagon/gen_tcg_funcs.py
> +++ b/target/hexagon/gen_tcg_funcs.py
> @@ -22,6 +22,14 @@
>  import string
>  import hex_common
>
> +def gen_disabled_ieee_insn(f, tag, regs):
> +    f.write("    if (!ctx->ieee_fp_extension) {\n")
> +    for regtype, regid in regs:
> +        reg =3D hex_common.get_register(tag, regtype, regid)
> +        if reg.is_hvx_reg() and reg.is_written():
> +            reg.gen_zero(f)
>

What happens to the non-HVX registers that are written (e.g., address for a
post-increment load)?  I assume they should also be set to zero.


> +    f.write("        return;\n")
> +    f.write("    }\n")
>
>  ##
>  ## Generate the TCG code to call the helper
> @@ -62,6 +70,9 @@ def gen_tcg_func(f, tag, regs, imms):
>          i =3D 1 if immlett.isupper() else 0
>          f.write(f"    int {hex_common.imm_name(immlett)} =3D
> insn->immed[{i}];\n")
>
> +    if "A_HVX_IEEE_FP" in hex_common.attribdict[tag]:
> +        gen_disabled_ieee_insn(f, tag, regs)
> +
>      if hex_common.is_idef_parser_enabled(tag):
>          declared =3D []
>          ## Handle registers
> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
> index c0e9f26aeb..32a61505ce 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -723,6 +723,11 @@ def decl_tcg(self, f, tag, regno):
>                  TCGv_ptr {self.reg_tcg()} =3D tcg_temp_new_ptr();
>                  tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env,
> {self.hvx_off()});
>              """))
> +    def gen_zero(self, f):
> +        f.write(code_fmt(f"""\
> +                tcg_gen_gvec_dup_imm(MO_64, {self.hvx_off()},
> +                    sizeof(MMVector), sizeof(MMVector), 0);
> +            """))
>      def gen_write(self, f, tag):
>          pass
>      def helper_hvx_desc(self, f):
> @@ -789,6 +794,11 @@ def decl_tcg(self, f, tag, regno):
>                  TCGv_ptr {self.reg_tcg()} =3D tcg_temp_new_ptr();
>                  tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env,
> {self.hvx_off()});
>              """))
> +    def gen_zero(self, f):
> +        f.write(code_fmt(f"""\
> +                tcg_gen_gvec_dup_imm(MO_64, {self.hvx_off()},
> +                    sizeof(MMVector), sizeof(MMVector), 0);
> +            """))
>      def gen_write(self, f, tag):
>          pass
>      def helper_hvx_desc(self, f):
> @@ -821,6 +831,11 @@ def decl_tcg(self, f, tag, regno):
>                                   vreg_src_off(ctx, {self.reg_num}),
>                                   sizeof(MMVector), sizeof(MMVector));
>              """))
> +    def gen_zero(self, f):
> +        f.write(code_fmt(f"""\
> +                tcg_gen_gvec_dup_imm(MO_64, {self.hvx_off()},
> +                    sizeof(MMVector), sizeof(MMVector), 0);
> +            """))
>      def gen_write(self, f, tag):
>          f.write(code_fmt(f"""\
>              gen_vreg_write(ctx, {self.hvx_off()}, {self.reg_num},
> @@ -854,6 +869,11 @@ def decl_tcg(self, f, tag, regno):
>                  TCGv_ptr {self.reg_tcg()} =3D tcg_temp_new_ptr();
>                  tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env,
> {self.hvx_off()});
>              """))
> +    def gen_zero(self, f):
> +        f.write(code_fmt(f"""\
> +            tcg_gen_gvec_dup_imm(MO_64, {self.hvx_off()},
> +                sizeof(MMVectorPair), sizeof(MMVectorPair), 0);
> +        """))
>      def gen_write(self, f, tag):
>          pass
>      def helper_hvx_desc(self, f):
> @@ -913,6 +933,11 @@ def decl_tcg(self, f, tag, regno):
>                  TCGv_ptr {self.reg_tcg()} =3D tcg_temp_new_ptr();
>                  tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env,
> {self.hvx_off()});
>              """))
> +    def gen_zero(self, f):
> +        f.write(code_fmt(f"""\
> +            tcg_gen_gvec_dup_imm(MO_64, {self.hvx_off()},
> +                sizeof(MMVectorPair), sizeof(MMVectorPair), 0);
> +        """))
>      def gen_write(self, f, tag):
>          f.write(code_fmt(f"""\
>              gen_vreg_write_pair(ctx, {self.hvx_off()}, {self.reg_num},
> @@ -946,6 +971,11 @@ def decl_tcg(self, f, tag, regno):
>                  TCGv_ptr {self.reg_tcg()} =3D tcg_temp_new_ptr();
>                  tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env,
> {self.hvx_off()});
>              """))
> +    def gen_zero(self, f):
> +        f.write(code_fmt(f"""\
> +            tcg_gen_gvec_dup_imm(MO_64, {self.hvx_off()},
> +                sizeof(MMQReg), sizeof(MMQReg), 0);
> +        """))
>

Do any of these instructions write QRegs?  If not, this isn't needed.


>      def gen_write(self, f, tag):
>          pass
>      def helper_hvx_desc(self, f):
> @@ -993,6 +1023,11 @@ def decl_tcg(self, f, tag, regno):
>                  TCGv_ptr {self.reg_tcg()} =3D tcg_temp_new_ptr();
>                  tcg_gen_addi_ptr({self.reg_tcg()}, tcg_env,
> {self.hvx_off()});
>              """))
> +    def gen_zero(self, f):
> +        f.write(code_fmt(f"""\
> +            tcg_gen_gvec_dup_imm(MO_64, {self.hvx_off()},
> +                sizeof(MMQReg), sizeof(MMQReg), 0);
> +        """))
>

Ditto


>      def gen_write(self, f, tag):
>          pass
>      def helper_hvx_desc(self, f):
> --
> 2.37.2
>
>

--000000000000743c55064ef9f969
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 8, =
2026 at 10:37=E2=80=AFAM Matheus Tavares Bernardino &lt;<a href=3D"mailto:m=
atheus.bernardino@oss.qualcomm.com">matheus.bernardino@oss.qualcomm.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This=
 flag will be used to control the HVX IEEE float instructions, which<br>
are only available at some Hexagon cores. When unavailable, the<br>
instruction effectively only set the destination registers to 0.<br>
<br>
Signed-off-by: Matheus Tavares Bernardino &lt;<a href=3D"mailto:matheus.ber=
nardino@oss.qualcomm.com" target=3D"_blank">matheus.bernardino@oss.qualcomm=
.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 1 +<br>
=C2=A0target/hexagon/translate.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0target/hexagon/attribs_def.h.inc |=C2=A0 3 +++<br>
=C2=A0target/hexagon/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 1 +<br>
=C2=A0target/hexagon/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0target/hexagon/gen_tcg_funcs.py=C2=A0 | 11 ++++++++++<br>
=C2=A0target/hexagon/hex_common.py=C2=A0 =C2=A0 =C2=A0| 35 ++++++++++++++++=
++++++++++++++++<br>
=C2=A07 files changed, 53 insertions(+)<br>
<br>
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h<br>
index 85afd59277..77822a48b6 100644<br>
--- a/target/hexagon/cpu.h<br>
+++ b/target/hexagon/cpu.h<br>
@@ -127,6 +127,7 @@ struct ArchCPU {<br>
=C2=A0 =C2=A0 =C2=A0bool lldb_compat;<br>
=C2=A0 =C2=A0 =C2=A0target_ulong lldb_stack_adjust;<br>
=C2=A0 =C2=A0 =C2=A0bool short_circuit;<br>
+=C2=A0 =C2=A0 bool ieee_fp_extension;<br>
=C2=A0};<br>
<br>
=C2=A0#include &quot;cpu_bits.h&quot;<br>
diff --git a/target/hexagon/translate.h b/target/hexagon/translate.h<br>
index b37cb49238..516aab7038 100644<br>
--- a/target/hexagon/translate.h<br>
+++ b/target/hexagon/translate.h<br>
@@ -70,6 +70,7 @@ typedef struct DisasContext {<br>
=C2=A0 =C2=A0 =C2=A0target_ulong branch_dest;<br>
=C2=A0 =C2=A0 =C2=A0bool is_tight_loop;<br>
=C2=A0 =C2=A0 =C2=A0bool short_circuit;<br>
+=C2=A0 =C2=A0 bool ieee_fp_extension;<br>
=C2=A0 =C2=A0 =C2=A0bool read_after_write;<br>
=C2=A0 =C2=A0 =C2=A0bool has_hvx_overlap;<br>
=C2=A0 =C2=A0 =C2=A0TCGv new_value[TOTAL_PER_THREAD_REGS];<br>
diff --git a/target/hexagon/attribs_def.h.inc b/target/hexagon/attribs_def.=
h.inc<br>
index 9e3a05f882..c85cd5d17c 100644<br>
--- a/target/hexagon/attribs_def.h.inc<br>
+++ b/target/hexagon/attribs_def.h.inc<br>
@@ -173,5 +173,8 @@ DEF_ATTRIB(NOTE_SHIFT_RESOURCE, &quot;Uses the HVX shif=
t resource.&quot;, &quot;&quot;, &quot;&quot;)<br>
=C2=A0DEF_ATTRIB(RESTRICT_NOSLOT1_STORE, &quot;Packet must not have slot 1 =
store&quot;, &quot;&quot;, &quot;&quot;)<br>
=C2=A0DEF_ATTRIB(RESTRICT_LATEPRED, &quot;Predicate can not be used as a .n=
ew.&quot;, &quot;&quot;, &quot;&quot;)<br>
<br>
+/* HVX IEEE FP extension attributes */<br>
+DEF_ATTRIB(HVX_IEEE_FP, &quot;HVX IEEE FP extension instruction&quot;, &qu=
ot;&quot;, &quot;&quot;)<br>
+<br>
=C2=A0/* Keep this as the last attribute: */<br>
=C2=A0DEF_ATTRIB(ZZ_LASTATTRIB, &quot;Last attribute in the file&quot;, &qu=
ot;&quot;, &quot;&quot;)<br>
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c<br>
index ffd14bb467..8b72a5d3c8 100644<br>
--- a/target/hexagon/cpu.c<br>
+++ b/target/hexagon/cpu.c<br>
@@ -54,6 +54,7 @@ static const Property hexagon_cpu_properties[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_UNSIGNED(&quot;lldb-stack-adjust&quot;, Hex=
agonCPU, lldb_stack_adjust, 0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 qdev_prop_uint32, target_ulong),<br>
=C2=A0 =C2=A0 =C2=A0DEFINE_PROP_BOOL(&quot;short-circuit&quot;, HexagonCPU,=
 short_circuit, true),<br>
+=C2=A0 =C2=A0 DEFINE_PROP_BOOL(&quot;ieee-fp&quot;, HexagonCPU, ieee_fp_ex=
tension, true),<br>
=C2=A0};<br>
<br>
=C2=A0const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS] =3D {<br>
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c<br>
index 633401451d..fa8f615a9e 100644<br>
--- a/target/hexagon/translate.c<br>
+++ b/target/hexagon/translate.c<br>
@@ -988,6 +988,7 @@ static void hexagon_tr_init_disas_context(DisasContextB=
ase *dcbase,<br>
=C2=A0 =C2=A0 =C2=A0ctx-&gt;branch_cond =3D TCG_COND_NEVER;<br>
=C2=A0 =C2=A0 =C2=A0ctx-&gt;is_tight_loop =3D FIELD_EX32(hex_flags, TB_FLAG=
S, IS_TIGHT_LOOP);<br>
=C2=A0 =C2=A0 =C2=A0ctx-&gt;short_circuit =3D hex_cpu-&gt;short_circuit;<br=
>
+=C2=A0 =C2=A0 ctx-&gt;ieee_fp_extension =3D hex_cpu-&gt;ieee_fp_extension;=
<br>
=C2=A0}<br>
<br>
=C2=A0static void hexagon_tr_tb_start(DisasContextBase *db, CPUState *cpu)<=
br>
diff --git a/target/hexagon/gen_tcg_funcs.py b/target/hexagon/gen_tcg_funcs=
.py<br>
index 87b7f10d7f..b752ec883c 100755<br>
--- a/target/hexagon/gen_tcg_funcs.py<br>
+++ b/target/hexagon/gen_tcg_funcs.py<br>
@@ -22,6 +22,14 @@<br>
=C2=A0import string<br>
=C2=A0import hex_common<br>
<br>
+def gen_disabled_ieee_insn(f, tag, regs):<br>
+=C2=A0 =C2=A0 f.write(&quot;=C2=A0 =C2=A0 if (!ctx-&gt;ieee_fp_extension) =
{\n&quot;)<br>
+=C2=A0 =C2=A0 for regtype, regid in regs:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D hex_common.get_register(tag, regtype, =
regid)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if reg.is_hvx_reg() and reg.is_written():<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg.gen_zero(f)<br></blockquote>=
<div><br></div><div>What happens to the non-HVX registers that are written =
(e.g., address for a post-increment load)?=C2=A0 I assume they should also =
be set to zero.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
+=C2=A0 =C2=A0 f.write(&quot;=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;\n&quot;)<b=
r>
+=C2=A0 =C2=A0 f.write(&quot;=C2=A0 =C2=A0 }\n&quot;)<br>
<br>
=C2=A0##<br>
=C2=A0## Generate the TCG code to call the helper<br>
@@ -62,6 +70,9 @@ def gen_tcg_func(f, tag, regs, imms):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i =3D 1 if immlett.isupper() else 0<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(f&quot;=C2=A0 =C2=A0 int {hex_com=
mon.imm_name(immlett)} =3D insn-&gt;immed[{i}];\n&quot;)<br>
<br>
+=C2=A0 =C2=A0 if &quot;A_HVX_IEEE_FP&quot; in hex_common.attribdict[tag]:<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_disabled_ieee_insn(f, tag, regs)<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if hex_common.is_idef_parser_enabled(tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0declared =3D []<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0## Handle registers<br>
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py<br=
>
index c0e9f26aeb..32a61505ce 100755<br>
--- a/target/hexagon/hex_common.py<br>
+++ b/target/hexagon/hex_common.py<br>
@@ -723,6 +723,11 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_ptr {sel=
f.reg_tcg()} =3D tcg_temp_new_ptr();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_addi_=
ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
+=C2=A0 =C2=A0 def gen_zero(self, f):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(code_fmt(f&quot;&quot;&quot;\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_gvec_dup_i=
mm(MO_64, {self.hvx_off()},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size=
of(MMVector), sizeof(MMVector), 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;))<br>
=C2=A0 =C2=A0 =C2=A0def gen_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
=C2=A0 =C2=A0 =C2=A0def helper_hvx_desc(self, f):<br>
@@ -789,6 +794,11 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_ptr {sel=
f.reg_tcg()} =3D tcg_temp_new_ptr();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_addi_=
ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
+=C2=A0 =C2=A0 def gen_zero(self, f):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(code_fmt(f&quot;&quot;&quot;\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_gvec_dup_i=
mm(MO_64, {self.hvx_off()},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size=
of(MMVector), sizeof(MMVector), 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;))<br>
=C2=A0 =C2=A0 =C2=A0def gen_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
=C2=A0 =C2=A0 =C2=A0def helper_hvx_desc(self, f):<br>
@@ -821,6 +831,11 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vreg_src_off(ctx, {self.reg_n=
um}),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(MMVector), sizeof(MMVe=
ctor));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
+=C2=A0 =C2=A0 def gen_zero(self, f):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(code_fmt(f&quot;&quot;&quot;\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_gvec_dup_i=
mm(MO_64, {self.hvx_off()},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size=
of(MMVector), sizeof(MMVector), 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;))<br>
=C2=A0 =C2=A0 =C2=A0def gen_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_vreg_write(ctx, {self.h=
vx_off()}, {self.reg_num},<br>
@@ -854,6 +869,11 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_ptr {sel=
f.reg_tcg()} =3D tcg_temp_new_ptr();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_addi_=
ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
+=C2=A0 =C2=A0 def gen_zero(self, f):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(code_fmt(f&quot;&quot;&quot;\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_gvec_dup_imm(MO_64, {sel=
f.hvx_off()},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(MMVectorPai=
r), sizeof(MMVectorPair), 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;))<br>
=C2=A0 =C2=A0 =C2=A0def gen_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
=C2=A0 =C2=A0 =C2=A0def helper_hvx_desc(self, f):<br>
@@ -913,6 +933,11 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_ptr {sel=
f.reg_tcg()} =3D tcg_temp_new_ptr();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_addi_=
ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
+=C2=A0 =C2=A0 def gen_zero(self, f):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(code_fmt(f&quot;&quot;&quot;\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_gvec_dup_imm(MO_64, {sel=
f.hvx_off()},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(MMVectorPai=
r), sizeof(MMVectorPair), 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;))<br>
=C2=A0 =C2=A0 =C2=A0def gen_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gen_vreg_write_pair(ctx, {s=
elf.hvx_off()}, {self.reg_num},<br>
@@ -946,6 +971,11 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_ptr {sel=
f.reg_tcg()} =3D tcg_temp_new_ptr();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_addi_=
ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
+=C2=A0 =C2=A0 def gen_zero(self, f):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(code_fmt(f&quot;&quot;&quot;\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_gvec_dup_imm(MO_64, {sel=
f.hvx_off()},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(MMQReg), si=
zeof(MMQReg), 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;))<br></blockquote><div><br>=
</div><div>Do any of these instructions write QRegs?=C2=A0 If not, this isn=
&#39;t needed.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
=C2=A0 =C2=A0 =C2=A0def gen_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
=C2=A0 =C2=A0 =C2=A0def helper_hvx_desc(self, f):<br>
@@ -993,6 +1023,11 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TCGv_ptr {sel=
f.reg_tcg()} =3D tcg_temp_new_ptr();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_addi_=
ptr({self.reg_tcg()}, tcg_env, {self.hvx_off()});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
+=C2=A0 =C2=A0 def gen_zero(self, f):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 f.write(code_fmt(f&quot;&quot;&quot;\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tcg_gen_gvec_dup_imm(MO_64, {sel=
f.hvx_off()},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(MMQReg), si=
zeof(MMQReg), 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;))<br></blockquote><div><br>=
</div><div>Ditto</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
=C2=A0 =C2=A0 =C2=A0def gen_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass<br>
=C2=A0 =C2=A0 =C2=A0def helper_hvx_desc(self, f):<br>
-- <br>
2.37.2<br>
<br>
</blockquote></div></div>

--000000000000743c55064ef9f969--

