Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B570C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 23:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNKEM-0000Mb-Vm; Thu, 05 Jun 2025 19:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uNKEL-0000ME-8Y
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 19:42:41 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uNKEJ-0004gY-9I
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 19:42:40 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7481600130eso1766529b3a.3
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 16:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749166958; x=1749771758; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UIY+I0zgj1+4vetHwZshTaoH/o7+9GIbx0lfx7tbbpA=;
 b=V5E9kFyFFQAdfNrb1vOji8INd0PREdeMh3nVbBodixYgm5Vw0mZsgZ1dZtW7T9Vxrv
 2UOJb3TcFkLGakiIShO2EQn2P8rfTKbXrFcL3cZGEfh4XVEhbPAH8ikIzwB5CV0y/Ztd
 zJ48H+Gc7XIMvm273hK0kHejA/W2SbGVcFovMDho7EIbPZ3Bnl0uFDxps55rSrkZlzg4
 U46gZ3Cci5lfRMrt/Ut4+qn367Ls7bsCzIkLSHz9J7v1cZVubBNAdbZE9UlzxSoRy2AZ
 hssOSf6EgRhKiRzVc6gmzIpvv3eti+3N2EXmAbQvmY9r1arwZkCCtt77LKFb/Yc7oSVV
 saHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749166958; x=1749771758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UIY+I0zgj1+4vetHwZshTaoH/o7+9GIbx0lfx7tbbpA=;
 b=iBg6e8r80DsgKhCznfHULLaGpAohzqanKqz0aEXkZ/pE0TDerEs9M92/V7v1XUFs9I
 IDfNfnwTxs2cOMQrPJ8X/pGtK7d2H8ce4sHDE7dEzgOAnGD8q5/LfzhrIktMl30MQx9m
 DgAYuSTD0O6PHQTbkXN+VVCnxiDfBQaTXmfm3mvnuDSzgwLv1F6l648BrnlNufKIvIi5
 XlFHUK485scMgQy0SAEP6tTgiheBGqEnNALW6WaGRrcLre+Fs1SulHzGdVDFPGhELqEv
 KHILUrUzkNIQmU7mD6ip4Bga8BzcTMvEB9D5zMv9VRyKpNVTacanD/+Vj5Q5GkNtk8x9
 jO3g==
X-Gm-Message-State: AOJu0YwxcUyumQxOubzSHh9hgl2YL03ZOgUGVFYoUtqzeEwyd3Z1l1OV
 UrCy8PWkpqpUBcMLgfYTrhCYKswaKE0Gph/9D5Hlub473d3/8zn6PcntPmQQ2Q==
X-Gm-Gg: ASbGncsGAxqn5CcOI5mSRwTrfkS3MZ3Pcku/xHCsEiaiF8QVIIBjJg9dJ51QfYgO95C
 HResslcxiK+5MzgqTuphtvh627dqgLBWSrGofZ9jk8213dZCU+SlsZx78fpe987uW4rdFskJr5t
 tKm0Znbe1sDQdyN+7FEyNsRHpUxmDUuD+h96Z5+cUavsXhrgmdlX6lTX+fGBXy22xXj82e/m4vU
 QQeIV+YM+8AHkEN9nwazYwlbs5v31hJ0XoV1kjXHtGTs0H/OQL4yLvLKH8iV/eGW9Ug9Tu0Qley
 Ccq4HoY2tOsGevrGCK7LMvHHBuEH3PlQQrZpWwig+Ye+PRJkHuWlEY6XDNdDehpAUKhpmZSM
X-Google-Smtp-Source: AGHT+IGAtLS/mBYpscr3DexPLJjBaEgPlCDJ/pp27tquY/jFHAanBx5we4RIamCx0ZeeyRFksGIkYA==
X-Received: by 2002:a05:6a21:6d8f:b0:1f5:63f9:9eb4 with SMTP id
 adf61e73a8af0-21ee6999fecmr1460105637.35.1749166957574; 
 Thu, 05 Jun 2025 16:42:37 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b0847b9sm213916b3a.104.2025.06.05.16.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 16:42:37 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>,
 Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH v3 1/9] cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
Date: Thu,  5 Jun 2025 23:42:15 +0000
Message-ID: <20250605234227.970187-2-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605234227.970187-1-anisa.su887@gmail.com>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Anisa Su <anisa.su@samsung.com>

FM DCD Management command 0x5600 implemented per CXL 3.2 Spec Section 7.6.7.6.1.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 59 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  4 +++
 include/hw/cxl/cxl_device.h |  1 +
 3 files changed, 64 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 0b615ea37a..3304048922 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -23,6 +23,7 @@
 #include "qemu/uuid.h"
 #include "system/hostmem.h"
 #include "qemu/range.h"
