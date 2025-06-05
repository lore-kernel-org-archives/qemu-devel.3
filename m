Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7FBC5B552
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 16:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNDQk-00070T-3y; Thu, 05 Jun 2025 12:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQi-0006z5-CF
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:27:00 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNDQf-0007w9-Gu
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 12:27:00 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ad55d6aeb07so229673266b.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749140816; x=1749745616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GQwrdoDZTl53LB+IkPogNbh7NAW9W/1iQ9BQhh4VHRk=;
 b=o2+I/oS8bJuUmh4V0o9C2t/ccYckPszbnTRUHOgkLILK35Tyw7UIKHeyM2v8NjxRop
 LQIBm+5hkVWZFvrYzxdEuZlS+VgK7pMYY513De2WUk+ePthJR99Q+Z6pK+9BdmUNsw5v
 nQMKKJlQLGKTtc19UZKu40AR8lZen5m0x/+8LSUSDeFrDJSGbm4XVQivJZ7PywdookIw
 QUpHqI41SRQ64xBH9twMX0sZoXmAMaRHmnMjMymgc01hFM7xoF7j3rpXwFHJqTrAkmNU
 EZLk108v3qbZVfb9stOeENA8mtlRgB0o07PYz4YsQBJHJkoq7sIa5iKx6LQ/ywLf3R7x
 boMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749140816; x=1749745616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GQwrdoDZTl53LB+IkPogNbh7NAW9W/1iQ9BQhh4VHRk=;
 b=TL49xacE0zsbMzGOPfH4XTzLzidqGIexdHtVOsaLcTNpnj4hfOTCMWJm/wdv0VI689
 9g0YBwZhuIB0WosMh5MRGEhBWx6gcNn6sXiPYAxF+aiYU8dedJkSUE7Qr5MVa4c36IuO
 1vc1/O1NPpYwRP18/QhT0nQRJP3ZzHONbDGAB0MbMvxKmP0B/6HigYqqgIaCu43AGtB8
 zydKJ14JI6BsMN9CPTIRRD+ecqha9+B37wUo6k7ekT2hx1fT0EhNI3+iN6F/qqOCBDfE
 3UIyb6cij+BgRMrI7okLYgT40dk6ROIaIWl5lV5lXkiSCi+tQJrWWP3C/VNGldoT/q+C
 hzxQ==
X-Gm-Message-State: AOJu0Yx2/CHIfCo4hTQ1YG3DRQEFBTh3Vj27KSz6/JM2CG5kQlFhSqki
 WGGzaAE0byKS3vPixIKB13HoJbQvyvf8kh6dTbNSs3goZ51mRS275gBELsCwM2X4Sws=
X-Gm-Gg: ASbGncsizhGeobaquUT5V6mEtPlExo+vpL3IJWGn1oiePL8AwB78b8V1eRA1cle+GZA
 SCXqU8rcMDgxQF8KJQIwIoVwTSgg70rd6hofVHFGHlG107lsEDdIRruT5PzPGhJy9kWKiInWdSX
 p6eHMrorjTpLOMs4wyr+Tb4vtnPQ72/caLY/rRjbzAQOuW+b9bg7/v0yZ5rCaFSkVh8wJYx5oVH
 koDFiYcZi1LSmvNgBHJVLCgvfl6X+RteiZVg2b4hoz1Y9dW1GlSmWc1jaD8Fl57FAXdCbbZXKhF
 ZgFmXY0fFQFFydbZBmgcKgaJk9zsL8e28GoRd247KFp2i6hLtZcM
X-Google-Smtp-Source: AGHT+IHhGpOgsEPpHbuowABzQgDC0eereD7wcbln7xOKXUTivyxm1kAuIpNCrPzFnMsK89FHik0GPg==
X-Received: by 2002:a17:907:3da3:b0:ad8:9a86:cf52 with SMTP id
 a640c23a62f3a-addf8c995c5mr769111066b.11.1749140815913; 
 Thu, 05 Jun 2025 09:26:55 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ada5d7fec76sm1284384766b.20.2025.06.05.09.26.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 09:26:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E677C5F81D;
 Thu, 05 Jun 2025 17:26:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 06/17] contrib/plugins: allow setting of instructions per
 quantum
Date: Thu,  5 Jun 2025 17:26:39 +0100
Message-ID: <20250605162651.2614401-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605162651.2614401-1-alex.bennee@linaro.org>
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250603110204.838117-7-alex.bennee@linaro.org>

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
index d067971135..f110c565bc 100644
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
+            if (!max_insn_per_quantum) {
+                fprintf(stderr, "bad ipq value: %s\n", tokens[0]);
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
2.47.2


