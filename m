Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8CEF99363
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqud-0007mz-Mh; Thu, 23 Apr 2026 06:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFquC-0006Zo-AH
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:35 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqu5-0002NW-Br
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:03:30 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43d75312379so4751908f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938603; x=1777543403; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QN43xmMq03C+GhN/cYJlUfio02EJPwSIHegtQrTYpd0=;
 b=eU8IIJNBYfuN57QBB1fM7DCriQBlFZsAEWftl/+5MwZWLege/GhO4zb87mij9cBokX
 eJ2tTeMkoc/0umZLVAkMifzlw9HT/vH4k/HbLkiNA0q6arS1L/B1aWEZ1rSrFslmpGMD
 449F4OcO9/HiHlWc6MhlbFxEz3256YU3/6jGzBBX58FnIm0V95mvDQHzKQL9mttk7jHk
 wXj4i7UM4JJUc32x0OGk2wvwOO4TVWO6XObkoznp4YN4s/ENLX7MnR55Wu7RNJKNcaRw
 EUV4++x1fvvHQZbYM0y/gRcsDq82TSmqOXs2YYpeYj0aqHxvZ9bxFN27Zkj2sF3pVCau
 R6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938603; x=1777543403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QN43xmMq03C+GhN/cYJlUfio02EJPwSIHegtQrTYpd0=;
 b=Y0VC/gnmq7HeEV+lB3ka/Dhs2NbUFTN0L12JtZd0ClbpcJgaxLV4NwxQzaaEQP8h+f
 XfFSb3XB4cb/wGMZwXDRjsZlmPbEVjZfddlQ6Oo70m4bprrBr07dIIl4XB+ZXwa4x2dK
 aYScJGDUDP/zFeem/ewnuHmiPAqpM7RRgiTNn0ZKhrGoeUiW1Sn5FJTBkK97c+TNZJU2
 0PQT8Y8hBbfSVNC9FP8wViT0TUye/h4cN1jFvH2E6V3KX/3Zz+7aF5uXaA9wj4ews7eh
 FxtgiZVwCtnCct3YbVd4Ghr+VAZL9jLt1nKMq3tTdElcByW1LWo3S7gQ3L9WTGTofv8g
 ciXw==
X-Gm-Message-State: AOJu0YzaDOrxEftvo+dqgtLnuO8nP22M3k2u14Tfb620VH3n8XK1V7D5
 msgble+bI31AE8S6eW9JX7FzozMMceiT4uegdRBbALgYClQmTlW/Np3/H8c34A2smxsQ0TTvty2
 5iedc
X-Gm-Gg: AeBDievhx7sd3itlYlsU1v+fc4/ujzFezGJ5tmFeZm7LYRIkfbgUV10Qg5szTTR9Bws
 8MtkwXORPy6T6BhqSJXP7ENi8WVa4tWd23+7HsN4tUss6XwRmIWxqlUE89EeUa7J5b+ytujQ4jl
 rfKOSFrjNtxOVWPh0R53mio8W6D4YPlgQSwrY0YwzB4Osu/mwGOhRgBkGBjt9EepWguFajEuRKq
 Nc/tPqlmw0QE4q+yDqdtQKzgrVVVkbTfLkEZLkJFAqW4w78QYr7GbKBY3Dwdh48oxPCTuUyQULe
 uyjbx3Je7y38R5V0zOAR5cQaX3xDuMT4urI8LYrGnRjelJFCxulCi+j8xVQiDlVNc6gXCrEUTQg
 qOfQmGvB0EpuWlhbSP7FCKtf97yGky1dKWjOjJAcfLx6LHOB+68lJkecC/B1Z/rkzq1na66NKei
 IWs0IzFeK4AWfBq9g3v4W3M2TXjPsVZrb05lkR/r3IsFDIPluUJazgRh9xCbK/qLOa+PsZTc3ak
 ztASPUdQIsaRngsskkcFS8epLzRQDR5aioOz7pf6w==
X-Received: by 2002:a05:6000:18a6:b0:43d:6df0:c7f6 with SMTP id
 ffacd0b85a97d-43fe407a70dmr41308465f8f.18.1776938603386; 
 Thu, 23 Apr 2026 03:03:23 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.03.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:03:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/59] MAINTAINERS: Remove Jia Liu
Date: Thu, 23 Apr 2026 11:02:18 +0100
Message-ID: <20260423100229.2941820-49-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

Jia Liu has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

This makes the or1k-sim OpenRISC machine orphan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260416091654.316158-18-peter.maydell@linaro.org
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 07a08b1a65..c58200cf37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1497,8 +1497,7 @@ F: include/hw/pci-host/xilinx-pcie.h
 OpenRISC Machines
 -----------------
 or1k-sim
-M: Jia Liu <proljc@gmail.com>
-S: Maintained
+S: Orphan
 F: docs/system/or1k/or1k-sim.rst
 F: hw/intc/ompic.c
 F: hw/or1k/or1k-sim.c
-- 
2.43.0


