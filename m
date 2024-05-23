Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75E9C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 07:09:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA2Zx-0002vO-Ff; Thu, 23 May 2024 03:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1sA2Zu-0002t0-UB
 for qemu-devel@nongnu.org; Thu, 23 May 2024 03:09:30 -0400
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1sA2Zr-0005HA-Ho
 for qemu-devel@nongnu.org; Thu, 23 May 2024 03:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1716448162; bh=mXzHop7tE5Sqk2acfGc4NPzDlj+tcQaFj6sjtxvjHIY=;
 h=From:Date:Subject:To:Cc:From;
 b=a15nmSJUK7ezdzRvifH1ZaJv6uFB76uN5v3rt7BjrrCufTssC+aN65hwc984AjjXJ
 oDJnsb1VRaORo6kwSP3B/PW7OoYryrZiVtQTAf5szrdvp/tlMX2CThZ1x0A/pYPaG8
 lt9rLeYpfydV1+375mJzmIV5Kl4UNoMdu/cW7bYg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Date: Thu, 23 May 2024 09:09:17 +0200
Subject: [PATCH] hw: debugexit: use runstate API instead of plain exit()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240523-debugexit-v1-1-d52fcaf7bf8b@t-8ch.de>
X-B4-Tracking: v=1; b=H4sIAJzrTmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyNj3ZTUpNL01IrMEl0jo1RzUwvzxJSk1CQloPqCotS0zAqwWdGxtbU
 AAT4+RlsAAAA=
To: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716448162; l=1341;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=mXzHop7tE5Sqk2acfGc4NPzDlj+tcQaFj6sjtxvjHIY=;
 b=qx+m6TfP48G+DHfvzRtkNAqvibNkyrasDCDpdd9ZX+MtPAyiXss4LcK56vZI+JyE1akGkU3oQ
 RrMau6wLKJJBNIDzp71IFMcjUlavayApTPED76NQBC+oNDAxvUOX7rJ
X-Developer-Key: i=thomas@t-8ch.de; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Received-SPF: pass client-ip=2a01:4f8:c010:41de::1;
 envelope-from=thomas@t-8ch.de; helo=todd.t-8ch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Directly calling exit() prevents any kind of management or handling.
Instead use the corresponding runstate API.
The default behavior of the runstate API is the same as exit().

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
 hw/misc/debugexit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/misc/debugexit.c b/hw/misc/debugexit.c
index ab6de69ce72f..c5c562fd9357 100644
--- a/hw/misc/debugexit.c
+++ b/hw/misc/debugexit.c
@@ -12,6 +12,7 @@
 #include "hw/qdev-properties.h"
 #include "qemu/module.h"
 #include "qom/object.h"
+#include "sysemu/runstate.h"
 
 #define TYPE_ISA_DEBUG_EXIT_DEVICE "isa-debug-exit"
 OBJECT_DECLARE_SIMPLE_TYPE(ISADebugExitState, ISA_DEBUG_EXIT_DEVICE)
@@ -32,7 +33,8 @@ static uint64_t debug_exit_read(void *opaque, hwaddr addr, unsigned size)
 static void debug_exit_write(void *opaque, hwaddr addr, uint64_t val,
                              unsigned width)
 {
-    exit((val << 1) | 1);
+    qemu_system_shutdown_request_with_code(SHUTDOWN_CAUSE_GUEST_SHUTDOWN,
+                                           (val << 1) | 1);
 }
 
 static const MemoryRegionOps debug_exit_ops = {

---
base-commit: 7e1c0047015ffbd408e1aa4a5ec1abe4751dbf7e
change-id: 20240523-debugexit-22e7587adbeb

Best regards,
-- 
Thomas Weißschuh <thomas@t-8ch.de>


