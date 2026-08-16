Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E537C5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgLE-0000oY-Mf; Sun, 16 Aug 2026 15:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgKw-0000eM-VP
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:16:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgKu-0008UX-3T
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEHcK7z4lsrjo+b0nnSXK3UE3eXILpOvD/vKXVIjWIU=;
 b=SvvFiVmcEeJifwheQn+Y2fdC1fhkttsNBiSJxmRTNafPXj9NMHzw13im9LTYxNvkHmpPYN
 zdfv74vi1PlruZztmPvJBZyg187Qb7AOWHIzF/82dCWj8mXzqKsAq6aFpmVD5N6Vk8eDoS
 eCHg3OH1ZwSnhRtgKyfgQ5ROTcgt5Ws=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-0D44Qhn8O3iTge3kEqClLg-1; Sun,
 16 Aug 2026 15:15:55 -0400
X-MC-Unique: 0D44Qhn8O3iTge3kEqClLg-1
X-Mimecast-MFC-AGG-ID: 0D44Qhn8O3iTge3kEqClLg_1786907754
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DBDE19560B5; Sun, 16 Aug 2026 19:15:54 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 34CB2195608A; Sun, 16 Aug 2026 19:15:52 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:13:13 +0400
Subject: [PATCH v3 46/49] stubs: split monitor-core stubs into separate
 compilation units
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-46-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2638;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2XvwU4FzVi+iQ75+LAQigV0q9d5xv2A741epbvOZt8c=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqggu0ygSaq5NDA7ihCFPjDn9Io9xkrDlAPQ/Zm
 4WbxPIn8YWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILtAAKCRDa6OEJdZac
 5ZjhD/94r88iG6jUbs0mQww5+E3lTCc+EfTl3QbQuLV6mFX0cVy/P8LaqyNhObP2n26M2gzd9SJ
 8Ntn6EX0NKCsvEcRlLGjmJmQdQR39trC9+/LCO0NlFyBxQ+BEUQ4fFve/CMMdqrw+3dWaAlk2My
 wU5kqIL/KDgUOtXVfXaLZ9XLfoHtNEMagmtGeLtRCNLj1bYbbZrew3Ygp0VoAbJEzunhQ8oGs7b
 7o93TqjW/OQZO0LnLB/iMuwRMdz6V9YMQHsmjiydrJBJmqnB+lHFbrPvdJF/dmmtHhCzXVz++mY
 ya02DvjojOR+1Imt9lo9vzsTrqVEnIiRd5BG3JrpoyZkLjWZWLdLEGXNE0/iCgHRayIeaLjXvOk
 sAZ+HqFU304fAZ602Zs6BIo8i0RvQhaDYl8cNuLHTbyJam1dI6eaFvXXT/s87ip+zpfUfNwd4Xx
 esxdKWGToI4ZrY2bU+51mnxRtbbfsE5j0aA9WmdDT1yQ66/8kZzjzOuntDqhGq4W5ym2QU2xCNh
 L/Vs1suB9KpZ2+vPABJujPIEIljT67BpIx6coVI4PYgmdqpVPSTxgGKg+T7VVoW4ouGaBN/87ud
 8FVSHApnXa+Sixjtx7pFwElcAk3/zaiCB2Ff+L7xDJ94y7sFqe151DCsM8PNVtUpr8C6H4SM5zZ
 greoKvER7SkXfgw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The wild linker rejects duplicate symbols even from archive members.
When qemu-storage-daemon links both libqmp (with monitor/monitor.c)
and libqemuutil (with stubs/monitor-core.c), all symbols from the
stub .o are pulled in, causing duplicates for monitor_cur,
monitor_set_cur, and qapi_event_emit.

Split each stub group into its own file so the linker only pulls in
archive members whose symbols are actually needed.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 stubs/meson.build       |  2 ++
 stubs/monitor-core.c    | 16 ----------------
 stubs/monitor-cur.c     | 14 ++++++++++++++
 stubs/qapi-event-emit.c |  8 ++++++++
 4 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/stubs/meson.build b/stubs/meson.build
index 93df8ea94f57..29b6644b2549 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -7,7 +7,9 @@ stub_ss.add(files('fdset.c'))
 stub_ss.add(files('iothread-lock.c'))
 stub_ss.add(files('is-daemonized.c'))
 stub_ss.add(files('monitor-core.c'))
+stub_ss.add(files('monitor-cur.c'))
 stub_ss.add(files('monitor-hmp.c'))
+stub_ss.add(files('qapi-event-emit.c'))
 stub_ss.add(files('replay-mode.c'))
 stub_ss.add(files('trace-control.c'))
 
diff --git a/stubs/monitor-core.c b/stubs/monitor-core.c
index 094b80721003..0e74d78d52e4 100644
--- a/stubs/monitor-core.c
+++ b/stubs/monitor-core.c
@@ -1,21 +1,5 @@
 #include "qemu/osdep.h"
-#include "monitor/monitor.h"
 #include "monitor/hmp.h"
-#include "qapi/qapi-emit-events.h"
-
-Monitor *monitor_cur(void)
-{
-    return NULL;
-}
-
-Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
-{
-    return NULL;
-}
-
-void qapi_event_emit(QAPIEvent event, QDict *qdict)
-{
-}
 
 int monitor_hmp_vprintf(MonitorHMP *mon, const char *fmt, va_list ap)
 {
diff --git a/stubs/monitor-cur.c b/stubs/monitor-cur.c
new file mode 100644
index 000000000000..93966a16b855
--- /dev/null
+++ b/stubs/monitor-cur.c
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "monitor/monitor.h"
+
+Monitor *monitor_cur(void)
+{
+    return NULL;
+}
+
+Monitor *monitor_set_cur(Coroutine *co, Monitor *mon)
+{
+    return NULL;
+}
diff --git a/stubs/qapi-event-emit.c b/stubs/qapi-event-emit.c
new file mode 100644
index 000000000000..70b2719d714b
--- /dev/null
+++ b/stubs/qapi-event-emit.c
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qapi/qapi-emit-events.h"
+
+void qapi_event_emit(QAPIEvent event, QDict *qdict)
+{
+}

-- 
2.55.0.543.g5ebe2ebe4ea8


