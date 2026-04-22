Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E23F9B605
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFUrh-0006pE-Kc; Wed, 22 Apr 2026 06:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFUrf-0006p5-Hk
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:31:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFUrd-00075B-Iw
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776853885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X5BfOb29CchgA3O8cD3d/CWCo4Ox5ZAg0ea68Q66Ig0=;
 b=b99NzYGUjtX7Zs2+OzhzdceGI3P3nICodgUf2vfhIW9dycgXGfvFeRchxXZz9+5NCcoBaC
 pL9ml+zy4JvHK3gJLwQTT6W8Tao4KSdDOOSmhQ4Jie+gEYZcXk0d1nqdC4qYaqk3MH+vBg
 2hd8gSq1Zwfrrf+pGikzh/FYV6nn9kI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-VV1FOndaP9-aScaOa-_now-1; Wed, 22 Apr 2026 06:31:23 -0400
X-MC-Unique: VV1FOndaP9-aScaOa-_now-1
X-Mimecast-MFC-AGG-ID: VV1FOndaP9-aScaOa-_now_1776853883
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3595485abbbso6522444a91.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776853883; x=1777458683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X5BfOb29CchgA3O8cD3d/CWCo4Ox5ZAg0ea68Q66Ig0=;
 b=DNLN0uCWNn9mpyBDAvu9NKe9nPTmvRgIgwVfX8jkgUMHp5A53JqnvvZTaMJwTSTupu
 y+JWQaCsHGje3ceRPZrF8z0JtmExpgtqCeQrOeIIHbNPkuO1FbbOnwHcDyiXlpXCs9Gi
 CkYu+ttkfE9BaT0aSxpGZK4f2IslVfIz0Y95hnTZ7i75dUMgwhxBshvk8DnXJlmFn2jd
 VR4r4yCWXm0c/D5gf5twcQkNUoVx/ENRAEbw+3P3mr6h5ZmQlp3Yeuo6hqysP02niNXb
 KgqUxnAWqoNFnCS+uyyUYopH0UOnEuFI8dVhLe3LfKwKaBumJfIQXoZlTFtaNezVDLJN
 7xwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776853883; x=1777458683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X5BfOb29CchgA3O8cD3d/CWCo4Ox5ZAg0ea68Q66Ig0=;
 b=sHw4Vxb3y+aA8SY1Ob49R1MdFdepjDuZeAhUxeaVrYf65NYysGzQH4lQoHjrDxgbQi
 FPYYwg2PWXfPkY/hfNR4UrGGdFKcUaDoHO4FczRvL7MYlmmuCY7/yskYfSPrJBbME/yT
 zHHcJUqvMPNA8SVk9JG9rU93HR1AR7h9z/n/vGi3QjFvbyWnl/JtTq5vTUCAflmRwZXo
 1HuDDcplUa1e8rQo89M+oIgkQTHzbHoCNsRpBDl0ttme+wgOlHOHvM1MgNV8fFaOmk+K
 2m1p4cywDGP/hgehImU9FIQCs4jNSRzlWWWrnSlzy4oyVWLyjDG8XX5FWTTbcf+ig43Z
 Jh1w==
X-Gm-Message-State: AOJu0YyLs7mime7Xp3qVz9RZ4KLe7AsLRi8nYIlNvtnUWOz+LRxGS1Bw
 6baW0M/pjUaTDOz6ynpiKooDGU/Anb3VOFf7iDRZpD5+ZM7XkX+sSDuKcu4eEgE85u5qyiyImP0
 0sQGWHyR2/1IgGo5iT4A2o4/EgiYK3TGnusUNUYPv0vZzUhOtSRkQd82V+Osn+HxDmjhF6xkl5Z
 +WKPZQcw+jKyRKg3TwPAcw4+ZFM9O4niz55NMTMDA=
X-Gm-Gg: AeBDieureMckw4OTNEh3eC4mKTIQ4tMkw894qDZWj7eE1PwmFqhd+Prh0NjvKVaOtyF
 g029NwVCqH4/0CfnSpDvWr470KNJslFA+DekpK4LCxI+5frf8DyAk1WFcqfpb/6WygkMxSzmq9W
 5eB1KgIKlSvN6RRLBVdfH+Wq6/PgIDr10BH1vVLzHaA81Vtt0rz+wQj/iAiqggrlynXNUKMoQaa
 wJKFgGwjKqpJjbwB8sBfoO1q8FoMp36F7MS1IHtURkxIIhRO3CtVNSczNAp9PmLOE+gId5McUEz
 8Fq/dphRYKyEOMwO9+g2qa+FQkkmOEyPPeFiWfSJeRBtbVo8hZ9O1xtCNHsOmFr9g8yewDw3NJD
 cdDtwlzW8ZmJ4vkzOvYddFU8+Xqx7PXumtEvPqDxWGUX6X0sf/rtDBnkHJodLrEZkjb8U4zGT9w
 ==
