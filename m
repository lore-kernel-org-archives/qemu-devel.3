Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379BAC61DD7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Qy-0003Cs-W7; Fri, 28 Aug 2026 16:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Qx-00035x-9C
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Qr-0000Qg-6Z
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IntAqb7DnZPw6ci/kULNqGR78w6ikkZFP3o6TpicLh8=;
 b=eDNWMw9Aao8XsnQ5ENC/9J7ax8fY6carr6/PGkQs0p1Hws6V7IlXJTa63gMRhxvsM5q0EG
 qnucEtz7HNrzgAkFsaeetpONKzUREOsst6z73hisDW0yS1lsi6lbTjmDQqFoWbsUHwHf8Y
 u8QbFe+EGR9R9NwVAA1g/mF5QsCntvM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-2WOQko4xMZitTIMLl5vekQ-1; Fri,
 28 Aug 2026 16:44:02 -0400
X-MC-Unique: 2WOQko4xMZitTIMLl5vekQ-1
X-Mimecast-MFC-AGG-ID: 2WOQko4xMZitTIMLl5vekQ_1787949842
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E77B018052C9; Fri, 28 Aug 2026 20:44:01 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 298A718001CF; Fri, 28 Aug 2026 20:44:00 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:42:12 +0400
Subject: [GIT PULL 33/50] monitor: add monitor_cur_hmp() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-33-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2349;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=C7Z2MiwnXVYSvRFfuRJ23ToGCWaLGW6Cqe4I0EiKEdU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKVWYphTjA2mExblVbQLzkMoggkIFnOQ7D9C
 2AOs5E560mJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylQAKCRDa6OEJdZac
 5WWvD/94X3+Eiok0N451C06a1MMlJfqsAx5L9MI6ZpoOM77+w0ih1omIguByI7Q/2cU/9RMqd4e
 Vu8RjcWYapl5rMY1LYPcmwtXxBGVcPEVvhhCckBDXCl3+pbg4A7BGEwQe6YBiQVbl3T23cImMww
 zcK/p716SDeIs+C0KAZnQ3jkWwyjpk1RUaixJUxtrbz3IMjtKVlZMlESR7Mp7a2NL6qPRVYcN8T
 eNoJDrxMxj8/ju1s9hJYXCpRDFgyKheTz53Eg4ESl0TEyUuXbBO2+X8RkW1lGFuF8qnL/kH2++8
 TfRkqLD7uu48ebpj04ObUreQdnvmKKWIX9hKh4BM7cTrcTmjQN2hPDbH30D74vJ0dsTXiD6rpUg
 xZLoWEywaKMIm/G9cJ3oNOGdh+mihd6XaFyLtgf6FTum1Ie2iATWztMChQh32GtrDxvHydCSYQt
 JHy5xNr3MPnl7fE5/GjicyjXXJzoT7MPgy8BuCpPcBmanxX3k+FRlXmt7rd9zzASnCKrlRChEzn
 jIuYNtR0kYq29R2I7EJ9oX39DllF6XgQdidy3dSCJ6i6Rc154RQnPXXBFajopbSVp+BXOz4EDsh
 dAjNl5Rnt9qw4ty7Ap2upw5u6N3r33aMWAFnZwLKPLjR6kIWo49PE0CW7l2Ge2Mnx3EAJcJZpWg
 LrJ8cJxU37kpHlA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
Message-ID: <20260828-qemu-no-hmp-v5-33-9227de146347@redhat.com>
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


