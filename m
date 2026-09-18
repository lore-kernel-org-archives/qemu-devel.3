Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D01C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 22:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7hEO-0005PF-Hw; Fri, 18 Sep 2026 18:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1x7hEL-0005Oy-47
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:38:54 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <palmer@dabbelt.com>)
 id 1x7hEI-0002Ac-QD
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 18:38:52 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-cbedd5aece4so1812140a12.0
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 15:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dabbelt-com.20251104.gappssmtp.com; s=20251104; t=1789771129; x=1790375929;
 darn=nongnu.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:to
 :from:cc:in-reply-to:subject:date:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z/S0uVRAdE+BJ7Ud/T6QlGxvk5qkMlC9JY1oAT2GstI=;
 b=nX6UglPMheTL00hh78AWc4DKGO2iiyXx6vrPGPGYnyiR+FgjWyIz0rWwF+zrRi5lmp
 jyr14GI2JZ2ai23crmmHXEB8MmgLYYptUV7d59iJCnVyh7x8ef0Ogekue6ZDYmw3Am6n
 b623bq+Js/5zmsHrvEhotLriLb+2y4XmQV0elKhi1r+C6c0WoBNvcWTxlAZO3hYFJt0z
 p51LgqvKnOWF99u7iv17cRoEEnOTIxIp1gOWcbHdgXCbnhNkt+bXNOM9G0h/xH3AQ/uq
 erSTlaJQhxw0Ssr4fDRpbxh5Ij6wEdsCCx2SkwVGsONLktQtaslP/Rdw2YraivuOAY09
 69xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789771129; x=1790375929;
 h=content-transfer-encoding:content-type:mime-version:message-id:to
 :from:cc:in-reply-to:subject:date:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Z/S0uVRAdE+BJ7Ud/T6QlGxvk5qkMlC9JY1oAT2GstI=;
 b=mM/A91abybkiidbgGL8VKMKeElNQg1vcJSqiq1rEF+IWjA+yRfaCyNIJ5xdY6Hjve4
 2Tr4RcCLeBMMaLxxbJEeuGqq9jkpHv9bSvvvIcD2hnH2NGGICjheRgmnRXEabnCgt0VN
 ak2gDzspzeTGy47iioN8ILs6y9YzDVzyfs5jNXzmsJGxj90FTRmAOz5s8p7R9K7fPLxT
 hIMeTaLxY3xcojYuXI6b3baUWh/mOz6nWrxKd0gfC2XDmrlMomsv1b3LFhsMyUfsLzZg
 sXnaS3D6Qjj0M6TJ56HifxBpO1Ixszvc18Rzu659y7xiWs7WHujkGG6zDJXdRfAF+vS6
 wybw==
X-Gm-Message-State: AFuF++kdI464Bydc/lkMcMmUCagf1dP7U3ZinNbqUArNAQ0aGWj3XiWB
 zpThaI8sr+jdY71rSd+WrpfDR1Mll56m9CKCpkcd5g3+lDy+N2piZZ/Zzmlhhy5hu0mM3BFWHIC
 VTojS
X-Gm-Gg: AYBFou2VuRHhuGfs5T6tRZQ79tXYnc+7kV1ZG0YKllPS01Y3X6pjwJiL7HlznGbyPOB
 InfvdxP0fO5h12/IQhmGNi9NpLmnYpJO7nerVti7nuydQNgGtyJSb/x2+XeDOz3tFfoS44gbZ2t
 HA+2aMGUY2D7aA8KZocAczQHC7at6s6NEZtI+JgWooyOghdM+wXFO10VGersd7SOLhviu1FT2KW
 Z9znMi5H9EDow+lIOMtAE6f/pB7b1tBAqGme6awWzjDTOh3aV8kUVriG/XGACOT8I167x3l/PP+
 X66jP7TTiLxcE2fexYv8j/7i1SSmoiL0BIWblSZbXrwjssqbP4ohV5OqINiTzzsU6+hiK/EatYX
 s5o9uDlR1rNacIHyHtcF5QiZgtgZx2rkkx/+LSeTTljVFIbkCV1yFUWFJN2Yymo7h0GIZdGhSw/
 KWfGZ9cDlpy1re0R5mm6PIh6O+El5Tca8bvCjeQnk8ZtKxDkzx/JaVTt3D5gi8uABEQ0D1gncmA
 I8DL64MWfPZXTBiBIfSHvpyxvdmZA==
X-Received: by 2002:a17:90b:57e6:b0:39e:58d8:f899 with SMTP id
 98e67ed59e1d1-39e58d8fa69mr4809925a91.35.1789771128434; 
 Fri, 18 Sep 2026 15:38:48 -0700 (PDT)
