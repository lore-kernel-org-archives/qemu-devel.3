Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2650F3D332
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBsO-0002Sw-8z; Thu, 05 Mar 2026 11:48:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyBsM-0002Sc-45
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:48:38 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vyBsJ-0001eC-Qb
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:48:37 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso75376555e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 08:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772729312; x=1773334112; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OiOTV/AO7GsPyd2nhvUEiE9+55PqnE/0NjxiC2SkIt0=;
 b=F8qzbWLZ5rWZw2lsmGZyW6bHt23aqVYev5qBBm0hm0XPwQQV0dIyNXotM72mlJlI1q
 JMKCcSphQyMSkRRmsonFg56e7f/ZDNfFF7gT+9biuFOnUfj8PEylpKUxLgdaMFob0AT/
 vnQ3x1yfZz8yMO8iGTLWsoXvsieS0s4l9xlf/DHq8i4DRbvsjdC/p+VKXBviydadQAwn
 KZleA+nGDY3Bp19OtZK5R/FSx3RNRlQrvlDEaeLI+J8/tYr3bdZvgt69J73m/Zt760zt
 urXPgYaL/oGqpcdvX42YFk/sSiMJsXMvOjLEwd+2tCRDYqdiCJ6ivPX05PowM84oI5ps
 A/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772729312; x=1773334112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OiOTV/AO7GsPyd2nhvUEiE9+55PqnE/0NjxiC2SkIt0=;
 b=blMmj9WH6GjP769JpwPHnrz40jQO9Z+0EiCfc7SS2GpLs//xEVd9j58yJObALCddA7
 NqhCgGTdBb1sI1XoU2UCJlIozNfJG9ZH7KNyNb8X91zSE/hIchjlvAQ5OD4wMvGexYQ3
 mU0LdVFPHb8syzxPq+ZY/h7ktf63RwvarpSEEJtbnSu7uCYggdzbsgUTF4pOQfO+CWWr
 VqiLv399mku8ler8es2DV3P85FUk6/IRpppFlHxsylXFwAfjXlmbdGG/oX1jT4nxkKAR
 BOI212WPAx0s2dPQhtE11qaHB7k9xYiZ8aMTjnd9RPJ3Fmo47UfOwiCPt1BwIuzyCflP
 IpiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv/IFtalO6C+gXSI8Kr66R8cya1gRUrawOXr8tuEdiRCwBRjqZH4Z+SLLAGQoIAeboWtdMjhKEPuLk@nongnu.org
X-Gm-Message-State: AOJu0YynV88YUwWEI40tSun6NUYxDVRu9BfVVcUqWAEI6ctBLYc5Fe5g
 NiHLlqJlTWJRynrurNIiVJSP79MYuIcnkHF42ZOrczWMCDBnEhp/QddVpjclpL83ajA=
X-Gm-Gg: ATEYQzyKD8NfCeOaxwHdzmBnrFEFHGrm6oucjFtrM75vJHNBpZVF7c6lCrG5d/F0AZy
 mSxA4+r0G+DuzZ1dJw5kKCHJNIQKA1B8deV8qr4uUQrIl4wW77+Zs2d9LLFiSG6ALa1H3F8DxX7
 CGO9Y3BTF+fxUGHfShPJmq50CKJr/8hqWwUMEE6aHJMBfk/dPp4BJ2M1vf/dxgk07iHgh5aGv1S
 Mdi0E+/EEuXINUyiNn8AgPfnDVPh1A3EFAuRGujTkk+tRWZyPkkhIuvcbjscuQIDu54PfHexviZ
 uM4co8WEGvAjB5FRwO+CvSGDmRxkczfmSh5r/XyHaFqs9mkEvlurv6BQbSWvXlFhn7RpXegNdCQ
 6FojsfnAvs3uM7qIw4zk4ULP4oL6AOhhh4891o/qdJYMAjXGFiXpPuq8Zby4oaor30AzGuyyZOM
 elQPvSEkUzZ4NCv6w8EhpqjUPl09ZpHSH9xxz31iwASjHxH4GLRMOM4sqgyjqQIafbmw==
X-Received: by 2002:a05:600c:c173:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-4851983b3dfmr112191445e9.3.1772729311993; 
 Thu, 05 Mar 2026 08:48:31 -0800 (PST)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851faf3938sm50505985e9.13.2026.03.05.08.48.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 08:48:31 -0800 (PST)
Message-ID: <1a23f69f-fba4-4f7c-9679-d06ad65be1d0@linaro.org>
Date: Thu, 5 Mar 2026 17:48:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/12] HVF: Add support for platform vGIC and nested
 virtualisation
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Paolo Bonzini
 <pbonzini@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>
References: <20260228220837.35275-1-mohamed@unpredictable.fr>
 <0BFFD4B5-6B69-4F75-B329-5C429E65532C@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0BFFD4B5-6B69-4F75-B329-5C429E65532C@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 1/3/26 02:34, Mohamed Mediouni wrote:
> 
>> On 28. Feb 2026, at 23:08, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>>
>> Link to branch: https://github.com/mediouni-m/qemu hvf-irqchip-and-nested
>> (tag for this submission: hvf-irqchip-and-nested-v11)
>>
>> This series adds supports for nested virtualisation when using HVF on arm64 Macs.
>>
>> Reviews would be very welcome :-) It's maybe a bit unlikely that this will make
>> it to QEMU 11.0 I might as well try.
>>
> 
> The patches remaining for review:
> 
> 1, 2, 3, 4, 5, 8, 10, 12

Cc'ing Manos who recently worked on SME2 in this area,
hopefully he has some review time available.

