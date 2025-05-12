Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B91C3ABC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJaC-0007Rn-9i; Sun, 11 May 2025 23:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJaA-0007Ov-HM; Sun, 11 May 2025 23:11:58 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJa8-0006mw-Nt; Sun, 11 May 2025 23:11:58 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7418e182864so2901218b3a.1; 
 Sun, 11 May 2025 20:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019514; x=1747624314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/66Hz+19pOAn4jKgYHKfXn5ifeOLo43bO50HaUuUavI=;
 b=PsjYbKT2zpYqmZRMMY+AP0JE0/bte+b+MKZhuyOMuPoo/4695dQkuHCqYrIwxYvT45
 XxJllNTIZk7BH14j/NQDjAzC+q7ApPzDCWYO54uU5ysSckJ7YzSorZGs1fKDRaXaUZmt
 1rgPz1i8c5j/IpxIZjR8d9I2yqANHViL1YSE51Y/xVSi5j6jeXHi0v9mWgPKzNarUYNX
 em/JH3NcVhMB5s81bubbDI+gvtlNlQhPlQTah9/6OVzOr9YwYBysqoMD9xgXiIpnb3TH
 omF6dEFbdGBdRK70h1Q52VKgM6rdwl5Qw9JaX610w55I/txYXK7nJRjQ/zwXgHFZW9T3
 SNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019514; x=1747624314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/66Hz+19pOAn4jKgYHKfXn5ifeOLo43bO50HaUuUavI=;
 b=vBPXJ6vTjx/gna/c17hP/6IVsktDm6bb0fCXDkP3GqjuDS8P82iXLWQ4X8IBZW8O6t
 VCpVYH1WCZ6Mk3GtnfldnBj6B8vQJmFR4cig9Z2mvPx0LHoISrY9VreSkME5AiJ59dFJ
 71kO+KKX5tZvkwLvhbRxYIPJScQVKPmxJMDF7h88eWN/mr8e2pHlAi3+uEd3F4hnVTH9
 Diet3C6zp5csCja8HycaBc8EOe38b/x+VlX63VtbalPnCHG9hJ/cN+vhraVFezrYpPwn
 4B0fdcLBRfVs7lvhxJehqv0Jyq6gj40Vxbh4dgs+a2nf+3r6TCW3Yizj8dG/iZyQqpHk
 5jHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8byc2WXeFBMbgyq2ZXTB5okXNnAWTFJ20FalCnxcU9UpZi+pN1hrXjp2LqNh7ZXwW2lUtGbzOIYc+@nongnu.org
X-Gm-Message-State: AOJu0Yx+M7SL8iUCpnV2QgXOlLwIKjCKQPLBnVTC/BTsKqJNCPGOIPB7
 Z7Ya6mzazGVSn7XlHrFwhPvzmwXze2rgsrjMl6JiiUw9lh+kn4x7n7E39w==
X-Gm-Gg: ASbGnctbn3F9fA0VhIrEw6sjHpAxAqSoW0VP4WbeRf6lgnGblMShi87/a3ytD5L4NPc
 9HoSFGGWD6u3K8HPD+cSJj/kJXI3nkoinPwrH3hAV+qarOTedVmpdsYRRVMbf3vlMl8yGHDHGIb
 aG4FROzPraHYx528lX3FOzX6NU3CHQ6N4btUGJESE9C/mSiqz+ApEM0SOWfq67hd95zQpFJzZNN
 oxNh5aGPCxKePtfQwdstPPmVUMalqmNps1IKQEUI90MfryRG3rF3eDkGdyyunEK4jLfsTmcclxO
 YQluKaTGnVSPTB3YWkius0yf+nrJmYy2jbwQsDJkOGsir5fpx6eZxzSs5Q==
X-Google-Smtp-Source: AGHT+IHNbjRlaOUQ/fA0bq8aGRYXCHc8HzY3hqYVzpiYTaU4PuxXhkhKWGgns3UX/+AXtKlmhCNAqg==
X-Received: by 2002:a05:6a00:4b01:b0:740:b5f9:90b4 with SMTP id
 d2e1a72fcca58-7423bfe3a32mr15633658b3a.17.1747019513660; 
 Sun, 11 May 2025 20:11:53 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:11:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 12/50] ppc/xive2: Set CPPR delivery should account for group
 priority
