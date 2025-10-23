Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E34ECCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBmjj-0000ni-HC; Thu, 23 Oct 2025 00:15:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmji-0000nU-Tl
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:38 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBmjg-0007MO-PR
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:15:38 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-79ef9d1805fso378590b3a.1
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761192935; x=1761797735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DaV098G5oL4FGgdKQrx8xC9vbZLN/Fck1L4/UQZrfQY=;
 b=AGp0wK1C0bUfotdxSMhUomvKUXr+suL+8TZj57nPommKiNza4G4wFErX/IMDHM0449
 WnUGi5HbYIGrYCXNyNSXbx1J3nl8++MV4hK3+gj41DTBfXU37j80izlMIkPQzufvWK94
 s2eJikWSNvIsitDBmgGY/Rm6PPeMhQiwm5iuzaIhf5QHccsTyAH3CTie4sbuaUekJ8HL
 Z+VC24GzORTFH512kg1x4RmsbJVVYwF8SriWvz8n6wnTdINrU64se7hMLGOqGC4kdeqr
 9xaWQDL7mjTh+9CT0AsB+2BLIazpNGT9bTdz6KPweb1wNFZzwqp/goxEuqpD0gDirkhJ
 pq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761192935; x=1761797735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DaV098G5oL4FGgdKQrx8xC9vbZLN/Fck1L4/UQZrfQY=;
 b=pVoYFUDuJZuD6XPNQ3vdwZZWLbiwuB7gbbSXryuNQa8gjk4NDZsfFimqdfpayultVt
 Pulb0Lw4VE4YLQoyzVgRr3VDUxL5K1wp/nD1ma/xgHgffcXHq+GepY8w7R26F+xpuURM
 c4TeqvXtjJrudeKd5QVp2lGD13d2Zagre2aLZz13oZAkxVSHSu2bsKLDWFmTQZufEHWr
 ejRDwG+wMvznvWUspNEnDCJ1P6y2tK5p6fPw3h0ORJ5+g/Wi5i5dsxLdqFQmacr3Anf7
 VT0OzQr3UXWBLFPQ79CXHj2ukEQeIK6ggQPBxLGusEt08r7ObXwNC4eTUU2xZR+eOhql
 r5Ww==
X-Gm-Message-State: AOJu0Yw8/T4H0hmaDje0eU+f9DgUmQ3kGz0T+r1CDOVey/jzpOqv0jgc
 Og6EBFZu4kDyxoUrQ+4ST3JORzzCoGRYTAwGc50pFdmd63LOpWji3ep0Ex//Gg==
X-Gm-Gg: ASbGncuHnkd1DWprzEiQyd0VrqS1BxKrc1wL0wRkzcmYnoyI/1QW4vfShiPvlfpj0CK
 +IuWu/xP81n2W0xFkU3MK165CtcuMLYsdzZtCSkRFjCVqbGfxHFwMyZlQe6mB1d6NBOYVLIiY6K
 Byh5POb72P3c+4fWMswLSVvz5sb+EmYY8v5SH/+MYwL2lpeH0UJ3v7tWvb8OOd78o0Mw658QVJo
 UHGxN6GCHv1v46OhA3+AwFejXWhKQux0/6jZ8fMS7srUWmvXCJHPndLoxc00tuCpQD8DPbkf2Fy
 Ai/JVoEC7FVxooA/ZLiHf8zcOf/HzsUsbpvXiKKVidgRUJzwOfGMzKFSERk0qftZK0dckNFKuWN
 nGUB/4IiQN7wPuOjqlvxR3TZpLxLHFwzQW+99bED78Wo3b852sYxZBi9p9GsauOMQC5YWNXKXal
 9zM0N+TN2am9ZhMpnfcQq1CFrEZZkcmqmCKfZYsjlec1xdyid95BHA4qS26bZtr4tTepKNab9Ud
 emL9u7RHs6sWa5WtpEQ
X-Google-Smtp-Source: AGHT+IFUc7zBAuGrOhaEzFmBf6PKJhYtMK5Ma4zNgtwhr1JB1Kmgp1XsmcBjYC4c9hmJSbB6QtWf1A==
X-Received: by 2002:a05:6a00:1742:b0:77d:6a00:1cd1 with SMTP id
 d2e1a72fcca58-7a274ba91e4mr1683937b3a.12.1761192934853; 
 Wed, 22 Oct 2025 21:15:34 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a274abe5f0sm961640b3a.34.2025.10.22.21.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:15:34 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Guenter Roeck <linux@roeck-us.net>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 14/37] hw/net/cadence_gem: Support two Ethernet interfaces
 connected to single MDIO bus
Date: Thu, 23 Oct 2025 14:14:12 +1000
Message-ID: <20251023041435.1775208-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023041435.1775208-1-alistair.francis@wdc.com>
References: <20251023041435.1775208-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x429.google.com
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


