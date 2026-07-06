Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441F2C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 05:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgbwe-0006S9-3U; Mon, 06 Jul 2026 01:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgbwb-0006Ri-84
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 01:32:37 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wgbwZ-0008Iz-Er
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 01:32:37 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-698ab9aae16so4435642a12.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 22:32:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783315954; cv=none;
 d=google.com; s=arc-20260327;
 b=CSLUVJewVOb1OG1cDhybEkGZ93nfN001Fdm+LfUtj0LJBLyyaX+FRET0UEPWVNso2i
 Rhs+f9H/sxYdCb8k2EQ+M0lKvoi4/CfX3a9/Tc9+b7nncnkjPXHccymAIs0t5HX8a+BD
 vpIIQ1P6vPhJOFciFoFgIe+hn7OtvQ/QLTQTbGN5FGplaeM8tMF+4uWLc8qucG6giPZT
 zkFDYEoKtSylNSE0kB5aSMD00wgFWJqCduVEFIAb/0vh/uPHwb1RIdHZODHI3ih+okvU
 wKktI7hGJlqY5J3xIdcdcpta9RtTk5GfRIaeCwy5wMtAd3z2l6rorcbIG7HlCvJk0WbF
 WJZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zaQmt+1CRY38HjRif+W7XAPqNUJ2db9Xfdb0awJ4AqE=;
 fh=9ZBm7Jeorp9wSVPYF5AiPBCRDB4kcVwmpribd+uGcX8=;
 b=EP9hs/8Uc3zEkCIew03SaUYgZDv5e/cOV79PUDnD2J4pErAWQqzUrzOH4/3gzC49Li
 SUZ6hxxvHq5/pvsZOGpUAfunU7TeI2ezSgvsB5MBr8zYsONl5AK1xaIaMH9LfVAEp6Zi
 hnQyvxTqTeCIzE42LonlKxXmJpqC2jmoDuNdb7yE0/f0SC8sZDuI+W7Q8QXaI9ClMfXD
 S2jYxFgl/MbmX0daWLYhFHu5dmyurlnOBJaZkGpzYQD30oeBd1HndoWBF8QgKIDVdrd/
 06vqaigQYeC/sKVCO02Ea+fR+6s8ru/n0rHs4xIvdN17Ub8DFnuolvWhD8h79RFUEjT0
 SqvQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783315954; x=1783920754; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zaQmt+1CRY38HjRif+W7XAPqNUJ2db9Xfdb0awJ4AqE=;
 b=WsLl2C9dDkpJDHV04xmYmW9heDAdGWRqTtgr0AqtSlrcHt3f4GXSr4oahgbnysSg7K
 qriHfRMxAjyuHayhMvWu7VV07Ggda28Uk3getK0EQku/iaRlDiIp1w+7CrBDD+2L+Yw4
 XeBuWvWc3uiIWxEGxi+m0h5ywQt69g7Ewc+WBDSTBVfugG3aWiAcrz3BvIqofwQ0W6lI
 5vNUBtnxxuEk6xs7Q6VTvZZDX3nBdYJ8hrleLyGt3cNizbjjIC7ZQnbZCWlnaK3m3OKF
 N/0TW+EtIyrKaF/Nbux6ye72AxqmwAve2EX9MDQu4ocwgqZEQNRnNUEqTZX93s1u/DcS
 sgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783315954; x=1783920754;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zaQmt+1CRY38HjRif+W7XAPqNUJ2db9Xfdb0awJ4AqE=;
 b=He3lWCKjI+fiHMeHH0Ysq8Jg5sT2OBXiSDzZi64ULGWhbKieEQPUJqCKkDJnKtS8Mb
 tiQiaE0bDuV4TT0XZABObWeg2skE5U+4D/YatiGWJBAo+CRYX2N4DYbgHyOl2GCVm+xs
 QcoHtQQ2HJjNyknL4Qpwq+BVLHzwbafKPYgFvZ2x7PMu3VlhbOFjvNLpIBz9BPZquib4
 jtIVh/X3c5fAy+XyuQGVL60kpjlpHqN84rQutnhDKZmhGLNdZEkRzuHnI9ujGsuZCa4t
 JaMXef1w4pnhx98InOOIdAJLTRphpYKJWiAnEyY76kQ5QbyFxxQ2ujfr3TQaQG/eWK+Y
 oDcw==
