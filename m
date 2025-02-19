Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E698C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 07:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkeJd-0003oQ-Vt; Wed, 19 Feb 2025 02:16:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tkeIR-0002KK-Gv
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 02:15:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tkeIM-00052p-EG
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 02:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739949297;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hgQBER1MJ2liAJuH4wPTGa8SyH6MCQm9SD6Ph8MTQ5Y=;
 b=QAMxgDaX7oragcFR1SQ/nUUiGAM8Y1HR6UqzA+niHS1+MKoUx0ahZCuTYL2oPH6Nsds3uW
 9qyKUs9cA+HG/DvEcTGIl4G7qfZz2saOK2AzMtmX6WUTr/43xjKBsrOy7boRU2wFO2SjOD
 gvy0i1fCZrpgfgtQRIoCfSJ750S9m2Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-cgCVKbGaMMOOiHB-B1QM-g-1; Wed,
 19 Feb 2025 02:14:52 -0500
X-MC-Unique: cgCVKbGaMMOOiHB-B1QM-g-1
X-Mimecast-MFC-AGG-ID: cgCVKbGaMMOOiHB-B1QM-g_1739949291
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D70F1800877; Wed, 19 Feb 2025 07:14:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.78])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A43E6300019F; Wed, 19 Feb 2025 07:14:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 753471801A93; Wed, 19 Feb 2025 08:14:32 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Ard Biesheuvel <ardb@kernel.org>,
 Michael Roth <michael.roth@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 graf@amazon.com, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v4 08/24] hw/uefi: add var-service-auth.c
Date: Wed, 19 Feb 2025 08:14:10 +0100
Message-ID: <20250219071431.50626-9-kraxel@redhat.com>
In-Reply-To: <20250219071431.50626-1-kraxel@redhat.com>
References: <20250219071431.50626-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This implements authenticated variable handling (see AuthVariableLib in
edk2).

The by far most common use case for auth variables is secure boot.  The
secure boot certificate databases ('PK', 'KEK', 'db' and 'dbx') are
authenticated variables, with update rules being specified in the UEFI
specification.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-auth.c | 361 +++++++++++++++++++++++++++++++++++++
 1 file changed, 361 insertions(+)
 create mode 100644 hw/uefi/var-service-auth.c

