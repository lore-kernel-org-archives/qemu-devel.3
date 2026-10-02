Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76726CA5FE6
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 21:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCl98-0001KJ-Ru; Fri, 02 Oct 2026 17:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xCl96-0001Jc-21
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 17:50:24 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xCl94-0006S2-2I
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 17:50:23 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5FC0260D85;
 Fri,  2 Oct 2026 21:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12891F00893;
 Fri,  2 Oct 2026 21:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790977821;
 bh=tVm0RuDlHkhrFH55su6TMM/AYuN9qEo5PWLjBQ7nYAM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XrxDTUphKnSswM7mdSmumqFQDEURi0hZVr7+4rCOaBXrFm0fY8ykBz9duvcXudHRQ
 mMgV81MWTxEgfABq6K6dQkKBOCSIXNJKJPzpNxc1Koy9ws9pgzUT2Au3QPIbPVfqGQ
 I/RlaA33658cInFFEciUb6C9KJq6vD5+WQj8Hu9HWvDh3u77xO+2O8Qs3tBCW6uBj7
 CXooncgCqZN1rp7X5ACh1k2e3R5qyn4qm9VZwnx2Xbe4ol98YXPoJtSt1IvozHIod4
 1uk18U3RwFw7kTjWoe3sM84pJs+sUBTBOtuPpDIWW+vBqSUbbBvdNN0Et1PDix5jzl
 Cf+gRDGEaDEhA==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Craig Lalley <mr_lalley@yahoo.com>, Helge Deller <deller@gmx.de>
Subject: [PULL 2/4] hw/hppa: Place the second Elroy of the A400 on rope 2
Date: Fri,  2 Oct 2026 23:50:12 +0200
Message-ID: <20261002215014.45371-3-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002215014.45371-1-deller@kernel.org>
References: <20261002215014.45371-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Craig Lalley <mr_lalley@yahoo.com>

On the A400 (and A500) the second Elroy PCI host bridge is connected
to Astro rope 2 at HPA 0xfed34000 (hardware path [0:2]), not to rope 1
at 0xfed32000 as on the C3700.

Add an Astro property "elroy1-on-rope2" which places the second Elroy
at 0xfed34000 on rope 2, including its LMMIO and GMMIO windows, and
set it for the A400.  The C3700 is unchanged.

This pairs with the SeaBIOS-hppa change "parisc/a400: Second Elroy is
at 0xfed34000 on rope 2", which reports the Elroy at that address.  No
PCI devices are attached behind the second Elroy by default.

Signed-off-by: Craig Lalley <mr_lalley@yahoo.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/hppa/hppa_hardware.h     |  1 +
 hw/hppa/machine.c           |  2 ++
 hw/pci-host/astro.c         | 26 ++++++++++++++++++++++----
 include/hw/pci-host/astro.h |  1 +
 4 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/hw/hppa/hppa_hardware.h b/hw/hppa/hppa_hardware.h
index e2b2faa4a3..615b422865 100644
--- a/hw/hppa/hppa_hardware.h
+++ b/hw/hppa/hppa_hardware.h
@@ -31,6 +31,7 @@
 #define ASTRO_HPA       0xfed00000
 #define ELROY0_HPA      0xfed30000
 #define ELROY2_HPA      0xfed32000
+#define ELROY4_HPA      0xfed34000      /* second Elroy on A400/A500, rope 2 */
 #define ELROY8_HPA      0xfed38000
 #define ELROYc_HPA      0xfed3c000
 #define ASTRO_MEMORY_HPA 0xfed10200
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index df25877cb1..fb3ef25f04 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -740,6 +740,8 @@ static AstroState *astro_init(bool is_a400)
                             &error_abort);
     object_property_set_bool(OBJECT(dev), "rotate-pci-pins", is_a400,
                              &error_abort);
+    object_property_set_bool(OBJECT(dev), "elroy1-on-rope2", is_a400,
+                             &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
     return ASTRO_CHIP(dev);
diff --git a/hw/pci-host/astro.c b/hw/pci-host/astro.c
index c024dab858..c688418ded 100644
--- a/hw/pci-host/astro.c
+++ b/hw/pci-host/astro.c
@@ -41,6 +41,23 @@ static const int elroy_hpa_offsets[ELROY_NUM] = {
 static const char elroy_rope_nr[ELROY_NUM] = {
             0, 1, 4, 6 }; /* busnum path, e.g. [10:6] */
 
+/* On the A400 the second Elroy is connected to rope 2 */
+static int astro_elroy_hpa_offset(AstroState *s, int i)
+{
+    if (i == 1 && s->elroy1_on_rope2) {
+        return ELROY4_HPA - ASTRO_HPA;
+    }
+    return elroy_hpa_offsets[i];
+}
+
+static int astro_elroy_rope_nr(AstroState *s, int i)
+{
+    if (i == 1 && s->elroy1_on_rope2) {
+        return 2;
+    }
+    return elroy_rope_nr[i];
+}
+
 /* Astro version numbers */
 enum { ID_ASTRO_1_0 = 0, ID_ASTRO_2_1 = 9, ID_ASTRO_3_0 = 2 };
 
@@ -589,7 +606,7 @@ static void adjust_LMMIO_mapping(AstroState *s)
 
         elroy = s->elroy[i];
         alias = &elroy->lmmio_alias;
-        rope = elroy_rope_nr[i];
+        rope = astro_elroy_rope_nr(s, i);
         if (alias->enabled) {
             memory_region_set_enabled(alias, false);
         }
@@ -715,7 +732,7 @@ static void adjust_GMMIO_mapping(AstroState *s)
 
         elroy = s->elroy[i];
         alias = &elroy->gmmio_alias;
-        rope = elroy_rope_nr[i];
+        rope = astro_elroy_rope_nr(s, i);
         if (alias->enabled) {
             memory_region_set_enabled(alias, false);
         }
@@ -1017,8 +1034,8 @@ static void astro_realize(DeviceState *obj, Error **errp)
         uint64_t map_size;
         int rope;
 
-        addr_offset = elroy_hpa_offsets[i];
-        rope = elroy_rope_nr[i];
+        addr_offset = astro_elroy_hpa_offset(s, i);
+        rope = astro_elroy_rope_nr(s, i);
 
         elroy = elroy_init(i);
         s->elroy[i] = elroy;
@@ -1070,6 +1087,7 @@ static void astro_realize(DeviceState *obj, Error **errp)
 static const Property astro_props[] = {
     DEFINE_PROP_UINT8("phys-addr-bits", AstroState, phys_addr_bits, 32),
     DEFINE_PROP_BOOL("rotate-pci-pins", AstroState, rotate_pci_pins, false),
+    DEFINE_PROP_BOOL("elroy1-on-rope2", AstroState, elroy1_on_rope2, false),
 };
 
 static void astro_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/pci-host/astro.h b/include/hw/pci-host/astro.h
index 3297cd2e62..30d7a0b332 100644
--- a/include/hw/pci-host/astro.h
+++ b/include/hw/pci-host/astro.h
@@ -85,6 +85,7 @@ struct AstroState {
 
     uint8_t phys_addr_bits;
     bool rotate_pci_pins;       /* PCI INTx pin rotation (A400) */
+    bool elroy1_on_rope2;       /* second Elroy on rope 2 (A400) */
 
     struct ElroyState *elroy[ELROY_NUM];
 
-- 
2.54.0


