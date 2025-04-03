Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A07C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 13:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0KzF-0007FJ-Fw; Thu, 03 Apr 2025 09:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0KzD-0007El-ET
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 09:52:03 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u0Kz7-000730-2d
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 09:52:03 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-227aaa82fafso9304485ad.2
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 06:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743688314; x=1744293114; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hD33rTP5aBpfkvusMasn2VQ375F+ooya8piv33mHdUs=;
 b=gAr++rOVjUwBTWJcizxHZjXI3qK5sK4//e8i9ommTgEeNkh/kS2Y4xWI+qSCMDlIUV
 9aQkqtdbf+eTrGDKUHO7iqoM3hcEXyBDz96aRbeK7kiTdcQa+Yt8d/DxMRoKg4hfv4PN
 gW+a/xI/kkG/kRGyPtddIbF442p2/SzbKFjQyqXmwfagcpwBqadT0EDhYB/4kl0Hw1ED
 LVswSKlL8MxFL+IYan9ZdGauDumRF2PZOSUab2p3tBA8sRgjCKSTw1/cgSaVRZ2x0aM6
 RsCQDfGeGkIlcgSQS0+SlRC7ZE3Lmaj1FFc/0NztWC+uvnsyP/R2xmfObDF/RpreCajE
 vYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743688314; x=1744293114;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hD33rTP5aBpfkvusMasn2VQ375F+ooya8piv33mHdUs=;
 b=ZGet9l33fBRdPygHNaaYkwp1YezB8SBvrld8g8Om5EfVW8+kMobN0whOF9jbKJnhu9
 d5BS0foR7AN+Z5rcyeKBR1urKvyhPPMr/03bWGiHNKJetuSA7kM8wBwXOqqfXBPbJSF5
 a7laRFG/grVJRT6gbCV7iTXvaslu9erlGTJI57D2bpdhxK5nwg/Iye0rfHj9eNFL3qyD
 0K0tpfoq3amlzG/tIG1v6LCJCDqso3J785+N6qPTQ6OJz2fh3FWOsn2zw71ept+BP///
 hgo31Dv8dFGLKz5wcjiCySXLr8lTLOUe8gyJZij9dVew/Tjrc/R2UOn8Ygt3cr2KPwHV
 O6dg==
X-Gm-Message-State: AOJu0YxGJxecf4Gk+Rf77QVbPicMOOaFgwqh4XMdxS6sl8AOWjwHT6iE
 Zftr7sK5wqYD9QLfIauXmHU6U9koCrrQme+PZFqm1icIkcY0/rm1zEDg25xObO8=
X-Gm-Gg: ASbGncuwfYRNjyfucc4EkJOmFRudBQx9Tqi3P4AAA72dlzz9webRV+nEMN5R4h1nAtC
 eKRP86Mr/zLocDdgmcZhQi0yFm0yMwKZwsFhdU6zByepCCNEvwDgqiFukIRbBV1U6hOaUzGQ90u
 eoDAUKc6OfI//xmHvw7P3JrhOQN78co299BmCrezz9z/jukh7sMR02uYwicjfttYbjusjODSk8g
 iqzgGr24HcJg7fEvjQcaZhNxsmufCK1HWOlfDeSl5d9L7jj4KdqOLQyvvixgYOZsFnUx81flJKV
 UZXXsmyX0G1wk/qCKLcO/EyvBVVa8s2NPQ4sVC4i4ypIlFxIq/9u7raZxz5/toQo6ZNqquKvt0h
 aiwAnpk47u9sGPgmxurA=
X-Google-Smtp-Source: AGHT+IHoG5ugTf4B1m8tuSZ/CxaEQzW4WADkXK2sj6sFcJQU0gHR3t1v1TxSHM26g3vljv17fGjECg==
X-Received: by 2002:a17:903:11ce:b0:224:1157:6d26 with SMTP id
 d9443c01a7336-22977d7df4bmr42868785ad.4.1743688314586; 
 Thu, 03 Apr 2025 06:51:54 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785c098dsm14374765ad.86.2025.04.03.06.51.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 06:51:54 -0700 (PDT)
Message-ID: <9861ee91-419c-414c-aeaf-ae2d4a17ea5f@linaro.org>
Date: Thu, 3 Apr 2025 06:51:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/mips: Revert TARGET_PAGE_BITS_VARY
To: Huacai Chen <chenhuacai@kernel.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com,
 arikalo@gmail.com
