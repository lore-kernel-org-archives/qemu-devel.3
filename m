Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C55BC282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 12:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpRhS-0004gw-0t; Tue, 04 Mar 2025 07:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tpRhJ-0004ev-5u
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 07:48:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tpRhF-0006hm-P4
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 07:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741092509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=soxuZe2OoPmZHU6LJxXL0aHKa070QZ98vQ3VDzAbP+4=;
 b=E4e5LA9zMBj5pjVxbrcmARouNE0mkDYDyRYxx+Dn27N7T/kV/Obhfth4M+uO66R5rklaQa
 5oZj9KP7AHoWYx0XGcc6nDO8cKbC4BKAMIrVlJ4XYh9b3o7ixvPwF323TiVYoitiytmi6j
 lE7fc3NlZmN2bWC/FuIBt9t6Lo19GIs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-oKOVJFEwNyOyZioV7e1iJg-1; Tue,
 04 Mar 2025 07:48:24 -0500
X-MC-Unique: oKOVJFEwNyOyZioV7e1iJg-1
X-Mimecast-MFC-AGG-ID: oKOVJFEwNyOyZioV7e1iJg_1741092503
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E8B51954B20; Tue,  4 Mar 2025 12:48:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.122])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A408A180035F; Tue,  4 Mar 2025 12:48:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5B5F91800399; Tue, 04 Mar 2025 13:48:15 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 03/24] hw/uefi: add include/hw/uefi/var-service-edk2.h
Date: Tue,  4 Mar 2025 13:47:51 +0100
Message-ID: <20250304124815.591749-4-kraxel@redhat.com>
In-Reply-To: <20250304124815.591749-1-kraxel@redhat.com>
References: <20250304124815.591749-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A bunch of #defines and structs copied over from edk2,
mostly needed to decode and encode the messages in the
communication buffer.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20250225163031.1409078-4-kraxel@redhat.com>
---
 include/hw/uefi/var-service-edk2.h | 227 +++++++++++++++++++++++++++++
 1 file changed, 227 insertions(+)
 create mode 100644 include/hw/uefi/var-service-edk2.h

