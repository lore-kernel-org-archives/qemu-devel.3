Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1F7CD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 17:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJxKM-00085c-AC; Mon, 04 May 2026 13:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wJxKE-00084A-RB
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:43:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wJxKB-0007li-IK
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:43:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777916598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=POg2kcrHtD7IxbfH3c9M90/eSffzpD9OEInNvAEthqM=;
 b=bgnLT85ADa2e8jlf7VST9LnxIZaHbdMm1KQqrBFeIy/DgubaU+pmfloRJi5ZZ7mmCeCMVQ
 wQ2CFHVwPzOvzqS4Qxpu/y7YwdaKLk5lBKcAQEVcfuibxECCJJLduB8LAM+F1MjwiCFsoA
 jsuHsQS0pn2CX2tzJtn4D/DP+k/OoaA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-8AQjMHVdO1SUoOHzu2jc6Q-1; Mon, 04 May 2026 13:43:17 -0400
X-MC-Unique: 8AQjMHVdO1SUoOHzu2jc6Q-1
X-Mimecast-MFC-AGG-ID: 8AQjMHVdO1SUoOHzu2jc6Q_1777916596
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b249975139so83761965ad.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 10:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777916596; x=1778521396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=POg2kcrHtD7IxbfH3c9M90/eSffzpD9OEInNvAEthqM=;
 b=ls/hj5dKfUuiUDArttv1mH6UAsuCXCBnXe+VktZCv9VQoVn+KQ/3cSCsObeyb5Tgqz
 LUIRdxsxl7ZCiJYyB6uEG1MC3UoNWJRgaNOuDfoHa2sdvJOCMn5iuJkjVgdasSnv70AT
 MunUjE1n6jNMjT7eGxMClMmz5c35gOMdfhqzEggxXRdjhRucoGMR8YGrEmT8cyx0apvI
 3bAVqFkEkF14Tc9CvofcK4FuGJcH8v+HfidlmZ9NLEl/5aIeaQsuv+JD33JTU9gsg+Rx
 5lmiG7gu7ww78mJ+eugjTCkkcfkzIWvzwNt3+CDlOE8rgVwbxp33QZjQqDgTbYxxFe5C
 45Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777916596; x=1778521396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=POg2kcrHtD7IxbfH3c9M90/eSffzpD9OEInNvAEthqM=;
 b=daVuFd9EYmE18A5ZejKnb0OpMcaVPXWJqVKImBMUh9rhsisMvEXc5pYMiEVYt2qWeA
 2FrrS2CLmcpdBYS06aZvnoHWwuzoRqQr8/6ksru4qczDk+HCG8scDrOuGNTQPHHKNQBL
 46lH+FzMcyv+Ovz4m8YLupwifeCyKAw1QrltDCgWyxdCcuW3sdr+qzFitjzm75suHlcj
 MKngtasG2gQaFIO4ETmXaPtEpXGUitmP5/4y3FqM8DYbFn2SOmNTrRc7lkHxVdNw9pBJ
 bZfKAstlU5bjSRRu29NlK6MBaSAaFPfl/Y1a48r4NqNKKT2pdfm4ApNHL5l3Zd3Y119r
 jw/Q==
X-Gm-Message-State: AOJu0YzBP/X4KbVNQpA6CtEukdLv0aCb9+kTOBSq68/yDkdqoAvsQCVa
 R/ED1308yEeU4hQEk8lgXbY+PFYLEr5ODy2oqNFWWSfMEL50gKJPT9zt0EkBchmYgKiBbRvo8XD
 Ap1ZpbLWtne2UO+oM6DasBwN4v/uIPFC0jtSfUoXo4J7QpkdjfPnf4qTVLvbgCvQ64leHxF3vWV
 N/vFY4+2GImHBO+k5R0CPvbeWN72SYiLbaCcYmLrU=
X-Gm-Gg: AeBDiet5iNh+16vGc1226YEbrJAXjXThMXUhVM6FVf4KaU834ilMc2SyTUx81HXMpaS
 GmhXlJhYETMFtorR50t8dOAUqqc1FXAlGq3fXCkjYTtococ7db413l3Kd/ef/0jvuQFY4EPkr7k
 Nuju4XafNhbruG2X3blkhXoUTAd1YNmKMskhlCy7LDFRXAeB4qtdgarWvN54UCQNbiGneVRcFy7
 rCiN/V+qgD6pJcJGL2q8BuvU0m3iOmDD5x0zOnsQ5bRmIrx1k5oMvfpLtBzOL6IRxlJubsPNCKs
 tJ3EyZPfqXpSe5i1oZGd7s5q/0FKLTKdpVD/puyBT2lk8w2GL4jQKyfiB+w6n2BiSdU1pz/4Ega
 zVtpk4OpmNbVYhPkMm+qlxBo9JtZ3xz+YvaTvDzMwxKKP+X9M5PHZhvtJNGMLxMgDpTDlh60s
