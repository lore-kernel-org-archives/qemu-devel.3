Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CAB1CE7B08
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 13:02:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJtR4-0006xE-3Q; Fri, 14 Nov 2025 08:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJtQM-0006fa-Uy
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:01:11 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJtQC-0004hX-WC
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 08:01:10 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-640d4f2f13dso1832077d50.1
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 05:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763125254; x=1763730054; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Sxe0nfN4FvXH37rL8I/U2Ynot6MXxlfpS473dhTJwy4=;
 b=Y69j0rrkL1MKQ3YkNFjIcixDurESsP2FVcNQ24BPJpwWc3zf4nMD16VH3eRq243EZX
 vr80KdV+Vl5LKMom0Xvj/3ryRZAkHQjcK4bJuSQi01MwXGIRuhczO0iekyEPJZtoqcze
 6FEW7lersrfODRhHBp503l/BQ/M3FhOtwuieFjEwobsEsl3TZwCGCY4FbAMCF1ZgrZCM
 rtUB606QKswxV1+oB0siVgobSnKVIhr+pLD8BHtQossKCtg6t7AQf8NgA0TKdic9NaZp
 WYoYSiHGlEviqIiTCXMNQiUcgHmJH9TCXQ9Q1BgV7GudanTGb4VScJv/bSE0i03P4srT
 mAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763125254; x=1763730054;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sxe0nfN4FvXH37rL8I/U2Ynot6MXxlfpS473dhTJwy4=;
 b=rjGx8D3crNjez2iZwUIIPyRRQWHWVOxIVvbwJ2os8/CDI597j1JY9d7jxBWv6SoBnv
 hUrx67Okfx47blwcDNcPjWQNuj8/xfoKCkz0WP4Q1njJE2Rlmev7C3OBTukrkfKu8bXm
 iGPSZP36ao9Wjg0JOKCGwfnicd/n2B+cXnbfMMPYtfkDmJRfHHAmGEf+z33y8G0C3zDn
 RfALPpwAH31wQgZzjbEwtSbIwv+xR75ahW+J8JbQoPc5u8KBL4HkcmC4VQ0XopOSmamJ
 u4cHCcCL0KJ/v3tZxSgD9m38csTzMGWY62lU3fNhw5KMrz10E66l228Es5dZHIr/GBQH
 3fQg==
X-Gm-Message-State: AOJu0YzRmqHw8GKaWz1N0WZbCR+pBjLrfqcnOf0sU+eAo/+FMgBYQG0/
 Y38e+Poy1lU8UsF2TUH2aP3OxqeTQaPGPeRcHymD5s4LLumXzvsIGCgKN6O3xEPtIl2ODD1LSBx
 cSljsMyaYtgI2jQiRpRUspJr2mxPQ89lmxAIQ2ql1Bg==
X-Gm-Gg: ASbGncs9J1Jetpr5yTfGPSQSYCB9Ub02Z76cxhb+O6vYkpddDqzjK4tjQZ4zC619xT1
 r+y88LLtPwjn+N/w6/0Ukli+TkBXytCBXNrc398H0hEb1f294bz2Uce4Jpn6uH3qxaC1W3ywfUw
 5qO/1ukTsTzM9Z+AsRiZhhlKabLG4/oMKwdiBBg2Vvklwp4rYKg/WM5J5m9tvwPxN4jvBzzDqWa
 05d54xm0UfljU5RGtKt+4S6ZZd6GveA6hFwm8GVLMqdzNhW7b/apEfiTyZwmg8NMaWZ3UZU
X-Google-Smtp-Source: AGHT+IFlUjjPZiu83jmEZVWMiRXUurNdIi2sLZLQ0Av9K85Jebl5oA0H0oYfMmiFtwdLxTynzMAf0LsCAKfa9YP0fXM=
X-Received: by 2002:a05:690e:1609:b0:640:cfa4:e8ce with SMTP id
 956f58d0204a3-641e769b265mr1905844d50.68.1763125254330; Fri, 14 Nov 2025
 05:00:54 -0800 (PST)
MIME-Version: 1.0
References: <20251107072337.28932-1-mohamed@unpredictable.fr>
In-Reply-To: <20251107072337.28932-1-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Nov 2025 13:00:43 +0000
X-Gm-Features: AWmQ_bn0V3KiSyg1chlH-e41pK9GHLI_27WlBHW9ADV-bjc11Svm28ZROyFhq0I
Message-ID: <CAFEAcA_aYPG3HMyYpKsTKtR+rJgcgc=C6bU0tqw8XLMGPwqZEw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update maintainers for WHPX
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>
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

On Fri, 7 Nov 2025 at 07:24, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> From Pedro Barbuda (on Teams):
>
> > we meant to have that switched a while back. you can add me as the maintainer. Pedro Barbuda (pbarbuda@microsoft.com)
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index be6efff80c..c75b1a4d07 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -547,7 +547,8 @@ F: include/system/hvf.h
>  F: include/system/hvf_int.h
>
>  WHPX CPUs
> -M: Sunil Muthuswamy <sunilmut@microsoft.com>
> +M: Pedro Barbuda <pbarbuda@microsoft.com>
> +M: Mohamed Mediouni <mohamed@unpredictable.fr>
>  S: Supported
>  F: target/i386/whpx/
>  F: accel/stubs/whpx-stub.c



Applied to target-arm.next, thanks.

-- PMM

