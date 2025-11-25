Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3033CFD364
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 04:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNkFk-0003gW-Ff; Mon, 24 Nov 2025 23:02:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vNkEm-0003Ev-5h
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 23:01:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vNkEk-0006WC-GR
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 23:01:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764043265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ymPqiV5bndhbbGY7pz1WSihf6pH46xZBKrdEXfr2wLQ=;
 b=Y34uF9+vNE5V7jq95nvhcg+lNbIDAVMTN+vdO1froHoRaWRHNT+uwsSiC1ShOWdZYDpr50
 8lGLkXiUK1c3u0ASkNCdCmsPIHeEgQmNBJ5S7WhzUcPCPiG6dqrtbjk1cXYsQnwBUSvyfU
 +N+qDPsPnefqGfJDLr0kZZwRNT3an/E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-Mv2Tuyj3ORe3X4Svzg8hnA-1; Mon,
 24 Nov 2025 23:01:01 -0500
X-MC-Unique: Mv2Tuyj3ORe3X4Svzg8hnA-1
X-Mimecast-MFC-AGG-ID: Mv2Tuyj3ORe3X4Svzg8hnA_1764043260
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFDF81800370; Tue, 25 Nov 2025 04:01:00 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA5C118004D8; Tue, 25 Nov 2025 04:00:58 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH v2 04/16] meson,
 mkvenv: add checktests and functests custom targets
Date: Mon, 24 Nov 2025 23:00:32 -0500
Message-ID: <20251125040045.461148-5-jsnow@redhat.com>
In-Reply-To: <20251125040045.461148-1-jsnow@redhat.com>
References: <20251125040045.461148-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

add "pyvenv_checktests_group" and "pyvenv_functests_group" targets to
meson. These targets will invoke mkvenv.py to install the associated
dependency group to the build/pyvenv directory.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 meson.build        |  1 +
 pyvenv/meson.build | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 pyvenv/meson.build

diff --git a/meson.build b/meson.build
index d9293294d8e..d7f06b8392b 100644
--- a/meson.build
+++ b/meson.build
@@ -4587,6 +4587,7 @@ subdir('scripts')
 subdir('tools')
 subdir('pc-bios')
 subdir('docs')
+subdir('pyvenv')
 # Tests are disabled on emscripten because they rely on host features that aren't
 # supported by emscripten (e.g. fork and unix socket).
 if host_os != 'emscripten'
diff --git a/pyvenv/meson.build b/pyvenv/meson.build
new file mode 100644
index 00000000000..f5638eacd5f
--- /dev/null
+++ b/pyvenv/meson.build
@@ -0,0 +1,36 @@
+# Note that this file only controls "optional" dependency groups; groups
+# *required* for the build are handled directly in configure instead:
+# namely, meson and sphinx.
+
+pyvenv_common_deps = files(
+    meson.project_source_root() + '/pythondeps.toml',
+    meson.project_source_root() + '/python/scripts/mkvenv.py'
+)
+pyvenv_wheel_dir = meson.project_source_root() + '/python/wheels'
+
+
+# This group must be available offline
+pyvenv_checktests_group = custom_target(
+    'pyvenv_checktests_group',
+    output: 'checktests.group',
+    input: pyvenv_common_deps,
+    command: [ python, '@INPUT1@',
+               'ensuregroup',
+               '--dir', pyvenv_wheel_dir,
+               '@INPUT0@',
+               'checktests' ],
+)
+
+# This group is allowed to fetch from PyPI.
+pyvenv_functests_group = custom_target(
+    'pyvenv_functests_group',
+    output: 'functests.group',
+    input: pyvenv_common_deps,
+    depends: pyvenv_checktests_group,
+    command: [ python, '@INPUT1@',
+               'ensuregroup',
+               '--online',
+               '--dir', pyvenv_wheel_dir,
+               '@INPUT0@',
+               'functests' ],
+)
-- 
2.51.1


