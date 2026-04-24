Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069AAFE5205
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGDrT-0000VW-M4; Fri, 24 Apr 2026 06:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGDrR-0000Uw-Fs
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:34:13 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGDrP-0000QD-RV
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:34:13 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488b0046078so69509795e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 03:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777026850; x=1777631650; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yJsNb2njP+5WpKik+x3zN3wL9kwMdk92FfukLkRRMHs=;
 b=eE8gY6IfkJu1pWFChQuNAHD7ynnjiWWyXjTs+jw6S86AGITjnZwEBl2d2pC3gbiXeQ
 FOHIFd0Q9VMeI3zg1mi+3j37RqHCWstz7Z5cBOy4D1XILxPMYU8LoDABJCUx5QDjjDIi
 VeSJQ0fKk0vkUlWsDO0Ng02Jwh6H4Jl36i0sI2VTv2e4FmC8Cw6Vl9jInfLusVJ4fmvq
 yNYQF7ywM6utPyFboUjWTfmE1oEcTdb1E6AmMPPeuW+TGN6XXGsw4XYtATuh8XOQ871R
 VZmu1WSsso38phGAKUtn/lj78LUUys3xqWPXJ2ybl9STkTt3zx6p9eeXAHaI8LvCOsWa
 VIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777026850; x=1777631650;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yJsNb2njP+5WpKik+x3zN3wL9kwMdk92FfukLkRRMHs=;
 b=pG/d9zzV2HDGVMJHBNKhLMVHCo6Kx/av7R7LVkvo7enqVqF5OiseC099ZGkWnNW10V
 xSUFNSMznGYpoWvA1Jv2nmvKS+/ZQR8xw0yc9tfycOW4WUDfF4fdV2l4wDsGfQBcWwCn
 kfoRtKXbw7MFPC6/BrnisvpM02uZRfNL1OQQ3Il8Gw01A+PlcBKo9imG3KmVmbQmtjBu
 iq5+bIE1eq6OYJXXSZEbIAChMSzssLHrb1LxZiB2PSJrBrbgKE5b/Wz3loViwdQVO9HR
 D+m2Uumb1ZCWZiZHk0034N2t6226yC1iUoJM41XuKEErAkQJg6E5k+hHb0LtdFJHf3Us
 Lo7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+V2JegwvENLwCpg6zd8+nP64XM/546bXOncbhm+HLLOdmbq1Nrr4M+kiHtH5toareAoYGN1IBffKtH@nongnu.org
X-Gm-Message-State: AOJu0Yw5+5l10pV1kr31OhuwimpaUFQzY2k6uWoVd9/oKEPOybQPXHHI
 X5uAZ8ceto9EbpkpXSO0g4NBId6rzVpMFCc0ZAmPHs2WkZhLMbRLj8yAbMOofxkR6n2cJzXofpb
 q5y5Ue+s=
X-Gm-Gg: AeBDies/PUTTCbbWWgoAIyFi/lEJjYfIN7J0pCdT40Y6vp8bnaUq+4LLsPObwejo84q
 C+otAaoIQcEtxW9Jhnzo/9o3/0y5ky8Xr8HeChgNB8uZqzGLJDx2neTYoJB2x83WcEdbH4d/z0c
 6LYezJhHFSS97udH71/XAlBpT+nbPzWaZ0FtXWUyOe1zQfYbMK6CGI/BDbHVRHNhLS+RAfFrpZg
 Qu4gQWd60rvmUSfqnRqIJ2cW1xYK0O0+prseqr3tgQEdqBz6aU2deb9MBFmNzss5nQgDv24wR4l
 90hgivzotmXQP3tW1RSpC3fWBdGluDaA64lxN7L/yY4m0oUmmSAXHs5CgQoPduNtNua2+gr0u5u
 r8IRmxpNM+8jJRVbbMCZ2rCBHCQuvmK1Gam9UhvKw1E5nYrqS9b1C683ST9dsUe2DpkPghqgJhG
 6yPhGD/ANsR3++azxvFgvjU+/3zsr7Rntpu9BdCMVXMzvQxhMGk8EItn1y9lvcf1tI3xq0BD+Ne
 DTu
X-Received: by 2002:a05:600c:4e4c:b0:48a:58ae:9938 with SMTP id
 5b1f17b1804b1-48a58ae9f69mr222905085e9.19.1777026850016; 
 Fri, 24 Apr 2026 03:34:10 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a6114f2cfsm27662475e9.35.2026.04.24.03.34.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 03:34:09 -0700 (PDT)
Message-ID: <042ffa5c-78df-4134-bda4-bcb68d0c0296@linaro.org>
Date: Fri, 24 Apr 2026 12:34:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/s390x: Leverage 128-bit vector type in VLL /
 VSTL opcodes
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org
References: <20260423141538.51583-1-philmd@linaro.org>
 <986c02ec-4e43-41c9-b520-7c5a41ca4109@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <986c02ec-4e43-41c9-b520-7c5a41ca4109@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 23/4/26 17:41, Ilya Leoshkevich wrote:
> 
> On 4/23/26 15:15, Philippe Mathieu-Daudé wrote:
>> The access is unaligned, we can easily replace the 2
>> consecutive 64-bit calls by a single 128-bit one.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Based-on: <20260423135035.50126-1-philmd@linaro.org>
>> ---
>>   target/s390x/tcg/vec.h        | 12 ++++++++++++
>>   target/s390x/tcg/vec_helper.c | 19 ++++++++-----------
>>   2 files changed, 20 insertions(+), 11 deletions(-)


>> diff --git a/target/s390x/tcg/vec_helper.c b/target/s390x/tcg/ 
>> vec_helper.c
>> index 98eecd9fde6..feb99f51c78 100644
>> --- a/target/s390x/tcg/vec_helper.c
>> +++ b/target/s390x/tcg/vec_helper.c
>> @@ -48,14 +48,12 @@ void HELPER(vll)(CPUS390XState *env, void *v1, 
>> uint64_t addr, uint64_t bytes)
>>       MemOpIdx oi;
>>       if (likely(bytes >= 16)) {
>> -        uint64_t t0, t1;
>> +        Int128 t;
>> -        oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
>> -        t0 = cpu_ldq_mmu(env, addr, oi, ra);
>> -        addr = wrap_address(env, addr + 8);
>> -        t1 = cpu_ldq_mmu(env, addr, oi, ra);
>> -        s390_vec_write_element64(v1, 0, t0);
>> -        s390_vec_write_element64(v1, 1, t1);
>> +        oi = make_memop_idx(MO_BE | MO_128 | MO_UNALN, mmu_idx);
>> +        addr = wrap_address(env, addr + 16);
> 
> I don't think we need to increment the address before loading from it.
> 
> We used to have +8, because it's the offset of the 2nd half.

Right!