> 
>> It has two parts:
>> - Apple vGICv3 support and necessary infrastructure changes for it
>> - Nested virtualisation support. Note that the nested virtualisation implementation
>> shipping as of macOS 26.3 is nVHE only (but it _does_ use VNCR as shipped).
>>
>> This series doesn't contain EL2 physical timer emulation, which is
>> needed if not leveraging the Apple vGIC. As such, nested virt requires kernel-irqchip=on.
>>
>> Known issues:
>> - when nested virt is enabled, no UI response within EDK2
>> and a permanent wait. Workaround: -boot menu=on,splash-time=0.
>>
> 
> For reference this is a platform bug pending resolution an OS update.
> Would it be good to add a specific warning about it? (In a separate commit)
> 
>> Apple Feedback Assistant item: FB21649319
>>
>> When the VM is running at EL2 at the very moment the virtual timer fires:
>> HV_EXIT_REASON_VTIMER_ACTIVATED doesn’t fire (when not using the provided vGIC)
>> - using a GICv2 doesn’t require having transition notifiers which Hypervisor.framework doesn’t have…)
>>
>> and when using the provided vGIC, the interrupt never gets delivered back to the guest
>>
>> Linux as a guest OS is fine with this… but the reference ArmVirtQemu edk2 build always uses the virtual timer even when running EFI at EL2, so it gets broken unless this patch is applied to edk2:
>>
>> diff of ArmVirtPkg/ArmVirt.dsc.inc:
>>
>> -  ArmGenericTimerCounterLib|ArmPkg/Library/ArmGenericTimerVirtCounterLib/ArmGenericTimerVirtCounterLib.inf
>> +  ArmGenericTimerCounterLib|ArmPkg/Library/ArmGenericTimerPhyCounterLib/ArmGenericTimerPhyCounterLib.inf^M
>>
>> Changelog:
>>
>> v1->v2:
>> Oops. I did a mistake when preparing my patches.
>>
>> - Add hvf_arm_el2_enable(_) call to virt_set_virt
>> - Fix nested virt support check to add HVF
>>
>> v2->v3:
>> - LORC_EL1 patch was merged separately, remove from this series.
>> - fix LPIs when kernel-irqchip disabled and using TCG
>> - remove spurious if case in vGIC supported version detection (inapplicable now)
>> - Add hvf_enabled() check in combination with hvf kernel-irqchip checks
>> - cleanly fail on attempt to use the platform vGIC together with ITS
>>
>> v3->v4:
>> - GIC state save improvements, including saving the opaque Apple-specific state
>> - Saving HVF system register state when using the vGIC and/or EL2
>>
>> v5:
>> - oops, fixed up save/restore to be functional
>> - misc changes otherwise
>>
>> v6:
>> - Addressing review comments
>>
>> v7:
>> - Address review comments, adapt around Qemu changes and bugfixes.
>>
>> v8:
>> - Rebase, and misc fixes
>>
>> v9:
>> - Misc fixes from WHPX review comments
>> - Split enablement commit for EL2 into its own separate commit
>>
>> v10:
>>
>> - A bit of changes across the board
>> - move HVF irqchip save/restore into irqchip code
>> - block nested virt support when kernel-irqchip=off with a GICv2 as
>> we don't implement an emulated physical timer yet.
>>
>> v11:
>> - fixups for the save/restore Apple GIC state patch
>> - block the same registers as the revert in 28b0ed32b32c7e5094cf2f1ec9c0645c65fad2aa
>> for "hvf: sync registers used at EL2"
>> - drop patch that warns instead of aborts on mismatch
>>
>> Mohamed Mediouni (12):
>>   hw/intc: Add hvf vGIC interrupt controller support
>>   hw/intc: arm_gicv3_hvf: save/restore Apple GIC state
>>   accel, hw/arm, include/system/hvf: infrastructure changes for HVF vGIC
>>   target/arm: hvf: instantiate GIC early
>>   hw/arm, target/arm: nested virtualisation on HVF
>>   hvf: only call hvf_sync_vtimer() when running without the platform
>>     vGIC
>>   hvf: gate ARM_FEATURE_PMU register emulation behind not being at EL2
>>   hvf: arm: allow exposing minimal PMU when running with nested virt on
>>   target/arm: hvf: add asserts for code paths not leveraged when using
>>     the vGIC
>>   hvf: sync registers used at EL2
>>   target/arm: hvf: pass through CNTHCTL_EL2 and MDCCINT_EL1
>>   hvf: enable nested virtualisation support
>>
>> accel/hvf/hvf-all.c                |  51 ++
>> accel/stubs/hvf-stub.c             |   2 +
>> hw/arm/virt.c                      |  37 +-
>> hw/intc/arm_gicv3_common.c         |   4 +
>> hw/intc/arm_gicv3_hvf.c            | 822 +++++++++++++++++++++++++++++
>> hw/intc/arm_gicv3_hvf_stub.c       |  25 +
>> hw/intc/meson.build                |   2 +
>> include/hw/intc/arm_gicv3_common.h |   4 +
>> include/system/hvf.h               |   8 +
>> system/vl.c                        |   2 +
>> target/arm/hvf/hvf.c               | 124 ++++-
>> target/arm/hvf/sysreg.c.inc        |  45 ++
>> 12 files changed, 1112 insertions(+), 14 deletions(-)
>> create mode 100644 hw/intc/arm_gicv3_hvf.c
>> create mode 100644 hw/intc/arm_gicv3_hvf_stub.c
>>
>> -- 
>> 2.50.1 (Apple Git-155)
>>
>>
> 
> 


