Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FA5C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 08:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSBzO-00074z-Os; Fri, 12 Jul 2024 04:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSBzK-0006sm-AS
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSBzG-0003ak-CT
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720774241;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1tDg5IkDR4CDTuXEF0m9xDRLc+Mo/63MWyin0ruRum4=;
 b=RyFgveNtB+v5nSYpYVHAEAZqyW9fn7qcf9S5TiOwfOKdCwGZQR13DIrWrHwcWm8vWHI1aV
 vg92ofphsFsJ6rd46ruESEqCevMKYa289q+NvrjpA+OMvhEa6ceQcnkiOFnntBAVOpvvVv
 UjYh7KUP8Py58T0EkyueGUrVE26Xs0k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-xIZe3yNcMkKM59bcuvmK-g-1; Fri,
 12 Jul 2024 04:50:38 -0400
X-MC-Unique: xIZe3yNcMkKM59bcuvmK-g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39FBF196E096; Fri, 12 Jul 2024 08:50:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AFE51956066; Fri, 12 Jul 2024 08:50:33 +0000 (UTC)
Date: Fri, 12 Jul 2024 09:50:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: Re: [RFC PATCH 1/8] tests/pytest: Add base classes for the upcoming
 pytest-based tests
Message-ID: <ZpDuVsAZKSQO2nwc@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
 <20240711115546.40859-2-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240711115546.40859-2-thuth@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jul 11, 2024 at 01:55:39PM +0200, Thomas Huth wrote:
> The file is a copy of the tests/avocado/avocado_qemu/__init__.py file
> with some adjustments to get rid of the Avocado dependencies (i.e.
> we also have to drop the LinuxSSHMixIn and LinuxTest for now).
> 
> The emulator binary, source and build directory are now passed via
> environment variables that will be set via meson.build later.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/pytest/qemu_pytest/__init__.py | 344 +++++++++++++++++++++++++++
>  1 file changed, 344 insertions(+)
>  create mode 100644 tests/pytest/qemu_pytest/__init__.py
> 
> diff --git a/tests/pytest/qemu_pytest/__init__.py b/tests/pytest/qemu_pytest/__init__.py
> new file mode 100644
> index 0000000000..e3ed32e3de
> --- /dev/null
> +++ b/tests/pytest/qemu_pytest/__init__.py
> @@ -0,0 +1,344 @@
> +# Test class and utilities for functional tests
> +#
> +# Copyright 2018, 2024 Red Hat, Inc.
> +#
> +# Original Author (Avocado-based tests):
> +#  Cleber Rosa <crosa@redhat.com>
> +#
> +# Adaption for pytest based version:
> +#  Thomas Huth <thuth@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import logging
> +import os
> +import shutil
> +import subprocess
> +import sys
> +import tempfile
> +import time
> +import uuid
> +import unittest
> +
> +from qemu.machine import QEMUMachine
> +from qemu.utils import (get_info_usernet_hostfwd_port, kvm_available,
> +                        tcg_available)
> +
> +BUILD_DIR = os.getenv('PYTEST_BUILD_ROOT')
> +SOURCE_DIR = os.getenv('PYTEST_SOURCE_ROOT')

We can make life slightly nicer for developers running tests directly
without meson, by figuring this out automatically if the env vars are
omitted. To enable devs to do

  PYTEST_QEMU_BINARY=./build/qemu-system-aarch64 \
  PYTHONPATH=./python \
  pytest build/tests/pytest/test_info_usernet.py

I propose the following additional logic on top of your patch:

diff --git a/tests/pytest/qemu_pytest/__init__.py b/tests/pytest/qemu_pytest/__init__.py
index 73d80b3828..711cb06012 100644
--- a/tests/pytest/qemu_pytest/__init__.py
+++ b/tests/pytest/qemu_pytest/__init__.py
@@ -21,13 +21,41 @@
 import time
 import uuid
 import unittest
+from pathlib import Path
 
 from qemu.machine import QEMUMachine
 from qemu.utils import (get_info_usernet_hostfwd_port, kvm_available,
                         tcg_available)
 
