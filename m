Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D929BCA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNBf-0006gC-MF; Sat, 30 Aug 2025 11:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uruXD-000487-Op
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:32:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uruX0-00071N-W9
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756456338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KckSa2WEXoYvVaFR55TUx1sVioyUDC48REchOysQKuk=;
 b=U+IoaT1mbkb6xswuE/vF/WMPJLUTE0j2ueKGwLD8/S+hS8QcdwnTruJWZna/LQWX0RXYlj
 Vvgli9Iv/NJxUz1lgRWVcqLC3ZUbLZrkQPYRdwJUK+PUMhlBszo26W8rADtOE0RtTrXjgA
 OS2tGnsDrdQv5+Ht75abu1Xp7pjBaZI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-L3jWIUwRPCKJ2tlT_825jg-1; Fri,
 29 Aug 2025 04:32:08 -0400
X-MC-Unique: L3jWIUwRPCKJ2tlT_825jg-1
X-Mimecast-MFC-AGG-ID: L3jWIUwRPCKJ2tlT_825jg_1756456327
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 567EC1956087; Fri, 29 Aug 2025 08:32:07 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.108])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 765DF19560BC; Fri, 29 Aug 2025 08:32:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 3/3] tests/functional: handle URLError when fetching assets
Date: Fri, 29 Aug 2025 09:31:56 +0100
Message-ID: <20250829083156.2570137-4-berrange@redhat.com>
In-Reply-To: <20250829083156.2570137-1-berrange@redhat.com>
References: <20250829083156.2570137-1-berrange@redhat.com>
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
 tests/functional/qemu_test/asset.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index ae2bec3ea5..36f64fe2f6 100644
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
@@ -171,6 +171,13 @@ def fetch(self):
                     raise AssetError(self, "Unable to download %s: "
                                      "HTTP error %d" % (self.url, e.code))
                 continue
+            except URLError as e:
+                # This is typically a network/service level error
+                # eg urlopen error [Errno 110] Connection timed out>
+                tmp_cache_file.unlink()
+                self.log.error("Unable to download %s: URL error %s",
+                               self.url, e)
+                continue
             except Exception as e:
                 tmp_cache_file.unlink()
                 raise AssetError(self, "Unable to download %s: %s" % (
-- 
2.50.1


