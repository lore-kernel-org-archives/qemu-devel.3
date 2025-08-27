Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800F6CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 11:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urEKy-00069B-1g; Wed, 27 Aug 2025 07:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <l.stelmach@samsung.com>)
 id 1urCrj-0000GU-8L
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 05:54:51 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <l.stelmach@samsung.com>)
 id 1urCrd-0004DS-Ad
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 05:54:50 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20250827095429euoutp025020fbed392d676667788cead3704234~flw7lY6aF0830508305euoutp02Z
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 09:54:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20250827095429euoutp025020fbed392d676667788cead3704234~flw7lY6aF0830508305euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1756288469;
 bh=gBdYfosTpSIbDsGE8qS6LTys01L/u2i0I1dUqIvtzyA=;
 h=From:To:Cc:Subject:Date:References:From;
 b=kbjcIMNi5qXyw9bT/eXMQQu2li8MnJmhwODAMUR3efNriKYEqNIuyEGbEskDfG5t0
 SWYFXYQ1FN+kOtaOQkDAo6Uq3Gimog7g4GmROdLxBBIUhgdu6D4GaYyUlYgmXdtbCD
 jxrG0u3u+Wqu4/5wt9O5plCZMXF+HAe49y/OQE1s=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20250827095429eucas1p2b685855e7dd423a83b039824e723c6ee~flw7IuAoN0748307483eucas1p2Y;
 Wed, 27 Aug 2025 09:54:29 +0000 (GMT)
Received: from localhost (unknown [106.120.51.111]) by eusmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20250827095429eusmtip2e2e7e4855b41a9e5b051558fdcd7950c~flw7EW2xm2378123781eusmtip2M;
 Wed, 27 Aug 2025 09:54:29 +0000 (GMT)
From: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To: qemu-devel@nongnu.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH] linux-user: do not print IP socket options by default
Date: Wed, 27 Aug 2025 11:54:12 +0200
Message-Id: <20250827095412.2348821-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250827095429eucas1p2b685855e7dd423a83b039824e723c6ee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250827095429eucas1p2b685855e7dd423a83b039824e723c6ee
X-EPHeader: CA
X-CMS-RootMailID: 20250827095429eucas1p2b685855e7dd423a83b039824e723c6ee
References: <CGME20250827095429eucas1p2b685855e7dd423a83b039824e723c6ee@eucas1p2.samsung.com>
Received-SPF: pass client-ip=210.118.77.12;
 envelope-from=l.stelmach@samsung.com; helo=mailout2.w1.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 27 Aug 2025 07:28:55 -0400
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

IP protocols should not be printed unless the socket is an IPv4 or
IPv6 one. Current arrangement erroneously prints IPPROTO_IP for Unix
domain sockets.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 linux-user/strace.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git linux-user/strace.c linux-user/strace.c
index 3b744ccd4a..786354627a 100644
--- linux-user/strace.c
+++ linux-user/strace.c
@@ -586,23 +586,27 @@ print_socket_protocol(int domain, int type, int protocol)
         return;
     }
 
-    switch (protocol) {
-    case IPPROTO_IP:
-        qemu_log("IPPROTO_IP");
-        break;
-    case IPPROTO_TCP:
-        qemu_log("IPPROTO_TCP");
-        break;
-    case IPPROTO_UDP:
-        qemu_log("IPPROTO_UDP");
-        break;
-    case IPPROTO_RAW:
-        qemu_log("IPPROTO_RAW");
-        break;
-    default:
-        qemu_log("%d", protocol);
-        break;
+    if (domain == AF_INET || domain == AF_INET6) {
+        switch (protocol) {
+        case IPPROTO_IP:
+            qemu_log("IPPROTO_IP");
+            break;
+        case IPPROTO_TCP:
+            qemu_log("IPPROTO_TCP");
+            break;
+        case IPPROTO_UDP:
+            qemu_log("IPPROTO_UDP");
+            break;
+        case IPPROTO_RAW:
+            qemu_log("IPPROTO_RAW");
+            break;
+        default:
+            qemu_log("%d", protocol);
+            break;
+        }
+        return;
     }
+    qemu_log("%d", protocol);
 }
 
 
-- 
2.39.5


