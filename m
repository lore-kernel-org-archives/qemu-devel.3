Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA6EC3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 10:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKYE-0002pn-Vo; Tue, 20 May 2025 06:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uHKYC-0002p2-Fg
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:50:24 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1uHKYA-0000Ap-3n
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:50:24 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-30e7e46cb47so4269622a91.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 03:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1747738220; x=1748343020; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wh5ztZjsTLAqklcjndZszOzagDNvgqRidXbp2Abj+A0=;
 b=KAjTRBV3GI58F4GkO1pt6iPbk7qhH79Gx47230cnYV6DP9dv6jjnHp4lZplTmBJAO2
 hT3ncSV1TD7KYIGQcN9wljypbV9xlUz7Ui7gnkQZxgvTgmsTZvqf3GCBIil9sus+8xUW
 NrsXB3SLzcb8Z7ZuCF88oNMTikscbiMEDie2tK7bd/8nhjxnup+jKAC/XdtyqRV8BydP
 xfWiLU96+7U+V0Zud8uz2rGjGdZ2QSmMlLM5qJ40FtYRx+nQlrgCOl0ihcsUnClTHPEf
 pt5f9vyRn6aZOYbd6QbSstM1sMzwUZYfux3QYzUlkXM5FaUMJUqmE9BW2qEtjQJmGfvb
 GZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747738220; x=1748343020;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wh5ztZjsTLAqklcjndZszOzagDNvgqRidXbp2Abj+A0=;
 b=InUIbF0uY6FODlgT3Nc701BpHiRgVgIc1mAQR/dNFl7dQ8MeHiYK4t/nlhERi1fuP6
 zplWSSr/K1/CJcUsT3GiIRKJuqb90HL72oFSCIeOOzNKXC75wk5Ntp+LLNWk67MGwu+3
 F+PdfanciTeP9hfg29ll6G7rB/VPKqUuXYNjgXBYbn2BUXTWrzQ2S1v0qi5OmhrTXk1u
 5rGWSvxjG1mWHVNTNXVrm0nOzfrfLuhbaZ6/fyrJdZBVOPrIBmvQtBE7cupJ+ywrEzPD
 0HCoS+VFHvHW05mxauTWkTNPQGs4JVV1upv8CJHekqx7u9quCfvm4JVOptg5SMmVDLGW
 NNjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfqJTdsH86lqIpZdXGFx/pJuR2iClymzVXHyIw2YtQXTtfIUxkdr3HSs3cs3Fh1fv0KZOQ9j9NA3rK@nongnu.org
X-Gm-Message-State: AOJu0YxmDATz3gmAgB4GDwIQvHlSIdnKsiLM6gJGivORrt/nPLNhrnin
 wBS4boX6u1HojCgUjcOfpF8km1EPOaLHb7mYslc4MR3K5ofAvv++qr3Yo0CxRT9jf7I=
X-Gm-Gg: ASbGnctdineB2y+jUDmgPxgTlnB765Zgd2+iE9xjH4xECuEf0YTTHqeHEbQy6oZP3vx
 HURMiU/ja0s752G6K8iUT/2KMM7/E/4exkXizpq2Mbg1z7OdB7DQkGYykBdsWLw7Icz+pHSl8Qr
 FMHNv1icZoQT7dngjG4CZQGT0Y+eUClyt87k6MkXPLZz1F26Ua05j6hfkrSUYRPMCDh2d7ZQygF
 npvMmGWSvi6TZql2Eks2J8eJREaYjf+tf2LNgyCAnHQNPT6Re28H8Ynsf9qZbihWAuxxZW/xkge
 43YsIHR7rxB3CNA0VYj/pvAVBGwggHd+NtUL+pd2+V3q+X9Ikh1p5073L4QHiYE2TBE=
X-Google-Smtp-Source: AGHT+IHdwQC7Mcu3uBuvjepZiP8XDFNh7xhVRfm0HeuU871s8/x9dqar1wpnfu9I19KRLvXLBS09qA==
X-Received: by 2002:a17:90b:52c5:b0:30c:5256:3 with SMTP id
 98e67ed59e1d1-30e830c7a9fmr22012696a91.5.1747738219625; 
 Tue, 20 May 2025 03:50:19 -0700 (PDT)
Received: from [192.168.68.110] ([152.250.131.100])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30f365102e7sm1498550a91.40.2025.05.20.03.50.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 03:50:19 -0700 (PDT)
Message-ID: <39ce5a78-8789-4d32-9fff-aa82b7505529@ventanamicro.com>
Date: Tue, 20 May 2025 07:50:15 -0300
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
 <c1368421-4441-4058-b78c-317d1d21d580@ventanamicro.com>
 <20250520-c62c9918435e564c09f1042a@orel>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20250520-c62c9918435e564c09f1042a@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x1036.google.com
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



