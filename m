Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBDFC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 12:58:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzEi2-0006C7-HV; Mon, 31 Mar 2025 08:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzEi0-0006Bq-2b
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:57:44 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzEhy-000173-9y
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 08:57:43 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22928d629faso47220715ad.3
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 05:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743425861; x=1744030661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=omEx8EKLunY54Ma+wQ+BIg2EYA/LEOc9I0znrxH406c=;
 b=jSgvAZCtIZxfZlq2XYekq9MbH4tcyl/wDobhyvgKVpRop6S8oV4GCUr5mFzodyplA6
 XN9vgcZgE0lF2MNEvkDRzAuIywwaFQVNdRhbsw7nKlOJm7c6TFhFYtpZI8pMgV/+L6jl
 kotnMUONXYFb65PV86bfXmHG1F71O8wpD9A7FMN5W7xAZE4OH+ixMKyyoSy9nBxtLGpm
 oRtgmc0mrtaVSlbSqzp8ba5PFB1tw6SVgxbzLkH6+wZTpjjyCBc7l+N7mKfwHYjXg7El
 X7R4/BLHGgYXXs16GpSuGof9XlYjfZekWGCw6/rm/ti8LReeX43bgypgh+liQXjiFoGx
 HNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743425861; x=1744030661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=omEx8EKLunY54Ma+wQ+BIg2EYA/LEOc9I0znrxH406c=;
 b=QoXLOJHVNnUjQztfW2PAXWwKVdRORWZxSiBiGT+75LCbbnPR8NfveITiIZSWXVt0Ae
 dycXW4hddbOOAPvQ1Z27ZvEdXNu0bJfPIDwIGnH99rq9AYRhEnoAv3tntLI5M/ttFgks
 HslyegOW53f0Aj7/PvaWf4uEdYMEgySMkE49A2JKFq9WIgVu8IFd8JjC5R1zQTtFcFSU
 sGNVFtyRNs9+7oH/+4KjvQo+L11aZEvOW5aKZq/QkKwbLnOvRyDj5d7Ew2Ebj/5l7ckI
 4OrZabyXlBqcMfmGpqGZlTB44RudVMbogwsF3DtzUKGxVqbuQHv8bjyK0QtxtWd3BcT5
 XwxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjOPRsI5GYOGJqvHHLLPFh4m3bvec0LkksxDTEJ15KY/ZFjLDsd9LV3y93sADJCfx8JmYo5gXHr2JD@nongnu.org
X-Gm-Message-State: AOJu0YxwvdU7Tv0vxxbKXYEgz5M2TLkfBpsu3Kicmo5S0V/4MlOXvbTj
 NyM65PreNVQgmQ8QTrPB6zTqZOVqcn4GOI98S9X0+4ihH4jeVLxQdDLHBQ==
X-Gm-Gg: ASbGncsmNhaJauPFXdK576eqHsaIO/5PdeZmlL1h1S7rAwjeSWNc2qgdDIZAaPhLWQu
 LW7CPxYq0t5TkI4+Hr/T6ZTj3LSaxGxkeJrnF7G30+IAssxlC1k/LVsvaVosQPfRzWokw9lr8tA
 vp8t6RcFM+H0wI05w0+q/LWZMzezVF6oXxIqtsC/humSXBw5+LyyxhVoGDwap1US1VHdKmgcerp
 j8tF/q1rIoVhVutpqZX0CkCZVyNGivN4zQlE+ZU8cU02YTTMp5w42K4QgBtIw4Iw6edaFj4sypj
 fX/Sms0v8eE5ZSwBsZgMQmQ17ZaYCgwaa/VdIixSGSapEQ/KEw==
