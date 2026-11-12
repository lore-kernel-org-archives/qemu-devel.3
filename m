Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C57606A327
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h5vkDKpi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRUy5-0004j6-A5; Thu, 12 Nov 2026 08:35:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRUvn-0000AR-4y
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:33:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRUvk-0008Rs-Ka
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794490411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GFsiJ3FjikGncyyns1QRPNOP0x18dCdbyqgo90uDd+I=;
 b=h5vkDKpiQhGsqvm4Gr4Ozl1TH8H4QrAzjC36vqLGBZnWzFau2s53SB+XMjH35Zi/iKjVwc
 32WtV78Oz7a3LONj07SIsf4li01nHFAMFvUKq0OyQRJrScKNrpMIAiI0frWdbntmX8q50C
 TcBqEkq8tSu8eVQJjSANSElDeoMGOdw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-K974BglRNlmN84lEwH5gAA-1; Thu,
 12 Nov 2026 08:33:28 -0500
X-MC-Unique: K974BglRNlmN84lEwH5gAA-1
X-Mimecast-MFC-AGG-ID: K974BglRNlmN84lEwH5gAA_1794490405
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7119E1956088; Thu, 12 Nov 2026 13:33:24 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9B49D18004FE; Thu, 12 Nov 2026 13:33:22 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, Joel Stanley <joel@jms.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org
Subject: [PATCH v2] tests/functional: use immutable tuxboot kernel URLs
Date: Thu, 12 Nov 2026 17:33:20 +0400
Message-ID: <20261112133320.418012-2-marcandre.lureau@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marc-André Lureau <marcandre.lureau@redhat.com>

tuxboot rebuilds the 6.18.54 kernel images in place, so the URLs
without a datestamp now serve content that does not match the recorded
hashes and the tuxrun tests fail to fetch their assets. Point the
x86_64, arm64 and s390 tests at the immutable 20260930 snapshots and
keep the hashes that were recorded against them, instead of implicitly
switching to the rebuilt images.

Do the same for the riscv64 6.11.9 kernel assets, which still used
non-datestamped URLs; their recorded hashes already match the 20241122
snapshot.

