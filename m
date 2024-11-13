Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 218C8D637AF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 19:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBJKD-0006Jy-IA; Wed, 13 Nov 2024 14:46:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBJKB-0006Je-Uj
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:46:47 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tBJK9-00038W-LW
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 14:46:47 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4D68321109;
 Wed, 13 Nov 2024 19:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731527204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Obf82hsFk+XoJDmLfrt5s0eGY5E0IBT3UZZp+PRauck=;
 b=1re+R3uro55Mgl1wiuJYUgEraqxQPaONFqcMqwY6D0l4TISTejjknaItthldRXNfW8S1Le
 MyEqSv30hqiQ7l0UCrz/blO317goFv3TmUaxjdGsfntYEWIxtGf5VlTcGqIzPJRwqFeR18
 gtm2L5d5e4AFu63iQMgCRT3fa1llLtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731527204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Obf82hsFk+XoJDmLfrt5s0eGY5E0IBT3UZZp+PRauck=;
 b=BeJlB7n/TI/IrAFHWMYfkJ86xDl4si0jDhWNgPnJ5Zcs6XNoe3DhsQxd7yeUnaSUzIaL9A
 B0FWIJr+3gwmd9Cw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=o4Y7xvc2;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eZ+7hyqa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1731527203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Obf82hsFk+XoJDmLfrt5s0eGY5E0IBT3UZZp+PRauck=;
 b=o4Y7xvc2+8lTrrqNH0SXpT7A2PRItlw3H7sliWSg79DGcCVknnZj5J2qwPO3W9fCC5qafV
 IJ8jRva/BTLBUfdXXbhUuLjN0KTLokjR2XKs6JS+KvlUsXAoBhpHIRi0O6Mfy/AOq9OHJG
 Tpohwd4sjORvhxl+7ymyBBafZxf5pbA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1731527203;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Obf82hsFk+XoJDmLfrt5s0eGY5E0IBT3UZZp+PRauck=;
 b=eZ+7hyqaUSviwqh7XeYHnYbrHJsrEH28aB3HzSr6Am0L9G0uvgNqUiC4rMJTbidiGKIERm
 wQT7bkn79U+UuCBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A32FC13301;
 Wed, 13 Nov 2024 19:46:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cMcXGiECNWfLcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 13 Nov 2024 19:46:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 04/22] tests/migration: Disambiguate guestperf vs. a-b