X-Google-Smtp-Source: AGHT+IERP5/WN8zI1jT/uVqOctgcUvDLk8njbNe3+V9DU6vQDGX6Isx0xlI49G2Gm6kSaDTNHVa3kA==
X-Received: by 2002:a05:6a21:8dc3:b0:1f5:75a9:526c with SMTP id
 adf61e73a8af0-2009f5fd52dmr16172858637.13.1743425860786; 
 Mon, 31 Mar 2025 05:57:40 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af93b67dc0fsm6324016a12.16.2025.03.31.05.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 05:57:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Corey Minyard <minyard@acm.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 3/3] ipmi/bmc-sim: Add 'Get Channel Info' command
Date: Mon, 31 Mar 2025 22:57:24 +1000
Message-ID: <20250331125724.607355-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331125724.607355-1-npiggin@gmail.com>
References: <20250331125724.607355-1-npiggin@gmail.com>
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

Linux issues this command when booting a powernv machine.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ipmi/ipmi.h | 14 +++++++++++
 hw/ipmi/ipmi_bmc_sim.c | 56 ++++++++++++++++++++++++++++++++++++++++--
 hw/ipmi/ipmi_bt.c      |  2 ++
 hw/ipmi/ipmi_kcs.c     |  1 +
 4 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
index 77a7213ed93..5f01a50cd86 100644
--- a/include/hw/ipmi/ipmi.h
+++ b/include/hw/ipmi/ipmi.h
@@ -41,6 +41,15 @@ enum ipmi_op {
     IPMI_SEND_NMI
 };
 
+/* Channel properties */
+#define IPMI_CHANNEL_IPMB                0x00
+#define IPMI_CHANNEL_SYSTEM              0x0f
+#define IPMI_CH_MEDIUM_IPMB              0x01
+#define IPMI_CH_MEDIUM_SYSTEM            0x0c
+#define IPMI_CH_PROTOCOL_IPMB            0x01
+#define IPMI_CH_PROTOCOL_KCS             0x05
+#define IPMI_CH_PROTOCOL_BT_15           0x08
+
 #define IPMI_CC_INVALID_CMD                              0xc1
 #define IPMI_CC_COMMAND_INVALID_FOR_LUN                  0xc2
 #define IPMI_CC_TIMEOUT                                  0xc3
@@ -170,6 +179,11 @@ struct IPMIInterfaceClass {
      * Return the firmware info for a device.
      */
     void (*get_fwinfo)(struct IPMIInterface *s, IPMIFwInfo *info);
+
+    /*
+     * IPMI channel protocol type number.
+     */
+    uint8_t protocol;
 };
 
 /*
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 8c3313aa65f..9198f854bd9 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -70,6 +70,7 @@
 #define IPMI_CMD_GET_MSG                  0x33
 #define IPMI_CMD_SEND_MSG                 0x34
 #define IPMI_CMD_READ_EVT_MSG_BUF         0x35
+#define IPMI_CMD_GET_CHANNEL_INFO         0x42
 
 #define IPMI_NETFN_STORAGE            0x0a
 
@@ -1033,8 +1034,8 @@ static void send_msg(IPMIBmcSim *ibs,
     uint8_t *buf;
     uint8_t netfn, rqLun, rsLun, rqSeq;
 
-    if (cmd[2] != 0) {
-        /* We only handle channel 0 with no options */
+    if (cmd[2] != IPMI_CHANNEL_IPMB) {
+        /* We only handle channel 0h (IPMB) with no options */
         rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
         return;
     }
@@ -1232,6 +1233,56 @@ static void get_watchdog_timer(IPMIBmcSim *ibs,
     }
 }
 
