Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51148C3ABBF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 00:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoye-00061f-Ff; Wed, 07 May 2025 20:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uCoyd-00061P-5h
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:19:03 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uCoyb-0006wR-6P
 for qemu-devel@nongnu.org; Wed, 07 May 2025 20:19:02 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736ad42dfd6so369081b3a.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 17:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746663540; x=1747268340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8A8Zt1gtvNZ8hmAUUEFU2ZRiAZPfj22eHGeqJsXNBa4=;
 b=MKKD9xp9QhErKUmP1zereCfBPM0awKVNg7JpCzPZGYij9quM7BwqBsBO9aaAcivkib
 jgI4YY4MUEFNY6AhmCGynnL8xNE3dQBVGBQzBFF/S3WU+JVATwp6f5ALQCTMsXZrEiSy
 yutFxY0fNFFRpf1PTr9r1XHWQlRMfrZpHlOlLBY1SIIK0vw3LV6wlKNsM4tEWUKIL99N
 xGOe+aKnUPV7J5hMU8kpQcizMMWJxTSWbu8vPx7dJzouRlmfzysy3gqHFFjqEDjr5BsP
 8RDOCw7KIwVe8cYA9Vy3dAtV/qZX2bI6QazEXue9Hzmwk9CKBglS/I0+Ladoac0JDJSB
 ilMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746663540; x=1747268340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8A8Zt1gtvNZ8hmAUUEFU2ZRiAZPfj22eHGeqJsXNBa4=;
 b=BdgQlviIP4IvaW1k98brX5gXerqXGiAlU1MkcKoGR5garunpA3RnNr5hbow3Zu6PDT
 YYRtldc4G+65ZUV40Uzgnl2vR3gcg3743/Pw225ot2xw3A8Wn7i9dvGc0wdJkW8jc7T4
 Znl9lUr4cRvkH8uCcjX7H2PRz5szkefnD9fnUpIVILYzX2HXApUIj1Krf1Ebk5mKX1i1
 7cg1iyoB8uunzCcsJGilW7cxPTeTuhAnIFu8xEc2cwe/7PgCiJkZ1dDF62lvywkV0WEc
 iumQjIJ/oPYuCYMI5YC2cLJGZIVbASdOKhuABXvbp+puCtenM/OS5PCPdsu7ywZTdNJh
 kIDw==
X-Gm-Message-State: AOJu0YysXXANE/wgsviSavuzIt4kkrxsY8s9gywsI+3JAyet6txIfiz/
 dh4M8feKtgO1u//AOAtEJc+oEAXy+mgdbAM5FDwdzrWM7tgqIr0Nz6kBkw==
X-Gm-Gg: ASbGncugsAEzANBJD4o9D8ySZ9H1J2cuuG+iMt85BZp0tUehqAZVJI0sQEe39tyza0u
 0rYxifNmMGghVTHn5dqnJQTDUYv8uMW+PdZppGzJA7KThKluSojJplBO4bOXwAu1HFuebd5eA0s
 teOrwF6pygjWYZ54gxJqdl5JGbL5wpq6DtdVzFviozuDPqeDQ61oHI4iM2omkvAzz85pICOiWMo
 tqvBi+5wmid47e1YokEe9WGdmV4aKRK6rxo35kOhW+aDlEQLM4/Dh2e++bRJ+Pm+8rq/bExR7Iu
 DJ2O4C9HDYidDVbeq8Kp9236W0VGZsQLwCDUvv4Pu4DrluuxzWXPJRubH0PetHWxIdg6EYa0
X-Google-Smtp-Source: AGHT+IEi42U6TnplQIeu2dkTaoQ02oUhOLfxnPpKuuJgEx9azbuVWKbt4/AhpRMe6fmR3FqpUB7tfA==
X-Received: by 2002:a05:6a00:ad8f:b0:739:4a30:b900 with SMTP id
 d2e1a72fcca58-7409cef9989mr6628104b3a.7.1746663539784; 
 Wed, 07 May 2025 17:18:59 -0700 (PDT)
Received: from deb-101020-bm01.dtc.local ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902167csm12378724b3a.98.2025.05.07.17.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 17:18:59 -0700 (PDT)
From: anisa.su887@gmail.com
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com, dave@stgolabs.net,
 linux-cxl@vger.kernel.org, Anisa Su <anisa.su@samsung.com>
Subject: [PATCH v2 10/10] cxl-mailbox-utils: 0x5605 - FMAPI Initiate DC Release
Date: Thu,  8 May 2025 00:01:06 +0000
Message-ID: <20250508001754.122180-11-anisa.su887@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250508001754.122180-1-anisa.su887@gmail.com>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x42b.google.com
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
 hw/cxl/cxl-mailbox-utils.c   | 56 ++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_opcodes.h |  1 +
 2 files changed, 57 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 9b176dea08..28266b16f7 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -3638,6 +3638,10 @@ static CXLRetCode cxl_mbox_dc_prescriptive_sanity_check(CXLType3Dev *dcd,
                                                ext.start_dpa, ext.len)) {
                 return CXL_MBOX_INVALID_EXTENT_LIST;
             }
+        } else if (type == DC_EVENT_RELEASE_CAPACITY) {
+            if (!ct3_test_region_block_backed(dcd, ext.start_dpa, ext.len)) {
+                return CXL_MBOX_INVALID_PA;
+            }
         }
     }
 
@@ -3777,6 +3781,51 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
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
+    int rc;
+
+    switch (in->flags & CXL_EXTENT_REMOVAL_POLICY_MASK) {
+    case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE:
+        rc = cxl_mbox_dc_prescriptive_sanity_check(ct3d,
+                                                   in->host_id,
+                                                   in->ext_count,
+                                                   in->extents,
+                                                   DC_EVENT_RELEASE_CAPACITY);
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
@@ -3919,6 +3968,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
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
diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
index 72ea0a7d44..7ac6cb9f34 100644
--- a/include/hw/cxl/cxl_opcodes.h
+++ b/include/hw/cxl/cxl_opcodes.h
@@ -67,5 +67,6 @@ enum {
         #define SET_DC_REGION_CONFIG 0x2
         #define GET_DC_REGION_EXTENT_LIST 0x3
         #define INITIATE_DC_ADD           0x4
+        #define INITIATE_DC_RELEASE       0x5
     GLOBAL_MEMORY_ACCESS_EP_MGMT = 0X59
 };
-- 
2.47.2


