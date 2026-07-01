Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0BD7C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 15:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wewSX-0000d6-T4; Wed, 01 Jul 2026 11:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wewSI-0000TC-FR
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 11:02:26 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wewSE-0003qj-DS
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 11:02:24 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-493a613571eso6477515e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 08:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782918140; x=1783522940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rY/Wgt2gutollXF3U9M/fzk3WvrsjulIO/mrxF7AD38=;
 b=Or3EWciwdnJRGFH0yKzFISR0fnJFHsuAees/WwRr1qdbfm5f59C4OAxXJelu0QgkSL
 Ti+g2HEHKqQECDZQjYd6PIrt+dxsAo//BUwn7JItmNlAp/IIWfOU6K3xILVt+/jmjqe/
 qBBU1rTT4Y+Iqybz/+rvHJGB9wtS64g3rAOcvgaQ12VozJhcVkj+8WvNpaX03xKcZpRG
 XB1kS790x946NCBuVcmB8NRVZOe2w3LbYOM11AaatMk3woyvbhxWrUnvBOOEOrMw9GQm
 rrth9hBiBHnrYPMx9RpP/p1Ty3k4tsuT/EVOXu7C/9zU/alfGCaGWN2jl89WBpf62Ve+
 zm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782918140; x=1783522940;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rY/Wgt2gutollXF3U9M/fzk3WvrsjulIO/mrxF7AD38=;
 b=bfZQQbDUXjVRN/lKnx9i6Ff6E+BQfIC+tPaanFUwXTVQsGNhZe472rw+PoLDGT2RRg
 FjIpmJ5Dpt7Ft0yRBoaELUi8CjpVamm+q1m55nrlbOTA7FIaODOzGlRsvWuaDSJSy+7m
 3RIHmjd+3nCDgMOXaDzpdINdWPJUO7sIlTDOfXOOCy/7zqSHMcdPzHPpHAtJ0xOWJGEn
 US4u3t3hv/Fp2SGftvLJRzyngvjRn4DV1cRzrWRov5TawpirVL+burb4eJeRJJUtOFvO
 sdkdxxzYCp1pGF/cHMBE/ixNQC5vVhGcNRK50JhscGZG0tXccMNTFr/i164QdQ/9U1hs
 93aA==
X-Gm-Message-State: AOJu0YzqsNO9X8wmyBPQjO3yPCvQqWjTJtDJpRV3WtRxICurN9uSQ94A
 fZ7M6vT2dP1rQPww35mfdUDdpw3kvW6vrPcYNUFwVvhFWk/WJmzyBEy1VQd5535JQTA=
X-Gm-Gg: AfdE7ckzNtCzw3UkdUPPbaHEKBf09LUNYRdN1dm3Eh3szh94VXa4T3klqpS1JLw/Cz3
 WAEnuQp6OSCnOIcrgdcPZ4+HNas+3Od0KKMesfphzHn+5QQ120GF7JZS0LXaINtRS67jsQpgq2O
 14InoX9hzzuaIxrKWX4PtA32OvP9H57aNJUZ44avfcP1vTcsRq0AE2nnzUDKr1n7HiFRk5v++kw
 7T0PpOygA6FBZgbY8Z3s7Z1avh/SXOwMYR+E0bVawuUWZwogJxJyXN/5PKCgirpmd6raTai/Gh9
 OvK2+PXcz6P8MQq1MwDBlKdDll4fUb/4Al4TeDBneN7bgV6j525FBpURqdNwng1sWsRQCffCiQM
 1RAN1LVFVienN/B6gn1d5zWZidQQUJTC8Vn0XQT6DwcUV1ReB+soWZFuBKZTjGk5V9bASiTjDdk
 M1kFzNo53O2aGTYlfwoc9jN3I=
X-Received: by 2002:a05:600c:8214:b0:493:bacb:1341 with SMTP id
 5b1f17b1804b1-493c2b3a681mr33244755e9.4.1782918140056; 
 Wed, 01 Jul 2026 08:02:20 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4da247sm79723765e9.7.2026.07.01.08.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 08:02:19 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3A01A5F889;
 Wed, 01 Jul 2026 16:02:18 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: TANG Tiancheng <lyndra@linux.alibaba.com>
