Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D76CC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGcU9-0001UA-Et; Tue, 13 Oct 2026 09:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcU7-0001R4-UO
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGcU6-0004gh-FJ
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 09:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791897841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SAogKNw5yHLW9Htd/Id3m9NdpWhYP6yL9mIB7BHt2+c=;
 b=bsXyTmrP0mI4MaZ2uyRktRAKyKOFD7sJb33ffa3Iv5/z0biCcOQ2vMVZQjIiNTkIlxh8E5
 f17+EYWJ7QRqPFe/nglPYIQ8V+6awwcRJkhB65DaSJbDE69ksNeETkUhVDU84dwQilZ95n
 B168qSJD+PXCIblteIvz4RYGIaOuFM0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-__n0fKG7O-u3qN18fGXsQw-1; Tue,
 13 Oct 2026 13:23:52 +0000
X-MC-Unique: __n0fKG7O-u3qN18fGXsQw-1
X-Mimecast-MFC-AGG-ID: __n0fKG7O-u3qN18fGXsQw_1791897831
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E2A84182A126; Tue, 13 Oct 2026 13:23:50 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4F79B30000E6; Tue, 13 Oct 2026 13:23:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 17:23:05 +0400
Subject: [GIT PULL 08/40] char-win-stdio: add support for terminal size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-ui-v1-8-92da3082ad96@redhat.com>
References: <20261013-ui-v1-0-92da3082ad96@redhat.com>
In-Reply-To: <20261013-ui-v1-0-92da3082ad96@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1991;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=77Ab9KbMqMuVF57b0AwFLzbws6MhvMXrUFil9fn/NHk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzjDC5o/qfrXA72vGLmP1zyx0KNeeWeVi2PUSm
 mDQycgivbqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas4wwgAKCRDa6OEJdZac
 5Tn2EAC6yUKneY/yDArDGNRbDCUrcRN4k6F06SJSPXGZHZb7iQ7aA/LDc2tE+wJJlsTrahcI8Kx
 cOPpIpkpOeNgn2zFYDQMdDBIcMQ268TVU0djQkcokB+/VDxIH5m2fh63Guwr03YZ+5QUBJAnNlt
 Vgb0xRYRkacyXj14TYAq6D3Xtf2yh3ztD0aFfQdF8qt/3HutEcQsfsSnJZsxfoli5/jTkEHrdIh
 4+J4cfryXylX0VujkfwJuAu5BqqKC0icYS1V0OdcRVR7CU7QHCg5J6+vRrNeDWq0wxpKth3M72H
 M2FryebzG4GR6GgamrjD49ovnPksFBO3jUZjQMohdZS0AKgIPUjB8m7gW3Hh32EZo0CrHDwYbgA
 +unP2Krb82zP906e0xVFufyIIIDPZe37IV8EGWfUhtCPXnD5X+DOMR7ztDgd66RT3bBG78/XO7K
 sBInVS/ZX60nDUXpvZEVHkVr0yjTX5IQF/CGdeuioGt2yFRwK3LiWtZP/PSANjyYpH4QkNJVBkY
 63nBVokTfpF+oyIjlwLHYnVwaLD7eN0zTqgm/X66Yqpme5FdHnOrMHqtMJYOt0sh6EzDkQSw8cd
 Lrf4Zkb0o5OVaKmdnpZM+C+cXrn3ryovwxqybuOOWl4z7x1PasJvAVOdDcRcSbI73ENPuJ2evq9
 vhz9l4+eC/jl0UQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Filip Hejsek <filip.hejsek@gmail.com>

Use GetConsoleScreenBufferInfo to obtain terminal size
and set ENABLE_WINDOW_INPUT to receive resize notifications.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261012-console-resize-v10-7-2c3b10d829b3@gmail.com>
---
 chardev/char-win-stdio.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
index 0deba3bffb0b..2132ae9a6bc4 100644
--- a/chardev/char-win-stdio.c
+++ b/chardev/char-win-stdio.c
@@ -44,6 +44,20 @@ typedef struct WinStdioChardev WinStdioChardev;
 DECLARE_INSTANCE_CHECKER(WinStdioChardev, WIN_STDIO_CHARDEV,
                          TYPE_CHARDEV_WIN_STDIO)
 
+static void win_stdio_chr_resize(Chardev *chr)
+{
+    HANDLE hStdOut = GetStdHandle(STD_OUTPUT_HANDLE);
+    CONSOLE_SCREEN_BUFFER_INFO ScreenBufferInfo;
+
+    if (GetConsoleScreenBufferInfo(hStdOut, &ScreenBufferInfo)) {
+        uint16_t cols = ScreenBufferInfo.srWindow.Right + 1
+                        - ScreenBufferInfo.srWindow.Left;
+        uint16_t rows = ScreenBufferInfo.srWindow.Bottom + 1
+                        - ScreenBufferInfo.srWindow.Top;
+        qemu_chr_resize(chr, cols, rows);
+    }
+}
+
 static void win_stdio_wait_func(void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
@@ -75,6 +89,9 @@ static void win_stdio_wait_func(void *opaque)
                 }
             }
         }
+        if (buf[i].EventType == WINDOW_BUFFER_SIZE_EVENT) {
+            win_stdio_chr_resize(chr);
+        }
     }
 }
 
@@ -201,6 +218,8 @@ static bool win_stdio_chr_open(Chardev *chr,
         } else {
             dwMode &= ~ENABLE_PROCESSED_INPUT;
         }
+        dwMode |= ENABLE_WINDOW_INPUT;
+        win_stdio_chr_resize(chr);
     }
 
     SetConsoleMode(stdio->hStdIn, dwMode);

-- 
2.56.0.116.g6de20f6092dc


