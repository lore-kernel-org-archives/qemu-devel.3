Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9728DC369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAguO-0003qc-56; Thu, 01 May 2025 23:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAguG-0003pz-Gx
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:17:45 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAguE-0003UV-UX
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:17:44 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-736aaeed234so1539471b3a.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746155861; x=1746760661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q5no8ddhr8154W5pKhH05o9hD5LHHhM1KYUT49zmTjI=;
 b=lQrp5tPqeuuNk2jheHGkWxdEbGNfiT6Tk/VnoR4l3IQxiEBskv24o3EKW5mwLIs6BR
 jbg5/wTJd9q2KJW55mmG4RO5QRJ5pTbl4gf7njIUPqtxBRhJllCuyY6b1e1susvyvrov
 PnEdquMMkJMXwVVhJg30JPIv3Ftd7/312vJ03HzxUUuy3zLOmKd1xny1EPGpKUwajyET
 NzO1cap1ZhyeDsMZ94GxIamRZwiPZH6wJGrYDQQR7h9aIQd1f/j1vsVpylKqJoECk+0I
 FGIXRm1f7vK8cAFBr/8Dbc8TSBAkRkc6P76UNp72+ZfiVW9bpgdGxIILK7iqp14XDym0
 vRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746155861; x=1746760661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q5no8ddhr8154W5pKhH05o9hD5LHHhM1KYUT49zmTjI=;
 b=ijuN2LTn+qBZj7/hNO7U/WvJOs8vWZ0MWJSMu6YXSVsEza9xqlUHDJ8WthDaN4nORD
 7UQyHjOO71oqK6Ebk2o1I/wUZamD1Om2tOoTHGyrSD67xh0DgvvnYzMn6Xwmtt5IZMUa
 Du1HL71K6ad3OVxsGLzP2dKqry2Ag00QMaRimq3AbDw93fKZpmj2TTMgaCWSf5evwem1
 eHonsJ00zDpWLLrjI5z75ZKQARoGf5V3teJjsTXaxLuPsIkgy4/u+dUJfi312LaoU8l5
 aGbID6CnJQLAqR/j+pHgjYG/xDhkVmYRTYNJB9pX3AneoI/pg11SDm85HhuAelqEcTmZ
 YkEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjeiZr5CGOQ2opvGBt5kRgG2i2q02ScvWUqzZZ4cx5E80JMojOy73vYG9+lrMM8Fh4bVUb4Bqhofsx@nongnu.org
X-Gm-Message-State: AOJu0YyRTw6gazKSLD4eQp/0/iYDW9b6NQxWAxz4fjLg042YPkYO3CyM
 vh0oyxLfhic7X8r4K+YNC8Wt40uNv5fnIOHOvZMujxKnezFvsUdx401Seg==
X-Gm-Gg: ASbGncsJq8Vk+Qw6X24zx0uN4i1nSjWNcO8EX1OA9fO6s0mV3LeLVk0qeGiRZo4/ZNF
 NpdyXxr1qOLm3Su6IoQRdhInCWvNwLsQtx7e5rbOFXkh3QDHc+x+M6RM5B/JbUyCk4676DnXlII
 9dim/5AKdHev7goXJFa/vo6xirbwj003GQO63jHmUkO3CUaqUG+TsjvqOwT+t16+YJRhQIFA0GW
 OXLe0132U9rPye9NH00vkma3nOZeFRDWNDYQUhzL01qiXGlbAV6Wusv5imOdg/Q9c6NBbFAUCb2
 qaLENrq/v/Dnkm7svC+NCQuD4/WqCn5Ru5t196BRefdr
X-Google-Smtp-Source: AGHT+IEbWaYjtf0OKUtqDYYT6VEsR8gwVHqNlDvytC7IU6hjb/p/oSP6FTeucW8OeCkc7RkZKVpEmQ==
X-Received: by 2002:a05:6a00:8d86:b0:730:95a6:375f with SMTP id
 d2e1a72fcca58-740588fac49mr1891360b3a.3.1746155861307; 
 Thu, 01 May 2025 20:17:41 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058ded48fsm467883b3a.83.2025.05.01.20.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:17:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 05/12] net/igb: Fix interrupt throttling interval
 calculation
Date: Fri,  2 May 2025 13:16:57 +1000
Message-ID: <20250502031705.100768-6-npiggin@gmail.com>
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

IGB throttling granularity is 1us, and interval field is in bits 2..14
of the EITRx registers.

Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/net/igb_regs.h | 3 +++
 hw/net/igb_core.c | 7 ++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/net/igb_regs.h b/hw/net/igb_regs.h
index 4dc4c31da27..a87aa44f5f3 100644
--- a/hw/net/igb_regs.h
+++ b/hw/net/igb_regs.h
@@ -146,6 +146,9 @@ union e1000_adv_rx_desc {
 #define IGB_82576_VF_DEV_ID        0x10CA
 #define IGB_I350_VF_DEV_ID         0x1520
 
+/* Delay increments in nanoseconds for interrupt throttling registers */
+#define IGB_INTR_THROTTLING_NS_RES (1 * SCALE_US)
+
 /* VLAN info */
 #define IGB_TX_FLAGS_VLAN_MASK     0xffff0000
 #define IGB_TX_FLAGS_VLAN_SHIFT    16
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 271c54380e9..9e9e6e3354f 100644
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


