Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE17C61DBE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 19:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0OUk-0005xx-Gz; Sat, 29 Aug 2026 15:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x0OUh-0005xc-Vf
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 15:13:36 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x0OUg-0006lG-Ei
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 15:13:35 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-39c8ee87f7eso18334601fa.3
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2026 12:13:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788030813; cv=none;
 d=google.com; s=arc-20260327;
 b=dCoQnrbAFiP88+avDnbUFBwrSIvnNirDennM0tQWORXykkXCJ10skkG194zeaGbe4E
 90OWxNlN6o1CuTic6lagnM5xaF2WCkTsEytSrEUSB1Bm9TGuDbfQ/yG6tzIClGcyFujY
 TJTRDVibKMcKloBXCBFBqEh+VoG1E12u78vu5NC1JNlendmwKHsmD2DrC7PkLYEZBMwB
 2WelvenvONZgVMtojN5VSreawJPH+vJOXr11NBCfzml3dSzvryWs/LcnMSgyPrxfqokq
 sGKUvXuBeLdoNb2wkVOlcV/gVfxGAVqYTXylm2uz0qZP4OXQF07scS31b0gsi+gvBxnL
 aedQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XAYdYsR6yT2aobN7LuVHKi9fi5sfTgb+thHqRo3zi6E=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=gNDqhAy3rEgLFS6+QR5KHXIUxXqVCwLw4mhfW5u2i/fF5TQqiwOb4gyMrCOOOGZ+z+
 zdia/y8B7bizoHj83n08EFar7bfJPlB4kXVN2UVyW20cx24nwSSN05nrSkwr2vDhRhBv
 o23zp1enPZmBiL/9CrSL3C9qWq9NbC60JkO2jqInsC0AW6FCi5hk58hgA9wV6XqH3YFv
 XdsqWA5w0rJmcgwj/3pj5/3Div356omHKKTopWDN2W/q3hRYZNICt9iqlcA40EtUJUsG
 CM8lrwtz5Tv65tPZLBRDEZj2IQHXkc1+r0GyuDU7sG262qhRlNmVw1IEw6XH7/BsvxkQ
 xywA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788030813; x=1788635613; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XAYdYsR6yT2aobN7LuVHKi9fi5sfTgb+thHqRo3zi6E=;
 b=DmSmHZeCzpJX9jxWB0z8tv3mqodDWuoZDW6WiYkqjkJpQSjVlcO65Qt1XK25JWBgOt
 hqYCAEiLETI5sROhyBJPv+R0uxYJJDinsdFng0T/I1ln/Z68Rm1Y8dIfedbcw4a6fR76
 kY8DbDDOP2hVm8A4nfugbNIk+u0/4Aqv2kuxkC9p+hibc9O7jfIiGtysOcET7KaYt2eN
 NAUSZIg3JlZ0I5WZ5ezo1AYj5b499NUi1jUPZURyAYJdCdd8H89uH+W/SWlMUIbO5RKj
 xObrZsY8uTFdgTsGew2yKNqQ+kbTCplnF9ThVq7DEVqBz2laLL9IhxYKxqnMk/rcmTb8
 534A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788030813; x=1788635613;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XAYdYsR6yT2aobN7LuVHKi9fi5sfTgb+thHqRo3zi6E=;
 b=kQhnsEszF9xyHzOopmuD+N1LbIwRN7jbRJF+JNqlZ17v58sKx2FLM8RLtQHZqLrgnP
 iFsTBahwlgr0pgIAFE4/z44KpprO2kOuLLmLarAiAkqTphkZhuI6SmkQbLCZzVFH0dGM
 k44QUJJ76wb9yXrlF8qE6VsrBURm7KwEbbulaib+Yxiw7CGKfenhKAgBtfXi2NIOu+fk
 LD8+8DRl2l4UfNLjZOW2ryojwtnRgqh7BCBPn4P8wrYkkit5DiOJ0KWi9THNzyJ8c/k/
 yVdo7PbcURPdLMHQszRaHBprj7Ssm6cuNbQORhT0yXXLppkD7fCNTgcR/SPC+4JCQrs2
 sQHw==
X-Gm-Message-State: AFuF++kcEti39mgxdSaePe2BO3CzP0SBYPJQvMIWPAK11nvWbe3jcHEY
 FD1uYgYONOmtV/vSZShZzJEy13e/P88L/b2CGb3ShAgq844dzy95WmMHJ/HdbsVv8+V1dWwGT3n
 DeS6rB/7pVOyvgTZMC9wzJ5kBuuuQG7s=
