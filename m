Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85668C7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk4H-0000dK-8x; Fri, 20 Jun 2025 18:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfbA-0007y5-Ry
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:32:20 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfb8-0006b8-W7
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:32:20 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4530921461aso17916425e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440737; x=1751045537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L4yIceXOfpWG6Pc9FN4242QyS92dqsokOykU1/e0mxI=;
 b=AttZDGh2iGX6RtRrDxQc2CYyjuYFAetd+VJkT4ymNdC0l5EI5DUeK1LTPeTIyE5L1G
 /al56n90OJTwadB/HeudcbTmQe9WbtbJ3stwvMlTfxGCloLnSxT2Ss7gtQ6a4+WCkUMI
 yrjGnERK8FGR+9SZQfMs+a0fhmE4lgLt+29Cy0S61MpY116sFBxDATNjAH0dcGuGha4p
 KheJVCRz+EJJxzlQOYQcZfpgPXWb+0I587MA79ygiaYcanzx8fWFtCI7meUzgf2M4wP1
 mXVdMHGFjZwcGkifXKx/XyaQMAqvCsrAww3DC3LbttZwbqvDDWi44U+SPFJNdMTahweN
 g89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440737; x=1751045537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L4yIceXOfpWG6Pc9FN4242QyS92dqsokOykU1/e0mxI=;
 b=fCP5QLU6NXH6kix0+89OZNhmAaBJM3JRClKJs9qm7iuRmJAluV56jlHeDJqo0E/cRh
 Tbiwko6HlbuBx54jkGV3XqWvSTPOrf4X+StVuNLACln/TjLDY/kcFJLQcydQnkQPXQaY
 n8TEKbI996B9xZhuOZoqrlqwB9bYUHgy39XN6BJw5Ucr7WWYmF2rISkeZyM3JHHx4s3O
 ROcPLzN/8pM2oC2d/A6Eh7ogSDSt9mjVD9Wl7BhOobkwkMRHAtGv9fJcYUk40q3u4tWU
 zu+6UClTq1soklab6D8p+hcIZs3M4IZYM5rny4CIsgr5FxxE5so2P48PGnkqN+R25r+K
 KV0g==
X-Gm-Message-State: AOJu0YzTWiBrTGp28m0z0Kj2gcMd/rr9b2OVLwoloZrsuP+V66GPKywh
 GQja/oSDILBvlqd9fUhTbMUH99L3rnmgcnuIgqMdu6aMVwEp3j+h0hk8mFBR6QaDPM3wYoVXoxd
 gHYr5sIu6PA==
X-Gm-Gg: ASbGncus9qN7WCTaltkmkEP0t49CsFPl20gTKOvbezvVQ0snSx4zNpR2OP07zfxwl6n
 ftM9RPmXF1b6PVqfSHOZA6zhjoUuIrwpKj0O96cD3lvc0SYjRvqtg9+qPCROvy5g4HmaF6LedZF
 8GMtqr0yDACfO6XXLsH6g+Bm+eh/oZtCtPNmaBFoD2cOo0ZgMLNI8WK4SKXMZsT2puZa3BalBNe
 YUEITerS90d78qmpPRxI2hc8gCAITZ42eZvGUPv26CpuqSV1dxsviRSLKy1IbZik2/hFlEHEZ3N
 jUVuKsMLKlXs/cvH4lmAK/VfJgi5zU1bOv8p+0mUtk58KdWSFvJcJD4SWuD9QdSxxuvx8JGA7BD
 oiexennxUZIjBQOXxX2fayxYkLGCoCmhsyAjqDwscE6AZlcgtkJen7Sm/
X-Google-Smtp-Source: AGHT+IEyCkMsOeYLjkP2jOQLWTC1x1vBDziIee5K4iwUkfgdCil2Om66od/XztWIC4I648fmJ5gQbg==
X-Received: by 2002:a05:600c:4e50:b0:453:7bd:2e30 with SMTP id
 5b1f17b1804b1-453655c2b6fmr33948515e9.29.1750440737310; 
 Fri, 20 Jun 2025 10:32:17 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1187e80sm2577352f8f.78.2025.06.20.10.32.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:32:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 30/42] accel/split: Implement
 remove_all_breakpoints()
Date: Fri, 20 Jun 2025 19:27:38 +0200
Message-ID: <20250620172751.94231-31-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/split/split-accel-ops.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
index e1d91ace2fa..0f3d48fc68d 100644
--- a/accel/split/split-accel-ops.c
+++ b/accel/split/split-accel-ops.c
@@ -269,7 +269,16 @@ static int split_remove_breakpoint(CPUState *cpu, int type,
 
 static void split_remove_all_breakpoints(CPUState *cpu)
 {
-    g_assert_not_reached();
+    SplitAccelState *sas = SPLIT_ACCEL(cpu->accel->accel);
+    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
+    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
+
+    if (hwc->ops->remove_all_breakpoints) {
+        hwc->ops->remove_all_breakpoints(cpu);
+    }
+    if (swc->ops->remove_all_breakpoints) {
+        swc->ops->remove_all_breakpoints(cpu);
+    }
 }
 
 static void split_get_vcpu_stats(CPUState *cpu, GString *buf)
-- 
2.49.0


