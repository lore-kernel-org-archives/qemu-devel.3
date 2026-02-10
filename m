Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A747EB270B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 20:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vptwP-0000qt-JT; Tue, 10 Feb 2026 15:02:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vptwE-0000oI-2V
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:02:23 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vptwA-00050V-QE
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:02:21 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 366F75969F3;
 Tue, 10 Feb 2026 21:02:10 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "MIME-Version"
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id aVUtlTxJUcBZ; Tue, 10 Feb 2026 21:02:08 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 345A25969FA; Tue, 10 Feb 2026 21:02:08 +0100 (CET)
Message-ID: <cover.1770753117.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 0/6] Implement memory_region_new_* functions
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
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Tue, 10 Feb 2026 21:02:08 +0100 (CET)
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

Our documentation says that memory regions are automatically freed
when the owner dies and the reference counting to do this is also
implemented. However this relies on the QOM free funtion that can only
be set by creating objects with object_new but memory API only
provides constructors that call object_initialize which clears the
free function that prevents QOM to manage the memory region lifetime.
Implement corresponding memory_region_new_* functions that do the same
as the memory_region_init_* functions but create the memory region
with object_new so the lifetime can be automatically managed by QOM as
documented. The memory_region_init functions are kept because they are
useful for memory regions embedded in other object or managed
externally and not by QOM for some reason.

v3:
Based-on: <cover.1770753117.git.balaton@eik.bme.hu>
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
 hw/xtensa/xtfpga.c      |   7 +-
 include/system/memory.h | 179 +++++++++++++++++++++++++++++++++++++++
 system/memory.c         | 181 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 407 insertions(+), 74 deletions(-)

-- 
2.41.3


