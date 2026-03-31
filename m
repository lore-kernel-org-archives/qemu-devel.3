Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F163CFF60F7
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7VUc-0000x6-SJ; Tue, 31 Mar 2026 05:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7VUa-0000vM-8d
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:34:36 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7VUY-0005XW-Ht
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:34:35 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso61651595e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 02:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774949672; x=1775554472; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wZMI9Wyu6cOsuHCG+sxcoMGLYV1u1z5fnlpXU6jhoOM=;
 b=jag29zwOe2jcB9CCjOpVdtYCvBt+ZnaRyjEHRuyTxPej+lsVFmp1PcqSNVWdqHcyoh
 0tqWFKwNwHDntppABgLy4sAIBn9BrwK6QsjtGeeuDFTLdgj5m90BldqUzitprDCY50Fk
 eERh2fq8plVIMb/gj2Y04CNaOEOTB6Jl6NMHxGMmsW/QR+i+feXx5S/xCYSJnaklTJjh
 YXDdnInJb2/N9aD9h2fvD4eka6gcqpFp3ronh7cO9ocoAc5T/HR5V51WJdca758ef16a
 mVsCl/KZV6qgcwM0huPiPi+RNWxDQJmKO/yCfCY9mCe6UFFWqKAq3RedtSJM5w8GBn6L
 epLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774949672; x=1775554472;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wZMI9Wyu6cOsuHCG+sxcoMGLYV1u1z5fnlpXU6jhoOM=;
 b=Kf8L0MaHgc40tKkMjc4w4lwxVeJ/PWisJ2L4dRZKuiCxOyj8iYuaRqUaiyl/z0YPL5
 ATciNH1HACMaBo+m71g4KpsgLR1i9g++2ERCEYJ1ygtubOVb9Kfn8MPBterFMFbWuJEF
 0BImROCua2wKi9XQPCIfw/6TgQLREdfdLkXKc9myu9aFwyF5eeUGafuOzCBw6VRLt/a1
 FR6IQfo/+qjhBIUkPGC/PLv/3Yolpldo+2/lUQPypwCrGJo40PdP/4UR0iz2HgKoeukE
 5gQqahNsWzdDOB3atsvUfc0A+5hPePXW6zHGuKEw9dwbhUpHxBxUeoHnxyQER6nahiR+
 PLEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUapRlZevqB9xaBA15MiYlyQ+FC0dCznGDBTWKgEZ9y8D0Bpi1yZwoYvbwt/xodE+jxEvJImVfGzHmh@nongnu.org
X-Gm-Message-State: AOJu0Yz+4p6IWQmXoMY32jGbM3xOiSPp481dFmvZwf23PeZOuxKCSxan
 NIrkiiOe/ybfE00RBKaaL+JPg1/W8JNPFVL1STdekSh/52smh88e9RcDtC7SNs9KpAs=
X-Gm-Gg: ATEYQzyJdfF7HBRA1CAo9BMTUY8lxZjBATs328tqwxh/I1n7/cbOCdL7ZB7emz/YOTi
 OKYVB5UzZqoA3dIzo4WmY4+ndQTjgqg+MCGnrl+a2NzJUJGju58F4SaHvZmYlmSBc5QMGunlX2A
 MDzX7+HDIsQJO7nnrXR1NuKt3HuyQmbQ0U/HHnImAW6vjOn6l+TjA8ECDNk8W5WHWeOLztekMWO
 0amV3c4c/3Gq5tEJAHbxh5n1Wt0ykYiGmTjCGvjraHtCoQ4SL1y7Z/fHAU+N8OYKQ2HFRNhQRLB
 ecH9PjACawFmIuvMRt5kyG11R4+K6Tyqvi2qG/8L5whKWvNmV6zWkM6jnkaVP0MIAL6bHvyxDWF
 EDQd5/5RiG4Bki8zlD03zDecV6cNJ4XL5hrPfPk3CxlLq8XuVQrfFC9v5b0nxuLKUW44bL9unvK
 sgSzN4J6pABPzru9dxp5R62lDQqVy1RqZJ8dZEFlWBHAxCwIJOA1Ggcu6kHA==
X-Received: by 2002:a05:600c:47cf:b0:487:1ed:6bf4 with SMTP id
 5b1f17b1804b1-488781840f3mr33661915e9.3.1774949672506; 
 Tue, 31 Mar 2026 02:34:32 -0700 (PDT)
Received: from [10.193.39.66] (43.149.216.82.rev.sfr.net. [82.216.149.43])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21eba4dsm27849754f8f.11.2026.03.31.02.34.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 02:34:31 -0700 (PDT)
Message-ID: <081d94dc-60e7-490d-84ef-d60857be3410@linaro.org>
Date: Tue, 31 Mar 2026 11:34:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] hw/hppa: Disable Artist graphics card on 64-bit
 machines
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Helge Deller <deller@kernel.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20260330211859.19317-1-deller@kernel.org>
 <20260330211859.19317-3-deller@kernel.org>
 <04942b9e-ed2f-4553-b4c7-73d5499f342a@linaro.org>
 <0634a5f1-7f98-4905-b5a4-394d5cfec3a3@gmx.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0634a5f1-7f98-4905-b5a4-394d5cfec3a3@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 31/3/26 10:58, Helge Deller wrote:
> On 3/30/26 23:42, Philippe Mathieu-Daudé wrote:
>> On 30/3/26 23:18, Helge Deller wrote:
>>> From: Helge Deller <deller@gmx.de>
>>>
>>> The original Artist graphics used the GSC bus, was often installed in 
>>> old
>>> 32-bit machines (e.g. 715) and can not be used on 64-bit machines.
>>> This is why this patch makes the artist driver dependend on the Lasi 
>>> chip,
>>> which was never used in a 64-bit machine.
>>>
>>> Note that there exists a variant of Artist for the PCI-bus 
>>> (Visualize-EG PCI).
>>> It has quite some differences in the registers, and would require 
>>> that we write
>>> a PCI ROM for it, so that Linux and HP-UX would be able to use it.
>>>
>>> Instead, for now, users can simply use a standard VGA or ATI PCI 
>>> graphics card
>>> on Linux.  This can be enabled on the command line with "-device ati- 
>>> vga" or
>>> "-device VGA".  If the "-nographic" option is omitted, a PCI OCHI 
>>> controller
>>> with USB keyboard and USB mouse will be added automatically.
>>>
>>> This fixes graphics support on 64-bit hppa machines and allows us to 
>>> boot up a
>>> 64-bit Linux installation with VGA graphics.
>>>
>>> Signed-off-by: Helge Deller <deller@gmx.de>
>>> ---
>>>   hw/hppa/machine.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>>> index 3663bac53b..58e76bee2e 100644
>>> --- a/hw/hppa/machine.c
>>> +++ b/hw/hppa/machine.c
>>> @@ -384,7 +384,8 @@ static void 
>>> machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
>>>       SysBusDevice *s;
>>>       /* Graphics setup. */
>>> -    if (machine->enable_graphics && vga_interface_type != VGA_NONE) {
>>> +    if (lasi_dev && machine->enable_graphics &&
>>> +        vga_interface_type != VGA_NONE) {
>>
>> Pre-existing, 'lasi_dev' being a static variable isn't really helpful.
> 
> Yes, can be done post-v11.
> Where would it belong? Into MachineState?

HppaMachineState that would encapsulate MachineState.
(hint: git grep ' MachineState parent_obj')

> 
>> Back to this patch:
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Thanks!
> 
>> Although a distinct descriptive boolean variable could be used
>> instead for clarity, rather than testing LASI presence.
> 
> Helge


