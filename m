Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CE0E7719F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 13:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXKC9-0005VQ-S4; Mon, 13 Jan 2025 08:09:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tXKBw-0005Ph-PO; Mon, 13 Jan 2025 08:09:16 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tXKBr-0000fQ-0U; Mon, 13 Jan 2025 08:09:15 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A2B865C4CE7;
 Mon, 13 Jan 2025 13:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB5AAC4CED6;
 Mon, 13 Jan 2025 13:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736773738;
 bh=G9AefVfbo2ddU34R7hJqCBaKTjnnsWnp240udDYJFgg=;
 h=From:To:Cc:Subject:Date:From;
 b=eABLkmXoPuGJEqF+GmtErGeQSZliYFMSp6pSynHbiin7aglBJ2Z9SAnglP34J/14i
 EGSCLEImmgRoDLieOrWVtRNY3klG9/BVzYVKS03FT4GvopnvkiMOrQ+ruICwHMLidH
 Uw7H5ePpknYvAPevAtf3yyLx04Iq+1WdL4OFSuvxekSO/uM65w6k2/RUKOoXtM1CeM
 nQIy1WAYulipFiV1kKVAxZMpTS6pdEuB5GPoSwVE6cyzqSzUf8DKGNUTmP4RHIacHY
 +dItBW6yeNxpsRY6LtbJRhHdsR4SUwAT+H9yZOL3Y6rSl0hzfE8JY7BQoGGN2+mDED
 6rbvoEWzr998Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1tXKBc-00000003Ymq-39wO; Mon, 13 Jan 2025 14:08:56 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v4 0/5] Change ghes driver to use HEST-based offsets
Date: Mon, 13 Jan 2025 14:08:46 +0100
Message-ID: <20250113130854.848688-1-mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.019,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

(patch resent as c/c ML was missing)

This series was part of the previous PR to add generic error injection
support on GHES. It depends on a cleanup patch series sent in December,
pending merge:

    https://lore.kernel.org/qemu-devel/cover.1733297707.git.mchehab+huawei@kernel.org/T/#t

It contains the changes of the math used to calculate offsets at HEST table
and hardware_error firmware file. It prepares for the addition of GHES
error injection.

The first patch was previously at the cleanup series. It prepares
the logic to support multiple sources.

The second patch adds a new firmware file to store HEST address.

The third patch use the new firmware to calculate offsets using
HEST table.

Patches 4 and 5 add migration support. They assume that this
series will be merged for qemu devel (maybe it is too late for that,
as QEMU is now on soft freeze).

Tested the following scenarios:

1. migration: QEMU 9.2 -> new QEMU with -M virt-9.2,nvdimm=on,ras=on
2. migration: new QEMU -> QEMU 9.2 -M with virt-9.2,nvdimm=on,ras=on
3. migration: new QEMU -> new QEMU with -M virt,nvdimm=on,ras=on
4. without migration with -M virt,nvdimm=on,ras=on

(virt is now an alias to virt-10.0)

Regards,
Mauro

-

The full qemu command when test backward-compatibility when running virt-9.2 is:

1) migration: QEMU 9.2 -> new QEMU with -M virt-9.2,nvdimm=on,ras=on

qemu 9.2:
	$ ../old_qemu/build/qemu-system-aarch64 -bios ../emulator/QEMU_EFI-silent.fd \
	-monitor stdio -m 4g,maxmem=8G,slots=8 -no-reboot -kernel \
	../work/arm64_build/arch/arm64/boot/Image.gz -device \
	pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd -device \
	virtio-net-pci,netdev=mynet,id=bob -drive \
	if=none,file=../emulator/debian.qcow2,format=qcow2,id=hd -object \
	memory-backend-ram,size=4G,id=mem0 -netdev \
	type=user,id=mynet,hostfwd=tcp::5555-:22 -qmp \
	tcp:localhost:4445,server=on,wait=off -M virt-9.2,nvdimm=on,ras=on -cpu \
	cortex-a57 -smp 4 -numa node,nodeid=0,cpus=0-3,memdev=mem0 -append \
	"earlycon nomodeset root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4"

	(qemu) stop
	(qemu) migrate "exec:gzip -c > STATEFILE.gz"
	(qemu) quit

