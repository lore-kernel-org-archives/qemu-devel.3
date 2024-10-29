Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8472D3A66B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nqj-0006WJ-Oy; Tue, 29 Oct 2024 11:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t5nqi-0006Vr-Uf
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:09:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1t5nqf-0007K3-Es
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730214572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EawrAMiqZPHCdfZ9f5osnaUKjQDNMwjBz2dwMHPU2NM=;
 b=RwzE2gh55IAmilFoiSQiDPtthMRMTbw3w6Kej3+5OUUw6gpgITXl49eNe00KqVssw66cGu
 0foiVu7wCXrr5so18nx0RO8icU7nBoiWTYt5NwCGLJ3Ru2uN9A31cJb9ozRGaS2UqZug/b
 GJWuufp+GzV+SsSX4MaRUH2mRs0u8jo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-Sf4MOfgjPmKRKAhmnb6HKQ-1; Tue,
 29 Oct 2024 11:09:29 -0400
X-MC-Unique: Sf4MOfgjPmKRKAhmnb6HKQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2228F195609D; Tue, 29 Oct 2024 15:09:28 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.74.16.130])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B9EF51956086; Tue, 29 Oct 2024 15:09:23 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH 2/5] migration/postcopy: magic value for postcopy channel
Date: Tue, 29 Oct 2024 20:39:05 +0530
Message-ID: <20241029150908.1136894-3-ppandit@redhat.com>
In-Reply-To: <20241029150908.1136894-1-ppandit@redhat.com>
References: <20241029150908.1136894-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Prasad Pandit <pjp@fedoraproject.org>

During migration, the precopy and the multifd channels
send magic value (4-bytes) to the destination side,
for it to identify the channel and properly establish
connection. But Postcopy channel did not send such value.

Introduce a magic value to be sent on the postcopy channel.
It helps to identify channels when both multifd and postcopy
migration are enabled together. An explicitly defined magic
value makes code easier to follow, because it is consistent
with the other channels.

Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 migration/postcopy-ram.c | 7 +++++++
 migration/postcopy-ram.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 83f6160a36..5bc19b541c 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1580,6 +1580,9 @@ void postcopy_unregister_shared_ufd(struct PostCopyFD *pcfd)
 
 void postcopy_preempt_new_channel(MigrationIncomingState *mis, QEMUFile *file)
 {
+    if (mis->postcopy_qemufile_dst) {
+        return;
+    }
     /*
      * The new loading channel has its own threads, so it needs to be
      * blocked too.  It's by default true, just be explicit.
@@ -1612,6 +1615,10 @@ postcopy_preempt_send_channel_done(MigrationState *s,
      * postcopy_qemufile_src to know whether it failed or not.
      */
     qemu_sem_post(&s->postcopy_qemufile_src_sem);
+
+    /* Send magic value to identify postcopy channel on the destination */
+    uint32_t magic = cpu_to_be32(POSTCOPY_MAGIC);
+    qio_channel_write_all(ioc, (char *)&magic, sizeof(magic), NULL);
 }
 
 static void
diff --git a/migration/postcopy-ram.h b/migration/postcopy-ram.h
index a6df1b2811..49e2982558 100644
--- a/migration/postcopy-ram.h
+++ b/migration/postcopy-ram.h
@@ -15,6 +15,9 @@
 
 #include "qapi/qapi-types-migration.h"
 
+/* Magic value to identify postcopy channel on the destination */
+#define POSTCOPY_MAGIC  0x55667788U
+
 /* Return true if the host supports everything we need to do postcopy-ram */
 bool postcopy_ram_supported_by_host(MigrationIncomingState *mis,
                                     Error **errp);
-- 
2.47.0


