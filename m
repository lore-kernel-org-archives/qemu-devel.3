Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DC3C3ABC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJbj-0003AH-QJ; Sun, 11 May 2025 23:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJap-000073-7n; Sun, 11 May 2025 23:12:40 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJam-0006ri-D1; Sun, 11 May 2025 23:12:38 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3081fe5987eso3601479a91.3; 
 Sun, 11 May 2025 20:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019554; x=1747624354; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WpRwN3HWni9vQioSB7tOQ37huVCXehOX4rurQ1W1P98=;
 b=jk/mzaE6w+RzM+uTW1e9WAI+rpo2wPwPOmvib+WmvtnebCeeZ5KJGxB/FY2zPgJGdR
 IQkPonkW6Ara+tDnc0+GCzzNqTAzMv5rOMJm0TZEexW907TMPDqfEN121y3J72yVGr0K
 xjo/IKDglt62920m/bdC4Zs0zzadOspgoycZVdg78DSHWkO7ZfMwgEY4ROT5QN7sBcRK
 hrEZZdWm206t4phEW0O03IEdd6S3Cj4c5WMd272tNWrynOBUWUFIxEybRs7kmt2TzBMN
 APbTi3hou1Mu2CTLsxZ8IVjok5MHmqzvmS9sLF9IHXjbllUUGxi+J1bYmzPFr8i1fIv6
 mrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019554; x=1747624354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WpRwN3HWni9vQioSB7tOQ37huVCXehOX4rurQ1W1P98=;
 b=Qu8Fd7PhrFIOKbvmTBhP5MJn4vgXfFYu/1P+1Jcpd+XSZLQ8UTWIXtOjpZC5tL0zbA
 PE8QHmBvnK0gSF0eG1mh2VTZvxim4C7t+KWIop9x1uRQN5saXk1mcqNOYa5ClJEP2gca
 JbcQ7UZmjEa/td2JL7ganzzXkrBAHXpjKUuzc9lkQsoUD3En5iPvZAtPWhu1ziiDkQCF
 EDsYoWhn8W1qym+HIVrUJ0bfsrbbILY75bV/Vu7FQrrch8YendjXF91IHK1litOzWUoa
 uoJCz2fkhGsAxadlV/yo8/B4f0rN6O3bbPMpA893STSeISE7YopZssAmuknLeZtt9kF+
 L5kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvd6RZgqb8YbUbs/hlo3vLRj558D8sn1yx+AKMBJ3kTUvWQQvXcdsbyaipFFlSnKdPGa+G84Dxwm/x@nongnu.org
X-Gm-Message-State: AOJu0Yy+Dp33wvpkRPYxycNOlHaDovdhPYC5OxmvMBA/xOsCJxbJ2m8z
 DGUyGWeD/gY8TOtVtnOc/mk44si5whxQ0qWQNPA49I6UguV8TPYIZBTAug==
X-Gm-Gg: ASbGnctEfqQX3uQT76Hs/GzOTkzJIfPDcsxNIiCE67Eqf+ws1Rw+Bf1Ny0revMvIu7i
 wB16vTbrea52UX+SOrMJPU1+FI3UIfDz7ReyL0i+ZyEskV2dcnwERKuFor/Chpbwan8tXxjKfk7
 XmmIkkLv8np+8VrhbLpYY531hyhXR8ltEXEX7A0qv5Ddabt0M2cMhb4HxSK597/eMyJFNZNHFRe
 OSMSB3+HMtv6AzUqy9UyqXjHY0RdWO2ZwrLa9swecdwR66Pz2A1/nZd+hUmcTvvRa0CCb7sIYEV
 Bxd+VrdDeOll/pd/TCb/b1QsvCSus1+dC4H8c/JSuKmysOLqtvaRd5zP/Q==
X-Google-Smtp-Source: AGHT+IHKmv7N/aqOliY6yTPkuLPUSttz3CWDpEt9slezbvxTC4dUVHlM1C4pyhutQCdnlue7meA7EA==
X-Received: by 2002:a17:90b:3c0a:b0:2ee:f440:53ed with SMTP id
 98e67ed59e1d1-30c3d65e84dmr17996698a91.31.1747019554150; 
 Sun, 11 May 2025 20:12:34 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:12:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 23/50] ppc/xive: Add more interrupt notification tracing
Date: Mon, 12 May 2025 13:10:32 +1000
Message-ID: <20250512031100.439842-24-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1036.google.com
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

From: Glenn Miles <milesg@linux.ibm.com>

