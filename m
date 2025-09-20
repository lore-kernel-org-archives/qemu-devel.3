Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2FFCAC5AC
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 23:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v07Hj-00050M-AI; Sat, 20 Sep 2025 19:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v07Hb-0004z1-QC
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 19:46:24 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v07HV-0006g3-F3
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 19:46:19 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45f2acb5f42so25328715e9.1
 for <qemu-devel@nongnu.org>; Sat, 20 Sep 2025 16:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758411975; x=1759016775; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pWUMTCvtPd60N3pCgp0ThXAAih3AgIHpUnUZqc/4qJ8=;
 b=GoBRkGnnRcF51Oz64dhgIsEsKZx5NBa+hywgQGlEm+ZEbq/Yy2WmtwpoqO2ZGS57vi
 y9bmHa/axMZeZ6C1xswDiEzbvs6OHGK4WEcii+zbpa9uyMae767F+oevVJ1bjWnZTqqZ
 Vi/qhdtisSqWR38KwmjlEfJYX4hPGdea+n0kZC+1ZdmSgBb+WB6+xo7EmGpSitbjS7HY
 Cay51vWboHBRTRx7CG2cPOKhpr6a+cNiRuvbQsX5GC4zaTnaXojy3+7Q3jts+G9Ow9p/
 7adi9UqE5Rnj8PzSPEvrajN8JsiHyzeB3pfhTmxAqiWTWOhHPCi/FtTozdCF4eE9czxe
 OtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758411975; x=1759016775;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pWUMTCvtPd60N3pCgp0ThXAAih3AgIHpUnUZqc/4qJ8=;
 b=NfF87fntNMIk/nytljBEfTC+QimZP98TrnwyixZvsXlo7Dtjw9WI71AMjs98lHHxgb
 TbjzcPBVahoxhg5rYcnH3c1lJR83ERLu63h5ayInRJeqPzdPShxofg516BlLIJeHaNx/
 wK9INdtrst+yXz2adSdZFFb0YvDCXwrtC8quMq08DcWmNz8SkL4r48rBD2wOQIW3xFj8
 rrZofMmHo36AXojZ74gbCLcOQvBIhz/3uZ+mKdH2FgRoaezGFuzIxRN5F6iZBS5//Hwp
 81F8eOqGlr+LmUH0ZT2/RKAyudrY4Ap38zGjg7iJ4DNGeB9jh2gPp3K+kN9FJcrZrDNL
 Ht4Q==
X-Gm-Message-State: AOJu0YwW7L+hKPOC4KVSbX5V/NC5rpXRB41iVfm9hlabPzYbj+gbDRgo
 M+k50i425qQ2a4CPkb401NaA8CPKqGUqZy2XorHFWIi/WvU36KN5wH1z
X-Gm-Gg: ASbGncsyeTRU79fe8zJXrymed8F7mtohtLKJ30X8kCZZF5tVKYvUffRZKCuJR/27tKv
 czFQ4rTASWmMvcGyTvAZGKFEUtiPr9Zg2iX1TM6Q/5dwYPrIPamUoTsiuUWZAXCgje27IdnatZv
 0HOkCeaLa3CP2bkpD2p88Zq5dmueAZ1UssNCDyJRupI3nyxQNNBhWlB0dNFMH12OSJx9DLHQiJt
 szRUDdJn2dLmsCi2IA5Jq82+q44AzdE2QplbMFfyIwics+sojzlrlvV2VeX3rk8XVh5jGgqY2PH
 2i0raDSq8OmGC/74h8gDwO1KNKKdotBCWY/b2mFMetL0TXKluABi+Zqh6qC7Qx+Ca68bV7p/5Df
 KkeMc8Tf4rIJsniO6NjW476SE4wvfDaoK4DNfMFW6G+v6I4aU/YT5
X-Google-Smtp-Source: AGHT+IH7ls+umpPTMUgq25wCbX6JjWVkPjuyFKdxQBhKRpjKg8ZGc+BQyYafskauwfXfDUWLEXXUkA==
X-Received: by 2002:a05:600c:3b1e:b0:45d:dc6c:9e30 with SMTP id
 5b1f17b1804b1-467aba7b0f2mr90961975e9.14.1758411974746; 
 Sat, 20 Sep 2025 16:46:14 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-464f64ad1b0sm160458735e9.21.2025.09.20.16.46.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 16:46:14 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Sun, 21 Sep 2025 01:45:37 +0200
Subject: [PATCH RFC v5 07/12] qmp: add chardev-window-size-changed command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250921-console-resize-v5-7-89e3c6727060@gmail.com>
References: <20250921-console-resize-v5-0-89e3c6727060@gmail.com>
In-Reply-To: <20250921-console-resize-v5-0-89e3c6727060@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>, Filip Hejsek <filip.hejsek@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758411962; l=2620;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=ISiOK22HKC8mI4/1MK6o39Mb6am1xM/7UJSCuA6f7m0=;
 b=Y3BwtPaXiWZ8kTIkhCIQ4oFJbO/on/nSX2O389xLlArGhsKoN5tTKrykTwAopMHXg54vTxbFV
 lYA2v+nW1xtBPVDwLSJ9DPwT6GghLBO7cFrUDGZpUlonAfOCq27+pCw
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x32a.google.com
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

From: Szymon Lukasz <noh4hss@gmail.com>

The managment software can use this command to notify QEMU about the
size of the terminal connected to a chardev, QEMU can then forward this
information to the guest if the chardev is connected to a virtio console
device.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
[Filip: rename command, change documentation]
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char.c | 14 ++++++++++++++
 qapi/char.json | 30 ++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index b45d79cb9b57643827eb7479257fdda2cf6b0434..f3aad545afe3d325aac388015b3d5517c2e48f0d 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -1269,6 +1269,20 @@ bool qmp_add_client_char(int fd, bool has_skipauth, bool skipauth,
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
index f0a53f742c8bee24c377551803a864fd36ac78cf..93b0d239276077d808af2e5479d539728377a99f 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -874,6 +874,36 @@
 { 'command': 'chardev-send-break',
   'data': { 'id': 'str' } }
 
+##
+# @chardev-window-size-changed:
+#
+# Notifies a chardev about the current size of the terminal connected
+# to this chardev. The information will be forwarded to the guest if
+# the chardev is connected to a virtio console device.
+#
+# The initial size is 0x0, which should be interpreted as an unknown size.
+#
+# Some backends detect the terminal size automatically, in which case
+# the size may unpredictably revert to the detected one at any time.
+#
+# @id: the chardev's ID, must exist
+#
+# @cols: the number of columns
+#
+# @rows: the number of rows
+#
+# Since: 10.2
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
2.51.0


