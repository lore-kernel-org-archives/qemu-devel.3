Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39088CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMsT-0007xd-3x; Wed, 07 Oct 2026 04:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEHM1-0003V6-IB
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:26:15 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEHLs-0008Kj-KA
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:25:58 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6acb57c2b88so4929711a12.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 19:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791339822; x=1791944622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wmm7DGZqm4QJ3LuHhxoQfymIpreglajXFKpx721XcyM=;
 b=D3LMc3TvlNoKsF+5Z4IEUHav7Nme4djBoUB3Yhi6Hub41rgLeuX9AsPoevjy+oyWE0
 FXi2B8w1t/jbu4cmTIWxlW2/NRd+NeXV6U4VEybCEVHeANxkRHL5lO3FyrhtUWbcUWpU
 0eACji6o8oKOPGmvQAQ4y7il9Nx/HlFUz+sYaoGFHILJjUkMNcveqrX8bc5G289uGRFK
 e4SmOGNfLkv2WiGUDFtKfOcDvix5NG6+NvAxH0wWBS/xxOJ5iDWcqaI3N9UStRbNPpRs
 3Y6G0kHJtIhEswCBGosALRcRiLa6NFD6BQqx0x2+0i+K3MCRcZa7XkIcr65qPnjakFnO
 dlhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791339822; x=1791944622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wmm7DGZqm4QJ3LuHhxoQfymIpreglajXFKpx721XcyM=;
 b=sq14Nta652A8w6lkq2kc3JBLhtcZYlk4Ye7Ds7hbSiwmePnwxte/wnj3AHSCYNBqhs
 IHMqxeUQfIElw5rWUBWeoQWxFm9KMyGhcxeHcGwVaAJvz+IYT27gc6UAdD7QdQ0h264D
 OunNBSYikjSS0dWSJWO1a9EuaEpmZIN3IaHFvbpbzNb9whuXInEkP73DOHDPl8PUTsnD
 9MinioIvj+dyYkcJXMDuZKcldTHdVmFtYlfMKArwpNV0gDp71+MFWDSvUqKHOss9Y35z
 2rTWGn1uHNOfhyC9EnObjHZM/V3y5mKQzdpZLfwqgjFZ6KNcECcQaeBxFGygltLZYpa0
 61HQ==
X-Gm-Message-State: AFq9FYJP4O8LYjY4GAsmY2tQ1GkcSdGYXDGhiFcUU6tJMP0dEMSwPHT+
 j/3noaRbJp4k0eDxV+rbHD1469T8bD7qJ7D0TpCaU0/oZnDYlTsHnSI2nTjQXQ==
X-Gm-Gg: AYBFou25mj87AVA6D48EJh7B9KtcId18D6oGKnuB01URURxb5pRgg/9lTALQBJWrrYr
 LXG9UQ+7gL3GoRqpGErZihUOiUMSNQOtmp/pZ65h+H0WICIxHwF9NgiQ0TvYackxMZZ7rL3Nc/y
 Lm3VtfHdq3Crh7lobQudYvWUbWDJEEQOlKcG6i9D41lJca8vlFGrdZ5mtJpuz+zgB4n6vpeJq5c
 TSRvWsIY/bzpCwVVhx688EBsn0iqjpeh98mlziCEou5nXCgVvW5Lkacy2z/2kpHuoVNkucqO9vW
 AsEvqWybIWWVW7lREGcL/BDPdp6ndKAWANqwdI+uf6rKstqI6D09sB52f38SnYgwVT6PHCrB7H9
 0Djbp2rFv6EgYsVSrt9TnegwP9gBYKPAK9YuOdZq0nNWAXt/FByPC+6mvjNK/cw+0/MK73Tuo70
 5ve0w2G+BkehScRqPrYUFIwQtXFLRFhwHFQ8y2hrjPHRimi5DfdBIz1I36RM1P/3qA5xAwE3gyr
 4WXiFn4JA2Ce6ftYBon3YGDWbCluIx45RPWbg==
X-Received: by 2002:a5d:64e6:0:b0:48b:26c:8cc with SMTP id
 ffacd0b85a97d-48c47fd9eefmr18069961f8f.27.1791275739080; 
 Tue, 06 Oct 2026 01:35:39 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:38 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 16/31] hw/arm/fsl-imx7: Derive from TYPE_SYS_BUS_DEVICE
Date: Tue,  6 Oct 2026 10:34:28 +0200
Message-ID: <20261006083445.30362-17-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/arm/fsl-imx7.h | 5 ++---
 hw/arm/fsl-imx7.c         | 5 +----
 hw/arm/mcimx7d-sabre.c    | 2 +-
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/hw/arm/fsl-imx7.h b/include/hw/arm/fsl-imx7.h
index a573e0dd4f..945d8c5ad7 100644
--- a/include/hw/arm/fsl-imx7.h
+++ b/include/hw/arm/fsl-imx7.h
@@ -37,6 +37,7 @@
 #include "hw/pci-host/designware.h"
 #include "hw/usb/chipidea.h"
 #include "hw/core/or-irq.h"
+#include "hw/core/sysbus.h"
 #include "target/arm/cpu.h"
 #include "qom/object.h"
 #include "qemu/units.h"
@@ -64,10 +65,8 @@ enum FslIMX7Configuration {
 };
 
 struct FslIMX7State {
-    /*< private >*/
-    DeviceState    parent_obj;
+    SysBusDevice   parent_obj;
 
-    /*< public >*/
     ARMCPU             cpu[FSL_IMX7_NUM_CPUS];
     A15MPPrivState     a7mpcore;
     IMXGPTState        gpt[FSL_IMX7_NUM_GPTS];
diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
index 2defa498d3..fc5d0efe06 100644
--- a/hw/arm/fsl-imx7.c
+++ b/hw/arm/fsl-imx7.c
@@ -753,15 +753,12 @@ static void fsl_imx7_class_init(ObjectClass *oc, const void *data)
 
     device_class_set_props(dc, fsl_imx7_properties);
     dc->realize = fsl_imx7_realize;
-
-    /* Reason: Uses serial_hds and nd_table in realize() directly */
-    dc->user_creatable = false;
     dc->desc = "i.MX7 SOC";
 }
 
 static const TypeInfo fsl_imx7_type_info = {
     .name = TYPE_FSL_IMX7,
-    .parent = TYPE_DEVICE,
+    .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(FslIMX7State),
     .instance_init = fsl_imx7_init,
     .class_init = fsl_imx7_class_init,
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 47744e66a4..55c23061b0 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -52,7 +52,7 @@ static void mcimx7d_sabre_init(MachineState *machine)
     object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
     object_property_set_bool(OBJECT(s), "fec2-phy-connected", false,
                              &error_fatal);
-    qdev_realize(DEVICE(s), NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX7_MMDC_ADDR,
                                 machine->ram);
-- 
2.56.0


