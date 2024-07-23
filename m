Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F300C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMJG-0000fE-4c; Tue, 23 Jul 2024 16:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMJ2-00080B-Vl
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:40:21 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMJ0-0004GF-QC
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:40:20 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-369cb9f086aso2071619f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767217; x=1722372017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pqhDz9jkzJVJQG2tzSqklstnX2oao7JbXMBXUDlT2s0=;
 b=lhQpAjNpUj2d8fkr0XCwzjRhteDtmS3dEbYCxXIodEx/hN3cTer2VzlJKVr5ySllq8
 LD5Vr+Kfy508M0YQ5UurQV7s7dAVcHEgQcNbjxz0VVpU405GWXm2/ORNpGx1ul7VBJJX
 +zUCAUZxaxI5sS09jdC/xWIDwly+7j16orA2GBDO4H4+FNjQnr6bx7rrjecUDpvN6F5e
 MIK+Ju0HP+wfL79k5yaSg6FpWuX7cITKTAJ8Fxg2Lp7TEaJJnJjsQPf7uURcIYLdXQwQ
 F+JUqJAmhAZT94+oKRp+lhdICq3VQSLdZmuPAFK4E1tATlnHDGYHrb94Yv+700cl4oJq
 Bbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767217; x=1722372017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pqhDz9jkzJVJQG2tzSqklstnX2oao7JbXMBXUDlT2s0=;
 b=vwzMc1p+s4p8wqeRPRXE38hZ/XS5XbTBhxDapumK/BSm6StvvltAHEcEX19BuuMUCa
 DQm9oL8tUuq3WKhTNqnrUdjPema1sGd12D6wptKL+6JCJUWGdGp/RNqm84fv3xcYmRWv
 psfgI0WWX8iv2gm/nim7bHy5mHIJbSxYDU4Xskn1DkfSFQ57K3HKFUp7i+2BlEen0m27
 jSP55iDfjtrqoxgo+1jbdizxLnN9PNehCxMd41lUmIsog1tdrPs+FMcSzrTDOXLTa+A9
 FZO4uqe7vEmlacCzJGjjf1+q6OzGdafVTtx5QN9X6AGF8xroQVifdQqEL2f8DM/5AgXT
 TYPA==
X-Gm-Message-State: AOJu0YyxBDyy/UtRtfY0Fpm6/NYkZ+WMApb8owV9IklYqeLctf2OF+rA
 78BZXXNwdZSR8SR+Z4WlRIdXH7sVFRHHtN5O5gtVhgVoLtGicVMUvq5TtvGaHnkvN/ELSSInk5c
 pZKc=
X-Google-Smtp-Source: AGHT+IElmPSE0293WEGARsdDyOGAzPplpJCqtDI/v2lMSEwrEPj48xacn2u84oW10zp7efsHROHLvA==
X-Received: by 2002:adf:f38c:0:b0:367:402f:805b with SMTP id
 ffacd0b85a97d-369f5af631amr43652f8f.2.1721767217092; 
 Tue, 23 Jul 2024 13:40:17 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427ef3f4665sm25877335e9.0.2024.07.23.13.40.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:40:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yao Xingtao <yaoxt.fnst@fujitsu.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/28] sparc/ldst_helper: make range overlap check more readable
Date: Tue, 23 Jul 2024 22:38:41 +0200
Message-ID: <20240723203855.65033-15-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Yao Xingtao <yaoxt.fnst@fujitsu.com>

use ranges_overlap() instead of open-coding the overlap check to improve
the readability of the code.

Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240722040742.11513-9-yaoxt.fnst@fujitsu.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/ldst_helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 2d48e98bf46..d92c9f15934 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
+#include "qemu/range.h"
 #include "cpu.h"
 #include "tcg/tcg.h"
 #include "exec/helper-proto.h"
@@ -240,9 +241,7 @@ static void replace_tlb_1bit_lru(SparcTLBEntry *tlb,
             if (new_ctx == ctx) {
                 uint64_t vaddr = tlb[i].tag & ~0x1fffULL;
                 uint64_t size = 8192ULL << 3 * TTE_PGSIZE(tlb[i].tte);
-                if (new_vaddr == vaddr
-                    || (new_vaddr < vaddr + size
-                        && vaddr < new_vaddr + new_size)) {
+                if (ranges_overlap(new_vaddr, new_size, vaddr, size)) {
                     DPRINTF_MMU("auto demap entry [%d] %lx->%lx\n", i, vaddr,
                                 new_vaddr);
                     replace_tlb_entry(&tlb[i], tlb_tag, tlb_tte, env1);
-- 
2.41.0


