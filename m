Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52461E7719E
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6K5-0004DH-0B; Sun, 12 Jan 2025 17:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6JH-0002Wt-56
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:19:56 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6JF-0006aY-Mn
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:19:54 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so26191985e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720392; x=1737325192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6igD5E/nbtwSQ78SmLcXDRAtrSWvkZ+A6IpBZtctTjk=;
 b=IsABqRQEF9txkWLm0Tg8XvN+2m0qLFM+8OyS8GxgH4Lo/AcIHsk6Eb9X5/tCiOo07Y
 PrIvWLZTaDSz2Sw2zmlkNWYoV318DA/BqcbZ/OOv66MEuCAvMrTkHoy9vQ3qdXhE4iUM
 xlJ0gVyRCjX+yaBgvgfClp6+MsG+3J+n8jAmJJu304Mi9Ez5EWDRKJfyNWkZkM7gOFUP
 azhxx+2BkmJlg2u7AsmRvpiATJ09USLqo+V38FxHY2asgeJ8d6RhhYUR9QxP6Yng02dE
 5RQgpRRku9DTPLQ6N8M6Cs8CsNpzcbtRh6RFrb3uBWzj7NCI61luFncU24RxVQc15uuV
 wpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720392; x=1737325192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6igD5E/nbtwSQ78SmLcXDRAtrSWvkZ+A6IpBZtctTjk=;
 b=NU5DyftATnFATFJOLo3k8d1CyQ7JeMFjaO7c+LUXvSljIhBuean0SdSpfsL0Pxca2y
 1Oiq2H2bDUhfUhwCfpMLPhPYMK/UmOQzUUnJQVP6jkghWYZU9sAEviAzC+S8tV0YKfI5
 QDPYZ7QsBZ8VXbW4ntVOwyvk6iXaqIqc56HlU+Y84pt+cgRNs4qG18eyoPEB1l2uUf5A
 jzRgdcnvAE79CAmIAK3J+F8r9OiOwCrs8krYv4GlbQP/ZgVY6OC0+nzq9A0RAImDC+Tx
 cwzmDrV7yc/aobUU5XZg0x4r7I0SsFb4oKoCzbo3dbXapPAsidlPlZjeNYdy450Ijg4O
 6b8w==
X-Gm-Message-State: AOJu0Yw9mt//hJB09a9qH6+gim3Q85mFhIY+/mfuavbXM65GbMAIudnj
 SQ5V9EysHB1JWMxzZ/o+CKDj9De/4/PzkjaK9iylv40x7mQRZJt6cagGfLp/PYNSLvqswoB1KYH
 2sBY=
X-Gm-Gg: ASbGncs0rnUB6DdNheumN1hR3mfGN0XfpxPLhdro65YwOx7XW7DeJ1UloY8WPGfpDH8
 XcqtL+XPP8kHa/ocbWaciZ3c/LnIT3Ga2bqQf/sjrxtWDR4sX1odEU1ZQDNsFE7/Jre8TF79XV1
 stwm1HhLsV6ZKEQwFVPshCAAM5TIm6r9sTkQnn1tnDh7IvSKWjb9g1O9Pvn+uYnSBkxOS+Weowo
 bH2zuU/UHXkGQD3RnAGLCXkSjn+HYVqm2fQZKU2tQ6IA4+66Zn1lyRNBvaAhV31KdVs1Lt7uJmj
 GzK3OcfbxZwKSF4QeJu7JT3pOE9DC+8=
X-Google-Smtp-Source: AGHT+IG225P8aOr6MKdzG1E4vNkut7SC5zr4OTLDFvMhToLX/q9PYBCa3sVrFd9d0TPAyrrF0H2new==
X-Received: by 2002:a05:600c:510a:b0:434:faa9:5266 with SMTP id
 5b1f17b1804b1-436e26adfc9mr164276005e9.13.1736720391870; 
 Sun, 12 Jan 2025 14:19:51 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e384f2bsm10504560f8f.41.2025.01.12.14.19.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:19:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 29/49] hw/timer/imx_gpt: Remove unused define
Date: Sun, 12 Jan 2025 23:17:05 +0100
Message-ID: <20250112221726.30206-30-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
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

From: Bernhard Beschow <shentey@gmail.com>

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250108092538.11474-11-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/imx_gpt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index 2663a9d9ef4..11eca9fa4df 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -20,10 +20,6 @@
 #include "qemu/log.h"
 #include "trace.h"
 
-#ifndef DEBUG_IMX_GPT
-#define DEBUG_IMX_GPT 0
-#endif
-
 static const char *imx_gpt_reg_name(uint32_t reg)
 {
     switch (reg) {
-- 
2.47.1