+static void get_channel_info(IPMIBmcSim *ibs,
+                             uint8_t *cmd, unsigned int cmd_len,
+                             RspBuffer *rsp)
+{
+    IPMIInterface *s = ibs->parent.intf;
+    IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
+    uint8_t ch = cmd[1] & 0x0f;
+
+    /* Only define channel 0h (IPMB) and Fh (system interface) */
+
+    if (ch == 0x0e) { /* "This channel" */
+        ch = IPMI_CHANNEL_SYSTEM;
+    }
+    rsp_buffer_push(rsp, ch);
+
+    if (ch != IPMI_CHANNEL_IPMB && ch != IPMI_CHANNEL_SYSTEM) {
+        /* Not supported */
+        int i;
+        for (i = 0; i < 8; i++) {
+            rsp_buffer_push(rsp, 0x00);
+        }
+        return;
+    }
+
+    if (ch == IPMI_CHANNEL_IPMB) {
+        rsp_buffer_push(rsp, IPMI_CH_MEDIUM_IPMB);
+        rsp_buffer_push(rsp, IPMI_CH_PROTOCOL_IPMB);
+    } else { /* IPMI_CHANNEL_SYSTEM */
+        rsp_buffer_push(rsp, IPMI_CH_MEDIUM_SYSTEM);
+        rsp_buffer_push(rsp, k->protocol);
+    }
+
+    rsp_buffer_push(rsp, 0x00); /* Session-less */
+
+    /* IPMI Vendor ID */
+    rsp_buffer_push(rsp, 0xf2);
+    rsp_buffer_push(rsp, 0x1b);
+    rsp_buffer_push(rsp, 0x00);
+
+    if (ch == IPMI_CHANNEL_SYSTEM) {
+        /* IRQ assigned by ACPI/PnP (XXX?) */
+        rsp_buffer_push(rsp, 0x60);
+        rsp_buffer_push(rsp, 0x60);
+    } else {
+        /* Reserved */
+        rsp_buffer_push(rsp, 0x00);
+        rsp_buffer_push(rsp, 0x00);
+    }
+}
+
 static void get_sdr_rep_info(IPMIBmcSim *ibs,
                              uint8_t *cmd, unsigned int cmd_len,
                              RspBuffer *rsp)
@@ -2028,6 +2079,7 @@ static const IPMICmdHandler app_cmds[] = {
     [IPMI_CMD_RESET_WATCHDOG_TIMER] = { reset_watchdog_timer },
     [IPMI_CMD_SET_WATCHDOG_TIMER] = { set_watchdog_timer, 8 },
     [IPMI_CMD_GET_WATCHDOG_TIMER] = { get_watchdog_timer },
+    [IPMI_CMD_GET_CHANNEL_INFO] = { get_channel_info, 3 },
 };
 static const IPMINetfn app_netfn = {
     .cmd_nums = ARRAY_SIZE(app_cmds),
diff --git a/hw/ipmi/ipmi_bt.c b/hw/ipmi/ipmi_bt.c
index 583fc64730c..d639c151c4d 100644
--- a/hw/ipmi/ipmi_bt.c
+++ b/hw/ipmi/ipmi_bt.c
@@ -434,4 +434,6 @@ void ipmi_bt_class_init(IPMIInterfaceClass *iic)
     iic->handle_if_event = ipmi_bt_handle_event;
     iic->set_irq_enable = ipmi_bt_set_irq_enable;
     iic->reset = ipmi_bt_handle_reset;
+    /* BT System Interface Format, IPMI v1.5 */
+    iic->protocol = IPMI_CH_PROTOCOL_BT_15;
 }
diff --git a/hw/ipmi/ipmi_kcs.c b/hw/ipmi/ipmi_kcs.c
index c15977cab4c..8af7698286d 100644
--- a/hw/ipmi/ipmi_kcs.c
+++ b/hw/ipmi/ipmi_kcs.c
@@ -420,4 +420,5 @@ void ipmi_kcs_class_init(IPMIInterfaceClass *iic)
     iic->handle_rsp = ipmi_kcs_handle_rsp;
     iic->handle_if_event = ipmi_kcs_handle_event;
     iic->set_irq_enable = ipmi_kcs_set_irq_enable;
+    iic->protocol = IPMI_CH_PROTOCOL_KCS;
 }
-- 
2.47.1


