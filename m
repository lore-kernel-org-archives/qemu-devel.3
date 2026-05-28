Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4FECD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 19:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSgpK-0000gM-Il; Thu, 28 May 2026 15:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSgpI-0000dX-HS
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:55:32 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wSgpG-0002GC-Tt
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:55:32 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-36ba706ab46so367434a91.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 12:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779998128; x=1780602928; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=anWJKREvmH0hUUm3u4xrZcH+XRjuoFAKWiLtHBa9ynA=;
 b=AtL/MIU9PhO2TxgagVW1ijIksxg4p1Aj+IcfnAap7wYfT1Md7RjeSvXkTraNS6ys0Z
 3LT3dJ4AjtPSvJKdzpbePXGyUbLCHv0cEddoMlfMyHE5Mw09DGSQcXLq5/lvUD4EAXSb
 bc3L1oBiNe1Czu9qXs3A+Dru6x56j49UvPzCfsL9rK7TxqYjjw1jth10J3dugOU65eGf
 F76AjbEAiTRuIMSmNvUkPpumUv9KwrDxL/C/0OMuNnPvBu3zOEyPOyhiKsWqsPy7OhqR
 sPJ1Xcztw2502DRonY0RRtYpkcg09hS5G2F4ZlLCb4w92Lqtx+O7XUinnv7CyZiydrEW
 BeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779998128; x=1780602928;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=anWJKREvmH0hUUm3u4xrZcH+XRjuoFAKWiLtHBa9ynA=;
 b=IP1Qmn66beY/gUO68SY1bCqyBF/F/bTLU2UEsrTKNN1OCyVP1uTnNDvxENDqTY4LX1
 1037h4nhlEw69iqSYkrvBAO8mC4H4qbvAROTfbmfUGouscJeb0QirM8gmhMA1e/GZIwg
 TBQEkbuxxVcF8kcnDxufMx/ReSqKSFlddHZvfDkxlKfLqBz7vy59D/h73ysGDElCXMsp
 HqifUMp8JsqK3a2CpzTUOSe71NZUM4IXTgCssHPFOT5gcfdoDD0Dlfh9QhWkXQk1cJJd
 82dZY9t12uYg64RlI1qM3sqxDy3wSYpj8I8tJ67jxShkzls6+yxdHUG/ExC06zj/lS1h
 /AAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+kbv9CxEyN8ZyKfXSrQqtYQtjSL170xVFSYsyfrdbrLjsgqkrP8bWlOgb2efGKP/znN0ugOnB161N5@nongnu.org
X-Gm-Message-State: AOJu0YyqhuORKqWk8q2VzuRVxsRDLkJQVn0fBWVvsnb8Tsp635xB2gRL
 GvJ7xM49XpKgLkny6rVfL1rekp/kDycyzhBxoHZr6s247dw3wquW2PQGccmdQp5iCDg=
X-Gm-Gg: Acq92OGpSSFDVKbVm2lZNdxq/DtuUVsm3eZ8uA6NBAiWNcJZfeC6LlT0OhP508vOesb
 9X67YcNvSOlOIitqzn4njfBxZVuUnj9oUzRrBoulEqikVSg4KH6wiKRJYpEzBwX7lyB6M2TC387
 cgsrKU923u1pVS+70pNFkY5KEnkypOoygQHSr4D9n/MwCGgYOirNkR9lbYdqJG6U4bzumW8SbdD
 EVhyaqPA0dMImh4WBPud8RI4NNpVkxMKqbI27H82vHTOstIZnJ2vjoqtyAk3BMp9WrveIeL+Ger
 KUmfmQ/BJYMZ8EE0gaMSVpNahFHrdrW8B5LOhXLvNyNN7tnb6/8zenOqhiuB0a5LeCUasPFEh7I
 EJha+rEbxm2BUhqEoFrYQEOPd84c2aBkSj/gjlvG/8ytkkSrOztbGMNeOXOhZqrmL26XkKiM8km
 gbpnMgxF1jadX/r9XNVCgx+uCQZT/JTVkRvMlMNbZqQNb0QrY=
X-Received: by 2002:a17:90b:5112:b0:367:b8ad:f0e9 with SMTP id
 98e67ed59e1d1-36bbcd8e1d3mr28996a91.16.1779998127967; 
 Thu, 28 May 2026 12:55:27 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36b908da728sm2266566a91.3.2026.05.28.12.55.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 12:55:27 -0700 (PDT)
Message-ID: <a68d14cd-e9c8-4c5f-bf55-560e6955cdd0@linaro.org>
Date: Thu, 28 May 2026 12:55:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] target/arm: advertise FEAT_RNG_TRAP on cortex-max
To: Jason Wright <wrigjl@proton.me>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20260519153249.31100-1-wrigjl@proton.me>
 <20260524002617.69593-1-wrigjl@proton.me>
 <20260528181857.92087-1-wrigjl@proton.me>
 <20260528181857.92087-3-wrigjl@proton.me>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260528181857.92087-3-wrigjl@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 5/28/26 11:19, Jason Wright wrote:
> Set ID_AA64PFR1.RNDR_TRAP=1 on the max CPU model so guests and
> firmware detect FEAT_RNG_TRAP, per the Arm Architecture Reference
> Manual for A-profile architecture (DDI 0487), and document the feature
> as emulated in docs/system/arm/emulation.rst.
> 
> Signed-off-by: Jason Wright<wrigjl@proton.me>
> ---
>   docs/system/arm/emulation.rst | 1 +
>   target/arm/tcg/cpu64.c        | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

