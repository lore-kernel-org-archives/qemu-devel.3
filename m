Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EE3FED2C8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 04:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0XUB-000085-NF; Thu, 12 Mar 2026 00:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w0XU7-00007l-Sc
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w0XU4-0008NT-LW
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 00:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773289035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9pL8kP9UQL8dUaqHGVHVwkA0K6NVXnOF01OJHrxYgrc=;
 b=iUUSfJV5Xp5xVxclXohPUDNZVhcQVD8gH/INchqhNCU9PXL/HhRtHwsZCpPF06XuL3O99j
 SPssztWac3NgJ5QJaI1If758buOZHUk0zl7im7mba3NfxSgvIzbRmWto28o9BsGiN+A6t/
 g+giQmvgtfQKujAUmiK+32QcyZoanYA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-sZLelzITMx63v-7qq9lw-A-1; Thu, 12 Mar 2026 00:17:13 -0400
X-MC-Unique: sZLelzITMx63v-7qq9lw-A-1
X-Mimecast-MFC-AGG-ID: sZLelzITMx63v-7qq9lw-A_1773289032
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ae44db60c2so6917715ad.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 21:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773289032; x=1773893832; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9pL8kP9UQL8dUaqHGVHVwkA0K6NVXnOF01OJHrxYgrc=;
 b=Dxh3eW3jPSd3bwdGXaeri2LhxmCsw0pUnHsw/XEp+A9oDkZ6Zhjf0Kgf+WeJlzc3b0
 JUMGwnRSTMINevGfsXJMZfbpuXAe6rwDOlMcQo8XEMj+odZxqgkL8I1JZHdkJ2HS7gDU
 d3NxQbo4mPjzcb1KsP8VFJTVUvcXNeb/jWOj+LUjSMztqM+8TENJKmDIWjnfddjhD8sI
 fCf6qxA4pGTqSIK/2f06JTw2sCmO/T9YwGdC/vYTqClmJuTLMP1kmhCKjvFCdQc4qoYk
 TADfBYpt+K4C7Y2RaJKQOrrZFNhi2JWIM0mG6xzdlKhJDnallTlCxGm9EOTHf5vcyOJv
 4Wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773289032; x=1773893832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9pL8kP9UQL8dUaqHGVHVwkA0K6NVXnOF01OJHrxYgrc=;
 b=w9bfOiKoIrC3+H2ny2VaNKUqmK8kp5aVL4b5eYcZs+fsFGMVSApV/4in9X8og9UWzr
 NdG5UODOuHtKjLj6C9sRo46K/Bi6utI1nMLyPIXdqHxvji0g047LnktvwAkdo5MdXsjH
 SMMg6htEAjWhHl22idmp1KOup23QABVZ31GLm+iUo2A9X8adHz6cd6lXNaMeqWEOBWbV
 5mlKzS4yrclUcZzf3LyttjZmXRRii7ENNXco3xo7hjKAKfwi1xbfVaNH0jHWaSuvxu9B
 gwrC7dyRP/tkIn+hPcG2MWMKnPEDecuewW0lu4jxBONP8hZ2ArBD7eiiN4kekJqM9f9b
 vGkA==
X-Gm-Message-State: AOJu0YwznICR3jGguBwevfvYY3o49Bheo0oe92GqOLrpS6oNy0KrY1MN
 nwO9+92fxVPWZFUQWSeu3ZW70sC+iwixuBn6QGYttJdJaSjKtYlK7rvj3OD5d0+gbZtmPk/cnQc
 dLAvONk/ufBxWOr1TtBgc1fEggkgn+MGMuN+9xTfDUBxOu86i5DF70aLsgtMMSGRK38AVvY1W3/
 +mvyPJAib0CvJZjVeY3DOoMvFl1AsNNWvBcIxqpJk=
X-Gm-Gg: ATEYQzzPOgpLQNO9YAa4JKEFFvRVz/hiG9zYs65IY7thexxhEQ1+y3G1TuywZNiRjZY
 9KL10EBY2Qqjoigfpy3OQMrPt/kCedLZmOtkkvP8HobF0xGi9M6qM7UGEkhGS49bmVJEv6XUAts
 yhz1BrRRKPJrlNzHgvcKMZ9SNh1dbfS5pEkvyJ/ZM3kXvLK2LOSTw9CUVhLMNhCsVSFsWqMC5YO
 ZrOaj26LZduIwmHtZupRUqEXMZp3bUIqAEPb0cL8I+wbDA3dcov2VntQ6X6Qtwaq2hC/AMG/jZT
 Q7BpmidOz+OVxdPoKUnh4pDf+eXGxEozl+3wBOwIKUy7lf5i01C1rD15vTaOWtLruwE3WOjo6he
 m4IWic9Uqmew4Au/qLpH3FspBf9lHrkie8pAxUDPMohBSj1Hj3JTFxH8IAabXqg==
X-Received: by 2002:a17:902:e88f:b0:2ad:ba80:df62 with SMTP id
 d9443c01a7336-2aeae892983mr54604865ad.37.1773289031828; 
 Wed, 11 Mar 2026 21:17:11 -0700 (PDT)
X-Received: by 2002:a17:902:e88f:b0:2ad:ba80:df62 with SMTP id
 d9443c01a7336-2aeae892983mr54604515ad.37.1773289031209; 
 Wed, 11 Mar 2026 21:17:11 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c73cdf0e498sm3634490a12.3.2026.03.11.21.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 21:17:10 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 marcandre.lureau@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Arun Menon <armenon@redhat.com>
Subject: [RFC 4/5] hw/tpm: Implement TPM CRB chunking logic
Date: Thu, 12 Mar 2026 09:46:49 +0530
Message-ID: <20260312041650.181411-5-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312041650.181411-1-armenon@redhat.com>
References: <20260312041650.181411-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
 hw/tpm/tpm_crb.c | 138 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 122 insertions(+), 16 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 5ea1a4a970..845f9c6c9f 100644
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
@@ -122,6 +126,58 @@ static uint8_t tpm_crb_get_active_locty(CRBState *s)
     return ARRAY_FIELD_EX32(s->regs, CRB_LOC_STATE, activeLocality);
 }
 
+static bool tpm_crb_append_command_request(CRBState *s)
+{
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
@@ -152,20 +208,48 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
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
@@ -205,13 +289,36 @@ static const MemoryRegionOps tpm_crb_memory_ops = {
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
@@ -288,8 +395,7 @@ static void tpm_crb_reset(void *dev)
     s->regs[R_CRB_CTRL_RSP_SIZE] = CRB_CTRL_CMD_SIZE;
     s->regs[R_CRB_CTRL_RSP_ADDR] = TPM_CRB_ADDR_BASE + A_CRB_DATA_BUFFER;
 
-    s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->tpmbe),
-                            CRB_CTRL_CMD_SIZE);
+    s->be_buffer_size = tpm_backend_get_buffer_size(s->tpmbe);
 
     if (tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_size) < 0) {
         exit(1);
-- 
2.53.0


