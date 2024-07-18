Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014C3C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sURHQ-000260-8N; Thu, 18 Jul 2024 09:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURHF-0001Yj-NV
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:34:33 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURHE-00006I-1F
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:34:33 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3684e8220f9so407110f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721309671; x=1721914471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mHLT+v60vx98P/4HziJkcSe5PukgkqBtt1Cd3ZIp3go=;
 b=wCBkoQe3eAVtX3faaYHqCPtkY3voN8kx04ojrAR3QZ9jPhC2iKEHMOyJSX8o7oFHTq
 xZljE9Xb+1JbDN3b4aY1kheCU4HaTeMh9y3Q8Sz6ai/DfLPWDhRRX03p6gnoNRIxD/0P
 S+kq7Wot91+jQLppqFiTy3yoIGaT1YLW0d0oYrCaDyWVB9EZUbU46gacKVXaYQ4fq/VB
 1Rn2Ja9wGDhTKHZ17fZKb4QcSm1mj8sIc6yeysmBXbY97DPn8MvLHdOHiJX26o7XEyIy
 CH3MSzKJ3opVs6Mig/OGgVhuitcH3GzLU9btpHghQ6SOf+WayQFNo6BsBKa7pdkXxVrx
 quFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721309671; x=1721914471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mHLT+v60vx98P/4HziJkcSe5PukgkqBtt1Cd3ZIp3go=;
 b=FsO862G+xDiRYiXcchcNybCFqYSlDjlEq7Nbp55hRnuN5YcaghgerfXZi0lPo+Xa/y
 WgSQWtmpE0kp+yX/+NbJVU8Ou9FByrmaLdBhjqFWpGYCKMMYFYjr0AgzYzkPZWiDyPv1
 jl2n9zEGDq/2BwB8uV0stkXxszjuFalu00qRpqlIR+c92OaQSrjLNSq8JkPfSfM2WKNj
 s77HLgrm80P6gghZo70v1ATkuFXLUhukbNQPH2X+Fi7EbeXdtwuUFaG9JsRgfbCi4blQ
 X9KFN3Jb/4aL8ZWEUJRxQ9dr+GGcXMIU5IG6pAT9CaJbeCYFB0I9MnFN6TUGeRgEeqFQ
 2WVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU60FY/17aXTCS0d4ZA3Pb9ui+z/BF7xZd4Np2MisM37kjekI9aTfGEt7Q9JMvttFNSpVYnnrVbwf+bwJ95Q5N4yt8C3Do=
X-Gm-Message-State: AOJu0YxBvIyjCLkdujCd/We9tqZyRj4dFmqi/G4Z7N6K1Wr80SZJ37sr
 d93XZPM5ySsKgnmwghuxclh222ontb26kGydYVOIje+6T7e8Lyf4lxonVPoJc84=
X-Google-Smtp-Source: AGHT+IHKAba/raOzMdHPVjdztftHkHevLD3ON/x08ynOWuJfc/7fe9mPv4NSYS5fYXiC/Dy49jFIIw==
X-Received: by 2002:adf:fe92:0:b0:367:940b:b662 with SMTP id
 ffacd0b85a97d-3684b3c82e8mr2297763f8f.31.1721309670558; 
 Thu, 18 Jul 2024 06:34:30 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680db0ee46sm14264104f8f.114.2024.07.18.06.34.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 06:34:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v5 13/19] hw/intc/loongson_ipi: Expose
 loongson_ipi_core_read/write helpers
Date: Thu, 18 Jul 2024 15:33:05 +0200
Message-ID: <20240718133312.10324-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718133312.10324-1-philmd@linaro.org>
References: <20240718133312.10324-1-philmd@linaro.org>
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

From: Bibo Mao <maobibo@loongson.cn>

In order to access loongson_ipi_core_read/write helpers
from loongson_ipi_common.c in the next commit, make their
prototype declaration public.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Song Gao <gaosong@loongson.cn>
---
 include/hw/intc/loongson_ipi_common.h |  6 ++++++
 hw/intc/loongson_ipi.c                | 10 ++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/hw/intc/loongson_ipi_common.h b/include/hw/intc/loongson_ipi_common.h
index 5447e9f650..a75882f775 100644
--- a/include/hw/intc/loongson_ipi_common.h
+++ b/include/hw/intc/loongson_ipi_common.h
@@ -10,6 +10,7 @@
 
 #include "qom/object.h"
 #include "hw/sysbus.h"
+#include "exec/memattrs.h"
 
 #define IPI_MBX_NUM           4
 
@@ -44,6 +45,11 @@ struct LoongsonIPICommonClass {
     CPUState *(*cpu_by_arch_id)(int64_t id);
 };
 
+MemTxResult loongson_ipi_core_readl(void *opaque, hwaddr addr, uint64_t *data,
+                                    unsigned size, MemTxAttrs attrs);
+MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr, uint64_t val,
+                                     unsigned size, MemTxAttrs attrs);
+
 /* Mainy used by iocsr read and write */
 #define SMP_IPI_MAILBOX         0x1000ULL
 
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 39bcf0031d..a2db8bb2e2 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -24,9 +24,8 @@
 #endif
 #include "trace.h"
 
-static MemTxResult loongson_ipi_core_readl(void *opaque, hwaddr addr,
-                                           uint64_t *data,
-                                           unsigned size, MemTxAttrs attrs)
+MemTxResult loongson_ipi_core_readl(void *opaque, hwaddr addr, uint64_t *data,
+                                    unsigned size, MemTxAttrs attrs)
 {
     IPICore *s = opaque;
     uint64_t ret = 0;
@@ -165,9 +164,8 @@ static MemTxResult any_send(LoongsonIPICommonState *ipi,
     return send_ipi_data(ipi, cs, val, addr, attrs);
 }
 
-static MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr,
-                                            uint64_t val, unsigned size,
-                                            MemTxAttrs attrs)
+MemTxResult loongson_ipi_core_writel(void *opaque, hwaddr addr, uint64_t val,
+                                     unsigned size, MemTxAttrs attrs)
 {
     IPICore *s = opaque;
     LoongsonIPICommonState *ipi = s->ipi;
-- 
2.41.0


