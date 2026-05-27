Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585EACD5BC9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBZd-0006wq-6c; Wed, 27 May 2026 06:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBZG-0006ig-Jl
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:32:57 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBZB-00016t-VI
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:32:53 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-490426d72f7so48815835e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779877968; x=1780482768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KC9M/BPGtRZabupmwKtiK6pkpu9e/Wyfnwu/kI1Is1I=;
 b=C5V/yvNNhnH5IlBIqlaWXFyhwim/yavZhGuAGobJm8K+/rNNxi5QWACGoy3mu+WAi4
 G6SpgLI7gASiBS8mAdevS2hYVXUMD1rne04jXQoR88SwqZMM3T7olhkbfdJcH/RjWpz3
 SfNbFw+NXQyjLK4/otU+VnOWHu25eAb+xcUaDqRstfq3YhOo92G0nz1b5hGOePmcMuYH
 IsILqqh/qdr5anz8wv8hbgit/jfyLoDGw6tt4lhhXGS7FvATd2ZyPtEtQvhrPdDkUAqQ
 7I/JFSm1wjaNcWEAMYX1M8mh3vM/JQA8ZbKmkSVCxgcTp5LbOBfdNH6hfkH+uqWBnT9h
 wtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779877968; x=1780482768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KC9M/BPGtRZabupmwKtiK6pkpu9e/Wyfnwu/kI1Is1I=;
 b=VjJac/KyNNaL+g1B2uZA7RfBR5UpA5b89q35jmmaxBQ97+8mVL+p2TwmMntL6OtclA
 Q7F2xwCtQXDddYLNLSkWITIU7dqmT9RQ99bsw6kATw3smMMoan0wrlXMxBtysNF+qkzV
 8cdl5lcdumaKSH5NuHTZz2jt12aUbnL+YMFpA69A+t/QxBJioGSmUR5GHjl+0dicOiZT
 w8azpFyXZdur9jq/4/a0fwCWaEmYsUMGpVt0NnzNd3jVBrHh3Pqg1Iqk9IjsdNJuSkiF
 W9n5dLp+Jm6vzntfF2ENEqGjK0ywtnAZHjnq0yQ05PmV4w2z2g5hQ35m9YXdb1gVLcy0
 MHdg==
X-Gm-Message-State: AOJu0YyrhjfARIWQ6flFLjwtuss1367O8qYm+er7IaRhOpXW0Q52O74O
 huKO3U71shtxTt34nu1k2f/j7C3EiefOF7E2jm8Wraplv32arOBuFuM3gbdvdtdIaVn9uVYq8YB
 ARILECRI0Aw==
X-Gm-Gg: Acq92OEQw68r2x260c+AfTfoDbbSonhUFueEnC/fo6AyXJrAMFCymHdWpKsH4n5Yj9k
 UAbqd2SIhPZCwS6RsauGznVBlz97Kmfz1tdMg91i3TCrqlP+s+ddFWVnMylIjtdHhcosgBPvMGs
 BFCQyvs1qGI/sneRq62iSkxguCMij3nOH/68uS8QHDwcbFijfVH3vEB9IvwB6X/4pcgiiHlT0ks
 V2yraJYbdcN5vWOfA/RHGB99/RS+YAv8T0e5hTQQ1WzJSXg0yzUCkf7lu+KqFKysTgSKt80NAzI
 MkVUT88wDpbRE8jYmxQ3JCocrEgNhYC+uxdRyMxd1O3gce0lCGyT5gfrcAxWH0qFUVXL7g0kaUI
 ZfzO7ctw8AecZAWq4vu1885BBm1vSf9uEAwr54mG3exnvstL68ab/S5d2K9db5I5V1YJlWrxH9f
 isPp7YHb6CIDlLUyF+zZ4aH3sU9Fnw5zVQoLlkN86j7khD+t/LyYsDOeQ=
X-Received: by 2002:a05:600c:1992:b0:48a:76a3:2b9b with SMTP id
 5b1f17b1804b1-490426c5416mr356231065e9.17.1779877968139; 
 Wed, 27 May 2026 03:32:48 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904561a160sm445846315e9.9.2026.05.27.03.32.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:32:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/32] target/arm: Build cpu64.o as common object
Date: Wed, 27 May 2026 12:30:23 +0200
Message-ID: <20260527103037.4461-20-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

While gdbstub64.o is already built once, build it as
common object, reducing target-specific set in arm_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20260526203722.79463-9-philmd@linaro.org>
---
 target/arm/tcg/meson.build | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index b0f5342245b..d5a95bf54f2 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -35,7 +35,6 @@ arm_ss.add(files(
 ))
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
-  'cpu64.c',
   'gengvec64.c',
   'translate-a64.c',
   'translate-sve.c',
@@ -80,6 +79,9 @@ arm_common_user_system_ss.add(
   'vec_helper.c',
   'vfp_helper.c',
 ))
+arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
+  'cpu64.c',
+))
 
 arm_common_system_ss.add(files(
   'cpregs-at.c',
-- 
2.53.0


