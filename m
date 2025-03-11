Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0A8C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzKG-000741-Dm; Tue, 11 Mar 2025 09:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDW-0004aS-H6; Tue, 11 Mar 2025 09:00:23 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDS-0008IS-9b; Tue, 11 Mar 2025 09:00:18 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-224341bbc1dso67975095ad.3; 
 Tue, 11 Mar 2025 06:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698009; x=1742302809; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s/XBvKPmghhbKFfzwm85aRAZZaLgzLWVK0EV9GNbOE4=;
 b=A4yTrPFCvwtbO/SEY6UeeeKqTYgJRD0oP3aNJIMWaXyhxJ94/5Rc2V/TA8LFzfpI9L
 gEeOgS+OnpbmaQ8LI76paYJs1aH7ogMvGjpKWWkKmjBVbEukuIGpjenjANAC5ixDc5CM
 xsdPFwyHDJWM0B97kyUPWDRsm1itnFZOLMLZJIbcEPfF/qGHm36ky3Wk/RIzX790TKuf
 auYvfwy4GAjoIIkj/oofI4MAnp4ntOnSbcaPKvYsK+BnwcX8kZaF/Y14u6TDCcsBpvKQ
 41/nor1Wd4VhZjJ79kSuN1alEN6UZitydDgNUAPbCxcxRw+2NTh9SoYQx4hkMr9Z/edt
 4PUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698009; x=1742302809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s/XBvKPmghhbKFfzwm85aRAZZaLgzLWVK0EV9GNbOE4=;
 b=HAkr3Xz9/Hg+FmNW+P5vRQ+8F1nyhZpM5xDkIPYvxLzvBkPffAzHsNH7To/HGu5aBX
 08aXzcebvO460OrPeEVFpfEvrn60/oHw387S9xILb42N3emcWDUNQOxfxUe10Lx6PiCV
 VqKKXZucjWxaIFlRlod8krqfNTHQxeCa/wpU861v93OyMU6cdOLHv/MvEO3q7KUeUcw4
 xGaqIoj1LrPkiSfeSMkuM0c5KJybgkRpAKEk3QLfU48rHQvo0PKhFMQPGhPxHz2ns3Gg
 Ov0biT+hsvZZ3n62vdj+TORhiEhLwcJbsARW65nqMxEObrvON/FpZxWm5mWBFpFfKiuH
 8isg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhRU4PHEWFynbcTilie8T/+BK95hYccZNR9Mc8YgilhLt/L8phirT6sgnSX82xbgz4jqVMoOJ9HA==@nongnu.org
X-Gm-Message-State: AOJu0YzekYfY+WwnbhfAZWVY2wch9D1ZGMhMll3k5TJe8U0md2CP4RE9
 bQj4PWVIL045vLDXVBI/EBbxnPd8tfTDl+u5gxabVOpAqOMdsxGVwkqa9g==
X-Gm-Gg: ASbGncubJFjaHH3BDfu/pdgtM25sB7VhwpaeU4kIVNxLRaM69uo3li5Kcc0kVwdayes
 nnPSWDoV9Aa7WrAQc81hvpmhhvmYJnzSYFEpWR4yoWFTH0wLZiKxvrIFiXW4R9VDahl8TcMd6ZM
 aO85yS8GDoUqAjJvM01HeXzHDagT5LFJ16pqAx5K9Jq9a07GAGQVNHFM/JTM2XVySM5fxdxR0Pw
 RfftX3PiptKYDc0M6yuSRRJMhSs1kuxso89CwtT5l4eDBRdFUctwRaMdQHFy11yNBTpWB8dG25m
 SiX9neP6IQ4ANYMD377rmOLyZIZj7ODXI2z0Sy3o2po9jIVDXXM=
X-Google-Smtp-Source: AGHT+IF1qSFvQdY4aQMYNsKVRb3BvJiV+sYcoOGgGY4PNlhMGzMIka3DoYXRPPzXncEghUctBhYk2A==
X-Received: by 2002:a17:902:c949:b0:224:78e:4ebe with SMTP id
 d9443c01a7336-22593183ec4mr45122475ad.33.1741698009287; 
 Tue, 11 Mar 2025 06:00:09 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.00.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:00:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Glenn Miles <milesg@linux.ibm.com>, Glenn Miles <milesg@linux.vnet.ibm.com>
Subject: [PULL 33/72] pnv/xive2: Rename nvp_ to nvx_ if they can refer to NVP
 or NVGC
Date: Tue, 11 Mar 2025 22:57:27 +1000
Message-ID: <20250311125815.903177-34-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

