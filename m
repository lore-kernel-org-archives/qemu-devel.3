Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85ED8C28B2E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 21:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqeoP-0007YQ-0K; Fri, 07 Mar 2025 16:00:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqeoA-0007UW-4z
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:00:38 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqeo7-000598-Ag
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 16:00:37 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43bb6b0b898so19453275e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 13:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741381233; x=1741986033; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DBlpnXVduv+5AmoyZl6pqWu84JM1UmMBLVVhVQDwJbY=;
 b=ga9TZdrU/+iQi9Hetrp2c1DWPDEDBueN/Jmr68aWc5xekiWwKiG9kKqTfEgdEzLV8m
 bliDUaHGxy3bIoP1Yso5nraxxaUNg6QbMDn0Uh5BwqUnotvsedYE4M3PcbxntHon0rRz
 RV8wJvylbHtfCMawjrZum+ySumOo+IwfCgwjWc23tIJKSf37zjdDzI0eVf77YkqqZ5li
 pm169l5G/QdZMby/uq8z/0GTouII7l/0kvkqkYhr3OonjLI1Bbdqo0Lh6fiOwzSd8X6e
 297kXUS4zQ/lT8znJa7NtWHHpTOOKUzDkBrneMcTx/HYRUKG6zB72j91TlXuxzW86wwO
 S8oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741381233; x=1741986033;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DBlpnXVduv+5AmoyZl6pqWu84JM1UmMBLVVhVQDwJbY=;
 b=WG7uUD9XmUh23r71QDfyO8xdh2OjiTZEuvjBVufusD4uAKuzuEYqDEoYhG1UaRLfkt
 U7693wwNoB6vBTyd3yX3CrSy1n2+ME2MCTjKWYzaQR5xGNM7oiWiVbfikRyKD+/JMmph
 57No9mpydwNP0Oo9Aej40erTbjZOyv4gOPo4tIdsPy5/JQLx3VnlUy2i5jdgGccy9ZEc
 wIJkNzA3EsfbfDIDNnNSg5LAu9jrSrE6q3uwR13GOlZh0A5pdjT2pVG0ZEpzaimRUvTo
 8y1a1mqPZEmSwxOj+W8qD3V/8lp/5zwWvhCatn7kvp9uiZ+6Z9EC+xkiZFqLNTN2Xb+9
 2qtQ==
X-Gm-Message-State: AOJu0YwdMz/pcxUmDMbgn+AUXPOGAMKp2AUFpPramUHNuKwIGcv1RKCc
 WWPUpkXbuaWYTxylDMVuqXcDG5OwwOCtBpUuhikebSEY5I4vXXrH/afa14mDs6s=
X-Gm-Gg: ASbGncvTxsaKHhmmnR8ah+gkVzlU16wIDeK2MrT6TCLgOKcmhNmEzuTXfgrSIXi+JGe
 uXz7mwKAjpcucIqUXc79VdbHp+dvpZTAyghnxfPY4kEIWCWixA+W2Z4NrzUMdHpJ/m/fYg3IQGX
 XgNIvw02vQvAb/L+crb66R9ENjvIdg2145rYz3MDHRZtFDo95CSmy8XeYY9j73Zc95lixuQVjfg
 58p6WjDS5F3deEhx1WUUO4jBU3bfcfaxI3a6MwwigTXA9c8JjZwW9HW+sw1NTlcc0A5WJMkifbE
 4H03Dxtx58cXKx9sNp3s2si3o5xqFTAdKhnvINW59ugSoktE5Y/ttnTBCqDO6lzip9+dQ3ZxkvS
 +AOJWtol84KNo
X-Google-Smtp-Source: AGHT+IE0Gp1qXbtCuv9Bulwm1KI40337TQnXd3oScjrftwexmZN2k7oxxGD0Prtym8VVD08S2Jl1cg==
X-Received: by 2002:a05:600c:4e89:b0:43b:c448:bc34 with SMTP id
 5b1f17b1804b1-43c601d0758mr36327145e9.18.1741381233183; 
 Fri, 07 Mar 2025 13:00:33 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfa52sm6285939f8f.21.2025.03.07.13.00.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 13:00:32 -0800 (PST)
