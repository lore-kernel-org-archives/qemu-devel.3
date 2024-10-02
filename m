Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02510CF6D38
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 15:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sw14F-0003f8-HB; Wed, 02 Oct 2024 11:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sw14A-0003cc-41
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 11:15:02 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sw148-0004Db-Ea
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 11:15:01 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42e5e1e6d37so62698315e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 08:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727882097; x=1728486897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F1MIQgPs+0xA8AvPQlQaLpUykGZqgvAuH2N6S+TT5O0=;
 b=YV6JfyGpL8tvxqYlNIIh+ZK51JsN90Pq04YUm/RxTat19wnrj+yX8lbuYVAUa+CtW3
 Eq4yJwXNLzhXPLwFub5oDPVcSOStIOXJCd5Dp/WHdxzsz0JbPcT1+bzHsLSHtosPOMir
 j8RxIZpuIHHrScZURFXNE9IcaGhikagNFw5Q/c8M9UZEitwwHXPQoHNixuYS2eyOiRFS
 3t+7WChWx2IHbuOzI9FtfLHypuX53von8UHv14oyx53mpnyWX+b/Ka36/IpwtOaz0cse
 rYgvCbRclFo1ufZHbzWap87gIofE9y1QwBssauKo5K/I7Sd2aTddNoDXH72d0ZlAonpD
 ZJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727882097; x=1728486897;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F1MIQgPs+0xA8AvPQlQaLpUykGZqgvAuH2N6S+TT5O0=;
 b=TnVGlY3PSHpsIWzNX32zV/dkiehZfSCnxKCGYE4HSmcqqq4gINMCAgzNPUuXubpWop
 WXmrzlWgqR8nGv8L90NA12n0ardHlEC5UWzN6rutgY/Uc9bjrZd/VqdsriER+ISwV6za
 9Od2reaqT1r1Td7RaBw93Gh3XC/VI+EdgyCNL01JHpX4KentjoGoqtWqnqIJ2Dp41kbt
 y0P6cUteCgnzzTyO6Yf0+JMdfsCIyl6ywTUI/SSNTAZP9ArAS2W34HcCtuEgUWFJ0quf
 RaGu7oN+JasGSSycySuDGbULJnSP10PSsSxCEWR/CZy1u47jWdybFoY8eJkebFxHWKkc
 lfsQ==
X-Gm-Message-State: AOJu0YxU0nY00Jopjfpk/vtIyKEhqLxj+hSVrnAx6va+47PG9Cq/QnhD
 gXsfx68/B/7AvhUYhpMYEe5ejG8q4XwAIE4NVTW943rifiu1Gxas0SXhvdD84+5JmSvQ5IgVLc1
 e
X-Google-Smtp-Source: AGHT+IHl0EmTzyRfZDY6mUGlm2Xl2Vpzo4c6NUpMyLdY8RLXIMD3KIs7mtDecLv+EgyRchUzkHCFGA==
X-Received: by 2002:a5d:69c8:0:b0:377:9867:9028 with SMTP id
 ffacd0b85a97d-37cfba0a658mr2353526f8f.44.1727882097303; 
 Wed, 02 Oct 2024 08:14:57 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd57429e5sm14092592f8f.98.2024.10.02.08.14.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2024 08:14:56 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B7A1B5F780;
 Wed,  2 Oct 2024 16:14:55 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-trivial@nongnu.org
Subject: Re: [PATCH] tests/tcg/plugins: Remove remainder of the cris target
In-Reply-To: <20241002143708.376707-1-thuth@redhat.com> (Thomas Huth's message
 of "Wed, 2 Oct 2024 16:37:08 +0200")
References: <20241002143708.376707-1-thuth@redhat.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Wed, 02 Oct 2024 16:14:55 +0100
Message-ID: <87ikuamt8w.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> The cris target has recently been removed (see commit 44e4075bf4 -
> "target/cris: Remove the deprecated CRIS target"), but apparently this
> line has been forgotten. So clean it up now.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/tcg/plugins/syscall.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
> index 89dc7f49b1..ff452178b1 100644
> --- a/tests/tcg/plugins/syscall.c
> +++ b/tests/tcg/plugins/syscall.c
> @@ -34,7 +34,6 @@ static const struct SyscallInfo arch_syscall_info[] =3D=
 {
>      { "arm", 4 },
>      { "armeb", 4 },
>      { "avr", -1 },
> -    { "cris", -1 },
>      { "hexagon", 64 },
>      { "hppa", -1 },
>      { "i386", 4 },

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

