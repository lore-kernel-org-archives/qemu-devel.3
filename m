Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7678FC52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 08:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sggjs-0001cq-3G; Wed, 21 Aug 2024 04:30:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sggjY-0007sU-Ez
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 04:30:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sggjU-0004ph-JX
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 04:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724229012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3LK5iVyQLZ+D9qJ7E7+RWtXHuaT266mgr8TFlU5FsmY=;
 b=XNL7K5VeN4b1YD4/q/mHcXeVU0G4nA8IOjer0moEFqTFX9+jthhTt7gfaJEb64M41ZRLn0
 dOFAXWp6LGub9moP4t/riYjPPrlhDrW0OjvXDAptNQP0GoZTA6VXl5zoUncQJyNz5AfPXz
 RSUVYP+Gri9wLYDO/ogbwItbZZ5QvQc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-bVIn7ssPPPq4TvyZjVvUMg-1; Wed,
 21 Aug 2024 04:30:09 -0400
X-MC-Unique: bVIn7ssPPPq4TvyZjVvUMg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCA991955F43; Wed, 21 Aug 2024 08:30:07 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-191.str.redhat.com
 [10.33.192.191])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 010831955F1B; Wed, 21 Aug 2024 08:30:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 35/35] docs/devel/testing: Add documentation for functional
 tests
Date: Wed, 21 Aug 2024 10:27:36 +0200
Message-ID: <20240821082748.65853-36-thuth@redhat.com>
In-Reply-To: <20240821082748.65853-1-thuth@redhat.com>
References: <20240821082748.65853-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_QUOTING=0.001 autolearn=no autolearn_force=no
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
 docs/devel/testing/functional.rst | 269 ++++++++++++++++++++++++++++++
 docs/devel/testing/index.rst      |   1 +
 docs/devel/testing/main.rst       |  12 ++
 3 files changed, 282 insertions(+)
 create mode 100644 docs/devel/testing/functional.rst

diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
new file mode 100644
index 0000000000..c1f4bbf224
--- /dev/null
+++ b/docs/devel/testing/functional.rst
@@ -0,0 +1,269 @@
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
+The tests should be written in the style of the Python `unittest`_
+framework, using stdio for the TAP protocol. The folder
+``tests/functional/qemu_test`` provides classes (e.g. the ``QemuBaseTest``
+and the ``QemuSystemTest`` classes) and utility functions that help
+to get your test into the right shape.
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
+By providing the "hash bang" line at the beginning of the script,
+and by calling into QemuSystemTest.main() when it is run directly,
+the test framework makes sure to run all test_*() functions in the
+right fassion (e.g. with TAP output that is required by the meson test
+runner).
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
+QemuSystemTest
+^^^^^^^^^^^^^^
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
+Skipping tests
+--------------
+
+Since the test framework is based on the common Python unittest framework,
+you can use the usual Python decorators which allow for easily skipping
+tests running under certain conditions, for example, on the lack of a binary
+on the test system or when the running environment is a CI system. For further
+information about those decorators, please refer to::
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


