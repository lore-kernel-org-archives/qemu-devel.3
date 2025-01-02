Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC96E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:09:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbW-00072k-An; Thu, 02 Jan 2025 13:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbH-0006yc-DH
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:19 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbC-00058b-L7
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:12 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2163b0c09afso155742455ad.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841228; x=1736446028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jnulhMf+m57g1T3wM1440HgR3ATLLlxN20cJi1PTGzY=;
 b=Z82xWntRMDH0HFEnkCyC5InHUq2Y/Zj++OuGSgAvJZB+aBPpUXl7mnG5HKHvRZAHB/
 jFFKcz+sv+eDqWIRU4cXTXvOknMoyhqGSxV3Y/y/yf/77szTlJiONAO+3vw1Ur1etKpI
 mLDl7Is/X4BCmO73Rw1l2zR36yKagkJfWXP/ZZLulenb3fb3a7dxE+LBPA4RNtsJo7xG
 GGtQd+XWlb1CbioaszboZDf8HXZ4mf1H4j867jiosB/vx1KHAD/Vdma5f63vUCffy9oV
 URckXiwP5M9di9PixbmvgvSB7E/uNwEZqyiy5MD+HED9TQoZllYwHeyyD9rYgg5jwAOW
 5YSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841228; x=1736446028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jnulhMf+m57g1T3wM1440HgR3ATLLlxN20cJi1PTGzY=;
 b=fMTWICVWk+PoWEL1JBaNVoAw8L7wAfkWQ8PVVnP0CT4HjlFlTnScbHoOu2WdZEJdXE
 qBCVub/4KQINEEh4G5hwWG8URRO9eQVLXYs8f2wPqo3WSIzkitHG+anxWFEYicKOvbt7
 vhRF+90XkR+zYLaHet9fmco6srRz4LzaSSleQAsjT+4l2+Ggmmj/Me0vr1a9NeoHPpsG
 /HWdY8P2U6Y1UX4BbM6mXICeh3EtHaGwwfIlj0Y3Uqg3ExNe78OwnMlCfOO3Cwqr8pXn
 3hNdpIXEBpcASxH4AAK3nLJ3umxhdY61j4l9ZEK3nByF3R/mxLuS2dMjdZVDjKmNwQfN
 Ucag==
X-Gm-Message-State: AOJu0Ywc4xw+PG+Z7h9MAyXXnxjKcAxw134nd/YNAitbn9BUqaLkpZUl
 Qj8St9+TBQjvIYAJO14OSbHnCc2vknn6/FxBy48DwiUTpGdCMX+3F3+DU7ij/URlQRtEXsCzcrw
 z
X-Gm-Gg: ASbGncuOQQgcd0HGx2xOv4oXOO7ox9BKTK+Sok+Ihxm3d1K2R3GEVnDrOqJJUD82NUz
 dPGDOYY2E/ufvAIh3Vev12PfWAOEfY8OeP/LES673/dxYkNKijWl9j5znGnRXtgax6OV8+Pv40r
 /sWNyyQvsJwQghhGdp7vmBxCmypHaN62tF9+Fy5MrEcJYuXim5HNSdP/EpVB3BELPtbSxq2B8Tf
 geG0vIxujQyPxX2EkY8wnYXZtK2wm5oc+x+vbeE4j8JmIcjkpz64aJaEWDovA==
X-Google-Smtp-Source: AGHT+IG+RZiAVsKZuABjkBUEcCKijm1AyTBU/KLv3ZW2/cBtb7yEvZ2azwE9lkl6ydaRXG9XpIFc2A==
X-Received: by 2002:a05:6a00:21c2:b0:728:e9d1:218a with SMTP id
 d2e1a72fcca58-72abdeaaa3fmr69134657b3a.17.1735841228189; 
 Thu, 02 Jan 2025 10:07:08 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 16/73] tcg: Rename tcg-target.opc.h to tcg-target-opc.h.inc
Date: Thu,  2 Jan 2025 10:05:56 -0800
Message-ID: <20250102180654.1420056-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

