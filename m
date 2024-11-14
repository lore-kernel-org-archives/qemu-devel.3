Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F83AD6A22F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 21:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgxv-0000ZU-7w; Thu, 14 Nov 2024 16:01:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgxZ-0000Nn-8C
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:01:01 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tBgxX-0007zZ-IJ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 16:01:00 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37d447de11dso18963f8f.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 13:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731618054; x=1732222854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wG+1NC98eSptDZUHUCzND7zjX1Tqst1VgWsS8j/5siQ=;
 b=PLHF8DTFh4adtJPQ+/g9H9pbrTPsO8PfRFaNY6YPGJMBGyVsFqplpj5TfPGC9pFS7S
 CsR1SJERx0U33ypYV7nAgco0w2rlUCUJTkiIMGjhp08Yf3oePBBZp2lc3Nj7k+JDGgCH
 jkTtZ3CI7BFThD4kyF/H/dhxBw0jzsORCcP7xDHJUKt2630PTD14jq7zTB9eMY/3RxbF
 /l7FjwLpvQjsbd9qJ7pBSIALS7UWmC3SRnrqYjAr11QKgrKR3jaidxJy73QiK8S4AR8U
 y0lnbfp4sAQMvdsgtsgnq5zYxBeK/3rVP4H1lWRm9tsOVISIwNiBC7ehCPtc2BnaDl0N
 YYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731618054; x=1732222854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wG+1NC98eSptDZUHUCzND7zjX1Tqst1VgWsS8j/5siQ=;
 b=w0XnlEeIQN2FLAoTVCaDFf67TjfAVhXdvYioNaDc2asmycfNqwWhtkIMnkx2Pb3v5v
 IV59MRZ0s2CjzoRZyDHIp2Kq7rLesHX8m2Uqg8muT6yb8OWeykiLh14Q6khaYtDQCHsZ
 l8yUDmAnf4XPtc3GJkMIyNMdoo2inFYEsJaDUHXv7zbUvjhH0Ryhq3X2nW9ZoJLjaVvh
 XiFkoep4jYWys8L5VInS1O+neMWcm3iNTb3f7K7ARxyIlbcp7DQG+C1EySYaYgZC6LeS
 3oeLBtID8Ngc+JkBVU6GrNfb0qGNHmAqjeChBJ1L58ZxSiiXj8OSENBwxBcqHxAiJx1D
 0qrw==
X-Gm-Message-State: AOJu0YwoSDYx4OCdTBbajn+x1TtFmzexdf/Mx1TpaRzA8ZmawtkrPmEs
 vPtwNzL7KbRuHZ8dOQWlgQvJZnrqlTSx7Y5eGU00say+c7NufvHg/NmYNMCanSyhL8C5db8iRsQ
 E
X-Google-Smtp-Source: AGHT+IGqSaGX9Gi7Y8t8eoIxlOllx0jqc/rAVgGASv43On4vQnTlMvmlMrnZwp+rKE7Wkboo5wRKFA==
X-Received: by 2002:a5d:6d01:0:b0:37d:4d80:34ae with SMTP id
 ffacd0b85a97d-38225901fe2mr147742f8f.4.1731618053653; 
 Thu, 14 Nov 2024 13:00:53 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.228])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821adbbca7sm2492439f8f.47.2024.11.14.13.00.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 14 Nov 2024 13:00:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Bernhard Beschow <shentey@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH RESEND v2 05/19] hw/net/xilinx_ethlite: Correct maximum RX
 buffer size
Date: Thu, 14 Nov 2024 21:59:56 +0100
Message-ID: <20241114210010.34502-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114210010.34502-1-philmd@linaro.org>
References: <20241114210010.34502-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

The current max RX bufsize is set to 0x800. This is
invalid, since it contains the MMIO registers region.
Add the correct definition (valid for both TX & RX,
see datasheet p. 20, Table 11 "XPS Ethernet Lite MAC
Memory Map") and use it.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 0f59811c78..0df962cd22 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -3,6 +3,9 @@
  *
  * Copyright (c) 2009 Edgar E. Iglesias.
  *
+ * DS580: https://docs.amd.com/v/u/en-US/xps_ethernetlite
+ * LogiCORE IP XPS Ethernet Lite Media Access Controller
+ *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
  * of this software and associated documentation files (the "Software"), to deal
  * in the Software without restriction, including without limitation the rights
@@ -33,6 +36,7 @@
 #include "trace.h"
 
 #define R_TX_BUF0     0
+#define BUFSZ_MAX      0x07e4
 #define R_TX_LEN0     (0x07f4 / 4)
 #define R_TX_GIE0     (0x07f8 / 4)
 #define R_TX_CTRL0    (0x07fc / 4)
@@ -195,7 +199,7 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
         return -1;
     }
 
-    if (size > (R_MAX - R_RX_BUF0 - rxbase) * 4) {
+    if (size >= BUFSZ_MAX) {
         trace_ethlite_pkt_size_too_big(size);
         return -1;
     }
-- 
2.45.2


