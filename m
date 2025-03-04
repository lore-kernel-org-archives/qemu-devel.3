Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE2EC282DC
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaZk-0005RF-EX; Tue, 04 Mar 2025 17:17:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaYJ-000478-Oa
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:15:53 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaXY-0001Us-PB
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:15:50 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tpaQZ-00000000LcL-3KZI; Tue, 04 Mar 2025 23:07:51 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Peter Xu <peterx@redhat.com>,
	Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: [PATCH v6 36/36] vfio/migration: Update VFIO migration documentation
Date: Tue,  4 Mar 2025 23:04:03 +0100
Message-ID: <6bbaaab45a9b8a2707c63570635255183eb1e997.1741124640.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741124640.git.maciej.szmigiero@oracle.com>
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Update the VFIO documentation at docs/devel/migration describing the
changes brought by the multifd device state transfer.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 docs/devel/migration/vfio.rst | 79 +++++++++++++++++++++++++++++++----
 1 file changed, 72 insertions(+), 7 deletions(-)

diff --git a/docs/devel/migration/vfio.rst b/docs/devel/migration/vfio.rst
index c49482eab66d..fb76a38c333f 100644
--- a/docs/devel/migration/vfio.rst
+++ b/docs/devel/migration/vfio.rst
@@ -67,14 +67,39 @@ VFIO implements the device hooks for the iterative approach as follows:
 * A ``switchover_ack_needed`` function that checks if the VFIO device uses
   "switchover-ack" migration capability when this capability is enabled.
 
-* A ``save_state`` function to save the device config space if it is present.
+* A ``switchover_start`` function that in the multifd mode starts a thread that
+  reassembles the multifd received data and loads it in-order into the device.
+  In the non-multifd mode this function is a NOP.
 
-* A ``save_live_complete_precopy`` function that sets the VFIO device in
-  _STOP_COPY state and iteratively copies the data for the VFIO device until
-  the vendor driver indicates that no data remains.
+* A ``save_state`` function to save the device config space if it is present
+  in the non-multifd mode.
+  In the multifd mode it just emits either a dummy EOS marker or
+  "all iterables were loaded" flag for configurations that need to defer
+  loading device config space after them.
 
-* A ``load_state`` function that loads the config section and the data
-  sections that are generated by the save functions above.
+* A ``save_live_complete_precopy`` function that in the non-multifd mode sets
+  the VFIO device in _STOP_COPY state and iteratively copies the data for the
+  VFIO device until the vendor driver indicates that no data remains.
+  In the multifd mode it just emits a dummy EOS marker.
+
+* A ``save_live_complete_precopy_thread`` function that in the multifd mode
+  provides thread handler performing multifd device state transfer.
+  It sets the VFIO device to _STOP_COPY state, iteratively reads the data
+  from the VFIO device and queues it for multifd transmission until the vendor
+  driver indicates that no data remains.
+  After that, it saves the device config space and queues it for multifd
+  transfer too.
+  In the non-multifd mode this thread is a NOP.
+
+* A ``load_state`` function that loads the data sections that are generated
+  by the main migration channel save functions above.
+  In the non-multifd mode it also loads the config section, while in the
+  multifd mode it handles the optional "all iterables were loaded" flag if
+  it is in use.
+
+* A ``load_state_buffer`` function that loads the device state and the device
+  config that arrived via multifd channels.
+  It's used only in the multifd mode.
 
 * ``cleanup`` functions for both save and load that perform any migration
   related cleanup.
@@ -176,8 +201,11 @@ Live migration save path
                 Then the VFIO device is put in _STOP_COPY state
                      (FINISH_MIGRATE, _ACTIVE, _STOP_COPY)
          .save_live_complete_precopy() is called for each active device
-      For the VFIO device, iterate in .save_live_complete_precopy() until
+              For the VFIO device: in the non-multifd mode iterate in
+                        .save_live_complete_precopy() until
                                pending data is 0
+	          In the multifd mode this iteration is done in
+	          .save_live_complete_precopy_thread() instead.
                                       |
                      (POSTMIGRATE, _COMPLETED, _STOP_COPY)
             Migraton thread schedules cleanup bottom half and exits
@@ -194,6 +222,9 @@ Live migration resume path
                           (RESTORE_VM, _ACTIVE, _STOP)
                                       |
      For each device, .load_state() is called for that device section data
+                 transmitted via the main migration channel.
+     For data transmitted via multifd channels .load_state_buffer() is called
+                                   instead.
                         (RESTORE_VM, _ACTIVE, _RESUMING)
                                       |
   At the end, .load_cleanup() is called for each device and vCPUs are started
@@ -206,3 +237,37 @@ Postcopy
 ========
 
 Postcopy migration is currently not supported for VFIO devices.
+
+Multifd
+=======
+
+Starting from QEMU version 10.0 there's a possibility to transfer VFIO device
+_STOP_COPY state via multifd channels. This helps reduce downtime - especially
+with multiple VFIO devices or with devices having a large migration state.
+As an additional benefit, setting the VFIO device to _STOP_COPY state and
+saving its config space is also parallelized (run in a separate thread) in
+such migration mode.
+
+The multifd VFIO device state transfer is controlled by
+"x-migration-multifd-transfer" VFIO device property. This property defaults to
+AUTO, which means that VFIO device state transfer via multifd channels is
+attempted in configurations that otherwise support it.
+
+Since the target QEMU needs to load device state buffers in-order it needs to
+queue incoming buffers until they can be loaded into the device.
+This means that a malicious QEMU source could theoretically cause the target
+QEMU to allocate unlimited amounts of memory for such buffers-in-flight.
+
+The "x-migration-max-queued-buffers" property allows capping the maximum count
+of these VFIO device state buffers queued at the destination.
+
+Because a malicious QEMU source causing OOM on the target is not expected to be
+a realistic threat in most of VFIO live migration use cases and the right value
+depends on the particular setup by default this queued buffers limit is
+disabled by setting it to UINT64_MAX.
+
+Some host platforms (like ARM64) require that VFIO device config is loaded only
+after all iterables were loaded.
+Such interlocking is controlled by "x-migration-load-config-after-iter" VFIO
+device property, which in its default setting (AUTO) does so only on platforms
+that actually require it.

