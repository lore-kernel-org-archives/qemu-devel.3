Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC9DC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 15:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s94cZ-0001S4-58; Mon, 20 May 2024 11:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s94cX-0001Re-9Z
 for qemu-devel@nongnu.org; Mon, 20 May 2024 11:08:13 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s94cV-00050v-NS
 for qemu-devel@nongnu.org; Mon, 20 May 2024 11:08:13 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56e6a1edecfso10574938a12.1
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 08:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716217690; x=1716822490; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nx6fREjBjz+KL7CHRbDoyFJoC3fJfDeTjds3bhWNztQ=;
 b=tyjBAgfSmLPdLiNNUEnJI8wvM+Q4ojOsoeuBgvCFC/nk/JLkOsb3f+zZF5oJ2iSCR1
 VzcQFvYUVKcYn36R3DIWIQPM+2YWO9JSUCmm4tzeoXN0URpGyzwNT+qI/hf/r8ra/Rn8
 DEU/AEmw4PfOm2/bZS4Uz27i4XeQ2hwLoNugbuMHHeI77UqUpX+xYhbcwyIWvKhIU2Fh
 vtZlzxdqwq19TbHcH+vG/9/5Cxz8AXzbxI/VcWhxprsFN9mvm4aVxxduXhAsWATyrJcQ
 Sj6dWq8hBD1Pkq/iU1qd+6cRxf2YB1NnVyZdRsD8vq3CXTPiOMQmzmu3wNYSHYDVhfwS
 XWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716217690; x=1716822490;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nx6fREjBjz+KL7CHRbDoyFJoC3fJfDeTjds3bhWNztQ=;
 b=d9qQm2fGM8eOssog0NZm9DNPGAHsVcGhx83rhPQshUg6yiMsXLXEJphA3XYMWVusTA
 dIkQ1P+7Qh+MXNQAE+14xw+4HB6hzn+63+D2dU9NNhjeGP6kW3XHl1LzZSzRvkWhj8rR
 S7iHHh2L17aXlSpDWuv2m391xhN3rRt3B1bfwFNHX5YTWixnmQnN08qgZoB2bJ1uxD3m
 8l7ZnaKjL0uqz+A8Xa1wBokStZRISyKLrEsnWFvUn50hf8LPRLN0Uc3Ul9MXcF+8AYK2
 PHUgEFmJBUSpkZuxu7V8EhwetmNIxzqsGE04nJ0SUrVzthW6UpCp4z2ysw5Bkq/2IovG
 98pw==
X-Gm-Message-State: AOJu0Yy4O6JMaZ53dnrQecwJlTQav+6N3WQeL1DeKfCl+tKLsCnHsZJt
 SRlWMT1bq+047f7rgvVy6bPJSvhcjtnImry7Z/+N6vE9xbEC8lx4XSO+8Ryd3hOFijJnAFQrjsu
 Zdp6ak2dRrUf2MsY/zEtfJg0NrLJgiz/iZMx2Qg==
X-Google-Smtp-Source: AGHT+IGJa8nC8mplDK21GiXSpSnTu71DD5n/ppTnnWlHcsANgjCGT3GuLtO//oxOVj1twydae6aN4X3e+XTMg4WuAo0=
X-Received: by 2002:a50:8d55:0:b0:575:2ad0:2887 with SMTP id
 4fb4d7f45d1cf-5752ad02939mr4648865a12.8.1716217690247; Mon, 20 May 2024
 08:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240513113513.640007-1-alex.bennee@linaro.org>
 <20240513113513.640007-3-alex.bennee@linaro.org>
In-Reply-To: <20240513113513.640007-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2024 16:07:59 +0100
Message-ID: <CAFEAcA_vcAYCpw7j7g9fZVQx5tG_VvEhDKQTb0xnWOERbkEGAw@mail.gmail.com>
Subject: Re: [Semihosting Tests PATCH 2/3] update includes for bare metal
 compiling
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Mon, 13 May 2024 at 12:35, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> We shouldn't use <string.h> for our own implementation. Also the base
> types we need live in <stdint.h> as <inttypes.h> doesn't exist for the
> bare metal compilers.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

