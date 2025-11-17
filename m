Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E81CEBF8D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 18:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL4MK-0003t3-Ca; Mon, 17 Nov 2025 13:53:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vL4Kr-0002k1-La
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 13:52:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vL4Kp-00089v-SY
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 13:52:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763405539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=My6nnBh84bMr0XzxdTm9zizvBrB/58C97qMYov5euxo=;
 b=CIX8RXL3f9JdlAKlSVB1syDZAAkHYW5R1u88EdoROJ7lAKD/DdwZ+72phfBfaJNJw8J2nV
 c24DW8aTvGyDK5beS8Tfws84+6ErY48Z/W4AputpciRtIq9RZr0EyAhLcXSi6SDJy9OeLW
 PGYZdDMdsop1U31bUbwVVEIc69tuDzU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361--DLTxW08M-eqZG0wz8ss2A-1; Mon,
 17 Nov 2025 13:52:15 -0500
X-MC-Unique: -DLTxW08M-eqZG0wz8ss2A-1
X-Mimecast-MFC-AGG-ID: -DLTxW08M-eqZG0wz8ss2A_1763405534
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FEC1180048E; Mon, 17 Nov 2025 18:52:14 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.81.70])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 166BF180047F; Mon, 17 Nov 2025 18:52:11 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 13/22] mtest2make: cleanup mtest-suites variables
Date: Mon, 17 Nov 2025 13:51:21 -0500
Message-ID: <20251117185131.953681-14-jsnow@redhat.com>
In-Reply-To: <20251117185131.953681-1-jsnow@redhat.com>
References: <20251117185131.953681-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Paolo Bonzini <pbonzini@redhat.com>

Remove the "--suite" argument from the .*.mtest-suites variables, and
add it only when actually computing the arguments to "meson test".
This makes it possible to look at the set of suites to set ninja-cmd-goals,
instead of doing it via many different .ninja-goals.* variables.

As a bonus, this removes code duplication between emit_suite_deps
and its caller emit_suite.  Since emit_suite_deps would now be one or
two lines of code, integrate it into emit_suite directly.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 Makefile              |  4 +++-
 scripts/mtest2make.py | 33 +++++++++++++--------------------
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/Makefile b/Makefile
index 74c2da20372..9fb55dcf330 100644
--- a/Makefile
+++ b/Makefile
@@ -96,6 +96,8 @@ meson.stamp: config-host.mak
 
 # 3. ensure meson-generated build files are up-to-date
 
+ninja-cmd-goals =
+
 ifneq ($(NINJA),)
 Makefile.ninja: build.ninja
 	$(quiet-@){ \
@@ -150,7 +152,7 @@ NINJAFLAGS = \
           $(or $(filter -l% -j%, $(MAKEFLAGS)), \
                $(if $(filter --jobserver-auth=%, $(MAKEFLAGS)),, -j1))) \
         -d keepdepfile
-ninja-cmd-goals = $(or $(MAKECMDGOALS), all)
+ninja-cmd-goals += $(or $(MAKECMDGOALS), all)
 ninja-cmd-goals += $(foreach g, $(MAKECMDGOALS), $(.ninja-goals.$g))
 
 makefile-targets := build.ninja ctags TAGS cscope dist clean
diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index 2ef375fc6fb..af4ee56de54 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -20,12 +20,12 @@ def names(self, base):
         return [base if speed == 'quick' else f'{base}-{speed}' for speed in self.speeds]
 
 
