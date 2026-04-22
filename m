Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB2AF9B60C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUrW-0006nQ-SQ; Wed, 22 Apr 2026 06:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFUrD-0006il-S7
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:31:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFUrA-0006tU-RT
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776853855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NLr0qXJ7fAigQtbt+dX50644FqGIf04RPB9U5wAO/9w=;
 b=g7gCTnc/2/6UH4aQn0OVOp5X+1Add2ovDyrLYjd0RYhu9qarD75VT90OoTGH3ymOvnLeN1
 0zUi+v1NJQNWvsPplQHmFHsJ6DDkeJI4ptyysaJdLAb8UKoUyG0IjpBsyBTNgdC3vBTtBh
 CG1MUfJik+jq6q90O6rKcKOkl/ZwNjo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607--koioQ0VPlWsgEy8ES2Gbw-1; Wed, 22 Apr 2026 06:30:54 -0400
X-MC-Unique: -koioQ0VPlWsgEy8ES2Gbw-1
X-Mimecast-MFC-AGG-ID: -koioQ0VPlWsgEy8ES2Gbw_1776853853
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-358e95e81aeso3685983a91.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776853853; x=1777458653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NLr0qXJ7fAigQtbt+dX50644FqGIf04RPB9U5wAO/9w=;
 b=iHjTyPuQHQhDOkBj/h5Ek84P5tcB6yPZEGjQ7UXgEUZLftTP0wZazd04ETw280h4KT
 GC3d7giryQDtMwIM2XXR+X7FknvLHFBcxrvbPeQnk/DbEHgoxf/Hya7n7j5hv5b6ls4d
 VoXqQZx02ILen7lXVp6QHBE9kQZqd9SHfzgM9oXdItFOIbhMVw+vtYI3ULyJ+6gYHGlT
 oP18gODmj4czIJCwp9IA4ryRfEvKpFCly+/cZ38MZNH6rPulNxA0a03Qa2q6aCaYkSpN
 OJ4HlUUefAkwL2wPaGi519w3lYUOQFvSA0JL53KEiXXxzy3GG7GsQKLGpIHPBgEdMYXX
 lIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776853853; x=1777458653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NLr0qXJ7fAigQtbt+dX50644FqGIf04RPB9U5wAO/9w=;
 b=Sdh8E22064XwnKSOOX3Q6WVSVP0ksy2TZyGKnd7CKUmh/516a/Y1SpX/IUsBKX4VuU
 SSE45xKQSj6BYU2TIufya8dhn9V8fh0E1OdCSZxneWhdAqPosmDkmLVR6EbPKtVxRuFp
 gBAVdaRA4MuNq15EB4WjCOwRH3LBkVwb3GU78scGYbrOlOUJQ8whCIrAVVxJvbGOMwmN
 Hh7QpWHJ6UaQ33isrc8Gxe0pZ3mqnJIQl8+7hI+HTeqc0UeSj3eFHQuo55wN/PObMfwD
 Ce9eEVjYhYR/b7k438DFJgm997LW0P2Gh4SeeS00/uyqiUR7SxhABDduoZABWCF5iLxJ
 R0xg==
X-Gm-Message-State: AOJu0YzCTkKlWsbnMG8PnjjXi0RU8l2Nd1Y9gmsR4D9B0YcZdILBGIIE
 FZDZMgu7IppI1Xmaog6zjx2u5+AjS0FdI9oXelPPGzbVHyTu9hLOUNciictOVaQmksEHwlakpxF
 +uam3b/j/aQgMErhwbSWVexj6Ua+AU5ZxSwgRmdzMa/Qyb/sSQ3I6B+4Yna/dWY/bMp/VMqyd7E
 zE3sIt33u7u0UiJWgNlvI+yExdLavg9UkL1VMEez4=
