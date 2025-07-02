Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0794C8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2dj-0007AM-CN; Wed, 02 Jul 2025 14:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2dQ-0006QS-1H
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:56:44 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2dN-0002WK-46
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:56:43 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a588da60dfso3068261f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482599; x=1752087399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HbtMMfTGvsSTq8PxfWtAmmbIIbgaQfV1sw8UTVP93vI=;
 b=iXjJmINNyc4cftnVsUMpH6d6ZhYYySvxOnz5UtlHFIEHs4y/dGBpuIxCjLo3Lq62K7
 Xp2bqHQ9VLuD8DYjRfHfO5P0nTkkVU4o0oneYho2WI9C9kqyARTboEVkU2nyTKQucJNU
 ZPLqYbqlpxeTxd31F2u8goAPM2fL9axIcwWNHaiuaswy+1GeokqXqbhFyIdpePExOQiC
 E8pUzqI96o7DMtSB2eR3bbrUWuAuPuSdGZ+ImGulz6FxzI3Q65/+TPbXCksPzRlP+t63
 BUFhF7Bb9eGwhFphmuFO0vr8p4vKB6g+hA34abqKx9vAdSoezNy/LAxVNhMRK/8unMSb
 U35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482599; x=1752087399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HbtMMfTGvsSTq8PxfWtAmmbIIbgaQfV1sw8UTVP93vI=;
 b=I6ClQ6snRKVn7itcbq+X+6K3qfX9sHbWDjySzWbVIn3ODIP/3xmbJMugYWVL+6LCEA
 CYLjv5Nucnv7httu5/2sjBbswPetozXTJ1Q1rYD9D76KL4DqCHBVtTIUmE8WtspunKob
 B+h5f8W/+Jnvh3o3CUyUEl8zhapOcOiuFLKOavtMX7LtFrKGoriHL+CQTkwgjXEGx6A0
 nwKGO9hsJv59xR7vsaWHhw8ZgK4Hhhq7wiZTJlwxKSWFS6AkcOiGQUy2rxyvZT2DL5QW
 kMsqNRvd5OlImJKtyrSfDWcK+wk5m5VOOOYS2YpKr4/eKb1+Ia7hBK1Ylf4+JLW35vFZ
 Ej0w==
X-Gm-Message-State: AOJu0YxGzbkR7wFKuRy0FszjWhwsv9JY1PnUsk2Udmir1MXg8ojAH4Oz
 IzCLzht4qKJxzacgCdorTjeMToA1VEmZOWhkXapSZ5gCoPwWbwpv751+H3eSlU80lP8lCkZrGrd
 HWO99
X-Gm-Gg: ASbGncvMYfE8eDnZpJ3NRDn+rVquAWJ1X/3buZPMWq28wnaJsNsPIH7NBhd215gGdny
 SUtaNBayGpg7skKWpd2/ZHQmS+nlb/UYuQQkYJzMcm0RmfecVdnk93XIKBW8OFvEi+SDkrFk2Bi
 GiA67QKJ+2cpK+siE/MnKItlCZcUaltIvqmbgg8DLR8bi+u6ql3RQHWT+C8w5lcapQN/Y+VQnZc
 5NZtH76Epc5aXd3glUN4WuOZF1rT1XIAT8MH8aee46Och7Z/o3900a39OA9o8r7OjPX4d2JkRnS
 nO5JeI5s2WRzs9p/8jy6gq3PhnJGSzOlwyT6yJC5yp/f4bAbL5kEO+xtxEDSs/X5+ymXYfWbK46
 HrN2INS44kHfTbfRGeEmeBEDt3JcDD+r2HoZRjlVLZ9z2eOE=
X-Google-Smtp-Source: AGHT+IFkQww10hbhm43S3pkTjnKIoi9bghBL6Eo1X1DPDUp3vTlYiiCw78fD7cvz3WR+ZnecsAAO6w==
X-Received: by 2002:a05:6000:2a88:b0:3a3:6a9a:5ebf with SMTP id
 ffacd0b85a97d-3b32c477c9cmr216065f8f.20.1751482598987; 
 Wed, 02 Jul 2025 11:56:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52a5asm16884357f8f.54.2025.07.02.11.56.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:56:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 25/65] accel/tcg: Factor tcg_dump_flush_info() out
Date: Wed,  2 Jul 2025 20:52:47 +0200
Message-ID: <20250702185332.43650-26-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
 accel/tcg/internal-common.h |  2 ++
 accel/tcg/monitor.c         | 27 +++++++++++++++++----------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 1dbc45dd955..fb265d0cefa 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -139,4 +139,6 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr);
 void tb_set_jmp_target(TranslationBlock *tb, int n, uintptr_t addr);
 
+void tcg_dump_flush_info(GString *buf);
+
 #endif
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index 5bdd837006c..3d024e250a1 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -146,11 +146,26 @@ static void tcg_dump_info(GString *buf)
     g_string_append_printf(buf, "[TCG profiler not compiled]\n");
 }
 
+void tcg_dump_flush_info(GString *buf)
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
@@ -187,15 +202,7 @@ static void dump_exec_info(GString *buf)
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
     tcg_dump_info(buf);
 }
 
-- 
2.49.0


