Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC477C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSNf-0006Pk-EW; Mon, 14 Jul 2025 19:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJM-0005sV-An
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:10:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJJ-00062X-Qi
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iMzsCuiK+55U/XfyyU1n4164I7WWpM53lulxxbvT5hg=;
 b=BiJQhfpTVd4BtEUoDhiVvzYKKp02h++qBZ3HdP3P67ZXAv7mjD1xjUZXh5eCqqnxteGm00
 C4MBDTkPO+T4U9DnuHOn6J7nnNBQZQ8Dox77RGN/v7Ro/1kXhLPgz8wUMvpXPWViFkvogU
 GRN/vgYXXZzzzkIYu8ofuAtIYzSCZNc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-5WV9DPTkNQKEIzp7onslNA-1; Mon, 14 Jul 2025 19:10:11 -0400
X-MC-Unique: 5WV9DPTkNQKEIzp7onslNA-1
X-Mimecast-MFC-AGG-ID: 5WV9DPTkNQKEIzp7onslNA_1752534610
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45626e0d3e1so1112275e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534609; x=1753139409;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iMzsCuiK+55U/XfyyU1n4164I7WWpM53lulxxbvT5hg=;
 b=qfSgSjL+a/0fxon4E4aNYOXizSqhZ2g6LxE1IysTiXvKux84LrA6RXwQcry9rRoC6D
 XY/Kqdu7DLFXjNt6TKOpiXf0n6w3UI4llt4T9TbF8yKpO+m+AzoqzKrsVt8MZkQ129hD
 GRAorPB1E1AvgfcP5rjmQCvfjHrqwQazm1HlQkY7VnJKXgq4rdDGH9tghOi2UwpftmY8
 UsLJkQ7DOiO2drw8lESotT+JZFEqnVUaKC4cJccilPOaHyZyLLMNDwtOfH5EmlJvRu+U
 8L3rw8IzC8j/VVYg+gXS7MjPrEreXTvqRa8tgr/5owsEx8YvFCZirCXTRPTXa9n5Fwm2
 B+qw==
X-Gm-Message-State: AOJu0Yz0o2O6hpNuFMMArh8QJIX6A0qV2iH9D5I3zeC+17uaybn+TnKM
 CJa8UeZg1wXM3qoxu+/CsFj3K0aPJRPYJzwKm1eAp4sQ1hVYL/GZED6IUxrX8A6KcgbF893E1C8
 FWWXB70Qgsxge6iyToY48oGBUTLQ076BNRNXL+fe8Ivtn5swCpVU1OSI6B4POkG1a9KWNxlXSTP
 8Pmy9SH1+C75jEbTVM+jZoDMJs+cZbjs7ydw==
X-Gm-Gg: ASbGncsEZs32OYD66abqSSnYrafOnVbRv8xQ9jQoTKFljOlzJ01TzzKiD8EKybBgUE9
 GkTaSedHoHd4I8uyKO8xH8Ix236oQl8rV8rXySYfpe6jPFjw3YjcVThBb+rBCv6mKjHyxCXGKJz
 TcL2jfOlwb4s1iGHL0EPx7pOjJTgpxxWM+ytXh88sai8GEI4wUdy53uHrf89zgHBcNlfQY/YhKl
 gp4uo85Nvuv3UoD0nnXTzbsgFndtbQqIm0YCq2jqmuR/qozjaYTU7aQFOpsY+sb9H2DNMvXXhLz
 3Mz2zPp6dE1TDinzV4+Zhn5kf27RRFS+
X-Received: by 2002:a05:600c:6387:b0:441:b3eb:574e with SMTP id
 5b1f17b1804b1-455fffb208fmr88849015e9.5.1752534609158; 
 Mon, 14 Jul 2025 16:10:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmAqTARcSqdyi2afWeAgzoXUFSMsJvsdXD2LL8EatnBz6C6Mo3c7nZmS06XuHPndbJJHwhIw==
X-Received: by 2002:a05:600c:6387:b0:441:b3eb:574e with SMTP id
 5b1f17b1804b1-455fffb208fmr88848835e9.5.1752534608732; 
 Mon, 14 Jul 2025 16:10:08 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-455f222e4f4sm104527975e9.10.2025.07.14.16.10.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:10:07 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:10:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Anisa Su <anisa.su@samsung.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 88/97] hw/cxl: mailbox-utils: 0x5600 - FMAPI Get DCD Info
Message-ID: <505870dd7a0fd4756319ddfe6e3a4497b1ebf266.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20250714174509.1984430-3-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |  1 +
 hw/cxl/cxl-mailbox-utils.c  | 59 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  4 +++
 3 files changed, 64 insertions(+)

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
index f283178d88..d898cfd617 100644
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
+    uint64_t supported_blk_size_bitmask = blk_size;
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
-- 
MST


