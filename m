Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37C9CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 09:24:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd2mQ-000154-DG; Fri, 26 Jun 2026 05:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd2mN-000148-TY
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 05:23:19 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd2mJ-0006So-Le
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 05:23:19 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-66481f17a4cso764523d50.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 02:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782465776; cv=none;
 d=google.com; s=arc-20260327;
 b=ReE+c2W33et5bRqYwSVatIcCcZ9BiaJuNwGE9XxilIXgtmnyYvJYOmmJQSNwA/tUJZ
 iSECkyC00xnFeslQIqf3M5GQ50UZbbmE42TiWMZCHirpyYDlKx4TCNGArm/A1AoeQg0b
 lYIq/k08januxToE7oU3CPipaqpldElDHSmHz9O58Ze6aypZB8n+ILPWiTwht6J47bkd
 TtvglgHxC1UANd15TDM46st4ZFcWx4ylkr7BnLFCFbMVUoRlY2xomHH3oDV+InTKyciG
 0G4zqrHGIINWmLJ/WYvXn9vYHh/qAZnXoN9mkV+ExpZdWUYCRTU0spL0x/vDjK0TJ6Kk
 d7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9tLL+7ob/JynzaazS6VpHSTWl1dz7nv1yrlIIWQlAJ4=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=LJ+tNoQtR5a0YHQ5QTvMltskLyX8cLo00F1icujyHeP01yNC9NCrEHX3SWVLCEWnFb
 7lw7ZRaRWgUenx6VT3bU5yUqpY41upCgRbLADGv5xdz3TkAHfs7WRxX4ssqLn2leR2xa
 XfL7mtTvjCggJFRNv/egBli7M7j9jSx7xlaZnoyNjy80e1hQnftAlcw/y0IQlXEH/63w
 rrcMVULkWmo2fNKqnxEbU/akxgxTEaYMwQ1Uz3NcUUPEVGgull5eKGp2ultgINxU0JYe
 Fs/XrdBvl+S0YmkqVBe/tOuAEc4fnOoKC63PYAZBGgroCymBnvkN8ZVZ6TW0Xrc3SqWy
 6T0A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782465776; x=1783070576; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9tLL+7ob/JynzaazS6VpHSTWl1dz7nv1yrlIIWQlAJ4=;
 b=BlgepWeouCvJIc3GFSO6LMaKzuVziVfIdM47QO5mXOCrwsyCRWsJlH70H5DNLXfq5Q
 KMWsDEw/SsBczqj5pD7+2gf+UQERIFW12GJy8eW1Q6MMIr9EKbUFOZNkh4qm8NvRZg0k
 YxvMzrAIQa9z9LwnbnSNTjbBlUDr4xyWFyO5tpqQPuMc2rjEuPzmS7kWi9JNa4d+dcG5
 cjBk7DFG1BalmxJs+qOfq4KQOSgv5LrGP/rloVW/DK6dG8V4OAQkqhrwMJQ8yHcaJKFR
 Axrp2U4SLjWuTICQfvoDELd1laJSrdbS6QSIwfQ18NFR+8G3VCjFCkCKtFh7vNjH5RMQ
 tW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782465776; x=1783070576;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tLL+7ob/JynzaazS6VpHSTWl1dz7nv1yrlIIWQlAJ4=;
 b=csY132DAIQsXQL/JDP7d15RMgyC7zOrV6h7h8ltrcNY6IZGee4f++qqx27iY/5y4y8
 eNrWCoFCOl2hnPVEllqQIRkvmqEfJEzkkcuY9xaWrIg4qNVhellznfYFTmF260MpH7+R
 0EQfQd0e3JxD0MfiirC3YHyxkVfOHB/vyi6+r8UNpQRZbprwTBGQ8fvkbNkrQc0dh5el
 MWeash1UGYpy8ZM1dVAlAvUSLcay8+AxkbAtffl0eQk01GdldQoaAk1uZrahb3QRS1Np
 eZu6sXbl4vxcJuoy1h47TAln5s2+/hwO0PYJL37TBGwtpjMbvjrrlRyTwT6/NOhOF9BP
 7UnQ==
X-Gm-Message-State: AOJu0Yyp93JzBGF40S9Nrq6TJPe5qE538av2JHrCHbTY9lbXDXTVPqQV
 Zlwjpo0VUgDqx/oxwnTFlXVD3hpPlm9lyYe/lhvzu7kdiLncpiDuHQTEf6MBMJqf3k8OiyPr4dU
 Qumq3Wx/IdgrD3wR1IcBrDnm7I0G3xWrRyxR32nIuFA==
X-Gm-Gg: AfdE7cn70P1LUOZry7X4QAcWK2IWZwXvXx8wvuWlLMSUBEwZE0SDFuI/sx/TZg7RzHP
 vekxbJwlGrr2sS2eIxFOm6dtMVbZlzpP9NCNSVGKUsuiDbh61zaW07suL6T6B3Y7d+8XEQlouPJ
 wmXl0pfY27fmORbGooV9KK0TPNnDqQHzHgk0Gku/uJH1d0IypDtumQH/uJDfEOfgDDxUbUtVTTf
 NXsUAQ8Q0MjgZAva65w6uNlPWYXVUexwKcb4HsS2AOwFD/N4B1yUIMqMaFmAEUYHk2UQDej3YIT
 iC+Zp3PKURf3a7WL6890ZzlZSCy8e8+Y/UbYSa1BQC5dYADQOyz6EBq+tu1nS9YnUrI=
X-Received: by 2002:a53:ac8e:0:b0:662:c6f9:946b with SMTP id
 956f58d0204a3-663556cd2fcmr11967703d50.35.1782465775575; Fri, 26 Jun 2026
 02:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260625015159.719300-1-richard.henderson@linaro.org>
 <20260625015159.719300-8-richard.henderson@linaro.org>
In-Reply-To: <20260625015159.719300-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 10:22:42 +0100
X-Gm-Features: AVVi8Cel5PaYX8UaCIQqlH3RY5N2a4-ISyzVFZaRRezfPQopaVrNFCZ29WJnSSI
Message-ID: <CAFEAcA_iMcGA57sYvAToG_gaW1jFoi81z22EHcQvjj_v+bYWYA@mail.gmail.com>
Subject: Re: [PATCH 07/10] target/arm: Implement FMOPA (widening, 2-way, FP8
 to FP16)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Thu, 25 Jun 2026 at 02:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

