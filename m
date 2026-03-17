Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F156F3381D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QBB-00084W-Tj; Tue, 17 Mar 2026 04:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QAe-0007BY-Qx
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:53:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QAc-0003AL-SV
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:53:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dc1IVpsqrJifoQWhJGaW7gKSSJjmAOhBW8BJtA1dpsY=;
 b=NJ9yERYUeq/0ZyQijVcgxnQxipy5rc1TiWkiMuoIirJaeBongymxUfRGjlNbmYu4kh7Hr7
 B1YhMGEEEF5BM5IC8euj5C4WxsR9bsIcHvJY+fmZaADx3Z/MoNSFkibr3gEmBzqmbeicKl
 dVCkgnJmY50HQvPFxVppDd/STcbfZP4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-3yLBCL3pPU6yv5UPrdSTag-1; Tue,
 17 Mar 2026 04:52:52 -0400
X-MC-Unique: 3yLBCL3pPU6yv5UPrdSTag-1
X-Mimecast-MFC-AGG-ID: 3yLBCL3pPU6yv5UPrdSTag_1773737571
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7C7619560BB
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:52:51 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE8BF3000223
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:52:50 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:37 +0400
Subject: [PATCH 23/60] ui/console-vc: console_scroll() -> vt100_scroll()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-23-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2751;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=p3/XhfZKxdc3Os8Qglmy6MKxOK7bn/ETt0Qao+PV3qU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXbKVIN5Akuec++M3Vt7inAzF6aURp3zE3pv
 sPwYzD78VOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV2wAKCRDa6OEJdZac
 5cpsD/4j2V+x9z2gAOU7v8wOPe8nZFVcTp8z9L3Jh0Rj60wmPUdL2JlWGCdbhjfvvkiN4lhRTiR
 kdMsGs3ZQktpcLisKxooLaf2ZQmskuTJH/PJT0lpiPOPxMz77KNwQ2bIo6J9hJb0dnXVbgkY2Ft
 LreBLIizlv8bo/oSYfmHEYP7t5K4VZ8btPZ81Pih9WyLD6KXotzKuY7PXReM7OPyIS/bC6/7JW+
 iqiAmIv6Lqj2wov8KOb/yrJ/JYab9NEfcUidOCzk2klOUcijexGyNvZlZQVIkhIDkfz/rxpi08n
 JcQaejp+9eKRd+WfOtbGqX/0JEORvg0zPIl8hNs3Z5jSosokCaCSTt1M+bizD1j8KOROS03FTCE
 7pB9/MVYU0aXYuUlkT4pTlv7KSIs6k1fa11YlqevZ8hEcvvBJdjrVUYnfmPyDQxd55rZyX9CgHq
 zg7swNwIIppGqAYgAw6Kuq2p4hbecU5WUGQgTrZj6/5I9VQ6k0uCxlyZ0A1be+JLV7nxmrFWc0d
 FQiAq4Uij/g2qApdq/fclRjiUeRWJ43x7xLgIctDuvzdRlyf/4aZ7Ea/MkeP3hgZbgocguAuvYT
 yJkWiooFeQht2Zc8ukUOsUF7Ro2bMQfqXWs+En8dhEFXxmXh+LBee9D+wPXGRyeSRK0YncOXqwh
 QUWq9zujQkFIiNQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

This decouples glyph rendering from the console object, continuing the
QemuVT100 abstraction introduced in the previous commits.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/console-vc.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 22d1128ee6b..a45f4bc875b 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -269,33 +269,33 @@ static void vt100_refresh(QemuVT100 *vt)
     vt100_image_update(vt, 0, 0, w, h);
 }
 
-static void console_scroll(QemuTextConsole *s, int ydelta)
+static void vt100_scroll(QemuVT100 *vt, int ydelta)
 {
     int i, y1;
 
     if (ydelta > 0) {
         for(i = 0; i < ydelta; i++) {
-            if (s->vt.y_displayed == s->vt.y_base)
+            if (vt->y_displayed == vt->y_base)
                 break;
-            if (++s->vt.y_displayed == s->vt.total_height)
-                s->vt.y_displayed = 0;
+            if (++vt->y_displayed == vt->total_height)
+                vt->y_displayed = 0;
         }
     } else {
         ydelta = -ydelta;
-        i = s->vt.backscroll_height;
-        if (i > s->vt.total_height - s->vt.height)
-            i = s->vt.total_height - s->vt.height;
-        y1 = s->vt.y_base - i;
+        i = vt->backscroll_height;
+        if (i > vt->total_height - vt->height)
+            i = vt->total_height - vt->height;
+        y1 = vt->y_base - i;
         if (y1 < 0)
-            y1 += s->vt.total_height;
+            y1 += vt->total_height;
         for(i = 0; i < ydelta; i++) {
-            if (s->vt.y_displayed == y1)
+            if (vt->y_displayed == y1)
                 break;
-            if (--s->vt.y_displayed < 0)
-                s->vt.y_displayed = s->vt.total_height - 1;
+            if (--vt->y_displayed < 0)
+                vt->y_displayed = vt->total_height - 1;
         }
     }
-    vt100_refresh(&s->vt);
+    vt100_refresh(vt);
 }
 
 static void kbd_send_chars(QemuTextConsole *s)
@@ -324,16 +324,16 @@ void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
 
     switch(keysym) {
     case QEMU_KEY_CTRL_UP:
-        console_scroll(s, -1);
+        vt100_scroll(&s->vt, -1);
         break;
     case QEMU_KEY_CTRL_DOWN:
-        console_scroll(s, 1);
+        vt100_scroll(&s->vt, 1);
         break;
     case QEMU_KEY_CTRL_PAGEUP:
-        console_scroll(s, -10);
+        vt100_scroll(&s->vt, -10);
         break;
     case QEMU_KEY_CTRL_PAGEDOWN:
-        console_scroll(s, 10);
+        vt100_scroll(&s->vt, 10);
         break;
     default:
         /* convert the QEMU keysym to VT100 key string */

-- 
2.53.0


