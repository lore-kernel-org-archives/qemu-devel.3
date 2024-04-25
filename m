Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46396C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 11:08:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwu4-0002K9-LE; Thu, 25 Apr 2024 07:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwtJ-0000B0-T9
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:04:03 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwtA-0000I3-Sq
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:03:44 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2de233961caso7891981fa.3
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 04:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714043011; x=1714647811; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2PQHJ5tsa1+Iw7rGUJbqHRL8DwWj2o26FTHLneT25lU=;
 b=qF5vPcOkQSHZM1NLwAfCBQMhgKN/jwiR9NQS6Ch89FK9VZIjHtD/ZTHN1U1oybFX9/
 j8km1Ge599RgH2hYhdMMQ/9FzK9rsJHIXk5WHMmT8xx79+NQvbvqp5RLY1B27ZBbLhsR
 E45oDsbfz2XHLQloCcYrmAb5HSOCzmCIUypH5bGamARXwIYgz02OqGSD6sFYcSxnIu0O
 nFAApaf1RT58vkwUKnTcdFQ4dEHldFNiO4Kffc2BISTerJOpHnHPdnFE0AyaIa4UhO5/
 x7u5Jrz2uRTFxoE08ZqEIvE44frv9LSbx6Wd1fQU6PgRYJbq817/YvCTEYUE8sXv3918
 GWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714043011; x=1714647811;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2PQHJ5tsa1+Iw7rGUJbqHRL8DwWj2o26FTHLneT25lU=;
 b=CW+2pwd07fyF+AOcDJ1u0LQb0PXIMzJjiJseJWGJfm18gjcwtUAsnRptDkD75BaPo4
 gwY4KZ6bjpdQ5FUmI7RH7Hgmdt9fy8yqp8yr5/r2BzaDQD9HIahniWnAFsMwN67lZRx+
 LNbVI9XVj2KJImO3ZM5LSUFYegczNvN/6DlGoIu9hCLFqaM7i47a+OphuoKONZJZdswG
 L2Q4hSJX6ZoyMbpx3ekxp8X5bN0kZkqkLT7WnT6Hb75tGJNutAhvjNTajqHVQB2Nx5Rk
 zKVESalVnj3tyI8Tw/vPHQOr8CzlmQJO82dOx4iVj0eKnruCHvysJgPotoGpTZjmFMS9
 tCSA==
X-Gm-Message-State: AOJu0Yxt7KNJPw4jQR8dem6nJymdQO++FKYLc50joCw3ytmi0F/PfLF1
 +M9r8WbtvV5V4QOhqGy+L8U7ObXq3USDHikQs9o/XFeDRQZyWRGq8zC716+9bAvr+KXvN724+cm
 Z
X-Google-Smtp-Source: AGHT+IHjXpphfPvfQQeNi/tfubBrsdyX+KmCThTxoYcIYz0zKxSB3Us2byui4wQDChBJF2z3pJlAyg==
X-Received: by 2002:a2e:b353:0:b0:2d8:3e07:5651 with SMTP id
 q19-20020a2eb353000000b002d83e075651mr4356960lja.34.1714043011391; 
 Thu, 25 Apr 2024 04:03:31 -0700 (PDT)
Received: from localhost.localdomain ([92.88.170.77])
 by smtp.gmail.com with ESMTPSA id
 bd25-20020a05600c1f1900b00419f7d6879dsm18832137wmb.8.2024.04.25.04.03.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Apr 2024 04:03:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 16/22] hw/xtensa: Include missing 'exec/cpu-common.h' in
 'bootparam.h'
Date: Thu, 25 Apr 2024 13:01:49 +0200
Message-ID: <20240425110157.20328-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240425110157.20328-1-philmd@linaro.org>
References: <20240425110157.20328-1-philmd@linaro.org>
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

cpu_physical_memory_write() is declared in "exec/cpu-common.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240418192525.97451-21-philmd@linaro.org>
---
 hw/xtensa/bootparam.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/xtensa/bootparam.h b/hw/xtensa/bootparam.h
index ade7891ec5..f57ff850bc 100644
--- a/hw/xtensa/bootparam.h
+++ b/hw/xtensa/bootparam.h
@@ -1,6 +1,8 @@
 #ifndef HW_XTENSA_BOOTPARAM_H
 #define HW_XTENSA_BOOTPARAM_H
 
+#include "exec/cpu-common.h"
+
 #define BP_TAG_COMMAND_LINE     0x1001  /* command line (0-terminated string)*/
 #define BP_TAG_INITRD           0x1002  /* ramdisk addr and size (bp_meminfo) */
 #define BP_TAG_MEMORY           0x1003  /* memory addr and size (bp_meminfo) */
-- 
2.41.0


