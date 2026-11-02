Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626656076D85
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=yandex-team.ru header.i=@yandex-team.ru header.a=rsa-sha256 header.s=default header.b=NxTdZqYx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNu9X-0000TW-V9; Mon, 02 Nov 2026 10:40:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xNu9T-0000SX-Fe
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 10:40:51 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1xNu9R-0006KU-6y
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 10:40:50 -0500
Received: from mail-nwsmtp-smtp-corp-main-68
 (mail-nwsmtp-smtp-corp-main-68.yp-c.yandex.net)
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 209DF80725;
 Mon, 02 Nov 2026 18:40:46 +0300 (MSK)
Received: from i115954770.yandex-team.ru
 by mail-nwsmtp-smtp-corp-main-68 with ESMTPSA id hepaFh2alCg0-IJ3AK1lZ;
 Mon, 02 Nov 2026 18:40:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1793634045;
 bh=6kBal3UbVKOCteZL+y+QEZAxwTXExQwjyOgu5XNT2XM=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=NxTdZqYxi1bs1rlYXzL2Nu1C0CqFFA1zjdLcbWxUKgR3plPZPDiFpXGhf9otvkL/n
 ghuLAP8daZXiCDA5aWvx8TLbokovCj1/VwEgVKv9tYtL+H0JpsswMLxtU2RUKdWVzV
 /p8kYB1Ed0PN/swTGFtE5K+koc/VMq9qjdokHyBo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: peterx@redhat.com, vsementsov@yandex-team.ro, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 1/2] tests/functional: skipWithoutSudo: handle missing sudo
 binary
Date: Mon,  2 Nov 2026 18:40:40 +0300
Message-ID: <20261102154041.3799429-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102154041.3799429-1-vsementsov@yandex-team.ru>
References: <20261102154041.3799429-1-vsementsov@yandex-team.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

skipWithoutSudo() runs "sudo -n /bin/true" when the decorator is
evaluated, i.e. at module import time. If sudo is not installed (as in
the centos and opensuse CI containers), subprocess.run() raises
FileNotFoundError and the whole test module fails to load, including
the asset precache step. Skip the test instead.

Fixes: ac84b9ec9604 ("tests/functional: add skipWithoutSudo() decorator")
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/functional/qemu_test/decorators.py | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
index aa135acc785..b044f96c941 100644
--- a/tests/functional/qemu_test/decorators.py
+++ b/tests/functional/qemu_test/decorators.py
@@ -7,7 +7,7 @@
 import platform
 import resource
 import subprocess
-from unittest import skipIf, skipUnless
+from unittest import skip, skipIf, skipUnless
 
 from .cmd import which
 
@@ -184,12 +184,15 @@ def skipLockedMemoryTest(locked_memory):
 sudo command is not available.
 '''
 def skipWithoutSudo():
-    proc = subprocess.run(["sudo", "-n", "/bin/true"],
-                          stdin=subprocess.PIPE,
-                          stdout=subprocess.PIPE,
-                          stderr=subprocess.STDOUT,
-                          universal_newlines=True,
-                          check=False)
+    try:
+        proc = subprocess.run(["sudo", "-n", "/bin/true"],
+                              stdin=subprocess.PIPE,
+                              stdout=subprocess.PIPE,
+                              stderr=subprocess.STDOUT,
+                              universal_newlines=True,
+                              check=False)
+    except OSError as e:
+        return skip(f'requires sudo: {e}')
 
     return skipUnless(proc.returncode == 0,
                       f'requires password-less sudo access: {proc.stdout}')
-- 
2.43.0


