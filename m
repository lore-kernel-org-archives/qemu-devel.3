Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB130CD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX1wb-00066Z-UX; Tue, 09 Jun 2026 15:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wX1wT-00062B-Py
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:16:53 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wX1wS-0006NJ-8Q
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:16:53 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-45ef616daf6so5439825f8f.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781032611; x=1781637411; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8KjtEs6GXuaSZvO/otOHVOhYdruaUkymc1cfvg/uON4=;
 b=NBvMvszLn1Zrb5nMwOXijZva+jcFEFBCI7G4fphMDS/qx/exy3yo1ppNQ8ogcVI2aX
 qmBnTs0aZ/2YNd/iaPmcxWq9IWS/RpP5G+nc93xotAchEwPfYRRaB5oPQTkUYdKzWaLj
 TK3G2cme4WdCbHx5Kmlt/71adtddVTw1TtIdJjIIwCRrBnzvFodlEy7NAxqo9q7TSXLH
 BN9plo4DxsecxIh/VlM74JMqA+ez798gK2TmxdksGmajifpfAL6I8ALhG14eCrFrMa9S
 lKD3/lpTFiFSSjzpnLYjK9Xk2sEKMM795jW7FWXN1tg+54zUCZ9BtqtG5eYFlLEbp4h2
 qRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032611; x=1781637411;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8KjtEs6GXuaSZvO/otOHVOhYdruaUkymc1cfvg/uON4=;
 b=VeF5NuQSyY4btjwBGYAB1K2HD2fXub1b7I3dCeM3Vibo8GnO51bFVlhmvRzDjzkICp
 BkIJnXgQFcS0PtOLthlaO3Cy4v0nzyzsO7O0Ma08cB5P0EQoFTth2IML3XGUQCcBd1QW
 9zxw7qlosilWHF2qYuZiy4VBb+03GluJfEOaPo2DVUKcYUnzrYhPjAISZzJJOPaz6A7P
 3dnAZ34RytRx+tF0efXhwrhDswxSWahx4J0Nt1poZelqHBYVUED5XHpETyTsjK59Cupu
 70zBfsCjWDjdotJzj0fgCB29x2j2r0lWMCP7Us6vfpp7jpB7nwg8HtSQ590OC/D8zRUX
 bQZg==
X-Gm-Message-State: AOJu0YwuNhKrca2S/55b9ilRJ3Xzq1vhiwYVkIfyRzQXmcOFz/G+ngkX
 5bREHlMCChoJPVM6vUPb/48dd8w3GGlteG3MTWZXuITx/Gh9PeRHQ0fT
X-Gm-Gg: Acq92OH+souZutiYmKTNhAcWapQxtgGPNvoHMB9HGDMCtf55sRuUCGnPSedegMnR1Cl
 Ru4LeB/rus10jWcBA3SWEO36EBki7W8IfeERJpsgBHjQNLKj5P9M7GxWuQjA5vLCU41nCZ5ihE3
 N93qlLCPCQSpOONr/o5yoRqfhpWhc7QEmDst191v7MBWjlkDGr48z3cuBJMnAcIzdW01UOaTGrf
 YwUGNa4mcnTbCEQJknStrCkFpG1GvzvjyQ3eS3VxIC50egTStdwd+rZh2GN2SgmWyS/4aInt1Hx
 WlwjShbvD+iaF226aDQWXUti2q6vWSDFfrX2nIo8gP+F3enaGAR2bkhiROCayDQh8XCyqNdMN3h
 DcA9vSMbGLhkLfyh2vgZ7g76a1BmTvWEKRum40bN/efDFZYNb1fUwHrLTf+W3Ox7iGM6VHIyGHR
 E62p4xLbFnIgEqneU/n0vvfIOG/wBlKPlDRleXrBtV6hB6L+Ui70+kbC75wkX9dqA=
X-Received: by 2002:a5d:4d8b:0:b0:439:b8b2:fad0 with SMTP id
 ffacd0b85a97d-460302dcc97mr24590061f8f.5.1781032610627; 
 Tue, 09 Jun 2026 12:16:50 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2ed944sm66954852f8f.13.2026.06.09.12.16.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:16:50 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Tue, 09 Jun 2026 21:16:16 +0200
Subject: [PATCH v7 06/12] char-stdio: add support for the terminal size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-console-resize-v7-6-0c550fdcec15@gmail.com>
References: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
In-Reply-To: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781032602; l=2540;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=eLrLa7zEPvB9zEiINHUOH8R1e+jO8eJ0+Xg53clUYDw=;
 b=49gLciysqQ7WDqK+ha+TR8JcRNi5bL1OUV945TbVMb1CQAhpARkG/ocRYjk23KdqywIGdujZF
 qiSssKdlE24Bf88V7Nbe1wum+oQsU2P7SD0frfFIpwJRArU6f8Z9jJ8
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
[Filip: use DECLARE_INSTANCE_CHECKER, qemu_chr_resize_stdio -> stdio_chr_resize]
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char-stdio.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index fe1cbb2d88..4fc8db212c 100644
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
@@ -162,6 +191,7 @@ static const TypeInfo char_stdio_type_info = {
     .parent = TYPE_CHARDEV_WIN_STDIO,
 #else
     .parent = TYPE_CHARDEV_FD,
+    .instance_size = sizeof(StdioChardev),
 #endif
     .instance_finalize = char_stdio_finalize,
     .class_init = char_stdio_class_init,

-- 
2.54.0