qemu devel:

	$ ../qemu/build/qemu-system-aarch64 -bios ../emulator/QEMU_EFI-silent.fd -monitor \
	stdio -m 4g,maxmem=8G,slots=8 -no-reboot -kernel \
	../work/arm64_build/arch/arm64/boot/Image.gz -device \
	pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd -device \
	virtio-net-pci,netdev=mynet,id=bob -drive \
	if=none,file=../emulator/debian.qcow2,format=qcow2,id=hd -object \
	memory-backend-ram,size=4G,id=mem0 -netdev \
	type=user,id=mynet,hostfwd=tcp::5555-:22 -qmp \
	tcp:localhost:4445,server=on,wait=off -M virt-9.2,nvdimm=on,ras=on -cpu \
	cortex-a57 -smp 4 -numa node,nodeid=0,cpus=0-3,memdev=mem0 -incoming \
	"exec: gzip -c -d ../emulator/STATEFILE.gz" -append \
	"earlycon nomodeset root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4"

	(qemu) cont

	$ scripts/ghes_inject.py arm

	<error properly injected using Using old GHES lookup>

2. migration: new QEMU -> QEMU 9.2 -M with virt-9.2,nvdimm=on,ras=on

qemu devel:

	$ ../qemu/build/qemu-system-aarch64 -bios ../emulator/QEMU_EFI-silent.fd -monitor \
	stdio -m 4g,maxmem=8G,slots=8 -no-reboot -kernel \
	../work/arm64_build/arch/arm64/boot/Image.gz -device \
	pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd -device \
	virtio-net-pci,netdev=mynet,id=bob -drive \
	if=none,file=../emulator/debian.qcow2,format=qcow2,id=hd -object \
	memory-backend-ram,size=4G,id=mem0 -netdev \
	type=user,id=mynet,hostfwd=tcp::5555-:22 -qmp \
	tcp:localhost:4445,server=on,wait=off -M virt-9.2,nvdimm=on,ras=on -cpu \
	cortex-a57 -smp 4 -numa node,nodeid=0,cpus=0-3,memdev=mem0 -append \
	"earlycon nomodeset root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4"

	(qemu) stop
	(qemu) migrate "exec:gzip -c > STATEFILE.gz"
	(qemu) quit

qemu 9.2:

	$ ../old_qemu/build/qemu-system-aarch64 -bios ../emulator/QEMU_EFI-silent.fd \
	-monitor stdio -m 4g,maxmem=8G,slots=8 -no-reboot -kernel \
	../work/arm64_build/arch/arm64/boot/Image.gz -device \
	pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd -device \
	virtio-net-pci,netdev=mynet,id=bob -drive \
	if=none,file=../emulator/debian.qcow2,format=qcow2,id=hd -object \
	memory-backend-ram,size=4G,id=mem0 -netdev \
	type=user,id=mynet,hostfwd=tcp::5555-:22 -qmp \
	tcp:localhost:4445,server=on,wait=off -M virt-9.2,nvdimm=on,ras=on -cpu \
	cortex-a57 -smp 4 -numa node,nodeid=0,cpus=0-3,memdev=mem0 -incoming \
	"exec: gzip -c -d ../emulator/STATEFILE.gz" -append \
	"earlycon nomodeset root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4"
	QEMU 9.2.0 monitor - type 'help' for more information

	(qemu) cont

	$ scripts/ghes_inject.py arm

	<error properly injected using Using old GHES lookup>

