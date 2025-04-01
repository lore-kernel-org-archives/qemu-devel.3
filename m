Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EB3C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 11:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tza2t-0002Jc-1d; Tue, 01 Apr 2025 07:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tza2f-0002FD-3b
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 07:44:31 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tza2d-0003hA-3k
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 07:44:28 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-22403cbb47fso112604695ad.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 04:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743507866; x=1744112666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5vyaNdF0ED2Kh0ojZF34u+l4QmvwlnYjuPhl4oykfjA=;
 b=FOMGuIlG0a8dDmwhDC+ZBbq2ovfoiEvunrMtswA5seQ0JTLwlpSZB1jkhP9lnacDkE
 hecnR4MhsHwBbZ8gn2xbBYJ1N/HB6Gqq8/qjRduyZ8nahhiOkOmUvqd8JDgYCkCtnmX6
 aqzEtuZxhqESLb19vT1dcPw+8qtvHQOHnIEJLhwMmCdhNdm77U5hE+pQRimER2mHrPky
 N88nFFRlUdrUYPdDRe5iqefD0sD597EGBpGXafkqtJRgTLO2HvvCe7hy+LL7mAra7wOc
 Duzfp62+jAVWRSTC0ucyvDd6GLRoz1GRuL+SM3lbNRKD4b8IKeZrbMe7KycPxnWhVl5p
 BQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743507866; x=1744112666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5vyaNdF0ED2Kh0ojZF34u+l4QmvwlnYjuPhl4oykfjA=;
 b=wBFZ9fREv+rtlhH9KuQErelHoXNvSRMMR729FrAq5f3b3GX4sPkvBY5aKLyPna+pZM
 O9msJHIzsrga0WeDiKUhqbfxmLTVtBswLav++1B03zbkiDRoLL4NTDWOo7NaGDwRlpsP
 GpWvvnrfZ2WFDzh0f3w5Kq3FDJhHrEzk6hGnk4ovr2SxlVWgGDeLMsDofT0mskjGTx88
 h4JHPpq6Ls32dujq3dljV1vjXmhtRMuaxa+JFFWagXqdMvnTCpiRJitXlyuNdwi7Rc3m
 eDx0dAIAcLhpTIdMI0lGy4CI8djj1Xn71e1OfM+O6miZFXeo/MJJMB1GiMG0uWwulJ31
 qMLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLC4D8Z3uYNqYjWrdfz9oLwrAcz4CAlhkPeRvCMP//01Tc72xMUzxo4z3yze5dIelftl2VtzvwLXIh@nongnu.org
X-Gm-Message-State: AOJu0YwQDIGWde11B705oRvhpiI22I8e9MNQoH4EQ5HiYM+mtWLYH0ll
 tE1NAGD+DMiRPM93CuwFZffFJGoSDJBE8UCdwlkfK2870P8yk9bE1LwcNg==
X-Gm-Gg: ASbGncuapo38hGzCRyE9KxnW2c6mLCX4ynzhJSekNIQ/CmUi4ixx23brx5fHbG539wc
 IzI1jp4Sog9n/y87LjAh0v3T2gU42Eo9g+OL+ZpxnEPhpBvIrQkvNtH7O264j2fTFuZbuf4p2WA
 2b1mvUrEPDCGvXjPUqrmg/NZOLKV86V5xN02TBmzyUBV4BP88hkbz1VJR/c3ZI/pxLgGOu+8e19
 u0CFotdJLyYX01Q8zufadQK7EB4CtPPkT+wX9RaGpWEf3vLAtFh4ascX/e9E5wXuZTm6EopCmTX
 xR/kisHKUy1R3wrBzOcNqx3SM3Znw602nTi4ZxN8l0D2TAAPkA==
X-Google-Smtp-Source: AGHT+IFnsQTqEltoOPdvO6SIRxje6y+bfvXxzl7B+8g3caOPoWoKh/KrytSKzHCBP9PwZcLn0xKpgg==
X-Received: by 2002:a17:903:98c:b0:224:10a2:cad9 with SMTP id
 d9443c01a7336-2292f9f13f8mr222118895ad.41.1743507865562; 
 Tue, 01 Apr 2025 04:44:25 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291eee11b7sm86408135ad.86.2025.04.01.04.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 04:44:25 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Corey Minyard <minyard@acm.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 3/5] ipmi/bmc-sim: Add 'Get Channel Info' command
Date: Tue,  1 Apr 2025 21:44:10 +1000
Message-ID: <20250401114412.676636-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401114412.676636-1-npiggin@gmail.com>
References: <20250401114412.676636-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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
 include/hw/ipmi/ipmi.h | 14 +++++++++
 hw/ipmi/ipmi_bmc_sim.c | 65 ++++++++++++++++++++++++++++++++++++++++--
 hw/ipmi/ipmi_bt.c      |  2 ++
 hw/ipmi/ipmi_kcs.c     |  1 +
 4 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
index 71c4efac8cd..d1af660012a 100644
--- a/include/hw/ipmi/ipmi.h
+++ b/include/hw/ipmi/ipmi.h
@@ -41,6 +41,15 @@ enum ipmi_op {
     IPMI_SEND_NMI
 };
 
+/* Channel properties */
+#define IPMI_CHANNEL_IPMB                0x00
+#define IPMI_CHANNEL_SYSTEM              0x0f
+#define IPMI_CHANNEL_MEDIUM_IPMB         0x01
+#define IPMI_CHANNEL_MEDIUM_SYSTEM       0x0c
+#define IPMI_CHANNEL_PROTOCOL_IPMB       0x01
+#define IPMI_CHANNEL_PROTOCOL_KCS        0x05
+#define IPMI_CHANNEL_PROTOCOL_BT_15      0x08
+
 #define IPMI_CC_INVALID_CMD                              0xc1
 #define IPMI_CC_COMMAND_INVALID_FOR_LUN                  0xc2
 #define IPMI_CC_TIMEOUT                                  0xc3
