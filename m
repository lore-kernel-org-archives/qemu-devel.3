Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EB4C36018
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzcCF-0000oS-PQ; Tue, 01 Apr 2025 10:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzcC0-0008Jo-Jj
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:02:17 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tzcBx-0000Pb-8l
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:02:15 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso102502605ad.1
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 07:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743516131; x=1744120931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ihqA4DvgePcDCt5G9mq9Uv5qfifhS22jJcEgx0LAJgM=;
 b=nciB4v60Dp/BARuY6GaKuxaPk+ndGHSN4NP4XuRIHE9KHUZ/eY4wsdx5oBexau9JQW
 SP1q4pyYeKP+k7nf4zym6uMf9Zg6S61KvDl5E26Wdn+PsOo2c7P1wH4NSdSaxFg513Vh
 Aj/ACHsTZze8BfvxrTVSGuzVzBgYZZ6UYNu6tzYsqofPKyLcTJ945RCILeWYqtOKaW8O
 ET1nXdj3kv4t4jvHuORp07geLsxzv9Fgqx/Lysqk42TzbLRNyerN2wN4qPZQ9C1HwgVM
 EBKIX9C+0rPT4UCUfDEqzbuCr3Rz90CBJ+xU9FK0Yl/vuJ5iCAcxuB+U9VG3XAf8o2hs
 R6HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743516131; x=1744120931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ihqA4DvgePcDCt5G9mq9Uv5qfifhS22jJcEgx0LAJgM=;
 b=J0ktLKkeSkydroEn1gou7ryY7xDsWTnHHeP5CorWPahx5AgltNGrNh28tzl7wcB0W2
 Mb8sVx2VmIB6jg3VpdvpbW58hcPM/wVWvOOY/iaHaIgEnDs3rUJPFxeHlIsy6Y/Wosp+
 mcqW/X421ZjXL5t4Jg4iMAhCjBs+B1XbMh90r/mvH7WCx8uwRXB+sY7xWt4JcrNWq5EY
 CzIMwh6SenPSRC1RfRbgSeAK620eaHdlEXpJvV7GzuMNNP4DEnEjIj3vjw1oA+Vt/3kS
 gwGPXplUWZLjbqPJ99rG/lz2AL1oYMYAGjD+jbd4sqitbm2z6ITTWhcv7Em1bfidulqf
 pO/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU71hanF8E4hxgdksvFOBagBRwHxCNwCIO569yujXfAYXrhUDMLFnnZJk7yPYsKXnj+IkDRJs5baW3W@nongnu.org
X-Gm-Message-State: AOJu0YxbcULjH+rsa7LId2DVaG+N6PLM+QmDzmoPxaGdbFozWfCL+Xt3
 R6bSM3WnYR/opYxfpJcbbWsoBkS5OO2uAIaGMmFaw9C6STjgHhFs
X-Gm-Gg: ASbGncsq35UoGoKJ4PY+D0wWGzNgM2Kj2CLXBCeH7CEAG/4y6pBIwQjrguWD2kHC+h2
 OhCOmloPPnX1ryOm2Rs18dIMNfZAK0I2RGnj4RdaGDN14wc4cXJSGXvrNWEI1aNH0KYlbOy0pGg
 XKdq+4ZZVRqOFJlMndrAhlj2hUa3uVRBPx4Hr8bV1McgwxYyHrPR+FXejm5OEI7jCUGtBwxssOi
 bixG30Lqxfps1b6fOAYerhT+bwhJnrrUoct37uUa9Ce/3X6l0xp+59ftIY3PsRBSlSBkFMXxK6S
 Vs2NTqb/Wo2X/fYRlr99u+FuIlHamYJF45mJe2Iz7aE4m8QzEQ==
X-Google-Smtp-Source: AGHT+IG04Gc8aRZCjVdFlfSOfxmpt4YWFqfk3ULgui76ke8VeXQAK/3qUkWgyBkq0xY/Y7XJswawLw==
X-Received: by 2002:a17:902:db09:b0:215:b1e3:c051 with SMTP id
 d9443c01a7336-229682c14ccmr827555ad.11.1743516131276; 
 Tue, 01 Apr 2025 07:02:11 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291f1f5774sm87768455ad.214.2025.04.01.07.02.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 07:02:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Corey Minyard <minyard@acm.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 4/5] ipmi/bmc-sim: implement watchdog dont log flag
Date: Wed,  2 Apr 2025 00:01:51 +1000
Message-ID: <20250401140153.685523-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250401140153.685523-1-npiggin@gmail.com>
References: <20250401140153.685523-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

