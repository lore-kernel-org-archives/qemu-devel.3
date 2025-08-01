Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CEE3C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 18:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhuwZ-0002AJ-6i; Fri, 01 Aug 2025 14:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhtSg-00054W-3Y
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:22:30 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhtSd-0002Xh-Po
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:22:29 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-76bdc73f363so1041120b3a.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754068946; x=1754673746; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hhz1ir387zaXp4wYTmvYDzcLzl24HNBFB0BgqBS0f7Q=;
 b=xmf8fPdlZZUh4Q3dJgQEWcatSNlcLc0e8cpUe43Yi6Lsi+XOhzMziiRySdwhVWamnd
 qcx9uEZfsAgHOXwd/+F+LvSG4UkWXiBDkhf0CVS1ODBnVMcopUCoYRsxKWIVL5m8NVDV
 VNey5S6QgWtN34GodMZK6Af7Yyav1kRoTZDQIUGta+B0y8Criv+cBrfUSttvn8bCCQyq
 TLG2gDutmE9utFcNPtoDKh37gsySD6Z6cGG8S6JMVLlt5HeRoX09facAga1cl5ELWcKB
 LCIKZZHAlJvRuszhiKRJK1shg9FUgyXw6WYUnPFnQcHrL5fi7ym7b4En4JLUweolPgIE
 aJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754068946; x=1754673746;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hhz1ir387zaXp4wYTmvYDzcLzl24HNBFB0BgqBS0f7Q=;
 b=V3/73aMmOhKArTItqEAmOq1sMJEoz3s69PAMeQFa4x2s4cfDIE3JLtU5cWDQTwSxd/
 Siz2MfI/3LKBPxzdm8nOw9ZKlRRdkaN4xhLOki7P2OJqsJ99wzU92ekgk/Mkx4H3fq99
 aHB6aLy4cKQ33gfGWCa1eqmxamS1uWWPKiHczY9XS0pPVJZqiA0nmBOfliT2Se2IGcDb
 XXNHmJ4d6WAeNjnHpAOuqqknZlkee2XwYyeQiHbl/CC+Nh8AXwU0XxIAC9eRIIhS1zus
 hSGSSslcMiY06rRnpE4NZ0llK0LafhIHwKnfxNs1RevWmM/4ba6yiiNKRxjTK1oqDxsl
 iTvQ==
X-Gm-Message-State: AOJu0YxdxvktLqsiaQuwLlEDGN14eiXkUUtHvN8Hqe0sboOn5PQINpLW
 V5DMh6tenfc6wcRUFXLiM/L5Acy4n3GjPgx1RlJIrzgZ15pimagAzWTI00VFaBoAiKo=
X-Gm-Gg: ASbGnctRpRorIS16Eaztjecas92zt53mSGePSJlWr8ZvD0ZugWoRtEmRZfybEXGHyG4
 FXR3WyA6LIaW78fywNyG+GVeGZl9weraTV8NsycoxkRnf0k2wNrWvWba0YmFjvwQTcm/vnjFT3L
 iwlRVq3bAytFtftNbbmP+J9BWRFzeYsjAOrSoa8mDaHTBo3MStr+/PITgCr2R+JYnPnzjvZYPhn
 tpyEJ4BUISiszF+5tmni9P/JoKVH/ZT7LYXMbpReuHfr70hao9GUBplnaY9Jwl3lUetBGx9Acps
 T5139BobX/bxvDCsOgBa7/hJg4ZGmgwmeh4SPK3IGs0Rcb0Lg6Avjn5tetC6X6oxi88Ixnznzxh
 L2PDS/BnUjHaorzA50BswmAXnAb5jE7T/WVk=
X-Google-Smtp-Source: AGHT+IEuYAbZD8EOvKtz/bEpuBMk5VIdcCM3Jq0QzjZ7csKC/Tb6dqr52ehaJROJlrCKx6Fb21dvwQ==
X-Received: by 2002:a05:6a20:12d5:b0:232:a762:def with SMTP id
 adf61e73a8af0-23df90cdfc5mr665872637.30.1754068945943; 
 Fri, 01 Aug 2025 10:22:25 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b422bafcce2sm4133420a12.52.2025.08.01.10.22.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 10:22:25 -0700 (PDT)
