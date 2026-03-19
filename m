Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F3D109022B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 13:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Doz-0005ol-TV; Thu, 19 Mar 2026 09:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w3Dor-0005im-Lw
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 09:53:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w3Dop-000194-Ou
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 09:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773928427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hf079Y/m3kO1LPhEzEnZCyPp1ng+shFS8YzdsaWuWYs=;
 b=jT/Rgm3XV3+EYW7GVeYkGpmAR4r7mohdHQtR2YgPcGQgmn9a2ViiOkHGsEXfHhHH2AvtdP
 5E+wiLpo+w3bLCNQ6NLqhEv0auTBogVjSYafDDtuhyX6O0IXWjf8cQEIkEDHMsGbhols1V
 tlDuZ55vcGuVc3eLO0ps0iVH/Ccz+IM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-6BVCks1WMRycIYO7L9m-eA-1; Thu, 19 Mar 2026 09:53:46 -0400
X-MC-Unique: 6BVCks1WMRycIYO7L9m-eA-1
X-Mimecast-MFC-AGG-ID: 6BVCks1WMRycIYO7L9m-eA_1773928424
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b068299665so15664165ad.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 06:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773928424; x=1774533224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hf079Y/m3kO1LPhEzEnZCyPp1ng+shFS8YzdsaWuWYs=;
 b=Jox8tKynQH9zB5/2VzS25/QfIAJrVrQOyjW9Jz1c2JMgo5MWxHO6UAtMMGK2KCDFC9
 J7o87pnrHKgl4/jbA39YKE9xWFEl0Yo+vv/hFfk6eoZZYI+6wwJQ3/VxlP1oOAxbvfkd
 wcZpQFTyagdVQh+IAkgLW8EoJF1eNXGFI39pJlfKOfIxci98EJ5Nxh1rYavSVq/9HfLS
 3PCcdLhYu+oM9633qlbuDwb6UxC84qQUGLTsFdXuD2y8uPls7oAlHQBNutcVKCsm9aLR
 r1D1ccwEzfhPc98uQ86wceb7M7M3y5DgEF44PX8L1tOHOXzpo/ZbP6u4P6ecuF6b9ESH
 f5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773928424; x=1774533224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hf079Y/m3kO1LPhEzEnZCyPp1ng+shFS8YzdsaWuWYs=;
 b=jnA3+oPXt7GS+ZfYLux5LjXfMlG84+goJkvFj1/NL4E0qnOM7RdamGwFJ84hu8YFUz
 SKjDdCwXGwDAlHZL4S7nVn9MwgRnsbLlFWQYfKmLWwhezQquIiHePtVeDOphRClysukO
 ObLaQjl3Kp5UoNxB8sYDKV02gnvFbstVUq/4/8LpKMYkTASO0ndS3unV66wFMG7VYyL4
 anu0eyeUD+b562JPH+GwqxTBdeTDkgvTZp6ktqFflFpVTtISDWRP5QjxSMJoc8mfqGBu
 lxLd69HwIM611zq3rADLpQ7InjddOXUvTST1ugCGF+dDRTNbIktNkOaJhp7n4w1crRta
 yjOA==
X-Gm-Message-State: AOJu0YwCpqF1KcXMAniQnyQOo02o8AOuWtCS8sPUosYEghgXhTJl5NMU
 D/PrF1I/UuHG7YQdczsc8qwwQsEbnuacWL306cRaSfBG+3EIrUxf9LvkckuxQ1gWewMiJxu7oP2
 erduCT1fP/zrY+nmye+WaMFxobC0hvhVIO0fHZRkRnst7AnRgpoKx35c3IM9oEVJDJYVv+ix3vM
 bD6W6HYEMtZZU08B4MnMk9fxEcFF8fXA11HguanMw=
X-Gm-Gg: ATEYQzxXzmhAYsxjxM2EmnAXTeZc2o99EoAqmBefm8CAjsGWJk1FYbYWiTHdsw8bZix
 MdIg1XZK2nFhvrI1SwIG/rSc7xX++YPEqjH+DhB2LpqUsURCZ9R2A491l+PT7MVFqXxiKcWWb7X
 QkTiOnKBrzDquSbwZ85Ouzms09sbzK9It8/rDO2j1bXjNKYMyVDi1yzYkaUvg3x3I+FVot2yiNB
 YckZ8RjeV983AprD2vb19S1POVtXvYzRKfOkuBQa7PITTnU4lwGhCABdFGWN598MZMO8uq0khSb
 pNU7TrbKpcpwiLNalIrjkFEfrNxwxSj8iwTKV9YLjI80jJg8Eg/ENB562+HC/TYMwns3IudA9vm
 ZaXdAPix5y097vZh1M57eN8uKQNkSXTdfDG+n3Ui/kJTt3Xobccbf88EzZGpNFA==
