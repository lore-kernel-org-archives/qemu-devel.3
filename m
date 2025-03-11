Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C56C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzGc-0000DJ-Tj; Tue, 11 Mar 2025 09:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDM-0004Ff-Mc; Tue, 11 Mar 2025 09:00:13 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzDD-00083P-3e; Tue, 11 Mar 2025 09:00:06 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ff64550991so8238766a91.0; 
 Tue, 11 Mar 2025 05:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697993; x=1742302793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LV73eZk7vJrbkDVPoyzfVDHfZQAl5NgriC87PEyH8zI=;
 b=jWBt3INKVyF7UbU/k3bt+TiuhMUSnDGqf5TVlgL0LdvsZ8iMEWMAmdsinuk5QixYzz
 2div17Mvs61tdhVtZhgS9KNPEBfV990CgsjGYEuj7JEm7vol0f7cBG6hsB619V3hLNWh
 gQhx5yUfXdNHfZkAx0+kM0NVkor/HpzBSDOtUArEYPVmWVNI2RRpcDS7aS+9ajnfSh6M
 bysV2gOIhOEDTYTw3s1poY7UwMSvyK63sk8FlXXjVroibLhyhLvJD23AzrtVfAU/Ktf4
 wTL3e3qw7lpR72iU1z6Z7mg7GDtbWkGbG+QPQeZbD0uicOVr7ALlIhJJnDYBeTgvkjHK
 pBRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697993; x=1742302793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LV73eZk7vJrbkDVPoyzfVDHfZQAl5NgriC87PEyH8zI=;
 b=auihO09VU91kmmy1v9Yq0DXr6eaWuH4S7w4rgt7/qc/LWgRVCkMLHNR5UE58Q5t3HX
 rfN7iISiGrtlwjLXS2Q+lZtmd70wDawu3wULmqO0JPILSpH2QrV+Rh6CQg2/Mrw+TeuX
 TE+NWmb1G72AaGzgFQ+tBHSRGpXF0XL651adtJQ8ijCBYFDzZuIaqQWWuem59YXDSDC1
 c5M8R/NBuET55nHDn6pWcC5yfF86/NkEm3I1kJJLoNeqj52bdNBDQsQfcIevy0w6xGX5
 odEu7FNNsufMsiIVHbj9RU0AWqLw4AEfw42MXqsY3JfGITIDUmPfZxD9vCwIKd1qXOKX
 9Tsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLSOCr4j/vBgZgzL2D+HO7xgGNJq3t+UgWrxYMsh0HNi746naG/tnJt2KYdp+FpOejZOiY1BMCEg==@nongnu.org
X-Gm-Message-State: AOJu0YzSF0WH2jeWY9bJfxNjgNxTCfXrSWLBx7C6ghbpDqswBYESe8zv
 EdC0nv8Y+Do2hYntT1xDd4PNhCrEW3Dl2Xkto4QOzua6LWvG5xcA48M7WA==
X-Gm-Gg: ASbGncs0wJhV9xfnocayeo/yxbX1yP/gXqEkPONlVwDknf0miFkIZNNjjuC2pl9af2t
 sGVp1DPw61Rxq7uhz6EWh2FnJ1YgYWw3uzuEhQSrq72kXLq+3X4gBwVe8VK6zCd6TeUIny1uB6h
 lDyD2gT9sIRX7prxMIfLCkarUzDr4i0AH1PX8m9rUz+8/SfeUiNktKJQ7j1fuJ/wDSwQMoQ+jLK
 oMWE+n5SnAbmMI8CFWBx/Tca+qForEchMRe3JsAglz+K0iAAgQugGd+2lXwfajvQIhZ09v7mtuR
 NC20cXp5cXDBiW2xtRpI9Rv+16RaUdBmQDZhzzcYknO701aOdFk=
X-Google-Smtp-Source: AGHT+IEzdBJbCY0edAKOTyoyZsqDTvJiP3s6ENrxFsqCZXVRPsMQugUOTEY1T9ttRK/0wTha6xJnaA==
X-Received: by 2002:a17:90b:1a8c:b0:2ee:94d1:7a89 with SMTP id
 98e67ed59e1d1-2ff7ce6f36emr24072499a91.1.1741697993428; 
 Tue, 11 Mar 2025 05:59:53 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:59:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Frederic Barrat <fbarrat@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>
Subject: [PULL 28/72] ppc/xive2: Process group backlog when pushing an OS
 context
Date: Tue, 11 Mar 2025 22:57:22 +1000
Message-ID: <20250311125815.903177-29-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
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

From: Frederic Barrat <fbarrat@linux.ibm.com>

When pushing an OS context, we were already checking if there was a
pending interrupt in the IPB and sending a notification if needed.  We
also need to check if there is a pending group interrupt stored in the
NVG table. To avoid useless backlog scans, we only scan if the NVP
belongs to a group.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/intc/xive2.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 44d891f1f6..2fa7b90669 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -279,6 +279,85 @@ static void xive2_end_enqueue(Xive2End *end, uint32_t data)
     end->w1 = xive_set_field32(END2_W1_PAGE_OFF, end->w1, qindex);
 }
 
