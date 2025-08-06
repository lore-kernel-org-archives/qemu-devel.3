Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887EBC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 16:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujggU-0002cJ-Hk; Wed, 06 Aug 2025 12:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ujfqx-0002lA-Be; Wed, 06 Aug 2025 11:14:57 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ujfqu-0006PI-Pz; Wed, 06 Aug 2025 11:14:55 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDn70_jcJNobSPWBA--.47S2;
 Wed, 06 Aug 2025 23:12:35 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCXIQnfcJNos_oJAA--.14849S3;
 Wed, 06 Aug 2025 23:12:31 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC 00/11] hw/arm/smmuv3: Add initial support for Secure State
Date: Wed,  6 Aug 2025 23:11:23 +0800
Message-Id: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCXIQnfcJNos_oJAA--.14849S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAOBWiSXH8HCwAZsG
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW3XF4xJr1UZw15Zr15JF1UWrg_yoWxCry5pa
 90k3Z8KryDGF17Zwn7Zw4xuFySg395Aw47GrnrG34UZ3Z5AFyvqry0ya45Kasrur4kA3W2
 vasF9Fs7Wr1UZrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 Aug 2025 11:27:14 -0400
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

Hi all,

This patch series introduces initial support for emulating the Arm SMMUv3
Secure State.

As Pierrick pointed out in a previous discussion [1], full Secure SMMUv3
emulation is a notable missing piece in QEMU. While the FVP model has
some support, its limited PCIe capabilities make it challenging for
complex use cases. The ability to properly manage device DMA from a
secure context is a critical prerequisite for enabling device assignment
(passthrough) for confidential computing solutions like Arm CCA and
related research such as virtCCA [2]. This series aims to build that
foundational support in QEMU.

This work is being proposed as an RFC. It introduces a significant amount
of new logic, including the core concept of modeling parallel secure and
non-secure contexts within a single SMMUv3 device. I am seeking feedback
on the overall approach, the core refactoring, and the implementation
details before proceeding further.

The series begins by implementing the components of the secure programming
interface, then progressively refactors the core SMMU logic to handle
secure and non-secure contexts in parallel.

Secure Interface Implementation: The initial patches add the
secure-side registers, implement their read/write logic, and enable
the secure command and event queues. This includes the S_INIT
mechanism and the new secure TLB invalidation commands.

Core Logic Refactoring: The next set of patches makes the core SMMU
functions security-state aware. This involves plumbing an is_secure
context flag through the main code paths and adding logic to route
SMMU-originated memory accesses to the correct (Secure or Non-secure)
address space.

Cache Isolation: With the core logic now aware of security states,
the following patches refactor the configuration and translation
lookup caches. The cache keys are modified to include the security
context, ensuring that secure and non-secure entries for the same
device or address are properly isolated and preventing aliasing.

Framework Integration: The final patch connects the SMMU's internal
security context to the generic QEMU IOMMU framework by using the
iommu_index to represent the architectural SEC_SID.

To validate this work, I performed the following tests:

Non-Secure Regression: To ensure that existing functionality remains
intact, I ran a nested virtualization test. A TCG guest was created on
the host, with iommu=smmuv3 and with an emulated PCIe NVMe device assigned.
Command line of TCG VM is below:

qemu-system-aarch64 \
-machine virt,virtualization=on,gic-version=3,iommu=smmuv3 \
-cpu max -smp 1 -m 4080M \
-accel tcg,thread=single,tb-size=512 \
-kernel Image \
-append 'nokaslr root=/dev/vda rw rootfstype=ext4 iommu.passthrough=on' \
-device pcie-root-port,bus=pcie.0,id=rp0,addr=0x4.0,chassis=1,port=0x10 \
-device pcie-root-port,bus=pcie.0,id=rp1,addr=0x5.0,chassis=2,port=0x11 \
-drive if=none,file=u2204fs.img.qcow2,format=qcow2,id=hd0 \
-device virtio-blk-device,drive=hd0 \
-qmp unix:/tmp/qmp-sock12,server=on,wait=off \
-netdev user,id=eth0,hostfwd=tcp::10022-:22,hostfwd=tcp::59922-:5922 \
-device virtio-net-device,netdev=eth0 \
-drive if=none,file=nvme.img,format=raw,id=nvme0 \
-device nvme,drive=nvme0,serial=deadbeef \
-d unimp,guest_errors -trace events=smmu-events.txt -D qemu.log -nographic