X-Received: by 2002:a17:903:1acd:b0:2b2:501c:bc0 with SMTP id
 d9443c01a7336-2b9f2533e8emr99468495ad.7.1777916595717; 
 Mon, 04 May 2026 10:43:15 -0700 (PDT)
X-Received: by 2002:a17:903:1acd:b0:2b2:501c:bc0 with SMTP id
 d9443c01a7336-2b9f2533e8emr99468125ad.7.1777916595043; 
 Mon, 04 May 2026 10:43:15 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.108.92])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9caaaec82sm112765315ad.24.2026.05.04.10.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 10:43:14 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, marcandre.lureau@redhat.com,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v6 4/6] hw/tpm: Implement TPM CRB chunking logic
Date: Mon,  4 May 2026 23:12:32 +0530
Message-ID: <20260504174234.13556-5-armenon@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504174234.13556-1-armenon@redhat.com>
References: <20260504174234.13556-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Arun Menon <armenon@redhat.com>

- Add logic to populate internal TPM command request and response
  buffers and to toggle the control registers after each operation.
- The chunk size is limited to CRB_CTRL_CMD_SIZE which is
  (TPM_CRB_ADDR_SIZE - A_CRB_DATA_BUFFER). This comes out as 3968 bytes
  (4096 - 128 or 0x1000 - 0x80), because 128 bytes are reserved for
  control and status registers. In other words, only 3968 bytes are
  available for the TPM data.
- With this feature, guests can send commands larger than 3968 bytes.
- Refer section 6.5.3.9 of [1] for implementation details.

[1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_Pub.pdf

Signed-off-by: Arun Menon <armenon@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_crb.c | 154 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 137 insertions(+), 17 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 1c944d7ef2..5572d89268 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -17,6 +17,7 @@
 #include "qemu/osdep.h"
 
 #include "qemu/module.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "system/address-spaces.h"
 #include "hw/core/qdev-properties.h"
@@ -66,6 +67,7 @@ DECLARE_INSTANCE_CHECKER(CRBState, CRB,
 #define CRB_INTF_CAP_CRB_CHUNK 0b1
 
 #define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - A_CRB_DATA_BUFFER)
+#define TPM_HEADER_SIZE 10
 
 enum crb_loc_ctrl {
     CRB_LOC_CTRL_REQUEST_ACCESS = BIT(0),
@@ -81,6 +83,8 @@ enum crb_ctrl_req {
 
 enum crb_start {
     CRB_START_INVOKE = BIT(0),
+    CRB_START_RSP_RETRY = BIT(1),
+    CRB_START_NEXT_CHUNK = BIT(2),
 };
 
 enum crb_cancel {
@@ -123,6 +127,69 @@ static uint8_t tpm_crb_get_active_locty(CRBState *s)
     return ARRAY_FIELD_EX32(s->regs, CRB_LOC_STATE, activeLocality);
 }
 
+static bool tpm_crb_append_command_request(CRBState *s)
+{
+    /*
+     * The linux guest writes the TPM command to the MMIO region in chunks.
+     * This function appends a chunk from the MMIO region to internal
+     * command_buffer.
+     */
+    void *mem = memory_region_get_ram_ptr(&s->cmdmem);
+    uint32_t to_copy = 0;
+    uint32_t total_request_size = 0;
+
+    /*
+     * The initial call extracts the total TPM command size
+     * from its header. For the subsequent calls, the data already
+     * appended in the command_buffer is used to calculate the total
+     * size, as its header stays the same.
+     */
+    if (s->command_buffer->len == 0) {
+        total_request_size = tpm_cmd_get_size(mem);
+        if (total_request_size < TPM_HEADER_SIZE) {
+            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS, tpmSts, 1);
+            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, Start, 0);
+            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, nextChunk, 0);
+            tpm_crb_clear_internal_buffers(s);
+            error_report("Command size %" PRIu32 " less than "
+                         "TPM header size %" PRIu32,
+                         total_request_size, (uint32_t)TPM_HEADER_SIZE);
+            return false;
+        }
+    } else {
+        total_request_size = tpm_cmd_get_size(s->command_buffer->data);
+    }
+    total_request_size = MIN(total_request_size, s->be_buffer_size);
+
+    if (total_request_size > s->command_buffer->len) {
+        uint32_t remaining = total_request_size - s->command_buffer->len;
+        to_copy = MIN(remaining, CRB_CTRL_CMD_SIZE);
+        g_byte_array_append(s->command_buffer, (guint8 *)mem, to_copy);
+    }
+    return true;
+}
+
+static void tpm_crb_fill_command_response(CRBState *s)
+{
+    /*
+     * Response from the tpm backend will be stored in the internal
+     * response_buffer. This function will serve that accumulated response
+     * to the linux guest in chunks by writing it back to MMIO region.
+     */
+    void *mem = memory_region_get_ram_ptr(&s->cmdmem);
+    uint32_t remaining = s->response_buffer->len - s->response_offset;
+    uint32_t to_copy = MIN(CRB_CTRL_CMD_SIZE, remaining);
+
+    memcpy(mem, s->response_buffer->data + s->response_offset, to_copy);
+
+    if (to_copy < CRB_CTRL_CMD_SIZE) {
+        memset((guint8 *)mem + to_copy, 0, CRB_CTRL_CMD_SIZE - to_copy);
+    }
+
+    s->response_offset += to_copy;
+    memory_region_set_dirty(&s->cmdmem, 0, CRB_CTRL_CMD_SIZE);
+}
+
 static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
                                uint64_t val, unsigned size)
 {
@@ -153,20 +220,61 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
         }
         break;
     case A_CRB_CTRL_START:
