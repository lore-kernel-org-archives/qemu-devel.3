Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EFEC27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 18:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGjof-0008Hd-1t; Mon, 10 Jun 2024 14:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sGjod-0008H9-35
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 14:32:23 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1sGjoa-0007zJ-BJ
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 14:32:22 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-35f1cb7a40fso1754560f8f.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 11:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1718044338; x=1718649138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M17iCrlJ95rsdcuEqIX9OUH+9zvH8kR2OWy2ikmIwCU=;
 b=oZQN+cZQYfto1o0S1DrkcqSD2n4OXEdRnB0dLYAz4iedlvlAX1V0Aj87NJwei1mWBM
 zUcDE1dnVSyM81/D+LLZJKarZmJ3W8GOS3uOUnV9kc5180ji8S30rOVWDrzWWqYUzXnV
 jTq0vqCmaz0MCOX9mGzXGRLe/WXHhBA9jQonKqYya/B+pYQWxFAuilX5FH3iahxj84i9
 Le/sN0UcCPV9msoQrI/UdvSG6hPLCykFXCoL68KWJI7MN/CvVNoB6FwBRV7hTr2lNg27
 ObghRyez6l6yDhHBjrJX/mBVUol4KM7mB6T0+BHYtCacZMDZ4YTxfvOnUFJOWP4JRehn
 U4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718044338; x=1718649138;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M17iCrlJ95rsdcuEqIX9OUH+9zvH8kR2OWy2ikmIwCU=;
 b=XfCEtWkIgpWQhgx3zqtQgV8FWnCH5zn3UUoz/3XU3r6bISspCOLBkbfs5qQKddsBon
 gn2MEyQzNagVPzlPeU0kpWwSf9HoHiggPdoLqQ1NsAo4Udj8hZ2TUBq5vtbFx2U2zirn
 7oJPFWxE3KRkoTey0+zBNe83NrdgZ1gg9nX33CnOZzaRRvk/jkeyi9+3pc9juOVFQka9
 7hbi8OWzTrn0+ziEpERz0F+eI/2BXgc9U3Q+rV6jOZKal+5zMBxKdEvst/CkdOHijBxm
 JioxJKeDCDw6yvXlur62owAJiuSpLL0hIASb2Iq4l89AxgRYDAZcGNOoPzXGVGhzmFm1
 KSCg==
X-Gm-Message-State: AOJu0YzEun6/3si9Mm0nhIauWg2/GoyJmoWOy2Mpjus8RKiRqTOgRJPe
 PhbA70C3uWnvf6VZjB0IUatZuMaTUuW3Kn05j5MIyZfMp7nW/0yRV3IT4yQsU8Y=
X-Google-Smtp-Source: AGHT+IGqa6A829F7edvyeWoaitaOwBlN0vd+pbfUWcCRSGw/ouXHuMlTNhRfie/JOE7y5Kr08TgIqQ==
X-Received: by 2002:a05:6000:259:b0:35f:b94:8e70 with SMTP id
 ffacd0b85a97d-35f0b948ee9mr6026429f8f.9.1718044337984; 
 Mon, 10 Jun 2024 11:32:17 -0700 (PDT)
