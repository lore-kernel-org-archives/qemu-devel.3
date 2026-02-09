Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25EAE7E0D2
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 18:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpWDQ-0005oW-Ra; Mon, 09 Feb 2026 13:42:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vpWD3-0005i6-Rc
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 13:42:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vpWD1-0008Tf-UY
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 13:42:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770662527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U0XBxSX87bJ30yfA4yoOcsk/FPqePhIPqBEmhZWhvu4=;
 b=UVW6b5U9qgC5VbjqImLJ16orIH0zFmwtqxwDAt7Jxlvv2q3uCXcOuufB9mys/QcoGT9YPA
 QHtOmY/8PdG2MX17EUfXfVSvtQayhT5HUxi0e2VKRgc2GZsf48qHwj6OAs3A2Vip9xChtZ
 +Et7p/IG48jcquRe0h63chiF3ELUziU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-N5YTfSKsMMShy4gg7Eyn7A-1; Mon,
 09 Feb 2026 13:42:04 -0500
X-MC-Unique: N5YTfSKsMMShy4gg7Eyn7A-1
X-Mimecast-MFC-AGG-ID: N5YTfSKsMMShy4gg7Eyn7A_1770662522
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D19F1800581; Mon,  9 Feb 2026 18:42:02 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.77])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ED14618003F6; Mon,  9 Feb 2026 18:41:57 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Maksim Davydov <davydov-max@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PATCH v6 05/16] meson, mkvenv: add functests custom target
Date: Mon,  9 Feb 2026 13:41:12 -0500
Message-ID: <20260209184124.1263625-6-jsnow@redhat.com>
In-Reply-To: <20260209184124.1263625-1-jsnow@redhat.com>
References: <20260209184124.1263625-1-jsnow@redhat.com>
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

add the "pyvenv_functests_group" target to meson. This target will
invoke mkvenv.py to install the associated dependency group to the
build/pyvenv directory.

A "pyvenv_tooling_group" is not included here as it is the plan to
always install this group by default, so it will not need an on-demand
trigger.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 meson.build        |  1 +
 pyvenv/meson.build | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 pyvenv/meson.build

diff --git a/meson.build b/meson.build
index 8c6c0a9a32f..1c732a3adba 100644
--- a/meson.build
+++ b/meson.build
@@ -4556,6 +4556,7 @@ subdir('scripts')
 subdir('tools')
 subdir('pc-bios')
 subdir('docs')
+subdir('pyvenv')
 # Tests are disabled on emscripten because they rely on host features that aren't
 # supported by emscripten (e.g. fork and unix socket).
 if host_os != 'emscripten'
diff --git a/pyvenv/meson.build b/pyvenv/meson.build
new file mode 100644
index 00000000000..4e7d8d9fcc4
--- /dev/null
+++ b/pyvenv/meson.build
@@ -0,0 +1,27 @@
+# Note that this file only controls "optional" dependency groups; groups
+# unconditionally installed at configure time are handled in configure
+# instead; namely: meson, sphinx, and the tooling groups.
+
+# Note that this command may or may not include the "--online" flag
+# based on configuration.
+ensuregroup_cmd = config_host['MKVENV_ENSUREGROUP'].split()
+
+pyvenv_common_deps = files(
+    meson.project_source_root() + '/pythondeps.toml',
+    meson.project_source_root() + '/python/scripts/mkvenv.py'
+)
+pyvenv_wheel_dir = meson.project_source_root() + '/python/wheels'
+
+# This group is allowed to (and must) rely on internet to fetch from
+# PyPI. Force the use of the --online flag here.
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


