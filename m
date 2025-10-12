Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D1CCCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 17:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7zrO-0001fh-5o; Sun, 12 Oct 2025 13:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v7zrG-0001f8-Hr
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 13:27:47 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1v7zr8-0000y0-Je
 for qemu-devel@nongnu.org; Sun, 12 Oct 2025 13:27:45 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so3270197b3a.1
 for <qemu-devel@nongnu.org>; Sun, 12 Oct 2025 10:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1760290056; x=1760894856; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=menZGbMwGQhVVtUpTET8LzZzVf4ElkNKHpE2z/fixN0=;
 b=LxtpFZmOUHfUP855BGO/V1EB99PJsD0UkffLgYMYYfvunnFq0ISMqbhySNLAY78+uW
 knLvnwSwRVfztL+v6vypGVUgudQMATu7TilbMyl6UCHFPlWwiySS/Nzwj2w+NvpQ+Y8l
 yez5fMwNfl7dX/2EVX2a+1ta/UoDtInYuGlfjfhjPSBRjht+K9DAuF+t+C5mMWb3JpP9
 8RTWusdp5mV0CwAehK9BRkGNUEH5ugRShfVuXdTsWS3azHUUwa5B3h2cUJEgnc3iJF1R
 nPS3bLNQaMCNHn8B6xkUWT5dsuoqJ82UW6go6ddJe5MGHdiEbX12qn//dGeQjeoKWo2x
 RBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760290056; x=1760894856;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=menZGbMwGQhVVtUpTET8LzZzVf4ElkNKHpE2z/fixN0=;
 b=ToLFoatv2e6WiBUFzY8PCkeYWm9o3CPBykQZlAboYZCnB32s+Kaa3YjZHNNUKebJLz
 ZC+qYz5IuLyjMThO3Lvbvuh7fbTHSRy44jd+m/g8iKjlvBMDKSH7khCMTvuPuInb/qjs
 AJyBZRBHiEAx/+FQh9EkH/MvGkByUbEiIybO5EyrVE1XkwaOI5Mye4bja7uRhbPFKPyO
 +yA8OckIP61goVwbq1dONpyS5frZhKVAERTnQ79AOhrqqfpxhTjrqKJy1xaIFwEWy9M2
 0dP7hdeTPyHPoRu3fzWmv3dM6uKk/lJ3RMdbg3Pa3c0sJm45s1pirD8oIjJxSC+O/RL2
 F55w==
X-Gm-Message-State: AOJu0YzJEGfY0oU8jFIDO+o0htfGSm9Dr7PkVKmMVkwM+2gva318rCfG
 6ctOoIWMg9izyEC3APviKW0Ocnzi1NeG8Oy3ro/jd64NTXWZm4WZuaejoBqvyjSkG94=
X-Gm-Gg: ASbGncvO9uSckdedndEKwfV2I107Nx1bY6wwA2lsIfNYk9msJMcQYJc9ItaqFmMAT7D
 aNMiF8sQhy0y1lc+MXMIwxNBygoQHy1p+cKvLm7Yq57+INDN31JtqO4Z9itrvcgFipYpGUS8Ntk
 y9N9w6s/v7QD3Y2T9RrrEmzcmKaP7yUiYuWb2UFuc8Drcj1reB8QnJWNRb6VWbgIA+tkPRBPzO2
 8dVXb46ilxIOQbaqMjy2ExgwqDjGlSC93tT+yTC4szIIjrEn6pE8stqE1URC8BFd3BKNr9fIHjc
 857t12djiO/sH/ah5cmcmtdPBt5Zg8S5x6DqSfTg+Rpq7FzR624CyNlS9Rre2NryLm4Ns+I4NxD
 vCwiDzMdYAUpDhv6z4IQOUN3Ahu/kLwhDoDphQKUnEPUx5gtWLZq8xd5IeA4a/o8/P7E=
