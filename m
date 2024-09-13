Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD846FA3755
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp80p-0004Yj-Or; Fri, 13 Sep 2024 11:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp80D-0002M6-Ai
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:29 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp80A-0007p2-Sq
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:29 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37747c1d928so744815f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726240465; x=1726845265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SdBENGCYVeHnIteVeEyvDPFnPAvCbtcxZIQLKQyP3eU=;
 b=YpEVlmrvy0n8UVcKxw+RvAT6jHUe0sbXubyUzcGccN7RSQEcSFwI2ws7JxRQMPGJYz
 L7bqScTWdzElmJwSqegkxC5eeg3W7fV+1FvGnqpPhLRuqL4uTZjehDu05rg/nE2Nwsp4
 SRL6gicn71C7Ux0Mgxz31jiJl1bOz3CTnzksm7YWmPHXTVq92ehhCiiUKeC+NKr7GqBs
 zOWhX2yHSFrP2s2iekND+KNA1hx7EsvL4ntd8EUWFR106ApSs7NpBOMAR9xBQSfJKliI
 gEv/LbZKt/iVUAzy8MTk6ErJ3XTU1bx+TvofXyo5Sojm5RJkQwncWaEJT6x6pDQbSuy5
 5ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726240465; x=1726845265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SdBENGCYVeHnIteVeEyvDPFnPAvCbtcxZIQLKQyP3eU=;
 b=gdextGy39qhXOtDC8oRJiOGDyRnTlrUVEosCD3wDsxvxlLJjyoCFhh4JRwmsHqoKxZ
 UB16lXT5rb/Adej4ijjsEVJE1E7J4tioM2ak3MbiXIPsMADT8Sp8B1VQulwI59cXPUgZ
 X39b3ltYYxEVioxZTw7Mg5Pu67kjWuE8at6eXKkzEmwbEX+1KhINgYni7x9QUQDz2Pxr
 xAWZZhanVuqXA7oV5ciCd0V2Ug8Gzal3z8nEo3gnRz5EqeN68jx7SGaknz1YN4me/v9A
 9ljQ+TpXOsTVHre/3bDd8wqDvD7wD2e7jiYnDQ8jP/SZXPcQQ64ILrFIa27IbJITl0DC
 v8Uw==
X-Gm-Message-State: AOJu0Yz/FcWYjmeNTTnRbV+dohub4XNBEbCZuZSZgULXzWEXaTCwSIYg
 baY4Xxv0x//KVibKkfI/5xU3BihLjK3pnj7s0kKBSle+6xn5Gffzqhw7PpbgCwsPkI1JZPTVv9G
 C
X-Google-Smtp-Source: AGHT+IHqTUnm0eIFsETyDK5qcPdmD3nx4Pkic5UaKt45z5LCdGwuvdvDkMAM0mFLwRVhe/cBtVtoiw==
X-Received: by 2002:a05:6000:b82:b0:371:828a:741d with SMTP id
 ffacd0b85a97d-378d61e2866mr2136777f8f.21.1726240465350; 
 Fri, 13 Sep 2024 08:14:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b16bfbfsm29152325e9.22.2024.09.13.08.14.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:14:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/27] hw/net/can/xlnx-versal-canfd: Simplify DLC conversions
Date: Fri, 13 Sep 2024 16:14:06 +0100
Message-Id: <20240913151411.2167922-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913151411.2167922-1-peter.maydell@linaro.org>
References: <20240913151411.2167922-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Doug Brown <doug@schmorgal.com>

Use QEMU's helper functions can_dlc2len() and can_len2dlc() for
translating between the raw DLC value and the SocketCAN length value.
This also has the side effect of correctly handling received CAN FD
frames with a DLC of 0-8, which was broken previously.

