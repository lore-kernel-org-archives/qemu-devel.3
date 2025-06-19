Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248ECC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 14:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSGbq-00008h-RY; Thu, 19 Jun 2025 10:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSGbe-000073-Kx
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 10:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSGbb-0006Qy-EN
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 10:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750344666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iVl6U9JUH3ddI0q7EbKabXr6EFNpnLzEnpeABfPqZjY=;
 b=bVpomwMFWoFaQ6yIXQL17HrYD1KGWkYa6S9u9UvqxZV8/PU3aJQujm02le6rQcoOvw8Lgu
 4azG520ZJTh9TU7TmukoQMKmNJsz9S1OlR7HAHFZx2Hdu3FiYiGEAbeGLh4C10Ps3GVy2l
 4VNifjcVwQsp20I2PEFlxj+++xqvYZ0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-CxMJNFEZNfeeLs8dpS7obA-1; Thu,
 19 Jun 2025 10:51:01 -0400
X-MC-Unique: CxMJNFEZNfeeLs8dpS7obA-1
X-Mimecast-MFC-AGG-ID: CxMJNFEZNfeeLs8dpS7obA_1750344659
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2A17180028F; Thu, 19 Jun 2025 14:50:58 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.77])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4AEA219560A3; Thu, 19 Jun 2025 14:50:54 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, miguel.luis@oracle.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maz@kernel.org,
 gkulkarni@amperecomputing.com, gankulkarni@os.amperecomputing.com
Cc: hi@alyssa.is
Subject: [PATCH v6 0/5] ARM Nested Virt Support
Date: Thu, 19 Jun 2025 16:49:58 +0200
Message-ID: <20250619145047.1669471-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The only change compared to v5 is the linux header update against
kvm main branch. As discussed on the mailing list, KVM_ARM_VCPU_EL2_E2H0
(non VHE version of the NV support) will be dealt with in a separate
add-on series. Also the fallback to TCG does not apply if the host
does not support nested and virtualization=on (which is aligned
with the behavior along with other arm virt machine properties such as
secure, mte, ...).

For gaining virt functionality in KVM accelerated L1, The host needs to
be booted with "kvm-arm.mode=nested" option and qemu needs to be invoked
with: -machine virt,virtualization=on.

This series can be found at:
https://github.com/eauger/qemu/tree/v10.0.0-nv-v6

Original version from Miguel:
[1] https://lore.kernel.org/all/20230227163718.62003-1-miguel.luis@oracle.com/
version from Haibo:
[2] https://lore.kernel.org/qemu-devel/cover.1617281290.git.haibo.xu@linaro.org/

History:
v5 -> v6:
- linux header update against v6.16-rc2

v4 -> v5:
- rebase on top of v10.0.0

v3 -> v4:
- fix: only set maint_irq if vms->virt

v2 -> v3:
- KVM EL2 only is set if virtualization option is set
- fixes regression with virtualization=off
- Add checks against unsupported GIC configs until the kernel does


Eric Auger (1):
  linux-headers: Update against  v6.16-rc2

Haibo Xu (4):
  hw/arm: Allow setting KVM vGIC maintenance IRQ
  target/arm/kvm: Add helper to detect EL2 when using KVM
  target/arm: Enable feature ARM_FEATURE_EL2 if EL2 is supported
  hw/arm/virt: Allow virt extensions with KVM

 include/hw/intc/arm_gicv3_common.h            |   1 +
 include/standard-headers/asm-x86/setup_data.h |  13 +-
 include/standard-headers/drm/drm_fourcc.h     |  45 +++++++
 include/standard-headers/linux/ethtool.h      | 124 +++++++++---------
 include/standard-headers/linux/fuse.h         |   6 +-
 .../linux/input-event-codes.h                 |   3 +-
 include/standard-headers/linux/pci_regs.h     |  12 +-
 include/standard-headers/linux/virtio_gpu.h   |   3 +-
 include/standard-headers/linux/virtio_pci.h   |   1 +
 linux-headers/asm-arm64/kvm.h                 |   9 +-
 linux-headers/asm-x86/kvm.h                   |   1 +
 linux-headers/linux/bits.h                    |   4 +-
 linux-headers/linux/kvm.h                     |   3 +
 linux-headers/linux/vhost.h                   |   4 +-
 target/arm/kvm_arm.h                          |   7 +
 hw/arm/virt.c                                 |  13 +-
 hw/intc/arm_gicv3_common.c                    |   1 +
 hw/intc/arm_gicv3_kvm.c                       |  21 +++
 target/arm/kvm-stub.c                         |   5 +
 target/arm/kvm.c                              |  21 +++
 20 files changed, 223 insertions(+), 74 deletions(-)

-- 
2.49.0


