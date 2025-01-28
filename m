Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0E4C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 15:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcnES-0005VM-4n; Tue, 28 Jan 2025 10:10:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcnEQ-0005Uy-C3
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 10:10:26 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcnEN-000246-IY
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 10:10:25 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-385dece873cso3131872f8f.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 07:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738077021; x=1738681821; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ViM+rjZUgxvbfxwTZxZKl7dD2XoHFDnQHFMIYBVWG2o=;
 b=J29znIgRIzTnqTbTk9QO/YQ1DI/H13uF/VPEi6gL9rt7SQSAuv5mtI5gcXom6Clie0
 +x75rabTu9gFWIX43dkhg5kqzcXGj9uleSoTk+sInwo7f1Zmfv2oL6WJdQOBxF8n/ya4
 DuiDw77Qxhrw9yanl+N9JtKAUGispuOdzLN63az5S/DRrMgNoc1/EkJZqm6X+1o56R7Q
 Lhgs3Smzot5kRzqAAk+w9ltLOlP5kr4u8Mt+BbwXJz7qnaTr0mg1q0uryI2mDqpC4QpO
 NLEwKGUD/T1eoJjZMscO9aQUniU1LyOxIPzc9dlp4hvPIk4+AWtds8jwOBJluQw+raHQ
 GrHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738077021; x=1738681821;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ViM+rjZUgxvbfxwTZxZKl7dD2XoHFDnQHFMIYBVWG2o=;
 b=G6xTRYxeEGc61pxtsFc5iB/ZRiaWXQq5PSN2COELHn4h7jbsLTAPACJtnvRFL/s9cZ
 b2q3YkHrlibkoAbayrWvLQINNrStcmr0DWw8SGidOdOm3XL7ZOYbDk6NBhJU2sq6gZ6f
 E0T4ODmwOFxJ2MeOAY/buIKg1BzDfqY6ysA5AJg8fHRUE7apxAur5Va4JCGbpxf1/yAr
 qXEQ+BColf9B0LADaPv9xIHhh8KPcaihGE0uYFKtInxcWM/5fR3Dx3k82UAbl3Oko3J/
 vzzL8zetTU/Ydcv32S6+qdZzo/DJmGOMj+kUh84txOxYDFqghhVZwELpIMPGlZE9sdoH
 h9Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2o9N85LM2P/LtEsl969/nRXjZLFRcKd9uCMCYDsf9Ct2+05ADvFkZpa7rJW9HkQb2Ue+lAtq0+6Lv@nongnu.org
X-Gm-Message-State: AOJu0YxMBX8XDFJoVR6Xf3/ytzRgM9Bw6CIS9XfColQiC7EtUoQDjO6x
 QQBOdoWHj2LJzziFNsxEEDEWIQjVeOnT4qhDU0wlD9ZMDm7d0mPHem+sRH6vZYA=
X-Gm-Gg: ASbGncsYavZ4fFWCcCGNoG6VyC1zBCIz6s87oJ5gm3MWoKRjOUNptwOggEAtQuD3ZkG
 yZybTf5uOkBJbga7copl9+FM77uOymxmuRPKN12XMKxryOcmjGGEXcnqjtEisxTWVwrfqv068Rd
 hhq7z0/RG+Wt9q5u583mtzmtqbEj/bj66iPAqau9qsA3t9iRAlDofJ0Sz6DQ2qVnXunBeMfrwJK
 qXulmwc2A+LMklgICBGtV612pqt2jWRO6DeNbaKOrGPxLECeAzR9708pazHFXK6zrRUHnD92+xG
 ieSKghurwgs6h0wxD8+bEUJiQj0co5+zpm4ueBXNE/73vIYYU53UE4RP3vo=
X-Google-Smtp-Source: AGHT+IGLc4A5clvj21CfoQyBX6F3omCt6bWQLv3EkWi0U+JM0LkNEZMv50192jgozkl7S+UQxS3FRg==
X-Received: by 2002:a05:6000:18a9:b0:38a:86fe:52dc with SMTP id
 ffacd0b85a97d-38c3b0cbb61mr9689447f8f.13.1738077020863; 
 Tue, 28 Jan 2025 07:10:20 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a1c402esm14561306f8f.97.2025.01.28.07.10.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 07:10:20 -0800 (PST)
