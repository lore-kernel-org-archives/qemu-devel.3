Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF83BCCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 21:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEaX8-0006vS-Ov; Thu, 30 Oct 2025 17:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vEaX4-0006vF-Ky
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 17:50:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1vEaWt-0000gR-Ou
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 17:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761860990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y6wqd5lciJsAo9IQM8zPf6C+QCoE2/o8d67nBJyAwDY=;
 b=jMNge5ZZvrMDu+fqJX5BxABsm7mwuVFLk7ue82E8gNycZ18WM+DRoC/Wr023+8bO2hD5bc
 Uw7KFiwW8SfVCua72qUKo4vxSwn9YXjW/FW/iZv8ayYDvMFJPqeOY5nuPGwpArj4Ij58Yz
 JUH09VT+v5rQUBOn03YO7c/Ip45otVA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-x27j4jd0O9ahP7qU_g8lRQ-1; Thu,
 30 Oct 2025 17:49:47 -0400
X-MC-Unique: x27j4jd0O9ahP7qU_g8lRQ-1
X-Mimecast-MFC-AGG-ID: x27j4jd0O9ahP7qU_g8lRQ_1761860986
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0F7A1955F3B; Thu, 30 Oct 2025 21:49:46 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.58])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C0CA71800586; Thu, 30 Oct 2025 21:49:44 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jiri Denemark <jdenemar@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 6/7] migration: Make postcopy listen thread joinable
Date: Thu, 30 Oct 2025 22:49:10 +0100
Message-ID: <20251030214915.1411860-7-jmarcin@redhat.com>
In-Reply-To: <20251030214915.1411860-1-jmarcin@redhat.com>
References: <20251030214915.1411860-1-jmarcin@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Juraj Marcin <jmarcin@redhat.com>

This patch makes the listen thread joinable instead detached, and joins
it alongside other postcopy threads.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
---
 migration/postcopy-ram.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 91431f02a4..8405cce7b4 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -2181,7 +2181,6 @@ static void *postcopy_listen_thread(void *opaque)
 
 out:
     rcu_unregister_thread();
-    mis->have_listen_thread = false;
     postcopy_state_set(POSTCOPY_INCOMING_END);
 
     migration_bh_schedule(postcopy_listen_thread_bh, NULL);
@@ -2215,7 +2214,7 @@ int postcopy_incoming_setup(MigrationIncomingState *mis, Error **errp)
     mis->have_listen_thread = true;
     postcopy_thread_create(mis, &mis->listen_thread,
                            MIGRATION_THREAD_DST_LISTEN,
-                           postcopy_listen_thread, QEMU_THREAD_DETACHED);
+                           postcopy_listen_thread, QEMU_THREAD_JOINABLE);
 
     return 0;
 }
@@ -2224,6 +2223,11 @@ int postcopy_incoming_cleanup(MigrationIncomingState *mis)
 {
     int rc = 0;
 
+    if (mis->have_listen_thread) {
+        qemu_thread_join(&mis->listen_thread);
+        mis->have_listen_thread = false;
+    }
+
     if (migrate_postcopy_ram()) {
         rc = postcopy_ram_incoming_cleanup(mis);
     }
-- 
2.51.0


