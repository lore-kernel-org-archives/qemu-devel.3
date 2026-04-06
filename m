Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539B0F46C47
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 14:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9kmZ-0003vC-AQ; Mon, 06 Apr 2026 10:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9kmV-0003uu-Ip
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:18:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9kmT-00053w-Ir
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775485100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7WOfrYNr8qdjwqalVNIDCmZ6n0sTZxk/tvJFpxXi1l8=;
 b=ivwgUre7J8JYBL3ODY4WFP0PaVssa4cuVrubfvbIxBqXMzt88/IKqzGCC1ViuVjfOaVehB
 xZrCZh46J1Zcxhb9rRU8ktBzaD7qZClh2VvUqZjePPx2Q/UDMk9oXSwx08o8tsde8ORnbt
 zULBeTUnEOpMhjrpOZBC/WXP1afr5GI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-R_FFpvZkNnuqieUV90t87g-1; Mon, 06 Apr 2026 10:18:19 -0400
X-MC-Unique: R_FFpvZkNnuqieUV90t87g-1
X-Mimecast-MFC-AGG-ID: R_FFpvZkNnuqieUV90t87g_1775485098
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b0c92ff4ebso53623725ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 07:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775485098; x=1776089898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7WOfrYNr8qdjwqalVNIDCmZ6n0sTZxk/tvJFpxXi1l8=;
 b=RT5m3C+CpkqBSJpwee64nXND3KSai5BRQT4jDq8d7QLfbnua5Gf1Uq+ykud7wFdlv5
 1HkT1+VtDczth9H3tnRLf0Ta1+biAIjjtXvpTbD2Od84Ok/zkuNErz/S5kuWrLX7ynbt
 xgDJEyK/K4cIOzIa3fllgBBxNgDgkc605DMsaAYGoxNJf6HxsUihLzVSXuLS03TRfV2K
 OnBFRhcyChXbfmd9bhktg2/5nZxZEwtY9UGmKn2PjbORoN++vsE2gN4vBAQTN7Pj1UP6
 gvEnUA9ubGGWKmXHKtMW1qtpHtXcuvYm39LC/LinBWndItwSc33eWLD2bi/59yD9LOon
 2RYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775485098; x=1776089898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7WOfrYNr8qdjwqalVNIDCmZ6n0sTZxk/tvJFpxXi1l8=;
 b=MLI+VSwRJAjvsTuLArxPjv5I6SQb9yjyJO3nvAWTF1rmavWvvD9xkrfxQ5q/HW3jt1
 SIfRvHZE70EsjMqCgF4SFgvBc072rQ927Qx0lXlArnumgJNB7TlQf6Y1DO9hZUSDx4Cx
 2rCh58UWE0iRtPZ0aDrEZvPF2UAoKyUHW0SQl762yUpmle9REA07uKP1flTTbHkC6zxc
 402igkbACtU7KDoEE+d+/aG6dXIukRp5zAr1SpXZ1yLxfReVQg4Dm6v4KQ/CGCMxOhv0
 9mkget+oXAaPLSZy5gvG1k8As/3oAFtCMehbkkt7YvMtcygoW6gL7HteAMuQZZ56N+Yh
 SNfA==
X-Gm-Message-State: AOJu0YwPcuSx9xzIMNY4Yw6LSlr12ykZiN8tVNaeP3LBMh6i5Un57TNC
 jvkCAqIJOmnYRuvI0u6QSutIRcs6LsRoXnSv3oqRxq5WH1Ex3Qr3tyoLX0BGZIKTFZScxYkkBam
 DBKdtdfuqZUJLCc57+SoYCVlgGqVNXBWm/PHr5QeZWyPeqTdj3NPsaB/L/AdBUfL1pxS1pkImTi
 eMdVs4xCEaipUrLFs76gajUNOENtSwoD+dl9dpRWk=
