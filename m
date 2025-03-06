Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CB40C28B25
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqC0v-0007qp-Hk; Thu, 06 Mar 2025 09:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0U-0007Hq-LO
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tqC0Q-0001nT-46
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741270520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cttGIj/EgxZzLx7fzWWIjmhxHltQh8WylsSt0tpo05g=;
 b=MvRxb28AV1FipyAqAZnukhnz312f9M+9Y1z0hs+iBDP3VqUW0rH4x6Sgl6fW4cAfJLjT6N
 vz7kT9CZMwLwF1r79LHSLOp98duzrg6+bcBwRdHSbZHoe0++8YdwuuqRs0S2/p6Iskb8xM
 4XtejrlvHP90WCD9vzDjBDYfkqnFZUA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-XAI3TW-2MkGN7_aj0iTOTA-1; Thu,
 06 Mar 2025 09:15:16 -0500
X-MC-Unique: XAI3TW-2MkGN7_aj0iTOTA-1
X-Mimecast-MFC-AGG-ID: XAI3TW-2MkGN7_aj0iTOTA_1741270515
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33B7D180AF69; Thu,  6 Mar 2025 14:15:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.141])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 15D2D18001D3; Thu,  6 Mar 2025 14:15:12 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 15/42] migration: Add qemu_loadvm_load_state_buffer() and its
 handler
Date: Thu,  6 Mar 2025 15:13:51 +0100
Message-ID: <20250306141419.2015340-16-clg@redhat.com>
In-Reply-To: <20250306141419.2015340-1-clg@redhat.com>
References: <20250306141419.2015340-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

qemu_loadvm_load_state_buffer() and its load_state_buffer
SaveVMHandler allow providing device state buffer to explicitly
specified device via its idstr and instance id.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Link: https://lore.kernel.org/qemu-devel/71ca753286b87831ced4afd422e2e2bed071af25.1741124640.git.maciej.szmigiero@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/migration/register.h | 15 +++++++++++++++
 migration/savevm.h           |  3 +++
 migration/savevm.c           | 23 +++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/include/migration/register.h b/include/migration/register.h
index ff0faf5f68c8e9ac0fd1144ad91b3fab731d8a2f..58891aa54b76cccdea9e442be9bf528a41593e26 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -229,6 +229,21 @@ typedef struct SaveVMHandlers {
      */
     int (*load_state)(QEMUFile *f, void *opaque, int version_id);
 
+    /**
+     * @load_state_buffer (invoked outside the BQL)
+     *
+     * Load device state buffer provided to qemu_loadvm_load_state_buffer().
+     *
+     * @opaque: data pointer passed to register_savevm_live()
+     * @buf: the data buffer to load
+     * @len: the data length in buffer
+     * @errp: pointer to Error*, to store an error if it happens.
+     *
+     * Returns true to indicate success and false for errors.
+     */
+    bool (*load_state_buffer)(void *opaque, char *buf, size_t len,
+                              Error **errp);
+
     /**
      * @load_setup
      *
diff --git a/migration/savevm.h b/migration/savevm.h
index 58f871a7ed9ce8498a16f76ab66b08ef665aee73..cb58434a9437f7f9752ae7ae02981e9927d4ce85 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -71,4 +71,7 @@ int qemu_loadvm_approve_switchover(void);
 int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
         bool in_postcopy);
 
+bool qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
+                                   char *buf, size_t len, Error **errp);
+
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index faebf47ef51f2c5e6c49df831e1efe585c1a38a9..7c1aa8ad7b9d5c1460467c36e9923ed13768fbad 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3060,6 +3060,29 @@ int qemu_loadvm_approve_switchover(void)
     return migrate_send_rp_switchover_ack(mis);
 }
 
+bool qemu_loadvm_load_state_buffer(const char *idstr, uint32_t instance_id,
+                                   char *buf, size_t len, Error **errp)
+{
+    SaveStateEntry *se;
+
+    se = find_se(idstr, instance_id);
+    if (!se) {
+        error_setg(errp,
+                   "Unknown idstr %s or instance id %u for load state buffer",
+                   idstr, instance_id);
+        return false;
+    }
+
+    if (!se->ops || !se->ops->load_state_buffer) {
+        error_setg(errp,
+                   "idstr %s / instance %u has no load state buffer operation",
+                   idstr, instance_id);
+        return false;
+    }
+
+    return se->ops->load_state_buffer(se->opaque, buf, len, errp);
+}
+
 bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
                   bool has_devices, strList *devices, Error **errp)
 {
-- 
2.48.1


