Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3561CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 14:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5mSG-0001Du-2c; Mon, 06 Oct 2025 10:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5mSD-0001Dm-D5
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 10:44:45 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5mS9-0006m5-Jt
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 10:44:45 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3ee1381b835so4377482f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 07:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759761875; x=1760366675; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PKcnBnbBvrM4/U/psx+k3CgiR89mQJn7LHvKjTToJtg=;
 b=seitG/43Hyyc57ZI1/eZ8RG4vqfLbBVw8FXZdyioJ+OLq4op7MqnIpg5+zKiqHONaE
 zVNzuBqQYNuAErdhN/WTFhHbqCs23eL3kkymGUii1JR9MAl1q9BuVjES9UO1qoFegIsy
 cF3lGm316QUdWNTBzKtaopn4kduiFSX0RVfbz9i4pqaqeWGf7r5zjJxMC2dLhzfn6Ovc
 ML7r2R7onywdxLJmQKewT2Gy33fBtQ9RO26b4xwP4RBb8Kw5DdH8tStAQNzoZHPvl/Gp
 gYR28b8I91JwdgfVf8jlBFow4S7ECafG2rB4cHKA8SNWZv95VXay0GvBQkKYG+MfCncp
 HoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759761875; x=1760366675;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PKcnBnbBvrM4/U/psx+k3CgiR89mQJn7LHvKjTToJtg=;
 b=a7DhJlAK6akjqcAPGN5Zq8j7dzaQFQQ8XL06nuSRvonMQKV0odbANXfPanO0ygAeEe
 ZmO7QHumwNReILwEZN4sPORYxEbj0s9iGlqI+RnF3eyltYpzSalbtR6yCSkr5W72ch/P
 IG4/GvzQdpA5XIaQ8M7nMiC1PJ++GrBjqMJiF8WG2Sloybxui2uMDNlQUn480fLNRBM+
 re7sZrW5AFxomkYMC1UnE4pkZwcaiQNfF8ngwoqv+rYfwH6LKzLXo0yDbAKt5OUhbjis
 tCpctShWm/tNB+uRYSlipycvHJLTjGjk3IUXpQ/b+ESG992daOSXBuKIMr1fOFIFeGKr
 L6Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTz51jp8kXbUaqOe/PPCU6yo+raoM1xfHdv0hgAMQ4CUyPjSuw0de1chrES6KvutbEYrvXCSLwyuew@nongnu.org
X-Gm-Message-State: AOJu0YyLge1rJ+1kKofUj5f9FJ3fog5RNqbtWXAijY2tC7fp57bozA6D
 316+VgeR6GHtFPmRjXfNCDoT+hje4nZ0JPHgBCnhSJ8llLZ3/f7gzoPZdFbPeFS+dz0=
X-Gm-Gg: ASbGncs7PvWsRnhSrH2pJQXe6+aNMxUgklGCdRBOQ8DZN/GfMhBdcAS0CmKharTh2zp
 oqGG8c68DE2cIRFuGkabluzt4ZNyIa4W/3j9hlmITDjAyYnk1AfFBAsgP171KvsfxWAjpofJmBa
 TWB3WKuJGiWW99IsQiJD2FilvgyI+qjMmyVG4hU1jLcNsw3D/X4/u276NZZPvDrthbEZBVMgJR8
 WCUtoqxA9b6NQb86DiqJ90rXMfcfoGDm38ejp691iB2doUMzGTvv2UhSTnWKR9bgeKiKThzK88J
 sdC9Ecq/6r5ef6/6mdttauAGBr5xnuy4cFGqjgswiv+VckHBIBiXU4KfVj01NHQg37UC3tmq/Li
 lAK3Ht2VtZDZHjWg4maAhtlkibESsjkwLRXEpeeo8sLVHtvPWCaF840uMcsYjVHDlxhgHsK7DYF
 eCd+c9M7sfG+cKktiuZyFxhDMno0Ua
X-Google-Smtp-Source: AGHT+IHylU1uDTKdef/LWVtD5jQ4lrYrPO9W9RsEjcCLQimUFxiOXAP7iueUoqs8PdgE9LlqtJP+Sw==
X-Received: by 2002:a05:6000:2888:b0:3ec:df2b:14e2 with SMTP id
 ffacd0b85a97d-425671b08damr8312450f8f.51.1759761875420; 
 Mon, 06 Oct 2025 07:44:35 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f4bdcsm21278489f8f.54.2025.10.06.07.44.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 07:44:34 -0700 (PDT)
Message-ID: <535d639f-6cfb-4b00-9d13-99ecd222b292@linaro.org>
Date: Mon, 6 Oct 2025 16:44:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] target/s390x: Replace legacy
 cpu_physical_memory_read/write() calls
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>
References: <20251002091132.65703-1-philmd@linaro.org>
 <20251002091132.65703-4-philmd@linaro.org>
 <9052ebc9-190c-48e2-bc4f-a4339e7692a9@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9052ebc9-190c-48e2-bc4f-a4339e7692a9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 6/10/25 16:04, Thomas Huth wrote:
> On 02/10/2025 11.11, Philippe Mathieu-Daudé wrote:
>> cpu_physical_memory_read() and cpu_physical_memory_write() are
>> legacy (see commit b7ecba0f6f6), replace by address_space_read()
>> and address_space_write() respectively.
> 
> I'm not sure whether this patch is a good idea in the current way it is 
> done.
> 
> Commit b7ecba0f6f6 says: "there is likely to be behaviour you need to 
> model correctly for a failed read or write operation" ... so if we 
> switch to the address_space_* API, I think you should also implement the 
> correct handling for the case where the memory transaction failed. 
> Otherwise this is more or less just code churn, isn't it?

Yes and no :) The point is to trigger reviewers/maintainers to fill the
missing parts when they notice them, otherwise this is just a no-op.

It worked because now I know the error path you expect, which is
currently ignored.

> 
>   Thomas
> 
>> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
>> index c2fedc55213..737c3bbc5be 100644
>> --- a/target/s390x/diag.c
>> +++ b/target/s390x/diag.c
>> @@ -17,6 +17,7 @@
>>   #include "s390x-internal.h"
>>   #include "hw/watchdog/wdt_diag288.h"
>>   #include "system/cpus.h"
>> +#include "system/memory.h"
>>   #include "hw/s390x/ipl.h"
>>   #include "hw/s390x/s390-virtio-ccw.h"
>>   #include "system/kvm.h"
>> @@ -82,11 +83,14 @@ static bool diag_iplb_read(IplParameterBlock 
>> *iplb, S390CPU *cpu, uint64_t addr)
>>           }
>>           s390_cpu_pv_mem_read(cpu, 0, iplb, be32_to_cpu(iplb->len));
>>       } else {
>> -        cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
>> +        const MemTxAttrs attrs = MEMTXATTRS_UNSPECIFIED;
>> +        AddressSpace *as = CPU(cpu)->as;
>> +
>> +        address_space_read(as, addr, attrs, iplb, sizeof(iplb->len));
>>           if (!iplb_valid_len(iplb)) {
>>               return false;
>>           }
>> -        cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
>> +        address_space_read(as, addr, attrs, iplb, be32_to_cpu(iplb- 
>> >len));
>>       }
>>       return true;
>>   }