+#include "qapi/qapi-types-cxl.h"
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 #define CXL_DC_EVENT_LOG_SIZE 8
@@ -117,6 +118,8 @@ enum {
         #define GET_PHYSICAL_PORT_STATE     0x1
     TUNNEL = 0x53,
         #define MANAGEMENT_COMMAND     0x0
+    FMAPI_DCD_MGMT = 0x56,
+        #define GET_DCD_INFO    0x0
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3237,6 +3240,52 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.2 section 7.6.7.6.1: Get DCD Info (Opcode 5600h) */
+static CXLRetCode cmd_fm_get_dcd_info(const struct cxl_cmd *cmd,
+                                      uint8_t *payload_in,
+                                      size_t len_in,
+                                      uint8_t *payload_out,
+                                      size_t *len_out,
+                                      CXLCCI *cci)
+{
+    struct {
+        uint8_t num_hosts;
+        uint8_t num_regions_supported;
+        uint8_t rsvd1[2];
+        uint16_t supported_add_sel_policy_bitmask;
+        uint8_t rsvd2[2];
+        uint16_t supported_removal_policy_bitmask;
+        uint8_t sanitize_on_release_bitmask;
+        uint8_t rsvd3;
+        uint64_t total_dynamic_capacity;
+        uint64_t region_blk_size_bitmasks[8];
+    } QEMU_PACKED *out = (void *)payload_out;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDCRegion *region;
+    int i;
+
+    out->num_hosts = 1;
+    out->num_regions_supported = ct3d->dc.num_regions;
+    stw_le_p(&out->supported_add_sel_policy_bitmask,
+             BIT(CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE));
+    stw_le_p(&out->supported_removal_policy_bitmask,
+             BIT(CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE));
+    out->sanitize_on_release_bitmask = 0;
+
+    stq_le_p(&out->total_dynamic_capacity,
+             ct3d->dc.total_capacity / CXL_CAPACITY_MULTIPLIER);
+
+    for (i = 0; i < ct3d->dc.num_regions; i++) {
+        region = &ct3d->dc.regions[i];
+        memcpy(&out->region_blk_size_bitmasks[i],
+               &region->supported_blk_size_bitmask,
+               sizeof(out->region_blk_size_bitmasks[i]));
+    }
+
+    *len_out = sizeof(*out);
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3350,6 +3399,11 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
                                      cmd_tunnel_management_cmd, ~0, 0 },
 };
 
+static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
+    [FMAPI_DCD_MGMT][GET_DCD_INFO] = { "GET_DCD_INFO",
+        cmd_fm_get_dcd_info, 0, 0 },
+};
+
 /*
  * While the command is executing in the background, the device should
  * update the percentage complete in the Background Command Status Register
@@ -3624,7 +3678,12 @@ void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
                                            DeviceState *intf,
                                            size_t payload_max)
 {
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
+
     cxl_copy_cci_commands(cci, cxl_cmd_set_t3_fm_owned_ld_mctp);
+    if (ct3d->dc.num_regions) {
+        cxl_copy_cci_commands(cci, cxl_cmd_set_fm_dcd);
+    }
     cci->d = d;
     cci->intf = intf;
     cxl_init_cci(cci, payload_max);
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index f283178d88..f608470362 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -8,6 +8,7 @@
  *
  * SPDX-License-Identifier: GPL-v2-only
  */
+#include <math.h>
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
@@ -634,6 +635,8 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
     uint64_t region_len;
     uint64_t decode_len;
     uint64_t blk_size = 2 * MiB;
+    /* Only 1 block size is supported for now. */
+    uint64_t supported_blk_size_bitmask = BIT((int) log2(blk_size));
     CXLDCRegion *region;
     MemoryRegion *mr;
     uint64_t dc_size;
@@ -679,6 +682,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
             .block_size = blk_size,
             /* dsmad_handle set when creating CDAT table entries */
             .flags = 0,
+            .supported_blk_size_bitmask = supported_blk_size_bitmask,
         };
         ct3d->dc.total_capacity += region->len;
         region->blk_bitmap = bitmap_new(region->len / region->block_size);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index a151e19da8..7eade9cf8a 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -530,6 +530,7 @@ typedef struct CXLDCRegion {
     uint32_t dsmadhandle;
     uint8_t flags;
     unsigned long *blk_bitmap;
+    uint64_t supported_blk_size_bitmask;
 } CXLDCRegion;
 
 typedef struct CXLSetFeatureInfo {
-- 
2.47.2


