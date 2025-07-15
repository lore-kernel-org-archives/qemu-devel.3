Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1277C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublkg-0002uR-Nq; Tue, 15 Jul 2025 15:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublb8-0002ql-3v
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:45:54 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ublb6-0002hr-7Y
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:45:53 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45618ddd62fso26976155e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 12:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752608750; x=1753213550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BSy9aVlBgxijF+Ou2qWAHloWsiUymVdjDuqFpB9M18s=;
 b=kjD/fDAp88hn+eSLd2XUcv0YbPKDg3tGDJMkB+KaEAMXBffwW+GKCtIwAbdIjbRLhX
 acB5nWH+6AyPG/EstHzElsZ4Xpacb5hTr2EBrhIJ+3X+SzYhNy1yrNNralfi1gNnks4a
 BLNHfsjRrQE3EfbAc19IPAhpoyKoMUEuqPeiFSYC16aGzJ1+qvdLSR74CDBVhU50n/Jp
 ak+3YBzS4a8nJbBJAs+OA3NwmguJptNvaWimvmJ03Bz3X4pCX50WUAD5nMmy7ZZGBl0J
 6YQ06GsI5eB9QI+ZneIFX+jpt8ZOu0l05NLWqzpN72BnUFTcx+PuoRW22p3dNHgKnFaa
 cBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752608750; x=1753213550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BSy9aVlBgxijF+Ou2qWAHloWsiUymVdjDuqFpB9M18s=;
 b=StbpYuq1YICkqzmRK8YGXw1CduLFbjYGiK69LX03gJewaFdWc9PuIh++vK6F1iBzDt
 pSwlRT89gyORml6ByT1yYODD5gJN1V5vNRNOEi0TcAZxL8m1Zm8+pLXIeGGwyyo4AnuC
 UCgFJhG9kIqs6qx46Go0mzCWqenn2M9WlgRCASyXtBFlk4ojzyea0L1DuIyl7GY8V1y/
 rQWMxAu5SPMXsVO/efEXeJOHVT/QE/jKMG1KH6gMq18aRUJC7Rx8A96oiOxCM6ZUPHVm
 DUMcIykjTixbDWmiLAQkWnPZwbfElH6H2Q/pb/RWN9IommYMYmVlofHIH64PcB1gpCSt
 RfHQ==
X-Gm-Message-State: AOJu0YyDmjTED5exlMtoJWnn6+FiqBUdlOKBu/zzZ/V43j1bUF+tsjkV
 02AL4z5ON4riQhp6g8scfts8HCdaz0wiGI2+ToY3n6SIGoqZnaEesIMVhtXoLxCZz3Y1dS/SV4k
 iHRz9
X-Gm-Gg: ASbGncuDxWCNM9xbgw+DZhtYyaRreK94M7/7m4QBI9vbfJyEmmUbTjeazYufkVgsvMl
 PwPay7AkTn4CFwApqPOljo0oqfFArb2xBcFJVWpTYKoWRCIHAqp3bDYFFrTphym+yGJzE0J/cC4
 JveXFAv0255ljH5wg1Hd7wqEpguft6Obyz3TdjqauR97R1WwZr0yvz6lKk/UKZqbVs9nThIoeqL
 3jdah1nwkQcncY8WmKJRtlc5wUOOc2Cjb0/4THTavLMDYcJ+/jycJ6mobbAnHyNDkBNhPjpcJCX
 tAtrlgDqB2UbdrtqtpLPKIwVp6vzWqS1ozYam9MzvwVvooKtwOvLr9Duzncxj3o1ZrcfQQLe74d
 J89E6KmSXBdgZ9cY2fNoz6yPKJWPfzEYllvgOlKMIgaYBIwT9eohcEs0L0+wEZmpE4VRhm1v4NI
 LqgTxEeyJE9Q3A
X-Google-Smtp-Source: AGHT+IFWke2DaMwS+JRGE8oZj47NTbGVsLSP6yIA61ULQ/3e/LJ7jM+M52uJhLbaMWn4BfeAvAsvrQ==
X-Received: by 2002:a05:600c:638e:b0:456:18ca:68fd with SMTP id
 5b1f17b1804b1-4562e389d48mr833415e9.10.1752608750177; 
 Tue, 15 Jul 2025 12:45:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4561efa9301sm54593425e9.24.2025.07.15.12.45.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 12:45:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/17] accel/tcg: Do not dump NaN statistics
Date: Tue, 15 Jul 2025 21:45:05 +0200
Message-ID: <20250715194516.91722-7-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715194516.91722-1-philmd@linaro.org>
References: <20250715194516.91722-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20250710111303.8917-1-philmd@linaro.org>
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


