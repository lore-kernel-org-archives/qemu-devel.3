Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF51C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 19:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdtM-0001E2-6n; Mon, 24 Feb 2025 14:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tmdsD-0000bx-KV
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:12:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tmdsB-0005vd-HB
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740424326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+cpCX4il9fjErP7OOakJXWhN6hcU0kmAb/KDCG4CX78=;
 b=Oqr1aDVpHUyJ9seMlH+2qU0XVnuUZwMdODEvH8WN+dGhr9OxXXs3BvToWAVD8mYsbtjboC
 VvBA1VpMEqxiQnp2RyBMFsvl3b6K72I1Gn5tV20f1gubseygOidKBWrY23+xGmdUa5/4lD
 DniFHhqoKLS2AuuUBwvjkxhGl5XaHd4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-EGcLyeL4O16-XhSG0xeobA-1; Mon,
 24 Feb 2025 14:12:04 -0500
X-MC-Unique: EGcLyeL4O16-XhSG0xeobA-1
X-Mimecast-MFC-AGG-ID: EGcLyeL4O16-XhSG0xeobA_1740424324
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC3121800373; Mon, 24 Feb 2025 19:12:03 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.119])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 255BB1800352; Mon, 24 Feb 2025 19:12:00 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [RFC 2/2] python: integrate linter tests natively with meson
Date: Mon, 24 Feb 2025 19:11:52 +0000
Message-ID: <20250224191152.2123003-3-berrange@redhat.com>
In-Reply-To: <20250224191152.2123003-1-berrange@redhat.com>
References: <20250224191152.2123003-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This creates meson test targets for the python linters which has a
number of benefits:

 * They can be invoked in the same manner as all other tests
   using meson or ninja, or the top level Makefile wrappers
 * They avoid the extra indirection of running via avocado
 * They get run by default when doing 'make check'

There is one general 'python' suite defined, and then a 'pythonVER'
suite for each tox environment listed in python/setup.cfg.

All python linters across all version get triggered by 'make check'.

To run just the python linters without other tests

  $ make check-python

To run just the python linters for Python 3.12

  $ make check-python312

Static lints can be enabled per source directory in meson.build by
adding

 pythontests += {
    'dir': meson.current_source_dir(),
    'pylint': true,
    'mypy': true,
    'flake8': true,
    'isort': true,
 }

If any given lint is omitted in the config, it defaults to disabled.

When the '--disable-downloads' option is given to 'configure', running
of the python tests is disabled since tox would otherwise attempt to
download files to populate the per-version envs.

TBD: if you have meson < 1.7, then 'build_by_default: false' does
not work correctly, so the tox envs get created by 'make', rather
than delayed until 'make check'. We could bump min meson to fix this
or accept that older versions have sub-optimal behaviour

TBD: setup.cfg defines 6 python venvs 3.8 -> 3.13 currently, which
gives alot of duplication in what we run with 'make check' by default.
This adds about 1 minute of wallclock time to a non-parallel build on
my (high end) laptop, or 15 seconds to a parallel build. This is a
combination of populating the tox envs, and pylint being generally
slow. IIRC there's a way to split tests in 'quick' vs 'thorough' so
'make check' runs 'quick' only by default, but I've not investigated
this yet.

