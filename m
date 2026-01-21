Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307F2C44502
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 10:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viVJy-0005tF-9P; Wed, 21 Jan 2026 05:20:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1viVJv-0005sd-Pt
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 05:20:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1viVJq-0004ZD-TU
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 05:20:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768990806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=oaFCJ3y71N19NwfGgWFXFAChlqUUZqmBcQ98mFkddvs=;
 b=YMOBOjIQ+RJ2V/a/3vn+2/Oa3fmxnSrPrSm6okBjfxbV2p9j3awIEBRWk4Od3gWK7GmzHy
 fT6UVs/r6Fy5IJVUPrCl/3MjRNQqhcLvKD84OEzJxLOCMbFXrQb85ZonYIeNzKdG1kY9Sz
 zfH9a9ip+++ADSM3YXaNsDkiYMdwPGc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-gZJ0HLUoPU66UHI8ubNFUA-1; Wed,
 21 Jan 2026 05:20:02 -0500
X-MC-Unique: gZJ0HLUoPU66UHI8ubNFUA-1
X-Mimecast-MFC-AGG-ID: gZJ0HLUoPU66UHI8ubNFUA_1768990801
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 522D019560B5; Wed, 21 Jan 2026 10:20:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.70])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 481C419560AB; Wed, 21 Jan 2026 10:19:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>
Subject: [PATCH] tests/functional: Enforce sha256 as hashsum algorithm for all
 tests
Date: Wed, 21 Jan 2026 11:19:57 +0100
Message-ID: <20260121101957.82477-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The functional testing framework currently supports both, sha256
and sha512 as hashsums for the assets. However, all but one test
currently only use sha256, which should also be sufficient according
to the current security standards. Having two algorithms around already
caused some confusion (e.g. the clean_functional_cache.py script only
supports sha256 right now), so standardize now on enforcing sha256
before more tests use a mix of the two algorithms.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/ppc64/test_fadump.py | 4 +---
 tests/functional/qemu_test/asset.py   | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/tests/functional/ppc64/test_fadump.py b/tests/functional/ppc64/test_fadump.py
index 2d6b8017e8f..bd9692f64c0 100755
--- a/tests/functional/ppc64/test_fadump.py
+++ b/tests/functional/ppc64/test_fadump.py
@@ -32,9 +32,7 @@ class QEMUFadump(LinuxKernelTest):
     ASSET_VMLINUZ_KERNEL = Asset(
         ('https://archives.fedoraproject.org/pub/archive/fedora-secondary/'
          'releases/39/Everything/ppc64le/os/ppc/ppc64/vmlinuz'),
-        ('81e5541d243b50c8f9568906c6918dda22239744d637bb9a7b22d23c3d661226'
-         '8d5302beb2ca5c06f93bdbc9736c414ef5120756c8bf496ff488ad07d116d67f')
-        )
+         '6d77658130a7de1dd014ae14d7983c27f8ba1a61fa02e8d9064afdb8519e7e96')
 
     ASSET_FEDORA_INITRD = Asset(
         ('https://archives.fedoraproject.org/pub/archive/fedora-secondary/'
diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index bae40765ce4..45a2e01e2e6 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -57,10 +57,8 @@ def _check(self, cache_file):
             return True
         if len(self.hash) == 64:
             hl = hashlib.sha256()
-        elif len(self.hash) == 128:
-            hl = hashlib.sha512()
         else:
-            raise AssetError(self, "unknown hash type")
+            raise AssetError(self, "unsupported hash type")
 
         # Calculate the hash of the file:
         with open(cache_file, 'rb') as file:
-- 
2.52.0


