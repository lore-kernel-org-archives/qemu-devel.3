Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A47C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 15:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtSDo-0003gf-5p; Mon, 10 Aug 2026 11:47:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtSDV-0003eD-1t
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:47:13 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wtSDT-0007Pk-Dd
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:47:08 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-81e9f7491ffso27564047b3.0
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 08:47:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786376826; cv=none;
 d=google.com; s=arc-20260327;
 b=ZN/iX0BA1Gt8bXOneRLrPUys5eDNmfwDnlpijraqP+YPanRI8mVklsyHzRUTVB8WTr
 n9B/Q7XVf5j1Z8wS4ORYIDAsIB1nsm+GJxc+PPoEqBEi8VbgjpPnpg8D6BdnlmbgrZ7i
 yRRdA+SscxU1R4aiFp+hDHFfeLUN55qBbvJTg4bDxRE1k2j46i43BVRK2QMx2lrlp7jB
 RSm854FCJNOY3k7aRund6x17u9Ph5XLwo/vJ6br8ww4khGPc4ShIrrE9UGlHMwbE1ieJ
 vcmykattywnSgwrHEUro3a7+TPzXUwD2JpqNod8zBvCmgZ21ZqrMxpo0Lk18F8fonBiq
 UjGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gdkZItnSRuRw4/riKLW3/+iFL6j3dXnCAEX1VMxJlZg=;
 fh=yQJexhFxNZ8AQrdz0beskElJZDvKl1BlTBoJLzFI/rM=;
 b=bEEnmn0NDKjAZy070aMsIEJxK9EUdvmzt5KlLaYc2CJ1LknOepPZan8pMEHyopKZUt
 SE6+wDqtxOLJwUcuut1HDlh3uuoFZRmTJy6t0qTsRFA/KoeInGcMdcoocg2ufP+ZrO1g
 rQB6UX7Nk5KYmNzQxqlOIT8GsOjYMSQ1+Ce9zXcebS7BTAeOGO2+QNbeVfgsPPC+v3ha
 BGIvpl939LhFU2Uq0WyQQy+I4NtM0CbVmucbBCDAMYHhLn+Lehk+fc/HoJrTVGg3Pdfe
 u8zZfY5qdvtPPRgL09bQt+7Js5EPcgT3WUj7hziFWx2IVOSUGf33xwvw6+P549K+rOcK
 jHOQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786376826; x=1786981626; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gdkZItnSRuRw4/riKLW3/+iFL6j3dXnCAEX1VMxJlZg=;
 b=ITr53VECHuxK7TqN3OPtDNhEituWdg+N/3SNSq7gpYMOPrmLApjhBOpKtNXbQ1lHuN
 IgGls8vemSCI81+qhPwYNOelebFX8oi8RRabNCmBSpBauO4rOjQAoET7fbDQaJO8Io47
 xeeFK7mu+rN/QAwmOXL+S4tATfYr/7r2L9H1vlx19c3DvbVASCoACjrnKEi9f9csNkt8
 zf6fF0SL3mnUwra9DDVuHtmMAipCB7iLbizUQyhMPWmX/hVDz+0ZKPAWSbUYYyLafnPi
 21u+Q1A5MQQay+eU1MCBExmo+PRFwkjqWlDDwHFldcZTXkET7C6/LiCV4vGGizhosSRI
 mfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786376826; x=1786981626;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gdkZItnSRuRw4/riKLW3/+iFL6j3dXnCAEX1VMxJlZg=;
 b=EWUwb5HfTuKHDhSvAJLJsJxK/oXuMvCv6/8i4jvYHXTerye45s6UoxxeLGfNqgl2m4
 HhA5zTnF1U1UuBNHxHg3EOK3WizYrI/+/e6fz5xKkNgV3mwRyUiQyfdAJn4B0cof8DMR
 EypUdfD6L+J+QktmO1mDIMgQrE0vRsHtILvwRcHfzQfoGIwrhArZ5ZA4l+Q0N3m/pkry
 YN7NhTl0NlWP3+5f+yFVEXxvPO3gVnL9Em/L7OX4gPxJ6LFCcSU+5H0l6w31Xs21c3X5
 UvuFcbmgv+TVK2Z6GFeV2+WPcshcpfny3rinZFGTii+ugKCHq9Urzlpc+/PUDt4N+Wyh
 YWdQ==
X-Gm-Message-State: AOJu0YwY60zgn8rxCZREkQIsPcbkWJFljA9MscVgEGUd0YrwI01ZjODB
 g7V0fgECNe2RWqA9FsBMHmgB/RQsZp1dSX5hXpIICw7LMrRSRk+f+hIlDDKMuO4gqVVJw52PrJ/
 o9xV9Avo3ZLsZ4FcB2W0qFenZKuhUwoAMI0Dwfo/rKw==
X-Gm-Gg: AR+sD13BqfzUn4QAAG9HYBULIaMq2JPL0nuBiZHGBlO7R5csDyjrT139qT4TGUPN0w+
 rclpqyBqovJFZy2iQLAJ1pNdq5o5lZJZADetxvIMrnHyoNSgt+1NM05xp15AmeLcZawM4c+Tfc6
 c5pMrrWtsWRA7isxh5fr+nJh1r1k/CaMppXuR17VVkHOSWai4MCwA3izq+1T7xNqieYBpJZ0piv
 ul7B9+zfgAmP/mT3auVp4MlEOPV8u/DiLKFTHPJ5mCTRgNO4pTEGeW7y6XYnbXCfVrVi8HxeWqz
 dtW0WfNjoIKLyt+BKtPdl/MPYC9pRvS5ld/1+GcjxvHWEhnwInShpGikp8WOL/dkPa0GWwYSkOb
 1wogAyYpYKd+Z9ZWvgPxVUC5Hkok4
X-Received: by 2002:a05:690c:6601:b0:81f:e85b:f9da with SMTP id
 00721157ae682-820229c183amr243742977b3.33.1786376825947; Mon, 10 Aug 2026
 08:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Aug 2026 16:46:53 +0100
X-Gm-Features: AUfX_myGjd5g_DD88Cgopr4RXqPVi3niqmoMkBqpaF5kmy8i4HcdG6EO20Jn-1M
Message-ID: <CAFEAcA_h7t7hF=i0xSh1DLq9Dmy-VL+fBa09R5RS6BOTFXLj=g@mail.gmail.com>
Subject: Re: [PATCH 00/27] single-binary: implement dynamic filtering for
 machine types
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, 
 Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Fri, 24 Jul 2026 at 01:09, Pierrick Bouvier
<pierrick.bouvier@oss.qualcomm.com> wrote:
>
> Now that we can link a single-binary with at least two targets (arm, aarch64),
> we want to make sure that we expose the same set of machines (later devices and
> cpus) than target binaries. For that, we implemented a static filtering based on
> target interfaces that each machine will implement to declare which targets have
> this machine.
>
> However, we discovered that this static filtering is not enough. Indeed, some
> machines and devices do not depend only on target, and their presence can depend
> on Kconfig or host/target combination. Thus, our static approach can't work, and
> we need something more flexible.

Do you have some specific examples of where the static filtering isn't
sufficient? I can certainly believe that we have some at the moment,
but I'm curious about how much of that is "just by accident because
ifdefs were the easy thing to do" versus when the filtering makes
sense for avoiding showing the user things that won't work.

-- PMM

