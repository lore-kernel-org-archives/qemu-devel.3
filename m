Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09963E8B376
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 22:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnP88-0002Zp-Lm; Tue, 03 Feb 2026 17:44:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnP86-0002Za-CB
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 17:44:18 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnP84-0001mI-Or
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 17:44:18 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso51085595e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 14:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770158655; x=1770763455; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XdltL7g37GxXVtYIIf94y4S40RKoOP8zDyCyWgvDdqI=;
 b=LooMcNteZSzSPl+DUP43WV3Jqj0xohD67tcIt2d9bZe/c5Jv2LmoNo0e/fn7yUGuV/
 q+hfIJymj21rKUfsYbmyGLA8/XgRjLkJZ4ggS8ZAL+emSeiUhH9P4C30N3wHV+OZ2ixL
 uAh9pYHIGskHFDPfigjQ10z+BkP1x/KiFnYlujvCbh/GfalnT1jTK56lWXmZ2UjQfGKS
 c+hZWF5/FW6rm9EivsGcWyG5vuaLPznMpFgkmIS2HIDemPWaQHvdcufNjXTjgADm76HD
 vUXggBBBUSWpD4c+FGx0lFuTqxpeibOqw8f2e8PefQNqZ2tHBsnBs1Hc+7R14l/c+ws/
 HWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770158655; x=1770763455;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XdltL7g37GxXVtYIIf94y4S40RKoOP8zDyCyWgvDdqI=;
 b=f8buVKwuOwpQyfBvoF4O8CTubD9AMfkx4geQS5yDj1PLpbNi+9dK/gVa4j2EwAooJQ
 KfXMz0DnUWSeMx/2NB8XmRx74pVf8Ew/LozFd6HYKQxBExwoTWxYvgDk4tMIyjjUndfO
 1sC83/S9X/U0xNbprEVNWUqGmkVnO6kLriA123K0QRnm1PDqu1UuhmutVVmzgiv8jBoo
 UCOVKaAcECxFb8lfzdr6FeZsJmBLherqH0Dn92y6bX5mIyvYI2Cpil+kYHi4VPhz5jim
 gZl32KyglN654IuAXmU1foJwR1derPp68Ma4vCuX4V1/ICjiCCkeGOdw+6n0yYRLFq/W
 hcvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXShCOoJYrdaflvi4iWbnY4qtx5awpMaKFVv2ncFgAJmvA+R9VAcrsz7LxPlxxAyB4NXxyurY7B4Fw0@nongnu.org
X-Gm-Message-State: AOJu0YygJCW/IMZTetjrtH3K5ZRHJKLhzp46XDrusS9Hru/XCGvFLJIt
 Di70a/d0Yk/8uPcJX75YEJkSU+nxFRTaGqLzPX1K/rRk9+zAAurC/iwSLzdT5KlnkNU=
X-Gm-Gg: AZuq6aJZRJYVVXX0gybEYRnPhPS65HoOYtWt0D1YY/vTirqQPHWThtVH5g6UvJyyrRI
 iYPTAJTcwWLATtnsntp/8te7k1CZBQlzpZNtjhwjCHFnkvIQvUx54NH20B8mRw24JRtN6pSHa/Z
 nCqkg0yAavxyal8+1FL0R1O/KuGPXHAffCIznWxAtWc0Y42gTJBeXy3rpOowcucS9y51xw2tHIb
 4HV/84U/rLHnBOU1PFBG42uoqTS80ppyakeHdk8VjvVVTbJjJmp5RarNLgvWZDHMa03htsPEV8Y
 cavNCZp21i1uB2B1fXD1cuNXwDzWibYBTHhXqsu4qd4yIBXL0sOa//sd5OTEO3QFK1qFyTGrGi8
 FSuLTMi6QQ4ZE4PWh/Ee/xrGl0YpSgWQ62Qm6uY2Rw6UrKUWvsan+pkDQSrdm9DVj9HNn/XvRnr
 Syj7iEE5obzmI7dk62IF2v/Qs3IPJMLpfLV6Udho5V6/Jnj8zlYoy+Lk1fhpkjfut6
