Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92383D24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ8S-00069F-Th; Fri, 11 Oct 2024 13:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1szJ4z-0000wP-RW
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:05:30 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1szGvC-0000yd-3h
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 10:47:15 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2e2cc469c62so1499651a91.2
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 07:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728658031; x=1729262831; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wb8rUR8AHX9p+yjPP1pvDx70iOr6RNAB7Xt4PWYFEjg=;
 b=erMSNfsd9rXfEg7x4y7iVir+HaM8wKIj29ISNOLpAxxguTLz8c7Jj9hPYgrhdqGaqT
 uKtXlOsHgCt3DzHocZqvzwkxlDnNrqQCvkjeLsTrFiSvrGws6boHphwHGlCJCMj+CY3X
 pPjVBo2gBcl8m5k7UbQhyyfUWvpFjOBK69Sg/5Ff7fx97jsqIdRodrpD77L8pqmL4EwS
 TekGM2tErc/Dmn3dbmfd+0Lce4e3AU3ITsbUQ9rFC9URa5yS2OIXt7A1kFXD7dhf/kUF
 lgmjxKiw10HU4YUjvUQZ4Bd8XrSBRA3HvyvToL5RmpeCwuG35Kb8ax9n0VU4lNE4Qe/Q
 IUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728658031; x=1729262831;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wb8rUR8AHX9p+yjPP1pvDx70iOr6RNAB7Xt4PWYFEjg=;
 b=nPwaAPQUt1hb7Jz4LzqJrZV5LKacs26EIS0sOlMecIg6haVyfKNcXiYg4GIv2yLudX
 qloK80a59qiGSlr2YgenvyfyBc9nAkjQ3NY8MJq1EfVLxxZxpMu6JSNNf2C/yQ+/nAjL
 OB/lCQrmOXFCenGlco7aqPZj7o2T4vojM9JPs0bdWapSyKMM+rJB0QoxeaQF6NaAgh1l
 PF9Elk7eDAstQLiJPhYFv8id2nEND9uTyoGVubWnBQ+hH5OUwydYzd0zc30UgHblD17x
 yya08Zm7wdbXBxndw4j3qRXg2cjXZlF5Y7OuYjxP/NhXVCSudkIJwpLODUVvaTMoxpPi
 uGFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNbci3g169saUEhuBmUsnmA0pxBhs+yJ03AszXeOi+ep/hu0QH9pFrGhM2/4OuN0Ttert4XOfw40E5@nongnu.org
X-Gm-Message-State: AOJu0YyWVKlaHfpfKMfp0IOuohYaKHLs8iyNarBhYe6oDiz2zERRJEN5
 mXESD0vDJHcsDxy6Jz06uDKydak/qBvg2naeHJa/Wa7J6zmqnU5w3Ge6hBQ776w=
X-Google-Smtp-Source: AGHT+IF0wBlKhZgqycVOKgcBYSocSwZslZRxQMUEZ1o4W1btpMCZGClnADdYeD88aYLLh0RvRA/lxw==
X-Received: by 2002:a17:90a:ad82:b0:2d8:3fe8:a195 with SMTP id
 98e67ed59e1d1-2e2f0a16ec5mr4069713a91.4.1728658031447; 
 Fri, 11 Oct 2024 07:47:11 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5f0b03bsm3273154a91.34.2024.10.11.07.47.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 07:47:10 -0700 (PDT)
Message-ID: <ad8716ae-2d7b-43bb-9653-ed8d9e4b83df@linaro.org>
Date: Fri, 11 Oct 2024 07:47:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/23] accel/tcg: Always use IntervalTree for code lookups
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-20-richard.henderson@linaro.org>
 <c81af2ad-fe0d-4f9f-8bc2-23bcd49354ea@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <c81af2ad-fe0d-4f9f-8bc2-23bcd49354ea@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 10/9/24 17:35, Pierrick Bouvier wrote:
>> @@ -1061,15 +1061,13 @@ static inline void tlb_set_compare(CPUTLBEntryFull *full, 
>> CPUTLBEntry *ent,
>>                                      vaddr address, int flags,
>>                                      MMUAccessType access_type, bool enable)
>>   {
>> -    if (enable) {
>> -        address |= flags & TLB_FLAGS_MASK;
>> -        flags &= TLB_SLOW_FLAGS_MASK;
>> -        if (flags) {
>> -            address |= TLB_FORCE_SLOW;
>> -        }
>> -    } else {
>> -        address = -1;
>> -        flags = 0;
>> +    if (!enable) {
>> +    address = TLB_INVALID_MASK;
>> +    }
>> +    address |= flags & TLB_FLAGS_MASK;
>> +    flags &= TLB_SLOW_FLAGS_MASK;
>> +    if (flags) {
>> +        address |= TLB_FORCE_SLOW;
>>       }
> 
> I'm not sure to follow this change correctly.
> After, the final address and flags value depend on flags in parameter, while before, it 
> used to depend on flags & enable parameter.

This deserves to be split out; I even thought about it Monday night but then forgot when I 
restarted on Tuesday morning.

Before, address is -1 for disabled, mostly because that mirrors what you get with memset 
to initialize the tlb.  All of the flags are discarded.  But the only thing that's 
important is that TLB_INVALID_MASK is set.

After, TLB_INVALID_MASK is still set, but the flags are retained.  This is because we want 
a source of those flags to use for MMU_INST_FETCH.  With this patch set we no longer store 
flags for execute and instead grab them from the flags for read.  From tlb_set_page_full...


>> @@ -1215,9 +1213,6 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
>>       /* Now calculate the new entry */
>>       node->copy.addend = addend - addr_page;
>> -    tlb_set_compare(full, &node->copy, addr_page, read_flags,
>> -                    MMU_INST_FETCH, prot & PAGE_EXEC);
>> -
>>       if (wp_flags & BP_MEM_READ) {
>>           read_flags |= TLB_WATCHPOINT;
>>       }

... we can see that the only difference between the two is the watchpoint bit. 
Importantly, TLB_MMIO is common to all three comparators.

> Sounds good to have a fast path for code fetch. Did you measure the benefit, or just 
> implemented this thinking it's worth?

This is not about a fast path for code fetch, but always using the *slow* path.  The 
object is to repurpose one word from CPUTLBEntry, removed here and added back in the next 
patch, to link CPUTLBEntry to CPUTLBEntryTree without changing sizeof(CPUTLBEntry).


r~

