Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F23FC83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 11:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZpDR-0005QK-CC; Thu, 10 Jul 2025 07:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZpDG-0005OY-2Q
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 07:13:15 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZpDA-00074b-PJ
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 07:13:11 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-453749aef9eso2872105e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 04:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752145986; x=1752750786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=h1wZWfq/2UJSPBdldh3OwyerpQbabStLVm8h8iaqLJM=;
 b=a6WClqtqZKNVe+w+n/CJtCDPNIAa4dUvij9+mv/G1V1BE0GR/lU1iR9pYrHby12sNY
 1/DQIgOj7cpF7M5hwXpRACg3cKJgEHn1sdWtOSSmv7AHGmmdHcs0cI7lUUF3Hx2svqQj
 kL0VnIqV3x6KlD8X+HF6ovu+WdGRfeEWOx71vZsnaxPvSEXK8puGirPnyhMAbU8Lozaf
 r88i7M2jKALB+y+wijgadbU4m8ao7y5jWEl2PMSoD4Ja5c5S18DbqrP7bKYIejusbH2h
 k2lVqIfoKFlA4/88ihrQLCV7KDi0AYJ3bQNddFZxTfqZfu3hCu/RiQtD4vBX+e0lyXCi
 J8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752145986; x=1752750786;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h1wZWfq/2UJSPBdldh3OwyerpQbabStLVm8h8iaqLJM=;
 b=w7U/Vuvs5SyLo3PnBfrTyzsrRTHUzte2MMd0vfpotgYEVW+N44AHJfqi/oWYj6xILV
 XfMm7l2qkL9UR3ZGDpdzp/9QFoN7r6UXQ9Xrr7CdLKuQuI0yz16QS40vl5a4SEiEzELE
 XCCxDXR9/tuY6fsE3E58CEqeaDErFo5bKHOV/bJoG246X6QFIFjsamN1jC4bNbtpABjP
 fY7PP40fB7qblPjJoDc3sj5Lf4wQ4o0/2rA637uoKd0zQ9xTX69z8VrFG/OJe8aFMq9u
 os1BHUIUco54HXhGqlajAGTEjF7Dyxfz2EuVSRPu6LauQ0Q4EL8LcUC+p8OFvYNFWf72
 lhSg==
X-Gm-Message-State: AOJu0YyXQ6n4GxNutn2ggsm6dpskEZaVTBkla6RsacJnM95Rh6AFr6FU
 TZdkQ3ePx6Aj9/zcy4bslSv80+PKUWQ5M82fZgE3aVn+Hgj1oJirdvHRU2tKRpTdK/dTFflkUhK
 7ZinUogg=
X-Gm-Gg: ASbGncsH/ByEblbGLbXtYWnGEn+c6/shYusmwV2ixla8iFejS/L5Q9iLcTi2e32C+UZ
 +uckgRsFlfj+1qvmqDluFPUXQKgt3zxJ3d8Tm4d9qyt3V2UsXUidnNnDLFi9UMpzVGavsgCQSzr
 iUTsGfM72jgCdhDSj0uoiijm/dlJAnKbeir0E93eL/8J35zoM2VjVdabJjyCWmwo9YTKSOsJFZx
 UAf28L/5cKw13KMDMBnf2/NXVq2ZUBygBZuvX7NGJCVoCbqyWkGt07673ZeTyCMN8s87yO8O+SM
 bpq80RHD+gtbhio3/WAzqEPLIrsdawVnNx3Xy6drCKw9rGyOsXybz+kNfcDqSM5vWAXPTpLZBQJ
 VO9212bWFS1bHu/gBs7sOXGUgOJiniyb/u75biw==
X-Google-Smtp-Source: AGHT+IGGCydWgtmASFlaXqT0/7MObWznQZZf5PBdEt2Kx/nrJCRJ/8Jq4DnLQ0cI6aEXbEQQJuCqeg==
X-Received: by 2002:a05:600c:3514:b0:43c:f3e4:d6f6 with SMTP id
 5b1f17b1804b1-454db890f27mr38624295e9.31.1752145985729; 
 Thu, 10 Jul 2025 04:13:05 -0700 (PDT)
Received: from pc-248.home (lfbn-mon-1-970-120.w86-227.abo.wanadoo.fr.
 [86.227.5.120]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d5032ff4sm55658045e9.8.2025.07.10.04.13.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 10 Jul 2025 04:13:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] accel/tcg: Do not dump NaN statistics
Date: Thu, 10 Jul 2025 13:13:03 +0200
Message-ID: <20250710111303.8917-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
---
 accel/tcg/monitor.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index e7ed7281a4b..778b12613f4 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -19,7 +19,7 @@
 #include "tcg/tcg.h"
 #include "internal-common.h"
 #include "tb-context.h"
-
+#include <math.h>
 
 static void dump_drift_info(GString *buf)
 {
@@ -57,6 +57,7 @@ static void print_qht_statistics(struct qht_stats hst, GString *buf)
     uint32_t hgram_opts;
     size_t hgram_bins;
     char *hgram;
+    double avg;
 
     if (!hst.head_buckets) {
         return;
@@ -73,9 +74,13 @@ static void print_qht_statistics(struct qht_stats hst, GString *buf)
         hgram_opts |= QDIST_PR_NODECIMAL;
     }
     hgram = qdist_pr(&hst.occupancy, 10, hgram_opts);
-    g_string_append_printf(buf, "TB hash occupancy   %0.2f%% avg chain occ. "
-                           "Histogram: %s\n",
-                           qdist_avg(&hst.occupancy) * 100, hgram);
+    avg = qdist_avg(&hst.occupancy);
+    if (!isnan(avg)) {
+        g_string_append_printf(buf, "TB hash occupancy   "
+                                    "%0.2f%% avg chain occ. "
+                                    "Histogram: %s\n",
+                               avg * 100, hgram);
+    }
     g_free(hgram);
 
     hgram_opts = QDIST_PR_BORDER | QDIST_PR_LABELS;
@@ -87,9 +92,12 @@ static void print_qht_statistics(struct qht_stats hst, GString *buf)
         hgram_opts |= QDIST_PR_NODECIMAL | QDIST_PR_NOBINRANGE;
     }
     hgram = qdist_pr(&hst.chain, hgram_bins, hgram_opts);
-    g_string_append_printf(buf, "TB hash avg chain   %0.3f buckets. "
-                           "Histogram: %s\n",
-                           qdist_avg(&hst.chain), hgram);
+    avg = qdist_avg(&hst.chain);
+    if (!isnan(avg)) {
+        g_string_append_printf(buf, "TB hash avg chain   %0.3f buckets. "
+                                    "Histogram: %s\n",
+                               avg, hgram);
+    }
     g_free(hgram);
 }
 
-- 
2.49.0