If the dont-log flag is set in the 'timer use' field for the
'set watchdog' command, a watchdog timeout will not get logged as
a timer use expiration.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ipmi/ipmi_bmc_sim.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index d63f2348ba1..98cfab6a455 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -514,7 +514,8 @@ static void gen_event(IPMIBmcSim *ibs, unsigned int sens_num, uint8_t deassert,
 
 static void sensor_set_discrete_bit(IPMIBmcSim *ibs, unsigned int sensor,
                                     unsigned int bit, unsigned int val,
-                                    uint8_t evd1, uint8_t evd2, uint8_t evd3)
+                                    uint8_t evd1, uint8_t evd2, uint8_t evd3,
+                                    bool do_log)
 {
     IPMISensor *sens;
     uint16_t mask;
@@ -534,7 +535,7 @@ static void sensor_set_discrete_bit(IPMIBmcSim *ibs, unsigned int sensor,
             return; /* Already asserted */
         }
         sens->assert_states |= mask & sens->assert_suppt;
-        if (sens->assert_enable & mask & sens->assert_states) {
+        if (do_log && (sens->assert_enable & mask & sens->assert_states)) {
             /* Send an event on assert */
             gen_event(ibs, sensor, 0, evd1, evd2, evd3);
         }
@@ -544,7 +545,7 @@ static void sensor_set_discrete_bit(IPMIBmcSim *ibs, unsigned int sensor,
             return; /* Already deasserted */
         }
         sens->deassert_states |= mask & sens->deassert_suppt;
-        if (sens->deassert_enable & mask & sens->deassert_states) {
+        if (do_log && (sens->deassert_enable & mask & sens->deassert_states)) {
             /* Send an event on deassert */
             gen_event(ibs, sensor, 1, evd1, evd2, evd3);
         }
@@ -700,6 +701,7 @@ static void ipmi_sim_handle_timeout(IPMIBmcSim *ibs)
 {
     IPMIInterface *s = ibs->parent.intf;
     IPMIInterfaceClass *k = IPMI_INTERFACE_GET_CLASS(s);
+    bool do_log = !IPMI_BMC_WATCHDOG_GET_DONT_LOG(ibs);
 
     if (!ibs->watchdog_running) {
         goto out;
@@ -711,14 +713,16 @@ static void ipmi_sim_handle_timeout(IPMIBmcSim *ibs)
             ibs->msg_flags |= IPMI_BMC_MSG_FLAG_WATCHDOG_TIMEOUT_MASK;
             k->do_hw_op(s, IPMI_SEND_NMI, 0);
             sensor_set_discrete_bit(ibs, IPMI_WATCHDOG_SENSOR, 8, 1,
-                                    0xc8, (2 << 4) | 0xf, 0xff);
+                                    0xc8, (2 << 4) | 0xf, 0xff,
+                                    do_log);
             break;
 
         case IPMI_BMC_WATCHDOG_PRE_MSG_INT:
             ibs->msg_flags |= IPMI_BMC_MSG_FLAG_WATCHDOG_TIMEOUT_MASK;
             k->set_atn(s, 1, attn_irq_enabled(ibs));
             sensor_set_discrete_bit(ibs, IPMI_WATCHDOG_SENSOR, 8, 1,
-                                    0xc8, (3 << 4) | 0xf, 0xff);
+                                    0xc8, (3 << 4) | 0xf, 0xff,
+                                    do_log);
             break;
 
         default:
@@ -738,24 +742,28 @@ static void ipmi_sim_handle_timeout(IPMIBmcSim *ibs)
     switch (IPMI_BMC_WATCHDOG_GET_ACTION(ibs)) {
     case IPMI_BMC_WATCHDOG_ACTION_NONE:
         sensor_set_discrete_bit(ibs, IPMI_WATCHDOG_SENSOR, 0, 1,
-                                0xc0, ibs->watchdog_use & 0xf, 0xff);
+                                0xc0, ibs->watchdog_use & 0xf, 0xff,
+                                do_log);
         break;
 
     case IPMI_BMC_WATCHDOG_ACTION_RESET:
         sensor_set_discrete_bit(ibs, IPMI_WATCHDOG_SENSOR, 1, 1,
-                                0xc1, ibs->watchdog_use & 0xf, 0xff);
+                                0xc1, ibs->watchdog_use & 0xf, 0xff,
+                                do_log);
         k->do_hw_op(s, IPMI_RESET_CHASSIS, 0);
         break;
 
     case IPMI_BMC_WATCHDOG_ACTION_POWER_DOWN:
         sensor_set_discrete_bit(ibs, IPMI_WATCHDOG_SENSOR, 2, 1,
-                                0xc2, ibs->watchdog_use & 0xf, 0xff);
+                                0xc2, ibs->watchdog_use & 0xf, 0xff,
+                                do_log);
         k->do_hw_op(s, IPMI_POWEROFF_CHASSIS, 0);
         break;
 
     case IPMI_BMC_WATCHDOG_ACTION_POWER_CYCLE:
         sensor_set_discrete_bit(ibs, IPMI_WATCHDOG_SENSOR, 2, 1,
-                                0xc3, ibs->watchdog_use & 0xf, 0xff);
+                                0xc3, ibs->watchdog_use & 0xf, 0xff,
+                                do_log);
         k->do_hw_op(s, IPMI_POWERCYCLE_CHASSIS, 0);
         break;
     }
-- 
2.47.1


