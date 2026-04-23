Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A821DF99368
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqtV-0006LG-6v; Thu, 23 Apr 2026 06:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtK-0006IF-Jb
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:39 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtI-0001uR-NF
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:38 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43fe3e22e33so4255584f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938555; x=1777543355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gz+3/c5alGnyG940k4eg01wh9k6RmeSDq2UN3hoJP2M=;
 b=zb1ZLo2i3BT7NakSY9f7qPYmUYqfWsefb7cbGgYZQ5ohLg/WN8qg8eoo9ondcixOBW
 gRDXOtkLKcVMMsnawYaMQDXEUh9wP5m0griqgh5btYr+MujqD4FvgUhwmBjFxCBU3Ihz
 hM3ooqm0+erwI5NOQUEWhWedtPapGXtzUxcXheJaMb6B+Wnq6bNtNsXXZvaV7t4fv+o/
 mqKeVVZQ6ivXjkSXKTAR1U04m4eOSWVppsD0iB8jlUgKcBdfNAuJHrG9sdlzgxhysVsW
 CzSd2wHdHrhKGYnZFQbAwJWBJdJMINvgP2vWRtSe7Nm+xqjV7xD0YoSoYE661BvU1K6G
 aXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938555; x=1777543355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Gz+3/c5alGnyG940k4eg01wh9k6RmeSDq2UN3hoJP2M=;
 b=pdkkfws4L4oBzw31N5S11VkiFwVzpe9RdbKXx0hTFM0l8uzaU8M/n1yXV677ScSRU0
 hQjeEv29mmARx9Z3HHJ0D7gUPcSE1V4/UPGJ79MkUtBjOzYt4U9PDTZm6zw/kiSYOGsb
 9AOElbvMKRHGaQnKOsQxTs6guoat0QQtTNbFASZ2vBoFNLmA1XOh5VPH1uk/St1DJdP6
 3COcN9v1EjnLuVcJPOJDrd+xskRWMK0ZVG+CzBxTagzcqBYbIM4qvGNC1okEZSvjj8bq
 81R8efAsVOOfTrkqop5z6ysMvU3921RSfLdwnzlIb5PI+wOaABg52h4qj5u8rIuUwSy5
 R3gQ==
X-Gm-Message-State: AOJu0YzCFvN9OTgNoFTulzry9/FDWLYXLsApe6tCJMhF+Ck0+UkTUHBP
 6aXETvCmXV+jUxqi4ppCbhVm7UDJZnZKnIc+IafzH+9gmf+LRr6V2EMMmJBCSXu+ID9P0pxrA97
 ycWxt
X-Gm-Gg: AeBDieteRZi5xkH9VVw5EX4ZNNFjiH2N60y7NnRw8Ig0agJvD4z8JquS7Un5U12LYjJ
 9DwAOE97mtr0FgYARSEJxf6+ENY+U8113JGkJ/CMkgU6+pgiZc7qZ1KZ+GG+hJwQpHsPW3JsEGc
 yVItfVBiqCRkAJMbieMaNYFVbqaaJpx17pHd1DgKtsuHEz8qdaUtNcNQlZLSQDy07La90LI6hMA
 uN5KRr0P00Q1+sG9ADq8xtH6ongSuRuhZ9/QuwaFnnD2W7QIVH6LYJfpYDd+7RPQkLuxQntV99J
 VuZeiSCfXpq3czLfCv0CvC4a6HSg37pC5YJO5rWeg2rmMVS+Y2bvQ1kXBlT1eVEJQidAN5Cj6Dl
 BB5oXdYKRsbyygpzlwZsEOW7rlAVcykMvHB4RVo4wuJR3PuaExys157v6mHpBXNsz/J3NG4A8ov
 iSsKSaGvb5LcwG0LVsgYAaE6YRMcbXT3F4KTJ4RvschIhiqBhokkYuDg3k8N/HfqUa4w8jaD50o
 83WBfLl33aq5mpqsGk+Iw3oXzvsOFF7vCx5P183aw==
X-Received: by 2002:a05:6000:2307:b0:43b:3e40:2223 with SMTP id
 ffacd0b85a97d-43fe3dcc52cmr42042708f8f.19.1776938555131; 
 Thu, 23 Apr 2026 03:02:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.02.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:02:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/59] bios-tables-test: prepare to change ARM ACPI virt PPTT
Date: Thu, 23 Apr 2026 11:01:34 +0100
Message-ID: <20260423100229.2941820-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alireza Sanaee <alireza.sanaee@huawei.com>

Prepare to update `build_pptt` function to add cache description
functionalities, thus add binaries in this patch.

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260311160609.358-5-alireza.sanaee@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..e84d6c6955 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,4 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/PPTT",
+"tests/data/acpi/aarch64/virt/PPTT.acpihmatvirt",
+"tests/data/acpi/aarch64/virt/PPTT.topology",
-- 
2.43.0


