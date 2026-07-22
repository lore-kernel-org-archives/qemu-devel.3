Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD10FC4453F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWPO-0006yM-3h; Wed, 22 Jul 2026 08:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWNN-0003YO-He; Wed, 22 Jul 2026 08:48:45 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWNK-0001sC-SS; Wed, 22 Jul 2026 08:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724390; bh=mcp0GimSRDvqcCRwzIyNdZqxXIDZ6ogX6yMKCLqEcS0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SJF06jFqhjkjuWzkTpa6fchFviF44N7Bqg7dzUF8Jezym4G98oZYInfgvv7HpSRbt
 E9jhLmRuPf8PY9G30zCN9tPLorFMdBunMBxcFBbOY92VnOR5pzJWjQEdBhkxqIqTpe
 2QLaNNBI8fLOEw8D5OmQsu6eZ9ZG/1WuCwaSGt4uqwItjpe8MLPxtk4E1lrc+BMG7s
 55UVhH8ksz0jdOwg6FvAXNKKPf4GkFpzQbJYGUv8XZcy9RxBxpk0YR0zOo9u59MmhK
 S4tpgqXDnTV9AGQsoZb64yVWWgpTVzJ1YMHuDU3rUvI2junCIAq5IOZbrARlwZvJQ7
 tHByhxd/BTaRg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A76351C3B0B;
 Wed, 22 Jul 2026 15:46:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id ED7A33F3765;
 Wed, 22 Jul 2026 15:46:47 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6CA2A17EFF; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Feifan Qian <bea1e@proton.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 098/122] hw/usb/hcd-xhci: Turn guest-triggerable
 abort() into qemu_log_mask()
Date: Wed, 22 Jul 2026 15:45:47 +0300
Message-ID: <20260722124622.31034-23-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Thomas Huth <thuth@redhat.com>

The FIXME macros in xhci_alloc_device_streams() can be triggered
by a (malicious) guest. Since the macro also contains an abort()
statement, this terminates QEMU. Turn the FIXME statements into
a qemu_log_mask() instead to avoid that a guest can shoot itself
this way.

Reported-by: Feifan Qian <bea1e@proton.me>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3784
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260713161406.361197-2-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 5257259428eaa305b76e63e5657448a39de0570f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 64c3a23b9b7..5835b1566dc 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -965,11 +965,13 @@ static TRBCCode xhci_alloc_device_streams(XHCIState *xhci, unsigned int slotid,
          * together and make an usb_device_alloc_streams call per group.
          */
         if (epctxs[i]->nr_pstreams != req_nr_streams) {
-            FIXME("guest streams config not identical for all eps");
+            qemu_log_mask(LOG_UNIMP,
+                          "guest streams config not identical for all eps\n");
             return CC_RESOURCE_ERROR;
         }
         if (eps[i]->max_streams != dev_max_streams) {
-            FIXME("device streams config not identical for all eps");
+            qemu_log_mask(LOG_UNIMP,
+                          "device streams config not identical for all eps\n");
             return CC_RESOURCE_ERROR;
         }
     }
-- 
2.47.3


