Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0E0E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX5zA-0005Kp-Bj; Sun, 12 Jan 2025 16:59:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX5z8-0005KX-KS
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:59:06 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX5z7-0003mh-6R
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:59:06 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso25725365e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 13:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736719143; x=1737323943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cfr9cRQteCKCUUzw1cda3aUrNzk5bprsudeb9V2vsoc=;
 b=O9WdUB759t7xCDpUs9DAb31rMDcsgexYDxWHwuEnjfZvZ7xJzZeDarXcEK01QYYkG3
 YNaXsqk8F0/AISezT5uZIHLm1aa16Zxu/8Ca6gBw5rwEgXAx8If+CzVqveTcN5WWIjkJ
 Dg0Qt3wOc8GeiMFO9jC12JbzzcgkmAhcM2YNeAJMsTglAq1wnNEKS3fw8o2JVHc/DaFf
 OkroKlhhft67yD4sTUBsK2yTwOAOLocAWnGWWsCjbRIcNwfcJe9XE6yvK3gDfKtnLJD7
 nkeGgN1z2MNfhvPDXmbaJt+Oksl+WaPe1mCE2e7+BEXtzBzCSVFbwo4wbmsehd22uMhr
 1hbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736719143; x=1737323943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cfr9cRQteCKCUUzw1cda3aUrNzk5bprsudeb9V2vsoc=;
 b=XrrmOQ7lFcINBYsDP3xHKKv6RxXHowKq9NmzX3rfzfV+xCAyOYX+6jrtPtZYjjn4wV
 Xn6wYtFNlCE1gqZZnkkKWGiUZSzjLoLLAXrV2VXHptc035OqTveSh/3qZms3NLmHjfAh
 I6S0Ylfb/vyjZqmCVQQJMHexTYWpKoJBBwMombuUHFW2iCGGpgm4AMGHdyBuJBHZnMdp
 1Ejs+bOh2ZcWe1RuG5YGnHio1LFZXQ2lAoSSSBLnprPf8IE/4fX45W36pF8Gj8Vz7i77
 lqhzGaoIPkqvmr8ZOZQyGL6dmqRyVjbXMD+M1fKWjqkfZxLzdFA1EvpgkoFAamjgQZf6
 UucQ==
X-Gm-Message-State: AOJu0Yw9zWzIbNLX7Hn+cOJ2dKCSaObdV0sUdOuOccDKZ9WnjocjIApG
 bNUWHRoMjzN3PkyOboxwV38832F4WHKJxMl7dKGYlaGQ/QFf+PzcnkmMgtTt6QBoVT1GHWJGsRY
 NcQM=
X-Gm-Gg: ASbGncvns9ISo6C1Z69ah+XpmdYKaIAVWM6Clc9DFTSMhfLEt7txXG1A2N+CNZBnhf2
 M7UwQJl9OgGFsoxO7Twdl4sCeAuu8yxWWnXBWMb85rERmFkL/1/khKGjAYrjqY4FhNT1q6xkED9
 uYkxDJ2g6EGL5+KgITDarT29R6ClkfcKk7eoui6+CYiOEzwfLG5E0OR/z2Y4RypwRNJuISFshvM
 Sx6idH2Txp/7f8sQaa+s//OHCZ4afZA8nghYrRy0w2mnX1j49RqG2kBbqfslywXtB+80Y8qfpKt
 ukZkE7RsC1y2EUgYVlBA/wl7GcObJtE=
X-Google-Smtp-Source: AGHT+IFFTx4b52Neta3UZy1xgrQiEwdCk1LZ2qm99PXfDbF/o37DR2S/bn0ROjZeNjU00h/LUVyInQ==
X-Received: by 2002:a05:600c:500f:b0:436:51bb:7a52 with SMTP id
 5b1f17b1804b1-436e2697170mr170863725e9.7.1736719143168; 
 Sun, 12 Jan 2025 13:59:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2dc0069sm158837685e9.11.2025.01.12.13.59.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 13:59:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 05/11] hw/mips/loongson3_bootp: Include missing headers
Date: Sun, 12 Jan 2025 22:58:29 +0100
Message-ID: <20250112215835.29320-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112215835.29320-1-philmd@linaro.org>
References: <20250112215835.29320-1-philmd@linaro.org>
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

MemMapEntry is declared in "exec/hwaddr.h", cpu_to_le32() in
"qemu/bswap.h". These headers are indirectly included via "cpu.h".
Include them explicitly in order to avoid when removing "cpu.h":

  In file included from ../../hw/mips/loongson3_bootp.c:27:
  hw/mips/loongson3_bootp.h:234:14: error: unknown type name 'MemMapEntry'
    234 | extern const MemMapEntry virt_memmap[];
        |              ^
  hw/mips/loongson3_bootp.c:33:18: error: call to undeclared function 'cpu_to_le32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     33 |     c->cputype = cpu_to_le32(Loongson_3A);
        |                  ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/loongson3_bootp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/mips/loongson3_bootp.c b/hw/mips/loongson3_bootp.c
index b97b81903b7..712439c2575 100644
--- a/hw/mips/loongson3_bootp.c
+++ b/hw/mips/loongson3_bootp.c
@@ -21,6 +21,8 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/cutils.h"
+#include "qemu/bswap.h"
+#include "exec/hwaddr.h"
 #include "cpu.h"
 #include "hw/boards.h"
 #include "hw/mips/loongson3_bootp.h"
-- 
2.47.1


