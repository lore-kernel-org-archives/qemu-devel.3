Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C4EC369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JTI-000735-8E; Tue, 22 Apr 2025 15:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSO-0004Kp-Hh
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:39:02 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSM-0007Nm-3b
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:39:00 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-227a8cdd241so63321705ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350736; x=1745955536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TEwojCbipjqc0WV/gEzN3cyq9jAbkGKw7ev6nih1Z3Y=;
 b=cGCcNQ5ZosQ8BSQDnn+ON4ntj3J4SXznHI83lPH0IeyFufnwPppAimxZTcSmTRV7Rx
 Rj2h/vJq2vOlHCvegLAaIuU/AcYECVV1BkFocCnSr9xqSz178gXeJSQhC3txCqwsbbS8
 0KCLoJllvkAp6m9pdHGbpxrIu+eqtX0W/mTwcn+wud+gJ3cWtX8vbuGng2jaqJodQ6oI
 lwGfWbkgxQoTeDNYCutue9Ltr7H0MlxtoddaidtpG8JU/zXAk2BmvwwcCheevFl2Sgs5
 +0XGDFN+a0i5WyAINIFobXE4twWNFhlEPTB+f4siNaGc+KzWKtNTYFRXO9d95u3HrRgi
 sDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350736; x=1745955536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TEwojCbipjqc0WV/gEzN3cyq9jAbkGKw7ev6nih1Z3Y=;
 b=iuMd9mlsHK3h7hNcryh6YFWX9WnbXNBE45WBieI8KvXjPiUQ40VmsfqE14iC/cOkNa
 589vAaBkvU41+wSoLNHJZpDyeCAXcE+YroaB+CXf9aNziGzztFsWDi6P6Dkl18d6tdwD
 pDLCuH16mjq8xsUBBEjY7bPkv1bd/imNBpWls/ciutEGEyqlBFBHmx2ZxIoA5eIVLj+C
 bo7batNoyjCuYDrzcMSmGm0RqHR4HdRxcUG2WM1JixMKOqHYe1yTd+WmvdAPp/ZTpxL2
 uQANP9ReYhFEURac8M5MxflKm7sauNjJXJYXqQJO2nXL6sTH48DtG55Iz+FzCV2zesdE
 cgBg==
X-Gm-Message-State: AOJu0YxZ5/6vh/LriSPfTeATZJcQk3zCKrbrTIen8d847zH9jHHyWHR/
 H8VVtcMT4Er6JsmxyKXLYmG5wmifSZHnQY1ZJa2t9Nhx2iAO/EbU5W0Ac9cZMuDPPtRDyCb4ATb
 +
X-Gm-Gg: ASbGncut+laKscsXtN81KdQF8yvjFnWGW5uSYH8aUuuPF/m2DHi65bncScuRO+heSHJ
 zTKdySLmgm8LTAJruvPFXOWoFIr8ZViJMwQlzljDm8gC8Isvv/J4wUi9LkjDAtzyVusWCT/xs+G
 Pa1m8fAxwKhpQzCfvBgvRjN4zzCfvQSSDQ6XZgLC0jiognlH9VlZML1cBP0t1TzaHmn0H+w5zJy
 PcHGp7NZ+N4F8gsAPqkFLTqbmn3fTvEx6UtYXNrPTADJqHUZSva7ZfH+T9W6mTrp7WEtzvoaGWT
 He7oNO0KnsApoyhBmVB81NeGpXD32SgATJwMjYO6Ayms6seCHxX5ipCqrPMYAK5KlTW0PDVgXVE
 =
X-Google-Smtp-Source: AGHT+IEdUaFWvn4BeGRMQOIvuqvJWRDxm99BmpQxJ4FNr0dXBx0nvnMN0SQVS8qUxsU3P9F5wdIwuw==
X-Received: by 2002:a17:903:1b6f:b0:223:90ec:80f0 with SMTP id
 d9443c01a7336-22c535a6192mr290496325ad.22.1745350736133; 
 Tue, 22 Apr 2025 12:38:56 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb484dsm88951765ad.148.2025.04.22.12.38.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:38:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 144/147] accel/tcg: Move mttcg warning to tcg_init_machine
Date: Tue, 22 Apr 2025 12:28:13 -0700
Message-ID: <20250422192819.302784-145-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Delay the warning to tcg_init_machine, because we will
have resolved the CPUClass at that point.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-all.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index fa77a4c5a2..ecdd48847c 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -93,7 +93,8 @@ static int tcg_init_machine(MachineState *ms)
 # else
     bool mttcg_supported = false;
 # endif
-    if (s->mttcg_enabled == ON_OFF_AUTO_AUTO) {
+    switch (s->mttcg_enabled) {
+    case ON_OFF_AUTO_AUTO:
         /*
          * We default to false if we know other options have been enabled
          * which are currently incompatible with MTTCG. Otherwise when each
@@ -108,12 +109,22 @@ static int tcg_init_machine(MachineState *ms)
          */
         if (mttcg_supported && !icount_enabled()) {
             s->mttcg_enabled = ON_OFF_AUTO_ON;
+            max_threads = ms->smp.max_cpus;
         } else {
             s->mttcg_enabled = ON_OFF_AUTO_OFF;
         }
-    }
-    if (s->mttcg_enabled == ON_OFF_AUTO_ON) {
+        break;
+    case ON_OFF_AUTO_ON:
+        if (!mttcg_supported) {
+            warn_report("Guest not yet converted to MTTCG - "
+                        "you may get unexpected results");
+        }
         max_threads = ms->smp.max_cpus;
+        break;
+    case ON_OFF_AUTO_OFF:
+        break;
+    default:
+        g_assert_not_reached();
     }
 #endif
 
@@ -153,10 +164,6 @@ static void tcg_set_thread(Object *obj, const char *value, Error **errp)
         if (icount_enabled()) {
             error_setg(errp, "No MTTCG when icount is enabled");
         } else {
-#ifndef TARGET_SUPPORTS_MTTCG
-            warn_report("Guest not yet converted to MTTCG - "
-                        "you may get unexpected results");
-#endif
             s->mttcg_enabled = ON_OFF_AUTO_ON;
         }
     } else if (strcmp(value, "single") == 0) {
-- 
2.43.0


