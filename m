Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADF1C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 12:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpRif-0005j5-A7; Tue, 04 Mar 2025 07:49:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tpRhY-0004ju-Nf
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 07:48:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tpRhW-0006lv-M9
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 07:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741092526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2S0DT0tDH2d3TDCtB2It8VnLXLr3fsOtArZ9huPJxo4=;
 b=EazL9t8D29Lx6nafSzUDgUbyZMrnAKZVK9K0qMGpS6Hy2ugRjJk44hYkUMz/FRmVcEwNlx
 qn3g56YxbuFrWa+sys4/++CdcJ5xyf0LR12Xju0XugJBz0RHu7hz/uW4XGtFY5lRLj86kI
 A3AU5wn9BogiyiqitIc8BwTIFqKbbvA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-eYZtMCKUNrqPeLNdmhWGEQ-1; Tue,
 04 Mar 2025 07:48:31 -0500
X-MC-Unique: eYZtMCKUNrqPeLNdmhWGEQ-1
X-Mimecast-MFC-AGG-ID: eYZtMCKUNrqPeLNdmhWGEQ_1741092509
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CCC881944EB3; Tue,  4 Mar 2025 12:48:29 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.122])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD4971954B00; Tue,  4 Mar 2025 12:48:28 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8A90E18003A0; Tue, 04 Mar 2025 13:48:15 +0100 (CET)
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
Subject: [PULL 06/24] hw/uefi: add var-service-utils.c
Date: Tue,  4 Mar 2025 13:47:54 +0100
Message-ID: <20250304124815.591749-7-kraxel@redhat.com>
In-Reply-To: <20250304124815.591749-1-kraxel@redhat.com>
References: <20250304124815.591749-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Add utility functions.  Helpers for UEFI (ucs2) string handling.
Helpers for readable trace messages.  Compare UEFI time stamps.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20250225163031.1409078-7-kraxel@redhat.com>
---
 hw/uefi/var-service-utils.c | 241 ++++++++++++++++++++++++++++++++++++
 1 file changed, 241 insertions(+)
 create mode 100644 hw/uefi/var-service-utils.c

