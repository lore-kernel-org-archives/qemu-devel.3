Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D147C982DD
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 20:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7fFm-00037b-7U; Fri, 18 Sep 2026 16:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7fFj-00037F-VR
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 16:32:11 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1x7fFi-0003vt-31
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 16:32:11 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CA74521EE9;
 Fri, 18 Sep 2026 20:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789763524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iIia9LF/FU6W/WcOdcz2d8EjzufmNNdj0WLEnEAJ3Tc=;
 b=Dk+wJ2PDPijxW2LQ+XsZ8jpqGWzS2xt0/mnmMSUpRODpc40wLCOIzKnutlWoLllBAeJ6/z
 VhXY7Dvpjp2hjjHQDdBE8heVgJYgjramxa2BYPbC96DZditL3enVd7ZZJFZP72Po2G5paD
 Cc6fbtBDSqWI26QwjQACEBuxmob7jRI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789763524;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iIia9LF/FU6W/WcOdcz2d8EjzufmNNdj0WLEnEAJ3Tc=;
 b=q+F5OwaxEl1YJEdTsbso0Ytli/gmyJQCA+gh2sfBAY5TH2XvJwJHLFOAI568Sr8WDBrsU2
 Xfk8yLeq+/ipLoBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1789763519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iIia9LF/FU6W/WcOdcz2d8EjzufmNNdj0WLEnEAJ3Tc=;
 b=Qal1hBjVRJYygifvsOpLxYzkNh4FKKe00m/mZAkzsYEAiBN77OTXuT4jpjTtGmeDjBgB5q
 1Vd9xfx6voG1F8MK9De94OxYQXZXgNB0elvwqztzx5o1veEByx6fCoEhaKasyhUqUXXc26
 dnEW63hMAbdx+vkjV6RvAS3vinkIfYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1789763519;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=iIia9LF/FU6W/WcOdcz2d8EjzufmNNdj0WLEnEAJ3Tc=;
 b=cc7i7rKpRS6yohgCGU37MZpu7g0xomgmfNZ1GTMhZOgobZmHyfgQgso54lk/HYE28XNSXN
 YS1AefELk5zDrADA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B99E01348F;
 Fri, 18 Sep 2026 20:31:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +WaBFryfrWpNfgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 18 Sep 2026 20:31:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH] meson: Fix meson suites invocation from make check
Date: Fri, 18 Sep 2026 17:31:52 -0300
Message-ID: <20260918203153.3874488-1-farosas@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.995];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWELVE(0.00)[14]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,mtest2make.py:url,meson.build:url];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

make check is currently by default running tests tagged
"slow". Running make check with no SPEED variable set should be
equivalent to SPEED=quick and run the meson 'quick' test setup, which
explicitly excludes slow tests:

  add_test_setup('quick', exclude_suites: ['slow', 'thorough'] ...

The problem is that the mtest2make.py script is effectively overriding
the "meson test --setup" setting by using --suite which takes
precedence over --setup according to meson documentation.

Fix by excluding suites directly with the "--no-suite" option while
generating Makefile.mtest.

Although the 'exclude_suites' in meson.build are useless for make
check, they still help when running 'meson test' from the
command-line, so keep them around.

For the configure line I'm using:

make check goes from 1100 to 996 tests
make SPEED=slow check stays at 2158 tests
make SPEED=thorough check stays at 2279 tests

(the rest of the test targets look sane, but maintainers please
double-check)

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
- With this change we obviously lose coverage in make check. I suggest
  we use this opportunity to review what gets put in the quick
  suite.

  For migration, I want to keep only the smoke tests in make
  check. I'll send a patch adding them back if this change is
  accepted.

- Some of the suffixes from functional tests could probably be removed
  and rely on having the tests in the proper suite instead. I.e. use
  'slow' instead of 'foobar_slow'.
---
 scripts/mtest2make.py          | 11 +++++++++--
 tests/qemu-iotests/meson.build |  2 +-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index 383ea68b16..a61a83f775 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -26,6 +26,11 @@ def names(self, base):
 .speed.slow = $(sort $(filter-out %-thorough, $1))
 .speed.thorough = $(sort $1)
 
+.speed_exclude_suites.quick = --no-suite slow --no-suite thorough \
+                              --no-suite optional
+.speed_exclude_suites.slow = --no-suite thorough
+.speed_exclude_suites.thorough =
+
 TIMEOUT_MULTIPLIER ?= 1
 .mtestargs = --no-rebuild -t $(TIMEOUT_MULTIPLIER)
 ifneq ($(SPEED), quick)
@@ -34,7 +39,8 @@ def names(self, base):
 .mtestargs += $(subst -j,--num-processes , $(filter-out -j, $(lastword -j1 $(filter -j%, $(MAKEFLAGS)))))
 
 .check.mtestargs = $(MTESTARGS) $(.mtestargs) $(if $(V),--verbose,--print-errorlogs) \
-    $(foreach s, $(sort $(.check.mtest-suites)), --suite $s)
+    $(foreach s, $(sort $(.check.mtest-suites)), --suite $s) \
+    $(.speed_exclude_suites.$(SPEED))
 .bench.mtestargs = $(MTESTARGS) $(.mtestargs) --benchmark --verbose \
     $(foreach s, $(sort $(.bench.mtest-suites)), --suite $s)''')
 
@@ -102,7 +108,8 @@ def emit_suite(name, suite, prefix):
         targets += f' {prefix} {prefix}-report.junit.xml'
     print(f'ifneq ($(filter {targets}, $(MAKECMDGOALS)),)')
     # for the "base" suite possibly add FOO-slow and FOO-thorough
-    print(f".{prefix}.mtest-suites += {name} $(call .speed.$(SPEED), {names})")
+    print(f".{prefix}.mtest-suites += {name} $(call .speed.$(SPEED), {names}) "
+          ".speed_exclude_suites.$(SPEED)")
     print(f'endif')
 
 targets = {t['id']: [os.path.relpath(f) for f in t['filename']]
diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
index 8857f25f29..34cfcdc53b 100644
--- a/tests/qemu-iotests/meson.build
+++ b/tests/qemu-iotests/meson.build
@@ -68,7 +68,7 @@ foreach driver, speed: qemu_iotests_drivers
   endif
 
   # Every driver gets put in the driver specific suite
-  suites = ['block-' + driver + '-optional']
+  suites = ['block-' + driver + '-optional', 'optional']
   # Any driver tagged quick or slow also gets added to slow
   # otherwise its tagged thorough
   if speed != 'thorough'
-- 
2.53.0


