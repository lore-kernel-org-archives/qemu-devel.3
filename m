Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98611C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 09:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua9e6-0000Lm-PH; Fri, 11 Jul 2025 05:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ua9Qv-0007a5-Dw
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:48:41 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ua9Qt-0002k7-KN
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:48:41 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e8275f110c6so1331510276.2
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 01:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752223717; x=1752828517; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TimCur25OrpeO8vdC5V/7CHTgVJ4y7hGx+XAsDTQQDI=;
 b=c5XzWdfsfFryJvCHn4wuDlVg/SBAGGaijhbqIxYmtt4CBfaAOwgb5NA/7L4W073b29
 aAld+Y6Mb5Jz8J36V3wSVxhwbryhwsKhMp2FU251Gns7xs6Dci5vR7sw8HGGKjCvV/NO
 1NTMY8Cj1eh1ZI5V4fPnfdZIw9at+VZQlOaMHelgKNQ7JsL0KK25Fet/6y9eck+sP0v8
 35wZMm1SyP6EmNre+oA9NZQq3jNM0ehLAAVTRJI5H3aUHQT4m7Sk9ctvaknJnNZNkbVa
 5+A0MakSOWq7V+afP7/k2El09cJ4EU3eJ/e5MrotaRbRTJ/bvzScb1MY7RMipEpyJdpU
 R1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752223717; x=1752828517;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TimCur25OrpeO8vdC5V/7CHTgVJ4y7hGx+XAsDTQQDI=;
 b=SyTX6BA6yWmWAt2Kc7TZTFpiEDzANGgMT0hx8ZKTVsZo0xaIsmAigQzQp4l7/EmNtf
 Zjf/mpdvkII0dHSPAaIskrakYFAEwTQkhXup3cq0akLUZ9cpg1L3ZeqsgDlbMWMxbknc
 KHW7Ps71dvHXBzyofvl2xjZ/49HKPIMsDqcgZ3lMjDwIE4BNlAUQ0o6oupqOr1Z9368B
 E2X5zqyGBH/vfPl4qvq3QTgmhFo8gSnz1FGrCjYZhg5py6i0DN+Pbzkr/rGsQ1/0G22f
 xGIwaNO1qL189BDIGlSqSZphqKDEw/Kvugwjby+8zxPlcc4CKawTuUWxMkxhUCPCyCB4
 9z+w==
X-Gm-Message-State: AOJu0Yy0I0Ox1Dkofc8lt9LQooRWFlv4rU9NaarTwJuRNqV8kuoOmOaD
 QeWLUuXeP9TQzhE5rQfWHzdkQvxbj7uMobPmC3EFW4BUBx988++4MnkIUgMnJK0GnUqsVrcdt9m
 MIRw1QHwGH7j4FJKVg7jFx9xpauBAcokGdyd/FXCL4Q==
X-Gm-Gg: ASbGncvZbBQ3P28/btrxsNNJKyIjXgXZIh4ExzulY2qc8OdfRPfgPFYN3rr0fOkzZ16
 LabfT5wcAiBfnmiXg4nkVigKyYzxKaafQMm/KcB1Q3pCCE22NYP/Uh6avUaj0zsz0sFCYjY+YXY
 DePoLa+RTXb9sYa4U3wFdx6EDYPe4shYFuilRBKpY/WyDB7vwjZXHunDKVHNE7M8uE3EtnfdgZ4
 4kiQLDw
X-Google-Smtp-Source: AGHT+IHd0HRhPxNIFWK4e//bqgvWKvo2w9zubb/JofASB53HZf6VxvGDQ0J+R1YwjsMb3lQjvGcepuseCe7OEzR/omM=
X-Received: by 2002:a05:690c:fd0:b0:70e:731f:d4c7 with SMTP id
 00721157ae682-717d5b81533mr41602707b3.8.1752223717091; Fri, 11 Jul 2025
 01:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250711020338.586222-1-jcksn@duck.com>
 <20250711020338.586222-2-jcksn@duck.com>
In-Reply-To: <20250711020338.586222-2-jcksn@duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Jul 2025 09:48:24 +0100
X-Gm-Features: Ac12FXySzGl6ycT9uD1DxGv9UM5PnYUfilStF5VGzacFXO2cvhOudMiWjDX355M
Message-ID: <CAFEAcA_9D+jMPGg961K+ZFQkzu_Bsp2BStKqM7Wgn-Q4D0c04g@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs/system: arm: Add max78000 board description
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb33.google.com
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

On Fri, 11 Jul 2025 at 03:03, Jackson Donaldson <jackson88044@gmail.com> wrote:
>
> This adds the target guide for the max78000FTHR
>
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>
> ---
>  docs/system/arm/max78000.rst | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 docs/system/arm/max78000.rst

Did your local system build the docs? This should have
given an error because the new file isn't listed in
the toctree in docs/system/target-arm.rst.

Passing configure --enable-docs will force it to
complain if you're missing a prerequisite to build
the docs (otherwise it only builds them if it can).

thanks
-- PMM

