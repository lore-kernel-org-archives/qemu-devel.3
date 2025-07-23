Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391C8C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 13:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueZOJ-0006bj-JB; Wed, 23 Jul 2025 09:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ueZJY-00044g-Nw
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 09:15:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ueZJS-0002Gi-Vk
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 09:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753276509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=QGoDYhwH7grYDUZs7DTRUsOWhob0TnbUWWOMhLUtrYM=;
 b=H8wz1+RQ6sgxzG1uTnxek4FofubZnwtmq+OZiP+VMkBXMo720NnoX7sJaJEZ6PKvPZ4pHz
 7MgtuHJpTaYEdC9yniUARCOAqCYT4CVisYrTN6DUF97f1v+o/cMQehQFRW3u1tEtnZhxp3
 H3kKlwXmPbzIbNCKXgqhAersgsfLrLc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-jcl-T2PwPn-imj9QKD7mjA-1; Wed,
 23 Jul 2025 09:15:08 -0400
X-MC-Unique: jcl-T2PwPn-imj9QKD7mjA-1
X-Mimecast-MFC-AGG-ID: jcl-T2PwPn-imj9QKD7mjA_1753276507
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AF551944D01
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 13:15:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.2])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 135C119560A0
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 13:15:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 582E321E6A27; Wed, 23 Jul 2025 15:15:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	kraxel@redhat.com
Subject: [PATCH] ui/keymaps: Avoid trace crash and improve error messages
Date: Wed, 23 Jul 2025 15:15:04 +0200
Message-ID: <20250723131504.1482657-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

parse_keyboard_layout() passes a possibly null @filename to
trace_keymap_parse().  Trace backend log then formats it with %s,
which crashes on some systems.

Fix by moving the null check before the trace_keymap_parse().

While there, improve the error messages a bit.

Fixes: d3b787fa7dde (keymaps: add tracing)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 ui/keymaps.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/ui/keymaps.c b/ui/keymaps.c
index 6ceaa97085..2359dbfe7e 100644
--- a/ui/keymaps.c
+++ b/ui/keymaps.c
@@ -86,19 +86,25 @@ static int parse_keyboard_layout(kbd_layout_t *k,
                                  const name2keysym_t *table,
                                  const char *language, Error **errp)
 {
+    g_autofree char *filename = NULL;
     int ret;
     FILE *f;
-    char * filename;
     char line[1024];
     char keyname[64];
     int len;
 
     filename = qemu_find_file(QEMU_FILE_TYPE_KEYMAP, language);
+    if (!filename) {
+        error_setg(errp, "could not find keymap file for language '%s'",
+                   language);
+        return -1;
+    }
+
     trace_keymap_parse(filename);
-    f = filename ? fopen(filename, "r") : NULL;
-    g_free(filename);
+
+    f = fopen(filename, "r");
     if (!f) {
-        error_setg(errp, "could not read keymap file: '%s'", language);
+        error_setg_file_open(errp, errno, filename);
         return -1;
     }
 
-- 
2.49.0


