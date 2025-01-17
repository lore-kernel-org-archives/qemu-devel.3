Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7858C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 17:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYpl7-00052r-HP; Fri, 17 Jan 2025 12:03:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYpl4-0004uS-C2
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:03:46 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYpl2-0003IY-CY
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:03:45 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21670dce0a7so53372395ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 09:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737133422; x=1737738222; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bz9BF9PbmirtQ18cY8gX0lnAdWnnAogpyF7tlrah8S4=;
 b=TkrrME2vizJZ5uV8NH94mY0Oi1ElnuZp4SHZ/icuq8on3co3FtACP+awUB9MpQRi/M
 tXR8qmCrBeUo03aKC03QbC6+jIcLwlre+gAhZqy8dp8GA7hAu/mmwSh2flEQs6s9v2Ww
 ygrOnmu0yUPHPjCjqBTI/oj8tN/klvUBj05TOzHcfdCI2aCGAo40uhnOv2I2PhcvJy2v
 NS2TuaxLfA8myFXZFhu/q/mbtbXi6+mlojZG1k2XsHkHZfHUe4AMX9BI8XZuK4whJykI
 pJEQfs+NfqJxq6pwm78pQMdQgi2ZMfrMv80u3r9xKlU7WFcvMq1Ur4jsHM+1WtAKiWgo
 KAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737133422; x=1737738222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bz9BF9PbmirtQ18cY8gX0lnAdWnnAogpyF7tlrah8S4=;
 b=Bf3UXfSpBqQGId0O3FvvDTDuOpGyfLKgT2UibnjSkhWueYtvn+Dob5bFv+zv0DayXq
 sSD0xbOi7nbXerthLjeqbWhZOHsW7iBp1hAOlxTgOqP+rn2d2l3O8SDh/kyRQZWQ3Zpm
 x/4ZtahAmqJt4HLqdiF1ReafE8SdIxKQDkvRTISGQQRLsv3p4mUlZK/NtpkNrafqAva1
 1tPv5t/FD24bSeP6DEskBslQyy56Xt1hIvu20ER3PlofSNlJi3bletUCTFUB4DT7Jra2
 lQm5+NTln+MEVTQJcHMUPU4R29+PvosT8PT8+i9LEaoZVRtRebrHlOkOptLQYSlOPInY
 Z1LQ==
X-Gm-Message-State: AOJu0YwMG0eScwGXfQH+FukjhAU9DoFz8+Aa7fPWTJjFE7PEK0+goixn
 PAsRKmx6BzZXLViXa191xiJd4HbiMRgU5jGAg0kDHVygpUJJgSM+B91FSQ==
X-Gm-Gg: ASbGnctJXnNcxiVbuR2O5ViHTTtxvSaM2nMFYt5XmI55qUF+Dn2247gXLVB2KikJKA5
 rt591Sp98oA5c8N4Cjj8Iyl4jxxx9ydb7iVAOpgkTSJJX+YfRmYUgrzk0gFLKRZxcxgOf7I1nPL
 Sw0nQNBJWtH3cnjjZ2AdNxjHn8pubV56jb35FF/oRIorRh0nA58IeCOzoZHCcU/odDWpRe6FnTl
 B22Jcx+UdOIGpfpySFcbJWLgaDjo1k2NE9DZj5xpc9hZz1EeoAhhY935xQH1sbOw16NfT4tb6LR
 pP4y03b5J8jXC2w=
X-Google-Smtp-Source: AGHT+IEneBcY/W+j0Eg5tMdLn4Xw0iFj8znpsFJcYQaFOdK0zeAN0m3YXuBqLZ36gSPhCGaFJX4RAw==
X-Received: by 2002:a17:902:f545:b0:215:6e01:ad19 with SMTP id
 d9443c01a7336-21c35587f37mr53232765ad.29.1737133422208; 
 Fri, 17 Jan 2025 09:03:42 -0800 (PST)
Received: from wheely.local0.net (124-169-212-233.tpgi.com.au.
 [124.169.212.233]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2cea0b91sm18249435ad.49.2025.01.17.09.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 09:03:41 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6/9] net/e1000e|igb: Fix interrupt throttling logic
Date: Sat, 18 Jan 2025 03:03:02 +1000
Message-ID: <20250117170306.403075-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250117170306.403075-1-npiggin@gmail.com>
References: <20250117170306.403075-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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
- Timer expiry that results in an interrupt does not re-arm
  the timer so an interrupt can appear immediately after the
  timer expiry interrupt.
- Interrupt auto-clear should not clear cause if an interrupt
  is delayed by throttling.

Fix these by skipping the auto-clear logic if an interrupt is
delayed, and when the throttle timer expires check the cause
bits corresponding to the msix vector before sending an irq,
and send it using the functions that run the throttling state
machine and perform auto-clear.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/net/e1000e_core.c | 60 +++++++++++++++++++++++++++++++++++++++-----
 hw/net/igb_core.c    | 28 +++++++++++++--------
 2 files changed, 72 insertions(+), 16 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index e32955d244b..c5be20bcbbe 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -168,16 +168,63 @@ e1000e_intrmgr_on_throttling_timer(void *opaque)
     }
 }
 
+/* Find causes from IVAR vectors and only interrupt if causes are set */
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
+    causes = find_msix_causes(core, idx);
+    if (core->mac[IMS] & core->mac[ICR] & causes) {
+        trace_e1000e_irq_msix_notify_postponed_vec(idx);
+        e1000e_msix_notify(core, causes);
+    }
 }
 
 static void
@@ -1982,10 +2029,11 @@ e1000e_msix_notify_one(E1000ECore *core, uint32_t cause, uint32_t int_cfg)
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
index cdebc917d2e..dad32be54fd 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -168,16 +168,7 @@ igb_intmgr_timer_resume(IGBIntrDelayTimer *timer)
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
@@ -2279,6 +2270,23 @@ static void igb_send_msix(IGBCore *core, uint32_t causes)
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
+    if ((causes & BIT(vector)) && !igb_eitr_should_postpone(core, vector)) {
+        trace_e1000e_irq_msix_notify_postponed_vec(vector);
+        igb_msix_notify(core, vector);
+    }
+}
+
 static inline void
 igb_fix_icr_asserted(IGBCore *core)
 {
-- 
2.45.2


