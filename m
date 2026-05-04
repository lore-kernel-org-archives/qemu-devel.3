Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C31CCD3427
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 17:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJxKe-0008Pp-Jm; Mon, 04 May 2026 13:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wJxKX-00087w-0A
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:43:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wJxKS-0007pe-Fs
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777916614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WucsC/EyLEgEjhfoh4v+bCxHQS+l16Kx9Qrfs9o+zOA=;
 b=RLOqfxiBEdGg4nZe9h7J7/u6ricLkTEeFswtLTmmwBsiTxnA8ERMXK7OTnV05iCe64XaOx
 gLFmwXFnFH7fHulcdcBEadCr0iUTKnrUYc+oXkTHVJ9SBv9ToCtcgqZ21oZB51DojiTc+J
 q5oy/k6yBtitqRvk0kuN5Ynt27vcIdA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-xPpMll69MKipIMd7OzHqlA-1; Mon, 04 May 2026 13:43:33 -0400
X-MC-Unique: xPpMll69MKipIMd7OzHqlA-1
X-Mimecast-MFC-AGG-ID: xPpMll69MKipIMd7OzHqlA_1777916612
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b7c2ee830aso95109495ad.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 10:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777916612; x=1778521412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WucsC/EyLEgEjhfoh4v+bCxHQS+l16Kx9Qrfs9o+zOA=;
 b=BEM1YI+fGePnNubLSvzuJDeXD3ZnTN5A0wFT3V8XbNIOLyneXauDsOuXSMEkDqw/lk
 iaL7BOyNhbj3LMDA0RX9NCHFhky/GBf2Qhq50v9LgAsNuvfkmPj96Klq3FxGY9tC3JF9
 Lfb3CrX6ZX2YzivSiKmwbEPD3ODjy4imdcCTJO4N44Fxm3qUYlQk0lqqAeBz7vo3AVas
 0TlJgEprMBbbMtkVWzsiwKayUm4UiFJ7SWaDMSUhuSWwUAjpdoP1mLkf+3r5dTWUDxBA
 rqAJdS69djjUNy+whISfK6UC+DTZAsTDrpk+UTDeME/7KsKYCau5aiDsp8W6yc9E1b9l
 m97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777916612; x=1778521412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WucsC/EyLEgEjhfoh4v+bCxHQS+l16Kx9Qrfs9o+zOA=;
 b=L0t3/7MZ03Hu0MoEHQ+y+KLxInk/ttsNPZJJjt2XK2tUyWygTKVXCyPhCMyP8+PYat
 UA8TGW2365aJBY9nck3E0mRAlRiKXxCYYGOn+dmIlJIQxVFJoaqFp/24qDjxIGumfMnT
 6vVb5zHPanj/72nZbeRj3sAoC6V8BWHF1zF5WLzlT/DnHacknkdKd04/4pHL+XCcz1vA
 cO2IG8KWSi251mTo1CATZYAbhNSIXh6zjB7wztQAKrBEA+SpdeyYY+PV25+sXcq9YjCa
 lZ29gmt9476HdDGerrHlOoIRJr+i8D/Fvo4rWWN9PniojQg4YCKHo9y+JLPvxceeVj5t
 5TLQ==
X-Gm-Message-State: AOJu0YxHng9sYg65xSCKuxM1v7ysaW1Ox4JvbyNsXghl9OcmQQnHZ1N5
 MiMOm+g4/TGrvafSsEezM3e6P+YZCOTDNvXW9n7gbgeaEY6ML98SeB0+ztD35Ds69i5+KHCIrPb
 LLS1l5aNJsx+W4azIrDlWppluhvmR7dXlPSGLeI2UzNCKLgXWb2NI91DoVxKiE/lE2EOVDZxAmM
 O+9lTIXKMwd3qd/NfdT02Jbz8+CveGV2lKVLIYkDY=
X-Gm-Gg: AeBDietxS2twifWw1PSpI93Tw6GfWkMYFtOzR61kLSW+/0EIL+PZl4uuxZXj3o9Rps/
 vez28qW+5PpXrOrRof6wZDCqeXcLJ0HrZ1AEhL35ezxs1pXbUVDD7Xm4cBuOjh99SzirgSpJfwz
 XUZ+lppR9gz3OFiUVIKc9xkOWC7T39V8R+7dj/YHLYb2dCpZiWpyKYvgzGIe71w+zgE7sTjE6O4
 VuqFQKLYwvQo4HPQHxTWRmV3TpmKipoaaJ1yc2sDqBjbJcBrTcnsLKESl1JRnJeFMAr8A558GKp
 91Yfaoa/sesvjdxV/IhmBh3g73OD2DWAlIFec77tY+8TbTpH7eSzKG+0JhmKp0eSODqD9dVkgGN
 ttoHZffabSgP0NYD9Wwta8EWyOteqbAsxevLKPvRxxgHVnhhCe3msX44zWKuh6ATDud2F6LLZ
X-Received: by 2002:a17:903:1984:b0:2b2:ec46:dfd4 with SMTP id
 d9443c01a7336-2b9f25df2fcmr110953395ad.22.1777916612019; 
 Mon, 04 May 2026 10:43:32 -0700 (PDT)
X-Received: by 2002:a17:903:1984:b0:2b2:ec46:dfd4 with SMTP id
 d9443c01a7336-2b9f25df2fcmr110952985ad.22.1777916611408; 
 Mon, 04 May 2026 10:43:31 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.108.92])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9caaaec82sm112765315ad.24.2026.05.04.10.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 10:43:30 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, marcandre.lureau@redhat.com,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Arun Menon <armenon@redhat.com>
Subject: [PATCH v6 6/6] hw/tpm: Add support for VM migration with TPM CRB
 chunking
Date: Mon,  4 May 2026 23:12:34 +0530
Message-ID: <20260504174234.13556-7-armenon@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504174234.13556-1-armenon@redhat.com>
References: <20260504174234.13556-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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
 hw/tpm/tpm_crb.c  | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

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
index 5572d89268..98feb734d5 100644
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
 
@@ -352,18 +355,68 @@ static int tpm_crb_pre_save(void *opaque)
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
+     * buffer capacity (s->be_bufer_size). This check ensures that if we
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
@@ -418,6 +471,7 @@ static void tpm_crb_reset(void *dev)
 static void tpm_crb_realize(DeviceState *dev, Error **errp)
 {
     CRBState *s = CRB(dev);
+    int ret;
 
     if (!tpm_find()) {
         error_setg(errp, "at most one TPM device is permitted");
@@ -427,6 +481,15 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
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
@@ -457,6 +520,11 @@ static void tpm_crb_unrealize(DeviceState *dev)
 
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
2.54.0


