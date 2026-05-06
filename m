Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567E1CD3424
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 07:59:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKX9p-0005ic-NQ; Wed, 06 May 2026 03:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wKX9n-0005cn-N9
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:58:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wKX9l-0000i6-Vr
 for qemu-devel@nongnu.org; Wed, 06 May 2026 03:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778054337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wLOTFeibi/SJQNjXUnMOcOvEOv6uYoUj8D8DXGCDyqY=;
 b=Ts488kS28JvvwD2nM/YTab4NJLkdI838rQ8Rhf9iJNgDD+qhKE6clKvVvyCVqBzmoForT4
 F/33m6Q7KO6Z4TSDo1xP0GnAxOaZDU18SJWD4dgv3v/zhpjVrC7A5cMpOvSwY8mMVdFoGG
 4YbKoQ1gYalKEBLo1kYNEBgB3MfItwU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-g4dqA67-MQyXcbmDJe5eiA-1; Wed, 06 May 2026 03:58:56 -0400
X-MC-Unique: g4dqA67-MQyXcbmDJe5eiA-1
X-Mimecast-MFC-AGG-ID: g4dqA67-MQyXcbmDJe5eiA_1778054335
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ba5f794825so9484185ad.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 00:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778054335; x=1778659135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wLOTFeibi/SJQNjXUnMOcOvEOv6uYoUj8D8DXGCDyqY=;
 b=hKs77L4HN4dx9nahucYjIUrZKptIpcJvG6UGHRre1HOMX4injrdQ3mWsbAqIrKyWIl
 SXs8UwiTaFj8C8cTYJ5cvA9TzY8xa7y/Ekbtb+Ek2NLqUBloAWx4fUgiBAmIz3VXcU3d
 UwVWh4PdRBaFvIZSZI3Q+O5/M0SAgd/vM1GGRuGyHce/4nPJ5C1oKnf4H1dFgP2Ezol6
 2/bT7Or0L1PvOWX7hunRGX45QghrDGSjeBEC7IT4gJQ9qFgAIi6BiCgDRlKhd0z1lADN
 B4Y3ve+aGQMd/KdH385FSoldh3gjM2gzO/5831ZrDiW9HDYX+tclKbJwfY3AXXxrIJiX
 4VnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778054335; x=1778659135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wLOTFeibi/SJQNjXUnMOcOvEOv6uYoUj8D8DXGCDyqY=;
 b=V/5/22kEz6k8M4DBVDNfhX2FGta2iNSyCvYhpisDAmUlncu+oqa6O/8v4dCbVcIscO
 wIfdV1nNWkWkUzc81/86S3sha+IxsRtF54sHurz5mHQHvJ/fEZAPsfuoBtBO242X/Etr
 oUEz2t8dH/43/ePImqoYCUANCoLBJLA6uRrN0m+1B6IbZPEK8tviZUpjJNk4Ls7XItf+
 YFMyuFDwoYhl0bq1rcWsxcXkYusaJsrOsVqIA15z5I54sAhPOcW+AIZ4j84ZxYxdFgaA
 MjClo/0uwcLfIcJ2MD6ZOWKN148YGVxCl/9uG4qa0sgrRN6S8zBrrYnhMC7p43tHDTod
 tb6Q==
X-Gm-Message-State: AOJu0YygSYHTcl+TDSiMJjh9XQdcR0ybuNO4880MX94ONRWgGOh1/oo9
 jbZcEIdDO6QlUXGMRNcBnh2b2Nx+QABKA7XrAAfqtT3UXZE81lpLUJjekwNCg2gDW7/4mkrpySg
 m6Dm3toMjglFLmBUKKFLWSMcZAmkz+HLOthmfGh/bbea/mVdgQPmvCaNuW/XkBCXXntQNSlZAdT
 FvppKePeGTjBgZXYC66LWAMMPptz06MDZACxvF0oc=
X-Gm-Gg: AeBDieu97kwklrfvxP2dtyXjdRV7blBJncGEpRcrcm7lEW/oUuQq7ULWdQnOoxFWT0K
 dNHrStbZxnRdSC+Gd5YgwJ79QxvFmnf88K1Hy268EpkocdEdR21HFeCBnGf7nyI36tE254aMk9j
 HMAYzs+zRWUyiyGLVfQ/HRu5NfkaZMI8rTz6pJkWoFu/1UamOwnOObh5KkkdGKmCZs+l+MQKj5i
 mzL2yLN0tRfgF9/11uY/Ffb0e/4w87SEzoVvTGwkmQLArkic+StfJ+mnN5KjpNPveZc4RtSUgZo
 w7AdZ+82lhoODWv/5++J5B/VtqOI7lZHYg8W70oOqVbWzgMdYXXDhdOsbqqeg98uimTbwkRlK+q
 Qe/BGWMuiJE/8Cc2fnJUod8tTuY4doCN/w9tbiDNudLM8QOMOuiZGEERXxd7Ueb4/1HTDBITQ