Message-ID: <ad9ab961-da0b-4835-a346-38c339150226@linaro.org>
Date: Fri, 7 Mar 2025 22:00:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] hw/virtio/virtio-mem: Convert
 VIRTIO_MEM_USABLE_EXTENT to runtime
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20250307151543.8156-1-philmd@linaro.org>
 <20250307151543.8156-6-philmd@linaro.org> <877c503ie6.fsf@draig.linaro.org>
 <a7126584-00fa-42ed-8e5c-d27d9933ac2f@linaro.org>
 <bb567f0a-ed7a-4861-a7bd-fda95f2ae7ce@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <bb567f0a-ed7a-4861-a7bd-fda95f2ae7ce@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 7/3/25 20:28, Pierrick Bouvier wrote:
> On 3/7/25 08:49, Philippe Mathieu-Daudé wrote:
>> On 7/3/25 17:38, Alex Bennée wrote:
>>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>>
>>>> Use qemu_arch_available() to check at runtime if a target
>>>> architecture is built in.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>    hw/virtio/virtio-mem.c | 20 ++++++++++++--------
>>>>    1 file changed, 12 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
>>>> index 5f57eccbb66..8c40042108c 100644
>>>> --- a/hw/virtio/virtio-mem.c
>>>> +++ b/hw/virtio/virtio-mem.c
>>>> @@ -15,6 +15,7 @@
>>>>    #include "qemu/cutils.h"
>>>>    #include "qemu/error-report.h"
>>>>    #include "qemu/units.h"
>>>> +#include "system/arch_init.h"
>>>>    #include "system/numa.h"
>>>>    #include "system/system.h"
>>>>    #include "system/reset.h"
>>>> @@ -170,13 +171,16 @@ static bool 
>>>> virtio_mem_has_shared_zeropage(RAMBlock *rb)
>>>>     * necessary (as the section size can change). But it's more 
>>>> likely that the
>>>>     * section size will rather get smaller and not bigger over time.
>>>>     */
>>>> -#if defined(TARGET_X86_64) || defined(TARGET_I386) || 
>>>> defined(TARGET_S390X)
>>>> -#define VIRTIO_MEM_USABLE_EXTENT (2 * (128 * MiB))
>>>> -#elif defined(TARGET_ARM)
>>>> -#define VIRTIO_MEM_USABLE_EXTENT (2 * (512 * MiB))
>>>> -#else
>>>> -#error VIRTIO_MEM_USABLE_EXTENT not defined
>>>> -#endif
>>>> +static uint64_t virtio_mem_usable_extent_size(void)
>>>> +{
>>>> +    if (qemu_arch_available(QEMU_ARCH_I386 | QEMU_ARCH_S390X)) {
>>>> +        return 2 * 128 * MiB;
>>>> +    } else if (qemu_arch_available(QEMU_ARCH_ARM)) {
>>>> +        return 2 * 512 * MiB;
>>>> +    } else {
>>>> +        g_assert_not_reached();
>>>> +    }
>>>> +}
>>>
>>> What happens if/when we have multiple arches available? Won't we want to
>>> know which CPU the virtio-mem device is attached to or do we take the
>>> minimal value over the whole system?
>>
>> "per attached vcpu" is how I was previously considering this problem,
>> but IIUC from the discussions with Pierrick, we should consider single
>> binary as a first step before heterogeneous emulation.
>>
> 
> I think it's safe to assume only a single arch is enable for now, in the 
> context of the single binary.
> A thing we could do is introduce qemu_arch_heterogenenous_emulation(), 
> that returns false for now. And assert this in places that will need to 
> be changed. So spots that will need refactoring will already be flagged 
> in the codebase.

Yes, after some discussion with Markus I started a branch adding such
macro. I didn't posted it so far waiting to show more realistic changes
w.r.t. heterogeneous emulation, to not add code that could bitrot.
Since we might be at a pivot position, I'll consider rebase and post it.

> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Thanks!

