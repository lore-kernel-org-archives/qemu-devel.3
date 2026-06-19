Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFD1CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 18:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wadY5-0000d6-QO; Fri, 19 Jun 2026 14:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <polina.vishneva@virtuozzo.com>)
 id 1wadY4-0000cs-5W
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 14:02:36 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <polina.vishneva@virtuozzo.com>)
 id 1wadY2-0004CS-Ig
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 14:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=yDx6HBQomJat4/Na+8CFSdYFcmmpQNnt9dYbWb4Wd/8=; b=TCAkmDfP0HCL
 Q6CT+dVmzua7F3cK33sKLvao0fEtkoGN3dpdxBu6GryS4FhLmzwtbq14CZEXhVQnlA8DlchyM3JcS
 aEkfZs59cUVQr/pgDItiKW85OUVatRXl5pSbQawzmif/PHU6mnQORfVz9QKqSgrnQ+WXBtswcAm/6
 PanBZgHuGXLBi2fSBXzgmAMq7aWrFm4m3j1fvUXuEcursb5fd+Q0fXznU2NGBaO2IBqCYwK6HvdjL
 kgu/lIutosqKv+bb0kb0GrV5XrTwQPSRKRRRemRCKxi7sQVUrI4fHmXXsHJ9bqkqmDoh7/EPenR4v
 k/UC/97/sDIaf4reP7SkHQ==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=mami)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <polina.vishneva@virtuozzo.com>) id 1wadXR-001Gyc-1R;
 Fri, 19 Jun 2026 20:02:29 +0200
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
Subject: [PATCH 2/4] util/qemu-sockets: Enable AF_VSOCK on Windows
Date: Fri, 19 Jun 2026 20:00:20 +0200
Message-ID: <20260619180121.2982356-3-polina.vishneva@virtuozzo.com>
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

Include the vendored vio_sockets.h on Windows, and set CONFIG_AF_VSOCK
unconditionally since the header is always present in-tree.

socket_parse("vsock:...") and the SOCKET_ADDRESS_TYPE_VSOCK dispatch
in socket_connect()/socket_listen() now resolve to the real
vsock_*_saddr() helpers on Windows instead of the vsock_unsupported()
stub.

Note that CONFIG_AF_VSOCK is a tree-wide switch: this enables the
vsock code paths for every Windows build, not just the guest agent.
QMP now accepts vsock socket addresses on Windows; without a viosock
provider installed they fail at runtime rather than being rejected
up front as unsupported.

Signed-off-by: Polina Vishneva <polina.vishneva@virtuozzo.com>
---
 meson.build         | 15 +++++++++++----
 util/qemu-sockets.c |  4 ++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index e026851309..34268f0348 100644
--- a/meson.build
+++ b/meson.build
@@ -3136,10 +3136,17 @@ have_afalg = get_option('crypto_afalg') \
   '''), error_message: 'AF_ALG requested but could not be detected').allowed()
 config_host_data.set('CONFIG_AF_ALG', have_afalg)
 
-config_host_data.set('CONFIG_AF_VSOCK', cc.has_header_symbol(
-  'linux/vm_sockets.h', 'AF_VSOCK',
-  prefix: '#include <sys/socket.h>',
-))
+if host_os != 'windows'
+  config_host_data.set('CONFIG_AF_VSOCK', cc.has_header_symbol(
+    'linux/vm_sockets.h', 'AF_VSOCK',
+    prefix: '#include <sys/socket.h>',
+  ))
+else
+  # The vendored vio_sockets.h is always available.
+  # This guarantees compile-time availability only; at run-time, it's
+  # generally useless if viosock isn't installed (no AF_VSOCK WSP).
+  config_host_data.set('CONFIG_AF_VSOCK', true)
+endif
 
 have_vss = false
 have_vss_sdk = false # old xp/2003 SDK
diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
index 4773755fd5..80bd5cca7f 100644
--- a/util/qemu-sockets.c
+++ b/util/qemu-sockets.c
@@ -18,7 +18,11 @@
 #include "qemu/osdep.h"
 
 #ifdef CONFIG_AF_VSOCK
+#ifndef _WIN32
 #include <linux/vm_sockets.h>
+#else
+#include "system/vio_sockets.h"
+#endif
 #endif /* CONFIG_AF_VSOCK */
 
 #include "monitor/monitor.h"
-- 
2.54.0


