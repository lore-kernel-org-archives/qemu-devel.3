Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FD3FF60EE
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 08:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7UbT-0006r8-UL; Tue, 31 Mar 2026 04:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7UbQ-0006qt-Nd
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 04:37:36 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7UbP-0005lm-44
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 04:37:36 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-66aa2204e9dso79022a12.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 01:37:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774946253; cv=none;
 d=google.com; s=arc-20240605;
 b=R4FL0KJ3AgfXI4jF+CJfr4Uf04CxPLc2ffumcfWoxOuo/K+p7PfrHj5L3pPdz9gX2d
 oeYrFFtjm6gJ3byswb7YSYOEVGqZaXgdhPn1LL0bplc46IJ1JC8qhKx9Jla1qwtCY/+O
 XMUQnv09cbZaZgMtwbdTdRPmyA4Ql3rlMFQLzdELBIHA10p1nUqf8F0JnARBaejTQxnw
 zrU4Spo7jJvGxeIaPIdANXdi+EF8csp+HeanhOZ3/hB6nUBOHrx/j6uBR8Ij6IbwQClz
 +CP6/k1RBDM6XELHUPifGrxgq+E71EP03G9U8ematJgrB6JComCyxVHLhebZGtOzyyR/
 ucWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=+uqtgV6HA1q3+c9dEfyiuKwP1ezMGxwV+bF3jSIhz54=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=ir0XDlQjA3ru3MOdMmPt+sWF1AICsNO5jTQza7NQo6zmaRiqFLtuM3YSbPko8y4H5g
 LZ2NDbG6Ax428lWqW06w+czFPPSj/2Ny1fUrXVE51H/rpuOG6jnma7OqLxhRarVq2mN0
 1166EpNA+dlCLL1u/7c/5K8ITJNCG4aP0uBFVklOih4nHTVKWClar4nN/vRcuhWxWJ2p
 GyKl3dHGry065vQ8pCZlsod/JJuUnRb9wvYDVR0PW6GWQNILO0GYgGdDRAa36XMbL1lB
 0IIjRj/dJJ1coTKQLzjeTB7zNYDQCvxEmCeRUjVcyDX0JEXi6C6ENglizd56FmXR4t6T
 uV6w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774946253; x=1775551053; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+uqtgV6HA1q3+c9dEfyiuKwP1ezMGxwV+bF3jSIhz54=;
 b=uS6HcQXMpIJpXqFB4sWcXasgfjMaNrGs++E+XRtedjG8iy9yEZR5bC11n0qxfU5wzs
 bcjq74OmyyM6L7unAhQJUpnfqzLNEW4kbg2z/vHaA9d6QRJoNhX0NNvbVW8QO38BzKz7
 kgRQrQlv2WS5CyAmQ60BupXRJwSN0hMjOOyrlVQu+xsczda96gA/wI3WRTQEVavRXADj
 N1SUgoQtkY/KyYNEnVPl5oSN7Ld6ZmL7jjjc/Tk3nJbgtK6MEjf/jKTB4pCr1767LQlE
 mF7LBZbowzu4CJ6NTvA9sSPQX7YdcgggrjG5WofqwowvCh3+we+5lQYKj1kW+yc1mqNT
 kBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774946253; x=1775551053;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+uqtgV6HA1q3+c9dEfyiuKwP1ezMGxwV+bF3jSIhz54=;
 b=f+DweFgfKzE/iVl8Uur8mG2D5NA9eJGMv/Wh0+DbNgB+/m5AEwzCUeusod5LBKnoQ+
 txYTdwzggOFIwexUhAXtb+P2xyM0SP4orer/nDJ0zYgG7hHoUrc54tKIAUP9Hv/7lMfQ
 8uANNhTRq6BdYBqN4m6BILb7Pmt+H6Fai83okWlXll1KS2a2eMmFUfy9tX7OxVZudh7C
 y3IndWZjw3H3efm9iEnGmLwxbmusSPPg2lvlGFK4IC9xQMDMXy/J/R3yyGzfnn6pxMEp
 9xxOur4CcuKJV50Lj0wJ4rVG4Kn8h/Or8DH2szqg7KnYlJ98cRM7VDwfJFvqIhZTeBYC
 w8Vw==
X-Gm-Message-State: AOJu0Yw5ANlADzHtylece48G1cLeSBb/uCvXMCcFAQA5zTI4h3THHEWY
 1iDWJKAxupvKVzmpYy3JcfeMHX58pnNR7p9Gkw4/ACbl56oijtRtGwn8NVQ/r92sWC4h8gNnSBn
 OaodMSTMp7ais9GzI7F2oE2Jlt59dnWDKu4/algWHCaDw8r5PB/JoJt8=
X-Gm-Gg: ATEYQzylrRipYnhzcQ/LrsPShhSpBCWwXBiaufAJ72BvJVl5M1XyW756LgSUlLhRQg1
 XmZ2YRklqkSgoOm0zga/kcBwkC44iBzgjfVtFMP5u+Az4dghw5Nb6vqd0rgZ93WjezeLOXE7Vx9
 F78M5F5uNFQegoHXZ+rFQlBB72tphrswn3T0svMys6X0rjllVe4pnpd9eFh+D/N0ZzFlIm2s6h1
 ZjsaUuAkHk9ObHsdZKZQFBkNSbrxAKAbDANhk3wGi+izSqC9tItx3auKDMxfRED3837gX18vj8E
 ztX4g4OmxHfyRbbnr2VNxuuTz8LXw8p6QcLaRpRRtqS2/n1ae1Ffs47YWwMdkUS7a8E=
X-Received: by 2002:a05:6402:460f:10b0:66b:d73e:b5dd with SMTP id
 4fb4d7f45d1cf-66c3388beb9mr1037344a12.15.1774946252779; Tue, 31 Mar 2026
 01:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260330185236.1905636-1-peter.maydell@linaro.org>
In-Reply-To: <20260330185236.1905636-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2026 09:37:19 +0100
X-Gm-Features: AQROBzBy8xK6FGAWNij-BGE-_3cnC82DiJjaq8jH6L7EVH2QfurWlB1-7t3w5Ds
Message-ID: <CAFEAcA9Nj0ZFD=5NLgZ7tOi_FC8Tas8dBj9KxJ5YSk+Gq3m=Sw@mail.gmail.com>
Subject: Re: [PULL 0/5] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Mon, 30 Mar 2026 at 19:52, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The following changes since commit dd3ee9c63d96b223c8d41bf5d65392eb898be626:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-03-30 13:54:56 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20260330
>
> for you to fetch changes up to 36212b4e859d1ccb25ab37deac152d67421ac425:
>
>   hw/arm/xilinx_zynq: Use strcasecmp to parse boot-mode option values (2026-03-30 16:18:07 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * target/arm: Don't skip access flag fault for AccessType_AT
>  * hw/net/rocker: Avoid double-free of l2_flood.group_ids
>  * MAINTAINERS updates
>  * hw/arm/xilinx_zynq: Use strcasecmp to parse boot-mode option values
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

