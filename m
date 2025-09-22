Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF2DCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 12:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0fIN-0007BB-GN; Mon, 22 Sep 2025 08:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0fIL-0007Ao-Ec
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:05:25 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0fIG-0000iP-BL
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 08:05:25 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-54a7bf06edfso2876181e0c.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 05:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758542717; x=1759147517; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7qqIOTGcI6PKpM5IzeBBys6UlqxBdhvaYy3CPwc7VrY=;
 b=WXUmZHhTo4zaH70jmBcQZT63HMBg3mKx6FEmcCHMdcmxRKuP8YTwn5FQzjAD9IPHGG
 9ptfb2YqR2lJZon+lcDPPA+P7iti+F6A+IMOUl1squO73E377vahYVBTS+uJbbJOu6PK
 Av1VvgoWtUsx/GnE1+BvQN42NRGcQk+OcOdV2xexknyzD+EaoQi/dRcvKEs318+1ljmM
 kzUrmoNO8VRBnWcy35fdPR2sGfPFh790zuDcCSHNDXFM8IHHyZXLyXe2Wx8NTRay82qF
 zL3VzSN1HJbCHnYdkNbpmQxV2x0WhUmCn3eSVkyo+kaBSdWzF5ys7ojMkUqGBW072Jn1
 GTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758542717; x=1759147517;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7qqIOTGcI6PKpM5IzeBBys6UlqxBdhvaYy3CPwc7VrY=;
 b=axL8KPMF4PKF7vqQIdnQPBl0de9tP1X9Ms/XPDZyZon5L7HhBBaQnPjplKWBB8UuUr
 Be3HUicN2vc0Jx0XQOUJ0d4rS93D0nR8SZLzkoZ8DEMV4LuuSljxkKKdVGkvd3eHrEU0
 AmKvA43ozMun8XPTy3wYTpEVmTw+cj9DFyWc+zISBJZJLdXmCr0mtVxbFxaqL/yeSeyp
 S88wDNyVJZotbw9clQgzme8h2BqHb6ZmyXNtHgk+XeJe4/7SpociTR1nvlrtGn+4zEJP
 vSEA20RPG+bvS/9//mY0u9IBjrYZghT6E30Vy4GsRpy40TNKkDme0mKT6ckPTsq2P4NJ
 ELlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXW93epVPsJj9ugvFrsDNs06h5Hy+73I8dEQ0QtLFF+p+PXuNIShk490A1DBzPFhkCraQPdolnhwO0I@nongnu.org
X-Gm-Message-State: AOJu0YxcA13H74qyaaP+nj5eDP9ZfZ31IKIbz7HVu8PoQcI6JTRpLcBs
 Qn+0MtZKUXn904F7I8ruRUZUmkbqowuZ2wizFO/vLlL1IcuhBkiok/XY0prT+pyvopM=
X-Gm-Gg: ASbGncsx2lea/IIJNbzNSsdJPpPRjmCHHgE5vln8fLdcPKLEBH/3QbDMfx7wQAiEoMe
 E/Teg22oZuoI50OQ4W3rYMu4feGTtkL8x5BisXYbATx2hVpaF7gL1oHF1Y/JMZfzVkQJkDRRlUU
 wcnLLeeUvs+afMLTgtQwhkwjiCvxUXzU55DxQ2mImIQzEC6MSU5LEkDK4IGN0MB8wV1OM2BQZzY
 yrF6PrSk9NggGSPUkB5H4IaZW2C73/IBuMlFrzAVSSzoKbYBSU3+c9LDNxp3gVWoHATJHUbnVVR
 nqsZHaryPrN4jC7QA10n2XNsL151+GmrZSpE9ojIs0Tg7N4hwYY314KHE0pzrnlToFhq82dGjck
 JvmeOyZ9stFAeE3cQWxAVKtiZvCDJ69qMAITOmC1hUK7YOIfnpJjV9dm1z0ZYbyeFuw==
X-Google-Smtp-Source: AGHT+IHlH49uEG9unLh1WtUWpbbGpshFyI+9WMpYESc1F+X3/rViUaQETYqQ3ZjoVPvCrhkgXZuESQ==
X-Received: by 2002:a05:6122:1348:b0:520:64ea:c479 with SMTP id
 71dfb90a1353d-54a83850acamr3569968e0c.10.1758542716770; 
 Mon, 22 Sep 2025 05:05:16 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-54a8bf1802asm1652923e0c.26.2025.09.22.05.05.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 05:05:16 -0700 (PDT)
