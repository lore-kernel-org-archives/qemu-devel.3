Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F04ABCA601D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 15:33:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFCa4-0001b9-Qi; Fri, 09 Oct 2026 11:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xFCZ2-0001S9-7k
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 11:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xFCZ0-000801-FN
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 11:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791559873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w6BtoRW+1MiLxfbSmGQadwo7l0abOPtZZ54uJBQ5yBg=;
 b=aPdKLFGxVC+R8JFqDepb5s3VEANnKD8SNW4kEMvdqhQIszECZTdflLO99PjLgun5Yapr6t
 KDJ+dgnVGoyUT4f24UJBZGYK+iD97Rx4Vtxy+eFOI7+M6H+6wcHd+4V55yEfmho7R7/rW/
 YwjY8Qb8PVb7mLkBsOMutTrsVYXsCmU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631--NCRT7p9OVidYdeSDbyIaw-1; Fri,
 9 Oct 2026 15:31:06 +0000
X-MC-Unique: -NCRT7p9OVidYdeSDbyIaw-1
X-Mimecast-MFC-AGG-ID: -NCRT7p9OVidYdeSDbyIaw_1791559865
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 458941800C3C; Fri,  9 Oct 2026 15:31:05 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F28E118004D2; Fri,  9 Oct 2026 15:31:04 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: akalenyu@redhat.com, <qemu-block@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 3/8] hw/scsi-disk: move MIG_EVENT_FAILED into a new function
Date: Fri,  9 Oct 2026 11:30:53 -0400
Message-ID: <20261009153058.1089786-4-stefanha@redhat.com>
In-Reply-To: <20261009153058.1089786-1-stefanha@redhat.com>
References: <20261009153058.1089786-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Move the MIG_EVENT_FAILED logic from scsi_block_migration_notifier()
into its own new scsi_block_migration_failed() function. The next commit
adds logic for handling another event, so doing that in dedicated
functions makes the code easier to read.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/scsi-disk.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index deb33ac1dda..3d88e57eded 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2761,20 +2761,26 @@ static SCSIRequest *scsi_new_request(SCSIDevice *d, uint32_t tag, uint32_t lun,
  * fails because the destination may have already preempted and we need to get
  * the reservation back.
  */
+static void scsi_block_migration_failed(SCSIDiskState *s)
+{
+    SCSIDevice *d = &s->qdev;
+    Error *local_err = NULL;
+
+    if (!scsi_generic_pr_state_preempt(d, &local_err)) {
+        /* MIG_EVENT_FAILED cannot fail, so just warn */
+        error_prepend(&local_err, "scsi-block migration rollback: ");
+        warn_report_err(local_err);
+    }
+}
+
 static int scsi_block_migration_notifier(NotifierWithReturn *notifier,
                                          MigrationEvent *e, Error **errp)
 {
-    if (e->type == MIG_EVENT_FAILED) {
-        SCSIDiskState *s =
-            container_of(notifier, SCSIDiskState, migration_notifier);
-        SCSIDevice *d = &s->qdev;
-        Error *local_err = NULL;
+    SCSIDiskState *s =
+        container_of(notifier, SCSIDiskState, migration_notifier);
 
-        if (!scsi_generic_pr_state_preempt(d, &local_err)) {
-            /* MIG_EVENT_FAILED cannot fail, so just warn */
-            error_prepend(&local_err, "scsi-block migration rollback: ");
-            warn_report_err(local_err);
-        }
+    if (e->type == MIG_EVENT_FAILED) {
+        scsi_block_migration_failed(s);
     }
     return 0;
 }
-- 
2.56.0


