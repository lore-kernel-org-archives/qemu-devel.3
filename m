Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC7CCEDDA3
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYJL-0001PQ-HQ; Wed, 09 Oct 2024 11:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJH-0001Ky-7B
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:07 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJE-0007wx-PK
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:06 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71dea49e808so4428411b3a.1
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728486543; x=1729091343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GFCnPzqY9yPtIcUh428jqMbY/g4iHxajC+FeFvs691s=;
 b=mCC7yv3SUkGOXH4sVANwqX3+PuLqueNjSxGsNAABdCilRtO1KGNPS8AzXPSFz093pz
 g7F3IU0FTrq3LpNAB3xnAVGAtDXIoP3adbSck0gu5S2cwL3zhwSHubGuDQRu/9zWym60
 3Bcyk962SQRjwC8nmoba+0geMHVi+cKVtzw2BtRbgtZVRb2QzX6LPEQewRPTAesB7EJK
 Z3EcCacFUUUedJx0hpCBoqZV3H+MjRVPj0CP3G5k4cwo6GAFF0ssOGO7bPa3vZn+QND8
 O5oXvTmuZwXj/VwgPiaJKbGa3AMmvqy2a3Gy/XcqYfnfGmg9g/AfC6MyaKxFzc0ISG6W
 NnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486543; x=1729091343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GFCnPzqY9yPtIcUh428jqMbY/g4iHxajC+FeFvs691s=;
 b=RXmq6eDTz8As07/UNuyosuWlmmeuuDgbg9ye9bY7nF0vaG4NjbSejK9BrrGmoLw85O
 Dqc8yqC/7zF8+iinKWN8xjsWZoPx9oH8lMjLtietpxh3ooZIR3TqOFaiAvG/qd4O+W4U
 CHxSRkekH9PC9zYhmDrUtUQaTrDKxzfXUNY8eUYx8+FSjFDdqizUBuyrfbJj98ZGG8Sa
 fxwR/+RL1R+KOjrwwBypwGI2J3Fj+zuj7/2hU3ONffrZd87jIxel3ovarDx7LGMQBTFf
 zeT8SF5E6jbXv9OWog/I+Es6W1hkbZCwCDod/N4gsqrP2LP6e5Mr7jtXyjIKORn0rMe8
 0yDA==
X-Gm-Message-State: AOJu0YxtHQBlYDbYb9NMvhshmcpuoMERMxgKPEZFpEOUqdxkbN1gIeUE
 qd9sZ9K8VXrFNUufNwaZPmpplzYbLIOgbguTeZnSJIEaxu228AxuM9SrRy21kb5yz/0CKXRg3L1
 0
X-Google-Smtp-Source: AGHT+IEfn/SZ+7K01hmmkXmSC71xAeP6HhI7oc7Ht7OKHdmUD5JRdAJ+0be1TSyHE3P/MzPZQJO6EQ==
X-Received: by 2002:a05:6a20:b807:b0:1d8:a49b:ee62 with SMTP id
 adf61e73a8af0-1d8a49bf013mr3402933637.19.1728486543421; 
 Wed, 09 Oct 2024 08:09:03 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d65278sm7881094b3a.160.2024.10.09.08.09.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:09:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/23] accel/tcg: Flush entire tlb when a masked range wraps
Date: Wed,  9 Oct 2024 08:08:39 -0700
Message-ID: <20241009150855.804605-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009150855.804605-1-richard.henderson@linaro.org>
References: <20241009150855.804605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

We expect masked address spaces to be quite large, e.g. 56 bits
for AArch64 top-byte-ignore mode.  We do not expect addr+len to
wrap around, but it is possible with AArch64 guest flush range
instructions.

Convert this unlikely case to a full tlb flush.  This can simplify
the subroutines actually performing the range flush.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 93b42d18ee..8affa25db3 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -808,8 +808,12 @@ void tlb_flush_range_by_mmuidx(CPUState *cpu, vaddr addr,
         tlb_flush_page_by_mmuidx(cpu, addr, idxmap);
         return;
     }
-    /* If no page bits are significant, this devolves to tlb_flush. */
-    if (bits < TARGET_PAGE_BITS) {
+    /*
+     * If no page bits are significant, this devolves to full flush.
+     * If addr+len wraps in len bits, fall back to full flush.
+     */
+    if (bits < TARGET_PAGE_BITS
+        || (bits < TARGET_LONG_BITS && (addr ^ (addr + len - 1)) >> bits)) {
         tlb_flush_by_mmuidx(cpu, idxmap);
         return;
     }
@@ -849,8 +853,12 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
         tlb_flush_page_by_mmuidx_all_cpus_synced(src_cpu, addr, idxmap);
         return;
     }
-    /* If no page bits are significant, this devolves to tlb_flush. */
-    if (bits < TARGET_PAGE_BITS) {
+    /*
+     * If no page bits are significant, this devolves to full flush.
+     * If addr+len wraps in len bits, fall back to full flush.
+     */
+    if (bits < TARGET_PAGE_BITS
+        || (bits < TARGET_LONG_BITS && (addr ^ (addr + len - 1)) >> bits)) {
         tlb_flush_by_mmuidx_all_cpus_synced(src_cpu, idxmap);
         return;
     }
-- 
2.43.0


