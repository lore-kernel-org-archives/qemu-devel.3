Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D14C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 17:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYpl4-0004si-GB; Fri, 17 Jan 2025 12:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYpkz-0004pY-O9
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:03:41 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYpkx-0003HH-Po
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:03:41 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso30949105ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 09:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737133418; x=1737738218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xwyr7QXQFNO5MELP1oos6ECc/mkTneVNSYwX1XccaXE=;
 b=k83gxvBQ8bL/P54M1VJBrfraA/aDiAE6DzhM4ZCPUL6V+cc2va0EYtClCeFnpeHF52
 EUK/zUGFStWQGJUzVksiTz+iLrNVSYnF6sXJSGOnYVPmYJlEvjYfG9Bv128GZPvouXiv
 rAD5qYP6kYKBaBBM6BTv5h4c/ikvgJUyxm7xXx9AfGOWenEb6bhPT2t/1bSaNyVXtRZQ
 sJfBVhUZ3RbCxUgoxcDcLbmmvKyLtq9obbFXk2sCTzODYK4BTThE+7A6a3xxWXGZbg58
 BxcomTBQzsYOv1f3HeMJWLoDQZw4HeEbEfd8Un758q2t05U2sw54CebkI0L/2beQLQ5F
 x27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737133418; x=1737738218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xwyr7QXQFNO5MELP1oos6ECc/mkTneVNSYwX1XccaXE=;
 b=TApzHMGsfLlod/3nxRQZW+X7/z+m9tGr1ccKRmt28Yk+h9rm16+dAD6ma7BPwUYUid
 rjpse4v+STKocMWSryeuN6I3mQPosx6u66g4LgjlpCP/Sgxm/2PQbzpgjuyvV5gc7IpU
 e24PThmCrT9ee5NlwqHTTDXw++m9jFQXgykcRGfv3dpcNJ/Z857IsrCOVxpMN4RQkMQJ
 +JJ/QePbvpqPulyYs9nfSghEw38y9WHStpQLqj6Nnxp8PwjAJCfcLkMjFF5/lM6o1JOo
 v0pbr3YQJHI7Ksi5yn8JaMWzt3YvA3wpKZ45sRzcrKAsp4/lZE4qQbAWCHJX4NVcfslr
 FeNw==
X-Gm-Message-State: AOJu0YzPtiJlsrckAtTeD/bA2E7C1X6Asa7DinmiEII4uTBtjUt2lrAM
 0psHJW9A6t1HgmtEUOCkgJD42ygExNsIiTbWATPK3ExKyB52Sp+QOagdxg==
X-Gm-Gg: ASbGncuHHK3qpcJF2mT2c7JD1B3hyMeoKI+vky+jqPGI5zaDsRVvHFp3Cigu6AZcrFN
 x91gnFdpeONAFUv9JO7PAnuITJ8yFYhYkGhC72az4onyFTJ4uJlpXjn0W9fFVe5AlwludmS806C
 ZVWSVaUO+NLRE4y+mWbvFSEq2VOAIxShGAhfEYGUch1KJJQLE3syWQ/NKHm/zWdkaDgLxYGwZpa
 J9xEmggJEK4SdnoHsKQsyd+NDZ4D6bcuf6seO6t1jb/zeHqiGt8fxQXT9XqDjW/EumJgsL83T29
 nPX+ihk9JTq5c+k=
X-Google-Smtp-Source: AGHT+IGhA4Zl9ics5Ok5xzJhd31Z7TI1IBwDmZ3kslT9hzafdFWXt19PdvXxruZ3c9TFQr+4ZkT2fg==
X-Received: by 2002:a17:902:c614:b0:215:a80b:f6f9 with SMTP id
 d9443c01a7336-21c352de41amr37255865ad.8.1737133417727; 
 Fri, 17 Jan 2025 09:03:37 -0800 (PST)
Received: from wheely.local0.net (124-169-212-233.tpgi.com.au.
 [124.169.212.233]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2cea0b91sm18249435ad.49.2025.01.17.09.03.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 09:03:37 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5/9] net/igb: Fix EITR LLI and counter fields
Date: Sat, 18 Jan 2025 03:03:01 +1000
Message-ID: <20250117170306.403075-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250117170306.403075-1-npiggin@gmail.com>
References: <20250117170306.403075-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

Implement the ITR counter and log an unimp message if software tries
to enable LLI moderation. Fix the implementation of the counter ignore
bit.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/net/igb_regs.h |  8 +++++--
 hw/net/igb_core.c | 53 ++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 51 insertions(+), 10 deletions(-)

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
index 94f9785749a..cdebc917d2e 100644
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
@@ -2881,7 +2887,22 @@ igb_mac_swsm_read(IGBCore *core, int index)
 static uint32_t
 igb_mac_eitr_read(IGBCore *core, int index)
 {
-    return core->eitr_guest_value[index - EITR0];
+    uint32_t eitr_num = index - EITR0;
+    uint32_t val = core->mac[eitr_num];
+    IGBIntrDelayTimer *timer = &core->eitr[eitr_num];
+
+    if (timer->running) { /* ITR is enabled, get ITR counter */
+        int64_t remains = timer_expire_time_ns(timer->timer) -
+                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
+        if (remains > 0) {
+            /* CNT is the most significant 10 of 12 bits */
+            uint32_t cnt;
+            cnt = remains / timer->delay_resolution_ns;
+            val |= ((cnt >> 2) << 21) & E1000_EITR_ITR_CNT;
+        }
+    }
+
+    return val;
 }
 
 static uint32_t igb_mac_vfmailbox_read(IGBCore *core, int index)
@@ -3047,8 +3068,24 @@ igb_set_eitr(IGBCore *core, int index, uint32_t val)
 
     trace_igb_irq_eitr_set(eitr_num, val);
 
-    core->eitr_guest_value[eitr_num] = val & ~E1000_EITR_CNT_IGNR;
-    core->mac[index] = val & 0x7FFE;
+    if (val & E1000_EITR_LLI_EN) {
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
+    core->eitr_guest_value[eitr_num] = val;
 }
 
 static void
-- 
2.45.2


