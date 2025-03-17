Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D1DC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 19:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuGS3-0007Tu-Rv; Mon, 17 Mar 2025 15:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1tuDZi-0003g3-SM
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:44:29 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1tuDZW-0001Ge-Mi
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:44:25 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-226185948ffso22914575ad.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742229846; x=1742834646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=353TAKo8VnbJ8QqIp//xm5+02cW4+3eAhYTJE+s11Po=;
 b=dUDZBP3rOaoGRg7FVgxfs7nuk9RYpeL8XfWjjuijeerHn+NGIEKFBune8FCfnD6Vzu
 vi0u4oHNLfo2h5VS7I3nL8EzFkRYMGDkul5wDZLDnb1B2IhxHl5gvNAxlnYSXH+o86E1
 BAWaMg3w8BmfS/RYwwl66oFJLqMzjX45by7UerHZZuReyAqtJPR59YmFUKpulsPFqLsm
 372cLtBT/a1xyRpDZvrhubnekrO8jkCOBuaLm0N/RuGE9mQKMrmgSLcw4IrKfgtmCTiD
 I1lMtSy9770GT+L/vGCPjTlNUG0KRArvg1OZHKoi6OsY2z9dWZMDsK2y5H2t7dUzzTQ5
 uhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742229846; x=1742834646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=353TAKo8VnbJ8QqIp//xm5+02cW4+3eAhYTJE+s11Po=;
 b=E46GkJWwC34cTmBXBwPTYnoQATgvpYER6FD1pIts4lZobGhp/Zy+zltmS6nFixcbPq
 OqVdY0eZNvf80HUBSxnOuITZWLceWslQJ/ODKlMDQE3801LgTv6MlB4zjwI9bhuGzERl
 S7v2Pw6dQ7ykXlHBmUxhTOnkOd/3FBHlucLqQvMwj1sp8rLXYxKtdtJJ/T/RUmBwf8JA
 Jo/A6E6ygsgzr3e3NeRypcvnSNwzxtwu5GwRWUpJ4Lrg+Y0Ffkeb93jOUzXf23wabnR6
 mQDLOAeSUcJIcffkOtPZZYt98IwfuHcaQYgaXsgNiGBwjRkZTgF+YyAZKlm9HV4xvS8X
 Z7Lw==
X-Gm-Message-State: AOJu0YzXMOXcwdiXE1sPrJaKiehWou2UJUh62Xlo7bj149HtR4Z/fQrN
 i0TeEgWg1R248IW2GlEG2uGgvPt8dmWILwCT7dQ5VQZ7UVEwdGNDggMqhQ==
X-Gm-Gg: ASbGncuZTwvd9SoYcwEXJMM+eibozl3jGmm+Z1tE6jN09rpLnCqld/kBw200JGUKGA+
 JtXG4OEbKwfzH/qBk+KtA1N8xzgwPSnOWETaza+Q+S/qN84BCtf2YjC9EJYnWJiImNMtSlKow0C
 f6S7QtTgB27efcMmIYtOEEbkaSp0u0jLKjkSIrskw6W1b/l/7rjcBDFSi49205htjS8KqqUT2sv
 qoHbLOddT8anZTDurIpIqKjJMfUvuL6xB3PXoJBvby+1VTNYxSI6XvkhIXfwfQOFnMLz0g14392
 Yq84X9fLkreW2U1OoGZFkQMcLfaykFmnex+swadQEHOBjBN9p1dQ4wRc29HeP8RJNw==
X-Google-Smtp-Source: AGHT+IH2UQVAMxqKvpv3asrn5zmBcvf0OAu7rzB4rOpB6x7Pz7Oqydnwl9BwCTj1jDJg3+oVjydsTw==
X-Received: by 2002:a17:902:ec81:b0:220:fe50:5b44 with SMTP id
 d9443c01a7336-2262c583a37mr3222255ad.31.1742229846058; 
 Mon, 17 Mar 2025 09:44:06 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6888461sm77810085ad.23.2025.03.17.09.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 09:44:05 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [PATCH 7/9] cxl-mailbox-utils: 0x5603 - FMAPI Get DC Region Extent
 Lists
Date: Mon, 17 Mar 2025 16:31:34 +0000
Message-ID: <20250317164204.2299371-8-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317164204.2299371-1-anisa.su887@gmail.com>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 17 Mar 2025 15:48:39 -0400
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

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 84 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 51ead2b152..77cf0fdb15 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -126,6 +126,7 @@ enum {
         #define GET_DCD_INFO 0x0
         #define GET_HOST_DC_REGION_CONFIG 0x1
         #define SET_DC_REGION_CONFIG 0x2
+        #define GET_DC_REGION_EXTENT_LIST 0x3
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3587,6 +3588,87 @@ static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * CXL r3.2 section 7.6.7.6.4 Get DC Region Extent Lists (Opcode 5603h)
+ */
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
+    if (ct3d->dc.num_regions == 0) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
+    if (in->host_id != 0) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (in->start_extent_id > ct3d->dc.total_extent_count) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count = MIN(in->extent_cnt,
+                       ct3d->dc.total_extent_count - in->start_extent_id);
+    max_size = CXL_MAILBOX_MAX_PAYLOAD_SIZE - sizeof(*out);
+    record_count = MIN(record_count, max_size / sizeof(out->records[0]));
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+
+    stw_le_p(&out->host_id, in->host_id);
+    stl_le_p(&out->start_extent_id, in->start_extent_id);
+    stl_le_p(&out->extents_returned, record_count);
+    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
+    stl_le_p(&out->list_generation_num, ct3d->dc.ext_list_gen_seq);
+
+    if (record_count > 0) {
+        out_rec = &out->records[record_done];
+
+        QTAILQ_FOREACH(ent, &ct3d->dc.extents, node) {
+            if (i++ < in->start_extent_id) {
+                continue;
+            }
+            stq_le_p(&out_rec->start_dpa, ent->start_dpa);
+            stq_le_p(&out_rec->len, ent->len);
+            memcpy(&out_rec->tag, ent->tag, 0x10);
+            stw_le_p(&out_rec->shared_seq, ent->shared_seq);
+
+            record_done++;
+            out_rec++;
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
@@ -3720,6 +3802,8 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
          CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
          CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
          CXL_MBOX_IMMEDIATE_DATA_CHANGE)},
+    [FMAPI_DCD_MGMT][GET_DC_REGION_EXTENT_LIST] = { "GET_DC_REGION_EXTENT_LIST",
+        cmd_fm_get_dc_region_extent_list, 12, 0},
 };
 
 /*
-- 
2.47.2


