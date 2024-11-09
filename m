Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A7CD5E122
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 06:41:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9f8p-0003zJ-2r; Sat, 09 Nov 2024 01:40:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9f8j-0003pD-8Z; Sat, 09 Nov 2024 01:40:10 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9f8g-00025b-O5; Sat, 09 Nov 2024 01:40:09 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3F403A12F4;
 Sat,  9 Nov 2024 09:38:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A8219167DD8;
 Sat,  9 Nov 2024 09:39:04 +0300 (MSK)
Received: (nullmailer pid 3272531 invoked by uid 1000);
 Sat, 09 Nov 2024 06:39:03 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.15 13/33] tests: Wait for migration completion on
 destination QEMU to avoid failures
Date: Sat,  9 Nov 2024 09:38:39 +0300
Message-Id: <20241109063903.3272404-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-7.2.15-20241109093832@cover.tls.msk.ru>
References: <qemu-stable-7.2.15-20241109093832@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Stefan Berger <stefanb@linux.ibm.com>

Rather than waiting for the completion of migration on the source side,
wait for it on the destination QEMU side to avoid accessing the TPM TIS
memory mapped registers before QEMU could restore their state. This
error condition could be triggered on busy systems where the destination
QEMU did not have enough time to restore the TIS state while the test case
was already reading its registers. The test case was for example reading
the STS register and received an unexpected value (0xffffffff), which
lead to a segmentation fault later on due to trying to read 0xffff bytes
from the TIS into a buffer.

Cc:  <qemu-stable@nongnu.org>
Reported-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
(cherry picked from commit d9280ea3174700170d39c4cdd3f587f260757711)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
index 25073d1f9e..7ea9038f60 100644
--- a/tests/qtest/tpm-tests.c
+++ b/tests/qtest/tpm-tests.c
@@ -114,7 +114,7 @@ void tpm_test_swtpm_migration_test(const char *src_tpm_path,
                      sizeof(tpm_pcrread_resp));
 
     tpm_util_migrate(src_qemu, uri);
-    tpm_util_wait_for_migration_complete(src_qemu);
+    tpm_util_wait_for_migration_complete(dst_qemu);
 
     tpm_util_pcrread(dst_qemu, tx, tpm_pcrread_resp,
                      sizeof(tpm_pcrread_resp));
-- 
2.39.5


