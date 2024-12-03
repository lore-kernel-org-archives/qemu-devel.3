Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23D3E74ACF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 20:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIZCN-0006Vg-PD; Tue, 03 Dec 2024 15:08:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIZCL-0006Sy-7Z
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:08:41 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIZCJ-0003GL-O2
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 15:08:40 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434a766b475so55214615e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 12:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733256518; x=1733861318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nZMOVj7GbVXZJay7mP9/qfBnekqIsTqZXLgo5aqBELo=;
 b=DyESerzb7x8mVGiHfYxsQAOMBm+A2MSlzA/6ngKEewJoMi0Xu8ch5Hl+XztJYzeOKd
 miDiZHsYd7E/kq7voaZSFBGinibqYzW1+0uvJvhWUNC/A9FcjbkSZsp+RdrvdFeiBqkI
 ctPc1cakX0xPPo7bTKyJM1vFa7w9kk7+CnLBg0Kv+jzf/OgDcPLH81CEhGSvGsL9bl+P
 fFkiWQVN/K/MYK3LZPRUOZG/1a56YnFcP0O9vKBJnMREHISJ8W7JwhnQ3n/SIHLH946i
 BDLD7x+xpO39CIbsPnOo4HIYTXYbKFiVWKKb6GoSLo6fOH3zBRHz6qBaZXH6ejCutK5e
 wOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733256518; x=1733861318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nZMOVj7GbVXZJay7mP9/qfBnekqIsTqZXLgo5aqBELo=;
 b=XRYCf+ZbeorVI9DqFB3bMmvyIHcpzBjrwiqasA1pKMiZAbpN1sLbZQk+1+UMDe7c43
 TeFU0RwCBunR6MgfYeGG11hIVbI5imvK+sadjEM6RWahdTJ2x7rvZICPLaPJccOJJEZx
 Fy19fqLj/423aQxQO9X/ypECqBZbQEBoQ6pL+g7CpWHNLoeL6d9wiK0UZGCb/WoZ72SH
 8obbq2FKnjskJmZWYoMd246wxh1Gs0IhCvzRgZnMB2Tb67sQPDcUIzjCuBG4S4tvUv+l
 27N4FQdWqjnJ6JnZMLH7obQnXZof/cOsV+00jzNAvDhIWOJaktWVxgWwewJaNZxncAWi
 dr+w==
X-Gm-Message-State: AOJu0YzXKPEM4q7Hc+wTfpIRxUIHFMum+tbxuNvVzItsPF2p1GnG6pU4
 0hyT8GzKzy5FQV83P4munLwUnLGrJiNgmsbXhBEQcwiNS/UKJntqViDdDxsBR81zVYSdwlZ8gJ+
 u
X-Gm-Gg: ASbGncs4PrF9W4qWybIBp9+0oc5UYvDnYQbMx+L6+VpNxdqRlhr19Lepq2ujPJQG/za
 GciqfcQn70zUWT9nN2dYp+U1SomkZXa4PSMOLOCqydErXQjZWk8FLBZOi2bJ4AYqltLPcsWwXou
 S6eQsKaTwu16qux8MBqPVDrxeJKYsb6NFAK/Sg2ZLe1OWNAuJn8lXiixJk5nD14GnxoS9BPtpMm
 4GPF7gpjSYT5RzOBKath9wmMrnPlDJiimWg6JMO9Ff+uHFDLU0UMhqwOW+tGGgUXbg5wnGxol/u
 Jw==
X-Google-Smtp-Source: AGHT+IHVpwAlh7+Qr0gXewOUCMgM1k5B6LlSBk1Z6ec4V4DbzPzaOXn3cd6Q2urc96Cavnp/ANpe9Q==
X-Received: by 2002:a05:600c:4586:b0:434:a39b:5e44 with SMTP id
 5b1f17b1804b1-434d09d01fbmr39423885e9.17.1733256517813; 
 Tue, 03 Dec 2024 12:08:37 -0800 (PST)
Received: from localhost.localdomain ([176.187.209.146])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385dea1e4ebsm14112074f8f.1.2024.12.03.12.08.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Dec 2024 12:08:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-riscv@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] target/riscv: Include missing headers in
 'vector_internals.h'
Date: Tue,  3 Dec 2024 21:08:27 +0100
Message-ID: <20241203200828.47311-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241203200828.47311-1-philmd@linaro.org>
References: <20241203200828.47311-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Rather than relying on implicit includes, explicit them,
in order to avoid when refactoring unrelated headers:

  target/riscv/vector_internals.h:36:12: error: call to undeclared function 'FIELD_EX32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     36 |     return FIELD_EX32(simd_data(desc), VDATA, NF);
        |            ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/vector_internals.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index 9e1e15b5750..a11cc8366dc 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -20,6 +20,7 @@
 #define TARGET_RISCV_VECTOR_INTERNALS_H
 
 #include "qemu/bitops.h"
+#include "hw/registerfields.h"
 #include "cpu.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "internals.h"
-- 
2.45.2