Message-ID: <1178e514-a054-4ace-a5b7-06ca899badec@linaro.org>
Date: Mon, 22 Sep 2025 14:05:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/19] hw/i386/pc_piix.c: restrict isapc machine to
 32-bit CPUs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, pbonzini@redhat.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, imammedo@redhat.com,
 qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>
References: <20250822121342.894223-1-mark.caveayland@nutanix.com>
 <20250822121342.894223-2-mark.caveayland@nutanix.com>
 <3c2e9fbc-db80-4dd6-a1a5-deeabb8c0194@intel.com>
 <58c515a4-292e-4aec-b57e-73be89b9c322@nutanix.com>
 <aK7wDn03e8RtKmk3@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aK7wDn03e8RtKmk3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=philmd@linaro.org; helo=mail-vk1-xa31.google.com
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

On 27/8/25 13:46, Daniel P. Berrangé wrote:
> On Wed, Aug 27, 2025 at 12:10:00PM +0100, Mark Cave-Ayland wrote:
>> On 26/08/2025 08:25, Xiaoyao Li wrote:
>>
>>> On 8/22/2025 8:11 PM, Mark Cave-Ayland wrote:
>>>> The isapc machine represents a legacy ISA PC with a 486 CPU. Whilst it is
>>>> possible to specify any CPU via -cpu on the command line, it makes no
>>>> sense to allow modern 64-bit CPUs to be used.
>>>>
>>>> Restrict the isapc machine to the available 32-bit CPUs, taking care to
>>>> handle the case where if a user inadvertently uses -cpu max then the
>>>> "best"
>>>> 32-bit CPU is used (in this case the pentium3).
>>>>
>>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>    hw/i386/pc_piix.c | 26 ++++++++++++++++++++++++++
>>>>    1 file changed, 26 insertions(+)
>>>>
>>>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>>>> index c03324281b..5720b6b556 100644
>>>> --- a/hw/i386/pc_piix.c
>>>> +++ b/hw/i386/pc_piix.c
>>>> @@ -436,6 +436,19 @@ static void pc_set_south_bridge(Object *obj,
>>>> int value, Error **errp)
>>>>    #ifdef CONFIG_ISAPC
>>>>    static void pc_init_isa(MachineState *machine)
>>>>    {
>>>> +    /*
>>>> +     * There is a small chance that someone unintentionally passes
>>>> "- cpu max"
>>>> +     * for the isapc machine, which will provide a much more modern
>>>> 32-bit
>>>> +     * CPU than would be expected for an ISA-era PC. If the "max"
>>>> cpu type has
>>>> +     * been specified, choose the "best" 32-bit cpu possible which
>>>> we consider
>>>> +     * be the pentium3 (deliberately choosing an Intel CPU given
>>>> that the
>>>> +     * default 486 CPU for the isapc machine is also an Intel CPU).
>>>> +     */
>>>> +    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
>>>> +        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
>>>> +        warn_report("-cpu max is invalid for isapc machine, using
>>>> pentium3");
>>>> +    }
>>>
>>> Do we need to handle the case of "-cpu host"?
>>
>> I don't believe so. I wasn't originally planning to support "-cpu max" for
>> isapc, however Daniel mentioned that it could possibly be generated from
>> libvirt so it makes sense to add the above check to warn in this case and
>> then continue.
> 
> Libvirt will support sending any valid -cpu flag, including both
> 'max' (any config) and 'host' (if KVM).
> 
> If 'isapc' still expects to support KVM, then it would be odd to
> reject 'host', but KVM presumably has no built-in way to limit to
> 32-bit without QEMU manually masking many features ?
> 
> I'm a little worried about implications of libvirt sending '-cpu max'
> and QEMU secretly turning that into '-cpu pentium3', as opposed to
> having '-cpu max' expand to equiv to 'pentium3', which might cauase
> confusion when libvirt queries the expanded CPU ? Copying Jiri for
> an opinion from libvirt side, as I might be worrying about nothing.

OK, on 2nd thought, even while warning the user, changing the type
under the hood isn't great.

What about simply removing "max" of valid_cpu_types[], since it is
clearly confusing "max" == "pentium3"...

