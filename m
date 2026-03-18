Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820DD103E173
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 13:29:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2qxN-0001vg-IB; Wed, 18 Mar 2026 09:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2qv8-0000bu-CQ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 09:26:49 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w2qv6-0005g4-Mi
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 09:26:46 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-64c31ca77b4so7359468d50.2
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 06:26:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773840403; cv=none;
 d=google.com; s=arc-20240605;
 b=H8scBhOKKJFlGBOL0xWnZHKHuFUIeqbFV1cuR8cTJ5PPauQ1rvHnFQyMHgTowNLdPU
 pzaeXsiSgwHtBM6lD5iXkfhpXq35DVNncT0/Y14Xl8BbHMuhXv2UpVTPAj7dOea0HpQR
 IIJwYM/QrBHiy7bAr26q8fgCUNGhe09AURIaJq+bljsriEFI+uoDSN+HJxc/5iLdsZfZ
 qC/Xzu6pHNMKyBin17lIB/emcTABVIp4ZUDUu02JXSrzJKJwVT1s8h7+U4DJKoBFpUJu
 ITT+yjr4AXvmrwaWhCkvUxiiy93Zr+su+OJvGwtpov2qRO3fw2FHzz49PfyT30yy5BS7
 3LUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2J/ARexlEkhoSjahDVI/cZqJwbPhZEMlfNgmS7ZCJBM=;
 fh=6kJ3CohSxQ+7EgnARanNFMAgatAnP0uu5SOkx3O7QGs=;
 b=QDR1yqyEooG9r4eOY2OrdgdfYQKAGpL7lQCFJXShTTY0gpi6Fk6heKZaQFZJQhB27p
 xFDrv6naqbADnjGKNFQsNjvfMGWsTc5HfTOgmZlSgUVZ8lGI1M5uXWLidRw3qIncZKml
 6LXY+ulquSsQosICTC7WWyarqLx4FG4lXCtjQs6Y+9k46T8Di6XQ0uW2uhHiGMNrfMqz
 /imzMWj2K3qEKzGbBSGRbqP+FiuHx8Dj596YbkDmIvLwMxGXP8Cuepv0vYqCzEnpo32A
 Fw3p4FL1VT06Oarawa3bs83Xpxz/cMzg0xOwgIK+NIUlrf9WeXRenVuSZhrs88ggZ4KS
 IRZQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773840403; x=1774445203; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2J/ARexlEkhoSjahDVI/cZqJwbPhZEMlfNgmS7ZCJBM=;
 b=GFMwtKEWhl85iBUCztgTV8HbsV57iwKoocLEDt/Lrjs6M9D4cl7sEm704CPL5XHA1M
 FkoJ4c59paZ/dAfYe4pUv/HOZskO0LznWX0yLqBSgbW7lbLKW9e67kcFBKglhlj/e7Cy
 8gMCz4yabFl3TNFw5F79eIjMF0KXNugwm2QTuDwzGaO4xJXulKfP0n+YTF582U67gyoM
 xldUDab1XO3NQA37W2d4dWkLzjbYVMKQYjNxxoNRJbt6wVGc2vz97kiMKtJyM5SyiuUy
 C8vz/iGM/1A2hObixDV80XNF+M5tC4xno+PTkwjmUA7fuW6QilBTNOnavHRAjOFkxw8n
 IAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773840403; x=1774445203;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2J/ARexlEkhoSjahDVI/cZqJwbPhZEMlfNgmS7ZCJBM=;
 b=QVd4tsZmAvEpelpLLEzRvHegAABTJR17J2qwZBlynrF3xEW8G9+MSmwkcTAmANC4dM
 TlGPImpTvtXbsmU0v1c1IQ5C1SqWzc7Mt3Yt3B8UJmVWwZBFLUu3EsreTRmai7MlGIO4
 8OlEqf8TWMQ/G9Fm3e+xhvS3IYLR6nEpvMOG79p3czW8vxuxeQsZOPzZPgSiRGqGOTyD
 CQlYtStbqProrwHJIgWmUnhwhbFDe0Oj2d4t7tJTN0vN1BksFpchkVZxAMbW4DfgEMJI
 qPue3IHg37/xa4tYOGNzduMOWslsJV8yxRGJSnFfaiRbNLdkHlhAmEmlwM3mF8BU/Kwb
 O4bw==
X-Gm-Message-State: AOJu0Yymmw9LML/0lZVSH9Q3k9KUp0u2MSu/AHcCxj92Cx7OYv3O+cs5
 5MviwJ4QRVGtArwhRNaG9R9VyPmxWvc26ZqreZDfPgsqqMb8cE31ZYqaem5figjcRaE5dNLLevU
 M3Nkexar1muGRNDUP2dECGdON17/IBhLH2Bj5+RaFmptrrPp26Ojh
X-Gm-Gg: ATEYQzycjtrouawC7D5joTzR/piTTRAhJpxZviA2sH72NboHfWwlGrYR08nxULtb4Yc
 ruzGBeCF/ifv7Q6xB5RjZfwC7/eL3AvjhfHR0t8Q91xRCF6nxA2mvqXam+RLkh9E3BI+cvAGhBP
 0FYtJXMAafdbzdS6RS07dSAFJF19N99Pa2cwFvh48iPALlP5W7TVigZ67ZnU9OjmorSkrlyUeP+
 7MXtQQAa9fakCxzPu+NAT+hf/3i2jKITbX40daSlZVM+GD0M9eIAU6Krht5z2Rt4IEI8agG8j77
 /gblEP+dlbdijcVHkfTZeKZHtG5n2BkxXZFZAGvNgD5pq5WVsIUC8D4d+7xkszEgK6k=
X-Received: by 2002:a53:acd0:0:20b0:64a:d74f:2583 with SMTP id
 956f58d0204a3-64e912eeb52mr2891587d50.8.1773840402933; Wed, 18 Mar 2026
 06:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260317182320.31991-1-farosas@suse.de>
In-Reply-To: <20260317182320.31991-1-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 18 Mar 2026 13:26:30 +0000
X-Gm-Features: AaiRm50999roi0uVICXCfyqSConArnNzI3s_qcGOI9-co16_7t3YVu5hL1wEWmg
Message-ID: <CAFEAcA88aWh3S2Wv0EeeskpjHc57avLFDCCm4YM0=+oZ6qG95g@mail.gmail.com>
Subject: Re: [PULL 00/10] Migration/Qtest patches for 2026-03-17
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb130.google.com
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

On Tue, 17 Mar 2026 at 18:23, Fabiano Rosas <farosas@suse.de> wrote:
>
> The following changes since commit 6667668e0cf369e47aa9dd0bae40989896e9ed9f:
>
>   Merge tag 'pr-plugins-20260316' of https://gitlab.com/pbo-linaro/qemu into staging (2026-03-17 10:20:30 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/farosas/qemu.git tags/migration-20260317-pull-request
>
> for you to fetch changes up to 8f627bf1be077382f8ebf2cbda5cfb7e94006c54:
>
>   tests/qtest/test-hmp: Free machine options (2026-03-17 14:58:09 -0300)
>
> ----------------------------------------------------------------
> Migration/Qtest pull request
>
> Various fixes



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

