Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F95109022B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 13:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Dpa-00068A-SA; Thu, 19 Mar 2026 09:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w3Dp0-0005pv-3P
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 09:53:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w3Doy-0001B3-CV
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 09:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773928435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RCrFXcagDckZtx6RGogtV/lXhSBL8xu18Ng4LTBb39I=;
 b=cLJ8id6bhnhXYPoFpdxxJZyzDBziua41/58YzFJB+0S7euqIbFO1qSUDgUGVOBavJgoDrw
 PwyRU3M8FrQtTSk+l7xG6cwIZGW//Zr2PNJeOytHt4uUecQxWZDuDpTzW48jSG3BwKlOdP
 Mm/FzI5DIjocX4FYwg5LtMKkJkNS6hY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-BCyx5lniNaa34uEGxr_CyQ-1; Thu, 19 Mar 2026 09:53:54 -0400
X-MC-Unique: BCyx5lniNaa34uEGxr_CyQ-1
X-Mimecast-MFC-AGG-ID: BCyx5lniNaa34uEGxr_CyQ_1773928433
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b06b68783dso12016325ad.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 06:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773928432; x=1774533232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCrFXcagDckZtx6RGogtV/lXhSBL8xu18Ng4LTBb39I=;
 b=BvB5VrfOAQPFj8KKErLUvTAcvs/WkNUbJhqeBulIBkVIQtfeEWWaKav1pyFbc+A1I5
 C6C6NwDmx+14m9EGE8+PtS/8EUf7AlorMWlpeAZ6pt87bp7Jq3wou4Xmh400ww575GcR
 ntS7bKHF0b/HpgBTk/NVt3ro6qqv3KKTjII4Y5hv0QbNNmAVsVYgiXUZvZ0YeopbnvbI
 wDeFG5ljbPtSRttqWlAsYg9YzBfLV2ijPx7PugJR48bv7W/kk0pxD9B0LEpcSyvU2xVl
 T0tjj+/s/KvC3i+EN4s/gfw+DSIfbIwd50w5ODlqJ5VhGmkXKhVIaXhc1ZJfGAKeZiVP
 NmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773928432; x=1774533232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RCrFXcagDckZtx6RGogtV/lXhSBL8xu18Ng4LTBb39I=;
 b=OHupn4LH/IETO/kz/RqMANSYh76tUXwC6HDLgOGohchWnextCPKNN2+Qv7m+u2vWx7
 H3SVHa7Kp6+bRjvtVBVJaI06hIO9E+SptdyxfT8iwBVWSkaW1b6UR56g0Nl4aZIGwknd
 /lnC00Q1CQ9/Si9RwGbWm9cz+nFsTPlYE8D8u1nCV/SVR8jcvt30I9vAJrXIkcb0/dc/
 6pL0Hrhy3L0xcnJZFp5gIC6Wqii2mRUXqLXBi1kJC73tJ484G9USyC+Lich1hgB1IFuM
 hX6fP8Cg5XrYxVIM+0tQVedvt4vXnd870BLNdULX4RTt2peC673OEmkzdfUT5iRcCarC
 VEIw==
X-Gm-Message-State: AOJu0Yye4EpoBUGinG2m6y1ppTF7VJKk8jtXUqh/M+8bkcM7ipGbvi0i
 SXB1cAfKc/ZJRug/7O7Gk8ENpqYFJZDL1eJiJtLQ6vDvwMXrQQD07id/2xsB5WRsDfFAWE51CUu
 rJqZ2qsS/n35RApJInb8jPJv2riKMnYaoXKx5ikwOBxKP3n2WK1/Ag7kUdbmVsksVzbPw63L792
 vqsfSWHtmyfgiCtBDFy5dBQF382y9bXeAKgAOhMDc=
