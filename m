Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AC7C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Rf-0006CZ-0o; Fri, 28 Aug 2026 16:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Rd-00065c-KX
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:45:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Rb-0000pj-VG
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sjafwm5BPsMoAETHERG3mpzCG9mRi3WYXcNEkit22Bo=;
 b=ZTHDjLmRslxvHW/kBsKONpG54rgRaKmv4kZtfCMoP18KcGgzT5xPWMx3M0pBqCFkzEMN7X
 z1M5cXqW+anV/d5HfzqRQq4uwlKfCBnPBNy4mqNyeuolz55Qfblqhhgas/nY6+/QFkItLo
 s35lrqpSxtNNjHlklvs62oNxSPT82Ts=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-84-rvbS6FknN-G1x-xlc57DfQ-1; Fri,
 28 Aug 2026 16:44:56 -0400
X-MC-Unique: rvbS6FknN-G1x-xlc57DfQ-1
X-Mimecast-MFC-AGG-ID: rvbS6FknN-G1x-xlc57DfQ_1787949895
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4300195D01A; Fri, 28 Aug 2026 20:44:55 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EB1BE1803A40; Fri, 28 Aug 2026 20:44:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:42:25 +0400
Subject: [GIT PULL 46/50] stubs: split monitor-core stubs into separate
 compilation units
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-46-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2768;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=e5zsDvqDHKFLUfJ1DZKf+ow2Mc/1tNSAbECpvkKyt34=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKVGrDZK1nqofi9w80BrrsxP0W+OpwDGstxt
 IcB62suCX+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylQAKCRDa6OEJdZac
 5bIKD/0ZKJOEyrQ4H3yBHreXXQLWqrna7/OU8xXdZ3+OOPsyWOdFkwkEno5xwA/wI/QZ9JmwaTu
 bfdsd5B36jNDYXz5sfycm/lz958h8uxvDVj/SrxCWKe8T912+xyBnyvkGZfbrxo3X0kUkwxxnLu
 vfeX1g40iHS3XIPZwRQcS0xgpJEAzC9UxW0W/+8jkX5qwf+UEXIagqFRHtDLG1ehVRtDMgxAUNt
 ec0q8AkfrLiiLQ+o1y53qJJ3frHEhC8nL4ylWbsrznJ7P7foqiYH+0JY/flejOJxH+jUf6YFGKp
 h6cVvpD6lzKENKNfe4p2qePfwMkZaUxg1ElFcBOgZrVTxY/OBPdNqFxKdsxrkiBYCafG/NwouRb
 tQ5saP3TIS6yfK4Sn4MJCIV2GhSl0hvgPFk1hDmhFKnhY9pBh1zTnV7ZAEN5hzp9wSYwFUV4g49
 LDVhJcA5Hv4HYHLUwV70daaeNkBGy+Bx+o1apxZuIJ8sIzTi8DdCeGg73hEVaPqgHq/yV6XgxCz
 cJ2ntQSV6ADmA9z8BhOWy82GD+n+LB3QGvUq09aQbq1nHBjTJUY/owH08immoy92PE+bpx5AERV
 GO7hk+L2xSJT/PbIbAsf5W89b/YVeDnFSJKEJxqD2lHjCyTeuzwWQLR3dBj6MOny/yzXf7PFGZ6
 sxzcyxS+NmFBHoA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260828-qemu-no-hmp-v5-46-9227de146347@redhat.com>
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


