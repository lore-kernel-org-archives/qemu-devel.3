Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00150F45A0C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:28:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHRt-0005oz-CL; Fri, 10 Apr 2026 15:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHRr-0005oO-S9
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHRq-00023s-Cv
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775849001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r5ipliGEfImsYLWRZ8XtsDDq+jSdUO3d2Undg+vDmX0=;
 b=jHuL2ZVl83ihIJg0CNSKtYEf2Ky4OMYQZ53y7fhOB5YUlYGgPmhjesITiAfGZ3kt6vPY8o
 UeCq3WFfL+GrRmqdSqMVRaSBuyQ6hNu3NWr9JCxarQGUSFi8qGgu7JVL/C2kqyU6bW7LjD
 AWnD0DkYiYBo8oZXxVaBbMjftNjqoX4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-EHsQiA3PM2i4BSxHpFdgtg-1; Fri,
 10 Apr 2026 15:23:20 -0400
X-MC-Unique: EHsQiA3PM2i4BSxHpFdgtg-1
X-Mimecast-MFC-AGG-ID: EHsQiA3PM2i4BSxHpFdgtg_1775848999
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99EBF180044D
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:23:19 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 860E63000C16; Fri, 10 Apr 2026 19:23:17 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:19:06 +0400
Subject: [PATCH v2 44/67] ui/vnc: fix vnc_display_init() leak on failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-44-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2626;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=xGMPjiKUOaS83BNgVUACNJ3GgkwfP0afhLEHwJZ2v0Y=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0WEsTxXciBVknFi5uX03YbTlWDL5b/ExK7E
 i0skVNu71OJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFgAKCRDa6OEJdZac
 5eD6EACYernzMfW9MGdD3eHc8MlFZQIwkwxO8EAv366QUGSiZWxNXOFNrYTqjG1DP4sPX4dF1vs
 UU1NTCkoGERCY0lVEL7eIgHTBz7jbBHKEMZc7sJusRkSthCDTDKQbSYwRYOMm86EbnTsgXaWBZ2
 obIpP0MnteIrMTVCFi30Y6zhJIUnUl9DgpcCvG5lWWD8kd7kBEgYgHD7dYahd/j18eQPkhnc8FB
 kkFAoKgdyE+cHGCjbPt0BRCNBjOa7j3A1yf3Tam4OwdmE8hJqIF6RnoJNKN3RC7q+RdNdHuw9XB
 PO2Vd81ixfUh8/ETCptJvwjHr3oY4Moo3llzRWlE2gcqkbh7w1/bJ0CJwtJTlpFHkG1gtxkbqKO
 QIDCvopBxgCPo7A+8e/gnUVC6nNS1PZ5ilAKXKBRcpiVpSowUk0XGjUYoL/k/JkNRCzPpvm5Jy+
 Li53n9TA0OT8HKYMC8dIgMq1wxrdOZwHy0d0WtXndkVROg6gU7+slx75+5iqLsz2z1evrnTNscb
 bHQgmMk+C5KCfluZr0pfL1SWSldxPp0h80VrTXwU+DaCf1w4Dt6XU7IO06kvXZQ3J5cb6378ZXM
 s61XkWHX1p5dGUhuMZpbIxxUTYXkelXlZJGElyedHfp34MhwyyZbBOVUK3yD3JoQMJjtuc4pmwE
 lIpqfOH9oF3jabw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Do not add the display state to the vnc list, if the initialization
failed. Add vnc_display_free(), to free the display state and associated
data in such case. The function is meant to be public and reused in the
following changes.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 522d4d8fb88..512e11d687e 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3422,6 +3422,8 @@ static void vmstate_change_handler(void *opaque, bool running, RunState state)
     update_displaychangelistener(&vd->dcl, VNC_REFRESH_INTERVAL_BASE);
 }
 
+static void vnc_display_free(VncDisplay *vd);
+
 void vnc_display_init(const char *id, Error **errp)
 {
     VncDisplay *vd;
@@ -3431,8 +3433,9 @@ void vnc_display_init(const char *id, Error **errp)
     }
     vd = g_malloc0(sizeof(*vd));
 
+    qemu_mutex_init(&vd->mutex);
     vd->id = g_strdup(id);
-    QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);
+    vd->dcl.ops = &dcl_ops;
 
     QTAILQ_INIT(&vd->clients);
     vd->expires = TIME_MAX;
@@ -3446,22 +3449,22 @@ void vnc_display_init(const char *id, Error **errp)
     }
 
     if (!vd->kbd_layout) {
+        vnc_display_free(vd);
         return;
     }
 
     vd->share_policy = VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
     vd->connections_limit = 32;
 
-    qemu_mutex_init(&vd->mutex);
     vnc_start_worker_thread();
 
-    vd->dcl.ops = &dcl_ops;
     register_displaychangelistener(&vd->dcl);
     vd->kbd = qkbd_state_init(vd->dcl.con);
     vd->vmstate_handler_entry = qemu_add_vm_change_state_handler(
         &vmstate_change_handler, vd);
-}
 
+    QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);
+}
 
 static void vnc_display_close(VncDisplay *vd)
 {
@@ -3505,6 +3508,28 @@ static void vnc_display_close(VncDisplay *vd)
 #endif
 }
 
+static void vnc_display_free(VncDisplay *vd)
+{
+    if (!vd) {
+        return;
+    }
+
+    assert(QTAILQ_EMPTY(&vd->clients));
+
+    vnc_display_close(vd);
+    unregister_displaychangelistener(&vd->dcl);
+    qkbd_state_free(vd->kbd);
+    qemu_del_vm_change_state_handler(vd->vmstate_handler_entry);
+    kbd_layout_free(vd->kbd_layout);
+    qemu_mutex_destroy(&vd->mutex);
+    if (QTAILQ_IN_USE(vd, next)) {
+        QTAILQ_REMOVE(&vnc_displays, vd, next);
+    }
+    g_free(vd->id);
+    g_free(vd);
+}
+
+
 int vnc_display_password(const char *id, const char *password, Error **errp)
 {
     VncDisplay *vd = vnc_display_find(id);

-- 
2.53.0


