Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201A7E8B383
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 01:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnRso-0001cu-Fl; Tue, 03 Feb 2026 20:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnRsk-0001cS-OJ
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 20:40:39 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnRsa-0001RC-CR
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 20:40:29 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c698873a1deso1338223a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 17:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770169225; x=1770774025; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WjNv+sRT4A4lG1FbEUHYxZAduP8Q4cAScgor30aajIc=;
 b=S00gplV8EW0yOTc6cYlOKnWLdmXwOZVmE7ow6fsXnMUIO9VzRE2z9D5zBe+d/alKUQ
 1kIV9c1hHHjfZ/6q8TpBah1XvlO2krtsopKWR0GjF5K9xh5e8NUukjSscpLUxNh8IgaM
 zMpSU/qaiK1pQzhxnH0XGdEHOHlf5rIrJxjStQ4umNq8lbEZh/lvCjwg+I9wIDWQDrch
 JDjGfBCdS3HElEcOlDONxPgVphtuUOgZO9MX54kokLTAkFOcS/fSIJMm37VHdBxhZV8+
 5bZsUlctdJ5L68ZccWqzvS+lxVUPH/OhTu9DTEII4IyNFsdyMRY7sfq7t9/DYmnNa57+
 LK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770169225; x=1770774025;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WjNv+sRT4A4lG1FbEUHYxZAduP8Q4cAScgor30aajIc=;
 b=W8b/V5zijAy+GyCnKiD/kx8GplYvzHU2S+qStHxw4Uoz87OXRJj0RBdVxLIEFuGveU
 b6BIGu8KYRV1QZNQIhnCLOeS+JjBprvN9Re9OvOSihGXPKuOxhryEu8vSLklN+1srpsJ
 jhDerO3t5Wf7LN+cURg9MYH1o0fKJhWzITZ80ImbeCeum0ERpn2xuWMspBbd+BdoIIyG
 y/6O3vldzscdw78NcH5VjHEd/3rZrQzVUwm60Q3HJisRdQtHt3gNZW5dkVd03iVk7v5c
 NU6emzuQHWR9J2wM+81RaSca9UMI/s6g/RBWcsqLBZBa0lVqKzgyj8rCw1xUgS+tmfTd
 Ur6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOIQfXHM7seUuEaAZWruq03E0yd907dW2un48nFd68IUT3pRovYPNtrE2wErGX5DX6+WhSJXvkKGmi@nongnu.org
X-Gm-Message-State: AOJu0Yxuai4jSl0fWxvQt5TWQ62V3YSoZayuSNTA/G1QzVcEcCJwho93
 Gasly8wTnSiFrL/kLbXORD6dN0ny5MK99PYUx0rjr/YkfZFz8wGnm37ITeiYs1RZclo=
X-Gm-Gg: AZuq6aLuANehbWiPlDQlFHsNak9FTngMCzXYJohuC+bnYsDNaayNWPgbWiRgwA3bs5K
 znN5oG3NSwywdYk3334CUaBlYX83h44cqfi/qERy7ab4JNn+N3Nqk/SfZ9rKmEcAk8yIUbB8Xrf
 tw10/42phVW+rYBWfO5plHmC6du4kF7MX5tIteh0VmwXlI3N7GGEQA3njDSd7S60ihVbeS0OouQ
 RAND0DAn7t41CHYu87iUPrYIRKY3/JkJxWiJ4mClKW+BfrMstEDnqLvzkUP9K64BhdE6R2qbFFO
 0N6ZsH8/IPsJUCycVp/tXH7+2ogHY+OVqi067HmWztyUt/+V7YFf7rJqy8QWMVg02zBt0wlJXWv
 FuJr7mi3j/BmC5NTj2R48q0ODzu29cHeanOaZD02UF0Q2fvth5E0s7scL5GPSpFAdpFvIh+iZXo
 35QFmXXnTf4NYxYRUa7+QTUNcOJiV56hydD4H9nky+A6L2GDv8kJjve3rn3jdtt6aQTLE=
X-Received: by 2002:a05:6a21:6e41:b0:389:8f3f:50d0 with SMTP id
 adf61e73a8af0-393724abba3mr1196024637.60.1770169225531; 
 Tue, 03 Feb 2026 17:40:25 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1bc:fe1e:491:928e?
 ([2401:d002:dc0f:2100:1bc:fe1e:491:928e])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a933a252f6sm6104205ad.75.2026.02.03.17.40.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 17:40:25 -0800 (PST)
Message-ID: <b31e88a8-6572-4f78-b714-4ef89219aaab@linaro.org>
Date: Wed, 4 Feb 2026 11:40:19 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/22] util: Introduce ldm_p() and stm_p() load/store
 helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
 <20260109165058.59144-3-philmd@linaro.org>
 <0db4b897-7645-43f2-a0e9-9dbe52a2746a@linaro.org>
 <546f3a4b-64ff-4f63-bb07-f5cb52b6c64c@redhat.com>
 <27324751-3f76-4912-a99c-d5bef3aa36b6@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <27324751-3f76-4912-a99c-d5bef3aa36b6@linaro.org>
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

On 2/4/26 08:44, Philippe Mathieu-Daudé wrote:
> On 12/1/26 09:56, Paolo Bonzini wrote:
>> On 1/10/26 00:23, Richard Henderson wrote:
>>> I'm not fond of the pointer arithmetic or the code structure.
>>>
>>> Perhaps better as
>>>
>>>      switch (mop & (MO_BSWAP | MO_SIZE)) {
>>>      case MO_LEUW:
>>>          return lduw_le_p(ptr);
>>>      case MO_BEUW:
>>>          return lduw_be_p(ptr);
>>>      ...
>>>      default:
>>>          g_assert_not_reached();
>>>      }
>>>
>>> which would hopefully compile to host endian-swapping load insns like
>>>
>>> .L1:
>>>     mov    (ptr), %eax
>>>     ret
>>> .L2:
>>>     movbe    (ptr), %eax
>>>     ret
>>
>> It only might do so for 32-bits, because movbe also bundles a free 32-  >64-bit zero 
>> extension, but not for the smaller ones.  Thinking about which, I think ldm_p also needs 
>> to handle MO_SIGN?  It can be done all in one with
>>
>> static inline uint64_t ldm_p(const void *ptr, MemOp mop)
>> {
>>      const unsigned size = memop_size(mop);
>>      uint64_t val;
>>      uint8_t *pval = (uint8_t *)&val;
>>
>>      if (HOST_BIG_ENDIAN) {
>>          pval += sizeof(val) - size;
>>      }
>>
>>      assert(size < 8);
>>      __builtin_memcpy(pval, ptr, size);
>>
>>      if (mop & MO_BSWAP) {
>>          val = __builtin_bswap64(val);
>>      } else if (mop & MO_SIGN) {
> 
> Can't we have both MO_BSWAP && MO_SIGN bits set?
> 
>>          val <<= (64 - 8 * size);
>>      } else {
>>          return val;
>>      }
>>
>>      if (mop & MO_SIGN) {
>>          return ((int64_t) val) >> (64 - 8 * size);
>>      } else {
>>          return val >> (64 - 8 * size);
>>      }

Yes, but that's handled by always using bswap64 so that the lsb ends up at the msb, and 
the shift takes care of the sign extend.


r~

