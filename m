Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA8CCCD193
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 23:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC54g-0004YD-QK; Thu, 23 Oct 2025 19:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54f-0004Uh-27
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:29 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vC54d-0007Qc-9J
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 19:50:28 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b608df6d2a0so1231266a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 16:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761263425; x=1761868225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DaV098G5oL4FGgdKQrx8xC9vbZLN/Fck1L4/UQZrfQY=;
 b=HVgPNf0PmBN9iuXvrE5UcTm9YYB05VDruutqkgdzcBqcYwOLsMGt8L+VO00ZoN6CRl
 n3OS4Tom6iHyfwFwXko5NjHBW+Bi3uyrwCScpzcxahp+rRDEzlwO7MGrfVJWWAhPQADE
 LM5Kri5S1rTTdeTA5J490BfCtPb7qnUXeEHxBS0W0XoU0fB9+71qcSS8s0d5HNrE28xM
 FEH5uoTxppW5H8wZ90mH2ieAL3nHCwKkFaD8DZu9mgI4iScOCsPBVZ+elyXvy0Btazou
 yuv/OVnWE/vb4hsPS5c9KolyBqg5e5mWANAHhQElBIbzRIZ0Dqx09/BAEvFDMDbrR+Rj
 hTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761263425; x=1761868225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DaV098G5oL4FGgdKQrx8xC9vbZLN/Fck1L4/UQZrfQY=;
 b=r5kSVXZyWx5Cd+jyQGp0vQ87a78Ft3SDIqJavllrfE5/QgsM/ShiXza1l/EwjeSWUX
 sG20jJRtWJ3ZyVlX228bm6IS81nrFkulTunsQQyhwW31K67WfR+kPzQnyVtl7utyi7Fj
 x65GAjdR53ZO4tj0QibXLJSJhw4e8aoFE5CKESJfhpSORrYYAf5UIpefmRnc0YyPkvu1
 UsIHa1UaxcwRGNk52cW9GuSpyztXiPAAP5l7yToriysrCFPqDa6FqErbANivVhXz4+6V
 fTrIKri/H+o2gHXXgbMGqCS/YaP4wkZw1rgOV3W8txj2WJjoznJtCI4JKT9bHHlxKx7P
 hxkw==
X-Gm-Message-State: AOJu0YyeSgDY+UYFZkboRqdM9JPU63IlDkc2RkOz5i7eG5cthGp+axpn
 VRRGhjEIq401/VyhDDzHa6owccDS5bnpePO8RRzx703irbZx8Np1TRfKMn2XGg==
X-Gm-Gg: ASbGncuGEZz10+GSbu9MLBJItHj9QMrCZxVG50uH7vB3X2KF5Q1DUqdG4hWE305uL7q
 TF4zW+e/rTM3u5EtL5s1vKNJ3C+ugaeSa01obw6AsN2/KvI/pE+8wdmQEa1UBvSHfqdsppIqa95
 4L5YIhaMBY/F2ucf/H4oXYqbharFPJ6pnshQxV7+lDcG9IJOxa+XFxmcW9xcxiGSSCTObCEucSh
 iI2R48OBmiiH3X4gjWhnr5YUux/BgVUmzWcP8O4X/tDsoBLIhG36z8ygUBZ3IruJbX+dnLRILUj
 f0vu68V5s+qAVOoRmVzvUmewtaURCpUuYGwkvs15UZpfSz5sZ8L6Bep4adWGLZnl+LiWYhVa3gI
 YL0cYis/bxu9l8gVHR/wTpEK0i2IC43cpHrmSxnFtij2yvR5/RD+DdJQ2um6zQoVEPvXUktyAyN
 1plyEZfURoaqvSbosMyLA8uh5SEaVVI1xzD1IWhcYSINbePp+uZjfRxFc6clst79/DgG9V1brQ0
 YLxpI+D
X-Google-Smtp-Source: AGHT+IFGUsRaMl50hhZX1kMN4WIkLzDPqiGEW4Kao3SjduNLr1Y+ckEIYHpw8QwKjdvkHuVRMzxrLQ==
X-Received: by 2002:a17:902:ccc3:b0:28e:9a74:7b58 with SMTP id
 d9443c01a7336-2948ba3ba9dmr2788605ad.31.1761263425190; 
 Thu, 23 Oct 2025 16:50:25 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946de02cb7sm36088525ad.40.2025.10.23.16.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 16:50:24 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Guenter Roeck <linux@roeck-us.net>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 14/25] hw/net/cadence_gem: Support two Ethernet interfaces
 connected to single MDIO bus
