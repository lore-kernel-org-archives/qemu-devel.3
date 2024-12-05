Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E881FE7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 21:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJJLM-0002cy-Pp; Thu, 05 Dec 2024 16:25:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJJLL-0002bP-8f
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:25:03 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJJLJ-0005BA-FQ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:25:02 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-434a1639637so14882755e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 13:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733433900; x=1734038700; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PCvG1uFJ7bfIwhXq4y2fDMl/5i/DI5j9+WT4jXv9Bfo=;
 b=SCY3CkwKH0c30q1IQSAK1eH4DbHJxafE4oB5jaypJK8ScId1+U1y2mUt/KhMa4j1iy
 9ZYI3SA9tUfUEAk+x1fFNEkOwRb6DfH7+GGbavinh5x5jauakdpIgRqEJkys/egz8obl
 hWe4wySDTMz48f82DcSOCYVY9ZU7aUnoptK8DaSWnT6abncsxb1Sbs9KitLS/FRUvQhM
 NkG+Lfv3Eceux1Y+hAfljIhcdikDAYXir89RRI4xHvQd4PyH2WGL/lJmLeBpTp1HJOOn
 Tx0C6XZX5fYcaOqdXeu7cAoVrWWZRG37sG+ZQAdnZ/MV8rBNU1kA3BvXGXPIfY66lp04
 LzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733433900; x=1734038700;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PCvG1uFJ7bfIwhXq4y2fDMl/5i/DI5j9+WT4jXv9Bfo=;
 b=hZOK+ghag9VQwTTbpODYz2vJRami3U/jfytp2BknsbOQ934R+HWeUBClgURrCScCSG
 Fs0jI3BnXcCfDmtdNg8cg456pbSWb9pTLyxQNh+aRWRfvFvTjJY/fkFE9tEIXWr9TJSW
 6Ay/ksplE/l4zsiZioEYzBQy8P2D1RtrOyv2gzB/gYF1PRWhK4uzgQJFgojsYQtI28yK
 DuRfxoVlIm9TemydMA68CYu7mNZ6tMpe6wvTBVZJXiXvLiJ3P7ylQYQclO6E4Nfvlnpt
 LtY6KXDQlFR87zkHP8clNVztF/Xx4nBzBCKelOvxcCRzdkm+GrjzBCp9nC6jueOqYeDD
 O3cQ==
X-Gm-Message-State: AOJu0YxuKytYB95Z2cOBBE+E/vX35x2FKTtliSw3A5E7t2KJmkDDCtwM
 5aOStpn8Kf2fw1DLvLlfIPcIX9qKEKsqM1RVQMtHcAjq2cSqi6A6us1LfAq2gA4=
X-Gm-Gg: ASbGncs5XUeX98CLBDp9ArpEm07QYek0+t8K1mp6jGwoOfDwFOIy1gy89qQGFhhtdbx
 TYadI8Qv2sRcLQPA3xyBCl3Pgh/Qe6uFNYf78s0fOpfk5icQ1v9/La697YAqEmUc7wN4oMs6aIU
 lUVmV83xXBTsOk0PvDBm5kxPm6xCwJPuHZhSeApGquVUe4Hkv3XawLd3CmhyNfn386W8vs81vJh
 vBhBsVl9mKWeOdR88AYFvllWDVcE5c3x5IXFO8WP7Zmf08B033xxZpHs6HBxXIzi6szpJ5ZQFKL
 gZzyrBxmGxZBjDXJDQ==
X-Google-Smtp-Source: AGHT+IFhmj0AT9hcMZk9gm9w2I7MvN3QVekpea3gzUdfhgO+7ZCtVFjTdiiwNF95Z1CinXa0fevyUw==
X-Received: by 2002:a05:600c:444b:b0:434:a815:2b5d with SMTP id
 5b1f17b1804b1-434dded670cmr6188655e9.24.1733433899849; 
 Thu, 05 Dec 2024 13:24:59 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434da0dc152sm36170945e9.25.2024.12.05.13.24.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 13:24:59 -0800 (PST)
Message-ID: <b353feb7-65c0-4db3-ac57-3a4f442b6474@linaro.org>
Date: Thu, 5 Dec 2024 22:24:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 v2 05/13] hw/pci: Propagate bar_at_addr_0_refused
 to pci_root_bus_internal_init()
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-riscv@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20241126112212.64524-1-philmd@linaro.org>
 <20241126112212.64524-6-philmd@linaro.org>
 <CAFEAcA_K_DqRfipvQf0LcrXAMANVrwtCPD3cd2gMah=p2JH2DQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_K_DqRfipvQf0LcrXAMANVrwtCPD3cd2gMah=p2JH2DQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 5/12/24 17:44, Peter Maydell wrote:
> On Tue, 26 Nov 2024 at 11:22, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Have pci_root_bus_internal_init() callers set the
>> 'bar_at_addr_0_refused' argument. No logical change.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/pci/pci.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>> index 27b66583e54..8eacb8f82fc 100644
>> --- a/hw/pci/pci.c
>> +++ b/hw/pci/pci.c
>> @@ -529,7 +529,8 @@ static bool machine_refuses_bar_at_addr_0(void)
>>
>>   static void pci_root_bus_internal_init(PCIBus *bus, DeviceState *parent,
>>                                          MemoryRegion *mem, MemoryRegion *io,
>> -                                       uint8_t devfn_min)
>> +                                       uint8_t devfn_min,
>> +                                       bool bar_at_addr_0_refused)
>>   {
>>       assert(PCI_FUNC(devfn_min) == 0);
>>       bus->devfn_min = devfn_min;
>> @@ -537,7 +538,7 @@ static void pci_root_bus_internal_init(PCIBus *bus, DeviceState *parent,
>>       bus->address_space_mem = mem;
>>       bus->address_space_io = io;
>>       bus->flags |= PCI_BUS_IS_ROOT;
>> -    if (machine_refuses_bar_at_addr_0()) {
>> +    if (bar_at_addr_0_refused && machine_refuses_bar_at_addr_0()) {
> 
> Should this be || rather than &&  ? If I understand the
> intent correctly, we want to prevent a BAR at address 0
> if either:
>   * the MachineClass field says we don't want one
>     (legacy handling, eventually goes away)
>   * the new command line argument says we don't want one
> 
> rather than only if *both* say "no address 0" ?

Oops :)

> 
> thanks
> -- PMM