X-Received: by 2002:a05:600c:c16b:b0:45d:d97c:236c with SMTP id
 5b1f17b1804b1-4830e96cf91mr13260415e9.21.1770158654877; 
 Tue, 03 Feb 2026 14:44:14 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830ff9fdbcsm3542535e9.13.2026.02.03.14.44.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 14:44:14 -0800 (PST)
Message-ID: <27324751-3f76-4912-a99c-d5bef3aa36b6@linaro.org>
Date: Tue, 3 Feb 2026 23:44:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/22] util: Introduce ldm_p() and stm_p() load/store
 helpers
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
 <20260109165058.59144-3-philmd@linaro.org>
 <0db4b897-7645-43f2-a0e9-9dbe52a2746a@linaro.org>
 <546f3a4b-64ff-4f63-bb07-f5cb52b6c64c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <546f3a4b-64ff-4f63-bb07-f5cb52b6c64c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 12/1/26 09:56, Paolo Bonzini wrote:
> On 1/10/26 00:23, Richard Henderson wrote:
>> I'm not fond of the pointer arithmetic or the code structure.
>>
>> Perhaps better as
>>
>>      switch (mop & (MO_BSWAP | MO_SIZE)) {
>>      case MO_LEUW:
>>          return lduw_le_p(ptr);
>>      case MO_BEUW:
>>          return lduw_be_p(ptr);
>>      ...
>>      default:
>>          g_assert_not_reached();
>>      }
>>
>> which would hopefully compile to host endian-swapping load insns like
>>
>> .L1:
>>     mov    (ptr), %eax
>>     ret
>> .L2:
>>     movbe    (ptr), %eax
>>     ret
> 
> It only might do so for 32-bits, because movbe also bundles a free 32- 
>  >64-bit zero extension, but not for the smaller ones.  Thinking about 
> which, I think ldm_p also needs to handle MO_SIGN?  It can be done all 
> in one with
> 
> static inline uint64_t ldm_p(const void *ptr, MemOp mop)
> {
>      const unsigned size = memop_size(mop);
>      uint64_t val;
>      uint8_t *pval = (uint8_t *)&val;
> 
>      if (HOST_BIG_ENDIAN) {
>          pval += sizeof(val) - size;
>      }
> 
>      assert(size < 8);
>      __builtin_memcpy(pval, ptr, size);
> 
>      if (mop & MO_BSWAP) {
>          val = __builtin_bswap64(val);
>      } else if (mop & MO_SIGN) {

Can't we have both MO_BSWAP && MO_SIGN bits set?

>          val <<= (64 - 8 * size);
>      } else {
>          return val;
>      }
> 
>      if (mop & MO_SIGN) {
>          return ((int64_t) val) >> (64 - 8 * size);
>      } else {
>          return val >> (64 - 8 * size);
>      }
> }
> 
> static inline void stm_p(void *ptr, uint64_t val, MemOp mop)
> {
>      const unsigned size = memop_size(mop);
>      uint8_t *pval = (uint8_t *)&val;
> 
>      assert(size < 8);
>      if ((mop & MO_BSWAP)) {
>          val = __builtin_bswap64(val) >> (64 - size * 8);
>      }
> 
>      if (HOST_BIG_ENDIAN) {
>          pval += sizeof(val) - size;
>      }
> 
>      __builtin_memcpy(ptr, pval, size);
> }
> 
> When inlining ldm_p, GCC is able to generate movzx/movsx instruction but 
> doesn't recognize bswap64 + right shift as a smaller-width bswap + zero 
> extension; clang does.  Neither is able to generate movbe instructions, 
> though.
> 
> I attach a standalone file I played with.
> 
> Paolo


