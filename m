Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F852D6B086
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUax-0001Cy-EJ; Thu, 29 Jan 2026 11:10:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUag-0000KJ-I1
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:55 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUad-0006el-5O
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:54 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43591b55727so1042778f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702985; x=1770307785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SXWhyW9afnvWJxgYgWEwCAWLC5peiCBqo1W4LCVPCMY=;
 b=mfy3crysTUTfScP/EQnW4IfVQmYNc5KoghUnp2ldzbVsXVY/t4GhUOVURr0Tt8SutM
 2H99gPWxm+XSBojNKYD4f4HWHxr+9ODhm3T7Tlfrsg27eoK1p1JhlD+o3zLzZgO0MU1H
 0NFnIFgwz1HjYNZSYB7UVEz7RDnhi2DTT2eKAPuIKn3V6MOjRSLrPChGMfEbNufesJ4C
 fJJPz51k5ZJsAqJuqf1IQlwYt+oRfV62rFVV7Oi7azIhWxT3Lc6uGu9zlZ7GZ72FvLDr
 vb4xjwvYu/ZzRhYD3olesHdubOSc2c4HPyhO0+ImFPu3lz2ku2HNkMC8RzZr9g9tfCvP
 i4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702985; x=1770307785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SXWhyW9afnvWJxgYgWEwCAWLC5peiCBqo1W4LCVPCMY=;
 b=et3wwQ9pn2i6eWz54pImbd0eGL25t+BjVvrzGl5sB/L+t2iqS8XWmWu/ML1vI2F9tj
 l++RDRdAdVvbngF7V6yk7Bra0prMTUjeEAu4irnzpBi46hfxDSklrncxhMk/11f0XB4D
 bG7eV03P71QXFgvboI4uEDuKiwczPoSPTBo52AJhQRPqliLuAnsUNoD/7Eb76q53c76t
 4/PaIm+AxRNvXNztAd6DIA+WsSqHvLzRdp92VQPQJgas0c6AXWoCYbVkJPZIa6Pk3poH
 3hfbdVR1bSlFpeQiRRERs9X3z2NUsxWy5dOyo21D7GGm6fr/L48SHwmKfM/B4cMB+faG
 36eQ==
X-Gm-Message-State: AOJu0YyTA/4Ul7LE+S6AZ/gVIl3GyF/kA7CfIZbzQOLWDyQs5eNdYdhp
 HgA6szJtz9q8EKvJNbDixVo6BkeMln0uz6TbYyQt4mOq3Z32I56TzJAjQGuLtuJfEmYQ96qu+0j
 06JVTgRg=
X-Gm-Gg: AZuq6aJAix+rJ/umRrG2o0PrY+kxH0eQjjCQxDensSS9regXv9UlL8yCkweI04z73el
 TkjTW3pXzgAuVZcZZzMBOxouo0Xl/hQ2fFkSq6a/Camv8+nT7yqViWQQSRMKzYEoei4nm64rEXl
 594HPmMmg8hshgNfCXKhhnjMf+/6Zx1qshpJn5LWeFeoT4wVthAqjqlAgA61Mv271zEjCx1CKzC
 2z0LCemgr94l/7Yar5As8AX89O4tbqW9yM22PqK1PypW/Mw73jAiQDI178LXMDJLcVvwOWjKr8k
 VCC5aTHrQhsOhMVSaRuC3Nfo5m5dq4fVCgwrGS24bFoKYsOw5MivNFu94HJ/mPIll1GjmHWPgd9
 ZnTO7g5vue03KC+JISYtCUq4NmuCBWh20mcnOjBpZNT3Xk/eZs8eSqqvuZbt0aVAktIWrN/lKP+
 3ClkSSYSurVU//RDiXu4N3oOETTNJuuQ==
X-Received: by 2002:a05:6000:24c3:b0:431:327:5dd4 with SMTP id
 ffacd0b85a97d-435f3ab000fmr128893f8f.46.1769702984642; 
 Thu, 29 Jan 2026 08:09:44 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/43] hw/arm/smmuv3-accel: Get host SMMUv3 hw info and validate
Date: Thu, 29 Jan 2026 16:08:55 +0000
Message-ID: <20260129160917.1415092-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Just before the device gets attached to the SMMUv3, make sure QEMU SMMUv3
features are compatible with the host SMMUv3.

Not all fields in the host SMMUv3 IDR registers are meaningful for userspace.
Only the following fields can be used:

  - IDR0: ST_LEVEL, TERM_MODEL, STALL_MODEL, TTENDIAN, CD2L, ASID16, TTF
  - IDR1: SIDSIZE, SSIDSIZE
  - IDR3: BBML, RIL
  - IDR5: VAX, GRAN64K, GRAN16K, GRAN4K

