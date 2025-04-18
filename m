Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D06C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pWz-0002JC-Kz; Fri, 18 Apr 2025 13:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pWy-0002J2-Rz
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:29:36 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5pWx-0008KM-Ap
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:29:36 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so21459325e9.1
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744997373; x=1745602173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0t/uXKNyhujXRRINXuzOy18EBWQDT1SxjDNFS8yAx2w=;
 b=No4NEv1IYGmCWTDI93Ch9elMXVXT42MVbExqkTbY0FJCcjYkuRjdtb1q1FtyhSWPc6
 YmQpNb1IHzRcf0fmoWwBkroLIMsA8cTjtHu4y9X0vhCiXEpNEaZNAm171TI8TI7fWYLk
 W4wIf50J1XerBAKtpPzBokFPxDtioeRNrBuBmNL2YUWSJtn3eoJR6kocWjy2tC/aA/Dp
 4ip2kf36gd877WwIc94O1NfJv8aZALP3tUzXPCbZzXul/FxOeBckMuSlPiB82Kv3Tq2J
 dbK2QJx8a7V1ge6jUo85A8YJyhB8kPSDrasaAvqt3ETKRRgSWpjHao7Z3mSc3acrc081
 dOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744997373; x=1745602173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0t/uXKNyhujXRRINXuzOy18EBWQDT1SxjDNFS8yAx2w=;
 b=N++5mToVjuuoIdLlBCtXS2NSVwEhYR2XDaQbFjNZlV04ZpwTpc58ArCkwmuQONodyb
 EZI2J24D79Zofi8Uhnde2aapGFDo3/rRz24CEo6ImhnscVO+BBwgZKZLyuLTQA71hYFZ
 LNq34OIRiKV7G+W1y0VxGVg+L60Xt2PHdS49uHQlrgdKo/tA7o2JtL7LXYUXECQ3OUVc
 X7AnPGXtO4iqf+mN1YwX22imFvu6FyuNDaaB0Rro5ggOvKhZPTtRz3XkCJZDBIfxNgSS
 hKB2XoNMb6yr6pQuN1O1MQRxG48Jlltv/YsXlVo2rYWX+H6sFbHC+kOmA3CwHUAGwE/9
 kFKw==
X-Gm-Message-State: AOJu0YyRRNPcAA6zIgaHuGrc9a28a9Sg8etdblwFvjP791+nmuXIBtkV
 UYycCPZyDZHbHuaLWBOhMV6aA4nquuAFumshCSqq/TN57bVyg0U6haqb605asxi0gi94HDqcH2L
 O
X-Gm-Gg: ASbGncuHMe6jpAv/34obhMtGZ7WX2dZOVqslpgQroikJWYpwun2yECGgovlZcMUiIwq
 SVNuQJq1pRwjGOegn3WagpciNYPfY0OYBQWPy6Sqs9wp7OBVKws3wiNrNoUTE6jZq0rEDr+VOlr
 oP8RedleUF1muNzE32QqwZgDMEnR2P0KHkFp/Qq2xG/01qer23Hlw9DVxxW6NhOV7l2eE/PPpoa
 dmIb/MCW8L0RWYtWaQ0T11097+jNsvpFOhQZVnyT+svwBtTcY+B0l13zjjS5VEqKNnfTf3wSRtm
 buysnJ6jOAAjsPxjfHEFtH7EbcNZnEgOfbCT9LeYW0kuAMs9GiYywNw8zSpNUrNe41cfhQFgVMg
 jPlvgyIQSjmR45a63+/ydh+blVQ==
X-Google-Smtp-Source: AGHT+IGl2ZlX5GCsg9EqsY4iweCsxxKoiEdqbC+Uy5E14j1h4szwDYCIUYoDvR8vVHpYVzjUqYcxMg==
X-Received: by 2002:a05:600c:1e0a:b0:43c:eeee:b713 with SMTP id
 5b1f17b1804b1-4406abfba46mr29267525e9.20.1744997373322; 
 Fri, 18 Apr 2025 10:29:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5aced5sm29098395e9.16.2025.04.18.10.29.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 18 Apr 2025 10:29:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH v3 05/14] hw/core: Allow ARM/Aarch64 binaries to use the
 'none' machine
Date: Fri, 18 Apr 2025 19:28:59 +0200
Message-ID: <20250418172908.25147-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250418172908.25147-1-philmd@linaro.org>
References: <20250418172908.25147-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

When we'll start to use target_machine_typename() to filter
machines for the ARM/Aarch64 binaries, the 'none' machine
will be filtered out. Register the proper interfaces to keep
it available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/null-machine.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 1ccaf652eb4..dd56d7cb7e5 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -16,6 +16,7 @@
 #include "hw/boards.h"
 #include "system/address-spaces.h"
 #include "hw/core/cpu.h"
+#include "hw/arm/machines-qom.h"
 
 static void machine_none_init(MachineState *mch)
 {
@@ -62,6 +63,11 @@ static const TypeInfo null_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("none"),
         .parent         = TYPE_MACHINE,
         .class_init     = null_machine_class_init,
+        .interfaces     = (InterfaceInfo[]) {
+            { TYPE_TARGET_ARM_MACHINE },
+            { TYPE_TARGET_AARCH64_MACHINE },
+            { },
+        },
     },
 };
 
-- 
2.47.1


