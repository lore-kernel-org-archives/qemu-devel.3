Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879B6E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 23:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMF9g-0005yy-It; Fri, 13 Dec 2024 18:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF9D-00043m-LA
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:32:40 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF9B-000394-1O
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:32:39 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-434e3953b65so16061545e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 15:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734132755; x=1734737555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CV9+f4SVBhtl9L6i7qT0yd0Q3TADzotsfEUks6qSmCU=;
 b=wK3DvIh7YjKOXqQ40AHmVpuGiNO7yf3RKyJbfRopeW/PwMnjx9T7D1u3aJM/MDDxp8
 hV9SU7KW+DWbCRwkLsU2KdflK0OAoXs2xi4nXrzoPuJW42AVIUivjiBdgSnAET5yv0l0
 wGXSL294rWRg0/CZhGmVa+HzTAzNCLzmMZBwUnwCTmvIyOTw+iC6NdSyF01QDRur92Ga
 Zpk+7EzpTGm7KfQkJklu/mHBz0JfQi01IsI3D1176zzYRjtNiAGd+R1YycyFmXY+YVw9
 xdvZgCFXAYth6n+abKDghAHSAlEtuPHWbTB4sCEsci3PX7Eg3ShnO8ZwticQVfF5OEAu
 qIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734132755; x=1734737555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CV9+f4SVBhtl9L6i7qT0yd0Q3TADzotsfEUks6qSmCU=;
 b=PEyqIiJdImO48ig1p+3lnB9jDNzQ9NSKg2FLpDp+vHdG6ZteVXPwX8emmLAzuncxuN
 YS/lpQQ0KI7gwcGUCJIvuLvi5DDXpBOSNoAed28Zj1THCCjGbJYXbwQf5DPKUlRR8xzS
 2JAAesRU8NvuElg4jsO8EtnLoX8k5VLgF6RqxYscgN6I8d11QRuwLINXeObiqrjNkeiG
 x+0AM5mrJxMNrRBoWH85G6QY842SGvNATAX3xO7yMt69qVoOFAdvPqu56iBuIA6BN8uo
 U3R2v1LmFz/JU7UG4VvhRl9aWB9IHy33/tdsueNjFgOU3bDpjdrMB180mRXtxJG6TsXb
 xNSg==
X-Gm-Message-State: AOJu0YwfhehaB2d+HXuNeCmWh0E7umdiMl11wbpRTSHNQXKYrulgy95l
 TqJx03Oo0KVD9OKTT3ONDrWl3zGB1+Fjy7w4RrZmr8bcQkjKg3M4JtFYRADiuth6xHqD8FvUYVR
 Nj0k=
X-Gm-Gg: ASbGncuRNjXOX2qXr31pUOdAHCaziobCN3wliC6eeSVykPaQuy4+J4WAZyUn7Lv7C28
 1F9CKda226sgxiMTrNaK1GZsxCPhryr0N+7OKxPjYBWVXGpzePrfha9zDgCpkIsMGrLHBBUbcWM
 7kx4pjfjX9EFi1vTStOPAqSzNdASB5Sz36QocMSMJsKtfhEg22UYTiPe7hLYD1nPPueL1NiN0mF
 3/iKg5gve1GFZATkfjz5mFsb/iWg8lx5B3nCAlEOct60gcdFIZXqmStog5Y9Ayt5ozkZJxXEYNv
 0NzNkQ==
X-Google-Smtp-Source: AGHT+IHcFpmrkGUsvL3jUwj3xLyYxHDCtFxKIpOXF5zJFPYdgXUFm+/jUSL/vovNuOu1loW3KAZXYg==
X-Received: by 2002:a05:600c:214a:b0:434:f7e3:bfbd with SMTP id
 5b1f17b1804b1-4362aa947admr38604895e9.23.1734132755094; 
 Fri, 13 Dec 2024 15:32:35 -0800 (PST)
Received: from localhost.localdomain ([45.93.146.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362557c502sm63157165e9.11.2024.12.13.15.32.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 15:32:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 19/20] hw/sh4/r2d: Include missing 'exec/tswap.h' header
Date: Sat, 14 Dec 2024 00:30:54 +0100
Message-ID: <20241213233055.39574-20-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213233055.39574-1-philmd@linaro.org>
References: <20241213233055.39574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

r2d.c indirectly get "exec/tswap.h" declarations via
"exec/cpu-all.h". Include it directly to be able to
remove the former from the latter, otherwise we get:

  hw/sh4/r2d.c:357:35: error: call to undeclared function 'tswap32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    357 |         boot_params.loader_type = tswap32(1);
        |                                   ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241211230357.97036-8-philmd@linaro.org>
---
 hw/sh4/r2d.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index 7eecd79fcc1..e6cc156c238 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -43,6 +43,7 @@
 #include "hw/loader.h"
 #include "hw/usb.h"
 #include "hw/block/flash.h"
+#include "exec/tswap.h"
 
 #define FLASH_BASE 0x00000000
 #define FLASH_SIZE (16 * MiB)
-- 
2.45.2


