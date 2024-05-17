Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DE5C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 12:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7x18-00018q-CS; Fri, 17 May 2024 08:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s7x16-000186-R5; Fri, 17 May 2024 08:48:56 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s7x15-0003Xz-0L; Fri, 17 May 2024 08:48:56 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f4603237e0so96559b3a.0; 
 Fri, 17 May 2024 05:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715950133; x=1716554933; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5CNBNZX/SgRSkN7l/MauqmJkBJZves/aeONYzBOiBwA=;
 b=O2xIIrnzO/0pIk7XdDfNEq/SkQxxky+h9uhAafUCiWWNXEmCJVimd/HSN/e733zcSD
 V2I8CzWtXbuL60UswiOqTR/CaHUaK+4Rc7fHfIXV5iJKk4smOF13YzEqi1hp/RckY6Hn
 +Z6C6EcTM5VnWcuck2fsBzWGO8H6e4jEhTecUbPILjCUdUztjIiJejpY6TH49Rajwt8g
 QSBqAXcrqT+Y07B/JczMnL1hnbi9APrR7V8JjQJuSGxD3zxVDJP/ZyKKDeUon4s9TH+S
 qkGzpaRRA3z2rUWTTXl4sTyQ0XoFe0RNSfoNuS9aB//TIyKIJ62SAtgko6xcms3pTq9d
 QZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715950133; x=1716554933;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5CNBNZX/SgRSkN7l/MauqmJkBJZves/aeONYzBOiBwA=;
 b=SO45/YnghS23vSQMYotnhVyZm0r03tCC5fJb7mMOUoFgf+tdiBmp3avAez2ZVP6Pow
 Z9qORaP/5/w6BNuQDUBp/AF1zrv8yaZYOydDf6Cs2IahaqzbooeLSZMCyQ5z+3118xSZ
 HSLq7w0lbNYrSFl0Js6Mx9mLZiNi4cMWtBv+tHADcSxOjhGsRpVcz+a78By/Z2z1b728
 kR89rOzSlDVD0QSb3UedQQFxUAiNMcknaQVGsYcIasFDYG2npwO4Rdhpvk6Qi9WxL/SZ
 nPNGOaU4096Z7LQsQLZF3/LEO8dowjCGSA7UVC1Qntw7QqRga6vje37Ax5RVvcaRkRfW
 T5AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkwx6La7C5c/CSQ4svfb5X5XqY9Igcy7J/CQ1nk6KaDInX3kED9EjV6BSm64rabnAVuCJeeBlt7TIz7ldTkey2qvju
X-Gm-Message-State: AOJu0YyiLLwEU01tg8WIHL1Kl118eVIq/SgrgJ3IWUIb39rNLUXw8xVC
 V68X7bnFwn8DrC2fEgxrufoizDKA+rlE1lS5eKQXadTjrGSPg5oZ
X-Google-Smtp-Source: AGHT+IEwGEywMwDKLOLoxPGzzXZljuEaoUZSbLocY+k9pnlwe8PDGA6rZLL/WXd9mDZcJETqGJZztw==
X-Received: by 2002:a05:6a00:4f82:b0:6ed:4a97:26c1 with SMTP id
 d2e1a72fcca58-6f4df3eb5f7mr27579166b3a.10.1715950133001; 
 Fri, 17 May 2024 05:48:53 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-656f38b855esm3642153a12.8.2024.05.17.05.48.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 May 2024 05:48:52 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 May 2024 22:48:47 +1000
Message-Id: <D1BXJXYYCCJF.1KUFFHK83W8CV@gmail.com>
Cc: <qemu-devel@nongnu.org>, <danielhb413@gmail.com>,
 <richard.henderson@linaro.org>, <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2 6/8] target/ppc: Move div/mod fixed-point insns (64
 bits operands) to decodetree.
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Chinmay Rath" <rathc@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240423063234.76282-1-rathc@linux.ibm.com>
 <20240423063234.76282-7-rathc@linux.ibm.com>
In-Reply-To: <20240423063234.76282-7-rathc@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Apr 23, 2024 at 4:32 PM AEST, Chinmay Rath wrote:
> Moving the below instructions to decodetree specification :
>
> 	divd[u, e, eu][o][.]	: XO-form
> 	mod{sd, ud}		: X-form
>
> With this patch, all the fixed-point arithmetic instructions have been
> moved to decodetree.
> The changes were verified by validating that the tcg ops generated by tho=
se
> instructions remain the same, which were captured using the '-d in_asm,op=
' flag.
> Also, remaned do_divwe method in fixedpoint-impl.c.inc to do_dive because=
 it is
> now used to divide doubleword operands as well, and not just words.
>
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

[...]

> +static bool do_divd(DisasContext *ctx, arg_XO *a, bool sign)
> +{
> +    gen_op_arith_divd(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a->rb=
],
> +                      sign, a->oe, a->rc);
> +    return true;
> +}
> +
> +static bool do_modd(DisasContext *ctx, arg_X *a, bool sign)
> +{
> +    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
> +    gen_op_arith_modd(ctx, cpu_gpr[a->rt], cpu_gpr[a->ra], cpu_gpr[a->rb=
],
> +                      sign);
> +    return true;
> +}
> +
> +TRANS64(DIVD, do_divd, true);
> +TRANS64(DIVDU, do_divd, false);
> +TRANS64(DIVDE, do_dive, gen_helper_DIVDE);
> +TRANS64(DIVDEU, do_dive, gen_helper_DIVDEU);
> +
> +TRANS64(MODSD, do_modd, true);
> +TRANS64(MODUD, do_modd, false);

Sigh. I'm having to fix a bunch of these for 32-bit builds. Just
doing the #ifdef TARGET_PPC64 ... #else qemu_build_not_reached();
thing.

Which is quite ugly and actually prevents using some of these
macros and requires open coding (e.g., because DIVDE helper is
not declared for 32-bit in this case).

Maybe we should move 64-bit only instructions into their own
.decode file and not build them for 32-bit, so we don't have
to add all these dummy translate functions for them.

For now I'll try to squash in the fixes.

Thanks,
Nick

