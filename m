Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A1BC021BB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 16:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmxq8-0001AL-V1; Tue, 25 Feb 2025 11:31:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tmxps-00012J-Li
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 11:31:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tmxpp-0006Z6-WF
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 11:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740501065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n92pvF6nCL5CjkeU6AZsN7p4gpUk1K+VSSkUzXeRW6g=;
 b=EksYga8CY0aZgii28O7NuF9W+Cg7iZh7n/+Jz/F2SH6uADstbXJN4E/MgALF018PZePdK4
 Loxe395IBchMsq5fKG2TSyW1j6dIQtltfKNTCpeu1HSKuX/JXgjKaZDtWrqI/3vwj/TLP2
 TbMYqOuYxDafF00UHGervlcP4AOVZLU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-AlpWaztNPUePC4geEoCfiA-1; Tue,
 25 Feb 2025 11:31:00 -0500
X-MC-Unique: AlpWaztNPUePC4geEoCfiA-1
X-Mimecast-MFC-AGG-ID: AlpWaztNPUePC4geEoCfiA_1740501059
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 045B019560B9; Tue, 25 Feb 2025 16:30:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.219])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 978C81800357; Tue, 25 Feb 2025 16:30:57 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 5F4E01800786; Tue, 25 Feb 2025 17:30:32 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Ard Biesheuvel <ardb@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, graf@amazon.com,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 13/24] hw/uefi: add var-service-siglist.c
Date: Tue, 25 Feb 2025 17:30:17 +0100
Message-ID: <20250225163031.1409078-14-kraxel@redhat.com>
In-Reply-To: <20250225163031.1409078-1-kraxel@redhat.com>
References: <20250225163031.1409078-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Functions to serialize and de-serialize EFI signature databases.  This
is needed to merge signature databases (happens in practice when
appending dbx updates) and also to extract the certificates for
pkcs7 signature verification.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-siglist.c | 212 ++++++++++++++++++++++++++++++++++
 1 file changed, 212 insertions(+)
 create mode 100644 hw/uefi/var-service-siglist.c

