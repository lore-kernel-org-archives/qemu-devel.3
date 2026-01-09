Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC382D277C1
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 23:24:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veLpO-0004Dy-FG; Fri, 09 Jan 2026 18:23:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLpL-0004Bj-Rv
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 18:23:32 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veLpK-0001uT-CZ
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 18:23:31 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-bc4b952cc9dso2159313a12.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 15:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768001009; x=1768605809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B7Q9EcfoSmtl5Pc6AtI2VVJgGIqIyZTLMJhUjy5TbVw=;
 b=qenyUvWUa48IanwiyuJu/feY3zIlsFKfjZ0ECoG8JMenxjIcvGwaDDIRQsmySyObWj
 9qMeTXV4+U6r04KIeKN8fKHFy5lvHh92CP86CcS/cO1/R9hs5Gc0FXmmMjBzHxUpvYUe
 YrBi8oeaghtXK7YLi8rRxY2e702enkZDUB61vWIisIfJ40VGdRvQI7UNlyG+xstwzzUT
 GTppSbsWvKxiCQMJJMJ6YTlPNa5gabSUl6MmxIxatnvWZBb5Fidpw9W4dEGsB8okaVif
 HUcB6njfL1AuaGTaKbBMzKHLg4NigeZqhLAGJZUsSo/qHT0ixYvHwYFZUcT5sUQP1H0j
 2Rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768001009; x=1768605809;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B7Q9EcfoSmtl5Pc6AtI2VVJgGIqIyZTLMJhUjy5TbVw=;
 b=WXuoANU92cFZ9F7OWltccUurw3uKIv+iF0XuehZa07FRkPS2FpCx93nQTWMvkmxO0S
 NYWbJ/zWP8aa3I8isXmBGFlhf6ETGYxsM4vMwYbyjgAbHlh1+zg9dDiDVkcf3i98aqpG
 NUpkJz9xur/J5/4ym06KsSnsgY+lF112vXCDEk2JwfkEj+qOq5KD1Y4i6vLJ0ZHv7+sc
 n/eop93qVlH5oqJU3XleN3Sl1DB5MxeILKzGCYk9VOmEvtt9JO7iFSEHQB0NDtCm2ZuU
 zV90lIm4SD0yQPZO2DT9UMTuaZWybQMXjiyVizMcmC6STyWaoBtDNoEL6GN66sRH1iZx
 SIbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpkW4S35Yu06WEfSdbk8yzDpuSy/HaY/o8TPs3qHfl092vUXv06Z4LYUnRpCCkUkgrk2rzJjXseDN1@nongnu.org
X-Gm-Message-State: AOJu0YwIM5UQLhRydHXAWgAQCUIpYCRov9RrZcxneKZpp6y9mqr369En
 7o+u1QWlgJMMD4Ps+WzlwXRqk7bbsZdJsNpMzpQ9DUrufpgnPjNkDC+gIBABMLsDPXM=
X-Gm-Gg: AY/fxX6pxUulb/rxkqpRm0ZF6wA1+HWM2MHwSztYaw2DXSNtAI7pd24r7RW6kFq8yOl
 esiR95bZc6flxSGAE1fTbp9qQJtCJdcG6K7SiF4vkJMzqbz4gZO8ulhy1rJhgYDP4ZgzmSEJcUn
 uyDBIoJQs3p19oTbPixBQ4b/TuRcOCmhSVRhxCDz3klfidToZFk/VKi6DLNimfqCug0XcShPzA/
 TFWgLX50/ctb8CNgnwipnZ8sZCaOHNh4xoT9y8+3/l4j2vxBYTDdOXXRNuiVkwONo/353Pxzcmu
 tlChFgSoW77m6V3v5igaPTr/AUapBpm7VM2z5mxlK8bKugeBCGxANGRT09QVk18f90yYExjJkZ9
 t8+xviAXZqZCxscEkTOAxy3ZWIYtVTstohDyRvbRFj12jdobx2u0tL322QDE8aAn8bfMnGGulc5
 20ni0BzAj0stA3v/oY3QlZYEyNuA==
X-Google-Smtp-Source: AGHT+IEUS3cNpQezkoBf+ph6PS4m31BmqqcOPIgSLhbgR/lxXD1DxIRAvcA0yrRdezpw7RZRSW+KKg==
X-Received: by 2002:a05:6a20:3d86:b0:366:1a31:a70a with SMTP id
 adf61e73a8af0-3898f888af4mr10566842637.10.1768001008501; 
 Fri, 09 Jan 2026 15:23:28 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc95d5f10sm11371693a12.26.2026.01.09.15.23.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 15:23:28 -0800 (PST)
Message-ID: <0db4b897-7645-43f2-a0e9-9dbe52a2746a@linaro.org>
Date: Sat, 10 Jan 2026 10:23:21 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/22] util: Introduce ldm_p() and stm_p() load/store
 helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
 <20260109165058.59144-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109165058.59144-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/10/26 03:50, Philippe Mathieu-Daudé wrote:
> +uint64_t ldm_p(const void *ptr, MemOp mop)
> +{
> +    const unsigned size = memop_size(mop);
> +    uint64_t val;
> +    uint8_t *pval = (uint8_t *)&val;
> +
> +    if (HOST_BIG_ENDIAN) {
> +        pval += sizeof(val) - size;
> +    }
> +
> +    __builtin_memcpy(pval, ptr, size);
> +    if (unlikely(mop & MO_BSWAP)) {
> +        switch (size) {
> +        case sizeof(uint16_t):
> +            val = __builtin_bswap16(val);
> +            break;
> +        case sizeof(uint32_t):
> +            val = __builtin_bswap32(val);
> +            break;
> +        case sizeof(uint64_t):
> +            val = __builtin_bswap64(val);
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +    }
> +    return val;
> +}

I'm not fond of the pointer arithmetic or the code structure.

Perhaps better as

     switch (mop & (MO_BSWAP | MO_SIZE)) {
     case MO_LEUW:
         return lduw_le_p(ptr);
     case MO_BEUW:
         return lduw_be_p(ptr);
     ...
     default:
         g_assert_not_reached();
     }

which would hopefully compile to host endian-swapping load insns like

.L1:
	mov	(ptr), %eax
	ret
.L2:
	movbe	(ptr), %eax
	ret
.L3:
	mov	(ptr), %rax
	ret
.L4:
	movbe	(ptr), %rax
	ret

etc.

And the default case assert makes sure that we're not passing garbage, or too large MO_SIZE.


r~

