Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4037C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj0nI-000740-Nt; Mon, 04 Aug 2025 15:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj06Y-0001EU-7D
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:40:17 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj06S-0001BR-SU
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:40:13 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-76bdc73f363so2879178b3a.3
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 11:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754332807; x=1754937607; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tr18OZZ52dyGR1rp5GdhWCgXctWVe7+fEbjUyyRt8KQ=;
 b=biy3ZF4rQ/36P6RS+EAl3H9zyBWfxHyr/GE5VnV3EyHhCEqe8zYDoRwaqQmGgrRlLA
 vkhnZhdx22nDR9uWP0VpaE5J4o8wX7jrH5h39RopweQUud8EDC1ilwHwnLw1Cokjhjjt
 /MPCzoXYMrncnBtPgDAvIqF7hSJTdt6GUCyrOfyz+cceLtNtXadURcsyq3EhDQqlxv33
 qd356ddJR85bAu8BaLqyLF3+kfKo3r6EpMFtYvNuXsO1GDaytJMBQmSL+si6d82mb7fq
 r7oCwIK7gN8l9FDWs6hZ+93dXbF0APQ0XoaremdVk8ASN2t8tdyf4nuIoF8PA+mAn42w
 5ZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754332807; x=1754937607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tr18OZZ52dyGR1rp5GdhWCgXctWVe7+fEbjUyyRt8KQ=;
 b=FGjWEEgxrd2IdaPptNq/sZYDvAn7nzM9ygYGL31YF57fb6gJos7aFPYHvLlOvREKPi
 pVeyD1pLSGAVYY2Ssy9BHaFbjjs3lQUPDiH5cQ7q89Vnca2G48/mq3vJJeD3Z/BVz5nz
 5FlpCQ69fOJfgxlGnIJ67qE3upCr5h0wPPebjTQs1PWGJBOZpoWvgB3u1A0spM/8NOEB
 gth17OrTev8ZXW8pOx+Ibk1otxbmAhwPQ2yzW1BTOqggFh+vECd8zpY+rKT9WpQ3sLBk
 xMa7G06agpCQH1RcdcFWg4atmiPavweGqGn4hjkV5NfSd7hElCB9mUh7WWNtnLAsW9rj
 Qcyw==
X-Gm-Message-State: AOJu0YzdHcrXoyQABfiRbZJi6KP8wVRiWOLO4pV7Xg5qmKy0DMM2+Rxm
 g9WrswN50CbaA657jHYMKGZSofrGzGDRMr+bY7TuRw8D4mV4sRxYvhK3L92S+Us1Ik8QgQE22Ym
 sKkQX
X-Gm-Gg: ASbGncsuCJCKDuUNIhgtfuM3H5SaW6kDldWLMFkIYVc+yd+HuzWjaXDm4vELr/BG++J
 OSq1jrnJ19aE0JgBC+mizhF1d1h7OC0VC/RzMuuz8onS3liiJNwOzP1y/XLcbMLnxLzOvAJHX+p
 LIX55JFkPmdTPz/X98NTip5y8KbQLL4VVbMQjHYG+mZUt14RE4is8JTkuaLPKh+FUZqmzPr2lei
 DAMa1oqLHOHWj8JDDhvO5aqjc6unlgUuECvUhD7oFOH1o1Cd5Q4qzaR1oB8PcaF/DtaCeGzdNLU
 Qu8dly1IdakraYwMVZtioTs0dYW03kSrlzJhLvVuA/QdUJ5kYRpM+Rf11QTpgT2ZGgtLgDDncfe
 05+KdScClIv9Nj03kXWoo1w==
X-Google-Smtp-Source: AGHT+IG+4auJINEWuw5Xp9QJD1n1E3XGcsgPw/I6tC7S02jAt1aOzDdFIEiqKxwRiFNulspvUlxGAQ==
X-Received: by 2002:a05:6a20:9389:b0:240:1a3a:d7ec with SMTP id
 adf61e73a8af0-2401a3ada6emr2876682637.4.1754332807334; 
 Mon, 04 Aug 2025 11:40:07 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bd78875cesm9940171b3a.15.2025.08.04.11.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 11:40:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, Weiwei Li <liwei1518@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-arm@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 11/12] semihosting/arm-compat-semi: remove dependency on
 cpu.h
Date: Mon,  4 Aug 2025 11:39:49 -0700
Message-ID: <20250804183950.3147154-12-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804183950.3147154-1-pierrick.bouvier@linaro.org>
References: <20250804183950.3147154-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 semihosting/arm-compat-semi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 55d7bf29ad6..a14de23d45a 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -34,7 +34,6 @@
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
 #include "exec/gdbstub.h"
-#include "cpu.h"
 #include "gdbstub/syscalls.h"
 #include "semihosting/semihost.h"
 #include "semihosting/console.h"
-- 
2.47.2


