Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E8F606A321
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 19:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bt5GGm6Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQUaa-0001Es-D9; Mon, 09 Nov 2026 13:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xQUaT-0001DT-Ft
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 13:59:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xQUaR-0006Dt-5N
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 13:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794250762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/W6/kz7VuD287OKmOjU7aNE//F1vy6wR+oe/2sb3P4=;
 b=Bt5GGm6YRhyY/07GZWh+Ide2NzmiGyG/AY2u1VHdQFCGl6H1ZA6tRgdGmiagELA3M9my7P
 ASGNsed1MR00y2LaWhGBxg0/aSUSZ0qLMoOHHkHfmgLVmYZ0EsA5f6C2xi4DjE1FOkgNYg
 +H74o6UNzQtHyE8yUgpQ56+Owhsco7Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-Uu7lIUJtOUmgZqlUQ2aYAw-1; Mon,
 09 Nov 2026 13:59:18 -0500
X-MC-Unique: Uu7lIUJtOUmgZqlUQ2aYAw-1
X-Mimecast-MFC-AGG-ID: Uu7lIUJtOUmgZqlUQ2aYAw_1794250757
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 043061800660; Mon,  9 Nov 2026 18:59:16 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.81])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 017891956089; Mon,  9 Nov 2026 18:59:12 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Alistair Francis <alistair.francis@wdc.com>, Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, John Snow <jsnow@redhat.com>
Subject: [PATCH 1/7] debug/mem: add utility to name anonymous memory mappings
Date: Mon,  9 Nov 2026 13:59:01 -0500
Message-ID: <20261109185907.3220584-2-jsnow@redhat.com>
In-Reply-To: <20261109185907.3220584-1-jsnow@redhat.com>
References: <20261109185907.3220584-1-jsnow@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support to name mmap'd memory regions using
PR_SET_VMA_ANON_NAME. On supported platforms, the QEMU utility
functions are no-ops.

This is useful primarily for debugging and profiling QEMU; beind able
to see and correlate each VMA segment with a specific use within QEMU.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/qemu/mmap-vma.h | 18 +++++++++++
 util/mmap-vma.c         | 67 +++++++++++++++++++++++++++++++++++++++++
 util/meson.build        |  1 +
 3 files changed, 86 insertions(+)
 create mode 100644 include/qemu/mmap-vma.h
 create mode 100644 util/mmap-vma.c

diff --git a/include/qemu/mmap-vma.h b/include/qemu/mmap-vma.h
new file mode 100644
index 00000000000..763ea5a5cab
--- /dev/null
+++ b/include/qemu/mmap-vma.h
@@ -0,0 +1,18 @@
+/*
+ * Utility for naming VMA allocations in linux
+ *
+ * Copyright (c) Red Hat, Inc 2026
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef __QEMU_MMAP_VMA_H
+#define __QEMU_MMAP_VMA_H
+
+#include <stddef.h>
+#include "osdep.h"
+
+int qemu_name_vma(void *ptr, size_t sz, const char *fmt, ...)
+    G_GNUC_PRINTF(3, 4);
+
+#endif
diff --git a/util/mmap-vma.c b/util/mmap-vma.c
new file mode 100644
index 00000000000..7dcef3b7455
--- /dev/null
+++ b/util/mmap-vma.c
@@ -0,0 +1,67 @@
+/*
+ * Utility for naming VMA allocations in linux
+ *
+ * Copyright (c) Red Hat, Inc 2026
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+#include "qemu/mmap-vma.h"
+#include "qemu/osdep.h"
+
+#include <errno.h>
+#include <stddef.h>
+#include <stdio.h>
+
+#if defined(__linux__)
+#include <sys/prctl.h>
+#endif
+
+#define VMA_PREFIX " qemu: "
+#define VMA_MAXLEN 80
+
+/*
+ * Give a human-readable name to a previously mmap'd memory segment.
+ * This feature is only available on Linux >= 5.17, and only when the
+ * kernel was configured with CONFIG_ANON_VMA_NAME=y.
+ *
+ * For systems without this option, prctl() will return -1 and set
+ * errno to EINVAL, and can be safely ignored.
+ *
+ * For systems with this option, these human-readable names will be
+ * visible in /proc/$pid/[s]maps, pmap output, etc.
+ */
+G_GNUC_PRINTF(3, 0)
+static int qemu_vname_vma(void *ptr, size_t sz, const char *fmt, va_list args)
+{
+    int rc = 0;
+
+#if defined(PR_SET_VMA_ANON_NAME)
+    char strbuf[VMA_MAXLEN];
+
+    assert(sizeof(VMA_PREFIX) < sizeof(strbuf));
+    strncpy(strbuf, VMA_PREFIX, sizeof(strbuf));
+    rc = vsnprintf(strbuf + sizeof(VMA_PREFIX),
+                   sizeof(strbuf) - sizeof(VMA_PREFIX), fmt, args);
+    if (rc < 0) {
+        return -errno;
+    } else if (rc >= (sizeof(strbuf) - sizeof(VMA_PREFIX))) {
+        sprintf(strbuf + sizeof(strbuf) - 4, "...");
+    }
+
+    rc = prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, ptr, sz, strbuf);
+    if (rc) {
+        return -errno;
+    }
+#endif
+
+    return rc;
+}
+
+G_GNUC_PRINTF(3, 4)
+int qemu_name_vma(void *ptr, size_t sz, const char *fmt, ...)
+{
+    va_list args;
+
+    va_start(args, fmt);
+    return qemu_vname_vma(ptr, sz, fmt, args);
+}
diff --git a/util/meson.build b/util/meson.build
index fa174c07a57..861ee228d5b 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -1,5 +1,6 @@
 util_ss.add(files('osdep.c', 'cutils.c', 'unicode.c', 'qemu-timer-common.c'))
 util_ss.add(files('thread-context.c'), numa)
+util_ss.add(files('mmap-vma.c'))
 if host_os != 'windows'
   util_ss.add(files('aio-posix.c'))
   util_ss.add(files('fdmon-poll.c'))
-- 
2.56.0


