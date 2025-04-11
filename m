Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168D2C369A8
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 04:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u363X-0004lE-Bl; Fri, 11 Apr 2025 00:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u363W-0004it-1G
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 00:31:54 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1u363U-0007Ws-92
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 00:31:53 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22409077c06so22331495ad.1
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 21:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744345911; x=1744950711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zhBCmES6uddU8sJEXZmLe0udlv86ZCQnsEc40OzKfD8=;
 b=QGpoxyOOvBFXqyu0dksQGmEjhiLIs9Yr9RWsxm7hQ86u+eXaiKw0GNgFtkGdRxt43w
 XnQyYP3UIKFr7VjDaHrqGF2u5GmWCexGxLzsIYUIeJLYV6ONksI3sz0X6JGV37p4muqX
 yBJHaNuPdJjHXvO/k50s2Zc0US/H+u01uYrWZMyi+sh+H0yF+ZaKQG263c0Vuo2/YIJC
 k8p7s5Gj/+3gei8Ac+nTpDgEiSJl9ayaFUTEqQic95ZkgQEvWMrBmuxkf5y+e5XOoODZ
 K/RElhCwH0+LOM4JFuPL01yDyP+a3bDDzg0qNKFmA+U49CtT6uIkBEISkhj2a7F1n64M
 5mnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744345911; x=1744950711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zhBCmES6uddU8sJEXZmLe0udlv86ZCQnsEc40OzKfD8=;
 b=JbcI3M2LGREL3bqso7ImFqk63QcXH1w6uYl5dcKxdws+rfU4UjrMMtFtiO6/SxP9hf
 Hw06cAuedvgHZIBT27wCvVOJPmQU0OKwC6j374RVU3apufFPrFY5EwHM4yPf8frnPrRl
 GTrp055naJU3BeZtmWsS9kcgE6bR20GXxxlFPhcVSdUT2M+fv/y8DTzeDOPX2KYN3YSt
 oUTPySr8MpBEdxitR0pWKlgTScAAmCtibimNkZ/3/4xqJ1ER7SVaV8pMmhIttMW9Lqwo
 gvsu1YF6o/PChBcDWcAPXGZ2jeuUgfb2YD1FzSGdhmMqJKJ8kUorA2yhckDWeFEhFkVS
 l8og==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSB+NLKRv6seNFGWFroDhz4h2tyaVCdI/y6oWkP3hW3RGyqX+RoljEa30dy5uMtrBrgE3uffKn8bwP@nongnu.org
X-Gm-Message-State: AOJu0YzPQfJC4z1muOxhGss+bjFdmyQFPDNRic9S9LAITwWwo1R0WLVK
 zScFLHrr+GDNCFf+y8xFcYJ6DJePGcpz79mDQlzHYWUvufhA/VUA
X-Gm-Gg: ASbGncs1WnYE5NANVF2CO/6pX4zmR1xZsub8LxG/o4TrEl+VALzRERGKaTafBdjih7K
 7KlEbYsJiR+aaILEI1uqAWwp76UWc0Qc0nB21cd+ayju+/WcIslQ4ICea8q+FJQqwB5uiLNligb
 5ZA7x6dU0UuvFUeOJGvvR01hcnS9EBnB6pA6ad7bp6qNweIABsBXvZddxinnyy0SGQyx3QMMdU9
 mQzkaAdlwCv/loLEjsp5LMFsoNKI6/ybFrFrRe5109UHIbzPdbEZdiFNGyjCzndGkjcOiCpKwYw
 YvO/3CfiU7dX4UAmVpvyNLGlODx5raZ/Z0s8kJQBqiX6
X-Google-Smtp-Source: AGHT+IHjJaFsCXfhooncVF9GK105/9B/2T4UqPvCOItHVkn5Gor1F72X39qHV7Xd98D4WaNOU12zZQ==
X-Received: by 2002:a17:903:244c:b0:224:2717:7993 with SMTP id
 d9443c01a7336-22bea4fe01dmr18988085ad.45.1744345911082; 
 Thu, 10 Apr 2025 21:31:51 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7b64906sm39361625ad.48.2025.04.10.21.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 21:31:50 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 3/8] hw/net/e1000e|igb: Remove xitr_guest_value logic
Date: Fri, 11 Apr 2025 14:31:23 +1000
Message-ID: <20250411043128.201289-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411043128.201289-1-npiggin@gmail.com>
References: <20250411043128.201289-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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

The guest value xITR logic is not required now that the write functions
store necessary data to be read back, and internal users mask and shift
fields they need as they go.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/net/e1000e_core.c | 31 +++++++++++++++----------------
 hw/net/igb_core.c    | 14 ++++++++++++--
 2 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 96f74f1ea14..f8e6522f810 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2563,18 +2563,6 @@ e1000e_mac_swsm_read(E1000ECore *core, int index)
     return val;
 }
 
