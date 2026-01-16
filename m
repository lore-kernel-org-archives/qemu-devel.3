Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32757C982C7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 14:40:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkzj-0005Xw-Sz; Fri, 16 Jan 2026 09:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vgkzh-0005Fj-C7; Fri, 16 Jan 2026 09:40:09 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vgkzc-0003HT-IF; Fri, 16 Jan 2026 09:40:09 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B06FF47122;
 Fri, 16 Jan 2026 15:39:51 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 jsnow@redhat.com
Subject: [PATCH] hw/block/block: add 'throttle-group' property
Date: Fri, 16 Jan 2026 15:39:33 +0100
Message-ID: <20260116143946.1031006-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1768574340328
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

With '-drive', it is possible to specify the throttle configuration
directly on the commandline. Add the possibility to do the same when
using the modern way with '-blockdev' and a front-end device. Using a
throttle filter block node is not always an option: in particular, the
mirror block job operates on a root block node and it might be desired
to throttle only the guest IO, but not to the block job.

There already is a 'block_set_io_throttle' QMP command, but it's nicer
to be able to do it via the commandline too.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Hope I didn't miss a way to do this already.

Should changing via qom-set be supported? Currently, an attempt fails:
> Error: Attempt to set property 'throttle-group' on device 'scsi0'
> (type 'scsi-hd') after it was realized
but there already is the 'block_set_io_throttle' QMP command.

 hw/block/block.c           | 15 +++++++++++++++
 include/hw/block/block.h   |  4 +++-
 tests/qemu-iotests/172.out | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/hw/block/block.c b/hw/block/block.c
index f187fa025d..1d70acdb76 100644
--- a/hw/block/block.c
+++ b/hw/block/block.c
@@ -254,6 +254,21 @@ bool blkconf_apply_backend_options(BlockConf *conf, bool readonly,
                           conf->num_stats_intervals, errp)) {
         return false;
     }
+
+    if (conf->throttle_group) {
+        if (!throttle_group_exists(conf->throttle_group)) {
+            error_setg(errp, "Throttle group '%s' not found",
+                       conf->throttle_group);
+            return false;
+        }
+        if (blk_get_public(blk)->throttle_group_member.throttle_state) {
+            error_setg(errp, "Cannot set throttle group, because there already"
+                       " is a throttle configuration (via '-drive'?)");
+            return false;
+        }
+        blk_io_limits_enable(blk, conf->throttle_group);
+    }
+
     return true;
 }
 
diff --git a/include/hw/block/block.h b/include/hw/block/block.h
index 7dc19d8a45..5565b32e62 100644
--- a/include/hw/block/block.h
+++ b/include/hw/block/block.h
@@ -36,6 +36,7 @@ typedef struct BlockConf {
     BlockdevOnError werror;
     uint32_t num_stats_intervals;
     uint32_t *stats_intervals;
+    char *throttle_group;
 } BlockConf;
 
 static inline unsigned int get_physical_block_exp(BlockConf *conf)
@@ -71,7 +72,8 @@ static inline unsigned int get_physical_block_exp(BlockConf *conf)
                             _conf.account_failed, ON_OFF_AUTO_AUTO),    \
     DEFINE_PROP_ARRAY("stats-intervals", _state,                        \
                      _conf.num_stats_intervals, _conf.stats_intervals,  \
-                     qdev_prop_uint32, uint32_t)
+                     qdev_prop_uint32, uint32_t),                       \
+    DEFINE_PROP_STRING("throttle-group", _state, _conf.throttle_group)
 
 #define DEFINE_BLOCK_PROPERTIES(_state, _conf)                          \
     DEFINE_PROP_DRIVE("drive", _state, _conf.blk),                      \
diff --git a/tests/qemu-iotests/172.out b/tests/qemu-iotests/172.out
index a023cd407d..368c411dcf 100644
--- a/tests/qemu-iotests/172.out
+++ b/tests/qemu-iotests/172.out
@@ -31,6 +31,7 @@ Testing:
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "288"
 
 
@@ -61,6 +62,7 @@ Testing: -fda TEST_DIR/t.qcow2
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -98,6 +100,7 @@ Testing: -fdb TEST_DIR/t.qcow2
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -113,6 +116,7 @@ Testing: -fdb TEST_DIR/t.qcow2
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "288"
 floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -154,6 +158,7 @@ Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2.2
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -169,6 +174,7 @@ Testing: -fda TEST_DIR/t.qcow2 -fdb TEST_DIR/t.qcow2.2
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -211,6 +217,7 @@ Testing: -fdb
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "288"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -226,6 +233,7 @@ Testing: -fdb
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "288"
 
 
@@ -256,6 +264,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -293,6 +302,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2,index=1
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -308,6 +318,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2,index=1
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "288"
 floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -349,6 +360,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=floppy,file=TEST_DIR/t
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -364,6 +376,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=floppy,file=TEST_DIR/t
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -409,6 +422,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -446,6 +460,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,unit=1
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -483,6 +498,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -498,6 +514,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qco
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -549,6 +566,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -564,6 +582,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -606,6 +625,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -621,6 +641,7 @@ Testing: -fda TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -663,6 +684,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 1 (0x1)
@@ -678,6 +700,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
 floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -720,6 +743,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 1 (0x1)
@@ -735,6 +759,7 @@ Testing: -fdb TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.qcow2.2 -device fl
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
 floppy1 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -786,6 +811,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -801,6 +827,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -843,6 +870,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
               dev: floppy, id ""
                 unit = 0 (0x0)
@@ -858,6 +886,7 @@ Testing: -drive if=floppy,file=TEST_DIR/t.qcow2 -drive if=none,file=TEST_DIR/t.q
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
 floppy0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/unattached/device[N]
@@ -906,6 +935,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -global floppy.drive=none0 -device
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -973,6 +1003,7 @@ Testing: -device floppy
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "288"
 
 Testing: -device floppy,drive-type=120
@@ -1000,6 +1031,7 @@ Testing: -device floppy,drive-type=120
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "120"
 
 Testing: -device floppy,drive-type=144
@@ -1027,6 +1059,7 @@ Testing: -device floppy,drive-type=144
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
 
 Testing: -device floppy,drive-type=288
@@ -1054,6 +1087,7 @@ Testing: -device floppy,drive-type=288
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "288"
 
 
@@ -1084,6 +1118,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,drive-t
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "120"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -1121,6 +1156,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,drive-t
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "288"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -1161,6 +1197,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,logical
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
@@ -1198,6 +1235,7 @@ Testing: -drive if=none,file=TEST_DIR/t.qcow2 -device floppy,drive=none0,physica
                 account-invalid = "auto"
                 account-failed = "auto"
                 stats-intervals = <null>
+                throttle-group = ""
                 drive-type = "144"
 none0 (NODE_NAME): TEST_DIR/t.qcow2 (qcow2)
     Attached to:      /machine/peripheral-anon/device[N]
-- 
2.47.3