X-Google-Smtp-Source: AGHT+IGH0XFozbxVPAgoHcr1nufXX21gsd2uUMK9wxk9yDS94JHYvLyd0omtY50nniXhHH/sJhW6gg==
X-Received: by 2002:a05:6a00:1404:b0:781:1f58:ce6e with SMTP id
 d2e1a72fcca58-7939753d114mr21496130b3a.4.1760290055756; 
 Sun, 12 Oct 2025 10:27:35 -0700 (PDT)
Received: from [192.168.68.110] ([152.234.122.223])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992d0e2ab3sm8889161b3a.64.2025.10.12.10.27.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Oct 2025 10:27:35 -0700 (PDT)
Message-ID: <125b7913-c8c0-448b-9f3f-3b893436b901@ventanamicro.com>
Date: Sun, 12 Oct 2025 14:27:24 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/18] exec: Add RISC-V WorldGuard WID to MemTxAttrs
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 "open list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
References: <20250417105249.18232-1-jim.shu@sifive.com>
 <20250417105249.18232-5-jim.shu@sifive.com>
 <e7616702-8a7b-4617-8433-236a1086bdf9@ventanamicro.com>
 <CALw707rstv76_oESKHzbeuPakSesWNBXogQoCJN4pHMj_wz7eg@mail.gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <CALw707rstv76_oESKHzbeuPakSesWNBXogQoCJN4pHMj_wz7eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x429.google.com
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



On 10/8/25 2:54 AM, Jim Shu wrote:
> Hi Daniel,
> 
> Both '_reserved1' and '_reserved2' fields are only for padding
> MemTxAttrs struct to be 8-byte [1], so I remove a 1-byte reserved
> field when adding 'world_id' field to it.
> Is it ok for you? Or you think it is better to separate them.

It's fine. I suggest adding this explanation in the commit msg to avoid
further questions about it.


Thanks,

Daniel

> 
> 
> [1]
> commit 5014e33b1e00d330f13df33c09a3932ac88f8d94
> Link: https://lore.kernel.org/r/20250121151322.171832-2-zhao1.liu@intel.com
> 
> Thanks!
> 
> On Sat, Aug 9, 2025 at 8:34 PM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>>
>>
>> On 4/17/25 7:52 AM, Jim Shu wrote:
>>> RISC-V WorldGuard will add 5-bit world_id (WID) to the each memory
>>> transaction on the bus. The wgChecker in front of RAM or peripherals
>>> MMIO could do the access control based on the WID. It is similar to ARM
>>> TrustZone NS bit, but the WID is 5-bit.
>>>
>>> The common implementation of WID is AXI4 AxUSER signal.
>>>
>>> Signed-off-by: Jim Shu <jim.shu@sifive.com>
>>> ---
>>>    include/exec/memattrs.h | 8 ++++++--
>>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
>>> index 8db1d30464..7a6866fa41 100644
>>> --- a/include/exec/memattrs.h
>>> +++ b/include/exec/memattrs.h
>>> @@ -54,6 +54,11 @@ typedef struct MemTxAttrs {
>>>         */
>>>        unsigned int pid:8;
>>>
>>> +    /*
>>> +     * RISC-V WorldGuard: the 5-bit WID field of memory access.
>>> +     */
>>> +    unsigned int world_id:5;
>>> +
>>>        /*
>>>         * Bus masters which don't specify any attributes will get this
>>>         * (via the MEMTXATTRS_UNSPECIFIED constant), so that we can
>>> @@ -63,8 +68,7 @@ typedef struct MemTxAttrs {
>>>         */
>>>        bool unspecified;
>>>
>>> -    uint8_t _reserved1;
>>> -    uint16_t _reserved2;
>>> +    uint16_t _reserved1;
>>
>> Is 'reserved2' unused? Not sure why you ended up removing it in this patch.
>>
>> If it's really unused it's ok to remove it but this should be done in separate.
>>
>>
>> Thanks,
>>
>> Daniel
>>
>>
>>>    } MemTxAttrs;
>>>
>>>    QEMU_BUILD_BUG_ON(sizeof(MemTxAttrs) > 8);
>>