Date: Fri, 24 Oct 2025 09:49:16 +1000
Message-ID: <20251023234927.1864284-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023234927.1864284-1-alistair.francis@wdc.com>
References: <20251023234927.1864284-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Guenter Roeck <linux@roeck-us.net>

The Microchip PolarFire SoC Icicle Kit supports two Ethernet interfaces.
The PHY on each may be connected to separate MDIO busses, or both may be
connected on the same MDIO bus using different PHY addresses.

To be able to support two PHY instances on a single MDIO bus, two properties
are needed: First, there needs to be a flag indicating if the MDIO bus on
a given Ethernet interface is connected. If not, attempts to read from this
bus must always return 0xffff. Implement this property as phy-connected.
Second, if the MDIO bus on an interface is active, it needs a link to the
consumer interface to be able to provide PHY access for it. Implement this
property as phy-consumer.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251004200049.871646-2-linux@roeck-us.net>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/net/cadence_gem.h |  3 +++
 hw/net/cadence_gem.c         | 24 ++++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
index 91ebb5c8ae..21e7319f53 100644
--- a/include/hw/net/cadence_gem.h
+++ b/include/hw/net/cadence_gem.h
@@ -81,6 +81,9 @@ struct CadenceGEMState {
 
     uint8_t phy_loop; /* Are we in phy loopback? */
 
+    bool phy_connected; /* true if connected */
+    struct CadenceGEMState *phy_consumer;
+
     /* The current DMA descriptor pointers */
     uint32_t rx_desc_addr[MAX_PRIORITY_QUEUES];
     uint32_t tx_desc_addr[MAX_PRIORITY_QUEUES];
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 44446666de..520324adfd 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1541,12 +1541,20 @@ static void gem_handle_phy_access(CadenceGEMState *s)
 {
     uint32_t val = s->regs[R_PHYMNTNC];
     uint32_t phy_addr, reg_num;
+    CadenceGEMState *ps = s;
+    uint32_t op;
 
     phy_addr = FIELD_EX32(val, PHYMNTNC, PHY_ADDR);
+    op = FIELD_EX32(val, PHYMNTNC, OP);
 
-    if (phy_addr != s->phy_addr) {
-        /* no phy at this address */
-        if (FIELD_EX32(val, PHYMNTNC, OP) == MDIO_OP_READ) {
+    /* Switch phy to consumer interface if there is an address match */
+    if (s->phy_consumer && phy_addr == s->phy_consumer->phy_addr) {
+        ps = s->phy_consumer;
+    }
+
+    if (!s->phy_connected || phy_addr != ps->phy_addr) {
+        /* phy not connected or no phy at this address */
+        if (op == MDIO_OP_READ) {
             s->regs[R_PHYMNTNC] = FIELD_DP32(val, PHYMNTNC, DATA, 0xffff);
         }
         return;
@@ -1554,14 +1562,14 @@ static void gem_handle_phy_access(CadenceGEMState *s)
 
     reg_num = FIELD_EX32(val, PHYMNTNC, REG_ADDR);
 
-    switch (FIELD_EX32(val, PHYMNTNC, OP)) {
+    switch (op) {
     case MDIO_OP_READ:
         s->regs[R_PHYMNTNC] = FIELD_DP32(val, PHYMNTNC, DATA,
-                                         gem_phy_read(s, reg_num));
+                                         gem_phy_read(ps, reg_num));
         break;
 
     case MDIO_OP_WRITE:
-        gem_phy_write(s, reg_num, val);
+        gem_phy_write(ps, reg_num, val);
         break;
 
     default:
@@ -1813,6 +1821,10 @@ static const Property gem_properties[] = {
                       num_type2_screeners, 4),
     DEFINE_PROP_UINT16("jumbo-max-len", CadenceGEMState,
                        jumbo_max_len, 10240),
+    DEFINE_PROP_BOOL("phy-connected", CadenceGEMState, phy_connected, true),
+    DEFINE_PROP_LINK("phy-consumer", CadenceGEMState, phy_consumer,
+                     TYPE_CADENCE_GEM, CadenceGEMState *),
+
     DEFINE_PROP_LINK("dma", CadenceGEMState, dma_mr,
                      TYPE_MEMORY_REGION, MemoryRegion *),
 };
-- 
2.51.0


