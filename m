Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61F3C5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 03:52:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sinET-0005NM-R2; Mon, 26 Aug 2024 23:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sinEP-00057M-P0
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 23:50:58 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <doug@schmorgal.com>)
 id 1sinEN-0003rC-Hb
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 23:50:56 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7163489149eso3078957a12.1
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 20:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schmorgal.com; s=google; t=1724730653; x=1725335453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Awp0ytvcQ56tnn09fPAbSHHgINoCasgEEQF1NRSqcwA=;
 b=EFZvROAMuShF9+vW7CZxycQSaKHRXIK0Etlgw2NXhx28ONZr1bvj46GBCIzHM8nKx9
 eZZ9Iw8Ip1Ys1U9hzfpkQ3EF+SbicOl1lfHV7uIW7iMD4xkZ3oOP+Y0XvgaHu6JNaTzA
 00wUNod9KiIqViauhrBAzEx4lQnRpX8W8WVr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724730653; x=1725335453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Awp0ytvcQ56tnn09fPAbSHHgINoCasgEEQF1NRSqcwA=;
 b=KPZ6XpN/K/9J6O1aI2MpHzWzAPKvAN3bnL8o5RcYS5n+85qqSfWs21Y553L8zh/url
 U49DUJ/I3zGeoJmBBNamPDuYG0M7qwxcZF2BxxzR4hn25YYhytaYLwCM+0JdM61DkEi5
 AH2TdZOfVf+C1POOjmxXwAaqd8jo6w/3yJ4u5R56AvJC9jtFCM+kzFdcPo3CIMfBhGXj
 fCNgsjhMP0qJgzkc8Y2OI5jHzkr2NT1ACeennzUr5C4UGYCJnBJh3cICinNBfBxeufsI
 bRSn2+2ycSaIAE3tQmT53LMKn0X4sTLP7upqX7sCwux3dij7dtP/KGwBdn617EakODxM
 mvhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEz5+3FmklyZ/cZesjNMNU6sChKMdIbdkRxV1WlKuvT+I4NBvWcPsWEkOsz+CfNI/zTIvItV6YEvgY@nongnu.org
X-Gm-Message-State: AOJu0Yw47GqrMWzwBpTX57ywb+on03JKsm2vHRgr0g7bmDbbt3ppWz6Q
 UNdHaPzmNFofNX8hTJeStWuVli0KjEZYPczZQRYMuVFb/9tsq1DcHGhy3qtZqz0=
X-Google-Smtp-Source: AGHT+IEMwa0uTkA57YVq8QyRnfzAPIK03A5xb3nbdhcI//ULSPBM6r28Im8OSZxxgno1CdVcpS6wTg==
X-Received: by 2002:a05:6a20:e687:b0:1c8:b10d:eadb with SMTP id
 adf61e73a8af0-1cc8b4855b3mr14515630637.17.1724730653261; 
 Mon, 26 Aug 2024 20:50:53 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.37.200.153])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-203855dd269sm74503625ad.135.2024.08.26.20.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 20:50:52 -0700 (PDT)
From: Doug Brown <doug@schmorgal.com>
To: Francisco Iglesias <francisco.iglesias@amd.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <bonzini@gnu.org>,
 qemu-devel@nongnu.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 6/7] hw/net/can/xlnx-versal-canfd: Simplify DLC conversions
Date: Mon, 26 Aug 2024 20:49:26 -0700
Message-Id: <20240827034927.66659-7-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827034927.66659-1-doug@schmorgal.com>
References: <20240827034927.66659-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=doug@schmorgal.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Use QEMU's helper functions can_dlc2len() and can_len2dlc() for
translating between the raw DLC value and the SocketCAN length value.
This also has the side effect of correctly handling received CAN FD
frames with a DLC of 0-8, which was broken previously.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 hw/net/can/xlnx-versal-canfd.c | 67 ++--------------------------------
 1 file changed, 4 insertions(+), 63 deletions(-)

diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index 5d7adf8740..589c21db69 100644
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


