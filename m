Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02908D59D67
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 20:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFfFT-0005UR-Kk; Mon, 25 Nov 2024 14:59:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFK-0005F6-V6
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:46 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tFfFD-0004sP-96
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 14:59:46 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3823e45339bso3613061f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 11:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732564778; x=1733169578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gw4CAtCWZHkyS6PsIdGnG26rQiDW6W2BIcqFa8xSXq0=;
 b=JzQqVVF57x672fr9wxsHVR7LoWZnDKY5EyU7LAjhtCm6buYnNFti2VOsWes97hD3a+
 zUVYkVDxJSU/aVxK6ZoOksyBsRG4YMaxyT87SYe8e+SGRcFEavWYy/Nnhu72M4SgM8eh
 SmLtekDJO0Mr2GCJboMPp9k6PDSRtOgn4m6KgcyFwJ9WITGPOvLitdCOKhcN67tLpZaJ
 GaH1rH6jEZGJqIXu+g0788KX6KfEZUXkKZ9MuppEeFyuf8JTA5o9Nz9dl8UxS1NwC6cJ
 Q4Hznu/cMBxPkclH/D5Ze4g1VrDTGLfh36/RDWHxoOXeJadaK9rwXpeKvDMb/ALQIYbj
 gxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732564778; x=1733169578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gw4CAtCWZHkyS6PsIdGnG26rQiDW6W2BIcqFa8xSXq0=;
 b=vUFdcbYoYb+N4wWc5DJtW9tRqZ7GAQflrtwp3K91b4Y+mYykrFAGJhvjD+yTfp9DSP
 gfK1AgYWW6mw0y5TsRxKpZriE7s+pv87urc5ne8Dl/vgdMZZFFviHhrVeUVSbgasH6as
 7XMFc7K7uS/SVnIGw9+m6WO51l/e07dxHU+GNoa0ibUuRvF6LOc8ethEh4E+IqGxGcrb
 jdeSiDRUDtSuHpRjU9MZVtlw4GD9+BsoydtIZllxormL0cP+ROVccPd187Kb8AJjxasZ
 cDlaH6GcP99fk5i3CK7N5E0BEmf/IxO7zNGU0YhsZ1jZdJqO1YsP1JKN0D3Yvj4kDtfG
 MvfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx/YgXviMulRYwmoNJN6LqAuzba4cX9Pn8jQLdWTDF05IAYC2c1wCp/mm6/woXkhlb9lrFBk6jOosp@nongnu.org
X-Gm-Message-State: AOJu0Ywzwuor2PgksPhv1d+005ad7jC42WQ3TOPteUNnPGxsY33I0XCD
 ipJtbRFM6qx7pB/bdYYXmLKTgzuyT7KZub0Yv9NZQ56DDBIDdf1y2xBV0z0rX0U=
X-Gm-Gg: ASbGncudii52kMqM63Qhf5AFLj1uKpYGbEO5TqxnInRHM7hHUwlO7KtnyVLiKYtTCOZ
 DpaZ6BaKJfypiHao8ryJoiwj4QUhsctQK+19U+tAKU4L0uqWhCB/3iThU0V5TxCFBkJ40l/QhOP
 To5AYZYB0bZvCn0EqvrscAJWokYPSS2G7UEj4Z8aYN1Jpn55P9QJrBt31v3/emlGl32WdPKIq3J
 NMorV9LhMFBxfCnyaYZexsDMQ2EruE3aAQeQH2mSpegTIQk3DY011HdN8AzhHRRsr6T
X-Google-Smtp-Source: AGHT+IEzg8tSZSzM5M7PAnv/+rwiNHPuZQSFt85fVuX8MRm2KzuXcWmnFXwJzhBD8GzVmZB3aeXBDg==
X-Received: by 2002:a5d:6dad:0:b0:37d:4e74:684 with SMTP id
 ffacd0b85a97d-38260be230fmr13303703f8f.52.1732564777822; 
 Mon, 25 Nov 2024 11:59:37 -0800 (PST)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fd0fbdcsm11237971f8f.109.2024.11.25.11.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 11:59:37 -0800 (PST)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [RFC PATCH v3 23/26] hw/tpm: Add TPM event log
