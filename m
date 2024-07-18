Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69DAC3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:40:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMgE-0005Zh-UO; Thu, 18 Jul 2024 04:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMfx-0004vU-L9
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:39:48 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMfw-0004kk-0i
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:39:45 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2eec7e431d9so8921371fa.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 01:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721291982; x=1721896782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8Tl+7b0JNXSy9A0pi7Y44qc/CIbAMFsiRwjgLhCAc4=;
 b=UfM+p+2B1U38qahuoie+3vb4qoP3MYCsESbh5klEORyVcvN0WgUwDz1d2tlHelRYaQ
 JoWm4N+RYboU3JxX7RrKtaex4zprs0RE7EZZ5RykW60J/c1yEPOuHAVRljB8kxQGIMCZ
 i75BsC3QGL66MVicLLs0ZciSrJJZyJApdqSBS3QF5C4LjjJCFB0EQx/lrWRhj05jBOUH
 zKYnQdIHI7FqhEuDR3p2NDtO1rg0TRoE3cRQkazPlSiZyqtR9cBk3Y3DR5drhVuvM7om
 NT8hMUuyEwno0Ti4qRKf6zfv71BKhiCC2eXH6icSdpbHCYw0b0VAhrCEJlGljivPhWeB
 xRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721291982; x=1721896782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J8Tl+7b0JNXSy9A0pi7Y44qc/CIbAMFsiRwjgLhCAc4=;
 b=LJEzsS4+kVxll80nxko76oScTxVabax89MXGAcq1lucmHos06A0GOg/ktmGCn89MaU
 hIiN+j+oKftPj1fE46jrb1VhBv7IHphYTPNCyNK92+6OAca6mhTmEES4v9mRS+dP/v9V
 W9Bwe/jWk9MnELtdHCN8b8Cz/q3DaHginFgErLpss3E/QbwJMTQxLQ1G4MiA3Z/atv1k
 De8J7vwK9prKSLc/SMtFReV1TTTGo8GO5Zv24KzkqZf+620Of8l7udQA72qO6seEvhRG
 vll8UyrP9k+rC1keAPlrPG43U7QQXTpx6iP1YKx1jKPFo579f8EHsPSTp5gVu2DahjN2
 VnvA==
X-Gm-Message-State: AOJu0YxOHYyNYkQWdwf+L4FyqKI173zXOXiY50B8CmXFwvSJlW83lu/O
 dQgnYX3vq5nvu5lMksLq8s7Jhvp6/Z9Yg1zkEfxlw5zD86mou2THS6JbXyEBZ4bVebSvg0yk8BT
 mtZQ=
X-Google-Smtp-Source: AGHT+IG4vIVpCTdDwCqnNcKmc3ucaA6/YVyz3Bjum6lU9ESe6H6XwyzTtGs5ruyQoJ5NA2B7anYaqA==
X-Received: by 2002:a2e:8703:0:b0:2ec:588d:7eb8 with SMTP id
 38308e7fff4ca-2ef05c99125mr9878851fa.21.1721291981017; 
 Thu, 18 Jul 2024 01:39:41 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a94af6sm2006495e9.42.2024.07.18.01.39.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 01:39:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 07/18] hw/intc/loongson_ipi: Move common definitions to
 loongson_ipi_common.h
Date: Thu, 18 Jul 2024 10:38:31 +0200
Message-ID: <20240718083842.81199-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718083842.81199-1-philmd@linaro.org>
References: <20240718083842.81199-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
---
 include/hw/intc/loongson_ipi.h        | 18 ------------------
 include/hw/intc/loongson_ipi_common.h | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/hw/intc/loongson_ipi.h b/include/hw/intc/loongson_ipi.h
index 82cb64ca40..d53bd5dcfe 100644
--- a/include/hw/intc/loongson_ipi.h
+++ b/include/hw/intc/loongson_ipi.h
@@ -12,24 +12,6 @@
 #include "hw/intc/loongson_ipi_common.h"
 #include "hw/sysbus.h"
 
-/* Mainy used by iocsr read and write */
-#define SMP_IPI_MAILBOX      0x1000ULL
-#define CORE_STATUS_OFF       0x0
-#define CORE_EN_OFF           0x4
-#define CORE_SET_OFF          0x8
-#define CORE_CLEAR_OFF        0xc
-#define CORE_BUF_20           0x20
-#define CORE_BUF_28           0x28
-#define CORE_BUF_30           0x30
-#define CORE_BUF_38           0x38
-#define IOCSR_IPI_SEND        0x40
-#define IOCSR_MAIL_SEND       0x48
-#define IOCSR_ANY_SEND        0x158
-
-#define MAIL_SEND_ADDR        (SMP_IPI_MAILBOX + IOCSR_MAIL_SEND)
-#define MAIL_SEND_OFFSET      0
-#define ANY_SEND_OFFSET       (IOCSR_ANY_SEND - IOCSR_MAIL_SEND)
-
 #define IPI_MBX_NUM           4
 
 #define TYPE_LOONGSON_IPI "loongson_ipi"
diff --git a/include/hw/intc/loongson_ipi_common.h b/include/hw/intc/loongson_ipi_common.h
index 70ac69d0ba..b43b77bda6 100644
--- a/include/hw/intc/loongson_ipi_common.h
+++ b/include/hw/intc/loongson_ipi_common.h
@@ -23,4 +23,23 @@ struct LoongsonIPICommonClass {
     SysBusDeviceClass parent_class;
 };
 
+/* Mainy used by iocsr read and write */
+#define SMP_IPI_MAILBOX         0x1000ULL
+
+#define CORE_STATUS_OFF         0x0
+#define CORE_EN_OFF             0x4
+#define CORE_SET_OFF            0x8
+#define CORE_CLEAR_OFF          0xc
+#define CORE_BUF_20             0x20
+#define CORE_BUF_28             0x28
+#define CORE_BUF_30             0x30
+#define CORE_BUF_38             0x38
+#define IOCSR_IPI_SEND          0x40
+#define IOCSR_MAIL_SEND         0x48
+#define IOCSR_ANY_SEND          0x158
+
+#define MAIL_SEND_ADDR          (SMP_IPI_MAILBOX + IOCSR_MAIL_SEND)
+#define MAIL_SEND_OFFSET        0
+#define ANY_SEND_OFFSET         (IOCSR_ANY_SEND - IOCSR_MAIL_SEND)
+
 #endif
-- 
2.41.0


