Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5409C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 10:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYO5j-00082D-3H; Fri, 09 Feb 2024 05:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYO5h-00081f-4l
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:26:41 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rYO5e-0001tj-Mn
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:26:40 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5602500d1a6so1134866a12.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707474397; x=1708079197; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7fltGwyUK5wMtjlAlmQDNf/qDg8RvuA45GqUl9uSqy0=;
 b=AN8Cz4HNKrFnirBOqObjdXQAnliTXNbmMlIYHFdQQRqe/Qo5U6TLwgJ19cNnufSt+F
 prgI3lO+hI3tl9SVjV9VOV6SXOKSQBr0D4Z820u2XHGinEq1l6XH68HeBJ5YBB++qMLB
 RNzlD5cuDzv7QG5MSwYyuLhgj02JXOUg8+pDMJyGrxKzG3PszG8qo3PktX/uW4SV8nYu
 EUF6yLLs1v8fWFbipAuVAxFxsfi6vKLPsCVv8QAsBn+b5jBn2YMQJM1WMlEoaZGqt1ZI
 +vwih3crEiLdyoRUo4a5BrX1KbW3NRFzdOgCIyeNPWVUUsJevxy05mrcyny26r7FTq/e
 IKDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707474397; x=1708079197;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7fltGwyUK5wMtjlAlmQDNf/qDg8RvuA45GqUl9uSqy0=;
 b=PUrmrYcxjhjlTVkDqoW8PSgKawBUnR6W+xm7B/PCE/A9RPdieYiSi+Q/+yn0zqx63i
 ZnXjC5wkkub7OXVkkUbfR1JJkgWiMHlTtwMrWIfshPfSyUzYNugti31/ETM7me9LP6+2
 NYnPIfqDAKvqYVj51oQZuheiW6HkPMGbeis3AC2WL1xYTK9Lx0qrL+mh0kTi7m3goQKS
 wpx1AKt5IXe+O06pSLqBgGfO2mvoyYW9f8/Sk7FSS8wPTuOJ++GnH4azRdBtRKqxxreX
 2K3+6w1+tah5HxiXvDYSA1H+FDhXYwVTkIosw14vfq5X/RI6Z/eQo53TafilEqTkdYTk
 NOaQ==
X-Gm-Message-State: AOJu0Yw5zoAFOuoUACdL9npk+yydqLt9IDCbB9AdQmm17pr28fXaIbSa
 lqjaiRoYjf4oQqaS9f5nDoJ84lYiK82Mc+G/YW4d2WV5ZxtTBRwmwEzhN/HJGQY9qsqdbCzexoo
 LWmuEO6bkOUlm3k5I2emEgs4AELDNLryq9nDSH5UXtFtp9r6d
X-Google-Smtp-Source: AGHT+IH5FvQ9dBxycB0m9tGd4IRsIyVGpQLclh4xu+5nrUVi1hAzIfvRS8XDe6BhI0qqInB6+5Zejes8gr3y5cZC5O4=
X-Received: by 2002:a05:6402:784:b0:561:1255:6237 with SMTP id
 d4-20020a056402078400b0056112556237mr933557edy.30.1707474396760; Fri, 09 Feb
 2024 02:26:36 -0800 (PST)
MIME-Version: 1.0
References: <20240209000505.B07D04E6049@zero.eik.bme.hu>
In-Reply-To: <20240209000505.B07D04E6049@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Feb 2024 10:26:25 +0000
Message-ID: <CAFEAcA-YGPjYWwRgG8wb4m5EsA44M5X0wmeC+mhNTwkOa+3=qw@mail.gmail.com>
Subject: Re: [PATCH] system: Move memory_ldst.c.inc to system
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 9 Feb 2024 at 00:06, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> This file is only used by system/physmem.c so move them together.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  memory_ldst.c.inc => system/memory_ldst.c.inc | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename memory_ldst.c.inc => system/memory_ldst.c.inc (100%)
>
> diff --git a/memory_ldst.c.inc b/system/memory_ldst.c.inc
> similarity index 100%
> rename from memory_ldst.c.inc
> rename to system/memory_ldst.c.inc
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

