Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB8CCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:17:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZAc-0007mx-9s; Tue, 16 Jun 2026 15:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8Y-0004ja-18
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:52 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8T-000130-OE
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:49 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-4624c1409c9so80163f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636843; x=1782241643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KEUPHZb5YuT1h0BGZ3M+7qfyPu+oA13cs/eRBK1qjto=;
 b=dgXWkuV/avch0Ovrr8shPMUxLQzkAzKFrL2cdkT6fT00ct77Zd7KW9kWF4tDgQ9HSW
 E7FoSXaOYMZ3jIIdw/AHZ0ixt5ll0/S91I/b++f5Lwj3wKzUSlj/MmSyxTz5SJKCDoZK
 rela/VRDr+fstOSPNmxwodgDSRC7RlmVQiU+tMz3EXtcND0uI3nq3cm+NJGjAh31CNV+
 bzy2/6+zMo5C7hW3PU2Kpjl3b+YQBngxM2+npCskAyePPFjYG1NG72eXvOLCB+LGU8hr
 SxxFPkVQAJR4oMnnuJljdudv5UUqQBWfYHPszEvHY09imMZ3z0N0Dk/5P7YcEuU0fctk
 JFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636843; x=1782241643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KEUPHZb5YuT1h0BGZ3M+7qfyPu+oA13cs/eRBK1qjto=;
 b=tOBZbWuc1cD6rfuvqHX4HUipioJKeIxsaut3ZtmAohiz1p4mKK+u3SDTa1/0a6usL4
 fATYcQnSnqJNNugBf+r0X92siYla8K/CPruCKUZoDun0K98naG+JNkhy2tlphoK3HaNn
 RPtDBPcXWgpDrmutBEQlA5RTBAX3iBv1X+adqFTkxV5ib18aPaR8aQs9+FlkuMITZY+S
 71MDCaZZVcay94HLdM0Aph7GSoqPeRsKaby2XIOIWVHqDj4wRzTQdmo2zWmodZ/zTnkj
 u1tNoKgV1TS+ZVEXc+4G6j1fZxoClZEkog3LLO3hg5RJ5D6keMmfHYek6f56qQYKDw1g
 jsrg==
X-Gm-Message-State: AOJu0Yy4v/8uwzuVWTvmoRR/j42io9New0KKamsEcwR7zK0U/f80pubq
 q78c3id7vxXziXJKX3NFIqpXHh2kAXv14/fH16xo88QaZp0kjvbqrCkYIgcvCE92MPJd7AMGDoM
 KUVBZ
X-Gm-Gg: Acq92OHOvzd/wtff+xrGi84AUYCO5JW29kUd5fO1dwwqkCXMg93CD9jk1l/KHX0fKMe
 OGu24/DKlfDRTkgylp47/7eZgnFKFRSioz/XtqJiuOPR52j4tflxcjQs9mECFRyZzA1w/782dpp
 GCah/3GiG1WYBF6vZKRApQlzZfBGQng9HOdTwNAvZcN95lhoZunKqY2yt3BsDfZerqUq6sEHG9E
 9FQVw9AIwBAX26QwxBzASf5itxb2UjoVMSfmppktEyLEMcGOdxbuNTF4ZGNzSZE7kdEFdKc8BKX
 B6EQDQ6SMJA1wdfgymLvNJXRQ1zfkFOc0hShp4nWLucBkOzss1WJgr1VjhIrho+Ozi3BwjfW+P7
 90ZmrxTZYv/3vUtm7fuC4La16MeCj9fS0pfryYedvK0MRHetCEYEFEoqti3ZH0qAUcJfrb1WGW9
 BVWVDLWUIZY/jb3ePjINvUQxaGnH2RvtnWwlORniQvDNXq7Vvww3usHevsLTtfK8KxlTMJsjquP
 KoXaXgY3uweDIwX2Om7q/v8mVvwr5bcJQ8zw+iDyCs=
X-Received: by 2002:a05:6000:1204:b0:45e:fa7b:a7d2 with SMTP id
 ffacd0b85a97d-46235caf3e4mr1023486f8f.7.1781636843170; 
 Tue, 16 Jun 2026 12:07:23 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/61] hw/arm/smmuv3-accel: Introduce helper to query CMDQV type
