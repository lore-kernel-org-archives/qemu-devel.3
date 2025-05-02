Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19A5C369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAguU-0003xm-U8; Thu, 01 May 2025 23:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAguO-0003rC-Hc
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:17:54 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAguJ-0003Zz-MY
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:17:52 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-736c1138ae5so1704215b3a.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746155866; x=1746760666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W/uPVqTrOylFMnnjOT+v+C9KrHxggrfQhY/SHrGtSGE=;
 b=KqFvS0+299BOL4+Mu+nKD6I2UA7xrw0CCfXfRQKee1f0hAEvfvEK4YtKSAtf4qUyRl
 pIyxkeFVO4QMryf8rKj2CekDBg8hMdKRn91CFRF8nuLLwT4cC7/B1wJyBFEMXuFof4rQ
 01TFWq4HQrN4ZZAHYY4UvG36edHJQ7pn6K5N77tb0L6M52zLzpo7Gq3hsoS44vxOTiGg
 PlAl28GS21XJHoBXT+Bdhe5mBYHUp/3jhd3YjyOrKEpofPnF5bdhQ6Ii5S1VhR1SWGhm
 AYrHSFmJhXqAnx4xf7Z2/BZ4uq4s1KXPmtNXFTi0hgvZcBdO9MMdGOUL/9d73dlPaRNa
 3LHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746155866; x=1746760666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W/uPVqTrOylFMnnjOT+v+C9KrHxggrfQhY/SHrGtSGE=;
 b=hYPLDlki868mOoGfp4OCSaCMBHeJXnd8V8H8PbEEz6vaoqLfUVHi0+H1WDI1f4kTBL
 qaoIAi9us3Cu/sxDvL9pFHauqS0/12Zl9gdzERVRvMGmjsgi3DOHu/x9SxtKGMXN8W22
 Bawq6QcloqUDGnEmC0LZSz12NCo50EjgG3D1mn15DoWYs7U3DEYuZV2fM41zGQ1yYdtw
 bZdXPfDa35L0n68KhKM1VOIwHJpa3yqp5OX3llOj2d77BeWe4joJ4nV/IarV6DZP+axx
 TVBxeMb+x85ruM/TA6pk7izorSopZk3Z5Pi66qvxOYQ7hzba+e5380Ci3s1suBzxUZOg
 59tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ9iuZoBQ2k4WKie6pZxF572lUTyExl+aRhNDEcK3aSzl/BR/khPgELyN9hIQ8Ohmkx9h5Gt17hJhO@nongnu.org
X-Gm-Message-State: AOJu0Yyn6LORSCdHixh7SCPb2E2Q4DHaCfL7tq0IxwtM6xqDURk++Gyc
 JVDN58q0u0U+bLFBS2dW15G5X5zvTJiFyw9wx5ZR4B2C+V2dboUU
X-Gm-Gg: ASbGncuWbgv5LzjZ/AN+NnwjJMBW9C/DagrIfZVDONz7I5T28gYsEUTHERuzZe+YLwu
 o+vgUaNoG97lxVtH9LIQMOp1x0ERdeQoZcYlT95UfzQ0e7dooynGKM27Qwbanso/Wshpayc0eoE
 +aWj/PkJVpyJG7jqUUSWfJ+6eqx1J6FFkPwONX9XtX6uKsdjFd/nn/39kdrTT8x9+GhnLSAXHYj
 PkgcaPZnmtSYXAAoL1w3VnTP8iaLXgxpFx/XYi5VGCt+AepMH36nmVyagu+VBhjVvnnqg2lNrvx
 0lmtROA+G29ApYiQdj1JySKThdkFM8ENGeV3LMNLTpLw
X-Google-Smtp-Source: AGHT+IH5fc7iEhgOzIxFncQkKmks2ox542BW/hbfxkS6FmjRUAPpb5dSOI7Dsqw2ow9jvKvN+GWm6w==
X-Received: by 2002:a05:6a21:33a2:b0:1f5:709d:e0c6 with SMTP id
 adf61e73a8af0-20ce04e7422mr1852965637.42.1746155866207; 
 Thu, 01 May 2025 20:17:46 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058ded48fsm467883b3a.83.2025.05.01.20.17.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:17:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 06/12] net/igb: Implement EITR Moderation Counter
Date: Fri,  2 May 2025 13:16:58 +1000
Message-ID: <20250502031705.100768-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502031705.100768-1-npiggin@gmail.com>
References: <20250502031705.100768-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/net/igb_regs.h |  6 ++++++
 hw/net/igb_core.c | 48 +++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
index a87aa44f5f3..c4785eda0ce 100644
--- a/hw/net/igb_regs.h
+++ b/hw/net/igb_regs.h
@@ -631,6 +631,12 @@ union e1000_adv_rx_desc {
 #define E1000_EICR_MSIX_MASK   0x01FFFFFF /* Bits used in MSI-X mode */
 #define E1000_EICR_LEGACY_MASK 0x4000FFFF /* Bits used in non MSI-X mode */
 
+/* These are only for 82576 and newer */
+#define E1000_EITR_INTERVAL     0x00007FFC
+#define E1000_EITR_LLI_EN       0x00008000
+#define E1000_EITR_LLI_CNT      0x001F0000
+#define E1000_EITR_ITR_CNT      0x7FE00000
+
 /* Mirror VF Control (only RST bit); RW */
 #define E1000_PVTCTRL(_n) (0x10000 + (_n) * 0x100)
 
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 9e9e6e3354f..eedc341f298 100644
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
@@ -3047,6 +3067,22 @@ igb_set_eitr(IGBCore *core, int index, uint32_t val)
 
     trace_igb_irq_eitr_set(eitr_num, val);
 
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
     core->mac[index] = val;
 }
 
-- 
2.47.1


