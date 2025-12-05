Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF03D2E008
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 06:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vROtg-0002E8-DL; Fri, 05 Dec 2025 01:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vROtU-00024P-Bp
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 01:02:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vROtS-0001In-Qs
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 01:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764914534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vt+SZNzBJoFLFiWFQgyxLD52fDXDASFagoh3QZx4wxQ=;
 b=J6603Df1qXRDX4EVef/uNpF8ghndC6VuHhb2mAhMr0ZG6UYi9XdUMiFPvGhPTGgykP3vdO
 AfPfkSskreotWSqtDtA+pUGyB/ekiHNutV92KOxHCdVmdvwH4Ldq0M213bqlewA1Lxt5ey
 QfxU2OfzT51/faBCAv9y3a4WTlSUzKY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-goCOzmmSNmCIJLxnOchA0A-1; Fri,
 05 Dec 2025 01:02:09 -0500
X-MC-Unique: goCOzmmSNmCIJLxnOchA0A-1
X-Mimecast-MFC-AGG-ID: goCOzmmSNmCIJLxnOchA0A_1764914528
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 958E518002EC; Fri,  5 Dec 2025 06:02:08 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.55])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 80ED83000701; Fri,  5 Dec 2025 06:02:04 +0000 (UTC)
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
Subject: [PATCH v3 12/15] meson,
 mkvenv: make functional tests depend on functests group
Date: Fri,  5 Dec 2025 01:00:54 -0500
Message-ID: <20251205060058.1503170-13-jsnow@redhat.com>
In-Reply-To: <20251205060058.1503170-1-jsnow@redhat.com>
References: <20251205060058.1503170-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Note that only the thorough group requires the extra testing
dependencies; the quick group is guaranteed to run with our minimal
testing dependency set.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/functional/meson.build | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 725630d3082..b8424a10376 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -57,16 +57,20 @@ foreach speed : ['quick', 'thorough']
       continue
     endif
 
+    test_deps = [roms, keymap_targets]
+
     if speed == 'quick'
       suites = ['func-quick', 'func-' + target_base]
       target_tests = get_variable('tests_' + target_base + '_' + sysmode + '_quick', []) \
                      + get_variable('tests_generic_' + sysmode)
+      test_deps += [pyvenv_checktests_group]
     else
       suites = ['func-' + speed, 'func-' + target_base + '-' + speed, speed]
       target_tests = get_variable('tests_' + target_base + '_' + sysmode + '_' + speed, [])
+      test_deps += [pyvenv_functests_group]
     endif
 
-    test_deps = [roms, keymap_targets]
+
     test_env = environment()
     if have_tools
       test_env.set('QEMU_TEST_QEMU_IMG', meson.global_build_root() / 'qemu-img')
@@ -99,6 +103,7 @@ foreach speed : ['quick', 'thorough']
       precache = custom_target('func-precache-' + testname,
                                output: teststamp,
                                command: [python, testpath],
+                               depends: pyvenv_functests_group,
                                depend_files: files(testpath),
                                build_by_default: false,
                                env: test_precache_env)
-- 
2.51.1


