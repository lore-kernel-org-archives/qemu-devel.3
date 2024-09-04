Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A66CD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slnSK-0002aK-K1; Wed, 04 Sep 2024 06:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnS1-0001Jz-5s
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:41:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnRw-0000X3-Dl
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725446479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6EClQSa5oD9S5lnZoi1Yswpkvvly9oI0W4k7+iXtqYs=;
 b=eA7ztMGIygsdJuJvrnoBhflJMG0v0Okk7QsYaBm+yKDoiaSU5x5OX2JqdyfaqrcPYfMARz
 fk9nQh3RzDbOnNiRpWHV/NiLzbIeFbycerZeLVN7oyfXkhvGsJpg/dnijKBjxv9dQNK+Dm
 3JTI3+N0moo5t2AFoLzKMB1YpGeh4Rk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-DAlG1Z3SOFGbrdz9Xd59CA-1; Wed,
 04 Sep 2024 06:41:16 -0400
X-MC-Unique: DAlG1Z3SOFGbrdz9Xd59CA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CD3719560A3; Wed,  4 Sep 2024 10:41:15 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.48])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C3B071955D42; Wed,  4 Sep 2024 10:41:13 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 40/42] docs/devel/testing: Split the Avocado documentation into
 a separate file
Date: Wed,  4 Sep 2024 12:39:15 +0200
Message-ID: <20240904103923.451847-41-thuth@redhat.com>
In-Reply-To: <20240904103923.451847-1-thuth@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The main testing documentation file got very overloaded already.
Thus let's split the Avocado information into a separate file.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240830133841.142644-43-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/devel/testing/avocado.rst | 581 +++++++++++++++++++++++++++++++++
 docs/devel/testing/index.rst   |   1 +
 docs/devel/testing/main.rst    | 565 +-------------------------------
 3 files changed, 583 insertions(+), 564 deletions(-)
 create mode 100644 docs/devel/testing/avocado.rst

