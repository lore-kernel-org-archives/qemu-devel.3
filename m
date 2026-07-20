Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8913C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wljYI-0005AL-4E; Mon, 20 Jul 2026 04:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wljYC-00058V-Jl
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:40:36 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wljYA-0003JN-De
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:40:36 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-80e24970f1dso48641287b3.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 01:40:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784536833; cv=none;
 d=google.com; s=arc-20260327;
 b=W+mmSRUHO/pAdJddx67H4WYEdCxpYOnJ54pUhNebHc/2uiJik+ue/cUIsN3ArPKPX2
 KN2qFqag+kUVlMitkaJDH8oZ3VBU4H/Jde26zRIDPspAZl+sg2+1Qt3OG83ygPYZdW++
 XdXqCq485HAFSDT+txhJNvW8Al2DL4bI0I4Ldof6VJdFjJPkzQZrYpiZe65tHRD5W1LW
 Pftjyy5RiZG8nqTeZbYhOV+kXU70chZZzN8EQg0w1Kms+V6UljIDapIbeBdYApWbP/Tg
 AVeXyCmmgojbZTd5uDzccUtDOTfzD3+1XcwvkTt4tN14nR63B/cUfFTFl9S8IsNg1FTY
 SOdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=bZxiAV9mmN2tKd8DiAqS6HbtAfvP1UumvFStr62do4s=;
 fh=AscTiPYl1cXv+X3ieQdb5FeXuXO7R+SAo5lFu1v2G1M=;
 b=MGgOLNcZ6UqEaUIu+HZA6d20p3Qm+03bktcoapWZuMmH1Fhor9dK6aLLIz/UhHrEBE
 3qXzY8bwuf2YjEzwZ1jK6AMu8hGPBCCxF8xaARJsE4ZGTP33ZWkjuwucnn+Ih6E2V3Pc
 ZzkrakHl8slUHAzPEO7U4GQfxUe4t36m0BtNsupJcbydS56kgmwtrzxmHDkXiJbyEtFF
 pJkOj7aKginec/aLuoA9nULNul2zsQy4LtNKvU68I9K8O4T15s/Hk1lQbVxwIAr8mFRh
 NW0qaERevVxKRuX4zlhRayq7Gm0c3sKF8NGGQ/kRe77ugwqAoPQ9aEuz2PwojEdn6kX3
 UG9A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784536833; x=1785141633; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bZxiAV9mmN2tKd8DiAqS6HbtAfvP1UumvFStr62do4s=;
 b=I+rstk9bUPBVt3KY+VOO4YE8siAviZhFqNyVEos0LzdOlo2sd70RcL4tkRtNQ5FTlB
 M4nD1xW5L9SayX9ge1uFMWox/QtSKSCQxKg8aJ4EoGG5HapbpGsula9BZIG6qJocCCyn
 VlAOnmqpwyHQBK1u9YY5Kqu7wFPACi4UcC+md/AXRWGQwlclyGTQYtljde3imu19P8m0
 q/I7CKW3fSJhEZUu3ux3ZJPy4usslW1C/17a86XiPYtlxiypCN1sRncxYjvvs91O0sZa
 R1Y5X21QDeZrJIVDWS+QEmSTDSn2/TM3VgTRFVXHq+u98DIF5/4OwGa9SRv1NnSWdmy0
 ttaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784536833; x=1785141633;
 h=content-type:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bZxiAV9mmN2tKd8DiAqS6HbtAfvP1UumvFStr62do4s=;
 b=TQ+PZZa7+3M6Mx8sD53UEssq04quqyOqAsD+hoQNTJrWlndOBkKD/jKjuB4P78jIpU
 xFUmY4I58ka7Vy/8qivlI3RbwemmYYFOISwr3yRhck7kwQh4CcuapH7mC4nRp+1NCspg
 R55kd3oeQuNQEVBXfoA3N5XQ9YAIIzd2Ul4Mv1wtC82s/mQ1iN3a9hDKL/Ar4trtbaPx
 2wO741YuUNG10DjKoGEN/G2QNugaaBVokG7kUfun/V7CGoKzD7buoR6iTZEm6KQQTg2e
 ZZbRkTGxzUn36sL0eg1or0Zs1B1ntnHb7/nNCu3au86jpZ52GlpfiGDpsSVNCOMrGja+
 RY2A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqgV9o7GHyU500nLwNAmk+cAJlSSkDRAyjwyQPOrGaxXH3VJI/D4Sw3g9N68w1J2+I5HEoYfJ43eK29@nongnu.org
