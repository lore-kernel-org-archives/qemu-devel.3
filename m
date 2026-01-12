Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC81CF45CD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 20:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfOie-0007DZ-KZ; Mon, 12 Jan 2026 15:40:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfOid-0007Ch-20
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 15:40:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfOib-0000mc-KC
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 15:40:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768250452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=moAwrK2n49hXREt/lA9q3TgfKecTSkokmei1vTgzCO4=;
 b=eeVAFjmxpcu1u2cDvbFW68rpIh9GpoXeobxJ0AfRzPCN/r6jGUwwCdJMRnBHAniq2ty5hR
 fVWFfHMa8ejXkxjsHpRcUfDeoQrzXbaUTki/p39RQMDCtMv5DwtCNk2oHKn+bawx8XqnRe
 9tHxuzI3YfikIQU7mOcHEVoovhMvKpE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-slRKtakaO1G0OhtJkbOVCA-1; Mon,
 12 Jan 2026 15:40:48 -0500
X-MC-Unique: slRKtakaO1G0OhtJkbOVCA-1
X-Mimecast-MFC-AGG-ID: slRKtakaO1G0OhtJkbOVCA_1768250447
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76CB41956096; Mon, 12 Jan 2026 20:40:47 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.178])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A47C30001A2; Mon, 12 Jan 2026 20:40:44 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 05/13] scripts/mtest2make: ensure output has stable sorting
Date: Mon, 12 Jan 2026 20:40:18 +0000
Message-ID: <20260112204026.710659-6-berrange@redhat.com>
In-Reply-To: <20260112204026.710659-1-berrange@redhat.com>
References: <20260112204026.710659-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
2.52.0


