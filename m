Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D73FFF8873
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 21:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIC6f-0007Zo-Ak; Wed, 29 Apr 2026 17:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC5R-0006Jo-5R
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:04:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wIC5P-0003UQ-Gh
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 17:04:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777496685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9xsmB+cqBRqaS9skMbjA7XRg5bZVpVFUgMg50GnuroM=;
 b=b8WAZlFscC06ruO5zPzyWVhWGI9JqXbWQLET9KDEFXkBM6b6ZuTW/ULXrpqAISLxITSFR+
 Jq+w6gr8vEgGrVlVaiN5xjZ3KzUOmTkYEm8A3sDE9u09FmYerVXSDYdukTunbXVJyHrxCb
 Aoer9zAPI28tG/7TIFTmKxJCbQz6cD4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-RWvMftFHO42LrwLjx79PZw-1; Wed,
 29 Apr 2026 17:04:44 -0400
X-MC-Unique: RWvMftFHO42LrwLjx79PZw-1
X-Mimecast-MFC-AGG-ID: RWvMftFHO42LrwLjx79PZw_1777496682
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A1331956050; Wed, 29 Apr 2026 21:04:42 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BCB27195608E; Wed, 29 Apr 2026 21:04:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 30 Apr 2026 01:02:48 +0400
Subject: [PATCH v3 15/26] ui/vnc: vnc_display_init() and vnc_display_open()
 return bool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-qemu-vnc-v3-15-be96757428d0@redhat.com>
References: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
In-Reply-To: <20260430-qemu-vnc-v3-0-be96757428d0@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3384;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=1BdF+ZE2ZaZ7NQ/12KK1Q24noSi6tIoILVGECxV0ikY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp8nIMKXhnRdo6HWaNS9G8J/dKMbJdtptmf9uYN
 0VTyhqYG06JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafJyDAAKCRDa6OEJdZac
 5XpdEACyKd4WFtudHsU368hBdh6Ab0Ojh6moGqf+tdEGlLib0ez3H7Z5t0WQVqSwmszgUkeQ0wu
 oLqUGbdkB+4oixkVw1r6PrlsNtGxdZnBrycrF2jmcB6DGpe2WtpeGLkpSe1c5L+vunpu5lTryRU
 hjHB4QH+iP3xJ9FpN1MxNdXVaRSB1a+6cRlpf66Gm9OhRATmru5WkxXmzGjd1/krqBFT8NoDnn0
 OY7s1H52kLK2ChMcKCotM1JMg+CO0SpmsS9US1vBBfzUgxAoE+Yuo8N6AYoPSTKdAaZUFAt8PT7
 VD59+9HKrYd3acB0Zrib3oZbQHZx9KOHUctWK9qFuDj5chIS0nIIcA8sl53Q8rmbivzW4iUWKAM
 xqwWVMJq1zopsif4YkET/LyzoC/5wOE1DNmAASSEHasYHUrbqy6gAXHFQah1n8P1smPPAhKNnF+
 FYi2xyMnZYOey0CRv/WSLYonoA8Z1LpPHP34BUWaGDe6nzFZs8Ad5nHeWqN3qSTgi7fW2r+9BIL
 /GRPqoX7+g/Y6q94mD9ZL1oJsfxMY9xKemDvVbA+csBO0bL7mJ2XIljdb/PUKVd5IRj3CJHS/Gk
 hWatWV0o51PFfINn1dQVI/iD/h5rj89JdxTrvZ5FLbMEEwlu5N7rVK+Q4xeJ0rxrtojAqyZ1eCn
 iIxaNRoOdmyN1Gw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Use the QEMU-style error pattern returning "true" on success.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h |  4 ++--
 ui/vnc.c             | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 2bf768ed482..7224b8142f3 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -438,8 +438,8 @@ const char *qemu_display_get_vc(DisplayOptions *opts);
 void qemu_display_help(void);
 
 /* vnc.c */
-void vnc_display_init(const char *id, Error **errp);
-void vnc_display_open(const char *id, Error **errp);
+bool vnc_display_init(const char *id, Error **errp);
+bool vnc_display_open(const char *id, Error **errp);
 void vnc_display_add_client(const char *id, int csock, bool skipauth);
 int vnc_display_password(const char *id, const char *password, Error **errp);
 int vnc_display_pw_expire(const char *id, time_t expires);
diff --git a/ui/vnc.c b/ui/vnc.c
index 3a908670ab9..067f534cf08 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3425,12 +3425,12 @@ static void vmstate_change_handler(void *opaque, bool running, RunState state)
 
 static void vnc_display_free(VncDisplay *vd);
 
-void vnc_display_init(const char *id, Error **errp)
+bool vnc_display_init(const char *id, Error **errp)
 {
     VncDisplay *vd;
 
     if (vnc_display_find(id) != NULL) {
-        return;
+        return true;
     }
     vd = g_malloc0(sizeof(*vd));
 
@@ -3451,7 +3451,7 @@ void vnc_display_init(const char *id, Error **errp)
 
     if (!vd->kbd_layout) {
         vnc_display_free(vd);
-        return;
+        return false;
     }
 
     vd->share_policy = VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
@@ -3465,6 +3465,7 @@ void vnc_display_init(const char *id, Error **errp)
         &vmstate_change_handler, vd);
 
     QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);
+    return true;
 }
 
 static void vnc_display_close(VncDisplay *vd)
@@ -4070,7 +4071,7 @@ bool vnc_display_update(DisplayUpdateOptionsVNC *arg, Error **errp)
     return true;
 }
 
-void vnc_display_open(const char *id, Error **errp)
+bool vnc_display_open(const char *id, Error **errp)
 {
     VncDisplay *vd = vnc_display_find(id);
     QemuOpts *opts = qemu_opts_find(&qemu_vnc_opts, id);
@@ -4273,7 +4274,7 @@ void vnc_display_open(const char *id, Error **errp)
     qkbd_state_set_delay(vd->kbd, key_delay_ms);
 
     if (saddr_list == NULL) {
-        return;
+        return true;
     }
 
     if (reverse) {
@@ -4291,10 +4292,11 @@ void vnc_display_open(const char *id, Error **errp)
     }
 
     /* Success */
-    return;
+    return true;
 
 fail:
     vnc_display_close(vd);
+    return false;
 }
 
 void vnc_display_add_client(const char *id, int csock, bool skipauth)
@@ -4350,12 +4352,10 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
         id = vnc_auto_assign_id(opts);
     }
 
-    vnc_display_init(id, errp);
-    if (*errp) {
+    if (!vnc_display_init(id, errp)) {
         return -1;
     }
-    vnc_display_open(id, errp);
-    if (*errp) {
+    if (!vnc_display_open(id, errp)) {
         return -1;
     }
     return 0;

-- 
2.54.0


