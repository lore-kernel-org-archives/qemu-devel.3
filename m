Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DBBC369C7
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 00:03:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5CiL-000435-NM; Wed, 16 Apr 2025 20:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1u5CiJ-00042Q-96
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 20:02:43 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corey@minyard.net>) id 1u5CiH-0006Px-Eg
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 20:02:42 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72c1419f73eso684786a34.1
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 17:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1744848159; x=1745452959;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JocjqZ7axQak0ryaIxlzlPJ7rR7B3nPUKxuLnqDLYbA=;
 b=Eor6tSOpKcH9dxeld4s7NiG0gQbGKtKm/NTdikg2cmUMaxrZgcxu1G1fsPNPXStlkd
 yCJeVG7FoGhhoTkViPNtT6PTN60pm6fTjTQJsS7J4MAeY+rwITmZ48IddacmGFcRSDNM
 33eIluxj7lE0Xd2FTbkqeSnfyKxdbrFNq4UgWxfvw1Iz8hgafd2M43omcSOR/QBg+3/G
 cSyVhmHqmsNycg2OtfZfy3U+Qz2kjVOZq2+UVH0CQVnKWiPIZM+nG7f711c7i7DKkd1o
 CiNEO8yHGL4CxihDhtK6WEiHmAojm+PLhko7v/w4Q/rWhkI/RzGvjztwoTrrxpoJptl5
 VwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744848159; x=1745452959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JocjqZ7axQak0ryaIxlzlPJ7rR7B3nPUKxuLnqDLYbA=;
 b=UqLeU9HdoNsSgcYeIBkD91gXivX02fn5rHcjetXafGDgKJsprsn+e9ngNx6W1KTbCg
 hTF/uRzzL3yCR8AOs4wOtZG+P/00ITzDxN5PtXH+Bk/ve/M/FF3ToPAGcr4qmcplcI5t
 +2/AYIZ1v4U6mZLd6nXuC1jxbWlr9BW/iqehnIPJlqxSYZZAvsa7czbLXrMzGBaLKF+a
 nSQ4ZqZtjifgsrC5FewsjkSYEn95eMV1+OZzzVFoo3wyiEi41zTRqlN7UTI+Kf8W2b3z
 ABNrOD7DvdsmSKWf6r7LJCCN3YUaVaGOAKxqRU9NEO6HELWQxFDkbNP21ibczTPmH5Ug
 63bw==
X-Gm-Message-State: AOJu0YzKteap0H72jkssCgBS0kfvtMG0q1GQdlqkXe64o9Ke7zDHuxSP
 osMc8XE3/q7XoSppszZZkZU1C9H64yE1wDW6+rXBjyVlyOakyqOStSEvKZLrk7zJy+JLwFS/2ce
 t
X-Gm-Gg: ASbGncuU6RhBKoODOO1FEIqd3gLR/EZcGwzXB7Db2rDhAqm2ZEQlx7tbqOKbrAsMtOc
 5EGxCvkoIu5VtQW/hP1zhiLBWzMu6n8aDxiTXPrJen9bWF9quNn0WnkkjfkHJaiGRkcCj0QWEQy
 5xrpe0zh+pUijB+ntNFu7RFD0cWmIf1SRq+V/gZiyZf+w7+eIbxwHhN/z8qHQGtr87MZvIMeDy7
 qH21Gm0JYfRaYk2So81eJ8r43P8pxpt5leqush/2flebV9mQ+rgmXhnUNd8PlCpEo8lSP/tXmM7
 6pmzMnGL6JkC979gAj66mACxk13leXRIS38=
X-Google-Smtp-Source: AGHT+IHoJn4tF9TxRP9AdgllUNZFXaRyUI2bD0axk6wKWNwxt+743nLtFxgSnySKbvS9LP+n6i17Sw==
X-Received: by 2002:a05:6830:620f:b0:72a:b2a:476 with SMTP id
 46e09a7af769-72f734b66admr494148a34.3.1744848159612; 
 Wed, 16 Apr 2025 17:02:39 -0700 (PDT)
Received: from localhost ([2001:470:b8f6:1b:8795:e9fb:beca:ef25])
 by smtp.gmail.com with UTF8SMTPSA id
 46e09a7af769-72e73d6eb1fsm2989768a34.16.2025.04.16.17.02.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 17:02:39 -0700 (PDT)
From: Corey Minyard <corey@minyard.net>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Corey Minyard <corey@minyard.net>
Subject: [PULL 5/6] ipmi/bmc-sim: implement watchdog dont log flag
Date: Wed, 16 Apr 2025 18:59:09 -0500
Message-ID: <20250417000224.3830705-6-corey@minyard.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417000224.3830705-1-corey@minyard.net>
References: <20250417000224.3830705-1-corey@minyard.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::330;
 envelope-from=corey@minyard.net; helo=mail-ot1-x330.google.com
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

If the dont-log flag is set in the 'timer use' field for the
'set watchdog' command, a watchdog timeout will not get logged as
a timer use expiration.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20250401140153.685523-5-npiggin@gmail.com>
Signed-off-by: Corey Minyard <corey@minyard.net>
---
 hw/ipmi/ipmi_bmc_sim.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 03e58d283e..4ed66e1ee0 100644
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
2.43.0


