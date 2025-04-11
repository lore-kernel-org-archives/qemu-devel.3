Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE1EC369A8
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 04:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u363m-0004o3-4I; Fri, 11 Apr 2025 00:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u363k-0004nr-Io
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 00:32:08 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u363i-0007b7-L4
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 00:32:08 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-af9a7717163so1838842a12.2
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 21:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744345925; x=1744950725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NfLhK5Ve1CZHHq4PEpYL+RpdL0tfDTxqGVUFnDZJCSM=;
 b=TNepy+o18b7UdVkDd0nQ3n7bFETl4mEfDbMVydkFmvlXnxK2l4AYOMQ8bVrSxIIc2A
 +u4+JuOdGM1TIKNAE4L2rj6fQXnXMQxWQqNey7JgozawzOKmVAm+XNZn9mXG8bOTbVau
 L5qM6wFrHUbkNBumnRcg1x+urp5FQob85+ItYErftJNRaHhGQzsb7v4YvGZ62Uv69Sgz
 GGrxjWLarJOnDrA+SxGjG6tJ6uLRITa8vLY4vkm6r7aYG676dAb4/Hw3uvebYESVwdZY
 e39a1ENQWsHFa9FDaDBE4OTm7wrORUsBRcA55G9VZntJ0bvjHz6NgsC6AVTg8V3DXH0V
 G8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744345925; x=1744950725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NfLhK5Ve1CZHHq4PEpYL+RpdL0tfDTxqGVUFnDZJCSM=;
 b=WlO1AmVJtdq8IqxopXz9/sb06ZMpNOEM0cTVblBwDsRrULFM8Gb+h3PDEdcOhCEPSF
 T5ym7WthH2MJ/y5gQPyspi0wz+biYSSkD0F62C3n8/am+KhBCxF0nGPkWhgDpB0G8rbt
 5isIwiLU73LQJMRElJRjkAsRj/7pVBii31W89KhQUpKZFuxDdZkW00dwHglInfqZZETB
 6O+pcCxGwif2g40lQ1HAL1bO4xtg0L0korsZkGbeiD1iM0bvqMKJOZC8LllBtTES3FU8
 VsZNuyZ0AwIAJxmwl0pOGPJdVF7M48gG+Q9xmA51R66gkQ6dYL5D0jwYX01jHLSOn2dN
 nZ5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCzetL2kc255UIyNNGsBmuTEsZAw87wQLi9lTOLNqUBcenRTz9yDnuGE7SjHn2k1roDI48hrplmFRZ@nongnu.org
X-Gm-Message-State: AOJu0YxIEMGv9AX8seS81CGdH0ROufh0UlazAwGjurajo+pet3JFdQ1t
 EXogbAe2tBHawqy2NQSYdsW1JbXapnDXkDVu742KuOZ5g+0h/Na+
X-Gm-Gg: ASbGncuLhQ5XLoxH6uuo1CGgUro1dUCxy71fKMQVOYJgOZehS0S1ec4WAx/2j/tb0IB
 ScqtCPjLBa7oMByAuOg8yGHVSBTHcGw5KhU7TzF+Kn+Vl2zq4qNtpqI32YaYETrWmHkIaphbbZP
 hPrVv+PKMkV2uMfsLaChDCjqAAbr3Vcm094OfUKbwOzGTxByz9faF3KdHJ3b+cPFeMXS7hmnc58
 QAl2jhzcdJqOUiZqN+8riiKLgfvERzsfM9onbJ7d8GgzCEKrghrjORznse2VqmvNrNLODtCkDH/
 A5sAG7FCCwI1jhC3W199UIx3TkAsOL3QOEDIVn6NiuaL
X-Google-Smtp-Source: AGHT+IHZ6+mbNhL+NeLI+h1oG9nQe9gXLZCiKOkCw3XafgWYAsLPfSjDE5E2N2EqojUQZXAnfAn4sA==
X-Received: by 2002:a17:902:fc44:b0:223:90ec:80f0 with SMTP id
 d9443c01a7336-22bea4afaa3mr22666935ad.22.1744345925112; 
 Thu, 10 Apr 2025 21:32:05 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7b64906sm39361625ad.48.2025.04.10.21.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 21:32:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 6/8] net/igb: Implement EITR Moderation Counter
Date: Fri, 11 Apr 2025 14:31:26 +1000
Message-ID: <20250411043128.201289-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411043128.201289-1-npiggin@gmail.com>
References: <20250411043128.201289-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52c.google.com
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

IGB EITR registers have counter fields which reflect the current ITR
and LLI counter values, as well as a bit to enable LLI moderation,
and a bit to write the register without modifying the counter fields.

Implement the EITR Moderation Counter (aka EITR counter), and counter
ignore bit. The EITR counter is the time remaining in the interrupt
moderation delay which is implemented as a QEMU timer.

Log an unimp message if software tries to enable LLI moderation.

Add a note about the problem with reloading timers after migration.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/net/igb_regs.h |  8 +++++--
 hw/net/igb_core.c | 54 ++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
