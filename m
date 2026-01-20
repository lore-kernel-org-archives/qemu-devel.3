Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB83D2ED0F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 09:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi8D4-0006SK-KJ; Tue, 20 Jan 2026 04:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vi8D2-0006N0-94
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 04:39:36 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vi8D0-00072k-SC
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 04:39:36 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-793fdbb8d3aso11136277b3.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 01:39:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768901972; cv=none;
 d=google.com; s=arc-20240605;
 b=hQ61U/ejld/utWS+51fk30VwlQXF8ZLaq1FpZxkEPTN0z4+O7bDHZ4rIQteVOYQgWO
 kVk9PJ5+F9h2eD+gpKKlWBBD8BqHewRZ35yjvIwgatpHll4td5F4ao7d/TBhJg53+65Z
 5oZArMzW/QuIQlrV7Xdzb03vvDzUJtiZ7Y9QTtlZK4hJNDyf6WDaxLhqcTK/fRsbotSN
 l38slhG8FLosK0YWWfL5pCk8EpUr4OUgvIly626DE+pvYAIjnUkdRelu9eThJAMvMKQw
 sh2OroCcvYvFqE/3ufHqBKSfDTHvbE2844cLB3irW+5Yhs617O9gtyhsFM3vdFtavAlj
 ZPvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=p8F9xJC5CefwY0Abxs8+Wa9Hku769lMVUPA+ypcmtJo=;
 fh=J9AnO9c1cK/BRtfGYAO0+7Hhm+S3DOBx7ftXTQ6jvXY=;
 b=lQda6NPOPvQFAbss/uJ9WwEbYeErZ7os6Ib1ZHzz1Ss5uuw+IB73nGVCnvyD3jl+ar
 0mA+xjqilooCIViG1QdSA5YuVoK6MPyAbLTixjugRn6owTIPEx+g83OvuLEgOy/JiG94
 9ruoDsKdUnCMFwjfNZSymnSUuvHyEnuzYFCKRuh2TMdrKuYe1HrtUZuVIebFWn/eqiuv
 RKRdG5Fl4kbb7ipLpxKVwKKHX8ioNLWkEG8XAGgwgphkgkZRf57d/bMYQURDaea4H8M5
 aaFVw74OzbacFHGNXcfo8PCWHEk6jq2RcT8sbUEupbeN68eEMRP3O3sOd/p83VsPW9NO
 +e4A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768901971; x=1769506771; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=p8F9xJC5CefwY0Abxs8+Wa9Hku769lMVUPA+ypcmtJo=;
 b=BnZc5JkePBf+bQyUKM/WLX986b6fu/3DVP9O5NECFeh3XlD//n88IiRoad0cO6PFAW
 TZCq1fnvJwNIlMeam2X6151VKf1XoXHlJJDPktnqyXgPQBLdZHMXrK0rwVbrHyypyUN8
 lle6PmCeuVogB+SdhhZ2FIJacrPO6/+bxkTAFFKwCkTIaEjRIALC+rZXEb4qTISl0duT
 3ilj9pHQnPbuMKuSFuDHwdj5fdO4DgPFi5opca8YwTVJyEVfmeQSdXiVdhVMrhaE+ZoQ
 f+qHxjAh+txrT4HFQIMRlLK0gJK8T3QLX+rQ8bC63RiWUVLRNBlwpLw393S8swsKCg7p
 +aNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768901972; x=1769506772;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p8F9xJC5CefwY0Abxs8+Wa9Hku769lMVUPA+ypcmtJo=;
 b=E35PM6Sph1xtyLXoIoyGS35UyWn1yQiZChj9nIZFAHx4msBMRLdrHSL8PYzfDLF7jC
 eKtAqzyj+CFDnE+vmrjFV6K0ze1r5k1YlsUbCAnaufnEDtN6Qj1l/620S5CJ5EEBvlpg
 l8ZmCD3bFcQLVswainKD3zNzSH47fzo8vUThpQVx81DDV7aVDhfO4h6f8DtwdM8TB+wp
 +6y73NudIEmK/mdmqzDJqlQwk4ccWzFUOVPX+vxGrfKl1xomD4BMW7PW8C0oabXruWmb
 o7tZdBXipaVDJtqtq7gEccsVFOYu5A3J3XTnAYW+IYyOziKzXfis8sUO/9fxoKlV5Tg7
 cWng==
X-Gm-Message-State: AOJu0Yzl5eSOKUmtx6U73quOePWMEIMR0RSz24PrwknZIfwKHE16+zwp
 G+DuDJi+o9jVMylMaVYSffo50kmgJ8cJOl3IGjvr1H4RoAXV5oi7Fvtv3KTLkOhI/zF6x4Dulr0
 2myNcNZsF9s/JR1Akv9FzOAVDb99O76C7ionEzE9ebQ==
X-Gm-Gg: AZuq6aIakNcdGj1DHslDVvgMCSAQ0OmavSs4JI5QiXgzJsAUaktVw5GQgjc7XYw/A56
 oO1pNVXicSwy8b3G3yWR9jB/qhf2NSgLJYbt+xnXgXTY9BxaMMY3tWbpescIGGY6Yfh7g1Kdye9
 UDGDHX1BZGDq6d9+rO2V6ORbvSntWif4rNXj2lYOKvYHNADuXkNURChi+bF0p1VERyxNbLWAQx/
 iwh2v42qXWo8JimGpNRdHmMh86Vz/GKt5jUpZ8ywI0FLBl/2TMBpGe7k4GfsdorDGzpRQ==
X-Received: by 2002:a05:690c:6d84:b0:794:3a7:e4a0 with SMTP id
 00721157ae682-79403a7e838mr20070107b3.23.1768901971519; Tue, 20 Jan 2026
 01:39:31 -0800 (PST)
MIME-Version: 1.0
References: <20260114213227.3812-1-shentey@gmail.com>
In-Reply-To: <20260114213227.3812-1-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jan 2026 09:39:19 +0000
X-Gm-Features: AZwV_Qh7ikiAl9qlyWImqqvG1ssVxx8uwfWiZnqXgpeH4Hcv9Wuqb0U6HOmZiTY
Message-ID: <CAFEAcA_t_-Xj=5VExfHk8mNDqa8DB4oxGRy89fgTZ2y1U6HU5w@mail.gmail.com>
Subject: Re: [PATCH 0/2] imx8mp-evk trivial patches
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org, 
 Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Wed, 14 Jan 2026 at 21:32, Bernhard Beschow <shentey@gmail.com> wrote:
>
> This series contains just some quality of life improvements for imx8mp-evk
> machine's CLI usage. The first patch removes the need to pass "-smp 4 -m 6G"
> and the second one does not suggest passing redundant "-cpu host" when using
> KVM.
>
> Bernhard Beschow (2):
>   hw/arm/imx8mp-evk: Provide some defaults matching real hardware
>   docs/system/arm/imx8mp-evk: Avoid suggesting redundant CLI parameters
>
>  docs/system/arm/imx8mp-evk.rst | 4 ++--
>  hw/arm/imx8mp-evk.c            | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)



Applied to target-arm.next, thanks.

-- PMM

