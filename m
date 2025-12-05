Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672F4D2CDE3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 06:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vROtB-0001cn-Rj; Fri, 05 Dec 2025 01:01:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vROt8-0001bE-50
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 01:01:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vROt6-0001Eh-IZ
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 01:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764914511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nIK4ibKDtmu1ITn2OJ8q06DGuhJdFYFYZ5om4h0mpLk=;
 b=J09A2NT80jECsYHqnYLzOvyyzelQNarb0ZV4YuWFLlS6WHBehh27kzZ6iKwZeySz4rvqHh
 kf3qOWQdtaoAh4oO7DhVR37EbhJNtUUO5R8KL0Yzav7qAHRswZu1BRYVCHZ79yleRk9FLe
 e/+WKLPX7Fbp4+t+igrg9fAb9jQX4+4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-K9TIrqKnOmKnAqUL8jldjg-1; Fri,
 05 Dec 2025 01:01:27 -0500
X-MC-Unique: K9TIrqKnOmKnAqUL8jldjg-1
X-Mimecast-MFC-AGG-ID: K9TIrqKnOmKnAqUL8jldjg_1764914486
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 259181956063; Fri,  5 Dec 2025 06:01:26 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.55])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 33A713011A84; Fri,  5 Dec 2025 06:01:20 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Michael Roth <michael.roth@amd.com>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 04/15] python/mkvenv: add mechanism to install local
 package(s)
Date: Fri,  5 Dec 2025 01:00:46 -0500
Message-ID: <20251205060058.1503170-5-jsnow@redhat.com>
In-Reply-To: <20251205060058.1503170-1-jsnow@redhat.com>
References: <20251205060058.1503170-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Currently, we "implicitly" install the local 'qemu' python package for
'make check-venv' with some logic inside tests/Makefile.include. I would
like to make this installation explicit in pythondeps.toml instead.

The version constraint specification that Python specifies does not
support relative paths, so it is difficult (or impossible?) to specify a
path within the source tree, and we will need a workaround to do so.

By specifying a package name that starts with $SRCROOT, you can now
specify a file path to a local package for installation. This is done to
allow us to install the python packages hosted inside of the tree while
also processing dependencies; i.e. so that our "qemu" package can
specify that it needs "qemu.qmp", which soon will not be included in
qemu.git.

This also has the benefit of being able to specify in a declarative
configuration file that our pyvenv environment *will* have our local
python packages installed and available without any PYTHONPATH hacks,
which should simplify iotests, device-crash-test and functional tests
without needing to manage local inclusion paths in environment
variables.

On the downsides, installing packages through mkvenv/ensuregroup means
that there are extra steps we need to take in order to install a local
package *offline*; namely we must disable build isolation (so we have
access to setuptools) and we must also include python3-wheel in QEMU's
build dependencies in order for "make check" to run successfully when in
an offline, isolated environment.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/scripts/mkvenv.py | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index a22e3ee3394..608b8faa9b2 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -662,6 +662,7 @@ def pip_install(
     args: Sequence[str],
     online: bool = False,
     wheels_dir: Optional[Union[str, Path]] = None,
+    env: Optional[Dict[str, str]] = None,
 ) -> None:
     """
     Use pip to install a package or package(s) as specified in @args.
@@ -687,6 +688,7 @@ def pip_install(
     full_args += list(args)
     subprocess.run(
         full_args,
+        env=env,
         check=True,
     )
 
@@ -733,9 +735,15 @@ def _do_ensure(
     :param wheels_dir: If specified, search this path for packages.
     """
     absent = []
+    local_packages = []
     present = []
     canary = None
     for name, info in group.items():
+        if name.startswith("$SRCROOT/"):
+            srcroot = Path(__file__).parents[2]
+            pkgpath = name.replace("$SRCROOT/", f"file://{srcroot}/")
+            local_packages.append(pkgpath)
+            continue
         constraint = _make_version_constraint(info, False)
         matcher = Matcher(name + constraint)
         print(f"mkvenv: checking for {matcher}", file=sys.stderr)
@@ -770,15 +778,33 @@ def _do_ensure(
             print(f"mkvenv: installing {', '.join(absent)}", file=sys.stderr)
             try:
                 pip_install(args=absent, online=online, wheels_dir=wheels_dir)
-                return None
+                absent = []
             except subprocess.CalledProcessError:
                 pass
 
-        return diagnose(
-            absent[0],
-            online,
-            wheels_dir,
-            canary,
+        if absent:
+            return diagnose(
+                absent[0],
+                online,
+                wheels_dir,
+                canary,
+            )
+
+    # Handle local packages separately and last so we can use different
+    # installation arguments (-e), and so that any dependencies that may
+    # be covered above will be handled according to the depfile
+    # specifications.
+    if local_packages:
+        print(f"mkvenv: installing {', '.join(local_packages)}",
+              file=sys.stderr)
+        env = dict(os.environ)
+        env['PIP_CONFIG_SETTINGS'] = "editable_mode=compat"
+        pip_install(
+            args=["--no-build-isolation",
+                  "-e"] + local_packages,
+            online=online,
+            wheels_dir=wheels_dir,
+            env=env,
         )
 
     return None
-- 
2.51.1


