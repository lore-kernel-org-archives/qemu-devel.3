Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5459E7FDC6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 19:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmzt3-0000Fb-7a; Mon, 02 Feb 2026 14:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmzsx-0000DR-Pq; Mon, 02 Feb 2026 14:47:03 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmzsw-0003DL-79; Mon, 02 Feb 2026 14:46:59 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F4099185098;
 Mon, 02 Feb 2026 22:46:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A65B335B27A;
 Mon, 02 Feb 2026 22:46:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.8 06/69] tests/docker: fix debian-all-test-cross
Date: Mon,  2 Feb 2026 22:45:29 +0300
Message-ID: <20260202194638.939438-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
References: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Alex Bennée <alex.bennee@linaro.org>

It turns out you can't easily expand an ENV var across multiple steps
in a dockerfile. This meant we silently dropped the architectures we
should have even on amd64 hosts. As the updated AVAILABLE_COMPILERS is
only needed for the following apt install line just merge them.

Fixes: 6da616bb170 (tests/docker: handle host-arch selection for all-test-cross)
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250804104308.250949-1-alex.bennee@linaro.org>
(cherry picked from commit 61432e805e5028df0a3df5a76915cdc3007ecd41)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index ef69bbc8a5..420a4e33e6 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -62,9 +62,7 @@ RUN if dpkg-architecture -e amd64; then \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; \
   fi && \
-  echo "compilers: ${AVAILABLE_COMPILERS}"
-
-RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+  DEBIAN_FRONTEND=noninteractive eatmydata \
         apt install -y --no-install-recommends \
         ${AVAILABLE_COMPILERS} && \
         dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt
-- 
2.47.3


