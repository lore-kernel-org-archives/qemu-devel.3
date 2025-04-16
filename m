Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143A5C369BD
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 00:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5CiM-00043c-KG; Wed, 16 Apr 2025 20:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1u5CiK-00042v-Bo
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 20:02:44 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1u5CiI-0006QC-Gk
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 20:02:44 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-603fd257386so36718eaf.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 17:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1744848159; x=1745452959;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/AW4tnkOIpzn+hkaLSPNo53y2Z1zRYt/SZox39VKYwQ=;
 b=dFYhTQShKnK6/K52R5SA/rna2kf7nTu4uFvWFgcf1Cya2ruN9beCfrEGzeeI/8DciV
 DWypoptbhzO1oazB/mQZLMu+gvXRuogxdOUzp3mAk3LCqtH6F+8yeiD/cLp9R0CuToTl
 gIh61wsI8r2Ga6G0lVnfrP4OSxCzsYthGvvmj20EFA4AC/r3iGGwj3V29AD8yAjK/2R8
 Fs74586aNCAgbMv3/EhZrO7gjNY3oIc93a/6saC5LIWXL2K1X12IlDZ9IIh4qMG2ZgZq
 c5zb/eQ0qHHMLBAF/MMzeMx0XTXNA26TYSZdqQld7sSzo7JOMeSs6EhdLR6pptOyLdje
 gSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744848159; x=1745452959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/AW4tnkOIpzn+hkaLSPNo53y2Z1zRYt/SZox39VKYwQ=;
 b=xENZF7xDnG0EU4IWBw816c0PWW4Bou/7oWCbTxGo0AAz+JY6ykngg8cZuffOacmQu1
 NOZu12LzDpeYVscAb251RKIc64KY+xUv9AzuVeAK4tM7TYAXP4dTyMp8at6bGrHM1Er8
 0EHMUBkXPLni7I609XIm8SgSJjnaLKrwfqmbUcWKzTPsKzs6RjKU+zYFN9kJ4/NAQT+y
 jKm3x9d4AJhD2Xy4Q9k6ALZ6uLnf75k5ymTxyQTqRnSBKNkfg372xH8vvM6Zl3paiGVC
 Ik+1W9YFM+zzg7gs4IBkDsRsnUqu+JNVKAvYPWgYjeviqc/5hXbIs8JV7OWF9LeGuMOh
 GAQg==
X-Gm-Message-State: AOJu0Ywy8JwBAEEfpmoUY9Wi6rap7iPoRhnG1n3TVFQbQeAatwXmkHeV
 xWUkjOV48sGZtYdnSu+wmu3xJIR3kAayYnKqpGVo4NGz/uzbLE1jSVR+XQFRN/cTXZhSOlQZVrv
 m
X-Gm-Gg: ASbGncuJ44bfizIZos9KT7rThLVyY7wkqygCA+DXd41jd4Mn9lkGKEddntfBM8WY/x+
 R/imYe0zHZp+7Shiwx8vUkl53iRl+Gy7NZ1geiLdnJJOqd1HGkLKK8hKYtvhe0LdSGNps229z5a
 dfKHME/OPmTAhVcul9fLitUx1aqwig8Zkte9axABTcjl7EaVR8HS/M0CUCM8LeVxNOQj18GdD5I
 WB7RlO8GuF5jESgn7C1pPeqMDAuE8Qw+GGOF8q5yYJ/KoHy1LeUbIhDS/KHGvRexrJ6HlkiyUff
 bvsmbRVxfcHmYfKRKpfwpqZPjKPthASPSfs=
X-Google-Smtp-Source: AGHT+IGf3fmN6Dftp8lWka7GnVEDjDvMNgDglg2hGJsI7Z241e3OMiamt8xvqgEcHw3195BZlNuLZA==
X-Received: by 2002:a05:6820:509:b0:604:710b:b921 with SMTP id
 006d021491bc7-604a8fcacbdmr1941982eaf.0.1744848158441; 
 Wed, 16 Apr 2025 17:02:38 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:8795:e9fb:beca:ef25])
 by smtp.gmail.com with UTF8SMTPSA id
 006d021491bc7-604a5b94c27sm567505eaf.13.2025.04.16.17.02.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 17:02:37 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Corey Minyard <corey@minyard.net>
Subject: [PULL 4/6] ipmi/bmc-sim: Add 'Get Channel Info' command
Date: Wed, 16 Apr 2025 18:59:08 -0500
Message-ID: <20250417000224.3830705-5-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417000224.3830705-1-corey@minyard.net>
References: <20250417000224.3830705-1-corey@minyard.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=corey@minyard.net; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

Linux issues this command when booting a powernv machine.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20250401140153.685523-4-npiggin@gmail.com>
Signed-off-by: Corey Minyard <corey@minyard.net>
---
 hw/ipmi/ipmi_bmc_sim.c | 68 ++++++++++++++++++++++++++++++++++++++++--
 hw/ipmi/ipmi_bt.c      |  2 ++
 hw/ipmi/ipmi_kcs.c     |  1 +
 include/hw/ipmi/ipmi.h | 10 +++++++
 4 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index bc0ddc52a9..03e58d283e 100644
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
index 583fc64730..28cf6ab218 100644
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
index c15977cab4..578dd7cef3 100644
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
diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
index c8ef04856e..802a2febb0 100644
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
 
-- 
2.43.0


