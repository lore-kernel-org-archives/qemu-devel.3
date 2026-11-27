Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55371606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N6ac8Aqv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xX1Pb-0003Hd-Ol; Fri, 27 Nov 2026 14:15:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1O4-0001wV-LD; Fri, 27 Nov 2026 14:13:40 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xX1O2-0007yN-GW; Fri, 27 Nov 2026 14:13:35 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 976F661521;
 Fri, 27 Nov 2026 19:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E191F00898;
 Fri, 27 Nov 2026 19:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795806812;
 bh=RmIEuSSk+Y3n+MfaYNg9vFBdjEvhvGaZXB+lPSu4Wrw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=N6ac8AqvALlKNFY6Lkz4JhP3wfUt8GXkXZ2iCVwbcfKHgOhFEUPi4Kgz7jptu7UQZ
 YlRc8ReadbeCNfcP3wyKiMuuxVCEhYXvDdvUizmYY90/m4XL4pGmgdl4CtAopyLEdI
 QMh8ybK/I2NvkayxjjorqdNCx65uHCl6AtSPbTWBcAyx/IhCByCkRi/BStVmoFbLO+
 mAYsuNEJSxxTZpJGCQRAQqsy93EKZUdk+A7aGwXVcOQEZhpB4x/sryG/qoNt6d/tHy
 u9s+sh0cNUwFg0YHVE0dwtq+/xtXcGrPGXjvgQVn1uT8OK2rlwbALv1Us6iIPEooS0
 DUY5DA9qi1hcA==
From: Niklas Cassel <cassel@kernel.org>
To: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH 13/13] hw/ide: report ACS-6 compliance behind AHCI
Date: Fri, 27 Nov 2026 20:12:48 +0100
Message-ID: <20261127191250.3298004-14-cassel@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127191250.3298004-1-cassel@kernel.org>
References: <20261127191250.3298004-1-cassel@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=cassel@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Behind AHCI, a disk now implements the General Purpose Logging and
Sense Data Reporting feature sets, the NCQ logs and RECEIVE FPDMA
QUEUED.

Report compliance with ACS-6 in IDENTIFY DEVICE: word 80 sets
every major version bit from ATA/ATAPI-4 to ACS-6 (bits 13:4), and
word 81 reports the latest ACS-6 minor version, ACS-6 version 11
(0070h).

A disk on another controller has none of these, and keeps reporting
ATA/ATAPI-4 to ATA/ATAPI-7, with the ATA/ATAPI-5 minor version (0016h).

Correct the comment of that major version, which named ATA-3 to
ATA/ATAPI-6. Check both in the identify qtests.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 hw/ide/core.c           | 9 +++++++--
 tests/qtest/ahci-test.c | 2 ++
 tests/qtest/ide-test.c  | 2 ++
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 31bb617390..7890780b90 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -208,8 +208,13 @@ static void ide_identify(IDEState *s)
         put_le16(p + 78, (1 << 7));
     }
 
-    put_le16(p + 80, 0xf0); /* ata3 -> ata6 supported */
-    put_le16(p + 81, 0x16); /* conforms to ata5 */
+    if (s->ncq_queues) {
+        put_le16(p + 80, 0x3ff0); /* ATA/ATAPI-4 -> ACS-6 supported */
+        put_le16(p + 81, 0x70); /* conforms to ACS-6 version 11 */
+    } else {
+        put_le16(p + 80, 0xf0); /* ATA/ATAPI-4 -> ATA/ATAPI-7 supported */
+        put_le16(p + 81, 0x16); /* conforms to ata5 */
+    }
     /* 14=NOP supported, 5=WCACHE supported, 0=SMART supported */
     put_le16(p + 82, (1 << 14) | (1 << 5) | 1);
     /* 13=flush_cache_ext,12=flush_cache,10=lba48 */
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 06d090cc04..c34c98d5cb 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -851,6 +851,8 @@ static void ahci_test_identify(AHCIQState *ahci)
 
     sect_size = le16_to_cpu(*((uint16_t *)(&buff[5])));
     g_assert_cmphex(sect_size, ==, AHCI_SECTOR_SIZE);
+    g_assert_cmphex(le16_to_cpu(buff[80]), ==, 0x3ff0);
+    g_assert_cmphex(le16_to_cpu(buff[81]), ==, 0x70);
 }
 
 static void ahci_test_io_rw_simple(AHCIQState *ahci, unsigned bufsize,
diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index d82efdfdda..c6438326ea 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -749,6 +749,8 @@ static void test_identify(void)
     assert_bit_clear(buf[84], 0x20);
     assert_bit_clear(buf[86], 0x8000);
     g_assert_cmphex(buf[119], ==, 0);
+    g_assert_cmphex(buf[80], ==, 0xf0);
+    g_assert_cmphex(buf[81], ==, 0x16);
 
     ide_test_quit(qts);
     free_pci_device(dev);
-- 
2.56.1


