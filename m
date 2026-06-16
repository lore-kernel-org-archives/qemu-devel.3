Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB9DCD98EE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZAX-0007Iu-RK; Tue, 16 Jun 2026 15:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8E-0004ZL-Ax
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:37 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ85-00011X-Ji
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:25 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-45ef1198766so125051f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636837; x=1782241637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=03cexD1Fz809DC5BukV1ykiIrCk3MZqLYcCjBMj80NM=;
 b=Iz2kt8p/kMhlvmYHmLuWu28z33JSlXop0hUh+ZfiqVj36I9FR6BBCk+DF21dg3xsJh
 WvVcJ9XC/QfcnyoH8AkEF2vIOL6bRKUsz3WeGSPqAGckwygsSqJOBcvAQ2bgfs4P76DY
 0YxJ+WlseH1lDJwvzEd12I6h1MO8GkvXC/Y9Ozh6FlgVeo+wY6nzXKK2irN0r7ONHVI8
 Utpb/2JvDJcyHK05WYxTZ0aRbR2x+O+nNtGis2SINsX1/j6qR77N9NEYyoKgTqxUvhoW
 9BgSKd9g7G5OY+NGZBbK43x1/I1U9N+bzzwP0bbm+culNHeHSipYgUOoBYIVHBoFHGCU
 7RNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636837; x=1782241637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=03cexD1Fz809DC5BukV1ykiIrCk3MZqLYcCjBMj80NM=;
 b=AHxsy60SG8Hq3M2PAZ8swH4gSYOn9mwY5+74mlJpbGit1Rvfy3V4d7EAOo13a/kZxL
 DxHLAKUce8MjRDElTCv+gGSQti3BRrRmsWQrZMY969+2zlckMtIu5nF5Ry2g13+ipyix
 6kicPlRaOim2q/rWZIW7jTHMBzmgAFYpItrg2gsDnj3tHYxEg46KCrr4IzHJuhs3IEhu
 j1G2T1XQNaqMbZxtQxpBHL68vtk/AwZRG5MbFK4hCB+vjCVJksEynADdGPugCl0cDMP2
 qbayp73a+zlL2leJSlgV9e7kG7AZeX4T6dYd0tTPKr0QM1+iM6ObYVMNCTWmdnSM5cUn
 gPNQ==
X-Gm-Message-State: AOJu0YyeQwOWHAFUjHiq4DqPC8gbkMsTnTc0OM/GZgzfPezR6xekuubO
 fmtWF8H2Nn/uuif+nfhI5U3IxfkWrS3AujvIOZ4+DOpQMl7O7Met2E1BndjEer4isn9x1oR7A3p
 ueffz
X-Gm-Gg: AfdE7cnvLlZ9yvjcLgnoC1gxsMCRiGfHfUxAY+yUtfiIynucCzMEgKGnrLSnwMQ3/q9
 XQKQYRjx9ri6COISPylWlwghKR1rOfWTAQV5Yx/DGaWoHrmsFi+/8tG5wlDmcmtO+k8vvmFXoYy
 C3HMDQ7913Bct1AQiIBdKAsQ8vf/sSxjheXWrZBEPb59TC6+/k7TkL0JwWN2PLT0TKvCMRpWMu9
 M9opQnY/fWRGuYWViEbfDEfEljuKpRIJGTGZaRgG1eGpssuLRWS6wb42yjw5gfaSGInXR9xt9iV
 6DsyPVoIaI11lGl0yvxau4xOCqvsLD3z5nkEAKTi/RbU5ZfLL06XGsdkwDacXS15pXTtpP5i57W
 rIlLHvdqRN2S6AjsdXXWIpcbkgCtUmwY9QZHZHGJF6rHXJM6QIUmAWyfJcEB5O7/6om2Edg3NHF
 Sag8bKVR1yLmxehe7mVURZRYY2NdyV1+78lv7rZMMa+uESscT5aadcdrP7xUEclOe19/1VIS6TU
 rR3hTRumezzxyaBviJ+Vn/RfDme88b9
X-Received: by 2002:a05:6000:2411:b0:461:a169:fdbd with SMTP id
 ffacd0b85a97d-46269aa5b38mr20688f8f.13.1781636836600; 
 Tue, 16 Jun 2026 12:07:16 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 31/61] hw/arm/tegra241-cmdqv: Use mmap'd host VINTF page0 for
 virtual VINTF page0
Date: Tue, 16 Jun 2026 20:06:08 +0100
Message-ID: <20260616190639.3462006-32-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Nicolin Chen <nicolinc@nvidia.com>