For now, the check is to make sure the features are in sync to enable
basic accelerated SMMUv3 support. AIDR is not checked, as hardware
implementations often provide a mix of architecture features regardless
of the revision reported in AIDR.

Note that SSIDSIZE check will be added later when support for PASID is
introduced.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260126104342.253965-22-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c | 101 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 89dc6f991c..33011962e3 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -27,6 +27,99 @@
 static MemoryRegion root, sysmem;
 static AddressSpace *shared_as_sysmem;
 
+static bool
+smmuv3_accel_check_hw_compatible(SMMUv3State *s,
+                                 struct iommu_hw_info_arm_smmuv3 *info,
+                                 Error **errp)
+{
+    /* QEMU SMMUv3 supports both linear and 2-level stream tables */
+    if (FIELD_EX32(info->idr[0], IDR0, STLEVEL) !=
+                FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {
+        error_setg(errp, "Host SMMUv3 Stream Table format mismatch "
+                   "(host STLEVEL=%u, QEMU STLEVEL=%u)",
+                   FIELD_EX32(info->idr[0], IDR0, STLEVEL),
+                   FIELD_EX32(s->idr[0], IDR0, STLEVEL));
+        return false;
+    }
+
+    /* QEMU SMMUv3 supports only little-endian translation table walks */
+    if (FIELD_EX32(info->idr[0], IDR0, TTENDIAN) >
+                FIELD_EX32(s->idr[0], IDR0, TTENDIAN)) {
+        error_setg(errp, "Host SMMUv3 doesn't support Little-endian "
+                   "translation table");
+        return false;
+    }
+
+    /* QEMU SMMUv3 supports only AArch64 translation table format */
+    if (FIELD_EX32(info->idr[0], IDR0, TTF) <
+                FIELD_EX32(s->idr[0], IDR0, TTF)) {
+        error_setg(errp, "Host SMMUv3 doesn't support AArch64 translation "
+                   "table format");
+        return false;
+    }
+
+    /* QEMU SMMUv3 supports SIDSIZE 16 */
+    if (FIELD_EX32(info->idr[1], IDR1, SIDSIZE) <
+                FIELD_EX32(s->idr[1], IDR1, SIDSIZE)) {
+        error_setg(errp, "Host SMMUv3 SIDSIZE not compatible "
+                   "(host=%u, QEMU=%u)",
+                   FIELD_EX32(info->idr[1], IDR1, SIDSIZE),
+                   FIELD_EX32(s->idr[1], IDR1, SIDSIZE));
+        return false;
+    }
+
+    /* QEMU SMMUv3 supports Range Invalidation by default */
+    if (FIELD_EX32(info->idr[3], IDR3, RIL) !=
+                FIELD_EX32(s->idr[3], IDR3, RIL)) {
+        error_setg(errp, "Host SMMUv3 doesn't support Range Invalidation");
+        return false;
+    }
+
+    /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
+    if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
+                FIELD_EX32(s->idr[5], IDR5, GRAN4K)) {
+        error_setg(errp, "Host SMMUv3 doesn't support 4K translation granule");
+        return false;
+    }
+    if (FIELD_EX32(info->idr[5], IDR5, GRAN16K) !=
+                FIELD_EX32(s->idr[5], IDR5, GRAN16K)) {
+        error_setg(errp, "Host SMMUv3 doesn't support 16K translation granule");
+        return false;
+    }
+    if (FIELD_EX32(info->idr[5], IDR5, GRAN64K) !=
+                FIELD_EX32(s->idr[5], IDR5, GRAN64K)) {
+        error_setg(errp, "Host SMMUv3 doesn't support 64K translation granule");
+        return false;
+    }
+
+    return true;
+}
+
+static bool
+smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
+                           Error **errp)
+{
+    struct iommu_hw_info_arm_smmuv3 info;
+    uint32_t data_type;
+    uint64_t caps;
+
+    if (!iommufd_backend_get_device_info(idev->iommufd, idev->devid, &data_type,
+                                         &info, sizeof(info), &caps, errp)) {
+        return false;
+    }
+
+    if (data_type != IOMMU_HW_INFO_TYPE_ARM_SMMUV3) {
+        error_setg(errp, "Wrong data type (%d) for Host SMMUv3 device info",
+                     data_type);
+        return false;
+    }
+
+    if (!smmuv3_accel_check_hw_compatible(s, &info, errp)) {
+        return false;
+    }
+    return true;
+}
+
 static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
                                                PCIBus *bus, int devfn)
 {
@@ -353,6 +446,14 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
         return true;
     }
 
+    /*
+     * Check the host SMMUv3 associated with the dev is compatible with the
+     * QEMU SMMUv3 accel.
+     */
+    if (!smmuv3_accel_hw_compatible(s, idev, errp)) {
+        return false;
+    }
+
     if (s->s_accel->viommu) {
         goto done;
     }
-- 
2.43.0


