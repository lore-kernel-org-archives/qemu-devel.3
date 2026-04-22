Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47D9F9B60D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUrY-0006nt-00; Wed, 22 Apr 2026 06:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFUrW-0006n8-AQ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:31:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFUrQ-0006zz-Ee
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776853871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+nQzf/D0K64i/5OlXj6ts+ZQEQEq47laODMb54sHduo=;
 b=DpvBnVA3cQpLU4WFDtLJzw00cIzJSy+Pcqh0EZCFLO9jJNb0YnHEm4nlqtQlxEGNPiwU3O
 OLplxaLu8TPEfLvl5rSk6LVWC14aKQBS7kqqAzbach0ws1frnobmBvwqrqB7AcGPz3rttJ
 Sk7xgLW3XWgoWDLNTwovmxE8MtFF4jA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-DGL65jU2NcOYnDvPN2NfKg-1; Wed, 22 Apr 2026 06:31:05 -0400
X-MC-Unique: DGL65jU2NcOYnDvPN2NfKg-1
X-Mimecast-MFC-AGG-ID: DGL65jU2NcOYnDvPN2NfKg_1776853865
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-354490889b6so8014941a91.3
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776853864; x=1777458664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+nQzf/D0K64i/5OlXj6ts+ZQEQEq47laODMb54sHduo=;
 b=Qce0hFwwJKq1RxoF34MKnqzE/Maerx3M1aCzHCwOqN+yKUnhtCypB/LGNafkDCXt3Y
 keRuh65NFB82LkP1FnrUKPCSkkA/rYHude3JphfCT7cJa8ab9qSSae8oQRGbZ03i2/IU
 x59ivul+qXYRmRNDNKMNQqK2MqoEyITldXCzUUIR4baS5YeEdbfng+vDP30BH+/rAw3v
 2/08WZHzmDi9Lyk1ZGySAQdfiJSwR4+mz9NqsYH6diLtMXn9zxLjopvqjy5fFffoG05F
 fp/pkRTwoBtxb1dzYZ5oN0yP8AuOAFmhQL0eHdIQNR4j9CKSPyzB9I4MMYnjM4oWyV+o
 0rgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776853864; x=1777458664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+nQzf/D0K64i/5OlXj6ts+ZQEQEq47laODMb54sHduo=;
 b=kdIe6XiUmSnjdqmzg1GdNb5aXG/YpZHdjdTur8LELofrVt+MK9yetm4GOPS8L0T7KS
 qufgJUsqW9dA/doshIZ4hQ+uxVA1sOxrN9A6vq2jSHhaEzd+mZYSrMIwxXLShYZhbosA
 DlOM4LTxL3Gw8fa3mcz87bTKWgpugUH1uTxfRYNE+vMEe/kD9ji++QXFIAoN29AJWia+
 LJSLVPOHMQedzd4Kmc9hF9/x3aThx+OeJCMXiH0TBBA9Iugb0QOuG8mPmCZx/NVLUrG5
 rdeoW//ZK2SKxi7a4JPJ0K8oAbYrroeQIvgWAiq+Zxpx2m6XkUscUcId74K1daq9o20b
 fQmA==
X-Gm-Message-State: AOJu0YxN2KhkmHshXh33vj261tQt/rHue5sheUTroQubezO+IHSAnarS
 iID5syqOuWLWytlYhL/kXHcJBGf8xSzSWIvG/cuUNzGCrgU8XofeLcOYKZ4UVhGW2qltA2S/FIJ
 +TNHbzYjF98b8IOy1cY+aS0y82uXzYFz4LLA5qo5V6yqihV/pY0xiKay3hMJIpgNhc1MP9y8JXa
 MSaj3eaN9nWFeSj5OQ/s5J21jaivpu44sy4qp8K6E=