X-Gm-Message-State: AOJu0YzumqAZwnTqj0jlef0IgO9DfFjRimcY9JRGi0a1ZM0daI9JV5qw
 pHH87M9PJmJ7xeAGaEM4AuhfPAEDE2/eGCV5mFxKgu7LW6y2X87HFRZ/MZngfu89rHe3g/I7+7/
 vzMcTcH5dX9y3/6ft1POJe/zOzWPj60fWJNxEXugyj82Y33LO+bxb
X-Gm-Gg: AR+sD10o6LVLkDnI4TAKt9ylVJZNg803JvF0yaEIkI3K/DkMPBE7jIIGsvX+WXjhJod
 XeV+wGr+U2aTPivhhX7dQv/8ApBtdrPawyKToG5r+AHaalplmD2bHHCMuu7sLVKWw/qD2ZGqlr1
 UkoSSQIfy3M+hGgdmJ/23TyBf7p54ErKg0dUbHKaOTbq2VvZQUuG0FMtv14FebzC52sCyLsV5WF
 eT712C9cLqE2mg7mJxkRvs+xJJtqNNKSOrpyT4b6nOPagfoZ/rOIQW5HpZYfeFP31QrlONA0/VF
 OMigm4n2i7OJdaRWj2R225C4Z0uKYqY6RjptpE9K4dMCaQ==
X-Received: by 2002:a05:690c:e3c6:b0:80c:3848:bde5 with SMTP id
 00721157ae682-81ef22ca309mr40703187b3.13.1784536832835; Mon, 20 Jul 2026
 01:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260706173324.804340-1-peter.maydell@linaro.org>
In-Reply-To: <20260706173324.804340-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2026 09:40:20 +0100
X-Gm-Features: AUfX_mzC09RSwO90MVs0Lc0hNhVQoye70CqtXuGEJju5bC9v4QVdZ-h38IgrMiM
Message-ID: <CAFEAcA-C4t+=KYiX5sk_Fj528u2MkB4AE74gC1yrWTzAxmTYew@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/display/exynos4210_find: Clamp windows to screen
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

Ping for code review, please?

thanks
-- PMM

On Mon, 6 Jul 2026 at 18:33, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The exynos4210_fimd device has a setup where the guest can program
> both the overall size of the LCD screen and also the corners of
> "windows" that define where the guest memory should appear on that
> screen. The current code assumes that the guest is sensible and
> puts the corners of windows inside the overall screen. If it doesn't
> then we will try to copy data to an address that is outside the
> interfal framebuffer memory that we allocate to be the size of the
> screen.
>
> This patchset clamps the window coordinates to be within the screen
> size. Patches 1 and 2 are simple refactorings to make the third
> patch easier to read.
>
> This fixes https://gitlab.com/qemu-project/qemu/-/work_items/3795
>
> thanks
> -- PMM
>
> Peter Maydell (3):
>   hw/display/exynos4210_fimd: Factor out finding screen width/height
>   hw/display/exynos4210_fimd: Pass width to draw_line functions
>   hw/display/exynos4210_fimd: Clamp windows to screen size
>
>  hw/display/exynos4210_fimd.c | 54 ++++++++++++++++++++++++++----------
>  1 file changed, 39 insertions(+), 15 deletions(-)

