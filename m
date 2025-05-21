Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F271C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 16:44:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHmX6-0000Ty-LZ; Wed, 21 May 2025 12:43:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmX0-0000Q8-PF
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:43:02 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHmWx-00069P-M2
 for qemu-devel@nongnu.org; Wed, 21 May 2025 12:43:02 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-601968db16bso3399537a12.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 09:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747845777; x=1748450577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VmQzX3BIbzz94t4XQwCRdZczcmOoQ3nURihzXuER/EE=;
 b=tp6oX/IF50czhCVvMvomGZBReVdcfK9rD5PXconXD3aKYX7x9XQqM6DavESJxZLSYx
 NtMxoGNpEcZdPWSwVhvNOrlsjB6qUq5HZ6qNUzr0TIW2IjGxn98biTSIeJ7ClAWxMJcR
 GoAJieCEcp5zcQZwBvInisTxsnvUBRyXlBH5BcYy2MqNMweFygj8kTAHrXXX4Z8rf+1M
 kFRnUgBm9EaypiQq6wjLju/Gx0DWgi3CsKi/A7ft5GjGzO5quCNabnuQGTAqvV3YzHZJ
 Z57xNooP6xdVzlODOqpYydtfgxZociVkrkRwAN9XM9c+hva4lqHeu1PhRGeryIU6jWz8
 5sWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747845777; x=1748450577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VmQzX3BIbzz94t4XQwCRdZczcmOoQ3nURihzXuER/EE=;
 b=iBDr+sWkDq1+iZGJRG9CLqbERw7XWcvWrh75goVuRH/iY5h+3FN9lSTZ2nx5Myn6Up
 AvZbEt/XUtOZpqD5xwH/gobmGbjp2MhxOe5SUVRsfzLj0C5P0vbIMY9tJxY8nLN5Tzbm
 GeOeZfKLqJ1Qyj6SsZ2T8ZbxCmeR+yStbFOxtZFRRu5jAWKXKzntx3QHkv3LKAJ2zdrY
 8rQeuKG6WB6UMSH/SOiQUKrylXLIvYffilFXYIhE1XzAtON/Su/bjp4uNgYRP472qkkJ
 Gv4A1PA7jjFOMGM9OYqdLZXGULtNIKrVzFssuPgNBGpKR2XC2hfF+m7LIgKkux+mbqE7
 MTdA==
X-Gm-Message-State: AOJu0YxgPfPE8eFS/fghh+55+Z9xoNUoXgxnNIj49bnMOf4bAvVL6ewg
 5XPhjak4+PG3g02Swllcrwk4rGW6Hj4rItaGT0lWH+v5v4NrbeLdZ0yahut+r9tqqTw=
X-Gm-Gg: ASbGnctdnwF8UJ1od4Fw8CsVCT2ZT2mcSzDprA9YSdfVd8+nBkgCMv7arOz5SFQkdcg
 ygnQFg4if2SI/v+oSragOpfXeaDEoLWXcssxujvxB/rxD2yQDQcVWi70cBOUgywdjxS/Jg6NI6v
 5/ZGAeygh7yIWmZn0t/lgl31MxvQg3SS9JUvpdqeZCYAuVmvwSX8f/hjboM2WqDNZKsvmSmOuT8
 rPWDQd9fkm4EokJ+KOu7PrtwEdEqSdI9Q2kp+V/Zz9BCCxV6Rqas7wYJVQgZw+txJl6qyfIZ9bR
 qUAkBECxhjdg8PmNsA0eo1FnpQfRbNKucQYiNwtWiu+m9Mgya2Nb
X-Google-Smtp-Source: AGHT+IHCbKSoLZXuPhcHNChdQJFNBEgFd7YwQj1+DEzi7mZBBd1w4uefhiMQvMvIrjP3ereWjnjMdw==
X-Received: by 2002:a05:6402:5248:b0:5fb:f4a5:7871 with SMTP id
 4fb4d7f45d1cf-60090076e17mr19948396a12.16.1747845777355; 
 Wed, 21 May 2025 09:42:57 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6005ae3918esm9074721a12.68.2025.05.21.09.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 09:42:55 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CF02B5F9FC;
 Wed, 21 May 2025 17:42:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 08/20] contrib/plugins: allow setting of instructions per
 quantum
Date: Wed, 21 May 2025 17:42:38 +0100
Message-Id: <20250521164250.135776-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250521164250.135776-1-alex.bennee@linaro.org>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

The default is we update time every 1/10th of a second or so. However
for some cases we might want to update time more frequently. Allow
this to be set via the command line through the ipq argument.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

---
v3
  - error checking for ipq
v2
  - checkpatch fixes.
---
 docs/about/emulation.rst |  4 ++++
 contrib/plugins/ips.c    | 15 ++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index a72591ee4d..456d01d5b0 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -811,6 +811,10 @@ This plugin can limit the number of Instructions Per Second that are executed::
   * - ips=N
     - Maximum number of instructions per cpu that can be executed in one second.
       The plugin will sleep when the given number of instructions is reached.
+  * - ipq=N
+    - Instructions per quantum. How many instructions before we re-calculate time.
+      The lower the number the more accurate time will be, but the less efficient the plugin.
+      Defaults to ips/10
 
 Other emulation features
 ------------------------
diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
index eb4418c25b..f1523cbee3 100644
--- a/contrib/plugins/ips.c
+++ b/contrib/plugins/ips.c
@@ -145,6 +145,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info, int argc,
                                            char **argv)
 {
+    bool ipq_set = false;
+
     for (int i = 0; i < argc; i++) {
         char *opt = argv[i];
         g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
@@ -175,6 +177,14 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                     return -1;
                 }
             }
+        } else if (g_strcmp0(tokens[0], "ipq") == 0) {
+            max_insn_per_quantum = g_ascii_strtoull(tokens[1], NULL, 10);
+
+            if (max_insn_per_quantum == 0 || max_insn_per_quantum == G_MAXUINT64) {
+                fprintf(stderr, "bad ipq value: %s\n", g_strerror(errno));
+                return -1;
+            }
+            ipq_set = true;
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
@@ -182,7 +192,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
     }
 
     vcpus = qemu_plugin_scoreboard_new(sizeof(vCPUTime));
-    max_insn_per_quantum = max_insn_per_second / NUM_TIME_UPDATE_PER_SEC;
+
+    if (!ipq_set) {
+        max_insn_per_quantum = max_insn_per_second / NUM_TIME_UPDATE_PER_SEC;
+    }
 
     if (max_insn_per_quantum == 0) {
         fprintf(stderr, "minimum of %d instructions per second needed\n",
-- 
2.39.5


