Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB10CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZSg3-0001qV-9Z; Tue, 16 Jun 2026 08:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZSg1-0001o0-Di
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:13:57 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZSfz-0007O3-Uz
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 08:13:57 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-660323f7b27so4249326d50.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 05:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781612034; cv=none;
 d=google.com; s=arc-20240605;
 b=kRXcTqDkJFQ+/optOPBfCo4hjIKa1TAtJIa278xCrHKFRYzWAQHTrYJt1kw20hmg/V
 /G+CHtarlqJHh5Y+YtzlPR1dytiyM33tKF94RGWwQW1XD3DMhoOq6McyTsP4u4sV6GAp
 U617qD9dWRflQO81vlFfiIzPFkRX4ABAj0WOpiKCXILNifZskXf41KJoJhXtt7tln4YB
 YyfqQwrC5D51/DX2sC0smBL7G+/k5rtrzSg4F5ojTCxci+11WsoDbMA8Er9vPYRjbIqY
 zeeKFzOYspPQq3gElSOuEL/8uWibMOTyNz/2WrOrYdo9ijMkrM4gSxnlK57FKNhLkWzD
 50/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=i80NjTv+gOcqKRAtL544hW65gkOooUdnIBR/5KAeDyo=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=WZsTDQaCzTIFUXPqQW/4hALkowaRQGvuNAWiGkgHYifwLmc6XzBSCkjE3Tu4k4ATtZ
 nOHZLsANAiZODoMs1qR5w8f+gjbegULr8uYlFUbbrZS8miEIui+aKSup5Kx2Zgk8tRle
 yzbLF7hjZeHPpfmyMmL8lktpuZw3HeOwIWudSM5yFbqNbvokc4Kc8+BwA9yb9J/Jprtg
 CaL+y/4YDNS9pFhHBhlz/tN/LU00IFYLWb2/ILA4y1DGJqRMBc9FHUBJIar7AV8JJFCJ
 UXsadp9hB0IQ994Ffh5BFdL/b2Nkeiq/M9aOf7qfV6GM6qjpXxSyCu7I0vMsTVZ0nJX4
 RIoQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781612034; x=1782216834; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i80NjTv+gOcqKRAtL544hW65gkOooUdnIBR/5KAeDyo=;
 b=LKV4TtudMzuflgUYVMgsnEwQFvAcKcOGVaJuCFZEiXnu44R2kFPOvi1glkU/+j2sBW
 cJVVp5IFReVsgzbEQFunrsvfigvBzCaa6+3qZa3VbAGpZOo3O4jgPE16/7lYVZ/I3+m0
 AKoTuqN/XSa1MqBo0OUBrIiwxwoELxphEyxt4cklFY7XT9IdLh+seRPVf+ztdTYbKU2M
 z9Y+Eky/jPenMWOzLyTsLWthu91s+8F4wQNiAJlRULH2MYA3DaK7d6qt3/OIt/WJwGR0
 Bx+0Ia8eQVZNzu9jHuk/TApPhakLspzJj2D1+G8q+iSLcB6HYtYHWR/w7QeoNuTsDjdR
 fPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781612034; x=1782216834;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i80NjTv+gOcqKRAtL544hW65gkOooUdnIBR/5KAeDyo=;
 b=DWDxVfLWQwOt0EK/NDuqp6FqBRBvaJp/yrXEKLFhZSZ/kyj774yjcuzuy19oFW87KR
 T1J783nEBAE//OHPrKrGi2WvYUFEtUI/3kVezBRbcRq5DPu7/nQZdagasLyBjHJQe+cQ
 0worTONOw4z1472uEhxPuBhRxMhN8OAANnh0Y5/n+H6k+sae7p/gpsXXp4QtCjnJU404
 X11PO4K2bqFNf26AsWeolYQfqBsNbSy4zk7QZ/g0fJ2aYqrwarUyERPe87EyvBAKQ8gz
 gCBj2OTe3X9l+Gp0HfkkkHTD++0JfbNYS5cqmgDtBBWxntAb2K7HEt8UVJOt9qCwGTMB
 wQ+g==
X-Gm-Message-State: AOJu0Yyt8yoGw7rT4j4JPPBVg8vFZ/hGIHarFhTp+3Aq9y0gB7pSxK52
 KMAJwzGYccFaFWPcMCXAVfKtxuG6wW+0FfHdxOJ87Xuxf36b86bzAx3YQkFC5IKiyB69YYu9KjX
 dSTCLe/kcpBOM8M5RrU1EERilJTeE4gEbwuSBUuUQ0g==
X-Gm-Gg: Acq92OGp3aqKt+DlOH2fwTEz+tm1JsAWiOByPiPxyOTdmmiNjwRFWmceEExDq2GJS2+
 Bg9IW0fYWr+UCTaKjQm2Z0fkP+A8C9aUORrmbgurcZ22FxkxKuR73DjPLzM6gDdorMcFMWBt+n3
 9Bmvkf/O9yehOITGvVu7LfIBDl7nVMtjBWafv+f1K9tB1E1VecCK6G/y66gTicClT/3jXVdusrm
 oHD9kLXFKD6O8C9qdHQM6klqEUfm/1lQMVbtbYAIUaYi719UREAI69tx743NF3kqULBCXXKoUYt
 7rwXYmcQnzs4eHxN2NqIxp3VwqUGAXeLvn4mTuE3cdrq8TXPdXE4G93wRkcXyTyBcis=
X-Received: by 2002:a05:690e:4145:b0:660:ec14:ef87 with SMTP id
 956f58d0204a3-6628500a306mr12712040d50.34.1781612034578; Tue, 16 Jun 2026
 05:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260604234852.573178-1-richard.henderson@linaro.org>
 <20260604234852.573178-2-richard.henderson@linaro.org>
In-Reply-To: <20260604234852.573178-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2026 13:13:43 +0100
X-Gm-Features: AVVi8Celhm_5i3htRegQ-w_ztro-X9hId-aOVK1VSHnnGUjNzIjSK4jcc5KSOS4
Message-ID: <CAFEAcA8_+K-PZh_d31MKh17MWMF9TXkoS6c6EC2pLMqhWQidCw@mail.gmail.com>
Subject: Re: [PATCH 01/25] target/arm: Add feature predicates for SVE2.2 and
 SME2.2
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Fri, 5 Jun 2026 at 00:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

