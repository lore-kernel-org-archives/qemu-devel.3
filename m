Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6306AC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmCpR-00055Z-V9; Tue, 21 Jul 2026 11:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wmCpJ-0004y8-22
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:56:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wmCpH-0004xk-2C
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 11:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784649370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QheUhG6B28CxdAvqoTOybLRApIzFG0nB93Av+Z/Uids=;
 b=LIQOX7grv7dMOp1xGYJYjW0HfuOxiZsQls9BFCgWZiQ8ALH08XIb2Qhw6VtFxlule3CqqH
 guJSFYpMn/BRa+ifjc1RXxWsnvjqYwF2e60cErrhHn+ZKDSHgzR/B8s8/fLM1sr0FCPpvF
 DThADQ/ymdeMDeKcNK2uxCkS91eVRL4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-Jq2q71lYOjGW3h1ZRYfE0w-1; Tue,
 21 Jul 2026 11:56:06 -0400
X-MC-Unique: Jq2q71lYOjGW3h1ZRYfE0w-1
X-Mimecast-MFC-AGG-ID: Jq2q71lYOjGW3h1ZRYfE0w_1784649365
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 649DD1956077; Tue, 21 Jul 2026 15:56:04 +0000 (UTC)
Received: from berrange.com (unknown [10.44.32.83])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C69961800619; Tue, 21 Jul 2026 15:56:00 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PULL 1/5] test-util-filemonitor: Adapt to FreeBSD 15's native
 inotify semantics
Date: Tue, 21 Jul 2026 16:55:50 +0100
Message-ID: <20260721155554.128840-2-berrange@redhat.com>
In-Reply-To: <20260721155554.128840-1-berrange@redhat.com>
References: <20260721155554.128840-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

From: Jessica Clarke <jrtc27@jrtc27.com>

FreeBSD 15 introduces a native inotify implementation rather than
requiring use of the kqueue-based libinotify package. This native
implementation does not generate the extra deleted events, so don't
expect them. However, the original implementation did have a bug that
caused IN_IGNORED to never be generated if you did not also watch for
IN_DELETE_SELF, which affects 15.0 and 15.1, but has been fixed and will
no longer apply in 15.2 / 16.0.

Note that the deleted event check is for the userspace version, since
that governs whether libinotify is being used or not, whereas the
ignored event check is both for the userspace version (to check if we're
using the native syscall) and the kernel version (to check if the kernel
has the bug or not).

All __FreeBSD_version values used here correspond to the value in-tree
at the time of the relevant commits. Since neither commit bumped the
value there will be a window of development snapshots between each
commit and the previous bump that will be incorrectly identified here,
but this is the best we can do, and something users of snapshots should
be prepared to deal with.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/unit/test-util-filemonitor.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/tests/unit/test-util-filemonitor.c b/tests/unit/test-util-filemonitor.c
index 02e67fc96a..972651dc1e 100644
--- a/tests/unit/test-util-filemonitor.c
+++ b/tests/unit/test-util-filemonitor.c
@@ -27,6 +27,10 @@
 
 #include <utime.h>
 
+#ifdef __FreeBSD__
+#include <osreldate.h>
+#endif
+
 enum {
     QFILE_MONITOR_TEST_OP_ADD_WATCH,
     QFILE_MONITOR_TEST_OP_DEL_WATCH,
@@ -221,6 +225,24 @@ qemu_file_monitor_test_expect(QFileMonitorTestData *data,
 }
 
 
+static bool
+expect_broken_ignored(void)
+{
+#if defined(__FreeBSD__) && __FreeBSD_version >= 1500051
+    int osreldate;
+
+    osreldate = getosreldate();
+    if (osreldate == -1) {
+        g_printerr("Unable to call getosreldate: %s\n", strerror(errno));
+        abort();
+    }
+    return osreldate < 1501501 || (osreldate >= 1600000 && osreldate < 1600019);
+#else
+    return false;
+#endif
+}
+
+
 static void
 test_file_monitor_events(void)
 {
@@ -360,7 +382,7 @@ test_file_monitor_events(void)
         { .type = QFILE_MONITOR_TEST_OP_EVENT,
           .filesrc = "one.txt", .watchid = &watch4,
           .eventid = QFILE_MONITOR_EVENT_DELETED },
-#ifdef __FreeBSD__
+#if defined(__FreeBSD__) && __FreeBSD_version < 1500051
         { .type = QFILE_MONITOR_TEST_OP_EVENT,
           .filesrc = "two.txt", .watchid = &watch0,
           .eventid = QFILE_MONITOR_EVENT_DELETED },
@@ -539,6 +561,11 @@ test_file_monitor_events(void)
                 g_printerr("Event id=%" PRIx64 " event=%d file=%s\n",
                            *op->watchid, op->eventid, op->filesrc);
             }
+            if (op->eventid == QFILE_MONITOR_EVENT_IGNORED &&
+                expect_broken_ignored()) {
+                g_printerr("Expect ignored event to be broken, skipping\n");
+                break;
+            }
             if (!qemu_file_monitor_test_expect(&data, *op->watchid,
                                                op->eventid, op->filesrc,
                                                op->swapnext))
-- 
2.55.0


