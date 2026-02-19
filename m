Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED916E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 10:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt1Mm-0007NT-2s; Thu, 19 Feb 2026 05:34:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Mh-0007JT-DZ
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:35 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vt1Mf-00067w-A9
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 05:34:35 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48371119eacso7373415e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 02:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771497268; x=1772102068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0iWZMlgml2iuRJplph15PwTWx4X9p8U10SYzFINXIkY=;
 b=hFc9y5Epr8AKyWh5ZuYV4o1l4nWMK+BeUfdfa3zn6t03wmjqxX3If5gkXHsiIfRAl1
 CDUjfMat6zwdBUxAilvUwsnHDEG0VkPX3LDqByLeMOFVpHj8PFkrRyUrqgKwk2+RNyuB
 huaWOOGSfotdQYQfFtBbjVNkNTRzdJWvHc2Ru4A04W8v0qpgt49AK0+GSawdL0pfDXGA
 tkbyM3JryejwBfzrFF6arJB6QbHriRD1Re6oJApi4SlEoHIVPxyDoEBLoOXjvGtfdMZ7
 5iXo/7k5idYOiK6GL/xHGtUrpVU20QFez2VcZ/7oIZKeKFUA37m6psP1iCIIlIJOmaYC
 RzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771497268; x=1772102068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0iWZMlgml2iuRJplph15PwTWx4X9p8U10SYzFINXIkY=;
 b=rgN6+gxUbBSKM1Y2s+yUILOK11qZwiOmyaCx4LGgDmo85xOPaA6wgpdqaT6txYWT84
 iUANn+8m6MqieEMfMLyk9cFJEG6ZEesOgvDLCfrJ+qk0O7Iz9dhTSrPsdg2OZLif1rRK
 gFhSlEXxfa7spTGrZd+5HlnwH94xZ47IAsUScZ2HrN4IB/+N/dFKGjk3tvk0Gm23q6Ht
 U1FAeJcsh9G1okeL7KZE3c45rVtmpq+9XBUWEzMLCRVZexIFdLzHiUYoPgM5kiMeou6x
 GaBToCDeuBrvX2e6Z+H0Wnpn6APFdfTFfXdSxr68vHYlESKOhyuZjpEryc+ltl3ch8ce
 7ZlA==
X-Gm-Message-State: AOJu0YwysNkWbtb9o0I/N8gWI5aJgTr6RcZohKWNIFXHU8ZD3G1jVc75
 QEepP//SLB359pZjkAACo1V43eylcRTAdJtfj+mAL1azIOnwCeeBtAaypDHke2+fE/yqG2qe+qi
 EIuxv
X-Gm-Gg: AZuq6aI8Vjg8HJDExfTzQu0yAibItXXhOcti2WNwJVYNHAwBHvGvO5Ip1Uokt437DoS
 srDRYmMPFmD9QHNppstBvQepxC6xS3Y/C3SaRLFlp5FZ77q3el7zF9pAB5fPienNEv1j4WPlA7E
 m2K7dJgwgAIavSIFwj/vXSozUPcRjSMgnnMXjEmL6BCmslSbOCiyoTyuwxh9+HYmAjMZRTNEmbi
 IXUbjh5joh4BcmPFKDJ0jTmG1y4z9BDOpizscr1a16cx0chfMFKr6+34ttw9JuGVzZnqnpfQWg6
 pQzMgq/hMRu0UjeBEs1znkmeEGy5FI/XalyxoDGbRWEcVkkKxBqF5skgMJ0pXczBzpRCuw9ecew
 houAj887dRnSQIcLIJZyTpl89RUM05vRZqdzYDDAlFKJIk4XsNKQe9p5SHdYJ0n1oF46KF/B8WO
 XFQ46Z4lIrTCl2OCitWb4MYGV1mW9bSD4b6RAWgXDv6VA9r1DAe7XheSVxp7ASVZ+gQzjLYRXYQ
 Y/tWq6O1solpOUmSMpDF6fBdfRGMfo=