-print('''
+print(r'''
 SPEED = quick
 
-.speed.quick = $(foreach s,$(sort $(filter-out %-slow %-thorough, $1)), --suite $s)
-.speed.slow = $(foreach s,$(sort $(filter-out %-thorough, $1)), --suite $s)
-.speed.thorough = $(foreach s,$(sort $1), --suite $s)
+.speed.quick = $(sort $(filter-out %-slow %-thorough, $1))
+.speed.slow = $(sort $(filter-out %-thorough, $1))
+.speed.thorough = $(sort $1)
 
 TIMEOUT_MULTIPLIER ?= 1
 .mtestargs = --no-rebuild -t $(TIMEOUT_MULTIPLIER)
@@ -34,8 +34,10 @@ def names(self, base):
 endif
 .mtestargs += $(subst -j,--num-processes , $(filter-out -j, $(lastword -j1 $(filter -j%, $(MAKEFLAGS)))))
 
-.check.mtestargs = $(MTESTARGS) $(.mtestargs) $(if $(V),--verbose,--print-errorlogs)
-.bench.mtestargs = $(MTESTARGS) $(.mtestargs) --benchmark --verbose''')
+.check.mtestargs = $(MTESTARGS) $(.mtestargs) $(if $(V),--verbose,--print-errorlogs) \
+    $(foreach s, $(sort $(.check.mtest-suites)), --suite $s)
+.bench.mtestargs = $(MTESTARGS) $(.mtestargs) --benchmark --verbose \
+    $(foreach s, $(sort $(.bench.mtest-suites)), --suite $s)''')
 
 introspect = json.load(sys.stdin)
 
@@ -72,29 +74,20 @@ def emit_prolog(suites, prefix):
     print(f'all-{prefix}-targets = {all_targets}')
     print(f'all-{prefix}-xml = {all_xml}')
     print(f'.PHONY: {prefix} do-meson-{prefix} {prefix}-report.junit.xml $(all-{prefix}-targets) $(all-{prefix}-xml)')
-    print(f'ifeq ($(filter {prefix}, $(MAKECMDGOALS)),)')
-    print(f'.{prefix}.mtestargs += $(call .speed.$(SPEED), $(.{prefix}.mtest-suites))')
-    print(f'endif')
+    print(f'ninja-cmd-goals += $(foreach s, $(.{prefix}.mtest-suites), $(.{prefix}-$s.deps))')
     print(f'{prefix}-build: run-ninja')
     print(f'{prefix} $(all-{prefix}-targets): do-meson-{prefix}')
     print(f'do-meson-{prefix}: run-ninja; $(if $(MAKE.n),,+)$(MESON) test $(.{prefix}.mtestargs)')
     print(f'{prefix}-report.junit.xml $(all-{prefix}-xml): {prefix}-report%.junit.xml: run-ninja')
     print(f'\t$(MAKE) {prefix}$* MTESTARGS="$(MTESTARGS) --logbase {prefix}-report$*" && ln -f meson-logs/$@ .')
 
-def emit_suite_deps(name, suite, prefix):
+def emit_suite(name, suite, prefix):
     deps = ' '.join(suite.deps)
-    targets = [f'{prefix}-{name}', f'{prefix}-report-{name}.junit.xml', f'{prefix}', f'{prefix}-report.junit.xml',
-               f'{prefix}-build']
-    print()
+    targets = f'{prefix}-{name} {prefix}-report-{name}.junit.xml {prefix} {prefix}-report.junit.xml {prefix}-build'
+    names = ' '.join(suite.names(name))
     print(f'.{prefix}-{name}.deps = {deps}')
-    for t in targets:
-        print(f'.ninja-goals.{t} += $(.{prefix}-{name}.deps)')
-
-def emit_suite(name, suite, prefix):
-    emit_suite_deps(name, suite, prefix)
-    targets = f'{prefix}-{name} {prefix}-report-{name}.junit.xml {prefix} {prefix}-report.junit.xml'
     print(f'ifneq ($(filter {targets}, $(MAKECMDGOALS)),)')
-    print(f'.{prefix}.mtest-suites += ' + ' '.join(suite.names(name)))
+    print(f".{prefix}.mtest-suites += $(call .speed.$(SPEED), {names})")
     print(f'endif')
 
 targets = {t['id']: [os.path.relpath(f) for f in t['filename']]
-- 
2.51.1


