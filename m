Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BEAD277D6
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfEtH-0005U1-Gt; Mon, 12 Jan 2026 05:11:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfEtB-0005O1-Bw
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:11:09 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfEt9-00071L-JD
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:11:09 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47d59da3d81so22483485e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 02:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768212665; x=1768817465; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EdrJr5UwoBbLZE3nuYaxiOrE832uhfsv3BleFpjJzuc=;
 b=q6q03JQCrCf9NCzDQfhk/nYU4hhp6W8O7d65EawHnTCy0c+WrjJkUR8CIx+KWVRwkk
 F3Nlw4Ilp6PmeciSYVIJQTCN2ms6JtqrxEISV3JCkJWOd0+D1x30v4GkvSdw9t0LOXxM
 IYbVyiqQsVj2+MPp72YGKaI/qluchhMl0onuJijigrOMQY3w2+7QcOX/wvQvBOCeOlUT
 wL8eBWCsrOQUUClWHi11LvB1AAS6iAudzsyBJzkwW9nV45h1B+Lp93ZCo5zpvMThV0ar
 E9YyqlggEt5JY/y5UO2dJ3itD1Y/bqjdTecahFjkR7dkOqP3TSdUWSdrPxnrGroKwKdC
 zU1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768212665; x=1768817465;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EdrJr5UwoBbLZE3nuYaxiOrE832uhfsv3BleFpjJzuc=;
 b=QHxYq/lgZCu5sfxRKDK6oi8uLyE2oqtVFIAkTbe6zIwIpCrE5IqcFpOKx4nPVtEGMM
 eqAF/QXifSh8b+vrGtsUgaAcOFk8qlnoeotKkaHH1ex576X3LyL+Hmwll3t1vnjsJcwt
 Ez+xwuKeNH+Q9pSwPURZCNdCBIUI+ncoUWn/msoqekVEzMAS7NfFm+Jam9dhv0Qa2tYv
 /DN/RtDB7voXKtt9K5wOOuIGk6GgYGenAs0JN2YzvJpoZErfJy6JRW/oXYBWuPdlmSCA
 GEp+DPHK8xM7t1OaXYtgsu94+II8QboZ6KedVbwNlIj+4nwrqRD1UKaqar6R+V3GwUr8
 HyJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcY3/ZJQSBwliBCD35PVVPbaBDf8YWTNp8L/zxFJXtJ+L6B3zXBWKXwvxjZCtvHYfjaaw09aJAeZ4Y@nongnu.org
X-Gm-Message-State: AOJu0YyYJS0bCbXLxBw9MZQX3q1/ZVfOVCGPeV/B2jAFdkt/3szmI8KV
 pBCsBsRF+mOB0bYFJXTXrUEqIyC+zYt1KfaBrPyBsmZ4SIXfvf+esC8vGgBmwfw7jSM=
X-Gm-Gg: AY/fxX71MxHlebiTtYN0isDoZfi/8SifqoYsl+X4Z34oP0wmXx8CxwwseAExFSPebI0
 Eq2nL/IeVG1oWt7tO5TRecCDIou4HKZKQ/yRDbK2TMIai1wZee7XMvdlH5scFa7211ttiR3hX++
 VsD4Mn+3kW6qFaF4OQzSeORskrCaIk3rSr8r2gF08TQHTcZxjP/JC2iDmsJgLKgJ4kMg2CtL1Bk
 1FiJF2wGRU9iTKyBT+n+GTkcOF1o6MVz85mZIepYXQQ7E83cpeKNmE1vSD2RMihtPxLSVXZsVBv
 ycWiUZUy93iCYj+Gc0ige0dO5xjrIIrkTRcDui5fSvUJXR1+eVgW1XA2rgAEnC5VMoWU0peGjHL
 AbZ9R+Z+xKZ+0K1OoeT5QRYs36wwgvdjR5YLu/J7hoG2qzV5NfmEhWS6Zb4U9uizKjvUCcFYnMf
 t0f6Yg6w8ttAzMHUqd15tLYP3Lrd6JXYVEY1zppSw/DmLyxB0i4S8wmDA5+/WHlGcX
X-Google-Smtp-Source: AGHT+IEia0bnGQA4ZZeuyI9+2gKn6U9jcpEcTlfuLS7ivWk+aITgZERN1g40+YYjPtnqGLWPvOk/gg==
X-Received: by 2002:a05:600c:3ba9:b0:477:9d88:2da6 with SMTP id
 5b1f17b1804b1-47d847d0f30mr226244845e9.0.1768212664888; 
 Mon, 12 Jan 2026 02:11:04 -0800 (PST)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f7035f2sm331730095e9.12.2026.01.12.02.11.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 02:11:04 -0800 (PST)
Message-ID: <bc27550c-f738-4b37-9ae3-7c42a0e38635@linaro.org>
Date: Mon, 12 Jan 2026 11:11:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/18] target/s390x: Use address_space_ldl_be() in
 read_table_entry()
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>
References: <20260107130807.69870-1-philmd@linaro.org>
 <20260107130807.69870-3-philmd@linaro.org>
 <0d46c208-0b8c-4984-a26c-7c584c86eb7e@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0d46c208-0b8c-4984-a26c-7c584c86eb7e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 12/1/26 10:32, Thomas Huth wrote:
> On 07/01/2026 14.07, Philippe Mathieu-Daudé wrote:
>> Keep address_space_read/write() API to access blob of memory.
>> When the access size is known, use the address_space_ld/st()
>> API which can directly swap endianness.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/s390x/mmu_helper.c | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
>> index 026502a3e40..9ee1d778876 100644
>> --- a/target/s390x/mmu_helper.c
>> +++ b/target/s390x/mmu_helper.c
>> @@ -108,6 +108,7 @@ static inline bool read_table_entry(CPUS390XState 
>> *env, hwaddr gaddr,
>>                                       uint64_t *entry)
>>   {
>>       CPUState *cs = env_cpu(env);
>> +    MemTxResult ret;
>>       /*
>>        * According to the PoP, these table addresses are 
>> "unpredictably real
>> @@ -116,13 +117,9 @@ static inline bool read_table_entry(CPUS390XState 
>> *env, hwaddr gaddr,
>>        *
>>        * We treat them as absolute addresses and don't wrap them.
>>        */
>> -    if (unlikely(address_space_read(cs->as, gaddr, 
>> MEMTXATTRS_UNSPECIFIED,
>> -                                    entry, sizeof(*entry)) !=
>> -                 MEMTX_OK)) {
>> -        return false;
>> -    }
>> -    *entry = be64_to_cpu(*entry);
>> -    return true;
>> +    *entry = address_space_ldl_be(cs->as, gaddr, 
>> MEMTXATTRS_UNSPECIFIED, &ret);
>> +
>> +    return ret == MEMTX_OK;
>>   }
> 
>   Hi Philippe,
> 
> this patch seems to break "make check-functional-s390x" ... looks like 
> there is a bug somewhere, please have a look!

Oops, address_space_ldQ_be.


