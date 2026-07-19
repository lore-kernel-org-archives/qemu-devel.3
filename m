Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83D7C4450A
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 15:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlTMa-0001jG-Fd; Sun, 19 Jul 2026 11:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wlTMW-0001iW-Tg
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 11:23:30 -0400
Received: from mail-106113.protonmail.ch ([79.135.106.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthew@pq.io>) id 1wlTMS-0006ho-QI
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 11:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pq.io;
 s=protonmail3; t=1784474602; x=1784733802;
 bh=geDIVkUUMmtblRevTeGjd6FLOcZXcoarTDChM9THX3U=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=kjzyqH76eidDtwdGTuwLzgJ0BmEwd35ErJbhFBiJdLVWpYPr6n272jbfbsBOYJ00U
 V7YO09z6FjAJn8Jcl8zD/wwHV+BHBpvwa3SrOBC6wKczHfdY7HvmCGscvoc3UfvkqY
 UHmxXg0Gz/ueMtxNchkIqM2T4JtynOqgyx2XNKZvdYrIoZA7zbyEl0CHPhsGWmHSh7
 MIFJaFvSeww51/ew/3bkFA4fIeznOU7rR33s2+i8/I+Y+lR6zInqnz+mJ+PWl5mSJ7
 4snfz9M7NjL7c7mL89uB7FVM3DdKPe4ag9oXnp8rRQBJtrxknlpE/XH0GKptXxy+Ck
 CtazxN9HxdDcA==
X-Pm-Submission-Id: 4h36qF0nX1z1DDLW
From: Matthew Jackson <matthew@pq.io>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com
Subject: [PATCH 1/4] hw/display/vmware_vga: raise resolution ceiling to 5K
 (5120x2880)
Date: Sun, 19 Jul 2026 08:23:15 -0700
Message-ID: <20260719152318.69481-2-matthew@pq.io>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260719152318.69481-1-matthew@pq.io>
References: <20260719152318.69481-1-matthew@pq.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=79.135.106.113; envelope-from=matthew@pq.io;
 helo=mail-106113.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

`SVGA_MAX_WIDTH` and `SVGA_MAX_HEIGHT` have been 2368x1770
since the device model's introduction. These constants gate
the guest's `SVGA_REG_MAX_WIDTH` / `SVGA_REG_MAX_HEIGHT`
responses; modern Linux/vmwgfx and macOS vmware_vga drivers
reject any larger requested mode with `invalid resolution` so
the device caps at effectively 1440p even on boards with
enough VRAM for higher modes.

The comment on the defines reads:

    /* These values can probably be changed arbitrarily.  */

Raise the caps to 5K (5120x2880). The VRAM BAR still bounds
what the guest can actually allocate, so this is a mode-
validation upper bound only - guests with a 16 MB default
vgamem still see the VRAM exhaustion error they always did
when requesting >2K modes, they just no longer hit the
software-side cap first.

Signed-off-by: Matthew Jackson <matthew@pq.io>
---
 hw/display/vmware_vga.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -218,10 +218,15 @@
 #define SVGA_FIFO_FLAG_NONE             0
 #define SVGA_FIFO_FLAG_ACCELFRONT       (1 << 0)

-/* These values can probably be changed arbitrarily.  */
+/*
+ * Raise the software-side geometry cap to 5K (5120x2880) so modern
+ * macOS/Linux guests can negotiate Retina-class modes. The VRAM BAR
+ * still bounds what the guest can actually allocate; this is an upper
+ * bound for mode validation.
+ */
 #define SVGA_SCRATCH_SIZE               0x8000
-#define SVGA_MAX_WIDTH                  2368
-#define SVGA_MAX_HEIGHT                 1770
+#define SVGA_MAX_WIDTH                  5120
+#define SVGA_MAX_HEIGHT                 2880

 #ifdef VERBOSE
 # define GUEST_OS_BASE          0x5001
--
2.47.0


