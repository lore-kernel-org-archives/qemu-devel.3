Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E10C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzcCC-0000Tx-KP; Tue, 01 Apr 2025 10:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzcBx-00086A-0B
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:02:17 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzcBu-0000PA-Kl
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:02:12 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2255003f4c6so100011645ad.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 07:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743516129; x=1744120929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W6rdKQAZN0wxZ5/2NXHFTrB7ljdm2MuzSFZ6lLJyE3g=;
 b=k0ZWAv4txk05qNGewrEr4bN5FsjD3c52J2kdj8pkNEEL+wa2kLX4xY4NugaBcPaiJX
 wAfnJtzjs9gI5TxPl3GHnm1x++3GGQFtyaWQxBmCeYHRR5y0wKStPJE9LyMZwxK+Yi8c
 94UV+TxIPQDEaTdSUcAslIR8OvvJ2cyV9k/klWWVR83OXbeUw9EzhKet/oWUWRewQyrr
 KOmmwek1W0tVy3uG2A6c/L0BzWjU+e+Xc2Qcloy6mEnDAiU28wa3aivvJYNdgo8j47uA
 YZrQ+4Q7dJIgd2gSayIw5HuIK3AWdeXu23i+N+Zg5ak3eRdeyZQWdgpO/Xv+sD/Ojmck
 hkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743516129; x=1744120929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W6rdKQAZN0wxZ5/2NXHFTrB7ljdm2MuzSFZ6lLJyE3g=;
 b=jOP5oIDpyyOdf9VquuLoDZ6hH3RB1PW12KtqX38ezIB6AbEhC964jCFrKWKnaHnUwu
 wdT36QuF9xB6DCWKNvAR+3k8XTHLxUCLwNb6W1jW+Sa6cfkzIo/kw87kACB/0Z8b6ADO
 evf/Ni6YTab/m8y9ULXnlphhgbCzihYQkrrUIa64l4SUjGC0XyWeCMBsnaiXS8AJFSpH
 YBSC9XiV7Q5/T4Iukj6FJYZ5hp6VaiQiRVS1Fwn2wJWZrUrTQqL/DXb/ZyZ8lS+16yPT
 oR4M3MCAgv6+4WxjYdlUXKrQvCSMj3cRgHyVD0JpMUmywlwcUKUiFLSKfLmvDxbwT7el
 6yIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCOKnygNv/zF2rATuRmd2cAWoQSpMNeoAQkD9ioo/daxLn5ypBf+S79xLdaIhnd0C/4VL7PShlKLIw@nongnu.org
X-Gm-Message-State: AOJu0Yy5NxwYSKEDrkbfs671DDU4SyMuwC7mxz3YP5va9NEBr7JtijHe
 gKyY4fZD+LOO7DE+fnayMQYA6yrr4Fgumxg8groU20Sfe1kHe7eNC4D2Ew==
X-Gm-Gg: ASbGncsy32kkeb4fi/16fVhzG5P8tRbcf1bF4By47ZR/t9q+sHcpGBFyJ37UK1YVyux
 8UYjtVqro03MNQglq9T9XIF7XjTMMZn9bX8Ns1BRhp78WOY4B0I4at7pilUVynRed2IMQU6EAqr
 uk5NYefWqhT9NqdI2bGu4C5Q6P8k48dgth7tTxAvvy7vXo73aLrvA37B3TGz7C6QiBc4nfoDmHV
 RS7LkpXo/pdMieE4EG2A7r2N6oQqbUERKTtW3/dB0qC/pl+M5JnUwsOMljrvrBdE2Ozysqb0E6e
 hnZZwv0oG7foOf7eAMTCqPkdtLgVI6QSiEvaECcCWoLkLsQPxQ==
X-Google-Smtp-Source: AGHT+IFRa6shF12JvcB9hpcvKkrifYF+7FX+bGwnqiHefVx/f8VKOYyZFOjMDlin3cBTvwQk7lBnLg==
X-Received: by 2002:a17:902:e54e:b0:21a:8300:b9ce with SMTP id
 d9443c01a7336-2295c12e596mr51753525ad.49.1743516128693; 
 Tue, 01 Apr 2025 07:02:08 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1f5774sm87768455ad.214.2025.04.01.07.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 07:02:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Corey Minyard <minyard@acm.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 3/5] ipmi/bmc-sim: Add 'Get Channel Info' command
