Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0D2FF60F7
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7VnG-0001FT-Ip; Tue, 31 Mar 2026 05:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w7VnF-0001DX-6b
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:53:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w7VnD-0008H1-HH
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:53:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774950830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XF0CkezX3Sf94Et+WA9PyBVV/sdIs6tS9kfJBKf5JBc=;
 b=VPLHqK75CBF8/aSAnR8IXPW5xeAennjr8XVaPDdSlyfSyZzEpdCFQBYQmY7bB5MmJ84Xv8
 XbqkQiVRQR0L8vKY3v1IC+EUYDJbLTufF6OOrH1OLeK3vcjmRbZf6Y0TtRz4FTLJhvMVnm
 0PKDHZzXPmLZSbJlGcCdQ2zklkdNErM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-qUh7VvyQNSyI4azbsudlRA-1; Tue,
 31 Mar 2026 05:53:46 -0400
X-MC-Unique: qUh7VvyQNSyI4azbsudlRA-1
X-Mimecast-MFC-AGG-ID: qUh7VvyQNSyI4azbsudlRA_1774950825
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25B9B180047F; Tue, 31 Mar 2026 09:53:45 +0000 (UTC)
Received: from localhost (unknown [10.44.22.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA20B19540C4; Tue, 31 Mar 2026 09:53:43 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Anton Kuchin <antonkuchin@nebius.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 6/6] tests: don't build audio tests when no audio drivers are
 enabled
Date: Tue, 31 Mar 2026 13:53:02 +0400
Message-ID: <20260331095302.644608-7-marcandre.lureau@redhat.com>
In-Reply-To: <20260331095302.644608-1-marcandre.lureau@redhat.com>
References: <20260331095302.644608-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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

From: Anton Kuchin <antonkuchin@nebius.com>

When there are no audio drivers configure fails with "ERROR: Command
cannot have '@INPUT@', since no input files were specified".

Fixes: 3220b38a8d ("tests: start manual audio backend test")
Signed-off-by: Anton Kuchin <antonkuchin@nebius.com>
Message-ID: <DB8P190MB07142E1BA8DEEA8B2E41D5B2DB57A@DB8P190MB0714.EURP190.PROD.OUTLOOK.COM>
[ Marc-André - use empty modinfo stub ]
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/audio/modinfo-stub.c |  5 +++++
 tests/audio/meson.build    | 14 ++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)
 create mode 100644 tests/audio/modinfo-stub.c

diff --git a/tests/audio/modinfo-stub.c b/tests/audio/modinfo-stub.c
new file mode 100644
index 00000000000..1cae8c6905e
--- /dev/null
+++ b/tests/audio/modinfo-stub.c
@@ -0,0 +1,5 @@
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+const QemuModinfo qemu_modinfo[] = {
+  { /* end of list */ }
+};
diff --git a/tests/audio/meson.build b/tests/audio/meson.build
index 84754bde221..be96313a63e 100644
--- a/tests/audio/meson.build
+++ b/tests/audio/meson.build
@@ -6,12 +6,14 @@ endif
 
 modinfo_dep = not_found
 if enable_modules
-    modinfo_src = custom_target('modinfo.c',
-                                output: 'modinfo.c',
-                                input: audio_modinfo_files,
-                                command: [modinfo_generate, '--skip-missing-deps', '@INPUT@'],
-                                capture: true)
-
+    modinfo_src = 'modinfo-stub.c'
+    if audio_modinfo_files.length() != 0
+        modinfo_src = custom_target('modinfo.c',
+                                    output: 'modinfo.c',
+                                    input: audio_modinfo_files,
+                                    command: [modinfo_generate, '--skip-missing-deps', '@INPUT@'],
+                                    capture: true)
+    endif
     modinfo_lib = static_library('modinfo.c', modinfo_src)
     modinfo_dep = declare_dependency(link_with: modinfo_lib)
 endif
-- 
2.53.0


