Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C70DC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 20:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk7ZD-0005IS-BA; Thu, 07 Aug 2025 16:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uk7Z7-0005E6-KA; Thu, 07 Aug 2025 16:50:22 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1uk7Z5-0007jD-KY; Thu, 07 Aug 2025 16:50:21 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1512B13F363;
 Thu, 07 Aug 2025 23:49:25 +0300 (MSK)
Received: from localhost.localdomain (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E90E425A00B;
 Thu,  7 Aug 2025 23:49:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Stefan Weil via <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 2/2] meson: Fix brlapi compile test for Windows builds
Date: Thu,  7 Aug 2025 23:49:33 +0300
Message-ID: <20250807204942.490526-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250807204942.490526-1-mjt@tls.msk.ru>
References: <20250807204942.490526-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Stefan Weil via <qemu-trivial@nongnu.org>

brlapi__openConnection returns a brlapi_fileDescriptor which is a pointer
for Windows builds.

The test for brlapi fails with cross builds on Debian trixie
(x86_64-w64-mingw32-gcc (GCC) 14-win32):

testfile.c:4:30: error: returning 'brlapi_fileDescriptor' {aka 'void *'} from a function with return type 'int' makes integer from pointer without a cast [-Wint-conversion]
    4 |      int main(void) { return brlapi__openConnection (NULL, NULL, NULL); }
      |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----------
../../../meson.build:1607: WARNING: could not link brlapi, disabling

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 meson.build | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index a7b3c683ce..50c774a195 100644
--- a/meson.build
+++ b/meson.build
@@ -1586,9 +1586,11 @@ if not get_option('brlapi').auto() or have_system
   brlapi = cc.find_library('brlapi', has_headers: ['brlapi.h'],
                          required: get_option('brlapi'))
   if brlapi.found() and not cc.links('''
-     #include <brlapi.h>
-     #include <stddef.h>
-     int main(void) { return brlapi__openConnection (NULL, NULL, NULL); }''', dependencies: brlapi)
+    #include <brlapi.h>
+    #include <stddef.h>
+    int main(void) {
+      return brlapi__openConnection(NULL, NULL, NULL) == BRLAPI_INVALID_FILE_DESCRIPTOR;
+    }''', dependencies: brlapi)
     brlapi = not_found
     if get_option('brlapi').enabled()
       error('could not link brlapi')
-- 
2.47.2


