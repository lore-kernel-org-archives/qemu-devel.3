Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B56C52D72
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 18:08:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb26i-0006CN-Sp; Mon, 05 Aug 2024 14:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb26h-00065v-8M
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:06:55 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sb26f-0006OU-IX
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 14:06:54 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-36ba3b06186so3035450f8f.2
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 11:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722881211; x=1723486011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tcvWw4VD2EULzwQDC9M8lg6CF9IpMcNlyvAmzky8oRU=;
 b=mJwGhNpA2l5O3pbypFBkVsHPFaVWSMJCviMT7EU2bHEViyP5pOb2BM4Cj7k1aGxCX4
 VN13tJ+SdtQfOqZe/M27bYt5G3WJc6XNJSXYzZM+dKJBZe3kLKvP8j8zR4trUA6uCj6z
 UwYVXop1myjGk0RxFmASWUiBfIgegfNXOgGIO46A6ygpWvbnZD+IL3drDm5ls0ki8PNL
 OAtI8AK4AVlz0mtGXJT4hXUQcxTazHlnDRfNhn0n9zN/f0/JX3H21Ba/ihDweLgatuGn
 VfOIfGI4tWkCnzu/9DJ/BplR+KjCLozvHokKoL8oJ7II7/ZAany7NlmAmRwpGHnJF9Id
 mPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722881211; x=1723486011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tcvWw4VD2EULzwQDC9M8lg6CF9IpMcNlyvAmzky8oRU=;
 b=Loh73YOQsvRiryM96b4Rp1E4NIwbJbuIGF7rlaPL2ABbOEJyRgacCjPCTy2O83TKfV
 0NC/aYHufb2daDfSEX8ZXqSRqVdpoOwQ2PCuO8STKmiSIBB56GkpKjc4sMqxSqWhvzow
 QmBLeDACRXtwtoUMA2Ah4TI83Xius+8/CYNRhVQoIPEG3rdDEnS3vkBB5unCDIfBOUlw
 Vao7cK89v/Gu44fPRyiD4XUsUmUIkHGIsnCudtp8rC2b8CRVMx5++nqIG2vCuo2m0Z/d
 qHpEpByPxAHRkk2MAFDp08nb3uzqoqa1crk4Pt0NthdhN1mbkDv7k7UANspZbTnmZm+j
 wVyw==
X-Gm-Message-State: AOJu0YwMB0O1R01k9K0c+8fxWXrPKDfM6g4DWC8GfQL3nOjJ5DuEbOd9
 bKsnrIcsK5Q1ne8pocEq1TjLgtInO9bXiY5XW79OdRQ/wVWeQfaVyMrlCahXU1m0eS24k5QbD/x
 r
X-Google-Smtp-Source: AGHT+IGB9G9FSCjFjeekOwPLTig4Kv2P7R2rvyxJ3f4z4LD9KPhbGe6jWIbXWinOTO2ul9EgnzUfKA==
X-Received: by 2002:a5d:4f11:0:b0:368:12ef:92d0 with SMTP id
 ffacd0b85a97d-36bbc1d2d8emr8952432f8f.51.1722881211600; 
 Mon, 05 Aug 2024 11:06:51 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd0597a7sm10684615f8f.75.2024.08.05.11.06.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 05 Aug 2024 11:06:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH-for-9.1 v6 04/15] hw/intc/loongson_ipi: Move common
 definitions to loongson_ipi_common.h
Date: Mon,  5 Aug 2024 20:06:11 +0200
Message-ID: <20240805180622.21001-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240805180622.21001-1-philmd@linaro.org>
References: <20240805180622.21001-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
Acked-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20240718133312.10324-8-philmd@linaro.org>
---
 include/hw/intc/loongson_ipi.h        | 18 ------------------
 include/hw/intc/loongson_ipi_common.h | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/hw/intc/loongson_ipi.h b/include/hw/intc/loongson_ipi.h
index 9c9030761e..70e00dc1a7 100644
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
2.45.2


