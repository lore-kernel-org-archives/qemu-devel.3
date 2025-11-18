Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DEBCED24E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 10:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLIyC-0006U9-If; Tue, 18 Nov 2025 05:29:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLIy9-0006TZ-OK
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:29:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLIy8-00031U-0p
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:29:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763461791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bFbOc8EhCAx8sad0roTMTN9jJAmTdHbS1Y6Z0xIpBBQ=;
 b=iMX/gupfOaQYbeiatXQX/t7yjO2l4A8P0noFrBb7lYCsTjzHBhuRrHpae1gqHqtATPpNfW
 nR9SnOLotLBdEMkOPjSP9xpVK8rBDvotXI7SI1FoLOvR4ZMDwMLWLTxGdxlLJ0B1eYK5Qt
 ZcZf+QT9ytQmoDTkai+IYhV26CTESVM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-PguL-nNeNoe6JESt6iLhBg-1; Tue, 18 Nov 2025 05:29:50 -0500
X-MC-Unique: PguL-nNeNoe6JESt6iLhBg-1
X-Mimecast-MFC-AGG-ID: PguL-nNeNoe6JESt6iLhBg_1763461789
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b3086a055so3531709f8f.3
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 02:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763461788; x=1764066588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bFbOc8EhCAx8sad0roTMTN9jJAmTdHbS1Y6Z0xIpBBQ=;
 b=a++wBfOSyw3YjoPeaWept3AYpv6G6JTjJ8cz1btJc82sgZMsJPKKX/xZ7nhwEj3qCK
 GhCHzQk6a3j4cBcB31Eh4SF6QOtE0llNEQZWkUwN/lXc001zy82GBTqEy2+a2nOVgaEP
 7KMEkoB0AFQXUoiVDP29bpGg9cVRB1LnJl4fcGmb5wjR5mJOnUdRjxGAl8RVOtnM4uVy
 LHrtWTBvuduribcGhR95ct8u6TeHe/Cj7yA6xrOyaUGixDXkDo/OUlFoFHgh5xvOctCO
 2IOXLjD3AEryLxegmBVpVGw+AR9ySvRWQcKutY8ne4I/ja6TtPVJ+lmG0+uTkEsaiY2E
 YlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763461788; x=1764066588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bFbOc8EhCAx8sad0roTMTN9jJAmTdHbS1Y6Z0xIpBBQ=;
 b=pHksfz4gqJr4hAkMByWQAjWsM31WzDBSOFdgtvgfUMfRzL/AZfVtl+ttojrhrJRPCa
 34QTPbEVSxRVOI/EI5FFn7CFxnMVTG/+kvzGSZFxOdESS57CCB3smd9hFrG/SwWo2tuy
 ZgwJwuavdN2rtsiVdRAXA1jWjjbkHVjlNakfDUVSj+RaMJee/uzdIS831PfDgfshONO+
 aV/VL8eAPNoSELPLWac8z7Enri93rAYofkrpbRUshupz1WoPCv97nmQ8sv+yFAqka4Dg
 8VYtIQHkRbc+BUv7BOJjv4rJcaveY7+8PDS0cdn68XyyBenvrOpECALUY+iix0SRSrY8
 CU7g==
X-Gm-Message-State: AOJu0Yxe82zhbxEmsYYB97qYItUhOLQZ8jcbkOYlim52wPj/BKLXco6o
 dMMWsBRqkX5lHnluSS26QrEjph5rZ5oyMz93nIAHEo1bHZ+mFA9wFgimelJepS5Ynqf43l9a8ma
 bELqNZvAB9hmOBhNGlcWev2xpjJsMiSTB3B8Mja4rTDRuDBrF3ozmX7VQJVlRyl/6qohb5kXk9e
 5McJWzOBI12M8aGMGYQRWd2D7i3rYharabho5g89BH