diff --git a/hw/uefi/var-service-auth.c b/hw/uefi/var-service-auth.c
new file mode 100644
index 000000000000..fba5a0956a57
--- /dev/null
+++ b/hw/uefi/var-service-auth.c
@@ -0,0 +1,361 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * uefi vars device - AuthVariableLib
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "system/dma.h"
+
+#include "hw/uefi/var-service.h"
+
+static const uint16_t name_pk[]           = u"PK";
+static const uint16_t name_kek[]          = u"KEK";
+static const uint16_t name_db[]           = u"db";
+static const uint16_t name_dbx[]          = u"dbx";
+static const uint16_t name_setup_mode[]   = u"SetupMode";
+static const uint16_t name_sigs_support[] = u"SignatureSupport";
+static const uint16_t name_sb[]           = u"SecureBoot";
+static const uint16_t name_sb_enable[]    = u"SecureBootEnable";
+static const uint16_t name_custom_mode[]  = u"CustomMode";
+static const uint16_t name_vk[]           = u"VendorKeys";
+static const uint16_t name_vk_nv[]        = u"VendorKeysNv";
+
+static const uint32_t sigdb_attrs =
+    EFI_VARIABLE_NON_VOLATILE |
+    EFI_VARIABLE_BOOTSERVICE_ACCESS |
+    EFI_VARIABLE_RUNTIME_ACCESS |
+    EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS;
+
+static void set_secure_boot(uefi_vars_state *uv, uint8_t sb)
+{
+    uefi_vars_set_variable(uv, EfiGlobalVariable,
+                           name_sb, sizeof(name_sb),
+                           EFI_VARIABLE_BOOTSERVICE_ACCESS |
+                           EFI_VARIABLE_RUNTIME_ACCESS,
+                           &sb, sizeof(sb));
+}
+
+static void set_secure_boot_enable(uefi_vars_state *uv, uint8_t sbe)
+{
+    uefi_vars_set_variable(uv, EfiSecureBootEnableDisable,
+                           name_sb_enable, sizeof(name_sb_enable),
+                           EFI_VARIABLE_NON_VOLATILE |
+                           EFI_VARIABLE_BOOTSERVICE_ACCESS,
+                           &sbe, sizeof(sbe));
+}
+
+static void set_setup_mode(uefi_vars_state *uv, uint8_t sm)
+{
+    uefi_vars_set_variable(uv, EfiGlobalVariable,
+                           name_setup_mode, sizeof(name_setup_mode),
+                           EFI_VARIABLE_BOOTSERVICE_ACCESS |
+                           EFI_VARIABLE_RUNTIME_ACCESS,
+                           &sm, sizeof(sm));
+}
+
+static void set_custom_mode(uefi_vars_state *uv, uint8_t cm)
+{
+    uefi_vars_set_variable(uv, EfiCustomModeEnable,
+                           name_custom_mode, sizeof(name_custom_mode),
+                           EFI_VARIABLE_NON_VOLATILE |
+                           EFI_VARIABLE_BOOTSERVICE_ACCESS,
+                           &cm, sizeof(cm));
+}
+
+static void set_signature_support(uefi_vars_state *uv)
+{
+    QemuUUID sigs_support[5];
+
+    sigs_support[0] = EfiCertSha256Guid;
+    sigs_support[1] = EfiCertSha384Guid;
+    sigs_support[2] = EfiCertSha512Guid;
+    sigs_support[3] = EfiCertRsa2048Guid;
+    sigs_support[4] = EfiCertX509Guid;
+
+    uefi_vars_set_variable(uv, EfiGlobalVariable,
+                           name_sigs_support, sizeof(name_sigs_support),
+                           EFI_VARIABLE_BOOTSERVICE_ACCESS |
+                           EFI_VARIABLE_RUNTIME_ACCESS,
+                           sigs_support, sizeof(sigs_support));
+}
+
+static bool setup_mode_is_active(uefi_vars_state *uv)
+{
+    uefi_variable *var;
+    uint8_t *value;
+
+    var = uefi_vars_find_variable(uv, EfiGlobalVariable,
+                                  name_setup_mode, sizeof(name_setup_mode));
+    if (var) {
+        value = var->data;
+        if (value[0] == SETUP_MODE) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static bool custom_mode_is_active(uefi_vars_state *uv)
+{
+    uefi_variable *var;
+    uint8_t *value;
+
+    var = uefi_vars_find_variable(uv, EfiCustomModeEnable,
+                                  name_custom_mode, sizeof(name_custom_mode));
+    if (var) {
+        value = var->data;
+        if (value[0] == CUSTOM_SECURE_BOOT_MODE) {
+            return true;
+        }
+    }
+    return false;
+}
+
+bool uefi_vars_is_sb_pk(uefi_variable *var)
+{
+    if (qemu_uuid_is_equal(&var->guid, &EfiGlobalVariable) &&
+        uefi_str_equal(var->name, var->name_size, name_pk, sizeof(name_pk))) {
+        return true;
+    }
+    return false;
+}
+
+static bool uefi_vars_is_sb_kek(uefi_variable *var)
+{
+    if (qemu_uuid_is_equal(&var->guid, &EfiGlobalVariable) &&
+        uefi_str_equal(var->name, var->name_size, name_kek, sizeof(name_kek))) {
+        return true;
+    }
+    return false;
+}
+
+static bool uefi_vars_is_sb_db(uefi_variable *var)
+{
+    if (!qemu_uuid_is_equal(&var->guid, &EfiImageSecurityDatabase)) {
+        return false;
+    }
+    if (uefi_str_equal(var->name, var->name_size, name_db, sizeof(name_db))) {
+        return true;
+    }
+    if (uefi_str_equal(var->name, var->name_size, name_dbx, sizeof(name_dbx))) {
+        return true;
+    }
+    return false;
+}
+
+bool uefi_vars_is_sb_any(uefi_variable *var)
+{
+    if (uefi_vars_is_sb_pk(var) ||
+        uefi_vars_is_sb_kek(var) ||
+        uefi_vars_is_sb_db(var)) {
+        return true;
+    }
+    return false;
+}
+
+static uefi_variable *uefi_vars_find_siglist(uefi_vars_state *uv,
+                                             uefi_variable *var)
+{
+    if (uefi_vars_is_sb_pk(var)) {
+        return uefi_vars_find_variable(uv, EfiGlobalVariable,
+                                       name_pk, sizeof(name_pk));
+    }
+    if (uefi_vars_is_sb_kek(var)) {
+        return uefi_vars_find_variable(uv, EfiGlobalVariable,
+                                       name_pk, sizeof(name_pk));
+    }
+    if (uefi_vars_is_sb_db(var)) {
+        return uefi_vars_find_variable(uv, EfiGlobalVariable,
+                                       name_kek, sizeof(name_kek));
+    }
+
+    return NULL;
+}
+
+static efi_status uefi_vars_check_auth_2_sb(uefi_vars_state *uv,
+                                            uefi_variable *var,
+                                            mm_variable_access *va,
+                                            void *data,
+                                            uint64_t data_offset)
+{
+    variable_auth_2 *auth = data;
+    uefi_variable *siglist;
+
+    if (custom_mode_is_active(uv)) {
+        /* no authentication in custom mode */
+        return EFI_SUCCESS;
+    }
+
+    if (setup_mode_is_active(uv) && !uefi_vars_is_sb_pk(var)) {
+        /* no authentication in setup mode (except PK) */
+        return EFI_SUCCESS;
+    }
+
+    if (auth->hdr_length == 24) {
+        /* no signature (auth->cert_data is empty) */
+        return EFI_SECURITY_VIOLATION;
+    }
+
+    siglist = uefi_vars_find_siglist(uv, var);
+    if (!siglist && setup_mode_is_active(uv) && uefi_vars_is_sb_pk(var)) {
+        /* check PK is self-signed */
+        uefi_variable tmp = {
+            .guid       = EfiGlobalVariable,
+            .name       = (uint16_t *)name_pk,
+            .name_size  = sizeof(name_pk),
+            .attributes = sigdb_attrs,
+            .data       = data + data_offset,
+            .data_size  = va->data_size - data_offset,
+        };
+        return uefi_vars_check_pkcs7_2(&tmp, NULL, NULL, va, data);
+    }
+
+    return uefi_vars_check_pkcs7_2(siglist, NULL, NULL, va, data);
+}
+
+efi_status uefi_vars_check_auth_2(uefi_vars_state *uv, uefi_variable *var,
+                                  mm_variable_access *va, void *data)
+{
+    variable_auth_2 *auth = data;
+    uint64_t data_offset;
+    efi_status status;
+
+    if (va->data_size < sizeof(*auth)) {
+        return EFI_SECURITY_VIOLATION;
+    }
+    if (uadd64_overflow(sizeof(efi_time), auth->hdr_length, &data_offset)) {
+        return EFI_SECURITY_VIOLATION;
+    }
+    if (va->data_size < data_offset) {
+        return EFI_SECURITY_VIOLATION;
+    }
+
+    if (auth->hdr_revision != 0x0200 ||
+        auth->hdr_cert_type != WIN_CERT_TYPE_EFI_GUID ||
+        !qemu_uuid_is_equal(&auth->guid_cert_type, &EfiCertTypePkcs7Guid)) {
+        return EFI_UNSUPPORTED;
+    }
+
+    if (uefi_vars_is_sb_any(var)) {
+        /* secure boot variables */
+        status = uefi_vars_check_auth_2_sb(uv, var, va, data, data_offset);
+        if (status != EFI_SUCCESS) {
+            return status;
+        }
+    } else {
+        /* other authenticated variables */
+        status = uefi_vars_check_pkcs7_2(NULL,
+                                         &var->digest, &var->digest_size,
+                                         va, data);
+        if (status != EFI_SUCCESS) {
+            return status;
+        }
+    }
+
+    /* checks passed, set variable data */
+    var->time = auth->timestamp;
+    if (va->data_size - data_offset > 0) {
+        var->data = g_malloc(va->data_size - data_offset);
+        memcpy(var->data, data + data_offset, va->data_size - data_offset);
+        var->data_size = va->data_size - data_offset;
+    }
+
+    return EFI_SUCCESS;
+}
+
+efi_status uefi_vars_check_secure_boot(uefi_vars_state *uv, uefi_variable *var)
+{
+    uint8_t *value = var->data;
+
+    if (uefi_vars_is_sb_any(var)) {
+        if (var->attributes != sigdb_attrs) {
+            return EFI_INVALID_PARAMETER;
+        }
+    }
+
+    /* reject SecureBootEnable updates if force_secure_boot is set */
+    if (qemu_uuid_is_equal(&var->guid, &EfiSecureBootEnableDisable) &&
+        uefi_str_equal(var->name, var->name_size,
+                       name_sb_enable, sizeof(name_sb_enable)) &&
+        uv->force_secure_boot &&
+        value[0] != SECURE_BOOT_ENABLE) {
+        return EFI_WRITE_PROTECTED;
+    }
+
+    /* reject CustomMode updates if disable_custom_mode is set */
+    if (qemu_uuid_is_equal(&var->guid, &EfiCustomModeEnable) &&
+        uefi_str_equal(var->name, var->name_size,
+                       name_custom_mode, sizeof(name_custom_mode)) &&
+        uv->disable_custom_mode) {
+        return EFI_WRITE_PROTECTED;
+    }
+
+    return EFI_SUCCESS;
+}
+
+/* AuthVariableLibInitialize */
+void uefi_vars_auth_init(uefi_vars_state *uv)
+{
+    uefi_variable *pk_var, *sbe_var;
+    uint8_t platform_mode, sb, sbe, vk;
+
+    /* SetupMode */
+    pk_var = uefi_vars_find_variable(uv, EfiGlobalVariable,
+                                     name_pk, sizeof(name_pk));
+    if (!pk_var) {
+        platform_mode = SETUP_MODE;
+    } else {
+        platform_mode = USER_MODE;
+    }
+    set_setup_mode(uv, platform_mode);
+
+    /* SignatureSupport */
+    set_signature_support(uv);
+
+    /* SecureBootEnable */
+    sbe = SECURE_BOOT_DISABLE;
+    sbe_var = uefi_vars_find_variable(uv, EfiSecureBootEnableDisable,
+                                      name_sb_enable, sizeof(name_sb_enable));
+    if (sbe_var) {
+        if (platform_mode == USER_MODE) {
+            sbe = ((uint8_t *)sbe_var->data)[0];
+        }
+    } else if (platform_mode == USER_MODE) {
+        sbe = SECURE_BOOT_ENABLE;
+        set_secure_boot_enable(uv, sbe);
+    }
+
+    if (uv->force_secure_boot && sbe != SECURE_BOOT_ENABLE) {
+        sbe = SECURE_BOOT_ENABLE;
+        set_secure_boot_enable(uv, sbe);
+    }
+
+    /* SecureBoot */
+    if ((sbe == SECURE_BOOT_ENABLE) && (platform_mode == USER_MODE)) {
+        sb = SECURE_BOOT_MODE_ENABLE;
+    } else {
+        sb = SECURE_BOOT_MODE_DISABLE;
+    }
+    set_secure_boot(uv, sb);
+
+    /* CustomMode */
+    set_custom_mode(uv, STANDARD_SECURE_BOOT_MODE);
+
+    vk = 0;
+    uefi_vars_set_variable(uv, EfiGlobalVariable,
+                           name_vk_nv, sizeof(name_vk_nv),
+                           EFI_VARIABLE_NON_VOLATILE |
+                           EFI_VARIABLE_BOOTSERVICE_ACCESS |
+                           EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS,
+                           &vk, sizeof(vk));
+    uefi_vars_set_variable(uv, EfiGlobalVariable,
+                           name_vk, sizeof(name_vk),
+                           EFI_VARIABLE_BOOTSERVICE_ACCESS |
+                           EFI_VARIABLE_RUNTIME_ACCESS,
+                           &vk, sizeof(vk));
+
+    /* flush to disk */
+    uefi_vars_json_save(uv);
+}
-- 
2.48.1