-BUILD_DIR = os.getenv('PYTEST_BUILD_ROOT')
-SOURCE_DIR = os.getenv('PYTEST_SOURCE_ROOT')
+def _pytest_dir():
+    if sys.argv[0].startswith("pytest") or "bin/pytest" in sys.argv[0]:
+        if sys.argv[1].endswith(".py"):
+            # Assume 'pytest ./build/tests/pytest/test_blah.py ....'
+            return Path(sys.argv[1]).absolute().parent
+        else:
+            # Assume 'pytest ./build/tests/pytest'
+            return Path(sys.argv[1]).absolute()
+
+    # Assume './build/tests/pytest/test_NAME.py'
+    if sys.argv[0].endswith(".py"):
+        return Path(sys.argv[0]).absolute().parent
+
+    raise Exception("Cannot identify pytest build dir, set PYTEST_BUILD_ROOT")
+
+def _build_dir():
+    root = os.getenv('PYTEST_BUILD_ROOT')
+    if root is not None:
+        return Path(root)
+    
+    return _pytest_dir().parent.parent
+
+def _source_dir():
+    root = os.getenv('PYTEST_SOURCE_ROOT')
+    if root is not None:
+        return Path(root)
+
+    # Assume build/tests/pytest is a symlink to the source root
+    return _pytest_dir().resolve().parent.parent
 
 def has_cmd(name, args=None):
     """
@@ -189,8 +217,8 @@ class QemuBaseTest(unittest.TestCase):
 
     qemu_bin = os.getenv('PYTEST_QEMU_BINARY')
 
-    workdir = os.path.join(BUILD_DIR, 'tests/pytest')
-    logdir = os.path.join(BUILD_DIR, 'tests/pytest')
+    workdir = str(Path(_build_dir(), 'tests', 'pytest'))
+    logdir = str(Path(_build_dir(), 'tests', 'pytest'))
 
     cpu = None
     machine = None
@@ -198,8 +226,6 @@ class QemuBaseTest(unittest.TestCase):
     log = logging.getLogger('qemu-pytest')
 
     def setUp(self, bin_prefix):
-        self.assertIsNotNone(BUILD_DIR, 'PYTEST_BUILD_ROOT must be set')
-        self.assertIsNotNone(SOURCE_DIR,'PYTEST_SOURCE_ROOT must be set')
         self.assertIsNotNone(self.qemu_bin, 'PYTEST_QEMU_BINARY must be set')
 
     def check_hash(self, file_name, expected_hash):
@@ -294,9 +320,11 @@ def get_qemu_img(self):
 
         # If qemu-img has been built, use it, otherwise the system wide one
         # will be used.
-        qemu_img = os.path.join(BUILD_DIR, 'qemu-img')
-        if not os.path.exists(qemu_img):
-            qemu_img = find_command('qemu-img', False)
+        qemu_img = Path(_build_dir(), 'qemu-img')
+        if qemu_img.exists():
+            return str(qemu_img)
+
+        qemu_img = find_command('qemu-img', False)
         if qemu_img is False:
             self.cancel('Could not find "qemu-img"')
 

This also allows for executing the tests directly without even involving
pytest if we make one slight further change to each individual tests:

diff --git a/tests/pytest/test_info_usernet.py b/tests/pytest/test_info_usernet.py
index 0cc3697c0b..aa7abb6a5e 100644
--- a/tests/pytest/test_info_usernet.py
+++ b/tests/pytest/test_info_usernet.py
@@ -8,6 +8,8 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
+import unittest
+
 from qemu_pytest import QemuSystemTest
 
 from qemu.utils import get_info_usernet_hostfwd_port
@@ -29,3 +31,6 @@ def test_hostfwd(self):
         self.assertGreater(port, 0,
                            ('Found a redirected port that is not greater than'
                             ' zero'))
+
+if __name__ == '__main__':
+    unittest.main()


and chmod +x tests/pytest/*.py, then that lets us simply run

  PYTEST_QEMU_BINARY=./build/qemu-system-aarch64 \
  PYTHONPATH=./python \
  build/tests/pytest/test_info_usernet.py 

being able to run with zero harness is nice for debugging problems,
especially if you want to be strace'ing tests without the harness
in the middle, which is something I've often wanted.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