X-Received: by 2002:a05:600c:1c25:b0:477:7c7d:d9b2 with SMTP id
 5b1f17b1804b1-48398b7b130mr76001995e9.32.1771497267661; 
 Thu, 19 Feb 2026 02:34:27 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd34sm697630795e9.7.2026.02.19.02.34.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 02:34:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/32] target/arm: extract helper-sve.h from helper.h
Date: Thu, 19 Feb 2026 10:33:56 +0000
Message-ID: <20260219103405.3793357-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219103405.3793357-1-peter.maydell@linaro.org>
References: <20260219103405.3793357-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260219040150.2098396-6-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper-sve.h                            | 14 ++++++++++++++
 target/arm/helper.h                                |  1 -
 target/arm/tcg/gengvec64.c                         |  3 ++-
 target/arm/tcg/{helper-sve.h => helper-sve-defs.h} |  0
 target/arm/tcg/sve_helper.c                        |  3 +++
 target/arm/tcg/translate-a64.c                     |  1 +
 target/arm/tcg/translate-sme.c                     |  2 ++
 target/arm/tcg/translate-sve.c                     |  2 ++
 target/arm/tcg/vec_helper.c                        |  1 +
 9 files changed, 25 insertions(+), 2 deletions(-)
 create mode 100644 target/arm/helper-sve.h
 rename target/arm/tcg/{helper-sve.h => helper-sve-defs.h} (100%)

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
new file mode 100644
index 0000000000..ae4f46c70a
--- /dev/null
+++ b/target/arm/helper-sve.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef HELPER_SVE_H
+#define HELPER_SVE_H
+
+#include "exec/helper-proto-common.h"
+#include "exec/helper-gen-common.h"
+
+#define HELPER_H "tcg/helper-sve-defs.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef HELPER_H
+
+#endif /* HELPER_SVE_H */
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 79f8de1e16..2f724643d3 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -3,6 +3,5 @@
 #include "tcg/helper.h"
 
 #ifdef TARGET_AARCH64
-#include "tcg/helper-sve.h"
 #include "tcg/helper-sme.h"
 #endif
diff --git a/target/arm/tcg/gengvec64.c b/target/arm/tcg/gengvec64.c
index c425d2b149..c7bdd1ea82 100644
--- a/target/arm/tcg/gengvec64.c
+++ b/target/arm/tcg/gengvec64.c
@@ -18,10 +18,11 @@
  */
 
 #include "qemu/osdep.h"
+#include "cpu.h"
+#include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
 
-
 static void gen_rax1_i64(TCGv_i64 d, TCGv_i64 n, TCGv_i64 m)
 {
     tcg_gen_rotli_i64(d, m, 1);
diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve-defs.h
similarity index 100%
rename from target/arm/tcg/helper-sve.h
rename to target/arm/tcg/helper-sve-defs.h
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 0600eea47c..16e528e41a 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -25,6 +25,7 @@
 #include "exec/target_page.h"
 #include "exec/tlb-flags.h"
 #include "helper-a64.h"
+#include "helper-sve.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "tcg/tcg.h"
@@ -38,6 +39,8 @@
 #include "user/page-protection.h"
 #endif
 
+#define HELPER_H "tcg/helper-sve-defs.h"
+#include "exec/helper-info.c.inc"
 
 /* Return a value for NZCV as per the ARM PredTest pseudofunction.
  *
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1a54337b6a..31fb2ea9cc 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "exec/target_page.h"
 #include "helper-a64.h"
+#include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
 #include "qemu/log.h"
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 091c56da4f..463ece97ab 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -18,6 +18,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "cpu.h"
+#include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 956ddee123..bd6be68d81 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -18,6 +18,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "cpu.h"
+#include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
 #include "fpu/softfloat.h"
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 7451a283ef..bc64c8ff37 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "helper-a64.h"
+#include "helper-sve.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "qemu/int128.h"
-- 
2.43.0


