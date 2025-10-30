Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AFFCCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 15:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEUiM-0005n1-FG; Thu, 30 Oct 2025 11:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vEUiJ-0005lp-6K
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:37:24 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vEUiA-0000zm-Nn
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:37:21 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-77f67ba775aso1581288b3a.3
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 08:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1761838626; x=1762443426; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2RsW1Ujx8DdE+xNsVV/ZHAzK/pHZA4PcHFp6aRoIces=;
 b=UqlNlVTZivXwQ3m5q/kWicoBuYVPYHhrFQuQYlk2O/CuMUftLBnNsGc0YHpp0eClLl
 l0RlendwiiGCL22846AbJu2EhMk7NgAOXPvY+182BHr7Q065i23d7Y99vU7MBDvPeocA
 RX7KJ3OQk68p6ZaFEw/RIAuKU/v0/jyqVV8OvrBodiXB8cFEttJhR0QmHa/hUdFZWm9u
 W6gapA0JkWSxY7y5dQUdsnIu2LRb9VvXETflzgLak8Ob7bvlTWTyOvV5ahI8WjPpKejd
 PAxzanOtilJjL0YpynwQnQ0Nj7k90Pv7pgcFbk0kIADJI9retCVv9StTrUQ/vDJy+SgX
 9PWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761838626; x=1762443426;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2RsW1Ujx8DdE+xNsVV/ZHAzK/pHZA4PcHFp6aRoIces=;
 b=KJtpv/OlA/d+7UZlCIqX+sN71o8Wf5tjoEEvYUhdkhqUSr0gOWjcn5O32iHApl/lpN
 k2SoMdLwdxsq2M+ridgjMDDgKSfRgS3DSbn4hy5EmV8Rez6z1kMfjsIswmiXPb9T+q2C
 yNpaijjq5Vzxg1ARZ8SRlAvqXdN0Pvq35mdJ7BD3hZ2Qsjbaw/kmIY1lskE7njJmqACC
 pggu4WZYPE9IfXmkpLHvBI+3ktJkO8/0mDKfkx1SmbTLChufkdeCdftYEP4Z5mfQ0fdA
 m8bF9SEKBI0btZ/l7sfcb89MuSq0Y0+s4MkwkiInpl0HhpKU4lqS5lgT+NBFIwdPU/B6
 uCpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmEEbDV2vvwd58VEDKmQ+R4wA1eKa7nozXCPOI8d8sRay1vzPxGjraO5XdImPy0NJaUsYpkEM5B/Ze@nongnu.org
X-Gm-Message-State: AOJu0YxGnRizZWZxlauP4hdrvUL2RWnunHIsnzEdFJHUEERTlQT6C9tN
 xmk8WBSeviULHUsY2aJ/IMBSAuCVyjqg5uJbmy9DFrpgixXH6oDtQcQnDW26JrUqfKs=
X-Gm-Gg: ASbGncuz8I0Q1MewCq3WinnV3mMYUorAupMPju5cR9dkDSIQE4WvMjS+oDy6x4KnlpM
 qmqdc/zStofV91YG/zsGlpiQutfg284fljm+vvpYRQ9usDfduD6rfVMAmEHsYmFfAb8q3cMzBZm
 lR9DL8P9xoAKRTDYFvoIoaTWcIFurpfPO+H36t2WnJ/sxIWmi0+1DuEjtS4iWmfvy9KhZCAa1t9
 8MNNgBTZf1pGdeanl0jzxUZey7la/C84PQA/TdwMTw8EUV0iXQxvVfUYB2AWTfRx59b+5apnJ2h
 jgoTIwuAjwxEl53DyvzqbLMm0IvS8vEy09udcVDHVuNq2SkgVp1tfq9xHSVpMxM66gPVi9so7tU
 mDrDtex1u+kixOi2uMW6i5blJpLpBj/ajporQ7eZ4x1EM+CTOK42me08d1Jq+9FDEl2HZwATSGM
 ih1djBwDEmd5jN
X-Google-Smtp-Source: AGHT+IHH7gT6C8yfHCP3zCJyTv9kBamOoDl6wfmXFifdXZE66oG9E+Y2pNrcDZmVj1KUcB24u/kN4A==
X-Received: by 2002:a05:6a20:7344:b0:334:96ed:7a73 with SMTP id
 adf61e73a8af0-348ca24f6aemr58120637.8.1761838625567; 
 Thu, 30 Oct 2025 08:37:05 -0700 (PDT)
