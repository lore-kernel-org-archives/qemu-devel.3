Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91899C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 18:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf1X3-0004O4-Ii; Fri, 16 Aug 2024 14:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sezwe-0003GZ-Iq
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:36:56 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sezwc-0002KZ-Qf
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 12:36:56 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2d3e6fd744fso140153a91.3
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 09:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schmorgal.com; s=google; t=1723826213; x=1724431013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=arg2TvA2GPM8gZ2q2s2JlR3QumG7iRuQQq7xe/+qsBo=;
 b=WFK6eqnZwsB/413xoHiWSa8YYHDM1Y5xomg9GPY7DdtysBkYxJH5RVVQqkmcesUkF+
 Z8qajv/8glpmlgy7h4tUOns3jsu2zm7dSDmj1sDHtJez1Bw74xD21XCRbts858uZnbVe
 QeG8La9+KREf62bXjVxZ7wPfG3DuT6u0y++kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723826213; x=1724431013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=arg2TvA2GPM8gZ2q2s2JlR3QumG7iRuQQq7xe/+qsBo=;
 b=Dw20SEGgSh2KpIg/iFZcc/PjixVpkByn7F0T0CmSCmoNpF5hECAHASRYnLLyerPDSu
 cr5FuDvuGGklnl5J5CvrmiaueLyiUVy3Dxq9gtm1F1PzKrY+tEmgsKotQ5tivyRrRbQq
 CJDAvfxlXSwn91SoywcRD4f7bn8qYbLhNvLmg2hleTWwYqOzT4NaUvGiYVy7Ex69b3FT
 rXR1E/VPqGfMQTdlInIWQN7TH0rE4pCEN86NrGlrIY4MnoN95G8hA8MI1qAFVz41ZbeZ
 ZIPRUag8MH9lfR9p8ZfH+3S4KNGu0eryIGSVf4CXcBbBgDdgMTVPwW7YCn3Q2TQwXya4
 F5Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAB6dnajPMuHNOjqjAR+u7ThjIVz2/d5zAwaiIWaqdDKcbGcYuLe7chlVV4FlrStj+ac4bOXLngovR@nongnu.org
X-Gm-Message-State: AOJu0YzoN8fV+H9dUB/LxBr7+VYGQo74/BUkgq7t/8dY6nOiAP1nZHDW
 ItuoTnPT70shd7Gk2+YxEKoy6AjqTfw2+uJAAYLdXz/txIo+pBfrSbTuXsu/it50ceWAij1ngGY
 I96r/2A==
X-Google-Smtp-Source: AGHT+IH6FsrYq3xYeN+0mTYBT1bY3l8I2ngn3RLvNXgzVs0mUr5pGTzRQ5xEVSmhszfhfAmPXNReqQ==
X-Received: by 2002:a05:6a20:394a:b0:1c2:9009:f6f with SMTP id
 adf61e73a8af0-1c9a1e9bb9amr2043871637.4.1723826213350; 
 Fri, 16 Aug 2024 09:36:53 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.37.200.153])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3e2e6b201sm2134285a91.15.2024.08.16.09.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 09:36:52 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: Vikram Garhwal <vikram.garhwal@amd.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Doug Brown <doug@schmorgal.com>
Subject: [PATCH 3/5] hw/net/can/xlnx-versal-canfd: Translate CAN ID registers
Date: Fri, 16 Aug 2024 09:35:03 -0700
Message-Id: <20240816163504.789393-4-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816163504.789393-1-doug@schmorgal.com>
References: <20240816163504.789393-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=doug@schmorgal.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 16 Aug 2024 14:18:35 -0400
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

