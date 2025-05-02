Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3948DC3ABA9
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAgub-00045V-HN; Thu, 01 May 2025 23:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAguV-0003zs-Ea
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:17:59 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAguT-0003su-Ou
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:17:59 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-739525d4e12so1648382b3a.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746155876; x=1746760676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pLzHhIcQuQ6FEeR22YuCCdcJNCbyDKG+84iGXCJrQqU=;
 b=ZxonigaUKVuDnGNvyHYUEmKfjnVBCDWd3VF9RUYLzSKNPIoZ1kJ6L/tU1t5moQ3nK1
 Q59blzUpK1UDcvmZqCxi2ahxDOZW/w3zwp9+uUFYQDDL+AeNIcaliTI0+5BiGNU7NPcs
 PXpW8Ksl42dljkGvrY/tYBv0tm+9cYrSEiDHSPKAlYQGRaAr1bIkJViX4R78/vzMx6X7
 NoaaCqBMEgiLLyMLLLBqXTYG/PnUatgE9RCZY88eVvUx2FNoMdlrE9DcwDvK8T37ylBC
 jjKXBk5cyc2CY3ilcwJkVP3vf3z/6CHaU6acDF3qvzAd804v5kJPBcdYyei70NwtRiKu
 qAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746155876; x=1746760676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pLzHhIcQuQ6FEeR22YuCCdcJNCbyDKG+84iGXCJrQqU=;
 b=JbQQFCacH/EiMwMsdCLr3uIBcWgDbjTXXLJUWnSB8MH2zNv0AcTiSiIwTRtc4ZGgg6
 gLO3FjcwpiJvsXmgfv9Wtna4onIIJGXA2LA+R7MCLnhj4EgQC6EK1ooeMkc5jdWxDj8V
 I0PF/0yGJ4ute4nCYzeewjtO9QMY/OfglZMnxsYWX7lGsMK/d5TBv7D6wGV6tU2m4BI6
 Y14/KZgmzQV7NdJUvPgd9oBkE5ZlCwNWvf54IgdWX0PINunIcmPiGRlamLrTTkv7+4HD
 FXUl3/wfSuufStTlhabqNx0C9LJElgxdTNAFNZN6l586UFqQubkZ/Q5n8u8Wf65xPFMW
 84dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTC8SkBusw1cnspe/7tPkBe1/WHytKwRwPJ7EIdPrGCF07doR1M9/iJvoHKzpUJiIYNzArSdiMMs1W@nongnu.org
X-Gm-Message-State: AOJu0YxGDnu2mJdydrOu/YpaXVG/ZaRXT0gfOXctUz8jDGVGHnIRdXUw
 x59gQ24yRE7/441GsfgSe4MtWXoL4bQxZJW5mhlIsjhxuyxMTLLe
X-Gm-Gg: ASbGncs66iGCVC7WWJsq9N88kmsAp4/bvPESFI/s3HTRcRxjZ3E2dP9SFPnIy/ZguhH
 +Xv3yPKbfATv3vzYnEAC/aHZ7cVa1rUEjGy9IbM/G0Qf37oxpCwHirXarLJxinkdBQsKoGNYJ5h
 NHKfw3C56I25aYK+xdnBpZYHwUhXXqxPFSZ8qjydBLb+eBKmJpxp+lrZrLx1A9/hsnf12vby7PI
 nKwGm294vsAK+MLAGxylH18N20m/ZVx6zy1Qg2NT1PTAZkYUdDivs+sbYROMXelgKFCGDMw+ux5
 SLKf9BxF25d9oCbST4OuXoFJdB+bviprSHc/cTy5DE9G
X-Google-Smtp-Source: AGHT+IE9h006LyR3sjjnzqkl6eccA0RYvP3fedvKQ9dPXg9w/fUe7IwB0VXoyzZ6lVkbTVwJUAA1KA==
X-Received: by 2002:a05:6a00:301f:b0:736:9e40:13b1 with SMTP id
 d2e1a72fcca58-74058b25ab3mr1834029b3a.23.1746155876297; 
 Thu, 01 May 2025 20:17:56 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058ded48fsm467883b3a.83.2025.05.01.20.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:17:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 08/12] hw/net/e1000e: Postponed msix interrupt processing
 should auto-clear cause
Date: Fri,  2 May 2025 13:17:00 +1000
Message-ID: <20250502031705.100768-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502031705.100768-1-npiggin@gmail.com>
References: <20250502031705.100768-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
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

Cause auto-clearing and masking should be performed during msix
interrupt processing.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/net/e1000e_core.c | 86 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 69 insertions(+), 17 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index f8e6522f810..5969f49e8fd 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -178,16 +178,62 @@ e1000e_intrmgr_on_throttling_timer(void *opaque)
     }
 }
 
+/* returns the bitmap of causes that are mapped to a given vector */
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
+e1000e_msix_auto_clear_mask(E1000ECore *core, uint32_t cause);
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
 
+    causes = find_msix_causes(core, idx);
     trace_e1000e_irq_msix_notify_postponed_vec(idx);
-    msix_notify(timer->core->owner, idx);
+    msix_notify(core->owner, idx);
+    e1000e_msix_auto_clear_mask(core, causes);
 }
 
 static void
@@ -1985,24 +2031,10 @@ e1000e_eitr_should_postpone(E1000ECore *core, int idx)
 }
 
 static void
-e1000e_msix_notify_one(E1000ECore *core, uint32_t cause, uint32_t int_cfg)
+e1000e_msix_auto_clear_mask(E1000ECore *core, uint32_t cause)
 {
     uint32_t effective_eiac;
 
-    if (E1000_IVAR_ENTRY_VALID(int_cfg)) {
-        uint32_t vec = E1000_IVAR_ENTRY_VEC(int_cfg);
-        if (vec < E1000E_MSIX_VEC_NUM) {
-            if (!e1000e_eitr_should_postpone(core, vec)) {
-                trace_e1000e_irq_msix_notify_vec(vec);
-                msix_notify(core->owner, vec);
-            }
-        } else {
-            trace_e1000e_wrn_msix_vec_wrong(cause, int_cfg);
-        }
-    } else {
-        trace_e1000e_wrn_msix_invalid(cause, int_cfg);
-    }
-
     if (core->mac[CTRL_EXT] & E1000_CTRL_EXT_EIAME) {
         trace_e1000e_irq_iam_clear_eiame(core->mac[IAM], cause);
         core->mac[IAM] &= ~cause;
@@ -2019,6 +2051,26 @@ e1000e_msix_notify_one(E1000ECore *core, uint32_t cause, uint32_t int_cfg)
     }
 }
 
+static void
+e1000e_msix_notify_one(E1000ECore *core, uint32_t cause, uint32_t int_cfg)
+{
+    if (E1000_IVAR_ENTRY_VALID(int_cfg)) {
+        uint32_t vec = E1000_IVAR_ENTRY_VEC(int_cfg);
+        if (vec < E1000E_MSIX_VEC_NUM) {
+            if (!e1000e_eitr_should_postpone(core, vec)) {
+                trace_e1000e_irq_msix_notify_vec(vec);
+                msix_notify(core->owner, vec);
+            }
+        } else {
+            trace_e1000e_wrn_msix_vec_wrong(cause, int_cfg);
+        }
+    } else {
+        trace_e1000e_wrn_msix_invalid(cause, int_cfg);
+    }
+
+    e1000e_msix_auto_clear_mask(core, cause);
+}
+
 static void
 e1000e_msix_notify(E1000ECore *core, uint32_t causes)
 {
-- 
2.47.1


