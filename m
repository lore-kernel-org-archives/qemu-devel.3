Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BFDCAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v298X-0007ND-Qi; Fri, 26 Sep 2025 10:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298N-0007CM-Td
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:16 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298C-0005ej-Gf
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:14 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3f0ae439b56so1405834f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895737; x=1759500537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3bhpaf1idG38kxz3QE1H3x0GUr2xtVGjLVLXG6Z87Lo=;
 b=gay5f864x5ZswG6McDhIwlvZWVYYRow5j5KygehchtYcAdFLveZbNgMHtU8SNqMUjS
 1SF7EI1z9xJ2VxGTDXa89bxb5n+GYKgJikr4T+MkHXXw68W1ipQvInKU3mD1mI3aBKx9
 xzGNLRVioItSaLutkCMBpM5KY5CwzDp65cinBsI+2L/m2kd+gWRkD1iDTpjeht8QemsZ
 JiTpETD9MpmeSrx3aTz66P9AbGo/JvvvNuByvO1YQl5eodrB5ziwJS3LBlViQzu+17wX
 Z5y5nnPffV8TQCqwThyBLHZ8UZ8kljH2QVQJqcGGsvxP0p7mR+qxQol4crG40mHJzVZO
 eleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895737; x=1759500537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3bhpaf1idG38kxz3QE1H3x0GUr2xtVGjLVLXG6Z87Lo=;
 b=hEKfcvdrxpvGO8JMVgv9M53eEtL+dqPTVnP6ICXrLbomer8FHu9Lkyc7pyigBA2XAM
 2DoDjLgku3ZGmDxzYgSwvdPvf35LxeaZpalM1OJWaeoCiq6cewMdTg6WRxXsvad6Tw2G
 HjqFoTgO1fEQsWJxwqI13T8X/meUkYj+LTBZb+6s44JC3qtYVKF51HxTXCz7WyJv+FOi
 KLZo+UA4bbmCO0M4fBjYBskGfKfYSOwr1wdKfVDQR4taEx8OX7LwamSkztnfdSNobltY
 uWAFsZ0GAtpQo1kLgTqusUjg0bL/IA4a56QeQDdqhN2gZHdkgeFABu0BQ9Faga7y86Nq
 VTjw==
X-Gm-Message-State: AOJu0YwTfO8pd91UCall+YE62M7trjVdcNWmyNv/Yh4bcLl98qvrqyza
 ROxZz76hbnj3Q1itYT/8cos3J4hhF0c7mfJNAT9FKPen5LBTM99U6eUNoH1ThatHIElGiJg+gDo
 h4Ew3
X-Gm-Gg: ASbGnctwgIqjZIgMvaFehnY02yqX3So4Z9zl7Y2uyCw8rYXOoNHrKQZdOVWMcMga7Ux
 mS9T7uXFQUE1QGCeddWOcN4QaB8zBaFhzqhY63x5KEK68CAsZwisNVUaG83PMkfo2Z09CNmNmX5
 5oD2wZeizXsNTd9cBVblosUrJAjsoFDEVtZclYleQfsEw8jYHGU8TDdog+lKDaVSuFtENGiXe+q
 +ZUg7Cpw2dM2Y18ynaeaR2HM6HHksLxsxdh0hfbx+F3PGfyF9kaf1dmQRhQ49yVmSFlPemomR2Y
 ncv9fBtOX4cBgmMrVfAnllqCDx/wZ4N6acKRaDkqKp62w5gdmdxPRuo9FhrzekH9I4cuNVOQWtb
 3PQiiuAGP7IxUI3aF5MhiBvJRON7q
X-Google-Smtp-Source: AGHT+IHjeGmCHhjeyTuZpbq4OJblr2CcT1uPZrUQ3AyTWMoiaydJmdphPk6YAgkHXTV9sm0JK2yKQQ==
X-Received: by 2002:a05:6000:2c05:b0:3fb:6f9d:2704 with SMTP id
 ffacd0b85a97d-40e46ad02e6mr6740342f8f.28.1758895737150; 
 Fri, 26 Sep 2025 07:08:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.08.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:08:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/44] target/arm/hvf: Sort the cpreg_indexes array
Date: Fri, 26 Sep 2025 15:08:10 +0100
Message-ID: <20250926140844.1493020-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index b043eac8c62..99d8672b9bc 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -925,6 +925,9 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     arm_cpu->cpreg_array_len = sregs_cnt;
     arm_cpu->cpreg_vmstate_array_len = sregs_cnt;
 
+    /* cpreg tuples must be in strictly ascending order */
+    qsort(arm_cpu->cpreg_indexes, sregs_cnt, sizeof(uint64_t), compare_u64);
+
     assert(write_cpustate_to_list(arm_cpu, false));
 
     /* Set CP_NO_RAW system registers on init */
-- 
2.43.0