Received: from [192.168.68.110] ([187.101.65.79])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b71288857c6sm16811728a12.18.2025.10.30.08.37.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 08:37:05 -0700 (PDT)
Message-ID: <a72eaf23-20b8-4877-9d50-0ee2a2b18fca@ventanamicro.com>
Date: Thu, 30 Oct 2025 12:37:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] hw/riscv: Add Server Platform Reference Board
To: Chao Liu <chao.liu.riscv@isrc.iscas.ac.cn>
Cc: ajones@ventanamicro.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 palmer@dabbelt.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 zhiwei_liu@linux.alibaba.com
References: <20250528200129.1548259-1-dbarboza@ventanamicro.com>
 <dbbdc597-9b4d-4dd3-8143-821ac5d82a3a@zevorn.cn>
 <18dc5a20-85c6-4e85-b76f-66dca6771bc1@ventanamicro.com>
 <74d8553b-f98b-4d5d-8b47-5fe21b1c7904@isrc.iscas.ac.cn>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <74d8553b-f98b-4d5d-8b47-5fe21b1c7904@isrc.iscas.ac.cn>
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



On 10/30/25 12:23 PM, Chao Liu wrote:
> On 10/30/2025 9:33 PM, Daniel Henrique Barboza wrote:
>>
>>
>> On 10/30/25 8:48 AM, Chao Liu wrote:
>>> On Wed, May 28, 2025 at 05:01:29PM -0300, Daniel Henrique Barboza wrote:
>>>> Hi,
>>>>
>>>> This is my attempt to ressurect the Server SoC Platform reference work
>>>> that has been buried for an year. The last posting was made an year ago
>>>> [1].
>>>> Most of the changes were made due to upstream differences from one year
>>>> ago. Patch 1 is an example of that.
>>>>
>>>> In patch 2 (former 1), the main difference is the new CPU is rva23s64
>>>> compliant. This wasn't possible in May 2024 because we didn't have this
>>>> support back then.
>>>>
>>>> Patch 3 consists mostly of code base changes rather than functional
>>>> changes. There was a discussion about whether we should supply fdts in
>>>> this machine back in the v2 review [2]. The answer is yes: machine mode
>>>> requires fdt to work, and we want to be flexible enough to generate our
>>>> own fdt instead of relying on EDK2 to supply them. Note that we can also
>>>> supply an EDK2-generated fdt via command line, bypassing the fdt created
>>>> by QEMU, if desired.
>>>>
>>>> Patch 4 adds a riscv-iommu-sys device to the board. This wasn't possible
>>>> back then because we didn't have the required upstream support for it.
>>>>
>>>
>>> Hi, Daniel.
>>>
>>> Do we have any plans to support virt-io on the rvsp-ref machine in the future?
>>
>> Hmmm good question. In theory we're interested only in implementing the rvsp-ref
>> spec but adding virt-io support doesn't hurt the spec implementation in any
>> way ... I think. Drew, any comments?
>>
>>
>>>
>>> Recently, I have been using the RISC-V reference platform built on this set of
>>> patches to support running the OpenEuler RISC-V operating system.
>>>
>>> I will actively feed back any test results to the upstream.
>>
>>
>> This series has been stale because, as you might've read in the thread, it turns
>> out we're missing a mandatory extension (sdext).
>>
> 
> I have a basic version of the sdext extension ready. I’ll improve it later and
> share it with the upstream community to discuss.


That's awesome! Guess we'll be able to upstream a 100% compliant server platform
emulation sooner than I've expected.


Thanks,

Daniel

> 
> Thank,
> Chao
> 
>> I get emails from time to time from people asking about the status of this work
>> so I'm considering pushing the patches as is, without sdext, and add documentation
>> saying that this isn't a 100% rsvp-ref compliant board. The absence of sdext
>> seems tolerable for the current uses ppl have for the board ATM, so upstreaming
>> it as is can be beneficial for everyone. We can add sdext support later and
>> then update the docs claiming 100% compliance.
>>
>> At very least I'll have to send a v4 now that you pointed out a wrong memory
>> address in the memmap, so I'll start with that.
>>
>>
>> Thanks,
>>
>> Daniel
>>
>>
>>>
>>> Thanks,
>>> Chao
> 


