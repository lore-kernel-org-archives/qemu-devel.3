Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7D6CC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcTz-0001JO-Ar; Tue, 13 Oct 2026 09:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcTx-0001Im-Hz
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:23:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcTv-0004fl-E1
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yMgExOrHwrAmMr5AeEn8sOsa+hhPgezxAvUH5kYoZAY=;
 b=d47gvKbzYgykRG2IrvUTZmScaheDTv2MBbG6zkPkxEQYm4CrwgB3WtF3BVNi4Du/qez2ul
 3xeSZFKwg85NOhwbbb8MXxBkCdJiWmH5whZobwAWzGVSG34w0PRh67/v33BSDfQ/q679Vy
 vq92XvuvJkhSAZU5GMJKwrJFd6boT4s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-6Oity0dANiGaXsIqXcjLJg-1; Tue,
 13 Oct 2026 13:23:47 +0000
X-MC-Unique: 6Oity0dANiGaXsIqXcjLJg-1
X-Mimecast-MFC-AGG-ID: 6Oity0dANiGaXsIqXcjLJg_1791897826
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E680195FE31; Tue, 13 Oct 2026 13:23:46 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A097A1956041; Tue, 13 Oct 2026 13:23:45 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:04 +0400
Subject: [GIT PULL 07/40] char-stdio: add support for the terminal size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-7-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2990;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=hjBGA558OpsCJhWKfSlgf0hkflIKnxEDTG0g3bKVCqI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDCOCvPGQUs5iExa3ONMw1JlLFS2nuUkt9Vp
 viLt/tCeAGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwgAKCRDa6OEJdZac
 5YQyD/4y7aS646jWGj0E2OpT9ccHmSK7aT0mJbJvpaYkMB/uh3PR/WARjGL1DrmbIjWIuT6eU4I
 TX33MVHf0m0Aidv2D5B1LLu587c6SZkYS4jnltY2dsVk4XAdyEWtD5Q19WtJSXMYXkFTUpQeHx1
 F9mqo4y0XZVkpHjDhB5q5d6bEn+fCIFI3cq7nYmlzKzSB3L/W9RKFhcF9Iq9UEIYcLVMHg4zGa6
 ZsppV+PywHTSrIXd5LYdQnJIC05Tj0VrwZw2moZrSIuPFDGE/aMpb3e2uAEHW+5LGybSV9Itcoc
 322m8ihuumggQA3dLqm1VURFAFwCAL5zMkyZkfTf3dHJZiWlz7St2UkDrZBqNdM/wLkuDLkUtjp
 18LItl4aKm0EHGf0q84k52bE/wyctViWEfD9D2t2s9uEudGcknQwWo5SA8NKSRuwJp2ra4tWyja
 HuJeCWuJ7s6cc6mzHlbHA3s4u32ijFUntMw11kFpPlh/D3rgs3cbxmvLtJr6hTN/fljgUtM/4G+
 m6tO1bV2bNLI6V3HD7ocnGR8ftBz1zYIiXZYjGLvZxipLMCQ6Achgp5CHA9RB8BwCJeouh9bwVA
 33VNe04Gtw3DwPSZQVCkCU1+vH6cP4ZYCDKNxSm0GTreP/JsQtOP59ZhlY4PAxXeXBiK1vsxB9/
 YmXhtJttPCF575Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Szymon Lukasz <noh4hss@gmail.com>

Update the terminal size upon SIGWINCH delivery.

[Filip: use DECLARE_INSTANCE_CHECKER,
        qemu_chr_resize_stdio -> stdio_chr_resize,
        remove notifier in char_stdio_finalize]

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261012-console-resize-v10-6-2c3b10d829b3@gmail.com>
---
 chardev/char-stdio.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index fe1cbb2d880f..f63bf413c741 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -34,7 +34,9 @@
 #include "chardev/char-win-stdio.h"
 #else
 #include <termios.h>
+#include <sys/ioctl.h>
 #include "chardev/char-fd.h"
+#include "qemu/main-loop.h"
 #endif
 
 #ifndef _WIN32
@@ -46,6 +48,14 @@ static bool stdio_in_use;
 static bool stdio_allow_signal;
 static bool stdio_echo_state;
 
+typedef struct {
+    FDChardev parent;
+    Notifier resize_notifier;
+} StdioChardev;
+
+DECLARE_INSTANCE_CHECKER(StdioChardev, STDIO_CHARDEV,
+                         TYPE_CHARDEV_STDIO)
+
 static void term_exit(void)
 {
     if (stdio_in_use) {
@@ -85,8 +95,23 @@ static void term_stdio_handler(int sig)
     stdio_chr_set_echo(NULL, stdio_echo_state);
 }
 
+static void stdio_chr_resize(Chardev *chr)
+{
+    struct winsize ws;
+    if (ioctl(1, TIOCGWINSZ, &ws) != -1) {
+        qemu_chr_resize(chr, ws.ws_col, ws.ws_row);
+    }
+}
+
+static void term_resize_notify(Notifier *n, void *data)
+{
+    StdioChardev *s = container_of(n, StdioChardev, resize_notifier);
+    stdio_chr_resize(CHARDEV(s));
+}
+
 static bool stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
+    StdioChardev *s = STDIO_CHARDEV(chr);
     ChardevStdio *opts = backend->u.stdio.data;
     struct sigaction act;
 
@@ -121,6 +146,10 @@ static bool stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
     stdio_allow_signal = !opts->has_signal || opts->signal;
     stdio_chr_set_echo(chr, false);
 
+    s->resize_notifier.notify = term_resize_notify;
+    sigwinch_add_notifier(&s->resize_notifier);
+    stdio_chr_resize(chr);
+
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
     return true;
 }
@@ -152,6 +181,9 @@ static void char_stdio_class_init(ObjectClass *oc, const void *data)
 static void char_stdio_finalize(Object *obj)
 {
 #ifndef _WIN32
+    StdioChardev *s = STDIO_CHARDEV(obj);
+
+    sigwinch_remove_notifier(&s->resize_notifier);
     term_exit();
 #endif
 }
@@ -162,6 +194,7 @@ static const TypeInfo char_stdio_type_info = {
     .parent = TYPE_CHARDEV_WIN_STDIO,
 #else
     .parent = TYPE_CHARDEV_FD,
+    .instance_size = sizeof(StdioChardev),
 #endif
     .instance_finalize = char_stdio_finalize,
     .class_init = char_stdio_class_init,

-- 
2.56.0.116.g6de20f6092dc


