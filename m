Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6BFC54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 13:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riwwx-0005dQ-OL; Sat, 09 Mar 2024 08:41:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1riwwu-0005cD-Q6
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 08:41:16 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1riwwr-0004ck-TM
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 08:41:16 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5101cd91017so4942363e87.2
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 05:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709991671; x=1710596471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wnO66AnmaDp5O1vZPqoDqyIqBLstHR6VW3Zpw6NqLJU=;
 b=lV1a3PZnBq0gG/P+4K82j7NGGTzvnYkDHATcapFpgdrzCMFFN6zUW8HqQtWSIJmSqv
 s8yWizN1Z3NNENphEiQsBSrqfPjqGnTZgcsOWZVCk+8U3Odis+f/jZxa/2xMjiOcepxC
 5uBgfVbUj8QecmzN8ZeyHfGnouAr/h5qcBEH0FZNkWayQNG7rJPZ0+cKYXtnvyWoqVDw
 gKRMSmNGJR0aW1RbehdGHTVA34OnaVYimKn03X62IqIKiKX76L10GXaME6jthdQKOmde
 iUKw1DO3gknvMxFThQV5oxavDskIis7ZfoZtvSp2UqAiNI5FVCEBlEvN2D/m/Al7dEap
 YMLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709991671; x=1710596471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wnO66AnmaDp5O1vZPqoDqyIqBLstHR6VW3Zpw6NqLJU=;
 b=H3myUoK96IO+a/0su7DK6K8mzuXJHmC6PAm4pDMDjSf3syBmNK8QKv7cFvYWaXfCai
 pFn1PUUbaJ1jG19UNS2V+3cwMEDnnuLcfJmsld7sQUc22ubN41JHwKP00Pzbk7IxIB+B
 VioYcmUho9H8Ki+fw1Vk4IoOe/3+xJ/VGHDfuCUg0a3V0aqEjf4zNOuHqWCggcA5IMwN
 okQFDWM20uGO1GyHSTkYwCwqMaaLRQidQjtRK2Yz/h9/cUAjyfIspyN7iSlYZ75+OQZb
 MbJQiRMi5jJTwpi/0zUPLuRWzxvmaAfK+GXbJJOoULmRL7+rj/jTk6G7tdOySQlV2fef
 aaqw==
X-Gm-Message-State: AOJu0YwKNVHYCNHLskF/nRWNtDMEw5kBYQIjTpUAeU+vGuHzAfkhw6ih
 SMfqxDwmysIDppbGRFlj+RmLpTCSVGG+vCCbIeSSRl6udUAvjULcpZIjljBg
X-Google-Smtp-Source: AGHT+IHKCwTHkROB7QdjAPQHJXnV8pyCBIn76o0R/wIO7qtd0y4o0jxYK3xI/kHdjeeBvAexqxX47g==
X-Received: by 2002:ac2:4da4:0:b0:513:9b6d:ab0e with SMTP id
 h4-20020ac24da4000000b005139b6dab0emr1022564lfe.5.1709991670781; 
 Sat, 09 Mar 2024 05:41:10 -0800 (PST)
Received: from archlinux.. (dynamic-078-054-250-034.78.54.pool.telefonica.de.
 [78.54.250.34]) by smtp.gmail.com with ESMTPSA id
 b2-20020aa7c902000000b00564e489ce9asm906157edt.12.2024.03.09.05.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 05:41:10 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 1/2] hw/pci-host/pam: Free PAMMemoryRegion from Intel-specific
 bit handling
Date: Sat,  9 Mar 2024 14:40:55 +0100
Message-ID: <20240309134056.1605-2-shentey@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240309134056.1605-1-shentey@gmail.com>
References: <20240309134056.1605-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The PAM bit extraction is currently spread across pam.c and the northbridge
device models, making the extraction logic harder to comprehend. Also note how
pam_update() deals with PAM_REGIONS_COUNT, even though it handles exactly one
region. Fix this (at the cost of minor code duplication) by moving the bit
extraction into the northbridge device models. As a side effect, pam_update()
becomes less Intel-specific which would allow it to be reused e.g. in VIA
northbridges.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/pci-host/pam.h |  7 +++----
 hw/pci-host/i440fx.c      |  7 +++++--
 hw/pci-host/pam.c         | 14 +++++++-------
 hw/pci-host/q35.c         |  5 +++--
 4 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/hw/pci-host/pam.h b/include/hw/pci-host/pam.h
index 005916f826..b9b33aecc8 100644
--- a/include/hw/pci-host/pam.h
+++ b/include/hw/pci-host/pam.h
@@ -70,7 +70,6 @@
 /* PAM registers: log nibble and high nibble*/
 #define PAM_ATTR_WE     ((uint8_t)2)
 #define PAM_ATTR_RE     ((uint8_t)1)
