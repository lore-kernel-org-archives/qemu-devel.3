Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94A8F45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 20:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBI8S-00034y-7r; Fri, 10 Apr 2026 16:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBI8Q-0002vA-35
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 16:07:22 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBI8O-0008UW-Bk
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 16:07:21 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so31933665e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 13:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775851638; x=1776456438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P4t86J5N0/PJWFmj1OvMCcQzKaGJ/HQALx536x36Hyc=;
 b=TjnMxIf/qNEsGj9s3K4vRY72dsH80ltv419suC336TKYeIHTLmShuPQqB4OfnAchRS
 7Nf8ZGh+15rKRtUd79ssQelZBCfklWYCxfZpx+ly5fiGumdXX7VcBUaY+q1z42ICC/Fz
 sHV8BLmxqU6fyssdCExOdJIEL87fz+oydY1aD4Lmd3oeXMONJ9dyts0BumKy0GUJNpQ/
 dr5lZwPo0OML3RJrs73wmKPwpNwtgWhLyl51yeS3ILTVTLDIggjInfPUvDqHUDuQr5Ug
 pww+gIN1s6o8arFz2IEe4686Jd69+PGV11Xk9jpra+z1ozhEwI/Sh4WV2WB2VQTjXQLq
 oHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775851638; x=1776456438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P4t86J5N0/PJWFmj1OvMCcQzKaGJ/HQALx536x36Hyc=;
 b=GctFEZ9p+q4sZSPwzCRbWnoJ61PxEHclYdtiZNdlnCMJ9UOAKLz7wPf4nAPhvUPw/h
 FCGq7FQNFJ5U2wsmUHMR7ZU5x7G904DZz/wyS4QuA6/utv4S8RsNffseLMdNiv5/oIVc
 5nxmXpJzVopjOEWNXFlzsO5CkxF3qtejVtIYvfbjIO0exBBctF9oIpRUDhS0oxEhSRo1
 FMU0KcPAr5tvLkBXqQxYh1r7zSiyu2xY3A6HsxI4hOFbhDM/zCZ+7XVR3CoZf5b0jPmj
 +DQ97m0UqUNQynQpJYGQU4bPCjxVcpFYvyE8kSlMSbImeq7fXaqYe5HT3IKH8hrn3KET
 KL9w==
X-Gm-Message-State: AOJu0YyIvmA8EjG8d+lrqRBJuH7FwGId5AR3wYwxxLvf/UyVXzMPrbJD
 /1CgvUljW8Wr/7/SlAHhzn4FXIwxNxLewvFhiEPjaTizH6bxdHVCduIOZy/Wb0aMxE0VGxfFu0a
 l1137r/w=
X-Gm-Gg: AeBDietAuLOALTRHk4stvKbs6aLEglWmELF02J4Usn9zdYVYqM3LBPEZNyD1KX6YsyW
 5//nvvVszmP6AdIQFaZ5eDCEE6qdxR6ND8h555BP5ojG1gQLrXLMvVlpkJytolvFFdAOvYN0m4Y
 hb6n2RdSPktS4W7csjmIxD7s+MG5AE+zk7Hl3wSSp1/1PiKrvOesWF0+DWddJJ9MGrp39eoAjFO
 RCJaSjS2vuA2CU8inDD13kmp6669w2Adk291ptlUwchzlLQFBOn7wshelny5vKn3ECprFny45k5
 LjdthW+RRWViG84KPmR/htTP2peUMA/Ujh784BqgGIGiNqgRm3m4VmbE7lb5AnFYMlcZMigYPOL
 ZR8jJzZvnR3eFuZ/YVSwrsF6d8JPf56F6OrJjqsBJI2gJe8Qcgv/Kul7zhH/lOdjrReqsunCyGq
 mGfYWpiIz/aNIcsjZmpTsSKE0Ka9S17KrzyoUs/Pd3obaDVyyxcLFn8rpBMjJGZlOyromKyZjS
X-Received: by 2002:a05:600c:528f:b0:488:a82f:bbb4 with SMTP id
 5b1f17b1804b1-488d689d0b8mr58824535e9.26.1775851638020; 
 Fri, 10 Apr 2026 13:07:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5734a94sm89632685e9.0.2026.04.10.13.07.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 13:07:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/9] target/arm: Compile mve_helper.c once
Date: Fri, 10 Apr 2026 22:06:26 +0200
Message-ID: <20260410200628.19378-8-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410200628.19378-1-philmd@linaro.org>
References: <20260410200628.19378-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/mve_helper.c | 2 +-
 target/arm/tcg/meson.build  | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 64ab804abcb..09ae2334167 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -23,7 +23,7 @@
 #include "helper-mve.h"
 #include "internals.h"
 #include "vec_internal.h"
-#include "accel/tcg/cpu-ldst.h"
+#include "accel/tcg/cpu-ldst-common.h"
 #include "tcg/tcg.h"
 #include "fpu/softfloat.h"
 #include "crypto/clmul.h"
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 506f031f1aa..95e9da151e5 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -33,7 +33,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
 arm_ss.add(files(
   'cpu32.c',
   'm_helper.c',
-  'mve_helper.c',
 ))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
@@ -71,6 +70,7 @@ arm_common_system_ss.add(
   'debug.c',
   'hflags.c',
   'gengvec.c',
+  'mve_helper.c',
   'neon_helper.c',
   'op_helper.c',
   'psci.c',
@@ -94,6 +94,7 @@ arm_user_ss.add(
   'debug.c',
   'gengvec.c',
   'hflags.c',
+  'mve_helper.c',
   'neon_helper.c',
   'op_helper.c',
   'tlb_helper.c',
-- 
2.53.0


