Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FE8C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJbU-0001j8-IA; Sun, 11 May 2025 23:13:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJam-0008Ur-8Q; Sun, 11 May 2025 23:12:37 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJaj-0006rT-BR; Sun, 11 May 2025 23:12:35 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-74267c68c11so274876b3a.0; 
 Sun, 11 May 2025 20:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019550; x=1747624350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/90WS5u7+XplUUzodUIf4yMTKQRUSlnJ1gKZzc3H1LM=;
 b=bjo1vFaKB4GyqREInb5uSa/F5LZ7edrHq/RaMYkzBFw4axoZJyOQuOKT9jbF1mI4Qu
 1/wc5jW0QNbs4eVW5O5LPWutIr129DipSGnb1103JlSFsJ5ZXv1S0txu8IKFiapBCTJb
 ZSj84tT+Xxes59hpiUbuuje8ROqhzUQnZ0YUxKOUeOYzRDvFxo8EeDFybUU3vOwybqWF
 Pgiterur9QJZ0v9a7FQypeMuxb+pUwcldNPwhk+cDkiU06QFI3O+NkqXe/CIcjjf7LYx
 bhdAz86jjlIdbzvOusOANVgHvqZdnUNTJ9QFKnMDOVftqZ7JOQbLTZVyN7DDHZlDUWUj
 3jbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019550; x=1747624350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/90WS5u7+XplUUzodUIf4yMTKQRUSlnJ1gKZzc3H1LM=;
 b=iNDr1Ztn/KnE6NrOfNFrb+uj0to0ByCfpKgOiEdEVJwbr0+YGJsWJY3YuSqYZl9ocF
 GL2g19TIdeyv2bxm8rlIL7Kt8xxkQd/fUi4MkSZbIz/qeCOdnOsqzGm6ikiE+JlzJV90
 RvSjFK3nvYFK99ZRYm2KuycTVU8sQ+sW7InUM43x/cnGMsmn/1/0jvSC96VBaJGDR1lZ
 edWzsVKuF1nUESwwwwKEadPSGJIG7PF337iUW0Av+rY7RPY/Zdp8TgciWj8dcNLSGAiW
 N420X+/j79D5aBeNpoqbIg41V6/duo0Y8NTx1H0z/SvO99poaMhV4a1r5B0JZY63izVm
 965A==
X-Forwarded-Encrypted: i=1;
 AJvYcCULXT8hUZf72FnntbNha6sfrV4b0laT8iiZlw3kEVqqgulemDzvxF3KrtffZZimxVCHfv2CgG0lahfw@nongnu.org
X-Gm-Message-State: AOJu0YwVFeXqA4l6E+ijMKSewFMQyhtwaV5cYGdzvpxRN/mQTeyAjHS/
 4niMScXN2mX36bpx1JmkHR3AU0xAihmMd8KOE1jdHGVlBXVswTQe0Lc0fw==
X-Gm-Gg: ASbGncvaanEvbbs50qvKojU9C37aH3fHKGMbmVXFaAHXyaq35KAGC2MipNgeWx+bA4I
 KtVemcL5fAMi3dHat3gJnAT8VjwH+xuq9s1sTubiKBwUThjijYqDtgqv3U7BixlYxigWKNYfgxQ
 AgNFbYIJwaQ4vkgMv2SyuGFTekcA7YxkM3IQxyUB7cGQn/PUmcIJHinYXL98ioO+MCAoYBwO3/f
 8EotZtUAKxgkDQpm1AbxajgFpfS6Pyi1rlan4wsofPNv3iql2CHcgtb+ESOJ9V1zXRoNZ/Vyu+X
 t5N6B7daqmT3iGMI4dT28SIP3IvUAKs6I1qSvvyDqmc1hWe+Nd55ThZ5Yj5qXL8ei1h5
