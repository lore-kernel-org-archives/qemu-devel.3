Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E87C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLf-0000rq-8U; Thu, 01 May 2025 17:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLO-0000kI-1O
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:22 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLL-0001Qr-Gc
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:21 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-af5085f7861so1030507a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134478; x=1746739278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+O1k7VqA10P+Nm26EsLR19J+UCHqhQNhPVgxBjdVUR8=;
 b=qfBLQzleY0iE/T/o+g1W86D7jzf+ZoktbG3Ji4BtYiHw8CDMCVO/e8bXJW4dcF8OMl
 NAhIrL6UeBOMH+izvgdgmnoCI/kmIibFf4xAkNKwg3PR7Laf/6p3dhNMxI7prV1cNv7G
 HqRyRqW/c8GQLt/Vc8aMuPp5pCc981gJRF2c9taHmiwonctM7R7OkrFuiF8AvFEUF66x
 ILbPyw6+XrzQdiT6U4ew15aFCNdSOvvnoep0PLQAukqudiJT7+xkgBPVrfGqSTppl0hu
 9e4twTOVixJHgfBsV/QKx4fmBgyeSIGI23/VRWN4v/ukNtKFfbuP5Dqf8fiPdUQj8Mtx
 83RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134478; x=1746739278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+O1k7VqA10P+Nm26EsLR19J+UCHqhQNhPVgxBjdVUR8=;
 b=aSXtxNQUl8Nu1ivVUtqXtUOO4KMyjtzVc4zBn3t1gpD5amv0gKJIGHPTMm62GhGwn9
 +wtA/PZvHEGUyijjZ2KW0VV+hFBJlDU3UOc9hkhjUNtU7zsPRULLSwpPtZ/YRNEOZWUt
 OhFL0n9HzVVZD2a5Vx317F0MbsPV0inN60n91hwymXUGzMIPy5+qnBOVGXf6qkMvpFDg
 qzyPkMNJZY6o2oCxZz72c3/hegnqyLNMXrn/K47HxSR/ifHd30h6pfFFSL2VXHpI9xq2
 lQJXpiy8VoXOXoEHKcRmbiyosh5Y5gELo3akrOi0/or+Ba565f9c+RfqixiA+wNUUDHF
 /oKg==
X-Gm-Message-State: AOJu0YzJ2yFvzItynfCZxN0wblSa6Ob1ZY1QqdUARnMx2CCyImmKegVF
 cSHUoBlHUnJ9wQ4r6ZFd9yQWL/PV8W9aO6dz9IAFm17s1dVRbrKJyEN7uG+Xy05HYkM/Eu7Hu2r
 W
X-Gm-Gg: ASbGncts1cPSZwDlyZzrBtaD4/UcA7AXOXyKMuhxVXLhPcjYHq+qjvW9Ayy7kdXBaU8
 Hfam4LKPJXabEcXnbaD8rYVWds9jePRBLdsfoQ6VT/gRuasj1s28s97kvjBTYqelbPznsm7gEsW
 /Q0+InKlmysylfbnl7uWjjmTEyTgnppV7PQWq22WkT0DXF1N0bt1RDPeQrWFI/eDb0iTkDhxSVK
 xY0S/NHXuCK+ttJSDk5c90vhqNO9ZEQ1OWPKYaRwhfuWf6mTkTBEbJJ/H/65Hrc9p19JmlusqHA
 bimqPpHYrZ948WdOZ0Vf+n2esVsmDaOqR11EiLH5+3hGgTb6ZwiyMb+MC+wv13vlOiiIiAs8sm4
 =
X-Google-Smtp-Source: AGHT+IE8+GzmDupYitrwjDfgtdczTF6MWsA3f8aQbWVH2LbVPzGkkINsJlq5Fm9jobF8cQ48H/p7Lw==
X-Received: by 2002:a17:90b:58d0:b0:2fa:13d9:39c with SMTP id
 98e67ed59e1d1-30a4e5a50d3mr1033985a91.14.1746134477729; 
 Thu, 01 May 2025 14:21:17 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 04/59] accel/tcg: Merge tb_invalidate_phys_range{__locked}
Date: Thu,  1 May 2025 14:20:18 -0700
Message-ID: <20250501212113.2961531-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Merge tb_invalidate_phys_page_fast__locked into its
only caller, tb_invalidate_phys_range_fast.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-maint.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 927e9c8ede..c893ea3073 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -1203,38 +1203,24 @@ void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t last)
     page_collection_unlock(pages);
 }
 
-/*
- * Call with all @pages in the range [@start, @start + len[ locked.
- */
-static void tb_invalidate_phys_page_fast__locked(struct page_collection *pages,
-                                                 tb_page_addr_t start,
-                                                 unsigned len, uintptr_t ra)
-{
-    PageDesc *p;
-
-    p = page_find(start >> TARGET_PAGE_BITS);
-    if (!p) {
-        return;
-    }
-
-    assert_page_locked(p);
-    tb_invalidate_phys_page_range__locked(NULL, pages, p, start, start + len - 1, ra);
-}
-
 /*
  * len must be <= 8 and start must be a multiple of len.
  * Called via softmmu_template.h when code areas are written to with
  * iothread mutex not held.
  */
-void tb_invalidate_phys_range_fast(ram_addr_t ram_addr,
-                                   unsigned size,
-                                   uintptr_t retaddr)
+void tb_invalidate_phys_range_fast(ram_addr_t start,
+                                   unsigned len, uintptr_t ra)
 {
-    struct page_collection *pages;
+    PageDesc *p = page_find(start >> TARGET_PAGE_BITS);
 
-    pages = page_collection_lock(ram_addr, ram_addr + size - 1);
-    tb_invalidate_phys_page_fast__locked(pages, ram_addr, size, retaddr);
-    page_collection_unlock(pages);
+    if (p) {
+        ram_addr_t last = start + len - 1;
+        struct page_collection *pages = page_collection_lock(start, last);
+
+        tb_invalidate_phys_page_range__locked(NULL, pages, p,
+                                              start, last, ra);
+        page_collection_unlock(pages);
+    }
 }
 
 #endif /* CONFIG_USER_ONLY */
-- 
2.43.0


