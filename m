Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7127CF6499
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 00:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLsMO-0003B3-Gz; Wed, 19 Nov 2025 19:17:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLsMM-0003AD-0T
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 19:17:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLsMK-0007RO-7i
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 19:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763597831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PjrgbpUYfOKsPhYt0zOmS65cEeXV9hjqSMGsw6ts8r8=;
 b=AEsqoCdC8gXXaU6wQnPXrCQjZ1R6KEV0beV+IYm+6Z3bzzTdSimS0rpk8eouA7rOl2+BFo
 7kXXsTk0hM5hpbJ16E3PYK/Sp0s1V68QTyvhA+kpUjVtVgSb0UyMNHeW3V+jVHJR8zqx3F
 cHXLWeJUpVR0pO0tOefG576BFG89Y4o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-R_WGEy4qPPeFwHi6RbEVig-1; Wed, 19 Nov 2025 19:17:09 -0500
X-MC-Unique: R_WGEy4qPPeFwHi6RbEVig-1
X-Mimecast-MFC-AGG-ID: R_WGEy4qPPeFwHi6RbEVig_1763597828
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4775d8428e8so2287925e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 16:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763597828; x=1764202628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PjrgbpUYfOKsPhYt0zOmS65cEeXV9hjqSMGsw6ts8r8=;
 b=A5GgaT9lnXikqjmXKTQOqegL5XIIVCp442EHY1OC4JZD2hY0u5To2Mbl99j1EJ2xKK
 jNi8VhnwteMF6mDNyAGzN3w3/3hy0utt4W0lQHb90997yZR89k8X4luZIWxh1YhAK130
 EX4BSl1zkynYAxWki5xeLVUjZ7iJavkfVpV8dqHCCHsNZgR1QmdDBTK35pRZx0PQzi8v
 CLjh/3rxWO2sUe97a7Ff35Koz2pQRkOxoliSbYaBuWUu5m1Bfsx2M/LGiECKEMsIaBng
 93WVFbgcvzTtc4ADctEp3Vem7Iz9Z59MHQOmudRSjzfcnxvLeH2HBAAxDiV1cY2tL+WF
 BEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763597828; x=1764202628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PjrgbpUYfOKsPhYt0zOmS65cEeXV9hjqSMGsw6ts8r8=;
 b=oKEWTZRVss7a0kzPCrvGJG6FnVQimUd8/CZj+pm6DJQPe7FRmfBUHZ1iFhlde/R13d
 drR+0Z1mShSeUxNEy0RyMqb7Np9c+xjv/2w93Uinjovi3ycytQoz1cawK+UqfuLr9u2/
 4TCrgcCMn+BfNr81g82z6+CCjB7mO1q2xcWbZjWSQXlRW7L14RFbTWpU1xod+PDS+J6h
 AYrSKwOC+1pEUJjbbTI8ajIdV/LC+r7hLJJNHX4E9Ya80zhGnRPq6nYmY1kalJya7PFh
 CrVkD7EI4R7sOO5pMkGZuUQDNS3w9hdlWCIIIgU2EJ8O5wk9mLdj1KydtjbkJWmjMu1I
 tn9Q==
X-Gm-Message-State: AOJu0YxjXxamHxh/HQ2/p2m6PdyD/FaX3e6Mb2e4OZGVOmyVKzkeQLpL
 /fSFaqcAnxD0eurSEhyT7pwSucla5GhoQCyiWlUM+4Ev1oWp6Ezg5pJcUCEeVtzPjHAs+ZJ2WcH
 dibuU3bGEr8pG6wnO7tWy4kIlmCeM0FJSlLxYk7QEIpBbfV/IJSOEzidu/H7GKWfp0T946HFNjA
 q3bWeGukkGz4nj9axJ9SgcLKeGSy8JiYBE0lUPkkn/
X-Gm-Gg: ASbGncslhrxsFsqBAI2N4w4SM+zkpVLpZmgYAPoR/8M89TbwwSDhBbkszEb+vGivo+A
 064wX9LHb2fcMeEhf0ED4QjFtJPGKNjQpgr8DppvE+ktpjkCkwP+fh+pSkOgji7LrbB6HqzBiP/
 4C5ALmOpvS0tIFsVe7dSBccDUl/pNGrRj+QC7yHGGwykAbn6CbrDoGadsBDuoZ+VCaV5NaeLIXH
 wJ5AIDZMSOCDlzd0/L+PtK/aogY0p1dtqoUjQGSLYuVp0f/7kurQ3ScvGcOzYcE7t/Y+1fkOcDl
 hBjN5PzKhWNloHhUti/Aa+Jt+xY5cgWUBYVt3syj9+Vok1o60sfmj1TV8zpq1kLCol0ZXWCLVVt
 bdOKZETPoz9mvk3o3ohEzTr67MEEk+/vub63uLp1IF4ijlPuxajyXoM9jUD2FulGdaIaTmwaPwE
 LFtw0IPwyHmI0cD0c=
