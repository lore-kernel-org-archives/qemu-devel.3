Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADE7FF885D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 10:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGZx7-0001uV-Hd; Sat, 25 Apr 2026 06:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGZx6-0001tz-69
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 06:09:32 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wGZx4-0006uB-E4
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 06:09:31 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43d7e23defbso5163724f8f.0
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 03:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777111769; x=1777716569; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8bL2ZcgkPjl8ISTmQ4lxnBY/k0LMIAlrPUx2Ra5XzxQ=;
 b=OzdNJDqVYJsIu1mwVVSj8H6EumO53QRx1eEl778wiorDXbCzl8sWCeo3Xn0H6TWBsM
 QxCDl7lk4dWfn8BERny3cbuVVcnrODtqYw0reSumQwMhZuCLEvpURVCbvPOEJkPKEjkr
 stAkfyb2n8UOYYKodgKAv4ARIBMBQ8VD3DsukEhmEYVYi6dWG1CqisyJVLxnuXKCD/Eu
 vKX2utlqwbST9hOdM4VZtc6aZVHeCxmPjC8Isf2HBLoiA3hcLlvGgfjNx42FbP4zeqxO
 dzjCZpVjuyjIJ8ZoYAk4DnjyqG+2mOUDN6GG8sbmIGLBfnBYQzQB4PqQ5LFol0mXJklw
 2rJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777111769; x=1777716569;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8bL2ZcgkPjl8ISTmQ4lxnBY/k0LMIAlrPUx2Ra5XzxQ=;
 b=fET2075081zePMwtkK2WAUKrm6FuvG/DBvuKrx0TumyBlhHNGNJSOhBwkOwLVmAos5
 ihTAjq/l/5dg/kMDC7hfEKqV9bp2ej1gaEDpViXaFCv7Z7+ZhurqB68DpT6YOrG4JRkg
 7CSxcFhgi1QpUf1a6uF6qlhp9JwAxN8vfv/ntVy1uS9Wo8ulPFr170zn6DeMtYTKgGyj
 CsMiekwABx9Y4eMX1OvISckxSBlUT/IUjPXDUAQU7Gx29M/CgjMCQ44BIii3Kp9aouuB
 6x1BF4haqsZi1KYo5vVF6Q51HfXa7j0yoEqpUR6d6IkCyr55vaNEA2HnYU/ag3NZLoDo
 TbXQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8qYb+bDz0VOMVdErKd98tAuqtQLpXHKYQjqcu+PUtaxePIZJj+U+MGdCALNLk8XCF4VIcO7NKiVgbu@nongnu.org
X-Gm-Message-State: AOJu0Yw8j7tMko+7GHWo/UrWa7jzGNFt2m61SFacy5XsyNa1hKIVf/i9
 q739fXa70u9o0K2AbLgHJ0lmGgh9iIjY8YR4UHeB+vYQMfVwV9mr6URga2DBC2EPHv4=
X-Gm-Gg: AeBDiesejVTwqSGC9YUvp9p5iBTCQdOVZ8oyDp2kcUI1XBfdp9M8+3ejk5o8b6IS/fz
 T2l3QiSLA6/iwLUGyqPTGvOcrCWXKXPZnKPw5UTJM4VHpPJbGDCom2hFKy7aRKPA59nzCYQI89G
 9KYbqJJyW5b08ptPDaNFDusXsMYK00qB+vVlr0yYstRG1PfnviCUV1OJ0QLXaeX/FE1VPH/ofhP
 rkSPxZHtpSyNWQ8hYViqybfqdBM75pI4BfNJsYUrJYe/lOuaCi6XYzN/Ztmr5vnweDJBibwTIgu
 F36zSKUpPcJEIVwkDh0dQhYhIC+00SMMKIvMUZBKpXAOtLnJE0do2YJRT6uPh/57Ly/tHXgN2r3
 MyfID1y2WgsIrPcZ9BzJYeqWc3vIZpXwNXBNjPVn1CcqqsGXYlAuo/DgMvDhXB0saunOFvjfMhn
 aox1wEQf4KTSf/2dGc+lfovxWkO/tWZKrvwNtgCY2n2qMVOvejobSiubIJ8H/O4+/Ka3y65X5ZM
 eBV
X-Received: by 2002:a05:6000:200e:b0:43b:8fa4:1937 with SMTP id
 ffacd0b85a97d-43fe3db3cfbmr56620260f8f.5.1777111768718; 
 Sat, 25 Apr 2026 03:09:28 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4412150a071sm29857879f8f.21.2026.04.25.03.09.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Apr 2026 03:09:28 -0700 (PDT)