Message-ID: <990dacab-6cfd-4a18-944d-ba076a80996c@linaro.org>
Date: Tue, 28 Jan 2025 16:10:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] hw/sysbus/platform-bus: Introduce
 TYPE_DYNAMIC_SYS_BUS_DEVICE
To: BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Yi Liu <yi.l.liu@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Anthony PERARD <anthony@xenproject.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, Jason Wang
 <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <graf@amazon.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20250125181343.59151-1-philmd@linaro.org>
 <wkb53fhvfchqa4uvmifgitvcr7t7rfpc3hcohdhzczkzvktetx@yjveswjel3s4>
 <CAFEAcA-QOYcnJi=joKHbRmUCXK1UFOgQRgYP-fDq4h_1SkMGyQ@mail.gmail.com>
 <2893a552-ca6c-01c4-dcc0-6107ccf1c7b5@eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2893a552-ca6c-01c4-dcc0-6107ccf1c7b5@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 28/1/25 13:57, BALATON Zoltan wrote:
> On Tue, 28 Jan 2025, Peter Maydell wrote:
>> On Tue, 28 Jan 2025 at 10:42, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>>
>>> On Sat, Jan 25, 2025 at 07:13:34PM +0100, Philippe Mathieu-Daudé wrote:
>>>> Some SysBus devices can optionally be dynamically plugged onto
>>>> the sysbus-platform-bus (then virtual guests are aware of
>>>> mmio mapping and IRQs via device tree / ACPI rules).
>>>
>>> Do we have some sane way to have user-pluggable sysbus devices on arm?
>>
>> The answer in a general sense is "no, because user pluggable
>> sysbus is a weird idea". "sysbus" means "it's wired into a
>> specific bit of the memory map and to specific IRQs, and whoever
>> does that needs to know what IRQs and bits of memory are usable,
>> and the guest OS needs to know it's there". "user-pluggable" means
>> "it's all automatic and the guest can just do some kind of
>> probing for what is or isn't present". All the platform bus stuff
>> is a nasty mess that's working around the things people want
>> to plug in not being clean devices on probeable buses :-(
>> And the platform bus is only supported on the "virt" board,
>> because that's the only one where QEMU is generating its
>> own dtb or ACPI tables where it can tell the guest "hey,
>> there's some device here".
> 
> There are some SoCs that have memory mapped devices but different 
> versions in the same family have different devices. Either older ones 
> missing some devices or have less USB or network ports while newer SoCs 
> have more of those or they have PCIe instead of PCI. Modelling these 
> could use pluggable sysbus devices so one could add the devices needed 
> for a SoC version without having to write or modify a board code. I 
> think Bernhard's attempt to try creating e500 SoCs from a device tree 
> goes in that direction too. We could also model this by having a SoC 
> that can instantiate devices based on some properties but maybe 
> pluggable devices could be more generic for this. The issue seems to be 
> how to tell the board or SoC where to map it and what IRQ to connect it 
> as this is done by the board and not the device so properties on the 
> device to set these does not really help unless the board can somehow 
> query it and instantiate the devices based on that. Otherwise whatever 
> handles the -device option to create the device would need knowledge 
> about the board. (E.g. the e500 devices are mapped in the CCSR memory 
> region so one can't just use system address space for them.)

IIRC Bernard's series takes a DTB as input and create the machine
matching this DTB.

As Peter explained, sysbus-platform-bus fits TYPE_DYNAMIC_SYS_BUS_DEVICE
in free slots, then generates the corresponding ACPI/DTB.

What you describe seems closer to the QEMU Dynamic Machine project,
following Damien's idea:
https://lore.kernel.org/qemu-devel/20220223090706.4888-1-damien.hedde@greensocs.com/
We are not quite there yet...