diff --git a/docs/devel/testing/avocado.rst b/docs/devel/testing/avocado.rst
new file mode 100644
index 0000000000..0d207a05c5
--- /dev/null
+++ b/docs/devel/testing/avocado.rst
@@ -0,0 +1,581 @@
+.. _checkavocado-ref:
+
+
+Integration testing with Avocado
+================================
+
+The ``tests/avocado`` directory hosts integration tests. They're usually
+higher level tests, and may interact with external resources and with
+various guest operating systems.
+
+These tests are written using the Avocado Testing Framework (which must
+be installed separately) in conjunction with a the ``avocado_qemu.Test``
+class, implemented at ``tests/avocado/avocado_qemu``.
+
+Tests based on ``avocado_qemu.Test`` can easily:
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
+ * Interact with external data files that accompany the test itself
+   (see ``self.get_data()``)
+
+ * Download (and cache) remote data files, such as firmware and kernel
+   images
+
+ * Have access to a library of guest OS images (by means of the
+   ``avocado.utils.vmimage`` library)
+
+ * Make use of various other test related utilities available at the
+   test class itself and at the utility library:
+
+   - http://avocado-framework.readthedocs.io/en/latest/api/test/avocado.html#avocado.Test
+   - http://avocado-framework.readthedocs.io/en/latest/api/utils/avocado.utils.html
+
+Running tests
+-------------
+
+You can run the avocado tests simply by executing:
+
+.. code::
+
+  make check-avocado
+
+This involves the automatic installation, from PyPI, of all the
+necessary avocado-framework dependencies into the QEMU venv within the
+build tree (at ``./pyvenv``). Test results are also saved within the
+build tree (at ``tests/results``).
+
+Note: the build environment must be using a Python 3 stack, and have
+the ``venv`` and ``pip`` packages installed.  If necessary, make sure
+``configure`` is called with ``--python=`` and that those modules are
+available.  On Debian and Ubuntu based systems, depending on the
+specific version, they may be on packages named ``python3-venv`` and
+``python3-pip``.
+
+It is also possible to run tests based on tags using the
+``make check-avocado`` command and the ``AVOCADO_TAGS`` environment
+variable:
+
+.. code::
+
+   make check-avocado AVOCADO_TAGS=quick
+
+Note that tags separated with commas have an AND behavior, while tags
+separated by spaces have an OR behavior. For more information on Avocado
+tags, see:
+
+ https://avocado-framework.readthedocs.io/en/latest/guides/user/chapters/tags.html
+
+To run a single test file, a couple of them, or a test within a file
+using the ``make check-avocado`` command, set the ``AVOCADO_TESTS``
+environment variable with the test files or test names. To run all
+tests from a single file, use:
+
+ .. code::
+
+  make check-avocado AVOCADO_TESTS=$FILEPATH
+
+The same is valid to run tests from multiple test files:
+
+ .. code::
+
+  make check-avocado AVOCADO_TESTS='$FILEPATH1 $FILEPATH2'
+
+To run a single test within a file, use:
+
+ .. code::
+
+  make check-avocado AVOCADO_TESTS=$FILEPATH:$TESTCLASS.$TESTNAME
+
+The same is valid to run single tests from multiple test files:
+
+ .. code::
+
+  make check-avocado AVOCADO_TESTS='$FILEPATH1:$TESTCLASS1.$TESTNAME1 $FILEPATH2:$TESTCLASS2.$TESTNAME2'
+
+The scripts installed inside the virtual environment may be used
+without an "activation".  For instance, the Avocado test runner
+may be invoked by running:
+
+ .. code::
+
+  pyvenv/bin/avocado run $OPTION1 $OPTION2 tests/avocado/
+
+Note that if ``make check-avocado`` was not executed before, it is
+possible to create the Python virtual environment with the dependencies
+needed running:
+
+ .. code::
+
+  make check-venv
+
+It is also possible to run tests from a single file or a single test within
+a test file. To run tests from a single file within the build tree, use:
+
+ .. code::
+
+  pyvenv/bin/avocado run tests/avocado/$TESTFILE
+
+To run a single test within a test file, use:
+
+ .. code::
+
+  pyvenv/bin/avocado run tests/avocado/$TESTFILE:$TESTCLASS.$TESTNAME
+
+Valid test names are visible in the output from any previous execution
+of Avocado or ``make check-avocado``, and can also be queried using:
+
+ .. code::
+
+  pyvenv/bin/avocado list tests/avocado
+
+Manual Installation
+-------------------
+
+To manually install Avocado and its dependencies, run:
+
+.. code::
+
+  pip install --user avocado-framework
+
+Alternatively, follow the instructions on this link:
+
+  https://avocado-framework.readthedocs.io/en/latest/guides/user/chapters/installing.html
+
+Overview
+--------
+
+The ``tests/avocado/avocado_qemu`` directory provides the
+``avocado_qemu`` Python module, containing the ``avocado_qemu.Test``
+class.  Here's a simple usage example:
+
+.. code::
+
+  from avocado_qemu import QemuSystemTest
+
+
+  class Version(QemuSystemTest):
+      """
+      :avocado: tags=quick
+      """
+      def test_qmp_human_info_version(self):
+          self.vm.launch()
+          res = self.vm.cmd('human-monitor-command',
+                            command_line='info version')
+          self.assertRegex(res, r'^(\d+\.\d+\.\d)')
+
+To execute your test, run:
+
+.. code::
+
+  avocado run version.py
+
+Tests may be classified according to a convention by using docstring
+directives such as ``:avocado: tags=TAG1,TAG2``.  To run all tests
+in the current directory, tagged as "quick", run:
+
+.. code::
+
+  avocado run -t quick .
+
+The ``avocado_qemu.Test`` base test class
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The ``avocado_qemu.Test`` class has a number of characteristics that
+are worth being mentioned right away.
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
+  from avocado_qemu import QemuSystemTest
+
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
+At test "tear down", ``avocado_qemu.Test`` handles all the QEMUMachines
+shutdown.
+
+The ``avocado_qemu.LinuxTest`` base test class
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The ``avocado_qemu.LinuxTest`` is further specialization of the
+``avocado_qemu.Test`` class, so it contains all the characteristics of
+the later plus some extra features.
+
+First of all, this base class is intended for tests that need to
+interact with a fully booted and operational Linux guest.  At this
+time, it uses a Fedora 31 guest image.  The most basic example looks
+like this:
+
+.. code::
+
+  from avocado_qemu import LinuxTest
+
+
+  class SomeTest(LinuxTest):
+
+      def test(self):
+          self.launch_and_wait()
+          self.ssh_command('some_command_to_be_run_in_the_guest')
+
+Please refer to tests that use ``avocado_qemu.LinuxTest`` under
+``tests/avocado`` for more examples.
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
+primarily depend on the value of the ``qemu_bin`` parameter.  If it's
+not explicitly set, its default value will be the result of a dynamic
+probe in the same source tree.  A suitable binary will be one that
+targets the architecture matching host machine.
+
+Based on this description, test writers will usually rely on one of
+the following approaches:
+
+1) Set ``qemu_bin``, and use the given binary
+
+2) Do not set ``qemu_bin``, and use a QEMU binary named like
+   "qemu-system-${arch}", either in the current
+   working directory, or in the current source tree.
+
+The resulting ``qemu_bin`` value will be preserved in the
+``avocado_qemu.Test`` as an attribute with the same name.
+
+Attribute reference
+-------------------
+
+Test
+^^^^
+
+Besides the attributes and methods that are part of the base
+``avocado.Test`` class, the following attributes are available on any
+``avocado_qemu.Test`` instance.
+
+vm
+""
+
+A QEMUMachine instance, initially configured according to the given
+``qemu_bin`` parameter.
+
+arch
+""""
+
+The architecture can be used on different levels of the stack, e.g. by
+the framework or by the test itself.  At the framework level, it will
+currently influence the selection of a QEMU binary (when one is not
+explicitly given).
+
+Tests are also free to use this attribute value, for their own needs.
+A test may, for instance, use the same value when selecting the
+architecture of a kernel or disk image to boot a VM with.
+
+The ``arch`` attribute will be set to the test parameter of the same
+name.  If one is not given explicitly, it will either be set to
+``None``, or, if the test is tagged with one (and only one)
+``:avocado: tags=arch:VALUE`` tag, it will be set to ``VALUE``.
+
+cpu
+"""
+
+The cpu model that will be set to all QEMUMachine instances created
+by the test.
+
+The ``cpu`` attribute will be set to the test parameter of the same
+name. If one is not given explicitly, it will either be set to
+``None ``, or, if the test is tagged with one (and only one)
+``:avocado: tags=cpu:VALUE`` tag, it will be set to ``VALUE``.
+
+machine
+"""""""
+
+The machine type that will be set to all QEMUMachine instances created
+by the test.
+
+The ``machine`` attribute will be set to the test parameter of the same
+name.  If one is not given explicitly, it will either be set to
+``None``, or, if the test is tagged with one (and only one)
+``:avocado: tags=machine:VALUE`` tag, it will be set to ``VALUE``.
+
+qemu_bin
+""""""""
+
+The preserved value of the ``qemu_bin`` parameter or the result of the
+dynamic probe for a QEMU binary in the current working directory or
+source tree.
+
+LinuxTest
+^^^^^^^^^
+
+Besides the attributes present on the ``avocado_qemu.Test`` base
+class, the ``avocado_qemu.LinuxTest`` adds the following attributes:
+
+distro
+""""""
+
+The name of the Linux distribution used as the guest image for the
+test.  The name should match the **Provider** column on the list
+of images supported by the avocado.utils.vmimage library:
+
+https://avocado-framework.readthedocs.io/en/latest/guides/writer/libs/vmimage.html#supported-images
+
+distro_version
+""""""""""""""
+
+The version of the Linux distribution as the guest image for the
+test.  The name should match the **Version** column on the list
+of images supported by the avocado.utils.vmimage library:
+
+https://avocado-framework.readthedocs.io/en/latest/guides/writer/libs/vmimage.html#supported-images
+
+distro_checksum
+"""""""""""""""
+
+The sha256 hash of the guest image file used for the test.
+
+If this value is not set in the code or by a test parameter (with the
+same name), no validation on the integrity of the image will be
+performed.
+
+Parameter reference
+-------------------
+
+To understand how Avocado parameters are accessed by tests, and how
+they can be passed to tests, please refer to::
+
+  https://avocado-framework.readthedocs.io/en/latest/guides/writer/chapters/writing.html#accessing-test-parameters
+
+Parameter values can be easily seen in the log files, and will look
+like the following:
+
+.. code::
+
+  PARAMS (key=qemu_bin, path=*, default=./qemu-system-x86_64) => './qemu-system-x86_64
+
+Test
+^^^^
+
+arch
+""""
+
+The architecture that will influence the selection of a QEMU binary
+(when one is not explicitly given).
+
+Tests are also free to use this parameter value, for their own needs.
+A test may, for instance, use the same value when selecting the
+architecture of a kernel or disk image to boot a VM with.
+
+This parameter has a direct relation with the ``arch`` attribute.  If
+not given, it will default to None.
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
+by the test.
+
+qemu_bin
+""""""""
+
+The exact QEMU binary to be used on QEMUMachine.
+
+LinuxTest
+^^^^^^^^^
+
+Besides the parameters present on the ``avocado_qemu.Test`` base
+class, the ``avocado_qemu.LinuxTest`` adds the following parameters:
+
+distro
+""""""
+
+The name of the Linux distribution used as the guest image for the
+test.  The name should match the **Provider** column on the list
+of images supported by the avocado.utils.vmimage library:
+
+https://avocado-framework.readthedocs.io/en/latest/guides/writer/libs/vmimage.html#supported-images
+
+distro_version
+""""""""""""""
+
+The version of the Linux distribution as the guest image for the
+test.  The name should match the **Version** column on the list
+of images supported by the avocado.utils.vmimage library:
+
+https://avocado-framework.readthedocs.io/en/latest/guides/writer/libs/vmimage.html#supported-images
+
+distro_checksum
+"""""""""""""""
+
+The sha256 hash of the guest image file used for the test.
+
+If this value is not set in the code or by this parameter no
+validation on the integrity of the image will be performed.
+
+Skipping tests
+--------------
+
+The Avocado framework provides Python decorators which allow for easily skip
+tests running under certain conditions. For example, on the lack of a binary
+on the test system or when the running environment is a CI system. For further
+information about those decorators, please refer to::
+
+  https://avocado-framework.readthedocs.io/en/latest/guides/writer/chapters/writing.html#skipping-tests
+
+While the conditions for skipping tests are often specifics of each one, there
+are recurring scenarios identified by the QEMU developers and the use of
+environment variables became a kind of standard way to enable/disable tests.
+
+Here is a list of the most used variables:
+
+AVOCADO_ALLOW_LARGE_STORAGE
+^^^^^^^^^^^^^^^^^^^^^^^^^^^
+Tests which are going to fetch or produce assets considered *large* are not
+going to run unless that ``AVOCADO_ALLOW_LARGE_STORAGE=1`` is exported on
+the environment.
+
+The definition of *large* is a bit arbitrary here, but it usually means an
+asset which occupies at least 1GB of size on disk when uncompressed.
+
+SPEED
+^^^^^
+Tests which have a long runtime will not be run unless ``SPEED=slow`` is
+exported on the environment.
+
+The definition of *long* is a bit arbitrary here, and it depends on the
+usefulness of the test too. A unique test is worth spending more time on,
+small variations on existing tests perhaps less so. As a rough guide,
+a test or set of similar tests which take more than 100 seconds to
+complete.
+
+AVOCADO_ALLOW_UNTRUSTED_CODE
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+There are tests which will boot a kernel image or firmware that can be
+considered not safe to run on the developer's workstation, thus they are
+skipped by default. The definition of *not safe* is also arbitrary but
+usually it means a blob which either its source or build process aren't
+public available.
+
+You should export ``AVOCADO_ALLOW_UNTRUSTED_CODE=1`` on the environment in
+order to allow tests which make use of those kind of assets.
+
+AVOCADO_TIMEOUT_EXPECTED
+^^^^^^^^^^^^^^^^^^^^^^^^
+The Avocado framework has a timeout mechanism which interrupts tests to avoid the
+test suite of getting stuck. The timeout value can be set via test parameter or
+property defined in the test class, for further details::
+
+  https://avocado-framework.readthedocs.io/en/latest/guides/writer/chapters/writing.html#setting-a-test-timeout
+
+Even though the timeout can be set by the test developer, there are some tests
+that may not have a well-defined limit of time to finish under certain
+conditions. For example, tests that take longer to execute when QEMU is
+compiled with debug flags. Therefore, the ``AVOCADO_TIMEOUT_EXPECTED`` variable
+has been used to determine whether those tests should run or not.
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
+You can also add ``:avocado: tags=flaky`` to the test meta-data so
+only the flaky tests can be run as a group:
+
+.. code::
+
+   env QEMU_TEST_FLAKY_TESTS=1 ./pyvenv/bin/avocado \
+      run tests/avocado -filter-by-tags=flaky
+
+Tests should not live in this state forever and should either be fixed
+or eventually removed.
+
+
+Uninstalling Avocado
+--------------------
+
+If you've followed the manual installation instructions above, you can
+easily uninstall Avocado.  Start by listing the packages you have
+installed::
+
+  pip list --user
+
+And remove any package you want with::
+
+  pip uninstall <package_name>
+
+If you've used ``make check-avocado``, the Python virtual environment where
+Avocado is installed will be cleaned up as part of ``make check-clean``.
diff --git a/docs/devel/testing/index.rst b/docs/devel/testing/index.rst
index 2711fd78b7..cdf7ba1f8b 100644
--- a/docs/devel/testing/index.rst
+++ b/docs/devel/testing/index.rst
@@ -9,6 +9,7 @@ testing infrastructure.
 
    main
    qtest
+   avocado
    acpi-bits
    ci
    fuzzing
diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index af73d3d64f..39b965ecf6 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -869,577 +869,14 @@ The ``tests/avocado`` directory hosts integration tests. They're usually
 higher level tests, and may interact with external resources and with
 various guest operating systems.
 
-These tests are written using the Avocado Testing Framework (which must
-be installed separately) in conjunction with a the ``avocado_qemu.Test``
-class, implemented at ``tests/avocado/avocado_qemu``.
-
-Tests based on ``avocado_qemu.Test`` can easily:
-
- * Customize the command line arguments given to the convenience
-   ``self.vm`` attribute (a QEMUMachine instance)
-
- * Interact with the QEMU monitor, send QMP commands and check
-   their results
-
- * Interact with the guest OS, using the convenience console device
-   (which may be useful to assert the effectiveness and correctness of
-   command line arguments or QMP commands)
-
- * Interact with external data files that accompany the test itself
-   (see ``self.get_data()``)
-
- * Download (and cache) remote data files, such as firmware and kernel
-   images
-
- * Have access to a library of guest OS images (by means of the
-   ``avocado.utils.vmimage`` library)
-
- * Make use of various other test related utilities available at the
-   test class itself and at the utility library:
-
-   - http://avocado-framework.readthedocs.io/en/latest/api/test/avocado.html#avocado.Test
-   - http://avocado-framework.readthedocs.io/en/latest/api/utils/avocado.utils.html
-
-Running tests
-~~~~~~~~~~~~~
-
 You can run the avocado tests simply by executing:
 
 .. code::
 
   make check-avocado
 
-This involves the automatic installation, from PyPI, of all the
-necessary avocado-framework dependencies into the QEMU venv within the
-build tree (at ``./pyvenv``). Test results are also saved within the
-build tree (at ``tests/results``).
-
-Note: the build environment must be using a Python 3 stack, and have
-the ``venv`` and ``pip`` packages installed.  If necessary, make sure
-``configure`` is called with ``--python=`` and that those modules are
-available.  On Debian and Ubuntu based systems, depending on the
-specific version, they may be on packages named ``python3-venv`` and
-``python3-pip``.
-
-It is also possible to run tests based on tags using the
-``make check-avocado`` command and the ``AVOCADO_TAGS`` environment
-variable:
-
-.. code::
-
-   make check-avocado AVOCADO_TAGS=quick
-
-Note that tags separated with commas have an AND behavior, while tags
-separated by spaces have an OR behavior. For more information on Avocado
-tags, see:
-
- https://avocado-framework.readthedocs.io/en/latest/guides/user/chapters/tags.html
-
-To run a single test file, a couple of them, or a test within a file
-using the ``make check-avocado`` command, set the ``AVOCADO_TESTS``
-environment variable with the test files or test names. To run all
-tests from a single file, use:
-
- .. code::
-
-  make check-avocado AVOCADO_TESTS=$FILEPATH
-
-The same is valid to run tests from multiple test files:
-
- .. code::
-
-  make check-avocado AVOCADO_TESTS='$FILEPATH1 $FILEPATH2'
-
-To run a single test within a file, use:
-
- .. code::
-
-  make check-avocado AVOCADO_TESTS=$FILEPATH:$TESTCLASS.$TESTNAME
-
-The same is valid to run single tests from multiple test files:
-
- .. code::
-
-  make check-avocado AVOCADO_TESTS='$FILEPATH1:$TESTCLASS1.$TESTNAME1 $FILEPATH2:$TESTCLASS2.$TESTNAME2'
-
-The scripts installed inside the virtual environment may be used
-without an "activation".  For instance, the Avocado test runner
-may be invoked by running:
-
- .. code::
-
-  pyvenv/bin/avocado run $OPTION1 $OPTION2 tests/avocado/
-
-Note that if ``make check-avocado`` was not executed before, it is
-possible to create the Python virtual environment with the dependencies
-needed running:
-
- .. code::
-
-  make check-venv
-
-It is also possible to run tests from a single file or a single test within
-a test file. To run tests from a single file within the build tree, use:
-
- .. code::
-
-  pyvenv/bin/avocado run tests/avocado/$TESTFILE
-
-To run a single test within a test file, use:
-
- .. code::
-
-  pyvenv/bin/avocado run tests/avocado/$TESTFILE:$TESTCLASS.$TESTNAME
-
-Valid test names are visible in the output from any previous execution
-of Avocado or ``make check-avocado``, and can also be queried using:
-
- .. code::
-
-  pyvenv/bin/avocado list tests/avocado
-
-Manual Installation
-~~~~~~~~~~~~~~~~~~~
-
-To manually install Avocado and its dependencies, run:
-
-.. code::
-
-  pip install --user avocado-framework
-
-Alternatively, follow the instructions on this link:
-
-  https://avocado-framework.readthedocs.io/en/latest/guides/user/chapters/installing.html
-
-Overview
-~~~~~~~~
-
-The ``tests/avocado/avocado_qemu`` directory provides the
-``avocado_qemu`` Python module, containing the ``avocado_qemu.Test``
-class.  Here's a simple usage example:
-
-.. code::
-
-  from avocado_qemu import QemuSystemTest
-
-
-  class Version(QemuSystemTest):
-      """
-      :avocado: tags=quick
-      """
-      def test_qmp_human_info_version(self):
-          self.vm.launch()
-          res = self.vm.cmd('human-monitor-command',
-                            command_line='info version')
-          self.assertRegex(res, r'^(\d+\.\d+\.\d)')
-
-To execute your test, run:
-
-.. code::
-
-  avocado run version.py
-
-Tests may be classified according to a convention by using docstring
-directives such as ``:avocado: tags=TAG1,TAG2``.  To run all tests
-in the current directory, tagged as "quick", run:
-
-.. code::
-
-  avocado run -t quick .
-
-The ``avocado_qemu.Test`` base test class
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-The ``avocado_qemu.Test`` class has a number of characteristics that
-are worth being mentioned right away.
-
-First of all, it attempts to give each test a ready to use QEMUMachine
-instance, available at ``self.vm``.  Because many tests will tweak the
-QEMU command line, launching the QEMUMachine (by using ``self.vm.launch()``)
-is left to the test writer.
-
-The base test class has also support for tests with more than one
-QEMUMachine. The way to get machines is through the ``self.get_vm()``
-method which will return a QEMUMachine instance. The ``self.get_vm()``
-method accepts arguments that will be passed to the QEMUMachine creation
-and also an optional ``name`` attribute so you can identify a specific
-machine and get it more than once through the tests methods. A simple
-and hypothetical example follows:
-
-.. code::
-
-  from avocado_qemu import QemuSystemTest
-
-
-  class MultipleMachines(QemuSystemTest):
-      def test_multiple_machines(self):
-          first_machine = self.get_vm()
-          second_machine = self.get_vm()
-          self.get_vm(name='third_machine').launch()
-
-          first_machine.launch()
-          second_machine.launch()
-
-          first_res = first_machine.cmd(
-              'human-monitor-command',
-              command_line='info version')
-
-          second_res = second_machine.cmd(
-              'human-monitor-command',
-              command_line='info version')
-
-          third_res = self.get_vm(name='third_machine').cmd(
-              'human-monitor-command',
-              command_line='info version')
-
-          self.assertEqual(first_res, second_res, third_res)
-
-At test "tear down", ``avocado_qemu.Test`` handles all the QEMUMachines
-shutdown.
-
-The ``avocado_qemu.LinuxTest`` base test class
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-The ``avocado_qemu.LinuxTest`` is further specialization of the
-``avocado_qemu.Test`` class, so it contains all the characteristics of
-the later plus some extra features.
-
-First of all, this base class is intended for tests that need to
-interact with a fully booted and operational Linux guest.  At this
-time, it uses a Fedora 31 guest image.  The most basic example looks
-like this:
-
-.. code::
-
-  from avocado_qemu import LinuxTest
-
-
-  class SomeTest(LinuxTest):
-
-      def test(self):
-          self.launch_and_wait()
-          self.ssh_command('some_command_to_be_run_in_the_guest')
-
-Please refer to tests that use ``avocado_qemu.LinuxTest`` under
-``tests/avocado`` for more examples.
-
-QEMUMachine
-~~~~~~~~~~~
-
-The QEMUMachine API is already widely used in the Python iotests,
-device-crash-test and other Python scripts.  It's a wrapper around the
-execution of a QEMU binary, giving its users:
-
- * the ability to set command line arguments to be given to the QEMU
-   binary
-
- * a ready to use QMP connection and interface, which can be used to
-   send commands and inspect its results, as well as asynchronous
-   events
-
- * convenience methods to set commonly used command line arguments in
-   a more succinct and intuitive way
-
-QEMU binary selection
-^^^^^^^^^^^^^^^^^^^^^
-
-The QEMU binary used for the ``self.vm`` QEMUMachine instance will
-primarily depend on the value of the ``qemu_bin`` parameter.  If it's
-not explicitly set, its default value will be the result of a dynamic
-probe in the same source tree.  A suitable binary will be one that
-targets the architecture matching host machine.
-
-Based on this description, test writers will usually rely on one of
-the following approaches:
-
-1) Set ``qemu_bin``, and use the given binary
-
-2) Do not set ``qemu_bin``, and use a QEMU binary named like
-   "qemu-system-${arch}", either in the current
-   working directory, or in the current source tree.
-
-The resulting ``qemu_bin`` value will be preserved in the
-``avocado_qemu.Test`` as an attribute with the same name.
-
-Attribute reference
-~~~~~~~~~~~~~~~~~~~
-
-Test
-^^^^
-
-Besides the attributes and methods that are part of the base
-``avocado.Test`` class, the following attributes are available on any
-``avocado_qemu.Test`` instance.
-
-vm
-''
-
-A QEMUMachine instance, initially configured according to the given
-``qemu_bin`` parameter.
-
-arch
-''''
-
-The architecture can be used on different levels of the stack, e.g. by
-the framework or by the test itself.  At the framework level, it will
-currently influence the selection of a QEMU binary (when one is not
-explicitly given).
-
-Tests are also free to use this attribute value, for their own needs.
-A test may, for instance, use the same value when selecting the
-architecture of a kernel or disk image to boot a VM with.
-
-The ``arch`` attribute will be set to the test parameter of the same
-name.  If one is not given explicitly, it will either be set to
-``None``, or, if the test is tagged with one (and only one)
-``:avocado: tags=arch:VALUE`` tag, it will be set to ``VALUE``.
-
-cpu
-'''
-
-The cpu model that will be set to all QEMUMachine instances created
-by the test.
-
-The ``cpu`` attribute will be set to the test parameter of the same
-name. If one is not given explicitly, it will either be set to
-``None ``, or, if the test is tagged with one (and only one)
-``:avocado: tags=cpu:VALUE`` tag, it will be set to ``VALUE``.
-
-machine
-'''''''
-
-The machine type that will be set to all QEMUMachine instances created
-by the test.
-
-The ``machine`` attribute will be set to the test parameter of the same
-name.  If one is not given explicitly, it will either be set to
-``None``, or, if the test is tagged with one (and only one)
-``:avocado: tags=machine:VALUE`` tag, it will be set to ``VALUE``.
-
-qemu_bin
-''''''''
-
-The preserved value of the ``qemu_bin`` parameter or the result of the
-dynamic probe for a QEMU binary in the current working directory or
-source tree.
-
-LinuxTest
-^^^^^^^^^
-
-Besides the attributes present on the ``avocado_qemu.Test`` base
-class, the ``avocado_qemu.LinuxTest`` adds the following attributes:
-
-distro
-''''''
-
-The name of the Linux distribution used as the guest image for the
-test.  The name should match the **Provider** column on the list
-of images supported by the avocado.utils.vmimage library:
-
-https://avocado-framework.readthedocs.io/en/latest/guides/writer/libs/vmimage.html#supported-images
-
-distro_version
-''''''''''''''
-
-The version of the Linux distribution as the guest image for the
-test.  The name should match the **Version** column on the list
-of images supported by the avocado.utils.vmimage library:
-
-https://avocado-framework.readthedocs.io/en/latest/guides/writer/libs/vmimage.html#supported-images
-
-distro_checksum
-'''''''''''''''
-
-The sha256 hash of the guest image file used for the test.
-
-If this value is not set in the code or by a test parameter (with the
-same name), no validation on the integrity of the image will be
-performed.
-
-Parameter reference
-~~~~~~~~~~~~~~~~~~~
-
-To understand how Avocado parameters are accessed by tests, and how
-they can be passed to tests, please refer to::
-
-  https://avocado-framework.readthedocs.io/en/latest/guides/writer/chapters/writing.html#accessing-test-parameters
-
-Parameter values can be easily seen in the log files, and will look
-like the following:
-
-.. code::
-
-  PARAMS (key=qemu_bin, path=*, default=./qemu-system-x86_64) => './qemu-system-x86_64
-
-Test
-^^^^
-
-arch
-''''
-
-The architecture that will influence the selection of a QEMU binary
-(when one is not explicitly given).
-
-Tests are also free to use this parameter value, for their own needs.
-A test may, for instance, use the same value when selecting the
-architecture of a kernel or disk image to boot a VM with.
-
-This parameter has a direct relation with the ``arch`` attribute.  If
-not given, it will default to None.
-
-cpu
-'''
-
-The cpu model that will be set to all QEMUMachine instances created
-by the test.
-
-machine
-'''''''
-
-The machine type that will be set to all QEMUMachine instances created
-by the test.
-
-qemu_bin
-''''''''
-
-The exact QEMU binary to be used on QEMUMachine.
-
-LinuxTest
-^^^^^^^^^
-
-Besides the parameters present on the ``avocado_qemu.Test`` base
-class, the ``avocado_qemu.LinuxTest`` adds the following parameters:
-
-distro
-''''''
-
-The name of the Linux distribution used as the guest image for the
-test.  The name should match the **Provider** column on the list
-of images supported by the avocado.utils.vmimage library:
-
-https://avocado-framework.readthedocs.io/en/latest/guides/writer/libs/vmimage.html#supported-images
-
-distro_version
-''''''''''''''
-
-The version of the Linux distribution as the guest image for the
-test.  The name should match the **Version** column on the list
-of images supported by the avocado.utils.vmimage library:
-
-https://avocado-framework.readthedocs.io/en/latest/guides/writer/libs/vmimage.html#supported-images
-
-distro_checksum
-'''''''''''''''
-
-The sha256 hash of the guest image file used for the test.
-
-If this value is not set in the code or by this parameter no
-validation on the integrity of the image will be performed.
-
-Skipping tests
-~~~~~~~~~~~~~~
-
-The Avocado framework provides Python decorators which allow for easily skip
-tests running under certain conditions. For example, on the lack of a binary
-on the test system or when the running environment is a CI system. For further
-information about those decorators, please refer to::
-
-  https://avocado-framework.readthedocs.io/en/latest/guides/writer/chapters/writing.html#skipping-tests
-
-While the conditions for skipping tests are often specifics of each one, there
-are recurring scenarios identified by the QEMU developers and the use of
-environment variables became a kind of standard way to enable/disable tests.
-
-Here is a list of the most used variables:
-
-AVOCADO_ALLOW_LARGE_STORAGE
-^^^^^^^^^^^^^^^^^^^^^^^^^^^
-Tests which are going to fetch or produce assets considered *large* are not
-going to run unless that ``AVOCADO_ALLOW_LARGE_STORAGE=1`` is exported on
-the environment.
-
-The definition of *large* is a bit arbitrary here, but it usually means an
-asset which occupies at least 1GB of size on disk when uncompressed.
-
-SPEED
-^^^^^
-Tests which have a long runtime will not be run unless ``SPEED=slow`` is
-exported on the environment.
-
-The definition of *long* is a bit arbitrary here, and it depends on the
-usefulness of the test too. A unique test is worth spending more time on,
-small variations on existing tests perhaps less so. As a rough guide,
-a test or set of similar tests which take more than 100 seconds to
-complete.
-
-AVOCADO_ALLOW_UNTRUSTED_CODE
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-There are tests which will boot a kernel image or firmware that can be
-considered not safe to run on the developer's workstation, thus they are
-skipped by default. The definition of *not safe* is also arbitrary but
-usually it means a blob which either its source or build process aren't
-public available.
-
-You should export ``AVOCADO_ALLOW_UNTRUSTED_CODE=1`` on the environment in
-order to allow tests which make use of those kind of assets.
-
-AVOCADO_TIMEOUT_EXPECTED
-^^^^^^^^^^^^^^^^^^^^^^^^
-The Avocado framework has a timeout mechanism which interrupts tests to avoid the
-test suite of getting stuck. The timeout value can be set via test parameter or
-property defined in the test class, for further details::
-
-  https://avocado-framework.readthedocs.io/en/latest/guides/writer/chapters/writing.html#setting-a-test-timeout
-
-Even though the timeout can be set by the test developer, there are some tests
-that may not have a well-defined limit of time to finish under certain
-conditions. For example, tests that take longer to execute when QEMU is
-compiled with debug flags. Therefore, the ``AVOCADO_TIMEOUT_EXPECTED`` variable
-has been used to determine whether those tests should run or not.
-
-QEMU_TEST_FLAKY_TESTS
-^^^^^^^^^^^^^^^^^^^^^
-Some tests are not working reliably and thus are disabled by default.
-This includes tests that don't run reliably on GitLab's CI which
-usually expose real issues that are rarely seen on developer machines
-due to the constraints of the CI environment. If you encounter a
-similar situation then raise a bug and then mark the test as shown on
-the code snippet below:
-
-.. code::
-
-  # See https://gitlab.com/qemu-project/qemu/-/issues/nnnn
-  @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-  def test(self):
-      do_something()
-
-You can also add ``:avocado: tags=flaky`` to the test meta-data so
-only the flaky tests can be run as a group:
-
-.. code::
-
-   env QEMU_TEST_FLAKY_TESTS=1 ./pyvenv/bin/avocado \
-      run tests/avocado -filter-by-tags=flaky
-
-Tests should not live in this state forever and should either be fixed
-or eventually removed.
-
-
-Uninstalling Avocado
-~~~~~~~~~~~~~~~~~~~~
-
-If you've followed the manual installation instructions above, you can
-easily uninstall Avocado.  Start by listing the packages you have
-installed::
-
-  pip list --user
-
-And remove any package you want with::
-
-  pip uninstall <package_name>
+See :ref:`checkavocado-ref` for more details.
 
-If you've used ``make check-avocado``, the Python virtual environment where
-Avocado is installed will be cleaned up as part of ``make check-clean``.
 
 .. _checktcg-ref:
 
-- 
2.46.0


