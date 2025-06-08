Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3B0C5B552
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Jun 2025 21:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uONVu-0008He-J0; Sun, 08 Jun 2025 17:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conte.souleymane@gmail.com>)
 id 1uONVq-0008HP-Hy
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 17:25:06 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <conte.souleymane@gmail.com>)
 id 1uONVl-0002g2-VN
 for qemu-devel@nongnu.org; Sun, 08 Jun 2025 17:25:05 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a376ba6f08so2021339f8f.1
 for <qemu-devel@nongnu.org>; Sun, 08 Jun 2025 14:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749417900; x=1750022700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sHxEGaKaurq8gnYpbl97Cu18xzOmBhJ/171kNl9SP04=;
 b=EwKOeshcgaKhEn7hw0cice5Renz5dYyxI1LEIXvpcgRMDOW2HVxsFFRw5XTAr/DQTh
 V06B2s5iht76f86KhETrGCOBe2c6ZKgTNTQ4lq5+9fznpFOZHAPDmIGNHSCxfKmd4h8Y
 7HHrJAbk9LPj6M/jHrin0WEAkHfKHM37DIPqfuIZB2JKh6IPtqTsuwKCdXWOHXXyHyil
 SQjuvu0DUgX4coZMraP1OPtwksYrTcNxFnvqmpYkZcZVjE041ByMzXOiB9FoOUoAeTqd
 /DpLhGTk5cgKsEiIX4D49caXf/b5Y+UyzhVfTfTTEAMspK3Xu1VOMgO98S4GkXThheTL
 nxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749417900; x=1750022700;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sHxEGaKaurq8gnYpbl97Cu18xzOmBhJ/171kNl9SP04=;
 b=nISa3UYB0JaoRooGDcVcZgWk+6lRLw4cXydnFSamS/03lVsnmJh5LA9e90hamwjdC6
 dUwPyPVHktYg+dvbWuqZUhIm/D6ttFXleO8M8B7iJ0DxKg9LFvM2YDCva2+axzKhP5Q9
 89EXtJVbRvUjyuDyp7ntDqBpXWUmIky8Ob/ZX+nTaMUjCzE/qizSJZm63SgrFXhBMm6L
 ItmVuXV0aMXoRNf9mRlyWIU1F9VfVskxMc87CFnLsF+69ojC/JK5bfVmklikcopOKDRG
 /Q2Li3Ph2aYedWnlO2R3A+2WH2DFNVcUIV49FRJ/Mc1DhHpKcCKGjr5ZjBa5sb5Aea80
 pCyA==
X-Gm-Message-State: AOJu0YwtyogCJ4aKSJJH4AxqxwPNsCHPRp44+FwnL14p3buuj2WS6tte
 9Qd/IGg3PqU4ptkmuAs/YdON6wxNJB+jcO50JlmjSzEfZidv3rGKXLdo1JMwMHOGg7Q=
X-Gm-Gg: ASbGncv7wZvKzKQSuBWIj91KpWivlSMTBrd5TxLCxwsnEd6WTZDuQLLHulq1VQH7GKr
 +OtxxkMxMxfdAmt+ARsgPpb0ldZ1SdCkevgVnZ0rrxKvZnv+FJ6gTq5KrqMMAw57ReZ5EaGBd2F
 dI1iczInbixK4QlYdPqe7M30LfTi/fLfI+vzHb/PmBHF2YtDNvc+zROFRrkPh8z9+qrA75SBtSW
 6AilvvRdoxLrIy0BTEVfanz+G9OiCYByKPEqVqKhrenDiVsvljCwM7hr9sFQuKSs17y74j0uMoD
 vkZTjtwZrzuvVdr0ld+u65LerPHevuMX7B0ExpeuTZyiEhIPfduavy3lO0wJryN5a7Kvv5LPrYe
 6VuJdsmxZbmkOGcs2vuB3FtUjxMGun5bY6OjU5LoZ7C6hXNIpPd8=
