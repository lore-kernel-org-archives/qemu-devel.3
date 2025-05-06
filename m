Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8A0C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 12:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCHrf-0003da-Jh; Tue, 06 May 2025 08:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrS-0003Py-VY
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:27 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uCHrO-0003qb-Qj
 for qemu-devel@nongnu.org; Tue, 06 May 2025 08:57:26 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5e8be1bdb7bso8618511a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 05:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746536241; x=1747141041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQXjIARbCIkupLYqHmy+1qVS0rGy139+5xHnakSfpw4=;
 b=FSe+5agbujLgVLnqDbPN1XIWqvMZ2t9VeZwm4Ke9mQ6VKk+3O1Vv2e+Sm7RXzZE7g2
 lmsp1tEZ4rLI1CKCXq/1o6q09D9sbT9FeGngNN7AWsEdRoL8QcUWEjONTLrzKLPwmCKD
 EN7VUP/yolQpbd5p+/uDS/lx35vpmDgai/qcThIzvDqfZyQs/CmJJH6qcOd8Wf8sKuWy
 QdS9RDeqE2YhXnrDLHYj3syNSRfdg63pBscT3pUpBLcsNyzq///K1XOlQM8fn7omJh2y
 XF38t3azK2wsQmWmcyjhRs2Wfx3Yrn+cVoWOxXJgCcYt16QItC+mmSrWZS2dxsGuNcZe
 lmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746536241; x=1747141041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQXjIARbCIkupLYqHmy+1qVS0rGy139+5xHnakSfpw4=;
 b=kleXJdn5m/h4OZOoysmp6eIvcC18UKBzSwHYuSpQQopUTGGB7VzQ/kT1DocO7x4Ipa
 a0jGgY5VsTv5ko8ye3vxzyTkk/04zhJiB8X+AGttVyi5EVLjZF61yk3BLW71HNB4p0ux
 M2FFV3Y/ijgeFtYKaX5coI+DaxnfzUJWQPbubJ9akpqt1EjzyclovZT3obZ4IeMtuHf1
 Xqm8N0XO3IwMS2AtA8oeICR7ZxPHgEDozbCxwiGf1DrkGiJ43xgNlVG01yzyPWDyF8SP
 QuwnR2zAV5Lsq+GK+Q9Bd7GtC1DPdAY2YVAJW5QbjT0cFldXttI4DMdCb6c5Y0ggl0dT
 gjbw==
X-Gm-Message-State: AOJu0Yyw9jEcbC0TOkXCrWqFnffSBtjepaBVHk+V9GNuiVWLr0p5x/ws
 DCSwY7H9QmhK8zbSY4OOydUm1MRBYfd4ui0baqBMcLT2lLgT6VGt8yeSUbSfEug=
X-Gm-Gg: ASbGnculDimL3sRh53xVy5sk53DQpl+tZtD3U0SIIrpFXuBdJifkgLlC6qhnKwc7stX
 2xC0Ehp0aHbJjXAUBQcnVjBo8H95IziZmucUmGq+5tM8aG1is1gE0Lprgv8umeeugIlx4S3f5t0
 jqRiuLS7DB19SKMVTd6VFbs82MAyoqXkYo2t/r5+fPf97ryykaaDhDMsD24f7b/b25iEdCElH87
 0yQer77HF4FX2aCSOP2WKjqBWL3SU2+RmQmGcJKKsPMmIjdHHSzzRyKh7US1jLnJLD1lkmX8D6I
 uSMTZE0htjwL2QOY+TdOFdwtGrp8ipUmlHSi3slS598UXvwqFWlVZA==
X-Google-Smtp-Source: AGHT+IGg91vSb76MTJEHpqCe8XY2mLnrwEizQT3yr6BPkpzqewipsvDpxXQZs/UGuCFs6IILUudpgg==
X-Received: by 2002:a17:907:9722:b0:ace:4197:9ac5 with SMTP id
 a640c23a62f3a-ad1d45abbcbmr290531066b.27.1746536240744; 
 Tue, 06 May 2025 05:57:20 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad189508c83sm702095866b.139.2025.05.06.05.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 05:57:18 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A30485FAAF;
 Tue,  6 May 2025 13:57:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 06/14] contrib/plugins: allow setting of instructions per
 quantum
Date: Tue,  6 May 2025 13:57:07 +0100
Message-Id: <20250506125715.232872-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250506125715.232872-1-alex.bennee@linaro.org>
References: <20250506125715.232872-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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
v2
  - checkpatch fixes.
---
 docs/about/emulation.rst |  4 ++++
 contrib/plugins/ips.c    | 10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

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
index 9b166a7d6c..62ed8ddd08 100644
--- a/contrib/plugins/ips.c
+++ b/contrib/plugins/ips.c
@@ -147,6 +147,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                                            const qemu_info_t *info, int argc,
                                            char **argv)
 {
+    bool ipq_set = false;
+
     for (int i = 0; i < argc; i++) {
         char *opt = argv[i];
         g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
@@ -177,6 +179,9 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                     return -1;
                 }
             }
+        } else if (g_strcmp0(tokens[0], "ipq") == 0) {
+            max_insn_per_quantum = g_ascii_strtoull(tokens[1], NULL, 10);
+            ipq_set = true;
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
@@ -184,7 +189,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
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


