Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4641FC0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6kV-0007eM-J2; Thu, 06 Feb 2025 13:37:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg6kT-0007dh-M0
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:37:13 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg6kR-0004QI-MY
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:37:13 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso8779145e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738867030; x=1739471830; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7Hhur0L/R0Khsw01cA+rc/OjVYMOUw5k7Zige8e37gM=;
 b=PLd/HRA+aXh+HG35LOkiVyhJvJlJ3sU44ZKs975+EPNyADtMXhzUj+vhZNhveD+p1s
 JCOWuH2w9a9q9Q5hMSxP13HTNfh5vFPuzFA2wOU6QNjUIhOyyAREl1aG1cdYH9VO8pOt
 m72Uc9Opow+O7bFGvKPd+5+5BvuXFUeQSZJNKVnKSF6sxeI7Ab+pDf+VvFf3vsu5Cn25
 yRb3gyZ4Ptk6mcr35ke9PWg34zf5EhIBqMQPWuKGipR55xUWaQSNL7NFdL7EIqHEKz+v
 OFNO7eIJehxFossV5HjCO4Gti+NfrMS5otKvByYqMPzz4Gf7WKV35KQ/8roDSHk/7FLI
 lvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738867030; x=1739471830;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Hhur0L/R0Khsw01cA+rc/OjVYMOUw5k7Zige8e37gM=;
 b=V+1ifHP2BGj2nrGCh3cPC7W+SeMdqa0PSbyIgcV+ERZ0LStRBTVv3aUyhZvj41gFs0
 NgKAEkYsS+gqi4IWjIRIu5pozAnc/j4UqiRcvRhnSHB0Bak9jsfAqVgDi71qmnU28GyU
 JmDdwSoCUK+xVKQacZ4oeO0flZAiuUMmPFmhyV40IMKBqBj6GxJNT1w32thbU2GxBwDo
 7SfQc+rSBau68Gvpv0CHp8bpXiO3oaGZdEGFGm3RFZjkyWhJ+6PcDWqHHtGgvL1sx7ar
 h34DBScrdNhHBohhHBseGs8m7PUeN0lE0as/9Rw3d8fpoP7ed9FFx5buEeQSV+OEZ3wi
 kCGw==
X-Gm-Message-State: AOJu0YzZQnQl4vLEQYI06no50n001lnAK1ZEy/mdehsH9mVLUQ6hJz7B
 j2Bdmrl3HErujdlXbxXOMKASB/415OM+geRr4B7kl2jzq4zw0CKy6/C5dMvkxuU=
X-Gm-Gg: ASbGncsLhmv3rS4Y6itvZ0+UXUNcmOeYAXJImfXoWz4BiRMtVi2iT17VnT4JxcbYVmC
 4d8IuHlQ2BGVbTmyPsG2irtL4U4pIfcdFGRAJTY1CHI7Wb/jRIJAndo7+mdOmV8agYGkZe7XRPL
 StZxfxmT8Gwv8Bg7SSv4yGyAUVEtm5hw+t8+xVKg19O30dpRhKz2RqNNnSPvlfSsKfVlpHwdjXa
 W/HrOTl4JRNUQnQlqnTz/0SyUBeE3nlerQmm52StEtdre3xhNZrq07AbYZ6ZaxQvWtyuplcbEbo
 n1hTaLPUyDrCfPegv+PQbh5P7Jdia7U8CRs52hKLtuN7RB8azCa1jmGKgfo=
X-Google-Smtp-Source: AGHT+IFRn0k/0VNdHATF21CxDhL2kDDJrPFrnzVYkO+t9DsvcqlIB579bGymQcNch+UVz1jhRR758Q==
X-Received: by 2002:a05:600c:4f47:b0:434:ea21:e14f with SMTP id
 5b1f17b1804b1-43924990cb5mr4514975e9.13.1738867029695; 
 Thu, 06 Feb 2025 10:37:09 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390db10b2fsm62443835e9.33.2025.02.06.10.37.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 10:37:09 -0800 (PST)
Message-ID: <c2ef5d4a-a1ec-42e3-b65a-1c1d96df749a@linaro.org>
Date: Thu, 6 Feb 2025 19:37:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/16] hw/microblaze: Support various endianness for
 s3adsp1800 machines
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michal Simek <michal.simek@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Anton Johansson
 <anjo@rev.ng>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@amd.com>
References: <20250206131052.30207-1-philmd@linaro.org>
 <20250206131052.30207-12-philmd@linaro.org> <Z6S3Mgt1G7fIjeBB@redhat.com>
 <4624f149-76d0-4da5-8f13-8c015043c335@linaro.org>
 <Z6THtfjL6UVhBiW7@redhat.com>
 <3156dc3b-9553-4b5f-a934-f29ee0601887@linaro.org>
 <Z6TtisO7JGAMGILH@redhat.com>
 <63f1130e-a30d-4416-ae74-374f1fd94dbe@linaro.org>
 <Z6T6CiL_F-LvLGel@redhat.com>
 <ce653340-1375-41b5-bebb-c7089d3ab2bb@linaro.org>
Content-Language: en-US
In-Reply-To: <ce653340-1375-41b5-bebb-c7089d3ab2bb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

(sorry, posted too quick)