X-Gm-Gg: ASbGncvLb2iyGcz/4Sqx0ihiYLs8tsiaH4BgsVSJDQKCnsLCPCOqTPvD1J//eZkMZD7
 GDQrd7rdKOX/Wp6TDkvtneNaqb1eZ2zz2Hmo0eZgocaSDLhOQejAK8Yljm5aQFUr2VvQAcns2k/
 FN2AO64S2DVgdzf053wddKW8tGj92knzN55kV552yxveqbJFk7o3M+g8fA8Yb6H49oT/AyrdgkH
 VPy/s/G5T0fJ3XIxI5J7rAoQiorInvwtlp1Wm+le4Wl3mWgcc/VzDV6LhBhkjo9+B3lltBmBkKN
 +u1D3LIGwQQclDUyttHC/I85F7nI+uf4/1O1obcBN71Fjiq5hVVnBwdMEa8gr8YftMTFq1RVbOi
 47ubLedwYePf5qk6mag8d72yS8fDVgLbIPpqCqMItZthabZfFZmSSQIw3YnpK3s/ASvCmOgmcId
 HBile+38wd4LXVMEA=
X-Received: by 2002:a05:6000:1842:b0:42b:3dfb:645f with SMTP id
 ffacd0b85a97d-42b59394e14mr14890715f8f.47.1763461787856; 
 Tue, 18 Nov 2025 02:29:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxM6umTQhEgZK72WnzEFldINH1o88AssGbXSjfTL0sg5RYDSoBuxcNolXRLh8kjPhcIc4QzA==
X-Received: by 2002:a05:6000:1842:b0:42b:3dfb:645f with SMTP id
 ffacd0b85a97d-42b59394e14mr14890686f8f.47.1763461787387; 
 Tue, 18 Nov 2025 02:29:47 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7b12asm31198140f8f.10.2025.11.18.02.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 02:29:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	alex.bennee@linaro.org
Subject: [PATCH v2 1/3] mtest2make: cleanup mtest-suites variables
Date: Tue, 18 Nov 2025 11:29:40 +0100
Message-ID: <20251118102942.551194-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118102942.551194-1-pbonzini@redhat.com>
References: <20251118102942.551194-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile              |  4 +++-
 scripts/mtest2make.py | 40 +++++++++++++++++-----------------------
 2 files changed, 20 insertions(+), 24 deletions(-)

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
index 2ef375fc6fb..891037e1d66 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -14,18 +14,18 @@
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
 
@@ -72,29 +74,21 @@ def emit_prolog(suites, prefix):
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
-    deps = ' '.join(suite.deps)
-    targets = [f'{prefix}-{name}', f'{prefix}-report-{name}.junit.xml', f'{prefix}', f'{prefix}-report.junit.xml',
-               f'{prefix}-build']
-    print()
-    print(f'.{prefix}-{name}.deps = {deps}')
-    for t in targets:
-        print(f'.ninja-goals.{t} += $(.{prefix}-{name}.deps)')
-
 def emit_suite(name, suite, prefix):
-    emit_suite_deps(name, suite, prefix)
-    targets = f'{prefix}-{name} {prefix}-report-{name}.junit.xml {prefix} {prefix}-report.junit.xml'
+    deps = ' '.join(suite.deps)
+    targets = f'{prefix}-{name} {prefix}-report-{name}.junit.xml {prefix} {prefix}-report.junit.xml {prefix}-build'
+    names = ' '.join(suite.names(name))
+    print(f'.{prefix}-{name}.deps = {deps}')
     print(f'ifneq ($(filter {targets}, $(MAKECMDGOALS)),)')
-    print(f'.{prefix}.mtest-suites += ' + ' '.join(suite.names(name)))
+    # for the "base" suite possibly add FOO-slow and FOO-thorough
+    print(f".{prefix}.mtest-suites += {name} $(call .speed.$(SPEED), {names})")
     print(f'endif')
 
 targets = {t['id']: [os.path.relpath(f) for f in t['filename']]
-- 
2.51.1


