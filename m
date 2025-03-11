Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D77C35FF1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 17:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts3PP-00018F-2y; Tue, 11 Mar 2025 13:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1ts3PK-00017q-3e
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:28:46 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1ts3PD-0004yI-Ju
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:28:45 -0400
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-bEdK5f4MOtSWO9kxrdd2aw-1; Tue,
 11 Mar 2025 13:28:34 -0400
X-MC-Unique: bEdK5f4MOtSWO9kxrdd2aw-1
X-Mimecast-MFC-AGG-ID: bEdK5f4MOtSWO9kxrdd2aw_1741714113
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D036A1956053; Tue, 11 Mar 2025 17:28:33 +0000 (UTC)
Received: from bahia.redhat.com (unknown [10.44.32.85])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A6D6F1955BCB; Tue, 11 Mar 2025 17:28:30 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v2 6/6] tests/9p: Test `Tsetattr` can truncate unlinked file
Date: Tue, 11 Mar 2025 18:28:09 +0100
Message-ID: <20250311172809.250913-7-groug@kaod.org>
In-Reply-To: <20250311172809.250913-1-groug@kaod.org>
References: <20250311172809.250913-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: softfail client-ip=207.211.30.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

Enhance the `use-after-unlink` test with a new check for the
case where the client wants to alter the size of an unlinked
file for which it still has an active fid.

Suggested-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/qtest/virtio-9p-test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index f515a9bb157b..20c0d744fa56 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -736,6 +736,14 @@ static void fs_use_after_unlink(void *obj, void *data,
         .data = buf
     }).count;
     g_assert_cmpint(count, ==, write_count);
+
+    /* truncate file to (arbitrarily chosen) size 2001 */
+    tsetattr({
+        .client = v9p, .fid = fid_file, .attr = (v9fs_attr) {
+            .valid = P9_SETATTR_SIZE,
+            .size = 2001
+        }
+     });
 }
 
 static void cleanup_9p_local_driver(void *data)
-- 
2.48.1


