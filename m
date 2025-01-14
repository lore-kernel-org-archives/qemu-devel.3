Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F189DC02184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfOL-0004RD-Qt; Tue, 14 Jan 2025 06:47:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfNu-0004LO-HM
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:47:05 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfNr-0006fH-P0
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:47:02 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so55744465e9.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736855217; x=1737460017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pERnavJS02WsVkpfgEIKcxRU3EPSk+CF5JdtAAMvhiw=;
 b=vijrYlprhGqX1iu7WH3ORyZsxOOWHG4e9/efInhI+NYED4kmwpYMnDzXzXYLm+9PIE
 XxW+MQ5tLr0TImb+dkhkB8Lzz8GCZ5wPHmRgI8xrgntEtziJHQYOlcMqgS3XtRoJXdPD
 GFoOc/a8RWQ39d8b6duNH09vl9r/xprE8fSp/HCT/igOx+4f1zJZxc1EjFdvxCfspT11
 q6USTQFHHHxoORCRgqZvrmdY+2h/PSCvxk61wL1SooB/fo3vZYLPr5JeQpTIzp1NYiu4
 Wu7pfNeUocE8wCpkH6XcDTud5oCUMWDylSJUiXxpGwrguDp9PRrEtWSFKN/w9liFtQvL
 6Awg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736855217; x=1737460017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pERnavJS02WsVkpfgEIKcxRU3EPSk+CF5JdtAAMvhiw=;
 b=xQDOBxI+vYROwtkzeRGOE+EjOEnwkpjE20rK8Co1qRPrO+CRjtKGWvw0ZX3lkHAA1I
 6CUI+R2f2MvdkkArhgHGmthbjw27RC330khMFobWMYBM74kINsZmjBo4AaLNM5HykUJe
 CYpDgRwOEtw0w0+x54ZzvvRe6Mz8Fyx6AbsNP+AbhBFyVMcBzzwDV9VU6qEjBz/K2zlJ
 9CmfrCbwBO0YXofFaU6pCIla5TAs3S12bvC2SrW6Y9z23yuVI9zl/MgG3zsvWIvEcOZ/
 E73fH25mNEv81w8kNrbBKB1xVWO4O8a64wf8a2WfRZOwtRLRbvxIFuGdSdqvefxzWe/K
 YZ/w==
X-Gm-Message-State: AOJu0YxLDgPZoRfJEk+SGH0l6FZfVhhR+HVPQOQNjPPrq1WP1PXcJ5lH
 lS9FzYEA/Ax1Bi2eJqC98+kE7HxXtkBrfUzGhsBPSytEBr6qwuaZdkpfWuQZ6UQ=
X-Gm-Gg: ASbGnctnxG5uUOvUAwaJ7p2oaql1ZLALnZ/AjOX1ZMZaBO7zQvRioc0ZgF8iGvLdSa7
 ZdBKBhIc6z2cbBoPStVOfZHnfBZ2W79HangA8TXiEKh1L0XTqAy9K5zUD80Sj6ES9LpKkVV6A7f
 Z8B1RWf/ylr45zaUMhAwtFiytmeTG2Wyd5L2So1YQPV4A30e1p6f+gYoPbyCyIEOuy3RVJxMTBB
 oeHdwOK0AWfVmzl+YEhm36RgLD4JQuJ7GKrVzGygwY5nG9CXtBNids=
X-Google-Smtp-Source: AGHT+IGHTi7xXl93VR6ukC+VBC/X3BcQpZtFOQ/VRYPyZnWSa/NYhXGyKUbMnAUoiIgpMnblmvmoMw==
X-Received: by 2002:a05:600c:1e09:b0:436:e751:e445 with SMTP id
 5b1f17b1804b1-436e751e61fmr232295415e9.5.1736855217542; 
 Tue, 14 Jan 2025 03:46:57 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fc5csm173943915e9.2.2025.01.14.03.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:46:56 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A20F45FA1B;
 Tue, 14 Jan 2025 11:38:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH v2 20/37] contrib/plugins/hotpages: fix 32-bit build
Date: Tue, 14 Jan 2025 11:38:04 +0000
Message-Id: <20250114113821.768750-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241217224306.2900490-11-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/hotpages.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/plugins/hotpages.c b/contrib/plugins/hotpages.c
index 8316ae50c7..c6e6493719 100644
--- a/contrib/plugins/hotpages.c
+++ b/contrib/plugins/hotpages.c
@@ -103,7 +103,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 static void plugin_init(void)
 {
     page_mask = (page_size - 1);
-    pages = g_hash_table_new(NULL, g_direct_equal);
+    pages = g_hash_table_new(g_int64_hash, g_int64_equal);
 }
 
 static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
@@ -130,12 +130,12 @@ static void vcpu_haddr(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
     page &= ~page_mask;
 
     g_mutex_lock(&lock);
-    count = (PageCounters *) g_hash_table_lookup(pages, GUINT_TO_POINTER(page));
+    count = (PageCounters *) g_hash_table_lookup(pages, &page);
 
     if (!count) {
         count = g_new0(PageCounters, 1);
         count->page_address = page;
-        g_hash_table_insert(pages, GUINT_TO_POINTER(page), (gpointer) count);
+        g_hash_table_insert(pages, &count->page_address, count);
     }
     if (qemu_plugin_mem_is_store(meminfo)) {
         count->writes++;
-- 
2.39.5


