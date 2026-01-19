Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC7ED2ECEB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 21:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhwov-000553-Ap; Mon, 19 Jan 2026 16:29:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vhwnw-0002bJ-JY
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 16:28:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vhwns-0008BW-VD
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 16:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768858132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ljhEhssPgyrB7dLIkS5v8vKHv0Ai7A7GGII1huvURUI=;
 b=fvBkLKGw97CLW2cxOe2xBY669JOkztbjFkFuuTEhYEOPvvUUkk/wEwW14rTyPiE2qKfjHE
 xWck5d3iHT7p4sWQHvKENEb9VQDyZHfy3lp1a1lQtZlTd2+6G8wL3NuZE+LcjHGls+8STr
 rR+Yf3MqhuGFn7Zh0AlakB7H2yXv4Oo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-789aJZllMWaUGacroZhM-A-1; Mon,
 19 Jan 2026 16:28:48 -0500
X-MC-Unique: 789aJZllMWaUGacroZhM-A-1
X-Mimecast-MFC-AGG-ID: 789aJZllMWaUGacroZhM-A_1768858126
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BF781956054; Mon, 19 Jan 2026 21:28:46 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.170])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1EF9519560AB; Mon, 19 Jan 2026 21:28:43 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Maksim Davydov <davydov-max@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Hanna Reitz <hreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Ed Maste <emaste@freebsd.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 10/17] meson,
 mkvenv: make functional tests depend on functests group
Date: Mon, 19 Jan 2026 16:27:36 -0500
Message-ID: <20260119212744.1275455-11-jsnow@redhat.com>
In-Reply-To: <20260119212744.1275455-1-jsnow@redhat.com>
References: <20260119212744.1275455-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
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

Note that only the thorough group requires the extra testing
dependencies; the quick group will run with just the "tooling" group,
which we intend to install by default at configure time in a forthcoming
commit.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/functional/meson.build | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 725630d3082..e1f5c0e7678 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -57,6 +57,8 @@ foreach speed : ['quick', 'thorough']
       continue
     endif
 
+    test_deps = [roms, keymap_targets]
+
     if speed == 'quick'
       suites = ['func-quick', 'func-' + target_base]
       target_tests = get_variable('tests_' + target_base + '_' + sysmode + '_quick', []) \
@@ -64,9 +66,9 @@ foreach speed : ['quick', 'thorough']
     else
       suites = ['func-' + speed, 'func-' + target_base + '-' + speed, speed]
       target_tests = get_variable('tests_' + target_base + '_' + sysmode + '_' + speed, [])
+      test_deps += [pyvenv_functests_group]
     endif
 
-    test_deps = [roms, keymap_targets]
     test_env = environment()
     if have_tools
       test_env.set('QEMU_TEST_QEMU_IMG', meson.global_build_root() / 'qemu-img')
@@ -99,6 +101,7 @@ foreach speed : ['quick', 'thorough']
       precache = custom_target('func-precache-' + testname,
                                output: teststamp,
                                command: [python, testpath],
+                               depends: pyvenv_functests_group,
                                depend_files: files(testpath),
                                build_by_default: false,
                                env: test_precache_env)
-- 
2.52.0