+/*
+ * Scan the group chain and return the highest priority and group
+ * level of pending group interrupts.
+ */
+static uint8_t xive2_presenter_backlog_scan(XivePresenter *xptr,
+                                            uint8_t nvp_blk, uint32_t nvp_idx,
+                                            uint8_t first_group,
+                                            uint8_t *out_level)
+{
+    Xive2Router *xrtr = XIVE2_ROUTER(xptr);
+    uint32_t nvgc_idx, mask;
+    uint32_t current_level, count;
+    uint8_t prio;
+    Xive2Nvgc nvgc;
+
+    for (prio = 0; prio <= XIVE_PRIORITY_MAX; prio++) {
+        current_level = first_group & 0xF;
+
+        while (current_level) {
+            mask = (1 << current_level) - 1;
+            nvgc_idx = nvp_idx & ~mask;
+            nvgc_idx |= mask >> 1;
+            qemu_log("fxb %s checking backlog for prio %d group idx %x\n",
+                     __func__, prio, nvgc_idx);
+
+            if (xive2_router_get_nvgc(xrtr, false, nvp_blk, nvgc_idx, &nvgc)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVG %x/%x\n",
+                              nvp_blk, nvgc_idx);
+                return 0xFF;
+            }
+            if (!xive2_nvgc_is_valid(&nvgc)) {
+                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid NVG %x/%x\n",
+                              nvp_blk, nvgc_idx);
+                return 0xFF;
+            }
+
+            count = xive2_nvgc_get_backlog(&nvgc, prio);
+            if (count) {
+                *out_level = current_level;
+                return prio;
+            }
+            current_level = xive_get_field32(NVGC2_W0_PGONEXT, nvgc.w0) & 0xF;
+        }
+    }
+    return 0xFF;
+}
+
+static void xive2_presenter_backlog_decr(XivePresenter *xptr,
+                                         uint8_t nvp_blk, uint32_t nvp_idx,
+                                         uint8_t group_prio,
+                                         uint8_t group_level)
+{
+    Xive2Router *xrtr = XIVE2_ROUTER(xptr);
+    uint32_t nvgc_idx, mask, count;
+    Xive2Nvgc nvgc;
+
+    group_level &= 0xF;
+    mask = (1 << group_level) - 1;
+    nvgc_idx = nvp_idx & ~mask;
+    nvgc_idx |= mask >> 1;
+
+    if (xive2_router_get_nvgc(xrtr, false, nvp_blk, nvgc_idx, &nvgc)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVG %x/%x\n",
+                      nvp_blk, nvgc_idx);
+        return;
+    }
+    if (!xive2_nvgc_is_valid(&nvgc)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid NVG %x/%x\n",
+                      nvp_blk, nvgc_idx);
+        return;
+    }
+    count = xive2_nvgc_get_backlog(&nvgc, group_prio);
+    if (!count) {
+        return;
+    }
+    xive2_nvgc_set_backlog(&nvgc, group_prio, count - 1);
+    xive2_router_write_nvgc(xrtr, false, nvp_blk, nvgc_idx, &nvgc);
+}
+
 /*
  * XIVE Thread Interrupt Management Area (TIMA) - Gen2 mode
  *
@@ -588,9 +667,13 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
                                    uint8_t nvp_blk, uint32_t nvp_idx,
                                    bool do_restore)
 {
+    XivePresenter *xptr = XIVE_PRESENTER(xrtr);
     uint8_t ipb;
     uint8_t backlog_level;
+    uint8_t group_level;
+    uint8_t first_group;
     uint8_t backlog_prio;
+    uint8_t group_prio;
     uint8_t *regs = &tctx->regs[TM_QW1_OS];
     Xive2Nvp nvp;
 
@@ -625,6 +708,20 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr, XiveTCTX *tctx,
     backlog_prio = xive_ipb_to_pipr(ipb);
     backlog_level = 0;
 
+    first_group = xive_get_field32(NVP2_W0_PGOFIRST, nvp.w0);
+    if (first_group && regs[TM_LSMFB] < backlog_prio) {
+        group_prio = xive2_presenter_backlog_scan(xptr, nvp_blk, nvp_idx,
+                                                  first_group, &group_level);
+        regs[TM_LSMFB] = group_prio;
+        if (regs[TM_LGS] && group_prio < backlog_prio) {
+            /* VP can take a group interrupt */
+            xive2_presenter_backlog_decr(xptr, nvp_blk, nvp_idx,
+                                         group_prio, group_level);
+            backlog_prio = group_prio;
+            backlog_level = group_level;
+        }
+    }
+
     /*
      * Compute the PIPR based on the restored state.
      * It will raise the External interrupt signal if needed.
-- 
2.47.1


