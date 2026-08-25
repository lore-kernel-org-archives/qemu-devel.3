Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0802EC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywZY-0001Qx-Uf; Tue, 25 Aug 2026 15:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywZH-0000xq-DU
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:12:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywZB-0004Md-PL
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:12:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTTOSanhGHKbR3ZZ0ym2Im83p2rMYPHN3U4INkRVXUw=;
 b=B3USttgakLCsRi3aJ+jkPWGnAh9smR40IlIIeM17Zsh09I7tp4kLGBgagOYFVrb8xfetSA
 98SQZMn42ph+41USCV1620kKXlPWt4r5KVBdh8vsGbDqrq5CZZq6jLi1uHI/Gt1Fh19Zke
 mLmIzXtFt97qyhRx2l7BJSRParN1j2M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-8psgVz8QPu2tQM1uXxcVeg-1; Tue,
 25 Aug 2026 15:12:08 -0400
X-MC-Unique: 8psgVz8QPu2tQM1uXxcVeg-1
X-Mimecast-MFC-AGG-ID: 8psgVz8QPu2tQM1uXxcVeg_1787685127
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1AF318C1057; Tue, 25 Aug 2026 19:12:07 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F2FE418005B4; Tue, 25 Aug 2026 19:12:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:39 +0400
Subject: [PATCH v4 32/49] monitor: add monitor_cur_hmp() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-32-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2283;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=27cFGH87Wmo+JiZTbLanexVZ3ePxuAtdbhaB/Ls1+ow=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiIgL1o9HMkf9JTk/U+0L5ipJNCBVdeHNT/2
 OKYUfOdt7mJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3oiAAKCRDa6OEJdZac
 5ffcD/4l9JKrsX9lfy+8DzVeC+vaCEe29mcQHcgKGMNDtggHozLDwcNQ8TVBR97pQ+yhrHFLP0I
 X061BJ5bS2zi3xojS6B9WWL4DKo3fSmyDv7/PJNgYvC7KuIV2LthZYvr3xt3JrN5AjJm1RDcSYg
 TCZB0Iec3vw62iDWGVfJQCJqF0F7JYnfvfCuKi+zXCv2UK6ZHlA6sUsrhNHUK1Dr1YkYucJVIur
 GslDTJy6Xuo80HVUDZiO0z5qFP+pxW7+/zIqzslx7rfL8s4s7oM5jdnyQVkK7cNqIA9JMr048my
 5701Stsfk+rZVJ9XQ7MZF/gI0dFHaGRQTNDJBjCvdyJ7KPKLbecekHknYHzD9eiP/ftt8DjxePU
 OEqglz3n1WJ/jV+5AxLMfSE4ap+a3NxIwLHlPxzboxai68xwJgcvmqexmiHPQ7nPiJPYzsOZdDq
 UaglLO7oguMo1pTK6vXm0V6IIFiEZW3/80kjQGvwba2d28CMGuuLHpjWZGyZ/xdLNbicqh3irjB
 AiPPcPIxVz0e7xUWFCYahvHr2wqAvuz/oPB0sjEUv5KDeOLnBjwxwOrXUed2TTWLMob64emLVBt
 1B6/8rwDipeoteWwJDyo9ZH/DqAO7YBSuotW7DdmC/3PCkpB/+ejWF3G5SUaeX3+JScAwHkUIYW
 TaXPi6+HIE3t6bw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
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