Date: Mon, 12 May 2025 13:10:21 +1000
Message-ID: <20250512031100.439842-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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

The group interrupt delivery flow selects the group backlog scan if
LSMFB < IPB, but that scan may find an interrupt with a priority >=
IPB. In that case, the VP-direct interrupt should be chosen. This
extends to selecting the lowest prio between POOL and PHYS rings.

Implement this just by re-starting the selection logic if the
backlog irq was not found or priority did not match LSMFB (LSMFB
is updated so next time around it would see the right value and
not loop infinitely).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive2.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 8ede95b671..de139dcfbf 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -939,7 +939,7 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
 {
     uint8_t *regs = &tctx->regs[ring];
     Xive2Router *xrtr = XIVE2_ROUTER(tctx->xptr);
-    uint8_t old_cppr, backlog_prio, first_group, group_level = 0;
+    uint8_t old_cppr, backlog_prio, first_group, group_level;
     uint8_t pipr_min, lsmfb_min, ring_min;
     bool group_enabled;
     uint32_t nvp_blk, nvp_idx;
@@ -961,10 +961,12 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
      * Recompute the PIPR based on local pending interrupts. It will
      * be adjusted below if needed in case of pending group interrupts.
      */
+again:
     pipr_min = xive_ipb_to_pipr(regs[TM_IPB]);
     group_enabled = !!regs[TM_LGS];
-    lsmfb_min = (group_enabled) ? regs[TM_LSMFB] : 0xff;
+    lsmfb_min = group_enabled ? regs[TM_LSMFB] : 0xff;
     ring_min = ring;
+    group_level = 0;
 
     /* PHYS updates also depend on POOL values */
     if (ring == TM_QW3_HV_PHYS) {
@@ -998,9 +1000,6 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
         }
     }
 
-    /* PIPR should not be set to a value greater than CPPR */
-    regs[TM_PIPR] = (pipr_min > cppr) ? cppr : pipr_min;
-
     rc = xive2_tctx_get_nvp_indexes(tctx, ring_min, &nvp_blk, &nvp_idx);
     if (rc) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: set CPPR on invalid context\n");
@@ -1019,7 +1018,7 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
 
     if (group_enabled &&
         lsmfb_min < cppr &&
-        lsmfb_min < regs[TM_PIPR]) {
+        lsmfb_min < pipr_min) {
         /*
          * Thread has seen a group interrupt with a higher priority
          * than the new cppr or pending local interrupt. Check the
@@ -1048,12 +1047,25 @@ static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
                                                     nvp_blk, nvp_idx,
                                                     first_group, &group_level);
         tctx->regs[ring_min + TM_LSMFB] = backlog_prio;
-        if (backlog_prio != 0xFF) {
-            xive2_presenter_backlog_decr(tctx->xptr, nvp_blk, nvp_idx,
-                                         backlog_prio, group_level);
-            regs[TM_PIPR] = backlog_prio;
+        if (backlog_prio != lsmfb_min) {
+            /*
+             * If the group backlog scan finds a less favored or no interrupt,
+             * then re-do the processing which may turn up a more favored
+             * interrupt from IPB or the other pool. Backlog should not
+             * find a priority < LSMFB.
+             */
+            g_assert(backlog_prio >= lsmfb_min);
+            goto again;
         }
+
+        xive2_presenter_backlog_decr(tctx->xptr, nvp_blk, nvp_idx,
+                                     backlog_prio, group_level);
+        pipr_min = backlog_prio;
     }
+
+    /* PIPR should not be set to a value greater than CPPR */
+    regs[TM_PIPR] = (pipr_min > cppr) ? cppr : pipr_min;
+
     /* CPPR has changed, check if we need to raise a pending exception */
     xive_tctx_notify(tctx, ring_min, group_level);
 }
-- 
2.47.1


