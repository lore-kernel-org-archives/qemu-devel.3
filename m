Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08554E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 13:44:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVspK-0005vL-Ug; Thu, 09 Jan 2025 08:43:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVspI-0005up-P0
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 08:43:57 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVspH-0003bw-1q
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 08:43:56 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aaef00ab172so167814966b.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 05:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736430233; x=1737035033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/gwqkHJXVNF0TWTT9SqwUAvu25Jy2OeRif2u47hJ4P0=;
 b=WwfeCj9vJ0d9igCgZoNhx+9ek7m2UTtmjxyx4gL6kart1e/ymTs3pIifwb8QLV/qLZ
 oCsn7joRnqLWXbEj/AUJefhZlNwELDlkZ4E2pOiPnu1vXRlux498vcIkWAJuvzGPtjhi
 jea8ZtIB/a5tphcbyHLvVG8qJ7al2RXXw3/dUIj6lORXFu+3RqYnZiL6do/f4l/fIGPU
 qT9+lrQOFKUOuYCCS+jkROqpBMivpPlEf9glkp40xIFw+uWl6/By0NlndJWIlQ0869qi
 aeg/zNYs4Pj02WgkAdIz/urc2Ll09WDhbArJj9APOciqkPnAssNzqrmQGU0rZYog56xw
 ZSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736430233; x=1737035033;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/gwqkHJXVNF0TWTT9SqwUAvu25Jy2OeRif2u47hJ4P0=;
 b=LOUzzJL3Jyim1EA7xkJFEBA+mBHTj1gzA4k7AOsK7btnpfQr5BaXEWWtE9TUZ/biMc
 GGAk+H3vrdIdsgJdZnTnkKYsS4gYFD6ccak2KSXIfwp2BS115wQQotUpfBWWhH6ojwEo
 OjD2OUQb/tTXOSTRF3eQtPutw21e8wyp4jl/Set4wYWZ4sR5ZSc2qU2YtnYX0OfJcrG5
 J4p8sNQX0nzNI5gHe+2gPtUltjjZOSTA9MMB4dhKkAoR7UGMmZ75cSY9JXnHtUWIRAqD
 YNb+C6c8DPjcwZyp+UYvpp5EKMoIUj611ORvvYN3ETDu0pyvEPKLVSq4PlJspp2HJbPW
 iZEg==
X-Gm-Message-State: AOJu0YxFCaMe/APovaoxhMvWcUPogNMA7+E/72gnfYBsYC/A2TOew8Eq
 9ryduf01elAQA5Fx7Hu1z6XC5V2B8wXEcSRQkM1VMXu0XW9l/nHWL0FZW3hfnKc=
X-Gm-Gg: ASbGnculv7y5t0TrXRwcZWWKWIgkjJOaip5mJ00stMKeKo8tqShDS3ZuLM9SlvKEMZk
 h4MAehmM0+SjADAuPrW9qrcgY95FszaAzBMA7RrlPe277Cp5MYGl5//ExT570Nlot43Gf1O8NXP
 Y6ZpZKNzwybc6aNKllfdHtfOqj8KxJRL+Maw/8riOvGiE7MhfDAuGIpcOwuhADE7g9QJME0QxKt
 /urANyL4/qbO32LmecvbU/HUM5KsLHCtCnUJs1kK3HLJj3srgl07So=
X-Google-Smtp-Source: AGHT+IF0DOOdGkDpQ1uWfh3z+lC9/e+POLF98ikPpS+aTf4fhE4os7M16ZWBYGWthSeF65lDBsCS1A==
X-Received: by 2002:a05:6402:3596:b0:5d0:ea4f:972f with SMTP id
 4fb4d7f45d1cf-5d972e0b068mr14723569a12.8.1736430233165; 
 Thu, 09 Jan 2025 05:43:53 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99008c35bsm631655a12.2.2025.01.09.05.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 05:43:51 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CD5D65F75D;
 Thu,  9 Jan 2025 13:43:50 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Aleksandar Rikalo <arikalo@gmail.com>
Subject: Re: [RFC PATCH v3 08/11] target/mips: call plugin trap callbacks
In-Reply-To: <5a165b308d75718e185806607df583596270181d.1733063076.git.neither@nut.email>
 (Julian Ganz's message of "Mon, 2 Dec 2024 20:26:49 +0100")
References: <cover.1733063076.git.neither@nut.email>
 <5a165b308d75718e185806607df583596270181d.1733063076.git.neither@nut.email>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 09 Jan 2025 13:43:50 +0000
Message-ID: <878qrk85m1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
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

Julian Ganz <neither@nut.email> writes:

> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
>
> This change places hooks for MIPS targets.
> ---
>  target/mips/tcg/sysemu/tlb_helper.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu=
/tlb_helper.c
> index e98bb95951..2b19975d53 100644
> --- a/target/mips/tcg/sysemu/tlb_helper.c
> +++ b/target/mips/tcg/sysemu/tlb_helper.c
> @@ -18,6 +18,7 @@
>   */

merge failure as this is now in system/tlb_helper.c

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

