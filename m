Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15073C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:39:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHE-0002GS-FD; Fri, 26 Jan 2024 09:33:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHC-0002Ej-57
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:50 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHA-0007sS-DP
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:49 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33921b95dddso1153370f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279627; x=1706884427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r1v3SV+PmV/A+0Uc2aWf5zTz7bzHoDfhI5pt+5wcTmM=;
 b=WBsp2ne/XAZmbJe2EkVtcfUmVsj12Y4MIXCxvq4hhGxdIcSGaaWCdRSWQ8rRNHA12h
 GI3HkvNegIqmbCAdmzeEx09y7VUaTwVU0YYC8kenKjWoFLgv0XPMg1j6RwnQhE56cOj1
 uE4VyHBbyqsoJ+KGxZCiE8UzwIBIAqK3u97n3lQupokx4QirXOdQTFEBWDDco7EdeuNZ
 /zwIcoVo0jBnkKTXj8tKP//MwYNwaBM6EMJZZIuOhF9J5BLLk9G30/cPkTpxICFDe5I6
 uxdcyaHM5H5ek0z+AJ0usGwHrB2wOZZ6550hMLbrJcxz3gokXoDfKAscoPByJDLWFZ/0
 cpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279627; x=1706884427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r1v3SV+PmV/A+0Uc2aWf5zTz7bzHoDfhI5pt+5wcTmM=;
 b=tLiAS5etpJhzFMEUgiNqxYHoavrBFTtGD2uNLxCQVyI2dSyPslO2bF3boFYzZv9ogB
 edmcGOUZZpoU12MWwLwa6D8qiql6zEtjFh4S91NgSUN/jZHzoYg65agjlL7FX9poJg4W
 ZUUwQGMCkZY8RuhiQo87+f7GBmIf9rArv+4m2Fty8bOBYrsNnFYr7B5N/nPXxab0wJOq
 Q7PCq8sYpqh6VR9tmYXZwUWqsoJ24gQigsdH/zGgxCmLWcuD2257J6DOobF62xN6Sdya
 Jje/V0MpD1P6EV3tdFNihKXEuu1A+9aV9HIItYxFOkkwGpK2L4kB07cd9+YEhVhxXaK5
 BVtw==
X-Gm-Message-State: AOJu0YwtiehlJVnKPPJvzqzNYCdYhO/RPz+o3EHO07eXcByQFGPG5ep6
 LAZGqhw9B7XzDexK7YzkwHP+Ch3yZLSeUx/cGRWDkl7/WET+yj58abNt3fSWMLKSIgKvhXFUT1Q
 t
X-Google-Smtp-Source: AGHT+IEcVNWisvqiZkQAoOFo2inzXfWoHFnIZMvkcTfVpgDghVxXOdzgJ9TEpTNjrXtPThhclCwvjA==
X-Received: by 2002:a05:600c:510e:b0:40e:8613:84f with SMTP id
 o14-20020a05600c510e00b0040e8613084fmr574058wms.6.1706279626835; 
 Fri, 26 Jan 2024 06:33:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:46 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/36] hw/arm/exynos4210: Include missing 'exec/tswap.h' header
Date: Fri, 26 Jan 2024 14:33:15 +0000
Message-Id: <20240126143341.2101237-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

hw/arm/exynos4210.c calls tswap32() which is declared
in "exec/tswap.h". Include it in order to avoid when
refactoring unrelated headers:

  hw/arm/exynos4210.c:499:22: error: call to undeclared function 'tswap32';
  ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
          smpboot[n] = tswap32(smpboot[n]);
                       ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240118200643.29037-2-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/exynos4210.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index de39fb0ece8..af511a153dd 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -23,6 +23,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "exec/tswap.h"
 #include "cpu.h"
 #include "hw/cpu/a9mpcore.h"
 #include "hw/irq.h"
-- 
2.34.1


