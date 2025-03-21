Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07843C35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 00:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvQZe-0003lr-Ty; Thu, 20 Mar 2025 20:49:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvQZN-0003jW-8Z
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 20:49:14 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvQZL-0006pw-K6
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 20:49:04 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22435603572so26721775ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 17:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742518141; x=1743122941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F1GjdiALWwLM23BW5wPruQzlNkE+LXjd0xuD3PbPTrw=;
 b=tz5wpFgH7tvb4zy9lmfSOH8bOazQqgdTqInTzbZP/z78X6FEC6LuDMgG9oaghivitP
 Pxjl4Rfg73O/36uj1m7hM9SGheHV8Y2TZVGhRBKSNT79cvQVHHDf4zcCxu5rPi1Bd1Tr
 egiZl1BSV0X7Yyzi/qUQs4zxgzHLLed1lLc1XScjd5oHIl2iaZ02XxmVou6yylsaKGgB
 V8GEP4MU17dHLa+LoF13kwNrCdZgAUtgaD/bD6Jyle4d54rE14H+j1MR5DgT0n/r1g7d
 MdqS0/TntOj40NGtMcEpRjGqv62wQgqPyT0Bh9v+zwHuILecsDvY4ju8j45pbuPzna5p
 lKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742518141; x=1743122941;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=F1GjdiALWwLM23BW5wPruQzlNkE+LXjd0xuD3PbPTrw=;
 b=jpv5EQxVM901kn9Mn217EtFwcnit7fJ+UNgu7I2WfMMXyUMJYJBHo+w9n7M09N3nKy
 0fG6jRvfv0NNOEp5cYoP5s0GFCeSCzKDnQcof9Nq62eZxoLhpi+Fli9ha5VJvp9cmh4/
 Y3u4SWAChF28jovAFi+yfClZWv9Op7pvTEhvRHQLqLKhsAtCW9Uku1GvHYSLsOlYK6+d
 NJUTNrQMNktdEOR+QSZkaRdN8vyjkeoUhKoCL4+SA4498Gz1lT90D01J0S2u0cSOuzpd
 xt0GSeSOt9M8Hr1zI4uivS/CC+3Yr+Jp8WukoUH27n9R39hFKShlkSJwdJVwVA8ygjok
 /C4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtBzr1OurLk37IGumJaba14XSWL/VHwtaFCbkavAh9HvCBTiepRyegy8XGCnOR+b5D4CvBpKQ45DLx@nongnu.org
X-Gm-Message-State: AOJu0YwvOY5WSi31rysN/BiGJbr77N/XRxbtUvfZzd/JXg6R4AIbmqz/
 23UY1Dkh9njZuRxoHStVEK/3rddvDWG5eV4Q7sRoQVhRKAREPvpdiutCr/uZb08=
X-Gm-Gg: ASbGncshfxxu8Yf0TMxIv+HJRGLlzNiFnyRl3/t6SzFUkwQiOHcdsbgTDKEqCnutAAu
 n38YkdMzd7ZZjnTQ4MFG5/P55+42QKuW2GgFJHwQYTNy7dSK7oZDBuYoOZMibzxYedNdyUxH9jh
 vdWIKDGtmQdWNNmVyokqFPZfLcwx5TbFk09jfC+kvLzs9oL8qTU/31WSoJBtiEjmB+uSotOvyLe
 O4BJ3dxPpvtGOVRCTOxsiGdkW03WQ4n1i3lD5kulx4wmWvtkuWLHrhOKOmHPWf9i/n+cNz17XTU
 /I2eAq+uAApINe+bWrYIo4fN81tLyHmBfQ/AaYEXf8s5Nv4MbTINbptku9b+dEqqjuKKZYEhRs7
 H6sU10yoR
X-Google-Smtp-Source: AGHT+IHF7glLrb83Huy380tNR0azGLpyl8GXDobSLLnDta04yzWiv9zmypTg09YJA7jwsvBONI8nUw==
X-Received: by 2002:a17:903:18c:b0:223:4816:3e9e with SMTP id
 d9443c01a7336-22780c7a8e9mr15388355ad.13.1742518140744; 
 Thu, 20 Mar 2025 17:49:00 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4579asm4553645ad.60.2025.03.20.17.48.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 17:49:00 -0700 (PDT)
Message-ID: <0d51b754-14bf-4a05-864e-0e3e7e5be2cd@linaro.org>
Date: Thu, 20 Mar 2025 17:48:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/42] accel/tcg: Use cpu_ld*_code_mmu in translator.c
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-13-richard.henderson@linaro.org>
 <f3b98848-70b7-4ece-8ba2-43f0e07302ac@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f3b98848-70b7-4ece-8ba2-43f0e07302ac@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/18/25 17:23, Pierrick Bouvier wrote:
>>   uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
>>   {
>> -    uint64_t raw, tgt;
>> +    uint64_t val;
>> -    if (translator_ld(env, db, &raw, pc, sizeof(raw))) {
>> -        tgt = tswap64(raw);
>> -    } else {
>> -        tgt = cpu_ldq_code(env, pc);
>> -        raw = tswap64(tgt);
>> -        record_save(db, pc, &raw, sizeof(raw));
>> +    if (!translator_ld(env, db, &val, pc, sizeof(val))) {
>> +        MemOpIdx oi = make_memop_idx(MO_UQ, db->code_mmuidx);
>> +        val = cpu_ldq_code_mmu(env, pc, oi, 0);
>> +        record_save(db, pc, &val, sizeof(val));
>>       }
>> -    return tgt;
>> +    return tswap64(val);
>>   }
>>   void translator_fake_ld(DisasContextBase *db, const void *data, size_t len)
> 
> If I understand correctly, cpu_ldq_code_mmu performs the tswap call we used to before. 

Incorrect: cpu_ldq_code_mmu has no tswap.

It has a conditional bswap, if MO_BSWAP is set, but that's not true for the MO_UQ used 
here.  Therefore both the direct load in translator_ld and the cpu_ld*_code_mmu function 
call both produce host-endian values.

Therefore the tswap at the end correctly swaps host to target-endianness.


r~

