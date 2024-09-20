Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B238CF9C59
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 16:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srgGP-0000VM-MW; Fri, 20 Sep 2024 12:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1srgGO-0000UX-5t
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 12:13:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1srgGM-0004JE-Lb
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 12:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726848821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+m6SzrDF1hmgV4N+sFo2uBKimrLhERLYwJRC4a2PXOA=;
 b=h9FEmeU3C5nUK8MoxJ9OgTHDbE8Q6qpd9EyQ10BpFKBCK1Y3dTxL1k2uDsLGFVj+EjdQRd
 KjtDEcIsB/FntUqirQEVjWeoOloM9D8vNlQ23r/ix3IJ5M5OyUwN5GXBv/0BeJITL1Wx0G
 CDVaF+gfiTMkwIAq3q5dCdtgffQCRTY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-0Bbwv3JgOYy4WPeci_TMoA-1; Fri,
 20 Sep 2024 12:13:38 -0400
X-MC-Unique: 0Bbwv3JgOYy4WPeci_TMoA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B569C1933189
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2024 16:13:37 +0000 (UTC)
Received: from rh-jmarcin.brq.redhat.com (unknown [10.43.2.64])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5B1DF30001A1; Fri, 20 Sep 2024 16:13:36 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH] tests/migration-test: Wait for cancellation sooner in multifd
 cancel
Date: Fri, 20 Sep 2024 18:13:02 +0200
Message-ID: <20240920161319.2337625-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The source QEMU might not finish the cancellation of the migration
before we start setting up the next attempt. During the setup, the
test_migrate_start() function and others might need to interact with the
source in a way that is not possible unless the migration is fully
canceled. For example, setting capabilities when the migration is still
running leads to an error.

By moving the wait before the setup, we ensure this does not happen.

Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 tests/qtest/migration-test.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 814ec109a6..95e45b5029 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -3267,6 +3267,16 @@ static void test_multifd_tcp_cancel(void)
     qtest_wait_qemu(to);
     qtest_quit(to);
 
+    /*
+     * Ensure the source QEMU finishes its cancellation process before we
+     * proceed with the setup of the next migration. The test_migrate_start()
+     * function and others might want to interact with the source in a way that
+     * is not possible while the migration is not canceled properly. For
+     * example, setting migration capabilities when the migration is still
+     * running leads to an error.
+     */
+    wait_for_migration_status(from, "cancelled", NULL);
+
     args = (MigrateStart){
         .only_target = true,
     };
@@ -3282,8 +3292,6 @@ static void test_multifd_tcp_cancel(void)
     /* Start incoming migration from the 1st socket */
     migrate_incoming_qmp(to2, "tcp:127.0.0.1:0", "{}");
 
-    wait_for_migration_status(from, "cancelled", NULL);
-
     migrate_ensure_non_converge(from);
 
     migrate_qmp(from, to2, NULL, NULL, "{}");
-- 
2.46.1


