Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483B8E9A777
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 12:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w50UU-0004gc-Tk; Tue, 24 Mar 2026 08:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w50UO-0004fp-1l
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:04:05 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w50UM-0003x8-2Z
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 08:04:03 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-79a46260385so12757457b3.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 05:04:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774353839; cv=none;
 d=google.com; s=arc-20240605;
 b=R7E3Lit1Ztrvc8h0ea6QQv33i3devE2fk5YHCTCAz7PAmcbIeHMCjPk/dWtshWRkO4
 6uR1uACr0455MiuZR1O6IvfXoQod1/E0xKe7VG3OM+mvTPWF77eTto3LxtUq0uoyvF1q
 48dA9YeUqKZ2eMbypCEks3lVjw78a4MCg7dizwHkFRewtbOUHMj8226hfEwRgd4WzUBS
 k3Wqo64soOyN75znV6eoca91O1dOE6XRDPTPWrC+4g96i3YiWl68iGRL93rgkzImMCvM
 dYDm5gjnbqx8calT1/nBozAqNczF/rn7pEwaLKRUfb7qztv/KAJSdO8DXhjJLQzka9/P
 YEBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=r7gq6yBnpG0O8tu5vXuylAbnJyVvKxBGP+f8Ge6CaOc=;
 fh=o9NNXRRpR1snqmakVgbq3eXDVCQ4hGFs6Xd9sNLXLEI=;
 b=jkqKIEepIYusIiNar1z2ce4+RWxYeWmqX/47cgYJM9HDhvGwzaLlWSb0ASi2Dlv5zR
 wXkON5/b5WtrEYjaDm26KwFopAiN+TTOdwanDJ+7ti56oqY04F1rHetel5qqHeJl8Z+l
 KWKvSJwUlVbTET2lUuNU0PPvQEvd6hKxLyQbw5e+ZfTChjVtav9UKuCUv1CBggVp2AzH
 Hn5YYjrEwE3VqZgHAUXotSYXLJ6Pg3xQ59+pxhGcsdK35kjNqV0b7XzwVNADsGYpHx0h
 GEAC3zIje8j18LA49sFcM2kg2PUCfItAraI97skI+lfqaenb9SI7Vhep2YO8gIrPu/SX
 EZqw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774353839; x=1774958639; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=r7gq6yBnpG0O8tu5vXuylAbnJyVvKxBGP+f8Ge6CaOc=;
 b=xsobDZ9vHoze+Uf17qQmmH66tC6WDmfthHoFVOw3iwq2e8MzgoQ1NMMx3uPsD7i8n7
 +mSUFaCF2ikV6qosc3KW6CCRju76otLFdaoo7gyUbFn9vjeaZGvjCQzS5u1vDLwzpaFH
 UJ5L6+1zL57NGMnObDItLOZ4EZzBFxd9uy5VMH/99RgJLvEbfjeXKA6P6EXMuagPwN4n
 V9fWsTaokjMT62sF1yLmijShG1YC1bOYRFGAoTTBDY+hSOaxPbHBdQLnQbmAnH0an1F/
 bdRJytSKik6mhI6zb9Do13zmqZcnbtTAsxAtJXyBwm9qMH/0i5wrllNBeAdST8Zzb+3q
 0+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774353839; x=1774958639;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r7gq6yBnpG0O8tu5vXuylAbnJyVvKxBGP+f8Ge6CaOc=;
 b=PY5Kjp8n6qhJEz/u+tNdFGVxVLuVBq6rqcPq+kOXwgsFgUZyfF678qelgG5ZaF7sa1
 Pn7Z0nTeXfPSEV9hDTQsdMCmADMmuHoXxIho1tkkWhlht4zepc4Q0F5rVLAC4+Tqigs7
 /p6GojnPT9CMdraCEqQVSoC9l/O9Blxw84mw78moud7pH6HCJfQxfCrE4dYBnajQqizt
 1kYJeuCbZbFu8KPeyumzz21KCBFPNFfhDzUUJCaWjAe4gn09NIUHTnWv8zTioRG4VBAP
 XbsPnnxihnVWTxHXx3Y2+u/ihMyeO7/OQPK+mDSdHlVupnMS/xOriW2nBWMVXIkvQHJu
 rtYQ==
X-Gm-Message-State: AOJu0YwjV5wAOg3WZuRbc0B8tiqPwPhd21Al1jVHikV2cDAWYNPngDrJ
 fllXdoisjrhVXf7rDewliR7JsNTlIDbh1lYkSVNN65qvOv2s9gHHokdQsF8WKvNrTtaUmTQSSvA
 wOmedKAnmLw9xpeYGOHpjSJD6Asm19T/PchUhZSxr/qMbblKNCidI6RM=
X-Gm-Gg: ATEYQzxLCzrfTFrXjoFvtYYaEki+4OkO/ZNfMwimATLR5X2lvPVeC/m5MgMTg9+NsLY
 jbky5YmhxlM0xoNv/74kTTh2KGtHHVV5ZWNzWEyEmUylxsTAN/Y7+Wezkmz9A+2DtAMQmjrvxNa
 g1kGHUkXHPob8sDdPpOSE1SxQmIyIv1HtQTpnNq0ecG3R0DqtlOuxIlxWPodKsVQ2VOpAcA8gFg
 nHFko/Ktm/ptNqczB28g76y4LJUSSPEdfv7SeqreWcWog057aU+en6Q+124CLo7Y9Acd2rpb6s+
 LNInRImHcsECE7sTr0yvBQdUlYNRWtI/ibspPynSdL9VuZFck3/3evfvt2SEx+rREF8=
X-Received: by 2002:a05:690c:e72c:b0:79a:5384:cb52 with SMTP id
 00721157ae682-79a90c19cafmr125422487b3.48.1774353839083; Tue, 24 Mar 2026
 05:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260323165736.386677-1-mjt@tls.msk.ru>
In-Reply-To: <20260323165736.386677-1-mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2026 12:03:47 +0000
X-Gm-Features: AaiRm52atFp1oFeyE9BUGIMrK7S2CX7fx3BgaxuvPZO8wWw5I71JLfQz8UXUQBA
Message-ID: <CAFEAcA_RTauRjGo0vBQ38w6eTQ3MasR3xurTaTfp8zVk8TC=Dg@mail.gmail.com>
Subject: Re: [PULL v2 0/4] Trivial patches for 2026-03-23
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Mon, 23 Mar 2026 at 16:58, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> The following changes since commit eb153d8fd3be325a5aa7e1a6a73be8854eeaaf27:
>
>   Merge tag 'pull-target-arm-20260323' of https://gitlab.com/pm215/qemu into staging (2026-03-23 10:55:20 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches
>
> for you to fetch changes up to b7ae542de40364cccb683a67e5f891d3ef69818f:
>
>   Fix several typos in documentation (found by codespell) (2026-03-23 19:55:24 +0300)
>
> ----------------------------------------------------------------
> trivial patches for 2026-03-23
>
> minor u2f tweaks ny Stefan, and small docs/comments updates
>
> v2: fix email address of Stefan.
>     (not resending the series)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