-        if (val == CRB_START_INVOKE &&
-            !(s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) &&
-            tpm_crb_get_active_locty(s) == locty) {
-            void *mem = memory_region_get_ram_ptr(&s->cmdmem);
-
-            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, Start, 1);
-            s->cmd = (TPMBackendCmd) {
-                .in = mem,
-                .in_len = MIN(tpm_cmd_get_size(mem), s->be_buffer_size),
-                .out = mem,
-                .out_len = s->be_buffer_size,
-            };
-
-            tpm_backend_deliver_request(s->tpmbe, &s->cmd);
+        if (tpm_crb_get_active_locty(s) != locty) {
+            break;
+        }
+        if (s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
+            /*
+             * Backend TPM is busy processing a request.
+             */
+            break;
+        }
+        if (val & CRB_START_INVOKE) {
+            if (!(s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE)) {
+                if (!tpm_crb_append_command_request(s)) {
+                    break;
+                }
+                ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, Start, 1);
+                g_byte_array_set_size(s->response_buffer, s->be_buffer_size);
+                s->cmd = (TPMBackendCmd) {
+                    .in = s->command_buffer->data,
+                    .in_len = s->command_buffer->len,
+                    .out = s->response_buffer->data,
+                    .out_len = s->response_buffer->len,
+                };
+                tpm_backend_deliver_request(s->tpmbe, &s->cmd);
+            }
+        } else if (val & CRB_START_NEXT_CHUNK) {
+            if (!s->cap_chunk) {
+                break;
+            }
+            /*
+             * nextChunk is used both while sending and receiving data.
+             * To distinguish between the two, response_buffer is checked.
+             * If it does not have data, then that means we have not yet
+             * sent the command to the tpm backend, and therefore call
+             * tpm_crb_append_command_request().
+             */
+            if (s->response_buffer->len > 0 &&
+                s->response_offset < s->response_buffer->len) {
+                tpm_crb_fill_command_response(s);
+            } else {
+                if (!tpm_crb_append_command_request(s)) {
+                    break;
+                }
+            }
+            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, nextChunk, 0);
+        } else if (val & CRB_START_RSP_RETRY) {
+            if (!s->cap_chunk) {
+                break;
+            }
+            if (s->response_buffer->len > 0) {
+                trace_tpm_crb_mmio_write(addr, size, val);
+                s->response_offset = 0;
+                tpm_crb_fill_command_response(s);
+            }
+            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, crbRspRetry, 0);
+            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, nextChunk, 0);
         }
         break;
     case A_CRB_LOC_CTRL:
@@ -211,8 +319,21 @@ static void tpm_crb_request_completed(TPMIf *ti, int ret)
     if (ret != 0) {
         ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
                          tpmSts, 1); /* fatal error */
+        tpm_crb_clear_internal_buffers(s);
+    } else {
+        uint32_t actual_resp_size = tpm_cmd_get_size(s->response_buffer->data);
+        uint32_t total_resp_size = MIN(actual_resp_size, s->be_buffer_size);
+        g_byte_array_set_size(s->response_buffer, total_resp_size);
+        s->response_offset = 0;
     }
-    memory_region_set_dirty(&s->cmdmem, 0, CRB_CTRL_CMD_SIZE);
+    /*
+     * Send the first chunk. Subsequent chunks will be sent
+     * on receiving nextChunk from the guest
+     */
+    tpm_crb_fill_command_response(s);
+    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, nextChunk, 0);
+    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, crbRspRetry, 0);
+    g_byte_array_set_size(s->command_buffer, 0);
 }
 
 static enum TPMVersion tpm_crb_get_version(TPMIf *ti)
@@ -287,8 +408,7 @@ static void tpm_crb_reset(void *dev)
     s->regs[R_CRB_CTRL_RSP_SIZE] = CRB_CTRL_CMD_SIZE;
     s->regs[R_CRB_CTRL_RSP_ADDR] = TPM_CRB_ADDR_BASE + A_CRB_DATA_BUFFER;
 
-    s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->tpmbe),
-                            CRB_CTRL_CMD_SIZE);
+    s->be_buffer_size = tpm_backend_get_buffer_size(s->tpmbe);
 
     if (tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_size) < 0) {
         exit(1);
-- 
2.54.0


