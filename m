Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A54D31778
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 18:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8NzF-0004jB-Hb; Tue, 05 Nov 2024 13:09:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8NzD-0004iU-4d
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:09:03 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8NzA-0004sw-MV
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 13:09:02 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7F89421D3A;
 Tue,  5 Nov 2024 18:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730830139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gqF0ChO9YKD/rSMDl0KVbfCgfoW6JfqRSz0zayU3h20=;
 b=qjjyM+tM+G84VX1HaYLlDG3RrgtWPpVXLc32P47Fhl1r6MFOiyR1rBN3ogWSdtwG+rtrB7
 epyM8Gwgcya6OIonFk1IUcriD7YiFebQHdZIYEe7t9mklWlVrTqVwHxtC8eKEehMh9z7Re
 plQbAPjdEnzGCo/J8ioErZh+NUVT31I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730830139;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gqF0ChO9YKD/rSMDl0KVbfCgfoW6JfqRSz0zayU3h20=;
 b=NWXwVgN43vWWgpLKH/YgYKN1BNvZp7CaPg/EiaDwmhZRaEFOQ4r5ogAhcLXQmNs+dqrTZB
 Gb8tJiW24GuTKADA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qjjyM+tM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NWXwVgN4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730830139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gqF0ChO9YKD/rSMDl0KVbfCgfoW6JfqRSz0zayU3h20=;
 b=qjjyM+tM+G84VX1HaYLlDG3RrgtWPpVXLc32P47Fhl1r6MFOiyR1rBN3ogWSdtwG+rtrB7
 epyM8Gwgcya6OIonFk1IUcriD7YiFebQHdZIYEe7t9mklWlVrTqVwHxtC8eKEehMh9z7Re
 plQbAPjdEnzGCo/J8ioErZh+NUVT31I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730830139;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gqF0ChO9YKD/rSMDl0KVbfCgfoW6JfqRSz0zayU3h20=;
 b=NWXwVgN43vWWgpLKH/YgYKN1BNvZp7CaPg/EiaDwmhZRaEFOQ4r5ogAhcLXQmNs+dqrTZB
 Gb8tJiW24GuTKADA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB3A41394A;
 Tue,  5 Nov 2024 18:08:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GM/SJzlfKmeCZwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Nov 2024 18:08:57 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 04/22] tests/migration: Disambiguate guestperf vs. a-b
Date: Tue,  5 Nov 2024 15:08:19 -0300
Message-Id: <20241105180837.5990-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241105180837.5990-1-farosas@suse.de>
References: <20241105180837.5990-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7F89421D3A
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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
 32 files changed, 6 insertions(+), 6 deletions(-)
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
index a40451df1e..61c8cf043f 100644
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


