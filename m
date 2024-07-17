Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031A4C3DA5D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 21:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUCVO-0000ik-6P; Wed, 17 Jul 2024 17:48:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCVM-0000YO-3o
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:48:08 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCVK-0002Jn-BS
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:48:07 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-36796d2e5a9so105022f8f.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 14:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721252885; x=1721857685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NSJ3QaL4bkehVQYGGugiUngoSHHCTqishnt4sbK/vnE=;
 b=etuKRgQgSd6xFmXrjBp0pcE62ickcb/Yb0RJgkn7smgpsTnVsZo4sYRObvJyc+dK7c
 xjxedh5gzZNNAwuN5xg1jXcNvos6BGMEWjFZCFiBoZdfHmEzBKoQPR6I6mmMtKMPjmQH
 2CF2+m2jZY86yY5Osoq4JWwaA+fV4zMCI32R36OOR+FQ13xp5vQ+s7dN/Y/Qq/hiVwWY
 zGiPlxHa76PXPu6zZ3S6wSDK+Q4ScBkctyxHwEYjmKuc6MmTrOmFlXoSTkL5xhgvF5zk
 ZC1y0VgF5DaKApUi++QNPYkDHg6xqxMmU8WdYzGTKLkcyN4ukts2E2pLihUQHbKpo5dp
 +KQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721252885; x=1721857685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NSJ3QaL4bkehVQYGGugiUngoSHHCTqishnt4sbK/vnE=;
 b=ccWo6EFC+tF5jAXNo/ifTdtCbiRRs3vH8emfmHy/5GUv2q+M96aqiWgrcpeQrXDdpF
 T5o5M+ak7EUKuWKnUWx13T0VQmAJyhNZQHNlJyOWZIw2IMlQ80zFfXi5u3p6tii8Ovmf
 Jb2qUQImNjTzoY5GhWypTAViwym3lDS/FaqlybXjZSB/MbGeBSXU4bKanwJTQthZMJ63
 7GfaAY1QD5h0SLGkXk/r4HIPOkRTK2BHQPsMaif0m9QF3YSc5QLfctxpw/OWDe+Vl9u+
 BqRMe5NJ/gR4cnq/W3X/1qokUY8r599oAQ7oZRxvEgH5G8oIoTYGJQOWetvpeggByeo+
 A7uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqM0cM9OQ1+7iKxX2vk4P3FNY7JJm5y43kDDL6DcR+x1K2KKjFH9uJsYnz1VLrrWDAdb1MlhxnQffqvyOV5mdWYhlQfiE=
X-Gm-Message-State: AOJu0YwdZSUrQImYt7ZI0cIgxeH8m4e2u0rvtlJwRAqVstPIuou+w2x4
 kVxhhSMCRIj4KbFliT2StHFLvk4eEEq96+dNgMxUqUT4IPEtY+3qRjhExV1HirQ=
X-Google-Smtp-Source: AGHT+IH3LQyrSq+d7CBMUmBNL4ECwh7idGLuSuEhJ9QZxxbM3cVCg5XaGV9rdzdKqd1kv0Qcs69New==
X-Received: by 2002:adf:b647:0:b0:366:ed80:d040 with SMTP id
 ffacd0b85a97d-36831789e61mr2035397f8f.67.1721252884647; 
 Wed, 17 Jul 2024 14:48:04 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427c778e049sm12098005e9.9.2024.07.17.14.48.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jul 2024 14:48:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH v3 06/17] hw/intc/loongson_ipi: Move common definitions to
 loongson_ipi_common.h
Date: Wed, 17 Jul 2024 23:46:57 +0200
Message-ID: <20240717214708.78403-7-philmd@linaro.org>
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

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


