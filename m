Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A12CD2F033
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 14:10:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkjh0-0007xo-1T; Tue, 27 Jan 2026 09:05:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vkjgw-0007wc-KD
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:05:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vkjgu-0007NS-Gt
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:05:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769522710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RhnzShHRyi4TuqfDez8LmHbT/EVu54Nc0/hZC7DJTzM=;
 b=W+tx2scFWDDC6JhXw2X7mabyF+kiYvkdZzDM0kYDz9fmtmFbQq9WwtbpF9PjhI5/J/XBYC
 cc5bEXw8w7Mesub4mztyf7D/h530kzVuaTt1/c6eNlEyFtZdazgotDZg60nrg0zGs+keYG
 J+/PlauwPBoWhIrxHBJuKDsl5+pSLY0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-ZeS_96mLNSqIsBSWF6L0Rg-1; Tue,
 27 Jan 2026 09:03:55 -0500
X-MC-Unique: ZeS_96mLNSqIsBSWF6L0Rg-1
X-Mimecast-MFC-AGG-ID: ZeS_96mLNSqIsBSWF6L0Rg_1769522634
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F22A81956096; Tue, 27 Jan 2026 14:03:53 +0000 (UTC)
Received: from fedora (unknown [10.43.3.182])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B5EA81800665; Tue, 27 Jan 2026 14:03:51 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 3/4] migration: Convert VMSD early_setup into VMStateSavePhase
 enum
Date: Tue, 27 Jan 2026 15:03:09 +0100
Message-ID: <20260127140316.4187221-4-jmarcin@redhat.com>
In-Reply-To: <20260127140316.4187221-1-jmarcin@redhat.com>
References: <20260127140316.4187221-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Juraj Marcin <jmarcin@redhat.com>

This allows devices to specify when during migration their fields should
be saved. For now there are two Save Phases defined.

EARLY_START

These devices are saved during qemu_savevm_state_setup(), and
corresponds to migration SETUP state, same behavior as the former
early_setup flag.

COMPLETE

These devices are saved during migration completion or switch-over with
qemu_savevm_state_complete_precopy_non_iterable(), this corresponds to
the migration DEVICE state. This is the default phase if none is
specified explicitly.

This also allows introduction of other phases in the future, for example
ITERATE_LIVE and POSTCOPY once support for iterative devices and
postcopy is implemented in VMSD, and for the NETPASS phase implemented
in this series.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 hw/virtio/virtio-mem.c      |  2 +-
 include/migration/vmstate.h | 27 +++++++++++++++++++--------
 migration/savevm.c          |  4 ++--
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index c1e2defb68..6d3e3746e5 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -1438,7 +1438,7 @@ static const VMStateDescription vmstate_virtio_mem_device_early = {
     .name = "virtio-mem-device-early",
     .minimum_version_id = 1,
     .version_id = 1,
-    .early_setup = true,
+    .phase = VMS_PHASE_EARLY_SETUP,
     .post_load = virtio_mem_post_load_early,
     .fields = (const VMStateField[]) {
         VMSTATE_WITH_TMP(VirtIOMEM, VirtIOMEMMigSanityChecks,
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index ed9095a466..62d7e9fe38 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -186,18 +186,29 @@ struct VMStateField {
     bool (*field_exists)(void *opaque, int version_id);
 };
 
-struct VMStateDescription {
-    const char *name;
-    bool unmigratable;
+typedef enum {
     /*
-     * This VMSD describes something that should be sent during setup phase
-     * of migration. It plays similar role as save_setup() for explicitly
+     * Specifies a VMSD of a device that should be migrated during the migration
+     * completion phase (switch-over). (Default behavior, same behavior as
+     * before the introduction of save phase.)
+     */
+    VMS_PHASE_COMPLETE = 0,
+    /*
+     * Specifies a VMSD of a device that should be saved during setup phase of
+     * migration. It plays similar role as save_setup() for explicitly
      * registered vmstate entries, so it can be seen as a way to describe
      * save_setup() in VMSD structures.
-     *
+     */
+    VMS_PHASE_EARLY_SETUP,
+} VMStateSavePhase;
+
+struct VMStateDescription {
+    const char *name;
+    bool unmigratable;
+    /*
      * Note that for now, a SaveStateEntry cannot have a VMSD and
      * operations (e.g., save_setup()) set at the same time. Consequently,
-     * save_setup() and a VMSD with early_setup set to true are mutually
+     * save_setup() and a VMSD with phase set to EARLY_SETUP are mutually
      * exclusive. For this reason, also early_setup VMSDs are migrated in a
      * QEMU_VM_SECTION_FULL section, while save_setup() data is migrated in
      * a QEMU_VM_SECTION_START section.
@@ -213,7 +224,7 @@ struct VMStateDescription {
      *          <0 on error where -value is an error number from errno.h
      */
 
-    bool early_setup;
+    VMStateSavePhase phase;
     int version_id;
     int minimum_version_id;
     MigrationPriority priority;
diff --git a/migration/savevm.c b/migration/savevm.c
index 1020094fc8..78eb1d6165 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1370,7 +1370,7 @@ int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
 
     trace_savevm_state_setup();
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (se->vmsd && se->vmsd->early_setup) {
+        if (se->vmsd && se->vmsd->phase == VMS_PHASE_EARLY_SETUP) {
             ret = vmstate_save(f, se, vmdesc, errp);
             if (ret) {
                 migrate_error_propagate(ms, error_copy(*errp));
@@ -1672,7 +1672,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
     cpu_synchronize_all_states();
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (se->vmsd && se->vmsd->early_setup) {
+        if (se->vmsd && se->vmsd->phase != VMS_PHASE_COMPLETE) {
             /* Already saved during qemu_savevm_state_setup(). */
             continue;
         }
-- 
2.52.0