X-Gm-Gg: AeBDievUUIWT3Ou1wN7f6YDzFEH8XfTZAS4KA9EhhmarM2knMrg/JB6peeb7Toyb9fF
 NQZdVRYoRr4ti0OKKXoNeQKzFd8c7r4vxgfcut3lRaZsMNBkVFHILEc56X9gxutxwza5bWrbNPS
 mxPXdYTSUDrh//Tp+mFC43ZKGMATuYlA5aoQDr8kSJlGHNUX4WITA3t1Gbub+7LGugDKSvKMjjH
 g1m6pqCWnuCodvc6Y/4wPqVPvi/5PNJdivG1d5X98ch8yLja9hIkvMmjPwdkg0t8KNSwWCMMEFJ
 Gw8V+X/JX6kXotqssI3Wzle0fcWZ8dsnwr/qOMFE+JVDCL2M+N1bJ6YMoTBMkZwTFmtz9zCAPXZ
 KURJ/g1WWpf8sFG/lwwh0AH2pDR4/J8oCbHwgeY3pm3pomX+hJKCqpU5Fnoz9xGhBWXq5AhtxpQ
 ==
X-Received: by 2002:a17:90b:5543:b0:35f:b227:db86 with SMTP id
 98e67ed59e1d1-361403af6a5mr22338597a91.2.1776853864438; 
 Wed, 22 Apr 2026 03:31:04 -0700 (PDT)
X-Received: by 2002:a17:90b:5543:b0:35f:b227:db86 with SMTP id
 98e67ed59e1d1-361403af6a5mr22338531a91.2.1776853863655; 
 Wed, 22 Apr 2026 03:31:03 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7976f920e1sm12589666a12.2.2026.04.22.03.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:31:03 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Igor Mammedov <imammedo@redhat.com>,
 marcandre.lureau@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Ani Sinha <anisinha@redhat.com>, Arun Menon <armenon@redhat.com>
Subject: [PATCH v5 06/10] hw/tpm: Add support for VM migration with TPM CRB
 chunking
Date: Wed, 22 Apr 2026 16:00:14 +0530
Message-ID: <20260422103018.123608-7-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422103018.123608-1-armenon@redhat.com>
References: <20260422103018.123608-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
---
 hw/core/machine.c |  1 +
 hw/tpm/tpm_crb.c  | 71 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 6d27cf69a2..b590af0125 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -40,6 +40,7 @@
 
 GlobalProperty hw_compat_11_0[] = {
     { "tpm-crb", "cap-chunk", "off"},
+    { "tpm-crb", "x-allow-chunk-migration", "off"},
 };
 const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
 
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 29370d6f49..23e6948aee 100644
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
@@ -51,6 +52,8 @@ struct CRBState {
     TPMPPI ppi;
 
     bool cap_chunk;
+    bool allow_chunk_migration;
+    Error *migration_blocker;
 };
 typedef struct CRBState CRBState;
 
@@ -353,12 +356,63 @@ static int tpm_crb_pre_save(void *opaque)
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
+    if (!s->response_buffer || !s->command_buffer) {
+        error_setg(errp, "tpm-crb: Internal buffers are not allocated");
+        return false;
+    }
+    if (s->response_offset > s->response_buffer->len) {
+        error_setg(errp, "tpm-crb: Invalid response "
+                   "offset %" PRIu32 " in migration stream",
+                   s->response_offset);
+        return false;
+    }
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
 
@@ -366,6 +420,8 @@ static const Property tpm_crb_properties[] = {
     DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
     DEFINE_PROP_BOOL("ppi", CRBState, ppi_enabled, true),
     DEFINE_PROP_BOOL("cap-chunk", CRBState, cap_chunk, true),
+    DEFINE_PROP_BOOL("x-allow-chunk-migration", CRBState,
+                     allow_chunk_migration, true),
 };
 
 static void tpm_crb_reset(void *dev)
@@ -422,6 +478,7 @@ static void tpm_crb_reset(void *dev)
 static void tpm_crb_realize(DeviceState *dev, Error **errp)
 {
     CRBState *s = CRB(dev);
+    int ret;
 
     if (!tpm_find()) {
         error_setg(errp, "at most one TPM device is permitted");
@@ -431,6 +488,15 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
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
@@ -463,6 +529,11 @@ static void tpm_crb_unrealize(DeviceState *dev)
 
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


