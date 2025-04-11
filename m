Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8848BC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 11:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Cpr-0007EG-Cv; Fri, 11 Apr 2025 07:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u3Cph-0007CR-EY
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 07:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u3Cpf-0001TL-5G
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 07:46:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744371962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SAgMwFknXKkkfdtdEIfRgOdkdzIxxxxTKSn68zcvnFA=;
 b=OKxQi287sQLAqptJmqqV9hAoPqaH+NIgnEu+RPbk76vNBs8z47ggSVxb8VfD7Z/xSl0Oyo
 6ULE/3cObGQtNUNi2Bk09nll71F5ebUJg6xKV0XuOW3VN80DgZ/Jd1Sdh3Xf4vL6AtbOz+
 kLdchY5Cq1JptYds4wbwlyMzyPmPR8I=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-dwSljb3aODKwI0_loUsIBg-1; Fri,
 11 Apr 2025 07:45:58 -0400
X-MC-Unique: dwSljb3aODKwI0_loUsIBg-1
X-Mimecast-MFC-AGG-ID: dwSljb3aODKwI0_loUsIBg_1744371958
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0A201955DC5; Fri, 11 Apr 2025 11:45:57 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.160])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0656B1801A69; Fri, 11 Apr 2025 11:45:54 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: farosas@suse.de,
	peterx@redhat.com,
	berrange@redhat.com
Subject: [PATCH v9 3/7] migration: Add save_postcopy_prepare() savevm handler
Date: Fri, 11 Apr 2025 17:15:30 +0530
Message-ID: <20250411114534.3370816-4-ppandit@redhat.com>
In-Reply-To: <20250411114534.3370816-1-ppandit@redhat.com>
References: <20250411114534.3370816-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Peter Xu <peterx@redhat.com>

Add a savevm handler for a module to opt-in sending extra sections right
before postcopy starts, and before VM is stopped.

RAM will start to use this new savevm handler in the next patch to do flush
and sync for multifd pages.

Note that we choose to do it before VM stopped because the current only
potential user is not sensitive to VM status, so doing it before VM is
stopped is preferred to enlarge any postcopy downtime.

It is still a bit unfortunate that we need to introduce such a new savevm
handler just for the only use case, however it's so far the cleanest.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 include/migration/register.h | 15 +++++++++++++++
 migration/migration.c        |  4 ++++
 migration/savevm.c           | 33 +++++++++++++++++++++++++++++++++
 migration/savevm.h           |  1 +
 4 files changed, 53 insertions(+)

v8: reorder this patch before enabling multifd and postcopy together
- https://lore.kernel.org/qemu-devel/20250318123846.1370312-1-ppandit@redhat.com/T/#t

diff --git a/include/migration/register.h b/include/migration/register.h
index c041ce32f2..b79dc81b8d 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -189,6 +189,21 @@ typedef struct SaveVMHandlers {
 
     /* This runs outside the BQL!  */
 
+    /**
+     * @save_postcopy_prepare
+     *
+     * This hook will be invoked on the source side right before switching
+     * to postcopy (before VM stopped).
+     *
+     * @f:      QEMUFile where to send the data
+     * @opaque: Data pointer passed to register_savevm_live()
+     * @errp:   Error** used to report error message
+     *
+     * Returns: true if succeeded, false if error occured.  When false is
+     * returned, @errp must be set.
+     */
+    bool (*save_postcopy_prepare)(QEMUFile *f, void *opaque, Error **errp);
+
     /**
      * @state_pending_estimate
      *
diff --git a/migration/migration.c b/migration/migration.c
index 64f4f40ae3..4bb29b7193 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2717,6 +2717,10 @@ static int postcopy_start(MigrationState *ms, Error **errp)
         }
     }
 
+    if (!qemu_savevm_state_postcopy_prepare(ms->to_dst_file, errp)) {
+        return -1;
+    }
+
     trace_postcopy_start();
     bql_lock();
     trace_postcopy_start_set_run();
diff --git a/migration/savevm.c b/migration/savevm.c
index ce158c3512..23ef4c7dc9 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1523,6 +1523,39 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
     qemu_fflush(f);
 }
 
+bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp)
+{
+    SaveStateEntry *se;
+    bool ret;
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (!se->ops || !se->ops->save_postcopy_prepare) {
+            continue;
+        }
+
+        if (se->ops->is_active) {
+            if (!se->ops->is_active(se->opaque)) {
+                continue;
+            }
+        }
+
+        trace_savevm_section_start(se->idstr, se->section_id);
+
+        save_section_header(f, se, QEMU_VM_SECTION_PART);
+        ret = se->ops->save_postcopy_prepare(f, se->opaque, errp);
+        save_section_footer(f, se);
+
+        trace_savevm_section_end(se->idstr, se->section_id, ret);
+
+        if (!ret) {
+            assert(*errp);
+            return false;
+        }
+    }
+
+    return true;
+}
+
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
 {
     int64_t start_ts_each, end_ts_each;
diff --git a/migration/savevm.h b/migration/savevm.h
index 138c39a7f9..2d5e9c7166 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -45,6 +45,7 @@ void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
 void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
                                         uint64_t *can_postcopy);
 int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy);
+bool qemu_savevm_state_postcopy_prepare(QEMUFile *f, Error **errp);
 void qemu_savevm_send_ping(QEMUFile *f, uint32_t value);
 void qemu_savevm_send_open_return_path(QEMUFile *f);
 int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len);
-- 
2.49.0