The blk/index in some paths may refer to an NVP or an NVGC. When it
is not known ahead of time, use the nvx_ prefix to prevent confusion.

[npiggin: split out of larger fix patch and reworded]
Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive2.c | 56 ++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 5fa8e1b3fb..e925307d0f 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -226,8 +226,8 @@ void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, GString *buf)
     uint32_t qsize = xive_get_field32(END2_W3_QSIZE, end->w3);
     uint32_t qentries = 1 << (qsize + 10);
 
-    uint32_t nvp_blk = xive_get_field32(END2_W6_VP_BLOCK, end->w6);
-    uint32_t nvp_idx = xive_get_field32(END2_W6_VP_OFFSET, end->w6);
+    uint32_t nvx_blk = xive_get_field32(END2_W6_VP_BLOCK, end->w6);
+    uint32_t nvx_idx = xive_get_field32(END2_W6_VP_OFFSET, end->w6);
     uint8_t priority = xive_get_field32(END2_W7_F0_PRIORITY, end->w7);
     uint8_t pq;
 
@@ -256,7 +256,7 @@ void xive2_end_pic_print_info(Xive2End *end, uint32_t end_idx, GString *buf)
                            xive2_end_is_firmware2(end)   ? 'F' : '-',
                            xive2_end_is_ignore(end) ? 'i' : '-',
                            xive2_end_is_crowd(end)  ? 'c' : '-',
-                           priority, nvp_blk, nvp_idx);
+                           priority, nvx_blk, nvx_idx);
 
     if (qaddr_base) {
         g_string_append_printf(buf, " eq:@%08"PRIx64"% 6d/%5d ^%d",
@@ -372,7 +372,7 @@ static void xive2_end_enqueue(Xive2End *end, uint32_t data)
  * level of pending group interrupts.
  */
 static uint8_t xive2_presenter_backlog_scan(XivePresenter *xptr,
-                                            uint8_t nvp_blk, uint32_t nvp_idx,
+                                            uint8_t nvx_blk, uint32_t nvx_idx,
                                             uint8_t first_group,
                                             uint8_t *out_level)
 {
@@ -387,19 +387,19 @@ static uint8_t xive2_presenter_backlog_scan(XivePresenter *xptr,
 
         while (current_level) {
             mask = (1 << current_level) - 1;
-            nvgc_idx = nvp_idx & ~mask;
+            nvgc_idx = nvx_idx & ~mask;
             nvgc_idx |= mask >> 1;
             qemu_log("fxb %s checking backlog for prio %d group idx %x\n",
                      __func__, prio, nvgc_idx);
 
-            if (xive2_router_get_nvgc(xrtr, false, nvp_blk, nvgc_idx, &nvgc)) {
+            if (xive2_router_get_nvgc(xrtr, false, nvx_blk, nvgc_idx, &nvgc)) {
                 qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVG %x/%x\n",
-                              nvp_blk, nvgc_idx);
+                              nvx_blk, nvgc_idx);
                 return 0xFF;
             }
             if (!xive2_nvgc_is_valid(&nvgc)) {
                 qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid NVG %x/%x\n",
-                              nvp_blk, nvgc_idx);
+                              nvx_blk, nvgc_idx);
                 return 0xFF;
             }
 
@@ -415,7 +415,7 @@ static uint8_t xive2_presenter_backlog_scan(XivePresenter *xptr,
 }
 
 static void xive2_presenter_backlog_decr(XivePresenter *xptr,
-                                         uint8_t nvp_blk, uint32_t nvp_idx,
+                                         uint8_t nvx_blk, uint32_t nvx_idx,
                                          uint8_t group_prio,
                                          uint8_t group_level)
 {
@@ -425,17 +425,17 @@ static void xive2_presenter_backlog_decr(XivePresenter *xptr,
 
     group_level &= 0xF;
     mask = (1 << group_level) - 1;
-    nvgc_idx = nvp_idx & ~mask;
+    nvgc_idx = nvx_idx & ~mask;
     nvgc_idx |= mask >> 1;
 
-    if (xive2_router_get_nvgc(xrtr, false, nvp_blk, nvgc_idx, &nvgc)) {
+    if (xive2_router_get_nvgc(xrtr, false, nvx_blk, nvgc_idx, &nvgc)) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVG %x/%x\n",
-                      nvp_blk, nvgc_idx);
+                      nvx_blk, nvgc_idx);
         return;
     }
     if (!xive2_nvgc_is_valid(&nvgc)) {
         qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid NVG %x/%x\n",
-                      nvp_blk, nvgc_idx);
+                      nvx_blk, nvgc_idx);
         return;
     }
     count = xive2_nvgc_get_backlog(&nvgc, group_prio);
