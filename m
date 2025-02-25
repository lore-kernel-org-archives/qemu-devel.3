Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0B1C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 19:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn0Ah-0001YD-DO; Tue, 25 Feb 2025 14:00:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tn0A4-0001OW-6I
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 14:00:11 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tn0A1-0002hl-Kj
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 14:00:07 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so3450511f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 11:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740510003; x=1741114803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UoYP30pe3Y69bUhEc/iugFWzVPK0AK9VEOiX7fDGWFE=;
 b=PlZxF+P8kcNx0tcy5h9gwUcFnV58gzZTfQXqul8NL0sNShIsm2zh4HV1Q0gw2nRzLv
 zPjJuUkbt2J/pvMwzw81h58CVf59wdKS1mpPPBsNclPB08vtTt/ee4tvX0PYImRZX1tF
 +tXfm4wPj+5PCtVNlV1nOrFPr+pVzV2oEjaVyko6vUdYlyWaQAgtn7zhI7AkKhfdPqwW
 0qLMYlypwEF6GwKfqiqiSlLZUEykLFK6B+MrgxqchjGbBrsmfCurqjt0NSi/PNJovIek
 dMtjEITYvmRBK91VGh43+ksD89cMCsXJyMfP56nCtEX3HEMmRikmIUfVPA6hfs8O6uC4
 r+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740510003; x=1741114803;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UoYP30pe3Y69bUhEc/iugFWzVPK0AK9VEOiX7fDGWFE=;
 b=LfPS6qLFnrHPROHnJFKWvZc4iNKmM/4gHATJJ9GuMoUWv8xXQSlp2ex43I1fZaB1qv
 gYemSM7PSBK0V30dDaixf524Gs7r8hLtHWQ8rI1a+3Ek9jpFBprRls5s4qsJq/xCL80/
 7cqL47+fVKADSwXehOPqpePm3Cb9u5rk8NQVTJW4VQP9pOawa3Qqz3ej6Mvl/OQ+qR4F
 mJiee1kChyKwzo3+eKXnfYLjy7zEKS0zJFDkMeEEI57Lnu/vSN/6PSznEaVJmZWFTTOC
 kTHzNSXMuON++w4H5QMhONGTWKGSQtb5NEvzRTCmN68AXo6t5B3GBUHabFbL8Wrt0Tcb
 FUlQ==
X-Gm-Message-State: AOJu0YwFDfKKnZP6EBndqzRYAHrMbsZl0gpRSnyP1TEH3oWMD9lJfDea
 i+vpsUvslRu+FiajM3+qLE8FpDJ7Zq1/1tjlDkBQDNPuqkXhC7llkLxrCXaYz48=
X-Gm-Gg: ASbGncsxW2TH7k41mD8zsAYWOTXnezbITwvWLDTfi5ve+QU0WC/lywZOGSxT3Wd13t7
 XoP/ih+b1vM/CpYQQi3FvQmXYBXKNCe1ubNCvjv2VQ9Y2asQARWjq1VLSgoy9XaBXzUhbict8xp
 DL+YOZZEXbc52AGFnkBM0o6jX58va9spNKUbhIFN0eqo3wtbzCAkdya14yxCz9MQipa+baXww2k
 MZsXaXCqeDdoUL/TphXBU4Ofcpgrqcla/KQncB+Y0WmHLFmCKXswdxu5+KoqzvZ6L03OB/Ks+c+
 2d2rrwUJwXSnEeM+FlfsC4io5ebe
X-Google-Smtp-Source: AGHT+IHdFfK9VUIfPH96O+Kspp00UkT5F2tiJ0VqHru4jyjq1vvTZs3aG2dsv8/3hk8IyrTs3Skq1A==
X-Received: by 2002:a05:6000:1789:b0:38f:295e:6331 with SMTP id
 ffacd0b85a97d-390cc605164mr3728683f8f.19.1740510003238; 
 Tue, 25 Feb 2025 11:00:03 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8e72e6sm3241546f8f.68.2025.02.25.11.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 11:00:02 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E740E5F7DC;
 Tue, 25 Feb 2025 19:00:01 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 001/162] tcg: Add all_outop[]
In-Reply-To: <20250216231012.2808572-2-richard.henderson@linaro.org> (Richard
 Henderson's message of "Sun, 16 Feb 2025 15:07:30 -0800")
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-2-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Tue, 25 Feb 2025 19:00:01 +0000
Message-ID: <87zfi94zpq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Richard Henderson <richard.henderson@linaro.org> writes:

> Add infrastructure for more consolidated output of opcodes.
> The base structure allows for constraints to be either static
> or dynamic, and for the existence of those constraints to
> replace TCG_TARGET_HAS_* and the bulk of tcg_op_supported.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 68 insertions(+), 8 deletions(-)
>
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index e8950df2ad..96c29536b6 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -861,6 +861,7 @@ static int tcg_out_pool_finalize(TCGContext *s)
>  #define C_N1_O1_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_n1_o1_i4_, O1, O2, I=
1, I2, I3, I4),
>=20=20
>  typedef enum {
> +    C_Dynamic =3D -2,
>      C_NotImplemented =3D -1,
>  #include "tcg-target-con-set.h"
>  } TCGConstraintSetIndex;
> @@ -954,6 +955,29 @@ static const TCGConstraintSet constraint_sets[] =3D {
>  #define C_O2_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_o2_i4_, O1, O2, I1, I2,=
 I3, I4)
>  #define C_N1_O1_I4(O1, O2, I1, I2, I3, I4) C_PFX6(c_n1_o1_i4_, O1, O2, I=
1, I2, I3, I4)
>=20=20
> +/*
> + * TCGOutOp is the base class for a set of structures that describe how
> + * to generate code for a given TCGOpcode.
> + *
> + * @static_constraint:
> + *   C_NotImplemented: The TCGOpcode is not supported by the backend.
> + *   C_Dynamic:        Use @dynamic_constraint to select a constraint set
> + *                     based on any of @type, @flags, or host isa.
> + *   Otherwise:        The register allocation constrains for the TCGOpc=
ode.
> + *
> + * Subclasses of TCGOutOp will define a set of output routines that may
> + * be used.  Such routines will often be selected by the set of registers
> + * and constants that come out of register allocation.  The set of
> + * routines that are provided will guide the set of constraints that are
> + * legal.  In particular, assume that tcg_optimize() has done its job in
> + * swapping commutative operands and folding operations for which all
> + * operands are constant.
> + */
> +typedef struct TCGOutOp {
> +    TCGConstraintSetIndex static_constraint;
> +    TCGConstraintSetIndex (*dynamic_constraint)(TCGType type, unsigned f=
lags);
> +} TCGOutOp;
> +

Nice ;-)

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

