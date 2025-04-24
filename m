Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B715C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tB9-0007vP-1a; Thu, 24 Apr 2025 05:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tB6-0007qh-3P
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:32 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tB4-0002aj-4x
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:31 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso7063505e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 02:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745488048; x=1746092848; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=766nu4+voMP/IZQOGysMn7ofUaqxPgeNp6L0gDtkVMA=;
 b=dM8Priw/a6VamxtAtUE/XLYR9h3U84T1V34luaPqUhVw3O9nFGHUSIL0XGA4Oneknw
 H9hvfT6px/SbNj1jek99kzoQEs1XxxIybp3qkY4CVFo2jUlDiBtgwY4cgXud5drA5AGL
 Okln0UxNa9MqSw7cRcWFjSgWLJL28/rKk+KsbHhodVgpb7bwvmIZbrCG81zRBPslvZaR
 bd0PpoC/Bp5L3go/owtGlaySDeil1QqqECeWO+3FVItX8TBMBbvLlrh+wjTJHbAVBvei
 oscev77thg4ypB/bYcAjABaIVgf2WeOyET3a8XyMw1ftoG3IakQ5rXaCHr5HmjznR2XR
 /Y8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745488048; x=1746092848;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=766nu4+voMP/IZQOGysMn7ofUaqxPgeNp6L0gDtkVMA=;
 b=YdvYfrD47XLNAiSClHL94a4FzQiR9LmvaUEYpqAYa8lERTk4DtDZva9+OPmVRjghCO
 96siwcw5Fp3jZBb+91Ri2sDXWh8eQ1MWSG52xkIDY95Hyjvo6aTxGzQstwILMYImey3n
 hoAli7XFUW+D4GJAplCmnB731Lw6jbnWpX0b7iibZCN9KV7ETJoxhdtoPi2dxAki92aw
 oSALOSNeVVYSY5kCp+EmZomWrEyNPzUZ4cME4y4qZJD7qTgZ7FchAeW2V3P5OB9rIOJ6
 YoQMYm1rMOgf8JrgC2VszF/2dXewhUGqgulsJDbXDEe3KZk3+Od6s0EwT6tI986yzfDA
 KScw==
X-Gm-Message-State: AOJu0YzQQV6Jkcjo8GKDLZ+WACWQiJTC1Nysa1kMUtlkQNFX9odBRk0m
 ABVRMTmb0tGTGZFBymaht7i3tY7TgFj5ISyMCfTr40wozeVGuI6+IVLGIzGa6PufxceBraPyGqu
 K
X-Gm-Gg: ASbGncvrQqKes51kvQ9pbOOkFBU09BBy7GBacwjF35SINjzP2+dGl86oFgrrbWnrSZe
 PUp1ay5eztC+0EI7Miy6MatEm0uJBrUtIUAjSMIVRHr0E1223vjMspHyVj3u0BJVopL8xCku0ZV
 Ion8F1TIERAKuwsHfaAygngbMbarYe5TxbCi8dtm9c3P/TjqDGt+2FxBY4Nac7Vc7cCYh+DFNx8
 CEbUp1qyQx6jLJ8ki/zI7A1qh3O80is3qKPIzyIQM3Blda/bSnWAZw/GQ12lda2AStJTPESptoP
 u8uMsPU7x1qrpjnRouu9TNZVkdk5Kge2gZ5BxWjF9DO956WLnI25V/iN7XlvL0fNxiZx9doIs33
 fuXbM00mQDGcQ7uoOyyWj
X-Google-Smtp-Source: AGHT+IEM9nUBdcFHzd7Ao2xx27IDjBOA8cM85PkrVmQbR2Odxvhut4ZVkwi3sb+7iWGV13qrB8BNlQ==
X-Received: by 2002:a05:600c:450e:b0:43d:1824:aadc with SMTP id
 5b1f17b1804b1-4409bd89ca4mr13272515e9.29.1745488048358; 
 Thu, 24 Apr 2025 02:47:28 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2bfa93sm13947915e9.37.2025.04.24.02.47.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 02:47:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 07/13] target/riscv: Include missing 'accel/tcg/getpc.h' in
 csr.c
Date: Thu, 24 Apr 2025 11:46:47 +0200
Message-ID: <20250424094653.35932-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424094653.35932-1-philmd@linaro.org>
References: <20250424094653.35932-1-philmd@linaro.org>
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

"accel/tcg/getpc.h" is pulled in indirectly. Include it
explicitly to avoid when refactoring unrelated headers:

  target/riscv/csr.c:2117:25: error: call to undeclared function 'GETPC' [-Wimplicit-function-declaration]
   2117 |     if ((val & RVC) && (GETPC() & ~3) != 0) {
        |                         ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/csr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index c52c87faaea..13086438552 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -28,6 +28,7 @@
 #include "exec/cputlb.h"
 #include "exec/tb-flush.h"
 #include "exec/icount.h"
+#include "accel/tcg/getpc.h"
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
 #include <stdbool.h>
-- 
2.47.1


