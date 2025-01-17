Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A002C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 17:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYplr-0005v7-FY; Fri, 17 Jan 2025 12:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYplH-0005UH-OK
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:04:02 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYplF-0003LZ-T8
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:03:59 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2161eb95317so47028505ad.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 09:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737133435; x=1737738235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YfzVLAg8WWCBN9Ke3c1EIUPupLd0OSWUA3+dPW/a0Zo=;
 b=b7XZmSUK3jA7TavycR8A8Q+5HDasezdl7dwZeDasKXm2ch6EFMcGyGFB92O8Ku4FQb
 pjjFaBnFU4m1MEOJQHbx4UdCC2LVsv+49BTOK6fUlrOZ9LZ5YMZrXD8FSNWrZy7rL/zs
 SnrRkFm4syF+EIxQx0F+ro1JHR3+9iiw7YYTwt0CWVUDO/HgakHU+oJJtRWbcs+G18eY
 0rfsjYmVMzbzb+0Bj6oOhlEnyk5FlPU6YrvobH13ux2b9xHE1EUybrnyw2enG9sSOMzn
 n5URR+7UYwyL5wfAx+CK1Zz48ve3ZTgZyvixnrpc4B8cYmXcaGGTweNvWLHefOqrpLJb
 9rvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737133436; x=1737738236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YfzVLAg8WWCBN9Ke3c1EIUPupLd0OSWUA3+dPW/a0Zo=;
 b=OldDEOwWpZ5GgBxuPJWdv3iMJzyZUxBRfQTpi+plBmpMvEeb2zR916dk9X/kpn6lIG
 xn3Rv6/PXjfi9yb+KLuMZ/EAAq3EAsz1wS1WgjQ4oDxls3QKSJGyFnjMr+76Boun4TDO
 lYxdU9P/SCyUqsDO7C0RPkGk4hZDLI87XX1S1MqgsT7aei3ZSwttWw/GmT97H2vxVvIg
 2HNs95SVe8WHcj7Nsq1T9e3v/49HGqMTUqOPGe9lslNs0ADd7c87NUZBGinzO8HdIEHz
 q9kQNYx4vfmMaRRaMuI8p7DUnjZuHHPF8V2BHFpvKy1WAx84T9HFtDdKN/9hdCcRcww9
 OZEA==
X-Gm-Message-State: AOJu0Yx9NWMVfcSjsjzOJ8kwij05fiBIhEpvdYgGG0ZkNb/JI4rvPLKp
 YrvPN8ch1e+h+Ak5oF1eZtCltmamLSfVSHARbSmte/srKE6McXA2X0eT4Q==
X-Gm-Gg: ASbGnctx9H4XTG4BMZ7e7KrkYC+wsS1A6aLi3hnU9Be4oxEz8ZcC+LBlU1+HRiojQSr
 ZHcIa6eIn4Hnvc6fvGGlw6JwMoe+4Gw40naOLueMy9BEJNhPLeKEYyRlHcf0xfi29Vetxmg8miA
 OyuyTAPybLushVynJEpkOG0u973F6rvqmxgfB0iBRPvMW0zlXJSSz/ShJYttKYiQ2yCdW2vPq4I
 cK4GJ3Zqw71+9w0ThMEZLYGk6gGkwQyCA+pb/dHSvKzmiqZIL/g8pqXIQdW0TGjLL3LLMFZz29C
 QHwWOdCydXHb9mo=
X-Google-Smtp-Source: AGHT+IFJQT5FiE8R9XhCPcVUrcW/1ZFLqu3PmiUpC9RyW0VirL9hFVtATHMqXSpexVuAGR048MZ0tg==
X-Received: by 2002:a17:903:2291:b0:208:d856:dbb7 with SMTP id
 d9443c01a7336-21c355b7732mr51978065ad.39.1737133435580; 
 Fri, 17 Jan 2025 09:03:55 -0800 (PST)
Received: from wheely.local0.net (124-169-212-233.tpgi.com.au.
 [124.169.212.233]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2cea0b91sm18249435ad.49.2025.01.17.09.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 09:03:55 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 9/9] hw/net/e1000e|igb: Remove xitr_guest_value logic
Date: Sat, 18 Jan 2025 03:03:05 +1000
Message-ID: <20250117170306.403075-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250117170306.403075-1-npiggin@gmail.com>
References: <20250117170306.403075-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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
 hw/net/igb_core.h    |  2 --
 hw/net/e1000e_core.c | 31 +++++++++++++++----------------
 hw/net/igb.c         |  2 +-
 hw/net/igb_core.c    |  1 -
 4 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
