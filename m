Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD362CCD183
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 20:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v58RV-00011R-Ow; Sat, 04 Oct 2025 16:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1v58RM-0000ti-9v
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 16:01:12 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1v58RF-0006DI-Ie
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 16:01:11 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-782023ca359so3405273b3a.2
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 13:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759608062; x=1760212862; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s89LU7o1ZyXNcRb/2leqwVIsfipruP3UJlVfpKF2qgY=;
 b=Olyk0q1LofsYdRMAlI3eSQBZvPiN/MNrQrH1XzW2V1TxKuWmmgCibjcn0jZ5k+z305
 6s3ZzSpO/ZVmpSnYOJ7GLCIzbGONci7RjwZaKQDz+Js3mox64wtN94QdoI7L+I6Avlpq
 EcEHYlUBF77M/s05PUVhzMN2NT5dao3fRjw6r4qlHdCA1/QimCE69WopFFKS0nVzXBzI
 BSOk0SMHDJbBo8P/ukfIAWFKdHmf06//DTVUljUzJJdD+GFFPrXK/9EiLsqwh1yg4MU+
 Gyxviupo1gDCZ3rFmGgINRFk/TX/QgKTe67zaNkOtn0gOLmMmEkCo19AyQPpzjXmRC4M
 s/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759608062; x=1760212862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s89LU7o1ZyXNcRb/2leqwVIsfipruP3UJlVfpKF2qgY=;
 b=khYf68u2EgzU/MF+tMPUJB25ZI/RnmtUCJ3mVqozYRoB/gVLtK3nQXMONFA1MKf1h9
 1Qmwg1Ga2dKIWRC8od6sYsnHwzgPrVhUb2vYJzS4chSO2zaJ0McHOYGbdrnsJ4B/SeqY
 Gh4mZ44E3MYXUmtZCfRGf5NFkAHmZSBRIpSPbC5773xp3uB8+1ry0jD3+IsygiTk2dxu
 bKUKtUZ1ycosCnc9Dv5nF2Q+efNhCUFJXNGqD8X2kQYEOhbwHoUHTXUasoSl33caJkea
 aKICAF/EoRjdnhBh1EeOmnzH5Vguu1fIdbuZBFiYP9Hoful64V3MnFOZaw837zv41NO5
 tP7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbSZ64RXrAJq+SkgXxdAXzkJ5CrBB7EQwlc7lIEoTwqXraIM47JWxr1xwy9i2JXCZoU+8xsP7lY+K7@nongnu.org
X-Gm-Message-State: AOJu0YwsAXCgJLkDerVRl/B9ovObouBh0URE6kjJIAmx5G5CLGP4ltI3
 bDpAomb2LheX08hntI5VGk2YMWDXXzPe0OakguS9MYBzhFYNYA+yRiML
X-Gm-Gg: ASbGncv13AiwCWxUU6D0jy0XKYekQMd4RKbjkxAENOjvh/8/pPQtN5BLMaN8a9JtCf6
 JKc9masQxQKTRrVHKPy4b4PmOx7xYtXPS0Hfh4lJpJcE29jMH5qh5sK5n9zECo4nsoifhdBRhrY
 nTkt35qMyVovfJkk79pCboklzYcJXYlVgOUNunxXs7m8A625qPgygfMU+OfbfJDKi6NHxJzcZx5
 HmpgLNSEGMSnAclXZTByfdN8QI7o5TkIanLeFF8LBrKAV9mGBLkPh2U9ZGZIAJKIIzrnBFNwTKB
 dF3Z2Fqn12kTm+YCx80878aC5rwplFXnIAvVl1/mdmiDItKClsIEZC5I+lomupdIKd3m9ge5MPl
 PMUunpWxrDQ7OF4xTP8zxcv/DttmVDWOGuhYqsQ0c4roGyfnz6WVCUB2Hqfwg74OjUgQ1GRKOUM
 hdk6S8
X-Google-Smtp-Source: AGHT+IHw8v/+jlqZ+OZxtkzgJ8jrGBYKxC8Djf49qos3QDGh7kPSXGhr8DHaEVXrjgttf285zb6STg==
X-Received: by 2002:a05:6a20:7d9e:b0:2e9:d6ce:e125 with SMTP id
 adf61e73a8af0-32b61dedc3dmr9689123637.5.1759608061728; 
 Sat, 04 Oct 2025 13:01:01 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6099f3b819sm7998413a12.26.2025.10.04.13.01.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Oct 2025 13:01:01 -0700 (PDT)
From: Guenter Roeck <linux@roeck-us.net>
To: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/4] hw/net/cadence_gem: Support two Ethernet interfaces
 connected to single MDIO bus
Date: Sat,  4 Oct 2025 13:00:46 -0700
Message-ID: <20251004200049.871646-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251004200049.871646-1-linux@roeck-us.net>
References: <20251004200049.871646-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 hw/net/cadence_gem.c         | 24 ++++++++++++++++++------
 include/hw/net/cadence_gem.h |  3 +++
 2 files changed, 21 insertions(+), 6 deletions(-)

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
-- 
2.45.2


