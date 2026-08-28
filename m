Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E89C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvOi-0000H5-Ep; Fri, 28 Aug 2026 08:09:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvO2-0007RW-CK
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:08:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvNz-00040P-GN
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4yxC37E6EPeDva1jw6J0uxU1XDQzh6XgusSRUOSXDhA=;
 b=KWihrRuvL9jfjpTDGGlJnLv2Zbgq4w5fGpWMuP3YJOSzDUBDZljEZ9QQnMSHNqoV/Nhgum
 4YG/sg3j9uDEu4pqbol4F/ttj/pDHu+eMzC414Z87itkOVo2CSHqiz+/F5+iwGbsyBzG+O
 wsx+TWlYURAlZwmxNWDjCdMyvyjkcmE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-zYMHoWkaOAW7nkQ7F2ClfQ-1; Fri,
 28 Aug 2026 08:08:41 -0400
X-MC-Unique: zYMHoWkaOAW7nkQ7F2ClfQ-1
X-Mimecast-MFC-AGG-ID: zYMHoWkaOAW7nkQ7F2ClfQ_1787918920
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61D421955DAF; Fri, 28 Aug 2026 12:08:40 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7F0683000223; Fri, 28 Aug 2026 12:08:38 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:43 +0400
Subject: [PATCH v5 46/50] stubs: split monitor-core stubs into separate
 compilation units
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-46-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2702;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ZHHikVkOxgFtjtJG4G5XJ54H00TpjuShs2goDtLk+2U=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk6/M6SNBuJvJn5cPl480zbIHDX9dgBrVgeI
 eQnDoamehKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OgAKCRDa6OEJdZac
 5Zt9D/9hJ9gAV1GVBHI9OaVKfUUDnlnU8PMydDMrrul9I09YGHfpCfptNjhbfUxEn0SIBmbRA+c
 KnSxm76x3g967HzXuCU0RlDU78bJJzwzzJiq8m2nzOW4/kffQ9jYnUVTCnBf2F+T4c9V+ACdiK+
 0NeoR3Ccw/Pm2cdH8ChUzmhJUES88O6b+4Yx8x9obizagv3PxBAB/62JcRF5jTeeAHrVkC+Vwy3
 7EE9VKLQ+BVq7Gi1y5BWp8/LonbO+AQOJgmINfofoF/g2YTBJm68SPtbJk88wsAh6utNWchTjb/
 SQYNjcXqxH2WP7DkhsDJtJXYNzwqoGxlrmmmStUOIhv3cBXGVpgFw494FvGjDZhfYLmuIBeN6Lp
 Tg15RFj0FHmk92MpCYv7AO6hs0UyX/UlsQt7PmfHlEDpYMNWAHJr/OtVKE38lizjETSJTh2pyP8
 0rqAa09TbuxN0mWURQ0Vu69u0sLAlwT5clofWVPPgAsihAIZWFftLofZG/OKyGUtsm1XG9khidX
 1lcJW5Yei703Dmx6BNQxqMUzOTlW0AhAkpoZxK+YBiFtC5xj5m/aJtV+rnbXIMXWXg8wXPvS9Sb
 j3ciURP3E0SifviCROKuXGGyM89B21bWackFXQO9GvS3hRhjd9fENG1k3Fz9dTQy0oaNH3UzoSx
 Kcc0mCSUBQ7x0mg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

The wild linker rejects duplicate symbols even from archive members.
When qemu-storage-daemon links both libqmp (with monitor/monitor.c)
and libqemuutil (with stubs/monitor-core.c), all symbols from the
stub .o are pulled in, causing duplicates for monitor_cur,
monitor_set_cur, and qapi_event_emit.

Split each stub group into its own file so the linker only pulls in
archive members whose symbols are actually needed.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


