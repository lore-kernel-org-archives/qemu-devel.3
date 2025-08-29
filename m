Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38CACA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNNC-0000ln-04; Sat, 30 Aug 2025 11:20:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1us03s-0002aM-SQ
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 10:26:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1us03n-0003l9-8s
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 10:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756477592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Is+UiccWxb96yhRoOO7eKrwQn7xK9xKMoov8YL7HXs=;
 b=ZtmdeTwyNlYuP+r0t2uR5tkuzwqd0Or6nv46v2zC3RDVhh5CXgRQZgpOgs7apWQcEslyI0
 X8ojBnnmqcT5o3ji87l3TtoKV8XcGnwmNnLfVUw9xlIz2Je/Sf0JolUkc8JadK+s1uMDMG
 pFjbEa3SBIzCmH8SIEMQ0wnhj0vph5I=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-TEPjQK3LOa2Io4Svkb8TTA-1; Fri,
 29 Aug 2025 10:26:29 -0400
X-MC-Unique: TEPjQK3LOa2Io4Svkb8TTA-1
X-Mimecast-MFC-AGG-ID: TEPjQK3LOa2Io4Svkb8TTA_1756477588
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB0D11956089; Fri, 29 Aug 2025 14:26:27 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.108])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA19719560BC; Fri, 29 Aug 2025 14:26:25 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 3/3] tests/functional: handle URLError when fetching assets
Date: Fri, 29 Aug 2025 15:26:16 +0100
Message-ID: <20250829142616.2633254-4-berrange@redhat.com>
In-Reply-To: <20250829142616.2633254-1-berrange@redhat.com>
References: <20250829142616.2633254-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We treat most HTTP errors as non-fatal when fetching assets,
but forgot to handle network level errors. This adds catching
of URLError so that we retry on failure, and will ultimately
trigger graceful skipping in the pre-cache task.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/asset.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index 5c74adf224..2dd32bf28d 100644
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
@@ -171,6 +171,14 @@ def fetch(self):
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
2.50.1


