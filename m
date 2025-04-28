Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26260C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 13:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9O5H-0008Ag-Tz; Mon, 28 Apr 2025 08:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9O54-0007uP-V3
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:59:31 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u9O50-00037W-1T
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 08:59:29 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac6e8cf9132so920334966b.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 05:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745845164; x=1746449964; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=djoQOHWyk0AtirIrodM8UGPqfENNxGNaKjJ0HgISDiU=;
 b=Ir1c84exYpMhLrW/0q8LgRysAfnCZ3aHUINXrsTQf6kEqHsriqufU7UzZcuZVm7+Mt
 uF2PWdVyCGcsEBBnluTbDdjYAzxrT2s4ZMBos4YhOstNuijw8WL0syTgnmbE0tizU9H+
 Ym0sCuqneUPAcaFOoFLO/CboAQFtrQpjeetbOkozDkwtPSSCvK7DZadgYHSLNGfpbz49
 PYhnH6txI0F6bLR6+GE2iIAuq67D0bZSHStQreRMiNmDr/s1BcGtDiHjtIs7Zg13YBI1
 3anDf0bNtIR5KaxxoKlPs5gXzlJ1u1HM/MjSr1+uk/kHXdptm4Oo2c0J7QOptVTeO5K0
 e9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745845164; x=1746449964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=djoQOHWyk0AtirIrodM8UGPqfENNxGNaKjJ0HgISDiU=;
 b=B3hAl396CBy+2+7cIAKYupD3dZNLnd3WLnMBesh9JSeQlUBdd3AYXw8nJLcPvOxEOo
 DThgxQzs8PnmPaXQ3yRTRFl4H41h3qMdF4cfQxAAiF9fRquV7qLW7S6fQQATeI2Pip71
 8mHKO/fkWKl+IXKygDxkEcaJJaHz6mTEyXtOqcJTriwhlcWLgqyCbjnSRuE5XVwHtTcy
 dbs83BATXgg/Vn2a3Dd6Hrd9JZGisrDzU0e5IfkQGDyM0jLm4IpnQLr8FY5aJsxAzUX5
 CUMRw2ITksuk67APDx1gbWYrAezKVaIbBw923CFWFGPON6zQB5QqDAMrOfVdf3VZ7XR5
 ThDw==
X-Gm-Message-State: AOJu0Yx9xHRf2C3aTgLI+fWCdCffFoPh8MKJXa2wf54ozf1s39T/swQg
 LNMWycVBKFdA7QMkaLoo3ine1yE0oc7PAWVXp3vbqTrNCv97WbseFXO4+sMtmEc=
X-Gm-Gg: ASbGncvjeisPQZbfSBP1pVwXfdZPrg/RIiVNGcGc5pAjL6ceTAhMRR+rB8fBzTXDFku
 Bb30J1MB23cEMbziMbd1S64sc5wYGAVo9aZrSCKkz8vcWGHcuVX+7ozg+nAD+srBQmz+bTNEB88
 89Qlu3vw6b3aWrUk0U4fJjVWYhpcSN4yHk8D5+7FaWI8SK7iMqWzkwyIFIfUP6yGLYB79A8mdIh
 jANFuBRqONu0lBnGx3RbYm6/99vXCCD13fwAaFG9+ZDBD1ZCWbUCykHHFCGSbSFo37mmEkHKPHv
 xpZm5Cvh7r1XgOq3q2nEPzTGE39pDYET4ZH2Ar1p7WU=
X-Google-Smtp-Source: AGHT+IHxGeWECFgvd9whl9fyik2oG/IL5je37HtGfe3mJ9A4rNSXfnBLN+VCPlMUzzwShYPVNb8/2Q==
X-Received: by 2002:a17:907:3f9b:b0:ace:672d:c7c9 with SMTP id
 a640c23a62f3a-ace73a6bed7mr1109878466b.26.1745845164287; 
 Mon, 28 Apr 2025 05:59:24 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6e4e70bbsm632156866b.63.2025.04.28.05.59.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 05:59:22 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B1C2C5FAED;
 Mon, 28 Apr 2025 13:59:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 5/9] contrib/plugins: allow setting of instructions per quantum
Date: Mon, 28 Apr 2025 13:59:14 +0100
Message-Id: <20250428125918.449346-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250428125918.449346-1-alex.bennee@linaro.org>
References: <20250428125918.449346-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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
---
 docs/about/emulation.rst |  4 ++++
 contrib/plugins/ips.c    | 10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index a72591ee4d..b607183d13 100644
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
index 1952e0866d..d83124d71c 100644
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
@@ -164,6 +166,9 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                         break;
                 }
             }
+        } else if (g_strcmp0(tokens[0], "ipq") == 0) {
+            max_insn_per_quantum = g_ascii_strtoull(tokens[1], NULL, 10);
+            ipq_set = true;
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
@@ -171,7 +176,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
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


