Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1596CFD315
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 07:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNn7s-0003U6-FV; Tue, 25 Nov 2025 02:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vNn7p-0003Q6-UJ
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 02:06:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vNn7j-0001SZ-Ov
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 02:06:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764054362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=DZK9oZtk3DC2XEVelKmzlvWizat0Ja1Mp1qEHVxErHg=;
 b=Sy2Dpx6srB+T5wpF2cGsoRoQu8g9tQXb0Gu1ls7z+IJ1Dieio+UixmX955rbtUEu7q3Nh7
 y/aWKBxAWnFGpjoLvaVNzgAJs7bfrL4qqt3RY57H7S1xLgPTue8OPhBkSueXcLUsVx/ZyJ
 IvrjUvuWcqH9LOpy6CEnhZCctnu4MOU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-swTkVXClMWev4xB_Iyv3yQ-1; Tue,
 25 Nov 2025 02:05:58 -0500
X-MC-Unique: swTkVXClMWev4xB_Iyv3yQ-1
X-Mimecast-MFC-AGG-ID: swTkVXClMWev4xB_Iyv3yQ_1764054357
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DDD6180034A; Tue, 25 Nov 2025 07:05:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D5ACB18004D8; Tue, 25 Nov 2025 07:05:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 77BC521E6A27; Tue, 25 Nov 2025 08:05:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de,
	peter.maydell@linaro.org
Subject: [PATCH] migration: Fix double-free on error path
Date: Tue, 25 Nov 2025 08:05:54 +0100
Message-ID: <20251125070554.2256181-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fixes: ffaa1b50a879 (migration: Use warn_reportf_err() where appropriate)
Resolves: Coverity CID 1643463
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 migration/multifd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 6210454838..3203dc98e1 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -450,7 +450,7 @@ static void multifd_send_set_error(Error *err)
  */
 static void migration_ioc_shutdown_gracefully(QIOChannel *ioc)
 {
-    g_autoptr(Error) local_err = NULL;
+    Error *local_err = NULL;
 
     if (!migration_has_failed(migrate_get_current()) &&
         object_dynamic_cast((Object *)ioc, TYPE_QIO_CHANNEL_TLS)) {
-- 
2.49.0


