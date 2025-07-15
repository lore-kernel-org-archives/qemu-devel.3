Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD85C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZ1R-0002f0-Dd; Tue, 15 Jul 2025 02:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ1N-0002Zx-Vm
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:20:10 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ1M-0007Kr-2F
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:20:09 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a54700a46eso3071580f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752560406; x=1753165206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nMsTV3CpO+fi1160dcF9jxvz0Q+D8HZl/5sRp3WflII=;
 b=zFgbZe0LPj7JWn70J7B/CUo1QT3M9nViTM37KTskuRkwBY0WPVG+AUASSeCgn7IdKk
 Zy5I7J1T24MEHcdgPZ6odxVAqGjtWF3HWiP4fe1E4dcghmI4UF9TQchBb5mEehZG145P
 9x8x4ySIYF1B79/B5mgakwjXO5gfrFj13qp5BlEWhdGGBY9mYMm9D/RPCY6Iev3GvcPQ
 U08ckCnm6PAJ+20aZwi+B9eX5+3U2y6oeJKQmXY1LpdvA4u5/oK9AvV0b0b1Etc81y2q
 jQ2hJtnxjLcQ/oQKuOnpypVQ52DJbdbPWr6cHy5daP/4XEJ01/X4agVBAUmGrPq5W7rR
 KePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752560406; x=1753165206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nMsTV3CpO+fi1160dcF9jxvz0Q+D8HZl/5sRp3WflII=;
 b=C1CaRIgAAgbyStfXULGc9GI385wd55b7eXhpwiHZ7PgUdhEWZFUtN0FzQNCYgawc1r
 OcCHneTJDNW/Mu1mjG1qULDtpmdtjcdkd+XXR1bkDp48Ezhb9/0ruCiz+VpImVtAmTuL
 N+VKMxMxMyfkB/NLq/12l2PwdJRj/BiXpm42ANTov5B6A2Ze5xvC8K6sw9AKAvGAw2gk
 e4hl/ODkNgJ2G/J3a6TaU1bQKgWDOnoJPFHgL5t1k43gLTMK/tXsIMHwkHnWWkWsWtkg
 Ci8VBr9MJvVMKqIf7KV9nDc0pJf6mFtsDnEBuUb0xohubeuySV763GKcNGHKD3t2+LRl
 ZU3Q==
X-Gm-Message-State: AOJu0YySTOK7y5CWzhM1Od2GOE/7SFAVWuQeotf7SyfbjfskrdZUIcWX
 r+JRovr4pbcCHST5RuYy+BPB9/dj3Ii08eWrx6BeeUDLP0ZBqpS9Jy8aPm2bbN5xmYBL/be+7NW
 5Tnku
X-Gm-Gg: ASbGncvSVK4QA+0TCmNA6Ll9q3oCF0pSErcWWn/tpuBYgMjgRDPNtRhMSwq6aTsUR/T
 zyMtQ/eaSIekMRMcSuyWlMPSkzddd8VGMfV9kyreTx/ciCdjPBoRgpJLmUsW+1d+9IOY6jxWpnV
 4lfE2UwqHKTXm1+i89oLNR8h8LrjYOQaixLrHa2O2YSGhyw1NdKc1eQXCL+6ZBsfZx2tUCzMewP
 C6sKflqfARckQcMhGiIcl6Q5OihICgrPw0CzJUwEO/qY/ZEgP8ZFo5YLakc3rGwZgCkNODki0S4
 s32a8d3m0bd9xDzNawtKFu8rb2Nc2YUWi/7tq8yNSP90WpIJFI3/hQ+KgUcb1zk9y0D5DpIeTYg
 j1ZRhTB9vL7gwdVXF9lyJgmKZh7WCcBHUgDLjrq5IzVdXLsNcHvSGR7pqG/vaexxs7wDyhikh2S
 eyz8Xwtpg=
X-Google-Smtp-Source: AGHT+IEguj2xPfqEKx3JR5NbuYC+YI92PCY2IOP9ra+fAo/0YTvwIF9cBdydRQzIeJI4nrzZ+0X3bg==
X-Received: by 2002:a5d:4083:0:b0:3a5:3b14:1ba3 with SMTP id
 ffacd0b85a97d-3b5f18d3732mr10268108f8f.49.1752560405873; 
 Mon, 14 Jul 2025 23:20:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d76fsm14539964f8f.64.2025.07.14.23.20.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 14 Jul 2025 23:20:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 09/17] hw/intc/loongarch_extioi: Remove unnecessary
 'qemu/typedefs.h' include
Date: Tue, 15 Jul 2025 08:19:09 +0200
Message-ID: <20250715061918.44971-10-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250715061918.44971-1-philmd@linaro.org>
References: <20250715061918.44971-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

"qemu/typedefs.h" is already included by "qemu/osdep.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20250708085859.7885-2-philmd@linaro.org>
---
 hw/intc/loongarch_extioi_kvm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/intc/loongarch_extioi_kvm.c b/hw/intc/loongarch_extioi_kvm.c
index 0133540c45d..aa2e8c753fb 100644
--- a/hw/intc/loongarch_extioi_kvm.c
+++ b/hw/intc/loongarch_extioi_kvm.c
@@ -6,7 +6,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/typedefs.h"
 #include "hw/intc/loongarch_extioi.h"
 #include "linux/kvm.h"
 #include "qapi/error.h"
-- 
2.49.0


