Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146D0FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 16:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHOss-0002J5-1J; Mon, 27 Apr 2026 12:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHOs4-0001yP-Dv
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 12:31:51 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHOrw-0006Oo-Of
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 12:31:39 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso145674855e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 09:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777307494; x=1777912294; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IZp1pSiwMH+5WuRXaoS+cnIfuOxZup82xhWZSv3nOAI=;
 b=M046ZNrxDPsGdMCylbZ2/L8pV0FpsCziTm2m+SSFMpIocFKmJTDnhrHSobc6vSlUUl
 1c+oNmQl6zqrLjcLG5I046ZLOiz1ZbJdM1U0If2bvCOfbkWtZcLtmK6PdejrJaZ7tO5m
 n5plw68gQtOut+YgwvdMrPr2GyA4UY4a+YpMlgE8RmsU/vkLaddeY8/ybxdkZC7o//IG
 Z7nVXsvJ3n5PeGmGm95MytCGaYOFle2q/xDJBfh362IEDdeH62nIQtn8gjBD+mANCAAV
 4Ph8YyORygHSooXzoQrumNKeDQd8m3XXC0n9jASXPU9EZVm3TvI43J8Nccm6zUYv7mDI
 dDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777307494; x=1777912294;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IZp1pSiwMH+5WuRXaoS+cnIfuOxZup82xhWZSv3nOAI=;
 b=pZSfS03fC279dRcn5gSOPYzTs1m+yJ4+xOd+Db0e+HDAGR1bkFmmTcBR6pA33Xh/1x
 nWC6eJOSr4BqlFuqBh46mcQy08gHWEvGELGEIUdpXzzr49teh1cA1gkxf8dPaP1OaQin
 +9kxXQdCTRYeSuAr1+CbZJy13U/mvKFHEoABDLJGyu6pjJd1Kvhhn5D8mZsDhDyLMK0+
 2mBN2lixS6VYv+gbz3thhDWHhmOuMPx2WCGtTcLuVakXxjTbdt0+o29L1siSmw529WkY
 Qeu8WBIjsjS0B2k/MTODvFyzDEzqL4IJR9+4vAxkwUzzJYX5Wosiz14nYhQMAJnTardG
 20xw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FFR/dwGw7NR3cUP61xZZvLC8ZQs4/Ah+5v3QZDaRbbBcVc5gu/1vQzpWt92NadCrbkt+55Cr+6Tdy@nongnu.org
X-Gm-Message-State: AOJu0Yw1MThnxMnQn4GXZ8dj8nS2R5zKSr6Hoj1eKb0iyI3g4sRPNX+H
 Wf+NaPPrNFYaOWjy1V/c8oFs70x7Uo2rbwhm3pIWPyo2v/3lPDQyvxXTxGx5JLyAenw=
X-Gm-Gg: AeBDieuejmeGCWFyN8OKPguTQPOJB/CAe/DLQqwlmuKuEOEggL/IAJpW1v6jWSW4vmY
 DqoRL9x1mpc3mK+R+QuN/Vl8sx5TU04NIL+tmGVGQABpw+Cpp+z9rG1D9hrw1zC3KQnauMrflpa
 qRNDyhU8qsfXfuFsnw4t3JWUZB1FbQfP8S8WOreAqSL40kS/vKynENt4UIlAcvws4lFSBo5jMNg
 shQQ2MqxqQU8VfnjrQ8SDxOQV/EpKGR4mxZ/VhlDPtKnUjQ1pnfCxvIjicbXTaxL2CWorY8LYT7
 vdf+iiuTojqVrWv7pYooCLmIbAEZofAiJTYmmpI5K03jeaHZFLqgVsDU3lEhMOwkp+roW7pH7sD
 epEN/i4U0tGfsvvSMAB77NYaekk3SvvSJoUIThOoUbsvBiesqrKRQ3SCXYYTI01K+pdqXQDAS8v
 +1SHpSwPig3WNdKCEUzllEPKF1wR7w/k4Fu5gNUF4+/DARua3PE47Qmc9vA+tHG1QLGlDRDzsEb
 UOlJK4LXk/orwI=
X-Received: by 2002:a05:600d:10:b0:488:b14f:b8ed with SMTP id
 5b1f17b1804b1-48a76e01657mr1821905e9.0.1777307494421; 
 Mon, 27 Apr 2026 09:31:34 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773af544sm188205e9.6.2026.04.27.09.31.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 09:31:33 -0700 (PDT)
Message-ID: <b25addc9-d0f3-4ab6-9abe-6398503bc8e0@linaro.org>
Date: Mon, 27 Apr 2026 18:31:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/84] fpu: Drop parts_default_nan
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 26/4/26 15:38, Richard Henderson wrote:
> Use parts{64,128}_default_nan at each call site.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c           | 23 +++++++++++------------
>   fpu/softfloat-parts.c.inc | 24 ++++++++++++------------
>   2 files changed, 23 insertions(+), 24 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

