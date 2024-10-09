Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F4DCEDDA4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYJP-0001W1-Se; Wed, 09 Oct 2024 11:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJM-0001Q5-D8
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:12 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJJ-0007yL-Uo
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:12 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71e0cd1f3b6so2289999b3a.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728486548; x=1729091348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EqamM47YYvl4fayf0B1PwwrQTXdDx1JaLcVtzZIDh0c=;
 b=gR5ZVGTQoGjElEI6ufXwc71V+GFG5hwZlzT+df1nSQZiOh4NxQnhaHloVIY6mck0sk
 dIFrbm5Eknar2JlEs269Dg0KEWoSwHJcnczW3AqUXjFSaHZEyATJQWRMPqEJJAkdihG+
 cvruVVy+O8lYP2amCJrr9oRsDja+ifqqpXeXcFh04Ucmz4QPx9LPHpaYA/zTkQbLjGhX
 +9EW7FAQSB8yJOUBuvt2BzWFBnfinRUOVVVYPa5LM1IVftlcLUOj8LXR5+HL8xaudklC
 Bvek4yaOXXrNwByfQkK4OStEIYFT3lx9X0dPDFuNv1zbSK2P19gPkpy8Qi9Qrp64KSAn
 JSEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486548; x=1729091348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EqamM47YYvl4fayf0B1PwwrQTXdDx1JaLcVtzZIDh0c=;
 b=C/d6gUXcXlddC4q8QTwKdE1vfYJm9d26IpxjZzApc56jKuiaY01W69B+Y4Q4RMRAG9
 TKhxX83SzKoBEhEs9hVailVWGr+A71fW/GKxiUZkGs9LGIqLF5sm7y3y/EsZL3gRL5UF
 H+jAgojJ6mHzUKjUoQLyGBVOZY0pTU6se+Sn0WQBlG9Qr/vYJGMdKGIvFajAqhHFGNn8
 po29qUKfnmPJYQx2SP8P2j/W1ZNk4VlMhLgLhghgwaXzHAfpK7pEkUIFbtZvMzNMg9EM
 V/+vueKmR9u6kLDbZ4T9mm8+jq74yQn7Azs16LXnZDKtw4yl6wJtQ6DsE6GzQ0pCDttE
 jYMg==
X-Gm-Message-State: AOJu0YwabvSNUas7+3+ThnUSinkxCJ2uaVQb4YqbGyUn3HS/qune8F6r
 AoeQI6MeKzyzSkyeinpBPqiRoCia2IoM6+cEZB30fFxV023QzRCzw6PCErhlmzIeGGmdJ1Zp833
 h
X-Google-Smtp-Source: AGHT+IF4vYOCZng0K18fYF28mQ/0bCl3IINgujjoyNdHgu+vJDGv2xCueQkw7cn5kXt7gESY3kvXUA==
X-Received: by 2002:a05:6a21:3511:b0:1d8:a3ab:7220 with SMTP id
 adf61e73a8af0-1d8a3b5cac9mr4419525637.0.1728486548400; 
 Wed, 09 Oct 2024 08:09:08 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d65278sm7881094b3a.160.2024.10.09.08.09.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:09:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/23] accel/tcg: Process IntervalTree entries in tlb_set_dirty
Date: Wed,  9 Oct 2024 08:08:45 -0700
Message-ID: <20241009150855.804605-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009150855.804605-1-richard.henderson@linaro.org>
References: <20241009150855.804605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Update the addr_write copy within an interval tree node.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 95f78afee6..ec989f1290 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1063,13 +1063,18 @@ static void tlb_set_dirty(CPUState *cpu, vaddr addr)
     addr &= TARGET_PAGE_MASK;
     qemu_spin_lock(&cpu->neg.tlb.c.lock);
     for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
-        tlb_set_dirty1_locked(tlb_entry(cpu, mmu_idx, addr), addr);
-    }
+        CPUTLBDesc *desc = &cpu->neg.tlb.d[mmu_idx];
+        CPUTLBEntryTree *node;
 
-    for (mmu_idx = 0; mmu_idx < NB_MMU_MODES; mmu_idx++) {
-        int k;
-        for (k = 0; k < CPU_VTLB_SIZE; k++) {
-            tlb_set_dirty1_locked(&cpu->neg.tlb.d[mmu_idx].vtable[k], addr);
+        tlb_set_dirty1_locked(tlb_entry(cpu, mmu_idx, addr), addr);
+
+        for (int k = 0; k < CPU_VTLB_SIZE; k++) {
+            tlb_set_dirty1_locked(&desc->vtable[k], addr);
+        }
+
+        node = tlbtree_lookup_addr(desc, addr);
+        if (node) {
+            tlb_set_dirty1_locked(&node->copy, addr);
         }
     }
     qemu_spin_unlock(&cpu->neg.tlb.c.lock);
-- 
2.43.0


