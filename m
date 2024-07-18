Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83264C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:39:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMfM-0001sz-PN; Thu, 18 Jul 2024 04:39:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMfK-0001kW-IS
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:39:06 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMfI-0004gq-VO
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:39:06 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42726d6eca5so438475e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 01:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721291943; x=1721896743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f3KoNavigW3dLA5bJeMlYDVs2sTflgXH0yz8/6ddF9M=;
 b=jJ6NRMEL9aN438Oyl77lWeKfJ4wY2w85qHurhCkqTr1aOFcpbH+O/uDPfAzz0qLc6/
 /IldDQr6LhgDQUg3JFIdYETEzL0dcKDgP8uKeFsMAkmT4whyJ5jbKL3e5LW+r+pZBMp9
 FXMunO26OVKZBsrrDFCT3dwk9uB+DUZvXv5I1UrvGWlsBfauw0DW3+Lf95QHNF6nE3Rj
 pdZdQO1aXRDGs7ldG6JYvYkLOrkgZaLHKMbswGDI9FCgTga3kD/9pZ228P/eszaq+oXT
 KB+Dl6o6fd2e1Mr+IxAQbWl8NjgkVuuTDviSoj61k1xqSw2IoI5Cq+5eEA1KjXzEqBh8
 3KVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721291943; x=1721896743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f3KoNavigW3dLA5bJeMlYDVs2sTflgXH0yz8/6ddF9M=;
 b=Q7b7koxh4ZoZzGBrBxWKiBzux/JzwIbOfYLYrIAV3ppiitR/iMJKSIy/VP8+Ji6JAr
 BtizeFz2AixM/JYhDkZ7Tp2DI3Q4LcdewGDh0WrQXAXTlhNKY5QLwgZvqNz+XcXiV8pH
 tFWRN4S6BqQZjUUEVtZ1nJItEPthCVfegaNxik/RPVu1zL/pKMxmQjkpUMvfVT/ykysm
 QgW0sA40qSfguS+mv/xA45TSKLCxlfziG+9orRv87T0Rw5wG3E3xMDbDLa8uf6PZH7wO
 Hf8XA/WeEsmsBLPEweQzrkv+2V2/rXP+T+ZHm3vNqciOdnEUKXslAWmpZtt7LkwEZCjQ
 aqOA==
X-Gm-Message-State: AOJu0Yxm6YgU+tYGkzv9sz0TihMSSfVRTd3OfpxddW5fXaMxJIQaqMGA
 1puAQCQE8fmxLd7e806Gm4PAxAscnoOr4mv6SC0iXxs8k9zkIUB1b1Zwm6NImGeYc6i0HJ/EoL7
 qGqc=
X-Google-Smtp-Source: AGHT+IEqxbTsbtb80tXDcnG9f/121c3zAda2XNgdiJ4avRfM/suARUbLdSTV4sk6aK8t8iOrLLiAdg==
X-Received: by 2002:a05:600c:45d2:b0:426:6241:5eb9 with SMTP id
 5b1f17b1804b1-427c2d00746mr27220735e9.39.1721291942972; 
 Thu, 18 Jul 2024 01:39:02 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafb9aasm13592658f8f.67.2024.07.18.01.39.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 01:39:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 02/18] hw/intc/loongson_ipi: Access memory in little endian
Date: Thu, 18 Jul 2024 10:38:26 +0200
Message-ID: <20240718083842.81199-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718083842.81199-1-philmd@linaro.org>
References: <20240718083842.81199-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Loongson IPI is only available in little-endian,
so use that to access the guest memory (in case
we run on a big-endian host).

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Fixes: f6783e3438 ("hw/loongarch: Add LoongArch ipi interrupt support")
[PMD: Extracted from bigger commit, added commit description]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
---
 hw/intc/loongson_ipi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index dc82caea0d..d315f6f303 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "exec/address-spaces.h"
+#include "exec/memory.h"
 #include "migration/vmstate.h"
 #ifdef TARGET_LOONGARCH64
 #include "target/loongarch/cpu.h"
@@ -102,7 +103,7 @@ static MemTxResult send_ipi_data(CPUState *cpu, uint64_t val, hwaddr addr,
      * if the mask is 0, we need not to do anything.
      */
     if ((val >> 27) & 0xf) {
-        data = address_space_ldl(iocsr_as, addr, attrs, NULL);
+        data = address_space_ldl_le(iocsr_as, addr, attrs, NULL);
         for (i = 0; i < 4; i++) {
             /* get mask for byte writing */
             if (val & (0x1 << (27 + i))) {
@@ -113,7 +114,7 @@ static MemTxResult send_ipi_data(CPUState *cpu, uint64_t val, hwaddr addr,
 
     data &= mask;
     data |= (val >> 32) & ~mask;
-    address_space_stl(iocsr_as, addr, data, attrs, NULL);
+    address_space_stl_le(iocsr_as, addr, data, attrs, NULL);
 
     return MEMTX_OK;
 }
-- 
2.41.0


