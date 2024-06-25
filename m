Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5558C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 11:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM4mn-00051F-3h; Tue, 25 Jun 2024 07:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM4ml-00050T-IL
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 07:56:31 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM4mi-00029Q-EP
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 07:56:31 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57d20d89748so5208108a12.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 04:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719316586; x=1719921386; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n6m1uGYAw2V2tNzKuzzVU/1bGox9Nl4LZRtZ579+Yc8=;
 b=a+iTbYgTW6t83KNGGgwvdfPmi98jLFx32jhuWCYeiqFrPZEZkka+JXvn20SadW4Leg
 PLn2lLZCurrLRmpw9Sa0sa8snG5FUZRetKvL2wnl/j/1L8I/rMEt41jNja1K1SJ3k5mV
 N2BAFFkjZn66SXYdmcq+jwWNWE5FcVd4L3cPE4yqT0EmMbADuxRm+AHY8L9or6p/nWFr
 oIKrsn4eLbG3Z2q+S01Tt7+id7pANjGHvNFCnXi1d0a10UuVulJ62DucviuekuoDodeo
 VyrmcEvW+6qIJEmcMaThwz76ssEeAxzE25hWe59d1ZU6cM46r8LAFGRs4FE0HJCqCb9+
 p5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719316586; x=1719921386;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n6m1uGYAw2V2tNzKuzzVU/1bGox9Nl4LZRtZ579+Yc8=;
 b=R5CDg7CIkF8tVuOmjd41nLWxqcEYly5MHtbscgzroJ2BqiKOU9jrmsKmX8o/1r4AzT
 1LjEuj55AXC7oeEoRy6GdQxu7Zy+6wdOFz8MOvbFKpiAZQuNNuYSDpBB7PzNI0EhyLLl
 hvMpLWQltG/NsgGQHENDLKgtGEUYKvDrOkvtL7dIh5Sk5G7Qu0LIof8hV0oFnYlQL1l4
 ojYwhIpoI+lbAxeT60JpgWWXsk2y308NaNPzg65j2fAt9PTEzGRPjOubtkxhImpbN9An
 B8kglGv9p+CjCmmA8LxrkYfcFgG8mpScrTMOoQW6ppxmKT0/lMMGdR/1EHkI/ycxVMlP
 onGA==
X-Gm-Message-State: AOJu0YzP9KHTGE0x0UFVrXnVayoRll2e6P9Z25IyFZRtML318dQL+sYz
 BQbtRcTv+hQ3dHmKmTtrY4FFoZqtRAPcPp0UHtq2lF03oRwbcR/pPKCXZEEH282AKwOGAZomZuZ
 j+acLh1bRyFoXnD9VeX9ilHf1+loa2jZHzVeBOw==
X-Google-Smtp-Source: AGHT+IEzZsY0Z5jznPPGFuN/M3Uwa2xoAeYNL8JD433/fSEb26I9CE+yO5XgK4TX7zXJtz9TR2lEwV63taUnS6Amhgg=
X-Received: by 2002:a05:6402:270c:b0:57d:6079:3916 with SMTP id
 4fb4d7f45d1cf-57d607939edmr4357359a12.26.1719316586234; Tue, 25 Jun 2024
 04:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240625050810.1475643-1-richard.henderson@linaro.org>
 <20240625050810.1475643-4-richard.henderson@linaro.org>
In-Reply-To: <20240625050810.1475643-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jun 2024 12:56:15 +0100
Message-ID: <CAFEAcA9t6nzxj4Lj769vHjyrLSrCKstnyWi2RVqJG0=J_j6jbw@mail.gmail.com>
Subject: Re: [PATCH 03/13] target/arm: Fix FJCVTZS vs flush-to-zero
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Tue, 25 Jun 2024 at 06:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Input denormals cause the Javascript inexact bit
> (output to Z) to be set.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 6c1f6f2733a ("target/arm: Implement ARMv8.3-JSConv")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2375
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

> --- /dev/null
> +++ b/tests/tcg/aarch64/test-2375.c
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/* See https://gitlab.com/qemu-project/qemu/-/issues/2375 */

Not a project requirement, I guess, but on the Linaro end I
think we want a
 /* Copyright (c) 2024 Linaro Ltd */

too.

> +
> +#include <assert.h>
> +
> +int main()

Missing "void".

> +{
> +   int r, z;
> +
> +   asm("msr fpcr, %2\n\t"
> +       "fjcvtzs %w0, %d3\n\t"
> +       "cset %1, eq"
> +       : "=r"(r), "=r"(z)
> +       : "r"(0x01000000L),     /* FZ = 1 */
> +         "w"(0xfcff00L));       /* denormal */
> +
> +    assert(r == 0);
> +    assert(z == 0);
> +    return 0;
> +}

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(If these are the only issues in the patchset I'll fix them
up when I apply it.)

thanks
-- PMM