diff --git a/hw/uefi/var-service-utils.c b/hw/uefi/var-service-utils.c
new file mode 100644
index 000000000000..c9ef46570f48
--- /dev/null
+++ b/hw/uefi/var-service-utils.c
@@ -0,0 +1,241 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * uefi vars device - helper functions for ucs2 strings and tracing
+ */
+#include "qemu/osdep.h"
+#include "system/dma.h"
+
+#include "hw/uefi/var-service.h"
+
+#include "trace/trace-hw_uefi.h"
+
+/* ------------------------------------------------------------------ */
+
+/*
+ * string helper functions.
+ *
+ * Most of the time uefi ucs2 strings are NULL-terminated, except
+ * sometimes when they are not (for example in variable policies).
+ */
+
+gboolean uefi_str_is_valid(const uint16_t *str, size_t len,
+                           gboolean must_be_null_terminated)
+{
+    size_t pos = 0;
+
+    for (;;) {
+        if (pos == len) {
+            if (must_be_null_terminated) {
+                return false;
+            } else {
+                return true;
+            }
+        }
+        switch (str[pos]) {
+        case 0:
+            /* end of string */
+            return true;
+        case 0xd800 ... 0xdfff:
+            /* reject surrogates */
+            return false;
+        default:
+            /* char is good, check next */
+            break;
+        }
+        pos++;
+    }
+}
+
+size_t uefi_strlen(const uint16_t *str, size_t len)
+{
+    size_t pos = 0;
+
+    for (;;) {
+        if (pos == len) {
+            return pos;
+        }
+        if (str[pos] == 0) {
+            return pos;
+        }
+        pos++;
+    }
+}
+
+gboolean uefi_str_equal_ex(const uint16_t *a, size_t alen,
+                           const uint16_t *b, size_t blen,
+                           gboolean wildcards_in_a)
+{
+    size_t pos = 0;
+
+    alen = alen / 2;
+    blen = blen / 2;
+    for (;;) {
+        if (pos == alen && pos == blen) {
+            return true;
+        }
+        if (pos == alen && b[pos] == 0) {
+            return true;
+        }
+        if (pos == blen && a[pos] == 0) {
+            return true;
+        }
+        if (pos == alen || pos == blen) {
+            return false;
+        }
+        if (a[pos] == 0 && b[pos] == 0) {
+            return true;
+        }
+
+        if (wildcards_in_a && a[pos] == '#') {
+            if (!isxdigit(b[pos])) {
+                return false;
+            }
+        } else {
+            if (a[pos] != b[pos]) {
+                return false;
+            }
+        }
+        pos++;
+    }
+}
+
+gboolean uefi_str_equal(const uint16_t *a, size_t alen,
+                        const uint16_t *b, size_t blen)
+{
+    return uefi_str_equal_ex(a, alen, b, blen, false);
+}
+
+char *uefi_ucs2_to_ascii(const uint16_t *ucs2, uint64_t ucs2_size)
+{
+    char *str = g_malloc0(ucs2_size / 2 + 1);
+    int i;
+
+    for (i = 0; i * 2 < ucs2_size; i++) {
+        if (ucs2[i] == 0) {
+            break;
+        }
+        if (ucs2[i] < 128) {
+            str[i] = ucs2[i];
+        } else {
+            str[i] = '?';
+        }
+    }
+    str[i] = 0;
+    return str;
+}
+
+/* ------------------------------------------------------------------ */
+/* time helper functions                                              */
+
+int uefi_time_compare(efi_time *a, efi_time *b)
+{
+    if (a->year < b->year) {
+        return -1;
+    }
+    if (a->year > b->year) {
+        return 1;
+    }
+
+    if (a->month < b->month) {
+        return -1;
+    }
+    if (a->month > b->month) {
+        return 1;
+    }
+
+    if (a->day < b->day) {
+        return -1;
+    }
+    if (a->day > b->day) {
+        return 1;
+    }
+
+    if (a->hour < b->hour) {
+        return -1;
+    }
+    if (a->hour > b->hour) {
+        return 1;
+    }
+
+    if (a->minute < b->minute) {
+        return -1;
+    }
+    if (a->minute > b->minute) {
+        return 1;
+    }
+
+    if (a->second < b->second) {
+        return -1;
+    }
+    if (a->second > b->second) {
+        return 1;
+    }
+
+    if (a->nanosecond < b->nanosecond) {
+        return -1;
+    }
+    if (a->nanosecond > b->nanosecond) {
+        return 1;
+    }
+
+    return 0;
+}
+
+/* ------------------------------------------------------------------ */
+/* tracing helper functions                                           */
+
+void uefi_trace_variable(const char *action, QemuUUID guid,
+                         const uint16_t *name, uint64_t name_size)
+{
+    QemuUUID be = qemu_uuid_bswap(guid);
+    char *str_uuid = qemu_uuid_unparse_strdup(&be);
+    char *str_name = uefi_ucs2_to_ascii(name, name_size);
+
+    trace_uefi_variable(action, str_name, name_size, str_uuid);
+
+    g_free(str_name);
+    g_free(str_uuid);
+}
+
+void uefi_trace_status(const char *action, efi_status status)
+{
+    switch (status) {
+    case EFI_SUCCESS:
+        trace_uefi_status(action, "success");
+        break;
+    case EFI_INVALID_PARAMETER:
+        trace_uefi_status(action, "invalid parameter");
+        break;
+    case EFI_UNSUPPORTED:
+        trace_uefi_status(action, "unsupported");
+        break;
+    case EFI_BAD_BUFFER_SIZE:
+        trace_uefi_status(action, "bad buffer size");
+        break;
+    case EFI_BUFFER_TOO_SMALL:
+        trace_uefi_status(action, "buffer too small");
+        break;
+    case EFI_WRITE_PROTECTED:
+        trace_uefi_status(action, "write protected");
+        break;
+    case EFI_OUT_OF_RESOURCES:
+        trace_uefi_status(action, "out of resources");
+        break;
+    case EFI_NOT_FOUND:
+        trace_uefi_status(action, "not found");
+        break;
+    case EFI_ACCESS_DENIED:
+        trace_uefi_status(action, "access denied");
+        break;
+    case EFI_ALREADY_STARTED:
+        trace_uefi_status(action, "already started");
+        break;
+    case EFI_SECURITY_VIOLATION:
+        trace_uefi_status(action, "security violation");
+        break;
+    default:
+        trace_uefi_status(action, "unknown error");
+        break;
+    }
+}
-- 
2.48.1