X-Gm-Gg: AYBFou0Gx4nlc0BkZ+PJuKJOYx7UqBuF8LgdHyPMf+sGlpUFEv/f4frSpJsF2ehNR/W
 7U1uRqlcomKJcTMjFnZSBRM0BFyNmZ+W03Zp4zLdkFvSz6byIVkKDFQ71s2NQ27Q+H2Wb1UYs6Q
 myf49Yq5qLUGNTZOu4ZXSN984quzS8ccELnOpBNd5KY3iVukhspJBHQR41pVc14z0FrykAKedf6
 Jq7D+0vgm22tg7DuP8gcwAIfn3yeUbsYxfBH7+r/07IidLUsBcykhjVlUZbWI4yQbGa6/r7ETZa
 7AtSdqWuwqnYD9+5S6ATvEiD/GYAU3XS4ToAcAMvfjQtfVfN
X-Received: by 2002:a05:651c:41d8:b0:3a1:35f3:d2f2 with SMTP id
 38308e7fff4ca-3a301cbba8fmr31031601fa.12.1788030812575; Sat, 29 Aug 2026
 12:13:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
 <20260828224451.1564072-5-richard.henderson@linaro.org>
In-Reply-To: <20260828224451.1564072-5-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 29 Aug 2026 15:13:20 -0400
X-Gm-Features: AcwNN1WDW3gPaYlfI8Hl9xirO6b7qcONu37Kskt8r33IhhIF0sIauspCccqvB_U
Message-ID: <CAEdQ38Hc=wk70pFuCC5ELC75sYFbn0d7LZgS=rBput9xXSu97w@mail.gmail.com>
Subject: Re: [PATCH 04/16] tcg/optimize: Handle INDEX_op_lea
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x22b.google.com
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

On Fri, Aug 28, 2026 at 6:44=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/optimize.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index d291c844ca8..83f95e26643 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2101,6 +2101,68 @@ static bool fold_extu(OptContext *ctx, TCGOp *op)
>      return fold_masks_zo(ctx, op, z_mask, o_mask);
>  }
>
> +static bool fold_shift(OptContext *ctx, TCGOp *op);
> +static bool fold_lea(OptContext *ctx, TCGOp *op)
> +{
> +    TCGArg sh =3D op->args[3];
> +    TCGArg imm =3D op->args[4];
> +    int var_mask =3D 0;
> +
> +    if (arg_is_const(op->args[1])) {
> +        imm +=3D arg_const_val(op->args[1]);
> +    } else {
> +        var_mask |=3D 1;
> +    }
> +    if (arg_is_const(op->args[2])) {
> +        imm +=3D arg_const_val(op->args[2]) << sh;
> +    } else {
> +        var_mask |=3D 2;
> +    }
> +
> +    switch (var_mask) {
> +    case 0:
> +        return tcg_opt_gen_movi(ctx, op, op->args[0], imm);
> +
> +    case 1:
> +        if (imm =3D=3D 0) {
> +            return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[1]);
> +        }
> +        op->opc =3D INDEX_op_add;
> +        op->args[2] =3D arg_new_constant(ctx, imm);
> +        break;
> +
> +    case 2:
> +        if (sh =3D=3D 0) {
> +            if (imm =3D=3D 0) {
> +                return tcg_opt_gen_mov(ctx, op, op->args[0], op->args[2]=
);
> +            }
> +            op->opc =3D INDEX_op_add;
> +            op->args[1] =3D op->args[2];
> +            op->args[2] =3D arg_new_constant(ctx, imm);

If we use `fold_add` here, will that handle optimizing add dst, x, -x
into mov dst, 0?

> +            break;
> +        }
> +        if (imm =3D=3D 0) {
> +            op->opc =3D INDEX_op_shl;
> +            op->args[1] =3D op->args[2];
> +            op->args[2] =3D arg_new_constant(ctx, sh);
> +            return fold_shift(ctx, op);
> +        }
> +
> +        /* If arg1 was not already 0, fold the immediates. */
> +        if (arg_const_val(op->args[1]) !=3D 0) {
> +            if (TCG_TARGET_lea_imm_valid(ctx->type, imm)) {
> +                op->args[1] =3D arg_new_constant(ctx, 0);
> +                op->args[4] =3D imm;
> +            } else {
> +                op->args[1] =3D arg_new_constant(ctx, imm);
> +                op->args[4] =3D 0;
> +            }
> +        }
> +        break;
> +    }
> +    return finish_folding(ctx, op);

It looks to me like `fold_shift` and `fold_add` propagate {z,o,s}_mask
information, but `fold_lea` doesn't. I think that might prevent
folding a downstream operation?

