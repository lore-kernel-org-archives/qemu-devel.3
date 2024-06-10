Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6A3C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 14:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGgTq-0008Hy-1M; Mon, 10 Jun 2024 10:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGgTo-0008HK-Dp
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 10:58:40 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGgTm-0004X4-Tb
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 10:58:40 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57c73a3b3d7so2114233a12.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2024 07:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718031516; x=1718636316; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YQ5kcnCOObbjA6/Or2TYLNPevY5gyQfg0ztfeo6rNcw=;
 b=K746NmEsNtGDUKEmxf3tt0bjxGNYZWyivyOwOcjqPJ3QSKMu0A2UEdHckqhsu5cYjg
 dX7uv/4d0dnEtpQz684d1QJFV0hkQe3PNY1o70iM8J3pLVyOQYRhU+bUidBvJZ8xQxH0
 Ouck4tVEZCbkfDwJ9qNv2QcctolDWPeiqgkpSUk6RpNWK4sm7JRZoMgHAn68BPuqaIUE
 j6trX/Ka/p/xoibaOY+TK/Seabfruk8pkl6ClOucsT13pznufaV6Kr1rLFMIiLQkRVJ0
 8JVh/PA4hCrZ8G8PLJt1G/o0SCpqBUDgx5Zn3kQ9BbvzJqGxTHEkulh3ihMXXj0VGWz7
 Y8cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718031516; x=1718636316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YQ5kcnCOObbjA6/Or2TYLNPevY5gyQfg0ztfeo6rNcw=;
 b=KgGscvJIam+A9v+4cRhrsED/UKLjsGApmExzOIuNZGDxl0lPbwaulwviXq9Xhfzb80
 OWa9Cm2frsSEo/qLb+UHeL20kR9Mksn2x1pQdxU0gRTMde9ozxSRBqgQ8I8xayJ2UyaR
 nw4lmZKnYVY9TwiJazpe0lG2qZlfuLq+QPe16/ZbsxVDW9UHstuE6CHSfymXn5LRjRYQ
 OgYWlc7wlBi8/rY6tEnFZnsCV1SkXna+NUK91RAUVDtMtNtMSeSzaYH9qczA8anjoBw1
 DE9ZL7Qg5gVJfqLxtkJJtJCQO0A8rV+5+5/Bf6+X4EVgJ8/MpoD1HMf1Vynf9OTy7ACg
 MLAQ==
X-Gm-Message-State: AOJu0YyZoXChgQjnT/PULRNEInNbFs8J7HFUgPBIzmFSYA2Dp7O9gStp
 EWgUlIRm30yCWtXyptz8WFdA0GNrIKN/fj38x4iuFDbOOvvgwIs2Nml/YQtwi8sh7uD7TpKCJ/k
 I
X-Google-Smtp-Source: AGHT+IFFghnUUT1xwJI05JQ+d1oNY3X+dmMT1DQ3Ay42A+j5eL/zpCYCNZcoPkSDZbFeGFW3W9skuQ==
X-Received: by 2002:a17:906:3b88:b0:a6f:33d6:2d45 with SMTP id
 a640c23a62f3a-a6f33d63036mr2735766b.60.1718031516113; 
 Mon, 10 Jun 2024 07:58:36 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f11e88ccbsm267003866b.133.2024.06.10.07.58.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jun 2024 07:58:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 4/5] target/riscv: Restrict semihosting to TCG
Date: Mon, 10 Jun 2024 16:58:06 +0200
Message-ID: <20240610145808.2267-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240610145808.2267-1-philmd@linaro.org>
References: <20240610145808.2267-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Semihosting currently uses the TCG probe_access API. To prepare for
encoding the TCG dependency in Kconfig, do not enable it unless TCG
is available.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/Kconfig b/target/riscv/Kconfig
index 5f30df22f2..c332616d36 100644
--- a/target/riscv/Kconfig
+++ b/target/riscv/Kconfig
@@ -1,9 +1,9 @@
 config RISCV32
     bool
-    select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
+    imply ARM_COMPATIBLE_SEMIHOSTING if TCG
     select DEVICE_TREE # needed by boot.c
 
 config RISCV64
     bool
-    select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
+    imply ARM_COMPATIBLE_SEMIHOSTING if TCG
     select DEVICE_TREE # needed by boot.c
-- 
2.41.0


