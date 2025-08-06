Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE68C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 07:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujZ1E-0002tM-Vb; Wed, 06 Aug 2025 03:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ujZ12-0002h1-Mz; Wed, 06 Aug 2025 03:56:52 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ujZ10-000217-4e; Wed, 06 Aug 2025 03:56:52 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5DF7313EC5D;
 Wed, 06 Aug 2025 10:56:14 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5DA022585E2;
 Wed,  6 Aug 2025 10:56:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH trivial] tests/qemu-iotests/tests/mirror-sparse: actually
 require O_DIRECT
Date: Wed,  6 Aug 2025 10:56:31 +0300
Message-ID: <20250806075635.3290-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Commit c0ddcb2cbc146e introduced the test which uses cache=direct
mode, without checking if the scratch filesystem supports O_DIRECT.
A subsequent commit, afeb002e0ad49d, tried to fix that issue, but
instead of checking for o_direct, it checked for
`_supported_cache_modes none directsync`, which is not what the
original mirror-sparse test uses.  Fix both by actually checking
for o_direct.

Fixes: c0ddcb2cbc146e "tests: Add iotest mirror-sparse for recent patches"
Fixes: afeb002e0ad49d "tests/qemu-iotests/tests/mirror-sparse: skip if O_DIRECT is not supported"
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
This is what happens when rushing for last-minute
pre-release fixes..  I'm sorry for this.

 tests/qemu-iotests/tests/mirror-sparse | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/tests/mirror-sparse b/tests/qemu-iotests/tests/mirror-sparse
index 3b183eea88..ee7101bd50 100755
--- a/tests/qemu-iotests/tests/mirror-sparse
+++ b/tests/qemu-iotests/tests/mirror-sparse
@@ -40,7 +40,7 @@ cd ..
 _supported_fmt qcow2 raw  # Format of the source. dst is always raw file
 _supported_proto file
 _supported_os Linux
-_supported_cache_modes none directsync
+_require_o_direct
 _require_disk_usage
 
 echo
-- 
2.47.2


