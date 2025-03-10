Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D0CC28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 00:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trQfg-00026L-0h; Sun, 09 Mar 2025 20:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQfa-00022f-TB
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:06:59 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQfZ-0007My-1v
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:06:58 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso1699506f8f.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 17:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741565216; x=1742170016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZOP1JCepoOpEGtD0DeikejYc/lpyX9gmrkBY6224GqM=;
 b=M2HY8597TyFM9qb24Gu96A+k+r5X6Te+fHAgXNag0yUv9lcB0+fHlgq5IbV79IsIUi
 DUYfGnkP7q6pW43mIsgQStZEFWAbsrFSatyxyjROVaDCTVMWglcPC0bzigSEXLEfamLE
 MlsU+FeiohwySuxV5GbhMqzOl1vxzDli38aMn4Kl52Z/sRLUyALkOcSLy3rQ3fxIsAv4
 vZCP+1muSoSp2wGhFtEuRsOjOhfYGZ+hupZGGjytNm8h11ra7uIrKw0GM8M5imOgrFlQ
 Ws9ATEjwxnhsB776Z8HEOMUdojWTKSed1U7yB4ui5yEA2CH57uV4o9mzRq8gZN0u3Vpe
 cQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741565216; x=1742170016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZOP1JCepoOpEGtD0DeikejYc/lpyX9gmrkBY6224GqM=;
 b=J1qtLclOPIintZekomsDNVbFxJX45MxppXvib0oErEWioinaUK3iIR98uX4Y3LKRo9
 JyMWial7+YeSTkW+llhOcl73HgxYUeYOCM9k1R/tOBzBbMEFF7AJMgky42nKyOxmMPVL
 QmN5Ozmu3MSqLUdh9QTVqlcKOUFwTV2VdRxY/52Hp1FxdX09jxARKu9niCubXITaeK/o
 kgBZifq562BdsZOrHCzlsdmm4rdXdaOR0aQZQv+PDSQXsl6NWx7wDkwACdk2l2UswTAe
 lK6vx1CFxJ91MFn5cDEIJCbgVuZQTkF4AqoPk45sV9yWGdcwUASi9SFyQQANi6SAUFIa
 eIJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSauE1kwwsWX0Lvt8MNCq9bVaysct8aOs0Dbk1TL40LR5Rjqvo4Ls3fOESToXpvW2o/yDtjk7z2+if@nongnu.org
X-Gm-Message-State: AOJu0YynnivJhtjYX5Tr86pJ2NJI7HgWpf9E8ff3ASWBHXt3qtyqNCyp
 XC2shRdr+7i+5ypKwnMIRPi2KTa+QlpEudl1d6V1VVCOcarSrEK4PdjU8bBtDbQ=
X-Gm-Gg: ASbGncs9eQDgQK5rght81A+mFOryt23HmTSCKv4oocP4vqx+MMpeTYPz8b/rhEqNMkp
 CJrC4HXjG17ZiLnXCIhuLJNo8is7BPt2/LJ+9Sheg3wAtycw5q/bihKUfoO1v/cWrH7aJDeKoW8
 SesPZgPHKT2Bz+YFXr7dLq7n7aGB40BF568i+WX0rTqmNoc0BrBXd0xCYIKWYlxiEZr/ay8rOEJ
 XbSczoko6H+v4neaCOtgsK1z0qvPLTkrRzFCxxrjuzr+JfMeqwDz2jx0Dee+0OqWcEMBdDHOllD
 QzogMvN1wHrGJUuBbsEx0khkf6ZAHyt9MsoUWjhD5qUsemHQE4vS3GgHqM+05o7Zuc6sC2eGoNq
 Fmjapn/sZNqFCN1/x/u4=
X-Google-Smtp-Source: AGHT+IHZn5VNBCcyaAnuhIVlrKNkJ1fO3I+O/PeMTYOLZEWuAXd6veEaEqResUHxa0p0v8isyn7U9A==
X-Received: by 2002:a5d:47cb:0:b0:391:21e2:ec3b with SMTP id
 ffacd0b85a97d-3913aed7e68mr4257819f8f.3.1741565215639; 
 Sun, 09 Mar 2025 17:06:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfe0004sm12885561f8f.40.2025.03.09.17.06.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 17:06:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>,
	qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>
Subject: [PATCH v5 06/14] hw/sd/sdhci: Introduce SDHCIClass stub
Date: Mon, 10 Mar 2025 01:06:12 +0100
Message-ID: <20250310000620.70120-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250310000620.70120-1-philmd@linaro.org>
References: <20250310000620.70120-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

TYPE_SYSBUS_SDHCI is a bit odd because it uses an union
to work with both SysBus / PCI parent.

