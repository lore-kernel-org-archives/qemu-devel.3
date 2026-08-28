Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A74C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03QU-00010d-9J; Fri, 28 Aug 2026 16:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03QS-0000lU-7y
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:43:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03QO-0000Bf-Ro
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BXCLwhgcQi/gt5bym7mqNkDOb0wR31qDVj1pXJtDITc=;
 b=RgaIyROSUzHHDMUCCXpLU2tbxtNh9wRJk85mCZXtEscQkHvztXFn7M2Brjvr+LEAkE6hkP
 6IlaAzzBm4A+oxqGcBpCmsHjso3/vDaysrLECPDYFjXfO671E2W2dF8YFi4UNSxVwlB3Jf
 RRk15gR181o9TlLiPWEecgc/JRMtJZs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-7q6numqANhK5Ocr4v2Qgig-1; Fri,
 28 Aug 2026 16:43:40 -0400
X-MC-Unique: 7q6numqANhK5Ocr4v2Qgig-1
X-Mimecast-MFC-AGG-ID: 7q6numqANhK5Ocr4v2Qgig_1787949819
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C54C18A3C04; Fri, 28 Aug 2026 20:43:39 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 54C671955F43; Fri, 28 Aug 2026 20:43:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:42:07 +0400
Subject: [GIT PULL 28/50] system: guard HMP initialization paths with
 CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-28-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3808;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mS/yD7T+C1jv09uRDGQ8wX8aprHujpG0sx8jk3RQCNM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKUTXWXHjLM0HVtcbKbRvvNA0C2hWNJ04ZkW
 hWnG4yBX0iJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylAAKCRDa6OEJdZac
 5QR5D/9V5W0Ig9KUVyvF0UWq2tJHnjs6Kj3H+orlpNcBgikHsSK1fNJdT+iURepIs5Y+n/3hGJp
 9E5Wh1vOzM2qcc6m6VZpk0uoUK1FRaBcUaIlnxB6lcVNEvzBQ7JKlQMm8VDrMCcEYsl8rpP8CPV
 ilGkbRffI1+bSn6WdbcPXRaz+avfL4P1Wlxq3elnhclLVebj5zHLKQhkzzVsV4edf9ZCjWEvQ9B
 d7bzCSdC6iGsMUxC2P/nmqM50Vfm0VbShPc32TN/spoXMZDplxbqFfu83OYdNVE2HMgrXhJpf9X
 dfVHoPCSS46O17lg99nwzcq+8kuNETTPvJc9VuPV6YXC0AHC6xiFtEWDcYKZNAXY78700W9uXif
 Qa/+mfvEwFMQfUZZBEAdEfU7XZZljmtjYUJEBDssqVkUaU5Q/vnOkqpoGN4jYQZHaeXtVOiz6qV
 0MSbL8LyMXVuKNNGC9g7W/2aFgHLeZTNKlAXRsGIm5l5AbrFCj5W5mdo993g4T7PsvvmmNIHtUD
 5YuBg8LJLakb7cAKRDUPWn6gH4sJSevP6PbDtY7adrVdoWy881RR9wqvkMJKMfidbZR38vVzYFJ
 XUXZnw4WQSVDBMFOs8iLN5WZshb7GclR37kRMv+ho0wFu3hQHDghHTfL+F9rcM3tMqBtrxH4AAj
 cBIx7tm73cXLg8w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

- disable default monitor when HMP is not available
- hide 'readline' from -mon help text
- error out on mux chardev monitor when no HMP
- skip HMP monitor terminal for gdb, return E01 for 'qRcmd' remote
  commands

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260828-qemu-no-hmp-v5-28-9227de146347@redhat.com>
---
 chardev/char.c   | 9 ++++++++-
 gdbstub/system.c | 8 ++++++++
 qemu-options.hx  | 6 +++++-
 system/vl.c      | 2 +-
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/chardev/char.c b/chardev/char.c
index 22e5bae388ad..c6c8133f5c1d 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -804,8 +804,9 @@ static Chardev *qemu_chr_new_from_name(const char *label, const char *filename,
     }
 
     if (qemu_opt_get_bool(opts, "mux", 0)) {
-        const char *chardev_id = qemu_opts_id(opts);
         assert(permit_mux_mon);
+#ifdef CONFIG_HMP
+        const char *chardev_id = qemu_opts_id(opts);
         monitor_new_hmp(NULL, chardev_id, true, &err);
         if (err) {
             error_report_err(err);
@@ -813,6 +814,12 @@ static Chardev *qemu_chr_new_from_name(const char *label, const char *filename,
             chr = NULL;
             goto out;
         }
+#else
+        error_report("HMP monitor is disabled");
+        object_unparent(OBJECT(chr));
+        chr = NULL;
+        goto out;
+#endif
     }
 
 out:
diff --git a/gdbstub/system.c b/gdbstub/system.c
index c77d067ab458..070bc26f416c 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -387,10 +387,14 @@ bool gdbserver_start(const char *device, Error **errp)
 
         qemu_add_vm_change_state_handler(gdb_vm_state_change, NULL);
 
+#ifdef CONFIG_HMP
         /* Initialize a monitor terminal for gdb */
         mon_chr = qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
                                    NULL, NULL, &error_abort);
         monitor_new_hmp(NULL, mon_chr->label, false, &error_abort);
+#else
+        mon_chr = NULL;
+#endif
     } else {
         qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
         mon_chr = gdbserver_system_state.mon_chr;
@@ -524,10 +528,14 @@ void gdb_handle_query_rcmd(GArray *params, void *ctx)
     len = len / 2;
     gdb_hextomem(gdbserver_state.mem_buf, gdb_get_cmd_param(params, 0)->data, len);
     g_byte_array_append(gdbserver_state.mem_buf, &zero, 1);
+#ifdef CONFIG_HMP
     qemu_chr_be_write(gdbserver_system_state.mon_chr,
                       gdbserver_state.mem_buf->data,
                       gdbserver_state.mem_buf->len);
     gdb_put_packet("OK");
+#else
+    gdb_put_packet("E01");
+#endif
 }
 
 /*
diff --git a/qemu-options.hx b/qemu-options.hx
index 562c4c2b0353..d8c7bb20ef23 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4993,7 +4993,11 @@ SRST
 ERST
 
 DEF("mon", HAS_ARG, QEMU_OPTION_mon, \
-    "-mon [chardev=]name[,mode=readline|control][,pretty=on|off]\n", QEMU_ARCH_ALL)
+    "-mon [chardev=]name[,mode="
+#ifdef CONFIG_HMP
+    "readline|"
+#endif
+    "control][,pretty=on|off]\n", QEMU_ARCH_ALL)
 SRST
 ``-mon [chardev=]name[,mode=readline|control][,pretty=on|off]``
     Set up a monitor connected to the chardev ``name``.
diff --git a/system/vl.c b/system/vl.c
index 5ccc19282ba2..eded498fa7e0 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -199,7 +199,7 @@ static int has_defaults = 1;
 static int default_audio = 1;
 static int default_serial = 1;
 static int default_parallel = 1;
-static int default_monitor = 1;
+static int default_monitor = IS_ENABLED(CONFIG_HMP);
 static int default_floppy = 1;
 static int default_cdrom = 1;
 static bool auto_create_sdcard = true;

-- 
2.55.0.543.g5ebe2ebe4ea8


