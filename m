Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03C7F46C47
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 14:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9kn9-000598-68; Mon, 06 Apr 2026 10:19:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9kn8-00058W-0F
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:19:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9kn6-0005Fn-2x
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775485139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X5BfOb29CchgA3O8cD3d/CWCo4Ox5ZAg0ea68Q66Ig0=;
 b=Cuc6uc261GsJuUWQabYiZQwRZLmXHUmnUeMaQQ1i3U7Je7R06chzsZKoTpJ0Rl/XVcHT/t
 BvWS7Eg5pSmeHMAks2P7ve6nC6dQx3JkoNaNr6MWf1LoH6t/g3Shqn0h+IYeY0aSv0ebKC
 TP93fXSsupwDd0NfLWA/LZva5fIEoKQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-v5rrIPv4MceRL9aJKZVDuw-1; Mon, 06 Apr 2026 10:18:58 -0400
X-MC-Unique: v5rrIPv4MceRL9aJKZVDuw-1
X-Mimecast-MFC-AGG-ID: v5rrIPv4MceRL9aJKZVDuw_1775485137
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b24e9b4d82so51142445ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 07:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775485137; x=1776089937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X5BfOb29CchgA3O8cD3d/CWCo4Ox5ZAg0ea68Q66Ig0=;
 b=AY6mdoq6zD71DR9DALychDnXMhF0H5RUmyypL2aJd82CMQmEKJA1J57kSJgGoEcQVF
 sVv3oWRGgV+YMpkQjssEn6qGwdDtl2LhJNHlGqpYTVHY561be8/zziRkcvXFaXIv5cju
 XFNP+kPh3C9cSUrixTlnoUDi3KqVEEBMPo258zIZph2MimfXoyjqs5h8m0NCLb+hogvs
 Bu/e3cB4mUDfooU1ji6yrhaCIhvkbGn6ORtLZMlWvADobsSN/OEyGVbynBZcjxdQAGht
 WOeHR1nfVaV/geN+0GMnTtu1XktWh99SlKmpzQ378BTVPFKtL5hJ0c5rvh7sS1ZCsyxu
 +6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775485137; x=1776089937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X5BfOb29CchgA3O8cD3d/CWCo4Ox5ZAg0ea68Q66Ig0=;
 b=TrWvzaUBdogGhfiwnN6MQox4Fxp4tAQjgQap/vuoqQJXd/g5iiMXE3g+zl1g0l5TA6
 F2YMW5dk1l61Rypnt4h9WdPPCQnlO9gT8EhSBEhLszv7dFz5dWokX6iyZ7tFHd/6CQEI
 j5JQQ/soU3Yn9qWJh1RLct1e6fgsBWsNnGAE+IUSm0xdR9XLLcI6qZ7vLZFmA9kj5Rpz
 MMP+sC9oKYnVkOc2WS3jW6HU2dSMrR3o6birOrjkyVkg54mqjekwab5bU0aCkmK8gwQq
 dksQLqfLyhySzqMsyPSOpj5W2xQpJLHW9Zki+ZgJOJ1obmCfC4cLW1ESPmLoHpO2nVgQ
 G/xA==
X-Gm-Message-State: AOJu0YxBAf9STpcN6Isjo+dD/4lh7fBagRAdtVhwsoNVTunD30OYbead
 BriigfjBSAkB91rBT+BNcYTdkEp1ezeMwS1SD1JWI8RSD0JKFD17YKAzKpGzK1RFMwyt7Vy4hhf
 ryW0CENgoDyrNGDPIRO9vdJorDberyAODXcvroZ+3T1aSjnd2Sb0QNnDRiWpMux3iGqGc9klFQy
 N2+NzssogNFDrygcH2nQyi7ABxCXkTMwOxiYJSVh0=
X-Gm-Gg: AeBDievLYpfUhXIGOp20PlXWAHJX/Bwhx5QK01V8nmaJ7YP/S6rLXiP136GOwlOd26R
 jkh5ceyYRwp3eZ1/qe1pJWF20aE3XdHhAC5h8dcQOxzNZVzVfRAfROoatNYWDqqpNJMsFOUXqKF
 F9TxHt2BTrXheNI5+8COOm+Snhs5c+ILdyeDcPpYbkvQ8n+FIElJ2VkuNLAg/G/8iPsCdddwBj3
 bPIoqrZleq230YQIqQZu421bd1RyzQS0XspXyKiT3kPHp18p0OpoodZWXk97xV8WOl0uIc4VCGp
 obujG+Pzut/jqCr9n76WQhooJxTksPXwv+OS7vtGvvKp7smbzXBKONwyNYTijI9PXe0ueG7kWdk
 RsvUX0kgcoAI5OrK2pzeEzx65cLs6iYkCS/mu3KvgdIU4tWporA7D5Sn4cWQ7JH8kqzg=
X-Received: by 2002:a17:902:f70c:b0:2b0:4fb3:c771 with SMTP id
 d9443c01a7336-2b277d6372emr149470805ad.6.1775485136598; 
 Mon, 06 Apr 2026 07:18:56 -0700 (PDT)
X-Received: by 2002:a17:902:f70c:b0:2b0:4fb3:c771 with SMTP id
 d9443c01a7336-2b277d6372emr149470345ad.6.1775485135989; 
 Mon, 06 Apr 2026 07:18:55 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([152.59.100.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478cb4fsm156732905ad.29.2026.04.06.07.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 07:18:55 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 marcandre.lureau@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Arun Menon <armenon@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 09/10] tpm: Extend TPM TIS buffer size to 8192 bytes
Date: Mon,  6 Apr 2026 19:47:34 +0530
Message-ID: <20260406141735.25844-10-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406141735.25844-1-armenon@redhat.com>
References: <20260406141735.25844-1-armenon@redhat.com>
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


