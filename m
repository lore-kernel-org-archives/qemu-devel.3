Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889DAD2ECEF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 21:26:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhwle-0007SI-Iy; Mon, 19 Jan 2026 16:26:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vhwlZ-0007Fs-Bf
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 16:26:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vhwlW-0007ON-C8
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 16:26:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768857985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nhqf6UDFYsexs/pw/I/lDafG4BN8D1dYeZUdtvqNzoI=;
 b=DWfS8KQ894R30E3qwIoexqyI3/7SF0HHs0iCA9pcBTk+5Qlg+Al42rV/LTO2hv3Or2Jc3I
 fVOwR5wNkwjGhHIX+2nrD6/t4AW5zoMcCvb+S/3hl8TnDTxqc5bPszBRhntyk4WLYKUNk6
 eVng1/BBRTvASDONaTpkF8gs0IZ34j8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-vZxXVcR5O-mnEJ9XzHE50g-1; Mon,
 19 Jan 2026 16:26:21 -0500
X-MC-Unique: vZxXVcR5O-mnEJ9XzHE50g-1
X-Mimecast-MFC-AGG-ID: vZxXVcR5O-mnEJ9XzHE50g_1768857980
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CF1D1955DD6; Mon, 19 Jan 2026 21:26:20 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.170])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A07561800285; Mon, 19 Jan 2026 21:26:16 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Maksim Davydov <davydov-max@yandex-team.ru>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 05/17] meson, mkvenv: add functests custom target
Date: Mon, 19 Jan 2026 16:25:41 -0500
Message-ID: <20260119212554.1274940-6-jsnow@redhat.com>
In-Reply-To: <20260119212554.1274940-1-jsnow@redhat.com>
References: <20260119212554.1274940-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
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

add the "pyvenv_functests_group" target to meson. This target will
invoke mkvenv.py to install the associated dependency group to the
build/pyvenv directory.

A "pyvenv_tooling_group" is not included here as it is the plan to
always install this group by default, so it will not need an on-demand
trigger.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 meson.build        |  1 +
 pyvenv/meson.build | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 pyvenv/meson.build

diff --git a/meson.build b/meson.build
index 3108f01e887..245f1bc2ec9 100644
--- a/meson.build
+++ b/meson.build
@@ -4551,6 +4551,7 @@ subdir('scripts')
 subdir('tools')
 subdir('pc-bios')
 subdir('docs')
+subdir('pyvenv')
 # Tests are disabled on emscripten because they rely on host features that aren't
 # supported by emscripten (e.g. fork and unix socket).
 if host_os != 'emscripten'
diff --git a/pyvenv/meson.build b/pyvenv/meson.build
new file mode 100644
index 00000000000..2bfddeb4a52
--- /dev/null
+++ b/pyvenv/meson.build
@@ -0,0 +1,28 @@
+# Note that this file only controls "optional" dependency groups; groups
+# *required* for the build are handled directly in configure instead:
+# namely, meson and sphinx.
+
+# NB: This command may or may not include the "--online" flag, depending
+# on the results of configure.
+ensuregroup_cmd = config_host['MKVENV_ENSUREGROUP'].split()
+
+pyvenv_common_deps = files(
+    meson.project_source_root() + '/pythondeps.toml',
+    meson.project_source_root() + '/python/scripts/mkvenv.py'
+)
+pyvenv_wheel_dir = meson.project_source_root() + '/python/wheels'
+
+
+# This group is allowed to rely on internet, to fetch from PyPI.
+# If --online was not passed to configure, this could fail.
+pyvenv_functests_group = custom_target(
+    'pyvenv_functests_group',
+    output: 'functests.group',
+    input: pyvenv_common_deps,
+    command: ensuregroup_cmd + [
+        '--online',
+        '--dir', pyvenv_wheel_dir,
+        '@INPUT0@',
+        'functests',
+    ],
+)
-- 
2.52.0


