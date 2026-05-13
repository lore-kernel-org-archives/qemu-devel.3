Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E549CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 12:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN8Gw-0007lY-BV; Wed, 13 May 2026 08:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wN8Gr-0007eF-FF
 for qemu-devel@nongnu.org; Wed, 13 May 2026 08:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wN8Gn-00054x-Uc
 for qemu-devel@nongnu.org; Wed, 13 May 2026 08:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778673657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f4dniefs7i/FGYXJMFZcCzJjOAvubeg6LqibDGQiwH8=;
 b=QAHP7TNMuPeVj2j7bs68YWbZIN+T6AmDAY1YLlZ/21Asj4DUecy/np7Fox7Pj0rm0Dpq6p
 UJAN+BY/CryQRMV93lo26sawJHLLuyuUmPoFbi9uS7JVkr4vsm/ETeP2c1AwUd4fqoxJw0
 VXYeMDJavnsQIkvk9lRCSEhDZ7rtbFk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-WRFAOhvXO8Ka9LXMWYgSaw-1; Wed,
 13 May 2026 08:00:46 -0400
X-MC-Unique: WRFAOhvXO8Ka9LXMWYgSaw-1
X-Mimecast-MFC-AGG-ID: WRFAOhvXO8Ka9LXMWYgSaw_1778673645
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1F8F19560B4; Wed, 13 May 2026 12:00:45 +0000 (UTC)
Received: from berrange.com (unknown [10.44.32.213])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 96F37180056E; Wed, 13 May 2026 12:00:40 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v6 07/16] scripts/mtest2make: support optional tests grouping
Date: Wed, 13 May 2026 12:59:54 +0100
Message-ID: <20260513120003.226790-8-berrange@redhat.com>
In-Reply-To: <20260513120003.226790-1-berrange@redhat.com>
References: <20260513120003.226790-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Currently tests can be classified into three speed groups depending on
whether the meson suite name ends in '-slow' or '-thorough' or neither.

This gets turned into make targets that match the name of the meson
suite, with the speed suffix stripped. e.g.

 * suite=block ->  'make check-block'
 * suite=block-slow -> 'make check-block SPEED=slow'
 * suite=block-thorough -> 'make check-block SPEED=thorough'

The set of tests under the "thorough" speed, however, can get rather
large and it would be useful to have a way to expose further make
targets for directly running a particular subset of tests.

This needs a way to run a target without requiring the SPEED variable,
while also not having them enabled by default as if they were 'quick'
tests.

This modifies mtest2make.py to support this idea by allowing for a new
suffix '-optional' on a suite. When this is present, a correspondingly
named make target will be created without the '-optional' suffix which
will never be run automatically.

This is intended to be combined with use of other suites. For example,
a single NBD test might be added to two suites, 'block-thorough' and
'block-nbd-optional'.

This would allow running it as part of all the block tests with
'make check-block SPEED=thorough', and as part of a standalone target
'make check-block-nbd'.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/mtest2make.py | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index 915f02d600..383ea68b16 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -22,7 +22,7 @@ def names(self, base):
 print(r'''
 SPEED = quick
 
-.speed.quick = $(sort $(filter-out %-slow %-thorough, $1))
+.speed.quick = $(sort $(filter-out %-slow %-thorough %-optional, $1))
 .speed.slow = $(sort $(filter-out %-thorough, $1))
 .speed.thorough = $(sort $1)
 
@@ -66,10 +66,15 @@ def process_tests(test, targets, suites):
             s = s[:-9]
             suites[s].speeds.add('thorough')
 
+def target_name(suite):
+    if suite.endswith('-optional'):
+        return suite[0:-9]
+    return suite
+
 def emit_prolog(suites, prefix):
-    all_targets = ' '.join((f'{prefix}-{k}'
+    all_targets = ' '.join((f'{prefix}-{target_name(k)}'
                             for k in sorted(suites.keys())))
-    all_xml = ' '.join((f'{prefix}-report-{k}.junit.xml'
+    all_xml = ' '.join((f'{prefix}-report-{target_name(k)}.junit.xml'
                         for k in sorted(suites.keys())))
     print()
     print(f'all-{prefix}-targets = {all_targets}')
@@ -83,14 +88,17 @@ def emit_prolog(suites, prefix):
     print(f'\t$(MAKE) {prefix}$* MTESTARGS="$(MTESTARGS) --logbase {prefix}-report$*" && ln -f meson-logs/$@ .')
 
 def emit_suite(name, suite, prefix):
+    tgtname = target_name(name)
     deps = ' '.join(sorted(suite.deps))
     print()
-    print(f'.{prefix}-{name}.deps = {deps}')
-    print(f'.ninja-goals.check-build += $(.{prefix}-{name}.deps)')
+    print(f'.{prefix}-{tgtname}.deps = {deps}')
+    print(f'.ninja-goals.check-build += $(.{prefix}-{tgtname}.deps)')
 
     names = ' '.join(sorted(suite.names(name)))
-    targets = f'{prefix}-{name} {prefix}-report-{name}.junit.xml'
-    if not name.endswith('-slow') and not name.endswith('-thorough'):
+    targets = f'{prefix}-{tgtname} {prefix}-report-{tgtname}.junit.xml'
+    if not name.endswith('-slow') and \
+       not name.endswith('-thorough') and \
+       not name.endswith('-optional'):
         targets += f' {prefix} {prefix}-report.junit.xml'
     print(f'ifneq ($(filter {targets}, $(MAKECMDGOALS)),)')
     # for the "base" suite possibly add FOO-slow and FOO-thorough
-- 
2.54.0