Message-ID: <fccd4e70-0e0e-468e-a11a-cc120c81e4bd@linaro.org>
Date: Sat, 25 Apr 2026 12:09:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/s390x: Leverage 128-bit vector type in V{L,
 ST}L opcodes
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@kernel.org>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
References: <20260424104325.81484-1-philmd@linaro.org>
 <56bfecd4-6169-4512-b019-2c9d6367525e@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <56bfecd4-6169-4512-b019-2c9d6367525e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 25/4/26 00:05, Ilya Leoshkevich wrote:
> 
> On 4/24/26 11:43, Philippe Mathieu-Daudé wrote:
>> The access is unaligned (MO_UNALN), we can easily replace the 2
>> consecutive 64-bit calls by a single 128-bit one.
>> Considering atomicity of the new 128-bit access, the both opcodes
>> VLL (Vector Load with Length) and VSTL (Vector STore with Length)
>> access byte granularity, so use MO_ATOM_NONE.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Based-on: <20260423135035.50126-1-philmd@linaro.org>
>>
>> v3:
>> - do not increase addr (Ilya)
>> - MO_ATOM_NONE (Richard)
>> ---
>>   target/s390x/tcg/vec.h        | 12 ++++++++++++
>>   target/s390x/tcg/vec_helper.c | 17 ++++++-----------
>>   2 files changed, 18 insertions(+), 11 deletions(-)
>>
>> diff --git a/target/s390x/tcg/vec.h b/target/s390x/tcg/vec.h
>> index 8d095efcfc6..34413f7e029 100644
>> --- a/target/s390x/tcg/vec.h
>> +++ b/target/s390x/tcg/vec.h
>> @@ -13,8 +13,10 @@
>>   #define S390X_VEC_H
>>   #include "tcg/tcg.h"
>> +#include "qemu/int128.h"
>>   typedef union S390Vector {
>> +    Int128 quadword;
>>       uint64_t doubleword[2];
>>       uint32_t word[4];
>>       uint16_t halfword[8];
>> @@ -72,6 +74,11 @@ static inline uint64_t 
>> s390_vec_read_element64(const S390Vector *v, uint8_t enr)
>>       return v->doubleword[enr];
>>   }
>> +static inline Int128 s390_vec_read_element128(const S390Vector *v)
>> +{
>> +    return v->quadword;
>> +}
>> +
>>   static inline uint64_t s390_vec_read_element(const S390Vector *v, 
>> uint8_t enr,
>>                                                uint8_t es)
>>   {
>> @@ -117,6 +124,11 @@ static inline void 
>> s390_vec_write_element64(S390Vector *v, uint8_t enr,
>>       v->doubleword[enr] = data;
>>   }
>> +static inline void s390_vec_write_element128(S390Vector *v, Int128 data)
>> +{
>> +    v->quadword = data;
>> +}
>> +
>>   static inline void s390_vec_write_element(S390Vector *v, uint8_t enr,
>>                                             uint8_t es, uint64_t data)
>>   {
>> diff --git a/target/s390x/tcg/vec_helper.c b/target/s390x/tcg/ 
>> vec_helper.c
>> index 98eecd9fde6..a86819f61b6 100644
>> --- a/target/s390x/tcg/vec_helper.c
>> +++ b/target/s390x/tcg/vec_helper.c
>> @@ -48,14 +48,11 @@ void HELPER(vll)(CPUS390XState *env, void *v1, 
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
>> +        oi = make_memop_idx(MO_128 | MO_UNALN | MO_ATOM_NONE | MO_BE, 
>> mmu_idx);
>> +        t = cpu_ld16_mmu(env, addr, oi, ra);
>> +        s390_vec_write_element128(v1, t);
>>       } else {
>>           S390Vector tmp = {};
>> @@ -206,10 +203,8 @@ void HELPER(vstl)(CPUS390XState *env, const void 
>> *v1, uint64_t addr,
>>       probe_write_access(env, addr, MIN(bytes, 16), GETPC());
>>       if (likely(bytes >= 16)) {
>> -        oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
>> -        cpu_stq_mmu(env, addr, s390_vec_read_element64(v1, 0), oi, ra);
>> -        addr = wrap_address(env, addr + 8);
>> -        cpu_stq_mmu(env, addr, s390_vec_read_element64(v1, 1), oi, ra);
>> +        oi = make_memop_idx(MO_128 | MO_UNALN | MO_ATOM_NONE | MO_BE, 
>> mmu_idx);
>> +        cpu_st16_mmu(env, addr, s390_vec_read_element128(v1), oi, ra);
>>       } else {
>>           oi = make_memop_idx(MO_8, mmu_idx);
> 
> 
> In general LGTM, but I just tried this on top of 20260423135035.50126-1- 
> philmd@linaro.org and I'm consistently getting:
> 
> 
> make[2]: *** [Makefile:236: run-precise-smc-softmmu] Error 1
> 
> 
> The test uses VSTL, so it's definitely related.

Is this on a big-endian host? (Asking because this is the single
configuration I didn't tested)

