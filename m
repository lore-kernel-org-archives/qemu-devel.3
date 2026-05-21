Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569D2CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 15:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ4vZ-0003NQ-QU; Thu, 21 May 2026 11:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ4vW-0003Mf-5d
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:03:10 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wQ4vT-0006kN-R7
 for qemu-devel@nongnu.org; Thu, 21 May 2026 11:03:09 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4903f7a90d1so1905495e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 08:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779375786; x=1779980586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g/8TdZZLqQDwmZI+2nkbFfne172OX66KyKf4tLY3HZE=;
 b=nHo4qlBZVfMn9EmUunP/d/y4gE1Fq7UTmk6bOA5PRmBwe7kCl8NXCJmota0gLaSeLs
 /xVr91hwjy+ZgRU2l9cc2+jwW4e1dK2Tp3RsXTy0cRtGAecyGr92Ugkp4MTUseS52her
 LcRCdq9UXsEYU1ZrI2ad4aXubrdgArpiGDCelZUZGIT0uDI3L3fCQXp7ZRrk5bTgCc46
 u0RvzI/ljSPO3rM5l1qhp35KpaUhXtkGMy0sryJPoLMNwd99FLZloJTkDuld/Bsur70K
 xiY0Ius7DHkotoGqR+UriHeBZtx5DxAZTtvUisjyPb+Y64NczKmbraW98IEEOCNwRSZj
 pWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779375786; x=1779980586;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g/8TdZZLqQDwmZI+2nkbFfne172OX66KyKf4tLY3HZE=;
 b=HnNvS521aOPC13XMQ1RUV8VlBlNIzF1r4w3RICGyyPN6IIoJq+89a6jNBgT93TNtYV
 xKhp8AOM02wYyKMO8IptEM18xgWxNm1CDaXrK5fPfEyiHNQdNM/WM++FuVMdW4LWDfWR
 GYY1SGPb/iWxVt1X2azluUMw9vENzmT2E1ey0TmhXrEBBha0//4gBDfP6UnOXT2qmWwk
 9W+/FpE/Ew7R2o9LuPAtjrTZrNA+kwhMCJNJgxa0KRTAu2iFY5yaRo+ZZ9O94ORW9f7r
 og56oliAmdkSKjcrEzzdV9VSRx0KQ7nz+CeFHLDJQwJg9n9StlAn+flypmN9Vipvdt5c
 40hQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+BHGOqaFC9WuV93xn1mAdqQH9ZkmbrlfTdSVnwbUDZX842r1SN3sFkvDWtDxw7+6Oi6x8z9+PdSkoB@nongnu.org
X-Gm-Message-State: AOJu0Yzpn4iQIgTrVGDtRH3xG/lp9OKShuYmfzNT59H6yuJd6va4OZtR
 YgARQKNX+4xXyOdU1w4mJoHbnYzOeg1mOi1SyYY+DynwItZGmyNfMJ4uN3PaRuTNFMs=
X-Gm-Gg: Acq92OE74WAu83xlbcn1qrA3S0g/hXkXXW61HUHqOuwJ5xi8TaqdTJkmknb4u0/ayVc
 XG5pREDGAmFDUgCHsOYA4onB71XK98USTiCmPVVyVbCFjkNglLk/zzKdXV/x5gqxnATytj1dbLq
 M6Fml9vTxvmhvaDPsJ2AOekl/6pd6+PDvVnmhuEPl7oHGIS62ARbOiinxpBotzBNROgaCeesvbo
 wFuGowWPEiUjE5Arf3YXiGKyoHcS9sfJsVXo8cckYMp5ZcRRVIIMLPgBKKk4eZN43nFZ/d86GWP
 taHSYKSjC+KmX5GZv2dWdPml9IIk2W/s/sjbE/2lxluqo1+evvb71BK+SGOM6tGK2AeISJIj3bt
 RbTuz1SPHfPuVkv/PxzyGy6wgRskNaIUu/Y3blh1fHy9r86Wa5WJOHdl2orf1s5pA90E/x+yIEZ
 Cc1TeED0SIyuJfOdmoKdLCNTKzciMEY2Hdhg==
X-Received: by 2002:a05:600c:468b:b0:488:a824:fdff with SMTP id
 5b1f17b1804b1-490360c53c8mr50881125e9.22.1779375785915; 
 Thu, 21 May 2026 08:03:05 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4903c99cb43sm31470915e9.4.2026.05.21.08.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 08:03:05 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 61D9A5F886;
 Thu, 21 May 2026 16:03:04 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  qemu-stable@nongnu.org
Subject: Re: [PATCH 3/3] target/arm: Set correct fp flags for FLOGB when
 FPCR.AH = 1
In-Reply-To: <20260521122913.1565011-4-peter.maydell@linaro.org> (Peter
 Maydell's message of "Thu, 21 May 2026 13:29:13 +0100")
References: <20260521122913.1565011-1-peter.maydell@linaro.org>
 <20260521122913.1565011-4-peter.maydell@linaro.org>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Thu, 21 May 2026 16:03:04 +0100
Message-ID: <87h5o0olef.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Peter Maydell <peter.maydell@linaro.org> writes:

> Our implementation of the FLOGB insn does the operations entirely
> in the helper function, without needing to use fpu functions.
> This means it needs to handle all the fp status flags itself.
> We aren't setting float_flag_input_denormal_used when we
> use (i.e. do not flush to zero) an input denormal, which means
> that FPCR.IDC isn't set when it should be for FPCR.AH=3D1.
> We missed this when we added float_flag_input_denormal_used
> and made the fpu/ code set it.
>
> Add the missing float_raise().
>
> Cc: qemu-stable@nongnu.org
> Fixes: d38a57a3f ("target/arm: Enable FEAT_AFP for '-cpu max'")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

