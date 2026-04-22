Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A726F9B60B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFV4V-0002fv-5H; Wed, 22 Apr 2026 06:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV4J-0000q7-No
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:44:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wFV4G-0003J6-DE
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776854667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r944Zh3o2C3dWrI8AujmdLr3ymk2rvx5/gP9TZ3t87g=;
 b=HcKTnB7mLNPQf8uPvdcCLHKx5n8sdJn6qLIXvrbI/osaYRdzB72fLt0uONMR8p3Jo5bagA
 rnQgPMl2s8H48oiOPGlXGW4a3T7+zvfxolYVHqn3hlLqZBLtXdr4JZ1rFsGTGeb40BquwQ
 mra5k/ThPbFfqE4VW1QEj5RQM9/nLyc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-BHgU2XTXMPWbFgiafmZ1uA-1; Wed,
 22 Apr 2026 06:44:26 -0400
X-MC-Unique: BHgU2XTXMPWbFgiafmZ1uA-1
X-Mimecast-MFC-AGG-ID: BHgU2XTXMPWbFgiafmZ1uA_1776854664
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46DBE1800652; Wed, 22 Apr 2026 10:44:24 +0000 (UTC)
Received: from localhost (unknown [10.44.22.21])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D526B180047F; Wed, 22 Apr 2026 10:44:22 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 35/40] ui/keymaps: introduce kbd_layout_free()
Date: Wed, 22 Apr 2026 14:40:36 +0400
Message-ID: <20260422104042.3936506-36-marcandre.lureau@redhat.com>
In-Reply-To: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
References: <20260422104042.3936506-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Enable callers to properly tear down keyboard layouts.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


