Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3CAFED3EA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGIgl-0003Pr-6h; Fri, 24 Apr 2026 11:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wGIg3-0002rZ-8a
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:42:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wGIfx-0007PC-Oc
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777045359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1tyVY+9RbGGWWtSVonpKjtbnK9dfRp81yNB473fze34=;
 b=hlDNrft+MmjLf9HMvlc0Kqd5ekF2iupgL4XRWqABL6Qa+tyXfAceMp9k/jKql2bSCJxYvR
 Jbs1tDzN5uU9TPnA9yZXjwYnJpzqQLsgYXkXNbBvDktuUzsvugYI3A4MldU54ahdAQPNXY
 bPAXabZ4igyxkdUfVmr+AJy20Xd//nk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-p6RsfnBJP0m1KJ0nRTjhmQ-1; Fri,
 24 Apr 2026 11:42:35 -0400
X-MC-Unique: p6RsfnBJP0m1KJ0nRTjhmQ-1
X-Mimecast-MFC-AGG-ID: p6RsfnBJP0m1KJ0nRTjhmQ_1777045354
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6630618002C0; Fri, 24 Apr 2026 15:42:34 +0000 (UTC)
Received: from thinkbook.redhat.com (unknown [10.44.32.213])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D1FED180047F; Fri, 24 Apr 2026 15:42:30 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 06/16] scripts/mtest2make: ensure output has stable sorting
Date: Fri, 24 Apr 2026 16:41:54 +0100
Message-ID: <20260424154205.364268-7-berrange@redhat.com>
In-Reply-To: <20260424154205.364268-1-berrange@redhat.com>
References: <20260424154205.364268-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When debugging mtest2make.py changes it is important to be able to
compare the old and new output. This requires that any lists in the
output have stable sort ordering.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/mtest2make.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index 4b252defc3..915f02d600 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -67,8 +67,10 @@ def process_tests(test, targets, suites):
             suites[s].speeds.add('thorough')
 
 def emit_prolog(suites, prefix):
-    all_targets = ' '.join((f'{prefix}-{k}' for k in suites.keys()))
-    all_xml = ' '.join((f'{prefix}-report-{k}.junit.xml' for k in suites.keys()))
+    all_targets = ' '.join((f'{prefix}-{k}'
+                            for k in sorted(suites.keys())))
+    all_xml = ' '.join((f'{prefix}-report-{k}.junit.xml'
+                        for k in sorted(suites.keys())))
     print()
     print(f'all-{prefix}-targets = {all_targets}')
     print(f'all-{prefix}-xml = {all_xml}')
@@ -81,12 +83,12 @@ def emit_prolog(suites, prefix):
     print(f'\t$(MAKE) {prefix}$* MTESTARGS="$(MTESTARGS) --logbase {prefix}-report$*" && ln -f meson-logs/$@ .')
 
 def emit_suite(name, suite, prefix):
-    deps = ' '.join(suite.deps)
+    deps = ' '.join(sorted(suite.deps))
     print()
     print(f'.{prefix}-{name}.deps = {deps}')
     print(f'.ninja-goals.check-build += $(.{prefix}-{name}.deps)')
 
-    names = ' '.join(suite.names(name))
+    names = ' '.join(sorted(suite.names(name)))
     targets = f'{prefix}-{name} {prefix}-report-{name}.junit.xml'
     if not name.endswith('-slow') and not name.endswith('-thorough'):
         targets += f' {prefix} {prefix}-report.junit.xml'
-- 
2.53.0