Date: Mon, 25 Nov 2024 19:56:22 +0000
Message-ID: <20241125195626.856992-25-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125195626.856992-2-jean-philippe@linaro.org>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Provide a library allowing the VMM to create an event log that describes
what is loaded into memory. During remote attestation in confidential
computing this helps an independent verifier reconstruct the initial
measurements of a VM, which contain the initial state of memory and
CPUs.

We provide some definitions and structures described by the Trusted
Computing Group (TCG) in "TCG PC Client Platform Firmware Profile
Specification" Level 00 Version 1.06 Revision 52 [1]. This is the same
format used by UEFI, and UEFI could reuse this log after finding it in
DT or ACPI tables, but can also copy its content into a new one.

[1] https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/

Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
v2->v3: New
---
 qapi/tpm.json            |  14 ++
 include/hw/tpm/tpm_log.h |  89 +++++++++++
 hw/tpm/tpm_log.c         | 325 +++++++++++++++++++++++++++++++++++++++
 hw/tpm/Kconfig           |   4 +
 hw/tpm/meson.build       |   1 +
 5 files changed, 433 insertions(+)
 create mode 100644 include/hw/tpm/tpm_log.h
 create mode 100644 hw/tpm/tpm_log.c

diff --git a/qapi/tpm.json b/qapi/tpm.json
index a16a72edb9..697e7150ee 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -188,3 +188,17 @@
 ##
 { 'command': 'query-tpm', 'returns': ['TPMInfo'],
   'if': 'CONFIG_TPM' }