X-Received: by 2002:a05:6a20:e211:b0:3a2:7ef4:81df with SMTP id
 adf61e73a8af0-3a27ef485b0mr14887062637.26.1776853882370; 
 Wed, 22 Apr 2026 03:31:22 -0700 (PDT)
X-Received: by 2002:a05:6a20:e211:b0:3a2:7ef4:81df with SMTP id
 adf61e73a8af0-3a27ef485b0mr14886993637.26.1776853881738; 
 Wed, 22 Apr 2026 03:31:21 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7976f920e1sm12589666a12.2.2026.04.22.03.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 03:31:21 -0700 (PDT)
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
Subject: [PATCH v5 09/10] tpm: Extend TPM TIS buffer size to 8192 bytes
Date: Wed, 22 Apr 2026 16:00:17 +0530
Message-ID: <20260422103018.123608-10-armenon@redhat.com>
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

From: Stefan Berger <stefanb@linux.ibm.com>

Extend the TIS buffer size to 8192 bytes and store the first 4096 bytes
using VMSTATE_PARTIAL_BUFFER and the rest using VMSTATE_BUFFER_START_MIDDLE
when necessary. It is necessary to store the buffer beyond original 4096
bytes when:

 - the user has written more than 4096 bytes to the buffer
 - the TPM 2 response is larger than 4096 bytes

Use the .needed function of the VMStateDescription interface to check
whether the bytes in the buffer beyond 4096 bytes needed to be saved.
The .pre_save function is called before the .needed function so that we
can be sure to have received any response packet from the TPM.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
[ Arun Menon - Removed WIP tag and TODO for submission ]
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 hw/tpm/tpm_tis.h        |  2 ++
 hw/tpm/tpm_tis_common.c | 23 +++++++++++++++++++++++
 hw/tpm/tpm_tis_i2c.c    | 24 +++++++++++++++++++++++-
 hw/tpm/tpm_tis_isa.c    | 24 +++++++++++++++++++++++-
 hw/tpm/tpm_tis_sysbus.c | 24 +++++++++++++++++++++++-
 5 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
index 184632ff66..d35c332287 100644
--- a/hw/tpm/tpm_tis.h
+++ b/hw/tpm/tpm_tis.h
@@ -90,4 +90,6 @@ uint32_t tpm_tis_read_data(TPMState *s, hwaddr addr, unsigned size);
 void tpm_tis_write_data(TPMState *s, hwaddr addr, uint64_t val, uint32_t size);
 uint16_t tpm_tis_get_checksum(TPMState *s);
 
+bool tpm_tis_ext_buffer_migration_needed(struct TPMState *s);
+
 #endif /* TPM_TPM_TIS_H */
diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
index f594b15b8a..dffb0a411e 100644
--- a/hw/tpm/tpm_tis_common.c
+++ b/hw/tpm/tpm_tis_common.c
@@ -890,3 +890,26 @@ const VMStateDescription vmstate_locty = {
     }
 };
 
+bool tpm_tis_ext_buffer_migration_needed(struct TPMState *s)
+{
+    if (!TPM_TIS_IS_VALID_LOCTY(s->active_locty)) {
+        return false;
+    }
+
+    switch (s->loc[s->active_locty].state) {
+    case TPM_TIS_STATE_IDLE:
+    case TPM_TIS_STATE_READY:
+        return false;
+    case TPM_TIS_STATE_RECEPTION:
+        return s->rw_offset >= 4096;
+    case TPM_TIS_STATE_EXECUTION:
+        /*
+         * TPM is executing: we cannot know the size of TPM response.
+         * .pre_save must have been called before (should never get here).
+         */
+        return false;
+    case TPM_TIS_STATE_COMPLETION:
+        return (tpm_cmd_get_size(&s->buffer) >= 4096);
+    }
+    return false;
+}
diff --git a/hw/tpm/tpm_tis_i2c.c b/hw/tpm/tpm_tis_i2c.c
index 9f13e0ec12..a01df7e5a0 100644
--- a/hw/tpm/tpm_tis_i2c.c
+++ b/hw/tpm/tpm_tis_i2c.c
@@ -110,13 +110,31 @@ static int tpm_tis_i2c_post_load(void *opaque, int version_id)
     return 0;
 }
 
