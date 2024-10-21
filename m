Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD74D3C92F
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 02:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2iFM-00024t-IW; Sun, 20 Oct 2024 22:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t2iFL-00024N-2W
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 22:34:15 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1t2iFJ-0004TH-2t
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 22:34:14 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20bb39d97d1so35921525ad.2
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 19:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729478051; x=1730082851; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4491m1flSoPK/UGzXgUFXmWFDkLb02T71tws0DrSeUQ=;
 b=NL30yOA8aCl12U7u+sssdTSg0Z73k3ChaFD6WmqY7nEvxOWE8Z2VODFKK7DHATdUyo
 gVSQT6jIMXMInRssj07Sc48OF0PIPOBNRFRmI4S5SFT8zliBURfc9WkhLZBOpSsM3BPK
 wjh5mY/6PELby/OarjwMVxg+a8VMnuFiW/VDdtTDaFrZT02KhjGbd4JJCd6KxIv+1ftl
 RPWXthKdpsQcdQgkTdcGQILzmHzsJ2xMuQJhRe2Y4/ffL+LWkie4OL/N2ELs3pTTRMDV
 umJjXjyq5HX2k6v8wSkP+6Al3FTnJjitwwSrSbrabbCtdF+Wcx+ueO3d1V0yzn2+frAx
 OXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729478051; x=1730082851;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4491m1flSoPK/UGzXgUFXmWFDkLb02T71tws0DrSeUQ=;
 b=FOcQsmvWpFjvziPS8VmrUNuckT3aKFYKkLxh7aiQyUIjt5Q8pjwquJr+mhTmJ9vtJV
 lxymWdyksRpx0it4y6o3vtEkVFwCSMLX9bQS6o89DQjwMnvOV+faN1uUlfZP2XuVgfD4
 Jp9F8wLu3zSTcolFnvRST4xv+xjXhx6I9VCpct6Hu1kluKegnq1qUpGbeE0BdfWhpwN6
 t5jinoyb0zP/h9Aob/vFYwf71WlzIUNOg3X6jEZPERMWGpfL8G044+BLq9IOMZ13nyth
 MtBwqjIt6pBmtDkf+lL0lZfu9/Y1bdhZBerAZUcgp159YNcK+ygcevQGCQ4sZpN6ueYu
 jNCw==
X-Gm-Message-State: AOJu0YwZ66K/ocANfaoSqGGcYAlJpTHVEbkuuQkclV26KtrOgLaDWyfP
 bol2HFxURXLD8RcYoW6eYjZhCCmxdmFDnnXy9QxCpPA/9t6tTAoNklSQoyFHrqg=
X-Google-Smtp-Source: AGHT+IFtm1mShQvC9KuvEbIZnRt7374CZIAKFOhFvl7LIqOSaL1Sy/MomYKV91jo5dcpa9+B8XEokA==
X-Received: by 2002:a17:902:f0cc:b0:20c:5983:888b with SMTP id
 d9443c01a7336-20e5a94e8c6mr94003655ad.54.1729478051092; 
 Sun, 20 Oct 2024 19:34:11 -0700 (PDT)
