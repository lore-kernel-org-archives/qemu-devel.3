Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB42EC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 04:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u363q-0004pv-4n; Fri, 11 Apr 2025 00:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u363o-0004pH-VK
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 00:32:12 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u363n-0007bi-9y
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 00:32:12 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22401f4d35aso18472825ad.2
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 21:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744345930; x=1744950730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r9QvwtGlAYFgKB3sHg3JoUwlEFl1jCGwyJmMH8E5dOc=;
 b=VB97LZ/OyLFpgS80J/iSvSUKyJB3iR/6gOxLqfFH1A7rtOGcam6FOUh9y+f/XLY7hu
 Wdss00mu4QFnn3OczxnbSZb+JYfrKl4UTcqx7fKAsig2FzuzzFzSWATETU/FWyzYBs1q
 52tTJ+W509vJDfyhHChYIWRsERcB1pibsIB2PJLBHR+emTeIMZZLgXcf7XfmBs57s8nE
 fNspBuK+3kAh+oWIepMfyKUTV7Fxc7o5xdKOYABeZyE0buYc3BLPjacK2B4rgDGhAesg
 1bLl5TeTcGSoDHyu3XDBP+IVBPntFBpQ4x6C8VP5mHel39REVEYTqw3Id2AyqTU2XsXk
 3Shg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744345930; x=1744950730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r9QvwtGlAYFgKB3sHg3JoUwlEFl1jCGwyJmMH8E5dOc=;
 b=uUvN8hIpjzG/lHhiZ8Py7Wtqco+D2cczFsEitUY6j23MdvD8IY5Sw7MaEt5/WZkrKl
 hMWf9mf+OGVfW2Q+OqEQaBKtlPFi9KqdZgAMqSixrIaEcBMqS8B+u79zmlx2//eLLLUG
 +HSRMxa7urlAchZp6SrW7IAttTSI0y1muxIHLJGuAN4txM6sWtJaPqXj0U4c+onH9r+Z
 Qq0cRBM/5+W3i/Zg7pjLgVSEpSTTqHke2mGCKhDa3wULMmHCxbB+2PJr8RsiNRvuC1te
 cazLUYVXJuwjzi/ak6NqN/RmTzghzPOy+JPt8BjTXNvuzhCXskU7hq0SEstOkDHPuv03
 OfUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWg9uAnbo+Tf8jiZIS3LjCvHHl+MAq0UITFDpLxrlQIbpNbTPNR3K498AsmUTbLHitFAgKRSxw8MtAP@nongnu.org
X-Gm-Message-State: AOJu0YyAy1Q8U88ygsGjnk8ghmvBjcB0TkuSUdmfUl8lV/gFM0qn6fHB
 JzwSeftEP3hFQhVbCXOElxq4nxpgdRCP+xoM69MtCFNdmWhij3bP
X-Gm-Gg: ASbGncuKVWRByWnRZP0EgxnYD5FHLvVyWKxzu16O3JwN9nm9xAv13XNs5BqM2B5TPK4
 MadD8XOUjye1Sy/AKCkDbsAIUwmuAyuAqgD4OG8s2UiNi1APvU/Jqh+1odz64uOQUlKlQVd2cQ0
 UpY/njnLDUiolOnP2GPUdYin37W/2d3b+xPVGwznM7/AZPLCXZGXIniWrpGdP/SBCpl4w6CtVuL
 FkQ//dQZqSdKzUCZ8+TRC+vVkkX/TEKInvs7ovioXdHrF97BPxH6rLxZg79BLsJAIW1OOdedq3u
 4LjW1XfE/c76EjUL1y90PelqaI0GkzyEZ0H9FasoTaJQ
X-Google-Smtp-Source: AGHT+IEwj1gO/sz8eMNQn3t/k/aY3W2e9JnwHJXkVFLmBMM9zsq5kcFOvrGOMbc2mzg+2FqH6o9Qhw==
X-Received: by 2002:a17:902:c94d:b0:223:47d9:1964 with SMTP id
 d9443c01a7336-22bea4f39bamr19695005ad.34.1744345929759; 
 Thu, 10 Apr 2025 21:32:09 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7b64906sm39361625ad.48.2025.04.10.21.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 21:32:09 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 7/8] net/e1000e|igb: Fix interrupt throttling logic