Date: Tue, 16 Jun 2026 20:06:14 +0100
Message-ID: <20260616190639.3462006-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

Introduce a SMMUv3AccelCmdqvType enum and a helper to query the
CMDQV implementation type associated with an accelerated SMMUv3
instance.

A subsequent patch will use this helper when generating the
Tegra241 CMDQV DSDT.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260609112552.378999-28-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel-stubs.c |  5 +++++
 hw/arm/smmuv3-accel.c       | 12 ++++++++++++
 hw/arm/smmuv3-accel.h       | 10 ++++++++++
 hw/arm/tegra241-cmdqv.c     |  6 ++++++
 4 files changed, 33 insertions(+)

diff --git a/hw/arm/smmuv3-accel-stubs.c b/hw/arm/smmuv3-accel-stubs.c
index 9e6c44a282..147ae06163 100644
--- a/hw/arm/smmuv3-accel-stubs.c
+++ b/hw/arm/smmuv3-accel-stubs.c
@@ -57,3 +57,8 @@ bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
 void smmuv3_accel_reset(SMMUv3State *s)
 {
 }
+
+SMMUv3AccelCmdqvType smmuv3_accel_cmdqv_type(Object *obj)
+{
+    return SMMUV3_CMDQV_NONE;
+}
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index c1c2a67c97..9c3bd4413d 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -1060,6 +1060,18 @@ static void smmuv3_accel_as_init(SMMUv3State *s)
     address_space_init(shared_as_sysmem, &root, "smmuv3-accel-as-sysmem");
 }
 
+SMMUv3AccelCmdqvType smmuv3_accel_cmdqv_type(Object *obj)
+{
+    SMMUv3State *s = ARM_SMMUV3(obj);
+    SMMUv3AccelState *accel = s->s_accel;
+
+    if (!accel || !accel->cmdqv_ops || !accel->cmdqv_ops->get_type) {
+        return SMMUV3_CMDQV_NONE;
+    }
+
+    return accel->cmdqv_ops->get_type();
+}
+
 static void smmuv3_accel_machine_done(Notifier *notifier, void *data)
 {
     SMMUv3State *s = container_of(notifier, SMMUv3State, machine_done);
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index 8d0f636338..5fc85fb89d 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -16,6 +16,11 @@
 #include <linux/iommufd.h>
 #endif
 
+typedef enum SMMUv3AccelCmdqvType {
+    SMMUV3_CMDQV_NONE = 0,
+    SMMUV3_CMDQV_TEGRA241,
+} SMMUv3AccelCmdqvType;
+
 /*
  * CMDQ-Virtualization (CMDQV) hardware support, extends the SMMUv3 to
  * support multiple VCMDQs with virtualization capabilities.
@@ -42,6 +47,10 @@ typedef struct SMMUv3AccelCmdqvOps {
      * If NULL, the viommu_id is freed directly via iommufd_backend_free_id().
      */
     void (*free_viommu)(SMMUv3State *s);
+    /**
+     * @get_type: Optional callback. Return the CMDQV implementation type.
+     */
+    SMMUv3AccelCmdqvType (*get_type)(void);
     /**
      * @reset: Optional callback. Reset CMDQV state.
      */
@@ -90,5 +99,6 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
 bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
                                       void *buf, size_t size, Error **errp);
 void smmuv3_accel_reset(SMMUv3State *s);
+SMMUv3AccelCmdqvType smmuv3_accel_cmdqv_type(Object *obj);
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 4b8f8b15c7..d821eafca1 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -964,6 +964,11 @@ static bool tegra241_cmdqv_init(SMMUv3State *s, Error **errp)
     return true;
 }
 
+static SMMUv3AccelCmdqvType tegra241_cmdqv_get_type(void)
+{
+    return SMMUV3_CMDQV_TEGRA241;
+}
+
 static bool tegra241_cmdqv_probe(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
                                  Error **errp)
 {
@@ -1004,6 +1009,7 @@ static const SMMUv3AccelCmdqvOps tegra241_cmdqv_ops = {
     .init = tegra241_cmdqv_init,
     .alloc_viommu = tegra241_cmdqv_alloc_viommu,
     .free_viommu = tegra241_cmdqv_free_viommu,
+    .get_type = tegra241_cmdqv_get_type,
     .reset = tegra241_cmdqv_reset,
 };
 
-- 
2.43.0