Add more tracing around notification, redistribution, and escalation.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
---
 hw/intc/trace-events |  6 ++++++
 hw/intc/xive.c       |  3 +++
 hw/intc/xive2.c      | 13 ++++++++-----
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/hw/intc/trace-events b/hw/intc/trace-events
index f77f9733c9..9eca0925b6 100644
--- a/hw/intc/trace-events
+++ b/hw/intc/trace-events
@@ -279,6 +279,8 @@ xive_tctx_notify(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_
 xive_tctx_set_cppr(uint32_t index, uint8_t ring, uint8_t ipb, uint8_t pipr, uint8_t cppr, uint8_t nsr) "target=%d ring=0x%x IPB=0x%02x PIPR=0x%02x new CPPR=0x%02x NSR=0x%02x"
 xive_source_esb_read(uint64_t addr, uint32_t srcno, uint64_t value) "@0x%"PRIx64" IRQ 0x%x val=0x%"PRIx64
 xive_source_esb_write(uint64_t addr, uint32_t srcno, uint64_t value) "@0x%"PRIx64" IRQ 0x%x val=0x%"PRIx64
+xive_source_notify(uint32_t srcno) "Processing notification for queued IRQ 0x%x"
+xive_source_blocked(uint32_t srcno) "No action needed for IRQ 0x%x currently"
 xive_router_end_notify(uint8_t end_blk, uint32_t end_idx, uint32_t end_data) "END 0x%02x/0x%04x -> enqueue 0x%08x"
 xive_router_end_escalate(uint8_t end_blk, uint32_t end_idx, uint8_t esc_blk, uint32_t esc_idx, uint32_t end_data) "END 0x%02x/0x%04x -> escalate END 0x%02x/0x%04x data 0x%08x"
 xive_tctx_tm_write(uint32_t index, uint64_t offset, unsigned int size, uint64_t value) "target=%d @0x%"PRIx64" sz=%d val=0x%" PRIx64
@@ -289,6 +291,10 @@ xive_end_source_read(uint8_t end_blk, uint32_t end_idx, uint64_t addr) "END 0x%x
 # xive2.c
 xive_nvp_backlog_op(uint8_t blk, uint32_t idx, uint8_t op, uint8_t priority, uint8_t rc) "NVP 0x%x/0x%x operation=%d priority=%d rc=%d"
 xive_nvgc_backlog_op(bool c, uint8_t blk, uint32_t idx, uint8_t op, uint8_t priority, uint32_t rc) "NVGC crowd=%d 0x%x/0x%x operation=%d priority=%d rc=%d"
+xive_redistribute(uint32_t index, uint8_t ring, uint8_t end_blk, uint32_t end_idx) "Redistribute from target=%d ring=0x%x NVP 0x%x/0x%x"
+xive_end_enqueue(uint8_t end_blk, uint32_t end_idx, uint32_t end_data) "Queue event for END 0x%x/0x%x data=0x%x"
+xive_escalate_end(uint8_t end_blk, uint32_t end_idx, uint8_t esc_blk, uint32_t esc_idx, uint32_t esc_data) "Escalate from END 0x%x/0x%x to END 0x%x/0x%x data=0x%x"
+xive_escalate_esb(uint8_t end_blk, uint32_t end_idx, uint32_t lisn) "Escalate from END 0x%x/0x%x to LISN=0x%x"
 
 # pnv_xive.c
 pnv_xive_ic_hw_trigger(uint64_t addr, uint64_t val) "@0x%"PRIx64" val=0x%"PRIx64
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 1a94642c62..7461dbecb8 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1276,6 +1276,7 @@ static uint64_t xive_source_esb_read(void *opaque, hwaddr addr, unsigned size)
 
         /* Forward the source event notification for routing */
         if (ret) {
+            trace_xive_source_notify(srcno);
             xive_source_notify(xsrc, srcno);
         }
         break;
@@ -1371,6 +1372,8 @@ out:
     /* Forward the source event notification for routing */
     if (notify) {
         xive_source_notify(xsrc, srcno);
+    } else {
+        trace_xive_source_blocked(srcno);
     }
 }
 
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 34fc561c9c..968b698677 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -616,6 +616,7 @@ static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx,
     uint8_t prio_limit;
     uint32_t cfg;
 
+    trace_xive_redistribute(tctx->cs->cpu_index, ring, nvp_blk, nvp_idx);
     /* convert crowd/group to blk/idx */
     if (group > 0) {
         nvgc_idx = (nvp_idx & (0xffffffff << group)) |
@@ -1455,6 +1456,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
     }
 
     if (!redistribute && xive2_end_is_enqueue(&end)) {
+        trace_xive_end_enqueue(end_blk, end_idx, end_data);
         xive2_end_enqueue(&end, end_data);
         /* Enqueuing event data modifies the EQ toggle and index */
         xive2_router_write_end(xrtr, end_blk, end_idx, &end, 1);
@@ -1631,11 +1633,11 @@ do_escalation:
          * Perform END Adaptive escalation processing
          * The END trigger becomes an Escalation trigger
          */
-        xive2_router_end_notify(xrtr,
-                               xive_get_field32(END2_W4_END_BLOCK,     end.w4),
-                               xive_get_field32(END2_W4_ESC_END_INDEX, end.w4),
-                               xive_get_field32(END2_W5_ESC_END_DATA,  end.w5),
-                               false);
+        uint8_t esc_blk = xive_get_field32(END2_W4_END_BLOCK, end.w4);
+        uint32_t esc_idx = xive_get_field32(END2_W4_ESC_END_INDEX, end.w4);
+        uint32_t esc_data = xive_get_field32(END2_W5_ESC_END_DATA, end.w5);
+        trace_xive_escalate_end(end_blk, end_idx, esc_blk, esc_idx, esc_data);
+        xive2_router_end_notify(xrtr, esc_blk, esc_idx, esc_data, false);
     } /* end END adaptive escalation */
 
     else {
@@ -1652,6 +1654,7 @@ do_escalation:
         lisn = XIVE_EAS(xive_get_field32(END2_W4_END_BLOCK,     end.w4),
                         xive_get_field32(END2_W4_ESC_END_INDEX, end.w4));
 
+        trace_xive_escalate_esb(end_blk, end_idx, lisn);
         xive2_notify(xrtr, lisn, true /* pq_checked */);
     }
 
-- 
2.47.1