diff --git a/include/hw/uefi/var-service-edk2.h b/include/hw/uefi/var-service-edk2.h
new file mode 100644
index 000000000000..c743a8df948d
--- /dev/null
+++ b/include/hw/uefi/var-service-edk2.h
@@ -0,0 +1,227 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * uefi-vars device - structs and defines from edk2
+ *
+ * Note: The edk2 UINTN type has been mapped to uint64_t,
+ *       so the structs are compatible with 64bit edk2 builds.
+ */
+#ifndef QEMU_UEFI_VAR_SERVICE_EDK2_H
+#define QEMU_UEFI_VAR_SERVICE_EDK2_H
+
+#include "qemu/uuid.h"
+
+#define MAX_BIT                   0x8000000000000000ULL
+#define ENCODE_ERROR(StatusCode)  (MAX_BIT | (StatusCode))
+#define EFI_SUCCESS               0
+#define EFI_INVALID_PARAMETER     ENCODE_ERROR(2)
+#define EFI_UNSUPPORTED           ENCODE_ERROR(3)
+#define EFI_BAD_BUFFER_SIZE       ENCODE_ERROR(4)
+#define EFI_BUFFER_TOO_SMALL      ENCODE_ERROR(5)
+#define EFI_WRITE_PROTECTED       ENCODE_ERROR(8)
+#define EFI_OUT_OF_RESOURCES      ENCODE_ERROR(9)
+#define EFI_NOT_FOUND             ENCODE_ERROR(14)
+#define EFI_ACCESS_DENIED         ENCODE_ERROR(15)
+#define EFI_ALREADY_STARTED       ENCODE_ERROR(20)
+#define EFI_SECURITY_VIOLATION    ENCODE_ERROR(26)
+
+#define EFI_VARIABLE_NON_VOLATILE                           0x01
+#define EFI_VARIABLE_BOOTSERVICE_ACCESS                     0x02
+#define EFI_VARIABLE_RUNTIME_ACCESS                         0x04
+#define EFI_VARIABLE_HARDWARE_ERROR_RECORD                  0x08
+#define EFI_VARIABLE_AUTHENTICATED_WRITE_ACCESS             0x10  /* deprecated */
+#define EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS  0x20
+#define EFI_VARIABLE_APPEND_WRITE                           0x40
+
+/* SecureBootEnable */
+#define SECURE_BOOT_ENABLE         1
+#define SECURE_BOOT_DISABLE        0
+
+/* SecureBoot */
+#define SECURE_BOOT_MODE_ENABLE    1
+#define SECURE_BOOT_MODE_DISABLE   0
+
+/* CustomMode */
+#define CUSTOM_SECURE_BOOT_MODE    1
+#define STANDARD_SECURE_BOOT_MODE  0
+
+/* SetupMode */
+#define SETUP_MODE                 1
+#define USER_MODE                  0
+
+typedef uint64_t efi_status;
+typedef struct mm_header mm_header;
+
+/* EFI_MM_COMMUNICATE_HEADER */
+struct mm_header {
+    QemuUUID  guid;
+    uint64_t  length;
+};
+
+/* --- EfiSmmVariableProtocol ---------------------------------------- */
+
+#define SMM_VARIABLE_FUNCTION_GET_VARIABLE            1
+#define SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME  2
+#define SMM_VARIABLE_FUNCTION_SET_VARIABLE            3
+#define SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO     4
+#define SMM_VARIABLE_FUNCTION_READY_TO_BOOT           5
+#define SMM_VARIABLE_FUNCTION_EXIT_BOOT_SERVICE       6
+#define SMM_VARIABLE_FUNCTION_LOCK_VARIABLE           8
+#define SMM_VARIABLE_FUNCTION_GET_PAYLOAD_SIZE       11
+
+typedef struct mm_variable mm_variable;
+typedef struct mm_variable_access mm_variable_access;
+typedef struct mm_next_variable mm_next_variable;
+typedef struct mm_next_variable mm_lock_variable;
+typedef struct mm_variable_info mm_variable_info;
+typedef struct mm_get_payload_size mm_get_payload_size;
+
+/* SMM_VARIABLE_COMMUNICATE_HEADER */
+struct mm_variable {
+    uint64_t  function;
+    uint64_t  status;
+};
+
+/* SMM_VARIABLE_COMMUNICATE_ACCESS_VARIABLE */
+struct QEMU_PACKED mm_variable_access {
+    QemuUUID  guid;
+    uint64_t  data_size;
+    uint64_t  name_size;
+    uint32_t  attributes;
+    /* Name */
+    /* Data */
+};
+
+/* SMM_VARIABLE_COMMUNICATE_GET_NEXT_VARIABLE_NAME */
+struct mm_next_variable {
+    QemuUUID  guid;
+    uint64_t  name_size;
+    /* Name */
+};
+
+/* SMM_VARIABLE_COMMUNICATE_QUERY_VARIABLE_INFO */
+struct QEMU_PACKED mm_variable_info {
+    uint64_t max_storage_size;
+    uint64_t free_storage_size;
+    uint64_t max_variable_size;
+    uint32_t attributes;
+};
+
+/* SMM_VARIABLE_COMMUNICATE_GET_PAYLOAD_SIZE */
+struct mm_get_payload_size {
+    uint64_t  payload_size;
+};
+
+/* --- VarCheckPolicyLibMmiHandler ----------------------------------- */
+
+#define VAR_CHECK_POLICY_COMMAND_DISABLE     0x01
+#define VAR_CHECK_POLICY_COMMAND_IS_ENABLED  0x02
+#define VAR_CHECK_POLICY_COMMAND_REGISTER    0x03
+#define VAR_CHECK_POLICY_COMMAND_DUMP        0x04
+#define VAR_CHECK_POLICY_COMMAND_LOCK        0x05
+
+typedef struct mm_check_policy mm_check_policy;
+typedef struct mm_check_policy_is_enabled mm_check_policy_is_enabled;
+typedef struct mm_check_policy_dump_params mm_check_policy_dump_params;
+
+/* VAR_CHECK_POLICY_COMM_HEADER */
+struct QEMU_PACKED mm_check_policy {
+    uint32_t  signature;
+    uint32_t  revision;
+    uint32_t  command;
+    uint64_t  result;
+};
+
+/* VAR_CHECK_POLICY_COMM_IS_ENABLED_PARAMS */
+struct QEMU_PACKED mm_check_policy_is_enabled {
+    uint8_t   state;
+};
+
+/* VAR_CHECK_POLICY_COMM_DUMP_PARAMS */
+struct QEMU_PACKED mm_check_policy_dump_params {
+    uint32_t  page_requested;
+    uint32_t  total_size;
+    uint32_t  page_size;
+    uint8_t   has_more;
+};
+
+/* --- Edk2VariablePolicyProtocol ------------------------------------ */
+
+#define VARIABLE_POLICY_ENTRY_REVISION  0x00010000
+
+#define VARIABLE_POLICY_TYPE_NO_LOCK            0
+#define VARIABLE_POLICY_TYPE_LOCK_NOW           1
+#define VARIABLE_POLICY_TYPE_LOCK_ON_CREATE     2
+#define VARIABLE_POLICY_TYPE_LOCK_ON_VAR_STATE  3
+
+typedef struct variable_policy_entry variable_policy_entry;
+typedef struct variable_lock_on_var_state variable_lock_on_var_state;
+
+/* VARIABLE_POLICY_ENTRY */
+struct variable_policy_entry {
+    uint32_t      version;
+    uint16_t      size;
+    uint16_t      offset_to_name;
+    QemuUUID      namespace;
+    uint32_t      min_size;
+    uint32_t      max_size;
+    uint32_t      attributes_must_have;
+    uint32_t      attributes_cant_have;
+    uint8_t       lock_policy_type;
+    uint8_t       padding[3];
+    /* LockPolicy */
+    /* Name */
+};
+
+/* VARIABLE_LOCK_ON_VAR_STATE_POLICY */
+struct variable_lock_on_var_state {
+    QemuUUID      namespace;
+    uint8_t       value;
+    uint8_t       padding;
+    /* Name */
+};
+
+/* --- variable authentication --------------------------------------- */
+
+#define WIN_CERT_TYPE_EFI_GUID  0x0EF1
+
+typedef struct efi_time efi_time;
+typedef struct efi_siglist efi_siglist;
+typedef struct variable_auth_2 variable_auth_2;
+
+/* EFI_TIME */
+struct efi_time {
+    uint16_t  year;
+    uint8_t   month;
+    uint8_t   day;
+    uint8_t   hour;
+    uint8_t   minute;
+    uint8_t   second;
+    uint8_t   pad1;
+    uint32_t  nanosecond;
+    int16_t   timezone;
+    uint8_t   daylight;
+    uint8_t   pad2;
+};
+
+/* EFI_SIGNATURE_LIST */
+struct efi_siglist {
+    QemuUUID  guid_type;
+    uint32_t  siglist_size;
+    uint32_t  header_size;
+    uint32_t  sig_size;
+};
+
+/* EFI_VARIABLE_AUTHENTICATION_2 */
+struct variable_auth_2 {
+    struct efi_time timestamp;
+
+    /* WIN_CERTIFICATE_UEFI_GUID */
+    uint32_t  hdr_length;
+    uint16_t  hdr_revision;
+    uint16_t  hdr_cert_type;
+    QemuUUID  guid_cert_type;
+    uint8_t   cert_data[];
+};
+
+#endif /* QEMU_UEFI_VAR_SERVICE_EDK2_H */
-- 
2.48.1


