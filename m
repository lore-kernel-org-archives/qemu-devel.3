Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F7EC28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 20:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyFwz-0002qc-2g; Fri, 28 Mar 2025 16:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyFww-0002o4-LP
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:05:06 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyFwu-0007kF-OB
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 16:05:06 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-6025007e9a0so451433eaf.1
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 13:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743192303; x=1743797103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vsSmqeOWwZw9KE8qAhLEmryV/FXdBjZqeFOodkM2cBg=;
 b=msFK+kfmv5kSggOdR/Hf3fmA92QyheD+moMU8kpRiFsGCpph5lac5vSP/Ly/EYreJ4
 N/W6ulg8JSkFV6UQiVDzF3y8EJCRonqHwNfLO5YbW2PJ668n5r8OJtIQWON57XYTO6gu
 UDp2u5x13i4bsyBfF99gw6BPpVJnYG0wNRUiIFG6ICAYwiz+jtvcZhh4AuJE+wdEWRlZ
 +fp2qWxNuwKX27zgxJqwb1zYXlxqiNHuaDNxkRYF/3PAMAbSuMDRxfi2/ku4Uv++NLMS
 o8Fmx3NUorsIvtFcZxe+DimyqT8dhqhAuH2ciQKgPerQ9/+sSc4xOWEeDmi4yLKNRePX
 wmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743192303; x=1743797103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vsSmqeOWwZw9KE8qAhLEmryV/FXdBjZqeFOodkM2cBg=;
 b=aj74CQETsnxxvTNi3B4wCtFn/vDYWtxTrDdFAgsTFOWgt4AkYcTwOEXZjjg8MuAQ7W
 LvyYqYjhWwkgVwk8Tu65N23q6VOv5P+j69AkPi3knY1N9P//19nqffDAaDvYJ2whI1QO
 Ye1I92287FxUpU390yWPO6cIM4cBFQ6hefIFKGkFzbwQxwIrgYgh62gfXRLFiNae5KGd
 Bby7L22NtrFMybC5HjiKAVmjsRzn0kIolQ75pGjtoDCv0XfQrATHKYBgqqwlEyB4hgD7
 z7qrN6Yvumid9I/LUYISr04mi+lpcMDR3TvjpTdzkSIlPfD+yCrHGtS4ApkYQirNZ5bj
 0q9w==
X-Gm-Message-State: AOJu0YzUEL0UAJl4CoGrEBvg5x9UeqMS92tZtZCKxH9n0yCUMFDWnD0p
 TW+cCydX+Z4VT3lEXr0S2w1fqyW63pK9L/2oIywJckV8yWqA7jrOOVBCWsTp+q6WX+hKO12ZUP8
 k
X-Gm-Gg: ASbGncvL3U2+TAwzwDrQ9c0jEKnStYvs445+Mzqz7MzjX/qXOWo6GRSPCFMKojIGBH9
 MDAOmfENpNP+dg3z2CHSXTKkWB6xyqwS6PB6AaIpgkJLC4AC+/Ry2nrx9ZzvbdzziGMxsWmECOC
 9kkE3tOE5gbmZo5SGBLS0zQtnjan4BuYNgfgv32O5Gffta5s8nSSrMbZKXZwG5RUmvJAasaOgHw
 j3XALZsBmqRPczGD622SRu6td9g5QVo3UOvYiOP4aCrzMbJaHOHDVZiUhNLPnq1641jHtsna/Qa
 oYY/R6knz7CYABSNpt2BCeaHpt/1XpvNM6MrRyYL7ksJ0cExmT81xYV1CW7CLNEpfUD5hw99VJn
 E8dXC4fodSYo=
X-Google-Smtp-Source: AGHT+IFdlyCdyH5z9Lf1LdvZNjKYie0f8jMASsQJ7HWZKeDQ13Tw8BERbDAAe6QY60WmdPHZ3oF75A==
X-Received: by 2002:a05:6808:3021:b0:3f6:7682:8571 with SMTP id
 5614622812f47-3ff0f502f75mr364918b6e.14.1743192303183; 
 Fri, 28 Mar 2025 13:05:03 -0700 (PDT)
