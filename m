Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4746C3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 21:49:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUCVz-000481-Fh; Wed, 17 Jul 2024 17:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCVx-0003ql-FR
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:48:45 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCVv-0002O3-Q4
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:48:45 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-367993463b8so79990f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 14:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721252922; x=1721857722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5RH2M9sCamaZBN6RONegOmRyzG2aIRG+ketvR+2FtGA=;
 b=z1zK8cOVpZAwZzGY9Y0kW8H1hHHW+VAN9x/HDtBxSjkiunqcAYaeicbP4L6YZ1S2lE
 nJAEnT6Yg+VzJdpPZ2b0W7WlWas0+1fSSGCJ5KZdugut6lfKhyE2nE5tUjDz42sJODMz
 UQ2mQMADBWwJlUiAM0XV0aaJEtpujnc1L+21P6KLkhUKulScpHgtelnDtG1A8+cUPEJ9
 g7fj04fu70cC96uDi0pVheR9Z67nLwumKq42/hykn9lFxxVs6ONjNaOVMg4QbN1PZBh9
 n93Y+KpEaxQfaK4z/oZR59HWYYUtKpZ8/Nn5m6BVSOgdA6uoolZw4DuaYMOB0v7UXjMt
 30ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721252922; x=1721857722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5RH2M9sCamaZBN6RONegOmRyzG2aIRG+ketvR+2FtGA=;
 b=fYPPbv/Vn18plfOnzmmgWNXh8qv1r6THDKmZdUG4Kp19AsS+qj1woMPnuhTB6x0zTP
 68eO9I2hzu55blmwL3rYmzoxnlQWLdZ8BAzav4n8Y+s1aN4m+UWjazsu1nB3cQxouTPd
 ufz4SuVjPxuVXzByGseuMQ0HX+OZg57zPXOVMIOlJUajr6cffbT0TNXaT1UHhykmVUEo
 28W8Emhz51IW1un7b22LhAcdxqwq1t5Vd/DzcgGiKL46oUzZYP2BqN92F9acWd76o/27
 beUBbr/JpkAn95LyQMRQJ5Nr7fsE3ESTgWTFQ/ESB5UnCfi9bVtsStYHD+ctryRF577B
 mCIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDySLI4NVn8xzC/a1Cqx2uk1eB8ib7vR0My5iWZDC5fZz7lrq6DTNCRerP4cbWsb+2uuW6hb6IHMAStSzgbupKFtcvJu0=
X-Gm-Message-State: AOJu0Yzy6C0h2Ve6wLAmetpZltPKepYFfRCehOHQIdHUbVYfr9m3ff0x
 Oy6WaRSiO1UqORUAW7xqAXMPcjaZ9OeH7BDZnB5gwEtc0WIm3n/hk/DiwtXH0jyZ0hFGxv1nXlV
 2uFY=
X-Google-Smtp-Source: AGHT+IGtBuUdpkC1n3jJL/YbwUxSk1FzfCH6RjmS5oNzBnhNjGPDvGFcD/An+ocgFm85FOGjXcdJEw==
X-Received: by 2002:a5d:58e7:0:b0:367:9765:b2ae with SMTP id
 ffacd0b85a97d-3683179cb2bmr1878043f8f.61.1721252922356; 
 Wed, 17 Jul 2024 14:48:42 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427c7840f95sm11377595e9.29.2024.07.17.14.48.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jul 2024 14:48:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH v3 12/17] hw/intc/loongson_ipi: Expose
 loongson_ipi_core_read/write helpers
Date: Wed, 17 Jul 2024 23:47:03 +0200
Message-ID: <20240717214708.78403-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240717214708.78403-1-philmd@linaro.org>
References: <20240717214708.78403-1-philmd@linaro.org>
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

In order to access loongson_ipi_core_read/write helpers
from loongson_ipi_common.c in the next commit, make their
prototype declaration public.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
index 603a88356d..227fd667d9 100644
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


