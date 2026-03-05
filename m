Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1B6F513E1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:52:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyHXh-0007kC-B8; Thu, 05 Mar 2026 17:51:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vyHXf-0007fY-0A
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:51:39 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vyHXa-0008Pz-1B
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:51:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=fHJhNNvhYY+rFqdZDqRCFU1COQFHS4VBPhWamddOOuM=; b=Mnv+hetrBrMV5yM
 1n8x5q75wLCX8hNLru/XKnTUjlpAyUrOec8Smn7rsfRjOdmLDvtzRThjHWkwhQCSrJTXLuoSKBgtf
 2mrxzLf8wGqzWJiaHtiPMjyMRqrBz7D5hudBrbj46cuSH0Kv7cpx2Mfr2kmQgYsS+xNYqp042C8iu
 UY=;
Subject: [PATCH v6 0/3] hppa: PA-8700, use 44 bit physical addresses
Date: Thu, 05 Mar 2026 23:54:19 +0100
Message-Id: <20260305-hppa-c3600-v6-0-d51526e5269c@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XPS2rDMBCA4asYrasyelmKV71HKWWsR6yN40qpa
 Qi+e6cONBG0yxn4fmaurMaSY2VDd2Ulrrnm00xD/9QxP+F8jDwHmpkE2YMUwKdlQe5VD8CTA2c
 tRDTGMgJLiSl/7bHXt9tc4scnNc+35T05dBQ0QoDmy3Sp7xhC4SMkbSMqEBqHVbOfxpTr+VQu+
 32r2CN/nbIKDhyFjd64BEalF3rmeT7ujVX+7yS5g0c4+J5eEbJx6tG5xilyo7IYjEMJITRO350
 C2ThNTmuLDiCg875x5tGpxhly0toxxX7UMLpft23bN9GHvhHFAQAA
X-Change-ID: 20260210-hppa-c3600-f808770ea557
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Anton Johansson <anjo@rev.ng>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772751314; l=3290;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=KVmM9wJv6eLbwSBctOA7IRFfF+7f7FpuIdrvsXZyVRg=;
 b=HqTe+kKu0xfiTDWg/RKKCcEw3RUWTX+463y1iIwwmz31tq5uz26Y9dG/3vdhF1BOZRuNUrP22
 IYWyTyccHwZDvs1qcVEq/EwdDDAWdjZARaWHgiCmpBws59OIzUMOQN1
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patchset tries to address a discrepancy between the C3700 machine
in QEMU/SeaBIOS and the documentation (chapter 5)

  http://ftp.parisc-linux.org/docs/whitepapers/PA-8700wp.pdf

where 40 bits of physical address space are used in SeaBIOS compared
to the 44 bits specified in the documentation.

A PA-8500 CPU with 40 bits of physical address space is added to be
used with the A400 machine.  AFAICT there are no major differences
from QEMUs side between the PA-8500 and 8700 aside from the physical
address space size.  The PA-8700 machine can then be moved to using
44 bits.  To account for the discrepancy with SeaBIOS, the functional
tests now run the A400.

This series introduces a small restructuring to the HPPA CPU class
heirarchy. CPU model definitions now inherit from a TYPE_HPPA_CPU base
class and use a HPPACPUDef struct to provide model specifics, similar
to the SPARC and RISCV targets.  This hopefully makes it easier to add
other models, such as the 8800/8900.

Signed-off-by: Anton Johansson <anjo@rev.ng>
---
Changes in v6:
- Squashed first two commits for ease of review (Philippe).
- Removed unnecessary branch from hppa_cpu_class_base_init() (Richard).
- Replaced first_cpu uses (Philippe).
  - Added phys_addr_bits property to Astro device.
  - Pass phys_addr_bits to hppa_abs_to_phys*() instead of env.
- Link to v5: https://lore.kernel.org/qemu-devel/20260303-hppa-c3600-v5-0-277bfe6b40b8@rev.ng

Changes in v5:
- Moved assert on maximum size of the physical address space to base
  class initialization function, so it's only ran once.
- Clarified commit message in final patch.
- Link to v4: https://lore.kernel.org/qemu-devel/20260302-hppa-c3600-v4-0-447a800da8cc@rev.ng

Changes in v4:
- Add PA-8500 instead of PA-8600 and use the now upstreamed A400
  machine.
- Link to v3: https://lore.kernel.org/qemu-devel/20260218-hppa-c3600-v3-0-b37ad58a20dd@rev.ng

Changes in v3:
- Fixed spelling in commit message/comment
- Rebased
- Dropped if statement in hppa_cpu_class_base_init() (patch
  "hppa: Introduce HPPACPUDef").  Not needed as it will simply
  be set to NULL for the abstract base class anyway.
- Link to v2: https://lore.kernel.org/qemu-devel/20260210-hppa-c3600-v2-0-9ca09c677012@rev.ng

Changes in v2:
- Missed a reference to the old "hppa" CPU model, updated to
  "pa-7300lc".
- Link to v1: https://lore.kernel.org/qemu-devel/20260210-hppa-c3600-v1-0-a17ec58f053f@rev.ng

---
Anton Johansson (3):
      hppa: Introduce HPPACPUDef
      hppa: Get physical address space bits from HPPACPUDef
      hppa: Use 44 bit physical addresses for PA-8700

 include/hw/pci-host/astro.h           |  2 ++
 target/hppa/cpu-qom.h                 |  8 ++++-
 target/hppa/cpu.h                     | 35 +++++++++++++++++-----
 hw/hppa/machine.c                     | 36 ++++++++++++++---------
 hw/pci-host/astro.c                   |  8 ++++-
 linux-user/hppa/elfload.c             |  2 +-
 target/hppa/cpu.c                     | 55 +++++++++++++++++++++++++++--------
 target/hppa/mem_helper.c              | 39 +++++++------------------
 tests/qtest/machine-none-test.c       |  2 +-
 tests/functional/hppa/test_seabios.py |  4 +--
 10 files changed, 125 insertions(+), 66 deletions(-)