Received: from stoup.. (syn-071-042-197-003.biz.spectrum.com. [71.42.197.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff052799b6sm465104b6e.37.2025.03.28.13.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 13:05:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH 2/9] accel/tcg: Move get_page_addr_code* declarations
Date: Fri, 28 Mar 2025 15:04:52 -0500
Message-ID: <20250328200459.483089-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328200459.483089-1-richard.henderson@linaro.org>
References: <20250328200459.483089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

Move the declarations from exec/exec-all.h to the
private accel/tcg/internal-common.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-common.h | 34 ++++++++++++++++++++++++++++++++++
 include/exec/exec-all.h     | 34 ----------------------------------
 accel/tcg/translator.c      |  1 +
 3 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/accel/tcg/internal-common.h b/accel/tcg/internal-common.h
index 9b6ab3a8cc..2f00560d10 100644
--- a/accel/tcg/internal-common.h
+++ b/accel/tcg/internal-common.h
@@ -74,4 +74,38 @@ uint32_t curr_cflags(CPUState *cpu);
 
 void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr);
 
+/**
+ * get_page_addr_code_hostp()
+ * @env: CPUArchState
+ * @addr: guest virtual address of guest code
+ *
+ * See get_page_addr_code() (full-system version) for documentation on the
+ * return value.
+ *
+ * Sets *@hostp (when @hostp is non-NULL) as follows.
+ * If the return value is -1, sets *@hostp to NULL. Otherwise, sets *@hostp
+ * to the host address where @addr's content is kept.
+ *
+ * Note: this function can trigger an exception.
+ */
+tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
+                                        void **hostp);
+
+/**
+ * get_page_addr_code()
+ * @env: CPUArchState
+ * @addr: guest virtual address of guest code
+ *
+ * If we cannot translate and execute from the entire RAM page, or if
+ * the region is not backed by RAM, returns -1. Otherwise, returns the
+ * ram_addr_t corresponding to the guest code at @addr.
+ *
+ * Note: this function can trigger an exception.
+ */
+static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
+                                                vaddr addr)
+{
+    return get_page_addr_code_hostp(env, addr, NULL);
+}
+
 #endif
diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index fcad3446fe..f52a680f42 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -143,40 +143,6 @@ struct MemoryRegionSection *iotlb_to_section(CPUState *cpu,
                                              hwaddr index, MemTxAttrs attrs);
 #endif
 
-/**
- * get_page_addr_code_hostp()
- * @env: CPUArchState
- * @addr: guest virtual address of guest code
- *
- * See get_page_addr_code() (full-system version) for documentation on the
- * return value.
- *
- * Sets *@hostp (when @hostp is non-NULL) as follows.
- * If the return value is -1, sets *@hostp to NULL. Otherwise, sets *@hostp
- * to the host address where @addr's content is kept.
- *
- * Note: this function can trigger an exception.
- */
-tb_page_addr_t get_page_addr_code_hostp(CPUArchState *env, vaddr addr,
-                                        void **hostp);
-
-/**
- * get_page_addr_code()
- * @env: CPUArchState
- * @addr: guest virtual address of guest code
- *
- * If we cannot translate and execute from the entire RAM page, or if
- * the region is not backed by RAM, returns -1. Otherwise, returns the
- * ram_addr_t corresponding to the guest code at @addr.
- *
- * Note: this function can trigger an exception.
- */
-static inline tb_page_addr_t get_page_addr_code(CPUArchState *env,
-                                                vaddr addr)
-{
-    return get_page_addr_code_hostp(env, addr, NULL);
-}
-
 #if !defined(CONFIG_USER_ONLY)
 
 MemoryRegionSection *
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 7ef04fc597..307a513487 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -17,6 +17,7 @@
 #include "exec/translator.h"
 #include "exec/plugin-gen.h"
 #include "tcg/tcg-op-common.h"
+#include "internal-common.h"
 #include "internal-target.h"
 #include "disas/disas.h"
 #include "tb-internal.h"
-- 
2.43.0