Inside this TCG VM, a KVM guest was launched, and the same NVMe device was
re-assigned to it via VFIO.
Command line of KVM VM inside TCG VM is below:

sudo qemu-system-aarch64  \
-enable-kvm  -m 1024  -cpu host  -M virt \
-machine virt,gic-version=3 \
-cpu max -append "nokaslr" -smp 1 \
-monitor stdio \
-kernel 5.15.Image \
-initrd rootfs.cpio.gz \
-display vnc=:22,id=primary \
-device vfio-pci,host=00:01.0

The KVM guest was able to perform I/O on the device
correctly, confirming that the non-secure path is not broken.

Secure Register/Command Interface: I set up an OP-TEE + Hafnium
environment. Hafnium's smmuv3_driver_init function was used to test
the secure register I/O and command queue functionality (excluding
translation). As Hafnium assumes larger queue and StreamID sizes than
are practical without TTST support, I temporarily patched Hafnium to
use smaller values, allowing its driver to initialize the emulated
secure SMMU successfully.

Secure Translation Path: Since the TF-A SMMUv3 Test Engine does not
support QEMU, and no secure device assignment feature exists yet, I
created a custom platform device to test the secure translation flow.
To trigger the translation logic, I initiated MMIO writes to this
device from within Hafnium. The device's MMIO callback handler then
performed DMA accesses via its IOMMU region, exercising the secure
translation path. While SMMUv3 is typically used for PCIe on
physical SoCs, the architecture allows its use with platform devices
via a stream-id binding in the device tree. The test harness
required some non-standard modifications to decouple the SMMU from
its tight integration with PCIe. The code for this test device is
available for review at [3]. README.md with detailed instructions is
also provided.

I've attempted to follow all of the guidance in the "Submitting a Patch"
guide, but as this is my first series of this scale, I apologize if I
missed anything and welcome all feedback.

Thanks,
Tang

[1] https://lists.nongnu.org/archive/html/qemu-devel/2025-06/msg02940.html
[2] https://arxiv.org/abs/2306.11011
[3] https://github.com/hnusdr/qemu

Tao Tang (11):
  hw/arm/smmuv3: Introduce secure registers and commands
  hw/arm/smmuv3: Implement read/write logic for secure registers
  hw/arm/smmuv3: Implement S_INIT for secure initialization
  hw/arm/smmuv3: Enable command processing for the Secure state
  hw/arm/smmuv3: Support secure event queue and error handling
  hw/arm/smmuv3: Plumb security state through core functions
  hw/arm/smmuv3: Add separate address space for secure SMMU accesses
  hw/arm/smmuv3: Enable secure-side stage 2 TLB invalidations
  hw/arm/smmuv3: Make the configuration cache security-state aware
  hw/arm/smmuv3: Differentiate secure TLB entries via keying
  hw/arm/smmuv3: Use iommu_index to represent SEC_SID

 hw/arm/smmu-common.c         |  74 ++-
 hw/arm/smmuv3-internal.h     | 128 +++++-
 hw/arm/smmuv3.c              | 844 ++++++++++++++++++++++++++++++-----
 hw/arm/trace-events          |   7 +-
 hw/arm/virt.c                |   5 +
 include/hw/arm/smmu-common.h |  23 +-
 include/hw/arm/smmuv3.h      |  27 ++
 7 files changed, 968 insertions(+), 140 deletions(-)

--
2.34.1


