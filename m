Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3408BD68B33
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcI3-0004z4-EZ; Thu, 14 Nov 2024 11:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcI1-0004xn-8e
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:49 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcHu-0002D5-NU
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:49 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e9b4a5862fso689740a91.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600101; x=1732204901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=u1afL0RFM67W2rOuMJqQQROG23LY3jQbGC8krRZVFcY=;
 b=yVR9gF63XvgesbIfGba7n9fZZX3hgXVni7+13PJkbUps6RHYDnGg2P4+cSMPzpuy3y
 lpDuKyNvrh09B3elyqfRp1fd269Prs2+5XyXStCq7KYjkI9+5upKjiXByxVIz1U52fA0
 2qsUCYtSpoPN4ZtTOlZCyj9Ur7ZW+hFuRKx0qvV0RBzrGt++jeNBUu1N/iSlbwyDqSw9
 7ByqYW2iyGKJIUUmTa3kLkBaNKbo/F+/9a/fArGzHg5GlcZ2+NzsRIWrSAqSon1bqBnP
 aRYonFMxGQtFXLNCBkgek05k1QtI0zbf811nR4lBFvdWua2uv7qVYxS54IC81soNpPlY
 pLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600101; x=1732204901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u1afL0RFM67W2rOuMJqQQROG23LY3jQbGC8krRZVFcY=;
 b=IQ+wS5vaSLobUmx/pgrpuOoCwhaqrajh841WkJz3H3sevGmZ8blqtBJQ4BMq+1sa44
 zNixf5/ptjJhZyJOsfeHHWn1Tfs7oiwPDIeARN/C2qeD5EWxCFR/APGwscT3xFQBmwrS
 kSxOQseKhVFFszkwFbNR8aUDfprQXxyXMItGcQq171uKsNKtnkl3/2ugSKqoW52GS8+Q
 fOyPSP0br85ZKhr3oBgAp2fQp35+g1So5ERhEGcRBLhGzJlRJCtyA+PvtQ/rRP2c42xa
 0MnKZiZth1UuLDPf4kL/rMvvbxTGqX6gxoTQwrBuoc3hHG3gAem/1linqIMF3XrkXDZW
 0KkA==
X-Gm-Message-State: AOJu0YzAlebavtB2CGB6KY3wAMboH/7N2mhFUgAmHchQOYHyWiB1KpMH
 wni8yWuZRqiHGOZGjrq7Q7TFE7uEXa9JFQwWS+n/FxFfcd3a4/uqvxvn1YZWkof3yWrfW4zWe0U
 2
X-Google-Smtp-Source: AGHT+IGd2wESbeUDZWZyULrJlD6ZhjqMg0umkV9Malj8l88C1hYJaC10rZTqQ9ZwkfZTBuGon/ZBDQ==
X-Received: by 2002:a17:90b:4a90:b0:2d1:bf48:e767 with SMTP id
 98e67ed59e1d1-2e9e4c73b9bmr14198227a91.29.1731600101380; 
 Thu, 14 Nov 2024 08:01:41 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 12/54] accel/tcg: Remove IntervalTree entries in
 tlb_flush_range_locked
Date: Thu, 14 Nov 2024 08:00:48 -0800
Message-ID: <20241114160131.48616-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

Flush a masked range of pages from the IntervalTree cache.
When the mask is not used there is a redundant comparison,
but that is better than duplicating code at this point.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index d532d69083..e2c855f147 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -311,6 +311,13 @@ static CPUTLBEntryTree *tlbtree_lookup_range(CPUTLBDesc *desc, vaddr s, vaddr l)
     return i ? container_of(i, CPUTLBEntryTree, itree) : NULL;
 }
 
+static CPUTLBEntryTree *tlbtree_lookup_range_next(CPUTLBEntryTree *prev,
+                                                  vaddr s, vaddr l)
+{
+    IntervalTreeNode *i = interval_tree_iter_next(&prev->itree, s, l);
+    return i ? container_of(i, CPUTLBEntryTree, itree) : NULL;
+}
+
 static CPUTLBEntryTree *tlbtree_lookup_addr(CPUTLBDesc *desc, vaddr addr)
 {
     return tlbtree_lookup_range(desc, addr, addr);
@@ -739,6 +746,8 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
     CPUTLBDesc *d = &cpu->neg.tlb.d[midx];
     CPUTLBDescFast *f = &cpu->neg.tlb.f[midx];
     vaddr mask = MAKE_64BIT_MASK(0, bits);
+    CPUTLBEntryTree *node;
+    vaddr addr_mask, last_mask, last_imask;
 
     /*
      * Check if we need to flush due to large pages.
@@ -759,6 +768,22 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
         vaddr page = addr + i;
         tlb_flush_vtlb_page_mask_locked(cpu, midx, page, mask);
     }
+
+    addr_mask = addr & mask;
+    last_mask = addr_mask + len - 1;
+    last_imask = last_mask | ~mask;
+    node = tlbtree_lookup_range(d, addr_mask, last_imask);
+    while (node) {
+        CPUTLBEntryTree *next =
+            tlbtree_lookup_range_next(node, addr_mask, last_imask);
+        vaddr page_mask = node->itree.start & mask;
+
+        if (page_mask >= addr_mask && page_mask < last_mask) {
+            interval_tree_remove(&node->itree, &d->iroot);
+            g_free(node);
+        }
+        node = next;
+    }
 }
 
 typedef struct {
-- 
2.43.0


