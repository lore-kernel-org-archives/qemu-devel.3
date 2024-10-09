Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFF6CEDDA4
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYJQ-0001X2-WE; Wed, 09 Oct 2024 11:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJM-0001Pj-9c
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:12 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJJ-0007xv-CF
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:12 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71e0c3e85c5so2366957b3a.2
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728486547; x=1729091347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Bw8T/FPM8CxFXoYkswVTq6Tu5U9eEUUb80nQFyOk+OE=;
 b=Qhp1h3R4guvq91RxhwmD5rn17dy9osN7Z9JU1yvWTzAy7Jgi151KuBz+I/YNzr5ZWC
 6dUPj+/ELA7XisauEPJd3zYaePPsn3aKh5ioxaGyDF7vWqX+K4vi6nw4VjVJnVoBgxfd
 1PumtWQ16c/a4586L0mBGRxOrTYwHpJCGDHz0SRU3CidQbh4XtnEU8s07dZJdA2l8qZ0
 RYHv6YReX6ZlC0Le3rKVsQ9NG8FL1nIPvMaVU3++zTLEwSoUAChkAK5R0bXKDUcVCHSN
 QNCvsffrh71fm7V3a7QJWts2dZFX1pah58toeu8zQ4pCd7gFA5Z489c5Ys4+wrMbVBJx
 qFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486547; x=1729091347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bw8T/FPM8CxFXoYkswVTq6Tu5U9eEUUb80nQFyOk+OE=;
 b=vXNYAtOCJ7llKoRMETy8/f20GW0eKpFTAC7iRiMX7wKa6ff+17IFyPKvrFWYbTFRxQ
 h43x9biB2f/M6exfVv4nReWWUl0XF5TrcxpNDQEtRwG6nInbbEkZQGuMAQh8pfXmAJys
 hQUEszT5YlC9Pymwv08QHvfxUBpmtx1n5MeiO9HzFi2fH+Ta3OT6YlaFg9e76RXvpmUh
 23fwnyUf1wBNrJrGH0Fsv0+LPjXLubwjxbZdNKzOO5aoKWg9Ch7QMPAvjX8y5AeMSAQj
 g7PskEg7jT01t56tUPq3blPtlXwdqXt0r1wleJ9WToCkPJwqgBLw9oIH1qAlyJANKa2r
 5SOQ==
X-Gm-Message-State: AOJu0YwZ0I4q+JxIW8WDIZv8XF7/okfsnJmr102m2VKM+bdOJ2pSvfeH
 o5codWH5B5hifkSKnNL54bC1zWMegjQeDJA/y/WQO6IFMbsB0o0XUPbixizJGoxpHo8XeoOc58n
 i
X-Google-Smtp-Source: AGHT+IHr0kI9YWbMCiMzLX6fOgD5JJc0LIrGJfKs77W4mNmDCvHKi0YAxxTG9gtb6wJ+4/7PtAMdWw==
X-Received: by 2002:a05:6a00:1886:b0:71e:3b8:666b with SMTP id
 d2e1a72fcca58-71e1db85a2dmr3439258b3a.15.1728486546795; 
 Wed, 09 Oct 2024 08:09:06 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d65278sm7881094b3a.160.2024.10.09.08.09.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:09:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/23] accel/tcg: Remove IntervalTree entries in
 tlb_flush_range_locked
Date: Wed,  9 Oct 2024 08:08:43 -0700
Message-ID: <20241009150855.804605-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009150855.804605-1-richard.henderson@linaro.org>
References: <20241009150855.804605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
index 772656c7f8..709ad75616 100644
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
@@ -744,6 +751,8 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
     CPUTLBDesc *d = &cpu->neg.tlb.d[midx];
     CPUTLBDescFast *f = &cpu->neg.tlb.f[midx];
     vaddr mask = MAKE_64BIT_MASK(0, bits);
+    CPUTLBEntryTree *node;
+    vaddr addr_mask, last_mask, last_imask;
 
     /*
      * Check if we need to flush due to large pages.
@@ -764,6 +773,22 @@ static void tlb_flush_range_locked(CPUState *cpu, int midx,
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