Received: from localhost ([2001:5a8:4687:d600:b5c5:5de3:d341:6ae9])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c32f17d77sm1656267eec.3.2026.09.18.15.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 15:38:47 -0700 (PDT)
Date: Fri, 18 Sep 2026 15:38:47 -0700 (PDT)
X-Google-Original-Date: Fri, 18 Sep 2026 15:38:46 PDT (-0700)
Subject: Re: [PATCH] tcg/riscv64: Set vtype before whole-register vector loads
In-Reply-To: <20260918201007.153384-1-richard.henderson@linaro.org>
CC: qemu-devel@nongnu.org, max.chou@sifive.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <mhng-9266D400-F468-4D4D-99CB-0F754C22F36D@Palmers-Mini.rwc.dabbelt.com>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=palmer@dabbelt.com; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, 18 Sep 2026 13:10:07 PDT (-0700), Richard Henderson wrote:
> With vtype uninitialized, VILL might be set, leading to SIGILL.
> Also, assert vtype initialized for whole-register stores and moves.
>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Reported-by: Max Chou <max.chou@sifive.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/riscv64/tcg-target.c.inc | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
> index 2ce9d47a633..de9a3570b23 100644
> --- a/tcg/riscv64/tcg-target.c.inc
> +++ b/tcg/riscv64/tcg-target.c.inc
> @@ -775,6 +775,7 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
>      case TCG_TYPE_V64:
>      case TCG_TYPE_V128:
>      case TCG_TYPE_V256:
> +        tcg_debug_assert(s->riscv_cur_type != TCG_TYPE_COUNT);
>          {
>              int lmul = type - riscv_lg2_vlenb;
>              int nf = 1 << MAX(lmul, 0);
> @@ -1014,6 +1015,10 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg arg,
>              unsigned idx = type - riscv_lg2_vlenb;
>
>              tcg_debug_assert(idx < ARRAY_SIZE(whole_reg_ld));
> +            /* We must initialize vtype to something to avoid VILL. */
> +            if (s->riscv_cur_type == TCG_TYPE_COUNT) {
> +                set_vtype(s, type, MO_8);
> +            }
>              insn = whole_reg_ld[idx];
>          } else {
>              static const RISCVInsn unit_stride_ld[] = {
> @@ -1046,6 +1051,7 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg,
>      case TCG_TYPE_V64:
>      case TCG_TYPE_V128:
>      case TCG_TYPE_V256:
> +        tcg_debug_assert(s->riscv_cur_type != TCG_TYPE_COUNT);
>          if (type >= riscv_lg2_vlenb) {
              static const RISCVInsn whole_reg_st[] = {
>                  OPC_VS1R_V, OPC_VS2R_V, OPC_VS4R_V, OPC_VS8R_V

Thanks!  Looks like it was just a lurking bug then.

Reviewed-by: Palmer Dabbelt <palmer@dabbelt.com>

and

Fixes: f63e7089b4 ("tcg/riscv: Add basic support for vector")

though that's old enough I'm not sure it really matters.

It looks like we're clobbering vtype and the rest of the V registers on calls,
so I think we're good there.

I poked through and it looks like every other case that constructs a V
instruction that depends on the vector configuration has a vtype set
immediately before it, so I think the rest of the port is safe.  That said, if
I understand the ISA correctly, we need a valid vector configuration before
executing any V instruction (assuming the post-change ISA), so I think we could
also just throw something like this in there and maybe catch some mistakes in
the future?

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 2ce9d47a63..42fcc8182e 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -686,18 +686,21 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
 static void tcg_out_opc_vv(TCGContext *s, RISCVInsn opc,
                            TCGReg vd, TCGReg vs2, TCGReg vs1)
 {
+    tcg_debug_assert(s->riscv_cur_type != TCG_TYPE_COUNT);
     tcg_out32(s, encode_v(opc, vd, vs1, vs2, true));
 }
 
 static void tcg_out_opc_vx(TCGContext *s, RISCVInsn opc,
                            TCGReg vd, TCGReg vs2, TCGReg rs1)
 {
+    tcg_debug_assert(s->riscv_cur_type != TCG_TYPE_COUNT);
     tcg_out32(s, encode_v(opc, vd, rs1, vs2, true));
 }
 
 static void tcg_out_opc_vi(TCGContext *s, RISCVInsn opc,
                            TCGReg vd, TCGReg vs2, int32_t imm)
 {
+    tcg_debug_assert(s->riscv_cur_type != TCG_TYPE_COUNT);
     tcg_out32(s, encode_vi(opc, vd, imm, vs2, true));
 }
 
@@ -714,12 +717,14 @@ static void tcg_out_opc_vv_vi(TCGContext *s, RISCVInsn o_vv, RISCVInsn o_vi,
 static void tcg_out_opc_vim_mask(TCGContext *s, RISCVInsn opc, TCGReg vd,
                                  TCGReg vs2, int32_t imm)
 {
+    tcg_debug_assert(s->riscv_cur_type != TCG_TYPE_COUNT);
     tcg_out32(s, encode_vi(opc, vd, imm, vs2, false));
 }
 
 static void tcg_out_opc_vvm_mask(TCGContext *s, RISCVInsn opc, TCGReg vd,
                                  TCGReg vs2, TCGReg vs1)
 {
+    tcg_debug_assert(s->riscv_cur_type != TCG_TYPE_COUNT);
     tcg_out32(s, encode_v(opc, vd, vs1, vs2, false));
 }
 
@@ -978,6 +983,7 @@ static void tcg_out_vec_ldst(TCGContext *s, RISCVInsn opc, TCGReg data,
 {
     tcg_debug_assert(data >= TCG_REG_V0);
     tcg_debug_assert(addr < TCG_REG_V0);
+    tcg_debug_assert(s->riscv_cur_type != TCG_TYPE_COUNT);
 
     if (offset) {
         tcg_debug_assert(addr != TCG_REG_ZERO);
@@ -1554,6 +1560,7 @@ static void tcg_out_cmpsel(TCGContext *s, TCGType type, unsigned vece,
 static void tcg_out_vshifti(TCGContext *s, RISCVInsn opc_vi, RISCVInsn opc_vx,
                              TCGReg dst, TCGReg src, unsigned imm)
 {
+    tcg_debug_assert(s->riscv_cur_type != TCG_TYPE_COUNT);
     if (imm < 32) {
         tcg_out_opc_vi(s, opc_vi, dst, src, imm);
     } else {


