Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E782C54FB3
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 12:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJA9z-0004g9-RN; Sun, 25 May 2025 08:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJA9c-0004QE-6x; Sun, 25 May 2025 08:08:36 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uJA9Z-0003BU-1P; Sun, 25 May 2025 08:08:35 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3E07D124E4C;
 Sun, 25 May 2025 15:08:17 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 41C03215FB3;
 Sun, 25 May 2025 15:08:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Keith Busch <kbusch@kernel.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.1 26/59] hw/nvme: fix nvme hotplugging
Date: Sun, 25 May 2025 15:07:43 +0300
Message-Id: <20250525120818.273372-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-10.0.1-20250525112807@cover.tls.msk.ru>
References: <qemu-stable-10.0.1-20250525112807@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Klaus Jensen <k.jensen@samsung.com>

Commit cd59f50ab017 caused a regression on nvme hotplugging for devices
with an implicit nvm subsystem.

The nvme-subsys device was incorrectly left with being marked as
non-hotpluggable. Fix this.

Cc: qemu-stable@nongnu.org
Reported-by: Stéphane Graber <stgraber@stgraber.org>
Tested-by: Stéphane Graber <stgraber@stgraber.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2950
Fixes: cd59f50ab017 ("hw/nvme: always initialize a subsystem")
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit 0b1c23a582f7bc721a9b858c289a8d165152a6a0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
index b617ac3892..64138cbd6d 100644
--- a/hw/nvme/subsys.c
+++ b/hw/nvme/subsys.c
@@ -226,7 +226,6 @@ static void nvme_subsys_class_init(ObjectClass *oc, void *data)
 
     dc->realize = nvme_subsys_realize;
     dc->desc = "Virtual NVMe subsystem";
-    dc->hotpluggable = false;
 
     device_class_set_props(dc, nvme_subsystem_props);
 }
-- 
2.39.5


