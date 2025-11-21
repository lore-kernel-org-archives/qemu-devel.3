Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C128CCF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMd1a-0000z5-TU; Fri, 21 Nov 2025 21:06:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcXn-0002Fi-DR; Fri, 21 Nov 2025 20:36:07 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMcVl-00020H-VG; Fri, 21 Nov 2025 20:36:04 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1375516CA86;
 Fri, 21 Nov 2025 21:44:30 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C1136321CC2;
 Fri, 21 Nov 2025 21:44:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.7 75/81] tests/functional: handle URLError when fetching
 assets
Date: Fri, 21 Nov 2025 21:44:14 +0300
Message-ID: <20251121184424.1137669-75-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
References: <qemu-stable-10.0.7-20251121170317@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

From: Daniel P. Berrangé <berrange@redhat.com>

We treat most HTTP errors as non-fatal when fetching assets,
but forgot to handle network level errors. This adds catching
of URLError so that we retry on failure, and will ultimately
trigger graceful skipping in the pre-cache task.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250829142616.2633254-4-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 335da23abec85cd2f6d10f1fe36b28a02088e723)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index debed88f5e..5aceb8f27a 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -15,7 +15,7 @@
 from time import sleep
 from pathlib import Path
 from shutil import copyfileobj
-from urllib.error import HTTPError
+from urllib.error import HTTPError, URLError
 
 class AssetError(Exception):
     def __init__(self, asset, msg, transient=False):
@@ -167,6 +167,14 @@ def fetch(self):
                     raise AssetError(self, "Unable to download: "
                                      "HTTP error %d" % e.code)
                 continue
+            except URLError as e:
+                # This is typically a network/service level error
+                # eg urlopen error [Errno 110] Connection timed out>
+                tmp_cache_file.unlink()
+                self.log.error("Unable to download %s: URL error %s",
+                               self.url, e.reason)
+                raise AssetError(self, "Unable to download: URL error %s" %
+                                 e.reason, transient=True)
             except Exception as e:
                 tmp_cache_file.unlink()
                 raise AssetError(self, "Unable to download: %s" % e)
-- 
2.47.3


