Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0557C98328
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA8V1-0001qE-3G; Fri, 25 Sep 2026 12:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xA8Ft-0000EM-Nv; Fri, 25 Sep 2026 11:54:34 -0400
Received: from 2.mo15.mail-out.ovh.net ([5.135.90.179])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xA8Fp-00067R-Ce; Fri, 25 Sep 2026 11:54:32 -0400
Received: from DAGFR11EX3.OVH.local (unknown [10.110.43.115])
 by mo15.mail-out.ovh.net (Postfix) with ESMTPS id 4hrwHW1CQbz3wp7;
 Fri, 25 Sep 2026 15:54:15 +0000 (UTC)
Received: from ovhcloud.com (109.190.254.61) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 17:54:13 +0200
From: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, Eric Blake <eblake@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 1/2] nbd/client-connection: Fix client returning a closed
 channel
Date: Fri, 25 Sep 2026 17:53:45 +0200
Message-ID: <20260925155346.357703-2-guillaume.vincke@ovhcloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925155346.357703-1-guillaume.vincke@ovhcloud.com>
References: <20260925155346.357703-1-guillaume.vincke@ovhcloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [109.190.254.61]
X-ClientProxiedBy: CAS4.OVH.local (172.16.1.4) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 11035789415831191847
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTET5RUJGNfmJ9NTrJITjXYbdcTO3CD1/irQgvmbcVvU+j3yU3NLNdBQmSWzUyxGftnAL5Iois3+qtj5G+XGi6yJapT3529pc59sfOOCq/Kc8FQqT0XQF2xXbKMW9Wi/PJNlpjMFYJCk+XKL+8KSXvAiIysT66Iz/ljKq0uOHOb4fy1muOGETRnXuHRDQlP5guWfSG0NaIpQ2MvLi/625mPQwXHSmLKChwuCT5l8HPUupqfW4YfVcoXdGds9cFNYInZ9eTzaLkTVa9NMU6N55UkVhVs1pX/lFlbzKKFdmuYQ7LC7KFt6l3jwirOWNNA0XHCtZueAPaQvk4ugL/EC2Ybessk4iZdJyM4kj0LVGZxyt6b/vAlnclParS91v/L68acsYwQQ3Rl8NA9EskWg7wcXzNCZQgR3lQCc9U1Q5KBX10qK0wxsS4grI0+aHtp28WBiaotM2121hUueftkSkXHHGA9k7XqBeHKSWs4zKG5nYBdzTpWvKoRT04XPVjXf0TVdXLzwI+I/bUqMu/JAj1q+6wyHWq0xv1+YJqKUnAo+dxeORxN+CxpC9rDjQsAcRTKvbWrh0dB6D8K0Sl6hCwFrFd2knOKIfv1Rj45r+EWlolc5aa5qv6WIKHpjfya1yJ0PaoasSnWd6orkgjpj9bNB3kpkOWy4+s1pyG/pZ3zwOg
DKIM-Signature: a=rsa-sha256; bh=c/b8KK6NZUiSNY5f9XgjrpPC0lZfNPNTGxt/ZcXT3mU=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1790351655; v=1; 
 b=fK7880b5SwVIYkPP+IPsuINon9dWE7Lvxw3FUAewHzSoqrZ64mJkiGqRwv+LgAYGrYSUInm+
 hRrbzkXv6I0KFHsUrqhpwXc0d5ArP8qJNTNeTqihRMpGcahIWrAGGkeYwklxDbnnHHR2UBiJ1pj
 tQPzGuEMdjqWiBbwE/q9CIxU=
Received-SPF: pass client-ip=5.135.90.179;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=2.mo15.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 25 Sep 2026 12:05:02 -0400
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

When a server closes the connection after a successful handshake but
before running any operations, the channel returned by
nbd_co_establish_connection() is the closed one and the connect thread
is not started.

When configured with reconnect-delay=0 (the default), this situation
generates at least two IO errors. The first one happens when trying to
issue an operation to the closed socket. The connect thread will be
started on the next request, which may happen long after, and will
create the second error as nbd_co_establish_connection() returns a NULL
channel.

Peeking the channel to detect FIN or RST avoids the first IO error and
does not delay the starting of the connect thread.

Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
---
 nbd/client-connection.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/nbd/client-connection.c b/nbd/client-connection.c
index 6a4f080717..878219fede 100644
--- a/nbd/client-connection.c
+++ b/nbd/client-connection.c
@@ -274,6 +274,26 @@ void nbd_client_connection_release(NBDClientConnection *conn)
     }
 }
 
+/* only true when the peer closed the channel. Does not detect if dead */
+static bool nbd_channel_is_closed(QIOChannel *ioc)
+{
+    char data;
+    struct iovec iov = { .iov_base = &data, .iov_len = 1 };
+    ssize_t len = -1;
+
+    if (!qio_channel_has_feature(ioc, QIO_CHANNEL_FEATURE_READ_MSG_PEEK)) {
+        return false;
+    }
+
+    len = qio_channel_readv_full(
+        ioc, &iov, 1, NULL, NULL, QIO_CHANNEL_READ_FLAG_MSG_PEEK, NULL);
+
+    if (len == 0 || (len < 0 && len != QIO_CHANNEL_ERR_BLOCK)) {
+        return true;
+    }
+    return false;
+}
+
 /*
  * Get a new connection in context of @conn:
  *   if the thread is running, wait for completion
@@ -295,6 +315,7 @@ nbd_co_establish_connection(NBDClientConnection *conn, NBDExportInfo *info,
                             bool blocking, Error **errp)
 {
     QemuThread thread;
+    QIOChannel *ioc;
 
     if (conn->do_negotiation) {
         assert(info);
@@ -308,6 +329,20 @@ nbd_co_establish_connection(NBDClientConnection *conn, NBDExportInfo *info,
         assert(!conn->wait_co);
 
         if (!conn->running) {
+            if (conn->sioc) {
+                /* discard if the socket got closed by its peer */
+                ioc = QIO_CHANNEL(conn->sioc);
+                if (!qio_channel_set_blocking(ioc, false, NULL) ||
+                    nbd_channel_is_closed(ioc)) {
+
+                    qio_channel_close(ioc, NULL);
+                    object_unref(OBJECT(conn->sioc));
+                    conn->sioc = NULL;
+                    object_unref(OBJECT(conn->ioc));
+                    conn->ioc = NULL;
+                }
+            }
+
             if (conn->sioc) {
                 /* Previous attempt finally succeeded in background */
                 if (conn->do_negotiation) {
-- 
2.43.0


