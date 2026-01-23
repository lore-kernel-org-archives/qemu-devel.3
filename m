Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F12CD74EEC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 16:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjJpT-0004Dc-Dm; Fri, 23 Jan 2026 11:16:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjJpR-0004Cq-Lz
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 11:16:09 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjJpP-00014t-Va
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 11:16:09 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47ee3da7447so18467765e9.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 08:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769184966; x=1769789766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Npq+Iy8IFq0PbXXHDZroCeaVa4zh+Ofswalg8x3cz/0=;
 b=wKCkOCLelbUbkHDUxdjGouzZmsbY63GM0XxULt7qGQywBmcIEu6LJ2dqHrVh2dqQdk
 Vx7p1ysMob28iEp8v8wbSEPDK9Nm3oBEaoD8aCkjSLam1zkTvdv9mahVI8tShJ1eGbgw
 e8v4dcz6wvoEwoSyopr+DnCxlYKD3uMeDVhooJSfgKfRAdlnPp5j2Xa1TiHFmIgfSx//
 PSEfbRbKA0z2MCX0OHzemHjvpKe5qtGYfcz1U/7ute6QFURTA471yOMpd/IJPLiSmtxW
 yoU28DO+KLkDYZrOq+eoPzrF1rVIG0dcSvVyw30NTR1MrXNIgcVgIjJoY+TdO/PWjpek
 TBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769184966; x=1769789766;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Npq+Iy8IFq0PbXXHDZroCeaVa4zh+Ofswalg8x3cz/0=;
 b=WwEEKXP4/2bCCbdEG2yCZ2GJw9C+2QeNWDOrYeZT0jm64BZmW4wlJF00/7YmIKtDmE
 EEp7I64ePYa+TENbtusv8FA2Zn6+dC9hcMw8qNR6kRdtc1NwXLZmOw/+Ul4Ce5zYCyqp
 Pq/77VrTE4n3jzWOUNbaGPoXX3OiPKzFColy93yIdwy9NSP6vVf0twxqffcdZRDfzY4l
 np/Q7WUurF0NgR05Eg6jpwW/JFYwtfTKjwthThyTc6cxkBeT8OjMmzzOXIIZl4W3PWEP
 iFdcFthKeY7NCPpZNLn2L+vEf7sTp9vS7dvIVueE4Nps2d68lIYJR0SlxEqHEdvboBSN
 8LQA==
X-Gm-Message-State: AOJu0YznbXOS8i8beC24pRlrbOnyd1SVRBMT6Xv4Wle3G4QFjPXiBrtV
 H7iSBshMMXuQFVZqgjOMGMX5cChZk//k0Ueg/TpiuYZlJ1EEfGBgCqLCDR+cw/vJcso=
X-Gm-Gg: AZuq6aJ7weR+GjnXkro6cTqvEgV6eQKM6Ho3SpUD9KKLLlYSXfw0EiROCtMk9jZhPjY
 +98+NB+cweAjmoOG57dXCt3fiPb3SJBSq6fd4i6UePTogHgXBQR/wR+zZvDqwtlBmhoh6WPhtnU
 HcxZAyvAjsFToULLJgZoUr4bdAf9jXfaYqpR0IIGHuRwxpCFB1iuM/nA7s7FPXGTunNZvEhRAKd
 +R5yJbf/SRlNaqWCXLMaeu2uVL9ivZ2KSEHH8ePMIXfnA3Gk0YTtGTo+KxgXrHsoivg/VJK2TKf
 By9kTuAnmTVA1HXzgiE2tQAXxjGOI9OOQhFuIlnc9ovIfubIPZEFPprxtq7WpYY+wt8R+R55JCx
 qswoyjfTnYMRZfx6eWzzcbyuQYTwvuEVKNvti2OI2+nTL0h0llVqROwVI4DLNB+L3XZHFDZQfH7
 lYiC7y3LD4zciT
X-Received: by 2002:a05:600c:5303:b0:477:7b16:5fb1 with SMTP id
 5b1f17b1804b1-4804c94c43dmr63722645e9.7.1769184966159; 
 Fri, 23 Jan 2026 08:16:06 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48046fba46dsm150256295e9.0.2026.01.23.08.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 08:16:05 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 527D65F7B3;
 Fri, 23 Jan 2026 16:16:04 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Phil =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,  Gustavo Bueno Romero
 <gustavo.romero@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  stefanha@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH] MAINTAINERS: add co-maintainer for TCG Plugins
In-Reply-To: <20260115202511.2709767-1-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 15 Jan 2026 12:25:09 -0800")
References: <20260115202511.2709767-1-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.15; emacs 30.1
Date: Fri, 23 Jan 2026 16:16:04 +0000
Message-ID: <87wm18l2yj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> I would like to help Alex to maintain TCG Plugins. We talked about it
> and he will keep the priority for merging series, but I can occasionally
> merge some of them when there is a special interest.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Queued to for-11.0/maintainers-update, thanks.

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ddbfba9f01..d80cdfbb6e7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4039,10 +4039,10 @@ F: include/tcg/
>=20=20
>  TCG Plugins
>  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> +M: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>  T: git https://gitlab.com/stsquad/qemu plugins/next
>  R: Alexandre Iooss <erdnaxe@crans.org>
>  R: Mahmoud Mandour <ma.mandourr@gmail.com>
> -R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>  S: Maintained
>  F: docs/devel/tcg-plugins.rst
>  F: plugins/

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

