Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED180C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywYr-0006n9-ER; Tue, 25 Aug 2026 15:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywYp-0006it-PW
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:11:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywYo-0004Ie-5y
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yzt3oQVtBjQ6TrWLxwLxcXzi8FaWAeSdiEMxpCf792k=;
 b=JLxi+Y6xIVHlWCDQ+Bnf/yf+uX93s/+ADk+RJdbyIQBwaQuyu3p+FIkeXBc0oXWwA0K67m
 aXwTSvmKtS3QTtwhS/4ibh1BD6ugqz7ioWW29bS3XA8cmKfdaS0DfUd4rSt5va3QTOiXlU
 HFeD3iB/nPQZYx3XQ/bRvMX+nxcoRas=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-fBnZphbrNqyG1Tao6AdBqA-1; Tue,
 25 Aug 2026 15:11:44 -0400
X-MC-Unique: fBnZphbrNqyG1Tao6AdBqA-1
X-Mimecast-MFC-AGG-ID: fBnZphbrNqyG1Tao6AdBqA_1787685103
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9180D195FCDD; Tue, 25 Aug 2026 19:11:43 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA80218005B4; Tue, 25 Aug 2026 19:11:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:34 +0400
Subject: [PATCH v4 27/49] system: guard HMP initialization paths with
 CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-27-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3769;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=NucbtIkSZZwE1hWWqwuXD6cB2sdzfg9xAMRVv7YI8qM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiHmPXkF3RVXsr4PZ/1i7esYGY507DN3TpM9
 6qJ44NhXGqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3ohwAKCRDa6OEJdZac
 5aOTD/4uoq/bC8vlV8lhYO8qHL8TGSuCRVT3DUglYBajMJGg3r9gGa8Ghe7/TTO2ReSiVS+4RTF
 nDR135Zl5cF0ExSxQintwYuGjEs6SWAaOD6ZFKxzaC6jiXnys1XTuyoIlnP7td2+15s9lOfaV48
 8xj5LerhXbzwi/RfL4PlElrGV+4wsqa4KhHox4SRlB6DOlzuRUW8BSCCKFYweK0hIaxrCyQRROy
 85OOsHHXYiP7FGjnSpS2KYiFRt3+7jBuUrL4ixnFe55lkcdL0RrtIi6youQsKu7f91NanszLO6S
 iWpiIOKyckEb/zLtrMbEnMucMS53xDN46OwYinmVclCws9WXXvhf4C6IpBmv5/Kqfo23S4t0VGT
 d1ZQSTwUQCyuCCWXSJ8BTOzXOADZXxQYFM94lcapYopO3oEo9JuZnaV0IKJuH9L9Xi0+sYJwlGi
 R0f17bIv44dZghvFt82VdO6jbi5yK4a+o8z3x+Hzqk+Nl477ilT0OYe6d4Eeg7pn/LKNz5gCOye
 0YC40E9ILL/uFXFNyENkLkZweRKI4ZKbm1M9UB5jKoZwuBpFNtD0U1a9UvJXhh8ugzD+YMm/ucB
 mbeUJPnvDHqM9losBsWg/RcEo7Zg3kskbwX+7+YrKtHuJoHlgGRb3xyypjBZl8QrClUhYa84m2h
 orjZmgSIojMbksg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

- disable default monitor when HMP is not available
- hide 'readline' from -mon help text
- error out on mux chardev monitor when no HMP
- skip HMP monitor terminal for gdb, return E01 for 'qRcmd' remote
  commands

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/char.c   | 9 ++++++++-
 gdbstub/system.c | 8 ++++++++
 qemu-options.hx  | 6 +++++-
 system/vl.c      | 4 ++++
 4 files changed, 25 insertions(+), 2 deletions(-)

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
index 34970fffc94b..680344162efb 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4985,7 +4985,11 @@ SRST
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
index 5ccc19282ba2..760cf6e7265a 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -199,7 +199,11 @@ static int has_defaults = 1;
 static int default_audio = 1;
 static int default_serial = 1;
 static int default_parallel = 1;
+#ifdef CONFIG_HMP
 static int default_monitor = 1;
+#else
+static int default_monitor; /* false */
+#endif
 static int default_floppy = 1;
 static int default_cdrom = 1;
 static bool auto_create_sdcard = true;

-- 
2.55.0.543.g5ebe2ebe4ea8


