Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41C5E7716E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 16:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIrm3-0007dr-Ca; Wed, 04 Dec 2024 10:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab@kernel.org>)
 id 1tIrly-0007bg-ME; Wed, 04 Dec 2024 10:58:43 -0500
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab@kernel.org>)
 id 1tIrlw-000757-06; Wed, 04 Dec 2024 10:58:42 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 5A772A4086D;
 Wed,  4 Dec 2024 15:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249CCC4CED2;
 Wed,  4 Dec 2024 15:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733327909;
 bh=jueMBi9DqtcIAo8jCb8vFwaEcMnWhMI0+nsU7Naunbo=;
 h=From:To:Cc:Subject:Date:From;
 b=GhUknTQVxI50Jxwu9VmhFjNs3op+lf/OTVA8FmnQWxFzTsMOfExv7I1rAuKrd9a36
 oQ68qTKjBhtWueYPiTTACBtwrN4hliJm9ufJeh4FT2jGtfTcF9fzamauhRheIlmT4O
 YULaUG/LU8ictiFlD4Qo+kQlfJB4xCvfKr7gjvjtb7aUS/TlyY4MJ90+yZxGL+8bNn
 6+ujN+JnuvLIIpNY2V8KCWA2CKqLSlTfRDka+kbtMJM9O/AWMFD7EvNm+PpHjJ1qlE
 74T8z2Octji2s4cr6q40rrr7z7CDy4zI/jtc3l+H1M55FE8rPdOt+laRsCt6lg1Eso
 3AjlS6gKJYtkQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
 (envelope-from <mchehab@kernel.org>) id 1tIrlf-00000000HYp-3B0D;
 Wed, 04 Dec 2024 16:58:23 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 0/5] Change ghes driver to use HEST-based offsets
Date: Wed,  4 Dec 2024 16:57:54 +0100
Message-ID: <cover.1733327276.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=mchehab@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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

This  series was part of the previous PR to add generic error injection
support on GHES. It depends on a cleanup patch series sent earlier
today:

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
series will be merged for qemu 9.2 (maybe it is too late for that,
as QEMU is now on soft freeze). 

I tested migration using both virt-9.1 and virt-9.2 machines
on qemu 9.2.

I also tested migration with:

	qemu-9.1 -M virt-9.1 -cpu cortex-a57 => qemu-9.2 -M virt-9.1 -cpu cortex-a57
	qemu-9.2 -M virt-9.1 -cpu cortex-a57 => qemu-9.1 -M virt-9.1 -cpu cortex-a57 

The full qemu command when test backward-compatibility when running virt-9.1 is:


~/qemu/build/qemu-system-aarch64 \
-m 4g,maxmem=8G,slots=8 -monitor stdio -no-reboot -bios ~/emulator/QEMU_EFI-silent.fd -kernel~/kernel/arm64_build/arch/arm64/boot/Image.gz -device pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd -device virtio-net-pci,netdev=mynet,id=bob -drive if=none,file=~/emulator/debian.qcow2,format=qcow2,id=hd -object memory-backend-ram,size=4G,id=mem0 -netdev type=user,id=mynet,hostfwd=tcp::5555-:22 -qmp tcp:localhost:4445,server=on,wait=off -M virt-9.1,nvdimm=on,gic-version=3,ras=on -cpu max -smp 4 -numa node,nodeid=0,cpus=0-3,memdev=mem0 -append 'earlycon nomodeset root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4'

(I actually call it from two different directories, one with qemu-9.1 and the other one with qemu-9.2.

For tests on qemu-9.2 with virt-9.2, I used a similar command:

~/qemu/build/qemu-system-aarch64 -m 4g,maxmem=8G,slots=8 -monitor stdio -no-reboot -bios ~/emulator/QEMU_EFI-silent.fd -kernel ~/kernel/arm64_build/arch/arm64/boot/Image.gz -device pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd -device virtio-net-pci,netdev=mynet,id=bob -drive if=none,file=~/emulator/debian.qcow2,format=qcow2,id=hd -object memory-backend-ram,size=4G,id=mem0 -netdev type=user,id=mynet,hostfwd=tcp::5555-:22 -qmp tcp:localhost:4445,server=on,wait=off -M virt-9.2,nvdimm=on,gic-version=3,ras=on -cpu max -smp 4 -numa node,nodeid=0,cpus=0-3,memdev=mem0 -append 'earlycon nomodeset root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4'

---

v3: did some minor cleanups at the code, as suggested by Jonathan Cameron.

v2:
  - some whitespace and comment changes
  - patch 3/6 (acpi/ghes: rename the function which gets hw error offsets)
    was merged on the cleanup series.

Mauro Carvalho Chehab (5):
  acpi/ghes: Prepare to support multiple sources on ghes
  acpi/ghes: add a firmware file with HEST address
  acpi/ghes: Use HEST table offsets when preparing GHES records
  acpi/generic_event_device: Update GHES migration to cover hest addr
  acpi/generic_event_device: add logic to detect if HEST addr is
    available

 hw/acpi/generic_event_device.c |  30 +++++++
 hw/acpi/ghes.c                 | 160 +++++++++++++++++++++++++++++----
 hw/arm/virt-acpi-build.c       |  33 ++++++-
 hw/core/machine.c              |   2 +
 include/hw/acpi/ghes.h         |  23 +++--
 5 files changed, 220 insertions(+), 28 deletions(-)

-- 
2.47.1



