Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E16C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 14:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRYWf-0005lb-KK; Wed, 10 Jul 2024 10:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRYWd-0005hg-6Y
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:42:31 -0400
Received: from mail-il1-x129.google.com ([2607:f8b0:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRYWa-0000nJ-CD
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 10:42:30 -0400
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-381f24d6bc4so25648835ab.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 07:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720622547; x=1721227347; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0chmTPrpv/QcEAGL+GHmIW/+wnaH1ufbuQMbsep2CrU=;
 b=yc7r0ro9l6+AAHt6t2TCKq2M2Y4CHze1QW2ZnC++89WRAWMeqm6NPHbqWjtD00ohAC
 Q5z4xaAm6qmmETpnn7ukj6cjCw6zR2LVUL54f54dgeqJhaFZWXXQ3vQ03s3/8y2Ck47/
 eZFQo0xMw/NvdYBKQ+MbqSCqpV0jyTU8pW8jI50iZnPw8k58p/BdjNf21BaphjknFyO0
 JAevylWg1Bpj8tBQbtKZIC0riwRxK8q7f/dCiiEQfaoJeDds9nCyY+fz3MseE4p/agVV
 sSkqNiE1qQiZjfKEVi/VolmQOUqX8NOkgSrYjWZPV41WdE/Zfosf5PBqIjiqZo023GgX
 LDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720622547; x=1721227347;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0chmTPrpv/QcEAGL+GHmIW/+wnaH1ufbuQMbsep2CrU=;
 b=HBpcHiNKSXtOcyEktj8QSZjFS/ELoD0kxCpNh1IKHs+BD7USl16+Rr8/uM6WJ/WQT2
 +D5PCy+tIrIb4IGAgJsWsEFtWoSnqcwCtCRIMikvjaWPx4WtQrUnqK+e6uPatc87sJcE
 4wkdinb4GpYwVGSkvTQVJHcQ+NZxOL3h0doRxLS+3Lp57bH9Z4Ncm/sE2XvnHWxJeQ6g
 3gpKISQGMjs+e0pD9W5k6b8IqsYXvimjcK52Kum/aReLCRgjrOYzUh29jh1WscjmzXhY
 JnWp2fel8EjTLY6v51PIeHl5+02RgTLWabRod1bsNU4lmoXRSUDLRXgDmvUWp78X3vZG
 9uYA==
X-Gm-Message-State: AOJu0Yz79zyb+Fd4zKzKMn+xnPQKmCueryDGzqflIGyHc6oGe8wgukhl
 9iGeDatqWvn8nHELjuGFzid4Ig/1gf/X5qKI1QtD2gut62jyynA+1hbV2FvLNCw=
X-Google-Smtp-Source: AGHT+IEdw3c8Kd1FF590o1pPV/su74B1J7sPja8A1ftRMAaIxw8RALj6nadiibddxaKky+2V5BrNCw==
X-Received: by 2002:a05:6e02:b26:b0:382:db50:6ebd with SMTP id
 e9e14a558f8ab-38a5910a09bmr66302045ab.27.1720622546903; 
 Wed, 10 Jul 2024 07:42:26 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-77d680cae23sm3037812a12.78.2024.07.10.07.42.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 07:42:26 -0700 (PDT)
Message-ID: <92a009d9-e5bc-44f7-a1ae-31e007bc6c76@linaro.org>
Date: Wed, 10 Jul 2024 07:42:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/13] target/ppc: Improve helper_dcbz for user-only
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongu.org,
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org, max.chou@sifive.com
References: <20240710032814.104643-1-richard.henderson@linaro.org>
 <20240710032814.104643-10-richard.henderson@linaro.org>
 <6b2f8ee5-0715-5040-403e-943a16ec170e@eik.bme.hu>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <6b2f8ee5-0715-5040-403e-943a16ec170e@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::129;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x129.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On 7/10/24 05:25, BALATON Zoltan wrote:
> On Tue, 9 Jul 2024, Richard Henderson wrote:
>> Mark the reserve_addr check unlikely.  Use tlb_vaddr_to_host
>> instead of probe_write, relying on the memset itself to test
>> for page writability.  Use set/clear_helper_retaddr so that
>> we can properly unwind on segfault.
>>
>> With this, a trivial loop around guest memset will spend
>> nearly 50% of runtime within helper_dcbz and host memset.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> target/ppc/mem_helper.c | 14 ++++++++++----
>> 1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
>> index 24bae3b80c..fa4c4f9fa9 100644
>> --- a/target/ppc/mem_helper.c
>> +++ b/target/ppc/mem_helper.c
>> @@ -280,20 +280,26 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
>>     addr &= mask;
>>
>>     /* Check reservation */
>> -    if ((env->reserve_addr & mask) == addr)  {
>> +    if (unlikely((env->reserve_addr & mask) == addr))  {
>>         env->reserve_addr = (target_ulong)-1ULL;
>>     }
>>
>>     /* Try fast path translate */
>> +#ifdef CONFIG_USER_ONLY
>> +    haddr = tlb_vaddr_to_host(env, addr, MMU_DATA_STORE, mmu_idx);
>> +#else
>>     haddr = probe_write(env, addr, dcbz_size, mmu_idx, retaddr);
>> -    if (haddr) {
>> -        memset(haddr, 0, dcbz_size);
>> -    } else {
>> +    if (unlikely(!haddr)) {
>>         /* Slow path */
>>         for (int i = 0; i < dcbz_size; i += 8) {
>>             cpu_stq_mmuidx_ra(env, addr + i, 0, mmu_idx, retaddr);
>>         }
> 
> Is a return needed here to only get to memset below when haddr != NULL?

Oops, yes.


r~

