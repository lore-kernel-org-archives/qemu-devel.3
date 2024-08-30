Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 663C6CA0FF1
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 13:44:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk1tT-0007AS-Ns; Fri, 30 Aug 2024 09:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk1tF-0006D4-Qo
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:42:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk1tA-0005h9-PM
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725025327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GYfy8Nn2T/dx9u5gtuYchnP2ogVj6dzCQA8Fj00g+X4=;
 b=CweBMQNBoiXnHEcbfH1LU0dmMoOiBVNdOYrMRTlvPRqmZgbvkbJMurNDMwkbJxkUlJjdQ+
 vddnZC5yoNIknVqmOQsRqhd2ZSpi+eW0FCKHAUaoU8+EYo8KlcKfXVqHN1w2onbqTpPl2O
 zbQPOW1hlHWnbKX+pjr2SgSbUcsviz4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-pmC-BO1mPX66gLs99LhtGQ-1; Fri,
 30 Aug 2024 09:42:04 -0400
X-MC-Unique: pmC-BO1mPX66gLs99LhtGQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4796E1954B1C; Fri, 30 Aug 2024 13:42:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B36FA300019C; Fri, 30 Aug 2024 13:41:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v5 44/44] docs/devel/testing: Add documentation for functional
 tests
Date: Fri, 30 Aug 2024 15:38:38 +0200
Message-ID: <20240830133841.142644-45-thuth@redhat.com>
In-Reply-To: <20240830133841.142644-1-thuth@redhat.com>
References: <20240830133841.142644-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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

Document the new functional testing framework. The text is originally
based on the Avocado documentation, but heavily modified to match the
new framework.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/testing/functional.rst | 338 ++++++++++++++++++++++++++++++
 docs/devel/testing/index.rst      |   1 +
 docs/devel/testing/main.rst       |  12 ++
 3 files changed, 351 insertions(+)
 create mode 100644 docs/devel/testing/functional.rst

diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
new file mode 100644
index 0000000000..bf6f1bb81e
--- /dev/null
+++ b/docs/devel/testing/functional.rst
@@ -0,0 +1,338 @@
+.. _checkfunctional-ref:
+
+Functional testing with Python
+==============================
+
+The ``tests/functional`` directory hosts functional tests written in
+Python. They are usually higher level tests, and may interact with
+external resources and with various guest operating systems.
+The functional tests have initially evolved from the Avocado tests, so there
+is a lot of similarity to those tests here (see :ref:`checkavocado-ref` for
+details about the Avocado tests).
+
+The tests should be written in the style of the Python `unittest`_ framework,
+using stdio for the TAP protocol. The folder ``tests/functional/qemu_test``
+provides classes (e.g. the ``QemuBaseTest``, ``QemuUserTest`` and the
+``QemuSystemTest`` classes) and utility functions that help to get your test
+into the right shape, e.g. by replacing the 'stdout' python object to redirect
+the normal output of your test to stderr instead.
+
+Note that if you don't use one of the QemuBaseTest based classes for your
+test, or if you spawn subprocesses from your test, you have to make sure
+that there is no TAP-incompatible output written to stdio, e.g. either by
+prefixing every line with a "# " to mark the output as a TAP comment, or
+e.g. by capturing the stdout output of subprocesses (redirecting it to
+stderr is OK).
+
+Tests based on ``qemu_test.QemuSystemTest`` can easily:
+
+ * Customize the command line arguments given to the convenience
+   ``self.vm`` attribute (a QEMUMachine instance)
+
+ * Interact with the QEMU monitor, send QMP commands and check
+   their results
+
+ * Interact with the guest OS, using the convenience console device
+   (which may be useful to assert the effectiveness and correctness of
+   command line arguments or QMP commands)
+
+ * Download (and cache) remote data files, such as firmware and kernel
+   images
+
+Running tests
+-------------
+
+You can run the functional tests simply by executing:
+
+.. code::
+
+  make check-functional
+
+It is also possible to run tests for a certain target only, for example
+the following line will only run the tests for the x86_64 target:
+
+.. code::
+
+  make check-functional-x86_64
+
+To run a single test file without the meson test runner, you can also
+execute the file directly by specifying two environment variables first,
+the PYTHONPATH that has to include the python folder and the tests/functional
+folder of the source tree, and QEMU_TEST_QEMU_BINARY that has to point
+to the QEMU binary that should be used for the test, for example::
+
+  $ export PYTHONPATH=../python:../tests/functional
+  $ export QEMU_TEST_QEMU_BINARY=$PWD/qemu-system-x86_64
+  $ python3 ../tests/functional/test_file.py
+
+Overview
+--------
+
+The ``tests/functional/qemu_test`` directory provides the ``qemu_test``
+Python module, containing the ``qemu_test.QemuSystemTest`` class.
+Here is a simple usage example:
+
+.. code::
+
+  #!/usr/bin/env python3
+
+  from qemu_test import QemuSystemTest
+
+  class Version(QemuSystemTest):
+
+      def test_qmp_human_info_version(self):
+          self.vm.launch()
+          res = self.vm.cmd('human-monitor-command',
+                            command_line='info version')
+          self.assertRegex(res, r'^(\d+\.\d+\.\d)')
+
+  if __name__ == '__main__':
+      QemuSystemTest.main()
+
+By providing the "hash bang" line at the beginning of the script, marking
+the file as executable and by calling into QemuSystemTest.main(), the test
+can also be run stand-alone, without a test runner. OTOH when run via a test
+runner, the QemuSystemTest.main() function takes care of running the test
+functions in the right fassion (e.g. with TAP output that is required by the
+meson test runner).
+
+The ``qemu_test.QemuSystemTest`` base test class
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The ``qemu_test.QemuSystemTest`` class has a number of characteristics
+that are worth being mentioned.
+
+First of all, it attempts to give each test a ready to use QEMUMachine
+instance, available at ``self.vm``.  Because many tests will tweak the
+QEMU command line, launching the QEMUMachine (by using ``self.vm.launch()``)
+is left to the test writer.
+
+The base test class has also support for tests with more than one
+QEMUMachine. The way to get machines is through the ``self.get_vm()``
+method which will return a QEMUMachine instance. The ``self.get_vm()``
+method accepts arguments that will be passed to the QEMUMachine creation
+and also an optional ``name`` attribute so you can identify a specific
+machine and get it more than once through the tests methods. A simple
+and hypothetical example follows:
+
+.. code::
+
+  from qemu_test import QemuSystemTest
+
+  class MultipleMachines(QemuSystemTest):
+      def test_multiple_machines(self):
+          first_machine = self.get_vm()
+          second_machine = self.get_vm()
+          self.get_vm(name='third_machine').launch()
+
+          first_machine.launch()
+          second_machine.launch()
+
+          first_res = first_machine.cmd(
+              'human-monitor-command',
+              command_line='info version')
+
+          second_res = second_machine.cmd(
+              'human-monitor-command',
+              command_line='info version')
+
+          third_res = self.get_vm(name='third_machine').cmd(
+              'human-monitor-command',
+              command_line='info version')
+
+          self.assertEqual(first_res, second_res, third_res)
+
+At test "tear down", ``qemu_test.QemuSystemTest`` handles all the QEMUMachines
+shutdown.
+
+QEMUMachine
+-----------
+
+The QEMUMachine API is already widely used in the Python iotests,
+device-crash-test and other Python scripts.  It's a wrapper around the
+execution of a QEMU binary, giving its users:
+
+ * the ability to set command line arguments to be given to the QEMU
+   binary
+
+ * a ready to use QMP connection and interface, which can be used to
+   send commands and inspect its results, as well as asynchronous
+   events
+
+ * convenience methods to set commonly used command line arguments in
+   a more succinct and intuitive way
+
+QEMU binary selection
+^^^^^^^^^^^^^^^^^^^^^
+
+The QEMU binary used for the ``self.vm`` QEMUMachine instance will
+primarily depend on the value of the ``qemu_bin`` class attribute.
+If it is not explicitly set by the test code, its default value will
+be the result the QEMU_TEST_QEMU_BINARY environment variable.
+
+Attribute reference
+-------------------
+
+QemuBaseTest
+^^^^^^^^^^^^
+
+The following attributes are available on any ``qemu_test.QemuBaseTest``
+instance.
+
+arch
+""""
+
+The target architecture of the QEMU binary.
+
+Tests are also free to use this attribute value, for their own needs.
+A test may, for instance, use this value when selecting the architecture
+of a kernel or disk image to boot a VM with.
+
+qemu_bin
+""""""""
+
+The preserved value of the ``QEMU_TEST_QEMU_BINARY`` environment
+variable.
+
+QemuUserTest
+^^^^^^^^^^^^
+
+The QemuUserTest class can be used for running an executable via the
+usermode emulation binaries.
+
+QemuSystemTest
+^^^^^^^^^^^^^^
+
+The QemuSystemTest class can be used for running tests via one of the
+qemu-system-* binaries.
+
+vm
+""
+
+A QEMUMachine instance, initially configured according to the given
+``qemu_bin`` parameter.
+
+cpu
+"""
+
+The cpu model that will be set to all QEMUMachine instances created
+by the test.
+
+machine
+"""""""
+
+The machine type that will be set to all QEMUMachine instances created
+by the test. By using the set_machine() function of the QemuSystemTest
+class to set this attribute, you can automatically check whether the
+machine is available to skip the test in case it is not built into the
+QEMU binary.
+
+Asset handling
+--------------
+
+Many functional tests download assets (e.g. Linux kernels, initrds,
+firmware images, etc.) from the internet to be able to run tests with
+them. This imposes additional challenges to the test framework.
+
+First there is the the problem that some people might not have an
+unconstrained internet connection, so such tests should not be run by
+default when running ``make check``. To accomplish this situation,
+the tests that download files should only be added to the "thorough"
+speed mode in the meson.build file, while the "quick" speed mode is
+fine for functional tests that can be run without downloading files.
+``make check`` then only runs the quick functional tests along with
+the other quick tests from the other test suites. If you choose to
+run only run ``make check-functional``, the "thorough" tests will be
+executed, too. And to run all functional tests along with the others,
+you can use something like::
+
+  make -j$(nproc) check SPEED=thorough
+
+The second problem with downloading files from the internet are time
+constraints. The time for downloading files should not be taken into
+account when the test is running and the timeout of the test is ticking
+(since downloading can be very slow, depending on the network bandwidth).
+This problem is solved by downloading the assets ahead of time, before
+the tests are run. This pre-caching is done with the qemu_test.Asset
+class. To use it in your test, declare an asset in your test class with
+its URL and SHA256 checksum like this::
+
+    ASSET_somename = (
+        ('https://www.qemu.org/assets/images/qemu_head_200.png'),
+        '34b74cad46ea28a2966c1d04e102510daf1fd73e6582b6b74523940d5da029dd')
+
+In your test function, you can then get the file name of the cached
+asset like this::
+
+    def test_function(self):
+        file_path = self.ASSET_somename.fetch()
+
+The pre-caching will be done automatically when running
+``make check-functional`` (but not when running e.g.
+``make check-functional-<target>``). In case you just want to download
+the assets without running the tests, you can do so by running::
+
+    make precache-functional
+
+The cache is populated in the ``~/.cache/qemu/download`` directory by
+default, but the location can be changed by setting the
+``QEMU_TEST_CACHE_DIR`` environment variable.
+
+Skipping tests
+--------------
+
+Since the test framework is based on the common Python unittest framework,
+you can use the usual Python decorators which allow for easily skipping
+tests running under certain conditions, for example, on the lack of a binary
+on the test system or when the running environment is a CI system. For further
+information about those decorators, please refer to:
+
+  https://docs.python.org/3/library/unittest.html#skipping-tests-and-expected-failures
+
+While the conditions for skipping tests are often specifics of each one, there
+are recurring scenarios identified by the QEMU developers and the use of
+environment variables became a kind of standard way to enable/disable tests.
+
+Here is a list of the most used variables:
+
+QEMU_TEST_ALLOW_LARGE_STORAGE
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+Tests which are going to fetch or produce assets considered *large* are not
+going to run unless that ``QEMU_TEST_ALLOW_LARGE_STORAGE=1`` is exported on
+the environment.
+
+The definition of *large* is a bit arbitrary here, but it usually means an
+asset which occupies at least 1GB of size on disk when uncompressed.
+
+QEMU_TEST_ALLOW_UNTRUSTED_CODE
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+There are tests which will boot a kernel image or firmware that can be
+considered not safe to run on the developer's workstation, thus they are
+skipped by default. The definition of *not safe* is also arbitrary but
+usually it means a blob which either its source or build process aren't
+public available.
+
+You should export ``QEMU_TEST_ALLOW_UNTRUSTED_CODE=1`` on the environment in
+order to allow tests which make use of those kind of assets.
+
+QEMU_TEST_FLAKY_TESTS
+^^^^^^^^^^^^^^^^^^^^^
+Some tests are not working reliably and thus are disabled by default.
+This includes tests that don't run reliably on GitLab's CI which
+usually expose real issues that are rarely seen on developer machines
+due to the constraints of the CI environment. If you encounter a
+similar situation then raise a bug and then mark the test as shown on
+the code snippet below:
+
+.. code::
+
+  # See https://gitlab.com/qemu-project/qemu/-/issues/nnnn
+  @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
+  def test(self):
+      do_something()
+
+Tests should not live in this state forever and should either be fixed
+or eventually removed.
+
+
+.. _unittest: https://docs.python.org/3/library/unittest.html
diff --git a/docs/devel/testing/index.rst b/docs/devel/testing/index.rst
index cdf7ba1f8b..45eb4a7181 100644
--- a/docs/devel/testing/index.rst
+++ b/docs/devel/testing/index.rst
@@ -9,6 +9,7 @@ testing infrastructure.
 
    main
    qtest
+   functional
    avocado
    acpi-bits
    ci
diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index 39b965ecf6..e9921a4b10 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -862,6 +862,18 @@ supported. To start the fuzzer, run
 Alternatively, some command different from ``qemu-img info`` can be tested, by
 changing the ``-c`` option.
 
+Functional tests using Python
+-----------------------------
+
+The ``tests/functional`` directory hosts functional tests written in
+Python. You can run the functional tests simply by executing:
+
+.. code::
+
+  make check-functional
+
+See :ref:`checkfunctional-ref` for more details.
+
 Integration tests using the Avocado Framework
 ---------------------------------------------
 
-- 
2.46.0


