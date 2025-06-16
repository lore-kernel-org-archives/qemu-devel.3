Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65489C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 20:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRGAS-0001l1-1a; Mon, 16 Jun 2025 16:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRGAP-0001k4-7f
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 16:10:53 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uRGAN-0006IE-06
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 16:10:52 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45347d6cba3so4362015e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 13:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750104648; x=1750709448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e1HQznq99qoCK8P8PgCsYfpPefLsvFqz98NOZI1uUSU=;
 b=tyC3dZyxRvrr7Da1k297sXE1T3xhamu1b7g0UrUO+eWVI1rmLx5ZUy+lGc6jtbEKhu
 pv5IjpPRqyZ9vKxM2gfOmU/lwibX40DD6UsIPbNe+DAj+OMvmu2lklGf0cvEEU+xLHOH
 3m/LmGF1LDjiwcKDOQuJWnxqZ2IjdeWxZQcnMMd1MxY2OhKuJcyFfp5XISbRN72e1hz5
 uDQBAyW+JgDgpKBjlqYp+j6kiTMwiaRaz/i3wgehMb/ATjnkerNn27UXAogAYDI5IkNf
 dC3UH2lHDa+NSpVMCts0ovBn8dpMwZEwWm1tyWGTqa3WUm0XdSR/CAkbDbjxOI0pc/s+
 s15w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750104648; x=1750709448;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e1HQznq99qoCK8P8PgCsYfpPefLsvFqz98NOZI1uUSU=;
 b=ZsOtGSzJqxMW0/yOsllF0g43kI7dNt8zTscktBCei80AAUT7VcETjidP6fgV1DxOym
 5bBvN2QHSDGFsMSMjKAm+BIyUQgv6MDWLt3LJEzntmGP/ADJbYkXRTJDTEl9NQsCYisd
 I6CPUtQXidUzEq4Moev99PIiTL269z21SCRPkuhla5i8Fb9vqlDiURwWJAEhK3J6sHM0
 fO9SI0D6/tO+ePPXUS7rZSVLJIuJ/OkO2TVogXsiQjeE2nz0ztlhYwmOQyjEfynUUOFf
 VQAUUeNgfDqfaTNpszlCvQj5pBGXKMlQFUyaTEaTnhTunBWpKSmAL6p/qSJLDvjUblWR
 FW6w==
X-Gm-Message-State: AOJu0Yz964MW+CaWDkJP3O2Mj0qmaHAFTzKADBHUydwKTYOUlRa0b9gw
 xrusitxtuCD4NsdrzYsSVlfkx7mCPqMDo84sCRrOvPDzefDyvzg1VgCS7ld47TJOfdKZw9c0a4U
 iHe0xkxU=
X-Gm-Gg: ASbGnctSeQg6q2hyK+VlFSigpMTeftCv/0kUxMesh4jrZvqkB1XhvOEogu0EzsQCr98
 ihaUV0o4PZvBe8DRSdd4ZwWAbGhZEwOFsxohj7O1P+rAEmY92wSTiIlLqvxOrWJWI4vqMeVVwpZ
 v0IS+Vwdu4NdFd5fzgPR2n5ZZOTQloIK3FUQvbDbnjCTqkcHnIdZN2nexkxfXjNe0FC2E0g7gCE
 Z0u8SX3I7EwhPtXiO22mLl9TuqsUOZgZ1Bp0U7XlUVYHvBG7o9Lnj1Sl+9a11Ka6j+CWhnE/Mtr
 C/c488utmzZT5GyHOBOdkz6HkDsznsAFKIWLCgopUxQYjwcVuHzXcP96FZpjtWA=
X-Google-Smtp-Source: AGHT+IHGttkRrfephVCBQu0wUh/9hw3NjkRpFA2g7XLjUPlYK2Q5LCLzFXgzlRRFiOykgcrvx0kk+w==
X-Received: by 2002:a05:600c:1c0b:b0:453:1058:f8aa with SMTP id
 5b1f17b1804b1-453418d1130mr91380755e9.15.1750104648334; 
 Mon, 16 Jun 2025 13:10:48 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532dea1c27sm152889575e9.15.2025.06.16.13.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jun 2025 13:10:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2E3705F7D7;
 Mon, 16 Jun 2025 21:10:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM cores)
Subject: [RFC PATCH] target/arm: clamp value to account for RES0 fields
Date: Mon, 16 Jun 2025 21:10:42 +0100
Message-ID: <20250616201042.2196127-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

If the user writes a large value to the register but with the bottom
bits unset we could end up with something illegal. By clamping ahead
of the check we at least assure we won't assert(bpr > 0) later in the
GIC interface code.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/intc/arm_gicv3_cpuif.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 4b4cf09157..165f7e9c2f 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -1797,6 +1797,9 @@ static void icc_bpr_write(CPUARMState *env, const ARMCPRegInfo *ri,
     trace_gicv3_icc_bpr_write(ri->crm == 8 ? 0 : 1,
                               gicv3_redist_affid(cs), value);
 
+    /* clamp the value to 2:0, the rest os RES0 */
+    value = deposit64(0, 0, 3, value);
+
     if (grp == GICV3_G1 && gicv3_use_ns_bank(env)) {
         grp = GICV3_G1NS;
     }
@@ -1820,7 +1823,7 @@ static void icc_bpr_write(CPUARMState *env, const ARMCPRegInfo *ri,
         value = minval;
     }
 
-    cs->icc_bpr[grp] = value & 7;
+    cs->icc_bpr[grp] = value;
     gicv3_cpuif_update(cs);
 }
 
-- 
2.47.2


