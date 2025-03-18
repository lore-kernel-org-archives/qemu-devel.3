Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408D2C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 20:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tue0X-0007Ll-9J; Tue, 18 Mar 2025 16:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tue06-0007IJ-6P; Tue, 18 Mar 2025 16:57:27 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tue02-0005mB-Bv; Tue, 18 Mar 2025 16:57:24 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aaeec07b705so955983266b.2; 
 Tue, 18 Mar 2025 13:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742331439; x=1742936239; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ouCa+Eml7mMwIDg1RqIgQDV+HuA/gplHpdTZ+ngI3Vg=;
 b=ghnr/JWzwCPXy93ybnju7kGRVIqVDQT+o4hUv32d93nA3O5uM9V4BTmxrEcPQ73Ytk
 Jq+OZNfH/Drp2KsTsd0umaHIzlmQaJ9o+wS8Rm1jBrE3kylN3vKIIWsHnoqwOS0zgR8Q
 0rCEs8f78KvLbVnIkx9M6TIITH+S3vUe3fSIWZO68hmu69Zw6haKG6HfiyXSVtZvcuah
 Vf0zxMeLWivWT76rV17vfQZpAlfhj89m39EgUJKXXvIWrY0VFSTKH/og4ymZsc20oYtc
 BWo9hsdyHpAJxOFcDRgeIUffNxsEDczBsyx8+rxr9hNpJ4Fsn54FEk/rg1Btc95YiaYH
 unpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742331439; x=1742936239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ouCa+Eml7mMwIDg1RqIgQDV+HuA/gplHpdTZ+ngI3Vg=;
 b=XURCcsGhGNSug95ThfbH1HFscrM8VrUluPAxpSlGsmldc5DrWhYrzogd5cwb4opiss
 2AWGoW5Vo/hZjtlUNw/aCNTYr9uMpeGPhaMgvsFcqJvggl0OW8YYO2C2m7/eXujjBDgs
 iWVCC/xvRdHUOg4roWKEaZILzazT/9AdRUpEQMEk05p74DpjkGIBCfV2yziXgZGMDBr8
 vjnbTlLuAxFUYVyZcrids9S+IfTVX+0tWbUWr3yQslXPejEsjESJ5PjYQVsa3wOOOIRK
 eo7BCpEw3Q4aO+Xa41p8kp6x3+2X9CVlyz9YpOG1udR+7tWYiZO8ZT/v2wDo2k63RKtw
 +oGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo1PzkGi5aom56PUiRdPWNEFrtYfu+i6nWtaQFQiylUh8EvhI9J18Cqr+SUUSJ/o9hg7+gfxy4Sw==@nongnu.org
X-Gm-Message-State: AOJu0YxM8wMlHEuxAobAjL1Pvk5qLsG5dBG6HiXq+tFca61Oi83unShX
 gmCjdWQx7meegCUa+ibEEM0IOGVpGLwzTpypxSRs7zibiQy+IPNxZs+mTw==
X-Gm-Gg: ASbGncsjGE1CbKkeqRxK+MbYhy6PYxZz6dYRkdBMDlKEBSU41icWA7uwFQaVwHnP018
 hSW/gpQU4VCVX6HM96ogjFvW2GOtHdOucMSDVjgRqf6MdItnzARCEteR+u8nlz770kyWwQ9GzTK
 KInBgWiM2T4AlKUcqZER3RZmK5I6pF9PFrUGcCyPcR5lxTmmGJRI4nLM8pzhXu8ZGYlYO3Y8oKy
 Akv/ikD5ePhmuzSukOvV0SRkjq42KbTK1XDqY51oWR12Pe8LDUSsNEPVKg6eAneP8wjcQviM6SR
 ir8xwGm3KcCijaTMfwl5MYgMIva42P/kZpFI6QEUTrQ20eEIsM5WAmerfdnfCUW6wt9w4pcdRRq
 QPyGUlJ53ykdNl2Ek4aBUNcSrARwg9zVjtMm9gBhuMKjETkbG35qcCJA46AMwlNs=
X-Google-Smtp-Source: AGHT+IHHJCMpHtkudSP1FMVMOmf2M1JktsCFiPiU3Z1PtY1EDjDOQGsdsZgsC7P4cvlyBMhBv1rF/Q==
X-Received: by 2002:a17:907:96a8:b0:ac1:e1da:8744 with SMTP id
 a640c23a62f3a-ac3b7ed0692mr6405266b.38.1742331438895; 
 Tue, 18 Mar 2025 13:57:18 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-19c6-0d00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:19c6:d00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3146aed4fsm895944266b.26.2025.03.18.13.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 13:57:18 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/3] hw/arm/fsl-imx8mp: Derive struct FslImx8mpState from
 TYPE_SYS_BUS_DEVICE
Date: Tue, 18 Mar 2025 21:57:08 +0100
Message-ID: <20250318205709.28862-3-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250318205709.28862-1-shentey@gmail.com>
References: <20250318205709.28862-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
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

Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be reset upon machine
reset. It also makes the SoC implementation not user-creatable which can trigger
the following crash:

  $ ./qemu-system-aarch64  -M virt -device fsl-imx8mp
  **
  ERROR:../../devel/qemu/tcg/tcg.c:1006:tcg_register_thread: assertion failed:
  (n < tcg_max_ctxs)
  Bail out! ERROR:../../devel/qemu/tcg/tcg.c:1006:tcg_register_thread:
  assertion failed: (n < tcg_max_ctxs)
  Aborted (core dumped)

Fixes: a4eefc69b237 "hw/arm: Add i.MX 8M Plus EVK board"
Reported-by: Thomas Huth <thuth@redhat.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/arm/fsl-imx8mp.h | 3 ++-
 hw/arm/fsl-imx8mp.c         | 2 +-
 hw/arm/imx8mp-evk.c         | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index bc97fc416e..22fdc0d67c 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -26,6 +26,7 @@
 #include "hw/timer/imx_gpt.h"
 #include "hw/usb/hcd-dwc3.h"
 #include "hw/watchdog/wdt_imx2.h"
+#include "hw/sysbus.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
@@ -49,7 +50,7 @@ enum FslImx8mpConfiguration {
 };
 
 struct FslImx8mpState {
-    DeviceState    parent_obj;
+    SysBusDevice   parent_obj;
 
     ARMCPU             cpu[FSL_IMX8MP_NUM_CPUS];
     GICv3State         gic;
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index c3f6da6322..82edf61082 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -702,7 +702,7 @@ static void fsl_imx8mp_class_init(ObjectClass *oc, void *data)
 static const TypeInfo fsl_imx8mp_types[] = {
     {
         .name = TYPE_FSL_IMX8MP,
-        .parent = TYPE_DEVICE,
+        .parent = TYPE_SYS_BUS_DEVICE,
         .instance_size = sizeof(FslImx8mpState),
         .instance_init = fsl_imx8mp_init,
         .class_init = fsl_imx8mp_class_init,
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index e1a21e52f9..f17d5db466 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -37,7 +37,7 @@ static void imx8mp_evk_init(MachineState *machine)
     s = FSL_IMX8MP(object_new(TYPE_FSL_IMX8MP));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
     object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fatal);
-    qdev_realize_and_unref(DEVICE(s), NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX8MP_RAM_START,
                                 machine->ram);
-- 
2.49.0