index 1ed5ee5039a..b612248264a 100644
--- a/hw/net/igb_regs.h
+++ b/hw/net/igb_regs.h
@@ -321,8 +321,12 @@ union e1000_adv_rx_desc {
 #define E1000_EICR_TX_QUEUE3    0x00000800 /* Tx Queue 3 Interrupt */
 #define E1000_EICR_OTHER        0x80000000 /* Interrupt Cause Active */
 
-/* Extended Interrupt Cause Set */
-/* E1000_EITR_CNT_IGNR is only for 82576 and newer */
+/* Extended Interrupt Throttle */
+/* These are only for 82576 and newer */
+#define E1000_EITR_INTERVAL     0x00007FFC
+#define E1000_EITR_LLI_EN       0x00008000
+#define E1000_EITR_LLI_CNT      0x001F0000
+#define E1000_EITR_ITR_CNT      0x7FE00000
 #define E1000_EITR_CNT_IGNR     0x80000000 /* Don't reset counters on write */
 
 #define E1000_TSYNCTXCTL_VALID    0x00000001 /* tx timestamp valid */
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 8fcc872a7c0..3ae3e53530b 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -140,12 +140,8 @@ static void igb_msix_notify(IGBCore *core, unsigned int cause)
 }
 
 static inline void
-igb_intrmgr_rearm_timer(IGBIntrDelayTimer *timer)
+igb_intrmgr_arm_timer(IGBIntrDelayTimer *timer, int64_t delay_ns)
 {
-    int64_t delay_ns =
-            (int64_t)((timer->core->mac[timer->delay_reg] & 0x7FFC) >> 2) *
-                     timer->delay_resolution_ns;
-
     trace_e1000e_irq_rearm_timer(timer->delay_reg << 2, delay_ns);
 
     timer_mod(timer->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + delay_ns);
@@ -153,6 +149,16 @@ igb_intrmgr_rearm_timer(IGBIntrDelayTimer *timer)
     timer->running = true;
 }
 
+static inline void
+igb_intrmgr_rearm_timer(IGBIntrDelayTimer *timer)
+{
+    uint32_t interval = (timer->core->mac[timer->delay_reg] &
+                         E1000_EITR_INTERVAL) >> 2;
+    int64_t delay_ns = (int64_t)interval * timer->delay_resolution_ns;
+
+    igb_intrmgr_arm_timer(timer, delay_ns);
+}
+
 static void
 igb_intmgr_timer_resume(IGBIntrDelayTimer *timer)
 {
@@ -2881,7 +2887,21 @@ igb_mac_swsm_read(IGBCore *core, int index)
 static uint32_t
 igb_mac_eitr_read(IGBCore *core, int index)
 {
-    return core->mac[index - EITR0];
+    uint32_t eitr_num = index - EITR0;
+    uint32_t val = core->mac[eitr_num];
+    IGBIntrDelayTimer *timer = &core->eitr[eitr_num];
+
+    if (timer->running) { /* timer is pending, find time remaining */
+        int64_t remains = timer_expire_time_ns(timer->timer) -
+                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        if (remains > 0) {
+            uint32_t cnt; /* CNT is the most significant 10 of 12 bits */
+            cnt = remains / timer->delay_resolution_ns;
+            val |= ((cnt >> 2) << 21) & E1000_EITR_ITR_CNT;
+        }
+    }
+
+    return val;
 }
 
 static uint32_t igb_mac_vfmailbox_read(IGBCore *core, int index)
@@ -3047,7 +3067,23 @@ igb_set_eitr(IGBCore *core, int index, uint32_t val)
 
     trace_igb_irq_eitr_set(eitr_num, val);
 
-    core->mac[index] = val & 0x7FFE;
+    if (val & (E1000_EITR_LLI_EN | E1000_EITR_LLI_CNT)) {
+        qemu_log_mask(LOG_UNIMP, "%s: LLI moderation not supported, ignoring\n",
+                                 __func__);
+    }
+
+    if (!(val & E1000_EITR_CNT_IGNR)) {
+        IGBIntrDelayTimer *timer = &core->eitr[eitr_num];
+        uint32_t itr_cnt = (val & E1000_EITR_ITR_CNT) >> 21;
+        /* CNT is the most significant 10 of 12 bits */
+        uint64_t ns = (itr_cnt << 2) * timer->delay_resolution_ns;
+
+        igb_intrmgr_arm_timer(timer, ns);
+    }
+
+    val &= E1000_EITR_INTERVAL | E1000_EITR_LLI_EN;
+
+    core->mac[index] = val;
 }
 
 static void
@@ -4553,7 +4589,9 @@ igb_core_post_load(IGBCore *core)
 
     /*
      * we need to restart intrmgr timers, as an older version of
-     * QEMU can have stopped them before migration
+     * QEMU can have stopped them before migration.
+     * XXX: re-setting timers with fresh values breaks deterministic
+     * replay.
      */
     igb_intrmgr_resume(core);
     igb_autoneg_resume(core);
-- 
2.47.1


