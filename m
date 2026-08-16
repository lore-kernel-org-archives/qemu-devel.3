Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C75C5DF66
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgKJ-0006uE-D3; Sun, 16 Aug 2026 15:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgKH-0006kv-54
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgK9-00088M-9x
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:15:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b0+NrocGg2s2UfaRXQzaxbckp7GlywcmRnsoIlrWMm4=;
 b=eHePZmOyrX086e8u3k4HeWwIhCo/EPj4N8DRVJOqulf3FPqjB2zzKcL9saOm0wKQzxLoBj
 MQ8T0BSXrrLMExKH4U+R3tP4LOL/zziE272ksj89uzn42VZ7AQ8Qjj0HEABOXkra1nbkCV
 0EeK/6Dr8F/SSrqR7UD21WwG6N3N/xY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-kdJ7Ngl9PUivQi3hu1FDcA-1; Sun,
 16 Aug 2026 15:15:04 -0400
X-MC-Unique: kdJ7Ngl9PUivQi3hu1FDcA-1
X-Mimecast-MFC-AGG-ID: kdJ7Ngl9PUivQi3hu1FDcA_1786907703
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C47619560A2; Sun, 16 Aug 2026 19:15:03 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 71DBC195608A; Sun, 16 Aug 2026 19:15:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:13:00 +0400
Subject: [PATCH v3 33/49] monitor: add monitor_cur_hmp() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-33-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2227;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=90aUJsjcWbB7AzInJ9UqT2isNsQm9fOohMSw1XfGyI0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqgguz2k/v7UDnaoaKfUvGZdEKP6bq35+SAcA5R
 28DmilGVTSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILswAKCRDa6OEJdZac
 5WVXEACpPp6wmJKthgwqcS7FeKB0UUiwgvRH0ng/2z/0w3Jjl795MYHkZVSpbjabvS3G/JAnhtt
 ipXLkd5RvgR5KArSwv1R9DkCpw85xVzWnOraC9B+ePaf2+2ld6X0Fc1SOLP0t2s7iO1o7yeug6l
 0b5tUvEstMvi88tSk/H4DchJaVOqFRBQ0CnaRq9bszQ0EQLCh6F0Jq7JeuwTmTtk31wOQZJ5/lo
 uDcoK5SpZFrthWPhgrKa2qOH5R5ShOYLPXeh2mDBh+JdcW++or2NQv3zK6rwl6YWjr8mFreCyfT
 /wsie5UVqr7pIoff+qD6+/1Srw5lhGkJdQMyPG0YZxYZ8GPZ4cqPeX6lkUtCbxgwgrheqMOsulT
 hJbLWsUdjovOjeA3ODcCvowicKgXQn11gx8tL6z/GUq1I/N2UFXdI3JXtUgpZcbzvBXxVl+lLbe
 XklaiaoP8qQtFGJV/1bHhGg4XbAOSvNrZt3KShxqiwDHpdWqvrA9u9ulYrpBQq1KJSVu80c80dV
 gQAktkHlcx4LvacQSF7oBiBMEzgBZJYENH+y0/b6xZgnptdnk0PawjfRTdP4ZjqFfQCuzXF0YDS
 EBfNXUlAXULYSxErpI19JjZniufHddHmPJK/NUkGDLxRF72Up7Y/TxDDm00yRvCG273iGTsPDdQ
 PH6j2VdGMsSGSlw==
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

This will help to simplify the code in the following changes.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/monitor/hmp.h |  2 ++
 monitor/hmp.c         | 10 ++++++++++
 stubs/meson.build     |  1 +
 stubs/monitor-hmp.c   |  9 +++++++++
 4 files changed, 22 insertions(+)

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 827a56144824..6aa562ddbaa2 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -36,6 +36,8 @@ struct MonitorDef {
 void monitor_new_hmp(const char *id, const char *chardev_id,
                      bool use_readline, Error **errp);
 
+MonitorHMP *monitor_cur_hmp(void);
+
 int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
     G_GNUC_PRINTF(2, 0);
 int monitor_printf(Monitor *mon, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 57c4127641ac..47fb7cef6de2 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -47,6 +47,16 @@
 
 OBJECT_DEFINE_TYPE(MonitorHMP, monitor_hmp, MONITOR_HMP, MONITOR);
 
+MonitorHMP *monitor_cur_hmp(void)
+{
+    Monitor *mon = monitor_cur();
+    if (mon) {
+        return (MonitorHMP *)object_dynamic_cast(OBJECT(mon),
+                                                 TYPE_MONITOR_HMP);
+    }
+    return NULL;
+}
+
 static void monitor_hmp_finalize(Object *obj)
 {
     MonitorHMP *hmp = MONITOR_HMP(obj);
diff --git a/stubs/meson.build b/stubs/meson.build
index 3b2f2680b193..7e15687a62b7 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -7,6 +7,7 @@ stub_ss.add(files('fdset.c'))
 stub_ss.add(files('iothread-lock.c'))
 stub_ss.add(files('is-daemonized.c'))
 stub_ss.add(files('monitor-core.c'))
+stub_ss.add(files('monitor-hmp.c'))
 stub_ss.add(files('replay-mode.c'))
 stub_ss.add(files('trace-control.c'))
 
diff --git a/stubs/monitor-hmp.c b/stubs/monitor-hmp.c
new file mode 100644
index 000000000000..9452a3f0c2c8
--- /dev/null
+++ b/stubs/monitor-hmp.c
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "monitor/hmp.h"
+
+MonitorHMP *monitor_cur_hmp(void)
+{
+    return NULL;
+}

-- 
2.55.0.543.g5ebe2ebe4ea8