@@ -175,6 +184,11 @@ struct IPMIInterfaceClass {
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
index 6157ac71201..216bf8ff7f0 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -70,6 +70,7 @@
 #define IPMI_CMD_GET_MSG                  0x33
 #define IPMI_CMD_SEND_MSG                 0x34
 #define IPMI_CMD_READ_EVT_MSG_BUF         0x35
+#define IPMI_CMD_GET_CHANNEL_INFO         0x42
 
 #define IPMI_NETFN_STORAGE            0x0a
 
@@ -1020,8 +1021,8 @@ static void send_msg(IPMIBmcSim *ibs,
     uint8_t *buf;
     uint8_t netfn, rqLun, rsLun, rqSeq;
 
-    if (cmd[2] != 0) {
-        /* We only handle channel 0 with no options */
+    if (cmd[2] != IPMI_CHANNEL_IPMB) {
+        /* We only handle channel 0h (IPMB) with no options */
         rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
         return;
     }
@@ -1219,6 +1220,65 @@ static void get_watchdog_timer(IPMIBmcSim *ibs,
     }
 }
 
+static void get_channel_info(IPMIBmcSim *ibs,
+                             uint8_t *cmd, unsigned int cmd_len,
+                             RspBuffer *rsp)
+{
+    IPMIInterface *s = ibs->parent.intf;
+    IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
+    uint8_t ch = cmd[2] & 0x0f;
+
+    /* Only define channel 0h (IPMB) and Fh (system interface) */
+
+    if (ch == 0x0e) { /* "This channel" */
+        ch = IPMI_CHANNEL_SYSTEM;
+    }
+    rsp_buffer_push(rsp, ch);
+
+    if (ch != IPMI_CHANNEL_IPMB && ch != IPMI_CHANNEL_SYSTEM) {
+        /* Not a supported channel */
+        rsp_buffer_set_error(rsp, IPMI_CC_INVALID_DATA_FIELD);
+        return;
+    }
+
+    if (ch == IPMI_CHANNEL_IPMB) {
+        rsp_buffer_push(rsp, IPMI_CHANNEL_MEDIUM_IPMB);
+        rsp_buffer_push(rsp, IPMI_CHANNEL_PROTOCOL_IPMB);
+    } else { /* IPMI_CHANNEL_SYSTEM */
+        rsp_buffer_push(rsp, IPMI_CHANNEL_MEDIUM_SYSTEM);
+        rsp_buffer_push(rsp, k->protocol);
+    }
+
+    rsp_buffer_push(rsp, 0x00); /* Session-less */
+
+    /* IPMI Enterprise Number for Vendor ID */
+    rsp_buffer_push(rsp, 0xf2);
+    rsp_buffer_push(rsp, 0x1b);
+    rsp_buffer_push(rsp, 0x00);
+
+    if (ch == IPMI_CHANNEL_SYSTEM) {
+        IPMIFwInfo info = {};
+        uint8_t irq;
+
+        k->get_fwinfo(s, &info);
+        if (info.irq == IPMI_ISA_IRQ) {
+            irq = info.interrupt_number;
+	} else if (info.irq == IPMI_PCI_IRQ) {
+            irq = 0x10 + info.interrupt_number;
+        } else {
+            irq = 0xff; /* no interrupt / unspecified */
+        }
+
+        /* Both interrupts use the same irq number */
+        rsp_buffer_push(rsp, irq);
+        rsp_buffer_push(rsp, irq);
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
@@ -2015,6 +2075,7 @@ static const IPMICmdHandler app_cmds[] = {
     [IPMI_CMD_RESET_WATCHDOG_TIMER] = { reset_watchdog_timer },
     [IPMI_CMD_SET_WATCHDOG_TIMER] = { set_watchdog_timer, 8 },
     [IPMI_CMD_GET_WATCHDOG_TIMER] = { get_watchdog_timer },
+    [IPMI_CMD_GET_CHANNEL_INFO] = { get_channel_info, 3 },
 };
 static const IPMINetfn app_netfn = {
     .cmd_nums = ARRAY_SIZE(app_cmds),
diff --git a/hw/ipmi/ipmi_bt.c b/hw/ipmi/ipmi_bt.c
index 583fc64730c..79311c41f2b 100644
--- a/hw/ipmi/ipmi_bt.c
+++ b/hw/ipmi/ipmi_bt.c
@@ -434,4 +434,6 @@ void ipmi_bt_class_init(IPMIInterfaceClass *iic)
     iic->handle_if_event = ipmi_bt_handle_event;
     iic->set_irq_enable = ipmi_bt_set_irq_enable;
     iic->reset = ipmi_bt_handle_reset;
+    /* BT System Interface Format, IPMI v1.5 */
+    iic->protocol = IPMI_CHANNEL_PROTOCOL_BT_15;
 }
diff --git a/hw/ipmi/ipmi_kcs.c b/hw/ipmi/ipmi_kcs.c
index c15977cab4c..618a33c581f 100644
--- a/hw/ipmi/ipmi_kcs.c
+++ b/hw/ipmi/ipmi_kcs.c
@@ -420,4 +420,5 @@ void ipmi_kcs_class_init(IPMIInterfaceClass *iic)
     iic->handle_rsp = ipmi_kcs_handle_rsp;
     iic->handle_if_event = ipmi_kcs_handle_event;
     iic->set_irq_enable = ipmi_kcs_set_irq_enable;
+    iic->protocol = IPMI_CHANNEL_PROTOCOL_KCS;
 }
-- 
2.47.1


