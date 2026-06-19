Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09B2CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 18:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wadY3-0000bn-E8; Fri, 19 Jun 2026 14:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <polina.vishneva@virtuozzo.com>)
 id 1wadY0-0000bV-V9
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 14:02:32 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <polina.vishneva@virtuozzo.com>)
 id 1wadXz-0004Ab-7N
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 14:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=DjOyqQnJ6RMF1XS8ej1SAjvRTDMFV0LbW14WnnJ9zz4=; b=TkZS0R/4A7W9
 zAmcGichE1hZL5uof+TzczCsNCc15E9H9d9vef7sSh99nFns0uQOYA0sn8qD0fUQx8eSrSXoY0Pbp
 ck86GxsuUxd0wzDQrK7AxmqsY+3NAmzR1eddoelHiN+XbAIjXxRIoLJYeK98pJ5PqGzIPMjBaVJVU
 VZaIxldl/W1uwN2rthjjX6ChD8nSj1XmsmDFLGKlCPTBrG4WUBgiLKdzmHeFRdS9CzzKm/Yek29Wz
 bn/vB0cnejuAOTN3mvVlhjGQe6yR7QsxuAjMgP0Ty9RIO+YTL8i5LJSP/I5Ssg/y3vmDablyBLbTE
 ZMENYNmyt8HzhI6HL4ZSQQ==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=mami)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <polina.vishneva@virtuozzo.com>) id 1wadXM-001Gyc-2U;
 Fri, 19 Jun 2026 20:02:24 +0200
From: Polina Vishneva <polina.vishneva@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: Polina Vishneva <polina.vishneva@virtuozzo.com>,
 Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Denis V . Lunev" <den@virtuozzo.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH 1/4] include/system: Add vio_sockets.h with AF_VSOCK support
 on Windows
Date: Fri, 19 Jun 2026 20:00:19 +0200
Message-ID: <20260619180121.2982356-2-polina.vishneva@virtuozzo.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619180121.2982356-1-polina.vishneva@virtuozzo.com>
References: <20260619180121.2982356-1-polina.vishneva@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=polina.vishneva@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Vendored from viosock/inc/vio_sockets.h in kvm-guest-drivers-windows
(d76a29c1), reformatted to QEMU coding style (SPDX tag, comment
rewrapping, brace placement, include guard).

The upstream BSD-3-Clause license was retained because no significant
changes were made.

Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
---
 MAINTAINERS                  |  1 +
 include/system/vio_sockets.h | 57 ++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 include/system/vio_sockets.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 93df53d87f..3ff59ec0a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3868,6 +3868,7 @@ Sockets
 M: Daniel P. Berrange <berrange@redhat.com>
 S: Maintained
 F: include/qemu/sockets.h
+F: include/system/vio_sockets.h
 F: util/qemu-sockets.c
 F: qapi/sockets.json
 
diff --git a/include/system/vio_sockets.h b/include/system/vio_sockets.h
new file mode 100644
index 0000000000..480df24d37
--- /dev/null
+++ b/include/system/vio_sockets.h
@@ -0,0 +1,57 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Core definitions for virtio VSOCK address family, based on
+ * linux/vm_sockets.h and kvm-guest-drivers-windows (d76a29c1).
+ *
+ * Copyright (c) 2019 Virtuozzo International GmbH
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met :
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and / or other materials provided with the distribution.
+ * 3. Neither the names of the copyright holders nor the names of their
+ *    contributors may be used to endorse or promote products derived from
+ *    this software without specific prior written permission.
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
+ * PARTICULAR PURPOSE ARE DISCLAIMED.IN NO EVENT SHALL THE COPYRIGHT HOLDERS
+ * OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
+ * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
+ * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
+ * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
+ * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
+ * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#ifndef VIO_SOCKETS_H
+#define VIO_SOCKETS_H
+
+#include <ws2def.h>
+
+#ifndef AF_VSOCK
+#define AF_VSOCK 40
+#endif
+
+#ifndef PF_VSOCK
+#define PF_VSOCK AF_VSOCK
+#endif
+
+/*
+ * Address structure for virtio vsockets. The address family should be set to
+ * AF_VSOCK.  The structure members should all align on their natural
+ * boundaries without resorting to compiler packing directives.
+ */
+typedef struct sockaddr_vm {
+    ADDRESS_FAMILY svm_family; /* Address family: AF_VSOCK */
+    USHORT svm_reserved1;
+    UINT svm_port; /* Port # in host byte order */
+    UINT svm_cid;  /* Address in host byte order */
+} SOCKADDR_VM, *PSOCKADDR_VM;
+
+#endif /* VIO_SOCKETS_H */
-- 
2.54.0


