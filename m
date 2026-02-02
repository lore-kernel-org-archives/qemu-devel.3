Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F9CE7315A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 12:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmsga-0000CK-Tf; Mon, 02 Feb 2026 07:05:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmsgW-0000Bo-Tp
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 07:05:41 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmsgU-00023k-CS
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 07:05:40 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so57990945e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 04:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770033935; x=1770638735; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CM+yViLVRKTQ4V6KQn5AGRKjrOQAMNYNmlINzbGGbHI=;
 b=nR6YvgR24N+cBrrYZaHgnS6ucvcfPXCxAvv9BZeVPYKe5qTaC0cc3uQqlAhmwFTxPP
 ia168rQRFgLv8pQdURRIe1/Q1U8HtK/mVofBVAhS6ZdlKGkqzFNaEzOXOWit6I4OOa/l
 WD+7K8e/WN3weubOaARZ7+SeaGK7dwkWhCQKVIhiiGUnQTIs24EO4OAXB3y3nQaKoDok
 N95g0lMkLpfGCskErlZwaxcmOviE2Gs7ZYFp6KJD4bhtUHiSWRXdxpYSkI7wIGdvPdNP
 c6OO/KFRlmejS9SQzkgFvIcI1UOxCe8y20OkfuD9qaFPJ1g4WVcK5h2qr6f6/WFy8LgA
 70ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770033935; x=1770638735;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CM+yViLVRKTQ4V6KQn5AGRKjrOQAMNYNmlINzbGGbHI=;
 b=jQnbdgYBam8SXWBedsEfQotIknLUdVOirCzAGPsR70Ojh20PHZjlsMeFlHz1Jt02RW
 XkDz00sJRe+Lmc0R186zUMw9ibyghbfYaCyUxuuyS05A53JUPtawzaSwmWJnkxnsaaJg
 V2aDlNVwJ+BPy9slUo/Ukwg74QMpZxKSBruU7Fb1Aiq/XRx9rUtrn42BJ5K6aTBRB9KC
 KS7W1es8fTL7pDKcEzFde+8vM47vA0+BGweaqdADkh1AH7tJf43JIHDffb+4EiqCoSfg
 C8IyYrHFqUEic/kuAtoJbmr+8cWZsFExOWsuEpP1Kg9065BBF/uj8PKYUqxPvKyqNLmk
 pfAA==
X-Gm-Message-State: AOJu0YxXC7irgPQWo6j1bSK0dXZsyir9Jrk8m7eSAsWQwARnx2LjGgIk
 6sTZZjjHfGmpbAbHifZ3ptxVhaVyPqHttykavxHEkVt+f5r+zD8/lYKV1iizBflye6w=
X-Gm-Gg: AZuq6aLrCWru+27QEZrr/9yUlbMgYZVL60/sb+DIOPg0rGQ3KW5CVHA+RPviuPcevVm
 RfmK/8uQRz2dGqQpHf52xipwUTo3D8OBjMWQ2CgEdGJvTzlj6yc1mGrCApgMon+R+angRR+3gij
 MFQ9KKC3VTitY2w6QUfDSKgehNF4Gnlkl7XI/7Cuyk+g8Rlwt/AwXpYQRsiwPGPw/omHiyKVp+I
 d0+DmQCYt8gBya4n8L0CHBbMwPj5PxMSlXzL8as75Mcnxa0YjqIfZMo8N87TGOtnq8od1OBbNEk
 L1LJqgarktBvfTeGWIOZTCdSpJwzphhFcSuqh9iua3QupVvIUhSFjlbCeKIDeebcUE5RlqktANT
 bfYBcOgEnRDtv/NjFk8RiYxHzmIQffmFhK+ldB+LDxsVRz3ac44/Y1SdubSZxlpyG63MFuWySCB
 twBl8adQE8UkPgIZOpEHKyzcUPpIKpNxzp8yOXGTzlGXsSD6adOSFsXg==
X-Received: by 2002:a05:600c:4f8a:b0:477:76c2:49c9 with SMTP id
 5b1f17b1804b1-482db4568dbmr156211985e9.2.1770033935165; 
 Mon, 02 Feb 2026 04:05:35 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm381675105e9.12.2026.02.02.04.05.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 04:05:34 -0800 (PST)
