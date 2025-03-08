Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBE7C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr39C-000514-L2; Sat, 08 Mar 2025 17:59:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38Y-0004bL-4e
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:18 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tr38W-0005NA-8i
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:59:17 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-224100e9a5cso56104845ad.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741474754; x=1742079554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PQ7VRfSKG1Ts2qHzv0Mc2UE7mllYcyWQa1NNvIfU4kY=;
 b=FjmXOQR/sVWs+avbB2i2yPM+IpctSSh5ibddNdlXm3T9460Wc52+3/fWTo28DeCm4k
 ON7HzQG39ZZxG5qDyRAOVrrt28JGIYYHUMgikNu2aN6zbm6eF6DAnjQTIaai8PL0M2Xg
 qbi26fQJbgFzX7g00s7abPi7opyJKXSmOBjza4YfWeIlJmFDrhhP9W4GCq5gfXnpcQ57
 LYMgcZCIimBDaoaR05KrpJnqxjuudgkVPapVG7tN7vMglIisMB5h+j6jiSZcc8LoN+sr
 Afn+fxUEU2Jxtr37pReID1P6sPnilX7rpghwito0yTt1tkYo5ADhhSwajhzs75csbgf2
 MAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741474754; x=1742079554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PQ7VRfSKG1Ts2qHzv0Mc2UE7mllYcyWQa1NNvIfU4kY=;
 b=dLY+XVREQv21FfEqotKo9Y8sqlUE8z0boMWl16u1WyBMezSHhBmXhDxjv8D9vnTSso
 3Uo3EqxTaIteuFCARzBRDIcPDiHjGUUlKDBPevQAwLbSb+mrmrwl2YfzI6qei69cG/DC
 vxRfg7Dm3tjlhdhAN5dMic4LuVdRe5qUec5zyYlVrd/luOKNeN0MIjCNM2a8zJrH6sQV
 cEvcKZGMD0YGjB0YoZzeZJ9Eg4srsCq5Ia/wqFmmJSLpNzRRz9tyk625woRYymGT/d5D
 t9H62AqG5bPSQ3n1A5jIPT+FIbjJxfqrNMjOFZj0ZXFtXTByS9/Al1TKn3RlIr9ocToq
 PE8A==
X-Gm-Message-State: AOJu0Yyo+gBXATyoEkBYsarwXeq4Vfv4RuQ8PcJdTfq7ssfnLdgwfu/O
 3j6SnIneEBiWwY/f0EldD0YA6tKalF989vCl2A7xeApWav4ZllOz9W66F6Gtv536bRYJ4ljKB9L
 H
X-Gm-Gg: ASbGncse6uMg8kVnENnUdqmJ+C/MDznS0kJ14LrDQw5rKnz1Vw6Gjmm6+hS+vXiRL40
 lDy0NzO7sSEG0ahOdHyEcY+t7ig5JRb9ftoGrmFLFvQAbxjGUkhr6gEOtEau51DiKuKbJJfB+ex
 LvR6yezMTCvbS3w+2KWcFRQB/MBEq165Shze6/tmgGsr+rQF3Oofb7L8euiG4MYzf3zy7NqSc4+
 d4oOmDCJPP+HucVsnlVvXzzatMYAw5Au2z1RhJqIbIouUfSEjYGsLmXD64d/6K0SVYaEoi2gLHP
 aTpKnaJdy6RrqO8kMslzuPBsqsztmSPiaAEv93XYDJV8qRJ/+7WiFPMeN+oScSa/yoNZzVxfkDN
 Z
X-Google-Smtp-Source: AGHT+IERSo3yeN1yI+8Yqb936MopykyHrFDIBOzqTPWwZuMtjqnS03zdsQTnG9yU1ENTIyh07wIjsg==
X-Received: by 2002:a17:903:40cb:b0:223:44c5:4eb8 with SMTP id
 d9443c01a7336-22428c0752cmr146211635ad.32.1741474754592; 
 Sat, 08 Mar 2025 14:59:14 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a908a0sm51831175ad.162.2025.03.08.14.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:59:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 16/23] accel/tcg: Build tcg-accel-ops-mttcg.c once
Date: Sat,  8 Mar 2025 14:58:55 -0800
Message-ID: <20250308225902.1208237-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250308225902.1208237-1-richard.henderson@linaro.org>
References: <20250308225902.1208237-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

All that is required is to avoid including exec-all.h.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops-mttcg.c | 1 -
 accel/tcg/meson.build           | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index ba7cf6819d..bdcc385ae9 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -30,7 +30,6 @@
 #include "qemu/main-loop.h"
 #include "qemu/notify.h"
 #include "qemu/guest-random.h"
-#include "exec/exec-all.h"
 #include "hw/boards.h"
 #include "tcg/startup.h"
 #include "tcg-accel-ops.h"
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 87c1394b62..81fb25da5c 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -20,7 +20,6 @@ specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
 
 specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'cputlb.c',
-  'tcg-accel-ops-mttcg.c',
 ))
 
 system_ss.add(when: ['CONFIG_TCG'], if_true: files(
@@ -28,6 +27,7 @@ system_ss.add(when: ['CONFIG_TCG'], if_true: files(
   'monitor.c',
   'tcg-accel-ops.c',
   'tcg-accel-ops-icount.c',
+  'tcg-accel-ops-mttcg.c',
   'tcg-accel-ops-rr.c',
   'watchpoint.c',
 ))
-- 
2.43.0


