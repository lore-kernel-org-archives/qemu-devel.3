Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED533D15D88
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 12:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2reS-0001ey-59; Mon, 21 Oct 2024 08:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2reP-0001eO-OZ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 08:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t2reN-00012o-Il
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 08:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729514202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=++SvW500SGFWsn1sWBh4jLVUUJBC7dHn3VXHDDXIfEE=;
 b=gyYGVM8QEqRSu7sp2tl1+wUnkfQak5qm2TM/sZZzHA/HHZr3rkudSN6sj8+FmCDCjf0giq
 gjOZylMTq5PEdcEAsN/oMTKc3qYy37x5xxaF8vBK8yKrTf4n0i7XOZygdoqg1ovZ/yHtKU
 CMwDv4ZWj8DlEZWWJLT4bP3q3PZqXs0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-00WV_FTfPtG6ZK5BXOIY7g-1; Mon,
 21 Oct 2024 08:36:38 -0400
X-MC-Unique: 00WV_FTfPtG6ZK5BXOIY7g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 676D41955EE6; Mon, 21 Oct 2024 12:36:37 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.27])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9BBAF300018D; Mon, 21 Oct 2024 12:36:35 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] test: make cached assets for functional tests read-only
Date: Mon, 21 Oct 2024 13:36:33 +0100
Message-ID: <20241021123633.1391911-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This ensures that if a functional test runs QEMU with a writable
disk pointing to a cached asset, an error will be reported, rather
than silently modifying the cache file.

As an example, tweaking test_sbsaref.py to set snapshot=off,
results in a clear error:

  Command: ./build/qemu-system-aarch64 ...snip... -drive file=/var/home/berrange/.cache/qemu/download/44cdbae275ef1bb6dab1d5fbb59473d4f741e1c8ea8a80fd9e906b531d6ad461,format=raw,snapshot=off -cpu max,pauth=off
  Output: qemu-system-aarch64: Could not open '/var/home/berrange/.cache/qemu/download/44cdbae275ef1bb6dab1d5fbb59473d4f741e1c8ea8a80fd9e906b531d6ad461': Permission denied

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/asset.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index e47bfac035..f126cd5863 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -8,6 +8,7 @@
 import hashlib
 import logging
 import os
+import stat
 import subprocess
 import sys
 import unittest
@@ -143,6 +144,8 @@ def fetch(self):
             raise Exception("Hash of %s does not match %s" %
                             (self.url, self.hash))
         tmp_cache_file.replace(self.cache_file)
+        # Remove write perms to stop tests accidentally modifying them
+        os.chmod(self.cache_file, stat.S_IRUSR | stat.S_IRGRP)
 
         self.log.info("Cached %s at %s" % (self.url, self.cache_file))
         return str(self.cache_file)
-- 
2.46.0