Message-ID: <7bfa5966-b7cd-4af4-b979-ea973a30195a@linaro.org>
Date: Mon, 2 Feb 2026 13:05:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] bulk: Stop forward-declaring enum typedefs
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, jpcottin@google.com,
 Markus Armbruster <armbru@redhat.com>, Roman Kiryanov <rkir@google.com>,
 Will Hollins <whollins@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, jansene@google.com,
 Eric Blake <eblake@redhat.com>
References: <20260130211746.46667-1-philmd@linaro.org>
 <20260130211746.46667-2-philmd@linaro.org> <87ms1rpdnw.fsf@draig.linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87ms1rpdnw.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 2/2/26 12:50, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> The C99 standard chapter §6.7.2.2 point 4 mentions:
>>
>>    Each enumerated type shall be compatible with char, a signed
>>    integer type, or an unsigned integer type. The choice of type
>>    is implementation-defined, but shall be capable of representing
>>    the values of all the members of the enumeration.
>>
>> Align with that recommendation by defining the typedef
>> along with the enum.
>>
>> For information, building with -Werror=pedantic was reporting:
>>
>>    In file included from ../../ui/kbd-state.c:10:
>>    include/ui/kbd-state.h:12:14: error: ISO C forbids forward references to 'enum' types [-Werror,-Wpedantic]
>>       12 | typedef enum QKbdModifier QKbdModifier;
>>          |              ^
>>    ...
>>
>> Reported-by: Roman Kiryanov <rkir@google.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   hw/riscv/riscv-iommu-bits.h          |  4 ++--
>>   hw/riscv/riscv-iommu.h               |  2 --
>>   include/hw/misc/auxbus.h             | 11 ++++-------
>>   include/hw/pci/pci_device.h          |  5 ++---
>>   include/hw/ssi/ssi.h                 |  6 ++----
>>   include/hw/xen/interface/io/xenbus.h |  5 ++---
>>   include/io/channel.h                 | 11 ++++-------
>>   include/system/replay.h              | 10 ++++------
>>   include/ui/clipboard.h               | 15 ++++++---------
>>   include/ui/kbd-state.h               |  6 ++----
>>   pc-bios/s390-ccw/virtio.h            |  5 ++---
>>   tests/qtest/libqos/qgraph_internal.h | 10 ++++------
>>   hw/core/loader.c                     |  5 ++---
>>   hw/display/xlnx_dp.c                 | 11 ++++-------
>>   hw/dma/xlnx_dpdma.c                  | 10 ++++------
>>   qapi/opts-visitor.c                  |  7 ++-----
>>   qapi/string-output-visitor.c         |  6 ++----
>>   tests/unit/check-qom-proplist.c      |  6 ++----
>>   18 files changed, 50 insertions(+), 85 deletions(-)
>>
>> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
>> index 47fe01bee58..281afa7bc3f 100644
>> --- a/hw/riscv/riscv-iommu-bits.h
>> +++ b/hw/riscv/riscv-iommu-bits.h
>> @@ -96,11 +96,11 @@ struct riscv_iommu_pq_record {
>>   #define RISCV_IOMMU_CAP_PD17            BIT_ULL(39)
>>   #define RISCV_IOMMU_CAP_PD20            BIT_ULL(40)
>>   
>> -enum riscv_iommu_igs_modes {
>> +typedef enum riscv_iommu_igs_modes {
>>       RISCV_IOMMU_CAP_IGS_MSI = 0,
>>       RISCV_IOMMU_CAP_IGS_WSI,
>>       RISCV_IOMMU_CAP_IGS_BOTH
>> -};
>> +} riscv_iommu_igs_mode;
> 
> mode vs modes.

Pre-existing...

> It seems very clumsy to have the type at the front and
> back of the declaration. The only real reason to have the tag ahead of
> the struct/enum was if there are references in the structure.
> 
> IOW this does feel like a lot of churn.

Well I got it clear old-school maintainers are very reluctant
to open the project to more contributors, even if changes
required are only cosmetics, and less invasive than Rust ones.

I won't put more energy to this now. Maybe in 10 years from
now if the project still exists, and we get more inclusive.

Regards,

Phil.

