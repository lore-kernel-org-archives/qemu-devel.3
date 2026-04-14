Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEB6ED7B82
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCZAm-000058-Kg; Tue, 14 Apr 2026 04:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wCZAV-0007ve-FD
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 04:30:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wCZAT-000433-2Z
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 04:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776155443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bK5BWDq0pPdx/5DVBrTlll0571lkzu0A1GqTXvFV8Cc=;
 b=XDOobnf0Ga6QaGQF9jr3OHarEnEKTDtLqq6uwV0APQWhxtQoCUsklyfceEp+JZc8f7EouX
 hIyFukq+Aq2weQ2AuXu4qxrlbShx5fHGqrzktzYjE0r6Cpm1v2YAKS2piWt3kz+dPQ+4BM
 zKj/schQhdPwLG7sUNtIgaKHcDIIDyU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-PwsgcEolPU6VaY6NkIQFtA-1; Tue, 14 Apr 2026 04:30:42 -0400
X-MC-Unique: PwsgcEolPU6VaY6NkIQFtA-1
X-Mimecast-MFC-AGG-ID: PwsgcEolPU6VaY6NkIQFtA_1776155441
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b24cd2e2b3so52654505ad.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 01:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776155441; x=1776760241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bK5BWDq0pPdx/5DVBrTlll0571lkzu0A1GqTXvFV8Cc=;
 b=f0klhg5WjeXVqM+45snUmhxv7pBMuNv4g3iSrt+9JIKI5PtqZKEhFhgHTjNBwW559K
 +Sl1OPRQJJAUMatFTzlNRx6Zs9cfLQA6BOZyxEcq94G4JRl1Jr5Bsf7a5vLngPz1mqNd
 fo1EMIaoLJ8OiFQ1gaqNo8srGaNijZ5Tddmfjf0ZPKkDWMpn8ZzS9PHnxPpD0BVgOnMm
 DwXx1H7DNrg19cmK35kuK1AgrMZxudlO/DsiYpVbH9uKeHucoJKNAluNyg8UlyuRiL2d
 DBLvjBsT5so+98qwnvFvRsKMeeACL8wTsIW03VwxAws/6bSqW332OJ34cJfiTPLyRqOd
 xmDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776155441; x=1776760241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bK5BWDq0pPdx/5DVBrTlll0571lkzu0A1GqTXvFV8Cc=;
 b=ZXQEJzqW4O+e6Q1jQJIMUIrdv3DwHoq1GtSjqojtw/hWKRSmQpqpaLGdIpnkH6ltlg
 LGwPDr2gi1pRodzkQt6cYg3mxV4I/qUJ/wm+o19PIaplR/1XQpYODNFy6DNtW7SfH3yh
 Da3yWsgkR44BKlrEvFoio+lfqfSzno9J7OR7dQBsRn5zUY969Ie3SMpjZVLKfh2dz3oP
 8C/R6LB8WQaE+8rPB46lmz/sLGYdNAKHdT0FE56mhNPl+kBd2TWKy/KI0lvceiJSSo8E
 LnCYPydNIJg55ZSq9NU7hXH30ScbIVyUfGx5y6TsbyI4vMw3idhHNiUuRse2SNHjryCb
 SAKQ==
X-Gm-Message-State: AOJu0Yxd20zZK2VM+yKmiQrkzsNljnnoi66hX4re809sr+xMCDK7R3bQ
 GhdwD+tvm6YlA5QVLzsy+GV8QJ0vD8a+eUbwMKVjNxzH1uwy3GkQWR+KuE6oO9/vLraWhqWDiOU
 M2BIeHpxmYzI46h5TIzNAbfXlK3Jle41d9ODLEwMDTxxtG1agK6beELFIpgZIC8uumGlMg4Vege
 uAhmgNw7j8TwKNv4hOL0VQNMBGWotBoy45DlOrkGk=
X-Gm-Gg: AeBDieuUPHMUvuKw/KKqlFDhe8UDbuqrCqrGF83PYh+xYr/2zHzCwUfzg0GO8beDVF7
 TVMo5PRdeG6RVmgxQx3VSjknwDpiwtl8Aqt1+8I7WjtvbUVQSwo46z7neGyo3jtUojoFLIAhzjO
 HSQIRhbis8xpRCjcHd81tIbl5M7GEmGEEOgGcKyn/1n9Xw94FNCB9bLod7m0OnOgzOHZVqC/GLi
 8j5W2OM+8IDz2RVBYuu7KlEkXJhJ94zhkh3e+ieXiH1dHpvYtQ5TQ1ZDFq7dN0oHkBKYK7ExwS7
 SnKvdMP5TCrRE6LTDZb6eghYqPZJtfeeKjWhCYL4AwAro9P/CjYT1UBTMoafum6D2LVHpmiBjYC
 oHbobJ5zlrOu6X2DEEybQHKqhg+Y1xTJy1NVBRQB+/Km3aiIsJfSn1YgdbuF9588=
X-Received: by 2002:a17:903:3c4b:b0:2ae:ac0c:5a2a with SMTP id
 d9443c01a7336-2b2d59433c5mr171481865ad.6.1776155441169; 
 Tue, 14 Apr 2026 01:30:41 -0700 (PDT)
