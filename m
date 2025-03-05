Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81958C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdUg-0002bG-PC; Tue, 04 Mar 2025 20:24:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdTl-0000Tq-5C
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:21 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdTj-00073u-FP
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:23:20 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso40736675e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137797; x=1741742597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/CnzfLPf8xf4AIvAaiMSlLZCOnCeYXV9atLF0rIWAMo=;
 b=FxAVF24YHZlO+GjDz/e+w7dyogpILrg9osDD728ihec58NCDMLhp+31HMlruxhsczC
 tvDjz1mkxmi27L8sYN6658A5rT7dmplp6T3YZjf31gXm9K+0szcv2tLa8LV/GJzYYeh8
 8XWhXMonIp+rMBooiij8iRgaU8VsyzCT0aHsbrTWYMptvTwusMExC0kYvAxaKLnaTHFc
 NBbLq1CMkqxk76/7Dwdi5yUTdY1hss4GOfJrcYdSCNgJpHoiNwStk9lYq/nUUafQrSPa
 ffn26hPHe4/nAtZxXY71v0xbO72Y5LCgs8R/i5q8YusCVgeLveAMjFa34/SS+01I3jwu
 NJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137797; x=1741742597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/CnzfLPf8xf4AIvAaiMSlLZCOnCeYXV9atLF0rIWAMo=;
 b=jourZ2djC8GxffWqSpH56w29i0RuUoi3rDlA59Y+di9j2HJ5wyUnUU9UHn7JB4VE8t
 NXGGwwzlkxnz8j4dCLlhMA7DB24pSaMkeJ0Vik4suG1kr2Fkyb5cS3Aqq2dvD8gMa8Vg
 OWY75dAU2CaWq+1Gzs2Bk6OblDL3JiTIDjJE5J9MzGvFGsEJnYobYIjtrxSkRd5JicQ/
 k+nMNsSPaio7Jl7sADD+WQjCf4m/p7ZED7LJL1jg35RUlVWtJ4IHWlBKUxRHEvQNeksg
 WjhgNO9ce/VN+E7ch8EzhEoRhh3Mnx4QrIqkXfNlp/n6GpOl3C0ezewIuYWtY6XRUrdY
 BYQg==
X-Gm-Message-State: AOJu0YxlqNjHA7xAh4zuGVB1nPTq1vQOICwi7Hy03MMaOWbJfhZLLMmv
 HHJuU3RDWZDJaDZ65X2Q2j5QYwBw9D8KC3gXAMnAcYkuK2RKJHuPVw5bzaTkS8X/M62VQcVgf20
 iOCA=
X-Gm-Gg: ASbGncvbKXmjFGR+pezoTj9xFd2pNxkZIt3WeQRXnAdUEKxYZ13lB6Cy80hAZ6dR7qE
 VlcG+w4tM+9x3PgdgdnbYhBr7LlUiYrfXNaut7tCESdUcmEYQ/8GiAX2H40ieRxpBwFx2YpxfXi
 Yktv1uV0V8pvEfAu90mDN/ODy9pA80J9W4GXcAFOjfCG7CAgvUQEaiaa8lIuTbjGAm7uO5rccWo
 k3S20VR1W+Mo/+0Q1Te7s0xLJIZ0XvZoEFcIS0PJOVUbamNq3XNPTNIG1sJCjoPijsZPQFR94Ld
 KftV3ADd+yjPMnWFksV7W9A0ger2pLs+UDIVMGvT5ye/LUiLKRllm/I8w2dpQgawt9MSGh15Nlp
 NGTUBHXVj5OhtC2TCwZc=
X-Google-Smtp-Source: AGHT+IFaCr2cj8q8mFa5/D2JsdT/Ae/V8MANJ9ca2dvHt/Mfrgxl9rMvvt03eV/Z/jkJpUl/06nWlg==
X-Received: by 2002:a05:600c:510f:b0:43b:cf12:2ca5 with SMTP id
 5b1f17b1804b1-43bd29bdf43mr5928775e9.8.1741137797615; 
 Tue, 04 Mar 2025 17:23:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd4310539sm1908815e9.35.2025.03.04.17.23.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:23:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony.perard@vates.tech>
Subject: [PULL 16/41] hw/xen/xen-bus: Reduce included headers
Date: Wed,  5 Mar 2025 02:21:31 +0100
Message-ID: <20250305012157.96463-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Have "hw/xen/xen-bus" include the bare minimal set of headers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anthony PERARD <anthony.perard@vates.tech>
Message-Id: <20250218162618.46167-7-philmd@linaro.org>
---
 include/hw/xen/xen-bus.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/xen/xen-bus.h b/include/hw/xen/xen-bus.h
index 2adb2af8391..bdbf1ed6fd0 100644
--- a/include/hw/xen/xen-bus.h
+++ b/include/hw/xen/xen-bus.h
@@ -8,9 +8,10 @@
 #ifndef HW_XEN_BUS_H
 #define HW_XEN_BUS_H
 
+#include "hw/qdev-core.h"
 #include "hw/xen/xen_backend_ops.h"
-#include "hw/sysbus.h"
 #include "qemu/notify.h"
+#include "qemu/queue.h"
 #include "qom/object.h"
 
 typedef struct XenEventChannel XenEventChannel;
-- 
2.47.1


