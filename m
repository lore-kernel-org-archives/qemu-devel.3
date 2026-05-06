Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C778CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 07:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKX9f-00052Q-8R; Wed, 06 May 2026 03:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wKX9e-00050B-4o
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:58:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wKX9c-0000g5-5B
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:58:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778054327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7CPWgNB13IdLZBd87QRLaWoqkdY/Umw55r84ixp/UY=;
 b=QDz/7ytPqtIGUuZChZ1vHaDB3IQwz4ZlnHlKlyKwL34oeEIyMLforull9xlqFY+ucWRoea
 11WLee7+KDTiYDc9FOAxLIKpYQIEWUDTutBX8R2PV7CzriAh7BQ+46iKDgnZPowJTVmHgY
 9+I6fn4cv2V8DxX+rMrBAvlUHK+yp4o=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-Dcc2FReKNi-5cssczkpKsg-1; Wed, 06 May 2026 03:58:45 -0400
X-MC-Unique: Dcc2FReKNi-5cssczkpKsg-1
X-Mimecast-MFC-AGG-ID: Dcc2FReKNi-5cssczkpKsg_1778054324
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b9b8137828so55823275ad.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 00:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778054324; x=1778659124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c7CPWgNB13IdLZBd87QRLaWoqkdY/Umw55r84ixp/UY=;
 b=j8eezvrzHbiUvt0WiCOyw3ylf8cb3GJRSl6aXQMbhqvryRrjA0onUI8PZMR/HJRGHe
 eTtNjUNT4DI5JbHdE4R7cp0rtJBypCW2dMLpY9by3imBMqhQPOeC0/riuf7Wj6aOR4lE
 JueeF/qP1SC1NraEH6UYWXJOsAwtxCnpOFWWQx1eXMi7+7krQdC/gZrdgupsm7PiRbni
 fXEn6LXl55LnRzkrer/2FGaR3HBC4PAo9qUxD+vOhMqqDAycAgu5j62qg/df4uC3FsNt
 V7wxcs2grmET8xvVfwmfmKcaANVMVkYHket1jQBPgLLZmHyujmR7w15TYOt6HN23znVT
 Oijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778054324; x=1778659124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=c7CPWgNB13IdLZBd87QRLaWoqkdY/Umw55r84ixp/UY=;
 b=o9YT8fMQIRxbqeEQlK1DlhgFxz9uUhgHnYTYloeDRbE4Q7S2t53TwBGzvzu4NRIXAu
 nHmBL2cBjxcy1g+PtGq3QAR0/zM+LEE8H/gNbXk2Yma3mSS3J5ZQdrIpJqPBxEDuO890
 z92JmyZ5JmbmghesT61CazfxwGJCCUDEMZiCmdvhl+/oGqw3HNwhCmINKO5TUTGldri+
 NmIZ58wr3tAzuZqnqoY6VIcbOZoDo2SzCD0jSFw2WMxXrc3u0aXnpmcocJYqCV4ENKtK
 7D1XI1pd+gfUsyHy8xvN+VPMR4Z3qPgP3Z/9h8dgHFR964gPGKeAen9Cd8PGeBildSq6
 AeJQ==
X-Gm-Message-State: AOJu0YwJlFBK+vrF8qX3lj6jZuhBDU8htdM+hds4+wKFxbsDHMSAk6hp
 L8IY5pPwui5PTE3ISKw+DETxVxx/MrcgplHGqPzSEwBhZ0Z0mwPXxHwDlcKaRT76DJRbq14V7Yl
 SM42lGz7qUZkcgYLbQtwc8hyO+BEabVjlbRJ9hFrM9FV7qgwhacE7JDP3mKDKDAzvPT6nSXye3B
 u867BP1tfSWaTOYCWELimRjVVf0LO5dvH6fKC4gUk=
X-Gm-Gg: AeBDietqgMmKwHU0+i650cIL/KM04fY+1LMwLtRVOJpiYG/ng/hC6/GD6Ek2Kr4/hHH
 aDrOcG4LY4OHcLDBJxhAHrRUmqyWSrTIeH3XcCjwsp+DSQAJ8JAj82D7YG5ePP6jjd9Eqcil+3w
 zGLmcUO2ecE1GmgwSbPZuLZPl/QAJoKyRUb813N7TiafcT4OJ2jg9znZFvFH6Oe85gYN482cHj8
 Iw4czl//Xlb9gjv0f2na75sdrfhOm1gw2szyYCztmQr1boC/L3Lu+GJ1A20UVT6/4WyYzCesSe+
 kPTTegYf374crbpbsJLPRv8R88rtBRNgTvAlCNDlVWZO/BaPSt1sR+u11hfFpTZqdvmn5PFP3tm
 s+POeqdByWtfswf4weaXCNasyQlX2fmf6LXQgZr3wZ6buioL5WA3KlX6NBB07tvaFUyhKQfI6
X-Received: by 2002:a17:903:2903:b0:2b0:9c2b:641d with SMTP id
 d9443c01a7336-2ba78b3fe5dmr15330365ad.2.1778054323660; 
 Wed, 06 May 2026 00:58:43 -0700 (PDT)
X-Received: by 2002:a17:903:2903:b0:2b0:9c2b:641d with SMTP id
 d9443c01a7336-2ba78b3fe5dmr15330015ad.2.1778054322944; 
 Wed, 06 May 2026 00:58:42 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.106.26])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ba7ca29f9dsm15439865ad.78.2026.05.06.00.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 00:58:42 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v7 4/6] hw/tpm: Implement TPM CRB chunking logic
Date: Wed,  6 May 2026 13:28:11 +0530
Message-ID: <20260506075813.120781-5-armenon@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506075813.120781-1-armenon@redhat.com>
References: <20260506075813.120781-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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


