Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AC4E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 23:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLVkX-0002oz-Vf; Wed, 11 Dec 2024 18:04:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLVkW-0002oJ-RT
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:04:08 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLVkV-0001rS-8T
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:04:08 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-385d7b4da2bso6022449f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 15:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733958245; x=1734563045; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q84BF+ePAefMMrHK1zEl0KjUdaMQRdy3zhrx62Em4cY=;
 b=A7ymYIDO5fap9DrW/EBuzh7/yEydEefzdDuEfKHedx5RcI4wSuCV5V55XUhPcIkajG
 JiUJbLRJR41PR+DwSgdBi047I+zg9ZylSlnR4CtmC8gGmdQjuTKZYKVM8pSEc1qasYmm
 5ztNXDuzPcP5k+lkHCmku3wgrOz4gLiKrSrX1PSBNvGsQBrnbjFy7qmreAyPj0qnTOYm
 yFErLFM7CXFctn9La0dFsOMtiNWKCzrinER09og6FJEoqLDKrI1ZaAMtj8De9WcehdO3
 L/M4Xx+iX8xuwNwQDvL2HP0Wt5Wzd+8lKOk31114f2cMJ//cpuwfANBFzIqDdC8zVXnB
 VL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733958245; x=1734563045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q84BF+ePAefMMrHK1zEl0KjUdaMQRdy3zhrx62Em4cY=;
 b=Hpmc5tLfHeiZGN1CITkLLqcKrl9oAuHZVUUTR05j5cWwBki6llDnDGak/5CHUK5h6k
 a5MtxYmQMGPD2xTWX7aR0jMUtk6bqwO5LkChNXpbzy6gY56cMyrYb/nT6cKaMdZNmAnW
 KM/qE0dgQgi7KMO2+NvkuRqf5wpsIoPwGK6T6LMd6va1OchlL+2zD6bc0q89He5H8i8e
 ahN+aU3Q1JsdbenpZanWzl3h/C5p2DzZuzWwzHDU2E2a4Olfk9bpJnfc3j5QHuoHVd8s
 sYRBkLTzOTkIgiVgDm0cUR5A0jhISY5MblNXwK5sK+sbYOv0s9R9Q2LW4UJ4cWaB/g8X
 ALoQ==
X-Gm-Message-State: AOJu0YyHGW1O+ur0l0fCzNU6iM+MGeevpZIv8lIL4KUuZDUsBtPxDO+I
 R0NFEzcJYolCZRAWtmMjq2GeP52LZq3CRL7DRTqlcyfw7e1QOfxfGiLS32IpLJIrzphw5RdOf4n
 q
X-Gm-Gg: ASbGncumTikcgP+3xnSMVNNpacsxDXwIQOWxVpA+hlHzJfNKPB9qSOAYMor6lj3qnQF
 1Nq/rWQPLh0/1yyYI/gf7RSoZbdaNFrmTCLaayqIYMgDsTZygVuosVOHsH61FtQFC/rB2fPtAcZ
 98qxtFhN9n3FKlso0NsXMb7CGoFErZmqO6h32cVpF3cWTo4dYmS2FKCqTRppez8LVjp8qpPJySt
 pFQIJxIIh4GqNmUVGDmhzP7pJP6/0Lw6v+Om08ainOreqANex4gJqIsATKNfyDzNZkL1vQqBRtG
 HuNiPP8YOi3nQ2NIPUWo51cv7i7t4u3XiQ==
X-Google-Smtp-Source: AGHT+IFj4wDYdVTeVwuYH2TKwtEA6LG+06PYKJPO47q/hi6nNnWcScJdwe5EV5X9ap37AMBzXiD+XQ==
X-Received: by 2002:a5d:5983:0:b0:386:3903:86eb with SMTP id
 ffacd0b85a97d-3864ce97148mr3804619f8f.23.1733958245097; 
 Wed, 11 Dec 2024 15:04:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38782514dc3sm2279838f8f.67.2024.12.11.15.04.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Dec 2024 15:04:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 1/9] target/xtensa: Remove tswap() calls in semihosting
 simcall() helper
Date: Thu, 12 Dec 2024 00:03:49 +0100
Message-ID: <20241211230357.97036-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211230357.97036-1-philmd@linaro.org>
References: <20241211230357.97036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

In preparation of heterogeneous emulation where cores with
different endianness can run concurrently, we need to remove
the tswap() calls -- which use a fixed per-binary endianness.

Get the endianness of the CPU accessed using the libisa
xtensa_isa_is_big_endian() call and replace the tswap() calls
by bswap() ones when necessary.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/xtensa/xtensa-semi.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index fa21b7e11fc..2ded8e5634e 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -30,6 +30,7 @@
 #include "chardev/char-fe.h"
 #include "exec/helper-proto.h"
 #include "semihosting/semihost.h"
+#include "semihosting/uaccess.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 
@@ -323,15 +324,12 @@ void HELPER(simcall)(CPUXtensaState *env)
             uint32_t fd = regs[3];
             uint32_t rq = regs[4];
             uint32_t target_tv = regs[5];
-            uint32_t target_tvv[2];
 
             struct timeval tv = {0};
 
             if (target_tv) {
-                cpu_memory_rw_debug(cs, target_tv,
-                        (uint8_t *)target_tvv, sizeof(target_tvv), 0);
-                tv.tv_sec = (int32_t)tswap32(target_tvv[0]);
-                tv.tv_usec = (int32_t)tswap32(target_tvv[1]);
+                get_user_u32(tv.tv_sec, target_tv);
+                get_user_u32(tv.tv_sec, target_tv + 4);
             }
             if (fd < 3 && sim_console) {
                 if ((fd == 1 || fd == 2) && rq == SELECT_ONE_WRITE) {
@@ -387,11 +385,8 @@ void HELPER(simcall)(CPUXtensaState *env)
                 const char *str = semihosting_get_arg(i);
                 int str_size = strlen(str) + 1;
 
-                argptr = tswap32(regs[3] + str_offset);
-
-                cpu_memory_rw_debug(cs,
-                                    regs[3] + i * sizeof(uint32_t),
-                                    (uint8_t *)&argptr, sizeof(argptr), 1);
+                put_user_u32(regs[3] + str_offset,
+                             regs[3] + i * sizeof(uint32_t));
                 cpu_memory_rw_debug(cs,
                                     regs[3] + str_offset,
                                     (uint8_t *)str, str_size, 1);
-- 
2.45.2


