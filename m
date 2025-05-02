Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94096C369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAguF-0003pZ-Ab; Thu, 01 May 2025 23:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAgu6-0003op-TW
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:17:35 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAgu4-0003Oi-AY
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:17:33 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-73bb647eb23so1568795b3a.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746155851; x=1746760651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=usc1iImkjRDDNy/viNJ0vQB1ad6BcL3XRMiXbZYdyis=;
 b=HPln83gsaM2L2AuGUgBDciy0Rc3tvmfudN496FHjG+w4OPk18hgdwItygp39SH21jw
 WFEDqIcjWLPYD8YoVsD9zvy97FZ8Z0pPUMvEG5bneI6wI3SMGJpAVvfJwhLVWm+XfVMe
 f+VfCzaI2kCPb36k5eAGAhzqYuNPj36PArvKBnxRhYH9oPKweAVFQGpHiGjZX1C8p6ci
 uH6mzT5ZH130NQe4Ptwpxcg47dlffAMvdowao0DqjY4vZ7VFhnou6Bb1EgeppfyewpMv
 tJR64VrtME6dsWRrBpb0ruG/4fjtS8Pv9swujto3UXPRL0aU+S7OcKbwLNYUF0cfWWlw
 utJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746155851; x=1746760651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=usc1iImkjRDDNy/viNJ0vQB1ad6BcL3XRMiXbZYdyis=;
 b=RznO7jmbojplrvjWzvCu3J0DYUogsJrazLRXrJLg0VCJZGZ/wyQN+wkPYPQiVIJ+Ns
 yukpDnM+5Qx5SW9EYoNVf0AvYUZP5u/QsZ7vao72G3WuOSGVgWuwTuEOdwfriMYsIj5Z
 puDAwn2J+fxj3PbUG/38dr6PrTcKVD8SPnTotiS2WCOtVO5Vz9TjTsNoK3NiP5lu604O
 Q8doNF1O3F3/1Q3yBgkC+VL+SzRj4sydFE6MZ5fMbqZKXPHsJA/uaNz5lzOA5vCZIO1e
 kMnXNmmkSiPBwpc5aX5lcaWxFxBI7GGnQRYzSeH8vlwp2oNaGiaEzvOgkF5RBJ3AoXGy
 7Lbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7tSHk4YpLKDHM4WTcGl1VapiNfYYvNAFRUxX4u+hPpnkif5QDUB3/0e7b/4eXETwpmPUSxTnpWAPM@nongnu.org
X-Gm-Message-State: AOJu0YxS4eV8Jovr90IQ/l5VLkFHuGMmYUXxV9J6UgeRc5MmFVkHMbBB
 DX+FkbfVw0i4/RU/Rz0UHShc6HAkOXTsAXvtEKVepcmwVnJpb6q3
X-Gm-Gg: ASbGncsdIs22c/AmyY7XbjnqF2SjTefsJNJ/iP+O7nYU/7F+WboJk66YM1uFhwPShBj
 HMam6Q7JaYGByFMX/tG8D8PslERlj/OGFiiceAVUpjcj443TtOso3jEbDjmOcnc3tFarYR549Mh
 +CuezxvDwzBW/l1Gd5eFO9Q5Y8R4CerBwJv3vE/SYXenwRIEyi4htj0wLw+t/K4NCufPgIn3rxK
 clvxT37kJ2mFAUAfu2fV13K+bVNGQCFag5Eoz30am3pC/qtJPez/i5EBVhdvfGCQBQL7l/y0+Ek
 OMPiloOLbsmu0dKMGwS78bIH2KFsyCWyMPusATQ1rzKY
X-Google-Smtp-Source: AGHT+IEkLH7R0K+dZ70l8hy5yxKx5v+4yg9xpdhMGciYVUp9boNogvOqmTqVao+V/6WRoD1bCcWQww==
X-Received: by 2002:a05:6a00:8415:b0:740:5927:92cb with SMTP id
 d2e1a72fcca58-740592793a1mr1141954b3a.0.1746155850816; 
 Thu, 01 May 2025 20:17:30 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058ded48fsm467883b3a.83.2025.05.01.20.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:17:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 03/12] hw/net/e1000e|igb: Remove xitr_guest_value logic
Date: Fri,  2 May 2025 13:16:55 +1000
Message-ID: <20250502031705.100768-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502031705.100768-1-npiggin@gmail.com>
References: <20250502031705.100768-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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
 hw/net/igb_core.c    | 16 +++++++++++++---
 2 files changed, 28 insertions(+), 19 deletions(-)

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
index 39e3ce1c8fe..271c54380e9 100644
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
@@ -3046,8 +3046,7 @@ igb_set_eitr(IGBCore *core, int index, uint32_t val)
 
     trace_igb_irq_eitr_set(eitr_num, val);
 
-    core->eitr_guest_value[eitr_num] = val & ~E1000_EITR_CNT_IGNR;
-    core->mac[index] = val & 0x7FFE;
+    core->mac[index] = val;
 }
 
 static void
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


