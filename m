Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A0DCCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAyAF-0007wp-1P; Mon, 20 Oct 2025 18:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAyAB-0007tY-8b
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:15:35 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAyA8-0006oF-L4
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:15:34 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so38518475e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760998531; x=1761603331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZb4bRLl32INwLUSG+fpNojV8szKnj+JRZ8eDE6DgN4=;
 b=DvNiEMmj+KgzYTDoJgKZQuyYRKmKGICtYj6obdqCxaH6RRazk0mbdk188XKuKutVf9
 5QxW6fQfJVZFJAWLj2IqqLrP4UYarNC0k7j8e5hNkrn8Lj7Z5c4h/2wZJFgprqfuq8aQ
 Okb+f3P6Njxq38pE3INofTVFAaj9swayuJnBtOzXuy4tvu1VyDDLShUbgVy7xRFgEtc0
 beR9DF5JzFYiEP27HnvAGi3S6ltrTxs6vs7VQVmXIA6PjkSF5aBr5BBT7W3K1gGJV0FW
 m8uxyKTKXWc/wzDQvhsk72WwMZ3HX3RIO/vqk4Me/7615pnmM86YTvQZyymW/WcD69oj
 hOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998531; x=1761603331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zZb4bRLl32INwLUSG+fpNojV8szKnj+JRZ8eDE6DgN4=;
 b=I/HHW2EWibtzaWEzn6VbZQwfjOEVNoQezJs4kvizhbgO3Lr5zUqUU5Mv47zAPzWFf5
 wwLpTU+hNW5PKIgQ6BZ5URff1pYo0fxF/sEpNRGV0aS4yJV5PESQ+pAv64ZkC6BKxP2X
 3nePzqw1FH+0EOaoRNZGPldOvG+51haud/qj8sgteuDSII9ME88EIDPrkyJCRMqGiXQ9
 yZiPDkKO5uUNnjgaj4iifp9Bqr7GcOPFtLIQ7qoQPoK0n0cxVru20esNCskfwyCnyZ2T
 xcZRIn1AsWML92y4ABtEUIjXStM7gHOPgjCoLKfQAcK5k8ElDmkwQmDY/htwuPxZM0dH
 /Mbg==
X-Gm-Message-State: AOJu0Yw+1hoMmQV5Ez2pC5XvjyvbVXmKdsUBzncZhAlfEnFO0NRaoIbU
 3t/gXmpwfqtTPPEoyjqdCYG0DE0zzW8gwNp9wQhVqellfREKWMyUdYJrxE9kGWVeDYYvD+t/nrC
 vPJLwp9k=
X-Gm-Gg: ASbGncsUb88S0o2j2IwujHZu+HAjRTjHxZRePhnjo/39QC7hj1TZNr16Jg53D2L3MCG
 lMoLe7QbHwnja/2Vso5TfjhEJz9kgp71rKIgCDkweZVzLPWzgi4VaTOx+BkJh0VoGfZfn0apL92
 NC8ISjp1b2VvYSWvqnkG3j8XwkxoVeBo8uTI56NPiowFNwedaEyzRKoOq7C7C9bic9uSVXDkgX2
 OYK64B+aCYm1dOQzy08CqKs4k5TEQHJJCXh1ex6KB/w26MkVXGcW6xIrJJs2ICRzGfWbr/Kfla0
 vcWU24gncykJyFC/4cNiAR3TFmfObB7Pz67vajqf0HS3/S/WsIb7BQ1ILP1wLQHXtruMwsDPAOu
 NICNYgHTPN3ryfoBvl3z88Jks9Cd+2R/Bi6YOchZFojFn7Z/yEKdQofK7wWFje2efjtaH2aaFt8
 QH4jpDkBlcP3eMM2dpLpp64cN8BzJSqMeBylynmKZDmZDcA6pT1Q==
X-Google-Smtp-Source: AGHT+IHSkH320nCjkaP9DaA5q2SqjMFMn8L21nFckzJ3ecqF0qHoFodfa/4pOoGDZep5TLkqQh+91A==
X-Received: by 2002:a05:600c:548a:b0:471:669:e95d with SMTP id
 5b1f17b1804b1-4711787dcc8mr95815825e9.12.1760998530786; 
 Mon, 20 Oct 2025 15:15:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47496cf3b45sm2489885e9.7.2025.10.20.15.15.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 15:15:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 20/30] qemu/target_info: Add target_base_arm() helper
Date: Tue, 21 Oct 2025 00:14:58 +0200
Message-ID: <20251020221508.67413-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020220941.65269-1-philmd@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
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

Add a helper to check whether the target base architecture
is ARM (either 32-bit or 64-bit).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/target-info.h |  7 +++++++
 target-info.c              | 11 +++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index e8fbdf19d53..62359622232 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -50,6 +50,13 @@ const char *target_cpu_type(void);
  */
 bool target_big_endian(void);
 
+/**
+ * target_base_arm:
+ *
+ * Returns whether the target architecture is ARM or Aarch64.
+ */
+bool target_base_arm(void);
+
 /**
  * target_arm:
  *
diff --git a/target-info.c b/target-info.c
index 332198e40a2..f661b1af289 100644
--- a/target-info.c
+++ b/target-info.c
@@ -63,6 +63,17 @@ bool target_big_endian(void)
     return target_endian_mode() == ENDIAN_MODE_BIG;
 }
 
+bool target_base_arm(void)
+{
+    switch (target_arch()) {
+    case SYS_EMU_TARGET_ARM:
+    case SYS_EMU_TARGET_AARCH64:
+        return true;
+    default:
+        return false;
+    }
+}
+
 bool target_arm(void)
 {
     return target_arch() == SYS_EMU_TARGET_ARM;
-- 
2.51.0