X-Google-Smtp-Source: AGHT+IGY/pPCJBAaEIdXcje5A2hR1yrlXMOW9OsR1eoLgZjfx0v4CCZhLEuT0+aSoblzi+L0Qqp8Kg==
X-Received: by 2002:a05:6000:2010:b0:3a4:dc93:1e87 with SMTP id
 ffacd0b85a97d-3a531684002mr9131860f8f.1.1749417899792; 
 Sun, 08 Jun 2025 14:24:59 -0700 (PDT)
Received: from localhost (mac76-h03-89-88-247-135.dsl.sta.abo.bbox.fr.
 [89.88.247.135]) by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-45209bc6d6dsm93348415e9.3.2025.06.08.14.24.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Jun 2025 14:24:59 -0700 (PDT)
From: conte.souleymane@gmail.com
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, peter.maydell@linaro.org,
 Souleymane Conte <conte.souleymane@gmail.com>
Subject: [PATCH] docs/devel: Convert image-fuzzer.txt to restructredText format
Date: Sun,  8 Jun 2025 21:24:32 +0000
Message-ID: <20250608212432.72724-1-conte.souleymane@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=conte.souleymane@gmail.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Souleymane Conte <conte.souleymane@gmail.com>

buglink: https://gitlab.com/qemu-project/qemu/-/issues/527
Signed-off-by: Souleymane Conte <conte.souleymane@gmail.com>
---
This patch convert image-fuzzer.txt to restructuredText format. Here are
the main updates:
- Move file to docs/devel/testing directory
- Properly structured sections with RST headings
- Uses cross-references for key glossary terms

 docs/devel/testing/image-fuzzer.rst | 260 ++++++++++++++++++++++++++++
 docs/devel/testing/index.rst        |   1 +
 docs/image-fuzzer.txt               | 239 -------------------------
 3 files changed, 261 insertions(+), 239 deletions(-)
 create mode 100644 docs/devel/testing/image-fuzzer.rst
 delete mode 100644 docs/image-fuzzer.txt

