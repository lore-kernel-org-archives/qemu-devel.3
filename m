Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D5DC369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 04:32:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u363i-0004nQ-Hk; Fri, 11 Apr 2025 00:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u363g-0004nA-8O
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 00:32:04 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u363e-0007aT-L1
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 00:32:03 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-aee773df955so2239663a12.1
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 21:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744345921; x=1744950721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RDcM4WPa5rlnwzZNxe25n1sS0neW52egb9WU2vT5q7c=;
 b=YQO22eWyyjeTKj0T8IMMzTR3SF3XN+DHaTf2hYFHfiSGtRouv/nU71aL5J0k9t1h+N
 70AK/Ms6XSzPXGWB/eJH0TYi7/veSYxRP5aJZbj9z0PZ90Hj4Qmv7eXhSI6Zc/XFAZjn
 HTkh+9pg+JGNBmhvjnq7xVpfu3DI6l4vSIU3KaynPYwj8BTeLMqvNRL5EY8KAZurGyG+
 ZaLvkCC9UuRoM49WG9kmaHj8BYVwIkYkyy+7qeQObcuDFdfAs/zcaDGyBtJ05Al9lxmf
 F6N9Zbtsvk+mUpIEqUwk4YSS102nHfaVPkR+VAGV/PcEijvZux7V9a94XTuEsjnxS5R7
 saNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744345921; x=1744950721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RDcM4WPa5rlnwzZNxe25n1sS0neW52egb9WU2vT5q7c=;
 b=W+yKR19w23XvgkG9ijkZ1XVt4Dij8Z1m8g9Eob9hQk8Rtl9ozgZQjzlP3mRsf+U4BN
 rE1J+pxzzzhvS41lV9nREQNTH7FsolrdSEpC71NLA66C5PBTO7FBfThwSaNE++2pO0XW
 LmyvApNCvLdNpG5nV/BM51433PrZNH9av75o0r53k5g7vZxuUAHpfFGE6R0rSXsQpNLG
 +afIX/ZczSgU2sozdnUvovsxSyHQzUIqg9R6/0nnc2yYLiNSki/IJOY6luV46PVB4IA7
 Rt1yNvYuCehufkW1BhtowvvhuBetRtF/GiJFqKtFi4O5hDtaNsd78akXbJTt57W6qxUo
 1ldg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfnCu5MItwVoDb2oVfXov1pkeQ0n2D0UO72bCqwTFml2vIknGp2KCJ8gqBNxhiJmLbYL+PifjC1ZNR@nongnu.org
X-Gm-Message-State: AOJu0YxYoY2dgniuoF5w25H/8YL+5AYPbn0aXCCKJwNhKVRuE8x8SQtD
 wPw1/LTh2Zj8KMcxfMTNbwnkrFvs5oOldKKA7QQ8zJ5y7q14ahMU
X-Gm-Gg: ASbGncuFiW+jSlOCN6Bvt/kdD2KTyftsHV0q1ElfER0XtrORhVyyE4kHY6mPOotFCUn
 mv8O2jXnVDEsWdzcSSM3/BxAL6v73yZEtNxFoBpYyfrZQZUKecTn6UeWVDk8dPQFzEfQxQ7c8GY
 0RkwKnKSGdLdn/WDMeLbidGMo28n+XMFb0AFqX56CMuNpu1rCMTgSphBMDNOLA6WW71u5rgxwxe
 cjXzNO/FT1uU8m3bmHbSBInanNhVNIgqb0IYvR5OYkiIG/gRkPq0wkR8Vx7TjGhEYIKUH56Lbw8
 degk84U1H3SeOjqlI74zxzNv0j3321uc3GPAz3ESiopD
X-Google-Smtp-Source: AGHT+IHzuibLXW6KC+wLKmDI0n4QV4AP1rgnosfGfIchfphMJYM+YVOho9rSSqlgudePRMjy+HpUCw==
X-Received: by 2002:a17:902:c412:b0:224:7a4:b31 with SMTP id
 d9443c01a7336-22bea041ddbmr20706275ad.6.1744345920923; 
 Thu, 10 Apr 2025 21:32:00 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7b64906sm39361625ad.48.2025.04.10.21.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 21:32:00 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 5/8] net/igb: Fix interrupt throttling interval calculation
Date: Fri, 11 Apr 2025 14:31:25 +1000
Message-ID: <20250411043128.201289-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411043128.201289-1-npiggin@gmail.com>
References: <20250411043128.201289-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x531.google.com
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

IGB throttling granularity is 1us, and interval field is in bits 2..14
of the EITRx registers.

Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/net/igb_regs.h | 3 +++
 hw/net/igb_core.c | 7 ++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
index 4dc4c31da27..1ed5ee5039a 100644
--- a/hw/net/igb_regs.h
+++ b/hw/net/igb_regs.h
@@ -146,6 +146,9 @@ union e1000_adv_rx_desc {
 #define IGB_82576_VF_DEV_ID        0x10CA
 #define IGB_I350_VF_DEV_ID         0x1520
 
+/* Delay increments in nanoseconds for interrupt throttling registers */
+#define IGB_INTR_THROTTLING_NS_RES (1000)
+
 /* VLAN info */
 #define IGB_TX_FLAGS_VLAN_MASK     0xffff0000
 #define IGB_TX_FLAGS_VLAN_SHIFT    16
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 5d169c059d9..8fcc872a7c0 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -142,8 +142,9 @@ static void igb_msix_notify(IGBCore *core, unsigned int cause)
 static inline void
 igb_intrmgr_rearm_timer(IGBIntrDelayTimer *timer)
 {
-    int64_t delay_ns = (int64_t) timer->core->mac[timer->delay_reg] *
-                                 timer->delay_resolution_ns;
+    int64_t delay_ns =
+            (int64_t)((timer->core->mac[timer->delay_reg] & 0x7FFC) >> 2) *
+                     timer->delay_resolution_ns;
 
     trace_e1000e_irq_rearm_timer(timer->delay_reg << 2, delay_ns);
 
@@ -180,7 +181,7 @@ igb_intrmgr_initialize_all_timers(IGBCore *core, bool create)
     for (i = 0; i < IGB_INTR_NUM; i++) {
         core->eitr[i].core = core;
         core->eitr[i].delay_reg = EITR0 + i;
-        core->eitr[i].delay_resolution_ns = E1000_INTR_DELAY_NS_RES;
+        core->eitr[i].delay_resolution_ns = IGB_INTR_THROTTLING_NS_RES;
     }
 
     if (!create) {
-- 
2.47.1