For this reason, we can not use the OBJECT_DECLARE_TYPE()
macro twice (on SYSBUS_SDHCI & PCI_SDHCI) and we must
keep a pair of lower DECLARE_INSTANCE_CHECKER) and
DECLARE_CLASS_CHECKERS() for PCI, in order to avoid:

  include/hw/sd/sdhci.h:165:1: error: redefinition of 'glib_autoptr_clear_SDHCIState'
  include/hw/sd/sdhci.h:165:1: error: redefinition of 'glib_autoptr_cleanup_SDHCIState'
  include/hw/sd/sdhci.h:165:1: error: redefinition of 'glib_autoptr_destroy_SDHCIState'
  include/hw/sd/sdhci.h:165:1: error: redefinition of 'glib_listautoptr_cleanup_SDHCIState'
  include/hw/sd/sdhci.h:165:1: error: redefinition of 'glib_slistautoptr_cleanup_SDHCIState'
  include/hw/sd/sdhci.h:165:1: error: redefinition of 'glib_queueautoptr_cleanup_SDHCIState'
    165 | OBJECT_DECLARE_TYPE(SDHCIState, SDHCIClass, SYSBUS_SDHCI)
        | ^
  include/hw/sd/sdhci.h:158:1: note: previous definition is here
    158 | OBJECT_DECLARE_TYPE(SDHCIState, SDHCIClass, PCI_SDHCI)
        | ^

Since we can not use SYSBUS_SDHCI_GET_CLASS() on PCI instances,
cache the class reference in the object state as 'sc'.

As this is not a normal use, introduce SDHCIClass in its own
commit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
I plan to remove the union later.
---
 include/hw/sd/sdhci.h | 17 +++++++++++++----
 hw/sd/sdhci-pci.c     |  1 +
 hw/sd/sdhci.c         |  3 +++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index 2e6e719df7b..c42aeab6848 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -30,6 +30,8 @@
 #include "hw/sd/sd.h"
 #include "qom/object.h"
 
+typedef struct SDHCIClass SDHCIClass;
+
 /*
  * SD/MMC host controller state
  *
@@ -41,13 +43,12 @@
  *    card to be protected).
  */
 struct SDHCIState {
-    /*< private >*/
     union {
         PCIDevice pcidev;
         SysBusDevice busdev;
     };
 
-    /*< public >*/
+    SDHCIClass *sc;
     SDBus sdbus;
     MemoryRegion iomem;
     AddressSpace sysbus_dma_as;
@@ -110,6 +111,13 @@ struct SDHCIState {
 };
 typedef struct SDHCIState SDHCIState;
 
+struct SDHCIClass {
+    union {
+        PCIDeviceClass pci_parent_class;
+        SysBusDeviceClass sbd_parent_class;
+    };
+};
+
 /*
  * NOTE: This definition is taken out of Linux kernel and so the
  * original bit number is preserved
@@ -126,10 +134,11 @@ enum {
 #define TYPE_PCI_SDHCI "sdhci-pci"
 DECLARE_INSTANCE_CHECKER(SDHCIState, PCI_SDHCI,
                          TYPE_PCI_SDHCI)
+DECLARE_CLASS_CHECKERS(SDHCIClass, PCI_SDHCI,
+                       TYPE_PCI_SDHCI)
 
 #define TYPE_SYSBUS_SDHCI "generic-sdhci"
-DECLARE_INSTANCE_CHECKER(SDHCIState, SYSBUS_SDHCI,
-                         TYPE_SYSBUS_SDHCI)
+OBJECT_DECLARE_TYPE(SDHCIState, SDHCIClass, SYSBUS_SDHCI)
 
 #define TYPE_IMX_USDHC "imx-usdhc"
 
diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
index 5268c0dee50..fe62582de90 100644
--- a/hw/sd/sdhci-pci.c
+++ b/hw/sd/sdhci-pci.c
@@ -73,6 +73,7 @@ static const TypeInfo sdhci_pci_types[] = {
         .parent         = TYPE_PCI_DEVICE,
         .instance_size  = sizeof(SDHCIState),
         .class_init     = sdhci_pci_class_init,
+        .class_size     = sizeof(SDHCIClass),
         .interfaces     = (InterfaceInfo[]) {
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
             { },
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index d1b1b187874..176bee6b8f5 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1419,6 +1419,8 @@ static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
 
 void sdhci_initfn(SDHCIState *s)
 {
+    s->sc = (SDHCIClass *)object_get_class(OBJECT(s)); /* Cache QOM parent */
+
     qbus_init(&s->sdbus, sizeof(s->sdbus), TYPE_SDHCI_BUS, DEVICE(s), "sd-bus");
 
     s->insert_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
@@ -1960,6 +1962,7 @@ static const TypeInfo sdhci_types[] = {
         .instance_size = sizeof(SDHCIState),
         .instance_init = sdhci_sysbus_init,
         .instance_finalize = sdhci_sysbus_finalize,
+        .class_size = sizeof(SDHCIClass),
         .class_init = sdhci_sysbus_class_init,
     },
     {
-- 
2.47.1


