Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B9CC3DA63
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sURGE-0003OA-KR; Thu, 18 Jul 2024 09:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURGD-0003Lc-UO
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:33:29 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURGC-0008Qs-C9
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:33:29 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-368526b1333so371016f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721309606; x=1721914406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ms4f5OfzFZYNwxaY7U7GVqyRgrfCUCWkkMxGuFg0vIE=;
 b=L4spQmzbV0z/gOxfSWRxoFq2S6iB71UoVmXCKW0XgLucvjOLIfZKfMu7EmcNVSChQZ
 fGIQAeTq3GHVALgLTUdv02lmDftqSlkWYhyAVVjpxTzLCfWNJEzmffoHOl6CYysSsSp9
 pEaoDwqSzYxHp3ef1PRm3F0ALLWEi9FGAiQODknmsSaMtlu3BrgYN7VFSGwNFWO4MN5H
 gKy0o3J65xIzgG/T86ttCYbNyvJNoT1Hi5EabcI4j/BQDBLRC0xjvmt9oBGq9UnstnSA
 pGmcudnuSPVyQ/WHuVunBSZeDAp8zMoc5JN+Wtp2dk9Kxyvijy0kjzWBgAvr7B6EBKtf
 cS2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721309606; x=1721914406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ms4f5OfzFZYNwxaY7U7GVqyRgrfCUCWkkMxGuFg0vIE=;
 b=FWstM99b/bjMlzOrw0r3e5rJdIG83irEkrBWjqOrMXDaAfbnyl56eFCcH3OvwmSEBZ
 EeHa4Vf2axgcg55UNX3NaOVZISp2ZLjEQ2gk16PgqqGZJPlLDfuwxBmmXxv0dWkETKRI
 PcYgZN6LDlcyrAE+iEdxE7zLYzd1fzYHNonAxYs+yOxJpihE2YN5g2jA4+NdPVoNKOob
 njLdB3qN4OJhrSEqHWM4F7F85WxWWmVXAyVXh3nWpTDW4uboLEIKzWqJLBZF0r3U0yyD
 45qSMOSxxkR2YpfNt4rrdIYactKsWWnCpCySUUzZJLtIj7Pq6VighNKJqkY+YxPueYAs
 MR5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0z3EJqtIgw0ZPB/CQynLp7gdHfMJRB8UiCvOLHiM5eoXcMP5CQ63AD01CEedFy5z3Z7jS2n/NBtUzNStgQ09w47JWyIc=
X-Gm-Message-State: AOJu0YxBic3dngi1mXf+KkFBDAQgID6ldewr3BrGi8eqhiqX30lKBc0t
 vV0onxLCEhgya+SPkV7cWtqeOCL46UF7l7xpnPQD/nVeW8dT+NVeFFitbUQlKY8=
X-Google-Smtp-Source: AGHT+IHamvtjHk7sV6d/a3ljFKi8iQqbYjk1DT9P6Y/g3yEoauuE9DCfFBHLmqcP5JlE+G20AXRQIQ==
X-Received: by 2002:a05:6000:ad1:b0:367:8e57:8 with SMTP id
 ffacd0b85a97d-3684b3e359amr1905635f8f.19.1721309606455; 
 Thu, 18 Jul 2024 06:33:26 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b1e211sm13553865e9.23.2024.07.18.06.33.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 06:33:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v5 02/19] hw/intc/loongson_ipi: Access memory in little endian
Date: Thu, 18 Jul 2024 15:32:54 +0200
Message-ID: <20240718133312.10324-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718133312.10324-1-philmd@linaro.org>
References: <20240718133312.10324-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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
Acked-by: Song Gao <gaosong@loongson.cn>
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


