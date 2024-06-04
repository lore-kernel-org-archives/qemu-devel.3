Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE14C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 19:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEZV9-000893-UZ; Tue, 04 Jun 2024 15:07:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZV8-0007wt-5p
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sEZV5-0000tr-Gb
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 15:07:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717528033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q5yMEJxQrvHs2013SKJXv7QWp1/VlpmqevozX2UnFx8=;
 b=DOTCwhYlPxYUpy6T25uv0+b7SktpfDViLVIRzbCjzseQAxG+mcB6HLoH7LU/GZEX4bk7lr
 UWTYEXmW3Cj2lSzB57cFjMCyyegjTgCQf/W09UtdyhM6wRHo8wgCpMfDfBLFtS/kPVKPUx
 iQv8v0Rmuiz/WrUXfCKnsewFrmGnI7w=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-xSYYhw4HODu80bls8pQeFg-1; Tue, 04 Jun 2024 15:07:12 -0400
X-MC-Unique: xSYYhw4HODu80bls8pQeFg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-35e808b1db8so64687f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 12:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717528030; x=1718132830;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q5yMEJxQrvHs2013SKJXv7QWp1/VlpmqevozX2UnFx8=;
 b=ojm2o0PVmjDbOy9PRIXS8TRSmAEMpV12MN7NOSP8KdLDvskg2P5T5/47XK+jVIh6pY
 RWvvm6tmV7A43vA+ZZKRVOWlx887S5RL3jkniWnf998/A2OsrP8lgTgcDs56N8oRivMr
 ClFWuYIONTMC2UUkW5gDVJ8+hT8w8KhbpL7zlC4V9JS8YaSeMmuKA7RdNkpZmkHi+PMY
 FSvOthiQ32HdjMQFkK9VnTSDoJnkkjZrFVgyFuRwFFjqDaCQ0FRNtk4U4BcxBJRArFVW
 CpJK9eR/Yz5NcQjuJJvign9gXKLQ3x45USdmuRp/qiy9wtjhIaNVsb3qqjB4YfhjjySV
 j3Tg==
X-Gm-Message-State: AOJu0YyWI7m+V4jax9uMQFaVo8ieIycAGXnXBMsU3GAHdF22Q4xiBRKe
 evMZCTRgX7z9DQTUAUVT9/em0TE70B2pkV/4NFWEaDyBjA9uxrPdhV7XtknFlitTMVdDoKEEUyG
 ovesY3hwuJvAW81mbKa5PSENjHBrY0THtGdw5Po3QIX/G27IB4SEzf/KU98jv3I7CTUICjyD/Nc
 pMbZBdZ3pQfFNsMYuiMLuSTZmk3NPKPw==
X-Received: by 2002:adf:f801:0:b0:354:c81e:b7ba with SMTP id
 ffacd0b85a97d-35e7c51a081mr3326163f8f.3.1717528029851; 
 Tue, 04 Jun 2024 12:07:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd0dgTsWT4ZP6HonGzlMLVd/dR36O1NQatxXDuPWYw51BUpRb6w/iZ5Sjhi4GnWm9Ej/8qMA==
X-Received: by 2002:adf:f801:0:b0:354:c81e:b7ba with SMTP id
 ffacd0b85a97d-35e7c51a081mr3326123f8f.3.1717528029031; 
 Tue, 04 Jun 2024 12:07:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:552:cf5c:2b13:215c:b9df:f231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd0659bbbsm12328804f8f.110.2024.06.04.12.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 12:07:08 -0700 (PDT)
Date: Tue, 4 Jun 2024 15:07:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 20/46] hw/cxl/cxl-mailbox-utils: Add dynamic capacity region
 representative and mailbox command support
Message-ID: <b5c718107795740f8b350636504258e985e9f6a5.1717527933.git.mst@redhat.com>
References: <cover.1717527933.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717527933.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Fan Ni <fan.ni@samsung.com>

Per cxl spec r3.1, add dynamic capacity (DC) region representative based on
Table 8-165 and extend the cxl type3 device definition to include DC region
information. Also, based on info in 8.2.9.9.9.1, add 'Get Dynamic Capacity
Configuration' mailbox support.

Note: we store region decode length as byte-wise length on the device, which
should be divided by 256 * MiB before being returned to the host
for "Get Dynamic Capacity Configuration" mailbox command per
specification.

