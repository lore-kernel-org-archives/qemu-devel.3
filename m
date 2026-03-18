Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BBC103E162
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 10:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2oQm-0003ay-S2; Wed, 18 Mar 2026 06:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w2oQg-0003XS-S1
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:47:13 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1w2oQf-0003Mq-9r
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 06:47:10 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso7392415e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 03:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773830827; x=1774435627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RXbm6LZc46i8z/YUVSg+0qi3TRX5Dk3YHcYXiwqEKZc=;
 b=aRWPH/SL1bZzMeqyPSW4wr70fLn6HSOw82IstzcKCR5whYnieMiMZgTOqBRaECbgB4
 JuWP1+u2ldiVUPwG8eN6v3Vl+GpI+vsqE7CerEEcno2NglDtnN0qMMdp+Mto6GTnRomI
 cd/kv/PjwQdLQa6iBrNUjOX/pS9fDGY7azZXXUX4y9RaW7iUtvqepknecLln4z28kvFt
 NdzFzXG1YFh5tAm7AgI/6NHmKE9os7scGCrQ2fFdFp9oe3z12PW7YRd9bdD+kOLHlfag
 +mRFqsbImRvjDnhSNlojqoDAmlKiSp1e5aRyFVrRM5Zq5vwZ6ThYghhmujUFl09kTo9W
 FLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773830827; x=1774435627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RXbm6LZc46i8z/YUVSg+0qi3TRX5Dk3YHcYXiwqEKZc=;
 b=ml0pEW5oj0qBx9zy4/xkzAAwitzXypABU6QsLJXY6zrXRClP0J351QPqHee3BDNq8K
 bXOueJDFaC6WSGzXw/b8xjnVi7CeTg8CNMoBTtBydtg1YukkuGNj7PwcUjqB2pXUlLzm
 IwATLXUqxxK2m/B91Gji6HZUejWQCufSB3qDNB8IAUsvmjDiyJLipdp8d5gfPOB3n85x
 nCIcyfSZyXmxlpoB4RnRT1asD4GUUbCOwhYSQI73xo4tl3UDhQkOMqeZxt42ZtmZxW6b
 MPs6tGlFMYUXQsPYnj9RuahzqCQMDpe5ZQtAZPjnS0/5lOgLz5QBfrLK2pvnez95YxkF
 7uHA==
X-Gm-Message-State: AOJu0Yw76RSLqZA09k6lhQ5Sj1FJeUIqvmAhzQs/SNYwcEqylWvzT2ad
 eU69TJuphVokLxF26FR6KFWjEdxRShqIm16rcvSbGsXDSUyeTy3+ekSEQTBJn0gd
X-Gm-Gg: ATEYQzzM8vivtw1WaIfV11W//pnmfQ4nZ4q2FotspG5JcY871aUaVdYAduYY/51E3E2
 CTBkvh/pKw93g9/5+v89cMzHLs+rsOAp4f/nDTkZgkOrDFcj7tC8dMt/p+kRd591SD6vpz7sc6V
 ZYPnLgkG6IrXfpPHPLM2tvlLyvr8kFDa65wDbeh2YErYyNEr0DVTwOq8mI/7y4G3ql/opV8BeKV
 yc2lbT36hgRSt8QNJN2ZaRTsgaMPyJek0whlbbTAHc8v/APaIO9KtYaV3q0ucRgGO80M2Ltbh1I
 Cx4n8iZ30O3Xbz7A6tNhXOvNm68hvJUGFnffOcwdgotWWb0x9SPIOk6jLQbO2XSTCeby2Oqz1d5
 cN5JgvKnvC9V26M3+xGK+pzLAR0FTg0VR3HQvWCOdmEDujPGQy5sh6Hc26zhl3XbBWNEZaGuDdy
 5r6oXiaymHUUE1I4WeHj3ny2t73HRg6bz5wWsxyinrBXVt76+U5AxbJzb/aDyzk4rMEz1QxUio6
 Xne
X-Received: by 2002:a05:600c:314c:b0:485:3989:b3e4 with SMTP id
 5b1f17b1804b1-486f40ab752mr45145435e9.6.1773830827346; 
 Wed, 18 Mar 2026 03:47:07 -0700 (PDT)
Received: from thinkpad-t470s.. (93-143-80-194.adsl.net.t-com.hr.
 [93.143.80.194]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-486f420de8asm56471095e9.3.2026.03.18.03.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 03:47:06 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 alex.bennee@linaro.org, peter.maydell@linaro.org,
 pierrick.bouvier@linaro.org, philmd@linaro.org, Ruslan_Ruslichenko@epam.com
Subject: [RFC PATCH 7/9] hw/arm/smmuv3: Add plugin fault handler for CMDQ
 errors
Date: Wed, 18 Mar 2026 11:46:38 +0100
Message-ID: <20260318104640.239752-8-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318104640.239752-1-ruslichenko.r@gmail.com>
References: <20260318104640.239752-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x32e.google.com
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Register custom 'smmu_gerror_cmdq' handler within plugin subsystem.

This enables external plugins to dynamically inject Command Queue
errors and trigger GERROR interrupts.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/arm/smmuv3.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index c08d58c579..e80b80e843 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -27,6 +27,8 @@
 #include "hw/pci/pci.h"
 #include "cpu.h"
 #include "exec/target_page.h"
+#include "qemu/plugin.h"
+#include "qom/object.h"
 #include "trace.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
@@ -42,6 +44,55 @@
                                         ((ptw_info).stage == SMMU_STAGE_2 && \
                                         (cfg)->s2cfg.record_faults))
 
+static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
+                               uint32_t gerror_mask);
+
+typedef struct {
+    uint64_t base_addr;
+    Object *found_obj;
+} SMMUSearchArgs;
+
+static int smmu_match_addr_cb(Object *obj, void *opaque)
+{
+    SMMUSearchArgs *args = (SMMUSearchArgs *)opaque;
+
+    if (object_dynamic_cast(obj, TYPE_ARM_SMMUV3)) {
+        SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
+
+        if (sbd->mmio[0].addr == args->base_addr) {
+            args->found_obj = obj;
+            return 1;
+        }
+    }
+
+    return 0;
+}
+
+static void smmu_inject_gerror_cmdq(void *target_data, void *fault_data)
+{
+    uint64_t base_address = *(uint64_t *)target_data;
+    SMMUCmdError cmd_error = *(SMMUCmdError*)fault_data;
+    Object *obj = NULL;
+
+    if (base_address) {
+        SMMUSearchArgs args = { .base_addr = base_address, .found_obj = NULL };
+        object_child_foreach_recursive(object_get_root(), smmu_match_addr_cb, &args);
+
+        obj = args.found_obj;
+    } else {
+        obj = object_resolve_path_type("", TYPE_ARM_SMMUV3, NULL);
+    }
+
+    if (!obj) {
+        return;
+    }
+
+    SMMUv3State *s = ARM_SMMUV3(obj);
+
+    smmu_write_cmdq_err(s, cmd_error);
+    smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_CMDQ_ERR_MASK);
+}
+
 /**
  * smmuv3_trigger_irq - pulse @irq if enabled and update
  * GERROR register in case of GERROR interrupt
@@ -2130,6 +2181,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
     dc->hotpluggable = false;
     dc->user_creatable = true;
 
+    plugin_register_custom_fault("smmu_gerror_cmdq",
+                              smmu_inject_gerror_cmdq);
+
     object_class_property_set_description(klass, "accel",
         "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
         "configured in nested mode for vfio-pci dev assignment");
-- 
2.43.0