TBD: purge python/Makefile and python/tests/*.sh wrappers. It is
desirable to have only one way of running tests that everyone agrees
on, so that we have consistency of results. Assuming the native meson
integration is good enough, this should make the Makefile obsolete,
as well as the .sh wrappers.

TBD: I added isort & mypy for the 'scripts/qapi' code as a demo, but
flake8 & pylint don't pass so are disabled.

TBD: I've not figured out a nice way to integrate qemu-iotests without
the linters.py indirection which is painful to consume. Perhaps solvable
by just giving all the iotests real file extensions (.sh & .py) so the
linters can auto-detect python files. Would then need to have an exclude
list in qemu-iotests/meson.build to skip non-compliant files initially.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build                |  1 +
 python/meson.build         | 43 ++++++++++++++++++++++++++++++++++++++
 python/scripts/__init__.py |  0
 scripts/meson.build        |  9 ++++++++
 tests/meson.build          |  1 +
 tests/python/meson.build   | 17 +++++++++++++++
 6 files changed, 71 insertions(+)
 create mode 100644 python/meson.build
 create mode 100644 python/scripts/__init__.py
 create mode 100644 tests/python/meson.build

diff --git a/meson.build b/meson.build
index 0ee79c664d..f1cbfda149 100644
--- a/meson.build
+++ b/meson.build
@@ -4440,6 +4440,7 @@ if stap.found()
   endforeach
 endif
 
+subdir('python')
 subdir('scripts')
 subdir('tools')
 subdir('pc-bios')
diff --git a/python/meson.build b/python/meson.build
new file mode 100644
index 0000000000..73360b6d43
--- /dev/null
+++ b/python/meson.build
@@ -0,0 +1,43 @@
+
+tox = find_program('tox', required: false)
+toxcfg = ['-c', meson.current_source_dir(),
+          '--workdir', meson.current_source_dir(),
+          '--root', meson.current_source_dir()]
+pythonlints = ['pylint', 'mypy', 'flake8', 'isort']
+
+pythontests = [
+    {
+        'dir': meson.current_source_dir() / 'qemu',
+        'pylint': true,
+        'mypy': true,
+        'flake8': true,
+        'isort': true,
+    },
+    {
+        'dir': meson.current_source_dir() / 'scripts',
+        'pylint': true,
+        'mypy': true,
+        'flake8': true,
+        'isort': true,
+    },
+]
+
+pyenvs = []
+if tox.found() and get_option('wrap_mode') != 'nodownload'
+    rc = run_command([tox, 'list'] + toxcfg,
+                     capture: true,
+                     check: true)
+
+    foreach envline: rc.stdout().strip().split('\n')
+        if envline.startswith('py')
+            pyenv = envline.split(' ')[0]
+            message('Adding python environment: ' + pyenv)
+
+            mkenv = custom_target('tox-env-' + pyenv,
+                                  command: [tox, 'run', '-e', pyenv, '--notest'] + toxcfg,
+                                  output: pyenv,
+                                  build_by_default: false)
+            pyenvs += { 'name': pyenv, 'version': pyenv.substring(2), 'target': mkenv }
+        endif
+    endforeach
+endif
diff --git a/python/scripts/__init__.py b/python/scripts/__init__.py
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/scripts/meson.build b/scripts/meson.build
index 532277f5a2..6a1fd9e5a9 100644
--- a/scripts/meson.build
+++ b/scripts/meson.build
@@ -3,3 +3,12 @@ if stap.found()
 endif
 
 test('xml-preprocess', files('xml-preprocess-test.py'), suite: ['unit'])
+
+
+pythontests += {
+    'dir': meson.current_source_dir() / 'qapi',
+    'pylint': false,
+    'mypy': true,
+    'flake8': false,
+    'isort': true,
+}
diff --git a/tests/meson.build b/tests/meson.build
index c59619220f..89eed7d259 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -88,3 +88,4 @@ subdir('qapi-schema')
 subdir('qtest')
 subdir('migration-stress')
 subdir('functional')
+subdir('python')
diff --git a/tests/python/meson.build b/tests/python/meson.build
new file mode 100644
index 0000000000..28be424d85
--- /dev/null
+++ b/tests/python/meson.build
@@ -0,0 +1,17 @@
+
+foreach pyenv: pyenvs
+    foreach scenario: pythontests
+        suites = ['python', 'python' + pyenv['version']]
+
+        foreach lint: pythonlints
+            if scenario.get(lint, false)
+                name = lint + scenario['dir'].replace(meson.project_source_root(), '').replace('/', '-')
+                toxargs = toxcfg + ['exec', '-e', pyenv['name'],
+                                    '--',
+                                    'python3', '-m', lint,
+                                    scenario['dir']]
+                test(name, tox, args: toxargs, suite: suites, depends: pyenv['target'])
+            endif
+        endforeach
+    endforeach
+endforeach
-- 
2.47.1


