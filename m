Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFE9606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 04:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kenjo.org header.i=@kenjo.org header.a=rsa-sha256 header.s=mail header.b=lPUFZ3/9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVhvS-0006Tg-Fg; Mon, 23 Nov 2026 23:14:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ken@kenjo.org>)
 id 1xVfe5-0008Kq-HE; Mon, 23 Nov 2026 20:48:33 -0500
Received: from h-155-4-163-233.a498.priv.bahnhof.se ([155.4.163.233]
 helo=mail.kenjo.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ken@kenjo.org>)
 id 1xVfe4-0000Rj-6o; Mon, 23 Nov 2026 20:48:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kenjo.org; 
 s=mail;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YNF5ZHXGZAroR25It2XFZNkSm/Glz9ic87BB7e8BUHg=; b=lPUFZ3/9em0CcXlG6Nb8+ZTJJa
 MEiNNKEJPhlwE+ratL1DomWlxnHgyXUxM1rDAhw3XjK451YhCpBpkYTFtX5a5xT2Ihh1TVnNGhKOR
 xsi8h8HTjFhmVO1G7wKjNwy8cJ4/y4uAytxSWis/UsFxvp2Vl+X1Aju/iWBX9Pr6AtGw=;
Received: from brix.kenjo.org ([172.16.2.16])
 by mail.kenjo.org with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.98.2)
 (envelope-from <ken@kenjo.org>) id 1xVewr-00000004FUo-38jT;
 Tue, 24 Nov 2026 02:03:53 +0100
From: Kenneth Johansson <ken@kenjo.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Kenneth Johansson <ken@kenjo.org>
Subject: [PATCH 1/2] tests/unit/test-aio: aio_notify() after aio_poll() in the
 glib loop
Date: Tue, 24 Nov 2026 02:03:50 +0100
Message-ID: <20261124010351.3166118-2-ken@kenjo.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261124010351.3166118-1-ken@kenjo.org>
References: <20261124010351.3166118-1-ken@kenjo.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=155.4.163.233; envelope-from=ken@kenjo.org;
 helo=mail.kenjo.org
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_RDNS_DYNAMIC_FP=0.01, RDNS_DYNAMIC=0.982, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 23 Nov 2026 23:14:35 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

aio_poll(qemu_aio_context) can run between the glib event loop's
prepare and poll steps, e.g. in a vCPU thread holding the BQL.  Check
that aio_notify() still wakes the glib event loop afterwards.  With the
io_uring fd monitor it does not: the poll times out.

test passes when compiled with --disable-linux-io-uring
test fails when compiled with --enable-linux-io-uring

Signed-off-by: Kenneth Johansson <ken@kenjo.org>
---
 tests/unit/test-aio.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tests/unit/test-aio.c b/tests/unit/test-aio.c
index b3ca4d8a59..3cf2fa91a4 100644
--- a/tests/unit/test-aio.c
+++ b/tests/unit/test-aio.c
@@ -830,6 +830,38 @@ static void test_worker_thread_co_enter(void)
     g_assert(!aio_poll(ctx, false));
 }
 
+/*
+ * aio_poll() can run between the glib event loop's prepare and poll steps,
+ * e.g. in a vCPU thread holding the BQL.  aio_notify() must still wake the
+ * glib event loop afterwards.
+ */
+static void test_source_notify_after_aio_poll(void)
+{
+    GMainContext *gctx = g_main_context_default();
+    GPollFD fds[16];
+    gint max_priority, timeout, nfds;
+
+    do {} while (g_main_context_iteration(NULL, false));
+
+    g_assert(g_main_context_acquire(gctx));
+    g_main_context_prepare(gctx, &max_priority);
+    nfds = g_main_context_query(gctx, max_priority, &timeout,
+                                fds, G_N_ELEMENTS(fds));
+    g_assert_cmpint(nfds, <=, G_N_ELEMENTS(fds));
+
+    aio_notify(ctx);
+    aio_poll(ctx, false);
+
+    aio_notify(ctx);
+    g_assert_cmpint(g_poll(fds, nfds, 1000), >, 0);
+
+    g_main_context_check(gctx, max_priority, fds, nfds);
+    g_main_context_dispatch(gctx);
+    g_main_context_release(gctx);
+
+    do {} while (g_main_context_iteration(NULL, false));
+}
+
 /* End of tests.  */
 
 int main(int argc, char **argv)
@@ -869,5 +901,6 @@ int main(int argc, char **argv)
     g_test_add_func("/aio-gsource/event/wait/no-flush-cb",  test_source_wait_event_notifier_noflush);
     g_test_add_func("/aio-gsource/event/flush",             test_source_flush_event_notifier);
     g_test_add_func("/aio-gsource/timer/schedule",          test_source_timer_schedule);
+    g_test_add_func("/aio-gsource/notify-after-aio-poll",   test_source_notify_after_aio_poll);
     return g_test_run();
 }
-- 
2.51.0


