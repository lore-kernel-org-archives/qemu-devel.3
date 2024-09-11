Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD223EE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMFU-0005ov-PU; Wed, 11 Sep 2024 08:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMFG-0005CU-So
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:14:52 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMFF-0007AM-5q
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:14:50 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5becfd14353so6343189a12.1
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726056887; x=1726661687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sfG7K0vO2YZb8Mr7z2795N5nQIZIeeUZz/GR/ld9L/o=;
 b=jfDm5mAehtR1oov6/mLcYqYR26lusEgkVb8AVSf0KQjUFOK6UWxbXQkOJswltKIHr7
 zuBVI1Egak3QQjU8KM5KqGGs6VgNmHmUdZv8TKJ/PhJ06DzN+V/hVyTYUgLxvaWVX1RU
 B4KJXhiHMBFj85vRYal3wpcA85v3HtrhRShn5bL0N92d2DofVUrG2I24Gk5mFaaZ4TDU
 N2hHF9ZP17nzhoil/l++IW+sMDWgFZRz/l/ws+PNJUY94XTTUk0Q8WQL9L98X42MZoqr
 DOPDkOLgU+bl9ughjVTDcqCil1gCmXtjDyuzAw2OM3ge0YdO3yM/g6tuSHp3mMr/jshQ
 OvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726056887; x=1726661687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sfG7K0vO2YZb8Mr7z2795N5nQIZIeeUZz/GR/ld9L/o=;
 b=g7+U+4laLcB+IHl7RT/2ShTue+Xqn1aEUgyxXwdguwgqn6ijy8CbeI9UsYao/BrShF
 ItTTQyhHhSSNZLVZ5Pp81uHKy93pCn0foifT2G9IFV8EiQJIsUi5vliF+K+2luiQsQz9
 HddTOD33oUNhJo+Zt2bdAm+9xPqKGf/yI7dQzAMBN7uAmpOj0bCZXqUb7xjCsYavLZbQ
 0yrpADBKmD/qn8MfcEI6Ha+YaSfXv6ljZjZqm0ItN9zI4YNa2q1kZh4kSOd7e5mlHIum
 jA/RyM7m4GgaORN462EVBt8FIeSKM84SDFVR6OLb4VS1IROk7pqz36ewAmSmSs+T5e1y
 XLuA==
X-Gm-Message-State: AOJu0YyMItCJsyLsiAKGTl0wx+c9Q+FbO5b/sSBURD8ao7HI9GUAb1C/
 haGR7RJA4SD95ABGG+7Vdt7K08+B1T4E1KUuZvgRJFvI5mjaWPfwBLwhTBE9ayrBoeVAAb62Bm/
 H
X-Google-Smtp-Source: AGHT+IHGD1BLCMEbBloXJ3Kjn3crL68G6p+sNiwNqCmBmvm8rMrnYgBYQUKXb1Nmfc1LKQrZCuY9+Q==
X-Received: by 2002:a05:6402:3594:b0:5c3:ca32:9508 with SMTP id
 4fb4d7f45d1cf-5c3eac276bfmr9584261a12.31.1726056887028; 
 Wed, 11 Sep 2024 05:14:47 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd424e5sm5254849a12.10.2024.09.11.05.14.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:14:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 03/56] hw/intc/loongson_ipi: Remove unused headers
Date: Wed, 11 Sep 2024 14:13:28 +0200
Message-ID: <20240911121422.52585-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20240718133312.10324-19-philmd@linaro.org>
---
 hw/intc/loongson_ipi.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 8382ceca67..4e08f03510 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -6,18 +6,9 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/boards.h"
-#include "hw/sysbus.h"
 #include "hw/intc/loongson_ipi.h"
-#include "hw/irq.h"
-#include "hw/qdev-properties.h"
 #include "qapi/error.h"
-#include "qemu/log.h"
-#include "exec/address-spaces.h"
-#include "exec/memory.h"
-#include "migration/vmstate.h"
 #include "target/mips/cpu.h"
-#include "trace.h"
 
 static AddressSpace *get_iocsr_as(CPUState *cpu)
 {
-- 
2.45.2


