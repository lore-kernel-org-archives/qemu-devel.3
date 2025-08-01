Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC1DC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 20:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhwUa-0005HA-Fm; Fri, 01 Aug 2025 16:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhvFC-000668-IS
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 15:16:51 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhvF8-0007qc-Lz
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 15:16:42 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-76bc61152d8so2395001b3a.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 12:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754075795; x=1754680595; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xq1ej7/YWthBFV7xddpPiP7VDb1B04YixthFeexlhTY=;
 b=LFGIsDfmS0n5WAo+6e4+j/7PhrIip1JHpu6ktP8d6i9LnEOjnXcRO4aFjz/t+Q8GTX
 TuAN5qjLdclUWpzB2KFDjSM1vAbqPxgv3eNNMVqYVY0+SdiR45TnsRWnU2Ea0c4fyKvj
 qA8odpY3JE0VHkv5VQGHSwVblQD8SL4VfzPl9U54lXnPUz8g9IoPCrxVJv0DrHXhIf+s
 dVpxcToSjNbxa5l8APEvqBCX6W3YuGnPWYnMKWrD6IThZKLBzchi6JS1c5FU8CwV3lXR
 EZUaWRCGH8O2xo0Px4nH1LWhJVOGorahbPgNBVHAkoFJJdprkzlZNNwRuz5tS16+VZG6
 c6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754075795; x=1754680595;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xq1ej7/YWthBFV7xddpPiP7VDb1B04YixthFeexlhTY=;
 b=G4nJ4/GrZV9BCINbHSjuMsT36+nU/M6nCNfnQGuHTD4oQfejPYWXBBacOoeZO6WJx1
 Gq6jziAIK1UD6MuDU5bGIe+tAU7I1SOufe3Ngu4aG7KWjaGb0OEJVw5eMyigfJXSuich
 EUjB3giL5O7ONubHjq0w93jmFKTjtHYqvXqY86rG9gJd09KAcCQdT5i1XQBDoW88ciby
 WHpjUw+fkDJj429C0B0BDbfTKuD8itSKuG43QAVbWHcmJSDZ8keClcKHQroUM10qHBrq
 BvBxJDOjjg9XJ6owPfNRdqCK/oMRPMSxjPJ1YkfV3T7qFOd8TZJi9U/BOwMGVALQbevV
 CecQ==
X-Gm-Message-State: AOJu0YzZkyHrLWPofhgh2tobo03cqBfSrmPyssJkYvRLoqcYz+K4KDI4
 fham2Ct2lfJ/CH2k6T8YNuudBgFhMLmjQFrdHm64wQsISe97URmt69mu/LozmpWxFVA=
X-Gm-Gg: ASbGncuqGRqPJp/ocdZ+3GXcDkntq9hkB9fx4lMH24A6LCRvWSEdJQl62Zad9DJLncn
 FvDIH2R3HKzsg4ZHxbHI5K2Il+pvKCeq4Ud/VVH+fSbPf2vZ2QupirhIyahuEky1jCgrZkn+OsF
 ysWoCwfx0Hy3pFGlBiOr2sZoZrNtM34Rzi9xtmF32o3wu6NA5Vpa/6XDDNQ+i2nhiaOLwq6ARxJ
 3ZoYej/faRvRmoV1WMA609v7AAtZ8YaRBc6tdul1fyXoIn3wkrfqxW2JuTAY1U17BF/WYeNm/Sj
 zbsxw3rhdh5kU+rVE2y+v5BdfnbJqWhyNED+wz5iLYhi/w8pF1plBu/X3iJaCWFjgP+Dx3vxm9c
 X+H1CjcHiDBRWlVJ+VDqytwnP4TuFa+kxtDE=
X-Google-Smtp-Source: AGHT+IHPK+DrK58FOeCQBf5R8wPIqrj9qN+/IiaQz15L3fouJHOW9yKfbwCzto2sjnAi82kw5vl9Mw==
X-Received: by 2002:a05:6a20:1583:b0:23d:ac50:3342 with SMTP id
 adf61e73a8af0-23df90f9c39mr1363196637.38.1754075795398; 
 Fri, 01 Aug 2025 12:16:35 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b422b77f070sm4297781a12.12.2025.08.01.12.16.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 12:16:34 -0700 (PDT)
Message-ID: <d495bae3-d252-4b79-883a-3f5f815c5feb@linaro.org>
Date: Fri, 1 Aug 2025 12:16:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/9] WHPX support for Arm
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250731052753.93255-1-mohamed@unpredictable.fr>
 <8af5e691-da19-4141-8874-51ca685288ac@linaro.org>
 <864AC97D-2C45-402A-92AF-D0FDDB72C40E@unpredictable.fr>
 <21266cf2-887d-4bf3-8c9a-7633bffd8cd2@linaro.org>
 <17413DE3-C53B-4DA6-9777-3E772D2C2C2D@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <17413DE3-C53B-4DA6-9777-3E772D2C2C2D@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 8/1/25 11:52 AM, Mohamed Mediouni wrote:
> 
> 
>> On 1. Aug 2025, at 19:22, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>>
>> On 8/1/25 5:43 AM, Mohamed Mediouni wrote:
>>>> On 1. Aug 2025, at 03:15, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>>>>
>>>> Hi Mohamed,
>>>>
>>>> On 7/30/25 10:27 PM, Mohamed Mediouni wrote:
>>>>> This one took way longer for me to publish than I should have.
>>>>> There are a number of lingering bugs in this one including u-boot not working.
>>>>> Interrupt controller save/restore is entirely missing in this RFC, and some other state
>>>>> bits are likely still missing too.
>>>>> ITS not blocked by default yet, remember to use its=off when testing this series.
>>>>> You might also want the GICv3 + GICv2m support patch as part of the HVF vGIC patch series, which
>>>>> is not duplicated here.
>>>>> PS: on both this and HVF, interrupt controller initialisation needs to be done early so I ended
>>>>> up with hardcoded addresses. Wonder if the right way to go might be to defer virt and vCPU initialisation
>>>>> until late in the process post-gic_realize...
>>>>> Other than that, this boots both EDK2 and Linux in SMP, when using devicetree or ACPI.
>>>>
>>>> thanks for posting this, that's an exciting series!
>>>>
>>>> I applied it on top of your other series (20250728134114.77545-1-mohamed@unpredictable.fr) and solved the conflicts.
>>>> However, it would really help if you could push that exact branch somewhere, so people can easily pull it and try.
>>>> I'm fine if you want to duplicate gic patches in this series as well.
>>> Hello,
>>> My branches are at https://github.com/mediouni-m/qemu
>>>
>>
>> Thanks, it's worth adding it in cover letter for next versions.
>>
>>> whpx-v1 corresponding to this RFC, but latest rev of the whpx branch has some fixes
>>> Have some additional notes and binaries here too: https://github.com/mediouni-m/qemu/releases/tag/whpx-v1.1
>>> Thank you,
>>> -Mohamed
>>>> I tried to direct boot a kernel (6.15 defconfig) and ran into this error [1]:
>>>> $ ./build/qemu-system-aarch64.exe -M virt,its=off -cpu cortex-a76 -m 2G -nographic -accel whpx -kernel out/Image.gz out/host.ext4
>>> Syntax that I use is -M virt,accel=whpx,its=off -m 2048-cpu cortex-a72 -bios share/edk2-aarch64-code.fd.
>>> And on some kernel versions, you’ll also need irqchip.gicv3_nolpi=1.
>>>> Could you please share your exact command line?
>>>> Does it work with direct kernel boot also?
>>>>
>>>> Kind Regards,
>>>> Pierrick
>>>>
>>>> [1] Error when booting:
>>>> [    1.381525] Internal error: Oops: 0000000096000002 [#1]  SMP
>>>> [    1.458060] Modules linked in:
>>>> [    1.461172] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.15.0-00001-g7797e43a2520 #1 PREEMPT
>>>> [    1.470502] Hardware name: linux,dummy-virt (DT)
>>>> [    1.475102] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>> [    1.482023] pc : pci_generic_config_read+0x38/0xb8
>>>> [    1.486970] lr : pci_generic_config_read+0x24/0xb8
>>> I don’t think I saw this particular one before… which Windows version and hardware are you testing this on?
>>>
>>
>> I see the same error as before.
>>
>> I tried also binaries from https://github.com/mediouni-m/qemu/releases/tag/whpx-v1.1, when directly booting kernel, I still see the same pci issue with both binaries and my compiled whpx-v1.3.
>> When booting edk2 provided, I ran into this other error instead with both binaries [1].
>>
>> I'm running latest Windows 11 (stable channel, fully updated), on a microsoft volterra (devkit). It might be an issue specific to this platform.
>>
> I didn’t test anything on the stable branch for now but only on Canary so far.
> Just cursorily tested (EDK2 only) an X Elite device on prod (26100.4652) and this issue doesn’t appear.
> 
> I have 8cx Gen 3 and 8cx Gen 1 (SQ1) devices around, will test on those older SoCs later and see.
> 
> Random idea for testing: what if you put -M highmem=off, does that change anything?
>

Good guess, it solves the problem with edk2, and direct boots linux 
kernel successfully now.

> Thanks,
> -Mohamed
> 
>> In case you're interested, we can arrange an access to the machine, but I understand if it's not your priority now.
>>
>> [1]
>> Windows Hypervisor Platform accelerator is operational
>> UEFI firmware (version edk2-stable202408-prebuilt.qemu.org built at 16:28:50 on Sep 12 2024)
>> ArmTrngLib could not be correctly initialized.
>> Error: Image at 000BFDB6000 start failed: 00000001
>> Error: Image at 000BFD6D000 start failed: Not Found
>> MapGcdMmioSpace: failed to add GCD memory space for region [0x4010000000+0x10000000)
>> ASSERT_EFI_ERROR (Status = Unsupported)
>> ASSERT [PciHostBridgeDxe] /home/kraxel/projects/qemu/roms/edk2/OvmfPkg/Fdt/FdtPciHostBridgeLib/FdtPciHostBridgeLib.c(326): !(((INTN)(RETURN_STATUS)(Status)) < 0)
>>
>>> (Message was sent from the wrong email alias on mobile, resending)
>>> Thank you,
>>> -Mohamed
>>
>> Thanks,
>> Pierrick
> 