Fixes: 8ac1aab21fca ("tests/functional: update arm64 tuxrun images")
Fixes: 09961fafc5a0 ("tests/functional: update s390x tuxrun images")
Fixes: 467c9eb7dd31 ("tests/functional: update x86_64 tuxrun images")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/functional/aarch64/test_tuxrun.py      | 4 ++--
 tests/functional/riscv64/test_milkv_duo.py   | 4 ++--
 tests/functional/riscv64/test_tt_atlantis.py | 2 +-
 tests/functional/riscv64/test_tuxrun.py      | 2 +-
 tests/functional/s390x/test_tuxrun.py        | 4 ++--
 tests/functional/x86_64/test_tuxrun.py       | 4 ++--
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/functional/aarch64/test_tuxrun.py b/tests/functional/aarch64/test_tuxrun.py
index 2ff321582d38..035984d8e3e5 100755
--- a/tests/functional/aarch64/test_tuxrun.py
+++ b/tests/functional/aarch64/test_tuxrun.py
@@ -17,10 +17,10 @@
 class TuxRunAarch64Test(TuxRunBaselineTest):
 
     ASSET_ARM64_KERNEL = Asset(
-        'https://storage.tuxboot.com/kernels/6.18.54/arm64/Image.gz',
+        'https://storage.tuxboot.com/kernels/20260930/6.18.54/arm64/Image.gz',
         '39f4633bbcb444267d4d829bd28d8868a287c4c160cda64b0fd23fb090571c4e')
     ASSET_ARM64_VMLINUX = Asset(
-        'https://storage.tuxboot.com/kernels/6.18.54/arm64/vmlinux.xz',
+        'https://storage.tuxboot.com/kernels/20260930/6.18.54/arm64/vmlinux.xz',
         '6487eb113ef6e841aedab6cb6fa704006377d68f64dd544570aa42f462a52b85')
     ASSET_ARM64_ROOTFS = Asset(
         'https://storage.tuxboot.com/buildroot/20260924/arm64/rootfs.ext4.zst',
diff --git a/tests/functional/riscv64/test_milkv_duo.py b/tests/functional/riscv64/test_milkv_duo.py
index 6a7e2a5d1967..fdc83d7c8284 100755
--- a/tests/functional/riscv64/test_milkv_duo.py
+++ b/tests/functional/riscv64/test_milkv_duo.py
@@ -14,11 +14,11 @@ class MilkvDuoMachine(LinuxKernelTest):
     timeout = 120
 
     ASSET_KERNEL = Asset(
-        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
+        'https://storage.tuxboot.com/kernels/20241122/6.11.9/riscv64/Image',
         '174f8bb87f08961e54fa3fcd954a8e31f4645f6d6af4dd43983d5e9841490fb0'
     )
     ASSET_DTBS = Asset(
-        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/dtbs.tar.xz',
+        'https://storage.tuxboot.com/kernels/20241122/6.11.9/riscv64/dtbs.tar.xz',
         '97e5e65a7e6c68303e53486af120c0846ee8df572e9c15f0c4dccb831d0cef4b'
     )
     ASSET_ROOTFS = Asset(
diff --git a/tests/functional/riscv64/test_tt_atlantis.py b/tests/functional/riscv64/test_tt_atlantis.py
index 48abd5cd27c2..7cd5234432d9 100755
--- a/tests/functional/riscv64/test_tt_atlantis.py
+++ b/tests/functional/riscv64/test_tt_atlantis.py
@@ -14,7 +14,7 @@
 class TTAtlantis(LinuxKernelTest):
 
     ASSET_KERNEL = Asset(
-        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
+        'https://storage.tuxboot.com/kernels/20241122/6.11.9/riscv64/Image',
         '174f8bb87f08961e54fa3fcd954a8e31f4645f6d6af4dd43983d5e9841490fb0')
     ASSET_ROOTFS = Asset(
         ('https://github.com/groeck/linux-build-test/raw/'
diff --git a/tests/functional/riscv64/test_tuxrun.py b/tests/functional/riscv64/test_tuxrun.py
index 6203a45060ce..b470c05300a7 100755
--- a/tests/functional/riscv64/test_tuxrun.py
+++ b/tests/functional/riscv64/test_tuxrun.py
@@ -17,7 +17,7 @@
 class TuxRunRiscV64Test(TuxRunBaselineTest):
 
     ASSET_RISCV64_KERNEL = Asset(
-        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
+        'https://storage.tuxboot.com/kernels/20241122/6.11.9/riscv64/Image',
         '174f8bb87f08961e54fa3fcd954a8e31f4645f6d6af4dd43983d5e9841490fb0')
     ASSET_RISCV64_ROOTFS = Asset(
         'https://storage.tuxboot.com/buildroot/20241119/riscv64/rootfs.ext4.zst',
diff --git a/tests/functional/s390x/test_tuxrun.py b/tests/functional/s390x/test_tuxrun.py
index 1dd662aaaf05..420e7146bb10 100755
--- a/tests/functional/s390x/test_tuxrun.py
+++ b/tests/functional/s390x/test_tuxrun.py
@@ -17,10 +17,10 @@
 class TuxRunS390xTest(TuxRunBaselineTest):
 
     ASSET_S390X_KERNEL = Asset(
-        'https://storage.tuxboot.com/kernels/6.18.54/s390/bzImage',
+        'https://storage.tuxboot.com/kernels/20260930/6.18.54/s390/bzImage',
         '5efeb31754b211440e1595ab11355bb006fe78a2c0604ed0a8c55c4598b71aec')
     ASSET_S390X_VMLINUX = Asset(
-        'https://storage.tuxboot.com/kernels/6.18.54/s390/vmlinux.xz',
+        'https://storage.tuxboot.com/kernels/20260930/6.18.54/s390/vmlinux.xz',
         '5bbd4d34e0950f88053a9bfd16078896df4b1ee1696fc2ad62488e681a6bdd8e')
     ASSET_S390X_ROOTFS = Asset(
         'https://storage.tuxboot.com/buildroot/20260924/s390/rootfs.ext4.zst',
diff --git a/tests/functional/x86_64/test_tuxrun.py b/tests/functional/x86_64/test_tuxrun.py
index 1a1138d16aea..d2e6008ae708 100755
--- a/tests/functional/x86_64/test_tuxrun.py
+++ b/tests/functional/x86_64/test_tuxrun.py
@@ -17,10 +17,10 @@
 class TuxRunX86Test(TuxRunBaselineTest):
 
     ASSET_X86_64_KERNEL = Asset(
-        'https://storage.tuxboot.com/kernels/6.18.54/x86_64/bzImage',
+        'https://storage.tuxboot.com/kernels/20260930/6.18.54/x86_64/bzImage',
         '24a3ade610c2cc426ff821050de8a35930b0371357d94cc2c334abac6658552b')
     ASSET_X86_64_VMLINUX = Asset(
-        'https://storage.tuxboot.com/kernels/6.18.54/x86_64/vmlinux.xz',
+        'https://storage.tuxboot.com/kernels/20260930/6.18.54/x86_64/vmlinux.xz',
         '77bf44cca48c9c1b9c142e16a2311d58b8ae3462b61bce44bcaf9243b5f26628')
     ASSET_X86_64_ROOTFS = Asset(
         'https://storage.tuxboot.com/buildroot/20260924/x86_64/rootfs.ext4.zst',
-- 
2.56.0.116.g6de20f6092dc