-#define PAM_ATTR_MASK   ((uint8_t)3)
 
 /* SMRAM register */
 #define SMRAM_D_OPEN           ((uint8_t)(1 << 6))
@@ -83,13 +82,13 @@
 #define PAM_REGIONS_COUNT       13
 
 typedef struct PAMMemoryRegion {
-    MemoryRegion alias[4];  /* index = PAM value */
-    unsigned current;
+    MemoryRegion alias[4];  /* index = mode value */
+    uint8_t mode;
 } PAMMemoryRegion;
 
 void init_pam(PAMMemoryRegion *mem, Object *owner, MemoryRegion *ram,
               MemoryRegion *system, MemoryRegion *pci,
               uint32_t start, uint32_t size);
-void pam_update(PAMMemoryRegion *mem, int idx, uint8_t val);
+void pam_update(PAMMemoryRegion *mem, uint8_t mode);
 
 #endif /* QEMU_PAM_H */
diff --git a/hw/pci-host/i440fx.c b/hw/pci-host/i440fx.c
index 4f0a0438d7..cddd506ab0 100644
--- a/hw/pci-host/i440fx.c
+++ b/hw/pci-host/i440fx.c
@@ -64,6 +64,8 @@ struct I440FXState {
 #define I440FX_PAM_SIZE 7
 #define I440FX_SMRAM    0x72
 
+#define I440FX_PAM_ATTR_MASK ((uint8_t)3)
+
 /* Keep it 2G to comply with older win32 guests */
 #define I440FX_PCI_HOST_HOLE64_SIZE_DEFAULT (1ULL << 31)
 
@@ -88,8 +90,9 @@ static void i440fx_update_memory_mappings(PCII440FXState *d)
 
     memory_region_transaction_begin();
     for (i = 0; i < ARRAY_SIZE(d->pam_regions); i++) {
-        pam_update(&d->pam_regions[i], i,
-                   pd->config[I440FX_PAM + DIV_ROUND_UP(i, 2)]);
+        uint8_t reg = pd->config[I440FX_PAM + DIV_ROUND_UP(i, 2)];
+        pam_update(&d->pam_regions[i],
+                   (reg >> ((!(i & 1)) * 4)) & I440FX_PAM_ATTR_MASK);
     }
     memory_region_set_enabled(&d->smram_region,
                               !(pd->config[I440FX_SMRAM] & SMRAM_D_OPEN));
diff --git a/hw/pci-host/pam.c b/hw/pci-host/pam.c
index 68e9884d27..29c0db097a 100644
--- a/hw/pci-host/pam.c
+++ b/hw/pci-host/pam.c
@@ -51,20 +51,20 @@ void init_pam(PAMMemoryRegion *mem, Object *owner, MemoryRegion *ram_memory,
                              start, size);
 
     memory_region_transaction_begin();
-    for (i = 0; i < 4; ++i) {
+    for (i = 0; i < ARRAY_SIZE(mem->alias); ++i) {
         memory_region_set_enabled(&mem->alias[i], false);
         memory_region_add_subregion_overlap(system_memory, start,
                                             &mem->alias[i], 1);
     }
     memory_region_transaction_commit();
-    mem->current = 0;
+    mem->mode = 0;
 }
 
-void pam_update(PAMMemoryRegion *pam, int idx, uint8_t val)
+void pam_update(PAMMemoryRegion *pam, uint8_t mode)
 {
-    assert(0 <= idx && idx < PAM_REGIONS_COUNT);
+    g_assert(mode < ARRAY_SIZE(pam->alias));
 
-    memory_region_set_enabled(&pam->alias[pam->current], false);
-    pam->current = (val >> ((!(idx & 1)) * 4)) & PAM_ATTR_MASK;
-    memory_region_set_enabled(&pam->alias[pam->current], true);
+    memory_region_set_enabled(&pam->alias[pam->mode], false);
+    pam->mode = mode;
+    memory_region_set_enabled(&pam->alias[pam->mode], true);
 }
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 0d7d4e3f08..947d9aa9c4 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -330,8 +330,9 @@ static void mch_update_pam(MCHPCIState *mch)
 
     memory_region_transaction_begin();
     for (i = 0; i < 13; i++) {
-        pam_update(&mch->pam_regions[i], i,
-                   pd->config[MCH_HOST_BRIDGE_PAM0 + DIV_ROUND_UP(i, 2)]);
+        uint8_t reg = pd->config[MCH_HOST_BRIDGE_PAM0 + DIV_ROUND_UP(i, 2)];
+        pam_update(&mch->pam_regions[i],
+                   (reg >> ((!(i & 1)) * 4)) & MCH_HOST_BRIDGE_PAM_MASK);
     }
     memory_region_transaction_commit();
 }
-- 
2.44.0


