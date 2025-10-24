Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DDFCCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 19:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCNk0-0002TD-3o; Fri, 24 Oct 2025 15:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNjt-0002Q8-Al
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:46:17 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCNjm-0003Yb-1Q
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 15:46:17 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4710665e7deso11977215e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 12:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761335165; x=1761939965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cla2YszDVwablt8Ymyx/d1GI0PEfMm4fj8BCEX8Hctc=;
 b=Uth6r2qDrCrCX7FXAxu/9jjz6CGpMAIXC2rpeuAw4LUjbIrS+8HnKvYQqvKuVPPgsS
 1OCM067sASOcRjnR1rOpD+nUpGaraUysc5gwHxEhE4iOP2ikb0lTTOBq+84l9+Bdf67M
 KvQLvvgFRQpEr8adN3vukjlaMoAKZ916eVfN9qipJ9JMROaeqewiz2VJ6ONun0t5IX9r
 NSNhc1e2ja2Z6AoV/tg+tgKCqcMZFsTJqyJzvfKGd3dJEwZVlz/f5Bn6pAlk7j3zyNej
 ht0q6xMLK2n2AyIXlINjVNZtI30rn0yMzUFNUy/pGiPu1UpJIEk068gBvDqeu287zwm5
 4t1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761335165; x=1761939965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cla2YszDVwablt8Ymyx/d1GI0PEfMm4fj8BCEX8Hctc=;
 b=aOoyP6fDz5hiGrhMxtnpsyRCWEo/gcdaKwTL/Sz0Cw0zl0uLm+8pF9aTmu5NZQiHe+
 GAoWGWTAYZVy4bbOvIV3PMDRyzOyyU31qMqeb5MpxiJwm6B7VvzE/BfwsTrjjHARRgPq
 Ql2f5zbMLracUP+8Cvs4qpkyKDdssXWgciSp6/kvBbEAyqs/ZnFB1vcJ+hyzW44dl2YJ
 SEYnPQGp4iG/vlpYWgAElgkBy2P4hvuarWkoj3IJnhkqUj5LO6o186M7PJ4oIcre0i6/
 olpE51HbirE1LAV0Yvuv5SXDpjVpGtNK1fzqrDogonBlAkQwu10Nd/9aN9yDhMSrW6CK
 U+Nw==
X-Gm-Message-State: AOJu0YxLJRF4yO0xpF3re0iRXZqY6mvo55GFKb4hW44D3gKTOh8m+20t
 pCyP3VRBLOfqGfKO7xmavwgrHa4yS3uEFd1qPFKWnsSZpaK7YcPxBRgXLIO5/paOwYXqZl8+xV2
 ldc+bhRU=
X-Gm-Gg: ASbGnctNFCkbd2EzB3Y/oqUIwl0g3GyK5CtWiUEQ968ywRulcX4jUK+adapHw3fienJ
 FmoEcxq3gINZdApRpfy9D/tQRWa924zOQmwDM2wQZ5E9qLsq2cPAYdGWZiILVnR7Y+YjI8iqQgn
 Dldo4dL8Gf1JEdmblb7klgRL2c+Uqxx9ZZPf26rsEjs0gGyKkRjCesS5Og0BugvMxAiLreaeBHp
 KMkAaBR9jsm51tPX44qpQmdSW9t1qh5XI190ZiAH/UPwMbvxL5d+HR/7PtYsytFeyUo4s/n5bbf
 4mOjsdddnVgMyFNLO0apCEElykHVQGnBETGdlTfkSVMSbj0RmGla8lgy926aRqgnPFwudgYZbIn
 sBLudY31ic25c8JleuQg7KKjxP7dBUsfYBfTXjV+A5Ki71iFPLtkp3vdkKxTc6jUKp5E7ThemwP
 lMrCbJ6LmlZFTXa29QEzhVZAIEH/jo8aDChrRSc42YRiNDGKC0YyMHLrv3yH9NyUhq/hCp+GA=