index d70b54e318f..3578ab79034 100644
--- a/hw/net/igb_core.h
+++ b/hw/net/igb_core.h
@@ -90,8 +90,6 @@ struct IGBCore {
 
     IGBIntrDelayTimer eitr[IGB_INTR_NUM];
 
-    uint32_t eitr_guest_value[IGB_INTR_NUM];
-
     uint8_t permanent_mac[ETH_ALEN];
 
     NICState *owner_nic;
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 34bb5f8096b..e9043a0080f 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -2606,18 +2606,6 @@ e1000e_mac_swsm_read(E1000ECore *core, int index)
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
@@ -2835,7 +2823,6 @@ e1000e_set_itr(E1000ECore *core, int index, uint32_t val)
 
     trace_e1000e_irq_itr_set(val);
 
-    core->itr_guest_value = interval;
     core->mac[index] = interval;
 }
 
@@ -2847,7 +2834,6 @@ e1000e_set_eitr(E1000ECore *core, int index, uint32_t val)
 
     trace_e1000e_irq_eitr_set(eitr_num, val);
 
-    core->eitr_guest_value[eitr_num] = interval;
     core->mac[index] = interval;
 }
 
@@ -3072,6 +3058,7 @@ static const readops e1000e_macreg_readops[] = {
     e1000e_getreg(GSCN_1),
     e1000e_getreg(FCAL),
     e1000e_getreg(FLSWCNT),
+    e1000e_getreg(ITR),
 
     [TOTH]    = e1000e_mac_read_clr8,
     [GOTCH]   = e1000e_mac_read_clr8,
@@ -3105,7 +3092,6 @@ static const readops e1000e_macreg_readops[] = {
     [MPRC]    = e1000e_mac_read_clr4,
     [BPTC]    = e1000e_mac_read_clr4,
     [TSCTC]   = e1000e_mac_read_clr4,
-    [ITR]     = e1000e_mac_itr_read,
     [CTRL]    = e1000e_get_ctrl,
     [TARC1]   = e1000e_get_tarc,
     [SWSM]    = e1000e_mac_swsm_read,
@@ -3130,7 +3116,7 @@ static const readops e1000e_macreg_readops[] = {
     [RETA ... RETA + 31]   = e1000e_mac_readreg,
     [RSSRK ... RSSRK + 31] = e1000e_mac_readreg,
     [MAVTV0 ... MAVTV3]    = e1000e_mac_readreg,
-    [EITR...EITR + E1000E_MSIX_VEC_NUM - 1] = e1000e_mac_eitr_read
+    [EITR...EITR + E1000E_MSIX_VEC_NUM - 1] = e1000e_mac_readreg,
 };
 enum { E1000E_NREADOPS = ARRAY_SIZE(e1000e_macreg_readops) };
 
@@ -3560,13 +3546,26 @@ void e1000e_core_pre_save(E1000ECore *core)
             core->tx[i].skip_cp = true;
         }
     }
+
+    /* back compat */
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
diff --git a/hw/net/igb.c b/hw/net/igb.c
index 4d93ce629f9..b7539267b7a 100644
--- a/hw/net/igb.c
+++ b/hw/net/igb.c
@@ -580,7 +580,7 @@ static const VMStateDescription igb_vmstate = {
         VMSTATE_IGB_INTR_DELAY_TIMER_ARRAY(core.eitr, IGBState,
                                            IGB_INTR_NUM),
 
-        VMSTATE_UINT32_ARRAY(core.eitr_guest_value, IGBState, IGB_INTR_NUM),
+        VMSTATE_UNUSED(sizeof(uint32_t) * IGB_INTR_NUM),
 
         VMSTATE_STRUCT_ARRAY(core.tx, IGBState, IGB_NUM_QUEUES, 0,
                              igb_vmstate_tx, struct igb_tx),
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index dad32be54fd..62f319d73e8 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -3093,7 +3093,6 @@ igb_set_eitr(IGBCore *core, int index, uint32_t val)
     val &= E1000_EITR_INTERVAL | E1000_EITR_LLI_EN;
 
     core->mac[index] = val;
-    core->eitr_guest_value[eitr_num] = val;
 }
 
 static void
-- 
2.45.2


