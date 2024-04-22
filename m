Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9553EC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 12:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rytFY-0007Qx-2c; Mon, 22 Apr 2024 08:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rytFT-0007QL-Fn
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 08:58:20 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rytFQ-0007Wc-Ty
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 08:58:19 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41a7c7abdbbso5688825e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 05:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713790694; x=1714395494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SEB7rrTLtp3+E0UWx6azHIwaCjR17UZYQGWqmUBhvzw=;
 b=mOxaxiE1YbQaLIU4pvvpNU4az2GTwO+gwfHQQHRfD2XWsvZNRc22Nx8W5KYupf321H
 FBw4uQH8zpdCqLzBUQCPhSo6FuqJsE39FEDO/reDhzRaxNNIY5Mjq1Pwr0A1+o6RBmU6
 UK4FybkYWE3Z+8+mTw6+QhBzFDNsgXc3Wwgryl9Nltf/1lb2xA3ckqdnM/uu4FKmV/Tw
 4l4svqzX0KU56vR4kHgve2sAb8FfMEsZgPaZru0ZW7jN6b21GEdk9dosmwMby5dXtFlX
 h1pu/htsaY8UhgfeAKhZrZx6DzI0rCMK+zOwOlM+nBqmHAYBa9V3qiYXQ8oyss/hAAR7
 +6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713790694; x=1714395494;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SEB7rrTLtp3+E0UWx6azHIwaCjR17UZYQGWqmUBhvzw=;
 b=Ow1+//3jIeGJzM49pfHih+QbiT/0s99/x08oaiRjEelgRkDSniL0JN9om+we6g3l7F
 SpikW2oC8VEjgGdJn1hZPpLxjL4tUbF2vCzSXvUaRefyN7o6TULnvFhGFLOdRpf8kFVA
 xEzusSlvzH/+dKVrD9eGdqxhd4MlI/4sL68+CWDTv+B3GBaPa58yFR7hb97GnPufxiPw
 pjrEEgJzCIyxzlN768YVtfSUIgfNXQKeZ9semAG8VWzSklIfp0SGFU9HiIUwidC+cb8t
 Dk7FwAbsrdfB3WcHsyn7VF41rFYVCaNySPMIPPDfWiIG0kouD91D9cUaBdPY61N6uatS
 nJvA==
X-Gm-Message-State: AOJu0YyV2uGMYRt0tuqxzJcPAzpVD0JsBg8n1wWVpAYMoAQ105f+3dMb
 O2RHS/V7NZR4faXnKK3CsxBLresYGCvi8+pQObqcO87aSg9GlMdnbxNXsKALQb7UDzLEK2Hjo5R
 w
X-Google-Smtp-Source: AGHT+IFW1UTXXwij4R8Vs3UUpmBBokzINWvRLjKm5S31UNlErxi5tweMFXcAKG6hedqOHPDdi0xYnw==
X-Received: by 2002:adf:ce06:0:b0:347:f94b:94d8 with SMTP id
 p6-20020adfce06000000b00347f94b94d8mr8864659wrn.62.1713790694546; 
 Mon, 22 Apr 2024 05:58:14 -0700 (PDT)
Received: from m1.home (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 l1-20020a5d4bc1000000b0034ae73a8b25sm4166840wrt.37.2024.04.22.05.58.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 Apr 2024 05:58:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Tyrone Ting <kfting@nuvoton.com>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Avi Fishman <Avi.Fishman@nuvoton.com>
Subject: [PATCH] hw/arm/npcm7xx: Store derivative OTP fuse key in little endian
Date: Mon, 22 Apr 2024 14:58:12 +0200
Message-ID: <20240422125813.1403-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Use little endian for derivative OTP fuse key.

Cc: qemu-stable@nongnu.org
Fixes: c752bb079b ("hw/nvram: NPCM7xx OTP device model")
Suggested-by: Avi Fishman <Avi.Fishman@nuvoton.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/npcm7xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/npcm7xx.c b/hw/arm/npcm7xx.c
index cc68b5d8f1..9f2d96c733 100644
--- a/hw/arm/npcm7xx.c
+++ b/hw/arm/npcm7xx.c
@@ -24,6 +24,7 @@
 #include "hw/qdev-clock.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
+#include "qemu/bswap.h"
 #include "qemu/units.h"
 #include "sysemu/sysemu.h"
 #include "target/arm/cpu-qom.h"
@@ -386,7 +387,7 @@ static void npcm7xx_init_fuses(NPCM7xxState *s)
      * The initial mask of disabled modules indicates the chip derivative (e.g.
      * NPCM750 or NPCM730).
      */
-    value = tswap32(nc->disabled_modules);
+    value = cpu_to_le32(nc->disabled_modules);
     npcm7xx_otp_array_write(&s->fuse_array, &value, NPCM7XX_FUSE_DERIVATIVE,
                             sizeof(value));
 }
-- 
2.41.0


