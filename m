Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C566FED7B82
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCZAz-0001Nr-PJ; Tue, 14 Apr 2026 04:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wCZAx-0001Fh-RB
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 04:31:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wCZAv-00047g-KQ
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 04:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776155472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X5BfOb29CchgA3O8cD3d/CWCo4Ox5ZAg0ea68Q66Ig0=;
 b=W/IdM70Bwj6aWlE4JIJhzd70oxe7SaFhxQvBsRK2x+DoVVvfIXIjY70PHZhwjyucJzKnpO
 XBEmeP+oZOgFOCucuuplWXTt1SgqfXaRIMHMQxgr97eektPFW+9gZpCB4VocRxh6fEXyg3
 ZcO3zXV7U459CZ2MF9VGPKPtC6Y/foc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-osmJiZLbP_66UXfO1frCug-1; Tue, 14 Apr 2026 04:31:11 -0400
X-MC-Unique: osmJiZLbP_66UXfO1frCug-1
X-Mimecast-MFC-AGG-ID: osmJiZLbP_66UXfO1frCug_1776155471
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b2523e0299so129491055ad.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 01:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776155470; x=1776760270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X5BfOb29CchgA3O8cD3d/CWCo4Ox5ZAg0ea68Q66Ig0=;
 b=NxENyXtL3Ye4D0f5rkcxHzko66O99Ik51vc0rj+c87jD7MzDTG1c0ofCkUPxdYylxl
 nUXakZaWAna9Dxj7ybQzg/Latb/J0QdSAxN1jzV5AV0xS/FV2oBqLqXsusa0Zhpy5Wvc
 PceSipnJ9SF4BbcOqGw1iXqF62rrQvbSCr92oJv24jh5yALaP99CtUDW/Qv1Vh5DgoUh
 YY7IT6Uows7miFdZogsLeR7Sq1jktOzquB0gf26j0EWu800J7QB8pRIo0HKi+7B+hpe7
 Wdxdm5OP6hmSIAFdg/SVBkOZ5hfGQFYCf8kgb9LBLhLzbxhLyXyUx2C1+WWAZ5NuXFvd
 5Jqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776155470; x=1776760270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X5BfOb29CchgA3O8cD3d/CWCo4Ox5ZAg0ea68Q66Ig0=;
 b=VVXBD14K1rSthcMxcBQIQubZ6tG6zG/U0gijfkr3pBJna+DlKAEka3edShDirSS+Tj
 9+wv1MyWgjbyLFsfH54dO1DQlk7BnUIgHU2cU/IlS50Gi3V3VqGxdeNsAhcd13shvXEE
 ZhCa5WvqqwNwVvm79ijbED1Hd+Zxtw/ZwSGNzCM/QeWRZprQaxKhxqya6jHEU5e3tfgy
 5AY9IbPqaX3DZd5+orhsdZokYFDAJmMEY8RrjRDGi0cKTl+0yoJ/KuPQi0quBhz9ujzc
 5uk7taRGyej9NK1e/94s5kHOnW5lmN0tfyvrkVvrwzBukeHqGuj2SVE6y8JMjUlAYjeV
 Jyzg==
X-Gm-Message-State: AOJu0YzQCzQWlI03P3Deb9Iq19G5bMiyS8zVvmdVcxQupkFfwmCGIntW
 0gnElpdc8nDGEJlgktdiW7whDUhQHSSnFU8jJZNAOhuuH7x3Ko6X7uoFIJKnZg0dckZ8CPv7bpy
 SVqei5KhjAEhd+Ivg05JE9c0OY7Pe3/pRfIfjP8w22AAyzHB96V0V+4v9Ws6MQsF0Ak8vBV5F0Y
 VPJjniPia4aU53SCfjts6cdT2D2/2oNHaeB7i3qMY=
X-Gm-Gg: AeBDievRgfw95zCsZUp4pFvw2w9WbxOTmiiOhAEfbvIASHhW9Y2ZTwIePvFPGBez4MS
 SOmni+Es5KIvGD6ceI3tt57nU75yJsSHFqW8KGx1YMuExKiCf+VxIJYOaSRMBr+grrkFNBi8Q5f
 f2y9oZUHF5MEl+KbkSxCmHUcLJYeX3S34zuQnyWk0hWl2lsOrlUEa5SGwJZ8G2NxUM5py44s0Ei
 adf2uKN54bIoqT2P6nrwJw3owLs1pDsEakHuYkcNGyFjawoT80tDuxPpT4E453jLcY7Iqw3MdzC
 UxixCnuPx9djEKja3UVDOjR8UtujMBXUgYkyyKSC7+bEvDNZRXPXw3IZ9GHiKRnZLAJyY1j0RAw
 v9cP/sBETxlMf+AZT6/R5qyd7OM04s3YXhb7ODVaIxmnq3PqYKXHSsawD32mDRdY=
X-Received: by 2002:a17:903:2285:b0:2b0:b1e7:8841 with SMTP id
 d9443c01a7336-2b2d5a49b1emr169400585ad.32.1776155470283; 
 Tue, 14 Apr 2026 01:31:10 -0700 (PDT)
X-Received: by 2002:a17:903:2285:b0:2b0:b1e7:8841 with SMTP id
 d9443c01a7336-2b2d5a49b1emr169400185ad.32.1776155469634; 
 Tue, 14 Apr 2026 01:31:09 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4e0f909sm181493785ad.35.2026.04.14.01.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 01:31:09 -0700 (PDT)
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
 Fabiano Rosas <farosas@suse.de>, Arun Menon <armenon@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 09/10] tpm: Extend TPM TIS buffer size to 8192 bytes
Date: Tue, 14 Apr 2026 13:59:14 +0530
Message-ID: <20260414082915.112122-10-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414082915.112122-1-armenon@redhat.com>
References: <20260414082915.112122-1-armenon@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


