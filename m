Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18038C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JQo-0000rC-Ar; Tue, 22 Apr 2025 15:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JP2-0005ES-D7
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:32 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JOz-00074o-6p
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:35:31 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-224341bbc1dso55202375ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350527; x=1745955327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BgalV7HruJEO8qZACAhRIvHXd09mMPeIqD7Z/pvVOVM=;
 b=kNKSkeI6pJjl39g9vmNvXbd0kOA4zW5Lq1tDrZxX8RHHXg/EaEk7W68G30INrNmeuO
 JNDeeRgA4l2zzIxHJwq+DSJdA4mjYMaRC2IJR1BOVhCwsRfCNMLwCKkQS13HtaWEZQ/U
 QSEcbu8FMI7Xgy7jdA6I0oiHpubZlKu4X1Mgab0ecOe+yim/RnCf/GIYmESLdu684+iC
 ekYNVbKvS9U1LgkCN8GqZLceFpfvCqphx6b/9mpS356PmZXEh0MqIIQHmg8PTymIOfU/
 DXLT8Oh34r6L6Y97sDaNslt/xnALHJPDtm3dzCLtympRzZeymMAizaLDFdsdNT866sdG
 dFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350527; x=1745955327;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BgalV7HruJEO8qZACAhRIvHXd09mMPeIqD7Z/pvVOVM=;
 b=jKOI95f1fLY34N9zloecvsMitA1ZBBJPO9ELxYmA6tPq+X2stC4r9H1zYDIOofltlv
 wNHeOI/YIqB3OoEgDX2wuncugKnKUoKC878RUrI1lc+IZXLIJ58s46N1qCuX/hfEbYXM
 ZVvdJTA+NShVIWIZyUWvLkztR0JSg3/FoPbMPodprzS7TFqXMz7f1eZhWnY9u6i/zm9K
 nVBm/IMwHionkFQ/Pr/wAZ9e5enIjofNyT2wkcHSVcB0/21Y7YW8OSPfgBfUAuDm1aDq
 xDJuz21/rHLI94JkClIQmKupVSfogBqc46qR9Sja9YtuQ+wFS1QTV1NPK2yHThiE++qa
 CFiQ==
X-Gm-Message-State: AOJu0YyEYV1UcfxkFAElgsBK+6xVrXqwH6wm5pODiR764MqU4/CYxjuX
 OiikfMq0VAgQ6n1Xxd+B4kuopWK43hOJ05a1BbV7F3GigEBy0+M9XIrC+I5PZanjx/0FN8FlZl2
 P
X-Gm-Gg: ASbGncsD4gF1/bbEksS5dXieayLEhsGGZ5RXNcr965+RCpxvUmb7NGTIIxCQgyHA/3C
 Hv938pxlkWDW6/BkpEJStcBgpjiRslZgqcsRwopclSKf/X9zFENmqCljX4ZkqpNxWmgRShAqOrr
 53BgvaJ9hEP1um0DCONYM0Tgb2+krbiuZ+n6XOeZU3EZFBWDyiI43yUWThyzL0mAs63yfTPvBtr
 EN2QjXnONHZ6ehlisIwn2Ir2o4VWpkndQI2mrZXKsHtzh50398z1RhMfQdhi9rgfVjEkPWqa3EL
 SI1AjERRNZPlTLgZLM6oBzI08wL1TMUdr4HVxCEbbTBU3YfmiMroGYKx3Lj4mR9A9HYtc32q7dA
 =
X-Google-Smtp-Source: AGHT+IEsLZGJ2AKNIXN6IPLQhXpYOp+WtWbybdGmBJAimbH9QCWVZiq3jj9Ccgzz1WrC9sXaTtemlA==
X-Received: by 2002:a17:903:2f90:b0:220:c813:dfce with SMTP id
 d9443c01a7336-22c53607d1emr238014295ad.39.1745350527273; 
 Tue, 22 Apr 2025 12:35:27 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50fdf1f1sm88996795ad.237.2025.04.22.12.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:35:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 102/147] include/exec/cpu-all: move compile time check for
 CPUArchState to cpu-target.c
Date: Tue, 22 Apr 2025 12:27:31 -0700
Message-ID: <20250422192819.302784-103-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-4-pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h | 4 ----
 cpu-target.c           | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 2aaaf0548d..be462c4410 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -33,8 +33,4 @@
 
 #include "cpu.h"
 
-/* Validate correct placement of CPUArchState. */
-QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
-QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
-
 #endif /* CPU_ALL_H */
diff --git a/cpu-target.c b/cpu-target.c
index 519b0f8900..7f3b244ed1 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "cpu.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/qemu-print.h"
@@ -29,6 +30,10 @@
 #include "accel/accel-cpu-target.h"
 #include "trace/trace-root.h"
 
+/* Validate correct placement of CPUArchState. */
+QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
+QEMU_BUILD_BUG_ON(offsetof(ArchCPU, env) != sizeof(CPUState));
+
 char *cpu_model_from_type(const char *typename)
 {
     const char *suffix = "-" CPU_RESOLVING_TYPE;
-- 
2.43.0


