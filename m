Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F40C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 17:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH458-0003yk-MZ; Mon, 19 May 2025 13:15:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uH453-0003vS-JR
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:15:13 -0400
Received: from mail-ua1-x929.google.com ([2607:f8b0:4864:20::929])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uH451-0001s2-Id
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:15:13 -0400
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-87bfd1499f0so521018241.0
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 10:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1747674910; x=1748279710; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tjk49PHUlteJGs2KitDuZCe1m5yPtwsrOIGRYZdzxDQ=;
 b=lffXFK+YC0IJhq2Iq8/vgD4jHkgAWAC0YU+gUEPhfOmICG4ukmtbMAp/u6aHyoEJvS
 ebYRg4U3nqT+FKvlXi+xy4RUP3sHK0sWf+p29WKGTmQAycDXNgTgvCmCzQWymN58bc2T
 10fCSuHjIACrJIKDWsROSgTW9pCeocefTgzbO5E4y+LylUyAVDGInT3sQYh+By+WQNjx
 34+7vlI2hcPcPZKLVKlATSldz45cMAnXOZkQhmW6ZsA8L11ZdzN+2fxoJACQ7hm7B6sh
 ex5EhEm3wNssxDughh5kyRDfflgmQg7jINed7OfW/PpkJYJuqDxaRn9vDpAZ2R7DdVkE
 BPrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747674910; x=1748279710;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tjk49PHUlteJGs2KitDuZCe1m5yPtwsrOIGRYZdzxDQ=;
 b=oS5knzn0zpoSkk8CC/Jud3e4hR7itw0czd0xYNi4Xem8hxFyfdWShhA9RpdMl7ycA2
 bnh9eJUKb8RWCLO1ydjg5TenTwejKoYbS3EX7NkLvlr7th+pgp2ysVEospaj133hnoR3
 MeST2OtT3T7A3Pd1GcfqpuGJVWnpihi3pbD61GTZgclPGzxykD5FRnxhqtIoY+WFQ6/L
 QdsHVEGbfPNFPRDj6n2Py+Huh1rbjxiMYYJmVIhT+xpRzs4FNxLOlat9g5f0pqyPtOnv
 /jS5+8BeWJPZ3sLzTzg9p0M9H9CYQURQGZLC2Zkphxya5WHQlD5OvXAcnOvGIX0kKcnI
 KQ9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnUq1hN0q5kH2aLsQa6QLNhXYXbhR+daC38B1t3YdIdbR2aRC0lQ3JJSEfuZsOMTe6OOiUERZrovtv@nongnu.org
X-Gm-Message-State: AOJu0YxSG+si7DDyYSDw74BtDMYa0e77WGEWRwQGK/nSPNjxLWmy6kqU
 G49T8qq25r3LCyqXlLIaEW0tfeNlJDTeIbmOtNCLeIchA6froKYbYg56mHy/9exCZbc=
X-Gm-Gg: ASbGncsKLsoJfaes6Ojc43BoRYojfuGm2wIoBbM1DgCD+ViLTAH4G876EOH5hr3BL1s
 BRhdkr1xSKdoVLpG+XvBPqEc+cThzZmOW33ZgSYw4QsUmAWcfYkxfnQLldQj/k1XVxwQqxWlwiD
 W4lLGLLPFVlKAcHY02FjxO8pD7trwcGLeCFT81vcCOYmlDj3YFwRb4sri45mXCHouMkQya/FyrM
 hxIZHlpym7wUCi4EV4W4GuWIGNqMKMgNp6WdZgi8XIDC4eDJ5U3/msggbFRP12Xe+AZBXvxxwdf
 IVp/I6lkBbNSNgHdHXjIzXJtOM2RtiR2edNrJEum6Lv4XAq3Xs2gWCqhjWwN9Y/D38s=
X-Google-Smtp-Source: AGHT+IExy0x4yge7bL1QjgSBJYPsWPYL6s1vtK7HLJylv9tbNrTBn3a6vSo1VNkmjLz8upEz80oGbg==
X-Received: by 2002:a05:6122:8c0f:b0:520:3536:feb5 with SMTP id
 71dfb90a1353d-52dba97c622mr12654125e0c.11.1747674909986; 
 Mon, 19 May 2025 10:15:09 -0700 (PDT)
