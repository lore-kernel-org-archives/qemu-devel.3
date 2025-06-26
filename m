Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E54C7EE30
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 22:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUv5L-0006Q2-BE; Thu, 26 Jun 2025 18:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uUv5B-0006Lu-4S
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 18:28:39 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uUv54-0000tt-Su
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 18:28:36 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-237e6963f63so11298795ad.2
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 15:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750976908; x=1751581708; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q4FJYJ8U4O5w3tqy5MpavB61ZpcaWiN2iAUIoKHfFUQ=;
 b=Xiq5iIsKPiKHAkFt+Qmzv6L3hhWf9HtAFYK+YATmXyqOYl5c36QJVvRFrugaQxQlHl
 B3oPXb5gkO0b7Nd3cQZRCgBqEElCApY8gKxStgM91jGXVmtaLlDPpitFtPDb7xmjPAh6
 mmMzM1wPSoSQi62zEbcDkH3GezPPgeCgaRshoxJkGm67kra6IrTwCLkZV6ZReGvbVvAO
 s0x7cb8cYz0STBbKWn1XhXiiCgSp8cJpry1waI9DyU40To9MqXSX3oQUsKfQ+GojifVZ
 TS9JHZsZ1gtjQ9ejNLoyvXIuC8eLa3xDkLUBTUqwPzWOpT8eO13SA+Ibi5vGlTH4Bus9
 A+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750976908; x=1751581708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q4FJYJ8U4O5w3tqy5MpavB61ZpcaWiN2iAUIoKHfFUQ=;
 b=MpMO2o1LA7ET/5hSbej7UmMFAaS+drf+FVhK78UhNLRPZZcTrrpnTJjAgQ4I35pPof
 EVZi8iYRwWlysMD9EvHA3lzXuWJJ6SOyLB2uYQzfE7dGmhgmdQpIxtiGKtexzZyLpj0h
 isKn8NNwFKBTKQJ9hwHBuzuYGMrj9e9eAMXGbspAkCnz7dGm6ngj+ufRcBY7rvrmwgeu
 jAzwAmlhPiDrpEn1A5Bn5Hc6GiV/NGa+eI5I5sT55zMshX19l+62bXZa6rE71N9DVY1Z
 tDJm72lYdPC/rmovt+4j3nl8yLJVNG7UC5Cp3AMtk+u3iBPZaWP0T/TEOCvA57P7f75V
 L2+Q==
X-Gm-Message-State: AOJu0YwbY4+BunhOYHUj2UMrWqAU21c7xeTlcG952g7EZwMWj/Q0YcOb
 bXifHob5OMSMWTfCvrJ1d/UKMNsfr+9dGcIBhfg/t0B9H7fRI2cpk8hp8HE4Ug==
X-Gm-Gg: ASbGncsZWoXyHKhHUkqvioDdnGH3ky8nSercpUqii+hQ2imcWnodDC61hVLnFzOl8OD
 cx9B8gIwVZt72nrvFON8lQPFtbMaSykM/xjpAK/2uBiN0XUwZUcAeveIsjoAmF8ZAFMdtx8peoV
 uyxejGf+YlZ3O0iBOb9y0E2BxCwcRZ/2wFlfDmV7SC/ekXfWm8iTAM4cmQSLZJtR4AsBjeTDApU
 hiLjq13MZLxK7UVtc5sap8pkF8I2HkSimaV8a5USDIBv4Gj+AnDo5rdVGRS9845GjLumL6xTdhj
 Awqw4XZZL6MzthyowcNcpp7VpZo0mNMA66AZDi3z4CbYTkeA6Mjous2VVcGPJbtYRXXYkG3GGe5
 UTkjBVv8=
X-Google-Smtp-Source: AGHT+IFPGI/jENu1Opk6rzXQM1PGC5KaqM00tRrzeAzqShzQOnfmyVlrJeo/YfMr80WZPQXkgnxrGw==
X-Received: by 2002:a17:903:1b6b:b0:234:8eeb:d834 with SMTP id
 d9443c01a7336-23ac43d318dmr14505035ad.16.1750976908121; 
 Thu, 26 Jun 2025 15:28:28 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb3c4b23sm870365ad.214.2025.06.26.15.28.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 15:28:27 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 alok.a.tiwari@oracle.com, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>, Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH v4 07/10] cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region
 Extent Lists