X-Received: by 2002:a05:600c:1d26:b0:471:1717:411 with SMTP id
 5b1f17b1804b1-477b9e2bcb6mr3364035e9.24.1763597827624; 
 Wed, 19 Nov 2025 16:17:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGx0xBXdzhYssstaWGDspIPbTnWACy9UO5URc93InfpHidUh/9lE7UG1+Bh7+EnR4fGgmD+tg==
X-Received: by 2002:a05:600c:1d26:b0:471:1717:411 with SMTP id
 5b1f17b1804b1-477b9e2bcb6mr3363825e9.24.1763597827191; 
 Wed, 19 Nov 2025 16:17:07 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477b0faf295sm77236565e9.0.2025.11.19.16.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 16:17:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 07/10] mtest2make: cleanup mtest-suites variables
Date: Thu, 20 Nov 2025 01:16:46 +0100
Message-ID: <20251120001649.1085913-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251120001649.1085913-1-pbonzini@redhat.com>
References: <20251120001649.1085913-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Remove the "--suite" argument from the .*.mtest-suites variables, and
add it only when actually computing the arguments to "meson test".
This makes it possible to set ninja-cmd-goals from the set of suites,
instead of doing it via many different .ninja-goals.* variables.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile              |  4 +++-
 scripts/mtest2make.py | 40 +++++++++++++++++++---------------------
 2 files changed, 22 insertions(+), 22 deletions(-)

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
index 2ef375fc6fb..d7c514243a5 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -8,24 +8,23 @@
 import itertools
 import json
 import os
-import shlex
 import sys
 
 class Suite(object):
     def __init__(self):
         self.deps = set()
-        self.speeds = ['quick']
+        self.speeds = []
 
     def names(self, base):
-        return [base if speed == 'quick' else f'{base}-{speed}' for speed in self.speeds]
+        return [f'{base}-{speed}' for speed in self.speeds]
 
 
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
@@ -34,8 +33,10 @@ def names(self, base):
 endif
 .mtestargs += $(subst -j,--num-processes , $(filter-out -j, $(lastword -j1 $(filter -j%, $(MAKEFLAGS)))))
 
-.check.mtestargs = $(MTESTARGS) $(.mtestargs) $(if $(V),--verbose,--print-errorlogs)
-.bench.mtestargs = $(MTESTARGS) $(.mtestargs) --benchmark --verbose''')
+.check.mtestargs = $(MTESTARGS) $(.mtestargs) $(if $(V),--verbose,--print-errorlogs) \
+    $(foreach s, $(sort $(.check.mtest-suites)), --suite $s)
+.bench.mtestargs = $(MTESTARGS) $(.mtestargs) --benchmark --verbose \
+    $(foreach s, $(sort $(.bench.mtest-suites)), --suite $s)''')
 
 introspect = json.load(sys.stdin)
 
@@ -72,29 +73,26 @@ def emit_prolog(suites, prefix):
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
     print()
     print(f'.{prefix}-{name}.deps = {deps}')
-    for t in targets:
-        print(f'.ninja-goals.{t} += $(.{prefix}-{name}.deps)')
+    print(f'.ninja-goals.check-build += $(.{prefix}-{name}.deps)')
 
-def emit_suite(name, suite, prefix):
-    emit_suite_deps(name, suite, prefix)
-    targets = f'{prefix}-{name} {prefix}-report-{name}.junit.xml {prefix} {prefix}-report.junit.xml'
+    names = ' '.join(suite.names(name))
+    targets = f'{prefix}-{name} {prefix}-report-{name}.junit.xml'
+    if not name.endswith('-slow') and not name.endswith('-thorough'):
+        targets += f' {prefix} {prefix}-report.junit.xml'
     print(f'ifneq ($(filter {targets}, $(MAKECMDGOALS)),)')
-    print(f'.{prefix}.mtest-suites += ' + ' '.join(suite.names(name)))
+    # for the "base" suite possibly add FOO-slow and FOO-thorough
+    print(f".{prefix}.mtest-suites += {name} $(call .speed.$(SPEED), {names})")
     print(f'endif')
 
 targets = {t['id']: [os.path.relpath(f) for f in t['filename']]
-- 
2.51.1