X-Received: by 2002:a17:902:d4d2:b0:2ae:825b:49a5 with SMTP id
 d9443c01a7336-2b06e1fe6b0mr80211785ad.0.1773928423558; 
 Thu, 19 Mar 2026 06:53:43 -0700 (PDT)
X-Received: by 2002:a17:902:d4d2:b0:2ae:825b:49a5 with SMTP id
 d9443c01a7336-2b06e1fe6b0mr80211395ad.0.1773928422955; 
 Thu, 19 Mar 2026 06:53:42 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.104.12])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e6216c5sm77287025ad.73.2026.03.19.06.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 06:53:42 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, marcandre.lureau@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC v2 4/7] hw/tpm: Implement TPM CRB chunking logic
Date: Thu, 19 Mar 2026 19:23:13 +0530
Message-ID: <20260319135316.37412-5-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319135316.37412-1-armenon@redhat.com>
References: <20260319135316.37412-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 hw/tpm/tpm_crb.c | 148 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 132 insertions(+), 16 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 5ea1a4a970..e61c04aee0 100644
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
+    CRB_START_RESP_RETRY = BIT(1),
+    CRB_START_NEXT_CHUNK = BIT(2),
 };
 
 enum crb_cancel {
@@ -122,6 +126,68 @@ static uint8_t tpm_crb_get_active_locty(CRBState *s)
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
+            error_report("Command size '%d' less than TPM header size '%d'",
+                         total_request_size, TPM_HEADER_SIZE);
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
@@ -152,20 +218,48 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
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
+             * To distinguish between the two, response_buffer is checked
+             * If it does not have data, then that means we have not yet
+             * sent the command to the tpm backend, and therefore call
+             * tpm_crb_append_command_request()
+             */
+            if (s->response_buffer->len > 0 &&
+                s->response_offset < s->response_buffer->len) {
+                    tpm_crb_fill_command_response(s);
+            } else {
+                if (!tpm_crb_append_command_request(s)) {
+                    break;
+                }
+            }
+            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, nextChunk, 0);
+        } else if (val & CRB_START_RESP_RETRY) {
+            if (s->response_buffer->len > 0) {
+                s->response_offset = 0;
+                tpm_crb_fill_command_response(s);
+            }
+            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, crbRspRetry, 0);
+            ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, nextChunk, 0);
         }
         break;
     case A_CRB_LOC_CTRL:
@@ -205,13 +299,36 @@ static const MemoryRegionOps tpm_crb_memory_ops = {
 static void tpm_crb_request_completed(TPMIf *ti, int ret)
 {
     CRBState *s = CRB(ti);
+    void *mem = memory_region_get_ram_ptr(&s->cmdmem);
 
     ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 0);
     if (ret != 0) {
         ARRAY_FIELD_DP32(s->regs, CRB_CTRL_STS,
                          tpmSts, 1); /* fatal error */
+        tpm_crb_clear_internal_buffers(s);
+    } else {
+        uint32_t actual_resp_size = tpm_cmd_get_size(s->response_buffer->data);
+        uint32_t total_resp_size = MIN(actual_resp_size, s->be_buffer_size);
+        g_byte_array_set_size(s->response_buffer, total_resp_size);
+        s->response_offset = 0;
+
+        /*
+         * Send the first chunk. Subsequent chunks will be sent using
+         * tpm_crb_fill_command_response()
+         */
+        uint32_t to_copy = MIN(CRB_CTRL_CMD_SIZE, s->response_buffer->len);
+        memcpy(mem, s->response_buffer->data, to_copy);
+
+        if (to_copy < CRB_CTRL_CMD_SIZE) {
+            memset((guint8 *)mem + to_copy, 0, CRB_CTRL_CMD_SIZE - to_copy);
+        }
+        s->response_offset += to_copy;
     }
     memory_region_set_dirty(&s->cmdmem, 0, CRB_CTRL_CMD_SIZE);
+    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, invoke, 0);
+    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, nextChunk, 0);
+    ARRAY_FIELD_DP32(s->regs, CRB_CTRL_START, crbRspRetry, 0);
+    g_byte_array_set_size(s->command_buffer, 0);
 }
 
 static enum TPMVersion tpm_crb_get_version(TPMIf *ti)
@@ -288,8 +405,7 @@ static void tpm_crb_reset(void *dev)
     s->regs[R_CRB_CTRL_RSP_SIZE] = CRB_CTRL_CMD_SIZE;
     s->regs[R_CRB_CTRL_RSP_ADDR] = TPM_CRB_ADDR_BASE + A_CRB_DATA_BUFFER;
 
-    s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->tpmbe),
-                            CRB_CTRL_CMD_SIZE);
+    s->be_buffer_size = tpm_backend_get_buffer_size(s->tpmbe);
 
     if (tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_size) < 0) {
         exit(1);
-- 
2.53.0


