Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9612CE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfgi-0007Pt-MY; Fri, 20 Dec 2024 11:17:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfgV-0006ji-QN
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:04 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfgS-0007hH-IO
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:03 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so21039515e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711419; x=1735316219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OTYecouxryt8oAmr6jLepXhNqrl+INtA6a9IOInE6NQ=;
 b=XZz5Bt0MytvIjGQels6CAu00itFkZtBVhHfk+az0ghUNW2ce2WZLNsFsuP/PNFYAeF
 bjwUq9NRu8LXmBYpz2UsRp2rd+l/JbM5gdemg9Qx7dHYWzXyC/yNOlYlSQiJPGzMC3qd
 IrDQ05He+jr23Xp/A3fTRxsvfTywNMCzWPXrGyL/k5iD+yPG1qnX2ZIprR9B+15Bd5hl
 3Zkiu+0fUxPx8Lh3hNPQ7HptgXNlC/yLRpFI8Aa073lFEFKp41XGmm4us7nux2/MVMM+
 pIAUNvicPSzOLYFpcDvZylxUvYXGHijynY9e/mqa7uK5ivsHAYRoHzpuOJM9wW3akXFv
 dkbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711419; x=1735316219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OTYecouxryt8oAmr6jLepXhNqrl+INtA6a9IOInE6NQ=;
 b=H5AYkw96yzFRwKVKBCi5FkmHw/rcOJA/c/0h6cOVQdG9gMJVOQ58VzAildu+RHmVeb
 x4TwQUIWj4cpNiwMgQAjoOE27UmUz5WiVl3BLvCOfAXI9kgo/IpGVSKSVj/Fx1f+5fSq
 nt/XDFtooq1dKFNjlAI4LOndNw/jCeYn6EPNpzxabzqVaRyXA2vM/ryksDkLtcIi6Z7W
 Q6yn/MrDp/Rypf8pR/f+IAWOvyXJdVecvLz+oJlpmOtHfE4JUQWV8L0Bpvd4iel1Iy8e
 hxRWxTvGwreS2StRCR5lDpUdIYm/dqzRT1qgSZflqRvuMSoCMjQczNlHcVUV1chZ4UD7
 xbsQ==
X-Gm-Message-State: AOJu0Ywc0sx+VufD/Exr23YDN3xNIfUVWzfzqeayVzXj/vbTfThGnKK4
 xSoqbBVZ5EVx2pb+wp5TIAIA8d8tbBSfbzwzBXssyjq0+lCqivgeweP3abeXytT6uq91AvxRR9X
 u
X-Gm-Gg: ASbGnctbJd/xlbNgo6zoeYukujkRexSgq2kq2J/fC7J4TauV8chJnd2u/4W9CYuSQkr
 LpOLtr3Jys1TedW3zZ+5ETihCUKXWY+Su8Lh9VHL2lcNows9pLv/GzLY7jlE472HWBJcoN31Wx2
 TXf08kz4NfAESKdre88KX0BWan5ppphT1/E8wxDV4z9eo2vN6SeUuK8fonvW6+1RvQvYhR4Gsto
 b30JnLrdkuEd5411qCxeAzgslEVVrWI8djMpqv3NGAOIB8Wu5piqGK1aPqovE/lj3AALbIHj4U=
X-Google-Smtp-Source: AGHT+IFOr5CeJBrvE7WyxWyJBNu2//WPF820f/+y3IoiOxsRpVj9sD8oRMSZYqUy4vV8hPW3NngtIA==
X-Received: by 2002:a05:6000:470a:b0:385:f092:df2 with SMTP id
 ffacd0b85a97d-38a221faae4mr2946386f8f.34.1734711418687; 
 Fri, 20 Dec 2024 08:16:58 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a2432e587sm1477255f8f.95.2024.12.20.08.16.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:16:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 14/59] accel/tcg: Include missing 'exec/tswap.h' header in
 translator.c
Date: Fri, 20 Dec 2024 17:15:05 +0100
Message-ID: <20241220161551.89317-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

translator.c indirectly gets "exec/tswap.h" declarations via
"exec/cpu-all.h". Include it directly to be able to remove the
former from the latter, otherwise we get:

  accel/tcg/translator.c:433:15: error: call to undeclared function 'tswap16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    433 |         tgt = tswap16(raw);
        |               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241211230357.97036-4-philmd@linaro.org>
---
 accel/tcg/translator.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index cbad00a5172..ff5dabc9014 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -15,6 +15,7 @@
 #include "exec/cpu_ldst.h"
 #include "exec/plugin-gen.h"
 #include "exec/cpu_ldst.h"
+#include "exec/tswap.h"
 #include "tcg/tcg-op-common.h"
 #include "internal-target.h"
 #include "disas/disas.h"
-- 
2.47.1


