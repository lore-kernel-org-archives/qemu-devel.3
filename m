Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6A0E63CA3
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 18:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vk4wE-0006gm-UU; Sun, 25 Jan 2026 13:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vk4wD-0006ep-Ii
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 13:34:17 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vk4wA-0002nS-LE
 for qemu-devel@nongnu.org; Sun, 25 Jan 2026 13:34:17 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 47ACF5974FC;
 Sun, 25 Jan 2026 19:34:12 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id JWyxWWGHBb2f; Sun, 25 Jan 2026 19:34:10 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E98C45974CE; Sun, 25 Jan 2026 18:51:02 +0100 (CET)
Message-ID: <e8376e9815134ef24201331a7b953bc8f858c30d.1769362313.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1769362313.git.balaton@eik.bme.hu>
References: <cover.1769362313.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 07/10] memory: Update documentation for memory_region_new*()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael S. Tsirkin <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Sun, 25 Jan 2026 18:51:02 +0100 (CET)
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

Clarify the difference between memory_region_new() and
memory_region_init() with regard to region lifecycle.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 docs/devel/memory.rst | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/docs/devel/memory.rst b/docs/devel/memory.rst
index f22146e56c..60eaea8df7 100644
--- a/docs/devel/memory.rst
+++ b/docs/devel/memory.rst
@@ -142,7 +142,8 @@ stability.
 Region lifecycle
 ----------------
 
-A region is created by one of the memory_region_init*() functions and
+A region is allocated by one of the memory_region_new*() functions or
+pre-allocated and initialized by memory_region_init*() functions and
 attached to an object, which acts as its owner or parent.  QEMU ensures
 that the owner object remains alive as long as the region is visible to
 the guest, or as long as the region is in use by a virtual CPU or another
@@ -158,16 +159,16 @@ ioeventfd) can be changed during the region lifecycle.  They take effect
 as soon as the region is made visible.  This can be immediately, later,
 or never.
 
-Destruction of a memory region happens automatically when the owner object
-dies.  When there are multiple memory regions under the same owner object,
-the memory API will guarantee all memory regions will be properly detached
-and finalized one by one.  The order in which memory regions will be
-finalized is not guaranteed.
+Destruction of a memory region allocated with memory_region_new*() functions
+happens automatically when the owner object dies.  When there are multiple
+memory regions under the same owner object, the memory API will guarantee all
+memory regions will be properly detached and finalized one by one.  The order
+in which memory regions will be finalized is not guaranteed.
 
-If however the memory region is part of a dynamically allocated data
-structure, you should free the memory region in the instance_finalize
-callback.  For an example see VFIOMSIXInfo and VFIOQuirk in
-hw/vfio/pci.c.
+If however the memory region is part of a separately allocated data structure
+and initialized with one of the memory_region_init*() functions, you may have
+to free the memory region e.g. in an instance_finalize callback.  For an
+example see VFIOMSIXInfo and VFIOQuirk in hw/vfio/pci.c.
 
 You must not destroy a memory region as long as it may be in use by a
 device or CPU.  In order to do this, as a general rule do not create or
-- 
2.41.3


