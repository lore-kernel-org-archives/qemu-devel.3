Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1132DD374A0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1RYB-0005PO-An; Thu, 17 Oct 2024 10:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1RY8-0005Ne-WD
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:32:25 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1RY6-0003sk-Ik
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:32:24 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 42C7721D2B;
 Thu, 17 Oct 2024 14:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729175540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pTjLE5k9ibYoIFALNcr3q01Oev4bQqTk9DaEMml1LA4=;
 b=rf1rpF9CJwali0QHACbx/4LwE5kNTBBdJ2aDXlGCN7PHkTUDFJC0hJgZCyrTgY3GKYI7/Q
 vZuUYg0QxQq9pCdfHdierZDClql+0jkovJ8ce8FJP/Z4mXYCYdmHWuOuEywLzywxLaAI1H
 9gPXwDoLCeq5O/7KuiwSNOjkPdZR0Ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729175540;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pTjLE5k9ibYoIFALNcr3q01Oev4bQqTk9DaEMml1LA4=;
 b=IzwIQ1jjFcgIIJMBWDA49gFu3Rspb3QhQbqu4XnlcpmKPmuAm6l9yPp/shjcPRGM/5MpYY
 tjd/l9Ia3+5tzwDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729175540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pTjLE5k9ibYoIFALNcr3q01Oev4bQqTk9DaEMml1LA4=;
 b=rf1rpF9CJwali0QHACbx/4LwE5kNTBBdJ2aDXlGCN7PHkTUDFJC0hJgZCyrTgY3GKYI7/Q
 vZuUYg0QxQq9pCdfHdierZDClql+0jkovJ8ce8FJP/Z4mXYCYdmHWuOuEywLzywxLaAI1H
 9gPXwDoLCeq5O/7KuiwSNOjkPdZR0Ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729175540;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pTjLE5k9ibYoIFALNcr3q01Oev4bQqTk9DaEMml1LA4=;
 b=IzwIQ1jjFcgIIJMBWDA49gFu3Rspb3QhQbqu4XnlcpmKPmuAm6l9yPp/shjcPRGM/5MpYY
 tjd/l9Ia3+5tzwDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18A4913A42;
 Thu, 17 Oct 2024 14:32:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kNzDM/IfEWcDKQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 17 Oct 2024 14:32:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 2/4] docs: Add migration tests documentation
Date: Thu, 17 Oct 2024 11:32:09 -0300
Message-Id: <20241017143211.17771-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241017143211.17771-1-farosas@suse.de>
References: <20241017143211.17771-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Add documentation about how to write, run and debug migration tests.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/devel/testing/index.rst     |   1 +
 docs/devel/testing/main.rst      |  13 ++
 docs/devel/testing/migration.rst | 275 +++++++++++++++++++++++++++++++
 docs/devel/testing/qtest.rst     |   1 +
 4 files changed, 290 insertions(+)
 create mode 100644 docs/devel/testing/migration.rst

diff --git a/docs/devel/testing/index.rst b/docs/devel/testing/index.rst
index 45eb4a7181..e46a33e9e8 100644
--- a/docs/devel/testing/index.rst
+++ b/docs/devel/testing/index.rst
@@ -9,6 +9,7 @@ testing infrastructure.
 
    main
    qtest
+   migration
    functional
    avocado
    acpi-bits
diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index 09725e8ea9..f238926300 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -96,6 +96,19 @@ QTest cases can be executed with
 
    make check-qtest
 
