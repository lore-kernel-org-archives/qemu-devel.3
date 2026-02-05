Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE1BEA795C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 03:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnq3u-0003yK-4K; Wed, 04 Feb 2026 22:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnq3r-0003xq-Vu
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:29:44 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnq3q-00044U-EP
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 22:29:43 -0500
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-2a871c8b171so3632365ad.3
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 19:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770262181; x=1770866981; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D2dupEyo2F5Q60qDSaObJURHA7eYSG7joDbYoWuXVIo=;
 b=ThMAy54komT2FPCtGER8S1Oy9M6kjZTvp0AFhpJVAuGGjUHw2/L8xgn88qsLC3VkN8
 +s+D1wzCzt/6A4kQtyIOBWeX+buXSV+gaFUIhqKhlS8hPzjH2tcL4U2GjNnenlpGYPdw
 0Ni/lx/5EFWUbPDgaqSdDVYZe5DnzoUnnRAL2QbUO7UQh0MmL43Y4MgpgQrBnMuE796M
 mdjStL7o55Jez89+DpEM8fQzGuCST6zHyRWQrqYAEkuC469LJlQCyRorwwj2btwE856G
 Auxsc7uNnft5Z9X/DV2Eeh8CDKXQpNa8GIaqI7mSw6yHJkyqT4hEW7Dj8lbZH5MFrFpL
 9MtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770262181; x=1770866981;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D2dupEyo2F5Q60qDSaObJURHA7eYSG7joDbYoWuXVIo=;
 b=Et2Cl/tWXKK/XnpATvNxrJE45aMNS0ggBglqWxmpHLyr4l6f3PlzUJCcpmsTHn9ffC
 Kl3d1OMmqqpqe6brRLZdVDOFGuQXlQCfOZPLolPvejTfH+6EOLevSnCwhOQp4g0z3oqQ
 GeDbCgrza5zpqO/kOO8xS9jIppZktje9Mk1u8ChEc1sAiraUcwShOEl1OXqUM+H+Ye4c
 bQBFyYby7MH3jWxHXJPlihjg9bmQmpJ/U+LuQLxPki+DEMpwldrMMiiDNKJlzgVLhHDB
 9eVdMOBjKhB+8Rr2fLRgwDJLjfJJnshHWoqIqsY6Z8e7QtYM1m18vBoZk0LHSVZUhxgm
 y05g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0KD1B9fYcbjEokE3FK2qEpwUt5mgOCQcks0rVGIQ+g+xa0IJPGUvpcIv8SuA2jnRSSSrgEcCXHw9A@nongnu.org
X-Gm-Message-State: AOJu0YzRghKPu/VgsaituagAO+ack0V4ZLhWQINMqg4e2ACSBgZFVShv
 PrA1VfYl6JZkzeepLMBV1iihBeN1iyQ8I9yvuqDFmu5wDkQHqOdB1iD2YbHjLME/a9y3ubm2VpW
 BRC9D51p1p4qC
X-Gm-Gg: AZuq6aIM4C9n5Bueiov6k+d+C83YtEm9JqPF4QGRuOx6Jz+YCUf42yLjs7VDcjSAnFR
 K1lYjDBtT/Oi2Q7wd3MufmuNnl2p0gnB2dD+r1MDu/FbzIhBBNK3upjPeZ50MGSOaE1a/8zXXyV
 n2ahhL2mmHD+nOu9fUIy7EkTSYSr8S3jOTRUU8I1MVxQDpx5OOi8VOkMAI+uWPMLw8dnk3Ci4Vs
 GCTE+GRFW0LymSUK3PgXJZzUdvgpWVq3yEpAhA8zGwr8TcBUeEaNsbd6MY5QbMh8nfoM4EnE76y
 eTB5s9E+D3hreI5g5phHDmnHxAwJdeEdnnNZnRYXMfT9Ims5JcvMmaX/jKBPZvgr2s1Cm/hLhQt
 vpLF5O1Ybb3KVK7LIAQqy6BK22XgiBB2IjHkbUP5mH5omWDipXtIMNLIILZ2NVQlutmRkZOPdvC
 RYwm6Uw0W+qkjxQ5HW18v7PsnVd+1vVXcoSZdYM7uV8tBl+IroOZlYjwlT14h+nGlB07TVZOuO
X-Received: by 2002:a17:903:b4f:b0:2a0:ccef:a5d3 with SMTP id
 d9443c01a7336-2a933bca7camr54976165ad.3.1770262180654; 
 Wed, 04 Feb 2026 19:29:40 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:7515:513c:b646:18b8?
 ([2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a93385127bsm40255245ad.1.2026.02.04.19.29.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 19:29:40 -0800 (PST)
Message-ID: <0a70dfa3-7547-4928-885d-89577a8f3e27@linaro.org>
Date: Thu, 5 Feb 2026 13:29:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/19] fpu/softfloat: Refactor IEEE format NaN
 classification to share code
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20260204051756.667397-1-max.chou@sifive.com>
 <20260204051756.667397-3-max.chou@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260204051756.667397-3-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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

On 2/4/26 15:17, Max Chou wrote:
> The floatN_is_[quiet|signaling]_nan functions for following formats
> (float16, bfloat16, float32, float64, float128) contain duplicated
> logic that should be shared.
> This commit introduces
> [float16|bfloat16|float32|float64|float128]_nan_is_snan that determine
> if a NaN is signaling.
> 
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Max Chou<max.chou@sifive.com>
> ---
>   fpu/softfloat-specialize.c.inc | 176 ++++++++++++++-------------------
>   1 file changed, 72 insertions(+), 104 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

