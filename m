Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE43C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpiSi-0002Ep-TU; Wed, 05 Mar 2025 01:42:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tpiSc-00024H-GL
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:42:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tpiSa-0001ke-Id
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741156947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=szKeHw66OQkf06T76hhF4jCCjbkVTQWsajG2ol3iiB8=;
 b=ZxYz2xfPJ56rCck6hTUSCTPahR0t5QV9A7uM4CTxPzk6VNIW2ML8UT/iHu3Hto1vXR1/we
 16uCFOXrIwjDA5FVWMk2+Of7VjVwzLcTPRPQynd8vtlsPHKkLFMQTaowt1SGUOs0OeGn8w
 0wWfVddmYAylXit848FNwSxtTXZFxG8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-c_WY4-k-PPeQ1yU7Ua8EuQ-1; Wed,
 05 Mar 2025 01:42:21 -0500
X-MC-Unique: c_WY4-k-PPeQ1yU7Ua8EuQ-1
X-Mimecast-MFC-AGG-ID: c_WY4-k-PPeQ1yU7Ua8EuQ_1741156940
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4FD319560A1; Wed,  5 Mar 2025 06:42:20 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9FBC11944EAA; Wed,  5 Mar 2025 06:42:17 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 5/6] ui/console-vc: implement DCH (delete) and ICH (insert)
 commands
Date: Wed,  5 Mar 2025 10:41:31 +0400
Message-ID: <20250305064132.87441-6-marcandre.lureau@redhat.com>
In-Reply-To: <20250305064132.87441-1-marcandre.lureau@redhat.com>
References: <20250305064132.87441-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Roman Penyaev <r.peniaev@gmail.com>

This patch implements DCH (delete character) and ICH (insert
character) commands.

DCH - Delete Character:
   "As characters are deleted, the remaining characters between the
    cursor and right margin move to the left. Character attributes move
    with the characters. The terminal adds blank spaces with no visual
    character attributes at the right margin. DCH has no effect outside
    the scrolling margins" [1].

ICH - Insert Character:
   "The ICH sequence inserts Pn blank characters with the normal
    character attribute. The cursor remains at the beginning of the
    blank characters. Text between the cursor and right margin moves to
    the right. Characters scrolled past the right margin are lost. ICH
    has no effect outside the scrolling margins" [2].

Without these commands console is barely usable.

[1] https://vt100.net/docs/vt510-rm/DCH.html
[1] https://vt100.net/docs/vt510-rm/ICH.html

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20250226075913.353676-6-r.peniaev@gmail.com>
---
 ui/console-vc.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/ui/console-vc.c b/ui/console-vc.c
index 522adc2806..df1341513d 100644
--- a/ui/console-vc.c
+++ b/ui/console-vc.c
@@ -645,6 +645,88 @@ static void vc_set_cursor(VCChardev *vc, int x, int y)
     s->y = y;
 }
 
+/**
+ * vc_csi_P() - (DCH) deletes one or more characters from the cursor
+ * position to the right. As characters are deleted, the remaining
+ * characters between the cursor and right margin move to the
+ * left. Character attributes move with the characters.
+ */
+static void vc_csi_P(struct VCChardev *vc, unsigned int nr)
+{
+    QemuTextConsole *s = vc->console;
+    TextCell *c1, *c2;
+    unsigned int x1, x2, y;
+    unsigned int end, len;
+
+    if (!nr) {
+        nr = 1;
+    }
+    if (nr > s->width - s->x) {
+        nr = s->width - s->x;
+        if (!nr) {
+            return;
+        }
+    }
+
+    x1 = s->x;
+    x2 = s->x + nr;
+    len = s->width - x2;
+    if (len) {
+        y = (s->y_base + s->y) % s->total_height;
+        c1 = &s->cells[y * s->width + x1];
+        c2 = &s->cells[y * s->width + x2];
+        memmove(c1, c2, len * sizeof(*c1));
+        for (end = x1 + len; x1 < end; x1++) {
+            vc_update_xy(vc, x1, s->y);
+        }
+    }
+    /* Clear the rest */
+    for (; x1 < s->width; x1++) {
+        vc_clear_xy(vc, x1, s->y);
+    }
+}
+
+/**
+ * vc_csi_at() - (ICH) inserts `nr` blank characters with the default
+ * character attribute. The cursor remains at the beginning of the
+ * blank characters. Text between the cursor and right margin moves to
+ * the right. Characters scrolled past the right margin are lost.
+ */
+static void vc_csi_at(struct VCChardev *vc, unsigned int nr)
+{
+    QemuTextConsole *s = vc->console;
+    TextCell *c1, *c2;
+    unsigned int x1, x2, y;
+    unsigned int end, len;
+
+    if (!nr) {
+        nr = 1;
+    }
+    if (nr > s->width - s->x) {
+        nr = s->width - s->x;
+        if (!nr) {
+            return;
+        }
+    }
+
+    x1 = s->x + nr;
+    x2 = s->x;
+    len = s->width - x1;
+    if (len) {
+        y = (s->y_base + s->y) % s->total_height;
+        c1 = &s->cells[y * s->width + x1];
+        c2 = &s->cells[y * s->width + x2];
+        memmove(c1, c2, len * sizeof(*c1));
+        for (end = x1 + len; x1 < end; x1++) {
+            vc_update_xy(vc, x1, s->y);
+        }
+    }
+    /* Insert blanks */
+    for (x1 = s->x; x1 < s->x + nr; x1++) {
+        vc_clear_xy(vc, x1, s->y);
+    }
+}
+
 /**
  * vc_save_cursor() - saves cursor position and character attributes.
  */
@@ -847,6 +929,9 @@ static void vc_putchar(VCChardev *vc, int ch)
                     break;
                 }
                 break;
+            case 'P':
+                vc_csi_P(vc, vc->esc_params[0]);
+                break;
             case 'm':
                 vc_handle_escape(vc);
                 break;
@@ -870,6 +955,9 @@ static void vc_putchar(VCChardev *vc, int ch)
             case 'u':
                 vc_restore_cursor(vc);
                 break;
+            case '@':
+                vc_csi_at(vc, vc->esc_params[0]);
+                break;
             default:
                 trace_console_putchar_unhandled(ch);
                 break;
-- 
2.47.0