In addition, add empty files for mips, sparc64 and tci.
Make the include unconditional within tcg-opc.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h                                      | 4 +---
 tcg/aarch64/{tcg-target.opc.h => tcg-target-opc.h.inc}     | 0
 tcg/arm/{tcg-target.opc.h => tcg-target-opc.h.inc}         | 0
 tcg/i386/{tcg-target.opc.h => tcg-target-opc.h.inc}        | 0
 tcg/loongarch64/{tcg-target.opc.h => tcg-target-opc.h.inc} | 0
 tcg/mips/tcg-target-opc.h.inc                              | 1 +
 tcg/ppc/{tcg-target.opc.h => tcg-target-opc.h.inc}         | 0
 tcg/riscv/{tcg-target.opc.h => tcg-target-opc.h.inc}       | 0
 tcg/s390x/{tcg-target.opc.h => tcg-target-opc.h.inc}       | 0
 tcg/sparc64/tcg-target-opc.h.inc                           | 1 +
 tcg/tci/tcg-target-opc.h.inc                               | 1 +
 11 files changed, 4 insertions(+), 3 deletions(-)
 rename tcg/aarch64/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 rename tcg/arm/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 rename tcg/i386/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 rename tcg/loongarch64/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 create mode 100644 tcg/mips/tcg-target-opc.h.inc
 rename tcg/ppc/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 rename tcg/riscv/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 rename tcg/s390x/{tcg-target.opc.h => tcg-target-opc.h.inc} (100%)
 create mode 100644 tcg/sparc64/tcg-target-opc.h.inc
 create mode 100644 tcg/tci/tcg-target-opc.h.inc

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 546eb49c11..93622f3f6b 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -301,9 +301,7 @@ DEF(cmpsel_vec, 1, 4, 1, IMPLVEC | IMPL(TCG_TARGET_HAS_cmpsel_vec))
 
 DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
-#if TCG_TARGET_MAYBE_vec
-#include "tcg-target.opc.h"
-#endif
+#include "tcg-target-opc.h.inc"
 
 #ifdef TCG_TARGET_INTERPRETER
 /* These opcodes are only for use between the tci generator and interpreter. */
diff --git a/tcg/aarch64/tcg-target.opc.h b/tcg/aarch64/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/aarch64/tcg-target.opc.h
rename to tcg/aarch64/tcg-target-opc.h.inc
diff --git a/tcg/arm/tcg-target.opc.h b/tcg/arm/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/arm/tcg-target.opc.h
rename to tcg/arm/tcg-target-opc.h.inc
diff --git a/tcg/i386/tcg-target.opc.h b/tcg/i386/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/i386/tcg-target.opc.h
rename to tcg/i386/tcg-target-opc.h.inc
diff --git a/tcg/loongarch64/tcg-target.opc.h b/tcg/loongarch64/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/loongarch64/tcg-target.opc.h
rename to tcg/loongarch64/tcg-target-opc.h.inc
diff --git a/tcg/mips/tcg-target-opc.h.inc b/tcg/mips/tcg-target-opc.h.inc
new file mode 100644
index 0000000000..84e777bfe5
--- /dev/null
+++ b/tcg/mips/tcg-target-opc.h.inc
@@ -0,0 +1 @@
+/* No target specific opcodes. */
diff --git a/tcg/ppc/tcg-target.opc.h b/tcg/ppc/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/ppc/tcg-target.opc.h
rename to tcg/ppc/tcg-target-opc.h.inc
diff --git a/tcg/riscv/tcg-target.opc.h b/tcg/riscv/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/riscv/tcg-target.opc.h
rename to tcg/riscv/tcg-target-opc.h.inc
diff --git a/tcg/s390x/tcg-target.opc.h b/tcg/s390x/tcg-target-opc.h.inc
similarity index 100%
rename from tcg/s390x/tcg-target.opc.h
rename to tcg/s390x/tcg-target-opc.h.inc
diff --git a/tcg/sparc64/tcg-target-opc.h.inc b/tcg/sparc64/tcg-target-opc.h.inc
new file mode 100644
index 0000000000..84e777bfe5
--- /dev/null
+++ b/tcg/sparc64/tcg-target-opc.h.inc
@@ -0,0 +1 @@
+/* No target specific opcodes. */
diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
new file mode 100644
index 0000000000..84e777bfe5
--- /dev/null
+++ b/tcg/tci/tcg-target-opc.h.inc
@@ -0,0 +1 @@
+/* No target specific opcodes. */
-- 
2.43.0


