Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61704C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 12:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWbXd-0007cS-Lu; Wed, 24 Jul 2024 08:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sWbXb-0007b6-NT
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 08:56:24 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sWbXZ-000398-EZ
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 08:56:23 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70d1d6369acso623735b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 05:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1721825779; x=1722430579; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b55Bv/fMkliL5N9hJdd9Czd8pHs3GomAs0nqsc/QVek=;
 b=MKOLhdODoCjZJAWOXr5g1V3GgQrvTU8I5PCsk9x7/DKMHS8P5fVn83VnOsh5ttUX8x
 /469zn1zrftRFQNCnhrEfnso2I7OUAbx+3hpB+pWn2UWBycHT/XP6xEOpR8Y0NcFDsV4
 vHwFsMBYO64u3hgO442Vw9Gu4XUqOUbG9cFmuvj11zg68tSs+ia9JfscIxe08g3MPofs
 iuPo483IpNFuCDO/rpreJAiU82AqwZPbFG2VHLGegVUWhMcI1jI8TfWqMA9fa2cSPJq8
 28zjneDlT03KP0xQKcbQeJhYd11jQJ0zVwE/9u4Z8u1+r5oIc+JSaZgVVYNpNVUhw0De
 RyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721825779; x=1722430579;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b55Bv/fMkliL5N9hJdd9Czd8pHs3GomAs0nqsc/QVek=;
 b=Xk6QpqWcoPBfdglVm8wvzoHr7UVakAu0brbNfo17epEmZk0hgwbMjgYP4+8S/0ozUI
 ZcnocFYtB4aBEFKwTjetPCNVuoZQVedU8r0BrlS+/v643kbjaMbWaYCl+8FDglQl3bj/
 Gc4s3e3QSQe3yhMGfQWHzcwYC2PwtAbDZP+FsE0dmXRH+Gnm/u771UMkeSVXGxPSGnQQ
 7FSGcBrWNOAkMhk8m00Pl8LXnHyKZc2y1/5JPknzdx/nEhZpwELHENb2wktfDG+kOoua
 CaSD4vBjrvkMnT9UQ2BXtQicci/A4ZfsJnFLNhFXNLGXjdv2ADuPJKSoY75sOQ/Q6tH9
 gpNg==
X-Gm-Message-State: AOJu0YwHlJGClEuOAgWFTqJgMdd6dypYVpjyrRVdiGZDEJNtO3AZgaIa
 n//Fe4gFypxbhgctGKmuA2tM2cjnd+IWpRx1grzumdXaQWRZJDVd2EEvHcIxMFA=
X-Google-Smtp-Source: AGHT+IEDRUXWG4IW2DT8AWE0+DJFPSdT6N3NN0lqvMyFFKIVievYpd4wS/CXMyzFHHzAGP8ukh8dIw==
X-Received: by 2002:a05:6a00:9296:b0:70d:2ab5:8677 with SMTP id
 d2e1a72fcca58-70e9ee90bcemr2854324b3a.10.1721825779002; 
 Wed, 24 Jul 2024 05:56:19 -0700 (PDT)
Received: from [192.168.68.110] ([179.193.8.144])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70cff4b2e31sm8503009b3a.78.2024.07.24.05.56.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 05:56:18 -0700 (PDT)
Message-ID: <ff35d3bb-b4d3-4a28-848c-1bd6668c35ec@ventanamicro.com>
Date: Wed, 24 Jul 2024 09:56:14 -0300
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x431.google.com
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

I suppose we can add a boilerplate sentence about what an IOMMU does, but aside
from that I'm not sure what to say about user expectation. If you're adding an
IOMMU (or any device in QEMU) it's expected that the user has some idea of what
the device is supposed to do in the board and so on hehe


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

