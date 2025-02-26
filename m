Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF229C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 08:50:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnD7e-0007yr-75; Wed, 26 Feb 2025 03:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnD7a-0007yO-On
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 03:50:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnD7Y-0006uo-VH
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 03:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740559823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=F0TO1H3g91BPAezbyCiVI8azAclSn1u4R4Ruyy5ytyY=;
 b=AepJo5ICSgyG8PCP4+0TLL3AeAZE/NiSryVyf9VC5RNU3zLKrrh3jzzGdIYpq2BbOrtOeJ
 kFI2HFoNhkbG37bKqxPTqP76Pv5GiPb6ar2twFeQ73CTclo4UC6pRTnUyhkW/fibwe41At
 8AdAw4DWsblRsmB1g3/6wN4fOG/iXTE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-EeoUV8lNP6GyasSaNMvZFg-1; Wed,
 26 Feb 2025 03:50:22 -0500
X-MC-Unique: EeoUV8lNP6GyasSaNMvZFg-1
X-Mimecast-MFC-AGG-ID: EeoUV8lNP6GyasSaNMvZFg_1740559821
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 597B419783B7; Wed, 26 Feb 2025 08:50:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.144])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6C20D1800357; Wed, 26 Feb 2025 08:50:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH] trace/simple: Fix hang when using simpletrace with fork()
Date: Wed, 26 Feb 2025 09:50:15 +0100
Message-ID: <20250226085015.1143991-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

When compiling QEMU with --enable-trace-backends=simple , the
iotest 233 is currently hanging. This happens because qemu-nbd
calls trace_init_backends() first - which causes simpletrace to
install its writer thread and the atexit() handler - before
calling fork(). But the simpletrace writer thread is then only
available in the parent process, not in the child process anymore.
Thus when the child process exits, its atexit handler waits forever
on the trace_empty_cond condition to be set by the non-existing
writer thread, so the process never finishes.

Fix it by installing a pthread_atfork() handler, too, which
makes sure that the trace_writeout_enabled variable gets set
to false again in the child process, so we can use it in the
atexit() handler to check whether we still need to wait on the
writer thread or not.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 trace/simple.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/trace/simple.c b/trace/simple.c
index c0aba00cb7f..269bbda69f1 100644
--- a/trace/simple.c
+++ b/trace/simple.c
@@ -380,8 +380,22 @@ void st_print_trace_file_status(void)
 
 void st_flush_trace_buffer(void)
 {
-    flush_trace_file(true);
+    flush_trace_file(trace_writeout_enabled);
+}
+
+#ifndef _WIN32
+static void trace_thread_atfork(void)
+{
+    /*
+     * If we fork, the writer thread does not exist in the child, so
+     * make sure to allow st_flush_trace_buffer() to clean up correctly.
+     */
+    g_mutex_lock(&trace_lock);
+    trace_writeout_enabled = false;
+    g_cond_signal(&trace_empty_cond);
+    g_mutex_unlock(&trace_lock);
 }
+#endif
 
 /* Helper function to create a thread with signals blocked.  Use glib's
  * portable threads since QEMU abstractions cannot be used due to reentrancy in
@@ -396,6 +410,7 @@ static GThread *trace_thread_create(GThreadFunc fn)
 
     sigfillset(&set);
     pthread_sigmask(SIG_SETMASK, &set, &oldset);
+    pthread_atfork(NULL, NULL, trace_thread_atfork);
 #endif
 
     thread = g_thread_new("trace-thread", fn, NULL);
-- 
2.48.1