+
+##
+# @TpmLogDigestAlgo:
+#
+# @sha256: Use the SHA256 algorithm
+#
+# @sha512: Use the SHA512 algorithm
+#
+# Algorithm to use for event log digests
+#
+# Since: 9.3
+##
+{ 'enum': 'TpmLogDigestAlgo',
+  'data': ['sha256', 'sha512'] }
diff --git a/include/hw/tpm/tpm_log.h b/include/hw/tpm/tpm_log.h
new file mode 100644
index 0000000000..b3cd2e7563
--- /dev/null
+++ b/include/hw/tpm/tpm_log.h
@@ -0,0 +1,89 @@
+#ifndef QEMU_TPM_LOG_H
+#define QEMU_TPM_LOG_H
+
+#include "qom/object.h"
+#include "sysemu/tpm.h"
+
+/*
+ * Defined in: TCG Algorithm Registry
+ * Family 2.0 Level 00 Revision 01.34
+ *
+ * (Here TCG stands for Trusted Computing Group)
+ */
+#define TCG_ALG_SHA256  0xB
+#define TCG_ALG_SHA512  0xD
+
+/* Size of a digest in bytes */
+#define TCG_ALG_SHA256_DIGEST_SIZE      32
+#define TCG_ALG_SHA512_DIGEST_SIZE      64
+
+/*
+ * Defined in: TCG PC Client Platform Firmware Profile Specification
+ * Version 1.06 revision 52
+ */
+#define TCG_EV_NO_ACTION                        0x00000003
+#define TCG_EV_EVENT_TAG                        0x00000006
+#define TCG_EV_POST_CODE2                       0x00000013
+#define TCG_EV_EFI_PLATFORM_FIRMWARE_BLOB2      0x8000000A
+
+struct UefiPlatformFirmwareBlob2Head {
+        uint8_t blob_description_size;
+        uint8_t blob_description[];
+} __attribute__((packed));
+
+struct UefiPlatformFirmwareBlob2Tail {
+        uint64_t blob_base;
+        uint64_t blob_size;
+} __attribute__((packed));
+
+#define TYPE_TPM_LOG "tpm-log"
+
+OBJECT_DECLARE_SIMPLE_TYPE(TpmLog, TPM_LOG)
+
+/**
+ * tpm_log_create - Create the event log
+ * @log: the log object
+ * @max_size: maximum size of the log. Adding an event past that size will
+ *            return an error
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Allocate the event log and create the initial entry (Spec ID Event03)
+ * describing the log format.
+ *
+ * Returns: 0 on success, -1 on error
+ */
+int tpm_log_create(TpmLog *log, size_t max_size, Error **errp);
+
+/**
+ * tpm_log_add_event - Append an event to the log
+ * @log: the log object
+ * @event_type: the `eventType` field in TCG_PCR_EVENT2
+ * @event: the `event` field in TCG_PCR_EVENT2
+ * @event_size: the `eventSize` field in TCG_PCR_EVENT2
+ * @data: content to be hashed into the event digest. May be NULL.
+ * @data_size: size of @data. Should be zero when @data is NULL.
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Add a TCG_PCR_EVENT2 event to the event log. Depending on the event type, a
+ * data buffer may be hashed into the event digest (for example
+ * TCG_EV_EFI_PLATFORM_FIRMWARE_BLOB2 contains a digest of the blob.)
+ *
+ * Returns: 0 on success, -1 on error
+ */
+int tpm_log_add_event(TpmLog *log, uint32_t event_type, const uint8_t *event,
+                      size_t event_size, const uint8_t *data, size_t data_size,
+                      Error **errp);
+
+/**
+ * tpm_log_write_and_close - Move the log to guest memory
+ * @log: the log object
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Write the log into memory, at the address set in the load-addr property.
+ * After this operation, the log is not writable anymore.
+ *
+ * Return: 0 on success, -1 on error
+ */
+int tpm_log_write_and_close(TpmLog *log, Error **errp);
+
+#endif
diff --git a/hw/tpm/tpm_log.c b/hw/tpm/tpm_log.c
new file mode 100644
index 0000000000..e6183a6e70
--- /dev/null
+++ b/hw/tpm/tpm_log.c
@@ -0,0 +1,325 @@
+/*
+ * tpm_log.c - Event log as described by the Trusted Computing Group (TCG)
+ *
+ * Copyright (c) 2024 Linaro Ltd.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ * Create an event log in the format specified by:
+ *
+ *  TCG PC Client Platform Firmware Profile Specification
+ *  Level 00 Version 1.06 Revision 52
+ *  Family “2.0”
+ */
+
+#include "qemu/osdep.h"
+
+#include "crypto/hash.h"
+#include "exec/address-spaces.h"
+#include "exec/memory.h"
+#include "hw/tpm/tpm_log.h"
+#include "qapi/error.h"
+#include "qemu/bswap.h"
+#include "qom/object_interfaces.h"
+
+/*
+ * Legacy structure used only in the first event in the log, for compatibility
+ */
+struct TcgPcClientPcrEvent {
+        uint32_t pcr_index;
+        uint32_t event_type;
+        uint8_t  digest[20];
+        uint32_t event_data_size;
+        uint8_t  event[];
+} __attribute__((packed));
+
+struct TcgEfiSpecIdEvent {
+        uint8_t  signature[16];
+        uint32_t platform_class;
+        uint8_t  family_version_minor;
+        uint8_t  family_version_major;
+        uint8_t  spec_revision;
+        uint8_t  uintn_size;
+        uint32_t number_of_algorithms; /* 1 */
+        /*
+         * For now we declare a single algo, but if we want UEFI to reuse this
+         * header then we'd need to add entries here for all algos supported by
+         * UEFI (and expand the digest field for EV_NO_ACTION).
+         */
+        uint16_t algorithm_id;
+        uint16_t digest_size;
+        uint8_t  vendor_info_size;
+        uint8_t  vendor_info[];
+} __attribute__((packed));
+
+struct TcgPcrEvent2Head {
+        uint32_t pcr_index;
+        uint32_t event_type;
+        /* variable-sized digests */
+        uint8_t  digests[];
+} __attribute__((packed));
+
+struct TcgPcrEvent2Tail {
+        uint32_t event_size;
+        uint8_t  event[];
+} __attribute__((packed));
+
+struct TpmlDigestValues {
+        uint32_t count;     /* 1 */
+        uint16_t hash_alg;
+        uint8_t  digest[];
+} __attribute__((packed));
+
+struct TpmLog {
+    Object parent_obj;
+
+    TpmLogDigestAlgo digest_algo;
+    size_t max_size;
+    uint64_t load_addr;
+
+    uint16_t tcg_algo;
+    GByteArray *content;
+    uint8_t *digest;
+    size_t digest_size;
+};
+
+OBJECT_DEFINE_SIMPLE_TYPE(TpmLog, tpm_log, TPM_LOG, OBJECT)
+
+static void tpm_log_init(Object *obj)
+{
+    TpmLog *log = TPM_LOG(obj);
+
+    log->digest_algo = TPM_LOG_DIGEST_ALGO_SHA256;
+}
+
+static void tpm_log_destroy(TpmLog *log)
+{
+    if (!log->content) {
+        return;
+    }
+    g_free(log->digest);
+    log->digest = NULL;
+    g_byte_array_free(log->content, /* free_segment */ true);
+    log->content = NULL;
+}
+
+static void tpm_log_finalize(Object *obj)
+{
+    tpm_log_destroy(TPM_LOG(obj));
+}
+
+static int tpm_log_get_digest_algo(Object *obj, Error **errp)
+{
+    TpmLog *log = TPM_LOG(obj);
+
+    return log->digest_algo;
+}
+
+static void tpm_log_set_digest_algo(Object *obj, int algo, Error **errp)
+{
+    TpmLog *log = TPM_LOG(obj);
+
+    if (log->content != NULL) {
+        error_setg(errp, "cannot set digest algo after log creation");
+        return;
+    }
+
+    log->digest_algo = algo;
+}
+
+static void tpm_log_get_max_size(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    TpmLog *log = TPM_LOG(obj);
+    uint64_t value = log->max_size;
+
+    visit_type_uint64(v, name, &value, errp);
+}
+
+static void tpm_log_get_load_addr(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    TpmLog *log = TPM_LOG(obj);
+    uint64_t value = log->load_addr;
+
+    visit_type_uint64(v, name, &value, errp);
+}
+
+static void tpm_log_set_load_addr(Object *obj, Visitor *v, const char *name,
+                                  void *opaque, Error **errp)
+{
+    TpmLog *log = TPM_LOG(obj);
+    uint64_t value;
+
+    if (!visit_type_uint64(v, name, &value, errp)) {
+        return;
+    }
+
+    log->load_addr = value;
+}
+
+
+static void tpm_log_class_init(ObjectClass *oc, void *data)
+{
+    object_class_property_add_enum(oc, "digest-algo",
+                                   "TpmLogDigestAlgo",
+                                   &TpmLogDigestAlgo_lookup,
+                                   tpm_log_get_digest_algo,
+                                   tpm_log_set_digest_algo);
+    object_class_property_set_description(oc, "digest-algo",
+            "Algorithm used to hash blobs added as events ('sha256', 'sha512')");
+
+    /* max_size is set while allocating the log in tpm_log_create */
+    object_class_property_add(oc, "max-size", "uint64", tpm_log_get_max_size,
+                              NULL, NULL, NULL);
+    object_class_property_set_description(oc, "max-size",
+            "Maximum size of the log, reserved in guest memory");
+
+    object_class_property_add(oc, "load-addr", "uint64", tpm_log_get_load_addr,
+                              tpm_log_set_load_addr, NULL, NULL);
+    object_class_property_set_description(oc, "load-addr",
+            "Base address of the log in guest memory");
+}
+
+int tpm_log_create(TpmLog *log, size_t max_size, Error **errp)
+{
+    struct TcgEfiSpecIdEvent event;
+    struct TcgPcClientPcrEvent header = {
+        .pcr_index = 0,
+        .event_type = cpu_to_le32(TCG_EV_NO_ACTION),
+        .digest = {0},
+        .event_data_size = cpu_to_le32(sizeof(event)),
+    };
+
+    log->content = g_byte_array_sized_new(max_size);
+    log->max_size = max_size;
+
+    switch (log->digest_algo) {
+    case TPM_LOG_DIGEST_ALGO_SHA256:
+        log->tcg_algo = TCG_ALG_SHA256;
+        log->digest_size = TCG_ALG_SHA256_DIGEST_SIZE;
+        break;
+    case TPM_LOG_DIGEST_ALGO_SHA512:
+        log->tcg_algo = TCG_ALG_SHA512;
+        log->digest_size = TCG_ALG_SHA512_DIGEST_SIZE;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    log->digest = g_malloc0(log->digest_size);
+
+    event = (struct TcgEfiSpecIdEvent) {
+        .signature = "Spec ID Event03",
+        .platform_class = 0,
+        .family_version_minor = 0,
+        .family_version_major = 2,
+        .spec_revision = 106,
+        .uintn_size = 2, /* UINT64 */
+        .number_of_algorithms = cpu_to_le32(1),
+        .algorithm_id = cpu_to_le16(log->tcg_algo),
+        .digest_size = cpu_to_le16(log->digest_size),
+        .vendor_info_size = 0,
+    };
+
+    g_byte_array_append(log->content, (guint8 *)&header, sizeof(header));
+    g_byte_array_append(log->content, (guint8 *)&event, sizeof(event));
+    return 0;
+}
+
+int tpm_log_add_event(TpmLog *log, uint32_t event_type, const uint8_t *event,
+                      size_t event_size, const uint8_t *data, size_t data_size,
+                      Error **errp)
+{
+    int digests = 0;
+    size_t rollback_len;
+    struct TcgPcrEvent2Head header = {
+        .pcr_index = 0,
+        .event_type = cpu_to_le32(event_type),
+    };
+    struct TpmlDigestValues digest_header = {0};
+    struct TcgPcrEvent2Tail tail = {
+        .event_size = cpu_to_le32(event_size),
+    };
+
+    if (log->content == NULL) {
+        error_setg(errp, "event log is not initialized");
+        return -EINVAL;
+    }
+    rollback_len = log->content->len;
+
+    g_byte_array_append(log->content, (guint8 *)&header, sizeof(header));
+
+    if (data) {
+        QCryptoHashAlgo qc_algo;
+
+        digest_header.hash_alg = cpu_to_le16(log->tcg_algo);
+        switch (log->digest_algo) {
+        case TPM_LOG_DIGEST_ALGO_SHA256:
+            qc_algo = QCRYPTO_HASH_ALGO_SHA256;
+            break;
+        case TPM_LOG_DIGEST_ALGO_SHA512:
+            qc_algo = QCRYPTO_HASH_ALGO_SHA512;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        if (qcrypto_hash_bytes(qc_algo, (const char *)data, data_size,
+                               &log->digest, &log->digest_size, errp)) {
+            goto err_rollback;
+        }
+        digests = 1;
+    } else if (event_type == TCG_EV_NO_ACTION) {
+        /* EV_NO_ACTION contains empty digests for each supported algo */
+        memset(log->digest, 0, log->digest_size);
+        digest_header.hash_alg = 0;
+        digests = 1;
+    }
+
+    if (digests) {
+        digest_header.count = cpu_to_le32(digests);
+        g_byte_array_append(log->content, (guint8 *)&digest_header,
+                            sizeof(digest_header));
+        g_byte_array_append(log->content, log->digest, log->digest_size);
+    } else {
+        /* Add an empty digests list */
+        g_byte_array_append(log->content, (guint8 *)&digest_header.count,
+                            sizeof(digest_header.count));
+    }
+
+    g_byte_array_append(log->content, (guint8 *)&tail, sizeof(tail));
+    g_byte_array_append(log->content, event, event_size);
+
+    if (log->content->len > log->max_size) {
+        error_setg(errp, "event log exceeds max size");
+        goto err_rollback;
+    }
+
+    return 0;
+
+err_rollback:
+    g_byte_array_set_size(log->content, rollback_len);
+    return -1;
+}
+
+int tpm_log_write_and_close(TpmLog *log, Error **errp)
+{
+    int ret;
+
+    if (!log->content) {
+        error_setg(errp, "event log is not initialized");
+        return -1;
+    }
+
+    ret = address_space_write_rom(&address_space_memory, log->load_addr,
+                                  MEMTXATTRS_UNSPECIFIED, log->content->data,
+                                  log->content->len);
+    if (ret) {
+        error_setg(errp, "cannot load log into memory");
+        return -1;
+    }
+
+    tpm_log_destroy(log);
+    return ret;
+}
diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
index a46663288c..70694b14a3 100644
--- a/hw/tpm/Kconfig
+++ b/hw/tpm/Kconfig
@@ -30,3 +30,7 @@ config TPM_SPAPR
     default y
     depends on TPM && PSERIES
     select TPM_BACKEND
+
+config TPM_LOG
+    bool
+    default y
diff --git a/hw/tpm/meson.build b/hw/tpm/meson.build
index 6968e60b3f..81efb557f3 100644
--- a/hw/tpm/meson.build
+++ b/hw/tpm/meson.build
@@ -6,4 +6,5 @@ system_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_crb.c'))
 system_ss.add(when: 'CONFIG_TPM_TIS', if_true: files('tpm_ppi.c'))
 system_ss.add(when: 'CONFIG_TPM_CRB', if_true: files('tpm_ppi.c'))
 
+system_ss.add(when: 'CONFIG_TPM_LOG', if_true: files('tpm_log.c'))
 specific_ss.add(when: 'CONFIG_TPM_SPAPR', if_true: files('tpm_spapr.c'))
-- 
2.47.0


