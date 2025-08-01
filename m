Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D83C87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 01:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhehp-0006GP-Nx; Thu, 31 Jul 2025 21:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uheMz-0000cv-Dq
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 21:15:38 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uheMv-0004XB-4Q
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 21:15:37 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-769a21bd4d5so1053852b3a.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 18:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754010929; x=1754615729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dh04ml9rlrb9ljaYwQCAx0luLtw8VFRFFkhR8CbzSaA=;
 b=jVfBIhciDcCqyyUCdrp0znIKzCtHdYj8GqmidQsSfZlcLY+5w+Vw39+vJX8bD5Hi/k
 Ab4R7kBtA7iAHlF8NMJ284QPm1Nk6h2eV4BPpMz9T89gjpYvy/1aHH9zQUlJcsfheb1C
 lquSxDi6AobeWcM1pvCeySKCFqmFlHWRJ9tzz01LaI9QHoM1+EEknyA1zxkF6U8QQ4Tz
 KPUog0Tnuzz4ZVo4y8d93jI0YCHoZ8sU+P19CyPNMbcjFDPJfII9SegZaq0kKn+niOL5
 l1K7lLqVNZ18TvV+U6RK2I+8dY793PF0XBSNMFRA+bJCM2O4Tr6t2qiOVvmTSsbb8jvM
 DulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754010929; x=1754615729;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dh04ml9rlrb9ljaYwQCAx0luLtw8VFRFFkhR8CbzSaA=;
 b=mQOxdWXN97591S8M+9LpGTI0zU5JWAeS7ABxYlmqoASvTtyqo2y6RdCyvgy7zjGDf0
 0sFubmDiK+mJOLb+YCQsF//jgXo/l18OUAukgsLmKGkVuRzzTfxG5/XiYVn2pnEGMITH
 9HJ0dfxUZPur1uUip9Xxav0Fb1eyy6q2y0wEX/LuWgioFGkbjg/H74HlekLSGa59TfQh
 hnLe+nRx/IhXj6gBX9K9sRAQ3MxBuUrzALwmJqgfBH/cMMmtyuWdTZBcqfREFivhYmTs
 0qbmIaFIT9BppOGAziOVLKNCexZ3zSODwUjc8tl8p1YPZQ1FkH0d5MvzwvH5vhjLuVdU
 GFsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHX8cTwXiRf3TRAxNMoC4dcIZOW0D+dWJrhmWXcBOIZtZEusBg5T+efKCQ7A5gTwnrS+NM9ZAJ8EH2@nongnu.org
X-Gm-Message-State: AOJu0YxasB0U8yGi4WoetrzCSziPapD0H2ly8zNj23vqDwDPMf/j/CC2
 KiR3zddOwTqXhw3LI/o18MmX35732zD4WsoHTucFq7XzhYEuC1ba6N4o6DKN/rvEGH0=
X-Gm-Gg: ASbGncvoKmPaMQiy/GxXyaIG7fN4OueoaKGHJlhhKicoHIqoJCj7v8Gu7oCLdw2yJ4T
 h9O4XJEMZMnZDCVCreUii7KVrwjlynO61CJ9OsxgdXhN/Wibh2UvSvHnA4JhJ5GsZlVGMAwm/N4
 Ih9w8wsfyu+U9d5XH3OOK7ya2tv39rbB1dslsntZ9ssMEHLJ3NJJqwFzE/r2jmHisikYg25X0Ae
 wDIw7EcAaf1MWqgnYhBKaoiZY4ScSStuVnHxWjMhXC1x/rECbPNk1Ff27Hu1Fcc1pDFr/T3d2zc
 6m2bfZyPm8WFoGGlA8UZES0Mp7Ddjr1S+1srgDW6q8ci9ep7vZ7CustlkYDMhMOoOGYcJpjvC5M
 PDwbkN4s6mjGO1gOIYzAernR6pH49+5g/t+QoP8OOkfkE4g==
X-Google-Smtp-Source: AGHT+IFBXpHhrIgSeI/1Ay/Q1R13VFRqiM34av93T3lmZ+mfQjL+m4mfyYOoX0TXUusLdsLuYYZgzQ==
X-Received: by 2002:a05:6a20:431a:b0:220:af86:7e01 with SMTP id
 adf61e73a8af0-23dc0ed6b8emr16076923637.29.1754010929239; 
 Thu, 31 Jul 2025 18:15:29 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfcf5f7sm2717118b3a.88.2025.07.31.18.15.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 18:15:28 -0700 (PDT)
Message-ID: <8af5e691-da19-4141-8874-51ca685288ac@linaro.org>
Date: Thu, 31 Jul 2025 18:15:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/9] WHPX support for Arm
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250731052753.93255-1-mohamed@unpredictable.fr>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250731052753.93255-1-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

Hi Mohamed,