X-Google-Smtp-Source: AGHT+IHhl6cb7bP2gJgYo66x4IvsdRKao+CSXO18A7S5jd/f57pMobcB9gZ+g6vzlvEpx697x1VwSw==
X-Received: by 2002:a05:6a21:9013:b0:201:4061:bd94 with SMTP id
 adf61e73a8af0-215abb37ebemr16097698637.19.1747019550507; 
 Sun, 11 May 2025 20:12:30 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:12:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 22/50] ppc/xive2: Support redistribution of group interrupts
Date: Mon, 12 May 2025 13:10:31 +1000
Message-ID: <20250512031100.439842-23-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
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

When an XIVE context is pulled while it has an active, unacknowledged
group interrupt, XIVE will check to see if a context on another thread
can handle the interrupt and, if so, notify that context.  If there
are no contexts that can handle the interrupt, then the interrupt is
added to a backlog and XIVE will attempt to escalate the interrupt,
if configured to do so, allowing the higher privileged handler to
activate a context that can handle the original interrupt.

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
---
 hw/intc/xive2.c             | 84 +++++++++++++++++++++++++++++++++++--
 include/hw/ppc/xive2_regs.h |  3 ++
 2 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 0993e792cc..34fc561c9c 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -19,6 +19,10 @@
 #include "hw/ppc/xive2_regs.h"
 #include "trace.h"
 
+static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
+                                    uint32_t end_idx, uint32_t end_data,
+                                    bool redistribute);
+
 uint32_t xive2_router_get_config(Xive2Router *xrtr)
 {
     Xive2RouterClass *xrc = XIVE2_ROUTER_GET_CLASS(xrtr);
@@ -597,6 +601,68 @@ static uint32_t xive2_tctx_hw_cam_line(XivePresenter *xptr, XiveTCTX *tctx)
     return xive2_nvp_cam_line(blk, 1 << tid_shift | (pir & tid_mask));
 }
 
+static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx,
+                               uint8_t nvp_blk, uint32_t nvp_idx, uint8_t ring)
+{
+    uint8_t nsr = tctx->regs[ring + TM_NSR];
+    uint8_t crowd = NVx_CROWD_LVL(nsr);
+    uint8_t group = NVx_GROUP_LVL(nsr);
+    uint8_t nvgc_blk;
+    uint8_t nvgc_idx;
+    uint8_t end_blk;
+    uint32_t end_idx;
+    uint8_t pipr = tctx->regs[ring + TM_PIPR];
+    Xive2Nvgc nvgc;
+    uint8_t prio_limit;
+    uint32_t cfg;
+
+    /* convert crowd/group to blk/idx */
+    if (group > 0) {
+        nvgc_idx = (nvp_idx & (0xffffffff << group)) |
+                   ((1 << (group - 1)) - 1);
+    } else {
+        nvgc_idx = nvp_idx;
+    }
+
+    if (crowd > 0) {
+        crowd = (crowd == 3) ? 4 : crowd;
+        nvgc_blk = (nvp_blk & (0xffffffff << crowd)) |
+                   ((1 << (crowd - 1)) - 1);
+    } else {
+        nvgc_blk = nvp_blk;
+    }
+
+    /* Use blk/idx to retrieve the NVGC */
+    if (xive2_router_get_nvgc(xrtr, crowd, nvgc_blk, nvgc_idx, &nvgc)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no %s %x/%x\n",
+                      crowd ? "NVC" : "NVG", nvgc_blk, nvgc_idx);
+        return;
+    }
+
+    /* retrieve the END blk/idx from the NVGC */
+    end_blk = xive_get_field32(NVGC2_W1_END_BLK, nvgc.w1);
+    end_idx = xive_get_field32(NVGC2_W1_END_IDX, nvgc.w1);
+
+    /* determine number of priorities being used */
+    cfg = xive2_router_get_config(xrtr);
+    if (cfg & XIVE2_EN_VP_GRP_PRIORITY) {
+        prio_limit = 1 << GETFIELD(NVGC2_W1_PSIZE, nvgc.w1);
+    } else {
+        prio_limit = 1 << GETFIELD(XIVE2_VP_INT_PRIO, cfg);
+    }
+
+    /* add priority offset to end index */
+    end_idx += pipr % prio_limit;
+
+    /* trigger the group END */
+    xive2_router_end_notify(xrtr, end_blk, end_idx, 0, true);
+
+    /* clear interrupt indication for the context */
+    tctx->regs[ring + TM_NSR] = 0;
+    tctx->regs[ring + TM_PIPR] = tctx->regs[ring + TM_CPPR];
+    xive_tctx_reset_signal(tctx, ring);
+}
+
 static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
                                   hwaddr offset, unsigned size, uint8_t ring)
 {
@@ -608,6 +674,7 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
     uint8_t cur_ring;
     bool valid;
     bool do_save;
+    uint8_t nsr;
 
     xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &valid, &do_save);
 