Previously the emulated CAN ID register was being set to the exact same
value stored in qemu_can_frame.can_id. This doesn't work correctly
because the Xilinx IP core uses a different bit arrangement than
qemu_can_frame for all of its ID registers. Correct this problem for
both RX and TX, including RX filtering.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 hw/net/can/xlnx-versal-canfd.c | 53 ++++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 8968672b84..1704b558d0 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -869,6 +869,8 @@ static void regs2frame(XlnxVersalCANFDState *s, qemu_can_frame *frame,
     uint32_t val = 0;
     uint32_t dlc_reg_val = 0;
     uint32_t dlc_value = 0;
+    uint32_t id_reg_val = 0;
+    bool is_rtr = false;
 
     /* Check that reg_num should be within TX register space. */
     assert(reg_num <= R_TB_ID_REGISTER + (NUM_REGS_PER_MSG_SPACE *
@@ -877,7 +879,20 @@ static void regs2frame(XlnxVersalCANFDState *s, qemu_can_frame *frame,
     dlc_reg_val = s->regs[reg_num + 1];
     dlc_value = FIELD_EX32(dlc_reg_val, TB0_DLC_REGISTER, DLC);
 
-    frame->can_id = s->regs[reg_num];
+    id_reg_val = s->regs[reg_num];
+    if (FIELD_EX32(id_reg_val, TB_ID_REGISTER, IDE)) {
+        frame->can_id = (FIELD_EX32(id_reg_val, TB_ID_REGISTER, ID) << 18) |
+                        (FIELD_EX32(id_reg_val, TB_ID_REGISTER, ID_EXT)) |
+                        QEMU_CAN_EFF_FLAG;
+        if (FIELD_EX32(id_reg_val, TB_ID_REGISTER, RTR_RRS)) {
+            is_rtr = true;
+        }
+    } else {
+        frame->can_id = FIELD_EX32(id_reg_val, TB_ID_REGISTER, ID);
+        if (FIELD_EX32(id_reg_val, TB_ID_REGISTER, SRR_RTR_RRS)) {
+            is_rtr = true;
+        }
+    }
 
     if (FIELD_EX32(dlc_reg_val, TB0_DLC_REGISTER, FDF)) {
         /*
@@ -923,6 +938,10 @@ static void regs2frame(XlnxVersalCANFDState *s, qemu_can_frame *frame,
         } else {
             frame->can_dlc = dlc_value;
         }
+
+        if (is_rtr) {
+            frame->can_id |= QEMU_CAN_RTR_FLAG;
+        }
     }
 
     for (j = 0; j < frame->can_dlc; j++) {
@@ -948,6 +967,33 @@ static void process_cancellation_requests(XlnxVersalCANFDState *s)
     canfd_update_irq(s);
 }
 
+static uint32_t frame_to_reg_id(const qemu_can_frame *frame)
+{
+    uint32_t id_reg_val = 0;
+    const bool is_canfd_frame = frame->flags & QEMU_CAN_FRMF_TYPE_FD;
+    const bool is_rtr = !is_canfd_frame && (frame->can_id & QEMU_CAN_RTR_FLAG);
+
+    if (frame->can_id & QEMU_CAN_EFF_FLAG) {
+        id_reg_val |= FIELD_DP32(0, RB_ID_REGISTER, ID,
+                                 (frame->can_id & QEMU_CAN_EFF_MASK) >> 18);
+        id_reg_val |= FIELD_DP32(0, RB_ID_REGISTER, ID_EXT,
+                                 frame->can_id & QEMU_CAN_EFF_MASK);
+        id_reg_val |= FIELD_DP32(0, RB_ID_REGISTER, IDE, 1);
+        id_reg_val |= FIELD_DP32(0, RB_ID_REGISTER, SRR_RTR_RRS, 1);
+        if (is_rtr) {
+            id_reg_val |= FIELD_DP32(0, RB_ID_REGISTER, RTR_RRS, 1);
+        }
+    } else {
+        id_reg_val |= FIELD_DP32(0, RB_ID_REGISTER, ID,
+                                 frame->can_id & QEMU_CAN_SFF_MASK);
+        if (is_rtr) {
+            id_reg_val |= FIELD_DP32(0, RB_ID_REGISTER, SRR_RTR_RRS, 1);
+        }
+    }
+
+    return id_reg_val;
+}
+
 static void store_rx_sequential(XlnxVersalCANFDState *s,
                                 const qemu_can_frame *frame,
                                 uint32_t fill_level, uint32_t read_index,
@@ -999,7 +1045,7 @@ static void store_rx_sequential(XlnxVersalCANFDState *s,
                                                     NUM_REGS_PER_MSG_SPACE));
         }
 
-        s->regs[store_location] = frame->can_id;
+        s->regs[store_location] = frame_to_reg_id(frame);
 
         dlc = frame->can_dlc;
 
@@ -1090,11 +1136,12 @@ static void update_rx_sequential(XlnxVersalCANFDState *s,
     if (s->regs[R_ACCEPTANCE_FILTER_CONTROL_REGISTER]) {
         uint32_t acceptance_filter_status =
                                 s->regs[R_ACCEPTANCE_FILTER_CONTROL_REGISTER];
+        const uint32_t reg_id = frame_to_reg_id(frame);
 
         for (i = 0; i < 32; i++) {
             if (acceptance_filter_status & 0x1) {
                 uint32_t msg_id_masked = s->regs[R_AFMR_REGISTER + 2 * i] &
-                                         frame->can_id;
+                                         reg_id;
                 uint32_t afir_id_masked = s->regs[R_AFIR_REGISTER + 2 * i] &
                                           s->regs[R_AFMR_REGISTER + 2 * i];
                 uint16_t std_msg_id_masked = FIELD_EX32(msg_id_masked,
-- 
2.34.1


