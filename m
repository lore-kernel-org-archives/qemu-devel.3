Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398A5E77194
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 20:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSimI-0003PR-KH; Tue, 31 Dec 2024 15:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSimD-0003I9-Bx
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:23:41 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSimB-0000tY-L2
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 15:23:41 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso34026835e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 12:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735676618; x=1736281418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xgwd1lvGYcpUC2JHW14mBK9dwBsC4XtKSYjNzKqRdck=;
 b=swnWsqVpbC7q9SXuk+BhApyDoHAombLyxiuOKTaRDIpVj3m+tonAAvS0BeQ7ORvb/o
 YKbRcXNvcK9p8OCKKdjSjU6/YSpocaZE7city17G+boeBApnE7uRZ1ue1geqikcvq6RT
 WrPXH4/GgJQMmW5YBbGJv87DIltoqwwhwjfp6fysPFndUeg+JLHIeA9+6/9i7mrNZq5R
 1OyWyQMgTJV3YXIJwHLwzrQGifP/wo6YtLqS9xesKR7sXKLPqXOpKH8b5zoQ1bju78/m
 uyHu9lgZ1XrZ1UxJIPrr1eT1R5wUgRlAB2bSDuGqLUcspAArAefjYYH3JEhRsNX4mCuz
 6y7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735676618; x=1736281418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xgwd1lvGYcpUC2JHW14mBK9dwBsC4XtKSYjNzKqRdck=;
 b=sQ5J3HX27EYAO15giv9bNrY9OmzVSnDKniuQrt6CTU9ukpOWo0EzADYIvbr97V8zrh
 w2cV2eKQ1NttO919eZ3oJAbWy4XAVnetzzTjln7tkKswBwX8IM3l1rvky4NIyKhOyybe
 28wb/af0+AYXF4njTc24JsGN2Bq+PKcyCuDhcEE2fIKj1NIYqdV2LsG0B3t5AAW5Wqvd
 KjzZE1sm2oTPd5KlUmjlYJdUJgyIMJjBOiYbVivoupG5zzom/SPM2AkSrbZaf3y5AYx9
 Tx2AbGzBNRckjU7v83DrSQBrsFAyqjpOIGMiT1nlMXewvVtcBc5q5up/CLp2HnmLkGwk
 jBzw==
X-Gm-Message-State: AOJu0Yynew9JaRbS1SFhptsEiCOFnj/pD4HXzXTMyEtmzb5g9OsF05ou
 NzkhUamzWLhrPeJyLk429DVLk8CwRHm2roKK8F1B5y670WtTnweujZp+NNV0CkRJSrgqG7ov+Sg
 pYTI=
X-Gm-Gg: ASbGnctFtRutHoqT7O4CSRfRGdiGNR2bJ4NwM41uUMnVNGc7Yt5SvUyhMnvgxchGJmU
 fU+WBEr48KAhZMLghlsWElcKIKwY4h7NSleg+GndCnoYnx6eYVVvlmb0oTBX42+OaBCZuR8ESVC
 L4SWxStIBanEkAT4fc/WOiqPysZwC2Tcu0UAZ+f92WEFNuvrKYE7M37TcTNDMgnp48kdWY3oppG
 iV7EuVVJGlhyBHdekTY4rch5TAYIUbGp8LSZI+RlSgYN2zOnCb9CqDp9CxScvvmZoRPvjS5fGfG
 orwTi9JhWgzBjNd/a0aVicrvA0dAEr0=
X-Google-Smtp-Source: AGHT+IFbsCPSSsGZU6KzWTaKDeBVlSRj4HU655UAz8UXKd88AbSHFrFQXAoa85NtX2bFQnDlAS0IkA==
X-Received: by 2002:a05:600c:5129:b0:434:a04f:2557 with SMTP id
 5b1f17b1804b1-4366854830cmr331283735e9.4.1735676618022; 
 Tue, 31 Dec 2024 12:23:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611ea487sm396406505e9.8.2024.12.31.12.23.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 12:23:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PULL 14/29] hw/net/xilinx_ethlite: Correct maximum RX buffer size
Date: Tue, 31 Dec 2024 21:22:13 +0100
Message-ID: <20241231202228.28819-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231202228.28819-1-philmd@linaro.org>
References: <20241231202228.28819-1-philmd@linaro.org>
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

The current max RX bufsize is set to 0x800. This is
invalid, since it contains the MMIO registers region.
Add the correct definition (valid for both TX & RX,
see datasheet p. 20, Table 11 "XPS Ethernet Lite MAC
Memory Map") and use it.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20241112181044.92193-6-philmd@linaro.org>
---
 hw/net/xilinx_ethlite.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 330dccb83df..d54f96df243 100644
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
@@ -191,7 +195,7 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
         return -1;
     }
 
-    if (size > (R_MAX - R_RX_BUF0 - rxbase) * 4) {
+    if (size >= BUFSZ_MAX) {
         trace_ethlite_pkt_size_too_big(size);
         return -1;
     }
-- 
2.47.1


