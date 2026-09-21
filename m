Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F54CC982FC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lrn-0006Lg-PN; Mon, 21 Sep 2026 17:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrj-0006Gk-9K
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:47:59 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrh-0000Hm-Gr
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:47:58 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912e64ccso25345345e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027266; x=1790632066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9Wbz4ZGk1ZRJg8frLDAcIdnA3seasqKtMV8wqIkAtHw=;
 b=tHZetRht2/z9ovL9iWG47rzE4g5kvsN32y0wGgIvoI1ALHLFnk8x7yYPmrhMO4NKNx
 SOH2lDAB234hgoPfS4+MADiXdxUsOzK2Pm9QByPrjJpqXWXsf0ukzCyWmtSE6sctmPAp
 LMO/qY1wO+dY6LHCXMgR4CVfhvkhuqvIRusq3U2LCw7qGU+HZAy6eqhp0yfGgkZ1qsEK
 M8/RQqNdSHgqW187WCN2f1ywILP1YTDM0jOPutUD3iHvcDqZI3FPjCyreJizCx8/yDgW
 VAL+G26AN5Mrps+LO0mt8aN0g967IRF8Zzmdb2myU+Vd/7JxzYoknx96BBNo4OD81+H8
 eBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027266; x=1790632066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9Wbz4ZGk1ZRJg8frLDAcIdnA3seasqKtMV8wqIkAtHw=;
 b=wnMDELpejT0udLBZRieQZrqDL9kBDcuVQu/ASuanG7fQJh/5RRPnYHq1ueQB8+wg6T
 O89adtQtn2vlIG35yESj6Fi292LKM877v0r+MxfB7RKQ2jutvtSPWCvmIxkcr67mXGIZ
 agOWvNfGB/pd+sArH6Udu9jqHF6/A8KUvQ+vHVMDADS5NcFumBZCkm7QVJto3LriV9bs
 OLagmfvIPhlpKTSwQY9xfd8hA07PfswJE7KN2ejswHusP+ZHoazExWdtlsJ6PPRKCJdi
 BfyEGlzjtDs4Q+xYBlAitMhA6X6912nynVAOCYQd4uugO8xjEzM1ufJumDHkeR17EX2F
 OhwQ==
X-Gm-Message-State: AFuF++l2t/K9EvcSoBjs+t6NvL60Bq1CdHWD8VcptzXAwc6EiRbr7iWD
 6D2wx4n4qI5FzEAUSsNCa0ASDb35XH2WBY86IV6I85gNzYQa3G7NrehFKiXg8w==
X-Gm-Gg: AYBFou2q6FSAHz/B8pJyK83BQ71XSOTfIobV7FUZI1JKTZ6p1oQyuu06PdILc+tOiyc
 LZzDrOuJ+fIndLMZbueXL1Twuymh5VoJQtJxFkic+GMnccHoQXapjBIP5VMJ3H7sut4xye8hu/y
 BfLFx/opVlDhhEgwPlSRjIhInDlWYiVvfLoUHzr0TRIap7AmO6YBgNHJXoZjcmc8ISrNiMT/o/C
 mwMKpfbpovK0zFiJMjIB5drT2u5rDEF+KRBTOUaflGOvZBV7IyroIZbIkZ6J7PWAzGxBk0axeZw
 DW1tJ8CItPSG1jLyZ2PQOofKus/CvxrsXqdxBlHne2uEmZpFCPEE7QdWmu6QkbnK/rBbeOhk2Za
 hlUjkjE8pyIhKHcoNH0QhAkSw4C27ZRYyBRVRcOD1TVq17hQsgRpJ+luIOkxr5/Hnj0q2D9B7TL
 ZkmtfLz363EhMFb7j3KXBzSVWC3Pqf33rpEFb5muOSGm4YhUaXEigZw8jgv+dPZH0hGgP7kY+NQ
 Eq97d03AeYSfIKTz7TtyyILO9gdnmrXwozC3muVaQ8p7yIJ93PyqsnWGt6sf+3Z03KoRYL3bRP9
 Vyc5HG0nPbLa9A==
X-Received: by 2002:a05:600c:3b0a:b0:49f:bd3c:bc20 with SMTP id
 5b1f17b1804b1-49fc573b7a2mr155976375e9.27.1790027266060; 
 Mon, 21 Sep 2026 14:47:46 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:47:45 -0700 (PDT)
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
Subject: [PATCH 14/42] hw/arm/fsl-imx6ul: Derive from TYPE_SYS_BUS_DEVICE
Date: Mon, 21 Sep 2026 23:46:42 +0200
Message-ID: <20260921214710.29422-15-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 include/hw/arm/fsl-imx6ul.h | 5 ++---
 hw/arm/fsl-imx6ul.c         | 4 +---
 hw/arm/mcimx6ul-evk.c       | 2 +-
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 6205fe6b77..9ae0488990 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -18,6 +18,7 @@
 #define FSL_IMX6UL_H
 
 #include "hw/cpu/a15mpcore.h"
+#include "hw/core/sysbus.h"
 #include "hw/misc/imx6ul_ccm.h"
 #include "hw/misc/imx6_src.h"
 #include "hw/misc/imx7_snvs.h"
@@ -64,10 +65,8 @@ enum FslIMX6ULConfiguration {
 };
 
 struct FslIMX6ULState {
-    /*< private >*/
-    DeviceState    parent_obj;
+    SysBusDevice   parent_obj;
 
-    /*< public >*/
     ARMCPU             cpu;
     A15MPPrivState     a7mpcore;
     IMXGPTState        gpt[FSL_IMX6UL_NUM_GPTS];
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 1863558a0d..84451c9909 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -730,13 +730,11 @@ static void fsl_imx6ul_class_init(ObjectClass *oc, const void *data)
     device_class_set_props(dc, fsl_imx6ul_properties);
     dc->realize = fsl_imx6ul_realize;
     dc->desc = "i.MX6UL SOC";
-    /* Reason: Uses serial_hds and nd_table in realize() directly */
-    dc->user_creatable = false;
 }
 
 static const TypeInfo fsl_imx6ul_type_info = {
     .name = TYPE_FSL_IMX6UL,
-    .parent = TYPE_DEVICE,
+    .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(FslIMX6ULState),
     .instance_init = fsl_imx6ul_init,
     .class_init = fsl_imx6ul_class_init,
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 4964cb9345..53d221b4a9 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -44,7 +44,7 @@ static void mcimx6ul_evk_init(MachineState *machine)
     object_property_set_uint(OBJECT(s), "fec2-phy-num", 1, &error_fatal);
     object_property_set_bool(OBJECT(s), "fec1-phy-connected", false,
                              &error_fatal);
-    qdev_realize(DEVICE(s), NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX6UL_MMDC_ADDR,
                                 machine->ram);
-- 
2.55.0


