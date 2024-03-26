Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD683C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 15:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp90C-0004Sj-UX; Tue, 26 Mar 2024 11:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp901-000436-Cr
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:46:12 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp8zx-0001FW-CI
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:46:04 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-33ed6078884so3745304f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 08:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711467960; x=1712072760; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZoPdLMWukYfNxcXkCat/bL6sGsc7qqjORe7Wmplu6s=;
 b=ZhKSc65n6aSSgjvZCIGZUYBuQTJzohbnxNhKAwvMA3eUDpaP4g8GJMX/qfzP0nRfNF
 kt/nXs3kCQmTcGFyWIRqoSljunIvDVY8GxP6fNXgFx6QYastUV5U85shDd0+t8//0H4y
 lFqEnAQMZ62hQaA3uHkXKeFlreoMNMjQcuuIE8/32JwyoOju+5s7lBe9fp/gze6VgPpf
 iL9B9DYDCPoCq5DgGZqEzmEtYK0NvEhYEf42JGJ8iLslKRzb8r3jVtiDAZn2frGL7t9V
 lUbpySQ++PRTbCyJOpi2gv86GdyZ0Y1kE907bozMH0X839rLA354SASPmgHZNwEWIUvX
 bHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711467960; x=1712072760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZoPdLMWukYfNxcXkCat/bL6sGsc7qqjORe7Wmplu6s=;
 b=jXwhNXkU/oZXPGsWh7KTmfKlvKN3jEz+lMkJaZvXIMr5tlQ4vHprGbY2ZKS4+5u3dJ
 f2lee3T4cwSRAQR95rpiggSvcuJkALMXx4h7vtkHLnmar7r/OUeMaUP5v9FaauavA6Zv
 ouojo/taGrlDB/7dIeiTS0Z0VJ105Ojmj1HBqPh2yRyJ+oYN7pDGTvDpxmTGRtvk2prX
 sxXn646N+h5lEuF+Xk5OLaorfbyw69XYcBtO6n2AVM67lUOSGeBHUxpKjc+sB3fHqI0Y
 FlIRlKAiQDVBM5gj4UjCGou8TZi/FBTxalsj2iVuIdIA7DIj6/sI7+3WPDCOXjP7H4xI
 3hgA==
X-Gm-Message-State: AOJu0YwOx3o/fafe8A2b1UH1tWw38+XQI3JKaytibJYujE8zvdnwcBJX
 rDf+u4sY9sByDUppqYFPNrOcxftgFSmhdj4jhTgTa0bHApFUy1rH2DyiIKO/0n0lnysNSS5fy0w
 4
X-Google-Smtp-Source: AGHT+IGn9vVSpDNh8rQWuVgF1+Gw5LLVBbsr7W6HSykE2xDWZmuWfsooId8xN1cHVcfv8a/1nR/yzg==
X-Received: by 2002:adf:e6cc:0:b0:33e:ce08:79b5 with SMTP id
 y12-20020adfe6cc000000b0033ece0879b5mr1645151wrm.9.1711467959787; 
 Tue, 26 Mar 2024 08:45:59 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 s17-20020adfa291000000b00341b7388dafsm11861938wra.77.2024.03.26.08.45.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Mar 2024 08:45:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Yao Xingtao <yaoxt.fnst@fujitsu.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 09/13] contrib/plugins/execlog: Fix compiler warning
Date: Tue, 26 Mar 2024 16:45:00 +0100
Message-ID: <20240326154505.8300-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240326154505.8300-1-philmd@linaro.org>
References: <20240326154505.8300-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Yao Xingtao <yaoxt.fnst@fujitsu.com>

1. The g_pattern_match_string() is deprecated when glib2 version >= 2.70.
   Use g_pattern_spec_match_string() instead to avoid this problem.

2. The type of second parameter in g_ptr_array_add() is
   'gpointer' {aka 'void *'}, but the type of reg->name is 'const char*'.
   Cast the type of reg->name to 'gpointer' to avoid this problem.

