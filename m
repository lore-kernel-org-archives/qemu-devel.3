Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60385CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 09:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1iZH-00020p-L0; Thu, 25 Sep 2025 05:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iZ8-0001qP-Tb
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:47:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v1iYm-0001ml-Iy
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758793599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mZJoRmH0LzYy4u3t3prpzh/NicjETYCxcryAx0u5eAw=;
 b=fbvq1dSW0zDRfElrJssLdpOCT+aghPRdaHFnYQm04FIw/BFTB3IRcbVV4tOC/NtIvn7EtG
 0fS0j1hgQgbK2peHM0L8tU5hwmDZlWiawVnk6YL3nrmGJ6JUWzFXqov8cSVU5yDK5ZPChr
 hhtyV42pLuYd6io8BpDmAtlGVfJBMPw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-orMQIbdsMvqdmttta_mbwg-1; Thu,
 25 Sep 2025 05:46:36 -0400
X-MC-Unique: orMQIbdsMvqdmttta_mbwg-1
X-Mimecast-MFC-AGG-ID: orMQIbdsMvqdmttta_mbwg_1758793594
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93B991956053; Thu, 25 Sep 2025 09:46:34 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.163])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 10F3B300021A; Thu, 25 Sep 2025 09:46:28 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-rust@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, devel@lists.libvirt.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 18/23] util: introduce common helper for error-report & log
 code
Date: Thu, 25 Sep 2025 10:44:36 +0100
Message-ID: <20250925094441.1651372-19-berrange@redhat.com>
In-Reply-To: <20250925094441.1651372-1-berrange@redhat.com>
References: <20250925094441.1651372-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The error-report and log code both have a need to add prefixes
to messages they are printing, with the current example being
a timestamp.

The format and configuration they use should be consistent, so
providing a common helper will ensure this is always the case.
Initially the helper only emits a timestamp, but future patches
will expand this.

This takes the liberty of assigning the new file to the same
maintainer as the existing error-report.c file, given it will
be extracting some functionality from the latter.

While vreport() dynamically changes between reporting to the
monitor vs stderr, depending on whether HMP is active or not,
message prefixes are only ever used in the non-HMP case. Thus
the helper API can take a FILE * object and not have to deal
with the monitor at all.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 MAINTAINERS            |  2 ++
 include/qemu/message.h | 28 ++++++++++++++++++++++++++++
 util/meson.build       |  1 +
 util/message.c         | 22 ++++++++++++++++++++++
 4 files changed, 53 insertions(+)
 create mode 100644 include/qemu/message.h
 create mode 100644 util/message.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 24b71a4fc5..e128a9d3be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3173,9 +3173,11 @@ M: Markus Armbruster <armbru@redhat.com>
 S: Supported
 F: include/qapi/error.h
 F: include/qemu/error-report.h
+F: include/qemu/message.h
 F: qapi/error.json
 F: util/error.c
 F: util/error-report.c
+F: util/message.c
 F: scripts/coccinelle/err-bad-newline.cocci
 F: scripts/coccinelle/error-use-after-free.cocci
 F: scripts/coccinelle/error_propagate_null.cocci
diff --git a/include/qemu/message.h b/include/qemu/message.h
new file mode 100644
index 0000000000..0a06421f77
--- /dev/null
+++ b/include/qemu/message.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef QEMU_MESSAGE_H
+#define QEMU_MESSAGE_H
+
+enum QMessageFormatFlags {
+    QMESSAGE_FORMAT_TIMESTAMP = (1 << 0),
+};
+
+/**
+ * qmessage_set_format:
+ * @flags: the message information to emit
+ *
+ * Select which pieces of information to
+ * emit for messages
+ */
+void qmessage_set_format(int flags);
+
+/**
+ * qmessage_context_print:
+ * @fp: file to emit the prefix on
+ *
+ * Emit a message prefix with the information selected by
+ * an earlier call to qmessage_set_format.
+ */
+void qmessage_context_print(FILE *fp);
+
+#endif /* QEMU_MESSAGE_H */
diff --git a/util/meson.build b/util/meson.build
index 35029380a3..f5365e3b4f 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -40,6 +40,7 @@ util_ss.add(files('host-utils.c'))
 util_ss.add(files('bitmap.c', 'bitops.c'))
 util_ss.add(files('fifo8.c'))
 util_ss.add(files('cacheflush.c'))
+util_ss.add(files('message.c'))
 util_ss.add(files('error.c', 'error-report.c'))
 util_ss.add(files('qemu-print.c'))
 util_ss.add(files('id.c'))
diff --git a/util/message.c b/util/message.c
new file mode 100644
index 0000000000..643f10c06a
--- /dev/null
+++ b/util/message.c
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+
+#include "qemu/message.h"
+#include "monitor/monitor.h"
+
+static int message_format;
+
+void qmessage_set_format(int flags)
+{
+    message_format = flags;
+}
+
+void qmessage_context_print(FILE *fp)
+{
+    if (message_format & QMESSAGE_FORMAT_TIMESTAMP) {
+        g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
+        g_autofree char *timestr = g_date_time_format_iso8601(dt);
+        fprintf(fp, "%s ", timestr);
+    }
+}
-- 
2.50.1


