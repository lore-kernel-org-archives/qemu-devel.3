Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92613C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMgs-0001op-BD; Thu, 18 Jul 2024 04:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMgg-000130-3s
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:40:30 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMgd-0005FH-W0
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:40:29 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2eedec7fbc4so6998521fa.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 01:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721292026; x=1721896826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6UPq27AY4GIf4EDDpmU+ZO9tTp1hi1LFdlwBIRXsUDE=;
 b=d3jthEd5Co/UPul0LFOTpB/Q2CXBGc+HQj8OU66S4MyiUkNDo+ME83vKLr5imAxQw4
 6EihMxbLYl5FZsgD77szE6uLZ8uZXzhTdOUWe/axHQz2vE7meaC+DkK9MVj0wAxdA+Cp
 6eo8IQC/AceCNuXbRPdOoALM7+zqHYGZMSYLOeAec2lyXHU8zaK3mEySh47V9rQITS7J
 MUNW2mtK58Qdy7u0d6xX53DVtgMn9mNqf6Zi/5jPEuuvFZdMl1tzN/DHCJFdWy8DYiME
 +T0RfUPb0xzu3rBJ3Ax+pMWZqg3DSIf5+rM/Ls+tmzsQluaE3YpJNxju5Zo5qdhqMNpG
 nDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721292026; x=1721896826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6UPq27AY4GIf4EDDpmU+ZO9tTp1hi1LFdlwBIRXsUDE=;
 b=tEEMG3mMMfvLDu3BYgwd3t7NBPceGHVxQO+oeD7ygDzNlVkxzKGOvy5YvrmuI4ZY5L
 ebamtuRSKNq2fhY6U+x1gZoxGqUbJMXRNXj7pTf917qLa+OqNjK/DbPW0GV5yX9a6zgo
 8TEBiRM2Im/+iCTwdIDxfnIQ5jcnV9Q6zfvFKYiROwnes+Rw7obcGHef1e5dLI0zrBQf
 M+OE3MrgvIoSDYtgT/eAZgIgfYnk1xaOoOGxgfaNmjSTP+NtnV24IF+qkQ4r61nsawIA
 fRuKeLp6cRMc8zUDQcBpnI1edEVrP/1iZdFIZxKMzkyGbg0T1NcsxwCh13SEoYmVwEQW
 ViIw==
X-Gm-Message-State: AOJu0YzvXmshfV34IOInabjKHgP3m4s2Jeb+gHkci8N++z24WLvSHd9U
 hJurcQxLwbelh7mEA9uUhi39QlhMvHXQ/Yrp89x/piYMgbsXMO8mirej7DURjSHc8TsFBr5goJU
 wEc8=
X-Google-Smtp-Source: AGHT+IFBMyZTCxeegsTo/qd6LmWQFfXX0yrxyt+vgwkyXVPKUEXa5zvU5nYvjlm8OwSP/VwiWNT2Bw==
X-Received: by 2002:a2e:9888:0:b0:2ee:e0a1:c496 with SMTP id
 38308e7fff4ca-2ef05c57438mr11915131fa.9.1721292025720; 
 Thu, 18 Jul 2024 01:40:25 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a9ff5dsm2018875e9.0.2024.07.18.01.40.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 01:40:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 13/18] hw/intc/loongson_ipi: Expose
 loongson_ipi_core_read/write helpers
Date: Thu, 18 Jul 2024 10:38:37 +0200
Message-ID: <20240718083842.81199-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718083842.81199-1-philmd@linaro.org>
References: <20240718083842.81199-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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


