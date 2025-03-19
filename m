Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60A1C35FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwYr-0003Eg-9G; Wed, 19 Mar 2025 12:46:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuwYC-00035w-HC
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:45:57 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuwY9-0002sz-J3
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:45:51 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3996af42857so677950f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 09:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742402748; x=1743007548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=byYuJ69mZseIS+pMuJcRRCa33X5idTReLqatgayIHc4=;
 b=vPA+CZKwjMrSqIz5412Kh3NuKtE8CdD2K9uZ5Sau9+NCi55ErMZ6iSHCp0hsHPCimp
 xp91mlvZ4Ka9G5NUwMRV9VrXgyAQScUvLEWbCSTpVYbxVz35N0gKQ8ILzuk2wZia5VfW
 XXwK2ePeHTidNywyiA+Ypf8rwPDGCxFt+A8RwBFdqDFfu18n4S5e90/lewN/MRZYRMGQ
 VZG466QYAxxfJGFjWCsd7hamQJ/XoQm9GkX8FgoJiVaIUNrJSvvyttHPflIY7YvUjmBB
 dN3nRwOpkLz06QaoOtX6sF3aY8arFkf60yWFJtgrL/bxYRHcuZL+u+SP6DwIlLlki08e
 Z19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742402748; x=1743007548;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=byYuJ69mZseIS+pMuJcRRCa33X5idTReLqatgayIHc4=;
 b=hmpigwwdf3gnov0xVrecN9Ci7Rr/b82UEmQ7yax6RvuZVdWIFp5TBIZAaHsPWk3xA2
 eRxeRuW2oLAIJDDus7ukbH5zCPP88CnF/rTHkkTDpQK1MhcChYQrMLlmk7v1EiwbkQlo
 Eu/xEGQvMNyoINpsRgfOwV017SVyApS4oksInwl9pZXyHYzXYU2wEORDmo+yrv8hucQh
 cTsk75tL/NSW6WlPw/l/H0vdVOoqinQ+cRKzeYm/+UE6BVV/wgjYQoeQyFqfVF7Vl1RK
 teqrayprguKHMKjg0XulaR4sdHA9OIXO2AJcFb8GQqZMecMlg+FmpnvgTGDUngCHrpbb
 zxtQ==
X-Gm-Message-State: AOJu0YxsEolfTcKIGWzcPE/2J8PcZjFPYy3N3Z2gN8stLF9myfFr7j/v
 L3/c2LQvuaXQDOQeRrdKVTyE/BIkCas9Ja6yF8qET66jCzB9Ibd5R/J40Ca3diA=
X-Gm-Gg: ASbGncurtdWRPSLf5j9VO3NA4UzHQPndw3tIfTfwt0MK0p5DXSAsVNCEuq2pZRC7ZPB
 HwmwEdaYJSBcszAjeyeDDYZxBHKo/esdf7KX0e/MF9eXMJ22xjkQbDibe/JDqJC9Clm5GXIikqi
 31JEvonxU9DmXiHG7nfpFW3Epi9PY4mlIAw/WPD01iguqDjGNe7eRwNz7FVR/oxosdtvqXEQrKz
 CZ31M4yKRYK2NI/1PqsI4LZ/O01+Bo60xKv+BpD0z+dc/tIpsS/6jMcpg8RYlxUmFaoIx4S+LX4
 d6r1K+iGsVXbmwmRI+v/iQ5od1iB1E0T5NFwGEwVzUFLmVs=
X-Google-Smtp-Source: AGHT+IHIMPodF8KvrwVr9bHPat7NZO/hvYsMFvCMJj6+Eqkf6lusrIQmo1WKP40/tVy4GEstgWaTVA==
X-Received: by 2002:a05:6000:4405:b0:391:21e2:ec3b with SMTP id
 ffacd0b85a97d-3997955cc17mr131997f8f.3.1742402747593; 
 Wed, 19 Mar 2025 09:45:47 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c7df3506sm22088677f8f.11.2025.03.19.09.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 09:45:47 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0325E5F93F;
 Wed, 19 Mar 2025 16:45:46 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Anton Johansson <anjo@rev.ng>,  Peter
 Maydell <peter.maydell@linaro.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH-for-10.1 12/12] tcg: Uninline tcg_gen_insn_start()
In-Reply-To: <20250319134507.45045-13-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 19 Mar 2025 14:45:06
 +0100")
References: <20250319134507.45045-1-philmd@linaro.org>
 <20250319134507.45045-13-philmd@linaro.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 19 Mar 2025 16:45:45 +0000
Message-ID: <878qp1m0jq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x434.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> tcg_gen_insn_start() is now common to all TCG frontends.
> We don't need to keep it inlined, move it to tcg.c.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/tcg/tcg-op.h | 15 ---------------
>  include/tcg/tcg.h    |  2 ++
>  tcg/tcg.c            | 15 +++++++++++++++
>  3 files changed, 17 insertions(+), 15 deletions(-)
>
> diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
> index cf177a1fd3b..470cb46225e 100644
> --- a/include/tcg/tcg-op.h
> +++ b/include/tcg/tcg-op.h
> @@ -22,21 +22,6 @@
>  # error
>  #endif
>=20=20
> -static inline void tcg_gen_insn_start(uint64_t pc, uint64_t a1, uint64_t=
 a2)
> -{
> -    unsigned insn_start_words =3D tcg_ctx->insn_start_words;
> -    TCGOp *op =3D tcg_emit_op(INDEX_op_insn_start,
> -                            insn_start_words * 64 / TCG_TARGET_REG_BITS);
> -
> -    tcg_set_insn_start_param(op, 0, pc);
> -    if (insn_start_words > 1) {
> -        tcg_set_insn_start_param(op, 1, a1);
> -    }
> -    if (insn_start_words > 2) {
> -        tcg_set_insn_start_param(op, 2, a2);
> -    }
> -}
> -
>  #if TARGET_LONG_BITS =3D=3D 32
>  typedef TCGv_i32 TCGv;
>  #define tcg_temp_new() tcg_temp_new_i32()
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index 92a23e10218..d87d900bf81 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -609,6 +609,8 @@ static inline void tcg_set_insn_start_param(TCGOp *op=
, int arg, uint64_t v)
>      }
>  }
>=20=20
> +void tcg_gen_insn_start(uint64_t pc, uint64_t a1, uint64_t a2);
> +

Is would be nice to docstring the function to explain what it does and
note where the additional data is interpreted
(cpu_restore_state_from_tb?).

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