+static bool tpm_tis_ext_buffer_migration_needed_i2c(void *opaque)
+{
+    TPMStateI2C *i2cst = opaque;
+
+    return tpm_tis_ext_buffer_migration_needed(&i2cst->state);
+}
+
+static const VMStateDescription vmstate_tpm_tis_ext_buffer_i2c = {
+    .name = "tpm-tis/ext_buffer",
+    .version_id = 0,
+    .needed = tpm_tis_ext_buffer_migration_needed_i2c,
+    .pre_save = tpm_tis_i2c_pre_save,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BUFFER_START_MIDDLE(state.buffer, TPMStateI2C, 4096),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_tpm_tis_i2c = {
     .name = "tpm-tis-i2c",
     .version_id = 0,
     .pre_save  = tpm_tis_i2c_pre_save,
     .post_load  = tpm_tis_i2c_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_BUFFER(state.buffer, TPMStateI2C),
+        VMSTATE_PARTIAL_BUFFER(state.buffer, TPMStateI2C, 4096),
         VMSTATE_UINT16(state.rw_offset, TPMStateI2C),
         VMSTATE_UINT8(state.active_locty, TPMStateI2C),
         VMSTATE_UINT8(state.aborting_locty, TPMStateI2C),
@@ -133,6 +151,10 @@ static const VMStateDescription vmstate_tpm_tis_i2c = {
         VMSTATE_UINT8(csum_enable, TPMStateI2C),
 
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription *const[]) {
+        &vmstate_tpm_tis_ext_buffer_i2c,
+        NULL,
     }
 };
 
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 61e95434f5..73038f1a10 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -49,12 +49,30 @@ static int tpm_tis_pre_save_isa(void *opaque)
     return tpm_tis_pre_save(&isadev->state);
 }
 
+static bool tpm_tis_ext_buffer_migration_needed_isa(void *opaque)
+{
+    TPMStateISA *isadev = opaque;
+
+    return tpm_tis_ext_buffer_migration_needed(&isadev->state);
+}
+
+static const VMStateDescription vmstate_tpm_tis_ext_buffer_isa = {
+    .name = "tpm-tis/ext_buffer",
+    .version_id = 0,
+    .needed = tpm_tis_ext_buffer_migration_needed_isa,
+    .pre_save = tpm_tis_pre_save_isa,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BUFFER_START_MIDDLE(state.buffer, TPMStateISA, 4096),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_tpm_tis_isa = {
     .name = "tpm-tis",
     .version_id = 0,
     .pre_save  = tpm_tis_pre_save_isa,
     .fields = (const VMStateField[]) {
-        VMSTATE_BUFFER(state.buffer, TPMStateISA),
+        VMSTATE_PARTIAL_BUFFER(state.buffer, TPMStateISA, 4096),
         VMSTATE_UINT16(state.rw_offset, TPMStateISA),
         VMSTATE_UINT8(state.active_locty, TPMStateISA),
         VMSTATE_UINT8(state.aborting_locty, TPMStateISA),
@@ -64,6 +82,10 @@ static const VMStateDescription vmstate_tpm_tis_isa = {
                              vmstate_locty, TPMLocality),
 
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription *const[]) {
+        &vmstate_tpm_tis_ext_buffer_isa,
+        NULL,
     }
 };
 
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index e9372e7316..86fc5a592c 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -48,12 +48,30 @@ static int tpm_tis_pre_save_sysbus(void *opaque)
     return tpm_tis_pre_save(&sbdev->state);
 }
 
+static bool tpm_tis_ext_buffer_migration_needed_sysbus(void *opaque)
+{
+    TPMStateSysBus *sbdev = opaque;
+
+    return tpm_tis_ext_buffer_migration_needed(&sbdev->state);
+}
+
+static const VMStateDescription vmstate_tpm_tis_ext_buffer_sysbus = {
+    .name = "tpm-tis/ext_buffer",
+    .version_id = 0,
+    .needed = tpm_tis_ext_buffer_migration_needed_sysbus,
+    .pre_save  = tpm_tis_pre_save_sysbus,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BUFFER_START_MIDDLE(state.buffer, TPMStateSysBus, 4096),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_tpm_tis_sysbus = {
     .name = "tpm-tis",
     .version_id = 0,
     .pre_save  = tpm_tis_pre_save_sysbus,
     .fields = (const VMStateField[]) {
-        VMSTATE_BUFFER(state.buffer, TPMStateSysBus),
+        VMSTATE_PARTIAL_BUFFER(state.buffer, TPMStateSysBus, 4096),
         VMSTATE_UINT16(state.rw_offset, TPMStateSysBus),
         VMSTATE_UINT8(state.active_locty, TPMStateSysBus),
         VMSTATE_UINT8(state.aborting_locty, TPMStateSysBus),
@@ -63,6 +81,10 @@ static const VMStateDescription vmstate_tpm_tis_sysbus = {
                              0, vmstate_locty, TPMLocality),
 
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription *const[]) {
+        &vmstate_tpm_tis_ext_buffer_sysbus,
+        NULL,
     }
 };
 
-- 
2.53.0


