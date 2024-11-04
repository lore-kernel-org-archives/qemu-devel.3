Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D32D132BC
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 12:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7wMu-00060P-D2; Mon, 04 Nov 2024 07:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t7wMA-0005uX-B6
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:38:54 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t7wM7-0001oe-T1
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:38:53 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7d4f85766f0so3141914a12.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 04:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730723929; x=1731328729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98jwi9p0o8fOmk8UPM/sqRh+geOrtT788L2sLhtj3/o=;
 b=G5JIHuikYGh0vMLkut5DV3dGmGYpr01oEteH5elZ6nexl6/zy/eamzrKykjZ7s3nqz
 vdeNXOLmu+FqN55h/++r/+8ngDj23xuAlmT92ZdfLeLOdzFrpHmzHpr2o7stE3xoYLJq
 j05U5sKdY2uS/1ojnm9qY1XTjFbf5xdBgdg1CL1kKM3x0qaS2x3XoZkYh4u+CJRE4uVd
 MVjO+X88wg68j6oc14MaIXMX53t7VOea+o1K1TrJomgtXwml7Q/YDMIvsGQYbj4AowVe
 ktBSBw/74S/e9jirselnVqZg/X6E2MA4ScKj9iRMyosRPWaiCJTl3NYAIowMX/jVUhuv
 P+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730723929; x=1731328729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=98jwi9p0o8fOmk8UPM/sqRh+geOrtT788L2sLhtj3/o=;
 b=YjDMaDo+cCZRVmymTSQUwW1B19PsiUqF9G37UBD5Wcu22HI3YYbNEUy5BNVj0iId6W
 pHPqa0X7jzBpPRr/RxBFDqHrd0hEu5i3PXCNihHWbmWupZzXj6fKtvkHPXCo6i375VGS
 HAJ4ll3kS1PUSQ5eaoFT3rVbMrr5HScVZdj4FOsB+XlPRSANmwdRY1XDe0YDCzIXs9Ko
 zCa+g+PUnUX9QPt7rJjR7aCtxspZ0gZBA1MaQ1QJ8IzPF3cX+aRvxSvPlD2zZbxZjRYQ
 aAtIgrvw2yzF70c5KXGa6iT0TEWk3qp4c01Jh+AmA/u0RUBuyLBsv5wtGhXx78mLD2Q9
 4uUg==
X-Gm-Message-State: AOJu0YyoExoZuWwqRUK9b9cvBP3Ae8jFLUMzWw6ejHoVxpOUbCK0E7J1
 cHppH8p8igXOPUm93FvfuYXTeMiQccddH3cuCQL/IOuwW/61bHHCt2OPxC+jDHIWDQ99qzFnUqn
 W
X-Google-Smtp-Source: AGHT+IFKu7hqEN439YF4lNoCIO/jofqVEb5OHNN68TMEEivr50e8YKHlJgQl8U1e8nNiVEl2M4OeVw==
X-Received: by 2002:a05:6a20:7483:b0:1db:e5ac:3d5b with SMTP id
 adf61e73a8af0-1dbe5ac3d81mr1616634637.39.1730723928668; 
 Mon, 04 Nov 2024 04:38:48 -0800 (PST)
Received: from grind.. ([152.234.121.56]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc20e4c2sm7550953b3a.91.2024.11.04.04.38.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 04:38:48 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 peter.maydell@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH 1/2] hw/riscv/riscv-iommu: change 'depth' to int
Date: Mon,  4 Nov 2024 09:38:38 -0300
Message-ID: <20241104123839.533442-2-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104123839.533442-1-dbarboza@ventanamicro.com>
References: <20241104123839.533442-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Coverity reports an unsigned overflow when doing:

    for (; depth-- > 0; ) {

When depth = 0 inside riscv_iommu_ctx_fetch().

Building it with a recent GCC the code doesn't actually break with depth
= 0, i.e. the comparison "0-- > 0" will exit the loop instead of
proceeding,  but 'depth' will retain the overflow value afterwards.

This behavior can be compiler dependent, so change 'depth' to int to
remove this potential ambiguity.

Resolves: Coverity CID 1564783
Fixes: 0c54acb8243 ("hw/riscv: add RISC-V IOMMU base emulation")
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 hw/riscv/riscv-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index feb650549a..05341ad20b 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -846,7 +846,7 @@ static int riscv_iommu_ctx_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx)
     /* Device Context format: 0: extended (64 bytes) | 1: base (32 bytes) */
     const int dc_fmt = !s->enable_msi;
     const size_t dc_len = sizeof(dc) >> dc_fmt;
-    unsigned depth;
+    int depth;
     uint64_t de;
 
     switch (mode) {
-- 
2.45.2


