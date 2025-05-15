Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1698C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 08:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFThz-00032f-T1; Thu, 15 May 2025 04:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uFTg3-0003ey-Vb
 for qemu-devel@nongnu.org; Thu, 15 May 2025 04:10:54 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uFTg1-00015K-7T
 for qemu-devel@nongnu.org; Thu, 15 May 2025 04:10:51 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-441c99459e9so4020315e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 01:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747296647; x=1747901447; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i8blzH84htNdwLmxGF8Fo5lYEnrapevirfn7c/HQO2s=;
 b=TedL2Jo/mN3Xv/MiQMqiuObDbU5Edngjr0tUp0n095SHdxoroA65BKnw53BcbtlGpc
 72dmDGLxJvZ5Dw+/nOEipjNOFOR+Lbi5BJZbFtVvL2F6TDum5AKngwwgj9EeDPpRtWzs
 Y2fBty83M4ENFIaIViypwrbTqU751o1CH3lKVUsghlFLYh+nNcjfTWLKL6Nlxw4Lkdmi
 GG7viHKDZ22ERauciAwW6AQ1ymdv7v+DvrqiwndRZjpEiu4XdH41yuYnGd/NuetvZTSh
 2bueFsmTy442sS1CzcxCm5iRBgHA59AVtsNfPJEY1tkFi8P4z7z2ohL5vJqPZ4LiEZey
 QRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747296647; x=1747901447;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i8blzH84htNdwLmxGF8Fo5lYEnrapevirfn7c/HQO2s=;
 b=K9FBZvYmbvstZKd0juocQz4EDExQIblwzcnakSAiw7fnLX/rg9yTwAG6WW4LpoRhxS
 /jsOrkupxTZuuErdKbcrgfElOT0MeLUf9OixjXnxD28pxtOgVDkdgv0t61Jil73yZDgR
 pSh2XHqxmT5z3x/0ZRarAFdbmm4R+pIF0I4MVKgIJ+k5By6/kKx43dnvsRmk3ELcPvjK
 nERrHhKMBylyHf52J8zzVu9ALgpjXEQuQqaYnNCI3MFbCfDuDHe9yimWaJOE/Y1T2atU
 6c+kkTHsfMm4QB9DiRKPKnTLBV18Pomqk1x/YZBgwjDy+kE2pIT+qs26zyfUEALHI7kv
 yO5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCnU4g30jCmpBYY1pqz2F5fkwQHeHgAI+Aes/22/dQn8B3KGQzqiAEXs29GiU/Lzq91sEckwZ/qCtS@nongnu.org
X-Gm-Message-State: AOJu0Yw1obEtqvLmqzpEoLHJDynoHASNFf5li6OMrhiGhRvFUa/Ehh8e
 eX51O3HjktP9PG/mJ3YBaZmU8AIR+gD9DIjcJsXrHZTME5VeiI1VbHIvJ75e0zI=
X-Gm-Gg: ASbGncvkMPi2puzOuruaib+CAnI0NFOnSwBBOWE58dVzBSXpDzSOeU3lNsTB+9aqtTJ
 xcxVFGm0uC4RFz5InahnjzJK8W/+C3yqnnrJS944fPNT4PLy07p1Pj9ZeJgjZ5Ur8Jo3G2HOQkD
 sryGuVtEfnMgp+yyeA+2hwneWznLPIHa/yeIzKrnf2eSkMRllHBe9i9FHUoFn/qrg3xnqB3g7Gn
 ks9SdZtWM/ymdEOaNYJ/685hKZ+AoL63tY5Sul2SnnqC7eU5Y+gMXo0Cob5f6Sqpozg/Mx6nz/P
 pqUxgPt13N87eX9NrOw8Z731lF7A/zF1y1DVFqEMOKx7uuTQ+P/jIymlhuSMFcsE/FDrag3X4Cm
 dUxT+rfmjvG06xCM=
X-Google-Smtp-Source: AGHT+IG0Fns6yAf9hOAHmp8An9ONTUC9VGwI7rATJ/7WEZqPt3yEGTeQkFeiymgJA/pLmWtbhOw7JA==
X-Received: by 2002:a05:6000:1445:b0:3a1:faa7:89e2 with SMTP id
 ffacd0b85a97d-3a34994ef7emr4623394f8f.58.1747296646704; 
 Thu, 15 May 2025 01:10:46 -0700 (PDT)
Received: from [10.61.1.10] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a4bbf0sm21633059f8f.82.2025.05.15.01.10.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 01:10:46 -0700 (PDT)
Message-ID: <29536f13-b441-4cb4-a58e-831c008a0962@linaro.org>
Date: Thu, 15 May 2025 09:10:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] target/riscv: Fix write_misa vs aligned next_pc
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com
References: <20250425152311.804338-1-richard.henderson@linaro.org>
 <20250425152311.804338-8-richard.henderson@linaro.org>
 <b1b72b45-d1fe-4ff4-8649-cbfd32e5f8a8@ventanamicro.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b1b72b45-d1fe-4ff4-8649-cbfd32e5f8a8@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/14/25 22:33, Daniel Henrique Barboza wrote:
> Richard,
> 
> On 4/25/25 12:23 PM, Richard Henderson wrote:
>> Do not examine a random host return address, but
>> properly compute the next pc for the guest cpu.
>>
>> Fixes: f18637cd611 ("RISC-V: Add misa runtime write support")
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/riscv/csr.c | 22 +++++++++++++++++-----
>>   1 file changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> index a663f527a4..85f9b4c3d2 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -30,6 +30,8 @@
>>   #include "exec/icount.h"
>>   #include "qemu/guest-random.h"
>>   #include "qapi/error.h"
>> +#include "tcg/insn-start-words.h"
>> +#include "internals.h"
>>   #include <stdbool.h>
>>   /* CSR function table public API */
>> @@ -2099,6 +2101,19 @@ static RISCVException read_misa(CPURISCVState *env, int csrno,
>>       return RISCV_EXCP_NONE;
>>   }
>> +static target_ulong get_next_pc(CPURISCVState *env, uintptr_t ra)
>> +{
>> +    uint64_t data[TARGET_INSN_START_WORDS];
> 
> Isn't this 'INSN_START_WORDS'?  I'm seeing code in i386 that is similar
> to what we're doing here and it's using INSN_START_WORDS:

Yes, though INSN_START_WORDS is a very recent change.
Probably the week after I posted this patch set.  :-)


r~

