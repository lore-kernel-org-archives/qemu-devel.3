Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D4BCD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxXf-0000xH-Pn; Tue, 09 Jun 2026 10:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxXe-0000wn-1B
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxXc-0006gL-5H
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781015695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2RgpOrSIaQ2GujtwJ46SCAP+lsYwP7kQWmaAHhskacc=;
 b=NQuXWhmrPqT5Z1p/8oHyeVbHaYtDY7zxbP938FmK58bcYf2k6ojluHRBpZQbMsJgEe8SVU
 +wHl4W1uxMyg/rh9sV72mY91b3k647COIQGHYBTw189bau/rv5hT5WVQWFqdGDclI6oz6R
 SwTHbObvROUpUvVWJ2Kbp0PBI39JeXQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-p0EqGKzePOeExApkm5JoKQ-1; Tue,
 09 Jun 2026 10:34:53 -0400
X-MC-Unique: p0EqGKzePOeExApkm5JoKQ-1
X-Mimecast-MFC-AGG-ID: p0EqGKzePOeExApkm5JoKQ_1781015693
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99890184EB40; Tue,  9 Jun 2026 14:34:52 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 577E13008B39; Tue,  9 Jun 2026 14:34:50 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 09 Jun 2026 18:34:21 +0400
Subject: [PATCH 02/17] ui/hmp: move index_from_key() where it is used
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-ui-input-v1-2-42615deb818e@redhat.com>
References: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
In-Reply-To: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2217;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=OeOwBzwyTq5PuLrEDwVvJdQKifbzG3kPTNXrjSBdoTE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKCR3vBtqyY8nmMAtLJwPb5uucUVOU0pjczg2m
 zcRg68C7PWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaigkdwAKCRDa6OEJdZac
 5djVD/sF6X9+Z5pxMaShW8qwHFkvdDKdGpnuDDuU925AtZtVLlsQsrn/9nGtSflBPypIM3+OQ7Z
 QLMnO9yoGYzFHG5+G9wPX6959+pu4FCVXs9N1Q8Eo/uwBcuMooMUnu5ohIOZXed6RPXtnzVXFfx
 qXSskPCKlIIRlUTH9r3PpWpBFcgKc5VZNX++mr2Mj/NEDSftHbi3XbHEfZyJkmLp9gDYUiCPLiF
 SyLcochnP6xAbrYINeTtWHNUFjBGwUQGcT1mw+xcVApEtindXoVRkOj1ulINDMvXEG90/Z98sPJ
 DF0g3dqSuiFmAcv3sQAuD8ZYlPddTWOiPPf4jEtUYy+HEFi5qX1lpJ9TavlZ5/4nZd53NtrOTKa
 61eriFVHlOTnIdkZYfptsewgTdASj0PbsrM2U+kgCop+yObPN4QPnivl8YuPQhXiNSlx0jH6jsg
 OSZdUA58dJcrCu1qH2DLH/xf0J1M7/J/30vs2v+WtfehAsro2DpizA9vYJ0jD5PTRF01GGs8F/p
 5zE2UVysnjsg8vJeVo4ZQ1nXTcoYJ41M/B2lbZZ6M7UB+KUhO7VKASIKFaSS1Gnc7NgA3yyYD71
 fsljS8fp0oXBsLQ6bZCzDvin8mPHwd9pnlZWy887qdRoYFLOTPBDKnlRqKxdTDCQk5rDDlzGPBO
 t/lYlAJ80YzISZA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h |  3 ---
 ui/input-legacy.c    | 15 ---------------
 ui/ui-hmp-cmds.c     | 15 +++++++++++++++
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index a31c5a4995c..3cb78989cd2 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -450,9 +450,6 @@ bool vnc_display_reload_certs(const char *id,  Error **errp);
 bool vnc_display_update(DisplayUpdateOptionsVNC *arg, Error **errp);
 void vnc_cleanup(void);
 
-/* input.c */
-int index_from_key(const char *key, size_t key_length);
-
 #ifdef CONFIG_LINUX
 /* udmabuf.c */
 int udmabuf_fd(void);
diff --git a/ui/input-legacy.c b/ui/input-legacy.c
index 193c9ae2ef9..71b17a3cfc7 100644
--- a/ui/input-legacy.c
+++ b/ui/input-legacy.c
@@ -56,21 +56,6 @@ struct QEMUPutLEDEntry {
 static QTAILQ_HEAD(, QEMUPutLEDEntry) led_handlers =
     QTAILQ_HEAD_INITIALIZER(led_handlers);
 
-int index_from_key(const char *key, size_t key_length)
-{
-    int i;
-
-    for (i = 0; i < Q_KEY_CODE__MAX; i++) {
-        if (!strncmp(key, QKeyCode_str(i), key_length) &&
-            !QKeyCode_str(i)[key_length]) {
-            break;
-        }
-    }
-
-    /* Return Q_KEY_CODE__MAX if the key is invalid */
-    return i;
-}
-
 void qmp_send_key(KeyValueList *keys, bool has_hold_time, int64_t hold_time,
                   Error **errp)
 {
diff --git a/ui/ui-hmp-cmds.c b/ui/ui-hmp-cmds.c
index 1e9bc77bd80..76f5181de43 100644
--- a/ui/ui-hmp-cmds.c
+++ b/ui/ui-hmp-cmds.c
@@ -350,6 +350,21 @@ void hmp_change_vnc(Monitor *mon, const char *device, const char *target,
 }
 #endif
 
+static int index_from_key(const char *key, size_t key_length)
+{
+    int i;
+
+    for (i = 0; i < Q_KEY_CODE__MAX; i++) {
+        if (!strncmp(key, QKeyCode_str(i), key_length) &&
+            !QKeyCode_str(i)[key_length]) {
+            break;
+        }
+    }
+
+    /* Return Q_KEY_CODE__MAX if the key is invalid */
+    return i;
+}
+
 void hmp_sendkey(Monitor *mon, const QDict *qdict)
 {
     const char *keys = qdict_get_str(qdict, "keys");

-- 
2.54.0


