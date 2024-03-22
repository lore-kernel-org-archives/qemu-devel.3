Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA7EC47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 16:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnhhc-0001Wv-Ep; Fri, 22 Mar 2024 12:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnhhb-0001We-Da
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:25:07 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rnhhZ-0002y2-Av
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:25:07 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4146562a839so16151295e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 09:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711124703; x=1711729503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P0be/J1+Pcb62z/yBW5hmBPz9B6hQYE9TN6r4a1eKxM=;
 b=wfEBoTtqojb895U9gCNKToHQ2scz61GiQHNZWlFDL5ykq5VpZFN3XU3NXxgPieqnwr
 FL/yebopAPa6xskfuh7rVktkWSsgrO4TgzqPdFWPIco3YoDNS0S2skPyWHG9sa2ZUtqs
 yyzEXdPqvNA8/puKufYl2r52jHDmh73xSCpb8ysBZhEbowID3EJONTBjt1s0Tsb65nzx
 mYMQP1HMIIfQ/NXnJXQOFMhETm9BaMKFZrMjIVMmirWFik02+ySQcTdtxLRZsRSPljd1
 Y04skbLuoPk1SWawTg8op04+EdNdofsDRcnwJ4vvBvbCtnyERYTQdCsYE931iq1xXnc/
 ZA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711124703; x=1711729503;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P0be/J1+Pcb62z/yBW5hmBPz9B6hQYE9TN6r4a1eKxM=;
 b=hXD4LDoiz8IhHDFMilbklEtOQ6ZtEGV5inlyAMq1i39ZwxrNnJCnsgiJK8hts9I0Kf
 z6jHlw2/pPPPnUhph8uOiNSqGGD5Qlv+O97JoQLzZnK5lmL0ZBAhOfB/NnDEuc/ogQ+b
 1tzBfv7Q5XbGZIUsGibXlywnziuJoIaIvHkKsgVu5Y/QYNam0ITFAJLLQ3thWMWaH4qm
 tLFDQ5JwtK5i60Sk2kvSOzdJLUvCVJauMGXP5g+Mb5/IQgMOkhGKWaF1h8yO2aPS3akG
 2ZV50Fih6SdZ/y2WnLL6EbjMm/UPuMTJPKLJG8LWflN4nfOoXyOMrundYar3oyFpYXbD
 ECnQ==
X-Gm-Message-State: AOJu0Yw69Kl+xUzZ2c9N24Mqh8ETjDlCviHvJAdV/jtx6jyLeJ6fRN6x
 7pq3w38b0WtiQ5/pnlQhLePGPSo9i4D7XWZKKZDgP9oJFWrFMqGr/8caLI+u/Rt0kxCoBxXYV1D
 x
X-Google-Smtp-Source: AGHT+IE1LYCwHCqxGnbNjiVHl47MwRpZZdzE3yrh18yx0pE9TNANVaep+nZiktx2vFtNHxWbmBx8BQ==
X-Received: by 2002:a7b:c853:0:b0:414:63c6:8689 with SMTP id
 c19-20020a7bc853000000b0041463c68689mr1799090wml.20.1711124702903; 
 Fri, 22 Mar 2024 09:25:02 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.178.251])
 by smtp.gmail.com with ESMTPSA id
 z18-20020a5d4d12000000b0033ec8f3ca9bsm2390606wrt.49.2024.03.22.09.25.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 22 Mar 2024 09:25:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] hw/ppc/spapr: Include missing 'sysemu/tcg.h' header
Date: Fri, 22 Mar 2024 17:24:59 +0100
Message-ID: <20240322162459.7173-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

"sysemu/tcg.h" declares tcg_enabled(), and is implicitly included.
Include it explicitly to avoid the following error when refactoring
headers:

  hw/ppc/spapr.c:2612:9: error: call to undeclared function 'tcg_enabled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    if (tcg_enabled()) {
        ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c417f9dd52..e9bc97fee0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -35,6 +35,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/hostmem.h"
 #include "sysemu/numa.h"
+#include "sysemu/tcg.h"
 #include "sysemu/qtest.h"
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
-- 
2.41.0