X-Gm-Gg: ATEYQzxXlFe6XycSYNDBTIq1q5I74g1G7wW6RxZdkiUA2O7TUV3mXWpDGBXFm0YacCO
 tHST+EM0sNFJAqvCowYl62XHvWYrRmdwtnVCdo3aEy4EHTkZ//ju9jhl0nzTJ6wmw8SB/niF9Ur
 3Ix0dwEHQVJIQjd7Ssl2nbtFxvIgdnHMEzFV8HFVQS9H9Y8JfioCsxULYXgaTN2UuTgIhp7rHth
 AIlO9ODbOp2/p73VD9SJfaVbse422oR8GmiMm0/G24iRCPK7+ZfxqUKTDJi2zbbgktgAyTHBFTa
 ZhWwDpBiUNPdkQGacRelLld5Limkx8bhfdmGkfSKknONVCqwdFr89gOy6YUtYXeedtt4EyCd73T
 6c5FXvUN8GXo1Mkpn8YzwSpfcHvvnkkow+3PFYYXR9vV5Kb4HCWwPpvHw5b8Gdg==
X-Received: by 2002:a17:903:1a88:b0:2b0:4f82:74d0 with SMTP id
 d9443c01a7336-2b06e43d36cmr80690665ad.46.1773928432590; 
 Thu, 19 Mar 2026 06:53:52 -0700 (PDT)
X-Received: by 2002:a17:903:1a88:b0:2b0:4f82:74d0 with SMTP id
 d9443c01a7336-2b06e43d36cmr80690285ad.46.1773928432005; 
 Thu, 19 Mar 2026 06:53:52 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.104.12])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e6216c5sm77287025ad.73.2026.03.19.06.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 06:53:51 -0700 (PDT)
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
 Yanan Wang <wangyanan55@huawei.com>, Arun Menon <armenon@redhat.com>
Subject: [RFC v2 6/7] hw/tpm: Add support for VM migration with TPM CRB
 chunking
Date: Thu, 19 Mar 2026 19:23:15 +0530
Message-ID: <20260319135316.37412-7-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319135316.37412-1-armenon@redhat.com>
References: <20260319135316.37412-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

- Add subsection in VMState for TPM CRB with the newly introduced
  command and response buffers, along with a needed callback, so that
  newer QEMU only sends the buffers if it is necessary.
- Add hw_compat blocker because the feature is only supported for
  machine type 11.0 and higher.
- If the VM has no pending chunked TPM commands in the internal buffers
  during a VM migration, or if the machine type does not support newly
  introduced buffers, then the needed callback will return false, as it
  checks the hw_compat blocker and thus the subsection will not be sent
  to the destination host.
- Since the original command and response buffers are of type GByteArray,
  they are serialized in pre-save hook before sending them to the
  destination host and then restored back into original buffer using
  the post-load hook.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 hw/core/machine.c |   1 +
 hw/tpm/tpm_crb.c  | 114 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 115 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 6cf0e2f404..fcd6043c99 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -40,6 +40,7 @@
 
 GlobalProperty hw_compat_10_2[] = {
     { "scsi-block", "migrate-pr", "off" },
+    { "tpm-crb", "migrate-buffers", "off"},
 };
 const size_t hw_compat_10_2_len = G_N_ELEMENTS(hw_compat_10_2);
 
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index e61c04aee0..9ce342fe8a 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -33,6 +33,17 @@
 #include "trace.h"
 #include "qom/object.h"
 
+/* command and response buffers; part of VM state when migrating */
+typedef struct TPMCRBMigState {
+    uint32_t cmd_size;
+    uint8_t *cmd_tmp;
+
+    uint32_t rsp_size;
+    uint8_t *rsp_tmp;
+
+    uint32_t rsp_offset;
+} TPMCRBMigState;
+
 struct CRBState {
     DeviceState parent_obj;
 
@@ -49,6 +60,9 @@ struct CRBState {
 
     bool ppi_enabled;
     TPMPPI ppi;
+
+    bool migrate_buffers;
+    TPMCRBMigState mig;
 };
 typedef struct CRBState CRBState;
 
@@ -347,18 +361,118 @@ static int tpm_crb_pre_save(void *opaque)
     return 0;
 }
 
