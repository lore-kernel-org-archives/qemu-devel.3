Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEDCC982FF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lrZ-0006Dp-7u; Mon, 21 Sep 2026 17:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrV-0006Af-E1
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:47:45 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrT-0000E7-N9
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:47:45 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e7d2bb404so11489695e9.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027262; x=1790632062; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7MdfdncaPRi3gjm6EBd30ADvJUJX19pLeuKV8DMjgrQ=;
 b=o/xn54oqPF5Ty8d26lDkK/Mq3nAjtqr+7uTDJtBWDsek+1J3G3/D66K5SumEhNtxhG
 ePcTuK5Ftk938tqQ2Gz+iB3q3xxIygBNGf42tltbKdthyud/VFEgLfDHfeDpDgRmLJtO
 GytQmaaJSqSh5S0AJBRUVg5GFZisYktHeDPTBUTLGE3h2O2/eZsPp+N5H0d5GYFwiW7e
 rbTikN9yvM5qSoAspekPnMLdiY/VQI2BThM5V+aUTwRBrcRrpgLWxnIb/n/Y/JM1A82+
 Bd0eJb3q38dvJNdLwwnvXmkTSnYws8D3RW7CAmiVCvy1AY32Z90DWtIjdYVBw/vz0PTw
 bYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027262; x=1790632062;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7MdfdncaPRi3gjm6EBd30ADvJUJX19pLeuKV8DMjgrQ=;
 b=Z5ASUR0jqtczcLszObVcWOks8OKPbcKI1tNOEC8iTacabDse5zwgwX6hNIPei38Js/
 aWFAi/cOV29riBpgYBvQxElRlF7g/0C15S7frt94IP9aUr0X+pYEX5bjgDk4n5+dUZUw
 EGG9CuDlxBs/1bU/SbsrxL5042LGbr6FRXV2sJIQApPm14iXISTUtTNSf9nPKDYEu/VA
 2gEEK30vdmK/bR/Cghw8xgGkJYa05yQeE5nlWvJ3pRs3mvlrCMdT9Jj2UGtxmoOxAypi
 aTYgiQdAKjh7qPnzXXgjiypR4qAgDVTmH59Q5kUiAnz1bK/DzoTBAtcfAHg45f/BIcIn
 ev0g==
X-Gm-Message-State: AFuF++lAYXtW+sS3G67AKYzonJWdBe6k95bkve23LhczNNKyDqrR80nk
 gyqaNlKBa6J73fkuGfIpYtQBdlWN5rgtQJu2vnk+EkNcWo7Gh2v/qxYhBLA/MA==
X-Gm-Gg: AYBFou3UOGo4rKTU26P1AhXDaKOeyHhrNUe7PaecOtmA5XjFVC1rrOm8jILOQyeAYxQ
 iy4tdc9AzHOoLGSwdAsvXDm8EEJHU+7k/q1Mast6zAV0QgrHlaen1WMrVcEL8/lgKpgEbTCQXxF
 6m0Ko/UZ/6CRQgNl3t3ZlBREjE/KfPtW42J/mfzrNoVIVro7sTqFJu5HokpvaGVx9B0P/VASIcp
 Q3zLYkf6xk5NUpB5D3YWPZ7wjhWh44wSMb6gA5SBrkGhQ1kuerIDBCkpAib6KLAjFbSL8pulWCl
 khrMwRwo8Ox5aG0drR0YiITzgm0ZjnRO0XTqou8LV17Du7RzXHrjCvxi69VyzCsU2pkhuYb/cOT
 5LepdA6y8Mc5qlbY+uec7XCnJa5mpCwMe/q80glE/lidq/7IxnFSCZSVqAxbSZGmGqfoYAO0dce
 kG91mnnvwybjLOXY1P7uoyU+tLsrwS7qocbILpNTT2YeSTcRF/N8klMXoEfcg/B3Rz/4FJuXg4T
 MxJPGJpkLVg770GOz9NFY/snb3/MpYy2znIlquBw5p3O20xTIN3DHya0P8xE7a2oxLaj2lnFxek
 UzY=
X-Received: by 2002:a05:600c:3e16:b0:49e:715d:95ca with SMTP id
 5b1f17b1804b1-49fd8a69266mr13470065e9.13.1790027262260; 
 Mon, 21 Sep 2026 14:47:42 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.47.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:47:41 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 11/42] hw/arm/fsl-imx25: Derive from TYPE_SYS_BUS_DEVICE
Date: Mon, 21 Sep 2026 23:46:39 +0200
Message-ID: <20260921214710.29422-12-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be reset upon
machine reset.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/arm/fsl-imx25.h | 5 ++---
 hw/arm/fsl-imx25.c         | 7 +------
 hw/arm/imx25_pdk.c         | 2 +-
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
index b68d4334a0..4bb4d5b3e5 100644
--- a/include/hw/arm/fsl-imx25.h
+++ b/include/hw/arm/fsl-imx25.h
@@ -29,6 +29,7 @@
 #include "hw/sd/sdhci.h"
 #include "hw/usb/chipidea.h"
 #include "hw/watchdog/wdt_imx2.h"
+#include "hw/core/sysbus.h"
 #include "system/memory.h"
 #include "target/arm/cpu.h"
 #include "qom/object.h"
@@ -45,10 +46,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslIMX25State, FSL_IMX25)
 #define FSL_IMX25_NUM_USBS 2
 
 struct FslIMX25State {
-    /*< private >*/
-    DeviceState parent_obj;
+    SysBusDevice parent_obj;
 
-    /*< public >*/
     ARMCPU         cpu;
     IMXAVICState   avic;
     IMX25CCMState  ccm;
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 7f65f4ca4b..efb22359c5 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -317,16 +317,11 @@ static void fsl_imx25_class_init(ObjectClass *oc, const void *data)
     device_class_set_props(dc, fsl_imx25_properties);
     dc->realize = fsl_imx25_realize;
     dc->desc = "i.MX25 SOC";
-    /*
-     * Reason: uses serial_hds in realize and the imx25 board does not
-     * support multiple CPUs
-     */
-    dc->user_creatable = false;
 }
 
 static const TypeInfo fsl_imx25_type_info = {
     .name = TYPE_FSL_IMX25,
-    .parent = TYPE_DEVICE,
+    .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(FslIMX25State),
     .instance_init = fsl_imx25_init,
     .class_init = fsl_imx25_class_init,
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 243c30a67e..6ce3e35ee3 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -72,7 +72,7 @@ static void imx25_pdk_init(MachineState *machine)
 
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_FSL_IMX25);
 
-    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     /* We need to initialize our memory */
     if (machine->ram_size > (FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_SIZE)) {
-- 
2.55.0