3) migration: new QEMU -> new QEMU with -M virt,nvdimm=on,ras=on

	$ ./qemu/build/qemu-system-aarch64 -bios ../emulator/QEMU_EFI-silent.fd -monitor \
	stdio -m 4g,maxmem=8G,slots=8 -no-reboot -kernel \
	../work/arm64_build/arch/arm64/boot/Image.gz -device \
	pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd -device \
	virtio-net-pci,netdev=mynet,id=bob -drive \
	if=none,file=../emulator/debian.qcow2,format=qcow2,id=hd -object \
	memory-backend-ram,size=4G,id=mem0 -netdev \
	type=user,id=mynet,hostfwd=tcp::5555-:22 -qmp \
	tcp:localhost:4445,server=on,wait=off -M virt,nvdimm=on,ras=on -cpu cortex-a57 \
	-smp 4 -numa node,nodeid=0,cpus=0-3,memdev=mem0 -append \
	"earlycon nomodeset root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4"
	QEMU 9.2.50 monitor - type 'help' for more information
	(qemu) stop
	(qemu) migrate "exec:gzip -c > STATEFILE.gz"
	(qemu) quit


	$ ../qemu/build/qemu-system-aarch64 -bios ../emulator/QEMU_EFI-silent.fd -monitor \
	stdio -m 4g,maxmem=8G,slots=8 -no-reboot -kernel \
	../work/arm64_build/arch/arm64/boot/Image.gz -device \
	pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd -device \
	virtio-net-pci,netdev=mynet,id=bob -drive \
	if=none,file=../emulator/debian.qcow2,format=qcow2,id=hd -object \
	memory-backend-ram,size=4G,id=mem0 -netdev \
	type=user,id=mynet,hostfwd=tcp::5555-:22 -qmp \
	tcp:localhost:4445,server=on,wait=off -M virt,nvdimm=on,ras=on -cpu cortex-a57 \
	-smp 4 -numa node,nodeid=0,cpus=0-3,memdev=mem0 -incoming \
	"exec: gzip -c -d ../emulator/STATEFILE.gz" -append \
	"earlycon nomodeset root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4"

	(qemu) cont

	$ scripts/ghes_inject.py arm

	<error properly injected using Using new GHES lookup>

4. without migration with -M virt,nvdimm=on,ras=on

	$ ../qemu/build/qemu-system-aarch64 -bios ../emulator/QEMU_EFI-silent.fd -monitor \
	stdio -m 4g,maxmem=8G,slots=8 -no-reboot -kernel \
	../work/arm64_build/arch/arm64/boot/Image.gz -device \
	pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd -device \
	virtio-net-pci,netdev=mynet,id=bob -drive \
	if=none,file=../emulator/debian.qcow2,format=qcow2,id=hd -object \
	memory-backend-ram,size=4G,id=mem0 -netdev \
	type=user,id=mynet,hostfwd=tcp::5555-:22 -qmp \
	tcp:localhost:4445,server=on,wait=off -M virt,nvdimm=on,ras=on -cpu cortex-a57 \
	-smp 4 -numa node,nodeid=0,cpus=0-3,memdev=mem0 -append \
	"earlycon nomodeset root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4"

	$ scripts/ghes_inject.py arm

	<error properly injected using Using new GHES lookup>

---

v4:
  - migration changed from 9.1 to devel and series are rebased on the top of
    upstream master

v3: did some minor cleanups at the code, as suggested by Jonathan Cameron.

v2:
  - some whitespace and comment changes
  - patch 3/6 (acpi/ghes: rename the function which gets hw error offsets)
    was merged on the cleanup series.

*** BLURB HERE ***

Mauro Carvalho Chehab (5):
  acpi/ghes: Prepare to support multiple sources on ghes
  acpi/ghes: add a firmware file with HEST address
  acpi/ghes: Use HEST table offsets when preparing GHES records
  acpi/generic_event_device: Update GHES migration to cover hest addr
  acpi/generic_event_device: add logic to detect if HEST addr is
    available

 hw/acpi/generic_event_device.c |  30 +++++++
 hw/acpi/ghes.c                 | 156 +++++++++++++++++++++++++++++----
 hw/arm/virt-acpi-build.c       |  33 ++++++-
 hw/core/machine.c              |   5 +-
 include/hw/acpi/ghes.h         |  23 +++--
 5 files changed, 218 insertions(+), 29 deletions(-)

-- 
2.47.1


