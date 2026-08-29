Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9987C61DBE
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2026 19:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0OMz-0004mF-7D; Sat, 29 Aug 2026 15:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x0OMy-0004m7-7b
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 15:05:36 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1x0OMw-0006Et-JB
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 15:05:36 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5b4a0e5aefeso2099567e87.3
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2026 12:05:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788030333; cv=none;
 d=google.com; s=arc-20260327;
 b=ZTrLpF5CKEyx/OLvRfK0jmtgK833iowGIToD9WzcXQw+SoAGsoCF26gSiPy0FbKncu
 VobcDdsd81fH0iPIas9vEF32G81+xuhEi1Rpol0qnIvf692oj0tAnsoSJaQTVdfsdda9
 AoPf/OGrZF/ADR6mVebyBBH1tRvgf/CdIz8QVf8x6QMRwHOjWF2K9CwGraibzA4soaEB
 SEwRlqzpMJ6rOSgaGiaJeszqQ6DIiPts8K9djYPuin99e9P5Qea4ibDpMTeWd22B8D/7
 eDR24QnS6bxcP8+IXRBPfgLdkTAKkIX4yguQ3piPTUXAVqwT7sfPnGMq3bDkLM3k1uum
 va6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EeVv9u08wG5Wfg+pmBuUoo8ESaLfgp2ii5nN/DD7y04=;
 fh=GI2e/SBiq4MTIPc9mHou6R6WJe3VvhdDMWKbaXflkfU=;
 b=QJW1Z0wehK4TRPpzEYiDfJ7Fta31GOG5fzGFsO/3/N0+3Tv0/EL68xNGUbGoEb7mKd
 +0evFkBwSNAm0lyX8u+biTI+x9kQ/wYY/Q0STY/dfgcWbdptlv8E5Ss3a/ZHRkYpHsSz
 YsfLQR00sHxMloctJvR0EcT2xAZUtLOkq6xny1Uh+/rjnLIqSFiDk0l//WYKmeaFihpA
 tZsfVTehyD+LwSxN7QRYK2uSqbhtjiyUeE/hXF61qqJDA09t3pSqeb9q+Zysd+rRKbZ+
 7LsjeY5uODI9a9R8gOtdkrfJ23w1vNU4hVlwxjfUWO9P/hWJMeI0TfdIDnMV3GUVM9qN
 lFXA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788030333; x=1788635133; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EeVv9u08wG5Wfg+pmBuUoo8ESaLfgp2ii5nN/DD7y04=;
 b=iaCFLCpzG4CnXYGU9m9ecVmG2gAdduP5c+0GnFVHhU2iW+d6sSNW5FdPf7fAn+fEtJ
 N+PPjTk1VuiekBHaBt0/WCHshmOBVwSs6YnufpM+qYlltkIWcX9jsOn+a2lgZ6Ovr+oI
 Pm26rtJ4NiKscNR0LwgJUaCDlqwWEWb7V+HasRugGf4ghlf+Shy0RFEBzCU9LPVgwjXr
 fT7Im214A7Wkq4DXQ7YrF9/478hCwms+T+S9xSmJgn9000JGBURirLdMjvF8BWs83Kag
 z14T9/dRHhVHuvh0psvHxOWcffr87dgO3QP3/R3krBsy/ZCEDJSLcVTsv3InUa+ye0my
 vk+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788030333; x=1788635133;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EeVv9u08wG5Wfg+pmBuUoo8ESaLfgp2ii5nN/DD7y04=;
 b=op+K1wAsXdkOLNltLh8a05ZEqnAwKr1db2ZZG6ZnRJWNiRLHC15GkPlY3B74xGXuFK
 h1pKNUKN3M6D+fFzJ6BlsGLPDdkz3R26LA2wq/VjptpReAqkW2t99YqSkOZzOqzE50vC
 g36EMLQ1sCB+aCWkBwy0j3fa6Sr3S9GEWtsKctzWxw5OdlhenGxknyvbbd4Btz1+w+58
 EX/SWr6S4k07uXWnax2SeSTusyLTjZxdf4PM1avOLfIFC4E63twkajP5XtboituA977D
 Tr9DM+cKeHMmiIUUWr+7oCjcBgU9JSClR1DHe7J+VWNEnVge4PoQP4WukjiHu/D21zyf
 T6mw==
X-Gm-Message-State: AFuF++miVnDaLSbbws0j5jM+btObb8Uz4xOxxTMN5oIoLQk6jMlwVFGQ
 9bZF6g1UgkHVqOjezUqJoCCl+QNYPMj3jgYAu5pEFgXf0k1K6tzRmeqMTK1wHETjx4AKGf1zrOa
 N80E436pT4aJzd9uq5ywPwDpyNoyfXKQ=
