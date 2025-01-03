Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E7CE7718F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 17:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTlCL-0000Rc-9U; Fri, 03 Jan 2025 12:10:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlCH-0000Qm-Lo
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:10:53 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlCF-0006my-ND
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:10:52 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38634c35129so9457163f8f.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 09:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735924250; x=1736529050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+ZxGzYLdyzFu2uJQr5CjuW08BAF9noYF4W9aPPe+So=;
 b=hS42hhXuLBB/5Mm4tPpo+71AfNpXdvqnaYAWECn3rMrykfgcyEiAICVj0ajmAPkUQo
 WSU44ElLXDRVlHpjR5W4p1gZ0iedn87ODMg63/ZpzkbAy+MIfaG3N8C/zC2JDuw61ZNS
 inLoz6NQzcaNUUUnhdUxUbIf4hEoZfFnK5CF2QZ7iSBJlZYpZiULGwCLGlXSr2PHCGAs
 R6zcoJ+GmC+Jk6ib5BhvdTsgkXvCspxzPS1P95hE5ACP5+Ff40jh2ttFt+3VVcSkyPsC
 RNDOc7VcPcchGXUsk7nD1JEsSkPaT/+f1NJhTTzm7YrcTXz6ZrwDeDXaZjewPUvqFuLy
 ACSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735924250; x=1736529050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H+ZxGzYLdyzFu2uJQr5CjuW08BAF9noYF4W9aPPe+So=;
 b=Y0UDpVS5XwwhPkrnbE9L1itBnsTZLYvGlfKK4BsleioV/FHtXyn4EA1cqOMJ4Djsot
 ReeeEeI15HSTOCnkwA60DpufrEnhVvehvwx1duJZiy5WqOYcw4AyVWHcGwj+y9s2pKXY
 X4A5cktXFwMu4KHPd9TpNSscmL95LtGZt6ob1K355VGZRZSibBkF/3qCcW8Xud5RxnJR
 sQVfM0BKZKVenY6PlfQ7mVXuQDxhVcMs2b9lQx7iJ9uEk6eLNYQRwr3ruZVQYxoc/M0o
 pP/kl1GtqXCBjyI1bHT8I7VLEZ6Fp5lO1061guhBUuU1gLu7ff7MMM0TwByMKoFKasrk
 MQ3w==
X-Gm-Message-State: AOJu0Yyh7f0p7NJ/UZ/6q02QeGbMTtDGM8HsRMQq5xIoCtCW7mcmHpcq
 0t29V3OdrwwyUUt2y/LoXWzXJwsuSGuwuJyCqdiq6/mttwnZc9GXi7CHIaNNjJLMLEhCozlA6g8
 QbKE=
X-Gm-Gg: ASbGncsJMaXRDtD/wHMcOMq+3xnkFgrBwHOx/ksGjtq0tYymyzqswd51k6wvgB+A0L9
 xyhjtqzJGO5ViY6sAkIyClvhJd4KJZM/WtRuFtgjv2OEKS/tvGKz7yvY22GsqulOYUNwrUQBqZw
 DMXm/903adk8enmIb1Q8Kvh/f+IaDgUas3GO3CdiIL01Z3iIrUX9l/gGwVEM2tT+OHgkocqvoxh
 LMNY1bzYujZbgWX2zdmKD2qn0lT5/G3V3rM7nUu5PDBrs6If1upEOJxI44r4rc08MsFcVKuXWpZ
 31asexDsvfPSuXRS+MGRb+TRWkL4z+I=
X-Google-Smtp-Source: AGHT+IG36+FxPfRoaJs6T0beHTgfIyO000dxf+TJr+Eixq0xO8Ji7S32Oazk3Y0uueD1EPyK9+OZIQ==
X-Received: by 2002:a05:6000:2a4:b0:386:1cf9:b96e with SMTP id
 ffacd0b85a97d-38a223ff2c2mr49058216f8f.55.1735924249885; 
 Fri, 03 Jan 2025 09:10:49 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c847dabsm40627875f8f.59.2025.01.03.09.10.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jan 2025 09:10:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Kito Cheng <kito.cheng@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Keith Packard <keithp@keithp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/5] semihosting/uaccess: Include missing 'exec/cpu-all.h'
 header
Date: Fri,  3 Jan 2025 18:10:34 +0100
Message-ID: <20250103171037.11265-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103171037.11265-1-philmd@linaro.org>
References: <20250103171037.11265-1-philmd@linaro.org>
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

TLB_INVALID_MASK is defined in "exec/cpu-all.h".
Include it in order to avoid when refactoring:

  ../semihosting/uaccess.c:41:21: error: use of undeclared identifier 'TLB_INVALID_MASK'
     41 |         if (flags & TLB_INVALID_MASK) {
        |                     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 semihosting/uaccess.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
index dc587d73bc4..382a366ce31 100644
--- a/semihosting/uaccess.c
+++ b/semihosting/uaccess.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/cpu-all.h"
 #include "exec/exec-all.h"
 #include "semihosting/uaccess.h"
 
-- 
2.47.1