X-Gm-Message-State: AOJu0Yw7M01yB4s+BZixqotcHQmH1VDH0g3S39U5mQ7HHi2uWhvvOweE
 FQfC16/885wa9YihDoqxVijgjjZh2pc5BlKwLbk3m0+iaVyrzEi5T3xClTwcSxKjwqeXF6naAj7
 P+ZUS2uLxUfuiar2ER+m/gTkLZHP27bI=
X-Gm-Gg: AfdE7cnhzz3t6tSHQO8v4VyKFH1RIrMu5SQk4oicRnwFHuWgvUneqECmGklDx1bHMzA
 9T+1tEICi89xhpj9hbsOyf+4VeD3QRvxzt/3cbvnV6NLsFodf65K3A38ZMdFdFTfmy0hl3Cc0Yk
 epxZPjga3zOzkolTMLbQyzwU7BozoNC+R5lbuECglVgvvxBX9cZxBrks6ojZsBCVjNkyj/YHmGG
 gYHCGAqlHDtYlirW0gARff/5odKQ313xtoFQFrTSIr48kYRo6/5axnkv7/pLlzGxRt4oDyLEkbj
 rt8kSMIa08V9b5s0HLusaB0d6Eo=
X-Received: by 2002:a05:6402:34c6:b0:68c:3439:1340 with SMTP id
 4fb4d7f45d1cf-69a1a3aa17amr2834253a12.22.1783315953625; Sun, 05 Jul 2026
 22:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260630104350.748267-1-frank.chang@sifive.com>
 <20260630104350.748267-3-frank.chang@sifive.com>
In-Reply-To: <20260630104350.748267-3-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2026 15:32:06 +1000
X-Gm-Features: AVVi8CcRk1B7JEiWmk4gvQFaTNsu9QBU8e51ga9q873ml6L9gOIMsCl7A_Ir0Kk
Message-ID: <CAKmqyKPFV++zTuzWSWdMLbj1gb+VaLdrW6TEEo29+7jLz=0+ZA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] target/riscv: Support raising misaligned
 exceptions for scalar loads/stores
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Max Chou <max.chou@sifive.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jun 30, 2026 at 8:46=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> When the Zicclsm extension is not enabled, raise misaligned load/store
> exceptions for misaligned accesses from scalar load/store instructions.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Max Chou <max.chou@sifive.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

This patch breaks the `func-riscv64-opensbi` test, which you can run
with `make check-functional-riscv64`

Alistair

> ---
>  target/riscv/insn_trans/trans_rvi.c.inc | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_=
trans/trans_rvi.c.inc
> index e47b16a7fa2..cc1b5dbbadc 100644
> --- a/target/riscv/insn_trans/trans_rvi.c.inc
> +++ b/target/riscv/insn_trans/trans_rvi.c.inc
> @@ -413,6 +413,9 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, Me=
mOp memop)
>      if (ctx->cfg_ptr->ext_zama16b) {
>          memop |=3D MO_ATOM_WITHIN16;
>      }
> +    if (!ctx->cfg_ptr->ext_zicclsm) {
> +        memop |=3D MO_ALIGN;
> +    }
>      decode_save_opc(ctx, 0);
>      if (get_xl(ctx) =3D=3D MXL_RV128) {
>          out =3D gen_load_i128(ctx, a, memop);
> @@ -524,6 +527,9 @@ static bool gen_store(DisasContext *ctx, arg_sb *a, M=
emOp memop)
>      if (ctx->cfg_ptr->ext_zama16b) {
>          memop |=3D MO_ATOM_WITHIN16;
>      }
> +    if (!ctx->cfg_ptr->ext_zicclsm) {
> +        memop |=3D MO_ALIGN;
> +    }
>      decode_save_opc(ctx, 0);
>      if (get_xl(ctx) =3D=3D MXL_RV128) {
>          return gen_store_i128(ctx, a, memop);
> --
> 2.43.0
>
>

