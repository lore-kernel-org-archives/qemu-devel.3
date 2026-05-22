Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A24CCD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXoe-0001AF-7U; Fri, 22 May 2026 17:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXo6-0000Cb-MZ; Fri, 22 May 2026 17:53:26 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXo3-00053K-Dz; Fri, 22 May 2026 17:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779486561; bh=t4CYhJA8XOnr+F14j2WG0HCzMMezf8973YvwtfLOE3I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=pf3Qci7Cks5PKX0V9BiOwGBqIpsagdAHXxKMlbdd7GHWzMRdf+isvyWiXt0UpBmUn
 q99Qzz8VjfX/9RG/ULxFf70oy4XE0U8AAxKLbUbW3Zx5Ry6fHAccXFW30SUJf5xzi8
 A9x5gKhQ7OSQrflPcYiayKa882vFWsfXk/7L/x4FSOR4cZLGaZ+MUBeo5Pql6+b3Gg
 jbmJL47+yJqX0FwvtaZSoDFaW8RkFMvNNZcJKqpo9rHGWXbWPG4RXduejURIKzMUFu
 sonnCVppEzaGjsB9Do5pMUWubV2BojH81670Z0Rl/MhCAlmfyz4kPZAN6F/xBQeQJk
 zIkRDDP17AzTQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CFAB61AFB85;
 Sat, 23 May 2026 00:49:21 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 05F7D3B71D4;
 Sat, 23 May 2026 00:49:26 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 143/149] block: Create DEFAULT_BLOCK_CONF macro
Date: Sat, 23 May 2026 00:49:15 +0300
Message-ID: <20260522214923.807017-44-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
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
index b9b115deed..982287191e 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -482,12 +482,7 @@ void scsi_bus_legacy_handle_cmdline(SCSIBus *bus)
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
index b4d914624e..7da643faff 100644
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


