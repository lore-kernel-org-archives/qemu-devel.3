Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8D0D12D70
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 04:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAMGR-0007Tv-Ae; Sun, 10 Nov 2024 23:42:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAMGP-0007TL-Ah
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 23:42:57 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tAMGL-0005LQ-3a
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 23:42:57 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20cb7139d9dso37537035ad.1
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 20:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1731300154; x=1731904954;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lPVo7GUNP7wa9nv2Axe6Am93l1PqfYEhaDPD5ZTFUpw=;
 b=vvUUTtKhO+CABuf/KUIjMWRqotiXsrL+X+tOh6kZRI0CnDabV0K+HUC95QFLXLnnOT
 CW1XQoLwW0P4N9aM7lbKcR7mL6SgWEsxLnjBcylSliJPAgdTcpvxur9el6+fF67HbzR1
 /ly9+qyR6qBCbcOn7hLgtkDC0p2dC5EHKHVmH92XKN+3rcTBthiOWO16AwI02okEPLPE
 tdlinZpW5hAYYExxyUXnPOtU/XOvWaLtwafuJ9+/AWV48SDQTAry9f1bkJLcVcJQRmb9
 dGDI1QOI1cIZF7ntBAUEwB1rahuLfsqujGATMR7/JBymU9HVrpB60ZFPFYDcxW/BGXIF
 xb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731300154; x=1731904954;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lPVo7GUNP7wa9nv2Axe6Am93l1PqfYEhaDPD5ZTFUpw=;
 b=IumczlQjXOtEyaWVCcCFD3rhQkSsifJUuVUFiDXXT5biie378cNQlhOa25B/4gBlAj
 gGO9U9hx5nPCBHrLvheGQgkhJKpLJzLPJOFKqJrxWyzDmh/qq92IcqyWS0NplCpacuK6
 /800B2bd5gKN77/Y+eJTvyQTPgQBEdsI2DEnsXrJYVHj2UnsqjqFQ5rmPX+a3gDXZheN
 KSBL/3QcjM7/YA1y3zaFSTjnQBcT0St0AszZpUZNi0CS9/xTmfn2RbwG1rHoJlmJE3O6
 zoucamQ2SIIpjum92c0JEPRniuXv00Cnr6oXwY2aj2bkWFlBEFqGbhp5vmln4liiASjh
 arhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnpMF3PnkaUPdCj+L0xnLZowLdMn2//HxRKGhgVwFQjhBRxfo09QM8HnTqCYwQpyPUBQua8SOa4fB3@nongnu.org
X-Gm-Message-State: AOJu0YzJ2jRDmxQ2eDJBrRw/IsG9i+5UW7YTonrmkCiFaE89KMmBhXeX
 4xfHmM5AAOMb6Ti0nyS+apyDiH3FPlZ1H1dIFZh8k/gALfutf64WYSI3JI2VT7w=
X-Google-Smtp-Source: AGHT+IEXy5hdY+IXCPXyGI5S1NTBu8fBe5ZQDmj0clfXKQilv8XXd0TCEtPyn9kdAw/UIt2goRIwDA==
X-Received: by 2002:a17:902:ed54:b0:20c:6bff:fca1 with SMTP id
 d9443c01a7336-21183d51b77mr114616295ad.23.1731300153593; 
 Sun, 10 Nov 2024 20:42:33 -0800 (PST)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177e58117sm67374105ad.172.2024.11.10.20.42.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Nov 2024 20:42:33 -0800 (PST)
Message-ID: <6a9ad03e-dff8-4229-97f2-9bace2721fed@daynix.com>
Date: Mon, 11 Nov 2024 13:42:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 15/15] hw/vmapple/vmapple: Add vmapple machine type
To: Phil Dennis-Jordan <lists@philjordan.eu>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 agraf@csgraf.de, peter.maydell@linaro.org, pbonzini@redhat.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, stefanha@redhat.com,
 mst@redhat.com, slp@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, chenhuacai@kernel.org, kwolf@redhat.com,
 hreitz@redhat.com, philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 Alexander Graf <graf@amazon.com>
