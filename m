Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E80A2C3ABA9
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAguu-0004QN-Js; Thu, 01 May 2025 23:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAguh-0004GH-3T
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:18:11 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAgue-0004AJ-PV
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:18:10 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso1842232b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746155887; x=1746760687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BKvR1gZcRBT/ylC50kaOx9Jww1GBQEMF/HrSuO992Q0=;
 b=ggJ++p2yVN18tlMRyuVPBoW8pIdeXCWhT//KmfyhBCnAXmJaU73na4kRanDvKDfI43
 h2SVxldFNchOBXvnuf3dkjCgyZnIIp4nYYrY2r6uzyMBWp44ARxxPEOgVVFusaLnQP4W
 uAsUA+akgD3cJs7zStZndbbJQ8F2xkL8aEOvYNKNXaUjmqrNaEqCNyNjcYl0Eu5VKHYY
 7hjbekThgiZga1nZk2A83qfW1qStcl4uVFxbi88f/7yEpEVwMHyznn8kzgzFynhcgpwv
 E2kmuTO2jj+UVCZsv3ofGpq8Sn8JWYPeAuK1uuUBnvmLP6LCpuPPFRoH42fzcLS4JMbR
 eEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746155887; x=1746760687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BKvR1gZcRBT/ylC50kaOx9Jww1GBQEMF/HrSuO992Q0=;
 b=dQqPISu23+pwXkMYyCXuBdFu3fezDjIirljw6vVDBAyI505XrpTE+lWkJOX60eTrGQ
 al5RMaXVc2JG8Typ1mJpSqPSntcbYGdIZmHitHX4w/gZPkbXMPUsjjChtfPt3joQZzM2
 ZG8G6GKtmXfYeQ7VevQgSaSC1HBJvE7pA97GNkYnRIja15QguJL5bseoGDs4BEO7szwX
 +MptTL/i8cuPlCwNoOgyBGq+SiaqvPAB489rdzvyAW+/rGs3VF4VcAY5LFfgKlJMVgDP
 OFwltZyXajpr0mBpDFfGHnquiqdrTTtt+FqEn7hNuYGunsr5MwpPb2Iz306zZSZT4Uav
 RZSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLYxAUnNcK69DhixwAqFnwOPH+lejfsNJ7klxDCoGdRxjf+yoyUgs/4zwbLtah1J3NfM58HJVbwpbI@nongnu.org
X-Gm-Message-State: AOJu0YzdkohFI0KQUCPacldyV5wHn7ooC3fzBRmuZbtOn9z0/k1SLLnt
 HISbacHO32DFqJ8iou4aMbpiRCa46SdTle2y3JuziOc8vj75Vo66
X-Gm-Gg: ASbGnctKDlvYeFwpWaG/t0WM2uzitqW/fDSKgKJ1K1sp1GHQGbXCsWAPKxHI39GVpHS
 47Wh9xTAy923KwZFewkbyFlZq0UX/La+sUfzwY/Ac11+xQolUQN2QF+X6DtX7C9mH+viHOHRJZi
 hIj++VsBMlWFc09qhcuG/vN1zVXIGM53FT8D5B61H6mQINKByd+kMWtO9Onydxwu6op2YhnUgKH
 DvcqNGGghlllnFextmNgTGBm3CQVj86z7MaDa9pmLeclpPqF2z1xiyTnrk8GjbvciE9bPafKqvs
 NZ3agr/U46rRUUT1ePqCzSaIRQDCKbcDxsksZdFfReih
X-Google-Smtp-Source: AGHT+IHAjCNYKWJVRSiXKvEdBuzly5m7pHr7CcdbYuiBtzQ+yzmsMLHyR2+40n1ctPV4GccKwKiunA==
X-Received: by 2002:a05:6a20:3d90:b0:20a:53e7:4a44 with SMTP id
 adf61e73a8af0-20cdec4b676mr1787185637.19.1746155886992; 
 Thu, 01 May 2025 20:18:06 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058ded48fsm467883b3a.83.2025.05.01.20.18.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:18:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 10/12] net/e1000e|igb: Only send delayed msix interrupts
 that have a cause
Date: Fri,  2 May 2025 13:17:02 +1000
Message-ID: <20250502031705.100768-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502031705.100768-1-npiggin@gmail.com>
References: <20250502031705.100768-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
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

The msix interrupt throttling timer expiry sends an interrupt even if
there is no unmasked interrupt causes. This can be observed by seeing
two interrupts in response to a single event when throttling is active.

The e1000e non-msix paths seem to get this right by masking and testing
ICR and IMS. Add similar checks for the msix cases in e1000e and igb.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/net/e1000e_core.c | 10 ++++++----
 hw/net/igb_core.c    | 11 ++++++++---
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 022884a2ea0..d53f70065ef 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -230,10 +230,12 @@ e1000e_intrmgr_on_msix_throttling_timer(void *opaque)
 
     timer->running = false;
 
-    causes = find_msix_causes(core, idx);
-    trace_e1000e_irq_msix_notify_postponed_vec(idx);
-    msix_notify(core->owner, idx);
-    e1000e_msix_auto_clear_mask(core, causes);
+    causes = find_msix_causes(core, idx) & core->mac[IMS] & core->mac[ICR];
+    if (causes) {
+        trace_e1000e_irq_msix_notify_postponed_vec(idx);
+        msix_notify(core->owner, causes);
+        e1000e_msix_auto_clear_mask(core, causes);
+    }
 }
 
 static void
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 3ae3e53530b..035637f81f8 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -171,12 +171,17 @@ static void
 igb_intrmgr_on_msix_throttling_timer(void *opaque)
 {
     IGBIntrDelayTimer *timer = opaque;
-    int idx = timer - &timer->core->eitr[0];
+    IGBCore *core = timer->core;
+    int vector = timer - &core->eitr[0];
+    uint32_t causes;
 
     timer->running = false;
 
-    trace_e1000e_irq_msix_notify_postponed_vec(idx);
-    igb_msix_notify(timer->core, idx);
+    causes = core->mac[EICR] & core->mac[EIMS];
+    if (causes & BIT(vector)) {
+        trace_e1000e_irq_msix_notify_postponed_vec(vector);
+        igb_msix_notify(core, vector);
+    }
 }
 
 static void
-- 
2.47.1