Date: Wed, 13 Nov 2024 16:46:12 -0300
Message-Id: <20241113194630.3385-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241113194630.3385-1-farosas@suse.de>
References: <20241113194630.3385-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4D68321109
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCPT_COUNT_FIVE(0.00)[5];
 DBL_BLOCKED_OPENRESOLVER(0.00)[nongnu.org:email, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim, suse.de:mid, suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The current build structure for migration tests is confusing. There is
the tests/migration directory, which contains two different guest code
implementations, one for the qtests (a-b-{bootblock|kernel}.S) and
another for the guestperf script (stress.c). One uses a Makefile,
while the other uses meson.

The next patches will add a new qtests/migration/ directory to hold
qtest code which will make the situation even more confusing.

Move the guest code used by qtests into a new qtests/migration/
directory and rename the old one to tests/migration-stress.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 MAINTAINERS                                            |  5 +++--
 tests/meson.build                                      |  2 +-
 .../{migration => migration-stress}/guestperf-batch.py |  0
 .../{migration => migration-stress}/guestperf-plot.py  |  0
 tests/{migration => migration-stress}/guestperf.py     |  0
 .../guestperf/__init__.py                              |  0
 .../guestperf/comparison.py                            |  0
 .../guestperf/engine.py                                |  0
 .../guestperf/hardware.py                              |  0
 .../{migration => migration-stress}/guestperf/plot.py  |  0
 .../guestperf/progress.py                              |  0
 .../guestperf/report.py                                |  0
 .../guestperf/scenario.py                              |  0
 .../{migration => migration-stress}/guestperf/shell.py |  0
 .../guestperf/timings.py                               |  0
 tests/{migration => migration-stress}/initrd-stress.sh |  0
 tests/{migration => migration-stress}/meson.build      |  0
 tests/{migration => migration-stress}/stress.c         |  0
 tests/qtest/migration-test.c                           | 10 +++++-----
 tests/{ => qtest}/migration/Makefile                   |  0
 tests/{ => qtest}/migration/aarch64/Makefile           |  0
 tests/{ => qtest}/migration/aarch64/a-b-kernel.S       |  0
 tests/{ => qtest}/migration/aarch64/a-b-kernel.h       |  0
 tests/{ => qtest}/migration/i386/Makefile              |  0
 tests/{ => qtest}/migration/i386/a-b-bootblock.S       |  0
 tests/{ => qtest}/migration/i386/a-b-bootblock.h       |  0
 tests/{ => qtest}/migration/migration-test.h           |  0
 tests/{ => qtest}/migration/ppc64/Makefile             |  0
 tests/{ => qtest}/migration/ppc64/a-b-kernel.S         |  0
 tests/{ => qtest}/migration/ppc64/a-b-kernel.h         |  0
 tests/{ => qtest}/migration/s390x/Makefile             |  0
 tests/{ => qtest}/migration/s390x/a-b-bios.c           |  0
 tests/{ => qtest}/migration/s390x/a-b-bios.h           |  0
 33 files changed, 9 insertions(+), 8 deletions(-)
 rename tests/{migration => migration-stress}/guestperf-batch.py (100%)
 rename tests/{migration => migration-stress}/guestperf-plot.py (100%)
 rename tests/{migration => migration-stress}/guestperf.py (100%)
 rename tests/{migration => migration-stress}/guestperf/__init__.py (100%)
 rename tests/{migration => migration-stress}/guestperf/comparison.py (100%)
 rename tests/{migration => migration-stress}/guestperf/engine.py (100%)
 rename tests/{migration => migration-stress}/guestperf/hardware.py (100%)
 rename tests/{migration => migration-stress}/guestperf/plot.py (100%)
 rename tests/{migration => migration-stress}/guestperf/progress.py (100%)
 rename tests/{migration => migration-stress}/guestperf/report.py (100%)
 rename tests/{migration => migration-stress}/guestperf/scenario.py (100%)
 rename tests/{migration => migration-stress}/guestperf/shell.py (100%)
 rename tests/{migration => migration-stress}/guestperf/timings.py (100%)
 rename tests/{migration => migration-stress}/initrd-stress.sh (100%)
 rename tests/{migration => migration-stress}/meson.build (100%)
 rename tests/{migration => migration-stress}/stress.c (100%)
 rename tests/{ => qtest}/migration/Makefile (100%)
 rename tests/{ => qtest}/migration/aarch64/Makefile (100%)
 rename tests/{ => qtest}/migration/aarch64/a-b-kernel.S (100%)
 rename tests/{ => qtest}/migration/aarch64/a-b-kernel.h (100%)
 rename tests/{ => qtest}/migration/i386/Makefile (100%)
 rename tests/{ => qtest}/migration/i386/a-b-bootblock.S (100%)
 rename tests/{ => qtest}/migration/i386/a-b-bootblock.h (100%)
 rename tests/{ => qtest}/migration/migration-test.h (100%)
 rename tests/{ => qtest}/migration/ppc64/Makefile (100%)
 rename tests/{ => qtest}/migration/ppc64/a-b-kernel.S (100%)
 rename tests/{ => qtest}/migration/ppc64/a-b-kernel.h (100%)
 rename tests/{ => qtest}/migration/s390x/Makefile (100%)
 rename tests/{ => qtest}/migration/s390x/a-b-bios.c (100%)
 rename tests/{ => qtest}/migration/s390x/a-b-bios.h (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 095420f8b0..068234d2c3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -118,7 +118,7 @@ F: pc-bios/s390-ccw.img
 F: target/s390x/
 F: docs/system/target-s390x.rst
 F: docs/system/s390x/
-F: tests/migration/s390x/
+F: tests/qtest/migration/s390x/
 K: ^Subject:.*(?i)s390x?
 L: qemu-s390x@nongnu.org
 
@@ -3416,10 +3416,11 @@ F: include/qemu/userfaultfd.h
 F: migration/
 F: scripts/vmstate-static-checker.py
 F: tests/vmstate-static-checker-data/
+F: tests/qtest/migration/
 F: tests/qtest/migration-*
 F: docs/devel/migration/
 F: qapi/migration.json
-F: tests/migration/
+F: tests/migration-stress/
 F: util/userfaultfd.c
 X: migration/rdma*
 
diff --git a/tests/meson.build b/tests/meson.build
index 907a4c1c98..f96c1be574 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -84,5 +84,5 @@ endif
 subdir('unit')
 subdir('qapi-schema')
 subdir('qtest')
-subdir('migration')
+subdir('migration-stress')
 subdir('functional')
diff --git a/tests/migration/guestperf-batch.py b/tests/migration-stress/guestperf-batch.py
similarity index 100%
rename from tests/migration/guestperf-batch.py
rename to tests/migration-stress/guestperf-batch.py
diff --git a/tests/migration/guestperf-plot.py b/tests/migration-stress/guestperf-plot.py
similarity index 100%
rename from tests/migration/guestperf-plot.py
rename to tests/migration-stress/guestperf-plot.py
diff --git a/tests/migration/guestperf.py b/tests/migration-stress/guestperf.py
similarity index 100%
rename from tests/migration/guestperf.py
rename to tests/migration-stress/guestperf.py
diff --git a/tests/migration/guestperf/__init__.py b/tests/migration-stress/guestperf/__init__.py
similarity index 100%
rename from tests/migration/guestperf/__init__.py
rename to tests/migration-stress/guestperf/__init__.py
diff --git a/tests/migration/guestperf/comparison.py b/tests/migration-stress/guestperf/comparison.py
similarity index 100%
rename from tests/migration/guestperf/comparison.py
rename to tests/migration-stress/guestperf/comparison.py
diff --git a/tests/migration/guestperf/engine.py b/tests/migration-stress/guestperf/engine.py
similarity index 100%
rename from tests/migration/guestperf/engine.py
rename to tests/migration-stress/guestperf/engine.py
diff --git a/tests/migration/guestperf/hardware.py b/tests/migration-stress/guestperf/hardware.py
similarity index 100%
rename from tests/migration/guestperf/hardware.py
rename to tests/migration-stress/guestperf/hardware.py
diff --git a/tests/migration/guestperf/plot.py b/tests/migration-stress/guestperf/plot.py
similarity index 100%
rename from tests/migration/guestperf/plot.py
rename to tests/migration-stress/guestperf/plot.py
diff --git a/tests/migration/guestperf/progress.py b/tests/migration-stress/guestperf/progress.py
similarity index 100%
rename from tests/migration/guestperf/progress.py
rename to tests/migration-stress/guestperf/progress.py
diff --git a/tests/migration/guestperf/report.py b/tests/migration-stress/guestperf/report.py
similarity index 100%
rename from tests/migration/guestperf/report.py
rename to tests/migration-stress/guestperf/report.py
diff --git a/tests/migration/guestperf/scenario.py b/tests/migration-stress/guestperf/scenario.py
similarity index 100%
rename from tests/migration/guestperf/scenario.py
rename to tests/migration-stress/guestperf/scenario.py
diff --git a/tests/migration/guestperf/shell.py b/tests/migration-stress/guestperf/shell.py
similarity index 100%
rename from tests/migration/guestperf/shell.py
rename to tests/migration-stress/guestperf/shell.py
diff --git a/tests/migration/guestperf/timings.py b/tests/migration-stress/guestperf/timings.py
similarity index 100%
rename from tests/migration/guestperf/timings.py
rename to tests/migration-stress/guestperf/timings.py
diff --git a/tests/migration/initrd-stress.sh b/tests/migration-stress/initrd-stress.sh
similarity index 100%
rename from tests/migration/initrd-stress.sh
rename to tests/migration-stress/initrd-stress.sh
diff --git a/tests/migration/meson.build b/tests/migration-stress/meson.build
similarity index 100%
rename from tests/migration/meson.build
rename to tests/migration-stress/meson.build
diff --git a/tests/migration/stress.c b/tests/migration-stress/stress.c
similarity index 100%
rename from tests/migration/stress.c
rename to tests/migration-stress/stress.c
diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 74df687c78..ff778ac659 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -24,7 +24,7 @@
 #include "ppc-util.h"
 
 #include "migration-helpers.h"
-#include "tests/migration/migration-test.h"
+#include "migration/migration-test.h"
 #ifdef CONFIG_GNUTLS
 # include "tests/unit/crypto-tls-psk-helpers.h"
 # ifdef CONFIG_TASN1
@@ -138,10 +138,10 @@ static char *bootpath;
 /* The boot file modifies memory area in [start_address, end_address)
  * repeatedly. It outputs a 'B' at a fixed rate while it's still running.
  */
-#include "tests/migration/i386/a-b-bootblock.h"
-#include "tests/migration/aarch64/a-b-kernel.h"
-#include "tests/migration/ppc64/a-b-kernel.h"
-#include "tests/migration/s390x/a-b-bios.h"
+#include "migration/i386/a-b-bootblock.h"
+#include "migration/aarch64/a-b-kernel.h"
+#include "migration/ppc64/a-b-kernel.h"
+#include "migration/s390x/a-b-bios.h"
 
 static void bootfile_delete(void)
 {
diff --git a/tests/migration/Makefile b/tests/qtest/migration/Makefile
similarity index 100%
rename from tests/migration/Makefile
rename to tests/qtest/migration/Makefile
diff --git a/tests/migration/aarch64/Makefile b/tests/qtest/migration/aarch64/Makefile
similarity index 100%
rename from tests/migration/aarch64/Makefile
rename to tests/qtest/migration/aarch64/Makefile
diff --git a/tests/migration/aarch64/a-b-kernel.S b/tests/qtest/migration/aarch64/a-b-kernel.S
similarity index 100%
rename from tests/migration/aarch64/a-b-kernel.S
rename to tests/qtest/migration/aarch64/a-b-kernel.S
diff --git a/tests/migration/aarch64/a-b-kernel.h b/tests/qtest/migration/aarch64/a-b-kernel.h
similarity index 100%
rename from tests/migration/aarch64/a-b-kernel.h
rename to tests/qtest/migration/aarch64/a-b-kernel.h
diff --git a/tests/migration/i386/Makefile b/tests/qtest/migration/i386/Makefile
similarity index 100%
rename from tests/migration/i386/Makefile
rename to tests/qtest/migration/i386/Makefile
diff --git a/tests/migration/i386/a-b-bootblock.S b/tests/qtest/migration/i386/a-b-bootblock.S
similarity index 100%
rename from tests/migration/i386/a-b-bootblock.S
rename to tests/qtest/migration/i386/a-b-bootblock.S
diff --git a/tests/migration/i386/a-b-bootblock.h b/tests/qtest/migration/i386/a-b-bootblock.h
similarity index 100%
rename from tests/migration/i386/a-b-bootblock.h
rename to tests/qtest/migration/i386/a-b-bootblock.h
diff --git a/tests/migration/migration-test.h b/tests/qtest/migration/migration-test.h
similarity index 100%
rename from tests/migration/migration-test.h
rename to tests/qtest/migration/migration-test.h
diff --git a/tests/migration/ppc64/Makefile b/tests/qtest/migration/ppc64/Makefile
similarity index 100%
rename from tests/migration/ppc64/Makefile
rename to tests/qtest/migration/ppc64/Makefile
diff --git a/tests/migration/ppc64/a-b-kernel.S b/tests/qtest/migration/ppc64/a-b-kernel.S
similarity index 100%
rename from tests/migration/ppc64/a-b-kernel.S
rename to tests/qtest/migration/ppc64/a-b-kernel.S
diff --git a/tests/migration/ppc64/a-b-kernel.h b/tests/qtest/migration/ppc64/a-b-kernel.h
similarity index 100%
rename from tests/migration/ppc64/a-b-kernel.h
rename to tests/qtest/migration/ppc64/a-b-kernel.h
diff --git a/tests/migration/s390x/Makefile b/tests/qtest/migration/s390x/Makefile
similarity index 100%
rename from tests/migration/s390x/Makefile
rename to tests/qtest/migration/s390x/Makefile
diff --git a/tests/migration/s390x/a-b-bios.c b/tests/qtest/migration/s390x/a-b-bios.c
similarity index 100%
rename from tests/migration/s390x/a-b-bios.c
rename to tests/qtest/migration/s390x/a-b-bios.c
diff --git a/tests/migration/s390x/a-b-bios.h b/tests/qtest/migration/s390x/a-b-bios.h
similarity index 100%
rename from tests/migration/s390x/a-b-bios.h
rename to tests/qtest/migration/s390x/a-b-bios.h
-- 
2.35.3


