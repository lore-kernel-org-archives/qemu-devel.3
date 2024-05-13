Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF081C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 12:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6UuY-0006Sv-Vh; Mon, 13 May 2024 08:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6UuX-0006SU-QT
 for qemu-devel@nongnu.org; Mon, 13 May 2024 08:36:09 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s6UuV-00054Z-Kl
 for qemu-devel@nongnu.org; Mon, 13 May 2024 08:36:09 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-51f3a49ff7dso5623424e87.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 05:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715603766; x=1716208566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kDeqcSWLmBNVGHQ6wU60jHVGTMOs2+iW8Wk5yin0P5c=;
 b=LtEcWmqE0hBamkDrPdyNV2wUdjCaC4WIWmV/fXfDhwqhYtyFrSoy3Qc5OdrspqcX6m
 p00aXfzomT3qdyDDSCDxWrKxjVEultDdFQqQw7KnBtWV3wknqKS1/4fyknO+AlL34RfD
 ggZSxyqdXxwaCd/9QwDG9dOajCmNg8OYQfBf411imhlDdrxMQr1jg0D6EQFK7bVgsb7d
 yx45oDWc4oBM79yNk8TO7FIqqOgzpG5wcdWUcni6Ji5AUBk3TV42DSJJzh6UY18zAJh5
 7aQZ7Gp67z0+2VaYx3GhPz+o8GPpDXdv9rCUxeKYJ+pShi6kd2Z3qRynjNBDrXg0hgWy
 nfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715603766; x=1716208566;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kDeqcSWLmBNVGHQ6wU60jHVGTMOs2+iW8Wk5yin0P5c=;
 b=dlTXnTGMWRfXO5SywQ8fZV1JjjySMcCFUs9I5Fuou5MRsz1Hs/OS9VqnHYFsWgVqg+
 4PV5eB6qVnktkGIfbsptlyt9SNPwuSMgiOzhn5Ad/c/Ld2/Dr8z8UFdNWIhHcx/lmCGR
 D6hezHsjBDQ4kQ/ILlrva7XNUJcNPX43erdjPuTF9njI+pnnGyeh1jQY3G3nJViB+zf3
 xua6P+RiAoH1oTxmpaWFj8IST6GLIehcueZepONSbMLLloQQVFxLo4ZAER1kux/UBAK/
 ahIl5iEU9BOeH5Dw8i1MQ6ScxFCxyDIeQ/xVtItjb0dNQnz84Z17/wRoqOpHEFVfTM0+
 hiZg==
X-Gm-Message-State: AOJu0YxTVjhLFpUc4Qxc/EchuMNnukNxgBXWwpwtkzQvR9RS/8MqV8z+
 tYhDcW4S57CzpL/cdC0pDEDQ6S7mvxT0Z7Aqu458V4mDRGARA6N8D63GlHnjhNE=
X-Google-Smtp-Source: AGHT+IFgU25YXlMUAMjT2n/W0l+Y+5doOfdmdoeFjmyQqpvFDTxY6r4nRJSS+qYdW5ZjE8vOak6OaQ==
X-Received: by 2002:a19:f601:0:b0:522:b1f:24c1 with SMTP id
 2adb3069b0e04-5220fc7dd36mr5438306e87.19.1715603765649; 
 Mon, 13 May 2024 05:36:05 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733c2c7dafsm6120224a12.65.2024.05.13.05.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 05:36:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B55945F8B5;
 Mon, 13 May 2024 13:36:04 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [Semihosting Tests PATCH 3/3] add SYS_GET_CMDLINE test
In-Reply-To: <20240513113513.640007-4-alex.bennee@linaro.org> ("Alex
 =?utf-8?Q?Benn=C3=A9e=22's?=
 message of "Mon, 13 May 2024 12:35:13 +0100")
References: <20240513113513.640007-1-alex.bennee@linaro.org>
 <20240513113513.640007-4-alex.bennee@linaro.org>
Date: Mon, 13 May 2024 13:36:04 +0100
Message-ID: <87cypprirv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x133.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> We actually had the stubs to implement this. The main pain is getting
> the binary name into the program so we can validate the result.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  Makefile   | 22 +++++++++++-----------
>  usertest.c | 24 ++++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 11 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 59fd831..f77665f 100644
> --- a/Makefile
> +++ b/Makefile
<snip>
> --- a/usertest.c
> +++ b/usertest.c
> @@ -315,6 +315,26 @@ static int test_feature_detect(void)
>      return 0;
>  }
>=20=20
> +static int test_cmdline(void)
> +{
> +    char cmdline[256];
> +    int actual;
> +    const char *s, *c;
> +
> +    if (semi_get_cmdline(&cmdline[0], sizeof(cmdline), &actual)) {
> +        semi_write0("FAIL could recover command line\n");
> +        return 1;
> +    }
> +
> +    if (strcmp(&cmdline[0], BINARY_NAME) !=3D 0) {
> +        semi_write0("FAIL unexpected command line:");
> +        semi_write0(&cmdline[0]);

oops need an error leg here.

> +    }
> +
> +    semi_write0("PASS command line test\n");
> +    return 0;
> +}
> +
>  int main(void)
>  {
>      void *bufp;
> @@ -366,6 +386,10 @@ int main(void)
>          return 1;
>      }
>=20=20
> +    if (test_cmdline()) {
> +        return 1;
> +    }
> +
>      semi_write0("ALL TESTS PASSED\n");
>=20=20
>      /* If we have EXIT_EXTENDED then use it */

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