compiler warning message:

  contrib/plugins/execlog.c:330:17: warning: ‘g_pattern_match_string’
  is deprecated: Use 'g_pattern_spec_match_string' instead [-Wdeprecated-declarations]
    330 |                 if (g_pattern_match_string(pat, rd->name) ||
        |                 ^~
  In file included from /usr/include/glib-2.0/glib.h:67,
                   from contrib/plugins/execlog.c:9:
  /usr/include/glib-2.0/glib/gpattern.h:57:15: note: declared here
     57 | gboolean      g_pattern_match_string   (GPatternSpec *pspec,
        |               ^~~~~~~~~~~~~~~~~~~~~~
  contrib/plugins/execlog.c:331:21: warning: ‘g_pattern_match_string’
  is deprecated: Use 'g_pattern_spec_match_string' instead [-Wdeprecated-declarations]
    331 |                     g_pattern_match_string(pat, rd_lower)) {
        |                     ^~~~~~~~~~~~~~~~~~~~~~
  /usr/include/glib-2.0/glib/gpattern.h:57:15: note: declared here
     57 | gboolean      g_pattern_match_string   (GPatternSpec *pspec,
        |               ^~~~~~~~~~~~~~~~~~~~~~
  contrib/plugins/execlog.c:339:63: warning: passing argument 2 of
  ‘g_ptr_array_add’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
    339 |                             g_ptr_array_add(all_reg_names, reg->name);
        |                                                            ~~~^~~~~~
  In file included from /usr/include/glib-2.0/glib.h:33:
  /usr/include/glib-2.0/glib/garray.h:198:62: note: expected
  ‘gpointer’ {aka ‘void *’} but argument is of type ‘const char *’
    198 |                                            gpointer          data);
        |                                            ~~~~~~~~~~~~~~~~~~^~~~

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2210
Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Message-ID: <20240326015257.21516-1-yaoxt.fnst@fujitsu.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 contrib/plugins/execlog.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index a1dfd59ab7..fab18113d4 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -311,6 +311,24 @@ static Register *init_vcpu_register(qemu_plugin_reg_descriptor *desc)
     return reg;
 }
 
+/*
+ * g_pattern_match_string has been deprecated in Glib since 2.70 and
+ * will complain about it if you try to use it. Fortunately the
+ * signature of both functions is the same making it easy to work
+ * around.
+ */
+static inline
+gboolean g_pattern_spec_match_string_qemu(GPatternSpec *pspec,
+                                          const gchar *string)
+{
+#if GLIB_CHECK_VERSION(2, 70, 0)
+    return g_pattern_spec_match_string(pspec, string);
+#else
+    return g_pattern_match_string(pspec, string);
+#endif
+};
+#define g_pattern_spec_match_string(p, s) g_pattern_spec_match_string_qemu(p, s)
+
 static GPtrArray *registers_init(int vcpu_index)
 {
     g_autoptr(GPtrArray) registers = g_ptr_array_new();
@@ -327,8 +345,8 @@ static GPtrArray *registers_init(int vcpu_index)
             for (int p = 0; p < rmatches->len; p++) {
                 g_autoptr(GPatternSpec) pat = g_pattern_spec_new(rmatches->pdata[p]);
                 g_autofree gchar *rd_lower = g_utf8_strdown(rd->name, -1);
-                if (g_pattern_match_string(pat, rd->name) ||
-                    g_pattern_match_string(pat, rd_lower)) {
+                if (g_pattern_spec_match_string(pat, rd->name) ||
+                    g_pattern_spec_match_string(pat, rd_lower)) {
                     Register *reg = init_vcpu_register(rd);
                     g_ptr_array_add(registers, reg);
 
@@ -336,7 +354,7 @@ static GPtrArray *registers_init(int vcpu_index)
                     if (disas_assist) {
                         g_mutex_lock(&add_reg_name_lock);
                         if (!g_ptr_array_find(all_reg_names, reg->name, NULL)) {
-                            g_ptr_array_add(all_reg_names, reg->name);
+                            g_ptr_array_add(all_reg_names, (gpointer)reg->name);
                         }
                         g_mutex_unlock(&add_reg_name_lock);
                     }
-- 
2.41.0


