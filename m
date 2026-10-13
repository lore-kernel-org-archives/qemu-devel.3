Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72282CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:19:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGh4i-0006vW-Je; Tue, 13 Oct 2026 14:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xGh4g-0006uv-FD
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 14:18:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xGh4f-00013t-58
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 14:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791915484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w6BtoRW+1MiLxfbSmGQadwo7l0abOPtZZ54uJBQ5yBg=;
 b=TUHD+bJPXVG+nSwaVev3TaAxCqK6nnOPVCIep5Hfs6L0S8e6rE2jQKcMs2Ny8YZu9V9y4d
 itBnnAfZHYoiDrFgdAQlbh3CxD5lJtyM3Ti+X6HMAtMLjtol2nXtD3bTePnumyV75pE0tk
 glm1Ad8/k1cfr5tKzwf5jEpnmvLDlkE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-lICvaFhtOqWH9Min4AZBNw-1; Tue,
 13 Oct 2026 18:18:00 +0000
X-MC-Unique: lICvaFhtOqWH9Min4AZBNw-1
X-Mimecast-MFC-AGG-ID: lICvaFhtOqWH9Min4AZBNw_1791915480
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D72F41944B15; Tue, 13 Oct 2026 18:17:59 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 51532195608E; Tue, 13 Oct 2026 18:17:59 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 akalenyu@redhat.com, Kevin Wolf <kwolf@redhat.com>, eblake@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 <qemu-block@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 3/8] hw/scsi-disk: move MIG_EVENT_FAILED into a new function
Date: Tue, 13 Oct 2026 14:17:47 -0400
Message-ID: <20261013181752.1299456-4-stefanha@redhat.com>
In-Reply-To: <20261013181752.1299456-1-stefanha@redhat.com>
References: <20261013181752.1299456-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