-static uint32_t
-e1000e_mac_itr_read(E1000ECore *core, int index)
-{
-    return core->itr_guest_value;
-}
-
-static uint32_t
-e1000e_mac_eitr_read(E1000ECore *core, int index)
-{
-    return core->eitr_guest_value[index - EITR];
-}
-
 static uint32_t
 e1000e_mac_icr_read(E1000ECore *core, int index)
 {
@@ -2792,7 +2780,6 @@ e1000e_set_itr(E1000ECore *core, int index, uint32_t val)
 
     trace_e1000e_irq_itr_set(val);
 
-    core->itr_guest_value = interval;
     core->mac[index] = interval;
 }
 
@@ -2804,7 +2791,6 @@ e1000e_set_eitr(E1000ECore *core, int index, uint32_t val)
 
     trace_e1000e_irq_eitr_set(eitr_num, val);
 
-    core->eitr_guest_value[eitr_num] = interval;
     core->mac[index] = interval;
 }
 
@@ -3029,6 +3015,7 @@ static const readops e1000e_macreg_readops[] = {
     e1000e_getreg(GSCN_1),
     e1000e_getreg(FCAL),
     e1000e_getreg(FLSWCNT),
+    e1000e_getreg(ITR),
 
     [TOTH]    = e1000e_mac_read_clr8,
     [GOTCH]   = e1000e_mac_read_clr8,
@@ -3062,7 +3049,6 @@ static const readops e1000e_macreg_readops[] = {
     [MPRC]    = e1000e_mac_read_clr4,
     [BPTC]    = e1000e_mac_read_clr4,
     [TSCTC]   = e1000e_mac_read_clr4,
-    [ITR]     = e1000e_mac_itr_read,
     [CTRL]    = e1000e_get_ctrl,
     [TARC1]   = e1000e_get_tarc,
     [SWSM]    = e1000e_mac_swsm_read,
@@ -3087,7 +3073,7 @@ static const readops e1000e_macreg_readops[] = {
     [RETA ... RETA + 31]   = e1000e_mac_readreg,
     [RSSRK ... RSSRK + 31] = e1000e_mac_readreg,
     [MAVTV0 ... MAVTV3]    = e1000e_mac_readreg,
-    [EITR...EITR + E1000E_MSIX_VEC_NUM - 1] = e1000e_mac_eitr_read
+    [EITR...EITR + E1000E_MSIX_VEC_NUM - 1] = e1000e_mac_readreg,
 };
 enum { E1000E_NREADOPS = ARRAY_SIZE(e1000e_macreg_readops) };
 
@@ -3517,13 +3503,26 @@ void e1000e_core_pre_save(E1000ECore *core)
             core->tx[i].skip_cp = true;
         }
     }
+
+    /* back compat, QEMU moves xITR in itr_guest_value state */
+    core->itr_guest_value = core->mac[ITR];
+    for (i = 0; i < E1000E_MSIX_VEC_NUM; i++) {
+        core->eitr_guest_value[i] = core->mac[EITR + i];
+    }
 }
 
 int
 e1000e_core_post_load(E1000ECore *core)
 {
+    int i;
     NetClientState *nc = qemu_get_queue(core->owner_nic);
 
+    /* back compat */
+    core->mac[ITR] = core->itr_guest_value;
+    for (i = 0; i < E1000E_MSIX_VEC_NUM; i++) {
+        core->mac[EITR + i] = core->eitr_guest_value[i];
+    }
+
     /*
      * nc.link_down can't be migrated, so infer link_down according
      * to link status bit in core.mac[STATUS].
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 39e3ce1c8fe..5d169c059d9 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -2880,7 +2880,7 @@ igb_mac_swsm_read(IGBCore *core, int index)
 static uint32_t
 igb_mac_eitr_read(IGBCore *core, int index)
 {
-    return core->eitr_guest_value[index - EITR0];
+    return core->mac[index - EITR0];
 }
 
 static uint32_t igb_mac_vfmailbox_read(IGBCore *core, int index)
@@ -3046,7 +3046,6 @@ igb_set_eitr(IGBCore *core, int index, uint32_t val)
 
     trace_igb_irq_eitr_set(eitr_num, val);
 
-    core->eitr_guest_value[eitr_num] = val & ~E1000_EITR_CNT_IGNR;
     core->mac[index] = val & 0x7FFE;
 }
 
@@ -4527,13 +4526,24 @@ void igb_core_pre_save(IGBCore *core)
             core->tx[i].skip_cp = true;
         }
     }
+
+    /* back compat, QEMU moves EITR in eitr_guest_value state */
+    for (i = 0; i < IGB_INTR_NUM; i++) {
+        core->eitr_guest_value[i] = core->mac[EITR0 + i];
+    }
 }
 
 int
 igb_core_post_load(IGBCore *core)
 {
+    int i;
     NetClientState *nc = qemu_get_queue(core->owner_nic);
 
+    /* back compat */
+    for (i = 0; i < IGB_INTR_NUM; i++) {
+        core->mac[EITR0 + i] = core->eitr_guest_value[i];
+    }
+
     /*
      * nc.link_down can't be migrated, so infer link_down according
      * to link status bit in core.mac[STATUS].
-- 
2.47.1


