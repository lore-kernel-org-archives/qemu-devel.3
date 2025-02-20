Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D175C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 22:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlF2g-0005Y0-Gd; Thu, 20 Feb 2025 17:29:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlF2b-0005XZ-7G
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 17:29:11 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tlF2Z-0005KN-AA
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 17:29:08 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-439ac3216dcso5664385e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 14:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740090543; x=1740695343; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N/7rqyRjk2jq5+8gYrc7ktRzu/nUFo5bffB0tKFoM7Q=;
 b=nQYL9Eztr6oYgPy0GDJu1F2v1Pwpjh7lIU2QMw/0RGhZjgm6DggwPtp+IW3owP+5oQ
 pEmwsdaYNTj04gZMqanu8eKi+q1j9bWoQCbM696KWJS9ZkXUWFle/6iVnmFQZMTZSvLW
 7yMZjso0eZuVx9kNSOpTs70b4baRmkQ/ienDc4bpHHbXB5JL6f498NtVOMaFXcW7QkFF
 FMheqVw5o7lUCebsQdbU35UlHBQZx8RcRZfOXbjs9Cw0XHMAQM9NMk9qRDden2OsQ+cu
 MXLlSK1Kp4OTyWY6vjeAAok3J8dW1jOxjIGr25KFpaExczD+T1JhIKWqLMU5dTy3vLU/
 lpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740090543; x=1740695343;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N/7rqyRjk2jq5+8gYrc7ktRzu/nUFo5bffB0tKFoM7Q=;
 b=JpuyjT5ZKxOOqQTxzyiUFPsEqVuB+itV8UKjpVoB6EoxEeqxG/6EiVMs5N6oIO8M/u
 qdzhaAs8QjXh8LJ1b2nmGm8JUeClpNH2U5ji2VNQ3fVjyybPaKLzc7DErcNjwS2D6fTN
 0l8qQxhaMPhVq3T3dnBZTHlwc4Jv9rMIZ4KWapKHeuvv8PhdoL9pBNTKxS1e3LCV9TM0
 3G718DbfurgZfssKTl0cgNbIC1xQESrEnQy+ipXPevl0/eNtiwYc2fQ7i+fT90KQvcpd
 1o3Z3k9Y6ERzIoLLPDcstB3Cc8rX/tVMirPq0id1ezxSPrHZBLLWn2CQbmtwQcfERAdN
 HTqQ==
X-Gm-Message-State: AOJu0YyudMNKFXic0+IBH3vAvDoElQGT21rLpgPsXSbL8vAp8BmcAXXN
 OOCaIpWXX9Q2KXahd99nMLsXzoA7Dpz3iEq58iyKa04ZrglwGWiMA+E71KFXXXc=
X-Gm-Gg: ASbGncslMCP0zVoCS50jAH9DzfQbfeqnkhtPd0pUTOL3JdNNb7qh8bXAzYSNQfTPyhd
 MW6ZxaT3Apl4qdp/csMqNUMx4RdhR0vVclJLNkBg203A4fthm1xAG2n2UJqkcaMT7n7B6yE+AXK
 7+kwdaI2QU86KOgyy4dwc1OuwJ5ElzjteSKiPRWLIC47WgB91yQYv5SZgU02HItpdkGcEmHcHGb
 ycEzcGKYzx79ImPCLUuFcietw+vSfl+adRSqoG/vX8hJM11e+JveyVxt0slkjjcTufzn3fpguAG
 6nt5Rzwa/jIOnEhSVILVhvrYB2GopKGjhQl2TePVPR4T7g0DWkn8ySmJZ6I=
X-Google-Smtp-Source: AGHT+IFHur79MHodt2fHRD4QAVOlAQO0M3XCLOXhCit1yE2o1YrzOczcxvLsJYGvnRYze11ZPBsrRA==
X-Received: by 2002:a05:600c:3b94:b0:439:8653:20bb with SMTP id
 5b1f17b1804b1-439aeb2b6afmr4032185e9.14.1740090543491; 
 Thu, 20 Feb 2025 14:29:03 -0800 (PST)
Received: from [192.168.69.157] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43995391824sm87349315e9.23.2025.02.20.14.29.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 14:29:03 -0800 (PST)
Message-ID: <ade78f31-5279-4862-acdd-15f083a000e2@linaro.org>
Date: Thu, 20 Feb 2025 23:29:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Improve Microchip Polarfire SoC customization
To: Conor Dooley <conor@kernel.org>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, Conor Dooley <conor.dooley@microchip.com>,
 Bin Meng <bin.meng@windriver.com>, alistair.francis@wdc.com,
 qemu-riscv@nongnu.org
References: <20250214062443.9936-1-sebastian.huber@embedded-brains.de>
 <20250220-reggae-hardness-907e385516d8@spud>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250220-reggae-hardness-907e385516d8@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Hi Conor,

On 20/2/25 19:30, Conor Dooley wrote:
> +cc qemu-riscv, Alistar.
> 
> On Fri, Feb 14, 2025 at 07:24:37AM +0100, Sebastian Huber wrote:
>> Booting the microchip-icicle-kit machine using the latest PolarFire SoC
>> Hart Software Services (HSS) no longer works since Qemu lacks support
>> for several registers (clocks, DRAM controller). Also reading from the
>> SDCard does not work currently.
> 
> On that note, I think the inaccurate docs about polarfire should be
> removed. There's a wiki page here with dead links, or links to things
> that do not work anymore:
> https://wiki.qemu.org/Documentation/Platforms/RISCV#Microchip_PolarFire_SoC_Icicle_Kit
> I think the whole section should be removed, find it kinda odd that
> there's a polarfire section but not for any other board. Either way,
> it's talking about something that just does not work, the current HSS
> and Yocto don't boot.
> 
> There's also a docs page here:
> https://www.qemu.org/docs/master/system/riscv/microchip-icicle-kit.html
> that has a copy of the table your patch 4 modifies, that probably should
> be updated to match your changes.
> 
> In a similar vein to the wiki, it talks about the HSS and booting a
> yocto wic image. I think those should be deleted since they don't work.
> 
> Alistar/Other RISC-V folks, what do you think? Bin wrote the port but
> seems to be AFK and I don't have the capacity to fix any of that stuff
> on top of what I already do in my spare time - do you agree that
> deleting the now inaccurate docs makes sense?
> 
>> In order to allow tests runs for real-time kernels such as RTEMS and
>> Zephyr, improve the boot customization. This patch set enables a direct
>> run of kernel executables, for example:
>>
>> qemu-system-riscv64 -no-reboot -nographic \
>>    -serial null -serial mon:stdio \
>>    -smp 2 \
>>    -bios none \
>>    -machine microchip-icicle-kit,clint-timebase-frequency=10000000 \
>>    -kernel rtos.elf
> 
> The series breaks my usage:
> qemu//build/qemu-system-riscv64 -M microchip-icicle-kit \
>          -m 3G -smp 5 \
>          -kernel vmlinux.bin \
>          -dtb riscvpc.dtb \
>          -initrd initramfs.cpio.gz \
>          -display none -serial null \
>          -serial mon:stdio \
>          -D qemu.log -d unimp
> opensbi-riscv64-generic-fw_dynamic.bin: No such file or directory
> qemu-system-riscv64: could not load firmware 'opensbi-riscv64-generic-fw_dynamic.bin'
> make: *** [Makefile:305: qemu-icicle] Error 1
> 
> Figure it is likely to be your patch 4? The file does exist, so probably
> some sort of path-to-it issues?

Maybe missing the -L option?

   -L path         set the directory for the BIOS, VGA BIOS and keymaps

Regards,

Phil.

