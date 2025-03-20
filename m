Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08A05C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 22:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOQw-000488-Oz; Thu, 20 Mar 2025 18:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPZ-0002TN-4z
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:53 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPN-00079k-Oe
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:48 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2235189adaeso25862955ad.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742509826; x=1743114626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=avokc7PtwidAIhGAXsNkScUiPBrKycg0jtKiMA4KDgs=;
 b=BIboVDtCFddNVzvXZJy68UWvOh5Ano4jGzvYmm7wGMx3Q1C0SBDuY5ha+RV3RdbP2R
 zYKBH73nhY1kZQAfJlLlSZSDFy1qyDZ3cGDhA5M502UyHi7QXljnOVfrIXvMm5XuDMWY
 mEAZlU3S9Al7/ZVLk6qMM0mKNGI3wJpSCj0zCkwTgFmR1HSlqc1zxDKy6qNaOAGuCU+b
 szSYqw2ULdote4TJGoSMVGkAeVdsiUSHaqqFqP7XM9Ij6T1uxaI+Q5QtiNCdWq5JPafZ
 FVul1GWmsAfMwSvJKZqsYZT7vJ0zS3ZONx2vH1mIXAhzuGM9yPIRzDk82x12HYtPGixl
 Nemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742509826; x=1743114626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=avokc7PtwidAIhGAXsNkScUiPBrKycg0jtKiMA4KDgs=;
 b=DoIqO6qJoeOTZka7tnkDkn7WpOQIbwBt7EuKZysLYCftuG5hXgHBtp28fEVGqjzZQe
 yGcC1nphKVawRBwfU7TnfoOL9ahl23Gnx3EgnQZ4Y8GLf65iXz1/4WpVWRRrvWwNYB7O
 EBRsWuSV2kBQ4eAj/pI/fEB8/4Fn0CZA2raXvdZWDUhA3Jd4a38zTOYnyiBofwYnXL76
 GRXEcbEgl/wreC61MHezyoHGJRehyuJkBBUVps+eHMtBPZqNLAZgcWiu+HplBJJChf10
 WlXfYGUsA9t3AG6lIrHLsSlJclzpI4h2PZbRxOmn6b0s5HxPRXkO3/+YvZTUJOxmWtPK
 fewA==
X-Gm-Message-State: AOJu0YxshOl/2MkeVl50PAgh5jdZ0Toc5EJgJuM7ONDJpoGlp9De5bXT
 hY6V/cctY1RhJyHdj/uf58dB9mdi+UwtmVUZ6PEYtdqxull8smxcCNLJxcBMSGbUv4e8g15gy/n
 F
X-Gm-Gg: ASbGnctQXiQmg2NQZI2evd7Jf6FHB+NpG9tnTSz2BFeF9LrEfLi25eDa3a2RpKR1v6B
 YF3VFxhvJWw1Zao0tmpOJxzN0mFQkqrd5rA7QVLBtqnCv5eHg2mHvgTGjlH3hqnwmTdBr8K+QzC
 Ss72Cn0AobwVDNj/7/RNJ37KdHF13BUAhc4n06PVk8OD9+gN4LCRdgbGecaRVKr1DX2yvNBZKys
 DFNYjSL7oLIUwlwwl9WUJdJtZRO0FbZTG4GzSeojpRndua/j4NuwoPX+OoGqD0zWlne+rbfM8zU
 osyMTP8fyN3SR+p16TDJE8GDoLPl6MW94lRkN4UuHqpV
X-Google-Smtp-Source: AGHT+IGEEKE91spkEXTcAVV49R6+3YhJ1RqwkB0C8ZoyykH1H01x06i5gZ0hciM5xTE4CtOtK2OMPw==
X-Received: by 2002:a17:902:ef4f:b0:21f:1348:10e6 with SMTP id
 d9443c01a7336-227806cfff4mr22432425ad.13.1742509825855; 
 Thu, 20 Mar 2025 15:30:25 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm3370145ad.59.2025.03.20.15.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 15:30:25 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 13/30] accel/tcg: fix missing includes for
 TARGET_HAS_PRECISE_SMC
Date: Thu, 20 Mar 2025 15:29:45 -0700
Message-Id: <20250320223002.2915728-14-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

We prepare to remove cpu.h from cpu-all.h, which will transitively
remove it from accel/tcg/tb-internal.h, and thus from most of tcg
compilation units.

Note: this was caught by a test regression for s390x-softmmu.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/poison.h | 1 +
 accel/tcg/tb-maint.c  | 1 +
 accel/tcg/user-exec.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/include/exec/poison.h b/include/exec/poison.h
index 964cbd5081c..c72f56df921 100644
--- a/include/exec/poison.h
+++ b/include/exec/poison.h
@@ -38,6 +38,7 @@
 #pragma GCC poison TARGET_SUPPORTS_MTTCG
 #pragma GCC poison TARGET_BIG_ENDIAN
 #pragma GCC poison TCG_GUEST_DEFAULT_MO
+#pragma GCC poison TARGET_HAS_PRECISE_SMC
 #pragma GCC poison BSWAP_NEEDED
 
 #pragma GCC poison TARGET_LONG_BITS
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index d5899ad0475..efe90d2d695 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/interval-tree.h"
 #include "qemu/qtree.h"
+#include "cpu.h"
 #include "exec/cputlb.h"
 #include "exec/log.h"
 #include "exec/exec-all.h"
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 667c5e03543..9d82d22bf40 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "accel/tcg/cpu-ops.h"
 #include "disas/disas.h"
+#include "cpu.h"
 #include "exec/vaddr.h"
 #include "exec/exec-all.h"
 #include "exec/tlb-flags.h"
-- 
2.39.5


