Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400D5C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 20:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u837u-0008IJ-1Z; Thu, 24 Apr 2025 16:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u837r-0008I1-SY
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:24:51 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u837q-00050y-5i
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 16:24:51 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso1816916f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 13:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745526288; x=1746131088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EzYHC9R7RTf1r/vPvoxmooHSOXxbT/I1N4/WAtczuAw=;
 b=U83A04Au7PvefqAAvPoSpkEOY5oqdqZUdUr8D4xOyee4kC4xAseTB3YWYQM0xlacbt
 sOZj7RTzgkbIHve0Tqm/AJxPBelYjM/Fl9okIXcIzVs4fZ+FTlNimYUEdP/HZVS9ovxU
 CuMlQHiy1idgfbQfG4MJy5vIEtJaURh5ZW8GBuQCAt3vS28AoyWNBQ7/AP4FmTpDeLcU
 p2Xr7arQilp+x+vAVQX3qOiymxeWqKNwWLMdwK2UClsAVL1KITZuYm5B1rd2VAJ0uCre
 n2JtyRjen2K3dxwhmVzWPI/BUoo38XSB1Oj1hie7cl1y5qNsiSm87F4R+PhJoSNzawJL
 LuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745526288; x=1746131088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EzYHC9R7RTf1r/vPvoxmooHSOXxbT/I1N4/WAtczuAw=;
 b=QwHcViV8oFMVOyf22sWT/OfTAwOVsQGXoz8nopccrZCYy31qAHl+7QdtA0gQ8z8RLG
 o36hsqSRfwBiD262ubJ5PO7ZOd9gZw6vTeTsrpRZkO/MgaCe6uuhIsYUlUiYf0IoNetO
 8x2NAYR+aHSkvtqpqf7rj0m2AdF5EqBfOpGP8IpO8/a6HYtkbqLYnJPdoIi+vnp/uz3N
 cuV5DFe03pOv+S+U7gl2HStD3Etokt+pz9NjrpI/byhhSfrwolPUjlJRPrBYz5oy8+tE
 COzU3NGQ72PZZuh14/9mxHU8ZSSZIfgnl2y/NBaut/y2UzgXUP0XT0Mmp021lVLdXewJ
 Ymsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWac1ucf73ueF5CqeSPMs+cbvb/J70eOc32OBh58m5gU9CgU/c/LNNyYZ8jIprxWEPWZ6cQ8xz69Ut1@nongnu.org
X-Gm-Message-State: AOJu0Yz5TJBvZA+KgnUPkXKp5a7Oh+fRKX7XNKLEPgA/s0WP6DAwDvkM
 D1vvV37tgDwwORzAKxpTdkQ+s1KT+P4dBCNkJV61bbPGvyzRK1hPYRf6Rxd/wZY=
X-Gm-Gg: ASbGncvAtH0cCXdPIFn8cG4wWwBmzVL3Akl5Ip72nI0rONZxhdwryL2AQWFn5vFZDON
 8WE4w5cVGciIwVIoeGfVEkG+5Y7lRv3E25mCG6nJiFIeO/bMckxhLwzQPwSafESz3jePJNeOy3Q
 O+CqmbcLRQAJ6TKpDdMyZwyy9HUZgMnQIZHwJt3/8wp0pi0uihFo2KfKlv6RwUcpXhekiiy+hWW
 x/Yhvh/uFuTRYMbJ2b7idBIWnybR05emYBFmvRRzMuwZcL4KruCUlglyElp6RdRc1bOzhoL8BBB
 A/0SP8xYk799QuUUybKwp3mlN9kAjh4re1JRpO8t/gm9lori9iqI8X/VHdZTxvKzm2XohRgJaAX
 pOIjEFI7qdKlbbzA=
X-Google-Smtp-Source: AGHT+IGuFrkab2UMktIvxfj3Z5UfSS/Z+H2Mb6Ffc39m9LjbprI8VENZeJCoLxwISscupJ4FYTsXow==
X-Received: by 2002:a5d:4887:0:b0:39a:c9ae:9eea with SMTP id
 ffacd0b85a97d-3a06d651cb5mr2730106f8f.10.1745526288182; 
 Thu, 24 Apr 2025 13:24:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5e198sm244598f8f.97.2025.04.24.13.24.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 13:24:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 07/13] target/riscv: Include missing 'accel/tcg/getpc.h' in
 csr.c
Date: Thu, 24 Apr 2025 22:24:06 +0200
Message-ID: <20250424202412.91612-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424202412.91612-1-philmd@linaro.org>
References: <20250424202412.91612-1-philmd@linaro.org>
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

Note the TODO comment around GETPC() added upon introduction in
commit f18637cd611 ("RISC-V: Add misa runtime write support"):

 2099 static RISCVException write_misa(CPURISCVState *env, int csrno,
 2100                                  target_ulong val)
 2101 {
  ...
 2113     /*
 2114      * Suppress 'C' if next instruction is not aligned
 2115      * TODO: this should check next_pc
 2116      */
 2117     if ((val & RVC) && (GETPC() & ~3) != 0) {
 2118         val &= ~RVC;
 2119     }

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
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


