Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9FBD34094
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 15:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vklJ9-0006rl-AH; Tue, 27 Jan 2026 10:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vklIj-0006WM-B3
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 10:48:26 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vklIh-0004E0-K5
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 10:48:20 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-432d2c7a8b9so5668050f8f.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 07:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769528898; x=1770133698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1P4Fp9YhrD/gyZOyp6pwmRmOxlP0nYVwqlUrVXaEAAU=;
 b=exrVxyOYrRx0nRiPxG28w1tm0kqlsUWeuSZg6rRfjKB+X2PdAg42JFiOIcE5XO6QZO
 q8ErqWA2vg6omV5Dc6EMWzNdIVNVydXE8iHUTXaMEbzoy6EICvF6wWfJnFdN3RoYnOZy
 /8Yna8Yw7yu4iy619aqI/LWF83WP2vs0+LBfkJp5fe7f+A36ww6WLNQXVvjVDantqyAg
 2ow4ZngcUTfq6YrGNZlUai46WEN/cHnDt4on0XykA6iKi1ya9AXhmP4WPXKbsRlUHoaZ
 +tkzPcLkpGCBh70sTiB0aai6JWPGSpdgoh5TBJr6oC7xzerYhiwCjIDvBPuJu56pCCLs
 1vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769528898; x=1770133698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1P4Fp9YhrD/gyZOyp6pwmRmOxlP0nYVwqlUrVXaEAAU=;
 b=GiAjgMgsaTynakNta5Qcxl2yg/abrc8PrukGpc+lnVA2qHBnagj+a0qy4cHDk6oNCX
 1+RwuiEEnoevF/gE7K4IF94IlnQgt8sRMMz5DI6BuAX0heflwlKQxteR5RMyEHRBfjv+
 L9AihJQJwcuL0Rny9Pq5+Dy3/8184ff3wyeIucodpHPgKeQGBd/nwzXEY8D0TtZTlOaC
 qBuhT1FnuxOnb9rxIujwE6h5iE07Q6yPyCTpz1xE41bv4JU4L4apNMtSlg352RRxc2J+
 BZXEGz/3TZ1L5MI3ey/xd+wNUq9NW1drqrNe0tXvSo6v2///mTvIaQc/zMyoenAlvy3M
 yvUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlEe4d9slZYxs40ZNucrcuiI0SU2nsBOZquJgO19mDsi0zx/X+zuL6bZD34U8LiV4TwhJBYuWhWiPX@nongnu.org
X-Gm-Message-State: AOJu0YxE6H4idwdBF6jFUCFu13xHukHlWDjfF+kjpkVyV5ZZ4yn0GBbL
 zEcc4T+r44vHxcn8+vxjNkKwGfKqWkxmJmD16KfUt115Hu9gH3dxsT2DFjADrrhuERw=
X-Gm-Gg: AZuq6aIv+ltKej/EmMfmp50j03I1AHk6DEzHRGa5J48lnD5VQjFMbODts9xbdW3vtvN
 U4tDSxA8cI+vX6O4DKTfaOB4QwDnTLIL6vgv9xtuukW1f9LohtlMGwIm4S1P0WgYRp+bvBwsmNi
 7vWW0UscdMD0plMuATvNKhjwE+Gr47Z0MHZpz19NY3o1X5gBaXCsKebLhkAqvETU9gXVvH0nIaE
 8H7sLFaoKjwKSAnCoeczqa+fO0N0xnGc/CDXPfF3bEJGc1nYGNA5YOj3J72GDlXZfpYr83xSgbY
 8LUjCAJbQE+gTJoEB4XjulYsNPY2Ho6hYGt8zbfP8aZTVZfng+c+w+/Ewnju+5ho5gKbQGLSgRI
 dmFEK+ZXMDBYmQpwkc/Y24pOatIhH/gSQtn4kYJtC3bArOOnyQSfinYp9dN/4Bvg6kTM+m7IDuT
 Zwd85/ZrWLQJjqcXiZVEbLfw9w+/UTZQ==
X-Received: by 2002:a05:6000:1786:b0:435:729a:eb6f with SMTP id
 ffacd0b85a97d-435dd032b63mr3359056f8f.19.1769528897999; 
 Tue, 27 Jan 2026 07:48:17 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e71503sm43080090f8f.25.2026.01.27.07.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 07:48:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC PATCH 2/3] target/arm: Handle SME-without-SVE on change of EL
Date: Tue, 27 Jan 2026 15:48:12 +0000
Message-ID: <20260127154813.591744-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127154813.591744-1-peter.maydell@linaro.org>
References: <20260127154813.591744-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

aarch64_sve_change_el() currently assumes that SME implies
SVE, and will return without doing anything if SVE is not
implemented, skipping a possible requirement to change
the vector register state because the SME vector length
has changed. Update it to handle SME also.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index a3dd84a2d6..bf3aca18b1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10128,8 +10128,8 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el,
     int old_len, new_len;
     bool old_a64, new_a64, sm;
 
-    /* Nothing to do if no SVE.  */
-    if (!cpu_isar_feature(aa64_sve, cpu)) {
+    /* Nothing to do if no SVE or SME.  */
+    if (!cpu_isar_feature(aa64_sve, cpu) && !cpu_isar_feature(aa64_sme, cpu)) {
         return;
     }
 
-- 
2.43.0


