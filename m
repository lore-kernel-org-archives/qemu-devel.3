Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F148AF3D330
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBkn-0006Iu-8w; Thu, 05 Mar 2026 11:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vyBkQ-0006BC-Uy
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:40:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vyBkH-0000mk-Jz
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772728813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ylVizt4FBS0JlnoU8wY+GABg+TfM6MLReoF0ERt1lB4=;
 b=bMF/MB/uWmSN5wzSxJPalZqXuqFJL4GXZqlZuAb0SY+sSJsiqAFvjGUsGqALmiu9WQSEKX
 HJvkYG7KCzl9gaKuWQ8dBlLRwdkS+oUGL6aK29ACTM1E0AIJTNzY0SxYcunfRvaytnlLi7
 GpyzAsW/m8pi6YSeXCTX0kJ83RZsbOU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-Z1WtApBrNYCrp1ygk4mE4Q-1; Thu,
 05 Mar 2026 11:40:11 -0500
X-MC-Unique: Z1WtApBrNYCrp1ygk4mE4Q-1
X-Mimecast-MFC-AGG-ID: Z1WtApBrNYCrp1ygk4mE4Q_1772728809
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3040A1955F29; Thu,  5 Mar 2026 16:40:09 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.34.122])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0846D1958DC5; Thu,  5 Mar 2026 16:40:05 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Maxime Coquelin <mcoqueli@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Koushik Dutta <kdutta@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [RFC PATCH 7/8] tests: vhost-vdpa: introduce TestParameters struct
Date: Thu,  5 Mar 2026 17:39:37 +0100
Message-ID: <20260305163938.3200787-8-eperezma@redhat.com>
In-Reply-To: <20260305163938.3200787-1-eperezma@redhat.com>
References: <20260305163938.3200787-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Encapsulate test configuration (VduseOps, features) in TestParameters
struct to prepare for parameterized tests with different device feature
flags.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 tests/qtest/vhost-vdpa-test.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/vhost-vdpa-test.c b/tests/qtest/vhost-vdpa-test.c
index 5efe688673cb..0192b00748d5 100644
--- a/tests/qtest/vhost-vdpa-test.c
+++ b/tests/qtest/vhost-vdpa-test.c
@@ -42,6 +42,10 @@
 
 static int NUM_RX_BUFS = 2;
 
+typedef struct TestParameters {
+    const VduseOps *ops;
+} TestParameters;
+
 typedef struct VdpaThread {
     GThread *thread;
     GMainLoop *loop;
@@ -264,6 +268,10 @@ static const VduseOps vduse_read_guest_mem_ops = {
     .disable_queue = vduse_read_guest_mem_disable_queue,
 };
 
+static const TestParameters mem_read_params = {
+    .ops = &vduse_read_guest_mem_ops,
+};
+
 static gboolean vhost_vdpa_rxtx_handle_tx(int fd, GIOCondition condition,
                                           void *data)
 {
@@ -318,6 +326,10 @@ static const VduseOps vduse_rxtx_ops = {
     .disable_queue = vduse_rxtx_disable_queue,
 };
 
+static const TestParameters rxtx_params = {
+    .ops = &vduse_rxtx_ops,
+};
+
 static gboolean vduse_dev_handler_source_fd(int fd, GIOCondition condition,
                                             void *data)
 {
@@ -432,7 +444,8 @@ static bool test_setup_reconnect_log(VduseDev *vdev, const char *tmpfs)
     return ok;
 }
 
-static TestServer *test_server_new(const gchar *name, const VduseOps *ops)
+static TestServer *test_server_new(const gchar *name,
+                                   const TestParameters *params)
 {
     TestServer *server = g_new0(TestServer, 1);
     g_autoptr(GError) err = NULL;
@@ -458,7 +471,7 @@ static TestServer *test_server_new(const gchar *name, const VduseOps *ops)
                                     2, /* num_queues */
                                     sizeof(config),
                                     config,
-                                    ops,
+                                    params->ops,
                                     server);
 
     if (!server->vdev) {
@@ -614,14 +627,14 @@ static void register_vhost_vdpa_test(void)
     QOSGraphTestOptions opts = {
         .before = vhost_vdpa_test_setup,
         .subprocess = true,
-        .arg = (void *)&vduse_read_guest_mem_ops,
+        .arg = (void *)&mem_read_params,
     };
 
     qos_add_test("vhost-vdpa/read-guest-mem/memfile",
                  "virtio-net",
                  test_wait, &opts);
 
-    opts.arg = (void *)&vduse_rxtx_ops;
+    opts.arg = (void *)&rxtx_params;
     qos_add_test("vhost-vdpa/rxtx",
                  "virtio-net",
                  vhost_vdpa_tx_test, &opts);
-- 
2.53.0


