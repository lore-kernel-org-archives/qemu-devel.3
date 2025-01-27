Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02E4C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 07:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcgUj-0001K1-3T; Tue, 28 Jan 2025 02:58:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgUa-0000HQ-J4; Tue, 28 Jan 2025 02:58:40 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcgUY-000128-V8; Tue, 28 Jan 2025 02:58:40 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C43E3E1AFC;
 Tue, 28 Jan 2025 10:54:25 +0300 (MSK)
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3F4A61A62E3;
 Tue, 28 Jan 2025 10:54:51 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id EFDFA5205D; Tue, 28 Jan 2025 10:54:50 +0300 (MSK)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.9 27/45] edk2: get version + date from git submodule
Date: Mon, 27 Jan 2025 23:26:08 +0300
Message-Id: <20250127202630.3724367-27-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-8.2.9-20250127232621@cover.tls.msk.ru>
References: <qemu-stable-8.2.9-20250127232621@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Turned out hard-coding version and date in the Makefile wasn't a bright
idea.  Updating it on edk2 updates is easily forgotten.  Fetch the info
from git instead.  Store in edk2-version, so this can be committed to
the repo and is present in tarballs too.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20240327102448.61877-2-kraxel@redhat.com>
(cherry picked from commit 6539c73dccfa8fff1f83d40f1c4477a233876071)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/roms/Makefile b/roms/Makefile
index 67f709ba2d..3caae36bbb 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -52,6 +52,8 @@ SEABIOS_EXTRAVERSION="-prebuilt.qemu.org"
 #
 EDK2_EFIROM = edk2/BaseTools/Source/C/bin/EfiRom
 
+-include edk2-version
+
 default help:
 	@echo "nothing is build by default"
 	@echo "available build targets:"
@@ -146,10 +148,19 @@ skiboot:
 	$(MAKE) -C skiboot CROSS=$(powerpc64_cross_prefix)
 	cp skiboot/skiboot.lid ../pc-bios/skiboot.lid
 
-efi:
+edk2-version: edk2
+	if test -e edk2/.git; then \
+		echo "EDK2_STABLE = $$(cd edk2; git describe --tags --match 'edk2-stable*')" > $@; \
+		echo "EDK2_DATE = $$(cd edk2; git log -1 --pretty='format:%cd' --date='format:%m/%d/%Y')" >> $@; \
+	else \
+		touch $@; \
+	fi
+
+efi: edk2-version
 	$(PYTHON) edk2-build.py --config edk2-build.config \
-		--version-override "edk2-stable202302-for-qemu" \
-		--release-date "03/01/2023"
+		--version-override "$(EDK2_STABLE)-for-qemu" \
+		--release-date "$(EDK2_DATE)" \
+		--silent --no-logs
 	rm -f ../pc-bios/edk2-*.fd.bz2
 	bzip2 --verbose ../pc-bios/edk2-*.fd
 
-- 
2.39.5