+Migration
+~~~~~~~~~
+
+Migration tests are part of QTest, but are run independently.  Refer
+to :doc:`migration` for more details.
+
+Migration test cases can be executed with
+
+.. code::
+
+   make check-migration
+   make check-migration-quick
+
 Writing portable test cases
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Both unit tests and qtests can run on POSIX hosts as well as Windows hosts.
diff --git a/docs/devel/testing/migration.rst b/docs/devel/testing/migration.rst
new file mode 100644
index 0000000000..e877a979bf
--- /dev/null
+++ b/docs/devel/testing/migration.rst
@@ -0,0 +1,275 @@
+.. _migration:
+
+Migration tests
+===============
+
+Migration tests are part of QTest, but have some particularities of
+their own, such as:
+
+- Extended test time due to the need to exercise the iterative phase
+  of migration;
+- Extra requirements on the QEMU binary being used due to
+  :ref:`cross-version migration <cross-version-tests>`;
+- The use of a custom binary for the guest code to test memory
+  integrity (see :ref:`guest-code`).
+
+Invocation
+----------
+
+Migration tests can be ran with:
+
+.. code::
+
+   make check-migration
+   make check-migration-quick
+
+or directly:
+
+.. code::
+
+   # all tests
+   QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test
+
+   # single test
+   QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test -p /x86_64/migration/bad_dest
+
+   # all tests under /multifd (note no trailing slash)
+   QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test -r /x86_64/migration/multifd
+
+for cross-version tests (see :ref:`cross-version-tests`):
+
+.. code::
+
+   # old QEMU -> new QEMU
+   QTEST_QEMU_BINARY=./qemu-system-x86_64 QTEST_QEMU_BINARY_SRC=./old/qemu-system-x86_64 ./tests/qtest/migration-test
+   QTEST_QEMU_BINARY_DST=./qemu-system-x86_64 QTEST_QEMU_BINARY=./old/qemu-system-x86_64 ./tests/qtest/migration-test
+
+   # new QEMU -> old QEMU (backwards migration)
+   QTEST_QEMU_BINARY_SRC=./qemu-system-x86_64 QTEST_QEMU_BINARY=./old/qemu-system-x86_64 ./tests/qtest/migration-test
+   QTEST_QEMU_BINARY=./qemu-system-x86_64 QTEST_QEMU_BINARY_DST=./old/qemu-system-x86_64 ./tests/qtest/migration-test
+
+   # both _SRC and _DST variants are supported for convenience
+
+.. _cross-version-tests:
+
+Cross-version tests
+~~~~~~~~~~~~~~~~~~~
+
+To detect compatibility issues between different QEMU versions, all
+tests from migration-test can be executed with two different QEMU
+versions. The common machine type between the two versions is used.
+
+To setup cross-version tests, a previous build of QEMU must be kept,
+e.g.:
+
+.. code::
+
+   # build current code
+   mkdir build
+   cd build
+   ../configure; make
+
+   # build previous version
+   cd ../
+   mkdir build-9.1
+   git checkout v9.1.0
+   cd build
+   ../configure; make
+
+To avoid issues with newly added features and new tests, it is highly
+recommended to run the tests from the source directory of *older*
+version being tested.
+
+.. code::
+
+   ./build/qemu-system-x86_64 --version
+   QEMU emulator version 9.1.50
+
+   ./build-9.1/qemu-system-x86_64 --version
+   QEMU emulator version 9.1.0
+
+   cd build-9.1
+   QTEST_QEMU_BINARY=./qemu-system-x86_64 QTEST_QEMU_BINARY_DST=../build/qemu-system-x86_64 ./tests/qtest/migration-test
+
+
+How to write migration tests
+----------------------------
+
+Add a test function (prefixed with ``test_``) that gets registered
+with QTest using the ``migration_test_add*()`` helpers.
+
+The choice between ``migration_test_add()`` and
+``migration_test_add_quick()`` affects whether a test is executed via
+``make check``. The former helper adds a test to the "slow" set, which
+only runs via ``make check-migration``, while the latter allows a test
+to run via ``make check`` or ``make check-migration-quick``.
+
+A new test should preferably not add too much time to ``make
+check``. In general, code that depends on external libraries or pieces
+outside of migration could be tested in the quick set as well as tests
+that are fast (e.g. only tests migration URL and exits). Code that is
+core to the migration framework or changes infrequently should be
+tested in the slow set as well as test that are considerably slower
+(e.g. run several migration iterations).
+
+.. code::
+
+  migration_test_add("/migration/multifd/tcp/plain/cancel", test_multifd_tcp_cancel);
+
+There is no formal grammar for the definition of the test paths, but
+an informal rule is followed for consistency. Usually:
+
+``/migration/<multifd|precopy|postcopy>/<url type>/<test-specific>/``
+
+Bear in mind that the path string affects test execution order and
+filtering when using the ``-r`` flag.
+
+For simpler tests, the test function can setup the test arguments in
+the ``MigrateCommon`` structure and call into a common test
+routine. Currently there are two common test routines:
+
+ - test_precopy_common - for generic precopy migration
+ - test_file_common - for migration using the file: URL
+
+The general structure of a test routine is:
+
+- call ``test_migrate_start()`` to initialize the two QEMU
+  instances. Usually named "from", for the source machine and "to" for
+  the destination machine;
+
+- define the migration duration, (roughly speaking either quick or
+  slow) by altering the convergence parameters with
+  ``migrate_ensure[_non]_converge()``;
+
+- wait for the machines to be in the desired state with the ``wait_for_*``
+  helpers;
+
+- migrate with ``migrate_qmp()/migrate_incoming_qmp()/migrate_qmp_fail()``;
+
+- check that guest memory was not corrupted and clean up the QEMU
+  instances with ``test_migrate_end()``.
+
+If using the common test routines, the ``.start_hook`` and ``.finish_hook``
+callbacks can be used to perform test-specific tasks.
+
+.. _guest-code:
+
+About guest code
+----------------
+
+The tests all use a custom, architecture-specific binary as the guest
+code. This code, known as a-b-kernel or a-b-bootblock, constantly
+iterates over the guest memory, writing a number to the start of each
+guest page, incrementing it as it loops around (i.e. a generation
+count). This allows the tests to catch memory corruption errors that
+occur during migration as every page's first byte must have the same
+value, except at the point where the transition happens.
+
+Whenever guest memory is migrated incorrectly, the test will output
+the address and amount of pages that present a value inconsistent with
+the generation count, e.g.:
+
+.. code::
+
+  Memory content inconsistency at d53000 first_byte = 27 last_byte = 26 current = 27 hit_edge = 1
+  Memory content inconsistency at d54000 first_byte = 27 last_byte = 26 current = 27 hit_edge = 1
+  Memory content inconsistency at d55000 first_byte = 27 last_byte = 26 current = 27 hit_edge = 1
+  and in another 4929 pages
+
+In the scenario above,
+
+``first_byte`` shows that the current generation number is 27, therefore
+all pages should have 27 as their first byte. Since ``hit_edge=1``, that
+means the transition point was found, i.e. the guest was stopped for
+migration while not all pages had yet been updated to the new
+generation count. So 26 is also a valid byte to find in some pages.
+
+The inconsistency here is that ``last_byte``, i.e. the previous
+generation count is smaller than the ``current`` byte, which should not
+be possible. This would indicate a memory layout such as:
+
+.. code::
+
+  0xb00000 | 27 00 00 ...
+  ...
+  0xc00000 | 27 00 00 ...
+  ...
+  0xd00000 | 27 00 00 ...
+  0x?????? | 26 00 00 ... <-- pages around this addr weren't migrated correctly
+  ...
+  0xd53000 | 27 00 00 ...
+  0xd54000 | 27 00 00 ...
+  0xd55000 | 27 00 00 ...
+  ...
+
+The a-b code is located at ``tests/migration/<arch>``.
+
+Troubleshooting
+---------------
+
+Migration tests usually run as part of make check, which is most
+likely to not have been using the verbose flag, so the first thing to
+check is the test log from meson (``meson-logs/testlog.txt``).
+
+There, look for the last "Running" entry, which will be the current
+test. Notice whether the failing program is one of the QEMU instances
+or the migration-test itself.
+
+E.g.:
+
+.. code::
+
+  # Running /s390x/migration/precopy/unix/plain
+  # Using machine type: s390-ccw-virtio-9.2
+  # starting QEMU: exec ./qemu-system-s390x -qtest ...
+  # starting QEMU: exec ./qemu-system-s390x -qtest ...
+  ----------------------------------- stderr -----------------------------------
+  migration-test: ../tests/qtest/migration-test.c:1712: test_precopy_common: Assertion `0' failed.
+
+  (test program exited with status code -6)
+
+.. code::
+
+  # Running /x86_64/migration/bad_dest
+  # Using machine type: pc-q35-9.2
+  # starting QEMU: exec ./qemu-system-x86_64 -qtest ...
+  # starting QEMU: exec ./qemu-system-x86_64 -qtest ...
+  ----------------------------------- stderr -----------------------------------
+  Broken pipe
+  ../tests/qtest/libqtest.c:205: kill_qemu() detected QEMU death from signal 6 (Aborted) (core dumped)
+
+  (test program exited with status code -6)
+
+The above is usually not enough to determine what happened, so
+re-running the test directly is helpful:
+
+.. code::
+
+   QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test -p /x86_64/migration/bad_dest
+
+There are also the QTEST_LOG and QTEST_TRACE variables for increased
+logging and tracing.
+
+The QTEST_QEMU_BINARY environment variable can be abused to hook GDB
+or valgrind into the invocation:
+
+.. code::
+
+   QTEST_QEMU_BINARY='gdb -q --ex "set pagination off" --ex "set print thread-events off" \
+   --ex "handle SIGUSR1 noprint" --ex "break <breakpoint>" --ex "run" --ex "quit \$_exitcode" \
+   --args ./qemu-system-x86_64' ./tests/qtest/migration-test -p /x86_64/migration/multifd/file/mapped-ram/fdset/dio
+
+.. code::
+
+   QTEST_QEMU_BINARY='valgrind -q --leak-check=full --show-leak-kinds=definite,indirect \
+   ./qemu-system-x86_64' ./tests/qtest/migration-test -r /x86_64/migration
+
+Whenever a test fails, it will leave behind a temporary
+directory. This is useful for file migrations to inspect the generated
+migration file:
+
+.. code::
+
+   $ file /tmp/migration-test-X496U2/migfile
+   /tmp/migration-test-X496U2/migfile: QEMU suspend to disk image
+   $ hexdump -C /tmp/migration-test-X496U2/migfile | less
diff --git a/docs/devel/testing/qtest.rst b/docs/devel/testing/qtest.rst
index c5b8546b3e..4665c160b6 100644
--- a/docs/devel/testing/qtest.rst
+++ b/docs/devel/testing/qtest.rst
@@ -5,6 +5,7 @@ QTest Device Emulation Testing Framework
 .. toctree::
 
    qgraph
+   migration
 
 QTest is a device emulation testing framework.  It can be very useful to test
 device models; it could also control certain aspects of QEMU (such as virtual
-- 
2.35.3


