Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D29606A885
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b88MohyD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRSxp-0006b1-Nk; Thu, 12 Nov 2026 06:27:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRSxl-0006a5-LR
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 06:27:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRSxj-0002RT-RR
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 06:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794482844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Pgcbj9/lnTidEzAyEj6557SM6wLqupwTUw7W4HzG/B0=;
 b=b88MohyDC1tYGZBsN0SxBUeWeYqgDZBDHh/SRGi9tF7r+ykGS6t1+GwlMRWp6amU6bs/y3
 KyL5mfE8ga0x59DR6xFN58R0tRPvKlHa2qguwkv9Qeqjv37lC3PJTi3SVv/27Wj0kXNMBQ
 BB2vflkNW6yKE+oOM6k5IbgEyq2llmo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-qCALw8JJO0y0Tk9SHjOguw-1; Thu,
 12 Nov 2026 06:27:21 -0500
X-MC-Unique: qCALw8JJO0y0Tk9SHjOguw-1
X-Mimecast-MFC-AGG-ID: qCALw8JJO0y0Tk9SHjOguw_1794482839
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 94CBE1885054; Thu, 12 Nov 2026 11:27:19 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF5FF1956087; Thu, 12 Nov 2026 11:27:17 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH] tests/functional: update tuxrun kernel hashes
Date: Thu, 12 Nov 2026 15:27:15 +0400
Message-ID: <20261112112714.357297-2-marcandre.lureau@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marc-André Lureau <marcandre.lureau@redhat.com>

tuxboot rebuilt the 6.18.54 kernels, so the recorded hashes no longer
match and the tuxrun tests fail to fetch their assets. Update the
kernel and vmlinux hashes for x86_64, arm64 and s390. The buildroot
rootfs images are unchanged.

We may want to go back to a fixed/time tagged version to avoid future
breakage.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/functional/aarch64/test_tuxrun.py | 4 ++--
 tests/functional/s390x/test_tuxrun.py   | 4 ++--
 tests/functional/x86_64/test_tuxrun.py  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/functional/aarch64/test_tuxrun.py b/tests/functional/aarch64/test_tuxrun.py
index 2ff321582d38..6c4367c8a20d 100755
--- a/tests/functional/aarch64/test_tuxrun.py
+++ b/tests/functional/aarch64/test_tuxrun.py
@@ -18,10 +18,10 @@ class TuxRunAarch64Test(TuxRunBaselineTest):
 
     ASSET_ARM64_KERNEL = Asset(
         'https://storage.tuxboot.com/kernels/6.18.54/arm64/Image.gz',
-        '39f4633bbcb444267d4d829bd28d8868a287c4c160cda64b0fd23fb090571c4e')
+        'e297f12682af7e88735a0aae38e6fbd137192b516ab5f0fc1a81c4bcc3992e80')
     ASSET_ARM64_VMLINUX = Asset(
         'https://storage.tuxboot.com/kernels/6.18.54/arm64/vmlinux.xz',
-        '6487eb113ef6e841aedab6cb6fa704006377d68f64dd544570aa42f462a52b85')
+        'aa9b984337e975528162ed873cf18a072b27be8e4f48e6cf0723e9b490c63171')
     ASSET_ARM64_ROOTFS = Asset(
         'https://storage.tuxboot.com/buildroot/20260924/arm64/rootfs.ext4.zst',
         '4ab8cec9d1e17dbb1abdf2ae1939ad4f9d0dc2466230f6a119a7c1845cdef0b1')
diff --git a/tests/functional/s390x/test_tuxrun.py b/tests/functional/s390x/test_tuxrun.py
index 1dd662aaaf05..be38fcded2e9 100755
--- a/tests/functional/s390x/test_tuxrun.py
+++ b/tests/functional/s390x/test_tuxrun.py
@@ -18,10 +18,10 @@ class TuxRunS390xTest(TuxRunBaselineTest):
 
     ASSET_S390X_KERNEL = Asset(
         'https://storage.tuxboot.com/kernels/6.18.54/s390/bzImage',
-        '5efeb31754b211440e1595ab11355bb006fe78a2c0604ed0a8c55c4598b71aec')
+        'b5022f97e243b8ecd51fc7ce4290a15806ecc51a41edbe777fc0fcdda567269e')
     ASSET_S390X_VMLINUX = Asset(
         'https://storage.tuxboot.com/kernels/6.18.54/s390/vmlinux.xz',
-        '5bbd4d34e0950f88053a9bfd16078896df4b1ee1696fc2ad62488e681a6bdd8e')
+        'cd70050ddb638e81c2f1b96a4629c224aedd36bf8ae3b56b264b070e94642e25')
     ASSET_S390X_ROOTFS = Asset(
         'https://storage.tuxboot.com/buildroot/20260924/s390/rootfs.ext4.zst',
         '5ba18c4d18831c50a0c743990f7bdee1d3b520629d423c55b668d8fbbac9c6f5')
diff --git a/tests/functional/x86_64/test_tuxrun.py b/tests/functional/x86_64/test_tuxrun.py
index 1a1138d16aea..efe907bed820 100755
--- a/tests/functional/x86_64/test_tuxrun.py
+++ b/tests/functional/x86_64/test_tuxrun.py
@@ -18,10 +18,10 @@ class TuxRunX86Test(TuxRunBaselineTest):
 
     ASSET_X86_64_KERNEL = Asset(
         'https://storage.tuxboot.com/kernels/6.18.54/x86_64/bzImage',
-        '24a3ade610c2cc426ff821050de8a35930b0371357d94cc2c334abac6658552b')
+        'ba98a8a07d5f3f3e20119341059c0f0096fda499d30e30049c1ea64553b7e7c2')
     ASSET_X86_64_VMLINUX = Asset(
         'https://storage.tuxboot.com/kernels/6.18.54/x86_64/vmlinux.xz',
-        '77bf44cca48c9c1b9c142e16a2311d58b8ae3462b61bce44bcaf9243b5f26628')
+        'bc8af37608753c6ba47c6fe85f4034188b5f15bb757a0cbd79672c65122278ab')
     ASSET_X86_64_ROOTFS = Asset(
         'https://storage.tuxboot.com/buildroot/20260924/x86_64/rootfs.ext4.zst',
         '8e310455b0244414ccff29c507f7ccfd4032e3587cc405e49ab0322738e3e27c')
-- 
2.56.0.116.g6de20f6092dc


