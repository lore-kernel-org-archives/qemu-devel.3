Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FFED116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 20:32:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQAZF-0003YX-WB; Mon, 01 Dec 2025 15:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQAZ4-0003Jy-66
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:32:12 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQAZ2-0003n5-NR
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 15:32:05 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6432842cafdso4216196d50.2
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 12:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764621123; x=1765225923; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q1uWko0F2rjwIoyroY6nySv280cnuV9wIYF4yRZG2ac=;
 b=WCReX2YcMea/7NJdFXtD+5/cHLzI6fmBwJD0sE9+MS04IcRkpXYNmlj919dbo8JSCo
 tCFgl3eAJffdUW1U9iG1Q4lJ5uZLhD9xMTV59wGGfHIdvXZlQiX56HsD+Z2ynTm9ScSs
 AhwKO2Bc3yN4n4pfIRILLhcqeWZehlAySWdTXZVDZL4je9slpDYMs/ORxl7c5qg7zQTc
 9SQCeuIO9tQczmpsXMA+1E/mafPNNVFmb3ewqnWhSzRyTGVHK32vytekQ1ImBxaWnCf5
 9kSextT0v5sluqGseObVfIOKCB8nEEHLwVVlOmnadlODn5qDmXDYEhxAmYBXDAv/3778
 1y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764621123; x=1765225923;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q1uWko0F2rjwIoyroY6nySv280cnuV9wIYF4yRZG2ac=;
 b=Aikxk1bT5HFQLfDYBQem4geyYWWQSMVZrtfuyFJ+blvAnj1XUYLf423W2ZTDf5+9Hw
 5CppCisJy1HkrBa2zN3fftybzj7rK+vGIKBif5FF+dXfbIpA39KC2ZfT/7ctoufYuzmt
 vdrB3E0S1YXQFY1ThPxFEwGuJG9Qho5Jg5o8AM4s0BrNetDjouqyE+QXNNBDubrA6L+K
 dCXEp9/1e3QYxCjqeHPYI1qNNJ3BJFK8N90jNgqk3qVp6Hk/twrGqzpRFIpFada60DG9
 pbsu04zxmUKwZK8W5w3m0alWXI1jslM20p+t2pCrQhm39FI9wCxOfdHfkigXmrWfh6xI
 Ov/g==
X-Gm-Message-State: AOJu0Ywk+PYy2ICUXB/ZoHJ6eAFsCWbTsJIrs6oFV8cTGAnjWeabWYIh
 embbPmG/75nmHq2FSlzm2xKW3jTWOsQS8Ie0ynWnEwE7aifZE3jn38utG+0rBs4cQuJ2SU2FcNE
 oIXSwz4wXD1x6e5Cqf+H9/uSsXo2UQOipnYed4t/q+w==
X-Gm-Gg: ASbGnct4ZOZq3EQyDc4ioZgRVXL+Qbs7cuGFlA7wit3hJZ+Uiox66MYmQz27WzTyV/9
 ftYsWfMOzd/lHuOx0wHc1hYVKzOXbss7SeDDsXquvF260sT1MLl4qGWEEM2c71Vjzm8GUESaPlb
 TJVAHfD4YOPIfGT5sKpEb76yF32skUQ7Wg+vPSzhHtbS+HOWxVtkzM5Qg3rqeumP7iOGNsWCmDl
 coaK6rPJwOBLBxIBgY/lEzV+0jtfARFov8IIhIxNGYap/Khz66A+up8Yp0RAAnLMvSj2GYP
X-Google-Smtp-Source: AGHT+IEHG1mQd+KFxZEYF1H6yu/hPtV067Ueo/5pA8js7TuCLtfA3qz1d26GRdXtFK1FY/QO0z0uHjIZaC9sqfxuVp8=
X-Received: by 2002:a05:690e:bcb:b0:644:2e5b:4124 with SMTP id
 956f58d0204a3-6442e5b4555mr487915d50.25.1764621123199; Mon, 01 Dec 2025
 12:32:03 -0800 (PST)
MIME-Version: 1.0
References: <20251119130027.3312971-1-gaurav.sharma_7@nxp.com>
 <20251119130027.3312971-10-gaurav.sharma_7@nxp.com>
In-Reply-To: <20251119130027.3312971-10-gaurav.sharma_7@nxp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Dec 2025 20:31:51 +0000
X-Gm-Features: AWmQ_blTJAgqVgP7cHoBgWzuoQb7NRnj-Ty_8dLmtg8d0FVlKYWF7yD7hGVOhYI
Message-ID: <CAFEAcA9Qtu1EF3xT3thWEbZyKPVEkFP0E0HN9UjYJCEEas0CTg@mail.gmail.com>
Subject: Re: [PATCHv3 09/13] hw/arm/fsl-imx8mm: Adding support for Watchdog
 Timers
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Wed, 19 Nov 2025 at 13:00, Gaurav Sharma <gaurav.sharma_7@nxp.com> wrote:
>
> It enables emulation of WDT in iMX8MM
> Added WDT IRQ lines
>
> Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
> ---
>  docs/system/arm/imx8mm-evk.rst |  1 +
>  hw/arm/Kconfig                 |  1 +
>  hw/arm/fsl-imx8mm.c            | 28 ++++++++++++++++++++++++++++
>  include/hw/arm/fsl-imx8mm.h    |  7 +++++++

> @@ -198,6 +201,10 @@ enum FslImx8mmIrqs {
>      FSL_IMX8MM_GPIO5_LOW_IRQ  = 72,
>      FSL_IMX8MM_GPIO5_HIGH_IRQ = 73,
>
> +    FSL_IMX8MM_WDOG1_IRQ    = 78,
> +    FSL_IMX8MM_WDOG2_IRQ    = 79,
> +    FSL_IMX8MM_WDOG3_IRQ    = 10,

Is this definitely 10, and not a typo for 80 ?

> +
>      FSL_IMX8MM_PCI_INTA_IRQ = 122,
>      FSL_IMX8MM_PCI_INTB_IRQ = 123,
>      FSL_IMX8MM_PCI_INTC_IRQ = 124,
> --

otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

