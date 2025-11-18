Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C52CEE34C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 19:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQy6-00016m-UJ; Tue, 18 Nov 2025 14:02:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQy3-0000zR-8H
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:02:19 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQxz-00064d-W9
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:02:18 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so64141095e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 11:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763492532; x=1764097332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=52zBhewqcn4T3m8Xjjm8OprozUFhcDO1Jmsc89Lvm6Y=;
 b=PPvK335PKMTbuBRmjFfWwxTWoK3lhwrHYr8p2t0K4dNBFHqLLBoCbMzy+uSl841EqS
 sOfK4viBWelw4LzxEAiH5dQtzaJxGHlEuh4CKC8J8WuUgLkp/wipNolhGXHUglNaQAKc
 FXeOCNL5W/dMRiabwgo6K2Ke4yL/tqCIa5DI0ML7zaUhwppF7W5pSNkJsicj6Jot/PzH
 i6CKCONnnCPl0YDCORypIN4l/P6LwTVTegYeQygGnoz0sJXSkZnBglwz0//jvQGSAbGh
 K4j/VGGXllLmimnNMAAlELf1ODMm2+f0TqQWd0bGMD6NnjXpGLP9rF/NEAA7TtfK0al7
 nMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763492532; x=1764097332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=52zBhewqcn4T3m8Xjjm8OprozUFhcDO1Jmsc89Lvm6Y=;
 b=ai8OJwLINUPHlF8x/8H2H8zZ0ao/gnr7+XhDm5a32JiqLTg/Xs3kBcyKxyX72AOdli
 bP3vyCj7AKuUm00GgF3M8f52zaszlbzUSI/CFebiFZB//W++bkjJbKm/lAaKlUNPw0JS
 9URccOCwHRDT0kqci8/1nx0k6+3bYWjy+QIEQjKZ602ZRLwk7bKSfkQfc9KWj5Mbz8Vb
 VQvLETYst0rsC7IryYm9lTdjy4bBnUa4ywjfgdnb+qKj3DxYHaKrsyKafc/djFB3l5Hd
 MAyoOqke2mPW+LkmVHCw/XA7gB8ahJ3hOSCoKPCFtqESdIhxrD9nAZcODzedOW3vD/kL
 p0bw==
X-Gm-Message-State: AOJu0YzQeLHLN6ETA3kbE1rLak9PHr8ymx3U5f+9S4V9pLUEer0t0TGK
 w1nmFs7YwV6lpnsCrIll7wq45KIgG/7RnodhBsiXq+nXxowlAal4mBi4sHc+DZx4iZ/1pom3PrO
 f3IcHR4/XSQ==
X-Gm-Gg: ASbGncvMnZTrfPG8pCr8ZhP0AZmLk80vBWHwLNeq7kkwXQMQ69P+TxnzVK8LcyDPvgN
 VbXTOyayq5pVlm+fuKAeO+7TVHUd/O+7/3NdLz1s+yxgqvH6o+4uiLcxBwR2rCaw0g7CTY/0F25
 tPjcqGtTqahlHVNFTvxkmdI13hcSM6j2Q+qeQYqXf5cycI6y7iTNDh6/8a+pkH16YGTrUxRWTxd
 snElASvHB7miEjEib7CBYOQsXAx4rKEIdFrsQSrDxWWrJqDuU9AwyEJyMKRsxETGYlzBlkimgFW
 TMsl2FILtaoMWQZv0A4qqIqHegGmKFIduhkuQuPCWyaJSLtdA+zYxKmQj1PTz7SZ5eTxXTAdiSi
 EUUw+Mz9oYW0f2+ZQm0SRSUhqLf/J5HIa1Knizb2mHcX3bGoKTrk8lT85nQfT0vKL+dbxjQvE+9
 eau+MD/S8TF2usXorFtlkzuu4lp1bdC1rOa5U7x8eMCKbdzA2xDSZlgA1u2dD2
X-Google-Smtp-Source: AGHT+IF+Ak4ucZXHxVvcZEbcdLb1WpTyub83hwVD/+i3PwI2AZb9aRcTDtVhHYhbDgBu160Z6nACxQ==
X-Received: by 2002:a05:600c:a05:b0:475:dc5c:3a89 with SMTP id
 5b1f17b1804b1-4778fea881fmr169331455e9.34.1763492532588; 
 Tue, 18 Nov 2025 11:02:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9e19875sm22161035e9.16.2025.11.18.11.02.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Nov 2025 11:02:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/18] hw/southbridge/lasi: Correct LasiState parent
Date: Tue, 18 Nov 2025 20:00:45 +0100
Message-ID: <20251118190053.39015-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118190053.39015-1-philmd@linaro.org>
References: <20251118190053.39015-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

TYPE_LASI_CHIP inherits from TYPE_SYS_BUS_DEVICE, not
TYPE_PCI_HOST_BRIDGE, so its parent structure is of
SysBusDevice type.

Cc: qemu-stable@nongnu.org
Fixes: 376b851909d ("hppa: Add support for LASI chip with i82596 NIC")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20251117091804.56529-1-philmd@linaro.org>
---
 include/hw/misc/lasi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/hw/misc/lasi.h b/include/hw/misc/lasi.h
index 04312d0b589..0e95be1c32a 100644
--- a/include/hw/misc/lasi.h
+++ b/include/hw/misc/lasi.h
@@ -13,8 +13,8 @@
 #define LASI_H
 
 #include "system/address-spaces.h"
-#include "hw/pci/pci_host.h"
 #include "hw/boards.h"
+#include "hw/sysbus.h"
 
 #define TYPE_LASI_CHIP "lasi-chip"
 OBJECT_DECLARE_SIMPLE_TYPE(LasiState, LASI_CHIP)
@@ -63,7 +63,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(LasiState, LASI_CHIP)
 #define LASI_IRQ_PS2MOU_HPA 26
 
 struct LasiState {
-    PCIHostState parent_obj;
+    SysBusDevice parent_obj;
 
     uint32_t irr;
     uint32_t imr;
-- 
2.51.0