X-Gm-Gg: AeBDievkExAqrJmF5cNwW5r6ME5uJzsUvFYdK7LG9qQhhIlOns8ZsTgSVNusqzEDNKj
 0MEUTUPuVcgQugtXTOCOBzcMRGI729Ppzqd65YGt7QCifrXdOHLoLrgozKSNml/bJKHtCrIGTj0
 z3P88LnC60sEbg//RfJTxzkUCLeOJogS7qRIj8FoCMgkRptts9HN/yTvJUUl6U/SmYtFZQvZ3PV
 6HXtHf2sZE/Ktk/K1yINfNgQIMVjgqerGZawtS35ihxzuW6/9mUG9z4AHAst1llnd07w2eB16yW
 P6u8W+ECW/AoCFLBTNuJQ2Tw5k7bFnwPEJmV1pE435+gffnmmooe8yBpAVtsYv6BZpsP+yYaDac
 DFgwsn/V/6IyjWV/2IofbB63aCWLGeXqGVmsyB6qwP3Xvie2an7yBW8PV2SpYQkA6EAU=
X-Received: by 2002:a17:903:9ce:b0:2b0:65b8:b5b4 with SMTP id
 d9443c01a7336-2b2818fd5d3mr137028075ad.39.1775485098004; 
 Mon, 06 Apr 2026 07:18:18 -0700 (PDT)
X-Received: by 2002:a17:903:9ce:b0:2b0:65b8:b5b4 with SMTP id
 d9443c01a7336-2b2818fd5d3mr137027535ad.39.1775485097329; 
 Mon, 06 Apr 2026 07:18:17 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([152.59.100.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478cb4fsm156732905ad.29.2026.04.06.07.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 07:18:16 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 marcandre.lureau@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Arun Menon <armenon@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 04/10] hw/tpm: Implement TPM CRB chunking logic
Date: Mon,  6 Apr 2026 19:47:29 +0530
Message-ID: <20260406141735.25844-5-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406141735.25844-1-armenon@redhat.com>
References: <20260406141735.25844-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

[1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf

Signed-off-by: Arun Menon <armenon@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_crb.c | 148 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 131 insertions(+), 17 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index d65b3e2cc1..b9f295db7a 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -17,6 +17,7 @@
 #include "qemu/osdep.h"
 
 #include "qemu/module.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "system/address-spaces.h"
 #include "hw/core/qdev-properties.h"
@@ -65,6 +66,7 @@ DECLARE_INSTANCE_CHECKER(CRBState, CRB,
 #define CRB_INTF_CAP_CRB_CHUNK 0b1
 
 #define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - A_CRB_DATA_BUFFER)
+#define TPM_HEADER_SIZE 10
 
 enum crb_loc_ctrl {
     CRB_LOC_CTRL_REQUEST_ACCESS = BIT(0),
@@ -80,6 +82,8 @@ enum crb_ctrl_req {
 
 enum crb_start {
     CRB_START_INVOKE = BIT(0),
+    CRB_START_RSP_RETRY = BIT(1),
+    CRB_START_NEXT_CHUNK = BIT(2),
 };
 
 enum crb_cancel {
@@ -122,6 +126,69 @@ static uint8_t tpm_crb_get_active_locty(CRBState *s)
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
+            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 0);
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
@@ -152,20 +219,55 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
         }
         break;
     case A_CRB_CTRL_START:
-        if (val == CRB_START_INVOKE &&
-            !(s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) &&
-            tpm_crb_get_active_locty(s) == locty) {
-            void *mem = memory_region_get_ram_ptr(&s->cmdmem);
-
-            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 1);
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
+                ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 1);
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
@@ -210,8 +312,21 @@ static void tpm_crb_request_completed(TPMIf *ti, int ret)
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
@@ -288,8 +403,7 @@ static void tpm_crb_reset(void *dev)
     s->regs[R_CRB_CTRL_RSP_SIZE] = CRB_CTRL_CMD_SIZE;
     s->regs[R_CRB_CTRL_RSP_ADDR] = TPM_CRB_ADDR_BASE + A_CRB_DATA_BUFFER;
 
-    s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->tpmbe),
-                            CRB_CTRL_CMD_SIZE);
+    s->be_buffer_size = tpm_backend_get_buffer_size(s->tpmbe);
 
     if (tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_size) < 0) {
         exit(1);
-- 
2.53.0


