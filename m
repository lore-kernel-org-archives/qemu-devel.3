Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A14C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wginz-0001AT-P5; Mon, 06 Jul 2026 08:52:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wgcQX-0002t6-KD
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 02:03:33 -0400
Received: from [115.124.28.73] (helo=out28-73.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang_wei@open-hieco.net>)
 id 1wgcQR-0005Rs-8g
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 02:03:33 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07448388|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00202762-2.34808e-05-0.997949;
 FP=7181971576053058843|0|0|0|0|-1|-1|-1; HT=maildocker-contentspam033037006180;
 MF=zhang_wei@open-hieco.net; NM=1; PH=DS; RN=6; RT=6; SR=0;
 TI=SMTPD_---.iEEStYR_1783317350; 
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net
 fp:SMTPD_---.iEEStYR_1783317350 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 06 Jul 2026 13:56:03 +0800
From: zhang_wei@open-hieco.net
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Tina Zhang <zhang_wei@hygon.cn>
Subject: [PATCH v1 0/9] target/i386: Fix Hygon vendor-specific CPU behavior
Date: Mon,  6 Jul 2026 13:55:21 +0800
Message-ID: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.73 (deferred)
Received-SPF: pass client-ip=115.124.28.73;
 envelope-from=zhang_wei@open-hieco.net; helo=out28-73.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 06 Jul 2026 08:51:54 -0400
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

From: Tina Zhang <zhang_wei@hygon.cn>

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

Tests were added for the Dhyana CPUID/ucode compatibility behavior and
for the Hygon HT GPA hole memory-layout case.

Tested with:

  ninja -C build

  build/pyvenv/bin/meson test -C build --print-errorlogs \
      qemu:qtest-i386/test-x86-cpuid-compat \
      qemu:qtest-x86_64/test-x86-cpuid-compat \
      qemu:func-x86_64-mem_addr_space

Tina Zhang (9):
  target/i386: Sync AMD CPUID aliases for Hygon
  target/i386: Hide Intel cache CPUID leaves for Hygon
  target/i386: Hide ARCH_CAPABILITIES for Hygon
  target/i386/kvm: Use AMD MCE status encoding for Hygon
  target/i386/kvm: Use AMD PMU MSR paths for Hygon
  target/i386: Do not broadcast injected MCEs for Hygon
  hw/i386: Apply AMD IOMMU HT GPA hole to Hygon
  target/i386: Use AMD legacy cache fallback for Hygon
  target/i386: Use AMD ucode-rev default for Hygon

 hw/i386/pc.c                                  | 22 +++--
 target/i386/cpu.c                             | 86 +++++++++++++----
 target/i386/cpu.h                             | 12 +++
 target/i386/helper.c                          |  6 +-
 target/i386/kvm/kvm.c                         | 36 +++++--
 .../functional/x86_64/test_mem_addr_space.py  | 36 +++++++
 tests/qtest/test-x86-cpuid-compat.c           | 95 +++++++++++++++++++
 7 files changed, 263 insertions(+), 30 deletions(-)

-- 
2.43.7

