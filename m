Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD0EC44501
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:38:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wigKA-0006i1-Hb; Sat, 11 Jul 2026 18:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigK8-0006gh-Pq; Sat, 11 Jul 2026 18:37:28 -0400
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([52.34.181.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=645f258d4=graf@amazon.de>)
 id 1wigK4-00052k-45; Sat, 11 Jul 2026 18:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1783809444; x=1815345444;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=0MKEuEIpD/FHAfSva87FmUKmiVL9WQehnJOSvluca2w=;
 b=WXaXF6eWebdmLFoqvka/hcfqVHs2nXm7rfTQ1UVo5FpZeEYCBn+8gA6S
 FO7eAEQ16i1dcSMWT6+ieMMV11MDOLAhDt6NYBx7+3Vmyumbpuuf7nN2K
 N75s5bgrB2hTbf1sxamATkE6Eajp69ArvTGKaPM8Ek7mSm3H9hEAx5pju
 lzroYK8w8MUcYUTvSN9gA6Q+I/f0AnNGQXk/OkhnpCeMNKArfXdrrWjgB
 +F2BVvfHP/8tWORuUtMYbWhSh7xz0ttWso92+ebZMBK7mZ6Hn1KZnwdZL
 LNIhhHen74ZeelhNxKuxRepPAADCElcCwHw0ViWGvf3FUzqINxz93RJIZ w==;
X-CSE-ConnectionGUID: Wjor8/OmTUqgD+KyUpWdDQ==
X-CSE-MsgGUID: KQFWUnnASmy4JAWAlHW7Vw==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; d="scan'208";a="23483171"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2026 22:37:18 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:11904]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.68:2525]
 with esmtp (Farcaster)
 id c466f816-c2d3-4d53-a3c8-aaf661ab8962; Sat, 11 Jul 2026 22:37:18 +0000 (UTC)
X-Farcaster-Flow-ID: c466f816-c2d3-4d53-a3c8-aaf661ab8962
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:37:17 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Sat, 11 Jul 2026 22:37:08 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, <qemu-ppc@nongnu.org>, <qemu-riscv@nongnu.org>,
 <qemu-s390x@nongnu.org>, Song Gao <17746591750@163.com>, Aditya Gupta
 <adityag@linux.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, Farhan Ali
 <alifm@linux.ibm.com>, Alistair Francis <alistair.francis@wdc.com>, "Alistair
 Francis" <alistair@alistair23.me>, Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi
 <balbi@kernel.org>, Christian Borntraeger <borntraeger@linux.ibm.com>, "Brian
 Cain" <brian.cain@oss.qualcomm.com>, Hendrik Brueckner
 <brueckner@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>, "Huacai
 Chen" <chenhuacai@kernel.org>, =?UTF-8?q?Cl=C3=A9ment=20Chigot?=
 <chigot@adacore.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>, Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "Gautam Gala" <ggala@linux.ibm.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?=
 <hpoussin@reactos.org>, Jan Kiszka <jan.kiszka@web.de>, Max Filippov
 <jcmvbkbc@gmail.com>, Joel Stanley <joel@jms.id.au>, Jared Rossi
 <jrossi@linux.ibm.com>, Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, "Laurent Vivier" <laurent@vivier.eu>, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>, Bibo Mao
 <maobibo@loongson.cn>, "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 "Michael Rolnik" <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 "Niek Linnenbank" <nieklinnenbank@gmail.com>, Nicholas Piggin
 <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Halil Pasic
 <pasic@linux.ibm.com>, "Paolo Bonzini" <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, "Pierrick Bouvier" <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>, Sai Pavan Boddu
 <sai.pavan.boddu@amd.com>, Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow
 <shentey@gmail.com>, Stafford Horne <shorne@gmail.com>, Sergio Lopez
 <slp@redhat.com>, "Subbaraya Sundeep" <sundeep.lkml@gmail.com>, Thomas Huth
 <th.huth+qemu@posteo.eu>, "Ran Wang" <wangran@bosc.ac.cn>, Hao Wu
 <wuhaotsh@google.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: [RFC PATCH 000/134] qom: Make composition-tree parenting mandatory
Date: Sat, 11 Jul 2026 22:34:53 +0000
Message-ID: <20260711223707.42139-1-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Received-SPF: pass client-ip=52.34.181.151;
 envelope-from=prvs=645f258d4=graf@amazon.de;
 helo=pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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


Motivation
----------
Markus observed [1] that a device reaching realize without a
composition-tree parent is a modeling bug, and that the
/machine/unattached container that catches such devices today is a
bug attractor rather than a safety net: it hides the fact that nobody
decided "what is part of what", and it gives the object an unstable,
implementation-defined QOM path that is useless for qom-get/qom-set and
for management tools that want to address board-created devices.

This series makes composition-tree parenting mandatory.  After it,
device_set_realized() errors on a device with no parent,
memory_region_do_init() asserts that a named region has an owner,
qdev_connect_gpio_out_named() asserts that the pin being wired has a
parent, and /machine/unattached is deleted.  Every board-created object
has a stable, human-chosen path.

[1] https://lore.kernel.org/qemu-devel/87jyr3w9tc.fsf@pond.sub.org/

Approach
--------
Rather than add a parallel "parented" API and migrate callers over
years, each creation helper is converted in a single rename->reintroduce
pair: a tree-wide Coccinelle rename of foo() to foo_orphan(), followed
immediately by a patch that reintroduces foo() with a leading
(Object *parent, const char *id, ...) signature.  The tree builds after
every patch and never carries two spellings of the same helper.

