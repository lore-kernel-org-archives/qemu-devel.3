Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EEE606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=FgewLZuY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp6K-000430-L8; Fri, 27 Nov 2026 01:06:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp3y-0005n8-LA; Fri, 27 Nov 2026 01:04:03 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp3w-0003bh-Bq; Fri, 27 Nov 2026 01:04:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759041; bh=LQIRAolb4MiCZg2AgX1QKOoV5Z3ykxOymBTQ6uV3Vzg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FgewLZuYS9TKxKTFVa90ae2CIhG0f46ti4MrGZRylToSGQHLK33fNLzKGzuT9TeKC
 v77sGlmwcELGWqBmSzkCQoR5UhZ9b8AB9Hr/xPY+eveow2NrXwX8rZkIUTu4+s1icf
 E6tXOCW+qxgoNA0t20dx11PPAND84llcXEyOFPSe3G61HqlXwNcSjicV5EII71wvv2
 qw504s1e+Tm+P1SgbtfoOfxxt50wSkCz6UFkMUBJ68YkiOWa09qESvq73IEo7xq3BX
 /5JVtfsP1usz7NnYbOeuA7FJdrnn+emHtbBmtyxTN4X2lTC8eYfbywxuJchq/eTbir
 b8+g/28R+T3NA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A45761EA341;
 Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A22A746996D;
 Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7C48FCF2D2; Fri, 27 Nov 2026 08:57:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 080/152] tests/qtest: Make netfilter tests accept
 padded ethernet packets
Date: Fri, 27 Nov 2026 08:53:38 +0300
Message-ID: <20261127055709.39630-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

Currently the various netfilter tests assume and assert that the data
they get from the filter is an exact match for the data that they
send in to it via the net socket backend.  This happens to be the
case currently because the net socket backend fails to pad frames to
the ethernet minimum when the device expects that (unlike e.g.  the
tap backend).  When we fix the socket backend to honour the device's
request for padding, the netfilter will see padded packets for
devices that require them (which is most of them), and not for those
that don't (notably virtio-net).

This seems best considered as a test error: if you're using netfilter
to look at what a particular network device is receiving, you want to
actually see what it is receiving.  And most real-world users of
filtering will be doing it with the backends like TAP that were
already doing pad-before-filter; it's only the oddball backends like
'socket' that forgot to pad.

Make the test cases accept as valid both padded and unpadded frames.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20261110180655.2072265-2-peter.maydell@linaro.org
(cherry picked from commit f996ee991c1f234046fd9a81ca152a7c8cf7ce3a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/test-filter-buffer.c b/tests/qtest/test-filter-buffer.c
index 441cbb975ca..418caccf00a 100644
--- a/tests/qtest/test-filter-buffer.c
+++ b/tests/qtest/test-filter-buffer.c
@@ -11,6 +11,7 @@
 #include "qobject/qdict.h"
 #include "qemu/iov.h"
 #include "qemu/sockets.h"
+#include "net/eth.h"
 
 /*
  * Test that changing interval at runtime affects packet release timing.
@@ -148,7 +149,8 @@ static void test_change_interval_timer(void)
     ret = recv(recv_sock, &len, sizeof(len), 0);
     g_assert_cmpint(ret, ==, sizeof(len));
     len = ntohl(len);
-    g_assert_cmpint(len, ==, sizeof(send_buf));
+    /* The snooped network device might or might not have asked for padding */
+    g_assert(len == sizeof(send_buf) || len == MAX(sizeof(send_buf), ETH_ZLEN));
 
     ret = recv(recv_sock, recv_buf, len, 0);
     g_assert_cmpint(ret, ==, len);
diff --git a/tests/qtest/test-filter-mirror.c b/tests/qtest/test-filter-mirror.c
index 723d2c2f291..9972712cb49 100644
--- a/tests/qtest/test-filter-mirror.c
+++ b/tests/qtest/test-filter-mirror.c
@@ -15,6 +15,7 @@
 #include "qemu/sockets.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "net/eth.h"
 
 static void test_mirror(void)
 {
@@ -58,7 +59,8 @@ static void test_mirror(void)
     g_assert_cmpint(ret, ==, sizeof(len));
     len = ntohl(len);
 
-    g_assert_cmpint(len, ==, sizeof(send_buf));
+    /* The snooped network device might or might not have asked for padding */
+    g_assert(len == sizeof(send_buf) || len == MAX(sizeof(send_buf), ETH_ZLEN));
     recv_buf = g_malloc(len);
     ret = recv(recv_sock[0], recv_buf, len, 0);
     g_assert_cmpint(ret, ==, len);
diff --git a/tests/qtest/test-filter-redirector.c b/tests/qtest/test-filter-redirector.c
index 5540c232c0b..a4f9b73c72a 100644
--- a/tests/qtest/test-filter-redirector.c
+++ b/tests/qtest/test-filter-redirector.c
@@ -57,6 +57,7 @@
 #include "qemu/sockets.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "net/eth.h"
 
 static void test_redirector_tx(void)
 {
@@ -115,7 +116,8 @@ static void test_redirector_tx(void)
     g_assert_cmpint(ret, ==, sizeof(len));
     len = ntohl(len);
 
-    g_assert_cmpint(len, ==, sizeof(send_buf));
+    /* The snooped network device might or might not have asked for padding */
+    g_assert(len == sizeof(send_buf) || len == MAX(sizeof(send_buf), ETH_ZLEN));
     recv_buf = g_malloc(len);
     ret = recv(recv_sock, recv_buf, len, 0);
     g_assert_cmpint(ret, ==, len);
-- 
2.47.3


