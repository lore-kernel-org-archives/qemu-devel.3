Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0213CE7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 17:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJFgD-0003iW-7C; Thu, 05 Dec 2024 12:30:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJFgA-0003iE-NI
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:30:19 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tJFg9-00033C-9a
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:30:18 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-71d56fe8240so661818a34.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 09:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733419816; x=1734024616; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6QZvgeI+YuoODB9ffzZ/nnQfxTjkTOLw79885ZiR3MA=;
 b=stiU/1BK3s6xidmxsgszgP2GwDzK1WYh+R5FLv/uuMSkKQTy0p5t/zJYKFduTnKw4K
 z+fPbhCbUiVbJG1KzTSZTM3fcpRnFQsOPiWy/PqjoYQ6rBo9xr8jU9vsjYNrIfndEDvP
 6FouchSEyn1myqsBKJI8kOP6HYARrV9UR5ZZaPArmdpy1KU9hsClNn6+3XjfePwUQFKu
 TejNxyM0be4OAF+EFCYdL201BDGcOUPiirBY0qPN33F9m+IyuzFnjvJV30GwrQFh/L4U
 Vn3XG9XVaA7kLASD7tFWjZJGyC7ON8xPCml7+u/kVlXW1GM3nKBzuEr8JqEWDJ2r6NLs
 zVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733419816; x=1734024616;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6QZvgeI+YuoODB9ffzZ/nnQfxTjkTOLw79885ZiR3MA=;
 b=WSvxjIcwIW6FmVdFPrMehaBmMCSpUuGT7MJXNuGGm2aRgb+K1sipM3HHXeeKJ8OKxW
 ioZ+a5AaOxEZvIL5P5YEkDx0GJXUL5O4twdA0NQreGnkWszReQb8840/FBnZWCArcNkz
 IPA2F6/j5xmmEtwRW1CnT2XlqIKhqJOndIIfWFSQXv0z0v+rhqVRs2W1c92ELpUqifmC
 b72dufM5ccaLvi141biFTU/KfHUtDa/7SO4Nbfcl8xorpngkZ5ULemLygRIaU0W+5fOU
 Fa1Vkdll8Z5VjXA4d2UUcBwCLhWrADv7HTo/vVdhT3++ZduyWnV2Y4RW6J34LQPuu/xz
 X1Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCYccfAQ6au/kVZ5+G62cVm/klBNXDx5yGGcV2QFNzHUhw2UFEPnujW4BnBC2+wNcGD3WaCDPAHKjf@nongnu.org
X-Gm-Message-State: AOJu0YzKkoSVMdZBhjO5pa1EB35Y9pBssvE7Ku/RSeatvyLOsLFzGOMN
 rGmfB2raO36Taw72FIUcdhPF1AnyTrD7fs5dy5JvzuNKGxwryBeSPCcYXMZpdug=
X-Gm-Gg: ASbGncvZydZ8B+5YIObjuBm18R57ONd3GXjrlyhBEeDHCmxiasOsdhMlqprDj1IWLbR
 taUW/I9F5wufVHWX0H8Kno5ZUmOhfHVyIaqmtu9No/Ro4NMmh/ET7ESnliRYWDois+P+CeL77x1
 e6yo2aYZtGUVD0aX/xqg8jnkerViwnLgUablSb/jN6HCISbOG3+iTYAGZSQV0741kQheO0Zg/DR
 mMrro7yvyxdz6hzATuARQ932JIfqhskeZhUhtF7bNj+hzDELODp4Utu1YBlTrS7LDyG3kPUij8D
 gANIZGv94IWPdohvy31wCw==
X-Google-Smtp-Source: AGHT+IEQGOCriwIVpIpk8F9BDJebGWNAeLZvcmK2Mt1ymCqqabqehZuA2Y22ccmjnYIsnai7mwMkAw==
X-Received: by 2002:a05:6830:924:b0:71d:4ff0:f8ea with SMTP id
 46e09a7af769-71dad60d88dmr11178674a34.10.1733419815856; 
 Thu, 05 Dec 2024 09:30:15 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd15706655sm1386132a12.42.2024.12.05.09.30.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 09:30:15 -0800 (PST)
Message-ID: <997e809f-832c-4bbd-b27e-a722ac835b34@linaro.org>
Date: Thu, 5 Dec 2024 09:30:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 11/11] tests: add plugin asserting correctness of
 discon event's to_pc
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <cover.1733063076.git.neither@nut.email>
 <36d316bf3e8b0aca778c5e8d1acde39a7f361946.1733063076.git.neither@nut.email>
 <d4b17c7d-c1d2-4e43-8eee-d1667e3ee5a2@linaro.org>
 <0e4171ca0baa8727c0bbec7a25fd72d8b8e1e4b8@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <0e4171ca0baa8727c0bbec7a25fd72d8b8e1e4b8@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ot1-x333.google.com
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

On 12/5/24 05:10, Julian Ganz wrote:
> Hi Pierrick,
> 
> December 5, 2024 at 12:33 AM, "Pierrick Bouvier" wrote:
>> On 12/2/24 11:41, Julian Ganz wrote:
>>
>>>   +/*
>>>   + * Copyright (C) 2024, Julian Ganz <neither@nut.email>
>>>   + *
>>>   + * License: GNU GPL, version 2 or later.
>>>   + * See the COPYING file in the top-level directory.
>>>   + */
>>>
>> Would be nice to include a description of the plugin here.
> 
> Agreed. I'll include one next time.
> 
>> When booting an arm64 vm, I get this message:
>> Trap target PC mismatch
>> Expected: 23faf3a80
>> Encountered: 23faf3a84
>>
>>   From what I understand, it means that the next_pc we have is incorrect.
> 
> Yes, this is indeed incorrect, and also a perfect example why this test
> plugin exists. There are likely other errors lurking in target specific
> code. Did you happen to also log interrupts? Do you remember what image
> you used?

I used exactly this:

./build/qemu-system-aarch64 -plugin 
./build/tests/tcg/plugins/libdiscons.so -smp 4 -M virt -d plugin -m 8G 
-device virtio-blk-pci,drive=root -drive 
if=none,id=root,file=./debianaarch64.img -M virt -cpu max,pauth=off 
-drive if=pflash,readonly=on,file=/usr/share/AAVMF/AAVMF_CODE.fd -drive 
if=pflash,file=./AAVMF_VARS.fd

The arm64 image is a vanilla debian stable I installed.
AAVMF* files come from qemu-efi-aarch64 debian package.

> 
> Btw: this also illustrates another issue I have with from_pc: we can
> test the behavior for to_pc, but doing this meaningfully for from_pc
> via a plugin is next to impossible because the instruction it points to
> is not observable via an exec callback. At least not in the general
> case, even not if we only consider a single type of event.
>

We can store the next_expected pc for each instruction (from 
current_instruction + insn_length), and we should be able to compare 
that with the expected from_pc.
This is mostly what contrib/plugins/cflow.c does.

With that, we can test from_pc.

> Regards,
> Julian Ganz


