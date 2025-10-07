Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FC4CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 10:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v64hr-0004gz-EB; Tue, 07 Oct 2025 06:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v64hq-0004gT-0v
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 06:14:06 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v64ho-0005iH-Ku
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 06:14:05 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-633b45fad1aso6447973d50.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 03:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759832043; x=1760436843; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Lmw9oNqH+XtpMGrI4OCMpc+B/lFVCaHifFsmGCJU15k=;
 b=nul+6O3b77HOLnnxaarZgf0teDXk0GeWaRhhk09GMsljb5/YXdiGEevp8ztVT8J3Du
 x22VfQPAaO9qOkJKEmskNctwzLp4KcOvpJiVO3OUB7VIG1zsZxkvFOkDOwf/vU0dG4sI
 TKPF40kHOvkM6LheF7bqnFijFm24z5RtBOfSfdHM4r2p/ZhLb8GK01OKQ3tN/DZ9GnoU
 YAbNqZqEOa46oR9nYsJj8jBvCT2UZaxbYHbghL9Mhmk0p4il5SWLsal/Nj0pDbV8BdRi
 pwY1+9mmSQ52pyuaEDhMn4WF1WVh94rx7329ATJGEdMUAGDajhqU6XFooHDIue354yqI
 ry4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759832043; x=1760436843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lmw9oNqH+XtpMGrI4OCMpc+B/lFVCaHifFsmGCJU15k=;
 b=CMFqRvzl8ScNJByu29tO6AxruQP44o2e3+bAIYxt4T1Ytgg18mcksOrWQ1wIPWrCNa
 bGS9VHe5SCsKFuZVGfREFxwDXC87d2tkgmzg/2jXFrJT67I06mm1ltrE57t/32I7X/q2
 CPe5wYsB196jFWFjhKCmA9tjsvpZrlfC7uv8qEeZUFyXM/b7Gy7CFNI5gkXTDwrQ/aO6
 FTQyv/wYYUtcHSHuyFqnyl8DQxVh2S4tVvSw61EVte0os/7kVi5NErFlqMWcG/40lAlW
 cB5FsYZJ6q56AmxrdZBIYu9UF/j/EyEZcfHdHdhCOVrqNUw3Y2IbOFaBWuxUwOvVokcp
 tGIw==
X-Gm-Message-State: AOJu0YwrCHUO/Aq9ql1uKH8ndK2E2Mib0lZi8EhTgt8AMcRPndgk3PXm
 Uv+rt+d++mvrg5r4AzwO7QaahdumEAUfDiWpMYJK5MHnQEahqgqGI3Lt/zPhyqOIjJ3PhMVjOBd
 HKZGQiOoZWGdGVA5Fb05U+LZWe+DlrV4qTmZE2czCpC6q469g6X6w
X-Gm-Gg: ASbGncud1mgc+5oI9GFP3bvdhamdMUIjVyNTaZPvvSqDanc0XO00cxdywNkV9Fecncp
 0VZYWS8G4OAUyng4PPMV/sAeX+026PD0l0Dlg5HtdCBtEKcsH/FKIj8dwNrfDcK4p3lvr/L0Drg
 lKB9jWrPwHgIkW9KQcDAt2f8tQcY553sGa04uw2d5di7s8Vuda877nH1YNvKjAjyqDMs/83J2RO
 dl5KYt/bn/6vmMfLN3VTamansWIQMbngA7H
X-Google-Smtp-Source: AGHT+IHQjobAFVtUBcS2WNHFU5GOZNtwpOrIOuq68I3wExZ8bKpbjVVqsWNvyoMLjRARpNrZ/m+V8Inx4JOuey/yVAI=
X-Received: by 2002:a53:d98a:0:b0:636:f1d:e26 with SMTP id
 956f58d0204a3-63b9a0e2b15mr10264697d50.32.1759832043015; 
 Tue, 07 Oct 2025 03:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <20251003170800.997167-1-richard.henderson@linaro.org>
 <20251003170800.997167-40-richard.henderson@linaro.org>
In-Reply-To: <20251003170800.997167-40-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Oct 2025 11:13:51 +0100
X-Gm-Features: AS18NWAXsHIiaMRhNi-XBWjB7ZF_LIqjhVPVju-BIS3tPtAa6YlhRo-xENwVEHU
Message-ID: <CAFEAcA_=eh9WAFBwRbwLOCWfjZQbzPRsSeavXte9ZfJXB1mJyg@mail.gmail.com>
Subject: Re: [PATCH v6 39/73] target/arm: Use arm_hcr_el2_nvx_eff in access_nv1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Fri, 3 Oct 2025 at 18:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