X-Gm-Gg: AeBDievSD2zQ7UEI0BtUzchLBauh6YDwOgFPn6VznjquN48bpg5zkXdeRGVC4sGi13N
 DVvkjG9o2m2qIdjaR6tSJ3B25sX55r1VzRfPVhBDBDdvJkrXOslhJOcUCWvLpio9yk7svn6QOtJ
 cwwaOHl+wcbKJCyTsGlq5DPa2LeJIRlagtOcg6BEXd2aTMBPUoz74rsT9KaMfppZ7r65ICfn3sV
 Lg9ewAM11hn/2+6XGbF2nleMeTQLQmJz/2cabPF6r7ORzrNMT2m8gkrHHZlw01gE5bhHuiffcfo
 y8KglbRf8ARg7Nv7erdoSlOJvei8a/3gypZHpR5gLnyd3c7B8tem9xkpSiFUkFgBcHiRy439vMm
 cI2l6yg+HsrbfxDztIpABgyVSy7xgCrV54ZlZN0DBrmRejt1R3ILGePHU38lb13eRkJQt9ofz8g
 ==
X-Received: by 2002:a05:6a20:eed1:10b0:38b:eadd:449a with SMTP id
 adf61e73a8af0-3a08d8fda47mr14918573637.38.1776853853027; 
 Wed, 22 Apr 2026 03:30:53 -0700 (PDT)
X-Received: by 2002:a05:6a20:eed1:10b0:38b:eadd:449a with SMTP id
 adf61e73a8af0-3a08d8fda47mr14918532637.38.1776853852546; 
 Wed, 22 Apr 2026 03:30:52 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7976f920e1sm12589666a12.2.2026.04.22.03.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:30:52 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Igor Mammedov <imammedo@redhat.com>,
 marcandre.lureau@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Ani Sinha <anisinha@redhat.com>, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v5 04/10] hw/tpm: Implement TPM CRB chunking logic
Date: Wed, 22 Apr 2026 16:00:12 +0530
Message-ID: <20260422103018.123608-5-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422103018.123608-1-armenon@redhat.com>
References: <20260422103018.123608-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
index e7ec9d0679..29370d6f49 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -17,6 +17,7 @@
 #include "qemu/osdep.h"
 
 #include "qemu/module.h"
+#include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "system/address-spaces.h"
 #include "hw/core/qdev-properties.h"
@@ -67,6 +68,7 @@ DECLARE_INSTANCE_CHECKER(CRBState, CRB,
 #define CRB_INTF_CAP_CRB_CHUNK 0b1
 
 #define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - A_CRB_DATA_BUFFER)
+#define TPM_HEADER_SIZE 10
 
 enum crb_loc_ctrl {
     CRB_LOC_CTRL_REQUEST_ACCESS = BIT(0),
@@ -82,6 +84,8 @@ enum crb_ctrl_req {
 
 enum crb_start {
     CRB_START_INVOKE = BIT(0),
+    CRB_START_RSP_RETRY = BIT(1),
+    CRB_START_NEXT_CHUNK = BIT(2),
 };
 
 enum crb_cancel {
@@ -124,6 +128,69 @@ static uint8_t tpm_crb_get_active_locty(CRBState *s)
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
@@ -154,20 +221,61 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
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
@@ -212,8 +320,21 @@ static void tpm_crb_request_completed(TPMIf *ti, int ret)
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
@@ -291,8 +412,7 @@ static void tpm_crb_reset(void *dev)
     s->regs[R_CRB_CTRL_RSP_SIZE] = CRB_CTRL_CMD_SIZE;
     s->regs[R_CRB_CTRL_RSP_ADDR] = TPM_CRB_ADDR_BASE + A_CRB_DATA_BUFFER;
 
-    s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->tpmbe),
-                            CRB_CTRL_CMD_SIZE);
+    s->be_buffer_size = tpm_backend_get_buffer_size(s->tpmbe);
 
     if (tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_size) < 0) {
         exit(1);
-- 
2.53.0


