Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94249FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 04:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJUX-0007Sv-3E; Thu, 30 Apr 2026 00:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJUV-0007SZ-41
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:59:11 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wIJUR-0003ls-2e
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 00:59:09 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43cff5dafc3so288330f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 21:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777525144; x=1778129944; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VbwkSerzEOY77DLn1LkDPw1XjVKxWgcHnPpJWw2TRx0=;
 b=MknQ/4fKIyXhETz2M6W1spA7KEA1JRP39DWnREnV8LchLUzfpzSAafameAg5UGO/05
 AB0PO3blPVzc6PuFKUpv/xxIgMh1aM8R/DUK2la54dbMBwXC06U2OPzFMqu0+/tWCC8y
 4o4iwubECVzclsRxKMg1fgEGQbuiec2hzD7TcvnyUppdpntzkheiyKXFBgkGGoP9KWAf
 Z3dgpL8nnPd6KpMaKwP20tgenGS3/n8byRlgyF9N0tADR0QsQ+RCok3W2gJ3fxSty0oS
 hBNNxxEQInUO9tiCI+hCPE4YdF/JU8eh5b2Zyrz8Fk32WqEsMewZmXVZOWRif2by1YWb
 2PYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777525144; x=1778129944;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VbwkSerzEOY77DLn1LkDPw1XjVKxWgcHnPpJWw2TRx0=;
 b=oYFwrapYUmaxK5oHRL2Z2FLd+rMZxmdBTlqujWweBA9uOIVz580LVqLjo+FPS39IEO
 vdDSEGLUrU5ZbUuvrITrtioDlVOLlcbh69rIuGd1HATyW+D4K8VVLVBooK1882pSpI1E
 MjR7MXsNviErQfOB+bZ5AhWsNWaqUbXwhDG2SfK9WShPGTMlO2hFtH5NFVO9GLjD96Bf
 cJbmBWacf/xxJSiVjH5zYp4S+LKHKSx4P3LEBUBMgWzqooIdSbmaLVvDOyGawRfCkXBR
 td4LMg2QzEX9K5DYGbCQzwktQ5HlOYuga3RK0v3k/JGcQ3Leg82/QN1jdxOZBp89itgo
 8UYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/9Db5mKmN5sgsyZdUzO64B2C1qzN8iwiEnFlmhpjChP7QtI5e0mBedIkwTIX//qvoTko9rUgQnC+lR@nongnu.org
X-Gm-Message-State: AOJu0YxjtMpPOr88zIzKkkbytBtfWTYDcux3gcbCKdTjqAvPeBf4z7Ip
 8Wj35qyqIV8FQI7uINAzv133XiwKxxC91AM9Goqx30lfMS8TZdOb2FHv12RFdeZ7ag8=
X-Gm-Gg: AeBDieu9nABnfhKegldqQWjTV4LElpsLgJwX6dFvXK7ofxW9ducD+KQCwbiUz6EdWKy
 4iuOBOlK2glV0UsIhEdcUsqyZccBRee9aznl/yh08KtZU+cxfyiJH3igLM0li0kLWn+JO0clvvd
 TCC7lvwgwPuvzDVk7R5n/iZKyI2xKQ/riaF3lACd1pvBAk1MbkjFE8jMLy483aIXC9EenLatiPf
 QqAojxX0OazFLnphXm8o0+wXkPzFBPVmLO/eiow8zL9PDpBiu0zJYEajWznztOWeQ8QG72V/mjc
 Ua1eY5jBlX82ZEusufiPF6otWxnULT6qMXMaGiiVl4a+9QjnEjX0imhHxcPwzweJ3XXw81FPTw4
 MaYAaAkPw/e5HcPV9jFWUOc46CPUzh7kDwsCe0eDrgTVSdDDqIHk+z9WaWWDqm/IMkhqiOdY01r
 vG7iEjYNwhiQw7rA44nf4gsv7H7ct5QT7ayP5TupuIsriu7j/u32DRGV3t0K9kAK2dYe1gXKYtM
 2lZ
X-Received: by 2002:a05:6000:2f81:b0:43b:6a16:17e with SMTP id
 ffacd0b85a97d-4493d02abb5mr1914133f8f.11.1777525143664; 
 Wed, 29 Apr 2026 21:59:03 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b7ca6451sm10759365f8f.36.2026.04.29.21.59.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 21:59:03 -0700 (PDT)
Message-ID: <12536f6e-e953-4f0e-b43e-40de96c1e393@linaro.org>
Date: Thu, 30 Apr 2026 06:59:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/40] fpu: Return struct from
 parts{64,128}_round_to_int
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-19-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260430000524.56046-19-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
> At the same time, export.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat-parts.h |  9 +++++++++
>   fpu/softfloat.c               | 19 ++++++++++++-------
>   fpu/softfloat-parts.c.inc     | 17 ++++++++++-------
>   3 files changed, 31 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