On 6/2/25 19:24, Philippe Mathieu-Daudé wrote:
> +Michal
> 
> On 6/2/25 19:06, Daniel P. Berrangé wrote:
>> On Thu, Feb 06, 2025 at 06:49:38PM +0100, Philippe Mathieu-Daudé wrote:
>>> On 6/2/25 18:12, Daniel P. Berrangé wrote:
>>>> On Thu, Feb 06, 2025 at 04:04:20PM +0100, Philippe Mathieu-Daudé wrote:
>>>>> On 6/2/25 15:31, Daniel P. Berrangé wrote:
>>>>>> On Thu, Feb 06, 2025 at 02:53:58PM +0100, Philippe Mathieu-Daudé 
>>>>>> wrote:
>>>>>>> Hi Daniel,
>>>>>>>
>>>>>>> On 6/2/25 14:20, Daniel P. Berrangé wrote:
>>>>>>>> On Thu, Feb 06, 2025 at 02:10:47PM +0100, Philippe Mathieu-Daudé 
>>>>>>>> wrote:
>>>>>>>>> Introduce an abstract machine parent class which defines
>>>>>>>>> the 'little_endian' property. Duplicate the current machine,
>>>>>>>>> which endian is tied to the binary endianness, to one big
>>>>>>>>> endian and a little endian machine; updating the machine
>>>>>>>>> description. Keep the current default machine for each binary.
>>>>>>>>>
>>>>>>>>> 'petalogix-s3adsp1800' machine is aliased as:
>>>>>>>>> - 'petalogix-s3adsp1800-be' on big-endian binary,
>>>>>>>>> - 'petalogix-s3adsp1800-le' on little-endian one.
>>>>>>>>
>>>>>>>> Does it makes sense to expose these as different machine types ?
>>>>>>>>
>>>>>>>> If all the HW is identical in both cases, it feels like the
>>>>>>>> endianness could just be a bool property of the machine type,
>>>>>>>> rather than a new machine type.
>>>>>>>
>>>>>>> Our test suites expect "qemu-system-foo -M bar" to work out of
>>>>>>> the box, we can not have non-default properties.
>>>>>>>
>>>>>>> (This is related to the raspberry pi discussion in
>>>>>>> https://lore.kernel.org/qemu-devel/20250204002240.97830-1- 
>>>>>>> philmd@linaro.org/).
>>>>>>>
>>>>>>> My plan is to deprecate 'petalogix-s3adsp1800', so once we
>>>>>>> remove it we can merge both qemu-system-microblaze and
>>>>>>> qemu-system-microblazeel into a single binary.
>>>>>>>
>>>>>>> If you don't want to add more machines, what should be the
>>>>>>> endianness of the 'petalogix-s3adsp1800' machine in a binary
>>>>>>> with no particular endianness? Either we add for explicit
>>>>>>> endianness (fixing test suites) or we add one machine for
>>>>>>> each endianness; I fail to see other options not too
>>>>>>> confusing for our users.
>>>>>>
>>>>>> We would pick an arbitrary endianness of our choosing
>>>>>> I guess. How does this work in physical machines ? Is
>>>>>> the choice of endianess a firmware setting, or a choice
>>>>>> by the vendor when manufacturing in some way ?
>>>>>
>>>>> Like MIPS*, SH4* and Xtensa*, it is a jumper on the board
>>>>> (wired to a CPU pin which is sampled once at cold reset).
>>>>
>>>> That makes me thing even more it is just a machine type property.
>>>
>>> I'm happy with a machine property, this was even my first approach
>>> using OnOffAuto until I ran the test-suite and have qom-introspection
>>> failing.
>>>
>>> What should be the default?
>>>
>>> Per the SH4 datasheet:
>>>
>>>    Bit 31—Endian Flag (ENDIAN): Samples the value of the endian
>>>    specification external pin (MD5) in a power-on reset by the
>>>    RESET pin. The endian mode of all spaces is determined by this
>>>    bit. ENDIAN is a read-only bit.
>>>
>>> There is no default per the spec, and I believe using one is
>>> a mistake.
>>
>> If it is left as an unspecified choice in the spec, then I would
>> presume HW vendors are picking an option based on what they
>> expect "most" common usage to be amongst their customers. IOW,
>> if we know of typically used guest OS prefer big or little, that
>> could influence our choice.
> 
> Please have a look at this thread:
> https://lore.kernel.org/qemu-devel/ 
> d3346a55-584b-427b-8c87-32f7411a9290@amd.com/

Per Michal:

   Truth is that I am not aware about anybody configuring MB to big
   endian and we  are on AXI for quite a long time. There is still
   code in Linux kernel for it but I can't see any reason to keep it
   around. I don't think that make sense to keep big endian
   configurations alive at all.

So with that in mind, using a default of little-endian=true for
MicroBlaze seems safe as of 2025.

For MIPS, big-endian was the default but as the industry shifted,
it stayed big-endian on low-end 32-bit cores but mostly became
little-endian on high-end 64-bit cores.

For Renesas RX, the "Endian" section in the "CPU" chapter of the
hardware manual mentions:

   Both big and little endian are supported for the treatment of data,
   and the endian is switched by changing the setting on a mode pin (MDE)
   at the time of a power-on reset.

SH-4 "is bi-endian, running in either big-endian or little-endian byte
ordering."