Date: Wed,  2 Apr 2025 00:01:50 +1000
Message-ID: <20250401140153.685523-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401140153.685523-1-npiggin@gmail.com>
References: <20250401140153.685523-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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
 include/hw/ipmi/ipmi.h | 10 +++++++
 hw/ipmi/ipmi_bmc_sim.c | 68 ++++++++++++++++++++++++++++++++++++++++--
 hw/ipmi/ipmi_bt.c      |  2 ++
 hw/ipmi/ipmi_kcs.c     |  1 +
 4 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
index c8ef04856e1..802a2febb07 100644
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
@@ -76,6 +85,7 @@ typedef struct IPMIFwInfo {
     int interface_type;
     uint8_t ipmi_spec_major_revision;
     uint8_t ipmi_spec_minor_revision;
+    uint8_t ipmi_channel_protocol;
     uint8_t i2c_slave_address;
     uint32_t uuid;
 
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 6157ac71201..d63f2348ba1 100644
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
@@ -1219,6 +1220,68 @@ static void get_watchdog_timer(IPMIBmcSim *ibs,
     }
 }
 
+static void get_channel_info(IPMIBmcSim *ibs,
+                             uint8_t *cmd, unsigned int cmd_len,
+                             RspBuffer *rsp)
+{
+    IPMIInterface *s = ibs->parent.intf;
+    IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
+    IPMIFwInfo info = {};
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
+    if (k->get_fwinfo) {
+        k->get_fwinfo(s, &info);
+    }
+
+    if (ch == IPMI_CHANNEL_IPMB) {
+        rsp_buffer_push(rsp, IPMI_CHANNEL_MEDIUM_IPMB);
+        rsp_buffer_push(rsp, IPMI_CHANNEL_PROTOCOL_IPMB);
+    } else { /* IPMI_CHANNEL_SYSTEM */
+        rsp_buffer_push(rsp, IPMI_CHANNEL_MEDIUM_SYSTEM);
+        rsp_buffer_push(rsp, info.ipmi_channel_protocol);
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
+        uint8_t irq;
+
+        if (info.irq_source == IPMI_ISA_IRQ) {
+            irq = info.interrupt_number;
+        } else if (info.irq_source == IPMI_PCI_IRQ) {
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
@@ -2015,6 +2078,7 @@ static const IPMICmdHandler app_cmds[] = {
     [IPMI_CMD_RESET_WATCHDOG_TIMER] = { reset_watchdog_timer },
     [IPMI_CMD_SET_WATCHDOG_TIMER] = { set_watchdog_timer, 8 },
     [IPMI_CMD_GET_WATCHDOG_TIMER] = { get_watchdog_timer },
+    [IPMI_CMD_GET_CHANNEL_INFO] = { get_channel_info, 3 },
 };
 static const IPMINetfn app_netfn = {
     .cmd_nums = ARRAY_SIZE(app_cmds),
diff --git a/hw/ipmi/ipmi_bt.c b/hw/ipmi/ipmi_bt.c
index 583fc64730c..28cf6ab2185 100644
--- a/hw/ipmi/ipmi_bt.c
+++ b/hw/ipmi/ipmi_bt.c
@@ -419,6 +419,8 @@ void ipmi_bt_get_fwinfo(struct IPMIBT *ib, IPMIFwInfo *info)
     info->interface_type = IPMI_SMBIOS_BT;
     info->ipmi_spec_major_revision = 2;
     info->ipmi_spec_minor_revision = 0;
+    /* BT System Interface Format, IPMI v1.5 */
+    info->ipmi_channel_protocol = IPMI_CHANNEL_PROTOCOL_BT_15;
     info->base_address = ib->io_base;
     info->register_length = ib->io_length;
     info->register_spacing = 1;
diff --git a/hw/ipmi/ipmi_kcs.c b/hw/ipmi/ipmi_kcs.c
index c15977cab4c..578dd7cef34 100644
--- a/hw/ipmi/ipmi_kcs.c
+++ b/hw/ipmi/ipmi_kcs.c
@@ -405,6 +405,7 @@ void ipmi_kcs_get_fwinfo(IPMIKCS *ik, IPMIFwInfo *info)
     info->interface_type = IPMI_SMBIOS_KCS;
     info->ipmi_spec_major_revision = 2;
     info->ipmi_spec_minor_revision = 0;
+    info->ipmi_channel_protocol = IPMI_CHANNEL_PROTOCOL_KCS;
     info->base_address = ik->io_base;
     info->i2c_slave_address = ik->bmc->slave_addr;
     info->register_length = ik->io_length;
-- 
2.47.1


