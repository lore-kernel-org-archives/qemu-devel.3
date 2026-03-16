Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F71F506D9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 14:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w28rl-0003wK-Qs; Mon, 16 Mar 2026 10:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w28rj-0003vl-I4
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 10:24:19 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w28rh-0000kp-Vy
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 10:24:19 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-79a1e732e5eso17492627b3.2
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 07:24:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773671056; cv=none;
 d=google.com; s=arc-20240605;
 b=HybWsqsXmkJ/eO302tcMk57NkmXMCiBiOYwBTZpJ+w+mun0lBJykZmxvCx392HiA3U
 H7X0ZIks84zFrKKnRlhj4aVuSKEOSlf1Ccui9eLSUOwXZORiuBa/HEouFsWTMTc2l403
 g23mEJuHJc2IMW+pJ2MB735WCFHBsPaKnAFOEscmmtzfK4k86tqgskRF9gV2+M32mfhp
 mJu3EV9TozSke910JS8gjXgBVaT8pczT7iEG24dd2JAbRL/u8u/duzLIwg0olB32BqVq
 gizeDeI9l8Is9RZ30j5VHQcGKZcHWOlQX6fMhOt8UALXwHrwrmZYRw4X9VCEfasg5M1+
 KXJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VDA04NpZWwJQrY6iT1SQok0uwi8301C0SCSMaooDszE=;
 fh=o9NNXRRpR1snqmakVgbq3eXDVCQ4hGFs6Xd9sNLXLEI=;
 b=c6mwP7UHBBNjMoWwGXz+s/IJphdJHWJkxVLKFeBp0Kz32ndlErMQdZ2oBVc6OzZKvj
 4M3Slp5tdjtdGi/Y62p0e6gNl+ttjG+i5YxmWGBDj5pED3JLk34qXWm4wSKp0215u2TW
 /4RfWxMzR7KqehRscdwHamrsyEY6X7jPlDlfnKLAiK7wL1IB1gsqjwfwiA1jCIOxuFTX
 vbbXEIQ1OlD6GHyTni/lmH3hcePj/LxHzrWHf4P0OWuLLSwGA4fHldWae9hCXSldanuW
 FltE8g7IRmeLbqDKGdWanJgUfMtIAS9EC9D1L0csfYfi2WR50+5pE0riAdggAPj7LaKn
 rqMg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773671056; x=1774275856; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VDA04NpZWwJQrY6iT1SQok0uwi8301C0SCSMaooDszE=;
 b=qnQsbSICfiA0XYepnp487/H2VAnAcE0L1NrMbHISpy/J7iPelN30NTxcm6hX4/IXFG
 S0M70W7MDawI/pwFRF5ZKZ0lTT8XVWA3PFwra3noEqYJdT8NnCrketwcJCQ1RO9g0HKU
 E8h04farxd2xvvwqJ+RqZOpX4IhpcxCDxMIJgod7Yg6p/8Wpt+M5cpMLiKM7VADm1j7L
 l8e/kagEgZlHG7kvwKR4DUHqlbo7qHvSwGEphAQ83qD4fZ9uNK3Y4KxJf97BrlhJAtCq
 /UZ+WnODv5J1MMuhZ8pJy+CrsJGShNTbKjQroyNKcWy8j5Isllw2k7Z/Ik0y9yhW8A/X
 fgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773671056; x=1774275856;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VDA04NpZWwJQrY6iT1SQok0uwi8301C0SCSMaooDszE=;
 b=A2qDTDjmdXRsUWnlGD2uWJNdh8P50zFvgRrWpcROQsqOSB7/VgNcPp2pjIo+AY5zf2
 m7sxqlXaML6UCD2KMHgL0eiOnYLWNjFvcE9/Jq6uR4Z7XefgBcInpiWyK5XCV0VkH43j
 cao/2yucFcWwxqD28/7KG4DkcXYk25J9n+YEU+WzLAsUxxeg450bVon24leLeKGpeH89
 0bh8bI9jr4Tmpge10A/Ec6vZd+jKNU9hbLSM0x+CmnCz9mmhBHY+MU8d1bvgOhNk8M9G
 PL6EM59f5Fj9AuiVDA9x+mMscchnr1/oFZW4IM6mOcZRIztOjQirgLNkniJ4zuqfDLBU
 tJmQ==
X-Gm-Message-State: AOJu0YzMDG+6MUDq0s5EIVS1C0l5WbQ/DM45yqdwIBGOBNq/G3tz5rkR
 e/IqKzBkWvz5fKLx2YTrLoHp3XphixPjCZgnxsP84tN9UsArMufHhbYZXLVArN0hUYXfVJqAEq6
 ZLZkpyXEThQmuYDIuqlH/ka/cBUOFG/nR//MO/sWMpw==
X-Gm-Gg: ATEYQzxf6y+uNct9SmMT5dLfHceil6PO+Ndu7ky4g7EZgLW/KSId9LoO8yxKbEb9jXr
 8tY3E0C+n5/s9dfcr/ubIhwbWi9ikncLN8kvqdqidMrsY1oVwGeIVMwV1j9Y5HxyFK07BbMwF9B
 HlTnRl2m7eK9KeKuTn/3E5e95yXVzu4dwXxQo6fDqwNTJrYLjVovNFOKBk0koyjc5KWfRHzVLuk
 3AUZGMXVAWV74uMIO8Q12z5pp0s05x4Ak9a5Hm/FCJA8C3VS3SBXBd8DWpeLYXGtZZgDimQ3sEa
 4VWekepvG5DCmb418NzonYPVF/mqppGHEmNiuwjKcFtNGzmLZdEDR5xv/MVIbjTvfpo=
X-Received: by 2002:a05:690c:e3e5:b0:796:357a:9ae7 with SMTP id
 00721157ae682-79a1c1d827fmr131533357b3.51.1773671056417; Mon, 16 Mar 2026
 07:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260316105244.107822-1-mjt@tls.msk.ru>
In-Reply-To: <20260316105244.107822-1-mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Mar 2026 14:24:04 +0000
X-Gm-Features: AaiRm53YZ_2fIp5w6JyRd_n1R0J3-r5wEAl5qsYO1_MWnv0kFEb_NgDyi0_IPq4
Message-ID: <CAFEAcA9LKPZZ4+5rL6+AOXghbsS1AgkaAi6B1uAEXp0UveHNhA@mail.gmail.com>
Subject: Re: [PULL v2 00/13] Trivial patches for 2026-03-16
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Mon, 16 Mar 2026 at 10:53, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> The following changes since commit fff352b9b6080e580aa1fadd29b4eccf4cb2922a:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-03-12 15:21:06 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches
>
> for you to fetch changes up to 7cc61f922f4b5db006e8f03d61208a3d652ed2df:
>
>   rename CONFIG_EPOLL_CREATE1 to CONFIG_EPOLL, and stop checking for epoll in meson.build (2026-03-16 13:50:18 +0300)
>
> ----------------------------------------------------------------
> trivial patches for 2026-03-16
>
> a few patches accumulated in trivial-patches tree to date.
> A larger part of it is my linux-user cleanup series.
>
> v2: drop the slirp socket change (net/slirp: allow hostfwd socket
> paths with dashes).  Not resending anything, just the cover letter,
> since the patchset is the same except of this single patch.
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

