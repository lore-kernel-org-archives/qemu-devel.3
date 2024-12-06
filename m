Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92F7E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 13:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJYSM-00015J-Oh; Fri, 06 Dec 2024 08:33:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJYSK-00014y-O4
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:33:16 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJYSG-0003VR-EW
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 08:33:15 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d122cf8dd1so3304708a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 05:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733491990; x=1734096790; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2MpNL2swcGGFC4JX/uRm4AT+wBWDQnwQyVZO+4oHt38=;
 b=eq5wQKmm7R+T9F8BAtFVFc4X6mVdwfOpktzzC/P6H4mbkZ9aexo6hiZS4gzz/fqfiz
 IhebYvzroYYqTJ9aQYZBq97XhvNlC6EIPJfZPhX7pLgNLpd5EArj6sXBpstNsciKt7RS
 +c3yfhXkHKuRbJmx5ALW4zQK6a/FbVxTTp+t2YdPVjUw/ycAv6oohQkIRoU2lnRFK/df
 9J3U8nydaf9leyMrGLA6fWvhu7TQI6yzkygZc6gzmOGm4xuOoz1B9OEuOqNhRYLsujuU
 oypBR8vEOZV/u/V/hdnfaB6nyhS+8uvnbZRsDOXhdyqN3a5PY3jf6wf3ihqPCely1K+O
 e3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733491990; x=1734096790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2MpNL2swcGGFC4JX/uRm4AT+wBWDQnwQyVZO+4oHt38=;
 b=HkJWau3CJpYza0cuiqkzVEpb6hxfcMGtshKaenC9hmeot0WJrQPXHHiAgu54pjYaJE
 bEC+KtW0byIBAyeZCR639uoVyDlgwMch70NvtHWn2oQPUN3KhCYSGGd2lD2U0tUm7HB8
 2TVX5wPWPLi7JH3NtzcoICYX+eRfvdx/L+cCFDdKuV1p6QWDDzhXdqGwOg+IXSsimCpY
 VJb0KtLS8jwtHN1dfRx7RODGntSj1B3xrtNNwc+0VnA0iST6uAXbT3pg2/qaODlaG1LI
 m6vbtoE8BM7RsvdIYgUqfBO3JJfQgzsPWqXQMA3tm1x+X43I3JmLDYQ5crK0BUgtoqwb
 QQYw==
X-Gm-Message-State: AOJu0Yx97mGVx4MMlcKXghVQMq0IAYCTnRHMdFdNdtUGwoHo4lvig6Fw
 WcXShimvp/hNMvPRS5Bk/fKQF3kdd3fMyRWoC6sVJIfuW21C6qoBTp5zFPWNByaFaKqF1Hh0eUQ
 GLJOuCY1R6EAEzsCiwG5H53vmGWFBJZ1s3fiG6w==
X-Gm-Gg: ASbGnctcjXyxdbKH6BRLrnpm9Ixbp1UN2BGqiZVk8Pl0Pl0gaSv3LYB/KYoZB6PIp+6
 KCq63xf/16CVg2DvKAQh36GA/m/7gxeLk
X-Google-Smtp-Source: AGHT+IE7Q1ppnPklUU8KO7z8S7OAJB31FzBzTxu/ApqvMXkDxv9J1B0nL3xIWZpYvabrHEQzE8jfOGhyyfl/T2bhfmM=
X-Received: by 2002:a05:6402:2696:b0:5d2:719c:8bf3 with SMTP id
 4fb4d7f45d1cf-5d3be67e27fmr2603369a12.9.1733491990008; Fri, 06 Dec 2024
 05:33:10 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-31-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-31-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 13:32:59 +0000
Message-ID: <CAFEAcA9=m99r9yaL_RrZ-W6Qh_LpJFyJ2DDnaFrR9RXT3G3ybw@mail.gmail.com>
Subject: Re: [PATCH 30/67] target/arm: Convert FCVT (scalar) to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Sun, 1 Dec 2024 at 15:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Remove handle_fp_fcvt and disas_fp_1src as these were
> the last insns decoded by those functions.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 159 ++++++++++++++-------------------
>  target/arm/tcg/a64.decode      |   7 ++
>  2 files changed, 74 insertions(+), 92 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

