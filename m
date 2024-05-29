Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B34C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 15:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLbF-0004st-GV; Wed, 29 May 2024 11:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCLbC-0004rf-Vu
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:52:23 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCLbB-0000Kj-5Z
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:52:22 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-35507a3a038so1426431f8f.0
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 08:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716997938; x=1717602738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GQkwYYE8hIz6lkjcirvUNJ8jsRUmv18Y8rHqkzlLzrE=;
 b=v6YYKOEdu7F4Zm0I4Q9DOe2N+zeaBYRh40BnwQvL3OQBvRJ7qIN3lz070L5rXl4kaH
 ma2VZ+tIAnMxsyg0nDgaAknPxowXV9PPBdDUeo7SSXhYg3Lz/oEUsey3RPT1whjj783L
 Aq3heYPP4GBeMp+4okCK7xyflWuJ7OtwXMvGBobJxd4azEy8Z0AIkqqrCMkCtc4M6ooC
 9Vwy3peJodcD+CId5Wg6sqXaRCL5r5p+cNb/wbb0r8cErfnTUIU83deQriKQt/zf1G+a
 +Dub2IJ0jlWTtoILk5RTckQzYUmf2W9OX8OoJKnq2dKPOGTT8KRsGZR0Rlfy/zW3VilD
 Rh5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716997938; x=1717602738;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GQkwYYE8hIz6lkjcirvUNJ8jsRUmv18Y8rHqkzlLzrE=;
 b=JItxuTkvfCdWPIDlmW91KEqRdQpBBSCAGmViAa4GPOCJulYKKL6IBgWTtxZ/IAXwlX
 axu27YcwV+A2OeSMIUOWLeIyAL+5NsfBe2mxCXqZJz2yeY39PFH7uKrTtKpylXnQd8kk
 7pUFdSe/Pe/Ew99QAgaN9fdmnzERJJwYfKJAp0vOJc0T0bq+lQM19Gk0GYi/fLeZPRV6
 2LDo5zxOujMT5fzLAKsh71dJ2g1LJ4PqdevZcDyfCVJmBt1zWf49VIMzFyxifqrp7LtN
 xMaPW6o98y1Cgk60R3R8MRZhiKgzLKuLWiFnLmkIcZ3ShqOIo3OrwdL+0zag+JNsyByC
 GinA==
X-Gm-Message-State: AOJu0Yya4qpZg3BQH9cJxw5/oIIppN0TyUzsBfEhvyk9grGAy3zmbafq
 d1Np75lWjkq5PPjkHIZLr7+zYTdzqN63c9CqzvinhW52sNd1Lg+Wev8ozOTxZlte0N94aF8As3U
 a
X-Google-Smtp-Source: AGHT+IH5yYE8c9UD7FnNki8S0vbViOdEkDdJ9cttpImwaByzcQTCQ5vv1apWe84YZ8ncq9W2cJZV8g==
X-Received: by 2002:adf:ea90:0:b0:354:faec:c9e4 with SMTP id
 ffacd0b85a97d-3552fdef9c0mr15572717f8f.60.1716997938659; 
 Wed, 29 May 2024 08:52:18 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35c19618fa3sm3502563f8f.52.2024.05.29.08.52.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 May 2024 08:52:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH] target/mips: Remove unused 'hw/misc/mips_itu.h' header
Date: Wed, 29 May 2024 17:52:16 +0200
Message-ID: <20240529155216.5574-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Since commit e1152f8166 ("target/mips: Remove helpers accessing
SAAR registers") this header is not needed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/sysemu/cp0_helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/mips/tcg/sysemu/cp0_helper.c b/target/mips/tcg/sysemu/cp0_helper.c
index ded6c78e9a..79a5c833ce 100644
--- a/target/mips/tcg/sysemu/cp0_helper.c
+++ b/target/mips/tcg/sysemu/cp0_helper.c
@@ -28,7 +28,6 @@
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
-#include "hw/misc/mips_itu.h"
 
 
 /* SMP helpers.  */
-- 
2.41.0


