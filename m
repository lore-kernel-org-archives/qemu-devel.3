Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7230C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 23:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNKES-0000Ox-VL; Thu, 05 Jun 2025 19:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uNKES-0000Om-2y
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 19:42:48 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uNKEQ-0004hu-BR
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 19:42:47 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-74801bc6dc5so1350086b3a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 16:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749166965; x=1749771765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cIr/2qSPqm5D7ejDBEP4TNOxs/6xpDxN+a3iMpOZeX8=;
 b=mOl8CrjLqiIRKAlDSrzblfkYPhnkhpgVGcbsQd2VNIoKPInSS5BggOwYz1QlB0djFR
 3ygyqxyumOawGJv3OYgDxOvYhUNwLwOvAg/9ePIxzPkXvj346B7beoZkjyD9wXSraZ24
 VJtZvEcUgRdP/E1Uzw32+pzadNZ6E5avx169tZCKlOsZPxuNZKBm2lcoavA9kZPdCqJP
 /py+6axorateOoqfqEqI1N/sPgad7sC38+CM50f1ngdTefh1RS829/WQCRcKmlFgzFJ9
 oLa1wkCG0jT1A5Os3gciwMCf1hZgzYnAtzCzUuQTcoSNhoZ/B8cdG1tnyZhDD1vxOByQ
 wYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749166965; x=1749771765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cIr/2qSPqm5D7ejDBEP4TNOxs/6xpDxN+a3iMpOZeX8=;
 b=Z/MGh+u71/VDOa/Fb/J1MTbNp7dWCvmQIPVCr4Ii8KaWQ0HVBfNV3tpkRn4PS9DtZs
 CUoPAJQSR1ht75c81zYiz1r1PcYpJDf47jfI0Ki9r5S2bewmvmdNdtuJhmZs3BHe4D9l
 LLaEbK0jbaYPLqKNw0wzw6dZ3pHrg2y/nAv8lWk7Iix4BjUHAZmLSGdcmGXUmbiob3bc
 1ML1qbjKQgVKxjZyg6PhicMk/Ne8tlj7RoQ0NZ27yx4OmfvBQ4+uIG3DiWj4YQ9On27r
 jdU62/+E2JEG/HtUTtTymtl+PkuL/kj4hhxsbaVOQxh9PBre0WytciMoO/UwA8KrvMiQ
 jMVw==
X-Gm-Message-State: AOJu0Yyu/cF/tm8tT++MfjtGbh+mWAadIB9QT3Tk2ofU0rqnusEFQG6s
 lhntVLwf5QZWz6Yx/F1AD8eDwJiQJp09xtT/pc+RFsx7XaqXvqjaXyVN1bqLLA==
X-Gm-Gg: ASbGncvnHYa5VDocAWlxQZHhTdNfzRPM9Yd8pqReagOTgQPJP5Uy3J01xMrIREC3VP8
 GulFykJNMRxr3BTuWuizDmWRDS3xx1ea9qWSn+MhLqrUIUqdzTRKwluIvFxM+CXmUWSUQJDKuEf
 uKjnU1lrTOhHLp0png7+CFg5EigZnCt22ARVBDdQ67ArFGXIiJN2Jpu2bdqO94qOA1M6WXV27t7
 mYlS6q3Rmf84DZrsAhYjnRZ2ceYohoDwk0iKr458MzOLX0HTd65eJcvIK8erQBkro1qclHN6f3y
 DwzWhuTp3qEBqsVfCq0wu6BYx/yAacdO70VSsRCkxDaKl4DLqWzSoAwNB/T/0gHqnjlPt0Xk
X-Google-Smtp-Source: AGHT+IFXzk+l4XDIkFhBEz/32lu2jSG/mj1KBR4DKloZp5r7ELS19AopKD8TKtCQirz8ZNZ6zStR4Q==
X-Received: by 2002:a05:6a00:840e:b0:746:1d29:5892 with SMTP id
 d2e1a72fcca58-7482c25fe78mr437109b3a.4.1749166964994; 
 Thu, 05 Jun 2025 16:42:44 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7482b0847b9sm213916b3a.104.2025.06.05.16.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 16:42:44 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [QEMU PATCH v3 9/9] cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC
 Release
Date: Thu,  5 Jun 2025 23:42:23 +0000
Message-ID: <20250605234227.970187-10-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250605234227.970187-1-anisa.su887@gmail.com>
References: <20250605234227.970187-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x42e.google.com
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

FM DCD Managment command 0x5605 implemented per CXL r3.2 Spec Section 7.6.7.6.6

Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 62 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 7ee5be00bc..6c57e0deac 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -124,6 +124,7 @@ enum {
         #define SET_DC_REGION_CONFIG        0x2
         #define GET_DC_REGION_EXTENT_LIST   0x3
         #define INITIATE_DC_ADD             0x4
+        #define INITIATE_DC_RELEASE         0x5
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3685,6 +3686,60 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+#define CXL_EXTENT_REMOVAL_POLICY_MASK 0x7
+/* CXL r3.2 Section 7.6.7.6.6 Initiate Dynamic Capacity Release (Opcode 5605h) */
+static CXLRetCode cmd_fm_initiate_dc_release(const struct cxl_cmd *cmd,
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLCCI *cci)
+{
+    struct {
+        uint16_t host_id;
+        uint8_t flags;
+        uint8_t reg_num;
+        uint64_t length;
+        uint8_t tag[0x10];
+        uint32_t ext_count;
+        CXLDCExtentRaw extents[];
+    } QEMU_PACKED *in = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLUpdateDCExtentListInPl *list;
+    CXLDCExtentList updated_list;
+    uint32_t updated_list_size;
+    int rc;
+
+    switch (in->flags & CXL_EXTENT_REMOVAL_POLICY_MASK) {
+    case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE:
+        list = calloc(1, (sizeof(*list) +
+                          in->ext_count * sizeof(*list->updated_entries)));
+        convert_raw_extents(in->extents, list, in->ext_count);
+        rc = cxl_detect_malformed_extent_list(ct3d, list);
+        if (rc) {
+            return rc;
+        }
+        rc = cxl_dc_extent_release_dry_run(ct3d,
+                                           list,
+                                           &updated_list,
+                                           &updated_list_size);
+        if (rc) {
+            return rc;
+        }
+        cxl_mbox_create_dc_event_records_for_extents(ct3d,
+                                                     DC_EVENT_RELEASE_CAPACITY,
+                                                     in->extents,
+                                                     in->ext_count);
+        return CXL_MBOX_SUCCESS;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+            "CXL extent selection policy not supported.\n");
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3819,6 +3874,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
+    [FMAPI_DCD_MGMT][INITIATE_DC_RELEASE] = { "INIT_DC_RELEASE",
+        cmd_fm_initiate_dc_release, ~0,
+        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
+         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
 };
 
 /*
-- 
2.47.2


