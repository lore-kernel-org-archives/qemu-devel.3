Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74B1C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 12:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWEZ-0003Cz-HJ; Tue, 18 Mar 2025 08:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tuWEN-0002gG-Hu
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 08:39:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tuWEJ-0007gm-LF
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 08:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742301574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=06iM+9P55Mj7StAkwOGZYdkiRCeTKmpFEP5kkBTrn2A=;
 b=Z5vwlpNeeVa7xxnFPsmR/gvU3huLAjjK3eTBxpTJtqZvNMS1tc4UnFlpofSZcumgzNyqF0
 WYqrSRNMIVGrzY5XO0ZBzsSYjf3//6oKx4+34uPi+XNakShhVxxk6S/DSKM2UjvamP3nSk
 gmqMOgInk/PiIGn7Iyyy0m/e/1zSwrM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-LcobzCDHNPClf9YLS81t8A-1; Tue,
 18 Mar 2025 08:39:31 -0400
X-MC-Unique: LcobzCDHNPClf9YLS81t8A-1
X-Mimecast-MFC-AGG-ID: LcobzCDHNPClf9YLS81t8A_1742301570
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82F621801A07; Tue, 18 Mar 2025 12:39:30 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.234])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82A481800946; Tue, 18 Mar 2025 12:39:27 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	farosas@suse.de,
	berrange@redhat.com
Subject: [PATCH v8 7/7] migration/ram: Implement save_postcopy_prepare()
Date: Tue, 18 Mar 2025 18:08:46 +0530
Message-ID: <20250318123846.1370312-8-ppandit@redhat.com>
In-Reply-To: <20250318123846.1370312-1-ppandit@redhat.com>
References: <20250318123846.1370312-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Peter Xu <peterx@redhat.com>

Implement save_postcopy_prepare(), preparing for the enablement of both
multifd and postcopy.

Please see the rich comment for the rationals.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 migration/ram.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

v8:
- New patch

v7:
- https://lore.kernel.org/qemu-devel/20250228121749.553184-1-ppandit@redhat.com/T/#t

diff --git a/migration/ram.c b/migration/ram.c
index 6fd88cbf2a..04fde7ba6b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4419,6 +4419,42 @@ static int ram_resume_prepare(MigrationState *s, void *opaque)
     return 0;
 }
 
+static bool ram_save_postcopy_prepare(QEMUFile *f, void *opaque, Error **errp)
+{
+    int ret;
+
+    if (migrate_multifd()) {
+        /*
+         * When multifd is enabled, source QEMU needs to make sure all the
+         * pages queued before postcopy starts to be flushed.
+         *
+         * Meanwhile, the load of these pages must happen before switching
+         * to postcopy.  It's because loading of guest pages (so far) in
+         * multifd recv threads is still non-atomic, so the load cannot
+         * happen with vCPUs running on destination side.
+         *
+         * This flush and sync will guarantee those pages loaded _before_
+         * postcopy starts on destination. The rational is, this happens
+         * before VM stops (and before source QEMU sends all the rest of
+         * the postcopy messages).  So when the destination QEMU received
+         * the postcopy messages, it must have received the sync message on
+         * the main channel (either RAM_SAVE_FLAG_MULTIFD_FLUSH, or
+         * RAM_SAVE_FLAG_EOS), and such message should have guaranteed all
+         * previous guest pages queued in the multifd channels to be
+         * completely loaded.
+         */
+        ret = multifd_ram_flush_and_sync(f);
+        if (ret < 0) {
+            error_setg(errp, "%s: multifd flush and sync failed", __func__);
+            return false;
+        }
+    }
+
+    qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
+
+    return true;
+}
+
 void postcopy_preempt_shutdown_file(MigrationState *s)
 {
     qemu_put_be64(s->postcopy_qemufile_src, RAM_SAVE_FLAG_EOS);
@@ -4438,6 +4474,7 @@ static SaveVMHandlers savevm_ram_handlers = {
     .load_setup = ram_load_setup,
     .load_cleanup = ram_load_cleanup,
     .resume_prepare = ram_resume_prepare,
+    .save_postcopy_prepare = ram_save_postcopy_prepare,
 };
 
 static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
-- 
2.48.1


