Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903A3CD98DE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 22:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZFc9-0001yA-LR; Mon, 15 Jun 2026 18:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wZFc6-0001x3-IM
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 18:17:02 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wZFc4-0007pR-PC
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 18:17:02 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F395C596949;
 Tue, 16 Jun 2026 00:16:57 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id Ei-c8EfLHvjh; Tue, 16 Jun 2026 00:16:55 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EA9D45968DE; Tue, 16 Jun 2026 00:16:55 +0200 (CEST)
Message-ID: <cover.1781561370.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v6 0/7] Implement memory_region_new_* functions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, berrange@redhat.com,
 philmd@mailo.com
Date: Tue, 16 Jun 2026 00:16:55 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Allow creating memory regions that are managed by QOM and freed with
their owner as it is already documented and implemented but there was
no way to use it.

v6:
- rebase on master
- do not export memory_region_set_ops in patch 1 (will try different
way in ati-vga for this)

v5:
- rebase on master
- add patch to export memory_region_set_ops (needed for ati-vga endian
switch)

v4:
- rebase on latest version of clean up series:
Based-on: cover.1772924151.git.balaton@eik.bme.hu

v3:
- based on split off clean up series
- convert xtfpga from nomigrate as this has no migration compatibility
issue

v2:
- rebase on master
- update documentation
- use these function to fix some leaks (there may be more, e.g. in
hw/pci-host/bonito but I leave that for later and/or others)

BALATON Zoltan (7):
  Move assert to memory_region_set_ops()
  memory: Add memory_region_new* functions
  memory: Update documentation for memory_region_new*()
  hw/ide/sii3112: Use memory_region_new to avoid leaking regions
  hw/pci-host/articia: Map PCI memory windows in realize
  hw/pci-host/articia: Add variable for common type cast
  hw/xtensa/xtfpga: Fix leaking memory region

 docs/devel/memory.rst   |  21 ++---
 hw/ide/sii3112.c        |  30 +++----
 hw/pci-host/articia.c   |  22 +++--
 hw/ppc/amigaone.c       |  28 ++-----
 hw/ppc/pegasos.c        |  13 ---
 hw/xtensa/xtfpga.c      |   5 +-
 include/system/memory.h | 179 +++++++++++++++++++++++++++++++++++++++
 system/memory.c         | 181 +++++++++++++++++++++++++++++++++++++++-
 8 files changed, 406 insertions(+), 73 deletions(-)

-- 
2.41.3


