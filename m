Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0CFF45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHRn-0005lE-5m; Fri, 10 Apr 2026 15:23:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHRl-0005kl-H9
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:23:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHRk-00023Z-5M
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775848995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=thtgrXJ52vS/oWAHRG9bnZ6YV3gy9fKuuRW+1nnw0yw=;
 b=LtPwRa2iQorafqWnZlHtHCxRohFJfIvTAmYaWCTF/0Icm2yxtz+v8GOHHkCX+madsHN4jL
 wrFbaMcvJyRzJvqEuUOpveC4GBU7ca55ENb6LRcBlVZ8TB8ufu8y4fsYOIQBBNUw83HARv
 jXJ8JNxaFq3slFYI6teJoN3O9ZFcV8o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-Nq7hokqPO8yqsCO9t17kdQ-1; Fri,
 10 Apr 2026 15:23:14 -0400
X-MC-Unique: Nq7hokqPO8yqsCO9t17kdQ-1
X-Mimecast-MFC-AGG-ID: Nq7hokqPO8yqsCO9t17kdQ_1775848993
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A104718002E7
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:23:13 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F02B3000C16; Fri, 10 Apr 2026 19:23:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:19:05 +0400
Subject: [PATCH v2 43/67] ui/keymaps: introduce kbd_layout_free()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-43-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1687;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=iQh+Fm1P/evY7D8sUcJsQUp91gqqVpdcJuZbaqvuho8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0WM1eIXQjibSxb5CStcoqC4XscLDaHWGLOX
 Vwrb8PwLi6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFgAKCRDa6OEJdZac
 5a3mD/9J/chsJjbNnz6qHmGS7Clf6oiRmlome4WLpxIFMWTdgrCCa/hxgsdg6PTqqNl7TKYispO
 heSzVzM1OK0883VBSAymnB7sR6LbDMN69y7EDopzVYniXEUvLfG7l6K3+3Ino7eVz2ldKwg3Gmy
 +QL8dVFKKj5xHfz7HIGik98Wav/vKs5FKIof1HfjkJ2HgBjiCbsd8TPikbMeHSWTQ2jIxWbPGbg
 Q2VA3kood64IlhndzUqsvh8nNiV/Z7wOWsod55KNp6fwEmQvaecglLDz/+5TqFk2fDRiAdbMJsO
 t+CnFGrTeR2Ah1Wk2sRZUZPIXXTmJDHn2YcITDqwsH0SdzafnsBMrvfwMqcg0F852OXGoZlsBBt
 SGVbdXdmxGfJQcn3B3hPLQBM1hN9WYWiUmpehadweObSAafiKmKee8Wjus0K4K8O3jEuzGcVtvQ
 +6LYqkWm68N90nsKmxG2Vp9803tA0/KfyLQi/ceTiSKw2tZ+8L5jBXR4RK8R+xaHQoars1lVB7C
 c1t9XnT5MfuhVrmHYD0icCqaT9QLfYgyh5bWQGKpI77Bi6Gl6EhA40Q85aXK2DRb+YSoEuy9FjT
 Qld2GyNNPbfI0lJvMExDriN3wviO1sAsqLg5/vS9nkZIOmpVk7Z147zFUN4+tPgjdDiJXSQ0PQ4
 huxHG7OwUhNw8Sw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Enable callers to properly tear down keyboard layouts.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/keymaps.h |  1 +
 ui/keymaps.c | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/ui/keymaps.h b/ui/keymaps.h
index 3d52c0882a1..e8917e56404 100644
--- a/ui/keymaps.h
+++ b/ui/keymaps.h
@@ -54,6 +54,7 @@ typedef struct kbd_layout_t kbd_layout_t;
 
 kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
                                    const char *language, Error **errp);
+void kbd_layout_free(kbd_layout_t *k);
 int keysym2scancode(kbd_layout_t *k, int keysym,
                     QKbdState *kbd, bool down);
 int keycode_is_keypad(kbd_layout_t *k, int keycode);
diff --git a/ui/keymaps.c b/ui/keymaps.c
index 2359dbfe7e6..d1b3f43dc8a 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -178,6 +178,14 @@ out:
     return ret;
 }
 
+void kbd_layout_free(kbd_layout_t *k)
+{
+    if (!k) {
+        return;
+    }
+    g_hash_table_unref(k->hash);
+    g_free(k);
+}
 
 kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
                                    const char *language, Error **errp)
@@ -185,10 +193,9 @@ kbd_layout_t *init_keyboard_layout(const name2keysym_t *table,
     kbd_layout_t *k;
 
     k = g_new0(kbd_layout_t, 1);
-    k->hash = g_hash_table_new(NULL, NULL);
+    k->hash = g_hash_table_new_full(NULL, NULL, NULL, g_free);
     if (parse_keyboard_layout(k, table, language, errp) < 0) {
-        g_hash_table_unref(k->hash);
-        g_free(k);
+        kbd_layout_free(k);
         return NULL;
     }
     return k;

-- 
2.53.0