diff --git a/hw/uefi/var-service-siglist.c b/hw/uefi/var-service-siglist.c
new file mode 100644
index 000000000000..8948f1b78471
--- /dev/null
+++ b/hw/uefi/var-service-siglist.c
@@ -0,0 +1,212 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * uefi vars device - parse and generate efi signature databases
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "system/dma.h"
+
+#include "hw/uefi/var-service.h"
+
+/*
+ * Add x509 certificate to list (with duplicate check).
+ */
+static void uefi_vars_siglist_add_x509(uefi_vars_siglist *siglist,
+                                       QemuUUID *owner,
+                                       void *data, uint64_t size)
+{
+    uefi_vars_cert *c;
+
+    QTAILQ_FOREACH(c, &siglist->x509, next) {
+        if (c->size != size) {
+            continue;
+        }
+        if (memcmp(c->data, data, size) != 0) {
+            continue;
+        }
+        return;
+    }
+
+    c = g_malloc(sizeof(*c) + size);
+    c->owner = *owner;
+    c->size = size;
+    memcpy(c->data, data, size);
+    QTAILQ_INSERT_TAIL(&siglist->x509, c, next);
+}
+
+/*
+ * Add sha256 hash to list (with duplicate check).
+ */
+static void uefi_vars_siglist_add_sha256(uefi_vars_siglist *siglist,
+                                         QemuUUID *owner,
+                                         void *data)
+{
+    uefi_vars_hash *h;
+
+    QTAILQ_FOREACH(h, &siglist->sha256, next) {
+        if (memcmp(h->data, data, 32) != 0) {
+            continue;
+        }
+        return;
+    }
+
+    h = g_malloc(sizeof(*h) + 32);
+    h->owner = *owner;
+    memcpy(h->data, data, 32);
+    QTAILQ_INSERT_TAIL(&siglist->sha256, h, next);
+}
+
+void uefi_vars_siglist_init(uefi_vars_siglist *siglist)
+{
+    memset(siglist, 0, sizeof(*siglist));
+    QTAILQ_INIT(&siglist->x509);
+    QTAILQ_INIT(&siglist->sha256);
+}
+
+void uefi_vars_siglist_free(uefi_vars_siglist *siglist)
+{
+    uefi_vars_cert *c, *cs;
+    uefi_vars_hash *h, *hs;
+
+    QTAILQ_FOREACH_SAFE(c, &siglist->x509, next, cs) {
+        QTAILQ_REMOVE(&siglist->x509, c, next);
+        g_free(c);
+    }
+    QTAILQ_FOREACH_SAFE(h, &siglist->sha256, next, hs) {
+        QTAILQ_REMOVE(&siglist->sha256, h, next);
+        g_free(h);
+    }
+}
+
+/*
+ * Parse UEFI signature list.
+ */
+void uefi_vars_siglist_parse(uefi_vars_siglist *siglist,
+                             void *data, uint64_t size)
+{
+    efi_siglist *efilist;
+    uint64_t start;
+
+    while (size) {
+        if (size < sizeof(*efilist)) {
+            break;
+        }
+        efilist = data;
+        if (size < efilist->siglist_size) {
+            break;
+        }
+
+        if (uadd64_overflow(sizeof(*efilist), efilist->header_size, &start)) {
+            break;
+        }
+        if (efilist->sig_size <= sizeof(QemuUUID)) {
+            break;
+        }
+
+        if (qemu_uuid_is_equal(&efilist->guid_type, &EfiCertX509Guid)) {
+            if (start + efilist->sig_size != efilist->siglist_size) {
+                break;
+            }
+            uefi_vars_siglist_add_x509(siglist,
+                                       (QemuUUID *)(data + start),
+                                       data + start + sizeof(QemuUUID),
+                                       efilist->sig_size - sizeof(QemuUUID));
+
+        } else if (qemu_uuid_is_equal(&efilist->guid_type, &EfiCertSha256Guid)) {
+            if (efilist->sig_size != sizeof(QemuUUID) + 32) {
+                break;
+            }
+            if (start + efilist->sig_size > efilist->siglist_size) {
+                break;
+            }
+            while (start <= efilist->siglist_size - efilist->sig_size) {
+                uefi_vars_siglist_add_sha256(siglist,
+                                             (QemuUUID *)(data + start),
+                                             data + start + sizeof(QemuUUID));
+                start += efilist->sig_size;
+            }
+
+        } else {
+            QemuUUID be = qemu_uuid_bswap(efilist->guid_type);
+            char *str_uuid = qemu_uuid_unparse_strdup(&be);
+            warn_report("%s: unknown type (%s)", __func__, str_uuid);
+            g_free(str_uuid);
+        }
+
+        data += efilist->siglist_size;
+        size -= efilist->siglist_size;
+    }
+}
+
+uint64_t uefi_vars_siglist_blob_size(uefi_vars_siglist *siglist)
+{
+    uefi_vars_cert *c;
+    uefi_vars_hash *h;
+    uint64_t size = 0;
+
+    QTAILQ_FOREACH(c, &siglist->x509, next) {
+        size += sizeof(efi_siglist) + sizeof(QemuUUID) + c->size;
+    }
+
+    if (!QTAILQ_EMPTY(&siglist->sha256)) {
+        size += sizeof(efi_siglist);
+        QTAILQ_FOREACH(h, &siglist->sha256, next) {
+            size += sizeof(QemuUUID) + 32;
+        }
+    }
+
+    return size;
+}
+
+/*
+ * Generate UEFI signature list.
+ */
+void uefi_vars_siglist_blob_generate(uefi_vars_siglist *siglist,
+                                     void *data, uint64_t size)
+{
+    uefi_vars_cert *c;
+    uefi_vars_hash *h;
+    efi_siglist *efilist;
+    uint64_t pos = 0, start;
+    uint32_t i;
+
+    QTAILQ_FOREACH(c, &siglist->x509, next) {
+        efilist = data + pos;
+        efilist->guid_type = EfiCertX509Guid;
+        efilist->sig_size = sizeof(QemuUUID) + c->size;
+        efilist->header_size = 0;
+
+        start = pos + sizeof(efi_siglist);
+        memcpy(data + start,
+               &c->owner, sizeof(QemuUUID));
+        memcpy(data + start + sizeof(QemuUUID),
+               c->data, c->size);
+
+        efilist->siglist_size = sizeof(efi_siglist) + efilist->sig_size;
+        pos += efilist->siglist_size;
+    }
+
+    if (!QTAILQ_EMPTY(&siglist->sha256)) {
+        efilist = data + pos;
+        efilist->guid_type = EfiCertSha256Guid;
+        efilist->sig_size = sizeof(QemuUUID) + 32;
+        efilist->header_size = 0;
+
+        i = 0;
+        start = pos + sizeof(efi_siglist);
+        QTAILQ_FOREACH(h, &siglist->sha256, next) {
+            memcpy(data + start + efilist->sig_size * i,
+                   &h->owner, sizeof(QemuUUID));
+            memcpy(data + start + efilist->sig_size * i + sizeof(QemuUUID),
+                   h->data, 32);
+            i++;
+        }
+
+        efilist->siglist_size = sizeof(efi_siglist) + efilist->sig_size * i;
+        pos += efilist->siglist_size;
+    }
+
+    assert(pos == size);
+}
-- 
2.48.1


