Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2005CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPorX-0000Eh-O8; Wed, 20 May 2026 17:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPorA-0007xC-Up
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:53:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPor9-00052Q-Dc
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779314014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i6WHRLVUsnP7EUiju8qFp03LMKX3by7HkCwwST9bmis=;
 b=AZu8UQd4SG9pUjuNqCn1jOSs80jBNNeINJ4STPEtPdckda9PgJGeQNCt/ysugS43XAQR1c
 FRgvzj1S9zPfJrLPCqv9HUDDkdVRgBG92tkhlxhYJOEx6czZci/7ty2CnsUFCbEOPewVnu
 ejU2jJakOc2Orl6RlfWmUk7UNjdcAL4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-7Wr-pcJ3Oh62k6_LrCImYg-1; Wed,
 20 May 2026 17:53:33 -0400
X-MC-Unique: 7Wr-pcJ3Oh62k6_LrCImYg-1
X-Mimecast-MFC-AGG-ID: 7Wr-pcJ3Oh62k6_LrCImYg_1779314012
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E5251956096
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:53:32 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 490FF180056E; Wed, 20 May 2026 21:53:30 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:36 +0400
Subject: [PATCH 35/40] system: guard HMP initialization paths with CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-35-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3542;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=HOXNpMG984jVPJUtTcl7zB1C3dRAMxcXx7pr//mD/Cc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyEIczIz5obFoLC+g7eie3H2ex69ZTrmp3FY
 W6YmQCrCFCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4shAAKCRDa6OEJdZac
 5SzYEACnK+/S+FSNLz7HmPI4d+IpU88rCGc5/5jrH8ulgezmqkcBRnxQxS9Rnzr5Jy7k98D8KXC
 9evw0V7zBt5zeqo1VrFjuVWAsyzSFRRk0KQb85kAhuXRkX74/2R0uUhzzNOpDylQNKvHm73xUuU
 wjAv1XG8zjLf+stsyz//Nf9MAhX1ARXhl3Ch3eFwHTJOp2OEzQU+JPiGsGjiZ5gwO5RoNdcZ5lK
 E2covjYDVJm0Vl2qqwUYnHnTimsBsonky2I/fwt4EAMplNwg9NDt2hG2zRpToPlpS/7thBjPa4c
 MVmG01Gl/dyBy+vWiJ5mYtrmZS4uUZJeRSNupUx01+4Z3Gfm0mtrWb6PVDfbtEsJFIm3jAhQJmP
 1DNppck4fa0J2QDt7Ex6SQ7uowdq69Y8wxN6wCa8qr++nNx/rNWKlaLlwyCqaaLjm5uhyQ73nkO
 wXK+xDL3QE5MzpRBomXwRSbs+AwhheLjDhLjMKDu2QSPp3Z2Mo4uwvaX8aA9UVcQoTqWZLMcb35
 ymWVBnlABzoJgBE7qHKWOn6AnN9yFYcDTb++FPQySjE7xY/8LOPKC7gq47YB0EJwK0BxSsJawzH
 X6ymY/KF6XEmOV8jNmYNMu4XqmseC7igu6a7OobuU0fCG80xgnD1qI9QKBHtnH2vIl6ymhA2EfK
 /kO5dKLyUxMiUWQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

- disable default monitor when HMP is not available
- hide 'readline' from -mon help text
- error out on mux chardev monitor when no HMP
- skip HMP monitor terminal for gdb, return E01 for 'qRcmd' remote
  commands

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 chardev/char.c   | 7 +++++++
 gdbstub/system.c | 8 ++++++++
 system/vl.c      | 4 ++++
 qemu-options.hx  | 6 +++++-
 4 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/chardev/char.c b/chardev/char.c
index ca8b37ed8d7..5f2b9fbc4bf 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -805,6 +805,7 @@ static Chardev *qemu_chr_new_from_name(const char *label, const char *filename,
 
     if (qemu_opt_get_bool(opts, "mux", 0)) {
         assert(permit_mux_mon);
+#ifdef CONFIG_HMP
         monitor_init_hmp(chr, true, &err);
         if (err) {
             error_report_err(err);
@@ -812,6 +813,12 @@ static Chardev *qemu_chr_new_from_name(const char *label, const char *filename,
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
index e86c5870abc..0c282c9c491 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -385,10 +385,14 @@ bool gdbserver_start(const char *device, Error **errp)
 
         qemu_add_vm_change_state_handler(gdb_vm_state_change, NULL);
 
+#ifdef CONFIG_HMP
         /* Initialize a monitor terminal for gdb */
         mon_chr = qemu_chardev_new(NULL, TYPE_CHARDEV_GDB,
                                    NULL, NULL, &error_abort);
         monitor_init_hmp(mon_chr, false, &error_abort);
+#else
+        mon_chr = NULL;
+#endif
     } else {
         qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
         mon_chr = gdbserver_system_state.mon_chr;
@@ -529,10 +533,14 @@ void gdb_handle_query_rcmd(GArray *params, void *ctx)
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
diff --git a/system/vl.c b/system/vl.c
index 4797700abd5..f9fa00de07b 100644
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
diff --git a/qemu-options.hx b/qemu-options.hx
index 4c1b32713e0..d788467b83f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4941,7 +4941,11 @@ SRST
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

-- 
2.54.0