The bulk of the series then converts *_orphan() call sites to the
parented form, one hw/ subdirectory per patch.  Most of those commits
carry a per-callsite table in the commit message giving the chosen
parent expression, the chosen child name, and the one-line reason
("board init -> machine", "realize of X -> X", ...); the smaller ones
carry a prose summary of the same.  Those tables are the substance the
RFC is asking maintainers to review: the mechanical part is trivial,
the modeling decisions are not.

Some hw/arm commit messages carry wide per-callsite tables that exceed
76 columns; please view with a fixed-width, non-wrapping mail reader.

Once no *_orphan() callers remain the _orphan variants are deleted, the
enforcement checks are armed, and /machine/unattached is removed.

Series shape
------------
  001-009   core API: object_new_child(); rename->reintroduce for
            qdev_new, sysbus_create_*, pci_new*, isa_new*,
            i2c_slave_*, ssi/usb/sd/adb/virtio/hda/aux/spapr-vio,
            cpu_create
  010-082   hw/*: convert *_orphan() call sites to the parented form,
            one subdirectory per patch, each with a per-callsite
            reasoning table (or prose summary) in the commit message
  083-088   delete the qdev/sysbus/pci/isa/i2c/ssi/usb/cpu *_orphan()
            creator variants
  089-107   memory: give the remaining owner==NULL memory regions an
            owner, then assert on owner==NULL for named regions
  108-116   irq: rename->reintroduce qemu_allocate_irq*() with an
            owner and name; convert callers; delete _orphan variants
  117-130   parent the remaining non-device singletons and per-device
            helper objects (main-system-bus, accel, reset container,
            per-MR helpers, per-devfn IOMMU objects, board-created
            CPUs, ...)
  131-132   arm the enforcement checks and delete /machine/unattached
  133-134   docs/devel/qom.rst: parenting contract; MAINTAINERS

The Coccinelle scripts used for the rename steps are included under
scripts/coccinelle/qom-parent/ and referenced from the corresponding
commit messages.

Not converted in this series
----------------------------
A handful of long-lived objects are deliberately left path-less for
now, each for a specific lifecycle reason called out in the relevant
commit message:

  * TYPE_MIGRATION is a TYPE_DEVICE that is never realized, per the
    upstream comment "TODO make this TYPE_OBJECT once QOM provides
    -global for objects".  Parenting it under /machine trips the
    qdev_assert_realized_properly() walk.  It can move under /machine
    once it becomes a plain TYPE_OBJECT.
  * RamDiscardManager is unref'd from memory_region_finalize() itself,
    so making it a child<> of the MR would use-after-free during MR
    teardown.
  * TPM backends and VFIO IOMMU containers are user-configurable and
    dynamically created; they belong under /objects/<id> or a
    dedicated /machine/vfio container respectively, and are best
    handled in a follow-up on top of this series.
  * QIOChannel* and per-mapping virtio-shmem objects remain path-less
    by design (transient, refcounted, no stable identity).

Verification
------------
  * The tree builds for 20 softmmu targets after every patch.
  * Every machine type across those targets was smoke-tested with
    "-M <machine> -S"; none abort on the new assertions.
  * "info qom-tree" on q35 and on aarch64 virt shows no
    /machine/unattached node after the final patch.
  * grep -r 'machine_get_container("unattached")' returns no hits.

AI-assistance disclosure (docs/devel/code-provenance.rst)
----------------------------------------------------------
Every patch in this series was produced with AI assistance and
reviewed by the human submitter.  Each commit carries an

    Assisted-by: Kiro

trailer following the format documented in the Linux kernel's
Documentation/process/coding-assistants.rst.  The tree-wide rename
patches are Coccinelle-equivalent mechanical transforms; the
per-callsite parent/name choices in the hw/* commits are the
AI-assisted modeling decisions this RFC is asking maintainers to
review.

QEMU's current policy in docs/devel/code-provenance.rst is to decline
AI-generated contributions absent an explicit exception.  This RFC is
therefore posted to open that discussion: I am requesting an exception
for this series (or, if the community prefers, will reauthor the parts
the policy requires) and will not post a non-RFC v1 until that is
resolved on qemu-devel.  The Signed-off-by DCO certification is mine
as the human reviewer taking full responsibility for the contribution.


Alexander Graf (134):
  qom: Introduce object_new_child()
  qdev: Rename qdev_new()/qdev_try_new() to *_orphan()
  qdev: Reintroduce qdev_new() with a mandatory QOM parent
  sysbus: Make sysbus_create_simple()/_varargs() take a QOM parent
  pci: Make pci_new*()/pci_create_simple*() take a QOM parent
  isa: Make isa_new()/isa_try_new()/isa_create_simple() take a QOM
    parent
  i2c: Make i2c_slave_new()/i2c_slave_create_simple() take a QOM parent
  ssi, usb: Make bus-layer creators take a QOM parent
  cpu: Make cpu_create() take a QOM parent
  hw/avr: Give onboard devices a QOM parent
  hw/tricore: Give onboard devices a QOM parent
  hw/xtensa: Give onboard devices a QOM parent
  hw/alpha: Give onboard devices a QOM parent
  hw/nitro: Give onboard devices a QOM parent
  hw/vmapple: Give onboard devices a QOM parent
  hw/hppa: Give onboard devices a QOM parent
  hw/microblaze: Give onboard devices a QOM parent
  hw/sh4: Give onboard devices a QOM parent
  hw/s390x: Give onboard devices a QOM parent
  hw/or1k: Give onboard devices a QOM parent
  hw/loongarch: Give onboard devices a QOM parent
  hw/intc: Give onboard devices a QOM parent
  hw/pci-host: Give onboard devices a QOM parent
  hw/core: Give onboard devices a QOM parent
  hw/remote: Give onboard devices a QOM parent
  hw/ufs: Give onboard devices a QOM parent
  hw/nvme: Give onboard devices a QOM parent
  hw/vfio: Give onboard devices a QOM parent
  hw/mem: Give onboard devices a QOM parent
  hw/cxl: Give onboard devices a QOM parent
  hw/hexagon: Give onboard devices a QOM parent
  hw/xen: Give onboard devices a QOM parent
  hw/display: Give onboard devices a QOM parent
  hw/nvram: Give onboard devices a QOM parent
  hw/dma: Give onboard devices a QOM parent
  hw/misc: Give onboard devices a QOM parent
  hw/scsi: Give onboard devices a QOM parent
  hw/net: Give onboard devices a QOM parent
  hw/ide: Give onboard devices a QOM parent
  hw/i3c: Give onboard devices a QOM parent
  hw/pci-bridge: Give onboard devices a QOM parent
  hw/sparc64: Give onboard devices a QOM parent
  hw/sparc: Give onboard devices a QOM parent
  hw/m68k: Give onboard devices a QOM parent
  hw/rtc: Give onboard devices a QOM parent
  hw/i2c: Give onboard devices a QOM parent
  hw/block: Give onboard devices a QOM parent
  hw/char: Give onboard devices a QOM parent
  hw/isa: Give onboard devices a QOM parent
  hw/pci: Give onboard devices a QOM parent
  hw/riscv: Give onboard devices a QOM parent
  hw/mips: Give onboard devices a QOM parent
  hw/i386: Give onboard devices a QOM parent
  hw/ppc: Give onboard devices a QOM parent
  hw/pci, hw/isa: Give VGA and slot-NIC helpers a QOM parent
  hw/arm/virt: Give onboard devices a QOM parent
  hw/arm/sbsa-ref: Give onboard devices a QOM parent
  hw/arm/xilinx-zynq: Give onboard devices a QOM parent
  hw/arm/xlnx-versal, xlnx-zynqmp: Give onboard devices a QOM parent
  hw/arm/realview, integratorcp: Give onboard devices a QOM parent
  hw/arm/npcm: Give onboard devices a QOM parent
  hw/arm/versatile, vexpress: Give onboard devices a QOM parent
  hw/arm/stellaris, musicpal: Give onboard devices a QOM parent
  hw/arm/exynos: Give onboard devices a QOM parent
  hw/arm/allwinner: Give onboard devices a QOM parent
  hw/arm/strongarm: Give onboard devices a QOM parent
  hw/arm/omap: Give onboard devices a QOM parent
  hw/arm/mps2: Give onboard devices a QOM parent
  hw/arm/imx: Give onboard devices a QOM parent
  hw/arm/misc: Give onboard devices a QOM parent
  hw/arm/aspeed: Give onboard devices a QOM parent (part 1)
  hw/arm/aspeed: Give onboard devices a QOM parent (part 2)
  hw/nvram/at24c: Give at24c_eeprom_init() a QOM parent
  hw/i386/pc: Give pcspk a QOM parent
  hw/timer, hw/net: Give i8254 and isa-ne2000 helpers a QOM parent
  hw/misc/unimp: Give create_unimplemented_device() a QOM parent
  hw/usb: Give -usbdevice and auto-hub devices a QOM parent
  hw/audio: Give -audio model= devices a QOM parent
  hw/xen: Give xenstore-driven backend devices a QOM parent
  hw/nitro: Give the vsock bridge a QOM parent
  hw/isa: Give the isabus-bridge a QOM parent
  net, target/mips: Give -nic and CPU-with-clock helpers a QOM parent
  usb, ssi, i2c: Remove *_orphan() creator variants
  isa: Remove *_orphan() creator variants
  pci: Remove *_orphan() creator variants
  cpu: Remove cpu_create_orphan()
  sysbus: Remove *_orphan() creator variants
  qdev: Remove qdev_new_orphan() and qdev_try_new_orphan()
  memory: Accept non-device owners in memory_region_init_ram()
  hw/misc-boards: Give memory regions an explicit owner
  hw/mips: Give memory regions an explicit owner
  hw/riscv: Give memory regions an explicit owner
  hw/i386: Give memory regions an explicit owner
  hw/arm: Give memory regions an explicit owner
  hw/arm/omap1: Give memory regions an explicit owner
  hw/sh4: Give memory regions an explicit owner
  hw/m68k: Give memory regions an explicit owner
  hw/ppc: Give memory regions an explicit owner
  hw/tricore: Give memory regions an explicit owner
  hw/xtensa: Give memory regions an explicit owner
  hw/display: Give memory regions an explicit owner
  hw/arm/omap: Give lcdc and dma memory regions an explicit owner
  hw/char: Give parallel and htif memory regions an explicit owner
  hw/remote: Give memory regions an explicit owner
  system, backends: Give named memory regions an explicit owner
  hw/ide: Let ide_init_ioport() take an explicit owner
  memory: Require an owner for named memory regions
  irq: Rename qemu_allocate_irq*() and friends to *_orphan()
  irq: Reintroduce qemu_allocate_irq*() with a mandatory owner and name
  hw/pci, hw/usb, system: Give allocated IRQs an owner and name
  hw/i386, hw/xen: Give allocated IRQs an owner and name
  hw/arm: Give allocated IRQs an owner and name
  hw/xtensa: Give allocated IRQs an owner and name
  hw: Give allocated IRQs an owner and name
  hw/core: Parent GPIO input IRQs and embedded IRQState via QOM
  irq: Delete the *_orphan() IRQ allocation variants
  sysbus: Parent main-system-bus directly under /machine
  accel: Parent the accelerator singleton under /machine
  hw/core/reset: Give the root reset container and legacy shims a QOM
    path
  system: Parent per-MR helper objects under their owner
  hw/virtio, hw/display: Parent per-device helper objects
  hw/i386/amd_iommu: Parent internally-created AMDVI-PCI under the IOMMU
  hw/s390x, hw/remote: Parent per-devfn IOMMU objects
  hw/pci-host/raven: Parent the OR-IRQ under the host bridge
  hw/arm/mps2: Parent the OR-IRQ gates under the machine
  hw/arm/digic: Parent the DIGIC SoC under the machine
  hw/microblaze: Parent the CPU under the machine
  hw: Pair object_initialize_child() with plain realize()
  hw: Parent board-created CPUs under the machine
  hw/pci-host/versatile: Use object_initialize_child() for pci_dev
  docs, qapi, scripts, iotests: Update /machine/unattached path
    references
  qom: Delete /machine/unattached and error on unparented realize
  docs/devel/qom: Document the composition-tree parenting contract
  MAINTAINERS: Add scripts/coccinelle/qom-parent/ under QOM

 MAINTAINERS                                   |   1 +
 accel/accel-system.c                          |   4 +-
 backends/igvm.c                               |   6 +-
 bsd-user/main.c                               |   3 +-
 docs/devel/qom.rst                            |  96 +++++++
 docs/devel/s390-cpu-topology.rst              |   2 +-
 docs/system/cpu-hotplug.rst                   |   4 +-
 hw/alpha/alpha_sys.h                          |   3 +-
 hw/alpha/dp264.c                              |  16 +-
 hw/alpha/typhoon.c                            |  10 +-
 hw/arm/allwinner-a10.c                        |   4 +-
 hw/arm/allwinner-h3.c                         |  34 ++-
 hw/arm/allwinner-r40.c                        |   4 +-
 hw/arm/armsse.c                               |  13 +-
 hw/arm/aspeed.c                               |  39 +--
 hw/arm/aspeed_ast1040_evb.c                   |   6 +-
 hw/arm/aspeed_ast10x0_evb.c                   |  12 +-
 hw/arm/aspeed_ast2400_palmetto.c              |   8 +-
 hw/arm/aspeed_ast2400_quanta-q71l.c           |  18 +-
 hw/arm/aspeed_ast2400_supermicrox11.c         |   8 +-
 hw/arm/aspeed_ast2500_evb.c                   |   7 +-
 hw/arm/aspeed_ast2500_g220a.c                 |  11 +-
 hw/arm/aspeed_ast2500_romulus.c               |   3 +-
 hw/arm/aspeed_ast2500_supermicro-x11spi.c     |   8 +-
 hw/arm/aspeed_ast2500_tiogapass.c             |  13 +-
 hw/arm/aspeed_ast2500_witherspoon.c           |  34 +--
 hw/arm/aspeed_ast2500_yosemitev2.c            |  13 +-
 hw/arm/aspeed_ast2600_anacapa.c               |  51 ++--
 hw/arm/aspeed_ast2600_bletchley.c             |  33 ++-
 hw/arm/aspeed_ast2600_catalina.c              |  99 +++----
 hw/arm/aspeed_ast2600_evb.c                   |   7 +-
 hw/arm/aspeed_ast2600_fby35.c                 |  20 +-
 hw/arm/aspeed_ast2600_fuji.c                  | 111 ++++----
 hw/arm/aspeed_ast2600_gb200nvl.c              |  24 +-
 hw/arm/aspeed_ast2600_rainier.c               | 188 ++++++++------
 hw/arm/aspeed_ast27x0-fc.c                    |   9 +-
 hw/arm/aspeed_ast27x0_evb.c                   |   3 +-
 hw/arm/aspeed_soc_common.c                    |  14 +-
 hw/arm/bananapi_m2u.c                         |   6 +-
 hw/arm/collie.c                               |   6 +-
 hw/arm/cubieboard.c                           |   6 +-
 hw/arm/digic_boards.c                         |   5 +-
 hw/arm/exynos4210.c                           |  70 ++---
 hw/arm/exynos4_boards.c                       |  15 +-
 hw/arm/fsl-imx25.c                            |   2 +-
 hw/arm/fsl-imx31.c                            |   2 +-
 hw/arm/fsl-imx6.c                             |   7 +-
 hw/arm/fsl-imx6ul.c                           |  37 +--
 hw/arm/fsl-imx7.c                             |  41 +--
 hw/arm/fsl-imx8mm.c                           |   2 +-
 hw/arm/fsl-imx8mp.c                           |   2 +-
 hw/arm/imx25_pdk.c                            |   6 +-
 hw/arm/imx8mm-evk.c                           |   6 +-
 hw/arm/imx8mp-evk.c                           |   6 +-
 hw/arm/integratorcp.c                         |  56 ++--
 hw/arm/kzm.c                                  |   6 +-
 hw/arm/max78000_soc.c                         | 107 ++++----
 hw/arm/max78000fthr.c                         |   5 +-
 hw/arm/mcimx6ul-evk.c                         |   4 +-
 hw/arm/mcimx7d-sabre.c                        |   4 +-
 hw/arm/mps2-tz.c                              |  27 +-
 hw/arm/mps2.c                                 |  91 ++++---
 hw/arm/mps3r.c                                |  20 +-
 hw/arm/msf2-soc.c                             |  24 +-
 hw/arm/msf2-som.c                             |  12 +-
 hw/arm/musca.c                                |   4 +-
 hw/arm/musicpal.c                             |  50 ++--
 hw/arm/netduino2.c                            |   5 +-
 hw/arm/netduinoplus2.c                        |   5 +-
 hw/arm/npcm7xx.c                              |  95 +++----
 hw/arm/npcm7xx_boards.c                       | 117 +++++----
 hw/arm/npcm8xx.c                              | 147 +++++------
 hw/arm/npcm8xx_boards.c                       |  19 +-
 hw/arm/nrf51_soc.c                            |   4 +-
 hw/arm/olimex-stm32-h405.c                    |   5 +-
 hw/arm/omap1.c                                | 244 ++++++++++--------
 hw/arm/omap_sx1.c                             |  20 +-
 hw/arm/orangepi.c                             |   4 +-
 hw/arm/raspi.c                                |   4 +-
 hw/arm/realview.c                             | 113 ++++----
 hw/arm/sabrelite.c                            |   5 +-
 hw/arm/sbsa-ref.c                             |  76 +++---
 hw/arm/stellaris.c                            |  99 ++++---
 hw/arm/stm32f100_soc.c                        |  62 ++---
 hw/arm/stm32f205_soc.c                        |   2 +-
 hw/arm/stm32f405_soc.c                        |  88 +++----
 hw/arm/stm32l4x5_soc.c                        |  88 +++----
 hw/arm/stm32vldiscovery.c                     |   5 +-
 hw/arm/strongarm.c                            |  27 +-
 hw/arm/strongarm.h                            |   2 +-
 hw/arm/versatilepb.c                          |  85 +++---
 hw/arm/vexpress.c                             |  87 ++++---
 hw/arm/virt.c                                 |  97 +++----
 hw/arm/xilinx_zynq.c                          | 160 ++++++------
 hw/arm/xlnx-versal-virt.c                     |   5 +-
 hw/arm/xlnx-versal.c                          | 197 ++++++--------
 hw/arm/xlnx-zcu102.c                          |  14 +-
 hw/arm/xlnx-zynqmp.c                          |   8 +-
 hw/audio/intel-hda.c                          |   4 +-
 hw/audio/model.c                              |   5 +-
 hw/avr/atmega.c                               |  24 +-
 hw/block/fdc-sysbus.c                         |  13 +-
 hw/block/fdc.c                                |   4 +-
 hw/block/pflash_cfi01.c                       |   6 +-
 hw/block/pflash_cfi02.c                       |   6 +-
 hw/block/xen-block.c                          |   5 +-
 hw/char/diva-gsp.c                            |   3 +-
 hw/char/exynos4210_uart.c                     |   6 +-
 hw/char/mcf_uart.c                            |  11 +-
 hw/char/mchp_pfsoc_mmuart.c                   |   4 +-
 hw/char/omap_uart.c                           |   4 +-
 hw/char/parallel-isa.c                        |  10 +-
 hw/char/parallel.c                            |   5 +-
 hw/char/pl011.c                               |   6 +-
 hw/char/riscv_htif.c                          |   5 +-
 hw/char/serial-isa.c                          |  11 +-
 hw/char/serial-mm.c                           |   6 +-
 hw/char/sifive_uart.c                         |   8 +-
 hw/char/spapr_vty.c                           |   6 +-
 hw/char/xen_console.c                         |   7 +-
 hw/core/cpu-common.c                          |   6 +-
 hw/core/gpio.c                                |  24 +-
 hw/core/irq.c                                 |  38 +--
 hw/core/null-machine.c                        |   2 +-
 hw/core/qdev-user.c                           |   6 +-
 hw/core/qdev.c                                |  39 ++-
 hw/core/reset.c                               |  13 +-
 hw/core/sysbus.c                              |  22 +-
 hw/cxl/cxl-host.c                             |   9 +-
 hw/display/cg3.c                              |   2 +-
 hw/display/g364fb.c                           |   2 +-
 hw/display/macfb.c                            |   2 +-
 hw/display/omap_lcdc.c                        |   5 +-
 hw/display/sii9022.c                          |   2 +-
 hw/display/sm501.c                            |   6 +-
 hw/display/vhost-user-gpu.c                   |  12 +-
 hw/display/virtio-gpu-gl.c                    |   2 +-
 hw/display/vmware_vga.c                       |   2 +-
 hw/display/xlnx_dp.c                          |  14 +-
 hw/dma/i8257.c                                |  10 +-
 hw/dma/omap_dma.c                             |   9 +-
 hw/dma/rc4030.c                               |   7 +-
 hw/hexagon/hexagon_dsp.c                      |  21 +-
 hw/hexagon/virt.c                             |  29 +--
 hw/hppa/machine.c                             |  96 ++++---
 hw/i2c/aspeed_i2c.c                           |   4 +-
 hw/i2c/core.c                                 |  22 +-
 hw/i2c/smbus_eeprom.c                         |  11 +-
 hw/i386/amd_iommu.c                           |   3 +-
 hw/i386/isapc.c                               |  17 +-
 hw/i386/kvm/clock.c                           |   4 +-
 hw/i386/kvm/clock.h                           |   2 +-
 hw/i386/kvm/i8259.c                           |   8 +-
 hw/i386/kvm/xen-stubs.c                       |   2 +-
 hw/i386/kvm/xen_evtchn.c                      |   6 +-
 hw/i386/kvm/xen_evtchn.h                      |   3 +-
 hw/i386/kvm/xen_gnttab.c                      |   6 +-
 hw/i386/kvm/xen_gnttab.h                      |   2 +-
 hw/i386/kvm/xen_overlay.c                     |   6 +-
 hw/i386/kvm/xen_overlay.h                     |   2 +-
 hw/i386/kvm/xen_primary_console.c             |   5 +-
 hw/i386/kvm/xen_primary_console.h             |   2 +-
 hw/i386/kvm/xen_xenstore.c                    |   5 +-
 hw/i386/kvm/xen_xenstore.h                    |   2 +-
 hw/i386/microvm.c                             |  34 +--
 hw/i386/nitro_enclave.c                       |   9 +-
 hw/i386/pc.c                                  |  96 +++----
 hw/i386/pc_piix.c                             |  28 +-
 hw/i386/pc_q35.c                              |  42 +--
 hw/i386/pc_sysfw.c                            |  16 +-
 hw/i386/sgx.c                                 |   5 +-
 hw/i386/x86-common.c                          |  33 ++-
 hw/i386/x86-cpu.c                             |   4 +-
 hw/i386/xen/xen-hvm.c                         |  12 +-
 hw/i386/xen/xen-pvh.c                         |   5 +-
 hw/i386/xen/xen_pvdevice.c                    |   2 +-
 hw/i3c/core.c                                 |  19 +-
 hw/ide/ahci.c                                 |   2 +-
 hw/ide/ide-bus.c                              |   5 +-
 hw/ide/ide-internal.h                         |   2 +-
 hw/ide/ioport.c                               |  37 ++-
 hw/ide/isa.c                                  |   9 +-
 hw/ide/pci.c                                  |   2 +-
 hw/ide/piix.c                                 |   2 +-
 hw/intc/apic_common.c                         |   3 +-
 hw/intc/exynos4210_gic.c                      |   4 +-
 hw/intc/i8259.c                               |   6 +-
 hw/intc/i8259_common.c                        |   7 +-
 hw/intc/riscv_aclint.c                        |  16 +-
 hw/intc/riscv_aplic.c                         |  13 +-
 hw/intc/riscv_imsic.c                         |   7 +-
 hw/intc/s390_flic.c                           |  12 +-
 hw/intc/sh_intc.c                             |  21 +-
 hw/intc/sifive_plic.c                         |   7 +-
 hw/ipack/ipack.c                              |  11 +-
 hw/ipmi/ipmi_bt.c                             |   2 +-
 hw/ipmi/ipmi_kcs.c                            |   2 +-
 hw/isa/i82378.c                               |  13 +-
 hw/isa/isa-bus.c                              |  44 ++--
 hw/isa/isa-superio.c                          |  25 +-
 hw/isa/lpc_ich9.c                             |   2 +-
 hw/isa/piix.c                                 |   4 +-
 hw/isa/vt82c686.c                             |   7 +-
 hw/loongarch/virt.c                           |  56 ++--
 hw/m68k/an5206.c                              |  13 +-
 hw/m68k/mcf5206.c                             |   8 +-
 hw/m68k/mcf5208.c                             |  32 ++-
 hw/m68k/mcf_intc.c                            |   7 +-
 hw/m68k/next-cube.c                           |  26 +-
 hw/m68k/q800.c                                |  28 +-
 hw/m68k/virt.c                                |  25 +-
 hw/mem/sparse-mem.c                           |   6 +-
 hw/microblaze/petalogix_ml605_mmu.c           |  40 ++-
 hw/microblaze/petalogix_s3adsp1800_mmu.c      |  27 +-
 hw/microblaze/xlnx-zynqmp-pmu.c               |   4 +-
 hw/mips/boston.c                              |  32 +--
 hw/mips/cps.c                                 |   5 +-
 hw/mips/fuloong2e.c                           |  24 +-
 hw/mips/jazz.c                                |  73 +++---
 hw/mips/loongson3_virt.c                      |  40 +--
 hw/mips/malta.c                               |  49 ++--
 hw/mips/mips_int.c                            |   2 +-
 hw/misc/empty_slot.c                          |   7 +-
 hw/misc/led.c                                 |  15 +-
 hw/misc/macio/macio.c                         |   2 +-
 hw/misc/sifive_e_prci.c                       |   6 +-
 hw/misc/sifive_test.c                         |   6 +-
 hw/net/can/can_kvaser_pci.c                   |   2 +-
 hw/net/imx_fec.c                              |   4 +-
 hw/net/lan9118.c                              |  10 +-
 hw/net/smc91c111.c                            |   6 +-
 hw/net/spapr_llan.c                           |   6 +-
 hw/net/xen_nic.c                              |   5 +-
 hw/nitro/machine.c                            |  11 +-
 hw/nitro/nitro-vsock-bus.c                    |   9 +-
 hw/nubus/nubus-virtio-mmio.c                  |   2 +-
 hw/nvme/ctrl.c                                |   2 +-
 hw/nvram/eeprom_at24c.c                       |  12 +-
 hw/nvram/fw_cfg.c                             |  16 +-
 hw/or1k/or1k-sim.c                            |  25 +-
 hw/or1k/virt.c                                |  43 +--
 hw/pci-bridge/pci_expander_bridge.c           |  13 +-
 hw/pci-host/articia.c                         |   6 +-
 hw/pci-host/astro.c                           |   8 +-
 hw/pci-host/bonito.c                          |  28 +-
 hw/pci-host/grackle.c                         |   2 +-
 hw/pci-host/gt64120.c                         |   5 +-
 hw/pci-host/i440fx.c                          |   2 +-
 hw/pci-host/mv64361.c                         |   4 +-
 hw/pci-host/pnv_phb.c                         |   5 +-
 hw/pci-host/pnv_phb3.c                        |   3 +-
 hw/pci-host/pnv_phb3_msi.c                    |   3 +-
 hw/pci-host/pnv_phb4.c                        |   3 +-
 hw/pci-host/pnv_phb4_pec.c                    |   3 +-
 hw/pci-host/ppc4xx_pci.c                      |   2 +-
 hw/pci-host/ppce500.c                         |   2 +-
 hw/pci-host/raven.c                           |   6 +-
 hw/pci-host/sabre.c                           |  12 +-
 hw/pci-host/sh_pci.c                          |   3 +-
 hw/pci-host/uninorth.c                        |  11 +-
 hw/pci-host/versatile.c                       |   3 +-
 hw/pci/pci.c                                  |  60 +++--
 hw/pci/pcie_sriov.c                           |   3 +-
 hw/ppc/amigaone.c                             |  24 +-
 hw/ppc/e500.c                                 |  70 ++---
 hw/ppc/mac_newworld.c                         |  58 +++--
 hw/ppc/mac_oldworld.c                         |  32 +--
 hw/ppc/pegasos.c                              |  22 +-
 hw/ppc/pnv.c                                  |  33 +--
 hw/ppc/pnv_bmc.c                              |   4 +-
 hw/ppc/pnv_lpc.c                              |   6 +-
 hw/ppc/pnv_psi.c                              |   6 +-
 hw/ppc/ppc440.h                               |   2 +-
 hw/ppc/ppc440_bamboo.c                        |  17 +-
 hw/ppc/ppc440_uc.c                            |  10 +-
 hw/ppc/ppc4xx_sdram.c                         |  34 +--
 hw/ppc/prep.c                                 |  50 ++--
 hw/ppc/sam460ex.c                             |  72 +++---
 hw/ppc/spapr.c                                |  37 +--
 hw/ppc/spapr_irq.c                            |   6 +-
 hw/ppc/spapr_vio.c                            |   6 +-
 hw/ppc/virtex_ml507.c                         |  23 +-
 hw/remote/iommu.c                             |   5 +-
 hw/remote/machine.c                           |   6 +-
 hw/remote/memory.c                            |   3 +-
 hw/remote/vfio-user-obj.c                     |   2 +-
 hw/riscv/aia.c                                |  12 +-
 hw/riscv/aia.h                                |   3 +-
 hw/riscv/boston-aia.c                         |  31 ++-
 hw/riscv/cps.c                                |  14 +-
 hw/riscv/k230.c                               | 127 ++++-----
 hw/riscv/microblaze-v-generic.c               |  51 ++--
 hw/riscv/microchip_pfsoc.c                    |  90 +++----
 hw/riscv/opentitan.c                          |  52 ++--
 hw/riscv/shakti_c.c                           |   8 +-
 hw/riscv/sifive_e.c                           |  25 +-
 hw/riscv/sifive_u.c                           |  39 +--
 hw/riscv/spike.c                              |   8 +-
 hw/riscv/tt_atlantis.c                        |  17 +-
 hw/riscv/virt.c                               |  57 ++--
 hw/riscv/xiangshan_kmh.c                      |  20 +-
 hw/rtc/ls7a_rtc.c                             |   2 +-
 hw/rtc/mc146818rtc.c                          |   6 +-
 hw/rtc/sun4v-rtc.c                            |   6 +-
 hw/s390x/ap-bridge.c                          |   6 +-
 hw/s390x/css-bridge.c                         |   7 +-
 hw/s390x/s390-pci-bus.c                       |  12 +-
 hw/s390x/s390-virtio-ccw.c                    |  41 ++-
 hw/scsi/esp-pci.c                             |   2 +-
 hw/scsi/lasi_ncr710.c                         |   8 +-
 hw/scsi/lasi_ncr710.h                         |   4 +-
 hw/scsi/ncr53c710.c                           |  15 +-
 hw/scsi/ncr53c710.h                           |   7 +-
 hw/scsi/scsi-bus.c                            |   5 +-
 hw/scsi/spapr_vscsi.c                         |   6 +-
 hw/sh4/r2d.c                                  |  38 +--
 hw/sh4/sh7750.c                               |  35 +--
 hw/sparc/leon3.c                              |  27 +-
 hw/sparc/sun4m.c                              | 167 ++++++------
 hw/sparc64/niagara.c                          |  20 +-
 hw/sparc64/sparc64.c                          |   3 +-
 hw/sparc64/sun4u.c                            |  69 ++---
 hw/ssi/ssi.c                                  |   7 +-
 hw/timer/arm_timer.c                          |   6 +-
 hw/timer/sh_timer.c                           |   9 +-
 hw/tricore/tc27x_soc.c                        |  77 +++---
 hw/tricore/tricore_testboard.c                |  19 +-
 hw/ufs/lu.c                                   |   5 +-
 hw/usb/bus.c                                  |  15 +-
 hw/usb/dev-serial.c                           |   3 +-
 hw/usb/vt82c686-uhci-pci.c                    |   4 +-
 hw/vfio/igd.c                                 |   5 +-
 hw/virtio/virtio-mem.c                        |   5 +-
 hw/vmapple/vmapple.c                          |  66 ++---
 hw/xen/xen-bus.c                              |   5 +-
 hw/xen/xen-legacy-backend.c                   |   5 +-
 hw/xen/xen-pvh-common.c                       |  26 +-
 hw/xen/xen_pt_graphics.c                      |   3 +-
 hw/xtensa/mx_pic.c                            |   8 +-
 hw/xtensa/pic_cpu.c                           |   5 +-
 hw/xtensa/sim.c                               |  15 +-
 hw/xtensa/virt.c                              |   4 +-
 hw/xtensa/xtensa_memory.c                     |   5 +-
 hw/xtensa/xtensa_memory.h                     |   3 +-
 hw/xtensa/xtfpga.c                            |  51 ++--
 include/hw/arm/aspeed.h                       |   6 +-
 include/hw/arm/aspeed_soc.h                   |   3 +-
 include/hw/arm/exynos4210.h                   |   2 +-
 include/hw/arm/omap.h                         |  11 +-
 include/hw/block/fdc.h                        |   5 +-
 include/hw/block/flash.h                      |   4 +-
 include/hw/char/mchp_pfsoc_mmuart.h           |   2 +-
 include/hw/char/parallel.h                    |   5 +-
 include/hw/char/pl011.h                       |   2 +-
 include/hw/char/riscv_htif.h                  |   3 +-
 include/hw/char/serial-isa.h                  |   2 +-
 include/hw/char/serial-mm.h                   |   2 +-
 include/hw/char/sifive_uart.h                 |   4 +-
 include/hw/core/cpu.h                         |  11 +-
 include/hw/core/irq.h                         |  27 +-
 include/hw/core/qdev.h                        |  50 ++--
 include/hw/core/sysbus.h                      |  29 ++-
 include/hw/i2c/i2c.h                          |  29 ++-
 include/hw/i2c/smbus_eeprom.h                 |   5 +-
 include/hw/i386/pc.h                          |   6 +-
 include/hw/i386/vmport.h                      |   5 -
 include/hw/i386/x86.h                         |   7 +-
 include/hw/i3c/i3c.h                          |   9 +-
 include/hw/ide/isa.h                          |   3 +-
 include/hw/intc/i8259.h                       |   4 +-
 include/hw/intc/riscv_aclint.h                |   6 +-
 include/hw/intc/riscv_aplic.h                 |   5 +-
 include/hw/intc/riscv_imsic.h                 |   3 +-
 include/hw/intc/sifive_plic.h                 |   3 +-
 include/hw/isa/i8259_internal.h               |   3 +-
 include/hw/isa/isa.h                          |  11 +-
 include/hw/m68k/mcf.h                         |   7 +-
 include/hw/mem/sparse-mem.h                   |   2 +-
 include/hw/mips/mips.h                        |   5 +-
 include/hw/misc/empty_slot.h                  |   3 +-
 include/hw/misc/sifive_e_prci.h               |   2 +-
 include/hw/misc/sifive_test.h                 |   2 +-
 include/hw/misc/unimp.h                       |   9 +-
 include/hw/net/lan9118.h                      |   2 +-
 include/hw/net/ne2000-isa.h                   |   8 +-
 include/hw/net/smc91c111.h                    |   2 +-
 include/hw/nitro/nitro-vsock-bus.h            |   2 +-
 include/hw/nvram/eeprom_at24c.h               |   6 +-
 include/hw/pci/pci.h                          |  19 +-
 include/hw/ppc/pnv.h                          |   2 +-
 include/hw/ppc/spapr_vio.h                    |   8 +-
 include/hw/rtc/mc146818rtc.h                  |   2 +-
 include/hw/rtc/sun4v-rtc.h                    |   2 +-
 include/hw/sh4/sh.h                           |   3 +-
 include/hw/sh4/sh_intc.h                      |   3 +-
 include/hw/ssi/ssi.h                          |   3 +-
 include/hw/timer/i8254.h                      |  13 +-
 include/hw/timer/tmu012.h                     |   3 +-
 include/hw/usb/usb.h                          |  13 +-
 include/hw/xen/xen.h                          |   2 +-
 include/hw/xtensa/mx_pic.h                    |   4 +-
 include/net/net.h                             |   5 +-
 include/qom/object.h                          |  25 ++
 linux-user/main.c                             |   6 +-
 net/net.c                                     |  10 +-
 qapi/block-core.json                          |  12 +-
 qapi/block.json                               |   2 +-
 qapi/machine.json                             |  12 +-
 qapi/qom.json                                 |   4 +-
 qom/object.c                                  |  13 +
 scripts/arm_processor_error.py                |   3 +-
 .../qom-parent/cpu-create-orphan.cocci        |  13 +
 .../qom-parent/i2c-slave-new-orphan.cocci     |  18 ++
 .../coccinelle/qom-parent/irq-rename.cocci    |  14 +
 .../qom-parent/isa-new-orphan.cocci           |  23 ++
 .../qom-parent/pci-new-orphan.cocci           |  28 ++
 .../qom-parent/qdev-new-orphan.cocci          |  18 ++
 .../qom-parent/ssi-usb-orphan.cocci           |  18 ++
 .../qom-parent/sysbus-create-orphan.cocci     |  18 ++
 scripts/qmp_helper.py                         |   2 +-
 stubs/xen-hw-stub.c                           |   2 +-
 system/ioport.c                               |  12 +-
 system/memory.c                               |  23 +-
 system/physmem.c                              |   4 +-
 system/qdev-monitor.c                         |   2 +-
 system/qtest.c                                |   2 +-
 system/ram-block-attributes.c                 |   7 +-
 system/vl.c                                   |   3 +-
 target/mips/cpu.c                             |   5 +-
 target/mips/cpu.h                             |   3 +-
 target/xtensa/cpu.c                           |  11 -
 target/xtensa/cpu.h                           |   2 -
 tests/qemu-iotests/172.out                    |  72 +++---
 tests/qemu-iotests/186.out                    |  10 +-
 tests/qemu-iotests/common.filter              |   2 +-
 tests/qtest/fuzz/generic_fuzz.c               |   2 +-
 tests/unit/test-qdev-global-props.c           |  17 +-
 tests/unit/test-qdev.c                        |  12 +-
 438 files changed, 4515 insertions(+), 3784 deletions(-)
 create mode 100644 scripts/coccinelle/qom-parent/cpu-create-orphan.cocci
 create mode 100644 scripts/coccinelle/qom-parent/i2c-slave-new-orphan.cocci
 create mode 100644 scripts/coccinelle/qom-parent/irq-rename.cocci
 create mode 100644 scripts/coccinelle/qom-parent/isa-new-orphan.cocci
 create mode 100644 scripts/coccinelle/qom-parent/pci-new-orphan.cocci
 create mode 100644 scripts/coccinelle/qom-parent/qdev-new-orphan.cocci
 create mode 100644 scripts/coccinelle/qom-parent/ssi-usb-orphan.cocci
 create mode 100644 scripts/coccinelle/qom-parent/sysbus-create-orphan.cocci

-- 
2.47.1


