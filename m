Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF842C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJbY-0002Dp-1b; Sun, 11 May 2025 23:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJay-0000OH-DK; Sun, 11 May 2025 23:12:49 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJav-0006sc-KQ; Sun, 11 May 2025 23:12:47 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so243508b3a.3; 
 Sun, 11 May 2025 20:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019561; x=1747624361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/sM3Fcl2nkTcvJ+mZtD/bEzJ5psrvAWh+VjIf988ETM=;
 b=fAgsNEYlCi1ZpzPg5ROqCs378ocXhGt/Myiw+tegCH7b11Iqii2qQ0eTiV19+MxMs2
 BMhL2+80W7NSZVCe2jqzaE2HaTAc+di92C/vP9dcDolcKPzd85dOoLWfCFEkyFAXcFjO
 1Sw/iPBa0nQ4TmZRt0ygbcTLsyB+Ko9MTEfHl/V3gNYfDrTcl6PIFeF2udkvqYwA3QWI
 XVsowU2ZNfwvhPM5bQYsoQojxP5ndlCSE9gl4sqKvXt0GzWBZuyzvYtvhsj6jO1dowxv
 IXsEnUWvmblc+w5yBqNUaxda3BA95FtKZTVXuSalPYigcUbVvpE+lfz5vfCmFv4oMQPr
 5LXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019561; x=1747624361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/sM3Fcl2nkTcvJ+mZtD/bEzJ5psrvAWh+VjIf988ETM=;
 b=WQwCftdFGYGEvuAV9cyfQwq1i8CSZ+FI7DcAW9ANETdz0iNw7mUp7RaX/RISbEjB/3
 zkT+OUHcQqA2QJg+89nwpUbm4HiaBIVfgx6XLWHSes+p4Fqb8s1Ia/noaRCZBfO/pFky
 vsD4GfB45QPlH6Rb40w+2y/mBhbY+FGBQXtR6LNaXE+2+l/cF92e2y/14Juo3JugWTsU
 4OkTiBLSYlj24uK2J6dwAG5ftDzpIAfjcBuiW0RqnKsO5YsoXIVNudajbzKVQdvbwJLD
 OolxB0RDOtljBgDYNxUqoj15Bz6zf7P18ocnZIe4o5JaquskEG6RxNY+i89MOojHUqSy
 Fd2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdtmJ86XBQuve8Kugtp93y9pVacZdzNGZKBSOnc/0h3ipHssckt34JJI2ANLdmBiX/Z/UPboKPTSOt@nongnu.org
X-Gm-Message-State: AOJu0YyaHN5o68YOuOPmIQHPVXj1I3m+7v9WrnpIGf03DQ36hEjWCtF+
 Me0TMDud9JGkjrHxS193MsOaKThyU7TgN/3b2dXUvkVJW6RVxbJoB0g0HA==
X-Gm-Gg: ASbGncvblPEvJRClkxjIom5GKgjHKXSMmK6nGJ4orU8a3dCBfCn5NU2GMbtQvz3Qiyr
 LfY6oL0aW3qmLODEipPmrz1yvLXZ8QJiw8Ync9Md543pcd2eKSLBediCNBKe7s/NXRVar0bg3bQ
 ci4aJKMrYCSzcqZxWZhI1hpts5qYOUPB19tddCFyXl02Xz/iXiL1cRdQVm9DoUz8H/e0r9HKzrr
 hlabGLnxM8HPByg3NDE66R35YawvlWj44MpmEaZRmm1bRsTtP3NXR3ziJBWSpfRaKgqgpfTugXf
 TLvfGtfs1xfP6whlRyGtv+jhohDQ2PpAhmAhNVGcIcf2VC7QS033a0EzfA==
X-Google-Smtp-Source: AGHT+IEOWcnB8FYocwC3zPAT5I8DetE1vUc3Hrkkw4B0jbI+6J4qb16xOed3kNFp536hB5orXzhoRw==
X-Received: by 2002:a05:6a21:158e:b0:1f5:8678:1820 with SMTP id
 adf61e73a8af0-215abb0b74dmr15938907637.12.1747019561394; 
 Sun, 11 May 2025 20:12:41 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:12:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 25/50] ppc/xive2: Implement "Ack OS IRQ to even report line"
 TIMA op
Date: Mon, 12 May 2025 13:10:34 +1000
Message-ID: <20250512031100.439842-26-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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

Booting AIX in a PowerVM partition requires the use of the "Acknowledge
O/S Interrupt to even O/S reporting line" special operation provided by
the IBM XIVE interrupt controller. This operation is invoked by writing
a byte (data is irrelevant) to offset 0xC10 of the Thread Interrupt
Management Area (TIMA). It can be used by software to notify the XIVE
logic that the interrupt was received.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
---
 hw/intc/xive.c         |  8 ++++---
 hw/intc/xive2.c        | 50 ++++++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/xive.h  |  1 +
 include/hw/ppc/xive2.h |  3 ++-
 4 files changed, 58 insertions(+), 4 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 7461dbecb8..9ec1193dfc 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -80,7 +80,7 @@ static qemu_irq xive_tctx_output(XiveTCTX *tctx, uint8_t ring)
         }
 }
 
