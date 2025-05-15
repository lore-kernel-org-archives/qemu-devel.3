Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEF9C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVoi-0006ml-8t; Thu, 15 May 2025 06:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnK-00050M-Bz
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnI-0008Cj-Jr
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:30 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-442f9043f56so2963545e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304787; x=1747909587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nlujjlRo/q5Y9N/gIBpDx+M72CgU3ObhTfz9p9bVHTs=;
 b=Fg8GP+lUDCqtuwGwbOlvOT3s7xrAmzBV0XSPYucvgt42K2hz/OR23fa55HRjmSA0Pe
 0H5enUlkOOZUtjpinbp5zp1+h1fcaR6qZnz42uD+YFoSiEJQnfPZYg5FWb8r5CTmrPYw
 CJZjHDmEl167GZdgCI1CtKAXdRdEh7N/hBALIQKNemhBn4Tv1qfofiGeXIed4FZW8Z/q
 /00uMUdjmE8cDr3xXfxREu2Cui+ZIcBo6uNBexd0Felqp4XOEGCABVhSmSrGNOpbYfhV
 DJqhIOLephxQ7MW6ha1uDv0vm9gMbN/4+xPezfjNDVLxSIS1xQAiKZDFwri+Pmk6Qc4A
 EZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304787; x=1747909587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nlujjlRo/q5Y9N/gIBpDx+M72CgU3ObhTfz9p9bVHTs=;
 b=tVjLnzCxdbB+LQChmKsI4Ym1MnFy/KXUWzUMo80i6g4JZe4DUlfQvnErz5/btNpSP/
 dnC2CuyCgFzSrtL8QInbSbmWOu/MnxGodgZZPADVRj3rvOS+RnZZSxiEuDK4isUxBIwG
 7z2AzmctBqlsT0CD4vuxr0agqf7LVmtaq1kk2pCnbZi8aYuzTEyF8NUspFzDr5hMc73U
 TBLailkGlOfoq6YSQczTA11Hb+QnyN1J1YEmdm/o0dKa28d4reyEWnooqGA0Ts/AHChm
 Y27AN3Kkz45jhM+qMbM2/MV2ABwMgAbidmOyYHp8nlRzvFYJQGXA283YZmeZ2MaafqAF
 PABQ==
X-Gm-Message-State: AOJu0YziHBNB0AhevoE/GaFFyZloph/0Z4C7zHmxCTc7TK5ViZvym1kk
 BlAVotIPxFnWCGi/2UJwQs5wrd/UcnZ3z7/hgwPpF8Qk97AKhsdSZ+Bnb6nZ24VySlJPEY1PMRY
 nKds=
X-Gm-Gg: ASbGnctPJ/XDl70Cnqkb70PpmRJgozMFoFOuMgmfSxXw9xMBaIxMCOxE0J47X5xwN9r
 Yaw9iWajhdmbnKy12hw+rarZU9V4aHvzHrUiHB4LmVUXnU1Sk/E9tVhs/m7kcXJmwPi3nm1MG13
 DCBJ11uRlxFsLrwkjOSn7VAAa7DAveRvyFqqucgAIxhIBWHJYzQBSCFge9kebgjYn8fiS/f88yC
 /V7NsyAG+vBK0MoawyWArg+gD+opATuHiVOeHPnbGLDD+SnXMdReBcgLkwiSsGEMFBWB8mGZ4wj
 U1E4pkp+uU1FASOGmV2rapw3ESwl8px2WC1zqfC9EVwAY8M/EH+ga/dyZQ==
X-Google-Smtp-Source: AGHT+IGbgflI2OLRd6tHzcbyLJpebzJrxlG2oq2c7sWYvK9x6Fk3eMkDJU8GAs4bWBacNY59tfkjsQ==
X-Received: by 2002:a05:600c:1c2a:b0:43d:683:8caa with SMTP id
 5b1f17b1804b1-442f20fc9b4mr65672835e9.15.1747304786780; 
 Thu, 15 May 2025 03:26:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/58] target/arm/helper: restrict include to common helpers
Date: Thu, 15 May 2025 11:25:17 +0100
Message-ID: <20250515102546.2149601-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-20-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4a2d1ecbfee..3795dccd16b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12,7 +12,6 @@
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "exec/helper-proto.h"
 #include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
 #include "qemu/main-loop.h"
@@ -35,6 +34,9 @@
 #include "cpregs.h"
 #include "target/arm/gtimer.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
 
 static void switch_mode(CPUARMState *env, int mode);
-- 
2.43.0


