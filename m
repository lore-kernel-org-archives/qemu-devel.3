Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9000C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 10:34:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOapY-0004As-CT; Tue, 02 Jul 2024 06:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOapW-00048z-HC
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 06:33:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOapU-00076V-SZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 06:33:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719916424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UP5k2DL6LgqTBAh4YGOkkQj9J7KbuqTIoxbbpQ6g+zs=;
 b=Di25aOGtvNZSu6rtkHrd91eGNkJjNjnWl2POtmZbzkrYhF6U5vAP2UZfBnbnYMcMhX5Zhr
 ait3RYv0Mg40zaglpQglsJzs5RPA+55qmy7/bDkxqgnF28ui9HOu06NlM5WO7sDIZOuqsq
 JIx8By5TQUARGrB1Mf0rVvUni8SfMh8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-SEnZ4n55MgWMwbeCEaqjtg-1; Tue,
 02 Jul 2024 06:33:40 -0400
X-MC-Unique: SEnZ4n55MgWMwbeCEaqjtg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0EC4119560A2; Tue,  2 Jul 2024 10:33:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C23A219560AA; Tue,  2 Jul 2024 10:33:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 07/12] tests/qtest: Free GThread
Date: Tue,  2 Jul 2024 12:33:05 +0200
Message-ID: <20240702103310.347201-8-thuth@redhat.com>
In-Reply-To: <20240702103310.347201-1-thuth@redhat.com>
References: <20240702103310.347201-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

These GThreads are never referenced.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20240627-san-v2-15-750bb0946dbd@daynix.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/vhost-user-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
index d4e437265f..929af5c183 100644
--- a/tests/qtest/vhost-user-test.c
+++ b/tests/qtest/vhost-user-test.c
@@ -928,7 +928,7 @@ static void *vhost_user_test_setup_reconnect(GString *cmd_line, void *arg)
 {
     TestServer *s = test_server_new("reconnect", arg);
 
-    g_thread_new("connect", connect_thread, s);
+    g_thread_unref(g_thread_new("connect", connect_thread, s));
     append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
     s->vu_ops->append_opts(s, cmd_line, ",server=on");
 
@@ -965,7 +965,7 @@ static void *vhost_user_test_setup_connect_fail(GString *cmd_line, void *arg)
 
     s->test_fail = true;
 
-    g_thread_new("connect", connect_thread, s);
+    g_thread_unref(g_thread_new("connect", connect_thread, s));
     append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
     s->vu_ops->append_opts(s, cmd_line, ",server=on");
 
@@ -980,7 +980,7 @@ static void *vhost_user_test_setup_flags_mismatch(GString *cmd_line, void *arg)
 
     s->test_flags = TEST_FLAGS_DISCONNECT;
 
-    g_thread_new("connect", connect_thread, s);
+    g_thread_unref(g_thread_new("connect", connect_thread, s));
     append_mem_opts(s, cmd_line, 256, TEST_MEMFD_AUTO);
     s->vu_ops->append_opts(s, cmd_line, ",server=on");
 
-- 
2.45.2


