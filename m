Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B05D58B00
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 12:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4ecv-00041r-FK; Mon, 23 Mar 2026 08:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4ecu-00040I-3Y
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:43:24 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4ecs-0003UT-Jq
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:43:23 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-64ad79dfb6eso197955d50.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 05:43:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774269801; cv=none;
 d=google.com; s=arc-20240605;
 b=AeEm71HUqK3EfNim4m5D5w/mVQy5i+VekAMZScF/QwZcsFuVEwV68mOIF6bjmQl6Gk
 9k8nCeaPXoNycGeExO9tPJcr3q7hLDFNXC3OdFpH680gvb79nWAohRmE+rOb21qL85NI
 hTT999/pyN58/XcUg3ayqQnKfHpw2ytIaBoLk+vOQsWwtmlfTfHZb2OCY2mvtjZTptjY
 TRK9ozWZIf7DjxXWX9IOKULPo8SWPXf0AWABOzGn2xCgyyrA3UFSqrfZiq1fAAnZ+zhT
 8im6Tn2p2tzcHkTAowJ/bz6WhODr0V/m8YPTu5wTWTSWYbuHxjeKwVhEDuuK8ni4BeOJ
 lDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=tO7mpVl9gZUMUz35wsWcuO07WJVuudmzsaI5xwZ5f4A=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=O2ugyc9qsnEqlPwlEjFXgyJdmembcq/xlkGLsfKCfcpTbiA9ZNc3hmXr7fdCGirk1q
 JSXpn6qAYQsPCQxOKWa1IyqtgBs8JogUntX5fXu9cL6p8525kDoxvdY/HKvSaroi0TZB
 gxVf1Vt0uqCDY9at2Tzlu1IPcd0SSPIrHclsPrGOin/uaDVeSmmXEci6xbAcY6DjOtvQ
 yFooP174YErNqHeNvdLDAO2K19MTQM0N7oW22xib8VaJ0ruz7Q3YkDeAWgbQHMiVU06/
 /oFQnQA3hbP1vsF4oRX/hynbZskl47Ik1oVuzbdb7R6WM+XPzwkfIkMAlE3o67D9crn1
 9Thg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774269801; x=1774874601; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tO7mpVl9gZUMUz35wsWcuO07WJVuudmzsaI5xwZ5f4A=;
 b=xv2KsAj67Xayekqj0h2VsQimvKOgTgNt7Xd2UlbOTENA1IWOTsIxiuYFl/Ak/zrAfD
 NiD//gsiQc//PejMhrEydZqXAC3YtNJ/a07GIvNFDu4tDzM8xd5JHDf0jimislA1fsS3
 spVvaCdI5SXo/DMypMCVS2d2eMvpqLOGI7aDq5BboLy1/mY/YECVTX0c+hCBq732bBVG
 iqEtofbDyNBzDCzdazUtFL/5+uFPhOvL1nwWlLH5UbqTtGOH+BgdROLzL3kPguN0+eOd
 5gG53JapOe0c6JjlazOLHkrpx9VrzAQiTzqV8OZWMGWvGx5zHYpdEM13jNqeVgSLB5+e
 u6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774269801; x=1774874601;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tO7mpVl9gZUMUz35wsWcuO07WJVuudmzsaI5xwZ5f4A=;
 b=V1StK34UcFbpFuvjQeB3zsrP+ATXwLQMkNPtpyYqTCITvmU46KjQfdyxxjoUxK+teU
 EtapHzpBzgn2uU2d9dw+FPu/lexlFQCqylUNZSmrOpKtnUFM3Ib4m+jwwDcZUMtKFQDR
 v3LtKRyhqQsFl1tVMiRIbfoza9zNS8e9a1xvWSao2aqJ4mSH5Bw2zIcFIGceqccLCq5f
 mV54NJAQR9zgxFjMwx8D+tldSpepPQlTKzhQyx5h1Pj123/ix11/RUIQ1VJflvndK1FH
 imft/Wha0MwBgYf0EHC9ACswTi33c5/mzIgHrd//mRuVLbnalDd4Be0KxeuauYuP++K6
 iAtg==
X-Gm-Message-State: AOJu0Yy8z1FaUaGL8mCz3eQ7eKJh2TylUlmThPXXePoc9eBZzcwIhZY8
 4KakqtMMj8Om3vEzgYXXoGBzmVVXWARAkVE0g+EiMmNZJt/PLGjOdkDcr4iBwsn6b+SDBJf5Xu/
 KjBgHhD6FvOMwTE/GSya05b4htLLsyFVHDEcFPggoD3zZaYORuTh+cSM=
X-Gm-Gg: ATEYQzzjST5Byu8sZsauTicHzYx0ASxiWReGS36/0aU1QrUpAYzOGDdgNHTHtX+VSg5
 kmRDisEWhhV9JcGGK9mWz0LeMHiFKyZMazF2p+1mezmFdY0deUkezt8fYexsMEiqjMP0cJaoSLC
 s50VLV1LABemP3Eg8irIOwDnzN6eGDZIR6Z0cmut9kKkR1B+ok223j3bovYh1P8RI7XueMzg8WJ
 S9ybwu/n1iLME/799pDwziBeP2yVCW3d0PWzkayZbYE61LQphfU4pBkFuBcFVfM/+Kna+ifVYkn
 U9t4EaH+04uR7NehP0oip8R6vW0zQQWaaMjXvnV6YWL5xYQ0Vn0kZ3jfHMY0a+f2bpw=
X-Received: by 2002:a05:690c:5c03:b0:799:1fa3:c915 with SMTP id
 00721157ae682-79a90c4ed76mr112671657b3.56.1774269801503; Mon, 23 Mar 2026
 05:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260323105429.4059580-1-peter.maydell@linaro.org>
In-Reply-To: <20260323105429.4059580-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Mar 2026 12:43:10 +0000
X-Gm-Features: AaiRm52uR88Ky_yyS7uQkpK2YoGaHCV51jL7C7skjw8uuEGrPXo8rEtFV_CoEmQ
Message-ID: <CAFEAcA8teeVJ=XqNo8XL0eATZXyhfxvb9VWepqHvkuZg1C7PyA@mail.gmail.com>
Subject: Re: [PULL 00/10] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Mon, 23 Mar 2026 at 10:54, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The following changes since commit 8e711856d7639cbffa51405f2cc2366e3d9e3a23:
>
>   Merge tag 'hppa-fixes-for-v11-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2026-03-20 10:04:48 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260323
>
> for you to fetch changes up to b38859be76abf4d49f81f36317e6e37ab93121f0:
>
>   hw/isa/piix: Embed i8259 irq in device state instead of allocating (2026-03-23 09:51:01 +0000)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * tests/qtest/arm-cpu-features: Fix thinko in g_strdup_printf() call
>  * configure: Remove unused variable default_cflags
>  * whpx: arm: Various fixes, notably making '-cpu host' work
>  * configs/targets: Restrict the legacy ldst_phys() API on ARM / Aarch64
>  * hw/isa/piix: Embed i8259 irq in device state instead of allocating
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

