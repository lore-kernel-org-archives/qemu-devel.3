Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DF1CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 21:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUAao-0006fQ-NB; Mon, 01 Jun 2026 17:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAal-0006db-Ui
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wUAaj-0003sH-NE
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 17:54:39 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651EfdOT845711; Mon, 1 Jun 2026 21:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=vU08AW
 d9TKdGS/hLoR3NbvJ2iQVAPYnf8MPTdmm9VdY=; b=Q98Qzfef6Gh+ip3nSmMKrH
 +N6c6q7ocb/Apc04scDekAxyODPyH2jDUhHf7QCXXPav/8x7N5KCbHkxuH2t7Z6t
 86zTAdUHR81iGQb9JezLAmPf0CtkYv+m0SHBhcnMRVmBkg94TSEqlZqTFHQAIiy0
 Rxt8QjqnYzzeCyq4k09ILiDaLheeod0lq7bYsjpxForRKWy7Ml3jXlG4WmHVcLul
 0OxXhD5d9gmyFE7tQglakPMMCccy9/PtTeO+0Ooe8THNJcx6SZ7iYZ38cmpY9On8
 7bnSyMA4NXLPKXB7xSPWrg1POsMIxHLpBZtAGAjzLTBWqWlocamfKSnCXzuMJKcA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjq32da-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 651LsGaV029603;
 Mon, 1 Jun 2026 21:54:34 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k09b2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 01 Jun 2026 21:54:34 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 651LsXtv31326758
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 1 Jun 2026 21:54:33 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1C3AD58054;
 Mon,  1 Jun 2026 21:54:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 86C505805D;
 Mon,  1 Jun 2026 21:54:32 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  1 Jun 2026 21:54:32 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v1 12/16] hw/tpm: Implement TPM CRB chunking logic
Date: Mon,  1 Jun 2026 17:54:05 -0400
Message-ID: <20260601215410.517009-13-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601215410.517009-1-stefanb@linux.ibm.com>
References: <20260601215410.517009-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Z8fwNMGuaFbEyld7vf4B3DX61R2WLszp
X-Proofpoint-GUID: Z8fwNMGuaFbEyld7vf4B3DX61R2WLszp
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a1dff9b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=xt6ew7UTAAAA:8
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=21JJ9ZgAsrre8Uwrx8wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=tn93DeGZTgJ6DdWMtdD4:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDIxMSBTYWx0ZWRfX2+hmHvy1NcRZ
 1YygodwT2ooB1EEScwHA6qrkmd028xFz66PrG9K4qsWcdPIz4VdGaX61wwdHLssOQs6/6EQcxws
 cR9CruFgIZbQ6ZxB7enxND7QkhOBkCa7szJCmfPDIJ0vJ+nAbrqgvnOasELnNQSB4rn7AT6kWcu
 MUJmtCn9Fl9g+1LTxWjkStbCe22oBNgcwxFkQ4vAf0IHq4IkCeWH2ieJ13Da0QP83MiFlhC1QFu
 PSDxQ1QJ8tn4ge9TN5wRhcHQqtX1+iPji5ASei/SYn6e4V671wLvjKAIwKdspMPZsu6RlPfr2Tp
 bEyWlShI6CpZvGBfjfYa2b+YgLDqLlmwdJRG/B/6nJrEbcoSkuW4aMVGVa1m5V/WT1JHoMU3GRU
 MQoZEcBbdwnnEdJ54AqxqVyovH5fNUExySz68ThBM1+yrN0gI1CRd1HTDUqeqZrgBURdeDS8ugt
 occ/JHZBiffQDevJnww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010211
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Link: https://lore.kernel.org/qemu-devel/20260506075813.120781-5-armenon@redhat.com
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_crb.c | 143 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 130 insertions(+), 13 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 1c944d7ef2..f85df08185 100644
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
@@ -153,20 +220,58 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
         }
         break;
     case A_CRB_CTRL_START:
-        if (val == CRB_START_INVOKE &&
-            !(s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) &&
-            tpm_crb_get_active_locty(s) == locty) {
-            void *mem = memory_region_get_ram_ptr(&s->cmdmem);
-
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
+            if (!tpm_crb_append_command_request(s)) {
+                break;
+            }
             ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, Start, 1);
+            g_byte_array_set_size(s->response_buffer, s->be_buffer_size);
             s->cmd = (TPMBackendCmd) {
-                .in = mem,
-                .in_len = MIN(tpm_cmd_get_size(mem), s->be_buffer_size),
-                .out = mem,
-                .out_len = s->be_buffer_size,
+                .in = s->command_buffer->data,
+                .in_len = s->command_buffer->len,
+                .out = s->response_buffer->data,
+                .out_len = s->response_buffer->len,
             };
-
             tpm_backend_deliver_request(s->tpmbe, &s->cmd);
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
+                s->response_offset = 0;
+                tpm_crb_fill_command_response(s);
+            }
+            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, crbRspRetry, 0);
+            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, nextChunk, 0);
         }
         break;
     case A_CRB_LOC_CTRL:
@@ -211,8 +316,21 @@ static void tpm_crb_request_completed(TPMIf *ti, int ret)
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
@@ -287,8 +405,7 @@ static void tpm_crb_reset(void *dev)
     s->regs[R_CRB_CTRL_RSP_SIZE] = CRB_CTRL_CMD_SIZE;
     s->regs[R_CRB_CTRL_RSP_ADDR] = TPM_CRB_ADDR_BASE + A_CRB_DATA_BUFFER;
 
-    s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->tpmbe),
-                            CRB_CTRL_CMD_SIZE);
+    s->be_buffer_size = tpm_backend_get_buffer_size(s->tpmbe);
 
     if (tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_size) < 0) {
         exit(1);
-- 
2.54.0