X-Received: by 2002:a17:903:3c4b:b0:2ae:ac0c:5a2a with SMTP id
 d9443c01a7336-2b2d59433c5mr171480035ad.6.1776155438542; 
 Tue, 14 Apr 2026 01:30:38 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4e0f909sm181493785ad.35.2026.04.14.01.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 01:30:38 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, marcandre.lureau@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Arun Menon <armenon@redhat.com>
Subject: [PATCH v4 06/10] hw/tpm: Add support for VM migration with TPM CRB
 chunking
Date: Tue, 14 Apr 2026 13:59:11 +0530
Message-ID: <20260414082915.112122-7-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414082915.112122-1-armenon@redhat.com>
References: <20260414082915.112122-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

- Add subsection in VMState for TPM CRB with the newly introduced
  command and response buffer GByteArrays, along with a needed callback,
  so that newer QEMU only sends the buffers if it is necessary.
- Add hw_compat global properties for both migrate-buffers and cap-chunk
  because the chunking feature is only supported for machine type 11.1
  and higher.
- Implement a migration blocker to prevent migration of the VM if the
  user manually enables chunking capability but disables buffer
  migration. This avoids state data loss.

Signed-off-by: Arun Menon <armenon@redhat.com>
---
 hw/core/machine.c |  5 ++++-
 hw/tpm/tpm_crb.c  | 53 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1abc8ae737..6d6b0fc9d1 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,7 +38,10 @@
 #include "hw/acpi/generic_event_device.h"
 #include "qemu/audio.h"
 
-GlobalProperty hw_compat_11_0[] = {};
+GlobalProperty hw_compat_11_0[] = {
+    { "tpm-crb", "x-migrate-buffers", "off"},
+    { "tpm-crb", "x-cap-chunk", "off"},
+};
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
 GlobalProperty hw_compat_10_2[] = {
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 8e44df1aed..0f1eced977 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -24,6 +24,7 @@
 #include "hw/pci/pci_ids.h"
 #include "hw/acpi/tpm.h"
 #include "migration/vmstate.h"
+#include "migration/blocker.h"
 #include "system/tpm_backend.h"
 #include "system/tpm_util.h"
 #include "system/reset.h"
@@ -49,6 +50,10 @@ struct CRBState {
 
     bool ppi_enabled;
     TPMPPI ppi;
+
+    bool migrate_buffers;
+    bool cap_chunk;
+    Error *migration_blocker;
 };
 typedef struct CRBState CRBState;
 
@@ -345,18 +350,48 @@ static int tpm_crb_pre_save(void *opaque)
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
+static const VMStateDescription vmstate_tpm_crb_chunk = {
+    .name = "tpm-crb/chunk",
+    .version_id = 0,
+    .needed = tpm_crb_chunk_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_GBYTEARRAY(command_buffer, CRBState, 0),
+        VMSTATE_GBYTEARRAY(response_buffer, CRBState, 0),
+        VMSTATE_UINT32(response_offset, CRBState),
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
+    DEFINE_PROP_BOOL("x-migrate-buffers", CRBState, migrate_buffers, true),
+    DEFINE_PROP_BOOL("x-cap-chunk", CRBState, cap_chunk, true),
 };
 
 static void tpm_crb_reset(void *dev)
@@ -392,7 +427,7 @@ static void tpm_crb_reset(void *dev)
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
                      InterfaceSelector, CRB_INTF_IF_SELECTOR_CRB);
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
-                     CapCRBChunk, CRB_INTF_CAP_CRB_CHUNK);
+                     CapCRBChunk, s->cap_chunk ? CRB_INTF_CAP_CRB_CHUNK : 0);
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
                      RID, 0b0000);
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID2,
@@ -413,6 +448,7 @@ static void tpm_crb_reset(void *dev)
 static void tpm_crb_realize(DeviceState *dev, Error **errp)
 {
     CRBState *s = CRB(dev);
+    int ret;
 
     if (!tpm_find()) {
         error_setg(errp, "at most one TPM device is permitted");
@@ -422,6 +458,16 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "'tpmdev' property is required");
         return;
     }
+    if (s->cap_chunk && !s->migrate_buffers) {
+        error_setg(&s->migration_blocker, "TPM chunking is enabled but "
+        "buffer migration is disabled. Migration is blocked to prevent "
+        "data loss");
+
+        ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
+        if (ret < 0) {
+            return;
+        }
+    }
 
     memory_region_init_io(&s->mmio, OBJECT(s), &tpm_crb_memory_ops, s,
         "tpm-crb-mmio", sizeof(s->regs));
@@ -454,6 +500,11 @@ static void tpm_crb_unrealize(DeviceState *dev)
 
     g_clear_pointer(&s->command_buffer, g_byte_array_unref);
     g_clear_pointer(&s->response_buffer, g_byte_array_unref);
+
+    if (s->migration_blocker) {
+        migrate_del_blocker(&s->migration_blocker);
+        error_free(s->migration_blocker);
+    }
 }
 
 static void tpm_crb_class_init(ObjectClass *klass, const void *data)
-- 
2.53.0


