Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66143606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=wSzFOPhH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWow9-0004mV-Fy; Fri, 27 Nov 2026 00:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWovx-0004Wh-Ni; Fri, 27 Nov 2026 00:55:48 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWovv-0000Tt-QR; Fri, 27 Nov 2026 00:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758870; bh=DcSugkKNOUyx4l5zjyVVPwPAIajcLpZk5wb0ZhQLKP4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=wSzFOPhHf0o0yjbIYANDqcFcATqyVKG6FHnIXeRdPmbfTa9LsbewJoyGJVHsQyPD7
 cmyq2G/xQ4LdPEoPRffqIpsTSl+jBG3PedwAHxPG00wgbXLtgYTQF4NwtS9VGcxH5/
 22xm26o1UQbKdCqsFmFl1YEusRQ7nDacGzQnTcK8M/XjyL6I+20ZaV6cRd1X6fLwW7
 DOegwQoM5X1v+zvPMaOy+sHHLI6we2eALdnrBNzAxfZvJFOsOpkKaPFl8O05DFMU2H
 w1Ao8078PP8KEwhZQoWh4/OwiYwSedikT/2X2pwPJ+Xc0ToVFb91ZCNIYgcESaEy1j
 0IK/1BFHVxQ1A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E226A1EA2D2;
 Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DFDD8469910;
 Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id BFFD7CF22C; Fri, 27 Nov 2026 08:54:30 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 075/140] tests/qtest: Make netfilter tests accept
 padded ethernet packets
Date: Fri, 27 Nov 2026 08:53:01 +0300
Message-ID: <20261127055421.39015-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
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
(Mjt: drop changes to tests/qtest/test-filter-buffer.c which is not in 10.0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
index a996a80c1c0..b32f2a88bf1 100644
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


