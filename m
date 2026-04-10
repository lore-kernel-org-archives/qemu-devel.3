Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760B8F45A0D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHSA-0006Jr-4e; Fri, 10 Apr 2026 15:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHS8-0006DW-VJ
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:23:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHS7-00028E-Ct
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775849018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AaYgLyQHGS1El8i7WXeapVRA3A7DlDOzohvzbOUY51A=;
 b=KW/SNFyo+e7Lbtn0DQvL1YRow9cvYDQ+lK4OEYJBfTLn54k1QE1cTdhFyp+Xe6VsCZygyJ
 uZxR9ZOomEipraVzg6mOkG7xz+zG0hFovVkrEn77UoPZExO2vQ1iFwqMXZbxEpzCzXldUJ
 LDFLuFPBD3T4VQsIUK+E0/KkqbVYiMU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-xH-Xz9-2P1-k8t1AG7xHZg-1; Fri,
 10 Apr 2026 15:23:37 -0400
X-MC-Unique: xH-Xz9-2P1-k8t1AG7xHZg-1
X-Mimecast-MFC-AGG-ID: xH-Xz9-2P1-k8t1AG7xHZg_1775849016
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C086F195608F
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:23:36 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A4C7D19560AB; Fri, 10 Apr 2026 19:23:35 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:19:09 +0400
Subject: [PATCH v2 47/67] ui/vnc: vnc_display_init() and vnc_display_open()
 return bool
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-47-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3270;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=hnN7DWHiJasepbkzKlsPFEQRnAxLd59i6FLsvNgF744=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0W7noNxUG+0zIoAuAo5Ca5DgUU87qDif7UG
 ku+GZ4sRH2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFgAKCRDa6OEJdZac
 5XUwD/oCVQ0iGXLZecRKNKPkxwCrNPiUSDJEdHw6FybDX0rO/M20AaAtlFQ230o+bmRJRTYNQRY
 8rC2gtNVwsbwLgWJqQQOEKiVAfH1zcPt5Et6fIQ23WU0Ns6yJ26EomwTJa5RfpGkLt1GCYICTmG
 AeBj3FbHTtRhlChdTrUwYHoAqiSh0qV2SDhGB+GZDRSGr1kGIFr/+CtwEsIy6hKze1bxUbxvmyi
 thqmg4D6a9GXQvgFUB7xe+UiE/0/7CjXnvR4VKy+dSlSVs4DdEmIHdQ+AC8+U8wzA8zLrj5jSHy
 ySEq8FXUsrHf5TXVI5A3g8ZmsjSr6QX8uOhWnzKApzXKsBZ5PTSc21pyZeh1iUDRvAeP9unKNaV
 bKrAkrVqiOtbWz9HatihMloX/V3CW7IKfn3RTn/+ebCmepKDhQS1SyYUpvEjWkNrKokyoexANVa
 alEzA2DIMnAL2HQYqWmBqYnq9IbR0rsqrPIogrNCx2AywSE2F/xXg7tBnn2v9dRdXtEqVS2L3dP
 drQcSojjBCYTThrPM89NZrOArdfV55azqUIPnVD2n8ISvK7gultL4HXnKpQkSMddElQY+skoQ6w
 sbyIviMNLt54kgaueobb3lre06f2DROG/c3rJsIutC03IyMMWNa69n4Or4l7lLo4QKOd5ytUqyZ
 K0BWT/cv0fEWLvA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Use the QEMU-style error pattern returning "true" on success.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h |  4 ++--
 ui/vnc.c             | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 75cd48ed7ad..f9b4665cb90 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -448,8 +448,8 @@ const char *qemu_display_get_vc(DisplayOptions *opts);
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
index 4e5a9ee0341..0775417c418 100644
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
@@ -4074,7 +4075,7 @@ bool vnc_display_update(DisplayUpdateOptionsVNC *arg, Error **errp)
     return true;
 }
 
-void vnc_display_open(const char *id, Error **errp)
+bool vnc_display_open(const char *id, Error **errp)
 {
     VncDisplay *vd = vnc_display_find(id);
     QemuOpts *opts = qemu_opts_find(&qemu_vnc_opts, id);
@@ -4277,7 +4278,7 @@ void vnc_display_open(const char *id, Error **errp)
     qkbd_state_set_delay(vd->kbd, key_delay_ms);
 
     if (saddr_list == NULL) {
-        return;
+        return true;
     }
 
     if (reverse) {
@@ -4295,10 +4296,11 @@ void vnc_display_open(const char *id, Error **errp)
     }
 
     /* Success */
-    return;
+    return true;
 
 fail:
     vnc_display_close(vd);
+    return false;
 }
 
 void vnc_display_add_client(const char *id, int csock, bool skipauth)
@@ -4354,12 +4356,10 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
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
2.53.0


