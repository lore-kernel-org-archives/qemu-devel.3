Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B74CCD1BF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 19:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCNXr-00029e-1M; Fri, 24 Oct 2025 15:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNXo-00028m-Jb
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:33:48 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNXm-0001WX-TL
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:33:48 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-428564f8d16so1344199f8f.1
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 12:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761334425; x=1761939225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9oW3kM/3oARNy2RW6YInbEGkmlrAbvhqLZNt15hfyFU=;
 b=kCn4fne0SYfExI4hVKpKprFTB2AsLI15tdyssFGkxCYzlt3Sc90RVMNpeP4mBGHK6P
 h+QX4NkDT0Vy81Za78vyD765Wg4LrnNzSptg5ffDwgvhg4GV1Jz/0TP7MGBF3duib3aA
 j4oA+tCfPw65n/fLAJDWjFJwfJtXcYjT9vJy22osxhxcCTublhPz8BRiZLfrJyJUtplC
 f6i20HpxoClHqKm56XnldJYqs1JNM0QrKnyc3eUm/r0IC9RViBe5Ufw0Sw5W9S26VBVQ
 bX40rjx3ZmstE2hPs/8/pzJABu6Y7jULjJWOWxJDh2ecm1POWUNIxxyCqfcrEkyDfsgc
 ZUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761334425; x=1761939225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9oW3kM/3oARNy2RW6YInbEGkmlrAbvhqLZNt15hfyFU=;
 b=SzLjCBp1yResEG/6i1IQhRooiCmAm0xED0d37ARYwTmDAyejpt8ghxGBEBxD4lWyAw
 F5yLOB/wEPHJcoVXGxW5RyxGgRa9Uuyoz8a78NmCpC4F2ZYe9T4FnyEJj0KG/jgauGEI
 QDS5+Nlucf4xXAbT6Xr2LpsdS1G0RH+343oa9zrIQZF7BIz8pr8Aalb0mAE0JPrvNQaR
 hEz+Acu969jHzkINt/8G5lvjnrLr2IOjgqg/oKb+B8eXxDKBgR/pVHwNlcO+emWIskpR
 SLlJZIL1UBpU3uNfKI/xUT9zlwPiH4n0D3yunquD/70SsUDU+zcr8LfY+oXrfr9OtaM0
 pm/g==
X-Gm-Message-State: AOJu0YzmZ5khZEHzbovs8IgOmvIo9GFcv7QpIdr05xHTA0F4hXBkrLuA
 zzaQtgh/gLiBa3/chw6W2gaU5wfjQymLIwaX6i/e2A3OBRmgVktDQ/PQ7Y7H0ySq9zhul4/aD4l
 HrcF8vwo=
X-Gm-Gg: ASbGncvGpRSQdffQvEsbNmhrTjNeAPdYx8WLuLY973zJyBQCIG4zN1qNOGSA+r52cHc
 Uzp1wUcuFZaWRrLzLLLFNDozTqvHxJXN9Sxwmsphy+eqOdmQMSpHWbH6DPX4z3Xrh4s8xv/AdgH
 bJlL0DqAap/6sxzCW5eybMmTXoWHgLgq1JQ9GpQzW1UrjHppV+BrqOsncP2OyLh4nBx9K95ohLW
 uypokbqTSJ+jiWXfbfnFfF9K5pLYcAcY6f8gBNLseMaNiKtglG90pNK/YtDyctB47Ur1QbbfQVg
 BFeNDQO9BLfk5MA/M52sKnSblGbNlstypeyF9YKdf6gjYo3sz+sjxzKpZ9L7zx1/jOvFD3hE9QC
 UvLLR4Ufx09W7LisKhgS0Z1ysCKRcoVYKd44TJ9/2h5azpgEJmev9ufzkn8QjIgfwhrqzWobyim
 ZhHn0WSFQQMucqSxlCddE3SZBO6xYwL3VDycewtPQEGsNkWGpy5XrcUDZEfip8
X-Google-Smtp-Source: AGHT+IH3sVraY9UzOiUmgqIAZfHGC9NuCzcLxWSPWLL0hHm0cCzMFDWXm0YYL7vX9i3JJbK5n3x1Ng==
X-Received: by 2002:a5d:5d10:0:b0:425:86da:325f with SMTP id
 ffacd0b85a97d-4298f58257fmr3644090f8f.27.1761334424881; 
 Fri, 24 Oct 2025 12:33:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d9e80sm7223f8f.28.2025.10.24.12.33.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Oct 2025 12:33:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PATCH 19/27] hw/tricore: Include missing 'system/memory.h' header
Date: Fri, 24 Oct 2025 21:04:06 +0200
Message-ID: <20251024190416.8803-20-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024190416.8803-1-philmd@linaro.org>
References: <20251024190416.8803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

"system/memory.h" header is indirectly pulled by "hw/sysbus.h".
Include it explicitly to avoid when refactoring the latter:

  include/hw/tricore/tricore_testdevice.h:30:18: error: field has incomplete type 'MemoryRegion' (aka 'struct MemoryRegion')
     30 |     MemoryRegion iomem;
        |                  ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/tricore/tc27x_soc.h          | 1 +
 include/hw/tricore/tricore_testdevice.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/hw/tricore/tc27x_soc.h b/include/hw/tricore/tc27x_soc.h
index dd3a7485c85..40962eab04d 100644
--- a/include/hw/tricore/tc27x_soc.h
+++ b/include/hw/tricore/tc27x_soc.h
@@ -24,6 +24,7 @@
 #include "hw/sysbus.h"
 #include "target/tricore/cpu.h"
 #include "qom/object.h"
+#include "system/memory.h"
 
 #define TYPE_TC27X_SOC ("tc27x-soc")
 OBJECT_DECLARE_TYPE(TC27XSoCState, TC27XSoCClass, TC27X_SOC)
diff --git a/include/hw/tricore/tricore_testdevice.h b/include/hw/tricore/tricore_testdevice.h
index 2c57b62f222..98ef6e7a3d0 100644
--- a/include/hw/tricore/tricore_testdevice.h
+++ b/include/hw/tricore/tricore_testdevice.h
@@ -19,6 +19,7 @@
 #define HW_TRICORE_TESTDEVICE_H
 
 #include "hw/sysbus.h"
+#include "system/memory.h"
 
 #define TYPE_TRICORE_TESTDEVICE "tricore_testdevice"
 #define TRICORE_TESTDEVICE(obj) \
-- 
2.51.0