diff --git a/docs/devel/testing/image-fuzzer.rst b/docs/devel/testing/image-fuzzer.rst
new file mode 100644
index 0000000000..1a42a7fe3f
--- /dev/null
+++ b/docs/devel/testing/image-fuzzer.rst
@@ -0,0 +1,260 @@
+..
+  Specification for the fuzz testing tool
+
+  Copyright (C) 2014 Maria Kustova <maria.k@catit.be>
+
+  This program is free software: you can redistribute it and/or modify
+  it under the terms of the GNU General Public License as published by
+  the Free Software Foundation, either version 2 of the License, or
+  (at your option) any later version.
+
+  This program is distributed in the hope that it will be useful,
+  but WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+  GNU General Public License for more details.
+
+  You should have received a copy of the GNU General Public License
+  along with this program.  If not, see <http://www.gnu.org/licenses/>.
+
+============
+Image fuzzer
+============
+
+Description
+===========
+
+The goal of the image fuzzer is to catch crashes of ``qemu-io/qemu-img``
+by providing to them randomly corrupted images. :ref:`Test images <test-image>`
+are generated from scratch and have valid inner structure with some elements,
+e.g. L1/L2 tables, having random invalid values.
+
+Test runner
+===========
+
+The test runner generates test images, executes tests utilizing generated
+images, indicates their results and collects all test related artifacts (logs,
+core dumps, test images, backing files).
+The test means execution of all available commands under test with the same
+generated test image.
+By default, the test runner generates new tests and executes them until
+keyboard interruption. But if a test seed is specified via the ``--seed`` runner
+parameter, then only one test with this seed will be executed, after its finish
+the runner will exit.
+
+The runner uses an external image fuzzer to generate test images. An image
+generator should be specified as a mandatory parameter of the test runner.
+Details about interactions between the runner and fuzzers see :ref:`Module
+interfaces <module-interfaces>`.
+
+The runner activates generation of core dumps during test executions, but it
+assumes that core dumps will be generated in the current working directory.
+For comprehensive test results, please, set up your test environment
+properly.
+
+Paths to binaries under test (SUTs) ``qemu-img`` and ``qemu-io`` are retrieved
+from environment variables. If the environment check fails the runner will
+use SUTs installed in system paths.
+``qemu-img`` is required for creation of backing files, so it's mandatory to set
+the related environment variable if it's not installed in the system path.
+For details about environment variables see ``qemu-iotests/check``.
+
+The runner accepts a JSON array of fields expected to be fuzzed via the
+``--config`` argument, e.g.
+
+.. code::
+
+    [["feature_name_table"],
+     ["header", "l1_table_offset"]]
+
+Each sublist can have one or two strings defining image structure elements.
+In the latter case a parent element should be placed on the first position,
+and a field name on the second one.
+
+The runner accepts a list of commands under test as a JSON array via
+the ``--command`` argument. Each command is a list containing a SUT and all its
+arguments, e.g.
+
+.. code::
+
+    runner.py -c '[["qemu-io", "$test_img", "-c", "write $off $len"]]' /tmp/test ../qcow2
+
+For variable arguments next aliases can be used:
+
+    - ``$test_img`` for a fuzzed img
+    - ``$off`` for an offset in the fuzzed image
+    - ``$len`` for a data size
+
+Values for last two aliases will be generated based on a size of a virtual
+disk of the generated image.
+In case when no commands are specified the runner will execute commands from
+the default list:
+
+    - ``qemu-img check``
+    - ``qemu-img info``
+    - ``qemu-img convert``
+    - ``qemu-io -c read``
+    - ``qemu-io -c write``
+    - ``qemu-io -c aio_read``
+    - ``qemu-io -c aio_write``
+    - ``qemu-io -c flush``
+    - ``qemu-io -c discard``
+    - ``qemu-io -c truncate``
+
+Qcow2 image generator
+=====================
+
+The ``qcow2`` generator is a Python package providing ``create_image`` method as
+a single public API. See details in :ref:`Test runner/image fuzzer <test-runner-image-fuzzer>`
+chapter of :ref:`Module interfaces <module-interfaces>`.
+
+Qcow2 contains two submodules: ``fuzz.py`` and ``layout.py``.
+
+- ``fuzz.py`` contains all fuzzing functions, one per image field. It's assumed
+  that after code analysis every field will have own constraints for its value.
+  For now only universal potentially dangerous values are used, e.g. type limits
+  for integers or unsafe symbols as ``%s`` for strings. For bitmasks random amount
+  of bits are set to ones. All fuzzed values are checked on non-equality to the
+  current valid value of the field. In case of equality the value will be
+  regenerated.
+
+- ``layout.py`` creates a random valid image, fuzzes a random subset of the image
+  fields by ``fuzz.py`` module and writes a fuzzed image to the file specified.
+  If a fuzzer configuration is specified, then it has the next interpretation:
+
+    1. If a list contains a parent image element only, then some random portion
+       of fields of this element will be fuzzed every test.
+       The same behavior is applied for the entire image if no configuration is
+       used. This case is useful for the test specialization.
+
+    2. If a list contains a parent element and a field name, then a field
+       will be always fuzzed for every test. This case is useful for regression
+       testing.
+
+The generator can create header fields, header extensions, L1/L2 tables and
+refcount table and blocks.
+
+.. _module-interfaces:
+
+Module interfaces
+=================
+
+.. _test-runner-image-fuzzer:
+
+Test runner/image fuzzer
+------------------------
+
+The runner calls an image generator specifying the path to a test image file,
+path to a backing file and its format and a fuzzer configuration.
+An image generator is expected to provide a ``create_image(test_img_path,
+backing_file_path=None, backing_file_format=None, fuzz_config=None)`` method 
+that creates a test image, writes it to the specified file and returns
+the size of the virtual disk. The file should be created if it doesn't exist
+or overwritten otherwise. ``fuzz_config`` has a form of a list of lists.
+Every sublist can have one or two elements: first element is a name of a
+parent image element, second one if exists is a name of a field in this element.
+Example::
+    
+    [['header', 'l1_table_offset'],
+     ['header', 'nb_snapshots'],
+     ['feature_name_table']]
+
+Random seed is set by the runner at every test execution for the regression
+purpose, so an image generator is not recommended to modify it internally.
+
+
+Overall fuzzer requirements
+===========================
+
+Input data:
+-----------
+
+ - :ref:`image template <image-template>` (generator)
+ - work directory
+ - :ref:`action vector <action-vector>` (optional)
+ - seed (optional)
+ - SUT and its arguments (optional)
+
+
+Fuzzer requirements:
+--------------------
+
+1.  Should be able to inject random data
+2.  Should be able to select a random value from the manually pregenerated
+    vector (boundary values, e.g. max/min cluster size)
+3.  Image template should describe a general structure invariant for all
+    test images (image format description)
+4.  Image template should be autonomous and other fuzzer parts should not
+    rely on it
+5.  Image template should contain reference rules (not only block+size
+    description)
+6.  Should generate the test image with the correct structure based on an image
+    template
+7.  Should accept a seed as an argument (for regression purpose)
+8.  Should generate a seed if it is not specified as an input parameter.
+9.  The same seed should generate the same image for the same action vector,
+    specified or generated.
+10. Should accept a vector of actions as an argument (for test reproducing and
+    for test case specification, e.g. group of tests for header structure,
+    group of test for snapshots, etc)
+11. Action vector should be randomly generated from the pool of available
+    actions, if it is not specified as an input parameter
+12. :ref:`Pool of actions <action-pool>` should be defined automatically based on
+    an image template
+13. Should accept a SUT and its call parameters as an argument or select them
+    randomly otherwise. As far as it's expected to be rarely changed, the list
+    of all possible test commands can be available in the test runner
+    internally.
+14. Should support an external cancellation of a test run
+15. Seed should be logged (for regression purpose)
+16. All files related to a test result should be collected: a test image,
+    SUT logs, fuzzer logs and crash dumps
+17. Should be compatible with python version 2.4-2.7
+18. Usage of external libraries should be limited as much as possible.
+
+
+Image formats:
+--------------
+
+Main target image format is ``qcow2``, but support of image templates should
+provide an ability to add any other image format.
+
+
+Effectiveness:
+--------------
+
+The fuzzer can be controlled via template, seed and action vector; it makes
+the fuzzer itself invariant to an image format and test logic.
+It should be able to perform rather complex and precise tests, that can be
+specified via an action vector. Otherwise, knowledge about an image structure
+allows the fuzzer to generate the pool of all available areas can be fuzzed
+and randomly select some of them and so compose its own action vector.
+Also complexity of a template defines complexity of the fuzzer, so its
+functionality can be varied from simple model-independent fuzzing to smart
+model-based one.
+
+
+Glossary:
+=========
+
+.. _action-vector:
+
+Action vector
+  A sequence of structure elements retrieved from an image
+  format, each of them will be fuzzed for the test image. It's a subset of
+  elements of the action pool. Example: header, refcount table, etc.
+
+.. _action-pool:
+
+Action pool
+  All available elements of an image structure that generated automatically
+  from an image template.
+
+.. _image-template:
+
+Image template
+  A formal description of an image structure and relations between image blocks.
+
+.. _test-image:
+
+Test image
+  An output image of the fuzzer defined by the current seed and action vector.
diff --git a/docs/devel/testing/index.rst b/docs/devel/testing/index.rst
index 1171f7db8f..953677cd03 100644
--- a/docs/devel/testing/index.rst
+++ b/docs/devel/testing/index.rst
@@ -16,3 +16,4 @@ testing infrastructure.
    fuzzing
    blkdebug
    blkverify
