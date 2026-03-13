Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD45105F78C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 12:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w11jc-0003J9-Dk; Fri, 13 Mar 2026 08:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w11ja-0003IX-4K
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 08:35:18 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w11jY-0003Wy-IR
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 08:35:17 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-64c9a6d7f81so2270089d50.3
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 05:35:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773405315; cv=none;
 d=google.com; s=arc-20240605;
 b=FrmhatUjq2mwzwU432autCtTtv7e3Bq3byJLrWhiZQ8CuLIYELiKhAg+yW4OvdNmJu
 AGY1MLROOJSjCrtPWM6OlpLhWPsvJfLTpRI568xJFmhFF61Tt3MUFJF2VNc0JKFTHzoa
 /w8o64jl1+mAF16kPSxqftnUtuYqf0PCxcIykQV9chCMq6lrajfxLlyWNSmQCneRTy4G
 YJIUiCEO2RF03F8sEAGMbJYyJEbahCoGoKPW0S+UC5J/t86dEZU130kbBcGSjkcpTiCm
 nsdBDxS/aYbvshCTo0YEotBLrK0hQS9RTKs2aWPgIcavGkxXFq+dy+X96galQvAAZD3p
 YbQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AlNspcE07UEWTn6y9KFkJ3h/Khw4tpNT9mIFukVluNU=;
 fh=gS8oh9EHdcTDcglskGyIv3/M5LtfI+jKdwGYJC227W4=;
 b=Odz8VKYFNDREEGeSWIz2dBHmD0T9RMgvI0/VqfX7Bx8MwnxWCutF9d6gsC0dkGpVNW
 TIQbLr41xx43QblGBsimwO1eSQZ50I5Z9YYxwSj9v3Ial3TxwseR0ZXmv0ZxFQsdAr9D
 yQz6rS/on+2EYZVPcAMm8qJpjVrcG3PapLzWGQuwbhZfFj/vbz1Fu2xM7zM7QJ4zQ8O1
 33gM8UheB92NuKLFiTGd75IWhSZyiJrUSWYcodMb6EGeAMmtrS+mNLTt7qzZNGaGK+LZ
 d5IHG4PPFUUU0i9xshIVImH1H23qLo4iGTboS+eEdGN1X0G25Y9V3ClvOQ+V18g8HEFn
 TZwQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773405315; x=1774010115; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AlNspcE07UEWTn6y9KFkJ3h/Khw4tpNT9mIFukVluNU=;
 b=fCD4/Vn66ZLVGgVvKLaUH1SHQEzfxmlTA9nfP2CVJK6kMb9nIMRtgLW2djj2gE8Cf7
 8wB6vyg6nhJYiPQnkHNhl2wxwBPPFmmQ5iw6C4joOMKh1kuTxN1cnOve+biRiSE8hO4S
 +0+aczk0FhUTByfD4uPnLZHV8nGZsKH5AvWhaY8hO1Qakcl325CD5qiww2QonrDYv6D0
 SoxsqNwkUok2tj6GLhCnClJBy4Tr3ppd+uPUcZUEqkBrnJOzXwTE/zPSt6dPfJi1yvFG
 YpuZwmlQITcdH0FCTIDBEnESL4+LYjIfTy1q46awIpvh6R39gsnSM6SxAkNjDy2RkQ5J
 XMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773405315; x=1774010115;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AlNspcE07UEWTn6y9KFkJ3h/Khw4tpNT9mIFukVluNU=;
 b=XhcacFDD6BNCzoPZjeY9+dv7yk/OhJpmzhUoc7/IDEeeyT/hqTTvL1dv4VIsQy61Wx
 E9okKcyGNac/abZ+ZRIn+AsYY90KiWRrbgVz1wea4OPuBN5LZSLbYI6jJPBQCI+Cbn6A
 jwWoYsJGItKQjqoB/i8q9JbFemj/CDMG6iR6s/A8Rm+OCUfBDQnpowCJZPUCFMaTp7dx
 Q6lGGgaATeomZbhhJwNXs0dE7VXh+qUV72EvfBeZHN15dGOjboj6zVfUuAWxH9UHy7rP
 AKLt/s1kFPLZnFHIG1SlwDzgFkcjJUuaTaeuaFeatUOC3VKcKpCMptP22KDHEiuLY+Le
 saww==
X-Gm-Message-State: AOJu0YwBpy2D92xJpN86VLz938AW4ue7tILix+N2bq5dqmDmdYlTA5vI
 MfbNBE+kTQy1BYx4rbkSwHOaWE72PaNV3Z5TJTpLOMe5ze8QCkuzN//uXYRpEx2Vf8GUiMmMjrN
 MKFSQWrE2uBIpy/O/1HjnulNELGB7le1ysjElexdAdw==
X-Gm-Gg: ATEYQzyGqCHQMY8jPc9lJkR8T+PdjHs/wejMxcLPvH81ESO0Wobrw+8rV2Z8jNWBzfX
 FEp4grsqYWPYMInDTlgwb8E1oFC8ZD/lqq4Bu6+qsDYP5cw5Li8EXgXOe5TmVkL5Fc94MfsDesg
 qprbFqjwidWwlCjzX2HIYdHKQMwgvffm0HL92drJru9+tsAl2IU7OGTBDemGnGX1x57+dwVPcOx
 BOfKfsINcPoPInBS749htqYk3jI3LjEwpPMTd1mXsuvMlV4JsLxO+46muSBs+7BNz3w2hL939AV
 ++cXW5Bkdgz64igoHhnTx1K3AbYFrsSvwfcXMbksdrzRJPqEiWW6If8m8e+CnKZD2ko=
X-Received: by 2002:a53:a492:0:b0:64c:a2f7:b49f with SMTP id
 956f58d0204a3-64e62fb509fmr2118771d50.35.1773405315045; Fri, 13 Mar 2026
 05:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1773301927.git.dingtao0430@163.com>
In-Reply-To: <cover.1773301927.git.dingtao0430@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2026 12:35:03 +0000
X-Gm-Features: AaiRm5292AN2DxUSFlfZi0wXZ1_PsPsdIlpigTs_NmIFQVTv6buv1wqkUrcjcbA
Message-ID: <CAFEAcA_qvAzHS6xDG5jErRxakhVD32otVgcHL4oLbK3P=NTBAQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Fixed bugs in pl080
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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

On Thu, 12 Mar 2026 at 08:02, Tao Ding <dingtao0430@163.com> wrote:
>
> Hi all,
> When I tested pl080 using the existing dmatest tool in Linux,
> I found that pl080 could not output the results correctly.
> The main issues involved are inconsistent source and destination bit widths,
> misalignment of LLI, which can lead to incorrect data and even cause qemu crashes.
>
> Tao Ding (3):
>   An interrupt is generated after the DMA transfer complete.
>   The swidth and dwidth of pl080 are not equal.
>   The LLI of pl080 should be aligned with 4 bytes.

Hi; I've taken patches 1 and 3 into target-arm.next (with
some adjustments to the commit messages). I had some
review comments on patch 2.

thanks
-- PMM