X-Received: by 2002:a17:902:8487:b0:2b2:b117:1e1b with SMTP id
 d9443c01a7336-2ba78f72f68mr15876755ad.17.1778054334950; 
 Wed, 06 May 2026 00:58:54 -0700 (PDT)
X-Received: by 2002:a17:902:8487:b0:2b2:b117:1e1b with SMTP id
 d9443c01a7336-2ba78f72f68mr15876255ad.17.1778054333651; 
 Wed, 06 May 2026 00:58:53 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.106.26])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ba7ca29f9dsm15439865ad.78.2026.05.06.00.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 00:58:52 -0700 (PDT)
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
Subject: [PATCH v7 6/6] hw/tpm: Add support for VM migration with TPM CRB
 chunking
Date: Wed,  6 May 2026 13:28:13 +0530
Message-ID: <20260506075813.120781-7-armenon@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506075813.120781-1-armenon@redhat.com>
References: <20260506075813.120781-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
- Implement a migration blocker to prevent migration of the VM if the
  user manually enables chunking capability, cap-chunk, but the machine
  type does not support it, using a new hw_compat property called
  allow_chunk_migration.
- Add a post_load_errp hook so that during a migration, the buffers are
  validated before destination VM is started.

Signed-off-by: Arun Menon <armenon@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/core/machine.c |  1 +
 hw/tpm/tpm_crb.c  | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 4e0a93e231..30464b21ac 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -41,6 +41,7 @@
 
 GlobalProperty hw_compat_11_0[] = {
     { "tpm-crb", "cap-chunk", "off" },
+    { "tpm-crb", "x-allow-chunk-migration", "off" },
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index f85df08185..54fa2042b5 100644
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
@@ -50,6 +51,8 @@ struct CRBState {
     TPMPPI ppi;
 
     bool cap_chunk;
+    bool allow_chunk_migration;
+    Error *migration_blocker;
 };
 typedef struct CRBState CRBState;
 
@@ -349,18 +352,68 @@ static int tpm_crb_pre_save(void *opaque)
     return 0;
 }
 
+static bool tpm_crb_chunk_needed(void *opaque)
+{
+    CRBState *s = opaque;
+
+    if (!s->allow_chunk_migration) {
+        return false;
+    }
+
+    return ((s->command_buffer && s->command_buffer->len > 0) ||
+            (s->response_buffer && s->response_buffer->len > 0));
+}
+
+static bool tpm_crb_chunk_post_load(void *opaque, int version_id, Error **errp)
+{
+    CRBState *s = opaque;
+
+    /*
+     * The external TPM emulator (example swtpm) determines the backend
+     * buffer capacity (s->be_buffer_size). This check ensures that if we
+     * migrate from a source with a PQC-enabled emulator that supports
+     * larger buffers to a destination with a non-PQC emulator, the
+     * migrated data does not exceed the destination's capacity.
+     */
+    if (s->response_buffer->len > s->be_buffer_size ||
+        s->command_buffer->len > s->be_buffer_size) {
+        error_setg(errp, "tpm-crb: Buffer sizes exceed backend capacity");
+        return false;
+    }
+    return true;
+}
+
+static const VMStateDescription vmstate_tpm_crb_chunk = {
+    .name = "tpm-crb/chunk",
+    .version_id = 0,
+    .needed = tpm_crb_chunk_needed,
+    .post_load_errp = tpm_crb_chunk_post_load,
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
     DEFINE_PROP_BOOL("cap-chunk", CRBState, cap_chunk, true),
+    DEFINE_PROP_BOOL("x-allow-chunk-migration", CRBState,
+                     allow_chunk_migration, true),
 };
 
 static void tpm_crb_reset(void *dev)
@@ -415,6 +468,7 @@ static void tpm_crb_reset(void *dev)
 static void tpm_crb_realize(DeviceState *dev, Error **errp)
 {
     CRBState *s = CRB(dev);
+    int ret;
 
     if (!tpm_find()) {
         error_setg(errp, "at most one TPM device is permitted");
@@ -424,6 +478,15 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "'tpmdev' property is required");
         return;
     }
+    if (s->cap_chunk && !s->allow_chunk_migration) {
+        error_setg(&s->migration_blocker,
+                   "The tpm-crb device does not support chunk migration with "
+                   "machine version less than 11.1");
+        ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
+        if (ret < 0) {
+            return;
+        }
+    }
 
     memory_region_init_io(&s->mmio, OBJECT(s), &tpm_crb_memory_ops, s,
         "tpm-crb-mmio", sizeof(s->regs));
@@ -454,6 +517,10 @@ static void tpm_crb_unrealize(DeviceState *dev)
 
     g_clear_pointer(&s->command_buffer, g_byte_array_unref);
     g_clear_pointer(&s->response_buffer, g_byte_array_unref);
+
+    if (s->migration_blocker) {
+        migrate_del_blocker(&s->migration_blocker);
+    }
 }
 
 static void tpm_crb_class_init(ObjectClass *klass, const void *data)
-- 
2.54.0


