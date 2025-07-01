Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D921C8303F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcCH-0000aP-Pn; Tue, 01 Jul 2025 10:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcC5-0008VC-Ep
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:42:46 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcC0-00070z-6j
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:42:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-453749aef9eso21795835e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380957; x=1751985757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ak9lJ0hh+/7PhnazZCq52FhrKz95d2xKMt0q99+YMRA=;
 b=oVn1WuhV+Sd5NUj4Y8ZIlHrcIZ68bJ6wAnOT/n3Kkb2AlqDdG2BcuzIhGvc/QFUVUG
 +rQbWWWaeOiblNV49feE5WxxZsV5GHzALD9YG/xGjsriv0UwEkgaMiyrs+RpGMRgUcGb
 YeOs+Bq6ZLuzw9+7qE7yDeZgtf97KBwu1PrBLmzaYudK6IDgMcHBQSdOrX6mAibp0kXe
 V/Ye7OoRZx9TP2/8xAegVdsUyL/O10qyFloiFmx3x3iXPFLUfwVqQ99dRWStqpGqbiuX
 wuGm6AcoJ86TRHbdu+k42V2nFTc40Gm1Zt5kyc8iwHEEViMr/Dih4wVSrMquZoJD4WoN
 Sg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380957; x=1751985757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ak9lJ0hh+/7PhnazZCq52FhrKz95d2xKMt0q99+YMRA=;
 b=YRu06PA35hafxuGCQmKSlbLruiaOYqXvXyKJd1DzBFmXY081QcibXBL5lmYBEoOF40
 b+Ba3YX1hCtmi55+NnWWEDyNjbVAk1ru0XYy+/GtCIemiXLqkh3oXXG2P9SLDWD6qYEh
 Mvwutzi9kwD/uv119pKEsQgAQxx89vCVpptgmd8SCZyKbWULSwfNYZM3QY8BWyNm1Zg1
 EToBqFy0Xnxc9PMNcDbLjPc4XJgb70ZxDtcG802+inuDT/neNjVFQK5xFIoVIdcd8BGz
 OIzjlmmHIakvnINx7QZa/RxWj2IOGAVyDytJBO0J4kVC3hA8X3XZmkzahcsVy5zV2DUv
 Hv0w==
X-Gm-Message-State: AOJu0YyTljTpTpASiH/+l4gvZg/EYeYEkDRBRFFhqwnaHMZJ/+SWDuNp
 O4O1pUWQcCbtTBLd+A+xhf/ZEUmJbBkJjLAhvqnHGn6peMFENfaY9UXrAh9hOTkBOy2G7GpuWkw
 NR45j
X-Gm-Gg: ASbGncv4z1kb0SAP2QXID0vFmSZcPp3c26umeZ7wY3GUcs0MN0VlJyLpmjQRkW8tiMh
 mQUbGujqowyh3BsC4ZAXMvxWDJhgGcHr0AqzlNqQ7QvTaKIqAUNt8GQJmb5NKe9rTQC8NbysYVo
 wpIAmTen0f/F31cn7BCMoMJqTAZXs01wuWZfjqvw+kQ7ZV6IUnaVG0UJvVDUKNKNz3A6v819XDx
 AHhA4+JwKGg/w86jNjqW3QP2ySxGxug/G3heW9FhHuogtLXSEgEBsO7eBmi7e2B1M882+TfPGFE
 69nZB3otP4ngrzGeu4Ds2dFnUJO8fsIAfa8zYtk1I256sh6hvbK7THMZ0hkLEDc/59qL617/Iq4
 2Gfiw5Qmsq5mYqA8pS9JbG3pHCoc9TNrnJ6H+ZF3eojbtyjU=
X-Google-Smtp-Source: AGHT+IEtlY42MMUw43RFNymXkYTRYGuOzaf0Ffxi+95ETpN5dU5eUllvEu7j6F7jb90EBlMCyAkPwg==
X-Received: by 2002:a05:600c:a089:b0:43d:b3:fb1 with SMTP id
 5b1f17b1804b1-45391c5ae8dmr165982725e9.27.1751380956627; 
 Tue, 01 Jul 2025 07:42:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e528a9sm13688798f8f.60.2025.07.01.07.42.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:42:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 25/68] accel/tcg: Factor tcg_dump_flush_info() out
Date: Tue,  1 Jul 2025 16:39:33 +0200
Message-ID: <20250701144017.43487-26-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
index 1c182b6bfb5..5f74881f2a3 100644
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