Install the mmap'd host VINTF page0 as a RAM-device MemoryRegion
backing the guest's virtual VINTF Page 0 aperture (guest MMIO offset
0x30000) when VINTF is enabled, and remove it on VINTF disable or
reset. This eliminates QEMU trapping for hot-path CONS/PROD index
updates via that aperture.

After this patch, the two VCMDQ Page 0 apertures use different
access paths: the direct aperture (0x10000) remains QEMU-trapped,
while the VINTF aperture (0x30000) is a guest-direct RAM mapping.

The direct aperture is intentionally kept trapped (not aliased to
the host VINTF mmap) so that writes to an unallocated VCMDQ remain
well-defined. The CMDQV architecture allows software to program a
VCMDQ through the direct aperture without first allocating it to a
VINTF; aliasing would route those writes to unallocated logical
slots in the VINTF page, where the hardware silently drops them.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260609112552.378999-22-skolothumtho@nvidia.com
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/tegra241-cmdqv.c | 37 +++++++++++++++++++++++++++++++++++++
 hw/arm/tegra241-cmdqv.h |  1 +
 2 files changed, 38 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 63fe0ac681..7264b4bfa9 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -26,6 +26,40 @@ static void tegra241_cmdqv_reset_vcmdq_cache(Tegra241CMDQV *cmdqv, int index)
     cmdqv->vcmdq_gerrorn[index] = 0;
 }
 
+static void tegra241_cmdqv_guest_unmap_vintf_page0(Tegra241CMDQV *cmdqv)
+{
+    if (!cmdqv->mr_vintf_page0) {
+        return;
+    }
+
+    memory_region_del_subregion(&cmdqv->mmio_cmdqv, cmdqv->mr_vintf_page0);
+    object_unparent(OBJECT(cmdqv->mr_vintf_page0));
+    g_free(cmdqv->mr_vintf_page0);
+    cmdqv->mr_vintf_page0 = NULL;
+}
+
+static void tegra241_cmdqv_guest_map_vintf_page0(Tegra241CMDQV *cmdqv)
+{
+    char *name;
+
+    if (cmdqv->mr_vintf_page0) {
+        return;
+    }
+
+    name = g_strdup_printf("%s vintf-page0",
+                           memory_region_name(&cmdqv->mmio_cmdqv));
+    cmdqv->mr_vintf_page0 = g_malloc0(sizeof(*cmdqv->mr_vintf_page0));
+    memory_region_init_ram_device_ptr(cmdqv->mr_vintf_page0,
+                                      memory_region_owner(&cmdqv->mmio_cmdqv),
+                                      name, VINTF_PAGE_SIZE,
+                                      cmdqv->vintf_page0);
+    memory_region_set_skip_iommu_map(cmdqv->mr_vintf_page0, true);
+    memory_region_add_subregion_overlap(&cmdqv->mmio_cmdqv,
+                                        CMDQV_VINTF_PAGE0_BASE,
+                                        cmdqv->mr_vintf_page0, 1);
+    g_free(name);
+}
+
 static void tegra241_cmdqv_free_vcmdq(Tegra241CMDQV *cmdqv, int index)
 {
     IOMMUFDViommu *viommu = cmdqv->s_accel->viommu;
@@ -430,7 +464,9 @@ static void tegra241_cmdqv_config_vintf_write(Tegra241CMDQV *cmdqv,
              * enabled need their hw_queue allocated now.
              */
             tegra241_cmdqv_setup_all_vcmdq(cmdqv, errp);
+            tegra241_cmdqv_guest_map_vintf_page0(cmdqv);
         } else {
+            tegra241_cmdqv_guest_unmap_vintf_page0(cmdqv);
             tegra241_cmdqv_free_all_vcmdq(cmdqv);
             cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
         }
@@ -772,6 +808,7 @@ static void tegra241_cmdqv_reset(SMMUv3State *s)
         return;
     }
 
+    tegra241_cmdqv_guest_unmap_vintf_page0(cmdqv);
     tegra241_cmdqv_free_all_vcmdq(cmdqv);
 }
 
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 84499b840d..01cd6af97d 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -49,6 +49,7 @@ typedef struct Tegra241CMDQV {
     IOMMUFDVeventq *veventq;
     IOMMUFDHWqueue *vcmdq[TEGRA241_CMDQV_MAX_CMDQ];
     void *vintf_page0;
+    MemoryRegion *mr_vintf_page0;
 
     /* CMDQ-V Config page register cache */
     uint32_t config;
-- 
2.43.0