X-Google-Smtp-Source: AGHT+IGSptXEI9c9Ynsr/iv3pZ589oWEr2VkZOpX37HpNrWv1MrV6VdutHVVPIXNK+OpALK/3rpETA==
X-Received: by 2002:a05:600c:1d15:b0:46d:d949:daba with SMTP id
 5b1f17b1804b1-475caf93244mr56926095e9.4.1761335165309; 
 Fri, 24 Oct 2025 12:46:05 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c428e9b2sm167837405e9.5.2025.10.24.12.46.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Oct 2025 12:46:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 27/27] hw/rx: Include missing 'system/memory.h' header
Date: Fri, 24 Oct 2025 21:04:14 +0200
Message-ID: <20251024190416.8803-28-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024190416.8803-1-philmd@linaro.org>
References: <20251024190416.8803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

"system/memory.h" header is indirectly pulled by "hw/sysbus.h".
Include it explicitly to avoid when refactoring the latter:

  In file included from ../../hw/rx/rx62n.c:27:
  In file included from /Users/philmd/source/qemu/include/hw/rx/rx62n.h:28:
  include/hw/intc/rx_icu.h:50:18: error: field has incomplete type 'MemoryRegion' (aka 'struct MemoryRegion')
     50 |     MemoryRegion memory;
        |                  ^
  In file included from ../../hw/char/renesas_sci.c:30:
  include/hw/char/renesas_sci.h:34:18: error: field has incomplete type 'MemoryRegion' (aka 'struct MemoryRegion')
     34 |     MemoryRegion memory;
        |                  ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/char/renesas_sci.h  | 1 +
 include/hw/intc/rx_icu.h       | 1 +
 include/hw/timer/renesas_cmt.h | 1 +
 include/hw/timer/renesas_tmr.h | 1 +
 4 files changed, 4 insertions(+)

diff --git a/include/hw/char/renesas_sci.h b/include/hw/char/renesas_sci.h
index a4764e3eee3..26142a20baf 100644
--- a/include/hw/char/renesas_sci.h
+++ b/include/hw/char/renesas_sci.h
@@ -12,6 +12,7 @@
 #include "chardev/char-fe.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
+#include "system/memory.h"
 
 #define TYPE_RENESAS_SCI "renesas-sci"
 typedef struct RSCIState RSCIState;
diff --git a/include/hw/intc/rx_icu.h b/include/hw/intc/rx_icu.h
index b23504f3dd1..a8ca94938d4 100644
--- a/include/hw/intc/rx_icu.h
+++ b/include/hw/intc/rx_icu.h
@@ -23,6 +23,7 @@
 
 #include "hw/sysbus.h"
 #include "qom/object.h"
+#include "system/memory.h"
 
 enum TRG_MODE {
     TRG_LEVEL = 0,
diff --git a/include/hw/timer/renesas_cmt.h b/include/hw/timer/renesas_cmt.h
index 1c0b65c1d5a..64bd14dc7a8 100644
--- a/include/hw/timer/renesas_cmt.h
+++ b/include/hw/timer/renesas_cmt.h
@@ -12,6 +12,7 @@
 #include "qemu/timer.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
+#include "system/memory.h"
 
 #define TYPE_RENESAS_CMT "renesas-cmt"
 typedef struct RCMTState RCMTState;
diff --git a/include/hw/timer/renesas_tmr.h b/include/hw/timer/renesas_tmr.h
index caf7eec0dca..f6c5937f40a 100644
--- a/include/hw/timer/renesas_tmr.h
+++ b/include/hw/timer/renesas_tmr.h
@@ -12,6 +12,7 @@
 #include "qemu/timer.h"
 #include "hw/sysbus.h"
 #include "qom/object.h"
+#include "system/memory.h"
 
 #define TYPE_RENESAS_TMR "renesas-tmr"
 typedef struct RTMRState RTMRState;
-- 
2.51.0


