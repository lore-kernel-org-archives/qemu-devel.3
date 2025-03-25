Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03ED0C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 15:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6d5-0005qK-L4; Tue, 25 Mar 2025 11:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx6d3-0005ps-O0
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:55:49 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx6d1-0005yx-UG
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:55:49 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so29089465e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 08:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742918145; x=1743522945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uTSRyU7OmmZxDsqp8vpgSBKkvfiWvPzZOW8ib7E9a2o=;
 b=oUMOhmbVswJvNEvy1+LY+Q3vHGJ/M4kgbQvDUyFFman1kQKVc/IkvYBnJK5mBCHwPO
 Y6hOp3riOBSKRd0rWpGyNe5Sb+UTC+uyy58C42iUGMkZK2DPTXhPSFHKF1BqHy5iWqke
 IBfQ/YqEVwpW39/vawH9I68kQZWZG6LfMvULMgviJAVi5U+c2jL0gZIRKla+B5c0HaYm
 q7QDpIM5RIdqpyV5HhPTuWNZKOzc7i/kPjRBHVogV6dIHycAV/zsjUgI0sAn5Ormc8Qn
 /0mmhFlY/go7kmObVeLZPkkpujdHfdgaRvLGo4PhACbeMojtNSccdBbaeCBYdjIx7HuD
 wQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742918145; x=1743522945;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uTSRyU7OmmZxDsqp8vpgSBKkvfiWvPzZOW8ib7E9a2o=;
 b=OUUtsM0zmDQEnPqhCy0nonqBLWt27flo8s2dK8G5lKuzxPUGKACMJ5h59I2Hk452Tw
 BlDL2natDML4FS4vWgss/CMv2DSKjZfchgsocBChJyqTSWQ68YdQaw4WF2Wh9/ZxAicH
 DEjHUdiqNgTlVtnJ5F+/UXXNFbF72bF3sWHlKr6f3sZ8XeOGCPwDrWiYAVrPNWnTE5VW
 jekh9gCsy+viqLmC9d9g7q6Ku0TJpa6vtnUsVqdJNK25JIWLm6Lqe2PycXLHXNmUanvQ
 IUtXz7IeYv6yyts/WRz0qdGnWq6VmT0+XGgvv9v4wR17JgW+0kh+sqS1cApGvQSUvLyK
 mhPA==
X-Gm-Message-State: AOJu0YzmUiGtCBfJIWOWmaHh6u4dZ5STt6O+lxe1ljo945krOkknRVx2
 qed49an2YsTE1ZWwg4FxwpyYDyse/xeDigegbhrwQSar4QvfKlV/TQPqV91AezB1FZp0kRfU3d4
 u
X-Gm-Gg: ASbGncvG0GkO9+ygTzOK/wq9CpBiAuldlFGeaNKGTc5lZXcuA2fV4rZUDQdjt5i0Lwn
 WWJusWQaurO0CD1EeTVndElUtFXil/QY3gzWE4XTTy6M45VUY6UOj9fBi/9QqAyBWDbM0DQwClt
 aHBAP6muCau2ePV+XWOr916RyTy36PHeGP2cymZRy4Jz1/wqWPUI4MbxmvPpPb7Hi21qTRJJLRI
 1vZoFybJlgJzXlqFuzCJZooqFDO4sBuSwz6h2drct86aStRdJhuRVMqBcXSgIPfJkHcs38Cu2Yq
 KZaNwl934GPfJD0obInLcXbH6WREcA0xsuzc147Ra/V+UtmRidyo8ySQSXFbpkFelnb0vJDuAIO
 lXZgnDjUDzEYAj5CzlAuTObkUa9gNEg==
X-Google-Smtp-Source: AGHT+IFFvzhxS//Ekl0XCK+aH+qOMTvGsWVyfqXD3XSW/v/yAR8SgzlXv1hSrbY4YPwRFHqhvyeClA==
X-Received: by 2002:a05:6000:2b10:b0:391:401f:bfd8 with SMTP id
 ffacd0b85a97d-3997f939a54mr11684861f8f.55.1742918145474; 
 Tue, 25 Mar 2025 08:55:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9eff6esm14028941f8f.100.2025.03.25.08.55.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 08:55:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1] gdbstub/helpers: Remove ldtul_p() macro definitions
Date: Tue, 25 Mar 2025 16:55:43 +0100
Message-ID: <20250325155543.95684-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

There are no more use of ldtul_p() in the code base,
remove the definitions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on:
- https://lore.kernel.org/qemu-devel/20250325154058.92735-6-philmd@linaro.org/ (mips)
- https://lore.kernel.org/qemu-devel/20250325154528.93845-1-philmd@linaro.org/ (x86)
- https://lore.kernel.org/qemu-devel/20250325154913.95283-1-philmd@linaro.org/ (riscv)
---
 include/gdbstub/helpers.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index 6f7cc48adcb..3d4a13b919c 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -94,12 +94,10 @@ static inline uint8_t *gdb_get_reg_ptr(GByteArray *buf, int len)
 
 #if TARGET_LONG_BITS == 64
 #define gdb_get_regl(buf, val) gdb_get_reg64(buf, val)
-#define ldtul_p(addr) ldq_p(addr)
 #define ldtul_le_p(addr) ldq_le_p(addr)
 #define ldtul_be_p(addr) ldq_be_p(addr)
 #else
 #define gdb_get_regl(buf, val) gdb_get_reg32(buf, val)
-#define ldtul_p(addr) ldl_p(addr)
 #define ldtul_le_p(addr) ldl_le_p(addr)
 #define ldtul_be_p(addr) ldl_be_p(addr)
 #endif
-- 
2.47.1


