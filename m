Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6E9C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 10:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp3LH-0006b4-7x; Mon, 03 Mar 2025 05:48:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp3LB-0006Zg-Mn; Mon, 03 Mar 2025 05:48:05 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp3LA-0000Lk-4f; Mon, 03 Mar 2025 05:48:05 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22339936bbfso60967865ad.1; 
 Mon, 03 Mar 2025 02:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740998882; x=1741603682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c+Ldo9P2mRH1rFYjnFnNgEjHpXt8fQDaXwALkQh1iqw=;
 b=k7Q9M3BZsBFMz1pJvLwImhsCE+Ip4q1VK2OPR+7yU72NeMEumhXps/0nagmR5iPw/F
 ZkNyB6CHjz9QjmOG6Y0a2rCPbHSxzvVxY5OvMIvtq9n9gfp9tOAUhEKaX2dq1qw8Dlm9
 XDcP6CLeJDtaMWJV0bCWAcQgLBr/AW8wXmykHmqStXTSuLb/ji5nfBbhlYLtUaIneKdh
 1jBw0rfFWej6+QNf0F1x46gY8usUlY35cc7ZgnlwRvnc+sfyFmiaAiQVpr1vmHMDMV1w
 1Va4Xkmp79/4EMS/3q78DR7WhPhWJ8se4uI5M1c2BhJ9Q8d3gfoD37Daz7CF2VNYoDJT
 UCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740998882; x=1741603682;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c+Ldo9P2mRH1rFYjnFnNgEjHpXt8fQDaXwALkQh1iqw=;
 b=s4OPgDjTrLsSTXkWLhC5q0E8G+5wIQ8nWDjcg8mPykJUeJZ7yjt5Q74akXd2MGMkEl
 89s3kez4Hj8jKv1w/HAFGl6jn7RUyrWkOPCz8K4DQOpQdBtiucriZo/Q32uv5kRItHa7
 zmaIFiudno2FgGYRaFpGKyihQYzkPnuvvQ6iXkZkC+MEdzFZnpL9RVSl054OslKJe5WK
 +9h6T1Rknj5vYfT5yMdI+LoAwlODISw5VRD83yxu438b4lH66NesxDWqxqk1P+40pIlA
 MCtGntvypoqOajd3zcpvbMxBpnL0LfDJvjZCIDWIXSAh083/HTiOYYuevGfsFbrVnfEP
 aWHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwWZX1ClHCfDNBHnYwgQQIcbhdh+YIJgYSLsMynVzhZBHTUzE7+CRXOprwYfH8qyXyulElsCUugU8L@nongnu.org
X-Gm-Message-State: AOJu0YzwBLDPMydERZy0hscFX0ump7fZpBCaFReAH9iKILP8hYW3wVTO
 PQ+xIy1z5IzHQAKe+BhWyI9Lz5ypAuEg4lNJ4IsakjQNkgrFGOJoWkjzmA==
X-Gm-Gg: ASbGncvK8WXaibjXP24zra6Y51ymiJdUcL1nEKOAeX+0EFlaRjZ7do8s9kJMIjKCT5L
 MlkZh4EO5jcXrA6bGhYthcaDZRDCMTISm2CehLgEZn6doGzTzcW4mr8wE1+F9uYUCilRng6hbOw
 JDor+aMm9SaRM9U+J4ON7Gh7cOG18bpQsjb6Ua2xGtBHDYP6tm8KD4kvWuRWxoo8feCn9XMKiOC
 POiVLIelDzykUtZYHkBUOsN8oI50fuYDhpK1qUa6LFsUNEja6iwCdPq0e0IUXM/NxwzePXPtdKh
 xfZblOPu7+UB4wEEsakj/1/3237mFIEXQmktTnGvfG/uHa+S8eo=
X-Google-Smtp-Source: AGHT+IHjf1V/kuZwdK5vXjlZ5RWbMmfU44h9j43EH8imzDjik9ghk+q26R70CCCoUq50IF1xm0rt7g==
X-Received: by 2002:a05:6a21:3d94:b0:1f3:26e5:55bc with SMTP id
 adf61e73a8af0-1f326e560e4mr4218957637.42.1740998881703; 
 Mon, 03 Mar 2025 02:48:01 -0800 (PST)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-aee7dec3ce0sm6753837a12.47.2025.03.03.02.47.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 02:48:01 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [RFC PATCH] target/ppc: Do not set HPTE R/C bits on !guest_visible
 xlate
Date: Mon,  3 Mar 2025 20:47:55 +1000
Message-ID: <20250303104755.584897-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Perform !guest_visible memory accesses without modifying R/C bits.

It's arguable whether !guest_visible memory accesses should modify
R/C bits. i386 seems to set accessed/dirty bit updates for "probe"
accesses, but ppc with radix MMU does not. Follow the ppc/radix
lead and perform the accesses without updating R/C bits.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu-hash32.c | 27 ++++++++++++++-------------
 target/ppc/mmu-hash64.c | 27 ++++++++++++++-------------
 2 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 1f791a7f2f7..b8d7f87507b 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -410,19 +410,20 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
 
     /* 8. Update PTE referenced and changed bits if necessary */
-
-    if (!(pte.pte1 & HPTE32_R_R)) {
-        ppc_hash32_set_r(cpu, pte_offset, pte.pte1);
-    }
-    if (!(pte.pte1 & HPTE32_R_C)) {
-        if (access_type == MMU_DATA_STORE) {
-            ppc_hash32_set_c(cpu, pte_offset, pte.pte1);
-        } else {
-            /*
-             * Treat the page as read-only for now, so that a later write
-             * will pass through this function again to set the C bit
-             */
-            prot &= ~PAGE_WRITE;
+    if (guest_visible) {
+        if (!(pte.pte1 & HPTE32_R_R)) {
+            ppc_hash32_set_r(cpu, pte_offset, pte.pte1);
+        }
+        if (!(pte.pte1 & HPTE32_R_C)) {
+            if (access_type == MMU_DATA_STORE) {
+                ppc_hash32_set_c(cpu, pte_offset, pte.pte1);
+            } else {
+                /*
+                 * Treat the page as read-only for now, so that a later write
+                 * will pass through this function again to set the C bit
+                 */
+                prot &= ~PAGE_WRITE;
+            }
         }
     }
     *protp = prot;
diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index 5ca4faee2ab..de5eb5fb221 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -1183,19 +1183,20 @@ bool ppc_hash64_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
 
     /* 6. Update PTE referenced and changed bits if necessary */
-
-    if (!(pte.pte1 & HPTE64_R_R)) {
-        ppc_hash64_set_r(cpu, ptex, pte.pte1);
-    }
-    if (!(pte.pte1 & HPTE64_R_C)) {
-        if (access_type == MMU_DATA_STORE) {
-            ppc_hash64_set_c(cpu, ptex, pte.pte1);
-        } else {
-            /*
-             * Treat the page as read-only for now, so that a later write
-             * will pass through this function again to set the C bit
-             */
-            prot &= ~PAGE_WRITE;
+    if (guest_visible) {
+        if (!(pte.pte1 & HPTE64_R_R)) {
+            ppc_hash64_set_r(cpu, ptex, pte.pte1);
+        }
+        if (!(pte.pte1 & HPTE64_R_C)) {
+            if (access_type == MMU_DATA_STORE) {
+                ppc_hash64_set_c(cpu, ptex, pte.pte1);
+            } else {
+                /*
+                 * Treat the page as read-only for now, so that a later write
+                 * will pass through this function again to set the C bit
+                 */
+                prot &= ~PAGE_WRITE;
+            }
         }
     }
 
-- 
2.47.1


