Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6996DC001CC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 18:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxA2P-00038U-AI; Wed, 17 Apr 2024 14:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA2M-0002p8-Nq
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:29:38 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA2K-0003br-BF
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:29:38 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a5561b88bb3so111650866b.0
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 11:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713378574; x=1713983374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=76vcPv2r9CdASlN2TgaoXk1O8gv7hK5cwNss1TmWJNY=;
 b=DsbGbR2qbpeb/WK896YqikZdJhlaxLzeD6cCLAmHan4NDAhvBynqR8eM2Xqkf5FuhC
 rVYD33w3nqB4Ze2OlM4faRai3pFjpnQmwYYFGbdGSknipyARDkR8B4XBkjh/xou0PhYv
 7x8y+/7RZVkIBqYtZrRJLpvEj4alohJgGe250E1TCKVcJYJHkpNVB8WqYTo671d9k6aw
 aBQPyGofR5Be0WVVv9itzEfBYnF2/Rvabph8NAWfNoCg5iKuE/hWQmONSAh9DE5sHvPz
 fIJX5LT/Oaoi6vGu1LYkHZnjd/Z/dMGdLLeb7mrchGgoPzkxo5ykP4LYuF2XjaJb//Tj
 e21g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713378574; x=1713983374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=76vcPv2r9CdASlN2TgaoXk1O8gv7hK5cwNss1TmWJNY=;
 b=Peevm3zrcqM0CZ80YZuI/fI0AJz0p5rfWtAekx4aDxNhij42a7g5uzTeAB6Pb4BeiV
 ag04iIDHl49ojXPbOEDp7bHy1t9EMrbG9+fuRgwZM4W/s5ZFbW3UdFwyJHQ1btC/mKPK
 2nrmoLwvftnLNWfLGniWyBhCBWBf75mDO8Vl7Cdaw6c/pyGd1UxAJb8n4SVvvObNWZQD
 QHufa+f3BKjJARM4o4QuVfE2OJpeRAxjKfREQki0hgcExDz5BGSLQw21ItwF949gQQRx
 SUMklKVT53FzvmNEpol8RZuERnJi3EudsHdmUbwWxLf6zrIS9qZWeO2UjAtY2SKUSDA+
 n2cw==
X-Gm-Message-State: AOJu0YxaKx+hX0KKAcuGLG8ZHy9yEalLVU0hlW1iQ1i6oVfVGy5w+hl+
 9+BHs8jZ2nem5g7Kgfjyr6V+GCa6NWkxhjFqjjOXRp1TAgnIDNbMBdwkdQRWsX58Af3asxwvkuS
 j
X-Google-Smtp-Source: AGHT+IFqslbhmqIYGQS2u0R7cu4pmJzmHT/63NWL8lJhn3yYU6bULo5XeD+kgLIQWuQUU06RZvvJKA==
X-Received: by 2002:a17:906:4310:b0:a52:3623:f498 with SMTP id
 j16-20020a170906431000b00a523623f498mr211705ejm.31.1713378574257; 
 Wed, 17 Apr 2024 11:29:34 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.201.23])
 by smtp.gmail.com with ESMTPSA id
 sa41-20020a1709076d2900b00a4e03823107sm8370482ejc.210.2024.04.17.11.29.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Apr 2024 11:29:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 15/21] accel/tcg: Include missing 'hw/core/cpu.h' header
Date: Wed, 17 Apr 2024 20:28:00 +0200
Message-ID: <20240417182806.69446-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240417182806.69446-1-philmd@linaro.org>
References: <20240417182806.69446-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

tcg_cpu_init_cflags() accesses CPUState fields, so requires
"hw/core/cpu.h" to get its structure definition.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20231212123401.37493-12-philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 9c957f421c..2c7b0cc09e 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -37,6 +37,8 @@
 #include "exec/tb-flush.h"
 #include "exec/gdbstub.h"
 
+#include "hw/core/cpu.h"
+
 #include "tcg-accel-ops.h"
 #include "tcg-accel-ops-mttcg.h"
 #include "tcg-accel-ops-rr.h"
-- 
2.41.0