Date: Fri, 11 Apr 2025 14:31:27 +1000
Message-ID: <20250411043128.201289-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411043128.201289-1-npiggin@gmail.com>
References: <20250411043128.201289-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

Interrupt throttling is broken in several ways:
- Timer expiry sends an interrupt even if there is no cause.
- (e1000e) Mitigated interrupts still auto-clear cause bits.
- Timer expiry that results in an interrupt does not re-arm the timer so
  an interrupt can appear immediately after the timer expiry interrupt.

To fix:

- When the throttle timer expires, check the cause bits corresponding to
  the msix vector before sending an irq.
- (e1000e) Skip the auto-clear logic if an interrupt is delayed, and
  send delayed irqs using e1000e_msix_notify() to perform auto-clear.
- Re-load the throttle timer when a delayed interrupt is signaled. e1000e
  gets this by signaling them with e1000e_msix_notify(), igb calls
  igb_intrmgr_rearm_timer() directly.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/net/e1000e_core.c | 59 +++++++++++++++++++++++++++++++++++++++-----
 hw/net/igb_core.c    | 50 ++++++++++++++++++++++++-------------
 2 files changed, 86 insertions(+), 23 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index f8e6522f810..6fb8da32e4d 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -178,16 +178,62 @@ e1000e_intrmgr_on_throttling_timer(void *opaque)
     }
 }
 
+static uint32_t find_msix_causes(E1000ECore *core, int vec)
+{
+    uint32_t causes = 0;
+    uint32_t int_cfg;
+
+    int_cfg = E1000_IVAR_RXQ0(core->mac[IVAR]);
+    if (E1000_IVAR_ENTRY_VALID(int_cfg) &&
+        E1000_IVAR_ENTRY_VEC(int_cfg) == vec) {
+        causes |= E1000_ICR_RXQ0;
+    }
+
+    int_cfg = E1000_IVAR_RXQ1(core->mac[IVAR]);
+    if (E1000_IVAR_ENTRY_VALID(int_cfg) &&
+        E1000_IVAR_ENTRY_VEC(int_cfg) == vec) {
+        causes |= E1000_ICR_RXQ1;
+    }
+
+    int_cfg = E1000_IVAR_TXQ0(core->mac[IVAR]);
+    if (E1000_IVAR_ENTRY_VALID(int_cfg) &&
+        E1000_IVAR_ENTRY_VEC(int_cfg) == vec) {
+        causes |= E1000_ICR_TXQ0;
+    }
+
+    int_cfg = E1000_IVAR_TXQ1(core->mac[IVAR]);
+    if (E1000_IVAR_ENTRY_VALID(int_cfg) &&
+        E1000_IVAR_ENTRY_VEC(int_cfg) == vec) {
+        causes |= E1000_ICR_TXQ1;
+    }
+
+    int_cfg = E1000_IVAR_OTHER(core->mac[IVAR]);
+    if (E1000_IVAR_ENTRY_VALID(int_cfg) &&
+        E1000_IVAR_ENTRY_VEC(int_cfg) == vec) {
+        causes |= E1000_ICR_OTHER;
+    }
+
+    return causes;
+}
+
+static void
+e1000e_msix_notify(E1000ECore *core, uint32_t causes);
+
 static void
 e1000e_intrmgr_on_msix_throttling_timer(void *opaque)
 {
     E1000IntrDelayTimer *timer = opaque;
-    int idx = timer - &timer->core->eitr[0];
+    E1000ECore *core = timer->core;
+    int idx = timer - &core->eitr[0];
+    uint32_t causes;
 
     timer->running = false;
 
-    trace_e1000e_irq_msix_notify_postponed_vec(idx);
-    msix_notify(timer->core->owner, idx);
+    causes = find_msix_causes(core, idx) & core->mac[IMS] & core->mac[ICR];
+    if (causes) {
+        trace_e1000e_irq_msix_notify_postponed_vec(idx);
+        e1000e_msix_notify(core, causes);
+    }
 }
 
 static void