Date: Thu, 26 Jun 2025 22:23:30 +0000
Message-ID: <20250626222743.1766404-8-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250626222743.1766404-1-anisa.su887@gmail.com>
References: <20250626222743.1766404-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

FM DCD Management command 0x5603 implemented per CXL r3.2 Spec Section 7.6.7.6.4
Very similar to previously implemented command 0x4801.

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 76 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 69c618383a..e3d54ed124 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -122,6 +122,7 @@ enum {
         #define GET_DCD_INFO    0x0
         #define GET_HOST_DC_REGION_CONFIG   0x1
         #define SET_DC_REGION_CONFIG        0x2
+        #define GET_DC_REGION_EXTENT_LIST   0x3
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3466,6 +3467,79 @@ static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.2 section 7.6.7.6.4 Get DC Region Extent Lists (Opcode 5603h) */
+static CXLRetCode cmd_fm_get_dc_region_extent_list(const struct cxl_cmd *cmd,
+                                                   uint8_t *payload_in,
+                                                   size_t len_in,
+                                                   uint8_t *payload_out,
+                                                   size_t *len_out,
+                                                   CXLCCI *cci)
+{
+    struct {
+        uint16_t host_id;
+        uint8_t rsvd[2];
+        uint32_t extent_cnt;
+        uint32_t start_extent_id;
+    } QEMU_PACKED *in = (void *)payload_in;
+    struct {
+        uint16_t host_id;
+        uint8_t rsvd[2];
+        uint32_t start_extent_id;
+        uint32_t extents_returned;
+        uint32_t total_extents;
+        uint32_t list_generation_num;
+        uint8_t rsvd2[4];
+        CXLDCExtentRaw records[];
+    } QEMU_PACKED *out = (void *)payload_out;
+    QEMU_BUILD_BUG_ON(sizeof(*in) != 0xc);
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDCExtent *ent;
+    CXLDCExtentRaw *out_rec;
+    uint16_t record_count = 0, record_done = 0, i = 0;
+    uint16_t out_pl_len, max_size;
+
+    if (in->host_id != 0) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (in->start_extent_id > ct3d->dc.nr_extents_accepted) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count = MIN(in->extent_cnt,
+                       ct3d->dc.nr_extents_accepted - in->start_extent_id);
+    max_size = CXL_MAILBOX_MAX_PAYLOAD_SIZE - sizeof(*out);
+    record_count = MIN(record_count, max_size / sizeof(out->records[0]));
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+
+    stw_le_p(&out->host_id, in->host_id);
+    stl_le_p(&out->start_extent_id, in->start_extent_id);
+    stl_le_p(&out->extents_returned, record_count);
+    stl_le_p(&out->total_extents, ct3d->dc.nr_extents_accepted);
+    stl_le_p(&out->list_generation_num, ct3d->dc.ext_list_gen_seq);
+
+    if (record_count > 0) {
+        QTAILQ_FOREACH(ent, &ct3d->dc.extents, node) {
+            if (i++ < in->start_extent_id) {
+                continue;
+            }
+            out_rec = &out->records[record_done];
+            stq_le_p(&out_rec->start_dpa, ent->start_dpa);
+            stq_le_p(&out_rec->len, ent->len);
+            memcpy(&out_rec->tag, ent->tag, 0x10);
+            stw_le_p(&out_rec->shared_seq, ent->shared_seq);
+
+            record_done++;
+            if (record_done == record_count) {
+                break;
+            }
+        }
+    }
+
+    *len_out = out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3591,6 +3665,8 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
          CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
          CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
          CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
+    [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
+        cmd_fm_get_dc_region_extent_list, 12, 0 },
 };
 
 /*
-- 
2.47.2