Received: from [192.168.68.110] ([152.250.131.100])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-52dbaa5a449sm6973291e0c.32.2025.05.19.10.15.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 May 2025 10:15:09 -0700 (PDT)
Message-ID: <c1368421-4441-4058-b78c-317d1d21d580@ventanamicro.com>
Date: Mon, 19 May 2025 14:15:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] target: riscv: Fix satp mode initialization based on
 profile
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20250516122319.4100121-1-alexghiti@rivosinc.com>
 <e86af5b2-7d8a-4503-8a5c-5ee2147aa850@ventanamicro.com>
 <20250519-a153c03e434d1bf31498eb01@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250519-a153c03e434d1bf31498eb01@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::929;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ua1-x929.google.com
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



On 5/19/25 1:35 PM, Andrew Jones wrote:
> On Mon, May 19, 2025 at 09:48:14AM -0300, Daniel Henrique Barboza wrote:
>>
>>
>> On 5/16/25 9:23 AM, Alexandre Ghiti wrote:
>>> The satp mode is set using the svXX properties, but that actually
>>> restricts the satp mode to the minimum required by the profile and
>>> prevents the use of higher satp modes.
>>
>> For rva23s64, in "Optional Extensions" we'll find:
> 
> The keyword is "Optional". The profile should only set sv39 since that's
> what rva23 (and rv22) have for the mandatory support. sv48 and sv57 are
> both optional so, while the user should be allowed to turn them on, just
> like other optional extensions, they shouldn't be on by default since we
> don't set any optional extensions on by default.

What about satp validation for a profile? For both rva22 and rva23 the mandatory
satp is sv39, but up to sv57 is also ok. Do we care if a sv64 CPU claims rva23
support?

I am aware that sv64 also means sv57 support but I'm worried about migration
compatibility. Let's say we migrate between two hosts A and B that claim
to be rva23 compliant. A is running sv64, B is running sv57. If the software
running in A is actually using satp sv64 we can't migrate A to B.

> 
> So we don't want this change, but fixing any bugs with the first hart vs.
> the other harts is of course necessary.

I'm working on it. I'll decouple the QMP bits (all the profile validation business
is a QMP problem in the end) from the core CPU finalize logic. I'll send patches
soon.


Thanks,

Daniel

> 
> Thanks,
> drew
> 
>>
>> https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.adoc
>>
>> - Sv48 Page-based 48-bit virtual-memory system.
>> - Sv57 Page-based 57-bit virtual-memory system.
>>
>> So in theory we could go up to sv57 for rva23s64 (and rva22s64, just checked).
>> Changing satp_mode to the maximum allowed seems sensible.
>>
>> But allowing all satp modes to go in a profile defeats the purpose, doesn't it?
>> None of the existing profiles in QEMU claims supports sv64. Granted, I'm not a
>> satp expert, but removing the satp restriction in profiles doesn't seem right.
>>
>>
>> Thanks,
>>
>> Daniel
>>
>>
>>>
>>> Fix this by not setting any svXX property and allow all satp mode to be
>>> supported.
>>>
>>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>> ---
>>>    target/riscv/tcg/tcg-cpu.c | 3 ---
>>>    1 file changed, 3 deletions(-)
>>>
>>> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
>>> index 5aef9eef36..ca2d2950eb 100644
>>> --- a/target/riscv/tcg/tcg-cpu.c
>>> +++ b/target/riscv/tcg/tcg-cpu.c
>>> @@ -1232,9 +1232,6 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
>>>    #ifndef CONFIG_USER_ONLY
>>>        if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
>>>            object_property_set_bool(obj, "mmu", true, NULL);
>>> -        const char *satp_prop = satp_mode_str(profile->satp_mode,
>>> -                                              riscv_cpu_is_32bit(cpu));
>>> -        object_property_set_bool(obj, satp_prop, profile->enabled, NULL);
>>>        }
>>>    #endif
>>
>>