Received: from [127.0.0.1] (cst2-173-81.cust.vodafone.cz. [31.30.173.81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f1fd78d1bsm4674138f8f.48.2024.06.10.11.32.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jun 2024 11:32:17 -0700 (PDT)
Date: Mon, 10 Jun 2024 20:32:15 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 palmer@rivosinc.com, tjeznach@rivosinc.com, frank.chang@sifive.com
Subject: Re: [PATCH v3 00/13] riscv: QEMU RISC-V IOMMU Support
In-Reply-To: <CAKmqyKNd2BL-B12RnXu6ZRC0ApqgFXeZSTxggSxJSnbvcN=aSA@mail.gmail.com>
References: <20240523173955.1940072-1-dbarboza@ventanamicro.com>
 <CAKmqyKNd2BL-B12RnXu6ZRC0ApqgFXeZSTxggSxJSnbvcN=aSA@mail.gmail.com>
Message-ID: <5ADE1DEF-D40E-4199-8646-5C539249796C@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On June 10, 2024 2:34:58 AM GMT+02:00, Alistair Francis <alistair23@gmail=
=2Ecom> wrote:
>On Fri, May 24, 2024 at 3:43=E2=80=AFAM Daniel Henrique Barboza
><dbarboza@ventanamicro=2Ecom> wrote:
>>
>> Hi,
>>
>> In this new version a lot of changes were made throughout all the code,
>> most notably on patch 3=2E Link for the previous version is [1]=2E
>>
>> * How it was tested *
>>
>> This series was tested using an emulated QEMU RISC-V host booting a QEM=
U
>> KVM guest, passing through an emulated e1000 network card from the host
>> to the guest=2E I can provide more details (e=2Eg=2E QEMU command lines=
) if
>> required, just let me know=2E For now this cover-letter is too much of =
an
>> essay as is=2E
>
>It would probably be helpful to document these somewhere, so others
>can use them as a starting point for running this
>

I've written up a testing procedure which I shared internally with Daniel=
=2E I'll sanitize it and post it somewhere public=2E

Thanks,
drew

>Alistair
>
>>
>> The Linux kernel used for tests can be found here:
>>
>> https://github=2Ecom/tjeznach/linux/tree/riscv_iommu_v6-rc3
>>
>> This is a newer version of the following work from Tomasz:
>>
>> https://lore=2Ekernel=2Eorg/linux-riscv/cover=2E1715708679=2Egit=2Etjez=
nach@rivosinc=2Ecom/
>> ("[PATCH v5 0/7] Linux RISC-V IOMMU Support")
>>
>> The v5 wasn't enough for the testing being done=2E v6-rc3 did the trick=
=2E
>>
>> Note that to test this work using riscv-iommu-pci we'll need to provide
>> the Rivos PCI ID in the command line=2E More details down below=2E
>>
>> * Highlights of this version *
>>
>> - patches removed from v2: platform driver (riscv-iommu-sys, former
>> patch 05) and the EDU changes (patches 14 and 15)=2E The platform drive=
r
>> will be sent later with a working example on the 'virt' machine,
>> either on a newer version of this series or via a follow-up series=2E W=
e
>> already have a PoC on [2] created by Sunil=2E More tests are needed, so
>> it'll be left behind for now=2E The EDU changes will be sent in separat=
e
>> after I finish the doc changes that Frank cited in v2=2E
>>
>> - patch 3 contains the bulk of changes made from v2=2E Please give spec=
ial
>> attention to the following functions since this is entirely new code I
>> ended up adding:
>>
>>  - riscv_iommu_report_fault()
>>  - riscv_iommu_validate_device_ctx()
>>  - riscv_iommu_update_ipsr()
>>
>>   Aside from these helpers most of the changes made in this patch 3 wer=
e
>> punctual=2E
>>
>> - Red HAT PCI ID related changes=2E A new patch (4) that introduces a
>> generic RISC-V IOMMU PCI ID was added=2E This PCI ID was gracefully giv=
en
>> to us by Red Hat and Gerd Hoffman from their ID space=2E The
>> riscv-iommu-pci device now defaults to this PCI ID instead of Rivos PCI
>> ID=2E The device was changed slightly to allow vendor-id and device-id =
to
>> be set in the command-line, so it's now possible to use this reference
>> device as another RISC-V IOMMU PCI device to ease the burden of
>> testing/development=2E
>>
>>   To instantiate the riscv-iommu-pci device using the previous Rivos PC=
I
>> ID, use the following cmd line:
>>
>>   -device riscv-iommu-pci,vendor-id=3D0x1efd,device-id=3D0xedf1
>>
>>   I'm using these options to test the series with the existing Linux RI=
SC-V
>> IOMMU support that uses just a Rivos ID to identify the device=2E
>>
>>
>> Series based on alistair/riscv-to-apply=2Enext=2E It's also applicable =
on
>> current QEMU master=2E It can also be fetched from:
>>
>> https://gitlab=2Ecom/danielhb/qemu/-/tree/riscv_iommu_v3
>>
>>
>> Patches missing reviews/acks: 3, 5, 9, 10, 11=2E
>>
>> Changes from v2 [1]:
>> - patch 05 (hw/riscv: add riscv-iommu-sys platform device): dropped
>>   - will be reintroduced in a later review or as a follow-up series
>>
>> - patches 14 and 15: dropped
>>   - will be sent in separate
>>
>> - patches 2, 3, 4 and 5:
>>   - removed all 'Ziommu' references
>>
>> - patch 2:
>>   - added extra bits that patch 3 ended up using
>>
>> - patch 3:
>>   - fixed blank line at EOF in hw/riscv/trace=2Eh
>>   - added a riscv_iommu_report_fault() helper to report faults=2E The h=
elper checks if
>>     a given fault is eligible to be reported if DTF is 1
>>   - Use riscv_iommu_report_fault() in riscv_iommu_ctx() and riscv_iommu=
_translate()
>>     to avoid code repetition
>>   - added a riscv_iommu_validate_device_ctx() helper to validate the de=
vice context
>>     as specified in "Device configuration checks" section=2E This helpe=
r is being used
>>     in riscv_iommu_ctx_fetch()
>>   - added a new riscv_iommu_update_ipsr() helper to handle IPSR updates
>>     in riscv_iommu_mmio_write()
>>   - riscv_iommmu_msi_write() now reports a fault in all error paths
>>   - check for fctl=2EWSI before issuing a MSI interrupt in riscv_iommu_=
notify()
>>   - change riscv-iommu region name to 'riscv-iommu'
>>   - change address_space_init() name for PCI devices to 'name' instead =
of using TYPE_RISCV_IOMMU_PCI
>>   - changed riscv_iommu_mmio_ops min_access_size to 4
>>   - do not check for min and max sizes on riscv_iommu_mmio_write()
>>   - changed riscv_iommu_trap_ops  min_access_size to 4
>>   - removed IOMMU qemu_thread thread:
>>     - riscv_iommu_mmio_write() will now execute a riscv_iommu_process_f=
n by holding
>>       'core_lock'
>>   - init FSCR as zero explicitly
>>   - check for bus->iommu_opaque =3D=3D NULL before calling pci_setup_io=
mmu()
>>
>> - patch 4 (new):
>>   - add Red-Hat PCI RISC-V IOMMU ID
>>
>> - patch 5 (former 4):
>>   - create vendor-id and device-id properties
>>   - set Red-hat PCI RISC-V IOMMU ID as default ID
>>
>> - patch 8:
>>   - use IOMMU_NONE instead of '0' in relevant 'iot->perm =3D 0' instanc=
es
>>
>> - patch 9:
>>   - add s-stage and g-stage steps in riscv_iommu_validate_device_ctx()
>>   - removed 'gpa' boolean from riscv_iommu_spa_fetch()
>>   - 'en_s' is no longer used for early MSI address match
>>
>> - patch 10:
>>   - add ATS steps in riscv_iommu_validate_device_ctx()
>>   - check for 's->enable_ats' before adding RISCV_IOMMU_DC_TC_EN_ATS in=
 device context
>>   - check for 's->enable_ats' before processing ATS commands in riscv_i=
ommu_process_cq_tail()
>>   - remove ambiguous trace_riscv_iommu_ats() from riscv_iommu_translate=
()
>>
>> - patch 11:
>>   - removed unused bits
>>   - added RISCV_IOMMU_TR_REQ_CTL_NW and RISCV_IOMMU_TR_RESPONSE_S
>>     bits
>>   - set IOMMUTLBEntry 'perm' using RISCV_IOMMU_TR_REQ_CTL_NW in riscv_i=
ommu_process_dbg()
>>   - clear RISCV_IOMMU_TR_RESPONSE_S in riscv_iommu_process_dbg()=2E Add=
ed a comment talking about the (lack of) superpage support
>>
>> [1] https://lore=2Ekernel=2Eorg/qemu-riscv/20240307160319=2E675044-1-db=
arboza@ventanamicro=2Ecom/
>> [2] https://github=2Ecom/vlsunil/qemu/commits/acpi_rimt_poc_v1/
>>
>> Andrew Jones (1):
>>   hw/riscv/riscv-iommu: Add another irq for mrif notifications
>>
>> Daniel Henrique Barboza (3):
>>   pci-ids=2Erst: add Red Hat pci-id for RISC-V IOMMU device
>>   test/qtest: add riscv-iommu-pci tests
>>   qtest/riscv-iommu-test: add init queues test
>>
>> Tomasz Jeznach (9):
>>   exec/memtxattr: add process identifier to the transaction attributes
>>   hw/riscv: add riscv-iommu-bits=2Eh
>>   hw/riscv: add RISC-V IOMMU base emulation
>>   hw/riscv: add riscv-iommu-pci reference device
>>   hw/riscv/virt=2Ec: support for RISC-V IOMMU PCIDevice hotplug
>>   hw/riscv/riscv-iommu: add Address Translation Cache (IOATC)
>>   hw/riscv/riscv-iommu: add s-stage and g-stage support
>>   hw/riscv/riscv-iommu: add ATS support
>>   hw/riscv/riscv-iommu: add DBG support
>>
>>  docs/specs/pci-ids=2Erst           |    2 +
>>  hw/riscv/Kconfig                 |    4 +
>>  hw/riscv/meson=2Ebuild             |    1 +
>>  hw/riscv/riscv-iommu-bits=2Eh      |  416 ++++++
>>  hw/riscv/riscv-iommu-pci=2Ec       |  177 +++
>>  hw/riscv/riscv-iommu=2Ec           | 2283 ++++++++++++++++++++++++++++=
++
>>  hw/riscv/riscv-iommu=2Eh           |  146 ++
>>  hw/riscv/trace-events            |   15 +
>>  hw/riscv/trace=2Eh                 |    1 +
>>  hw/riscv/virt=2Ec                  |   33 +-
>>  include/exec/memattrs=2Eh          |    5 +
>>  include/hw/pci/pci=2Eh             |    1 +
>>  include/hw/riscv/iommu=2Eh         |   36 +
>>  meson=2Ebuild                      |    1 +
>>  tests/qtest/libqos/meson=2Ebuild   |    4 +
>>  tests/qtest/libqos/riscv-iommu=2Ec |   76 +
>>  tests/qtest/libqos/riscv-iommu=2Eh |  100 ++
>>  tests/qtest/meson=2Ebuild          |    1 +
>>  tests/qtest/riscv-iommu-test=2Ec   |  234 +++
>>  19 files changed, 3535 insertions(+), 1 deletion(-)
>>  create mode 100644 hw/riscv/riscv-iommu-bits=2Eh
>>  create mode 100644 hw/riscv/riscv-iommu-pci=2Ec
>>  create mode 100644 hw/riscv/riscv-iommu=2Ec
>>  create mode 100644 hw/riscv/riscv-iommu=2Eh
>>  create mode 100644 hw/riscv/trace-events
>>  create mode 100644 hw/riscv/trace=2Eh
>>  create mode 100644 include/hw/riscv/iommu=2Eh
>>  create mode 100644 tests/qtest/libqos/riscv-iommu=2Ec
>>  create mode 100644 tests/qtest/libqos/riscv-iommu=2Eh
>>  create mode 100644 tests/qtest/riscv-iommu-test=2Ec
>>
>> --
>> 2=2E44=2E0
>>
>>


