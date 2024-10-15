Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131D2CFC278
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 08:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0dII-000769-6I; Tue, 15 Oct 2024 04:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0dIG-00075v-Np
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 04:52:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0dIF-0008CG-75
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 04:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728982358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Q5K6BeJaiZ2Fm44mfbHcepRRyNraqfAuk63pnZL6Ug=;
 b=L2DnFjaReDKpncjd+73dO6YyX3n7IuwYFjFAAaK0ItGBJ1IXlLdeTByTQMNJKNGAkhmwBy
 LI2nyFYlX9RPHFtSB4egPKk4AH8f8508GI60f6Et2Uwh8OQxBHmUdQz4RQXFRfRLXgeTfS
 XOgP0c2i7J0nssRaYqr9Y6FVS3RsQPM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-o5g9fm_XMA6Y9Rnac2iW-A-1; Tue,
 15 Oct 2024 04:52:35 -0400
X-MC-Unique: o5g9fm_XMA6Y9Rnac2iW-A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B10FA1955F0B; Tue, 15 Oct 2024 08:52:34 +0000 (UTC)
Received: from localhost (unknown [10.39.208.15])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8AB7B1956056; Tue, 15 Oct 2024 08:52:33 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 8/8] tests/unit/test-char: implement a few mux remove test cases
Date: Tue, 15 Oct 2024 12:51:50 +0400
Message-ID: <20241015085150.219486-9-marcandre.lureau@redhat.com>
In-Reply-To: <20241015085150.219486-1-marcandre.lureau@redhat.com>
References: <20241015085150.219486-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.076,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Roman Penyaev <r.peniaev@gmail.com>

This patch tests:

1. feasibility of removing mux which does not have frontends attached
   or frontends were prior detached.
2. inability to remove mux which has frontends attached (mux is "busy")

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
[ fixed *error leak ]
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20241014152408.427700-9-r.peniaev@gmail.com>
---
 tests/unit/test-char.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
index f273ce5226..a1c6bb874c 100644
--- a/tests/unit/test-char.c
+++ b/tests/unit/test-char.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include <glib/gstdio.h>
 
+#include "qapi/error.h"
 #include "qemu/config-file.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
@@ -184,6 +185,21 @@ static void char_mux_test(void)
     char *data;
     FeHandler h1 = { 0, false, 0, false, }, h2 = { 0, false, 0, false, };
     CharBackend chr_be1, chr_be2;
+    Error *error = NULL;
+
+    /* Create mux and chardev to be immediately removed */
+    opts = qemu_opts_create(qemu_find_opts("chardev"), "mux-label",
+                            1, &error_abort);
+    qemu_opt_set(opts, "backend", "ringbuf", &error_abort);
+    qemu_opt_set(opts, "size", "128", &error_abort);
+    qemu_opt_set(opts, "mux", "on", &error_abort);
+    chr = qemu_chr_new_from_opts(opts, NULL, &error_abort);
+    g_assert_nonnull(chr);
+    qemu_opts_del(opts);
+
+    /* Remove just created mux and chardev */
+    qmp_chardev_remove("mux-label", &error_abort);
+    qmp_chardev_remove("mux-label-base", &error_abort);
 
     opts = qemu_opts_create(qemu_find_opts("chardev"), "mux-label",
                             1, &error_abort);
@@ -334,7 +350,13 @@ static void char_mux_test(void)
     g_free(data);
 
     qemu_chr_fe_deinit(&chr_be1, false);
-    qemu_chr_fe_deinit(&chr_be2, true);
+
+    qmp_chardev_remove("mux-label", &error);
+    g_assert_cmpstr(error_get_pretty(error), ==, "Chardev 'mux-label' is busy");
+    error_free(error);
+
+    qemu_chr_fe_deinit(&chr_be2, false);
+    qmp_chardev_remove("mux-label", &error_abort);
 }
 
 
-- 
2.47.0


