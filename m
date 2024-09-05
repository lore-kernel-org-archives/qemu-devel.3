Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32583CE7A8C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 19:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smIKs-00035a-FT; Thu, 05 Sep 2024 15:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1smIKm-000328-FM
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:40:01 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1smIKk-0002wb-9x
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:40:00 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20551eeba95so12246625ad.2
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 12:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725565196; x=1726169996; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OgVEac63Wi6iW9mh8KU0SsJkNzB9pltNijJ6M0WOQwA=;
 b=WrxP0n70wn9do8N9/TmG5Vs54e9ZidaG8lC3FUOxvSrSVhzO52sXwmd/b8KNWvPreU
 MFnIp1qkr5fISPyKxLupqs4+WQe2zWMTT5Mm0Xt6tK0nSdKXRDq8SgvoW1wqQyv3cSnL
 4TFUm42yEY0CfHpstYeNJjbhT5g0po2/E9ZGcO9IA866N8yfGxLL1kRfpQmd4IAh5ni7
 6/qjiA1NYVxwrCNui1NchoZRvwNPQKueNqbBpkgkFWRKLA+9ywjcXEfd0i5Pk+IvuhcT
 COXzmtg30ddEI/52L10Ihlb2yTB+4rfMvAgMV7bGezAc0TS9YqtsoGjeKzqMyVxFZ+1a
 JS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725565196; x=1726169996;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OgVEac63Wi6iW9mh8KU0SsJkNzB9pltNijJ6M0WOQwA=;
 b=j2ZnIWU+ihrVUm6bcJEhfjicaAU3LVMfXlHU5orQs2ILVEqLlC4vFV3jICFkEIBSt/
 ievv1ZswZyRfFrlNVHb4Z7R6kZ4+HocJigqbnW5rkG4Ba7Zq2n4lXOdzra5dhYcPWO3B
 +Cj+AKkmcUTq9sxcWmWDcVqMvibNo7bVrlzA/nV6Sb4q88nZL8KoBOGgdEtvHd4hOpQd
 8ekcO1ZuoqnWlAcQ3p5w06DRa+gTfNCVdx4Dt91kU2W1n8z4MRqzkpEu70Wn97/AHO6C
 AEGe6hL68S8dFi3/8e3dGPKULXHTT4P+pPzgGh1NYjTyeSUbrI/j/DXMyicrI/LfPcjo
 inHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3O/UTvzaRCBCn/xtdju2wvkaD/vEQKKvYrL/cbRciUwMokfBQtv+TvC4qxhrOqy2Ab61ibD6/IE8n@nongnu.org
X-Gm-Message-State: AOJu0YwB/RHM+L0Cu+BoI22P/yNuS1Cihv8imiRIdvINnlkzDRUPUeP5
 lx32ngWMckwpW0qKndKbegOTt07sdzABVxdK6xhfy2sqm9CYcz1DoyIYeNl/cvY=
X-Google-Smtp-Source: AGHT+IE7NaJLYR6GaxDIoLbU+/xVwmdzvFzqLFsdnMgSKqza+q9eiqUzjpLv0RuDTcKwx63vPkvkrA==
X-Received: by 2002:a17:902:d2d2:b0:206:b79e:5780 with SMTP id
 d9443c01a7336-206f0507dc6mr2226805ad.24.1725565195473; 
 Thu, 05 Sep 2024 12:39:55 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206aea38389sm31831145ad.137.2024.09.05.12.39.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2024 12:39:55 -0700 (PDT)
Message-ID: <2c81231c-4c99-4d6b-96d3-47c7c1e1e576@linaro.org>
Date: Thu, 5 Sep 2024 12:39:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] target/loongarch/tcg: Add hardware page table walker
 support
To: gaosong <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, philmd@linaro.org
References: <20240729013939.1807982-1-gaosong@loongson.cn>
 <20240729013939.1807982-6-gaosong@loongson.cn>
 <87ca1589-089a-4ebb-90dd-21780897da98@linaro.org>
 <0cc6072a-d251-5d59-73e5-9009856e06a0@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <0cc6072a-d251-5d59-73e5-9009856e06a0@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 9/5/24 01:27, gaosong wrote:
> How about adding a variable to determine if tlb needs to be modified?
> like this:
> 
> @@ -248,7 +250,7 @@ hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>       int prot;
> 
>       if (get_physical_address(env, &phys_addr, &prot, addr, MMU_DATA_LOAD,
> -                             cpu_mmu_index(cs, false)) != 0) {
> +                             cpu_mmu_index(cs, false) != 0, false)) {
>           return -1;
>       }

Yes, that sort of thing.  In other targets the flags is called 'debug'.

>>> +        entry = ldq_phys(cs->as, tmp0) & TARGET_PHYS_MASK;
>>> +
>>> +        if (entry == 0) {
>>> +            return ret;
>>> +        }
>>> +
>>> +        /* Check entry, and do tlb modify. */
>>> +        if ((tlb_error == TLBRET_INVALID) &&
>>> +            (access_type == MMU_DATA_LOAD ||
>>> +             access_type == MMU_INST_FETCH )) {
>>> +            if (!(FIELD_EX64(entry, TLBENTRY, PRESENT))) {
>>> +                break;
>>> +            }
>>> +            entry = FIELD_DP64(entry, TLBENTRY, V, 1);
>>> +        } else if ((tlb_error == TLBRET_INVALID) &&
>>> +                   access_type == MMU_DATA_STORE) {
>>> +            if (!((FIELD_EX64(entry, TLBENTRY, PRESENT) &&
>>> +                  (FIELD_EX64(entry, TLBENTRY, WRITE))))){
>>> +                break;
>>> +            }
>>> +            entry = FIELD_DP64(entry, TLBENTRY, V, 1);
>>> +            entry = FIELD_DP64(entry, TLBENTRY, D, 1);
>>> +        } else if (tlb_error ==  TLBRET_DIRTY) {
>>> +            if (!(FIELD_EX64(entry, TLBENTRY, WRITE))) {
>>> +                break;
>>> +            }
>>> +            entry = FIELD_DP64(entry, TLBENTRY, D, 1);
>>> +            entry = FIELD_DP64(entry, TLBENTRY, V, 1);
>>> +        }
>>> +        stq_phys(cs->as, tmp0, entry);
>>
>> You certainly want to use a compare and swap here, restarting if the compare fails.
>>
> Sorry ,  I don't understand here, could you explain it in detail?

A plain store will have an smp race condition with the guest kernel.
The update needs to be atomic.

Compare:

   target/arm/ptw.c, arm_casq_ptw()
   target/riscv/cpu_helper.c, get_physical_address(), s/cmpxchg/
   target/i386/tcg/sysemu/excp_helper.c, ptw_setl()


r~