Received: from [192.168.0.102] ([187.121.94.4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7ef08d29sm16049405ad.64.2024.10.20.19.34.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2024 19:34:10 -0700 (PDT)
Message-ID: <acd27416-e612-48c1-b2f4-c6157d710bb3@linaro.org>
Date: Sun, 20 Oct 2024 23:33:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 0/4] Arch agnostic ACPI changes to support vCPU Hotplug
 (on Archs like ARM)
To: Igor Mammedov <imammedo@redhat.com>, Salil Mehta <salil.mehta@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 maz@kernel.org, jean-philippe@linaro.org, jonathan.cameron@huawei.com,
 lpieralisi@kernel.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, andrew.jones@linux.dev, david@redhat.com,
 philmd@linaro.org, eric.auger@redhat.com, will@kernel.org, ardb@kernel.org,
 oliver.upton@linux.dev, pbonzini@redhat.com, gshan@redhat.com,
 rafael@kernel.org, borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 npiggin@gmail.com, harshpb@linux.ibm.com, linux@armlinux.org.uk,
 darren@os.amperecomputing.com, ilkka@os.amperecomputing.com,
 vishnu@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, jiakernel2@gmail.com,
 maobibo@loongson.cn, lixianglai@loongson.cn, shahuang@redhat.com,
 zhao1.liu@intel.com, linuxarm@huawei.com
References: <20241014192205.253479-1-salil.mehta@huawei.com>
 <20241018164629.2939b711@imammedo.users.ipa.redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20241018164629.2939b711@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x62b.google.com
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

Hi Igor,

On 10/18/24 11:46, Igor Mammedov wrote:
> On Mon, 14 Oct 2024 20:22:01 +0100
> Salil Mehta <salil.mehta@huawei.com> wrote:
> 
>> Certain CPU architecture specifications [1][2][3] prohibit changes to the CPUs
>> *presence* after the kernel has booted. This is because many system
>> initializations depend on the exact CPU count at boot time and do not expect it
>> to change afterward. For example, components like interrupt controllers that are
>> closely coupled with CPUs, or various per-CPU features, may not support
>> configuration changes once the kernel has been initialized.
>>
>> This requirement poses a challenge for virtualization features like vCPU
>> hotplug. To address this, changes to the ACPI AML are necessary to update the
>> `_STA.PRES` (presence) and `_STA.ENA` (enabled) bits accordingly during guest
>> initialization, as well as when vCPUs are hot-plugged or hot-unplugged. The
>> presence of unplugged vCPUs may need to be deliberately *simulated* at the ACPI
>> level to maintain a *persistent* view of vCPUs for the guest kernel.
> 
> the series is peppered with *simulated* idea, which after looking at code
> I read as 'fake'. While it's obvious to author why things need to be faked
> at this time, it will be forgotten later on. And cause a lot swearing from
> whoever will have to deal with this code down the road.
> 
> Salil, I'm sorry that review comes out as mostly negative but for me having to
> repeat 'simulated' some many times, hints that the there is
> something wrong with design and that we should re-evaluate the approach.

I think 'simulated' was indeed a badly chosen name because the series,
as read it, is merely saving the hotplugged/unplugged vCPU states to the
ACPI for persistence and later restoration, so I think s/simulated/saved/ is
reasonable here, i.e., ACPI now reflects the vCPU states after hotplug/unplug.
QEMU manipulates the ACPI tables and methods to reflect the machine config.
and this series is essentially doing the same. Why that's not ok?


Cheers,
Gustavo

> ps:
> see comments on 1/4 for suggestions
> 
> 
>> This patch set introduces the following features:
>>
>> 1. ACPI Interface with Explicit PRESENT and ENABLED CPU States: It allows the
>>     guest kernel to evaluate these states using the `_STA` ACPI method.
>>     
>> 2. Initialization of ACPI CPU States: These states are initialized during
>>     `machvirt_init` and when vCPUs are hot-(un)plugged. This enables hotpluggable
>>     vCPUs to be exposed to the guest kernel via ACPI.
>>
>> 3. Support for Migrating ACPI CPU States: The patch set ensures the migration of
>>     the newly introduced `is_{present,enabled}` ACPI CPU states to the
>>     destination VM.
>>
>> The approach is flexible enough to accommodate ARM-like architectures that
>> intend to implement vCPU hotplug functionality. It is suitable for architectures
>> facing similar constraints to ARM or those that plan to implement vCPU
>> hotplugging independently of hardware support (if available).
>>
>> This patch set is derived from the ARM-specific vCPU hotplug implementation [4]
>> and includes migration components adaptable to other architectures, following
>> suggestions [5] made by Igor Mammedov <imammedo@redhat.com>.
>>
>> It can be applied independently, ensuring compatibility with existing hotplug
>> support in other architectures. I have tested this patch set in conjunction with
>> the ARM-specific vCPU hotplug changes (included in the upcoming RFC V5 [6]), and
>> everything worked as expected. I kindly request maintainers of other
>> architectures to provide a "Tested-by" after running their respective regression
>> tests.
>>
>> Many thanks!
>>
>>
>> References:
>> [1] KVMForum 2023 Presentation: Challenges Revisited in Supporting Virt CPU Hotplug on
>>      architectures that don’t Support CPU Hotplug (like ARM64)
>>      a. Kernel Link: https://kvm-forum.qemu.org/2023/KVM-forum-cpu-hotplug_7OJ1YyJ.pdf
>>      b. Qemu Link:  https://kvm-forum.qemu.org/2023/Challenges_Revisited_in_Supporting_Virt_CPU_Hotplug_-__ii0iNb3.pdf
>> [2] KVMForum 2020 Presentation: Challenges in Supporting Virtual CPU Hotplug on
>>      SoC Based Systems (like ARM64)
>>      Link: https://kvmforum2020.sched.com/event/eE4m
>> [3] Check comment 5 in the bugzilla entry
>>      Link: https://bugzilla.tianocore.org/show_bug.cgi?id=4481#c5
>> [4] [PATCH RFC V4 00/33] Support of Virtual CPU Hotplug for ARMv8 Arch
>>      Link: https://lore.kernel.org/qemu-devel/20241009031815.250096-1-salil.mehta@huawei.com/T/#mf32be203baa568a871dc625b732f666a4c4f1e68
>> [5] Architecture agnostic ACPI VMSD state migration (Discussion)
>>      Link: https://lore.kernel.org/qemu-devel/20240715155436.577d34c5@imammedo.users.ipa.redhat.com/
>> [6] Upcoming RFC V5, Support of Virtual CPU Hotplug for ARMv8 Arch
>>      Link: https://github.com/salil-mehta/qemu/commits/virt-cpuhp-armv8/rfc-v5
>>
>> Salil Mehta (4):
>>    hw/acpi: Initialize ACPI Hotplug CPU Status with Support for vCPU
>>      `Persistence`
>>    hw/acpi: Update ACPI CPU Status `is_{present, enabled}` during vCPU
>>      hot(un)plug
>>    hw/acpi: Reflect ACPI vCPU {present,enabled} states in ACPI
>>      _STA.{PRES,ENA} Bits
>>    hw/acpi: Populate vCPU Hotplug VMSD to migrate `is_{present,enabled}`
>>      states
>>
>>   cpu-target.c         patches.vcpuhp.rfc-v5.arch.agnostic.acpi          |  1 +
>>   hw/acpi/cpu.c                  | 70 +++++++++++++++++++++++++++++++---
>>   hw/acpi/generic_event_device.c | 11 ++++++
>>   include/hw/acpi/cpu.h          | 21 ++++++++++
>>   include/hw/core/cpu.h          | 21 ++++++++++
>>   5 files changed, 119 insertions(+), 5 deletions(-)
>>
> 


