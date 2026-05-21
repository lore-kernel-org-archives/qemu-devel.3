Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F1CCD5BB1
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:14:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3Dg-0003Fe-KB; Thu, 21 May 2026 09:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ3De-0003Eu-4l
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:13:46 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wQ3Dc-0007NP-Hy
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:13:45 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-651c7ddf514so5702864d50.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779369223; cv=none;
 d=google.com; s=arc-20240605;
 b=HBzbSbDbph3hZjPQwEG37hElAvi7ILtYLYG4xjNgnszihsriEujN5WpNvOCuCwxmqO
 KFQ7nuM/ld4nv3h882NR0JwsV974dRwq30NsF7jrWW9P+I9lzH38zXns8xPWQ7jgqTaX
 jRuZ0JZiWt60l/OwDe9YQ3PYxTcReO4W1N52u8fOKcyvAj0QXVnb+jLzYIzjSF53xrvZ
 C6B8JwaDsHiIqXF7iRc42IQFwO2nk3u669deDbbZBog1YTGDhNNRhLx4c4irxkjLlHbt
 MtIBOjXaqq1I/qzT0wjE7JuqQ7ZfKp7GlXU87zIGCmWzDFLurdr9k7WI2qzj4WQGJUEu
 Ue7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=A2bf2Qa6b+aZl5QhGuVx9cLh1flJJ6/N83rTs+ubI4Q=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=WQqFMDzlqHOCiSpLckW3kjc2szizvI1W6l1ztdaxuLVecTkzshemSCiHiyFsol9u9f
 oJP7mpt3/i8u/Wq6WXkMe8boCLikZDzCBE8/snm/+3z7+j3GRFH4C5ZVUF1UN5K7TXSp
 TIreIhAweT2H6jQXQYI8YeaXWu/KvLrR9ayug550XK6KR5ip2oWjKjuhJ3JKE268qpn4
 Lr69+WOBLf6ycGFYl5EThHhZ1nSyaVeeXCo/7T6oD+Rx1RwEAE6UNFFdqiB3CUPaDby2
 qJ2xUCFWOqBElzDOji9dSIHeY+JgMIqQGbNxZWzixWmr0A4ut0SCxMxFX8oUnL5Ty0z8
 ENoA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779369223; x=1779974023; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A2bf2Qa6b+aZl5QhGuVx9cLh1flJJ6/N83rTs+ubI4Q=;
 b=tw16Lf6lM9iHDBwCtQRp2BAQ4sy2Obx8lpkB4fi0ZuEJtV4ZauOwoTmK+Id2KBqSJh
 PmNegj7ZSxgRiXqy7zNl/td0QrjI+2J79CJVxZzf3PEneL3lpIPi6KtublMK+5u6fLNk
 Pexfe4m7hdZIh6yfwrUjwKngOcv0/ATLpC0r8AMdSF5KPZhoyeuXpQSYpkAoOKd3zZ0g
 BSaihr1rAtCz6fGObHsF+wrk0gHXZzPw5URfGQG5Rhju6G/FzbXaJZUfxp9H7liu1yNJ
 SZwgs//FtyllWcbaSVv8syZHnCLB/5AmIwEk1yhCHAJccBa9mNI2+zb9Lb8cs9/l+dQn
 7RDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779369223; x=1779974023;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A2bf2Qa6b+aZl5QhGuVx9cLh1flJJ6/N83rTs+ubI4Q=;
 b=EWYwVSojIvDECi4yPqvxGAcTkH9+wW1oCHqPEwSJicnQByOhokuOWU6iZbQLYzKz8k
 S9W+yqx+hoPByRZgfPAhKA54C7/+8Zzr3s61uO7jxBslyew4lffxcHGsgbLC1MWeI9jq
 giZjZx2Rl3sGbcZn/Nod7dRAL/fqJHNzQMv9AHQXbq7EtFaBToQB6Y4hI3xhJLPKDQAL
 YV7z/GfRtFGCj474xW3iQtVKgYF/jRTo+9mByiJmDejdsoI56LcwyW7OAHkUwtkwl94B
 dGkiJpR8HlHeU2dULCn5SLTOfnnIOpLdUkcPFXoXWPmnRNqR7IUrMxPfw8WP653VheUn
 snVA==
X-Gm-Message-State: AOJu0YyTYor1Qbh2ej4GmkqjvZ+0pPhKKFgMocw4p6Cr25xHN6KVWc2a
 YFOOaJoHI1EFEN7/rQy0FGU/3CT/BawrmjqnwHK9RL1HAVYSnVZFHwjfqUWAwU6Jo2V1VvVm5fe
 v1b9dAxyD7PN73jcDpjS4cA4/yUKm4eXLjX+bTCt+Xw==
X-Gm-Gg: Acq92OGooTn+ZOWHCsszwbJkmyYAMZyUs2Do25HL8ZB3iwpSebvOJ3+RRzDLFwFyLHa
 9l875DLJRmSzr2p4CHdCBWWoZo8BZz0MzT+r5HgmbiAYDe1Z6nLX2C2PMP6m6KB9eCOwFS7fDF8
 vXzq8VF/3vDuUlOOn7fjV0HbN0ChMNUaiiPy4lYBaxy9+CQMbX8Ne8w95s8hJCG6DImGsD3tQtD
 y7hSfay7YYsfRDqubb8vwKaNrGJrDDOZ8AfWIr6xJQS2Q6uaRtympXgL80EW8qKsGVxoKVTDofd
 icSmY2RwrEsviajEHZMccu5mxgGQWncyWgC7FuIwaYVsxtFvqbXAowSHLMNP/0Csai0=
X-Received: by 2002:a05:690e:1688:b0:65e:4cea:a088 with SMTP id
 956f58d0204a3-65eae0e4aa0mr2250227d50.36.1779369223028; Thu, 21 May 2026
 06:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260520171820.848839-1-richard.henderson@linaro.org>
 <20260520171820.848839-3-richard.henderson@linaro.org>
In-Reply-To: <20260520171820.848839-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2026 14:13:31 +0100
X-Gm-Features: AVHnY4KeuglWnnjUzg4G8dK-F4re91abCB_kfx9uCAUhabP0IAr2WUP1NTuZZF4
Message-ID: <CAFEAcA_D8ssZdY-ve7px5hZ0abvivWSGeux9d_nVRn4F3E6m3w@mail.gmail.com>
Subject: Re: [PATCH v5 02/30] fpu: Reorganize partsN(muladd)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Wed, 20 May 2026 at 18:20, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Check the likely case of normal product and normal or
> zero addend first; shift NaN and infinity detection down;
> end with zero product + addend.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  fpu/softfloat-parts.c.inc | 156 +++++++++++++++++---------------------
>  1 file changed, 71 insertions(+), 85 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