-static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
+uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring)
 {
     uint8_t *regs = &tctx->regs[ring];
     uint8_t nsr = regs[TM_NSR];
@@ -340,14 +340,14 @@ static uint64_t xive_tm_vt_poll(XivePresenter *xptr, XiveTCTX *tctx,
 
 static const uint8_t xive_tm_hw_view[] = {
     3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-0 User */
-    3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-1 OS   */
+    3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 3, /* QW-1 OS   */
     0, 0, 3, 3,   0, 3, 3, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-2 POOL */
     3, 3, 3, 3,   0, 3, 0, 2,   3, 0, 0, 3,   3, 3, 3, 0, /* QW-3 PHYS */
 };
 
 static const uint8_t xive_tm_hv_view[] = {
     3, 0, 0, 0,   0, 0, 0, 0,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-0 User */
-    3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 0, /* QW-1 OS   */
+    3, 3, 3, 3,   3, 3, 0, 2,   3, 3, 3, 3,   0, 0, 0, 3, /* QW-1 OS   */
     0, 0, 3, 3,   0, 3, 3, 0,   0, 3, 3, 3,   0, 0, 0, 0, /* QW-2 POOL */
     3, 3, 3, 3,   0, 3, 0, 2,   3, 0, 0, 3,   0, 0, 0, 0, /* QW-3 PHYS */
 };
@@ -718,6 +718,8 @@ static const XiveTmOp xive2_tm_operations[] = {
                                                      xive_tm_pull_phys_ctx },
     { XIVE_TM_HV_PAGE, TM_SPC_PULL_PHYS_CTX_OL,   1, xive2_tm_pull_phys_ctx_ol,
                                                      NULL },
+    { XIVE_TM_OS_PAGE, TM_SPC_ACK_OS_EL,          1, xive2_tm_ack_os_el,
+                                                     NULL },
 };
 
 static const XiveTmOp *xive_tm_find_op(XivePresenter *xptr, hwaddr offset,
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index ec4b9320b4..68be138335 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -1009,6 +1009,56 @@ static int xive2_tctx_get_nvp_indexes(XiveTCTX *tctx, uint8_t ring,
     return 0;
 }
 
+static void xive2_tctx_accept_el(XivePresenter *xptr, XiveTCTX *tctx,
+                                 uint8_t ring, uint8_t cl_ring)
+{
+    uint64_t rd;
+    Xive2Router *xrtr = XIVE2_ROUTER(xptr);
+    uint32_t nvp_blk, nvp_idx, xive2_cfg;
+    Xive2Nvp nvp;
+    uint64_t phys_addr;
+    uint8_t OGen = 0;
+
+    xive2_tctx_get_nvp_indexes(tctx, cl_ring, &nvp_blk, &nvp_idx);
+
+    if (xive2_router_get_nvp(xrtr, (uint8_t)nvp_blk, nvp_idx, &nvp)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVP %x/%x\n",
+                      nvp_blk, nvp_idx);
+        return;
+    }
+
+    if (!xive2_nvp_is_valid(&nvp)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid NVP %x/%x\n",
+                      nvp_blk, nvp_idx);
+        return;
+    }
+
+
+    rd = xive_tctx_accept(tctx, ring);
+
+    if (ring == TM_QW1_OS) {
+        OGen = tctx->regs[ring + TM_OGEN];
+    }
+    xive2_cfg = xive2_router_get_config(xrtr);
+    phys_addr = xive2_nvp_reporting_addr(&nvp);
+    uint8_t report_data[REPORT_LINE_GEN1_SIZE];
+    memset(report_data, 0xff, sizeof(report_data));
+    if ((OGen == 1) || (xive2_cfg & XIVE2_GEN1_TIMA_OS)) {
+        report_data[8] = (rd >> 8) & 0xff;
+        report_data[9] = rd & 0xff;
+    } else {
+        report_data[0] = (rd >> 8) & 0xff;
+        report_data[1] = rd & 0xff;
+    }
+    cpu_physical_memory_write(phys_addr, report_data, REPORT_LINE_GEN1_SIZE);
+}
+
+void xive2_tm_ack_os_el(XivePresenter *xptr, XiveTCTX *tctx,
+                        hwaddr offset, uint64_t value, unsigned size)
+{
+    xive2_tctx_accept_el(xptr, tctx, TM_QW1_OS, TM_QW1_OS);
+}
+
 static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cppr)
 {
     uint8_t *regs = &tctx->regs[ring];
diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 28f0f1b79a..46d05d74fb 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -561,6 +561,7 @@ void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priority,
                            uint8_t group_level);
 void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring);
 void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level);
+uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t ring);
 
 /*
  * KVM XIVE device helpers
diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
index 760b94a962..ff02ce2549 100644
--- a/include/hw/ppc/xive2.h
+++ b/include/hw/ppc/xive2.h
@@ -142,5 +142,6 @@ void xive2_tm_set_hv_target(XivePresenter *xptr, XiveTCTX *tctx,
                             hwaddr offset, uint64_t value, unsigned size);
 void xive2_tm_pull_phys_ctx_ol(XivePresenter *xptr, XiveTCTX *tctx,
                                hwaddr offset, uint64_t value, unsigned size);
-
+void xive2_tm_ack_os_el(XivePresenter *xptr, XiveTCTX *tctx,
+                        hwaddr offset, uint64_t value, unsigned size);
 #endif /* PPC_XIVE2_H */
-- 
2.47.1


