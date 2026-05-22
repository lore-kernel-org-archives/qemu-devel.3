Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 490FECD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXYI-0004CI-Ol; Fri, 22 May 2026 17:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXXv-0003YO-2c; Fri, 22 May 2026 17:36:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXXr-00019V-2m; Fri, 22 May 2026 17:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779485634; bh=iB8+DD2CCARFB1ExC1+rjLjOekeA9E4stav5DEa6fiA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZzTkUGdyZoVLZax1jY80VamBKe6Skxtaqj1HB8MOW5fsPiaizTkVGKRFhyGjFE/+z
 dDKjyFmyGzSQ2PFp6EjC/7NDtw4QrGWbLtiBuPHJ/EH2kO73NSxeorSz0w/7NoxTG2
 saIpuj6ZBFeME/RzzCOayvaWKsjMnhOXmd95hVkmcFmCbJw6o6UAfAitvcD3gEHkfK
 Q5jDqQYI/vj+gVfv3Hvcx2W/4lw1BUkDjx5+lbBebNmrLkRgSUXV/+CiY2rfUWJtId
 6Yfk8RLcjQuwNwhQKByyEgw9uNkj7WvSK7z93eudW1RQ1AZ1HteWiUXHD4oF5yyb6F
 OCedYWGA8RqOQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 246DE1AFAE7;
 Sat, 23 May 2026 00:33:54 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 487583B716D;
 Sat, 23 May 2026 00:33:58 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.1 88/94] block: Create DEFAULT_BLOCK_CONF macro
Date: Sat, 23 May 2026 00:33:45 +0300
Message-ID: <20260522213356.806058-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.1-20260522213549@cover.tls.msk.ru>
References: <qemu-stable-11.0.1-20260522213549@cover.tls.msk.ru>
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

From: Kevin Wolf <kwolf@redhat.com>

The property default values from include/hw/block/block.h were
duplicated in scsi_bus_legacy_handle_cmdline(), allowing them to go out
of sync easily. There doesn't seem a good way to avoid the duplication,
but moving them next to each other in the header file should help to
avoid this problem in the future.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260410152314.86412-2-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit a1310cc6281d22ac948f4aa198dcc55d58fc039d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 1a6b181b9d..dccb2f25b2 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -485,12 +485,7 @@ void scsi_bus_legacy_handle_cmdline(SCSIBus *bus)
     Location loc;
     DriveInfo *dinfo;
     int unit;
-    BlockConf conf = {
-        .bootindex = -1,
-        .share_rw = false,
-        .rerror = BLOCKDEV_ON_ERROR_AUTO,
-        .werror = BLOCKDEV_ON_ERROR_AUTO,
-    };
+    BlockConf conf = DEFAULT_BLOCK_CONF;
 
     loc_push_none(&loc);
     for (unit = 0; unit <= bus->info->max_target; unit++) {
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index 7dc19d8a45..e0a427039e 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -51,6 +51,13 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
     return exp;
 }
 
+#define DEFAULT_BLOCK_CONF (BlockConf) {                                \
+    .bootindex = -1,                                                    \
+    .share_rw = false,                                                  \
+    .rerror = BLOCKDEV_ON_ERROR_AUTO,                                   \
+    .werror = BLOCKDEV_ON_ERROR_AUTO,                                   \
+}
+
 #define DEFINE_BLOCK_PROPERTIES_BASE(_state, _conf)                     \
     DEFINE_PROP_ON_OFF_AUTO("backend_defaults", _state,                 \
                             _conf.backend_defaults, ON_OFF_AUTO_AUTO),  \
-- 
2.47.3


