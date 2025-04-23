Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94829C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 21:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7hjZ-0002Zh-Sz; Wed, 23 Apr 2025 17:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7hjX-0002ZE-VU
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 17:34:19 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7hjW-000188-Au
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 17:34:19 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so2802565e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 14:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745444056; x=1746048856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pkRuLK5D22o5gXzvzRGz1aHW2JHk+piMFxo74rISbXg=;
 b=Iu/clCs6hmKteo9YBn7f8f72p/UyhU6Y1lFWKfAFvodFxGp52HD2hHCLSmOOWBxMqf
 xPIf+b21k+z3BnqoxG4TLtzEVmTYDXukBPfdTgt68o05HCOmrQW+v6BUF0cx0w8VWQ0D
 ISHu1jTXkE2h3U/EDUhCTZ8CmQHEo1i3vUz2IlW+VnU3IEZivddLP5yK3Xv9Jg2GXWwQ
 ZaKNu1Bh1EhbSoj6wV0g7q03noSxWXiV9e2QVS98GwBBeVqNjQgEgZ83V7dRYCE//qYT
 SSo4ISyuJifZJ0vYViP4xZyno9LEudZ+gGE+n8VDXw9BNJ36VNlWjtzvumwuu01Tc1pZ
 A85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745444056; x=1746048856;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pkRuLK5D22o5gXzvzRGz1aHW2JHk+piMFxo74rISbXg=;
 b=FeYQdkKbWd2aJBV7Wv/d9cMvTIe4WQmlXhzoOL5Ods6DGlw5tZOjqDZFiSw4304+0s
 PC02cPv5xasiM64EBfQ30vDv0o0yLM9GssgMBs+RMdNE0ULF5hmy8ILLMhQiDbhB/a8I
 S4R4topKcIKxbfgj6mLmJI1alEctl7uwtEPX/Dd5mNP2yIMXvlZ3MIK6wFM4ICsZUmm6
 /Aa3XF/H4F4dqcyYpDPBH8bhCpjiZS23+WDOOayjhNxn7G4VMudBgfxK8jFxLsIlo/pK
 jyrglWvwXbspHN1qEjbFsPo60rRTU75oYOhjNM54ZSte9bGZMQbt9ejSyhh9ll7mB6qs
 aK4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0/a8AE++e3/7sv9FlXw40UWIgyLNm3RS8Cbu0mSh1gQpPS6+KPV2OelVtWHVqVg1+ZhYmkhtCs1MH@nongnu.org
X-Gm-Message-State: AOJu0YwOLj6uQMTFuas9xPpIv2JI1b7jyloJld7tFnDu1ToruEN3M+vA
 tjvgwHMnNIn3uVS4H3DRGRbeljbhxGHVuxcJ1y/QjC1nW2JbwuCr9ioP6PRjo/A=
X-Gm-Gg: ASbGncvfXkxXZ2YUzb4lx5S1kfEpBzdNfQO2yBg7oYwevnL20Fkn0DhbDzVP8edZTpb
 bmLHZ4R8z4omPaW5Kkn/2HT5EqTA2BFe9TIE77srmRqKU2xCBsLBpJ+LR287XjCal+b4szZjnBZ
 /VruI/vh17GBxxcsXRUk3fZMEgRlHDuApsxmfpAcEraj1NF8fHplPvKV0/N8/gG34U+TrSfJnYe
 Y7z9vPgUXJ6CbZc2c3jdma9Y8ZUgOK4nHSsJuK2BLWeuxNSArEoY/QTB3HQUVCtngTBoJzpvSgJ
 dOQRJni2niUYn8VMxHcv5MVkl5zh1hIiUdJDB9KiX6aW/R9y9mtrEtGHOPw0PSrz+Kzf/6ucOAn
 ubaOjdw0XXHF7LA==
X-Google-Smtp-Source: AGHT+IFJY5fo6Uq/fixps9b8b+e5slcCaKPlfWiEGJS+CyedyDO3igIktZOGu7cjGfgq9JZi7CRfgw==
X-Received: by 2002:a05:600c:46c5:b0:43c:fdbe:43be with SMTP id
 5b1f17b1804b1-4409bdafefamr1085545e9.27.1745444056057; 
 Wed, 23 Apr 2025 14:34:16 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d369f1sm38440585e9.29.2025.04.23.14.34.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 14:34:14 -0700 (PDT)
Message-ID: <595d5da3-ebbb-4b0b-ad46-e30326158bdb@linaro.org>
Date: Wed, 23 Apr 2025 23:34:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 064/147] accel/tcg: Pass CPUTLBEntryFull to
 tlb_reset_dirty_range_locked
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-65-richard.henderson@linaro.org>
 <071a47a7-bc91-4f1b-8901-fc523444ca14@linaro.org>
 <a1463f24-83f3-4226-8862-607618005ce3@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <a1463f24-83f3-4226-8862-607618005ce3@linaro.org>
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

On 23/4/25 23:07, Richard Henderson wrote:
> On 4/23/25 03:03, Philippe Mathieu-Daudé wrote:
>> Hi Richard,
>>
>> On 22/4/25 21:26, Richard Henderson wrote:
>>> While we're renaming things, don't modify addr; save it for
>>> reuse in the qatomic_set.  Compute the host address into a
>>> new local variable.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   accel/tcg/cputlb.c | 20 ++++++++++----------
>>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
>>> index 10090067f7..5df98d93d0 100644
>>> --- a/accel/tcg/cputlb.c
>>> +++ b/accel/tcg/cputlb.c
>>> @@ -882,18 +882,16 @@ void tlb_unprotect_code(ram_addr_t ram_addr)
>>>    *
>>>    * Called with tlb_c.lock held.
>>>    */
>>> -static void tlb_reset_dirty_range_locked(CPUTLBEntry *tlb_entry,
>>> +static void tlb_reset_dirty_range_locked(CPUTLBEntryFull *full, 
>>> CPUTLBEntry *ent,
>>>                                            uintptr_t start, uintptr_t 
>>> length)
>>>   {
>>> -    uintptr_t addr = tlb_entry->addr_write;
>>> +    const uintptr_t addr = ent->addr_write;
>>
>> Can we introduce 'int flags' here, and add the CPUTLBEntryFull
>> argument in the following patch?
> 
> What 'int flags'?

Whatever please ignore.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


