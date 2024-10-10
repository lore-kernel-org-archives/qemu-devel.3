Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8E3CFC5FE
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 19:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syyqi-0006xz-BW; Thu, 10 Oct 2024 15:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syyqg-0006xq-Nu
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 15:29:22 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syyqe-0007MT-VP
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 15:29:22 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2e2d1858cdfso740128a91.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 12:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728588559; x=1729193359; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zQzGC9+vwxOjgDsdau4L5cco5Nqu3IiZb25lJwpcg7M=;
 b=BL0iIC1p+Y55xi7AVJCcm7WgZNlSgN/OF3SdbqdlhM5fAh6tfTiA8iMuBxF7t+H93C
 PfSmlAI13KHTa7zh+oBmwIH09ADqLLm55LB4Czm/jBDm/6LkMRN+g3HasENxmmY/Kadj
 7MmIUah8ofWYTxaLuVsMSPFK5GhBmyUJCYAdeggygTvMj0XIw5KUqTXGFG3mEI21FvDe
 AMurgic7mnic6I3QxUKOqLCS21yB+5EuEk/YPNnHPmWQuRbCTDRTHNqlCa1P0NpYqeHv
 5CsHyr/wiX68+VFLxgoU/UV1QVIBTVJwQwERIgHlAkjuAgyN+z04Y6WrnIO9fQ//Xaoh
 LCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728588559; x=1729193359;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zQzGC9+vwxOjgDsdau4L5cco5Nqu3IiZb25lJwpcg7M=;
 b=oF3NxstCZuUCSi5i8p3Q11ZiLvuD9Ew2nwDsliLJn08gErPRM4sMPEsphH4jn2cDFw
 lIAitsvizvBoXG/iTqtYRMfqKOCjh92eD5LT040GY/UPaNuB6iz6wIqcHrI9nVEVN+w/
 /SvV5auPWOjK1sRvxqN09fbShVkRLk9GYwjQ+D5qaqj1CdQToDJwgFSBtPPdnBEqsI26
 W3/oNJaHzFyG6cKF5/uWKa0YwN/y/Hx5S8SDPMuObmUgl5D8NIigfwBgCTza/QqfoY5z
 cgev6nC5UsYSUGI84bwWt3dyPUPnCZlm+XkOIbFQ4V7XiKxiUh6ZHiohFNMD8GoqfBz6
 JNZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAa811HZ29FqKSxvdIvt4JiwWExbOaiOLwBiB1k6a4bx9U7LvSvQyp1eS5PXfLtLhkrAsZFDSrK7O5@nongnu.org
X-Gm-Message-State: AOJu0YyboskCYaUFCRpppZP3hKOwAYgH9EnTVKMgbTVA2h7W7EO/F5fc
 28PCK2Vu/Id89W1DjMdzkADPp/w84jh5frwyBfHaoQL7SSfmP3ssIuXJPoz0vIE=
X-Google-Smtp-Source: AGHT+IH9wjegBn0c7yV5nsM+5DRZEl5O9JqLTPF8GU0tUCXi9EQFM2++wrk2Kt5H588tpCDvDur2kw==
X-Received: by 2002:a17:90a:f406:b0:2e2:cd11:c9b with SMTP id
 98e67ed59e1d1-2e2f09ee5e4mr323809a91.3.1728588559136; 
 Thu, 10 Oct 2024 12:29:19 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2a5aaae34sm4007252a91.46.2024.10.10.12.29.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2024 12:29:18 -0700 (PDT)
Message-ID: <79708a5a-be2b-486e-91ba-9c39e1dab3fc@linaro.org>
Date: Thu, 10 Oct 2024 12:29:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/23] accel/tcg: Replace victim_tlb_hit with tlbtree_hit
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-15-richard.henderson@linaro.org>
 <a55f268b-ca9c-49b9-b6f2-8bb9c0b966d0@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <a55f268b-ca9c-49b9-b6f2-8bb9c0b966d0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 10/9/24 17:10, Pierrick Bouvier wrote:
>> +static bool tlbtree_hit(CPUState *cpu, int mmu_idx,
>> +                        MMUAccessType access_type, vaddr addr)
>>   {
>> -    size_t vidx;
>> +    CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
>> +    CPUTLBDescFast *fast = &cpu->neg.tlb.f[mmu_idx];
>> +    CPUTLBEntryTree *node;
>> +    size_t index;
>>       assert_cpu_is_self(cpu);
>> -    for (vidx = 0; vidx < CPU_VTLB_SIZE; ++vidx) {
>> -        CPUTLBEntry *vtlb = &cpu->neg.tlb.d[mmu_idx].vtable[vidx];
>> -        uint64_t cmp = tlb_read_idx(vtlb, access_type);
>> -
>> -        if (cmp == page) {
...
>> +    if (!tlb_hit(tlb_read_idx(&node->copy, access_type), addr)) {
>> +        /* This access is not permitted. */
>> +        return false;
>> +    }
> 
> This is not something we were checking before. If this is an addition, maybe it would be 
> better to split this out of this commit. Or maybe I missed a step in previous commits :)

It's there, with the comparison and page mask, but I agree it's not obvious.


r~