+static bool tpm_crb_chunk_needed(void *opaque)
+{
+    CRBState *s = opaque;
+
+    if (!s->migrate_buffers) {
+        return false;
+    }
+
+    return ((s->command_buffer && s->command_buffer->len > 0) ||
+            (s->response_buffer && s->response_buffer->len > 0));
+}
+
+static int tpm_crb_chunk_pre_save(void *opaque)
+{
+    CRBState *s = opaque;
+
+    if (s->command_buffer) {
+        s->mig.cmd_size = s->command_buffer->len;
+        s->mig.cmd_tmp = s->command_buffer->data;
+    } else {
+        s->mig.cmd_tmp = NULL;
+        s->mig.cmd_size = 0;
+    }
+
+    if (s->response_buffer) {
+        s->mig.rsp_size = s->response_buffer->len;
+        s->mig.rsp_tmp = s->response_buffer->data;
+    } else {
+        s->mig.rsp_tmp = NULL;
+        s->mig.rsp_size = 0;
+    }
+    s->mig.rsp_offset = (uint32_t)s->response_offset;
+    return 0;
+}
+
+static bool tpm_crb_chunk_post_load(void *opaque, int version_id, Error **errp)
+{
+    CRBState *s = opaque;
+
+    if (s->mig.cmd_size > s->be_buffer_size ||
+        s->mig.rsp_size > s->be_buffer_size ||
+        s->mig.rsp_offset > s->mig.rsp_size) {
+        error_setg(errp,
+                   "tpm-crb-chunk: incoming buffer %u, exceeds limits %zu "
+                   "or offset %u exceeds size %u",
+                   s->mig.cmd_size, s->be_buffer_size,
+                   s->mig.rsp_offset, s->mig.rsp_size);
+        g_free(s->mig.cmd_tmp);
+        s->mig.cmd_tmp = NULL;
+        g_free(s->mig.rsp_tmp);
+        s->mig.rsp_tmp = NULL;
+        return false;
+    }
+
+    if (s->mig.cmd_tmp) {
+        if (s->command_buffer) {
+            g_byte_array_unref(s->command_buffer);
+        }
+        s->command_buffer = g_byte_array_new_take(s->mig.cmd_tmp,
+                                                  s->mig.cmd_size);
+        s->mig.cmd_tmp = NULL;
+    } else {
+        if (s->command_buffer) {
+            g_byte_array_set_size(s->command_buffer, 0);
+        }
+    }
+    if (s->mig.rsp_tmp) {
+        if (s->response_buffer) {
+            g_byte_array_unref(s->response_buffer);
+        }
+        s->response_buffer = g_byte_array_new_take(s->mig.rsp_tmp,
+                                                   s->mig.rsp_size);
+        s->mig.rsp_tmp = NULL;
+    }
+    return true;
+}
+
+static const VMStateDescription vmstate_tpm_crb_chunk = {
+    .name = "tpm-crb/chunk",
+    .version_id = 1,
+    .needed = tpm_crb_chunk_needed,
+    .pre_save = tpm_crb_chunk_pre_save,
+    .post_load_errp = tpm_crb_chunk_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(mig.cmd_size, CRBState),
+        VMSTATE_VBUFFER_ALLOC_UINT32(mig.cmd_tmp, CRBState, 0, NULL,
+                                     mig.cmd_size),
+        VMSTATE_UINT32(mig.rsp_size, CRBState),
+        VMSTATE_VBUFFER_ALLOC_UINT32(mig.rsp_tmp, CRBState, 0, NULL,
+                                     mig.rsp_size),
+        VMSTATE_UINT32(mig.rsp_offset, CRBState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_tpm_crb = {
     .name = "tpm-crb",
     .pre_save = tpm_crb_pre_save,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, CRBState, TPM_CRB_R_MAX),
         VMSTATE_END_OF_LIST(),
+    },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_tpm_crb_chunk,
+        NULL,
     }
 };
 
 static const Property tpm_crb_properties[] = {
     DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
     DEFINE_PROP_BOOL("ppi", CRBState, ppi_enabled, true),
+    DEFINE_PROP_BOOL("migrate-buffers", CRBState, migrate_buffers, true),
 };
 
 static void tpm_crb_reset(void *dev)
-- 
2.53.0