Message-ID: <21266cf2-887d-4bf3-8c9a-7633bffd8cd2@linaro.org>
Date: Fri, 1 Aug 2025 10:22:25 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <864AC97D-2C45-402A-92AF-D0FDDB72C40E@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 8/1/25 5:43 AM, Mohamed Mediouni wrote:
> 
> 
>> On 1. Aug 2025, at 03:15, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>>
>> Hi Mohamed,
>>
>> On 7/30/25 10:27 PM, Mohamed Mediouni wrote:
>>> This one took way longer for me to publish than I should have.
>>> There are a number of lingering bugs in this one including u-boot not working.
>>> Interrupt controller save/restore is entirely missing in this RFC, and some other state
>>> bits are likely still missing too.
>>> ITS not blocked by default yet, remember to use its=off when testing this series.
>>> You might also want the GICv3 + GICv2m support patch as part of the HVF vGIC patch series, which
>>> is not duplicated here.
>>> PS: on both this and HVF, interrupt controller initialisation needs to be done early so I ended
>>> up with hardcoded addresses. Wonder if the right way to go might be to defer virt and vCPU initialisation
>>> until late in the process post-gic_realize...
>>> Other than that, this boots both EDK2 and Linux in SMP, when using devicetree or ACPI.
>>
>> thanks for posting this, that's an exciting series!
>>
>> I applied it on top of your other series (20250728134114.77545-1-mohamed@unpredictable.fr) and solved the conflicts.
>> However, it would really help if you could push that exact branch somewhere, so people can easily pull it and try.
>> I'm fine if you want to duplicate gic patches in this series as well.
> Hello,
> 
> My branches are at https://github.com/mediouni-m/qemu
>

Thanks, it's worth adding it in cover letter for next versions.

> whpx-v1 corresponding to this RFC, but latest rev of the whpx branch has some fixes
> 
> Have some additional notes and binaries here too: https://github.com/mediouni-m/qemu/releases/tag/whpx-v1.1
> 
> Thank you,
> -Mohamed
> 
>> I tried to direct boot a kernel (6.15 defconfig) and ran into this error [1]:
>> $ ./build/qemu-system-aarch64.exe -M virt,its=off -cpu cortex-a76 -m 2G -nographic -accel whpx -kernel out/Image.gz out/host.ext4
> 
> Syntax that I use is -M virt,accel=whpx,its=off -m 2048-cpu cortex-a72 -bios share/edk2-aarch64-code.fd.
> 
> And on some kernel versions, you’ll also need irqchip.gicv3_nolpi=1.
> 
>> Could you please share your exact command line?
>> Does it work with direct kernel boot also?
>>
>> Kind Regards,
>> Pierrick
>>
>> [1] Error when booting:
>> [    1.381525] Internal error: Oops: 0000000096000002 [#1]  SMP
>> [    1.458060] Modules linked in:
>> [    1.461172] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.15.0-00001-g7797e43a2520 #1 PREEMPT
>> [    1.470502] Hardware name: linux,dummy-virt (DT)
>> [    1.475102] pstate: 204000c5 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [    1.482023] pc : pci_generic_config_read+0x38/0xb8
>> [    1.486970] lr : pci_generic_config_read+0x24/0xb8
> I don’t think I saw this particular one before… which Windows version and hardware are you testing this on?
>

I see the same error as before.

I tried also binaries from 
https://github.com/mediouni-m/qemu/releases/tag/whpx-v1.1, when directly 
booting kernel, I still see the same pci issue with both binaries and my 
compiled whpx-v1.3.
When booting edk2 provided, I ran into this other error instead with 
both binaries [1].

I'm running latest Windows 11 (stable channel, fully updated), on a 
microsoft volterra (devkit). It might be an issue specific to this platform.

In case you're interested, we can arrange an access to the machine, but 
I understand if it's not your priority now.

[1]
Windows Hypervisor Platform accelerator is operational
UEFI firmware (version edk2-stable202408-prebuilt.qemu.org built at 
16:28:50 on Sep 12 2024)
ArmTrngLib could not be correctly initialized.
Error: Image at 000BFDB6000 start failed: 00000001
Error: Image at 000BFD6D000 start failed: Not Found
MapGcdMmioSpace: failed to add GCD memory space for region 
[0x4010000000+0x10000000)
ASSERT_EFI_ERROR (Status = Unsupported)
ASSERT [PciHostBridgeDxe] 
/home/kraxel/projects/qemu/roms/edk2/OvmfPkg/Fdt/FdtPciHostBridgeLib/FdtPciHostBridgeLib.c(326): 
!(((INTN)(RETURN_STATUS)(Status)) < 0)

> (Message was sent from the wrong email alias on mobile, resending)
> Thank you,
> -Mohamed
> 

Thanks,
Pierrick