Cc: qemu-devel@nongnu.org,  Christoph Muellner
 <christoph.muellner@vrull.eu>,  LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,  Alistair Francis
 <Alistair.Francis@wdc.com>,  Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  qemu-riscv@nongnu.org
Subject: Re: [PATCH v3 5/5] disas/riscv: Use extract helpers for operand fields
In-Reply-To: <20260701-b4-disas-xthead-fix-riscv-next-v3-5-fc4f5f1b6c15@linux.alibaba.com>
 (TANG Tiancheng's message of "Wed, 01 Jul 2026 22:32:13 +0800")
References: <20260701-b4-disas-xthead-fix-riscv-next-v3-0-fc4f5f1b6c15@linux.alibaba.com>
 <20260701-b4-disas-xthead-fix-riscv-next-v3-5-fc4f5f1b6c15@linux.alibaba.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Wed, 01 Jul 2026 16:02:18 +0100
Message-ID: <87qzlmu51h.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

TANG Tiancheng <lyndra@linux.alibaba.com> writes:

> Replace shift-based operand extraction with extract32() and sextract32().
> For signed immediates, use sextract32() on the field that carries the sign
> bit and combine it with the remaining extract32() fields.
>
> The RISC-V disassembler currently follows target/riscv/internals.h:
> insn_len() and decodes only 16-bit or 32-bit instruction lengths, so the
> converted fields are all in the low 32 bits of rv_inst.
>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>  disas/riscv.c | 216 +++++++++++++++++++++++++++++-----------------------=
------
>  1 file changed, 108 insertions(+), 108 deletions(-)
>
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 4b3f90418f8f17dd3fcb71f70c39607fa293eb0e..2ba0a6a73ad36c6263eed6211=
9d2c4c864b61cb6 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -4202,82 +4202,82 @@ static void decode_inst_opcode(rv_decode *dec, rv=
_isa isa)
>=20=20
>  static uint32_t operand_rd(rv_inst inst)
>  {
> -    return (inst << 52) >> 59;
> +    return extract32(inst, 7, 5);
>  }
>=20=20
>  static uint32_t operand_rs1(rv_inst inst)
>  {
> -    return (inst << 44) >> 59;
> +    return extract32(inst, 15, 5);
>  }
>=20=20
>  static uint32_t operand_rs2(rv_inst inst)
>  {
> -    return (inst << 39) >> 59;
> +    return extract32(inst, 20, 5);
>  }
>=20=20
>  static uint32_t operand_rs3(rv_inst inst)
>  {
> -    return (inst << 32) >> 59;
> +    return extract32(inst, 27, 5);
>  }
>=20=20
>  static uint32_t operand_aq(rv_inst inst)
>  {
> -    return (inst << 37) >> 63;
> +    return extract32(inst, 26, 1);
>  }
>=20=20
>  static uint32_t operand_rl(rv_inst inst)
>  {
> -    return (inst << 38) >> 63;
> +    return extract32(inst, 25, 1);
>  }
>=20=20
>  static uint32_t operand_pred(rv_inst inst)
>  {
> -    return (inst << 36) >> 60;
> +    return extract32(inst, 24, 4);
>  }
>=20=20
>  static uint32_t operand_succ(rv_inst inst)
>  {
> -    return (inst << 40) >> 60;
> +    return extract32(inst, 20, 4);
>  }
>=20=20
>  static uint32_t operand_rm(rv_inst inst)
>  {
> -    return (inst << 49) >> 61;
> +    return extract32(inst, 12, 3);
>  }
>=20=20
>  static uint32_t operand_shamt5(rv_inst inst)
>  {
> -    return (inst << 39) >> 59;
> +    return extract32(inst, 20, 5);
>  }
>=20=20
>  static uint32_t operand_shamt6(rv_inst inst)
>  {
> -    return (inst << 38) >> 58;
> +    return extract32(inst, 20, 6);
>  }
>=20=20
>  static uint32_t operand_shamt7(rv_inst inst)
>  {
> -    return (inst << 37) >> 57;
> +    return extract32(inst, 20, 7);
>  }
>=20=20
>  static uint32_t operand_crdq(rv_inst inst)
>  {
> -    return (inst << 59) >> 61;
> +    return extract32(inst, 2, 3);
>  }
>=20=20
>  static uint32_t operand_crs1q(rv_inst inst)
>  {
> -    return (inst << 54) >> 61;
> +    return extract32(inst, 7, 3);
>  }
>=20=20
>  static uint32_t operand_crs1rdq(rv_inst inst)
>  {
> -    return (inst << 54) >> 61;
> +    return extract32(inst, 7, 3);
>  }
>=20=20
>  static uint32_t operand_crs2q(rv_inst inst)
>  {
> -    return (inst << 59) >> 61;
> +    return extract32(inst, 2, 3);
>  }
>=20=20
>  static uint32_t calculate_xreg(uint32_t sreg)
> @@ -4287,80 +4287,80 @@ static uint32_t calculate_xreg(uint32_t sreg)
>=20=20
>  static uint32_t operand_sreg1(rv_inst inst)
>  {
> -    return calculate_xreg((inst << 54) >> 61);
> +    return calculate_xreg(extract32(inst, 7, 3));
>  }
>=20=20
>  static uint32_t operand_sreg2(rv_inst inst)
>  {
> -    return calculate_xreg((inst << 59) >> 61);
> +    return calculate_xreg(extract32(inst, 2, 3));
>  }
>=20=20
>  static uint32_t operand_crd(rv_inst inst)
>  {
> -    return (inst << 52) >> 59;
> +    return extract32(inst, 7, 5);
>  }
>=20=20
>  static uint32_t operand_crs1(rv_inst inst)
>  {
> -    return (inst << 52) >> 59;
> +    return extract32(inst, 7, 5);
>  }
>=20=20
>  static uint32_t operand_crs1rd(rv_inst inst)
>  {
> -    return (inst << 52) >> 59;
> +    return extract32(inst, 7, 5);
>  }
>=20=20
>  static uint32_t operand_crs2(rv_inst inst)
>  {
> -    return (inst << 57) >> 59;
> +    return extract32(inst, 2, 5);
>  }
>=20=20
>  static uint32_t operand_cimmsh5(rv_inst inst)
>  {
> -    return (inst << 57) >> 59;
> +    return extract32(inst, 2, 5);
>  }
>=20=20
>  static uint32_t operand_csr12(rv_inst inst)
>  {
> -    return (inst << 32) >> 52;
> +    return extract32(inst, 20, 12);
>  }
>=20=20
>  static int32_t operand_imm12(rv_inst inst)
>  {
> -    return ((int64_t)inst << 32) >> 52;
> +    return sextract32(inst, 20, 12);
>  }
>=20=20
>  static int32_t operand_imm20(rv_inst inst)
>  {
> -    return (((int64_t)inst << 32) >> 44) << 12;
> +    return sextract32(inst, 12, 20) << 12;
>  }
>=20=20
>  static int32_t operand_jimm20(rv_inst inst)
>  {
> -    return (((int64_t)inst << 32) >> 63) << 20 |
> -        ((inst << 33) >> 54) << 1 |
> -        ((inst << 43) >> 63) << 11 |
> -        ((inst << 44) >> 56) << 12;
> +    return sextract32(inst, 31, 1) << 20 |
> +        extract32(inst, 21, 10) << 1 |
> +        extract32(inst, 20, 1) << 11 |
> +        extract32(inst, 12, 8) << 12;
>  }
>=20=20
>  static int32_t operand_simm12(rv_inst inst)
>  {
> -    return (((int64_t)inst << 32) >> 57) << 5 |
> -        (inst << 52) >> 59;
> +    return sextract32(inst, 25, 7) << 5 |
> +        extract32(inst, 7, 5);
>  }
>=20=20
>  static int32_t operand_sbimm12(rv_inst inst)
>  {
> -    return (((int64_t)inst << 32) >> 63) << 12 |
> -        ((inst << 33) >> 58) << 5 |
> -        ((inst << 52) >> 60) << 1 |
> -        ((inst << 56) >> 63) << 11;
> +    return sextract32(inst, 31, 1) << 12 |
> +        extract32(inst, 25, 6) << 5 |
> +        extract32(inst, 8, 4) << 1 |
> +        extract32(inst, 7, 1) << 11;
>  }
>=20=20
>  static uint32_t operand_cimmshl6(rv_inst inst, rv_isa isa)
>  {
> -    int imm =3D ((inst << 51) >> 63) << 5 |
> -        (inst << 57) >> 59;
> +    int imm =3D extract32(inst, 12, 1) << 5 |
> +        extract32(inst, 2, 5);
>      if (isa =3D=3D rv128) {
>          imm =3D imm ? imm : 64;
>      }
> @@ -4369,8 +4369,8 @@ static uint32_t operand_cimmshl6(rv_inst inst, rv_i=
sa isa)
>=20=20
>  static uint32_t operand_cimmshr6(rv_inst inst, rv_isa isa)
>  {
> -    int imm =3D ((inst << 51) >> 63) << 5 |
> -        (inst << 57) >> 59;
> +    int imm =3D extract32(inst, 12, 1) << 5 |
> +        extract32(inst, 2, 5);
>      if (isa =3D=3D rv128) {
>          imm =3D imm | (imm & 32) << 1;
>          imm =3D imm ? imm : 64;
> @@ -4380,116 +4380,116 @@ static uint32_t operand_cimmshr6(rv_inst inst, =
rv_isa isa)
>=20=20
>  static int32_t operand_cimmi(rv_inst inst)
>  {
> -    return (((int64_t)inst << 51) >> 63) << 5 |
> -        (inst << 57) >> 59;
> +    return sextract32(inst, 12, 1) << 5 |
> +        extract32(inst, 2, 5);
>  }
>=20=20
>  static int32_t operand_cimmui(rv_inst inst)
>  {
> -    return (((int64_t)inst << 51) >> 63) << 17 |
> -        ((inst << 57) >> 59) << 12;
> +    return sextract32(inst, 12, 1) << 17 |
> +        extract32(inst, 2, 5) << 12;
>  }
>=20=20
>  static uint32_t operand_cimmlwsp(rv_inst inst)
>  {
> -    return ((inst << 51) >> 63) << 5 |
> -        ((inst << 57) >> 61) << 2 |
> -        ((inst << 60) >> 62) << 6;
> +    return extract32(inst, 12, 1) << 5 |
> +        extract32(inst, 4, 3) << 2 |
> +        extract32(inst, 2, 2) << 6;
>  }
>=20=20
>  static uint32_t operand_cimmldsp(rv_inst inst)
>  {
> -    return ((inst << 51) >> 63) << 5 |
> -        ((inst << 57) >> 62) << 3 |
> -        ((inst << 59) >> 61) << 6;
> +    return extract32(inst, 12, 1) << 5 |
> +        extract32(inst, 5, 2) << 3 |
> +        extract32(inst, 2, 3) << 6;
>  }
>=20=20
>  static uint32_t operand_cimmlqsp(rv_inst inst)
>  {
> -    return ((inst << 51) >> 63) << 5 |
> -        ((inst << 57) >> 63) << 4 |
> -        ((inst << 58) >> 60) << 6;
> +    return extract32(inst, 12, 1) << 5 |
> +        extract32(inst, 6, 1) << 4 |
> +        extract32(inst, 2, 4) << 6;
>  }
>=20=20
>  static int32_t operand_cimm16sp(rv_inst inst)
>  {
> -    return (((int64_t)inst << 51) >> 63) << 9 |
> -        ((inst << 57) >> 63) << 4 |
> -        ((inst << 58) >> 63) << 6 |
> -        ((inst << 59) >> 62) << 7 |
> -        ((inst << 61) >> 63) << 5;
> +    return sextract32(inst, 12, 1) << 9 |
> +        extract32(inst, 6, 1) << 4 |
> +        extract32(inst, 5, 1) << 6 |
> +        extract32(inst, 3, 2) << 7 |
> +        extract32(inst, 2, 1) << 5;
>  }
>=20=20
>  static int32_t operand_cimmj(rv_inst inst)
>  {
> -    return (((int64_t)inst << 51) >> 63) << 11 |
> -        ((inst << 52) >> 63) << 4 |
> -        ((inst << 53) >> 62) << 8 |
> -        ((inst << 55) >> 63) << 10 |
> -        ((inst << 56) >> 63) << 6 |
> -        ((inst << 57) >> 63) << 7 |
> -        ((inst << 58) >> 61) << 1 |
> -        ((inst << 61) >> 63) << 5;
> +    return sextract32(inst, 12, 1) << 11 |
> +        extract32(inst, 11, 1) << 4 |
> +        extract32(inst, 9, 2) << 8 |
> +        extract32(inst, 8, 1) << 10 |
> +        extract32(inst, 7, 1) << 6 |
> +        extract32(inst, 6, 1) << 7 |
> +        extract32(inst, 3, 3) << 1 |
> +        extract32(inst, 2, 1) << 5;
>  }
>=20=20
>  static int32_t operand_cimmb(rv_inst inst)
>  {
> -    return (((int64_t)inst << 51) >> 63) << 8 |
> -        ((inst << 52) >> 62) << 3 |
> -        ((inst << 57) >> 62) << 6 |
> -        ((inst << 59) >> 62) << 1 |
> -        ((inst << 61) >> 63) << 5;
> +    return sextract32(inst, 12, 1) << 8 |
> +        extract32(inst, 10, 2) << 3 |
> +        extract32(inst, 5, 2) << 6 |
> +        extract32(inst, 3, 2) << 1 |
> +        extract32(inst, 2, 1) << 5;
>  }
>=20=20
>  static uint32_t operand_cimmswsp(rv_inst inst)
>  {
> -    return ((inst << 51) >> 60) << 2 |
> -        ((inst << 55) >> 62) << 6;
> +    return extract32(inst, 9, 4) << 2 |
> +        extract32(inst, 7, 2) << 6;
>  }
>=20=20
>  static uint32_t operand_cimmsdsp(rv_inst inst)
>  {
> -    return ((inst << 51) >> 61) << 3 |
> -        ((inst << 54) >> 61) << 6;
> +    return extract32(inst, 10, 3) << 3 |
> +        extract32(inst, 7, 3) << 6;
>  }
>=20=20
>  static uint32_t operand_cimmsqsp(rv_inst inst)
>  {
> -    return ((inst << 51) >> 62) << 4 |
> -        ((inst << 53) >> 60) << 6;
> +    return extract32(inst, 11, 2) << 4 |
> +        extract32(inst, 7, 4) << 6;
>  }
>=20=20
>  static uint32_t operand_cimm4spn(rv_inst inst)
>  {
> -    return ((inst << 51) >> 62) << 4 |
> -        ((inst << 53) >> 60) << 6 |
> -        ((inst << 57) >> 63) << 2 |
> -        ((inst << 58) >> 63) << 3;
> +    return extract32(inst, 11, 2) << 4 |
> +        extract32(inst, 7, 4) << 6 |
> +        extract32(inst, 6, 1) << 2 |
> +        extract32(inst, 5, 1) << 3;
>  }
>=20=20
>  static uint32_t operand_cimmw(rv_inst inst)
>  {
> -    return ((inst << 51) >> 61) << 3 |
> -        ((inst << 57) >> 63) << 2 |
> -        ((inst << 58) >> 63) << 6;
> +    return extract32(inst, 10, 3) << 3 |
> +        extract32(inst, 6, 1) << 2 |
> +        extract32(inst, 5, 1) << 6;
>  }
>=20=20
>  static uint32_t operand_cimmd(rv_inst inst)
>  {
> -    return ((inst << 51) >> 61) << 3 |
> -        ((inst << 57) >> 62) << 6;
> +    return extract32(inst, 10, 3) << 3 |
> +        extract32(inst, 5, 2) << 6;
>  }
>=20=20
>  static uint32_t operand_cimmq(rv_inst inst)
>  {
> -    return ((inst << 51) >> 62) << 4 |
> -        ((inst << 53) >> 63) << 8 |
> -        ((inst << 57) >> 62) << 6;
> +    return extract32(inst, 11, 2) << 4 |
> +        extract32(inst, 10, 1) << 8 |
> +        extract32(inst, 5, 2) << 6;
>  }
>=20=20
>  static int32_t operand_vimm(rv_inst inst)
>  {
> -    return (int64_t)(inst << 44) >> 59;
> +    return sextract32(inst, 15, 5);
>  }
>=20=20
>  static uint32_t operand_vuimm(rv_inst inst)
> @@ -4499,74 +4499,74 @@ static uint32_t operand_vuimm(rv_inst inst)
>=20=20
>  static uint32_t operand_vzimm11(rv_inst inst)
>  {
> -    return (inst << 33) >> 53;
> +    return extract32(inst, 20, 11);
>  }
>=20=20
>  static uint32_t operand_vzimm10(rv_inst inst)
>  {
> -    return (inst << 34) >> 54;
> +    return extract32(inst, 20, 10);
>  }
>=20=20
>  static uint32_t operand_vzimm6(rv_inst inst)
>  {
> -    return ((inst << 37) >> 63) << 5 |
> -        ((inst << 44) >> 59);
> +    return extract32(inst, 26, 1) << 5 |
> +        extract32(inst, 15, 5);
>  }
>=20=20
>  static uint32_t operand_bs(rv_inst inst)
>  {
> -    return (inst << 32) >> 62;
> +    return extract32(inst, 30, 2);
>  }
>=20=20
>  static uint32_t operand_rnum(rv_inst inst)
>  {
> -    return (inst << 40) >> 60;
> +    return extract32(inst, 20, 4);
>  }
>=20=20
>  static uint32_t operand_vm(rv_inst inst)
>  {
> -    return (inst << 38) >> 63;
> +    return extract32(inst, 25, 1);
>  }
>=20=20
>  static uint32_t operand_uimm_c_lb(rv_inst inst)
>  {
> -    return (((inst << 58) >> 63) << 1) |
> -        ((inst << 57) >> 63);
> +    return extract32(inst, 5, 1) << 1 |
> +        extract32(inst, 6, 1);
>  }
>=20=20
>  static uint32_t operand_uimm_c_lh(rv_inst inst)
>  {
> -    return (((inst << 58) >> 63) << 1);
> +    return extract32(inst, 5, 1) << 1;
>  }
>=20=20
>  static uint32_t operand_zcmp_spimm(rv_inst inst)
>  {
> -    return ((inst << 60) >> 62) << 4;
> +    return extract32(inst, 2, 2) << 4;
>  }
>=20=20
>  static uint32_t operand_zcmp_rlist(rv_inst inst)
>  {
> -    return ((inst << 56) >> 60);
> +    return extract32(inst, 4, 4);
>  }
>=20=20
>  static uint32_t operand_imm6(rv_inst inst)
>  {
> -    return (inst << 38) >> 58;
> +    return extract32(inst, 20, 6);
>  }

Ahh there it is, I would have just fixed it directly.

>=20=20
>  static uint32_t operand_imm2(rv_inst inst)
>  {
> -    return (inst << 37) >> 62;
> +    return extract32(inst, 25, 2);
>  }
>=20=20
>  static uint32_t operand_immh(rv_inst inst)
>  {
> -    return (inst << 32) >> 58;
> +    return extract32(inst, 26, 6);
>  }
>=20=20
>  static uint32_t operand_imml(rv_inst inst)
>  {
> -    return (inst << 38) >> 58;
> +    return extract32(inst, 20, 6);
>  }
>=20=20
>  static uint32_t calculate_stack_adj(rv_isa isa, uint32_t rlist, uint32_t=
 spimm)
> @@ -4585,12 +4585,12 @@ static uint32_t operand_zcmp_stack_adj(rv_inst in=
st, rv_isa isa)
>=20=20
>  static uint32_t operand_tbl_index(rv_inst inst)
>  {
> -    return ((inst << 54) >> 56);
> +    return extract32(inst, 2, 8);
>  }
>=20=20
>  static uint32_t operand_lpl(rv_inst inst)
>  {
> -    return inst >> 12;
> +    return extract32(inst, 12, 20);
>  }
>=20=20
>  /* decode operands */

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