On 5/20/25 4:50 AM, Andrew Jones wrote:
> On Mon, May 19, 2025 at 02:15:05PM -0300, Daniel Henrique Barboza wrote:
>>
>>
>> On 5/19/25 1:35 PM, Andrew Jones wrote:
>>> On Mon, May 19, 2025 at 09:48:14AM -0300, Daniel Henrique Barboza wrote:
>>>>
>>>>
>>>> On 5/16/25 9:23 AM, Alexandre Ghiti wrote:
>>>>> The satp mode is set using the svXX properties, but that actually
>>>>> restricts the satp mode to the minimum required by the profile and
>>>>> prevents the use of higher satp modes.
>>>>
>>>> For rva23s64, in "Optional Extensions" we'll find:
>>>
>>> The keyword is "Optional". The profile should only set sv39 since that's
>>> what rva23 (and rv22) have for the mandatory support. sv48 and sv57 are
>>> both optional so, while the user should be allowed to turn them on, just
>>> like other optional extensions, they shouldn't be on by default since we
>>> don't set any optional extensions on by default.
>>
>> What about satp validation for a profile? For both rva22 and rva23 the mandatory
>> satp is sv39, but up to sv57 is also ok. Do we care if a sv64 CPU claims rva23
>> support?
> 
> Is sv64 defined yet? I thought it's just a placeholder. Anyway, I'd expect
> it to be like sv57 and sv48 in that each narrower width must be supported,
> which means sv39 would also still be supported, and that means the cpu
> could be rva23. If, OTOH, an sv64 cpu cannot support sv39, then the cpu
> cannot have both, so it cannot be rva23. IOW, as long as sv39 is _also_
> supported, then sv64 is OK to select and still be rva23.

We have sv64 defined in QEMU. Not sure if it's already a thing or not ....
it seems to me that ppl cares to sv57 mostly, so perhaps my sv64 worry
unjustified.

Just took a look in how we're validating satp for profiles and we're
allowing a higher satp mode than the profile mandates, issuing warnings
if the satp mode is set to a lower mode than the profile value.


So I guess the way we would like people to use rva23s64 with sv57 would be:

-cpu rva23s64,sv57=on


> 
>>
>> I am aware that sv64 also means sv57 support but I'm worried about migration
>> compatibility. Let's say we migrate between two hosts A and B that claim
>> to be rva23 compliant. A is running sv64, B is running sv57. If the software
>> running in A is actually using satp sv64 we can't migrate A to B.
> 
> A and B are incompatible already if A is '-cpu rva23,sv64=on' and B is
> '-cpu rva23,sv57=on', so the migration manager should already disallow
> that.
> 
>>
>>>
>>> So we don't want this change, but fixing any bugs with the first hart vs.
>>> the other harts is of course necessary.
>>
>> I'm working on it. I'll decouple the QMP bits (all the profile validation business
>> is a QMP problem in the end) from the core CPU finalize logic. I'll send patches
>> soon.
> 
> Great, thanks!
> 
> Another comment I thought of later that I should have put in my original
> reply is that we of course want 'max' to default to the widest QEMU
> supports. Then, users that want to ensure they get sv57 or sv64 without
> having to explicitly add it to their command lines can use 'max'.
> Specifying '-cpu rva23' means you just want the mandatory base of the
> given profile and if you want more than that then you need to append each
> optional extension explicitly. If we don't have that documented somewhere,
> then maybe we should, in order to help clarify the intent.
> 

max CPU is using satp_mode = sv57. Since sv64 is mostly a placeholder then I
believe it's all good. Perhaps we could add a satp_mode_latest value for these
situations.


Thanks,

Daniel

> Thanks,
> drew
> 
>>
>>
>> Thanks,
>>
>> Daniel
>>
>>>
>>> Thanks,
>>> drew
>>>
>>>>
>>>> https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.adoc
>>>>
>>>> - Sv48 Page-based 48-bit virtual-memory system.
>>>> - Sv57 Page-based 57-bit virtual-memory system.
>>>>
>>>> So in theory we could go up to sv57 for rva23s64 (and rva22s64, just checked).
>>>> Changing satp_mode to the maximum allowed seems sensible.
>>>>
>>>> But allowing all satp modes to go in a profile defeats the purpose, doesn't it?
>>>> None of the existing profiles in QEMU claims supports sv64. Granted, I'm not a
>>>> satp expert, but removing the satp restriction in profiles doesn't seem right.
>>>>
>>>>
>>>> Thanks,
>>>>
>>>> Daniel
>>>>
>>>>
>>>>>
>>>>> Fix this by not setting any svXX property and allow all satp mode to be
>>>>> supported.
>>>>>
>>>>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>>>> ---
>>>>>     target/riscv/tcg/tcg-cpu.c | 3 ---
>>>>>     1 file changed, 3 deletions(-)
>>>>>
>>>>> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
>>>>> index 5aef9eef36..ca2d2950eb 100644
>>>>> --- a/target/riscv/tcg/tcg-cpu.c
>>>>> +++ b/target/riscv/tcg/tcg-cpu.c
>>>>> @@ -1232,9 +1232,6 @@ static void cpu_set_profile(Object *obj, Visitor *v, const char *name,
>>>>>     #ifndef CONFIG_USER_ONLY
>>>>>         if (profile->satp_mode != RISCV_PROFILE_ATTR_UNUSED) {
>>>>>             object_property_set_bool(obj, "mmu", true, NULL);
>>>>> -        const char *satp_prop = satp_mode_str(profile->satp_mode,
>>>>> -                                              riscv_cpu_is_32bit(cpu));
>>>>> -        object_property_set_bool(obj, satp_prop, profile->enabled, NULL);
>>>>>         }
>>>>>     #endif
>>>>
>>>>
>>


