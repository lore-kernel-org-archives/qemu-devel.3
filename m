Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DD4C61DD7
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvNF-0004sJ-VQ; Fri, 28 Aug 2026 08:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvMs-0004Gz-HB
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:07:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvMo-0003IS-MZ
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:07:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTTOSanhGHKbR3ZZ0ym2Im83p2rMYPHN3U4INkRVXUw=;
 b=P6V0tAeHWIOHhNwB9dCw4tLMdt1DBjBfJlqwkucnKOe1Wd4K18bk4eJkeOgAaaft+FdTXo
 uBORgx1fzdCYWcrDv0vEFnPEXT2s9OV57mBmU+FFOkc5xPEHacxLHE/KWxIW7grw0uHK1o
 KpdhqbkwwOZXgySa3ej42WeFV5/KBgA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-gA_FvuLpM-2GHJaxFhff0g-1; Fri,
 28 Aug 2026 08:07:26 -0400
X-MC-Unique: gA_FvuLpM-2GHJaxFhff0g-1
X-Mimecast-MFC-AGG-ID: gA_FvuLpM-2GHJaxFhff0g_1787918845
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79BA518C0FCC; Fri, 28 Aug 2026 12:07:25 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ACF2E1955F05; Fri, 28 Aug 2026 12:07:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:30 +0400
Subject: [PATCH v5 33/50] monitor: add monitor_cur_hmp() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-33-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2283;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=27cFGH87Wmo+JiZTbLanexVZ3ePxuAtdbhaB/Ls1+ow=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk5BzbfmiZ6J+rQvAldl8SXfH/EoeZkZ8DxY
 uqoH70cFFeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OQAKCRDa6OEJdZac
 5RaNEACMOaaPQyP6vAnh37+BLlg0d8dRNhXfvj2rqH+4NuVMxv5JKRehLtWRBZGkAoebQIpGz9L
 FaYXswcGXqDkxtBwaTXNO4n4oc7wCRXk85o14E5T222tDp3rrxCqpM3PS1BfN6a4USSAqBIvLKc
 hhzV02ftsQ68llPDP2Jofx92L8wOojkIYbMeLUqJAXWVox2mFRzdEwdPLJHUxrZnAyWsTBmU0Gx
 AwRWzXZPootl1DRHeE/yG/Eq+rndduiYQRnaPngGQ7lIKLOljZ7U4UtTvnHgWjm1P6s1JmPCbLP
 qs3UcnR8LDNuqds8EYlqbVa2uJmKuzn047EBUjffh/huq6M/TZDznEPif4qwX0GKX3HZE/NV27W
 /8j7X40joQmOtR/By/87y5+IIH9cO74C/iDSELkUPbkH6b5CJJJVWunFlTgyZqi0nLUy/UUWe7d
 O714nONpqJ3uXHHk799BujydFuFUFsOnZ7Z+BFLa7Df5wWSSDBf4eB2FFdqTR+5NfvFL0JvWKj+
 E/IPT7hGT3qr72bGW6C+bAbafyTSBHOyBLH9i0I0pDfglo/x0fAwUg65Kd/O2MF/VHEZbVvYD9W
 S7+obSmD3cFN7opZJvaiIzVywlgeyQDz9ZO1L6ggxoJXbSiZhQPOHEym5bM5sI+xy7gNH9v2NMj
 37XiY/h4fO6mnHA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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


