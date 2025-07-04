Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A87C83F05
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdRm-00062E-AG; Fri, 04 Jul 2025 06:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdRk-00060u-4z
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:15:08 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXdRi-0006bS-9e
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:15:07 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a57c8e247cso556502f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751624104; x=1752228904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/bqUcP0GVFbZdYz0pOg29PIjT2vqEhewVl+kCu78NhM=;
 b=SR/BTxBKqo8OREH087+Q6Xo2damESwPeyvoMbHTNijfnsCbvJu2vmXEy2e8KtUNc21
 5J80RggrzF62lCZjS+3t0RaDTXlGfgYF0nIaIW97jjZA4A49dasixh7x6+xxvtfOCMQN
 80I1WSCMe1OjLtI5UCnDJb0wPaQKOaKdCGn/cmUcM838D4Q0b+FiYcdzN9DzgOKZRl9I
 bbZIkfcqOalZHXAqINT8dLu+z2ft4tCTK5rMfzGmo37kEeCuDpS2+olL/LUfjOScYcCW
 2dnOqWoh9yXAERPrJK/5aCuyt70KXwdKshijPgTtLP4tO/syLlVgwyQ9fTceJ7R1nx4K
 Bfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624104; x=1752228904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/bqUcP0GVFbZdYz0pOg29PIjT2vqEhewVl+kCu78NhM=;
 b=ct/2ha80ZmeZUJKjwgLoYZNPMosZEJgokCb/J3y2eo5WNV6pwpIN9ZA56obX8TZYQo
 Q0xX+VgXVS7C+aUbUoELIGUxqcHuMY5ecPumCqzwAAMX2uGDTFuKqEE48HMIc/RNJsN5
 W7X1j1Zxy8lSzv61fd/D+32VRPhLOqr1Zs+jqZSyUQw4Hn0zwoNHIp0NSMR1mQ0B4mwr
 7PTgF84xwG+XQE8WOIw2oWCcHKhN1P3GhMi+eKP7LoqYPxnK1W9frDFpnHor6VjufaeJ
 RgcI6v97ubq31doraMu++fhmFq+DcHMabv//LI4jPR1c7Q6rUvJJj6aqOrA0U7tuF/er
 1GsQ==
X-Gm-Message-State: AOJu0YxKOM5JB8x5sS6FZr1okhe3nPpXXHa+4Pd05AuZdnFCfp2g41nt
 rQDzyE/zizvS4m+wQZbyH7ZVGrhyScZSZNHtCOXCKiJfzBvSc7exf6y11z5Bbk6DT5rO2RuOWF8
 V/npIGO4=
X-Gm-Gg: ASbGncup8i2nP5rokSjHBicsueY/axpLGY+ACwKLRinRJH4L8l/kPVYX/bve8nl9hEB
 6zLvqnxPeG2qbmGN0yVa8fR32xhVv8eTLV+4wUZjdiNmQ44zM5D7Obsw9hCS9KktQbU4JViGxzp
 sU7HHE7JZW9l07YjE2JCDOi4VZAL9+dIXWgFgVZG7Elh49kjsJxD7fSAKIVXCp7d2wuShQjYLBz
 mTmhsEMlKhKFIZsfH1ep/0KdY2Ht+9Cr2CbV/uQHN2R5JVCfMuMWNj4SsrVj7rLqd7v5Z1T3L25
 sc5fguXdqKIF97B2gVQcqv24iF6WYJSY7vfdGPq0X0ula96kQFQWIDt8bfTG6ZzzZhrSuXhMfTI
 ZPDC4XiyMzgYPBHubTA0p7kV8RkKgfpPhixKMMoMGRY8mOB4=
X-Google-Smtp-Source: AGHT+IHiafN3IWpLkHqEVFEliylHLlMrRUUSCAHl9rg1a4gpxh3Bm/bffoNyceSVT/WrlBT4J2UIwA==
X-Received: by 2002:a05:6000:2011:b0:3a4:e480:b5df with SMTP id
 ffacd0b85a97d-3b497038f48mr1291588f8f.44.1751624104114; 
 Fri, 04 Jul 2025 03:15:04 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b968ebsm2077004f8f.47.2025.07.04.03.15.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Jul 2025 03:15:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/31] accel/tcg: Factor tcg_dump_flush_info() out
Date: Fri,  4 Jul 2025 12:14:07 +0200
Message-ID: <20250704101433.8813-7-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704101433.8813-1-philmd@linaro.org>
References: <20250704101433.8813-1-philmd@linaro.org>
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
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20250703173248.44995-10-philmd@linaro.org>
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


