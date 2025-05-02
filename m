Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7860EC3ABA9
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAgvI-0004wK-TF; Thu, 01 May 2025 23:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAgul-0004Po-MC
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:18:16 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAguj-0004Fu-Le
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:18:15 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7394945d37eso1433128b3a.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746155892; x=1746760692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=69mKuFE3hql0lZ2w4laAr5osBAUcA87Gfn7jgseJ534=;
 b=Yc7r1S9zXY8RsHxtB0+3CRYnhvR/1L2yve2Ikctx+2StzPCWr+bYsOfof48RhZ6Lfs
 piQeb4a5msj0CVnjmTSqcoVgJ62ZmlA6Dy/S5KtxvnaINBOqVwCRn+NOtQklO/I0m+EK
 irypGYqPEHOCww/KnLx73K0IEnqgUD1d7ESLXbgiq6XxohbTuBxEFQAgYfm126PQ4yLp
 B4gIJbaoZgsZz3D8Jsd4mEhciGmrcJOvVomwHyuQhc7IWxKJONmuMPKcD6OKul6Cey1w
 /Ebg/rWBP4CQpGAbltRpE0nQymXQbTJ3B8din9yKbChEclpBQXVN3J9nM0fr7CbhvRY2
 1kzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746155892; x=1746760692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=69mKuFE3hql0lZ2w4laAr5osBAUcA87Gfn7jgseJ534=;
 b=WpHf2gITnYjwIE+YZoaJNFPJd8sXBayiC1pi9y+EKKwNDSGxgOqCJNcMJOYdz3hhIO
 fc9vDOJ/XthhEB8e/vaO3c4abZqXRQYw/EJVBfSajNoMQunnZmyNd+LELmG0u115oykE
 CxSMA1WMSMmLLw77wGCehYbiYOQHPuVhOv7Ux2ENbUlhkgZUphLrK4T3HTCVjtofb/fv
 eKMJdc2YX5T6+hfDvNVPoqElsimzyiRzk12lbZqEj8gX8LfBIiCPLbbqQNcfDyP9MzAm
 svCHTyUVvYVOeOgR4lS2r2n3bRbFTjty2zIxNjqZfX9xJmuaoojUkdN2M+S8y+JN/0Bf
 7E6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHGtVNoIqug7NKEEnaG2GDSa75836ONsgrXKlTKyH1OAyh4cISSh5l4puTDzGreJNcgYpxLwEbn4cI@nongnu.org
X-Gm-Message-State: AOJu0Yz2/Cwo7/qSuf97a1bHG3ePitXtozxb9/AqpYrjUA4BT9bo6kg4
 YYFOLXz1d+oqU00ciM4gX30QdY8/XtXxvs6++QxMC46nV8GPBwdt
X-Gm-Gg: ASbGnctO0yh7OtapiuHepmCakvR7Xu2U8nqG3pocK6DhWO9G2MXx+mbczNN89rNHGuo
 YoeDqhZx/Jes8FfQgtmdM1hPOCGiVAGWT0yXcFY/CakFJKgRCMlLDR2OyydkCnnCYSsEi0JN8mq
 B3F9kmiqP8ucvgLpvR/kO/plLDOawzPrA/2Q7Dh1mBR7bs5ko/YBGzw1HwgeGjO7+TQP6Daznr2
 LpkRcxeg3VcqZ6xMWXvZlxOcQ2ho39LMk0GQ63L0Q5T4fc38Pmmj9shup3UYVic0YuOXUcGQDr3
 4Cgsbhp05f2M4li5VNL0wBJdeOaOZmS+gqqCdmQVmwp/
X-Google-Smtp-Source: AGHT+IEWrlX/enTXJSa5gJPSVOE3vr8hvCW34MGAs9k9z/9sCKivxJjUTnLnJLcuMTjCm6ZlEPytCQ==
X-Received: by 2002:a05:6a00:4acd:b0:736:ff65:3fcc with SMTP id
 d2e1a72fcca58-74058ae68a2mr1920693b3a.16.1746155892230; 
 Thu, 01 May 2025 20:18:12 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058ded48fsm467883b3a.83.2025.05.01.20.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:18:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 11/12] net/e1000e|igb: Fix interrupt throttling rearming
Date: Fri,  2 May 2025 13:17:03 +1000
Message-ID: <20250502031705.100768-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502031705.100768-1-npiggin@gmail.com>
References: <20250502031705.100768-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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

Timer expiry that results in an interrupt does not rearm the timer so
an interrupt can appear immediately after the interrupt generated by
timer expiry.

Fix this by rearming the throttle timer when a delayed interrupt is
processed. e1000e gets this by reusing the e1000e_msix_notify()
logic, igb calls igb_intrmgr_rearm_timer() directly.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/net/e1000e_core.c |  5 ++--
 hw/net/igb_core.c    | 55 ++++++++++++++++++++++++++------------------
 2 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index d53f70065ef..2932122c04b 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -218,7 +218,7 @@ static uint32_t find_msix_causes(E1000ECore *core, int vec)
 }
 
 static void
-e1000e_msix_auto_clear_mask(E1000ECore *core, uint32_t cause);
+e1000e_msix_notify(E1000ECore *core, uint32_t causes);
 
 static void
 e1000e_intrmgr_on_msix_throttling_timer(void *opaque)
@@ -233,8 +233,7 @@ e1000e_intrmgr_on_msix_throttling_timer(void *opaque)
     causes = find_msix_causes(core, idx) & core->mac[IMS] & core->mac[ICR];
     if (causes) {
         trace_e1000e_irq_msix_notify_postponed_vec(idx);
-        msix_notify(core->owner, causes);
-        e1000e_msix_auto_clear_mask(core, causes);
+        e1000e_msix_notify(core, causes);
     }
 }
 
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 035637f81f8..cc25a1d5baa 100644
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
@@ -168,21 +171,7 @@ igb_intmgr_timer_resume(IGBIntrDelayTimer *timer)
 }
 
 static void
-igb_intrmgr_on_msix_throttling_timer(void *opaque)
-{
-    IGBIntrDelayTimer *timer = opaque;
-    IGBCore *core = timer->core;
-    int vector = timer - &core->eitr[0];
-    uint32_t causes;
-
-    timer->running = false;
-
-    causes = core->mac[EICR] & core->mac[EIMS];
-    if (causes & BIT(vector)) {
-        trace_e1000e_irq_msix_notify_postponed_vec(vector);
-        igb_msix_notify(core, vector);
-    }
-}
+igb_intrmgr_on_msix_throttling_timer(void *opaque);
 
 static void
 igb_intrmgr_initialize_all_timers(IGBCore *core, bool create)
@@ -2258,9 +2247,7 @@ igb_postpone_interrupt(IGBIntrDelayTimer *timer)
         return true;
     }
 
-    if (timer->core->mac[timer->delay_reg] != 0) {
-        igb_intrmgr_rearm_timer(timer);
-    }
+    igb_intrmgr_rearm_timer(timer);
 
     return false;
 }
@@ -2284,6 +2271,30 @@ static void igb_send_msix(IGBCore *core, uint32_t causes)
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