References: <20241108144709.95498-1-phil@philjordan.eu>
 <20241108144709.95498-16-phil@philjordan.eu>
 <388c911e-bd7a-45ad-8188-c1321b12f80c@daynix.com>
 <CAGCz3vsnUqeVxtgqbcDibtTzvdxYDGWMAGHDygGVdzbSis=cgQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAGCz3vsnUqeVxtgqbcDibtTzvdxYDGWMAGHDygGVdzbSis=cgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2024/11/11 5:18, Phil Dennis-Jordan wrote:
> I've applied the majority of this feedback in the soon-to-be-posted v9
> of the patch set, thanks!
> 
> Just a few extra comments/replies below:
> 
> On Sun, 10 Nov 2024 at 08:38, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2024/11/08 23:47, Phil Dennis-Jordan wrote:
>>> From: Alexander Graf <graf@amazon.com>
>>>
>>> Apple defines a new "vmapple" machine type as part of its proprietary
>>> macOS Virtualization.Framework vmm. This machine type is similar to the
>>> virt one, but with subtle differences in base devices, a few special
>>> vmapple device additions and a vastly different boot chain.
>>>
>>> This patch reimplements this machine type in QEMU. To use it, you
>>> have to have a readily installed version of macOS for VMApple,
>>> run on macOS with -accel hvf, pass the Virtualization.Framework
>>> boot rom (AVPBooter) in via -bios, pass the aux and root volume as pflash
>>> and pass aux and root volume as virtio drives. In addition, you also
>>> need to find the machine UUID and pass that as -M vmapple,uuid= parameter:
>>>
>>> $ qemu-system-aarch64 -accel hvf -M vmapple,uuid=0x1234 -m 4G \
>>>       -bios /System/Library/Frameworks/Virtualization.framework/Versions/A/Resources/AVPBooter.vmapple2.bin
>>>       -drive file=aux,if=pflash,format=raw \
>>>       -drive file=root,if=pflash,format=raw \
>>>       -drive file=aux,if=none,id=aux,format=raw \
>>>       -device vmapple-virtio-aux,drive=aux \
>>>       -drive file=root,if=none,id=root,format=raw \
>>>       -device vmapple-virtio-root,drive=root
>>>
>>> With all these in place, you should be able to see macOS booting
>>> successfully.
>>>
>>> Known issues:
>>>    - Keyboard and mouse/tablet input is laggy. The reason for this is
>>>      either that macOS's XHCI driver is broken when the device/platform
>>>      does not support MSI/MSI-X, or there's some unfortunate interplay
>>>      with Qemu's XHCI implementation in this scenario.
>>>    - Currently only macOS 12 guests are supported. The boot process for
>>>      13+ will need further investigation and adjustment.
>>>
>>> Signed-off-by: Alexander Graf <graf@amazon.com>
>>> Co-authored-by: Phil Dennis-Jordan <phil@philjordan.eu>
>>> Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
>>> ---
>>>
>>> v3:
>>>    * Rebased on latest upstream, updated affinity and NIC creation
>>>      API usage
>>>    * Included Apple-variant virtio-blk in build dependency
>>>    * Updated API usage for setting 'redist-region-count' array-typed property
>>>      on GIC.
>>>    * Switched from virtio HID devices (for which macOS 12 does not contain
>>>      drivers) to an XHCI USB controller and USB HID devices.
>>>
>>> v4:
>>>    * Fixups for v4 changes to the other patches in the set.
>>>    * Corrected the assert macro to use
>>>    * Removed superfluous endian conversions corresponding to cfg's.
>>>    * Init error handling improvement.
>>>    * No need to select CPU type on TCG, as only HVF is supported.
>>>    * Machine type version bumped to 9.2
>>>    * #include order improved
>>>
>>> v5:
>>>    * Fixed memory reservation for ecam alias region.
>>>    * Better error handling setting properties on devices.
>>>    * Simplified the machine ECID/UUID extraction script and actually created a
>>>      file for it rather than quoting its code in documentation.
>>>
>>> v7:
>>>    * Tiny error handling fix, un-inlined function.
>>>
>>> v8:
>>>    * Use object_property_add_uint64_ptr rather than defining custom UUID
>>>      property get/set functions.
>>>
>>>    MAINTAINERS                 |   1 +
>>>    contrib/vmapple/uuid.sh     |   9 +
>>>    docs/system/arm/vmapple.rst |  60 ++++
>>>    docs/system/target-arm.rst  |   1 +
>>>    hw/vmapple/Kconfig          |  20 ++
>>>    hw/vmapple/meson.build      |   1 +
>>>    hw/vmapple/vmapple.c        | 638 ++++++++++++++++++++++++++++++++++++
>>>    7 files changed, 730 insertions(+)
>>>    create mode 100755 contrib/vmapple/uuid.sh
>>>    create mode 100644 docs/system/arm/vmapple.rst
>>>    create mode 100644 hw/vmapple/vmapple.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 9d0d26cb65f..9591fd44a34 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -2767,6 +2767,7 @@ R: Phil Dennis-Jordan <phil@philjordan.eu>
>>>    S: Maintained
>>>    F: hw/vmapple/*
>>>    F: include/hw/vmapple/*
>>> +F: docs/system/arm/vmapple.rst
>>>
>>>    Subsystems
>>>    ----------
>>> diff --git a/contrib/vmapple/uuid.sh b/contrib/vmapple/uuid.sh
>>> new file mode 100755
>>> index 00000000000..956e8c3afed
>>> --- /dev/null
>>> +++ b/contrib/vmapple/uuid.sh
>>> @@ -0,0 +1,9 @@
>>> +#!/bin/sh
>>> +# Used for converting a guest provisioned using Virtualization.framework
>>> +# for use with the QEMU 'vmapple' aarch64 machine type.
>>> +#
>>> +# Extracts the Machine UUID from Virtualization.framework VM JSON file.
>>> +# (as produced by 'macosvm', passed as command line argument)
>>> +
>>> +plutil -extract machineId raw "$1" | base64 -d | plutil -extract ECID raw -
>>> +
>>> diff --git a/docs/system/arm/vmapple.rst b/docs/system/arm/vmapple.rst
>>> new file mode 100644
>>> index 00000000000..6a634fa4572
>>> --- /dev/null
>>> +++ b/docs/system/arm/vmapple.rst
>>> @@ -0,0 +1,60 @@
>>> +VMApple machine emulation
>>> +========================================================================================
>>> +
>>> +VMApple is the device model that the macOS built-in hypervisor called "Virtualization.framework"
>>> +exposes to Apple Silicon macOS guests. The "vmapple" machine model in QEMU implements the same
>>> +device model, but does not use any code from Virtualization.Framework.
>>> +
>>> +Prerequisites
>>> +-------------
>>> +
>>> +To run the vmapple machine model, you need to
>>> +
>>> + * Run on Apple Silicon
>>> + * Run on macOS 12.0 or above
>>> + * Have an already installed copy of a Virtualization.Framework macOS 12 virtual machine. I will
>>> +   assume that you installed it using the macosvm CLI.
>>
>> Add a URL to macosvm.
>>
>>> +
>>> +First, we need to extract the UUID from the virtual machine that you installed. You can do this
>>> +by running the shell script in contrib/vmapple/uuid.sh on the macosvm.json file.
>>> +
>>> +.. code-block:: bash
>>> +  :caption: uuid.sh script to extract the UUID from a macosvm.json file
>>> +
>>> +  $ contrib/vmapple/uuid.sh "path/to/macosvm.json"
>>> +
>>> +Now we also need to trim the aux partition. It contains metadata that we can just discard:
>>> +
>>> +.. code-block:: bash
>>> +  :caption: Command to trim the aux file
>>> +
>>> +  $ dd if="aux.img" of="aux.img.trimmed" bs=$(( 0x4000 )) skip=1
>>
>> Quoting is inconsistent. aux.img.trimmed is not quoted below but it is
>> quoted here.
>>
>>> +
>>> +How to run
>>> +----------
>>> +
>>> +Then, we can launch QEMU with the Virtualization.Framework pre-boot environment and the readily
>>> +installed target disk images. I recommend to port forward the VM's ssh and vnc ports to the host
>>> +to get better interactive access into the target system:
>>> +
>>> +.. code-block:: bash
>>> +  :caption: Example execution command line
>>> +
>>> +  $ UUID=$(uuid.sh macosvm.json)
>>> +  $ AVPBOOTER=/System/Library/Frameworks/Virtualization.framework/Resources/AVPBooter.vmapple2.bin
>>> +  $ AUX=aux.img.trimmed
>>> +  $ DISK=disk.img
>>> +  $ qemu-system-aarch64 \
>>> +       -serial mon:stdio \
>>> +       -m 4G \
>>> +       -accel hvf \
>>> +       -M vmapple,uuid=$UUID \
>>> +       -bios $AVPBOOTER \
>>
>> $AUX and $DISK are quoted but $UUID and $AVPBOOTER are not.
>>
>>> +        -drive file="$AUX",if=pflash,format=raw \
>>> +        -drive file="$DISK",if=pflash,format=raw \
>>
>> These two lines are misaligned.
>>
>>> +       -drive file="$AUX",if=none,id=aux,format=raw \
>>> +       -drive file="$DISK",if=none,id=root,format=raw \
>>> +       -device vmapple-virtio-aux,drive=aux \
>>> +       -device vmapple-virtio-root,drive=root \
>>> +       -net user,ipv6=off,hostfwd=tcp::2222-:22,hostfwd=tcp::5901-:5900 \
>>> +       -net nic,model=virtio-net-pci \
>>
>> -net is a legacy option and creates a unnecessary indirection with hub.
>> Use -netdev and -device options. Also plug virtio-net-pci into a PCIe
>> root port as suggested in: docs/pcie.txt
> 
> I have not had any success with booting macOS with the block devices
> connected to PCIe root ports, and similarly the network doesn't come
> up if I attach just the virtio-net-pci device to one.
> 
> As far as I can tell (ioreg), Apple's own VMapple machine type does
> not use PCIe root ports, but I'm not 100% sure. The PCIe documentation
> is generally rather focused on x86 and on running Linux in the 'virt'
> machine type.

Without a PCIe root port, virtio devices will be forced to work as a PCI 
device (not PCIe) and to use its "legacy" interface. I don't think 
Virtualization.framework uses the legacy interface though.

> 
> In any case, a far more pressing issue is MSI support, without which
> the XHCI driver fails to receive most kinds of notifications from the
> USB controller. (Therefore keyboard/mouse is currently very laggy.)
> The arm 'virt' machine type supposedly supports it via the GIC ITS
> device, but I've so far not managed to transfer this to 'vmapple' in a
> way that makes the guest OS detect MSI support. Anyway, in its current
> iteration, the machine type is good enough to be used for some tasks,
> and we can always refine it later. (Another major limitation is of
> course guest support for OS versions > 12 - but those issues might
> even be related.)

Perhaps the MSI issue may be also related to PCIe.

> 
> One thing I am thinking about changing (as we've now missed the 9.2
> merge window anyway, sigh) as it would be non-backwards-compatible is
> replacing the vmapple-virtio-aux/vmapple-virtio-root pair of devices
> with just the the base type, vmapple-virtio-blk-pci, and adding a
> variant property to it. So:
> 
>         -device vmapple-virtio-blk-pci,variant=aux,drive=aux \
>         -device vmapple-virtio-blk-pci,variant=root,drive=root \
> 
> I think this would make hw/vmapple/virtio-blk.c somewhat more readable
> and also significantly shorter.

I agree. It will be a nice improvement.

