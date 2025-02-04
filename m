Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97798C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 22:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfREj-0005Vh-5U; Tue, 04 Feb 2025 17:17:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tfREg-0005UG-3L
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 17:17:38 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1tfREe-0005Qx-AG
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 17:17:37 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 9F50DA42D30;
 Tue,  4 Feb 2025 22:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A63C4CEDF;
 Tue,  4 Feb 2025 22:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738707454;
 bh=x2atwE4gHU0GpGAhwAVJlP3HgxN8fVPhNglWL/AB3UM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mSCyAHem5B5MW/V6rUguiXEbGVeOS8kaTWkSZd387PHKNqV6yUjoRKT9aAOfaznrB
 ejx48euwsZXrlWXFvGcVRcIc+DLwY8gSfWb2VXfJ96n9dw5vrgG7rxGhUw2AEBhqoa
 UfmibVc3TOv+qpohJXHhkkw29hQN55zTdhkESawJMuflFGGiAZfLteKZMcsgA0K6r7
 xfCcv0XzjLWoJ5yJH8ZkyLkZQJEyomfs/herl6juvtzovQ3kJ04Kd0KumHu/eRIIqJ
 jg7aWjBAHLricxXCzKqe/8pCW78C6hBENg7nF+ypiVlrTVZqXA3Ka2arYeYHmQHzgM
 /ojIKy8hLJ6nQ==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH 4/6] hw/hppa: Avoid creation of artist if disabled on command
 line
Date: Tue,  4 Feb 2025 23:17:24 +0100
Message-ID: <20250204221726.151287-5-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250204221726.151287-1-deller@kernel.org>
References: <20250204221726.151287-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=147.75.193.91; envelope-from=deller@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Helge Deller <deller@gmx.de>

Do not create the artist graphic card if the user disabled it
with "-global artist.disable=true" on the command line.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/machine.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 9c98b4c229..c5f247633e 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -366,12 +366,15 @@ static void machine_HP_common_init_tail(MachineState *machine, PCIBus *pci_bus,
 
     /* Graphics setup. */
     if (machine->enable_graphics && vga_interface_type != VGA_NONE) {
-        vga_interface_created = true;
         dev = qdev_new("artist");
         s = SYS_BUS_DEVICE(dev);
-        sysbus_realize_and_unref(s, &error_fatal);
-        sysbus_mmio_map(s, 0, translate(NULL, LASI_GFX_HPA));
-        sysbus_mmio_map(s, 1, translate(NULL, ARTIST_FB_ADDR));
+        bool disabled = object_property_get_bool(OBJECT(dev), "disable", NULL);
+        if (!disabled) {
+            sysbus_realize_and_unref(s, &error_fatal);
+            vga_interface_created = true;
+            sysbus_mmio_map(s, 0, translate(NULL, LASI_GFX_HPA));
+            sysbus_mmio_map(s, 1, translate(NULL, ARTIST_FB_ADDR));
+        }
     }
 
     /* Network setup. */
-- 
2.47.0


