Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89EDC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIc-0007yL-21; Thu, 28 Aug 2025 13:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urduP-0003oh-4j
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:47:25 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urduJ-0001Z9-IB
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:47:24 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-71d603acc23so6971897b3.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756392438; x=1756997238; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HBSxWIEeG+rclfkWajGrnVaVMZsCrkC53o/De+Qt/eA=;
 b=yI4pa0tVhN7RD8xvxyhUobMF+Z6PQ1Zkv/BFJEDoPZ4d7DZzub6u8QeBAiDWwjtP5I
 g0uZ85PpdLmVR492bp7TTSFgMn5KyevOmBxMOKup6pwBjZYD2SuRssT3fnkGXoOF3XTN
 sShvrLkRU863a32gPaLry3ruZYQjz2eEXAQGrFe/E9OdoaHYgR8SLTk72Wn3OmWhM/nU
 5sXpB7j8KNfuo9xw/QcCpHGvT4NputbSmZqyzkOdw8xZLWHBzIwxgUGmWMa1a9CasX+6
 IoFQ2es9ZFMydeNGroh04hV9ffBkZt33wVe92gXI3kRmsVKG4RxDV3V9QP3Mlu2e2vQp
 AZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756392438; x=1756997238;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HBSxWIEeG+rclfkWajGrnVaVMZsCrkC53o/De+Qt/eA=;
 b=uWy5AIWkz26gpB3tBTVfImarSdWEmnCSyPHPhFQ2/FfJymN+zOZipbvcWTqFljV5IG
 ncpVY0POU4Fog65X3juH/75E+fsFbZU/e/x61lA6Dh/vMntc6JTLCXflsC3YBuMZY29J
 vLxBENZA6s2juZhbtqyA+oAGa3Mpp1E6Y5FZOa8UJxMUtfmtEvgXD9iSZuVcLNOWUZRp
 m5u06KtwJ+cQRPBG5axe6uwWayACmIu7bLYI6hf8S+677nt05iFMF3KVuyhT//DSLocA
 uEaktrys9zS6/GpAJTlgj98/89ApP59P5s8oHbTeiKYbQXal8k+MTYUzFVLVgPMYKIDR
 yVvw==
X-Gm-Message-State: AOJu0YymhOtf70XjO3AKvalmebnTqufbqWownmekPni5Ev5Pield5jjo
 k2yFav3c4xsE7GLK9qbQ3ujDfu1Hty4biUHZa+F4WFdzrQMHfYZp+WmaOf0a5EIy3sRltrt7siV
 XWuYJEAvqdenK0Z0sW3oX0RVWVL5DWAVMXaDRt7C4DA3uxK+OAg7g
X-Gm-Gg: ASbGncvBT6KWMH0hNsltBjIZa8iQBQIsJummWyit2gsDHUDzJFaXRY/+Ctn0GsKsEgS
 sd0pIsglKiwkI27sVmb0qOGC2rdWeV/4MsUkr0xtUjyajuX6XhKBUsdG+9qvKqTWrwnivOsuGko
 Gq1oMP3X20MD3+6FQ81RYjzCdkTMSdxWzx0FssmwzDkv6ruMdHlG3wtEDkfDXmAmqJEzhd2gzXN
 NtwYh6nvR2lluPjag8=
X-Google-Smtp-Source: AGHT+IG6Mm+vEteEg55K4/kzLXPRIigzBlygusULqZJFjlziNvL+pWPQ9qyf8RrLuNriSm8H9Wt22S1BJhhAKyxqSpM=
X-Received: by 2002:a05:690c:4d0a:b0:720:9b0:5791 with SMTP id
 00721157ae682-72009b05a57mr205345977b3.25.1756392437665; Thu, 28 Aug 2025
 07:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-38-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-38-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:47:05 +0100
X-Gm-Features: Ac12FXzIk6odLLHd-tI7PhbWB5xQCIbi9sF0-jjYFo5iFi9Uk9LeCtwnie80VUQ
Message-ID: <CAFEAcA-UyNhs347efeZOQqUK4ZjuWG2sjbseH2n65D5-eYLj3w@mail.gmail.com>
Subject: Re: [PATCH v3 37/87] linux-user/arm: Create target_ptrace.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
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

On Thu, 28 Aug 2025 at 13:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move the target_pt_regs structure from target_syscall.h.
> Replace the array with proper structure fields.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/arm/target_ptrace.h  | 16 ++++++++++++++++
>  linux-user/arm/target_syscall.h |  8 --------
>  2 files changed, 16 insertions(+), 8 deletions(-)
>  create mode 100644 linux-user/arm/target_ptrace.h
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

