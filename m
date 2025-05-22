Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD32FC54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 15:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI81p-0005V8-N9; Thu, 22 May 2025 11:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uI81d-0005TX-PM
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:40:05 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uI81a-0002vU-Qp
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:40:05 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-601d10de7e1so7800221a12.1
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 08:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747928400; x=1748533200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ot8JENurp6e7aO2NzX5cehLZR9sNFK64U95hYjOdV6U=;
 b=WlXffOqugWMNbwwTou2KUjXc4d+fvsN6j5lEcZZzfaDFiI/nt78eU3Gyw/jW65DxFI
 x0oUZ4+U2OTmgno5Vz2ujddSmO77nPOsiLB9xGDvNkt60g+V0Oplr7Ih0US4CWlTHoSX
 pCVQeTaH4fXg8f/eT7775x0HVVASMZb4rfgSQS0ryduS/Bs/5K94dcRN27wYFisXJqYa
 EST+AjUwEX7CjfnNnP6VKrXdUlg6KV8oEZsqGtWS7Re0zJMRgyHBRAwlmq910Lh4fswv
 xlI3isNuHUfG/8am3wfa7Y3fSgrvlaWDl72PnvLfYydUvLEm13OkUoh4YrqJrMfUMG44
 XV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747928400; x=1748533200;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ot8JENurp6e7aO2NzX5cehLZR9sNFK64U95hYjOdV6U=;
 b=MLVOXVnEYd/+B2obhlXNTBg3bVicV7GeD+iTMfnKZQPUixEJATLUtC5Biou0yPTTg6
 Ai5ZVazBYnyIN1s45zVl6s59HAhiwQ0SFMXMmBYfeUx1U4bSRm8s1CCFc3IHH78qioDT
 A9xTpyk/VIyHGrqL2L+sRk0pYnn1oGbbxQLa0WU9b2ETP0UbX9od4NZJ5SNIy4ZHJzQp
 UVVU8E9bmC7Uqm91kCz3ZpQm26nbXfBqXjdJJIZ5TF5T7zq0cshifaM5/2/TIPr8oVN1
 7+xojOglQz+BnuIeRvqMzxdrCApEuPNXByLBgrU3nY+huShU8/F9P7loYyDcGZITCiDP
 eZEw==
X-Gm-Message-State: AOJu0YwKiF5fkS+hESCAG9gfmX2sKDBspNx/p+Q3Ja7anuB3aI2hPY5s
 FOwnerAFSwVIl/13jiCKjozLkUzlWawLTRvA2FPYdV1DjJJLhvVbEqpEDa95O4fE/U4=
X-Gm-Gg: ASbGncvDnvfwTALrbTctUKJV1D0IWxHqjSAJnyTyB3ZM7MQC7+ucCqFG0zNjIRkc4J8
 sNh8qHITvuZ+auJvMfiBV0bZr2PE5ZApp4aHh/HSPiKF7pua7nvCV3AE7CSZTR/izRr0nF+5a6T
 hidFQiLOqEeULtopc51VnVJIv9qXVdlvhZP7ohjzBnrZQj28Iq9bLP4vS9V0klnGJxid9Jnx7aH
 dkvYeMKgvRwDJaOV9IRKOT9BzwiqYq1rm/JI9grefzPRNnFEGW8pKpkAjuAYFrivYPXC3IOJFwO
 M/5c+t21wp7FGBr3yREfzbreivyDuoGLZRpnWxNTPauF5T62ImiT
X-Google-Smtp-Source: AGHT+IFqIFgqDn4Za3TOSx2QnqAfbnOjugpBhv9tC9qUZrDGyR9sAC8X2EoBFd61DKShWLPqF0dK4A==
X-Received: by 2002:a05:6402:26c9:b0:5ec:cbf8:ab28 with SMTP id
 4fb4d7f45d1cf-6011411a904mr22891545a12.22.1747928400192; 
 Thu, 22 May 2025 08:40:00 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6005ac33a98sm10824421a12.49.2025.05.22.08.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 08:39:59 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 76E645F7D1;
 Thu, 22 May 2025 16:39:58 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Rowan Hart <rowanbhart@gmail.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Eduardo Habkost <eduardo@habkost.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 2/8] Add register write API
In-Reply-To: <20250521094333.4075796-3-rowanbhart@gmail.com> (Rowan Hart's
 message of "Wed, 21 May 2025 02:43:26 -0700")
References: <20250521094333.4075796-1-rowanbhart@gmail.com>
 <20250521094333.4075796-3-rowanbhart@gmail.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Thu, 22 May 2025 16:39:58 +0100
Message-ID: <874ixcwt69.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

Rowan Hart <rowanbhart@gmail.com> writes:

> From: novafacing <rowanbhart@gmail.com>
>
> Signed-off-by: novafacing <rowanbhart@gmail.com>
> Signed-off-by: Rowan Hart <rowanbhart@gmail.com>
> ---
>  include/qemu/qemu-plugin.h | 57 +++++++++++++++++++++++++-------------
>  plugins/api.c              | 26 ++++++++++++-----
>  2 files changed, 56 insertions(+), 27 deletions(-)
>
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 3a850aa216..68c8632fd7 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -254,9 +254,6 @@ typedef struct {
>   * @QEMU_PLUGIN_CB_NO_REGS: callback does not access the CPU's regs
>   * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
>   * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
> - *
> - * Note: currently QEMU_PLUGIN_CB_RW_REGS is unused, plugins cannot chan=
ge
> - * system register state.

I would expect us to:

 a) handle the QEMU_PLUGIN_CB_RW_REGS
 b) try and enforce we are only being called from such callbacks

Otherwise TCG won't know to restore register state from what has been
written to.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

