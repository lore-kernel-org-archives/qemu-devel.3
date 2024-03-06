Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DDBC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 13:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhrQQ-0008EL-5m; Wed, 06 Mar 2024 08:35:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrQK-0008Dd-Ps
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:35:08 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org>)
 id 1rhrQI-0004yy-9y
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 08:35:08 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TqYMV3xpwz4wx5;
 Thu,  7 Mar 2024 00:35:02 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqYMR2ZF1z4wcF;
 Thu,  7 Mar 2024 00:34:59 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 03/25] migration: Add documentation for SaveVMHandlers
Date: Wed,  6 Mar 2024 14:34:18 +0100
Message-ID: <20240306133441.2351700-4-clg@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306133441.2351700-1-clg@redhat.com>
References: <20240306133441.2351700-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=yBjJ=KM=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The SaveVMHandlers structure is still in use for complex subsystems
and devices. Document the handlers since we are going to modify a few
later.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/migration/register.h | 263 +++++++++++++++++++++++++++++++----
 1 file changed, 237 insertions(+), 26 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index 2e6a7d766e62f64940086b7b511249c9ff21fa62..d7b70a8be68c9df47c7843bda7d430989d7ca384 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -16,30 +16,130 @@
 
 #include "hw/vmstate-if.h"
 
+/**
+ * struct SaveVMHandlers: handler structure to finely control
+ * migration of complex subsystems and devices, such as RAM, block and
+ * VFIO.
+ */
 typedef struct SaveVMHandlers {
-    /* This runs inside the BQL.  */
+
+    /* The following handlers run inside the BQL. */
+
+    /**
+     * @save_state
+     *
+     * Saves state section on the source using the latest state format
+     * version.
+     *
+     * Legacy method. Should be deprecated when all users are ported
+     * to VMStateDescription.
+     *
+     * @f: QEMUFile where to send the data
+     * @opaque: data pointer passed to register_savevm_live()
+     */
     void (*save_state)(QEMUFile *f, void *opaque);
 
-    /*
-     * save_prepare is called early, even before migration starts, and can be
-     * used to perform early checks.
+    /**
+     * @save_prepare
+     *
+     * Called early, even before migration starts, and can be used to
+     * perform early checks.
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     * @errp: pointer to Error*, to store an error if it happens.
+     *
+     * Returns zero to indicate success and negative for error
      */
     int (*save_prepare)(void *opaque, Error **errp);
+
+    /**
+     * @save_setup
+     *
+     * Initializes the data structures on the source and transmits
+     * first section containing information on the device
+     *
+     * @f: QEMUFile where to send the data
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns zero to indicate success and negative for error
+     */
     int (*save_setup)(QEMUFile *f, void *opaque);
+
+    /**
+     * @save_cleanup
+     *
+     * Uninitializes the data structures on the source
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     */
     void (*save_cleanup)(void *opaque);
+
+    /**
+     * @save_live_complete_postcopy
+     *
+     * Called at the end of postcopy for all postcopyable devices.
+     *
+     * @f: QEMUFile where to send the data
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns zero to indicate success and negative for error
+     */
     int (*save_live_complete_postcopy)(QEMUFile *f, void *opaque);
+
+    /**
+     * @save_live_complete_precopy
+     *
+     * Transmits the last section for the device containing any
+     * remaining data at the end of a precopy phase. When postcopy is
+     * enabled, devices that support postcopy will skip this step,
+     * where the final data will be flushed at the end of postcopy via
+     * @save_live_complete_postcopy instead.
+     *
+     * @f: QEMUFile where to send the data
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns zero to indicate success and negative for error
+     */
     int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
 
     /* This runs both outside and inside the BQL.  */
+
+    /**
+     * @is_active
+     *
+     * Will skip a state section if not active
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns true if state section is active else false
+     */
     bool (*is_active)(void *opaque);
+
+    /**
+     * @has_postcopy
+     *
+     * Checks if a device supports postcopy
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns true for postcopy support else false
+     */
     bool (*has_postcopy)(void *opaque);
 
-    /* is_active_iterate
-     * If it is not NULL then qemu_savevm_state_iterate will skip iteration if
-     * it returns false. For example, it is needed for only-postcopy-states,
-     * which needs to be handled by qemu_savevm_state_setup and
-     * qemu_savevm_state_pending, but do not need iterations until not in
-     * postcopy stage.
+    /**
+     * @is_active_iterate
+     *
+     * As #SaveVMHandlers.is_active(), will skip an inactive state
+     * section in qemu_savevm_state_iterate.
+     *
+     * For example, it is needed for only-postcopy-states, which needs
+     * to be handled by qemu_savevm_state_setup() and
+     * qemu_savevm_state_pending(), but do not need iterations until
+     * not in postcopy stage.
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns true if state section is active else false
      */
     bool (*is_active_iterate)(void *opaque);
 
@@ -48,44 +148,155 @@ typedef struct SaveVMHandlers {
      * use data that is local to the migration thread or protected
      * by other locks.
      */
+
+    /**
+     * @save_live_iterate
+     *
+     * Should send a chunk of data until the point that stream
+     * bandwidth limits tell it to stop. Each call generates one
+     * section.
+     *
+     * @f: QEMUFile where to send the data
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns 0 to indicate that there is still more data to send,
+     *         1 that there is no more data to send and
+     *         negative to indicate an error.
+     */
     int (*save_live_iterate)(QEMUFile *f, void *opaque);
 
     /* This runs outside the BQL!  */
-    /* Note for save_live_pending:
-     * must_precopy:
-     * - must be migrated in precopy or in stopped state
-     * - i.e. must be migrated before target start
-     *
-     * can_postcopy:
-     * - can migrate in postcopy or in stopped state
-     * - i.e. can migrate after target start
-     * - some can also be migrated during precopy (RAM)
-     * - some must be migrated after source stops (block-dirty-bitmap)
-     *
-     * Sum of can_postcopy and must_postcopy is the whole amount of
+
+    /**
+     * @state_pending_estimate
+     *
+     * This estimates the remaining data to transfer
+     *
+     * Sum of @can_postcopy and @must_postcopy is the whole amount of
      * pending data.
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     * @must_precopy: amount of data that must be migrated in precopy
+     *                or in stopped state, i.e. that must be migrated
+     *                before target start.
+     * @can_postcopy: amount of data that can be migrated in postcopy
+     *                or in stopped state, i.e. after target start.
+     *                Some can also be migrated during precopy (RAM).
+     *                Some must be migrated after source stops
+     *                (block-dirty-bitmap)
      */
-    /* This estimates the remaining data to transfer */
     void (*state_pending_estimate)(void *opaque, uint64_t *must_precopy,
                                    uint64_t *can_postcopy);
-    /* This calculate the exact remaining data to transfer */
+
+    /**
+     * @state_pending_exact
+     *
+     * This calculates the exact remaining data to transfer
+     *
+     * Sum of @can_postcopy and @must_postcopy is the whole amount of
+     * pending data.
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     * @must_precopy: amount of data that must be migrated in precopy
+     *                or in stopped state, i.e. that must be migrated
+     *                before target start.
+     * @can_postcopy: amount of data that can be migrated in postcopy
+     *                or in stopped state, i.e. after target start.
+     *                Some can also be migrated during precopy (RAM).
+     *                Some must be migrated after source stops
+     *                (block-dirty-bitmap)
+     */
     void (*state_pending_exact)(void *opaque, uint64_t *must_precopy,
                                 uint64_t *can_postcopy);
+
+    /**
+     * @load_state
+     *
+     * Load sections generated by any of the save functions that
+     * generate sections.
+     *
+     * Legacy method. Should be deprecated when all users are ported
+     * to VMStateDescription.
+     *
+     * @f: QEMUFile where to receive the data
+     * @opaque: data pointer passed to register_savevm_live()
+     * @version_id: the maximum version_id supported
+     *
+     * Returns zero to indicate success and negative for error
+     */
     int (*load_state)(QEMUFile *f, void *opaque, int version_id);
+
+    /**
+     * @load_setup
+     *
+     * Initializes the data structures on the destination.
+     *
+     * @f: QEMUFile where to receive the data
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns zero to indicate success and negative for error
+     */
     int (*load_setup)(QEMUFile *f, void *opaque);
+
+    /**
+     * @load_cleanup
+     *
+     * Uninitializes the data structures on the destination.
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns zero to indicate success and negative for error
+     */
     int (*load_cleanup)(void *opaque);
-    /* Called when postcopy migration wants to resume from failure */
+
+    /**
+     * @resume_prepare
+     *
+     * Called when postcopy migration wants to resume from failure
+     *
+     * @s: Current migration state
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns zero to indicate success and negative for error
+     */
     int (*resume_prepare)(MigrationState *s, void *opaque);
-    /* Checks if switchover ack should be used. Called only in dest */
+
+    /**
+     * @switchover_ack_needed
+     *
+     * Checks if switchover ack should be used. Called only on
+     * destination.
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     *
+     * Returns true if switchover ack should be used and false
+     * otherwise
+     */
     bool (*switchover_ack_needed)(void *opaque);
 } SaveVMHandlers;
 
+/**
+ * register_savevm_live: Register a set of custom migration handlers
+ *
+ * @idstr: state section identifier
+ * @instance_id: instance id
+ * @version_id: version id supported
+ * @ops: SaveVMHandlers structure
+ * @opaque: data pointer passed to SaveVMHandlers handlers
+ */
 int register_savevm_live(const char *idstr,
                          uint32_t instance_id,
                          int version_id,
                          const SaveVMHandlers *ops,
                          void *opaque);
 
+/**
+ * unregister_savevm: Unregister custom migration handlers
+ *
+ * @obj: object associated with state section
+ * @idstr:  state section identifier
+ * @opaque: data pointer passed to register_savevm_live()
+ */
 void unregister_savevm(VMStateIf *obj, const char *idstr, void *opaque);
 
 #endif
-- 
2.44.0


