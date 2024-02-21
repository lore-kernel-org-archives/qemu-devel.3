Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D441C5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcqiN-0000wm-VD; Wed, 21 Feb 2024 12:49:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcqiM-0000wU-OE
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:49:02 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rcqiK-00057l-ME
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:49:02 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33d118a181fso3654763f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 09:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708537739; x=1709142539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fBRt+Dcap8Nv9e9jWElvC4/9r+A10VMN88gU2Cxi6Lo=;
 b=PD/rJc8VbQUuZgKOgBL/NGN0+74kuYXwvgoRWZ9lGDhISN1AM7A7eL+EbNeVnZAnb/
 8aEDkO9eaIQVTUtZzS5IDB984pPKjSP6M/u4pb+ZnR2zTd75NnwXHm45y5GfNMYg+osb
 zURIaavahXW9dQ+L4nCNZx14HUbR9XX7WsTRKssWqX9mWm9z6+2NZ1D8u0QkAzY8B+8z
 8T6T3VJ8HaTRaRwTJ2cXpEws4WXpAkDSG2jK+PyFKMkRg3165wB7Y+DdViqRQOp216Ab
 NWX2RkVtYZiOrUaQ8maRlftlOGr9k47O6CkbfVAgRC3jFIa0HB2dalXTnBnJOBMJUHBe
 CCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708537739; x=1709142539;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fBRt+Dcap8Nv9e9jWElvC4/9r+A10VMN88gU2Cxi6Lo=;
 b=CyIQnVsnVmk0oMMShWlSZPw1uw6Blu1wN+ptj4UxFRoxilfGHgazPSdXXnQBk8JZbb
 WJdr5uCKmDCQpIfV9hF0CMwDaVeLkFL/WHlPRiB8+qZQS6CsNh5eCHsHEue7/tNS8bn9
 3pXsN2gKrZL77XA/+p6yb5sd8/QXoM7wXf7e9lwCsppM0BE8uNCAcvpNwmoWAyNQD0Z5
 A2DB0x7DsG1nMtoYpGivHSFyHEJwSDK58KlBPAz/PQQE+N1H0UPi5g5aiVHvRzFbO/xx
 TDqZW4BF4v7vVzhhi1EsBc9U+VB+F8ONHjC7sc2Zd69RiCxs+1rhm5PnDa/DzU7hD1Jx
 hYyA==
X-Gm-Message-State: AOJu0Yy5o1ELKZHDNt1C/Us+QdEY5flV/0Ro/1Ow4us27aW3LAMsDCj6
 cnkj2uHEjlHgj+3VuQaBkfyOat5qoPJ5NkaXW0WEz+UM1OSIxXszbwQY5EuiKKM=
X-Google-Smtp-Source: AGHT+IFTxmY8+vThDn5wZw8+XsfwNngSf+ojPtP5+U3tZzTB2tatqnK/vaR8yqZuRVeji2CycWM3lQ==
X-Received: by 2002:a5d:544c:0:b0:33d:64a3:9bc8 with SMTP id
 w12-20020a5d544c000000b0033d64a39bc8mr4256141wrv.45.1708537738756; 
 Wed, 21 Feb 2024 09:48:58 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bt27-20020a056000081b00b0033d1b653e4csm18404128wrb.54.2024.02.21.09.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 09:48:58 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 067455F875;
 Wed, 21 Feb 2024 17:48:58 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Tianlan Zhou <bobby825@126.com>
Cc: qemu-devel@nongnu.org,  qemu-trivial@nongnu.org
Subject: Re: [PATCH] docs/system: Fix key for input grab
In-Reply-To: <20240221131900.2041-1-bobby825@126.com> (Tianlan Zhou's message
 of "Wed, 21 Feb 2024 21:19:01 +0800")
References: <20240221131900.2041-1-bobby825@126.com>
User-Agent: mu4e 1.11.28; emacs 29.1
Date: Wed, 21 Feb 2024 17:48:57 +0000
Message-ID: <87ttm1aet2.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Tianlan Zhou <bobby825@126.com> writes:

> Key for input grab should be Ctrl-Alt-g, not just Ctrl-Alt.
>
> Signed-off-by: Tianlan Zhou <bobby825@126.com>
> ---
>
> v1:
> - Initial patch
>
> ---
>  docs/system/keys.rst.inc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docs/system/keys.rst.inc b/docs/system/keys.rst.inc
> index 2e2c97aa23..59966a3fe7 100644
> --- a/docs/system/keys.rst.inc
> +++ b/docs/system/keys.rst.inc
> @@ -29,7 +29,7 @@ Ctrl-Alt-n
>     *3*
>        Serial port
>=20=20
> -Ctrl-Alt
> +Ctrl-Alt-g
>     Toggle mouse and keyboard grab.

I think this is correct although I notice we also echo this advice in
the vl help text:

#include "qemu-options.def"

    printf("\nDuring emulation, the following keys are useful:\n"
           "ctrl-alt-f      toggle full screen\n"
           "ctrl-alt-n      switch to virtual console 'n'\n"
           "ctrl-alt        toggle mouse and keyboard grab\n"
           "\n"
           "When using -nographic, press 'ctrl-a h' to get some help.\n"
           "\n"
           QEMU_HELP_BOTTOM "\n");

    exit(exitcode);


>=20=20
>  In the virtual consoles, you can use Ctrl-Up, Ctrl-Down, Ctrl-PageUp and

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