On 7/30/25 10:27 PM, Mohamed Mediouni wrote:
> This one took way longer for me to publish than I should have.
> 
> There are a number of lingering bugs in this one including u-boot not working.
> 
> Interrupt controller save/restore is entirely missing in this RFC, and some other state
> bits are likely still missing too.
> 
> ITS not blocked by default yet, remember to use its=off when testing this series.
> You might also want the GICv3 + GICv2m support patch as part of the HVF vGIC patch series, which
> is not duplicated here.
> 
> PS: on both this and HVF, interrupt controller initialisation needs to be done early so I ended
> up with hardcoded addresses. Wonder if the right way to go might be to defer virt and vCPU initialisation
> until late in the process post-gic_realize...
> 
> Other than that, this boots both EDK2 and Linux in SMP, when using devicetree or ACPI.
> 

thanks for posting this, that's an exciting series!

I applied it on top of your other series 
(20250728134114.77545-1-mohamed@unpredictable.fr) and solved the conflicts.
However, it would really help if you could push that exact branch 
somewhere, so people can easily pull it and try.
I'm fine if you want to duplicate gic patches in this series as well.

I tried to direct boot a kernel (6.15 defconfig) and ran into this error 
[1]:
$ ./build/qemu-system-aarch64.exe -M virt,its=off -cpu cortex-a76 -m 2G 
-nographic -accel whpx -kernel out/Image.gz out/host.ext4

Could you please share your exact command line?
Does it work with direct kernel boot also?

Kind Regards,
Pierrick

[1] Error when booting:
[    1.381525] Internal error: Oops: 0000000096000002 [#1]  SMP
[    1.458060] Modules linked in:
[    1.461172] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 
6.15.0-00001-g7797e43a2520 #1 PREEMPT
[    1.470502] Hardware name: linux,dummy-virt (DT)
[    1.475102] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS 
BTYPE=--)
[    1.482023] pc : pci_generic_config_read+0x38/0xb8
[    1.486970] lr : pci_generic_config_read+0x24/0xb8
[    1.491734] sp : ffff80008000b940
[    1.495079] x29: ffff80008000b940 x28: 0000000000000000 x27: 
ffffbb8fe13f00ec
[    1.502473] x26: ffffbb8fe14f9060 x25: ffffbb8fe14f9078 x24: 
ffffbb8fe1c99990
[    1.509564] x23: 0000000000000000 x22: ffff80008000b9f4 x21: 
ffff574c83b7c000
[    1.516636] x20: ffff80008000b964 x19: 0000000000000004 x18: 
0000000000000006
[    1.523722] x17: 6666666666666666 x16: 6678302d30303030 x15: 
0720072007200720
[    1.531583] x14: 0720072007200720 x13: 0720072007200720 x12: 
ffffbb8fe1736838
[    1.539094] x11: 0000000000000058 x10: 0000000000000018 x9 : 
ffffbb8fe1736838
[    1.546212] x8 : 00000000000000c5 x7 : ffffbb8fe187ff40 x6 : 
00000000000000ff
[    1.553370] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 
ffff800090000000
[    1.560676] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 
ffff800090000000
[    1.567890] Call trace:
[    1.570509]  pci_generic_config_read+0x38/0xb8 (P)
[    1.575362]  pci_bus_read_config_dword+0x80/0xe4
[    1.580231]  pci_bus_generic_read_dev_vendor_id+0x30/0x164
[    1.586164]  pci_scan_single_device+0x118/0x18c
[    1.590912]  pci_scan_slot+0x58/0x214
[    1.594782]  pci_scan_child_bus_extend+0x40/0x234
[    1.599606]  pci_scan_root_bus_bridge+0x64/0xd8
[    1.604194]  pci_host_probe+0x30/0xec
[    1.607972]  pci_host_common_probe+0x128/0x1c0
[    1.612430]  platform_probe+0x68/0xdc
[    1.616220]  really_probe+0xbc/0x2c0
[    1.619814]  __driver_probe_device+0x78/0x120
[    1.624435]  driver_probe_device+0x3c/0x154
[    1.628620]  __driver_attach+0x90/0x1a0
[    1.632509]  bus_for_each_dev+0x7c/0xdc
[    1.636449]  driver_attach+0x24/0x30
[    1.640067]  bus_add_driver+0xe4/0x208
[    1.643774]  driver_register+0x68/0x130
[    1.647667]  __platform_driver_register+0x24/0x30
[    1.652704]  gen_pci_driver_init+0x1c/0x28
[    1.657181]  do_one_initcall+0x60/0x1d4
[    1.661172]  kernel_init_freeable+0x210/0x274
[    1.665749]  kernel_init+0x20/0x140
[    1.669341]  ret_from_fork+0x10/0x20
[    1.673034] Code: 7100067f 540002c0 71000a7f 54000180 (b9400000)