X-Gm-Gg: AYBFou074ZM1AjnYAeNKdRuxOb22uijAVlqpUBP5+Y7XCQ731B4YVMwUzlUK9S1tBuI
 fXl6lPsY3z2HzedWiDLBEexEuUxEE1coioqVv1nYGgaEo9ViR+ktgc68wF1Ht5pU9ktO4WGOdxF
 ofwbQXDMTDstu1WVLo6RSQMZJpuydxMOv67IMSspeKrdbuiWMNcVDVP/zvTepfeMKKjPd65vHut
 wtpmMgxYlMwP2A1wPjpXLaH6FgMnKhzRf7/nB9aux3pEjqjkK5QahcWy+1wRi0NqDHwKIsyC126
 +k//jX0BkYm06Lmejq0LpWsp4BPhaKO5zQs0CTY0ytHgka8=
X-Received: by 2002:a05:6512:3096:b0:5b5:edd1:471f with SMTP id
 2adb3069b0e04-5b5edd14997mr2415814e87.11.1788030332386; Sat, 29 Aug 2026
 12:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
 <20260828224451.1564072-16-richard.henderson@linaro.org>
In-Reply-To: <20260828224451.1564072-16-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Sat, 29 Aug 2026 15:05:19 -0400
X-Gm-Features: AcwNN1XInQUykVnIqU2cEQSN3xy0hYPJmzcCGtMOsaexvbBgg2acRAe7AjgXW-I
Message-ID: <CAEdQ38F2QrafQtxrxLCKav8PiDBtkvEotR8r7R3BMC+fJNRczA@mail.gmail.com>
Subject: Re: [PATCH 15/16] tcg/riscv64: Implement INDEX_op_lea
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=mattst88@gmail.com; helo=mail-lf1-x136.google.com
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

On Fri, Aug 28, 2026 at 6:45=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/riscv64/tcg-target-has.h | 12 ++++++++++--
>  tcg/riscv64/tcg-target.c.inc | 16 +++++++++++++++-
>  2 files changed, 25 insertions(+), 3 deletions(-)
>
> diff --git a/tcg/riscv64/tcg-target-has.h b/tcg/riscv64/tcg-target-has.h
> index 93f8baad09f..3cdeb5c3900 100644
> --- a/tcg/riscv64/tcg-target-has.h
> +++ b/tcg/riscv64/tcg-target-has.h
> @@ -69,7 +69,15 @@ tcg_target_sextract_valid(TCGType type, unsigned ofs, =
unsigned len)
>
>  #define TCG_TARGET_deposit_valid(type, ofs, len)  0
>
> -#define TCG_TARGET_lea_sh_valid(type, sh)         0
> -#define TCG_TARGET_lea_imm_valid(type, imm)       0
> +/*
> + * The SH*ADD instructions only operate on full register width.
> + * To allow TCG_TYPE_I32, we'd need a subsequent extension,
> + * with the result no better than the separate shift+add insns.
> + */
> +#define TCG_TARGET_lea_sh_valid(type, sh)         \
> +    (cpuinfo & CPUINFO_ZBA &&                     \
> +     (type) =3D=3D TCG_TYPE_REG &&                    \
> +     (sh) >=3D 1 && (sh) <=3D 3)
> +#define TCG_TARGET_lea_imm_valid(type, imm)       ((imm) =3D=3D 0)
>
>  #endif
> diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
> index df4c4a9789b..ba7aab9246c 100644
> --- a/tcg/riscv64/tcg-target.c.inc
> +++ b/tcg/riscv64/tcg-target.c.inc
> @@ -224,6 +224,7 @@ typedef enum {
>
>      /* Zba: Bit manipulation extension, address generation */
>      OPC_ADD_UW =3D 0x0800003b,
> +    OPC_SHxADD =3D 0x20000033,  /* plus sh << 13 */
>
>      /* Zbb: Bit manipulation extension, basic bit manipulation */
>      OPC_ANDN   =3D 0x40007033,
> @@ -2725,8 +2726,21 @@ static const TCGOutOpStore outop_st =3D {
>      .out_r =3D tcg_out_st,
>  };
>
> +static void tgen_lea(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1,
> +                     TCGReg a2, unsigned sh, tcg_target_long imm)
> +{
> +    tcg_out32(s, encode_r(OPC_SHxADD, a0, a2, a1) | (sh << 13));
> +}
> +
> +static TCGConstraintSetIndex cset_zba_rrr(TCGType type, unsigned flags)
> +{

Assert type =3D=3D TCG_TYPE_REG to mirror the macro?

> +    return cpuinfo & CPUINFO_ZBA ? C_O1_I2(r, r, r) : C_NotImplemented;
> +}