References: <20250328175526.368121-1-richard.henderson@linaro.org>
 <20250328175526.368121-2-richard.henderson@linaro.org>
 <CAAhV-H6=iZOBfxF=_DXqc5M9GjTiXJ7nxotLAJ-0Eb7=zVd0bQ@mail.gmail.com>
 <b17663bc-40c3-4501-be88-065363138038@linaro.org>
 <CAAhV-H4mmKvJ75uSm_LCFrCFYM0QG=4oh0ZLVTGXdKX+svs5eA@mail.gmail.com>
 <8d897be6-24b6-4fe3-8201-59f0bd08763d@linaro.org>
 <CAAhV-H6BFRRg_4ZS9S50kgE+ZEJWRMwgm45zBWLwqVP1JLwE_Q@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAAhV-H6BFRRg_4ZS9S50kgE+ZEJWRMwgm45zBWLwqVP1JLwE_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 4/2/25 20:05, Huacai Chen wrote:
> On Thu, Apr 3, 2025 at 2:11 AM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 4/1/25 20:04, Huacai Chen wrote:
>>> Hi, Richard,
>>>
>>> On Tue, Apr 1, 2025 at 9:39 PM Richard Henderson
>>> <richard.henderson@linaro.org> wrote:
>>>>
>>>> On 3/31/25 20:15, Huacai Chen wrote:
>>>>>>     #  define TARGET_VIRT_ADDR_SPACE_BITS 32
>>>>>>     #endif
>>>>>>     #endif
>>>>>> -#ifdef CONFIG_USER_ONLY
>>>>>>     #define TARGET_PAGE_BITS 12
>>>>>> -#else
>>>>>> -#define TARGET_PAGE_BITS_VARY
>>>>>> -#define TARGET_PAGE_BITS_MIN 12
>>>>>> -#endif
>>>>> I'm a bit confused about TARGET_PAGE_BITS and other macros.
>>>>>
>>>>> In my opinion, if we define TARGET_PAGE_BITS as 12, that means we only
>>>>> support 4K pages. And if we define TARGET_PAGE_BITS_VARY and
>>>>> TARGET_PAGE_BITS_MIN as 12, that means we support the minimum page as
>>>>> 4K, but we also support larger pages.
>>>>>
>>>>> Am I wrong?
>>>> Yes.
>>>>
>>>> TARGET_PAGE_BITS is a minimum value that is used by the memory subsystem for managing ram
>>>> and i/o.  If variable, via TARGET_PAGE_BITS_VARY, this is set very early in qemu startup
>>>> and cannot be changed.
>>>>
>>>> The page size for the mips cpu, like many others, may be changed at runtime.  The page
>>>> size used at that point is reported to softmmu during tlb_fill.
>>>>
>>>> The value of TARGET_PAGE_BITS must be the minimum supported by the cpu.
>>>>
>>>> For Arm, the minimum for armv6 was 1k, then armv7 dropped support for tiny pages so the
>>>> minimum is 4k.  At runtime, armv8 supports page sizes of 4k, 16k, and 64k.
>>>>
>>>> For MIPS, ignoring those cpus which support 1k pages, the minimum is 4k.
>>> If all types of cpus of the target arch has the same minimum supported
>>> page size, we only need to define TARGET_PAGE_BITS; otherwise we need
>>> to define TARGET_PAGE_BITS_VARY, and TARGET_PAGE_BITS_MIN means the
>>> minimum supported page size of the smallest supported page's cpu type.
>>> Here we remove TARGET_PAGE_BITS_VARY because we just ignore the 1K
>>> pages.
>>>
>>> Am I right now?
>>
>> Yes.
> OK, then it is fine to remove the TARGET_PAGE_BITS_VARY and
> TARGET_PAGE_BITS_MIN definition. But Loongson still prefers 16K pages
> (4K pages cause cache alias on Loongson), so I want to keep
> mc->minimum_page_bits = 14.

You can't set minimum_page_size = 14, because TARGET_PAGE_BITS_VARY is unset.

However, the Loongson kernel will continue to correctly program 16k pages at runtime, and 
we will continue to correctly provide 16k pages to softmmu during tlb_fill.  All is well.


r~