Signed-off-by: Doug Brown <doug@schmorgal.com>
Reviewed-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Message-id: 20240827034927.66659-7-doug@schmorgal.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/can/xlnx-versal-canfd.c | 67 ++--------------------------------
 1 file changed, 4 insertions(+), 63 deletions(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index bcfffee1cc2..ccfed364cc9 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -678,8 +678,6 @@ REG32(RB_DW15_REGISTER_1, 0x4144)
     FIELD(RB_DW15_REGISTER_1, DATA_BYTES62, 8, 8)
     FIELD(RB_DW15_REGISTER_1, DATA_BYTES63, 0, 8)
 
-static uint8_t canfd_dlc_array[8] = {8, 12, 16, 20, 24, 32, 48, 64};
-
 static void canfd_update_irq(XlnxVersalCANFDState *s)
 {
     const bool irq = (s->regs[R_INTERRUPT_STATUS_REGISTER] &
@@ -897,59 +895,19 @@ static void regs2frame(XlnxVersalCANFDState *s, qemu_can_frame *frame,
     }
 
     if (FIELD_EX32(dlc_reg_val, TB0_DLC_REGISTER, FDF)) {
-        /*
-         * CANFD frame.
-         * Converting dlc(0 to 15) 4 Byte data to plain length(i.e. 0 to 64)
-         * 1 Byte data. This is done to make it work with SocketCAN.
-         * On actual CANFD frame, this value can't be more than 0xF.
-         * Conversion table for DLC to plain length:
-         *
-         *  DLC                        Plain Length
-         *  0 - 8                      0 - 8
-         *  9                          9 - 12
-         *  10                         13 - 16
-         *  11                         17 - 20
-         *  12                         21 - 24
-         *  13                         25 - 32
-         *  14                         33 - 48
-         *  15                         49 - 64
-         */
-
         frame->flags |= QEMU_CAN_FRMF_TYPE_FD;
 
-        if (dlc_value < 8) {
-            frame->can_dlc = dlc_value;
-        } else {
-            assert((dlc_value - 8) < ARRAY_SIZE(canfd_dlc_array));
-            frame->can_dlc = canfd_dlc_array[dlc_value - 8];
-        }
-
         if (FIELD_EX32(dlc_reg_val, TB0_DLC_REGISTER, BRS)) {
             frame->flags |= QEMU_CAN_FRMF_BRS;
         }
     } else {
-        /*
-         * FD Format bit not set that means it is a CAN Frame.
-         * Conversion table for classic CAN:
-         *
-         *  DLC                        Plain Length
-         *  0 - 7                      0 - 7
-         *  8 - 15                     8
-         */
-
-        if (dlc_value > 8) {
-            frame->can_dlc = 8;
-            qemu_log_mask(LOG_GUEST_ERROR, "Maximum DLC value for Classic CAN"
-                          " frame is 8. Only 8 byte data will be sent.\n");
-        } else {
-            frame->can_dlc = dlc_value;
-        }
-
         if (is_rtr) {
             frame->can_id |= QEMU_CAN_RTR_FLAG;
         }
     }
 
+    frame->can_dlc = can_dlc2len(dlc_value);
+
     for (j = 0; j < frame->can_dlc; j++) {
         val = 8 * (3 - i);
 
@@ -1007,7 +965,6 @@ static void store_rx_sequential(XlnxVersalCANFDState *s,
                                 bool rx_fifo_id, uint8_t filter_index)
 {
     int i;
-    bool is_canfd_frame;
     uint8_t dlc = frame->can_dlc;
     uint8_t rx_reg_num = 0;
     uint32_t dlc_reg_val = 0;
@@ -1053,17 +1010,10 @@ static void store_rx_sequential(XlnxVersalCANFDState *s,
 
         s->regs[store_location] = frame_to_reg_id(frame);
 
-        dlc = frame->can_dlc;
+        dlc_reg_val = FIELD_DP32(0, RB_DLC_REGISTER, DLC, can_len2dlc(dlc));
 
         if (frame->flags & QEMU_CAN_FRMF_TYPE_FD) {
-            is_canfd_frame = true;
-
-            /* Store dlc value in Xilinx specific format. */
-            for (i = 0; i < ARRAY_SIZE(canfd_dlc_array); i++) {
-                if (canfd_dlc_array[i] == frame->can_dlc) {
-                    dlc_reg_val = FIELD_DP32(0, RB_DLC_REGISTER, DLC, 8 + i);
-                }
-            }
+            dlc_reg_val |= FIELD_DP32(0, RB_DLC_REGISTER, FDF, 1);
 
             if (frame->flags & QEMU_CAN_FRMF_BRS) {
                 dlc_reg_val |= FIELD_DP32(0, RB_DLC_REGISTER, BRS, 1);
@@ -1071,17 +1021,8 @@ static void store_rx_sequential(XlnxVersalCANFDState *s,
             if (frame->flags & QEMU_CAN_FRMF_ESI) {
                 dlc_reg_val |= FIELD_DP32(0, RB_DLC_REGISTER, ESI, 1);
             }
-        } else {
-            is_canfd_frame = false;
-
-            if (frame->can_dlc > 8) {
-                dlc = 8;
-            }
-
-            dlc_reg_val = FIELD_DP32(0, RB_DLC_REGISTER, DLC, dlc);
         }
 
-        dlc_reg_val |= FIELD_DP32(0, RB_DLC_REGISTER, FDF, is_canfd_frame);
         dlc_reg_val |= FIELD_DP32(0, RB_DLC_REGISTER, TIMESTAMP, rx_timestamp);
         dlc_reg_val |= FIELD_DP32(0, RB_DLC_REGISTER, MATCHED_FILTER_INDEX,
                                   filter_index);
-- 
2.34.1


