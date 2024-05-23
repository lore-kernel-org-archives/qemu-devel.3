Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6275CC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 20:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAEud-0000dr-AI; Thu, 23 May 2024 16:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sAEuc-0000dZ-I7
 for qemu-devel@nongnu.org; Thu, 23 May 2024 16:19:42 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sAEua-0002HL-AB
 for qemu-devel@nongnu.org; Thu, 23 May 2024 16:19:42 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 239D022CA1;
 Thu, 23 May 2024 20:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716495578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9a+i01ypPUBXQqxb3ZkvWdnNpmAXA9MsaEaz7vDZC8k=;
 b=TdftmnAvWA3gTBxu9JPZByiNJAVPpmSECqFwyl+/WdzQeJxppL3HxDjPZ/W8SHXiVK53xA
 UYG8ERBqJdg/wvKSgUXlBNI2bAWHSPdS9sxYm/tF67U/KXxbq4ELrbdYUGykx9FYTWm6Zu
 2PGd5vmzULseVhrGLsNc8i4D4IbA6y0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716495578;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9a+i01ypPUBXQqxb3ZkvWdnNpmAXA9MsaEaz7vDZC8k=;
 b=U7GTMSPgYeEcHQI2QnWXLFL3E1PsA1bkN1fE4Er8UhpVZfiw8KbamLWBir/KIcVolRz/71
 MeGpm3nUHQwRdDDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716495578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9a+i01ypPUBXQqxb3ZkvWdnNpmAXA9MsaEaz7vDZC8k=;
 b=TdftmnAvWA3gTBxu9JPZByiNJAVPpmSECqFwyl+/WdzQeJxppL3HxDjPZ/W8SHXiVK53xA
 UYG8ERBqJdg/wvKSgUXlBNI2bAWHSPdS9sxYm/tF67U/KXxbq4ELrbdYUGykx9FYTWm6Zu
 2PGd5vmzULseVhrGLsNc8i4D4IbA6y0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716495578;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9a+i01ypPUBXQqxb3ZkvWdnNpmAXA9MsaEaz7vDZC8k=;
 b=U7GTMSPgYeEcHQI2QnWXLFL3E1PsA1bkN1fE4Er8UhpVZfiw8KbamLWBir/KIcVolRz/71
 MeGpm3nUHQwRdDDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6761A13A6C;
 Thu, 23 May 2024 20:19:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uHC8C9ekT2ZqcgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 May 2024 20:19:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fiona Ebner <f.ebner@proxmox.com>, Het Gala <het.gala@nutanix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [RFC PATCH 4/4] ci: Add the new migration device tests
Date: Thu, 23 May 2024 17:19:22 -0300
Message-Id: <20240523201922.28007-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240523201922.28007-1-farosas@suse.de>
References: <20240523201922.28007-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[10];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

We have two new migration tests that check cross version
compatibility. One uses the vmstate-static-checker.py script to
compare the vmstate structures from two different QEMU versions. The
other runs a simple migration with a few devices present in the VM, to
catch obvious breakages.

Add both tests to the migration-compat-common job.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 .gitlab-ci.d/buildtest.yml | 43 +++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 91c57efded..bc7ac35983 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -202,18 +202,47 @@ build-previous-qemu:
   needs:
     - job: build-previous-qemu
     - job: build-system-opensuse
-  # The old QEMU could have bugs unrelated to migration that are
-  # already fixed in the current development branch, so this test
-  # might fail.
+  # This test is allowed to fail because:
+  #
+  # - The old QEMU could have bugs unrelated to migration that are
+  #   already fixed in the current development branch.
+  #
+  # - The vmstate-static-checker script trips on renames and other
+  #   backward-compatible changes to the vmstate structs.
   allow_failure: true
   variables:
     IMAGE: opensuse-leap
     MAKE_CHECK_ARGS: check-build
   script:
-    # Use the migration-tests from the older QEMU tree. This avoids
-    # testing an old QEMU against new features/tests that it is not
-    # compatible with.
-    - cd build-previous
+    - cd build
+    # device state static test: Tests the vmstate structures for
+    # compatibility across QEMU versions. Uses the latest version of
+    # the tests.
+    # old to new
+    - PYTHON=pyvenv/bin/python3
+          QTEST_QEMU_BINARY_SRC=../build-previous/qemu-system-${TARGET}
+          QTEST_QEMU_BINARY=./qemu-system-${TARGET}
+          ./tests/qtest/migration-test -p /${TARGET}/migration/vmstate-checker-script
+    # new to old skipped because vmstate version bumps are always
+    # backward incompatible.
+
+    # device state runtime test: Performs a cross-version migration
+    # with a select list of devices (see DEFAULT_DEVICES in
+    # migration-test.c). Using the multifd tcp test here, but any will
+    # do.
+    # old to new
+    - QTEST_DEVICE_OPTS=all QTEST_QEMU_BINARY_SRC=../build-previous/qemu-system-${TARGET}
+          QTEST_QEMU_BINARY=./qemu-system-${TARGET} ./tests/qtest/migration-test
+          -p /${TARGET}/migration/multifd/tcp/channels/plain/none
+    # new to old
+    - QTEST_DEVICE_OPTS=all QTEST_QEMU_BINARY_DST=../build-previous/qemu-system-${TARGET}
+          QTEST_QEMU_BINARY=./qemu-system-${TARGET} ./tests/qtest/migration-test
+          -p /${TARGET}/migration/multifd/tcp/channels/plain/none
+
+    # migration core tests: Use the migration-tests from the older
+    # QEMU tree. This avoids testing an old QEMU against new
+    # features/tests that it is not compatible with.
+    - cd ../build-previous
     # old to new
     - QTEST_QEMU_BINARY_SRC=./qemu-system-${TARGET}
           QTEST_QEMU_BINARY=../build/qemu-system-${TARGET} ./tests/qtest/migration-test
-- 
2.35.3


