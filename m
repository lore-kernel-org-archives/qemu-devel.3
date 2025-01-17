Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC09C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 17:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYpky-0004n1-A0; Fri, 17 Jan 2025 12:03:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYpkv-0004ix-4d
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:03:37 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYpkt-0003GZ-79
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:03:36 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso44329975ad.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 09:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737133413; x=1737738213; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LzmeobXpEoq3EntXppNhn02rvVAVNXcjDHWZcam6DrY=;
 b=h0vbpD3Lh+TQMZPg+qux6vLRt02pxA1NiaQ4GjW5lUAUU08d/q8SwxBOMM+hiWEYY7
 2attXFMftkAw14ya7O8NYAAmJMplLSvCgZxvO7mdoHtnueJDfbc30zN7igOmS7cUDxaf
 31IGrjtX/YNSmiUahakOnrkFHyvpTzrQEiSHVD83tOjSjGWTBiV40u7Jr7OaOLcra2lh
 AjWgJn84xZqxw0HF7VqR5ASWhG97wMRc9ofdsoBA9KyRh0rdUj8NDf98hD4wor4ybxF4
 qjXFx9I8HmHp0ioE5V1cjcBanYKn9+VO/dxhfPN5vX8m73H96S7n0HzWafL6zo3PvFYv
 R1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737133413; x=1737738213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LzmeobXpEoq3EntXppNhn02rvVAVNXcjDHWZcam6DrY=;
 b=tQnkl3x4xazDtWJ8Md8FY+OW/SkTMvy3jtniEuIdSsBIMts0Gff601uPiZphySNq87
 Uv15UkKp+p4yGRT4irxfsIMun3JsuuyxO7dNXZxd6tjAu+6ajs1bD1A8ljBag1LnQCbv
 d/NJ6wY+l7kutyQjBO3IIFKJGEGhmNja29xur5VopHfpqzgm+DvN8W3r3Sm+MdmZZobE
 usc4evzcfH3y9Wwp2svJPnO6I1DPVNfxnFI33d4XwGlGkXdpm4BoSh72pjtXkFoI2qs/
 nYpU7cgOM/0wywOeOulRaLQSgMT229ckjn92sFTrb/rIfpoVWyhEgspS3au1WLO5NQyi
 3qJg==
X-Gm-Message-State: AOJu0YwSslW7aVGcfpGsinZ3EmI9IBopwKI+HFKzJBS4NwFLkTtbAKa4
 ugIT2Uu28DlZCqqPp7OKqNvel8wQLhGZrMgGcVtJBmfz16ETCidl+m1UjQ==
X-Gm-Gg: ASbGncvFp/jYXufsK4ZmmRRf1dk00IcZNMgCO3B4nMwoBS2JRkE3sqVuhRlCzydoR0U
 LrgcSCmzD7BRhHA4h784IjuWNEd7s/NVpGTPY0nt0UanYybWgO+u4HajjRa2c+DqNDCNiXtHXBV
 sOzvj25fngUS/NiaQpUFO5gdVk0DFGg7S9tovvGyepTZ0UWEoba1vfIjBSPwZ4cf61Y9dnJZfO8
 WZFSW14QoMMqQbIXSpjv7AzUS8Il78YYjRZoJN1Kstj4Mmi+FOq/RbV7s+l63oE9nna6/mtp9Dg
 80X9RwE8sqK9QPw=
X-Google-Smtp-Source: AGHT+IHsBDdrIWJsRNPAu/lA86c3buB9PYAkijuHvkNeHAlhV6tvrc4rHwCGcNNAldUjTM8vrZR7Iw==
X-Received: by 2002:a17:902:ebce:b0:21c:15b3:e3a8 with SMTP id
 d9443c01a7336-21c355b78d9mr42658685ad.37.1737133413182; 
 Fri, 17 Jan 2025 09:03:33 -0800 (PST)
Received: from wheely.local0.net (124-169-212-233.tpgi.com.au.
 [124.169.212.233]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2cea0b91sm18249435ad.49.2025.01.17.09.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 09:03:32 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4/9] net/igb: Fix interrupt throttling interval calculation
Date: Sat, 18 Jan 2025 03:03:00 +1000
Message-ID: <20250117170306.403075-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250117170306.403075-1-npiggin@gmail.com>
References: <20250117170306.403075-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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
index 39e3ce1c8fe..94f9785749a 100644
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
2.45.2