+   image-fuzzer
diff --git a/docs/image-fuzzer.txt b/docs/image-fuzzer.txt
deleted file mode 100644
index 279cc8c807..0000000000
--- a/docs/image-fuzzer.txt
+++ /dev/null
@@ -1,239 +0,0 @@
-# Specification for the fuzz testing tool
-#
-# Copyright (C) 2014 Maria Kustova <maria.k@catit.be>
-#
-# This program is free software: you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation, either version 2 of the License, or
-# (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program.  If not, see <http://www.gnu.org/licenses/>.
-
-
-Image fuzzer
-============
-
-Description
------------
-
-The goal of the image fuzzer is to catch crashes of qemu-io/qemu-img
-by providing to them randomly corrupted images.
-Test images are generated from scratch and have valid inner structure with some
-elements, e.g. L1/L2 tables, having random invalid values.
-
-
-Test runner
------------
-
-The test runner generates test images, executes tests utilizing generated
-images, indicates their results and collects all test related artifacts (logs,
-core dumps, test images, backing files).
-The test means execution of all available commands under test with the same
-generated test image.
-By default, the test runner generates new tests and executes them until
-keyboard interruption. But if a test seed is specified via the '--seed' runner
-parameter, then only one test with this seed will be executed, after its finish
-the runner will exit.
-
-The runner uses an external image fuzzer to generate test images. An image
-generator should be specified as a mandatory parameter of the test runner.
-Details about interactions between the runner and fuzzers see "Module
-interfaces".
-
-The runner activates generation of core dumps during test executions, but it
-assumes that core dumps will be generated in the current working directory.
-For comprehensive test results, please, set up your test environment
-properly.
-
-Paths to binaries under test (SUTs) ``qemu-img`` and ``qemu-io`` are retrieved
-from environment variables. If the environment check fails the runner will
-use SUTs installed in system paths.
-``qemu-img`` is required for creation of backing files, so it's mandatory to set
-the related environment variable if it's not installed in the system path.
-For details about environment variables see qemu-iotests/check.
-
-The runner accepts a JSON array of fields expected to be fuzzed via the
-'--config' argument, e.g.
-
-       '[["feature_name_table"], ["header", "l1_table_offset"]]'
-
-Each sublist can have one or two strings defining image structure elements.
-In the latter case a parent element should be placed on the first position,
-and a field name on the second one.
-
-The runner accepts a list of commands under test as a JSON array via
-the '--command' argument. Each command is a list containing a SUT and all its
-arguments, e.g.
-
-       runner.py -c '[["qemu-io", "$test_img", "-c", "write $off $len"]]'
-     /tmp/test ../qcow2
-
-For variable arguments next aliases can be used:
-    - $test_img for a fuzzed img
-    - $off for an offset in the fuzzed image
-    - $len for a data size
-
-Values for last two aliases will be generated based on a size of a virtual
-disk of the generated image.
-In case when no commands are specified the runner will execute commands from
-the default list:
-    - qemu-img check
-    - qemu-img info
-    - qemu-img convert
-    - qemu-io -c read
-    - qemu-io -c write
-    - qemu-io -c aio_read
-    - qemu-io -c aio_write
-    - qemu-io -c flush
-    - qemu-io -c discard
-    - qemu-io -c truncate
-
-
-Qcow2 image generator
----------------------
-
-The 'qcow2' generator is a Python package providing 'create_image' method as
-a single public API. See details in 'Test runner/image fuzzer' chapter of
-'Module interfaces'.
-
-Qcow2 contains two submodules: fuzz.py and layout.py.
-
-'fuzz.py' contains all fuzzing functions, one per image field. It's assumed
-that after code analysis every field will have own constraints for its value.
-For now only universal potentially dangerous values are used, e.g. type limits
-for integers or unsafe symbols as '%s' for strings. For bitmasks random amount
-of bits are set to ones. All fuzzed values are checked on non-equality to the
-current valid value of the field. In case of equality the value will be
-regenerated.
-
-'layout.py' creates a random valid image, fuzzes a random subset of the image
-fields by 'fuzz.py' module and writes a fuzzed image to the file specified.
-If a fuzzer configuration is specified, then it has the next interpretation:
-
-    1. If a list contains a parent image element only, then some random portion
-    of fields of this element will be fuzzed every test.
-    The same behavior is applied for the entire image if no configuration is
-    used. This case is useful for the test specialization.
-
-    2. If a list contains a parent element and a field name, then a field
-    will be always fuzzed for every test. This case is useful for regression
-    testing.
-
-The generator can create header fields, header extensions, L1/L2 tables and
-refcount table and blocks.
-
-Module interfaces
------------------
-
-* Test runner/image fuzzer
-
-The runner calls an image generator specifying the path to a test image file,
-path to a backing file and its format and a fuzzer configuration.
-An image generator is expected to provide a
-
-   'create_image(test_img_path, backing_file_path=None,
-                 backing_file_format=None, fuzz_config=None)'
-
-method that creates a test image, writes it to the specified file and returns
-the size of the virtual disk.
-The file should be created if it doesn't exist or overwritten otherwise.
-fuzz_config has a form of a list of lists. Every sublist can have one
-or two elements: first element is a name of a parent image element, second one
-if exists is a name of a field in this element.
-Example,
-        [['header', 'l1_table_offset'],
-         ['header', 'nb_snapshots'],
-         ['feature_name_table']]
-
-Random seed is set by the runner at every test execution for the regression
-purpose, so an image generator is not recommended to modify it internally.
-
-
-Overall fuzzer requirements
-===========================
-
-Input data:
-----------
-
- - image template (generator)
- - work directory
- - action vector (optional)
- - seed (optional)
- - SUT and its arguments (optional)
-
-
-Fuzzer requirements:
--------------------
-
-1.  Should be able to inject random data
-2.  Should be able to select a random value from the manually pregenerated
-    vector (boundary values, e.g. max/min cluster size)
-3.  Image template should describe a general structure invariant for all
-    test images (image format description)
-4.  Image template should be autonomous and other fuzzer parts should not
-    rely on it
-5.  Image template should contain reference rules (not only block+size
-    description)
-6.  Should generate the test image with the correct structure based on an image
-    template
-7.  Should accept a seed as an argument (for regression purpose)
-8.  Should generate a seed if it is not specified as an input parameter.
-9.  The same seed should generate the same image for the same action vector,
-    specified or generated.
-10. Should accept a vector of actions as an argument (for test reproducing and
-    for test case specification, e.g. group of tests for header structure,
-    group of test for snapshots, etc)
-11. Action vector should be randomly generated from the pool of available
-    actions, if it is not specified as an input parameter
-12. Pool of actions should be defined automatically based on an image template
-13. Should accept a SUT and its call parameters as an argument or select them
-    randomly otherwise. As far as it's expected to be rarely changed, the list
-    of all possible test commands can be available in the test runner
-    internally.
-14. Should support an external cancellation of a test run
-15. Seed should be logged (for regression purpose)
-16. All files related to a test result should be collected: a test image,
-    SUT logs, fuzzer logs and crash dumps
-17. Should be compatible with python version 2.4-2.7
-18. Usage of external libraries should be limited as much as possible.
-
-
-Image formats:
--------------
-
-Main target image format is qcow2, but support of image templates should
-provide an ability to add any other image format.
-
-
-Effectiveness:
--------------
-
-The fuzzer can be controlled via template, seed and action vector;
-it makes the fuzzer itself invariant to an image format and test logic.
-It should be able to perform rather complex and precise tests, that can be
-specified via an action vector. Otherwise, knowledge about an image structure
-allows the fuzzer to generate the pool of all available areas can be fuzzed
-and randomly select some of them and so compose its own action vector.
-Also complexity of a template defines complexity of the fuzzer, so its
-functionality can be varied from simple model-independent fuzzing to smart
-model-based one.
-
-
-Glossary:
---------
-
-Action vector is a sequence of structure elements retrieved from an image
-format, each of them will be fuzzed for the test image. It's a subset of
-elements of the action pool. Example: header, refcount table, etc.
-Action pool is all available elements of an image structure that generated
-automatically from an image template.
-Image template is a formal description of an image structure and relations
-between image blocks.
-Test image is an output image of the fuzzer defined by the current seed and
-action vector.
-- 
2.49.0