@@ -624,6 +691,12 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
         memcpy(&tctx->regs[cur_ring + TM_WORD2], &ringw2_new, 4);
     }
 
+    /* Active group/crowd interrupts need to be redistributed */
+    nsr = tctx->regs[ring + TM_NSR];
+    if (xive_nsr_indicates_group_exception(ring, nsr)) {
+        xive2_redistribute(xrtr, tctx, nvp_blk, nvp_idx, ring);
+    }
+
     if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save) {
         xive2_tctx_save_ctx(xrtr, tctx, nvp_blk, nvp_idx, ring);
     }
@@ -1352,7 +1425,8 @@ static bool xive2_router_end_es_notify(Xive2Router *xrtr, uint8_t end_blk,
  * message has the same parameters than in the function below.
  */
 static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
-                                    uint32_t end_idx, uint32_t end_data)
+                                    uint32_t end_idx, uint32_t end_data,
+                                    bool redistribute)
 {
     Xive2End end;
     uint8_t priority;
@@ -1380,7 +1454,7 @@ static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
         return;
     }
 
-    if (xive2_end_is_enqueue(&end)) {
+    if (!redistribute && xive2_end_is_enqueue(&end)) {
         xive2_end_enqueue(&end, end_data);
         /* Enqueuing event data modifies the EQ toggle and index */
         xive2_router_write_end(xrtr, end_blk, end_idx, &end, 1);
@@ -1560,7 +1634,8 @@ do_escalation:
         xive2_router_end_notify(xrtr,
                                xive_get_field32(END2_W4_END_BLOCK,     end.w4),
                                xive_get_field32(END2_W4_ESC_END_INDEX, end.w4),
-                               xive_get_field32(END2_W5_ESC_END_DATA,  end.w5));
+                               xive_get_field32(END2_W5_ESC_END_DATA,  end.w5),
+                               false);
     } /* end END adaptive escalation */
 
     else {
@@ -1641,7 +1716,8 @@ void xive2_notify(Xive2Router *xrtr , uint32_t lisn, bool pq_checked)
     xive2_router_end_notify(xrtr,
                             xive_get_field64(EAS2_END_BLOCK, eas.w),
                             xive_get_field64(EAS2_END_INDEX, eas.w),
-                            xive_get_field64(EAS2_END_DATA,  eas.w));
+                            xive_get_field64(EAS2_END_DATA,  eas.w),
+                            false);
     return;
 }
 
diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index 2c535ec0d0..e222038143 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -224,6 +224,9 @@ typedef struct Xive2Nvgc {
 #define NVGC2_W0_VALID             PPC_BIT32(0)
 #define NVGC2_W0_PGONEXT           PPC_BITMASK32(26, 31)
         uint32_t        w1;
+#define NVGC2_W1_PSIZE             PPC_BITMASK32(0, 1)
+#define NVGC2_W1_END_BLK           PPC_BITMASK32(4, 7)
+#define NVGC2_W1_END_IDX           PPC_BITMASK32(8, 31)
         uint32_t        w2;
         uint32_t        w3;
         uint32_t        w4;
-- 
2.47.1


