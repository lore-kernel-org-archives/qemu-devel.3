Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11EB106FD87
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 06:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0vuj-0003SL-TG; Fri, 13 Mar 2026 02:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vuh-0003G2-GF
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:22:23 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0vuf-00071F-V1
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 02:22:23 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-439b8a3f2bcso1345162f8f.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 23:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773382939; x=1773987739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cq5cTPfeh3Pg0d95v0IReDt8464LYRGbtL2o+1/LtEI=;
 b=gpNRWEjvVte8cuEpcZqV9KB1JgknxCl0r1fcCNdOyR8ptXm67FQYUcezyTywMQmmP1
 0JJybUNe2Wx5b1cvnEtNgdZVBNhgHTF7Q4g1tuNvNEqVxapbD9tf8J6RUhoKaI/CBgkU
 vQnReBokcGiyNrn2xpH40i9+lQHUFVS5S1jrRnM3akoxderSCn2dkCKQlmltSzmQVJ0N
 3rLP2LgO7sDROFT30Ldes2klWYWkDA/peweRwemCtSv8gzeUkRm1lhGZFLKV7Yp79wMV
 X2RzRQkPU08EMBq1XVStHHJRs1XWUo6BLabZkE5TU9o/jTyDDjU7QHelwBkoFNiMJw8x
 7djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773382939; x=1773987739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cq5cTPfeh3Pg0d95v0IReDt8464LYRGbtL2o+1/LtEI=;
 b=gUscVFNWYiuAqi44cHg6UYSlzxW0ynOShld3DBGRk3o8xElhdu4gQdPNZ3M4ZMsiUt
 Wvm2eQ0wwB6J/Jg9WUAgutlz6gp99nzanM2cw6uJg/KuxSL2b7iRneTur90L27uRd8j2
 6ZpvJ7CHE0V3wIlxHjrh8TL/CxnYvK68dW0esJ4ThJk/QeElfewE9tWk90n48xOVUeuI
 bzolin6tnliZ88K8syDJIMbZZLpLsMCX83wRz1JXmGZU+zXV0GJWxUbu4d64aNMuR+Pi
 fqjvV6Cb7GTcNfFFqf5ZRb/fpp2yFdrfqowMeMpjQLL3+bZfmWio3W4czYJf+5T3zJXQ
 N5/A==
X-Gm-Message-State: AOJu0Yyli4DwFq+C3Bu7F5gYQk0aV1+PbKxdPJeUSoMfmvGm0zMYGcTY
 LR70iy1RkMLncwOldTihOmRcUsietGNSwW8ummh7lGBs4LdoQ/YKmP/Ggr7DiS7CM7uZIaHoVss
 DEj1rHik=
X-Gm-Gg: ATEYQzyaNozBf8hJ/BkFGe4lehkjdCu/o6z8oNPtWC98OaMYTWzNg0fOHqgvOSfTrlN
 aj27HLZr2GHYvmnWN5HHYGilJpBYC5jq8bnrE+oCvzdEXDk18+7+MOvglMR2sxWg+0k3m8vQB8H
 gVtrjuk6BQxpRCQxzhs2Zf9rO0ueXbGU8r2+7ptWry84UHqN4ngZAAyBx7tH+xnyyuwvgdtvf60
 3m9iun15qnx/Zk++K6QjTAJLOmPPUseFmbnxqbEF3ayY4UU2My3bi8375oeW/q3TUbxshQQAmUL
 Apyr/TkNMejylHHRsjEm2Fa7gl1p+SDjBVEwZw3FZ+DkB2zLcbflciVkOnN4dlMoEinVaBuvqGr
 u/XI8nqFy4AEs3ye6QZJKrZDBiaceqapP47vCzlG8hVqo7zbILQeEgAe23Y7IPmczUEhPlVioCc
 9c7JE5dYywKld2TxI4Au5Z8hrPLN6esEYJknwNhxRxsDzMMIguGpr5Tx3yaRY1rGashiyVYsh55
 puStg==
X-Received: by 2002:a05:6000:1866:b0:439:fcd5:c9be with SMTP id
 ffacd0b85a97d-43a04db127bmr3882898f8f.33.1773382939560; 
 Thu, 12 Mar 2026 23:22:19 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe21b631sm17153314f8f.27.2026.03.12.23.22.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 12 Mar 2026 23:22:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 12/38] target/ppc: Include missing 'exec/target_long.h'
 header
Date: Fri, 13 Mar 2026 07:20:28 +0100
Message-ID: <20260313062055.2188-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313062055.2188-1-philmd@linaro.org>
References: <20260313062055.2188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

The "exec/target_long.h" header is indirectly included, pulled
via "exec/cpu-defs.h". Include it explicitly otherwise we'd get
when removing the latter:

  target/ppc/cpu.h:1281:5: error: unknown type name 'target_ulong'
   1281 |     target_ulong gpr[32];  /* general purpose registers */
        |     ^
  hw/ppc/spapr_ovec.h:76:44: error: unknown type name 'target_ulong'
         76 | SpaprOptionVector *spapr_ovec_parse_vector(target_ulong table_addr, int vector);
            |                                            ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/spapr_ovec.h | 2 +-
 target/ppc/cpu.h            | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr_ovec.h b/include/hw/ppc/spapr_ovec.h
index c3e8b98e7e2..8d67f492d02 100644
--- a/include/hw/ppc/spapr_ovec.h
+++ b/include/hw/ppc/spapr_ovec.h
@@ -37,7 +37,7 @@
 #ifndef SPAPR_OVEC_H
 #define SPAPR_OVEC_H
 
-#include "cpu.h"
+#include "exec/target_long.h"
 
 typedef struct SpaprOptionVector SpaprOptionVector;
 
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index d637a50798f..a0df7a467ed 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -25,6 +25,7 @@
 #include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
+#include "exec/target_long.h"
 #include "cpu-qom.h"
 #include "qom/object.h"
 #include "hw/core/registerfields.h"
-- 
2.53.0


