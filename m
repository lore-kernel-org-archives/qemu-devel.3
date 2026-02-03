Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A12E8B363
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 20:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnN7k-0003Vz-Cx; Tue, 03 Feb 2026 15:35:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vnN7d-0003UI-Di
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:35:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vnN7b-0000mb-Ov
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:35:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770150939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=INsCdA8ORqDRFPrjAiL1krAJRf580qAaCr1ibMzw0vc=;
 b=gwj3HVBxBOQSaCqLvjJQF+d2Oxk95snEE0jYjKcVNqeMSdtMpw/J3LeNuoXC9ajBcEi4wH
 NyEKW1QheIZteMFTYnir1LTYXl1Tat56vW2Mj7C5Y5k6dHFdh+EvSVBXaU5JmOnjsDKoXr
 +cEcQFGxSMYf/944QTIC5v3nzKVENgk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-icMubE2XPg2jZtKbvQSKiw-1; Tue,
 03 Feb 2026 15:35:35 -0500
X-MC-Unique: icMubE2XPg2jZtKbvQSKiw-1
X-Mimecast-MFC-AGG-ID: icMubE2XPg2jZtKbvQSKiw_1770150934
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D63F618005B0; Tue,  3 Feb 2026 20:35:33 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.43])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 867B918007D2; Tue,  3 Feb 2026 20:35:30 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v5 04/16] python/mkvenv: add mechanism to install local
 package(s)
Date: Tue,  3 Feb 2026 15:34:59 -0500
Message-ID: <20260203203512.672552-5-jsnow@redhat.com>
In-Reply-To: <20260203203512.672552-1-jsnow@redhat.com>
References: <20260203203512.672552-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

This patch adds a path constraint that can be used in lieu of version
constraints to specify that a package should be installed from the
source tree instead of from PyPI or vendored packages. This is done to
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
an offline, isolated environment. These extra dependencies are handled
in a forthcoming commit; for now, nothing is utilizing this new pathway.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/scripts/mkvenv.py | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index b4662d33e6e..8ed6a354505 100644
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
 
@@ -733,9 +735,14 @@ def _do_ensure(
     :param wheels_dir: If specified, search this path for packages.
     """
     absent = []
+    local_packages = []
     present = []
     canary = None
     for name, info in group.items():
+        if "path" in info:
+            pkgpath = Path(__file__).parents[2].joinpath(info["path"])
+            local_packages.append(str(pkgpath))
+            continue
         constraint = _make_version_constraint(info, False)
         matcher = Matcher(name + constraint)
         print(f"mkvenv: checking for {matcher}", file=sys.stderr)
@@ -770,15 +777,33 @@ def _do_ensure(
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
2.52.0


