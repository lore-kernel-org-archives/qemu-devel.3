Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8F0F3D32A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:41:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBk4-00067Y-Gt; Thu, 05 Mar 2026 11:40:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vyBjz-00062M-F7
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:39:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vyBjt-0000YQ-P9
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772728793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xKblfboIEcoo6KaZTrWP7K6ZzZXW+hRgTkfdNeolCmA=;
 b=T25WGJ2CazBXTCPpUvv88UDY7KB9h8kqIrp4gKpA+1Oid59QlYb4Bz+Zs6WYkUIglYPcfP
 0p6YjEpiFM7lMbyrh0CQOHK+B16ZqLlsbjRmFOE2gAtr9ZI7zn1woX2tVC4SD7PEv1gj7R
 YB00DnlL7lB4KzD1cFP8zHOX9Il3N1M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-DSR_7XXAOaSRZkACBW2E2Q-1; Thu,
 05 Mar 2026 11:39:51 -0500
X-MC-Unique: DSR_7XXAOaSRZkACBW2E2Q-1
X-Mimecast-MFC-AGG-ID: DSR_7XXAOaSRZkACBW2E2Q_1772728790
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A10831956052; Thu,  5 Mar 2026 16:39:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.122])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7AB5B1958DC5; Thu,  5 Mar 2026 16:39:47 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Koushik Dutta <kdutta@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [RFC PATCH 2/8] tests: vhost-vdpa: parameterize VDUSE operations
Date: Thu,  5 Mar 2026 17:39:32 +0100
Message-ID: <20260305163938.3200787-3-eperezma@redhat.com>
In-Reply-To: <20260305163938.3200787-1-eperezma@redhat.com>
References: <20260305163938.3200787-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Make the VduseOps callbacks a parameter to test_server_new() instead
of hardcoding vduse_read_guest_mem_ops.

This allows different test cases to provide custom queue enable/disable
handlers for testing various vhost-vdpa scenarios.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 tests/qtest/vhost-vdpa-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/vhost-vdpa-test.c b/tests/qtest/vhost-vdpa-test.c
index 1fc5acacfed3..1c7d8540bd19 100644
--- a/tests/qtest/vhost-vdpa-test.c
+++ b/tests/qtest/vhost-vdpa-test.c
@@ -277,7 +277,7 @@ static bool test_setup_reconnect_log(VduseDev *vdev, const char *tmpfs)
     return ok;
 }
 
-static TestServer *test_server_new(const gchar *name)
+static TestServer *test_server_new(const gchar *name, const VduseOps *ops)
 {
     TestServer *server = g_new0(TestServer, 1);
     g_autoptr(GError) err = NULL;
@@ -302,7 +302,7 @@ static TestServer *test_server_new(const gchar *name)
                                     2, /* num_queues */
                                     sizeof(config),
                                     config,
-                                    &vduse_read_guest_mem_ops,
+                                    ops,
                                     server);
 
     if (!server->vdev) {
@@ -387,7 +387,7 @@ static void vhost_vdpa_test_cleanup(void *s)
 
 static void *vhost_vdpa_test_setup_memfile(GString *cmd_line, void *arg)
 {
-    TestServer *server = test_server_new("vdpa-memfile");
+    TestServer *server = test_server_new("vdpa-memfile", &vduse_read_guest_mem_ops);
 
     if (!server->ready) {
         g_test_skip("Failed to create VDUSE device");
-- 
2.53.0


