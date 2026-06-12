Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30695CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 17:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY5FW-0005Qy-Eh; Fri, 12 Jun 2026 13:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wY5Ev-00055J-Qv; Fri, 12 Jun 2026 13:00:18 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wY5Eu-00067j-1h; Fri, 12 Jun 2026 13:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781283582; bh=lltfqVI3SUbM60fPgAtziaAUWN/Og/rKJ/16PMUK91A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=c5QpY6eWZm6iA0eqXYOWCS0qLysq5QXf7x43BPUpeouJHDraojx5h99+1GfV1/Ui9
 jJwlXRXLa+jNA4/wt9colqShwC/YEPitMT1JKAUHIq+FIsYNN/lTQdc8G3ZZ1a87D4
 3mr/O94+6GuQHVMjl6Yuiit+v1iooiwT+kw6oWrpWOc0VHSBFZ+IAL2YQ8cBmQjssh
 vTAXxZ/et0EsTaknQ5f1VlBZ7JCAyzRYqo8BYtF6MXqgHvW6ZW60AmcEKqHUejLBZn
 5grVCcczbxs+D8kJhWZtSvi9XiWv8rx+SgEPYTAzuSLWYA2YmuuvtQJH+mVeXqF/Sw
 quMlBUk3uWcMA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 181221B6BCB;
 Fri, 12 Jun 2026 19:59:42 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E14203CE168;
 Fri, 12 Jun 2026 19:59:57 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Ajinkya Udgirkar <ajinkyaudgirkar@gmail.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 6/8] hw/xtensa: replace calloc with g_new0 in mx_pic
Date: Fri, 12 Jun 2026 19:59:50 +0300
Message-ID: <20260612165957.1779082-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612165957.1779082-1-mjt@tls.msk.ru>
References: <20260612165957.1779082-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Ajinkya Udgirkar <ajinkyaudgirkar@gmail.com>

Replace libc calloc() with GLib g_new0() for consistency with the
rest of the QEMU codebase. g_new0() aborts on allocation failure
rather than returning NULL, which matches QEMU's allocation policy.

Signed-off-by: Ajinkya Udgirkar <audgirka@redhat.com>
Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/xtensa/mx_pic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/xtensa/mx_pic.c b/hw/xtensa/mx_pic.c
index 098c1aaf85..8ded3bc79b 100644
--- a/hw/xtensa/mx_pic.c
+++ b/hw/xtensa/mx_pic.c
@@ -343,7 +343,7 @@ static void xtensa_mx_pic_set_irq(void *opaque, int irq, int active)
 
 XtensaMxPic *xtensa_mx_pic_init(unsigned n_irq)
 {
-    XtensaMxPic *mx = calloc(1, sizeof(XtensaMxPic));
+    XtensaMxPic *mx = g_new0(XtensaMxPic, 1);
 
     mx->n_irq = n_irq + 1;
     mx->irq_inputs = qemu_allocate_irqs(xtensa_mx_pic_set_irq, mx,
-- 
2.47.3


