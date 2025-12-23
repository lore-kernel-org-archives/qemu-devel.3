Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CC1E748F7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 21:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYAGf-0002tU-MJ; Tue, 23 Dec 2025 16:50:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vYAGc-0002rj-H9
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 16:50:06 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vYAGZ-0006s8-Cn
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 16:50:06 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id F0F4F5969F6;
 Tue, 23 Dec 2025 22:49:57 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id cGxxhZwZx5Es; Tue, 23 Dec 2025 22:49:55 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EAA445969FD; Tue, 23 Dec 2025 22:49:55 +0100 (CET)
Message-ID: <cover.1766525089.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 0/6] Implement memory_region_new_* functions
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael S. Tsirkin <mst@redhat.com>,
 philmd@linaro.org
Date: Tue, 23 Dec 2025 22:49:55 +0100 (CET)
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

Our documentation says that memory regions are automatically freed
when the owner dies and the reference counting to do this is also
implemented. However this relies on the QOM free funtion that can only
be set by creating objects with object_new but memory API only
provides constructors that call object_initialize which clears the
free function that prevents QOM to manage the memory region lifetime.
Implement corresponding memory_region_new_* functions that do the same
as the memory_region_init_* functions but create the memory region
with object_new so the lifetime can be automatically managed by QOM as
documented.

BALATON Zoltan (6):
  memory: Add internal memory_region_set_ops helper function
  memory: Factor out common ram region initialization
  memory: Factor out more common ram region initialization
  memory: Shorten memory_region_init_rom_nomigrate
  memory: Add internal memory_region_register_ram function
  memory: Add memory_region_new* functions

 include/system/memory.h | 360 ++++++++++++++++++++++++++++++
 system/memory.c         | 484 +++++++++++++++++++++++++---------------
 2 files changed, 668 insertions(+), 176 deletions(-)

-- 
2.41.3


