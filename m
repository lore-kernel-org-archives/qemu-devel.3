Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC31CCF2CF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB0V-0005Zv-O3; Sat, 17 Oct 2026 16:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB09-0005Cm-Lc; Sat, 17 Oct 2026 16:27:35 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB05-0003uc-Dt; Sat, 17 Oct 2026 16:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268830; bh=KHePKfogxeS8j3nlAq9JkImMvLuEe70YBvA2vP9BZHk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XaQ7uDTTgpggwwD33FUQY1jQgV8q+aepLa6e5aEtAaJ+FkipznF7Rx57Z3PFWaFwb
 eL7nDDTNKlnzV2s2LOKNvS5qZSC6hwJA9pLd60xiIAWR/wT7u6Gk377gnZNy9judqz
 mScr5yZJcoPFDfD20u2PBgfr1MhulbRwBo6s4G3vgjfe0YGQFWiwk/1CaJ9tG9rF+g
 72kdtuyjjqs8ahLJs2xIivxTYQUEBJ49XuPcJKU6V8WX4Zu3aUfyoVVRkaI7SYi/MN
 fXmRDySrBfsLRv4UTyGlY7oyC6KQA3SkS9tZrKq2Iavu5JdHpXHqPNiGGovkr0o5ZP
 r18NkIXmGf3vQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 73E0C1DE743;
 Sat, 17 Oct 2026 23:27:10 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6B58B44341A;
 Sat, 17 Oct 2026 23:27:09 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Anthony Krowiak <akrowiak@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 08/73] vfio/ap: Clear error object pointer after
 non-fatal errors
Date: Sat, 17 Oct 2026 23:25:26 +0300
Message-ID: <20261017202638.728621-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
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

From: Eric Farman <farman@linux.ibm.com>

Registering a new IRQ notifier will allocate an error object if needed,
and warn_report_err() will release that memory once it's finished.
The pointer remains, however, so subsequent errors after the non-fatal
errors in vfio_ap_realize() would cause an assertion failure for a
non-NULL pointer.

Fix this by clearing the pointer once the warning has been reported,
to reset the state of the error objects.

Cc: Anthony Krowiak <akrowiak@linux.ibm.com>
Cc: qemu-stable@nongnu.org
Fixes: 1360b2ad1f ("s390x/ap: Wire up the device request notifier interface")
Fixes: 0fb8a62fe4 ("hw/vfio/ap: notification handler for AP config changed event")
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260922201526.2383047-5-farman@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit 057ca01937b75d772da5a0f8c0282e7c9dbdfb63)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 6e2a1223ea..2926e04ad4 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -247,8 +247,10 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
         /*
          * Report this error, but do not make it a failing condition.
          * Lack of this IRQ in the host does not prevent normal operation.
+         * Clear the pointer, since the warning will release it.
          */
         warn_report_err(err);
+        err = NULL;
     }
 
     if (!vfio_ap_register_irq_notifier(vapdev, VFIO_AP_CFG_CHG_IRQ_INDEX, &err))
@@ -256,8 +258,10 @@ static void vfio_ap_realize(DeviceState *dev, Error **errp)
         /*
          * Report this error, but do not make it a failing condition.
          * Lack of this IRQ in the host does not prevent normal operation.
+         * Clear the pointer, since the warning will release it.
          */
         warn_report_err(err);
+        err = NULL;
     }
 
     return;
-- 
2.47.3


