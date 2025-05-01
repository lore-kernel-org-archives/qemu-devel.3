Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E286C3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLp-00011s-S4; Thu, 01 May 2025 17:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLZ-0000ng-1B
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:35 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLX-0001Ui-6k
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:32 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7394945d37eso1291553b3a.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134489; x=1746739289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DY53sbbsfhMz/uL2ST/i1QboUtxsyltjh/Yn/CjASj8=;
 b=zSr6z3ZgFnlXh8HI4m9IBDNV/r4KxqA8O5zXa3NVDuGPu+vIgYz5KP3rrCFnouKewT
 uQvclVHqrnK2WAf4xm5zNQ+Sdv4HJX/QJTlxBxl7+PdM7LbvuvlBaqbAnNUjIjXO/UEr
 iM55yiqhuJWLsOTTw7FQSIj7ha0x6Axq4YfvGKIXLgdxsP+q7VWqYvjhtcnkjzEXYfvN
 G9j5kOBe9XunOS+RF5FK1teG0bFlyRi6mdlYo8ehi2XbmIMTbiwWntZtQP6uYhKfV5jz
 7GK6t+zNGe6vQaJCBj47O15pSvrvfe73Wsm5jdndulWLSmFhdJCPsGSd3H9qzFDDbgv7
 zjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134489; x=1746739289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DY53sbbsfhMz/uL2ST/i1QboUtxsyltjh/Yn/CjASj8=;
 b=BOkVm4tKm4yRABXH27lr+A/W7fujYzE8S5iF5HlPsekrOYlQbHqkdRxxF1aCVaXQ1b
 CzSK8D85ysQM7NskCwzSziTP0VKYYny+zFgV0j+8bZtJruBlb0je0H94Us3TVd24Xbtw
 K86u2PxewKYuRj2A4IO3e1kRLu8I1gPODI1tb977fa0ZxhNe/hilW5bgnQ9OBQx4Qk+9
 qCIGffvxeu46F4Gy3LRw5TPeQO8ZuIOpohhpXjZpzS5TKcP+G96rlAxvIxQOJDhHe1uP
 LAjrsLsrdPYqq8jnVGbli82N7hhmJQN37ObAU6dH+9DvS5XaBCfIAMbFoqfdzIHAf92n
 S0fg==
X-Gm-Message-State: AOJu0YwYuuWkDa2MShyC7iyuL5VJFiKU5lCyKYkory476Z58HUVUP9Fu
 ivBuZqQQY7MBrHEjAGMv0o03VvwKtJfsW6Wkl40/wy1uQV6dwuKp0eCKOjs9NbxUUKuw6HM66YJ
 k
X-Gm-Gg: ASbGnctNZdpEcIOBsf1AlBpZPiWUlJRl1PG/rRTSXNm351suboKx7rlNid4fXrcdJv6
 xu/uYvnZcU/9xCotnXk/B3E/4BouIrbYSvwSMdKcxCnkekB6KVg7F/oTGMlry7Tod02hKJmFxUJ
 asF1BZ9mQCSkwqJ8N9gbxDMnwjrQlZXR2Fara5yNJJbHpvKYIVSyNKmOnKq8Pex3Ytu/aYxlxsh
 GTOPQHi8AwL44DKAXVF5dNFCTPiiWiKcneMPGL0xsZASFSlNrYhD2GbEQveCjg8va3jKkcJuTEV
 FORESXHws0mHWab0JAxSnFvpBncrKq1AtjcbticarFyyHdti7Are8np75Mhc8mhlSOhZmdz9W84
 =
X-Google-Smtp-Source: AGHT+IG0FVDesoCK7QnxxAAPn4ziz+8441rVXpGhO8e2XogoFFYBqGakFSFdnx3u3IDUzMD3ljWJUg==
X-Received: by 2002:a17:90b:534d:b0:30a:4ce4:5287 with SMTP id
 98e67ed59e1d1-30a4e42faa9mr1220926a91.0.1746134489626; 
 Thu, 01 May 2025 14:21:29 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 18/59] target/riscv: Include missing 'accel/tcg/getpc.h' in
 csr.c
Date: Thu,  1 May 2025 14:20:32 -0700
Message-ID: <20250501212113.2961531-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

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
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250424202412.91612-8-philmd@linaro.org>
---
 target/riscv/csr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index c52c87faae..1308643855 100644
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
2.43.0


