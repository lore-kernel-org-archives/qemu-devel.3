Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20978CD6E50
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 14:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSyKK-0006Nl-If; Fri, 29 May 2026 10:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSyK9-0006Hp-Se
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:36:35 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSyK8-0007T3-88
 for qemu-devel@nongnu.org; Fri, 29 May 2026 10:36:33 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45ee5cdbd28so1210338f8f.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 07:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780065391; x=1780670191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=v8hnt8QTR0m3dsrSXtppaehwSCPzuZgau1gE20XoQoc=;
 b=cdMcGbEpkeRoZEx+3Vb+1T5vVs4at9j88fabbENveiakmSiJxioqpK7QxAjCmrSbHU
 USn94MjZVbvKhKGiSHS8eoXluwnJixTVfRfYH46yGibasaVmjyPhdAbIm596VjKec28z
 uvLx7++CgpM8PlIFdyze79oEZ1Opz9Q9jvisrioCXgeueMegkdjWMzL7s45MZx7d7Muj
 h4TyiCIAOJ+hu8jg1d+P5Bn32z1Jh5WZJTmsauAZxYXjOwCFt1ZPE0QV5gDTw7KIR900
 6TPbWeaksWw1XCynlBVJ0VgPOJfxTsj3osPqp/6oa+DOZ3mwg65yU+4nkbpi5zDfZqht
 ZpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780065391; x=1780670191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=v8hnt8QTR0m3dsrSXtppaehwSCPzuZgau1gE20XoQoc=;
 b=oTOTY3UuV5qIPWUGD5q3hKgCFrRokDpL/OMurvP7xYdFxrkE+cakXWDHzcwiNcPB1o
 YPgSd/gJmR+0hSdjSKBmq+cAv1SAwa65dj5weGE1s2HSs090Mi+o/pLHOEfXLLOGvAqI
 9ZoeXkFqQKHdD1V7trOGZ2b9TYs/ZyX/B9WB9JUmBYcbDRy+2wgrKkNwr0I69IoXCyXz
 18L9KiHUIWw9vM1f/v1rJZsNoWwO0Xchwfm2aqnh3D5nQj4blMlE6mmHcmm5s1rYi5yF
 0wY4fhGGUoeOtWCryJBCVstpjKQhgdDbzJwEmNUmmgm3lmQ0ygux3dUzP8xkI3dApWko
 MKdA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8EeEvI9JM9Mx8kPktfAGQAc42XCuVFfxewM81Pc/pgZIzKc/lZmDBrJZdsXl7G95pkXEk0AqGLrIR0@nongnu.org
X-Gm-Message-State: AOJu0YysF5uX/pjwMeaW5OIvJTGfMW/CffpS55dmmE7OpEodVpC4WYJS
 zTRuGay/f3BUy6OnXEuLfgK/lOkCnnViSxXRdYmMELwuCJA21xnJOz5I9lGX171esNg=
X-Gm-Gg: Acq92OE8tpPVggIcRvWx8c+2wpTmHUDWWHgff8jjc0Yqvwn9nY7zo5u0Cxljwrd1Far
 3ShtsEXvTtcSh+KYkJ8YzD4S7ZgjcAEwsoMRZlbdTx55d8tQ6rjsFU/+HPTIn/tqyKni4gUobv/
 RV2micmqyKQBcGkFYYQoUBRpPfG9O/epzez8okGp5pY7Xp8NFs/9fmlRy8QRnt2ThFZbMtSu83m
 AdMWJ1FLzdTlqoXMh17gEuG49DS0vu4uJqUXadGm9PpjsUiwjLHQvxCW5YVcI7VeQHy1XxnBGrm
 7pEuE/sArBd5nYotWqVlgikaOAsO+Xk21i68wmRHr28Wa86PXSER9BY4jjdKdJC9mM8lAMlOcl2
 oC7LrCvoX4FrMIehO3Zven8vwscAvya43EP85L++awVpzGcztCYgNXzyi/9JlBg0FKEYe/q8ZPL
 U/KQ75yiytSN1m0pjR4h/RxMKkOVJx2W6o/D/aGxsmA517tCxl3hrBmhtfpYN5L5koK3+Olrnrw
 pCTJItGZxJkGcE//bezOPZblRvM5CUygqEQHOZM39Y=
X-Received: by 2002:a5d:6684:0:b0:45e:739b:2750 with SMTP id
 ffacd0b85a97d-45ef1447483mr3640431f8f.9.1780065390603; 
 Fri, 29 May 2026 07:36:30 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef356a4c4sm4180675f8f.31.2026.05.29.07.36.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 07:36:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/dma/pl080: Don't use hw_error() for unimplemented
 features
Date: Fri, 29 May 2026 15:36:24 +0100
Message-ID: <20260529143624.158935-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529143624.158935-1-peter.maydell@linaro.org>
References: <20260529143624.158935-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

In the pl080 device, we don't implement "peripheral flow control",
which is where the DMA engine can be programmed to transfer data
until a source or destination peripheral tells it to stop.  We
currently call hw_error() if the guest tries to use this missing
feature, which prints a register dump and aborts QEMU.

Change the hw_error() call to the LOG_UNIMP log-and-continue,
which is how we prefer to report guest attempts to use
unimplemented features these days.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3409
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/pl080.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 4a90c7bb27..f9f1e3e931 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -13,7 +13,6 @@
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/dma/pl080.h"
-#include "hw/core/hw-error.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "qapi/error.h"
@@ -132,8 +131,9 @@ again:
                 continue;
             flow = (ch->conf >> 11) & 7;
             if (flow >= 4) {
-                hw_error(
-                    "pl080_run: Peripheral flow control not implemented\n");
+                qemu_log_mask(LOG_UNIMP,
+                              "pl080_run: Peripheral flow control not implemented\n");
+                continue;
             }
             src_id = (ch->conf >> 1) & 0x1f;
             dest_id = (ch->conf >> 6) & 0x1f;
-- 
2.43.0


