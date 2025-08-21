Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A44CA0EF8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 14:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up6dl-0006Tl-TD; Thu, 21 Aug 2025 10:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1up6dj-0006TZ-92
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 10:51:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1up6dg-0000oO-MC
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 10:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755787896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JGzXuCKcSk6XG7nWQ9phlfBMKI3ZI1XngCb1NSL9y5o=;
 b=OCW/40HqgNbX9+ZqEAibcCDJiD9BR6slf/h7au+WQOjfVp0u4hMIx9pVsj7qI1hfIeMpvd
 JQGjLS6jYWgNzpIXzj9tVG7FQR1wdlC4VhmXQrqinendisnvGcRaz9382oNZ0zx2EZF+rK
 tf2J7uqSJqWoiHp7ZzxUut9WM0Aa/Pk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-IJyaNsyFMIaSrDwBRXXvWA-1; Thu,
 21 Aug 2025 10:51:34 -0400
X-MC-Unique: IJyaNsyFMIaSrDwBRXXvWA-1
X-Mimecast-MFC-AGG-ID: IJyaNsyFMIaSrDwBRXXvWA_1755787894
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCEBF180034A
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 14:51:33 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.226.28])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 54C621977686; Thu, 21 Aug 2025 14:51:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/vnc: Fix crash when specifying [vnc] without id in the
 config file
Date: Thu, 21 Aug 2025 16:51:30 +0200
Message-ID: <20250821145130.845104-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Thomas Huth <thuth@redhat.com>

QEMU currently crashes when there is a [vnc] section in the config
file that does not have an "id = ..." line:

 $ echo "[vnc]" > /tmp/qemu.conf
 $ ./qemu-system-x86_64 -readconfig /tmp/qemu.conf
 qemu-system-x86_64: ../../devel/qemu/ui/vnc.c:4347: vnc_init_func:
  Assertion `id' failed.
 Aborted (core dumped)

The required "id" is only set up automatically while parsing the command
line, but not when reading the options from the config file.
Thus let's move code that automatically adds the id (if it does not
exist yet) to the init function that needs the id for the first time,
replacing the assert() statement there.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2836
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 ui/vnc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 68ca4a68e7a..9054fc81253 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -4309,8 +4309,9 @@ void vnc_display_add_client(const char *id, int csock, bool skipauth)
     }
 }
 
-static void vnc_auto_assign_id(QemuOptsList *olist, QemuOpts *opts)
+static char *vnc_auto_assign_id(QemuOpts *opts)
 {
+    QemuOptsList *olist = qemu_find_opts("vnc");
     int i = 2;
     char *id;
 
@@ -4320,23 +4321,18 @@ static void vnc_auto_assign_id(QemuOptsList *olist, QemuOpts *opts)
         id = g_strdup_printf("vnc%d", i++);
     }
     qemu_opts_set_id(opts, id);
+
+    return id;
 }
 
 void vnc_parse(const char *str)
 {
     QemuOptsList *olist = qemu_find_opts("vnc");
     QemuOpts *opts = qemu_opts_parse_noisily(olist, str, !is_help_option(str));
-    const char *id;
 
     if (!opts) {
         exit(1);
     }
-
-    id = qemu_opts_id(opts);
-    if (!id) {
-        /* auto-assign id if not present */
-        vnc_auto_assign_id(olist, opts);
-    }
 }
 
 int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
@@ -4344,7 +4340,11 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
     Error *local_err = NULL;
     char *id = (char *)qemu_opts_id(opts);
 
-    assert(id);
+    if (!id) {
+        /* auto-assign id if not present */
+        id = vnc_auto_assign_id(opts);
+    }
+
     vnc_display_init(id, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-- 
2.50.1


