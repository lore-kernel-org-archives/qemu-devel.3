Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBFF606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 23:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT6T2-000071-C5; Mon, 16 Nov 2026 18:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.lamprecht@proxmox.com>)
 id 1xT6T0-00006V-V3
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:50:30 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t.lamprecht@proxmox.com>)
 id 1xT6Sy-0005Cl-Uh
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 18:50:30 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8489548666;
 Tue, 17 Nov 2026 00:50:18 +0100 (CET)
From: Thomas Lamprecht <t.lamprecht@proxmox.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH for-12.0 0/2] hw/i386/microvm: add versioned machine types
Date: Tue, 17 Nov 2026 00:30:12 +0100
Message-ID: <20261116235010.3622909-1-t.lamprecht@proxmox.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1794873015888
Received-SPF: pass client-ip=94.136.29.106;
 envelope-from=t.lamprecht@proxmox.com; helo=proxmox-new.maurer-it.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Proxmox VE wants to use microvm with PCIe and ACPI for long-lived Linux
guests, i.e. like Linux containers but with better isolation. Our
cluster upgrades and host maintenance rely on live migrating guests to
hosts that already run a newer QEMU, which is currently not really
possible with microvm, as it is not versioned.

When microvm was added, versioning was ruled out on purpose [1], as it
targeted short-lived guests. Since then, Paolo noted that microvm could
start having versioned variants [2]. So this series adds microvm-X.Y
machine types, starting with 12.0, as 11.2 is already in freeze.

Noteworthy points that migth be up for discussion:

- Following Paolo preference [2], "microvm" does not become an alias of
  the latest version, rather, it is left as it is. Unversioned machine
  types are meant to be a moving target [2], which includes defaulting
  to the latest version of a CPU model. The versioned types need a fixed
  default and use version 1, like pc and q35 do, and an alias cannot
  differ from the type it refers to.

- The x86 CPU compat properties are part of pc_compat_X_Y in
  hw/i386/pc.c, which is only built with CONFIG_PC. Once microvm-12.0
  needs them, they would have to move, for example to
  hw/i386/x86-common.c (but I'm happy to use another place, just say
  the word).

- With KVM, microvm uses the host's physical address width, so
  migration also needs the same width on both hosts. This is not new,
  the series only documents it for now.

Tested with the x86_64 CPU model and migration functional tests,
bios-tables-test and qom-test, and by live migrating Linux guests on
microvm-12.0 with TCG and KVM.

[1] https://lore.kernel.org/qemu-devel/af3acd26-f114-5889-182a-7dbd025393b9@redhat.com/
[2] https://lore.kernel.org/qemu-devel/004396c0-8370-4015-b746-3c800f45984f@redhat.com/

Thomas Lamprecht (2):
  hw/i386/microvm: make the default CPU model version a class field
  hw/i386/microvm: add versioned machine types

 docs/system/i386/microvm.rst                  | 21 ++++++++-
 hw/i386/microvm.c                             | 47 ++++++++++++++++++-
 include/hw/i386/microvm.h                     |  3 ++
 .../x86_64/test_cpu_model_versions.py         | 41 ++++++++++++++++
 4 files changed, 110 insertions(+), 2 deletions(-)


base-commit: f71afb409a87c4ecd0f9d63a5963eb645dfab780
-- 
2.47.3



