Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DB1C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtLSY-0001Y2-W9; Mon, 10 Aug 2026 04:34:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wtLRk-0001QE-TE
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 04:33:33 -0400
Received: from [115.124.28.5] (helo=out28-5.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wtLRf-0005Bu-MU
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 04:33:23 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07437109|-1; CH=green;
 DM=|CONTINUE|false|; DS=CONTINUE|ham_alarm|0.00974696-4.09803e-05-0.990212;
 FP=7199979514931766635|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033068016216;
 MF=zhang_wei@open-hieco.net; NM=1; PH=DS; RN=8; RT=8; SR=0;
 TI=SMTPD_---.iiL7hCG_1786350652; 
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net
 fp:SMTPD_---.iiL7hCG_1786350652 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 10 Aug 2026 16:30:58 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanjing Zhou <zhouyanjing@hygon.cn>,
 Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v2 0/9] target/i386: Fix Hygon vendor-specific CPU behavior
Date: Mon, 10 Aug 2026 16:29:47 +0800
Message-ID: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.5 (deferred)
Received-SPF: pass client-ip=115.124.28.5;
 envelope-from=zhang_wei@open-hieco.net; helo=out28-5.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

Hygon Dhyana uses the HygonGenuine vendor string, but a number of
guest-visible and KVM-facing interfaces follow AMD-compatible behavior.
QEMU currently keys several of these paths only on AuthenticAMD, so Hygon
guests can see vendor-inconsistent CPUID/MSR state or use the wrong KVM
PMU/MCE handling paths.

This series makes those checks explicit for Hygon where appropriate.

Guest-visible CPU ABI changes are gated by the new
x-hygon-vendor-abi-fixes property.  The property defaults to true for new
machine types and is disabled for pc-11.0 and older, so existing machine
types keep their previous Hygon ABI for migration compatibility.

The KVM injected-MCE and PMU path changes are not CPUID model table
changes.  They make QEMU use the AMD-compatible runtime handling that
Linux/KVM already uses for Hygon.

The series covers:

  * AMD CPUID[0x80000001].EDX aliases for Hygon
  * hiding Intel cache CPUID leaves 2 and 4 for Hygon
  * hiding IA32_ARCH_CAPABILITIES for Hygon unless old ABI requires it
  * AMD MCE status encoding for Hygon memory-failure injection
  * AMD PMU MSR setup/save/restore paths for Hygon
  * disabling Intel-style MCA broadcast for Hygon injected MCEs
  * AMD IOMMU HT GPA hole layout for Hygon on new machine types
  * AMD legacy cache fallback for Hygon when legacy-cache=on
  * AMD-shaped default ucode-rev value for Hygon

Changes in v2:

  * Rebased onto v11.1.0-rc3.  Moved the compatibility property to
    pc_compat_11_1 and wired it into the i440fx and q35 11.1 machine
    options.  (Zhao)
  * Patch 1: removed the single-use CPUID-alias helper and checked Hygon
    directly at the call site.  Also updated the hygon_vendor_abi_fixes
    field comment to emphasize that it is a machine-type compatibility
    option.  (Zhao)
  * Patch 4: removed the single-use MCE-status helper and checked Hygon
    directly at the call site.  (Zhao)
  * Patch 5: reworked the PMU vendor checks around a common PMU vendor-family
    abstraction, covering host/guest compatibility, PMU initialization,
    and PMU MSR save/restore.  (Zhao)
  * Collected Reviewed-by tags for patches 2, 3, and 8.

Tested with:

  ninja -C build

  build/pyvenv/bin/meson test -C build --print-errorlogs \
      qemu:qtest-x86_64/test-x86-cpuid-compat \
      qemu:func-x86_64-mem_addr_space

Tina Zhang (9):
  target/i386: Sync AMD CPUID aliases for Hygon
  target/i386: Hide Intel cache CPUID leaves for Hygon
  target/i386: Hide ARCH_CAPABILITIES for Hygon
  target/i386/kvm: Use AMD MCE status encoding for Hygon
  target/i386/kvm: Use AMD PMU MSR paths for Hygon
  target/i386: Do not broadcast injected MCEs for Hygon
  hw/i386: Reserve AMD IOMMU HT GPA range for Hygon
  target/i386: Use AMD legacy cache fallback for Hygon
  target/i386: Use AMD ucode-rev default for Hygon

 hw/i386/pc.c                                  | 23 ++++-
 hw/i386/pc_piix.c                             |  1 +
 hw/i386/pc_q35.c                              |  1 +
 include/hw/i386/pc.h                          |  3 +
 target/i386/cpu.c                             | 73 ++++++++++----
 target/i386/cpu.h                             | 13 +++
 target/i386/helper.c                          |  2 +-
 target/i386/kvm/kvm.c                         | 75 +++++++++++----
 .../functional/x86_64/test_mem_addr_space.py  | 37 ++++++++
 tests/qtest/test-x86-cpuid-compat.c           | 95 +++++++++++++++++++
 10 files changed, 282 insertions(+), 41 deletions(-)

-- 
2.43.7

