Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B72FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJaN-0002Xe-5P; Thu, 30 Apr 2026 01:05:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJYp-0001j3-4o
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:03:39 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJYm-0006qW-SB
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:03:38 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so2412835e9.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777525415; x=1778130215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aDXTpQNx/c4JcGrw2JKpcE2jquaYt7pwzGcf88WYjHY=;
 b=O8kZQoHkeUHpnHKAd7vzMudXElzX3OP7WYdboiYVGmFxMx++FPDvY0oqNg5XdKCRN9
 BLMSHsXwo5OuQFcSYGCuEZeyj2gT75PQQCGKGrqkUhnseltLneW70y7lqITdNMNlWMPE
 RnnKYj3RgGM52RqdFuFBFo8Xw3hwZi8vf/UVu+m7vCZsR1LocSKpR1lJobUiIDLGuzcr
 HdB4s90qy2UhJ982XTA/uybF2d9Lok9cm9bwoxHQO+tfz5b+IYTqVZWy6Ofqj//dS4hT
 fCUe2Bcu+jxIwi/2NoCGGZIFsCqUuRTwzsaqPgI1J1N8bEe2BBWAWqe3bhAJleAFjCSB
 IGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777525415; x=1778130215;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aDXTpQNx/c4JcGrw2JKpcE2jquaYt7pwzGcf88WYjHY=;
 b=jVserABx6TmvjOuD53nVZzY8k+5k4SIirH8Dk2QJjIb4s6fy566tfAgv5ePNjgALzF
 GsCe/5p0yaprDjiaoWKVJ3biu2lXFXYaoqqFenGg7Vtdlxwy7MgtAKHOs1cor8NGYp5Z
 3WIAqcYv1WC9BKzElcFHhAktXlm3ugu/j0Rp9I6NJY+XzAjLOFAd/SBx0u8Bz/ipdonP
 ffD54gBpyI6WEWli4ojTHtTlYNffNRgP3t6jFGTjuOYTFTi+M6TxC5NwXM2pilmkj4Oa
 vJ26l20aGJ1yscMfbqM04a+ALq40+FVd+8K/6+g93yKgtXTktnebsCKvJHA96YBm8QCg
 bCrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9dFkf0hiqabZOx3RnDEAR/MRNeuQLSEkboNgjwp+SgfPN2wHL5icvjwmZv2N/NqL0Gcsfxn8vrpAE5@nongnu.org
X-Gm-Message-State: AOJu0YyhnEcnU4Q5x4e31xr1lDNHLkFu0tk+cnpIIVK2RqpoGA6sxYDD
 vBQKKdbwLlDKuKoxY0ftT60DWq6FHAq+FWTbYMIqbQyMf+xdMo04EK3dxNRQFbfGEIY=
X-Gm-Gg: AeBDievCf0LO+HhQRfmK6eHrqfCmQlytHbB74/PcLDk349XEr+Qkf196HuBJapjsvjO
 FuNKVL/TprOc8SbvT1/kNnJk6+DW3bZqUQo5vONpjtPYUH29Msd0moGvNeLdTLJi0elgqlSNHQy
 vjV8dBoZITBHnMstIIpGS9hQruxQfACSKxbHWAvuxyTwCRl0tBgDf8yU37t3c96sc2qj9gQcOQD
 WbAcoEKVf7IHgPo+Ka8F4P75nkBYStDTS55gGaXJHbrrFEPBIM5P637wo+T2O1lkiGzQz7tKlH6
 MrDfWolkhq/iAy4PUKBpZB4t3Tiz/Pid1pzckj/ujjw9UezQ8BVqnA/pxJz/B8b3msFmSA3XIaE
 Q5moXgDvOkjWJTwkeBHLkjN93gXDn8/1Q4j4s6l2Tyf9Nd7hpJpSWO5M5mhcGsCUC4ZyFkN2Q5C
 YV5ZxBddjZzXBwf+GUWqyWgwgFo4tfPvVAVHOlCnL/3B8YOJ6JGh0SEEqt3FVMM6z9Pn6lO+xhK
 1te
X-Received: by 2002:a05:600d:8451:b0:489:1c09:6c4b with SMTP id
 5b1f17b1804b1-48a83f6e2camr17629995e9.6.1777525415096; 
 Wed, 29 Apr 2026 22:03:35 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a82307f7csm38749705e9.12.2026.04.29.22.03.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 22:03:34 -0700 (PDT)
Message-ID: <2b7a550e-06f7-41fb-9ece-18b5832d88d1@linaro.org>
Date: Thu, 30 Apr 2026 07:03:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/40] fpu: Introduce record_denormals_used
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-24-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 30/4/26 02:05, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c           |  8 +++++++
>   fpu/softfloat-parts.c.inc | 49 +++++++++++----------------------------
>   2 files changed, 22 insertions(+), 35 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

