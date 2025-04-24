Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6FFC369D8
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kwU-00043U-N3; Wed, 23 Apr 2025 20:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktf-0005zR-LW
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:57:01 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktb-00058O-T3
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:58 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2260c91576aso3451395ad.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456214; x=1746061014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kHsAIp23EWRdufSrcLbCASuKqIf9fO9vwVBtAt7EmVA=;
 b=vXYeDg3+Pmwh9oRfxkP8RD7Cq4POHW5EIDpLgCHqYBPxqtY52LhvzXYFDqn68mPf2H
 8dVPRkVv09feYng4XmnK2RxwSpWAxutJD3hIASsodE7tu3g042uR9CCDZlCRpdQ8nKBb
 ZA718zNBgNtfIXMGZow+KujRpPbjjizjmge3HMa6aFdE/f43UJ3eaDKBaYAyez26N7aT
 NUs1GkkWvV3zgssQdyqHBxZqInpmzG43NA3sGuBuL9mxg/9gAzZnK+DSNDzsHg2J5ExW
 lxRHqVUuNKlNk3QxkAgrRflR67PQAIEmq+LxDGQWRN0gXGYTHDVTQ2SH6J2aSkLvXsfb
 I2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456214; x=1746061014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kHsAIp23EWRdufSrcLbCASuKqIf9fO9vwVBtAt7EmVA=;
 b=oGCPk0+K+v/BofOQ6ItTi6anObsfV4VJI3TsIovlPoK/gM/yJqZ79chbwpr0W8gfRQ
 ZTgqdHWI8I2AMjMCgxyHBAX2euMjIwA6bHz78gK9MwkqFNOYj+wLyWX0DZnK1V72ddov
 HZgL9stZ6rD0/qZSZFO+0t5IRqS92YkRrsW+VftHIhiDb7JqezSFBGX6Bh0IrIodugrK
 GD06dD2pPi07KoQxZ9d4st/73BJzgqpwlzaBFmWQGSogZn6Ec+EmK98kn9chL6/Xvi2G
 SmetTt/d0IzOIP/vI0yoZnFXrm96mj9er66oQkgMvj0yxlMbvthMurw4+8qnne6NvHbb
 5tiA==
X-Gm-Message-State: AOJu0YzJqaI3nB8KpvMhmmK3dKY7IfdRqiAcXlk0zBKSugyvJ9tTOp/j
 LjQAQ2mHyXgr+5zHcW3Wab6YVt82IY+rx8NX/6yTD8QSdUvAK73nmHZ2F9X0vfqCldJHlqaVxPm
 A
X-Gm-Gg: ASbGncuYm+pfaT/71Dii//OZNCjjV3/1sXGV2XRX7Qb6D5+i/6EeCrWDWwB3KyGzhv2
 4ZMWxVMJsP7KIvuEgjwyQt33vpZayfLcWrmclt5rZ524vlHHSmqGITwgk8Cev/Jc7rIjd+8rZlz
 +OoEWt65o4W/YMuzS6GHzep7EiohPeBC49NvGhEdsXeNKMYrWOHvVb/aFkbEJ+pa9DGxS9Hs9js
 Bp8lGnWuk9VgjR16Lm8sqVwX95U2gq9Hi9tCLEZ21swg5lP+mduIV7lXpctG7ZyVLCytT8Vzz0S
 X3jU/HlfnxVyhlzIJFRWLkCM7GKRJUIxKjXTG+IiuPrrcHLiANL3AdRRNd+K5cOC2dx8w5fQ8FY
 =
X-Google-Smtp-Source: AGHT+IE7Xbm+BY5tL4oOTUn/aUtqoganbbL5THMYnNjGlV3xEVFDGtKeafH+xsk4pV6REin46LUu6Q==
X-Received: by 2002:a17:903:8c6:b0:223:619e:71e9 with SMTP id
 d9443c01a7336-22db3bb6f8cmr8148005ad.11.1745456214172; 
 Wed, 23 Apr 2025 17:56:54 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 109/148] exec/cpu-all: remove cpu include
Date: Wed, 23 Apr 2025 17:48:54 -0700
Message-ID: <20250424004934.598783-110-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Now we made sure important defines are included using their direct
path, we can remove cpu.h from cpu-all.h.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-14-pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h | 1 -
 accel/tcg/cpu-exec.c   | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 7b712b2556..dae4fbcea8 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -23,6 +23,5 @@
 #include "hw/core/cpu.h"
 #include "exec/cpu-defs.h"
 #include "exec/target_page.h"
-#include "cpu.h"
 
 #endif /* CPU_ALL_H */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index d388be83d0..8d2b957a3b 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -36,6 +36,7 @@
 #include "exec/log.h"
 #include "qemu/main-loop.h"
 #include "exec/cpu-all.h"
+#include "cpu.h"
 #include "exec/icount.h"
 #include "exec/replay-core.h"
 #include "system/tcg.h"
-- 
2.43.0