@@ -1992,10 +2038,11 @@ e1000e_msix_notify_one(E1000ECore *core, uint32_t cause, uint32_t int_cfg)
     if (E1000_IVAR_ENTRY_VALID(int_cfg)) {
         uint32_t vec = E1000_IVAR_ENTRY_VEC(int_cfg);
         if (vec < E1000E_MSIX_VEC_NUM) {
-            if (!e1000e_eitr_should_postpone(core, vec)) {
-                trace_e1000e_irq_msix_notify_vec(vec);
-                msix_notify(core->owner, vec);
+            if (e1000e_eitr_should_postpone(core, vec)) {
+                return;
             }
+            trace_e1000e_irq_msix_notify_vec(vec);
+            msix_notify(core->owner, vec);
         } else {
             trace_e1000e_wrn_msix_vec_wrong(cause, int_cfg);
         }
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 3ae3e53530b..cc25a1d5baa 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -152,11 +152,14 @@ igb_intrmgr_arm_timer(IGBIntrDelayTimer *timer, int64_t delay_ns)
 static inline void
 igb_intrmgr_rearm_timer(IGBIntrDelayTimer *timer)
 {
-    uint32_t interval = (timer->core->mac[timer->delay_reg] &
-                         E1000_EITR_INTERVAL) >> 2;
-    int64_t delay_ns = (int64_t)interval * timer->delay_resolution_ns;
+    uint32_t eitr = timer->core->mac[timer->delay_reg];
 
-    igb_intrmgr_arm_timer(timer, delay_ns);
+    if (eitr != 0) {
+        uint32_t interval = (eitr & E1000_EITR_INTERVAL) >> 2;
+        int64_t delay_ns = (int64_t)interval * timer->delay_resolution_ns;
+
+        igb_intrmgr_arm_timer(timer, delay_ns);
+    }
 }
 
 static void
@@ -168,16 +171,7 @@ igb_intmgr_timer_resume(IGBIntrDelayTimer *timer)
 }
 
 static void
-igb_intrmgr_on_msix_throttling_timer(void *opaque)
-{
-    IGBIntrDelayTimer *timer = opaque;
-    int idx = timer - &timer->core->eitr[0];
-
-    timer->running = false;
-
-    trace_e1000e_irq_msix_notify_postponed_vec(idx);
-    igb_msix_notify(timer->core, idx);
-}
+igb_intrmgr_on_msix_throttling_timer(void *opaque);
 
 static void
 igb_intrmgr_initialize_all_timers(IGBCore *core, bool create)
@@ -2253,9 +2247,7 @@ igb_postpone_interrupt(IGBIntrDelayTimer *timer)
         return true;
     }
 
-    if (timer->core->mac[timer->delay_reg] != 0) {
-        igb_intrmgr_rearm_timer(timer);
-    }
+    igb_intrmgr_rearm_timer(timer);
 
     return false;
 }
@@ -2279,6 +2271,30 @@ static void igb_send_msix(IGBCore *core, uint32_t causes)
     }
 }
 
+static void
+igb_intrmgr_on_msix_throttling_timer(void *opaque)
+{
+    IGBIntrDelayTimer *timer = opaque;
+    IGBCore *core = timer->core;
+    int vector = timer - &core->eitr[0];
+    uint32_t causes;
+
+    timer->running = false;
+
+    causes = core->mac[EICR] & core->mac[EIMS];
+    if (causes & BIT(vector)) {
+        /*
+         * The moderation counter is loaded with interval value whenever the
+         * interrupt is signaled. This includes when the interrupt is signaled
+         * by the counter reaching 0.
+         */
+        igb_intrmgr_rearm_timer(timer);
+
+        trace_e1000e_irq_msix_notify_postponed_vec(vector);
+        igb_msix_notify(core, vector);
+    }
+}
+
 static inline void
 igb_fix_icr_asserted(IGBCore *core)
 {
-- 
2.47.1


