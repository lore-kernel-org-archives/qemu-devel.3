Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C06C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 13:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxPG1-00024k-40; Fri, 21 Aug 2026 09:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxPFz-00024G-Fx
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:26:03 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxPFx-0006Pb-Rq
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 09:26:03 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-47f703a9d05so603791f8f.0
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 06:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787318760; x=1787923560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I0h9mD58WMwK8xuh3O68ZsPFvMRWW43LjfznY7PTEQE=;
 b=LsMquxZCJAEbFBdfWqF2NQKmKhC3vZkn0ZctQxgvKajzKSU958uKr6iDvIcCM0cUjN
 TCPmaZuLUp0WwEdmdeuwZR9MTkNXT60h+E9iwqXPBwuAGneSrTqB3fGKheZg2mfq0kYM
 xdI+uJ0ZwuemNQjkNGUBVeHjol7T2EUvCH3RW8qxC9hfW+6DPvY3e/EmhmwHT8Oc555d
 jj9Q8W9t6tv2erG7AW/Lxg31sWPWvY7EcOdK3GIYa/ZMI9trncMpWjqiad1VhTlq7Oay
 K/9XT7E3a02W5iD0IHk4RPQVSPaQj0sxTqDMgFzWEtCZX/J6YamHnK+E6g68kz/BZcDS
 e1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787318760; x=1787923560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=I0h9mD58WMwK8xuh3O68ZsPFvMRWW43LjfznY7PTEQE=;
 b=Vlrl8jZJTcUQ0bKpfoEtGH88ZUOcjIqagq472aYqVZnI+VfhVqPmGjyzwmCs2NmEOY
 Ra95XtrAqv/kOgMJzdF6oc2bERbJmdEhZ0xDTycC/t2ZIGMRV3FeWKZWWy0t3eHozOaG
 5t0YbeYRoEM5l/Foen1BkCx9W+yGlzxjZZI6AJJRd/AHGvNMGcBITw7gVrq0utLe4C9I
 Z1TA+D50ZpMS6jJM1Ua6XxZ2q9f2G0140hc2TBl46IsT3F7hSs3oYdujp5PS7E5qbLee
 34IURZYDPtgMG5N8to+t7a7HJyBBu66GumeWq7f3gKT2f4WrQ44IwvOP0LUyO/Gh/wzA
 lsjg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp5B2MBQwMnupSfZSm/a01aiJGvombsy/bU0Z06GK1lRtOf6HAZ8KzpyUbwqXPO+NgRWlXCNJwGXxZH@nongnu.org
X-Gm-Message-State: AFuF++kpJIYLuxXD0nvmf9QmE6fjuSe4jXs3yotGwK3McSgckd/y8tIg
 XsXSY7nvfT6V/9N/d27ni76MZ8Rw3dQDmlGNoe8ZPoVjC0BnKAFRVxC2knBGgEKaQ9gBP4qBEB4
 xvN2eELE=
X-Gm-Gg: AR+sD11Dth5ay/Fi/mnQh5beHEZAO6XFfFF1AhLdU4JRJ1eQpZ8geq1yRiSBQdKAGHJ
 E/KxCshSIiq7DagHGueEKRml3fdqjkOHrMnHoxS6y0mIc7ATk4xeOler3Hryzdo/qlR7B1ff0XS
 A4xcTiOEuLx9PTMS07rAkAHWG95GpHS4zWmWl/fexNrOYRJ53OXSfJsiVVyMcveIWAeLeVdsX4d
 74MhVYqYSG16N1zyjzjOixRcqgDdS59Uv5TZRvETpxANeJcdw5li5tGWWIm9MU0DHJQgl1daIN1
 wXpi/+e9h9TH9OhThq11eXJGmCEcSk3roxdi78qIC63MUfHCFNUhPfKNBvc5M7EYNlNLAYQJ4EN
 bpN3LQydCZ3bbdKyliqkKS6c+mEI9vdRkZtvJtQ2Lg0vhk1u1PGZtyNQxPblnbQU7d05kQ8W37w
 Ansj2zJV5oK79MWEdJD4cJKFf8FdFv9pdM18vuIY+5pB5xSA2qbKclcTkqV4cgVw3wHMAXRwI46
 96EC1kPyWi0ev44+WkBuzpOwkyRwhaxNq0gRgeWY1pFO9e+YHHN0aerk95l4sRV02GeRg==
X-Received: by 2002:a05:6000:4811:b0:47f:8fc8:a8b1 with SMTP id
 ffacd0b85a97d-482c0b9b22dmr10710256f8f.14.1787318760304; 
 Fri, 21 Aug 2026 06:26:00 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1450e54sm18770327f8f.11.2026.08.21.06.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 06:25:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/3] target/arm: Make IT insn undef when not present
Date: Fri, 21 Aug 2026 14:25:49 +0100
Message-ID: <20260821132550.168896-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821132550.168896-1-peter.maydell@linaro.org>
References: <20260821132550.168896-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

The IT insn is introduced for A-profile starting in v6T2; for
M-profile it is present when the Main Extension is implemented (which
includes v7M and excludes v6M).  We were missing the feature-check,
so fail to UNDEF on earlier cores.

Add the missing check.

Cc: qemu-stable@nongnu.org
Fixes: 9ee6e8bb853bde ("ARMv7 support.")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index df98dc2e34d..103e2fe7c73 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6038,6 +6038,16 @@ static bool trans_IT(DisasContext *s, arg_IT *a)
 {
     int cond_mask = a->cond_mask;
 
+    /*
+     * IT insn introduced in v6T2 for A-profile; it is only present
+     * on M-profile if the Main Extension is implemented.
+     */
+    if (!arm_dc_feature(s, ARM_FEATURE_THUMB2) ||
+        (arm_dc_feature(s, ARM_FEATURE_M) &&
+         !arm_dc_feature(s, ARM_FEATURE_M_MAIN))) {
+        return false;
+    }
+
     /*
      * No actual code generated for this insn, just setup state.
      *
-- 
2.43.0


