Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FB4C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 19:18:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZEpR-0007xX-Cy; Wed, 31 Jul 2024 15:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sZEpL-0007wL-M7
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 15:17:35 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sZEpJ-0000FY-GS
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 15:17:35 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70d1a74a43bso4415835b3a.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 12:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1722453452; x=1723058252; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vuvlbscv2fxE86Epu1744EkRqeC/nW3T1TIjVBij18w=;
 b=byInlowv05jZJTtYeggJDEqJefi9GfsIZQgOq8acMnkHjn1WG35XmTMW8bt00rZMba
 ymd6MOUeSDo3IQZKMVmqWLpb+HLnPgTgCIxteF8tddF20GFFUvMQ0WRAnvmA6WqUOwxl
 YHwIne+XwiL14d7WbhuvHv+m/S7TElz4l4dnjcrQlbIn09gx4SHVkMHO8noRpGMxt8Zr
 QUm0CLahcPKbco4pjr6YZB2zkVzT/p325AcNU6sl5xReOA7qAXMN6Igt0+uVf+QOr5H6
 fA6KD26pAN08sjPQ7/gBVvuDouY6cKKpDW/LazUIpFWrcDEB3G4l8ojQCtADPMvZTu8i
 AAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722453452; x=1723058252;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vuvlbscv2fxE86Epu1744EkRqeC/nW3T1TIjVBij18w=;
 b=BLGflvz8h1/oQJkdoCwNwbs1koe41KpRdJkkNbaEBURW0kJvTyLuJJlT/YG1V/GwU7
 WFTQNj63I93yOioWQMHhle4bBqHbAH4zvR4n9XvwMzj2ud+QPdho/WWWSF5B1cjfu16J
 ms/80vazdX/dvAjFQ2lMtWqEh3EYmlbOFYU7IK+beOkCo/dzaFMCVqLuFG6aUdRpb8+b
 AuTem4k6YsbSFDWniU04dVIoQSMrtqU1F9aa3amslKVtEWLsn+Mezruuq5mE0B3heyLX
 yAbsIBY/G3WzsR+iNXxMolTUI1gPJcD8RRbooSZaxcxvSbLtb2jb12UZHfPc2C0Sl4ul
 HKWw==
X-Gm-Message-State: AOJu0Ywj2Qt+wgo0S8smjttfSqJsAn4vlK8EEX2dyDGQ0B8Bp6mJjeA0
 tclpchhTRcc1W0laxl1HWhHpvYtq0Mkrm7RysbgJSeV6GLO1H5YdMM8F/Wp14tI=
X-Google-Smtp-Source: AGHT+IFbkkNaBQj+7tyvwpL3EWTFF++NWM/onsDiIIDbxBXHFyWpNYdtkgQNHYL1fZUnsrnQIcDaBA==
X-Received: by 2002:a05:6a00:9165:b0:706:b10c:548a with SMTP id
 d2e1a72fcca58-7105d7b2653mr252128b3a.22.1722453451700; 
 Wed, 31 Jul 2024 12:17:31 -0700 (PDT)
Received: from [192.168.68.110] ([177.197.107.101])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead72ad5asm10594206b3a.90.2024.07.31.12.17.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jul 2024 12:17:31 -0700 (PDT)
Message-ID: <ad9acd2b-f76c-4e84-ad67-159c7623177c@ventanamicro.com>
Date: Wed, 31 Jul 2024 16:17:27 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/13] docs/specs: add riscv-iommu
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, frank.chang@sifive.com, tjeznach@rivosinc.com,
 jason.chien@sifive.com
References: <20240708173501.426225-1-dbarboza@ventanamicro.com>
 <20240708173501.426225-14-dbarboza@ventanamicro.com>
 <CAKmqyKOA8VHg=BDBfhZcf0eU=3ts0=PoLEdzdd0rhNOz000=Xg@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CAKmqyKOA8VHg=BDBfhZcf0eU=3ts0=PoLEdzdd0rhNOz000=Xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x432.google.com
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



On 7/19/24 6:34 AM, Alistair Francis wrote:
> On Tue, Jul 9, 2024 at 3:37 AM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
>>
>> Add a simple guideline to use the existing RISC-V IOMMU support we just
>> added.
>>
>> This doc will be updated once we add the riscv-iommu-sys device.
>>
>> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>> ---
>>   docs/specs/index.rst       |  1 +
>>   docs/specs/riscv-iommu.rst | 55 ++++++++++++++++++++++++++++++++++++++
>>   docs/system/riscv/virt.rst | 13 +++++++++
>>   3 files changed, 69 insertions(+)
>>   create mode 100644 docs/specs/riscv-iommu.rst
>>
>> diff --git a/docs/specs/index.rst b/docs/specs/index.rst
>> index 1484e3e760..c68cd9ae6c 100644
>> --- a/docs/specs/index.rst
>> +++ b/docs/specs/index.rst
>> @@ -33,3 +33,4 @@ guest hardware that is specific to QEMU.
>>      virt-ctlr
>>      vmcoreinfo
>>      vmgenid
>> +   riscv-iommu
>> diff --git a/docs/specs/riscv-iommu.rst b/docs/specs/riscv-iommu.rst
>> new file mode 100644
>> index 0000000000..fa38ff7667
>> --- /dev/null
>> +++ b/docs/specs/riscv-iommu.rst
>> @@ -0,0 +1,55 @@
>> +.. _riscv-iommu:
>> +
>> +RISC-V IOMMU support for RISC-V machines
>> +========================================
>> +
>> +QEMU implements a RISC-V IOMMU emulation based on the RISC-V IOMMU spec
>> +version 1.0 [1].
>> +
>> +The emulation includes a PCI reference device, riscv-iommu-pci, that QEMU
>> +RISC-V boards can use.  The 'virt' RISC-V machine is compatible with this
>> +device.
>> +
>> +A platform device that implements the RISC-V IOMMU will be added in the
>> +future.
>> +
>> +
>> +riscv-iommu-pci reference device
>> +--------------------------------
>> +
>> +This device implements the RISC-V IOMMU emulation as recommended by the section
>> +"Integrating an IOMMU as a PCIe device" of [1]: a PCI device with base class 08h,
>> +sub-class 06h and programming interface 00h.
>> +
>> +As a reference device it doesn't implement anything outside of the specification,
>> +so it uses a generic default PCI ID given by QEMU: 1b36:0014.
>> +
>> +To include the device in the 'virt' machine:
>> +
>> +.. code-block:: bash
>> +
>> +  $ qemu-system-riscv64 -M virt -device riscv-iommu-pci (...)
> 
> We should add a sentence saying what this does. As in what should a
> user expect after they have done this

