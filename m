Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A7ECD98C9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX1xF-0006Lq-8F; Tue, 09 Jun 2026 15:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wX1wa-000658-HT
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:17:00 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wX1wY-0006Rb-1j
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:16:59 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490b8a97b11so65564165e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781032615; x=1781637415; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QpO8HP+PFHdvEFU4knPliKS2+GJF2NSMI5lVUskX8as=;
 b=Mqw2b1tPmJRxinwNS3UHVg2TG33KaHPlrHB4xfZxINfeOwXswNQi1jloPRE5Fz+Ytq
 hMsndtLn9arcrtwyl1Pxucajj/enaCTmqI1uAngyr3S9tkMPo/NSA6bJJW8eeBenzyMb
 8H2wN5VAfxyD7rQWNnk00DpHqO4m9AgVIiF/X2zWrW5ED+4c5H2utzQ+TGfaxqLuJU8g
 cCkoC6BzQkA21kJ/McKGVAtQ05UgvvYQdu+NzhvZ8Kygt6IhnMirSyWpjEoGkXoElGXh
 Cwt+JVe9pk6KDviRErAYB4OsP9T6KR5jb70iBqntDgxuos/g7h18bAgqyqcCuoPVquA3
 cWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032615; x=1781637415;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QpO8HP+PFHdvEFU4knPliKS2+GJF2NSMI5lVUskX8as=;
 b=SnQvXDh0qrGtFqfaXUpNcRkE4oWX8Tyj9nvxPkjOjaJTOtWgkOskKpATxjf2yU4iEc
 V9gEP06h/T7s/ZaWi6IaZXxulyXguaLXMS8tURzm7Z1OdVhM2zdJm6aKxOB6fvihV8KF
 vm3gnTPq9IYvyPoL+ji02JsyAHBWLu+uz5y5OSfdxBE7CSacsV8DbsjXUoUpQarmQ/yS
 J29+5Qxg1T1xqEmBvwO5AQSkBfN52aV2Z9/RkUKRlSqYPbVn5OUPd8ndFa2nIovTy01M
 +9YPjXFPfkJkZaLEhefdIIh1K6FcGj7gHP9d1W5ZJdK9q0p1j2UHO/lGgEIq68emMcLq
 Ir2A==
X-Gm-Message-State: AOJu0Yw8qf86Txm0MMpSn1HHD4b76Gzy5/tEWwhQHBhqJADdL//uDozW
 cDo1Sa4RJWjSzdCwhC45v+SW5RahpLgqyDMn+M9V7/qF04YHNRuOCDlf
X-Gm-Gg: Acq92OHtf2sz1V/Q6naeYnNKuPEl+vl8vz1vX5UL+gYnj2JiIx1ybLYic30MaBAFZMh
 rit6VYzfizM6MbVyHxKonbkd0E1lfEF4oWckK8EgNTDVsLR57GSkSXvMie5hXN4qmXBv46SFaBn
 3h1yyz37Pr4CyY2VuXvDXrBJeOiZy09JRxkQe6eApQtM8avXDkvzjmfKFmb8cNlVhwTkcid8CZu
 2CvWg3W7Z5SyHKFammxXN06OJlGbYmhZOCM8kbrxMibkS7xFBbNu+8IlrNac0WwRQ/+ACSkTFQn
 8IxNQgZAXklvMcCvOkAWx+M7Za9oySCHX5hDhxq/NxM9PeqYl5dOkeHDgXL+/P+8UZSll3Eclmk
 I2RKQO7MVPF2P1Rf+6/kZEAtvqqufkg0e1wEeCqUMu/hxz/tERNBQGH0xjLkrgj3aQcHdqAG8D9
 ZqlEzwY4ET8unrBMX7zNp74XGIpPXwBCiEaFvdWO1vrWjs4KcZE764tJBURz4jCHc=
X-Received: by 2002:a05:600c:470c:b0:490:3c15:7146 with SMTP id
 5b1f17b1804b1-490c25dd118mr365017945e9.19.1781032615335; 
 Tue, 09 Jun 2026 12:16:55 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490dc47d474sm4076915e9.1.2026.06.09.12.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:16:54 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Tue, 09 Jun 2026 21:16:20 +0200
Subject: [PATCH v7 10/12] qmp: add chardev-window-size-changed command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-console-resize-v7-10-0c550fdcec15@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781032602; l=2599;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=oVW2OU4JaqUxxATANHkEVJwpWo5oQ7U5cSyn9nx6HvY=;
 b=AGKK8ixirLF40UqbkptUTsrltrCh0j9h+LUqsTaS34V5ClolEiMPLsFZYGr8W6mENAxNCrjli
 vxY5fzVXzXICJG696SvRbMzeBhYFtMWVFyYpzaS646eTEw6QOVACVAQ
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Szymon Lukasz <noh4hss@gmail.com>

The managment software can use this command to notify QEMU about the
size of the terminal connected to a chardev, QEMU can then forward this
information to the guest if the chardev is connected to a virtio console
device.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
[Filip: rename command, change documentation]
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char.c | 14 ++++++++++++++
 qapi/char.json | 31 +++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index d4ef717c56..96e67de815 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -1339,6 +1339,20 @@ bool qmp_add_client_char(int fd, bool has_skipauth, bool skipauth,
     return true;
 }
 
+void qmp_chardev_window_size_changed(const char *id, uint16_t cols,
+                                     uint16_t rows, Error **errp)
+{
+    Chardev *chr;
+
+    chr = qemu_chr_find(id);
+    if (chr == NULL) {
+        error_setg(errp, "Chardev '%s' not found", id);
+        return;
+    }
+
+    qemu_chr_resize(chr, cols, rows);
+}
+
 /*
  * Add a timeout callback for the chardev (in milliseconds), return
  * the GSource object created. Please use this to add timeout hook for
diff --git a/qapi/char.json b/qapi/char.json
index aa5ee9ffcd..d26af6bcc3 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -891,6 +891,37 @@
 { 'command': 'chardev-send-break',
   'data': { 'id': 'str' } }
 
+##
+# @chardev-window-size-changed:
+#
+# Notifies a chardev about the current size of the terminal connected
+# to this chardev.  The information will be forwarded to the guest if
+# the chardev is connected to a virtio console device.
+#
+# The initial size is 0x0, which should be interpreted as an unknown
+# size.
+#
+# Some backends detect the terminal size automatically, in which case
+# the size may unpredictably revert to the detected one at any time.
+#
+# @id: the chardev's ID
+#
+# @cols: the number of columns
+#
+# @rows: the number of rows
+#
+# Since: 11.1
+#
+# .. qmp-example::
+#
+#     -> { "execute": "chardev-window-size-changed", "arguments": { "id": "foo", "cols": 80, "rows": 24 } }
+#     <- { "return": {} }
+##
+{ 'command': 'chardev-window-size-changed',
+  'data': { 'id': 'str',
+            'cols': 'uint16',
+            'rows': 'uint16' } }
+
 ##
 # @VSERPORT_CHANGE:
 #

-- 
2.54.0


