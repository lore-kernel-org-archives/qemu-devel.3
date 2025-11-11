Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CB8CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 11:48:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vImrJ-0006jS-Sm; Tue, 11 Nov 2025 06:48:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vImqi-00052u-B0
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:47:48 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vImqg-0004QU-AL
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 06:47:48 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-640d0ec9651so6782357a12.3
 for <qemu-devel@nongnu.org>; Tue, 11 Nov 2025 03:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762861664; x=1763466464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5CBEBtmFXIYhtD9uj/O0m0IZEIQnCBydNbN9HhNAKK8=;
 b=yP27YQbuxK6Kq/UT9Cj/J5aXO33twcYka0tRYd4623hHR6uAa34buIoHa4UJx/pD34
 YTZVnEAsOobsGnjG3CnbuwuLpfjSh4m2CLa6ad8vv9UPaS+70kcPARF0uYMXqU6+fr6y
 7+iusrdT2ZY9Nz2hY23tz5TmELCS8x2Zm6h8uAU8I4lC0rWBVZO76LzV1aB0yt9efeQA
 UJ1cQNIKc2OM+sAgdY4OUPe2x9qTdpz0NZSXVneHFS9HQOPgoDUf+rBNO1piuAJzsWZs
 QSjOwK75T+herBP4gmPXYdHX3Oif+10C36mbL/WKDEU6w2uANYWZ4qULs91MaA/MqDib
 ihzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762861664; x=1763466464;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5CBEBtmFXIYhtD9uj/O0m0IZEIQnCBydNbN9HhNAKK8=;
 b=nGTkpFhsHJ9l8MMzwMdQH2ODC5RE5RJQKvf8TaEgOZACq1S+9lMgUMYZI4kAl4JLry
 ZfBgPCymfbKmfXfyhPIZDdVTC3I2TSWs5d9C9XonTbQ+4zWLVCyrBYnwisdJ5NKqyQVw
 eJzky8mmR9T2UjVKzTGYXlAF6hXICqn32tNllUkYOAb7RyByPojET1hOAmIamS6NfeGg
 Pcw0UX7d1aSTX8L3F8+2lwWuCS27XJlASPk9lZXnRdlIny4Iv8Jw2DrZWFiCi6iInBvx
 FhyzdM8IgX7zVqaqLvTGOyRdPhbxtPAZ4+98+pHJGkVEoGCXms4IS1G8L5r5gpMp+IiA
 iFgQ==
X-Gm-Message-State: AOJu0Yz+wjDAvKKVf9RBEi2HRScVGMJenRCKL31F/rXd81i68QIeO055
 DYUlFeYVSf9kcSDWLwfg+ZpWFuehRvDCpjr0bpTuzeRleEKOGRLjTh2hJ/sw/sQeilotkMhZisc
 7kdigHS4=
X-Gm-Gg: ASbGncu6JaFgLMo3NCCyt4ibjxQEpx+cBIkmm/aijoDUlyOCBjySyIuDwFIvcjjHvyU
 35Fb/6ZVsc+fdvJJwlIk/1AWkmokbHC10wLdsGWG29JSi3xZ+4JrZ3dTVxFfn4PLUvg3gT/1b58
 GE3UCT3gM5hs6Tv4mF0zUH2Wir7LGAMbV7kOgmFGduiF0Rs4WcTZQtiyaAOgevd3Dnh/nQyV5vx
 5l/KufNylb21FebWnr0jIcdFrKQYOjKKPhLIzhtVC8gHvxTmst5bHPFp9jf66p4CHDKodsqm7tE
 jLF0Qh+oIB57Ov0XfXr0rVr1DdOmsojlfL4/E11GL7M4lRyluyIYZeaqmbPzj20kES+bgCNVZzm
 nk2AuNmAkFbgfkaGbIGWSinBaByIq6i6xu+xwUOzPRu6dm3WnqoubZMgBm18IrtfQKoY1i+mk0N
 ric4xm4gqWFsw=
X-Google-Smtp-Source: AGHT+IEUIwW0WkQrXpevTrRi1x3YysgnDtxgHUTJxSeTZOPBephkYD4MkNTvEieUtkDOSRNNNumJUg==
X-Received: by 2002:a17:906:eec7:b0:b6d:5914:30c with SMTP id
 a640c23a62f3a-b72e04e3d76mr1391400666b.34.1762861664493; 
 Tue, 11 Nov 2025 03:47:44 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bf97d43bsm1383702766b.45.2025.11.11.03.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 03:47:43 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0F4555F871;
 Tue, 11 Nov 2025 11:47:43 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  peter.maydell@linaro.org
Subject: Re: [PATCH] target/arm/cpu64: remove duplicate include
In-Reply-To: <20251110161552.700333-1-osama.abdelkader@gmail.com> (Osama
 Abdelkader's message of "Mon, 10 Nov 2025 18:15:52 +0200")
References: <20251110161552.700333-1-osama.abdelkader@gmail.com>
User-Agent: mu4e 1.12.14-dev2; emacs 30.1
Date: Tue, 11 Nov 2025 11:47:42 +0000
Message-ID: <87zf8srdsx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Osama Abdelkader <osama.abdelkader@gmail.com> writes:

> cpregs.h is included twice.
>
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu64.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index f81cfd0113..ae84d8e420 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -34,7 +34,6 @@
>  #include "hw/qdev-properties.h"
>  #include "internals.h"
>  #include "cpu-features.h"
> -#include "cpregs.h"
>=20=20
>  /* convert between <register>_IDX and SYS_<register> */
>  #define DEF(NAME, OP0, OP1, CRN, CRM, OP2)      \

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