Here's what was added at this point:

  .. code-block:: bash
  
-  $ qemu-system-riscv64 -M virt -device riscv-iommu-pci (...)
+  $ qemu-system-riscv64 -M virt -device riscv-iommu-pci,[optional_pci_opts] (...)
+
+This will add a RISC-V IOMMU PCI device in the board following any additional
+PCI parameters (like PCI bus address).  The behavior of the RISC-V IOMMU is
+defined by the spec but its operation is OS dependent.  As of this writing the
+existing Linux kernel support `linux-v8`_, not yet merged, will configure the IOMMU
+to create IOMMU groups with any eligible cards available in the system,
+regardless of factors such as the order in which the devices are added in the
+command line.
+
+This means that these command lines are equivalent as far as the current
+IOMMU kernel driver behaves:
+
+.. code-block:: bash
+
+  $ qemu-system-riscv64 \
+        -M virt,aia=aplic-imsic,aia-guests=5 \
+        -device riscv-iommu-pci,addr=1.0,vendor-id=0x1efd,device-id=0xedf1 \
+        -device e1000e,netdev=net1 -netdev user,id=net1,net=192.168.0.0/24 \
+        -device e1000e,netdev=net2 -netdev user,id=net2,net=192.168.200.0/24 \
+        (...)
+
+  $ qemu-system-riscv64 \
+        -M virt,aia=aplic-imsic,aia-guests=5 \
+        -device e1000e,netdev=net1 -netdev user,id=net1,net=192.168.0.0/24 \
+        -device e1000e,netdev=net2 -netdev user,id=net2,net=192.168.200.0/24 \
+        -device riscv-iommu-pci,addr=1.0,vendor-id=0x1efd,device-id=0xedf1 \
+        (...)
+
+Both will create iommu groups for the two e1000e cards.


What I tried to say here is that the operation of the IOMMU device is OS dependent,
and the current Linux driver doesn't care to things such as the order in which the
devices were added. Is this what you had in mind?


I also removed the platform device reference at the start of the doc. I think it was
doing more harm than good. We'll need to change this doc when that device is added,
might as well leave it as is for now.


Thanks,

Daniel


> 
> Alistair
> 
>> +
>> +As of this writing the existing Linux kernel support [2], not yet merged, is being
>> +created as a Rivos device, i.e. it uses Rivos vendor ID.  To use the riscv-iommu-pci
>> +device with the existing kernel support we need to emulate a Rivos PCI IOMMU by
>> +setting 'vendor-id' and 'device-id':
>> +
>> +.. code-block:: bash
>> +
>> +  $ qemu-system-riscv64 -M virt        \
>> +     -device riscv-iommu-pci,vendor-id=0x1efd,device-id=0xedf1 (...)
>> +
>> +Several options are available to control the capabilities of the device, namely:
>> +
>> +- "bus"
>> +- "ioatc-limit"
>> +- "intremap"
>> +- "ats"
>> +- "off" (Out-of-reset translation mode: 'on' for DMA disabled, 'off' for 'BARE' (passthrough))
>> +- "s-stage"
>> +- "g-stage"
>> +
>> +
>> +[1] https://github.com/riscv-non-isa/riscv-iommu/releases/download/v1.0/riscv-iommu.pdf
>> +[2] https://lore.kernel.org/linux-riscv/cover.1718388908.git.tjeznach@rivosinc.com/
>> diff --git a/docs/system/riscv/virt.rst b/docs/system/riscv/virt.rst
>> index 9a06f95a34..8e9a2e4dda 100644
>> --- a/docs/system/riscv/virt.rst
>> +++ b/docs/system/riscv/virt.rst
>> @@ -84,6 +84,19 @@ none``, as in
>>
>>   Firmware images used for pflash must be exactly 32 MiB in size.
>>
>> +riscv-iommu support
>> +-------------------
>> +
>> +The board has support for the riscv-iommu-pci device by using the following
>> +command line:
>> +
>> +.. code-block:: bash
>> +
>> +  $ qemu-system-riscv64 -M virt -device riscv-iommu-pci (...)
>> +
>> +Refer to :ref:`riscv-iommu` for more information on how the RISC-V IOMMU support
>> +works.
>> +
>>   Machine-specific options
>>   ------------------------
>>
>> --
>> 2.45.2
>>
>>

