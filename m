Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D42CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 12:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut3LA-0006AD-Nj; Mon, 01 Sep 2025 08:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ut3L6-00064q-Nh
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:08:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ut3Ku-0005eo-Tt
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:08:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756728509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=os84wrbCKE8S3rpPjh53xN3q5M0Jv9m6MCnVR8nrjUA=;
 b=NFqZ2dZscpUhtPvPPaRUG25kLYfFguSqsJKzgCYWgMZXfkZQJUEJh3MD8SO3cOodgUixbl
 4Kd23jt8rGee12k8eqr8pLp2C9cqFiePsoJIfJeqRvUqm9MOuwDXtwmjIH1gx3jagYWNKa
 VURGOTWKJ3s4HP/WzClhsPAi4ypdZa8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-EzAoKK4hPXaNdnhg7ceK0g-1; Mon,
 01 Sep 2025 08:08:28 -0400
X-MC-Unique: EzAoKK4hPXaNdnhg7ceK0g-1
X-Mimecast-MFC-AGG-ID: EzAoKK4hPXaNdnhg7ceK0g_1756728507
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6377519560B3; Mon,  1 Sep 2025 12:08:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D67DC1955EA4; Mon,  1 Sep 2025 12:08:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0DEA621E6924; Mon, 01 Sep 2025 14:08:24 +0200 (CEST)
Resent-To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 01 Sep 2025 14:08:23 +0200
Resent-Message-ID: <87tt1m4bpk.fsf@pond.sub.org>
X-From-Line: armbru@redhat.com  Mon Sep  1 13:19:06 2025
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9878E21E6924; Mon, 01 Sep 2025 13:19:06 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/3] ui/keymaps: Avoid trace crash and improve error messages
Date: Mon,  1 Sep 2025 13:19:04 +0200
Message-ID: <20250901111906.2403307-2-armbru@redhat.com>
In-Reply-To: <20250901111906.2403307-1-armbru@redhat.com>
References: <20250901111906.2403307-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Message-ID: <20250723131504.1482657-1-armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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



