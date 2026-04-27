Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89967FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHSa8-0003iY-9J; Mon, 27 Apr 2026 16:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHSa7-0003ha-2H
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:29:27 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHSa5-00021c-Hw
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:29:26 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso89013455e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 13:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777321764; x=1777926564; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=32iiHGTDBAbFitloiukIljyJaBKdS26fxCahwfQV3a4=;
 b=ZWQ2d6Fs3/j0xiBI9/syvskrOcC3gXucaEjKyiKTunJHkVG8fERbhbpyTNQJtXUKUE
 mrckazmY/FYPaKXe9tWcbcLbescSTrKdhPmQh+V099k5SpJAqNopsbo81zo+gOX/D/jp
 UvgvY5/VLukgru8VpyB6WHkdB+/vvleb3568hFhUyaEBlsqqmKOp8NObAduZM+3Tejug
 j23jdYWbqJnIrm/DblXr6xhe2XavCmv0S0U8i4doQkYHv5fJfzyGqtdRH2aD/iqeiKTD
 /LTOaKHnmYMd85g7KwGlFlB6iLnZqNrdBwkGpQ8NtS0Xvd7AnwExz5HYTCNkk0r5rhq+
 eUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777321764; x=1777926564;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=32iiHGTDBAbFitloiukIljyJaBKdS26fxCahwfQV3a4=;
 b=JViReYNfxbxHR4jx6TN1ENGxAnfhtdp8cijDjwuREmYELI95VlQT6i8mzCqC6apeky
 EXNONPuUNRx8xzCpFhl7sJPgumQli67G3CpspjUPU0kwV/At6pvEw8yzuIrZegOslkUq
 Dx57h37lIb/Zg9XyDBtEWx23ab9OhIQqK3Y9nzYdDN0NEmDaa5YU46ui2skmbW+y1bPO
 qO+IW7IA4EB2egubowOTU+XquRw/ejwxysK5jcRd1it9gZG+tV9n1EOhAdAOKXPO2uqp
 n2sv16788MPQYEohpG9A15qi5B750AQMu1MRgoQ13xA4LXXIPhpCaTSEWDUEdOvaWwHK
 4PNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ83+WV6nrGno1NOc3h2WGL0HFgZFkrLapJd0PEIwWeS1bTuVWwjP/Aa9dGZm2CwKaqTw3lGMmnLFxpU@nongnu.org
X-Gm-Message-State: AOJu0YyX8zzD90tCPhaT5yi0J/6mxTsKpyhS4m9FlHL3NokIRSqJaV35
 RKgcNLIy6laGq/EGFSpTYFxp0m1FM1L2aYFEiKIcnJQxIB26rfjvjIifB8ZMHLCcGVzeDeSvYzt
 O0JJOBx0=
X-Gm-Gg: AeBDietQzA5/2o9Db9LbtdWjK08C4f8EQQ2yQEsWQrsERumvPlEClpiU75bQGFFlAk6
 yTQafY2GUgzQlguUJo7BrlQFLvFHBfeWvl8Xzb5heXndcvHhcH9aem4hglSgvc6VpSE5auAaREj
 hGQvtlOpTjY+AR6f1vAo9SDmjHQn7Ofn6PlwcsMIXaK/qn0ri5kcEM6sKEFBNDpCOIF21lCzEFp
 AP2pGRyXP2Dtb7q8RWeTpzJbEMiR55SJNLpvqHS3rDk361ZdBXdyK6HOn47VqgMx45cTMncbRjl
 27X04qY1wr4/Z9pTwaFfuVKLVIOUPG+f3COHqO3T/65sQv/wqC6Xmw6exofAnqNqI2dtz2rf4wf
 NvAvLNPNvFMJ6cQKa/XKmzoExipgm/MaZdoEmGB1E2fXw6LuVEAMOwlNBuRDEi/mq35e5yfsP28
 +kswu+uSBbE/TquKcDGTnkYz9F2v19qPXkPr6pDWVHY/s33wC+Vs64GcQnrSZ3H4PXtsX3tCE13
 JBb
X-Received: by 2002:a05:600c:19d3:b0:488:904b:f31 with SMTP id
 5b1f17b1804b1-48a77b240aamr2846495e9.22.1777321763696; 
 Mon, 27 Apr 2026 13:29:23 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463d02f6a1sm871143f8f.13.2026.04.27.13.29.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 13:29:23 -0700 (PDT)
Message-ID: <d466b822-2531-406b-bb03-8c03e3e7ce56@linaro.org>
Date: Mon, 27 Apr 2026 22:29:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/84] fpu: Drop parts_sqrt
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-17-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
> Use parts{64,128}_sqrt at each call site.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 20 +++++++-------------
>   1 file changed, 7 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