@@ -443,7 +443,7 @@ static void xive2_presenter_backlog_decr(XivePresenter *xptr,
         return;
     }
     xive2_nvgc_set_backlog(&nvgc, group_prio, count - 1);
-    xive2_router_write_nvgc(xrtr, false, nvp_blk, nvgc_idx, &nvgc);
+    xive2_router_write_nvgc(xrtr, false, nvx_blk, nvgc_idx, &nvgc);
 }
 
 /*
@@ -1289,8 +1289,8 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
     uint8_t priority;
     uint8_t format;
     bool found, precluded;
-    uint8_t nvp_blk;
-    uint32_t nvp_idx;
+    uint8_t nvx_blk;
+    uint32_t nvx_idx;
 
     /* END cache lookup */
     if (xive2_router_get_end(xrtr, end_blk, end_idx, &end)) {
@@ -1355,10 +1355,10 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
     /*
      * Follows IVPE notification
      */
-    nvp_blk = xive_get_field32(END2_W6_VP_BLOCK, end.w6);
-    nvp_idx = xive_get_field32(END2_W6_VP_OFFSET, end.w6);
+    nvx_blk = xive_get_field32(END2_W6_VP_BLOCK, end.w6);
+    nvx_idx = xive_get_field32(END2_W6_VP_OFFSET, end.w6);
 
-    found = xive_presenter_notify(xrtr->xfb, format, nvp_blk, nvp_idx,
+    found = xive_presenter_notify(xrtr->xfb, format, nvx_blk, nvx_idx,
                           xive2_end_is_crowd(&end), xive2_end_is_ignore(&end),
                           priority,
                           xive_get_field32(END2_W7_F1_LOG_SERVER_ID, end.w7),
@@ -1389,15 +1389,15 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
             Xive2Nvp nvp;
 
             /* NVP cache lookup */
-            if (xive2_router_get_nvp(xrtr, nvp_blk, nvp_idx, &nvp)) {
+            if (xive2_router_get_nvp(xrtr, nvx_blk, nvx_idx, &nvp)) {
                 qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no NVP %x/%x\n",
-                              nvp_blk, nvp_idx);
+                              nvx_blk, nvx_idx);
                 return;
             }
 
             if (!xive2_nvp_is_valid(&nvp)) {
                 qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVP %x/%x is invalid\n",
-                              nvp_blk, nvp_idx);
+                              nvx_blk, nvx_idx);
                 return;
             }
 
@@ -1409,7 +1409,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
             ipb = xive_get_field32(NVP2_W2_IPB, nvp.w2) |
                 xive_priority_to_ipb(priority);
             nvp.w2 = xive_set_field32(NVP2_W2_IPB, nvp.w2, ipb);
-            xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 2);
+            xive2_router_write_nvp(xrtr, nvx_blk, nvx_idx, &nvp, 2);
         } else {
             Xive2Nvgc nvgc;
             uint32_t backlog;
@@ -1422,15 +1422,15 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
              * counters are stored in the NVG/NVC structures
              */
             if (xive2_router_get_nvgc(xrtr, crowd,
-                                      nvp_blk, nvp_idx, &nvgc)) {
+                                      nvx_blk, nvx_idx, &nvgc)) {
                 qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no %s %x/%x\n",
-                              crowd ? "NVC" : "NVG", nvp_blk, nvp_idx);
+                              crowd ? "NVC" : "NVG", nvx_blk, nvx_idx);
                 return;
             }
 
             if (!xive2_nvgc_is_valid(&nvgc)) {
                 qemu_log_mask(LOG_GUEST_ERROR, "XIVE: NVG %x/%x is invalid\n",
-                              nvp_blk, nvp_idx);
+                              nvx_blk, nvx_idx);
                 return;
             }
 
@@ -1442,11 +1442,11 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
              */
             backlog = xive2_nvgc_get_backlog(&nvgc, priority) + 1;
             xive2_nvgc_set_backlog(&nvgc, priority, backlog);
-            xive2_router_write_nvgc(xrtr, crowd, nvp_blk, nvp_idx, &nvgc);
+            xive2_router_write_nvgc(xrtr, crowd, nvx_blk, nvx_idx, &nvgc);
 
             if (backlog == 1) {
                 XiveFabricClass *xfc = XIVE_FABRIC_GET_CLASS(xrtr->xfb);
-                xfc->broadcast(xrtr->xfb, nvp_blk, nvp_idx,
+                xfc->broadcast(xrtr->xfb, nvx_blk, nvx_idx,
                                xive2_end_is_crowd(&end),
                                xive2_end_is_ignore(&end),
                                priority);
-- 
2.47.1


