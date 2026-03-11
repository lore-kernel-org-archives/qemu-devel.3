Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DBB1125847
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LIm-0008NG-Bs; Wed, 11 Mar 2026 11:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w0LIT-00084B-Ce; Wed, 11 Mar 2026 11:16:31 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w0LIR-0000QV-85; Wed, 11 Mar 2026 11:16:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1773242174; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BKS8tkW1+MhgLeTfchmF86Fi0ufPK3DH++LM6ESYyX7dIZim7MfmniNOQqlvcXwbzColuIkaRCXuuKh19mhIE9M5migAxPFtV94Ucybba8jrBERjT1dwSfcNedy7kAkL/A2cbcQC2L5M1w9EF9/OY9+ilCAtQH+q5c6SK8Pn04g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773242174;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=EdsQt9XAkhr3J9fJ/2sTgcnnBkZM2wyLclrl9WyqDG4=; 
 b=aJalXG8D7MRxX1AuZUjkRoGpns+5HKa7PfYWesNFA5NWojXE9SMOSnCy3OOFP7Egc8Ktg9WeyHkmGNb1MRb71VGg7PdJh1sgruMLM6hed9OVTc3VVBs9cz2mayt0nn+CFGCfiI5OMsqm24fzv7K9eCWzf/j2JkcC7YaDVEXt0F4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773242174; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=EdsQt9XAkhr3J9fJ/2sTgcnnBkZM2wyLclrl9WyqDG4=;
 b=ArY5FdC+Z1HudFTEsqAumIPDnWKF+nD3RQQhdpin0ZFGbz/sqFQLqemtwssf1iwx
 025iKSfKYuJCoYXjnp4eeTKLQMnMcysGFm6dZWfzU5BEQb/i8n2nJlGdL/SYpV/mOQz
 NVwNWrM/sl9UAvmJET56DkQ2mEBkkmnplXz+P+6E=
Received: by mx.zohomail.com with SMTPS id 1773242172116262.8075739050563;
 Wed, 11 Mar 2026 08:16:12 -0700 (PDT)
From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
Subject: [PATCH 00/14] Add ARM64 support for MSHV accelerator
Date: Wed, 11 Mar 2026 15:15:27 +0000
Message-Id: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA+HsWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0ND3dzijLL4xOTk1Jz4xKJcM5P44tKCAt1UC7MkAwMLo8TUVBMloN6
 CotS0zAqwudGxtbUARDakIGcAAAA=
X-Change-ID: 20260311-mshv_accel_arm64_supp-e86b0082aee4
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org
X-Mailer: b4 0.14.3
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.54;
 envelope-from=anirudh@anirudhrb.com; helo=sender4-of-o54.zoho.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This series adds ARM64 guest support to the MSHV (Microsoft Hypervisor)
accelerator, enabling QEMU to run aarch64 VMs on Microsoft's hypervisor
using the mshv Linux kernel module.

The first few patches refactor the existing x86 MSHV code to separate
arch-specific pieces from common infrastructure: moving MSR handling to
target/i386, extracting shared register hypercall helpers, provisioning
host CPU features, and introducing arch-specific init hooks.

The remaining patches add the ARM64 backend:
 - vCPU state get/set using hypervisor register hypercalls
 - -cpu host support by querying ID registers from the hypervisor
 - vCPU run loop with MMIO emulation via ESR_EL2 syndrome decoding
 - In-kernel vGICv3 backed by HVCALL_ASSERT_VIRTUAL_INTERRUPT
 - Interrupt control structure adjustments for arm64

With this series, a standard aarch64 virt machine can be launched with:
  qemu-system-aarch64 -accel mshv -cpu host -M virt ...

Caveats:
- Currently only direct kernel is supported. We're still debugging edk2
  firmware boot. 
- Live migration is not yet supported.

---
Aastha Rawat (7):
      accel/mshv: move msr.c to target/i386
      accel/mshv: extract common CPU register helpers
      meson, target/arm/mshv: Enable arm64 build & add initial MSHV support
      target/arm/mshv: implement vcpu state operations for ARM64
      target/arm/mshv: implement -cpu host for MSHV
      accel/mshv: Add access_vp_regs synthetic proc features
      target/arm: cpu: Mark MSHV supporting PSCI 1.3

Anirudh Rayabharam (Microsoft) (6):
      accel/mshv: provision guests with the same features as host
      accel/mshv: add arch-specific accelerator init hook
      target/arm/mshv: add vCPU run loop
      include/hw/hyperv: adjust hv_interrupt_control structure for arm64
      hw/intc,target/arm/mshv: add MSHV vGICv3 implementation
      MAINTAINERS: updates for MSHV arm64 code

Magnus Kulke (1):
      accel/mshv: implement cpu_thread_is_idle() hook

 MAINTAINERS                        |   8 +
 accel/mshv/irq.c                   |   2 +
 accel/mshv/meson.build             |   4 +-
 accel/mshv/mshv-all.c              |  73 +++-
 accel/mshv/mshv-cpu-common.c       | 151 +++++++++
 hw/arm/virt.c                      |  11 +-
 hw/intc/arm_gicv3_common.c         |   3 +
 hw/intc/arm_gicv3_mshv.c           | 180 ++++++++++
 hw/intc/meson.build                |   1 +
 include/hw/hyperv/hvgdk_mini.h     | 130 ++++++++
 include/hw/hyperv/hvhdk.h          |  97 +++++-
 include/hw/hyperv/hvhdk_mini.h     |   6 +
 include/hw/intc/arm_gicv3_common.h |   1 +
 include/system/hw_accel.h          |   3 +-
 include/system/mshv.h              |   2 +
 include/system/mshv_int.h          |   5 +
 meson.build                        |   7 +-
 target/arm/cpu.c                   |   7 +-
 target/arm/cpu64.c                 |  24 +-
 target/arm/meson.build             |   1 +
 target/arm/mshv/meson.build        |   7 +
 target/arm/mshv/mshv-all.c         | 665 +++++++++++++++++++++++++++++++++++++
 target/arm/mshv_arm.h              |  18 +
 target/i386/mshv/meson.build       |   2 +
 target/i386/mshv/mshv-all.c        |  85 +++++
 target/i386/mshv/mshv-cpu.c        | 170 +---------
 {accel => target/i386}/mshv/msr.c  |   0
 27 files changed, 1465 insertions(+), 198 deletions(-)
---
base-commit: 1fd5ff9d76d23ab23a68419cbc76d5ee33e8b455
change-id: 20260311-mshv_accel_arm64_supp-e86b0082aee4

Best regards,
-- 
Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


