Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495E5C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UK8-0001Cy-Gx; Thu, 03 Apr 2025 19:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UK5-00014F-In
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:50:13 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UK3-0000gr-Mx
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:50:13 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39c1ee0fd43so1243951f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724209; x=1744329009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F4hQtsRqLsOAfmfIygYHr5yTvJJXu3lpTgjRUryOvbU=;
 b=vWhmwXnBRb9XRw9XPjZoe1l0ymrDprgPxL0lGn/bJ2+1YlGygL7AfEqJ4/uJboTHNJ
 hmw/A6/hW+7d7YRSstBBTeau4rAHkT8XGX1sw/fH+f7U30BmxCjZAVkjVL/RgNYDPrTV
 ryHgewR48Yiu5KadCmLNd99M/eNVkkusJDERMOaA545BigF8PkmFfg3pVeuxDYocNI/V
 d0WHHdZKQrU31DeRymyYopAUuTyKgRa0mDuKQLVeVr4stHjqQSrdlo5J6/d1QPCdIAfe
 11K6muiIf/Fv1tJtpJIxZ1RwOkueYH+ueVYLKzSe2TRUIlYe/TsKRaLMFNbvpYKnqr2/
 tOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724209; x=1744329009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F4hQtsRqLsOAfmfIygYHr5yTvJJXu3lpTgjRUryOvbU=;
 b=aO1BdO2mpAvhGrII/fq295QW4zMzzFC+uSxwbiwvCde38qo0/meBh/fi/cEE0YA/f9
 tV/sqjWXVbaX4AfL2pIazxgFE08NNicZT9WQXxsH1xt+0tPkeY6QDQ6mGutfAfE4XmUY
 z8bEthzioWHnTh05MuqZLkICHKtX8YdgW/JBbgJB+ERkwMH847f2uldjYUguoiL8tPzu
 TbjeVYjNHtte9VTlR5VgTyWg0VLcuwk+ugjTaOzWn5/aibwTfjYmwsJlsSMeKCOwYw+5
 am7doio/OK6cn9+E2AqKEXqEtJdIlOuN45CFHRT2ro99yctePTtzv32GRkbtRejYX27/
 Huog==
X-Gm-Message-State: AOJu0YwQMgIY1b1cgfFAGBLNxa2FDKTXqUUEGp9GtZ6UiuQEkC8o2C5j
 nDLUBEt6WX9yDXYbdr+Mc59eVMhmxvm0wmaQdgQof1UcaAa3D/31TexAM/UbJkCJ+fec4MFuWwq
 s
X-Gm-Gg: ASbGnctU3oBRpb8W7um+Ufl5rT2uoIrVtiDSFr+/ovWuUZU6f4IjKqhkNG4EHKwAiJ4
 utatLKeOc7GVwva7EcdnG/LXr0oGUurq0Ar5pyo6OTl1bh80JwoJaJTkSk0Wbf6tdORF13IcBwh
 QM8VFODA4JQj4yJpgCBTkosOF6Mk70uTs8utzDyc+f3QPR60XJkwXVetLs2KDXG1V20VuFw+Kh+
 iH2uBT8tojaGtI82olhYlcrR8S7+SFwKZsh6qyibykSVZKWo9eEoDyN/4WgXLtNcLQ3TT8NFXv4
 /wg7UfiOQZ14vIlA2QfjWRhtZwbs1Wa7mbudr2ratyT/guwyNO0fVNg+Dxo9zr+S3CeEvtF19Lu
 8C1MsWDNqPEJixKvtRwlXhREaR/OIKA==
X-Google-Smtp-Source: AGHT+IHgo84CqX39MHLOljzDfCIs/gYPnZSVlSftyCKU3RiHgkB0JxR2VO2oTfQ4WXzOz6k2V9ziyA==
X-Received: by 2002:a05:6000:40c7:b0:391:40bd:621e with SMTP id
 ffacd0b85a97d-39cba9827c6mr852409f8f.44.1743724209677; 
 Thu, 03 Apr 2025 16:50:09 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301b816csm2968052f8f.57.2025.04.03.16.50.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:50:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH-for-10.1 08/19] target/riscv: Replace TARGET_LONG_BITS ->
 target_long_bits()
Date: Fri,  4 Apr 2025 01:49:03 +0200
Message-ID: <20250403234914.9154-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403234914.9154-1-philmd@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/riscv/riscv-iommu.c | 3 ++-
 hw/riscv/riscv_hart.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index 65411b3e4c0..37563b2102f 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -26,6 +26,7 @@
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
+#include "qemu/target_info.h"
 
 #include "cpu_bits.h"
 #include "riscv-iommu.h"
@@ -393,7 +394,7 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
             if (pass == S_STAGE && va_len > 32) {
                 target_ulong mask, masked_msbs;
 
-                mask = (1L << (TARGET_LONG_BITS - (va_len - 1))) - 1;
+                mask = (1L << (target_long_bits() - (va_len - 1))) - 1;
                 masked_msbs = (addr >> (va_len - 1)) & mask;
 
                 if (masked_msbs != 0 && masked_msbs != mask) {
diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
index a55d1566687..667d3b0a507 100644
--- a/hw/riscv/riscv_hart.c
+++ b/hw/riscv/riscv_hart.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
+#include "qemu/target_info.h"
 #include "system/reset.h"
 #include "system/qtest.h"
 #include "qemu/cutils.h"
@@ -72,7 +73,7 @@ static void csr_call(char *cmd, uint64_t cpu_num, int csrno, uint64_t *val)
         ret = riscv_csrr(env, csrno, (target_ulong *)val);
     } else if (strcmp(cmd, "set_csr") == 0) {
         ret = riscv_csrrw(env, csrno, NULL, *(target_ulong *)val,
-                MAKE_64BIT_MASK(0, TARGET_LONG_BITS));
+                MAKE_64BIT_MASK(0, target_long_bits()));
     }
 
     g_assert(ret == RISCV_EXCP_NONE);
-- 
2.47.1


