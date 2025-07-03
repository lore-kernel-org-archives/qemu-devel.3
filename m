Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39683C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 17:33:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXNoc-0005XU-R9; Thu, 03 Jul 2025 13:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNob-0005XI-82
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:33:41 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXNoY-0008JI-Ez
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 13:33:39 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45310223677so853135e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 10:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751564016; x=1752168816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KA0b8Mx/diMOpz5eVRAgzHisGcdWtT3pud+mD+Gv0yw=;
 b=iY5J1U4cZwuYbmCqVT37sh/UWtaDghXCGDA1Wtc3y//feETEYbjrYE+OpRRAPoS2Xz
 r8bPIYGA02DytedHL+wjdlbDbRBxpwcj8USkeKCNuDy7q83mgc1NJRaptXujlTuc4VQC
 sXdxJlkf7xTe9NAr2E1DF/XnqNKMFmULqrI3K0QVCDdjwx4xmjW4wMSNVAqLVkruw/QM
 5DolwY7vyvdouUqWQo0F57sUVyRuLrFIe8feULVw/+F9HjFTqY/NQmSp50iMzjXCNZXr
 kYO5Eisgjn06HXtfXYfssfRnInB/y5lNEVUBP+1qgFAfqNh0tiWCAPCp5cbzdl8RK6rb
 qlmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751564016; x=1752168816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KA0b8Mx/diMOpz5eVRAgzHisGcdWtT3pud+mD+Gv0yw=;
 b=iuv3ROsIBaPYMnchEZtWSs4OSKAk8m+/TC3VMoOXTpQSg0wu0fAnZfTA8BEKFBrT9V
 Mmb76CixIzF8hlMZT1jfEN+aKpH+OdZ7ClZ6Gd/IVsCPHlRXOKLj2yX9JcXTs6tCudaJ
 OFTfXlSWG96M3vH8atOze50NWdNG1oQ469iKvl9jhAnGv1CMH21/3DmAxqoFh3PeR9n3
 /lE/SUOwkD6ZCJhEL1zr1m0B1V8EoWYgmJmXK1LjYRjD4dBWxhzHH0N7v8hcXajFOeYl
 PzZRUOZxjUvwk2QrQt5yHNmSiUFxJMFJCyuj6xmK4YH9c5Da+8gQFwFL+klc/gVj06k8
 shYg==
X-Gm-Message-State: AOJu0YzHdxtZLMqInUSVms0lDneZS8VMjPj0RO58+AGu9ixYgyblhAz8
 FlNz1DlYOOlOUsIJE0FudGBDxxiVcPzQ+Y/W6ewU+f2zMSd7cttL09W6dm1QDt5idiXESvj7iMM
 XlVzMJKw=
X-Gm-Gg: ASbGncsafPXiJjQ/7F8JCgmte5xjjUqKAiMOYq8heqGb53hSYB6GqY1B0jHDOlivLw1
 lYibxNkqMRuTJmdW+ZcuF5n1KXeYDglSCTH2j8SLuMAwIfYFztjF7296oZrOarfiYnOMtYvjUJJ
 hnQRvkodgWPbDYsSWvx6DsWfGDxl1IjqjD0mx42EnFKJjsAVJ8hMD6/ONcHzX35W/UuZCn37RAc
 nNN/vE6WI7ZowX83RXLpq7MTLE0v0D2SU+cNijSLbHliKVmLhOECbIlIQT64NkodtoclUlzwu4S
 JKPQXrekJAmjTIKfstzrkjKmsnAzDAFU7uRFoQe2V7I7ztKe03l5nOSqopeIbHJ6HMlEeW8uYCP
 mnUDG1V5j+SOqPnw7sh1nqTN+hkXKiKmyVJyW
X-Google-Smtp-Source: AGHT+IGrLN692bB7k8Ayl5O7V9o9uvyHI0QE3MSkBBI4qxyi7en3ThLvxe5qeQ6PPc6pGdIGwE3q0Q==
X-Received: by 2002:a05:600c:4752:b0:441:d2d8:bd8b with SMTP id
 5b1f17b1804b1-454a36e2c39mr83163645e9.8.1751564016216; 
 Thu, 03 Jul 2025 10:33:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b1698e24sm3369755e9.34.2025.07.03.10.33.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 10:33:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 09/39] accel/tcg: Factor tcg_dump_flush_info() out
Date: Thu,  3 Jul 2025 19:32:15 +0200
Message-ID: <20250703173248.44995-10-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703173248.44995-1-philmd@linaro.org>
References: <20250703173248.44995-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/monitor.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 344ec500473..6d9cc11d94c 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -141,11 +141,26 @@ static void tlb_flush_counts(size_t *pfull, size_t *ppart, size_t *pelide)
     *pelide = elide;
 }
 
+static void tcg_dump_flush_info(GString *buf)
+{
+    size_t flush_full, flush_part, flush_elide;
+
+    g_string_append_printf(buf, "TB flush count      %u\n",
+                           qatomic_read(&tb_ctx.tb_flush_count));
+    g_string_append_printf(buf, "TB invalidate count %u\n",
+                           qatomic_read(&tb_ctx.tb_phys_invalidate_count));
+
+    tlb_flush_counts(&flush_full, &flush_part, &flush_elide);
+    g_string_append_printf(buf, "TLB full flushes    %zu\n", flush_full);
+    g_string_append_printf(buf, "TLB partial flushes %zu\n", flush_part);
+    g_string_append_printf(buf, "TLB elided flushes  %zu\n", flush_elide);
+}
+
 static void dump_exec_info(GString *buf)
 {
     struct tb_tree_stats tst = {};
     struct qht_stats hst;
-    size_t nb_tbs, flush_full, flush_part, flush_elide;
+    size_t nb_tbs;
 
     tcg_tb_foreach(tb_tree_stats_iter, &tst);
     nb_tbs = tst.nb_tbs;
@@ -182,15 +197,7 @@ static void dump_exec_info(GString *buf)
     qht_statistics_destroy(&hst);
 
     g_string_append_printf(buf, "\nStatistics:\n");
-    g_string_append_printf(buf, "TB flush count      %u\n",
-                           qatomic_read(&tb_ctx.tb_flush_count));
-    g_string_append_printf(buf, "TB invalidate count %u\n",
-                           qatomic_read(&tb_ctx.tb_phys_invalidate_count));
-
-    tlb_flush_counts(&flush_full, &flush_part, &flush_elide);
-    g_string_append_printf(buf, "TLB full flushes    %zu\n", flush_full);
-    g_string_append_printf(buf, "TLB partial flushes %zu\n", flush_part);
-    g_string_append_printf(buf, "TLB elided flushes  %zu\n", flush_elide);
+    tcg_dump_flush_info(buf);
 }
 
 HumanReadableText *qmp_x_query_jit(Error **errp)
-- 
2.49.0


