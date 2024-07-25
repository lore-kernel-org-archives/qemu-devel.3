Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14DDC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 20:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX56Z-00074O-Br; Thu, 25 Jul 2024 16:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sX56V-00073q-Q0
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 16:30:23 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sX56U-0004Xx-0U
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 16:30:23 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2f01e9f53e3so7382151fa.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 13:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721939420; x=1722544220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8GiNrMrOXdE29zDz/EWenwdZ8aZTTPaV6uRz2wPhMT0=;
 b=EpGQ62XcWbBWGXsNSHCO0cSkvQdhnqJhW8tOHjULhSPh/UXrGDATYtoc9ewI/oQ19r
 8FLi+tf2CdTKhhiNfXuI+uelOylxbIw9HMxvhWRSXLbnGYFQRiMwytGls9PzSB498G4v
 RrORXW0Esg19XISJVwMbmbauflmFGLzs9MWuYpF9h8kBmUnTmH2l7R/ogpjgoxJSVDWp
 zzn7LVbF22fS3VPedm2O64g6ubzECvfAkb5hbWNpIPKIjdskvfLZBXB/AMdlvO8lZIgf
 YlzzR8flhoooknn0QPC7lES+NI6a42gpsSZhGYq7WYEK/vRdKJVZLiRsepMU/bZipKyq
 Pckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721939420; x=1722544220;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8GiNrMrOXdE29zDz/EWenwdZ8aZTTPaV6uRz2wPhMT0=;
 b=ni4R0EyL1HhNqvx/2j2OQcRIqI6tPZkY3uM6xOcwphj0ljeTB/tFwmI0a4L1V75hAH
 0Bs2b4jMO5agfeWM8htBBQVArFgPRZ5fIICYTwmhj5vlQKCX/n8Te2l8jC9lHj3BslAy
 6KcbTByfasPpFIAFP5EKOCyFXPAr+FQA/Q8huiMp1OVjzc1c4enjaAqD22q5yrzXUmoL
 eqNVkyZdM6LL/fGm/psoJi0jwOMbmc+XABLEHBWmC8NrlVPLA/9oJwmATUdpbVRWxaTE
 wQV9Ko5DtN7ODnWiCDB6bk4l250XeFCobHDi2dEcKHU3jJBwMrnOzDemvsO5PFBM0JRu
 ZgPw==
X-Gm-Message-State: AOJu0YyI7GJs8Hzapy2Q9gd4/juPOAcgl+5EdN8cuqtJlAwHq62oR0Tj
 58KijQZcVfMsOpD6drYNOXzHmADfoBV5VeMu8CKbUIZEfDRbGmUo3BiAT6gatcw=
X-Google-Smtp-Source: AGHT+IGic2uTnpcYVeqgS+q3/0FevwTIzQkWAToksiNSQ05N468gxgjbF8zlNNEsJs/bAuQyksPdAA==
X-Received: by 2002:a05:6512:3089:b0:52c:ddef:4eb7 with SMTP id
 2adb3069b0e04-52fd602bc31mr2728917e87.20.1721939420028; 
 Thu, 25 Jul 2024 13:30:20 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab23394sm105590166b.26.2024.07.25.13.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 13:30:19 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7AEB85F863;
 Thu, 25 Jul 2024 21:30:18 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH] contrib/plugins/cache.c: Remove redundant check of
 l2_access
In-Reply-To: <20240725164851.1930964-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 25 Jul 2024 17:48:51 +0100")
References: <20240725164851.1930964-1-peter.maydell@linaro.org>
Date: Thu, 25 Jul 2024 21:30:18 +0100
Message-ID: <87o76lmcyt.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x231.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> In append_stats_line(), we have an expression
>    l2_access ? l2_miss_rate : 0.0
> But this is inside an if (l2_access && l2_misses) { ... } block,
> so Coverity points out that the false part of the ?: is dead code.
>
> Remove the unnecessary test.
>
> Resolves: Coverity CID 1522458
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Queued to maintainer/for-9.1, thanks.

> ---
>  contrib/plugins/cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
> index c5c8ac75a9c..512ef6776b7 100644
> --- a/contrib/plugins/cache.c
> +++ b/contrib/plugins/cache.c
> @@ -558,7 +558,7 @@ static void append_stats_line(GString *line,
>                                 "  %-12" PRIu64 " %-11" PRIu64 " %10.4lf%=
%",
>                                 l2_access,
>                                 l2_misses,
> -                               l2_access ? l2_miss_rate : 0.0);
> +                               l2_miss_rate);
>      }
>=20=20
>      g_string_append(line, "\n");

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

