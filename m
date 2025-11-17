Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E454CEBF61
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 16:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL28R-0007G7-8u; Mon, 17 Nov 2025 11:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vL28M-00079k-OF
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:31:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vL28K-0007gh-Sj
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763397075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2pn8tdgNfLASOvuPWNTWM6oSQ6NEVCBo2XL5ksJU9So=;
 b=M721b6ABKy4vxZ0hK7tAvpwrJ5Ggi8UKvE6IG8gb/y/PsdUnQ3uCK2Nsg6/olZghPkVxQo
 OtqRuG26jkjd09MNNikXPx1VIvEzcZRreeuTZx82zY+M6ah2qk6cp/R2wghBT4aJlF7GF+
 Fys3fq9N5mlneI3WkBlZyrpEdhCivyc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-5Ysr__7aMjOVxPWn-URCbQ-1; Mon, 17 Nov 2025 11:31:13 -0500
X-MC-Unique: 5Ysr__7aMjOVxPWn-URCbQ-1
X-Mimecast-MFC-AGG-ID: 5Ysr__7aMjOVxPWn-URCbQ_1763397072
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-429c76c8a1bso2735847f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 08:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763397071; x=1764001871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2pn8tdgNfLASOvuPWNTWM6oSQ6NEVCBo2XL5ksJU9So=;
 b=TtmLfojDkI+HAsmdlvmEHR0MdrS5DpFOBkuWq3TIdLwzIS1GcWyW6mjUGVmTMYRDqp
 mB1vmmJs/M1PeykqGzPEEvlX/WU/ESiVmj5Sj8uemZZ8Cm2UC+TjlNGNKwwGL9NdkZPa
 Go1xxhSLcH1klKBiByLtnEeRTsP5vxTzG5sHmdt2DAjzNH3hBvBbnPF5X9S8qjr2zD6u
 OQYnWtqqwfEmtmbesX9DR6A2LM5PehPucg3yPIsUYBCyzT++7NJUC2JJ9UcwHXoKzPXR
 ds1g477mBQKIBdU5olVLzritpNmBhCT8K979zXVop6zD2MXbbzNLatzS6o+bTZQuHL7m
 iNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763397071; x=1764001871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2pn8tdgNfLASOvuPWNTWM6oSQ6NEVCBo2XL5ksJU9So=;
 b=hYAvi1CbO+CLpOp9D+Dl9xyUy7DAsfXdcbgDdLSHwkn59PdPWJ4ZXjo5Equ6QbvtN9
 faYNTWzAddh1L0iaezZexZwfaBzd8X66kgivYZdWUQx0nM2bDcpX36G9gwqwBNhQQhSz
 j8gOjCwhKzC6hJ7bic3dOr9yAQ5zReK4Bo+VOV2Nqt08VnrPw53Ni0TQj35jIU4wu7Ch
 3cEBkSfYM3QeefR2CaKC9cFQVwtaaGkIKNDOTzSYPfpiRM8cMk8wk/8UwJbWuu2dZBEv
 +jvj+Kig3VEpWGhggXQnkO5JETdLqA4olZgVcbyK+pXjGDUUENcgkxgrGhqeH1uflFKr
 Ie0A==
X-Gm-Message-State: AOJu0Yx/zYS5y53KSeAziIQrZ0HV6tb07CwF58xe+wYccbMFNdArJiIZ
 X2q556cPpgFsKKw6hCAtCLmqUOMD6e4U44mdD+QQDE2w5CPcOhnw5ctdd7p1mcJtgO7KIlHxa+r
 kvWOYtjAvdsH+J9FkXT9QJ/v35OV/ZRpyHlYrir0p+oNBqDHHbrc8lv5wCwRzlk924uNfdwM/xS
 GQSHT+ISBc/qlm78orKK/7peyuMNcGxHc1vDBtW1Ex
X-Gm-Gg: ASbGnct5zSyeITz5x4SWEMauMYpaRPTx9BH4vj4HAqTogZBpK+4aQlYrZmvT82RZtVm
 aElPX0stfSU+w2vkfCfqHP3WPQeJJw1LOYqp2UBBMVW4O2tBDGPwDeQbM7KNR3CoPBc0VSsluHQ
 vd72kjKlKY2GyIujvIbplXThW2j7lCYp1bZAw5uhs260B6GoP8gqVmPqdtIlBt4/ZoMxoZCMynx
 NN3wkWVlT2Xp9WRXwklhWVtegxWi4psHT9jAMI6fnSH1sBCm7sv+ci+WiIIB3xS9zaGn91yoYdz
 G1nktpQZCe7h20oTGTA2Vj/Kcx/MjEkxMnLfU5Axnq3hdxEIRAl5Kdai8/j2emcPLVH52SrV/s1
 e69MQGU27FIuR38HdxpwvV49F3Huj6M5fnTjEOQielUEXI4scz5v9zbasvE7Vmr90bLdFrOE0zj
 Tx/hcB
X-Received: by 2002:a05:6000:1ace:b0:3ff:17ac:a34b with SMTP id
 ffacd0b85a97d-42b59383b2dmr12854976f8f.42.1763397071195; 
 Mon, 17 Nov 2025 08:31:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLWAqTbjxJLdcShd9EuFkYF7JjwGuWiMRtkrUGAvFY8pM0W623wuE3rMwfbFZ7lqOhyC7x4A==
X-Received: by 2002:a05:6000:1ace:b0:3ff:17ac:a34b with SMTP id
 ffacd0b85a97d-42b59383b2dmr12854948f8f.42.1763397070747; 
 Mon, 17 Nov 2025 08:31:10 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53dea1c9sm27261602f8f.0.2025.11.17.08.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 08:31:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com
Subject: [PATCH 1/3] mtest2make: cleanup mtest-suites variables
Date: Mon, 17 Nov 2025 17:31:05 +0100
Message-ID: <20251117163107.372393-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117163107.372393-1-pbonzini@redhat.com>
References: <20251117163107.372393-1-pbonzini@redhat.com>
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
This makes it possible to look at the set of suites to set ninja-cmd-goals,
instead of doing it via many different .ninja-goals.* variables.

As a bonus, this removes code duplication between emit_suite_deps
and its caller emit_suite.  Since emit_suite_deps would now be one or
two lines of code, integrate it into emit_suite directly.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile              |  4 +++-
 scripts/mtest2make.py | 35 ++++++++++++++---------------------
 2 files changed, 17 insertions(+), 22 deletions(-)

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
+    print(f".{prefix}.mtest-suites += $(call .speed.$(SPEED), {names})")
     print(f'endif')
 
 targets = {t['id']: [os.path.relpath(f) for f in t['filename']]
-- 
2.51.1


