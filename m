Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6058E8B365
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 20:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnN8R-0004tQ-D9; Tue, 03 Feb 2026 15:36:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vnN8Q-0004t0-O0
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:36:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vnN8O-00018D-2k
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770150987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K/iYy/9/6r3cRoFsMydhtnY6mu+gNhWJOabPmJ4/nmo=;
 b=gw87QpkfW5x2JPiHt/v9Qas+DHwOEzlnlac9w96iqwSg2o1JJIC5PCFFZWJPcSO4lFr4R1
 e680jV/o7g8B2MlB9fGKzXRpVQ9RsXnqsaZ/vGX07aOSHyu/ByJOCWAxJvVkxOiCanzfTR
 QMAraWpm0MxSyEvW6+GX7+SR4vDV0QQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-xko4xH5kOvy0g3etUNzysA-1; Tue,
 03 Feb 2026 15:36:21 -0500
X-MC-Unique: xko4xH5kOvy0g3etUNzysA-1
X-Mimecast-MFC-AGG-ID: xko4xH5kOvy0g3etUNzysA_1770150978
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8FE61956096; Tue,  3 Feb 2026 20:36:18 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.43])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C331018004D8; Tue,  3 Feb 2026 20:36:15 +0000 (UTC)
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
Subject: [PATCH v5 16/16] python: update README.rst to reflect qemu.qmp's
 removal
Date: Tue,  3 Feb 2026 15:35:11 -0500
Message-ID: <20260203203512.672552-17-jsnow@redhat.com>
In-Reply-To: <20260203203512.672552-1-jsnow@redhat.com>
References: <20260203203512.672552-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It is no longer simply possible to just use this directory as if it were
an installed package now that it has dependencies, so update the README
to reflect this.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/README.rst | 50 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/python/README.rst b/python/README.rst
index d62e71528d2..02cb481f19e 100644
--- a/python/README.rst
+++ b/python/README.rst
@@ -3,7 +3,17 @@ QEMU Python Tooling
 
 This directory houses Python tooling used by the QEMU project to build,
 configure, and test QEMU. It is organized by namespace (``qemu``), and
-then by package (e.g. ``qemu/machine``, ``qemu/qmp``, etc).
+then by package (e.g. ``qemu/machine``, ``qemu/utils``, etc).
+
+These tools and libraries are installed to the QEMU configure-time
+Python virtual environment by default (see qemu.git/pythondeps.toml
+"tooling" group), and are available for use by any Python script
+executed by the build system. To have these libraries available for
+manual invocations of scripts, use of the "run" script in your build
+directory is recommended.
+
+General structure
+-----------------
 
 ``setup.py`` is used by ``pip`` to install this tooling to the current
 environment. ``setup.cfg`` provides the packaging configuration used by
@@ -20,9 +30,9 @@ environment. ``setup.cfg`` provides the packaging configuration used by
 
 If you append the ``--editable`` or ``-e`` argument to either invocation
 above, pip will install in "editable" mode. This installs the package as
-a forwarder ("qemu.egg-link") that points to the source tree. In so
-doing, the installed package always reflects the latest version in your
-source tree.
+a forwarder that points to the source tree. In so doing, the installed
+package always reflects the latest version in your source tree. This is
+the mode used to install these packages at configure time.
 
 Installing ".[devel]" instead of "." will additionally pull in required
 packages for testing this package. They are not runtime requirements,
@@ -40,8 +50,18 @@ for more information.
 Using these packages without installing them
 --------------------------------------------
 
-These packages may be used without installing them first, by using one
-of two tricks:
+It is no longer recommended to try to use these packages without
+installing them to a virtual environment, but depending on your use
+case, it may still be possible to do.
+
+The "qemu.qmp" library is now hosted outside of the qemu.git repository,
+and the "qemu.machine" library that remains in-tree here has qemu.qmp as
+a dependency. It is possible to install "qemu.qmp" independently and
+then use the rest of these packages without installing them, but be
+advised that if future dependencies are introduced, bypassing the
+installation phase may introduce breakages to your script in the future.
+
+That said, you can use these packages without installing them by either:
 
 1. Set your PYTHONPATH environment variable to include this source
    directory, e.g. ``~/src/qemu/python``. See
@@ -61,8 +81,24 @@ invoke them without installation, you can invoke e.g.:
 
 ``> PYTHONPATH=~/src/qemu/python python3 -m qemu.qmp.qmp_shell``
 
+Or, with the run script available in the QEMU build directory, simply:
+
+``> $builddir/run qmp-shell``
+
 The mappings between console script name and python module path can be
-found in ``setup.cfg``.
+found in ``setup.cfg``, but the console scripts available are listed
+here for reference:
+
+* ``qemu-ga-client``
+* ``qmp-shell``
+* ``qmp-shell-wrap``
+* ``qmp-tui`` (prototype urwid interface for async QMP)
+* ``qom``
+* ``qom-fuse`` (requires fusepy to be installed!)
+* ``qom-get``
+* ``qom-list``
+* ``qom-set``
+* ``qom-tree``
 
 
 Files in this directory
-- 
2.52.0


