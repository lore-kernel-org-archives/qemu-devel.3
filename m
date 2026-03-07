Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526ADF55123
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 23:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz13a-0005PS-B3; Sat, 07 Mar 2026 18:27:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vz13Y-0005Op-A9
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 18:27:36 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vz13V-0004vJ-VT
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 18:27:36 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DFE31596D94;
 Sun, 08 Mar 2026 00:27:31 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "MIME-Version"
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id bEFusc6oqnp7; Sun,  8 Mar 2026 00:27:29 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D0EB85969F2; Sun, 08 Mar 2026 00:27:29 +0100 (CET)
Message-ID: <cover.1772924827.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 0/6] Implement memory_region_new_* functions
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Sun, 08 Mar 2026 00:27:29 +0100 (CET)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

BALATON Zoltan (6):
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
 include/system/memory.h | 179 ++++++++++++++++++++++++++++++++++++++++
 system/memory.c         | 172 ++++++++++++++++++++++++++++++++++++++
 8 files changed, 398 insertions(+), 72 deletions(-)

-- 
2.41.3