Reviewed-by: Gregory Price <gregory.price@memverge.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
Message-Id: <20240523174651.1089554-5-nifan.cxl@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h | 16 +++++++
 hw/cxl/cxl-mailbox-utils.c  | 96 +++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index a5f8e25020..e839370266 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -422,6 +422,17 @@ typedef struct CXLPoison {
 typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
 #define CXL_POISON_LIST_LIMIT 256
 
+#define DCD_MAX_NUM_REGION 8
+
+typedef struct CXLDCRegion {
+    uint64_t base;       /* aligned to 256*MiB */
+    uint64_t decode_len; /* aligned to 256*MiB */
+    uint64_t len;
+    uint64_t block_size;
+    uint32_t dsmadhandle;
+    uint8_t flags;
+} CXLDCRegion;
+
 struct CXLType3Dev {
     /* Private */
     PCIDevice parent_obj;
@@ -454,6 +465,11 @@ struct CXLType3Dev {
     unsigned int poison_list_cnt;
     bool poison_list_overflowed;
     uint64_t poison_list_overflow_ts;
+
+    struct dynamic_capacity {
+        uint8_t num_regions; /* 0-8 regions */
+        CXLDCRegion regions[DCD_MAX_NUM_REGION];
+    } dc;
 };
 
 #define TYPE_CXL_TYPE3 "cxl-type3"
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 626acc1d0d..bede28e3c8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -22,6 +22,8 @@
 
 #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 #define CXL_DC_EVENT_LOG_SIZE 8
+#define CXL_NUM_EXTENTS_SUPPORTED 512
+#define CXL_NUM_TAGS_SUPPORTED 0
 
 /*
  * How to add a new command, example. The command set FOO, with cmd BAR.
@@ -80,6 +82,8 @@ enum {
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
         #define CLEAR_POISON           0x2
+    DCD_CONFIG  = 0x48,
+        #define GET_DC_CONFIG          0x0
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
@@ -1238,6 +1242,88 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * CXL r3.1 section 8.2.9.9.9.1: Get Dynamic Capacity Configuration
+ * (Opcode: 4800h)
+ */
+static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLCCI *cci)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    struct {
+        uint8_t region_cnt;
+        uint8_t start_rid;
+    } QEMU_PACKED *in = (void *)payload_in;
+    struct {
+        uint8_t num_regions;
+        uint8_t regions_returned;
+        uint8_t rsvd1[6];
+        struct {
+            uint64_t base;
+            uint64_t decode_len;
+            uint64_t region_len;
+            uint64_t block_size;
+            uint32_t dsmadhandle;
+            uint8_t flags;
+            uint8_t rsvd2[3];
+        } QEMU_PACKED records[];
+    } QEMU_PACKED *out = (void *)payload_out;
+    struct {
+        uint32_t num_extents_supported;
+        uint32_t num_extents_available;
+        uint32_t num_tags_supported;
+        uint32_t num_tags_available;
+    } QEMU_PACKED *extra_out;
+    uint16_t record_count;
+    uint16_t i;
+    uint16_t out_pl_len;
+    uint8_t start_rid;
+
+    start_rid = in->start_rid;
+    if (start_rid >= ct3d->dc.num_regions) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count = MIN(ct3d->dc.num_regions - in->start_rid, in->region_cnt);
+
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+    extra_out = (void *)(payload_out + out_pl_len);
+    out_pl_len += sizeof(*extra_out);
+    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+    out->num_regions = ct3d->dc.num_regions;
+    out->regions_returned = record_count;
+    for (i = 0; i < record_count; i++) {
+        stq_le_p(&out->records[i].base,
+                 ct3d->dc.regions[start_rid + i].base);
+        stq_le_p(&out->records[i].decode_len,
+                 ct3d->dc.regions[start_rid + i].decode_len /
+                 CXL_CAPACITY_MULTIPLIER);
+        stq_le_p(&out->records[i].region_len,
+                 ct3d->dc.regions[start_rid + i].len);
+        stq_le_p(&out->records[i].block_size,
+                 ct3d->dc.regions[start_rid + i].block_size);
+        stl_le_p(&out->records[i].dsmadhandle,
+                 ct3d->dc.regions[start_rid + i].dsmadhandle);
+        out->records[i].flags = ct3d->dc.regions[start_rid + i].flags;
+    }
+    /*
+     * TODO: Assign values once extents and tags are introduced
+     * to use.
+     */
+    stl_le_p(&extra_out->num_extents_supported, CXL_NUM_EXTENTS_SUPPORTED);
+    stl_le_p(&extra_out->num_extents_available, CXL_NUM_EXTENTS_SUPPORTED);
+    stl_le_p(&extra_out->num_tags_supported, CXL_NUM_TAGS_SUPPORTED);
+    stl_le_p(&extra_out->num_tags_available, CXL_NUM_TAGS_SUPPORTED);
+
+    *len_out = out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -1282,6 +1368,11 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_clear_poison, 72, 0 },
 };
 
+static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
+    [DCD_CONFIG][GET_DC_CONFIG] = { "DCD_GET_DC_CONFIG",
+        cmd_dcd_get_dyn_cap_config, 2, 0 },
+};
+
 static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
     [INFOSTAT][BACKGROUND_OPERATION_STATUS] = { "BACKGROUND_OPERATION_STATUS",
@@ -1487,7 +1578,12 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
 
 void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
 {
+    CXLType3Dev *ct3d = CXL_TYPE3(d);
+
     cxl_copy_cci_commands(cci, cxl_cmd_set);
+    if (ct3d->dc.num_regions) {
+        cxl_copy_cci_commands(cci, cxl_cmd_set_dcd);
+    }
     cci->d = d;
 
     /* No separation for PCI MB as protocol handled in PCI device */
-- 
MST


