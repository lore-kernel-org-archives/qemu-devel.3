Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9DEC83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 07:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZvp-0004Nw-Mw; Tue, 15 Jul 2025 03:18:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZt2-0002VJ-Sq
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 03:15:38 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZt0-00021c-Nd
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 03:15:36 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a4f379662cso3852548f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 00:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752563730; x=1753168530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jK3VHhVp0eVShcAqpjGBRXDmPLTaiJrK+trki6OAZaY=;
 b=llYz9pi+GS68hsRs3UxY4YY+rN7irCj9K+Umx13Cxs/24yh4EWf0K+RQamolW8cdz4
 SyBiR1XMx7dsUT2TZe45nylPs1AiupeC/J2t9wb5Q9vEmQ9vGrFbkHKDYCWB4w0ElbR7
 MDKm7HBlHbwTVr5C3mCLD5hGbOjyv6BvxUwoIlDd9bZc+48bQUIe10M80t5iAw+RVXYA
 DwSC2U8YtYm1zkgS7Xk5sdSIlkSpd9kON8bh7PnhPX2DkVJbxrqT9Nr/8Ze1UO7VpjSU
 6d2Kd7K8Vaz93WT4UdrxyndTEMJb6/2Qk2C+yyMpw38NBmhnEwyBPd/t9r73i1WbLDFx
 ECIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752563730; x=1753168530;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jK3VHhVp0eVShcAqpjGBRXDmPLTaiJrK+trki6OAZaY=;
 b=pyJZVuWr0SI+LyJXDLfEzOrp12yM8L0r+0RtchleP/oPndtvm/XZxlC74gpaLf5xf0
 14NwTeDI8P1i4HmBxud8+mQRzFV2XUMRSwx/9rXWNLM5OwC3Cc3ZJ6FmRLx5GRNnZCIP
 UZQYCtlf0lHltzUkSyEqadnb0I+4fFtxLpO0bWUyPsAubqthmmujlHuvifsrNBUV8gM8
 wRpovwPtb7KGlnYAUlysvm77gpo+nYDfPJ9Kqh55DqscWUbDbOtlOVvrgHPN66N4jD5T
 w/PZPNynK3MmSJETbEIFD4yOzFEoc/TI4aFzD91zKL72dDR4Q0fcvfAdgqvYFmGDiDH7
 lbNg==
X-Gm-Message-State: AOJu0YxU/RNXUiSSMj+mrOFcrDYEQUKMt+OToD+PkX3Pxm9kORE1jJVe
 a3wt+Edv5c5o/djSqlv0cXAt37wsJJFlz1cDEZM+PCF7PoW7VdEl2evXb7UQS70aT3O6ra+1ksr
 ndixD
X-Gm-Gg: ASbGncv0DxSHR/tntWJjY8LLYezN12lD1029ApXQkTbjmhavBIkem1j7fFrcpcvXRHx
 /q3Cj0fkkkGR7CB3Lnz614u4b4v0iUD20TodM8cHK8aVML8NdBFTI6Qy/x8yic6uPzt0X//bTKM
 9MBpVrUFubd5U9vS1f+mn+ZbSIbiHU5y4aqd9Lc+Ap3ZWt7ovkgu/2Odm2fQXb8MeXVgg8hKL+d
 Dz5xc3HQ3cJtLtjZSmecKC5MaKfEtDWonkkwT+ctozqo3Vk7CMyCJslGvtiyzXU00Dbb/0qmg8F
 K30ejtAPjj+UWxhSsu1leYxl40emBmuNYm/5dlEhQF6Y+9ujA8TRK+WsI8ZO9wSFmtpdhZLaPW0
 o8D+8tm7tlQUI+dBmC0Cld/pc6eAY8hhyD04WlPbH1PfwHURDIfa/6rzcu0bD6xErpnQ8QMSHRs
 IcbQ==
X-Google-Smtp-Source: AGHT+IHc/hNaSxV/q5zS/EGfLlhOgnJMNAW+20yw+IkE5PFdUkO2Ro8e29tK1H+hW7tz8zfDXyx3sg==
X-Received: by 2002:a5d:64e2:0:b0:3a6:ec1d:1cba with SMTP id
 ffacd0b85a97d-3b5f2dc2ce7mr10700753f8f.20.1752563730160; 
 Tue, 15 Jul 2025 00:15:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4561976784dsm57489215e9.18.2025.07.15.00.15.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 00:15:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anthony PERARD <anthony@xenproject.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v2] hw/arm/xen-pvh: Remove unnecessary 'hw/xen/arch_hvm.h'
 header
Date: Tue, 15 Jul 2025 09:15:27 +0200
Message-ID: <20250715071528.46196-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

"hw/xen/arch_hvm.h" only declares the arch_handle_ioreq() and
arch_xen_set_memory() prototypes, which are not used by xen-pvh.c.
Remove the unnecessary header inclusion.

Cc: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20250513171737.74386-1-philmd@linaro.org>
---
 hw/arm/xen-pvh.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index 4b26bcff7a5..1a9eeb01c8e 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -10,7 +10,6 @@
 #include "hw/boards.h"
 #include "system/system.h"
 #include "hw/xen/xen-pvh-common.h"
-#include "hw/xen/arch_hvm.h"
 
 #define TYPE_XEN_ARM  MACHINE_TYPE_NAME("xenpvh")
 
-- 
2.49.0


