Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33341CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 18:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL4MO-000424-NY; Mon, 17 Nov 2025 13:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vL4Ks-0002k5-Vr
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 13:52:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vL4Kq-0008AD-M4
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 13:52:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763405540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VbYkG+U0X52W7QPAk+stT3R0B5yCs3OAw72+kWHIJsc=;
 b=gZ5z2CzkqAdskkjqcdDcaIjl8seJu/t5cg2SsbAIvEu6QXSUpiCAXItsjUGKARvPvH0/X9
 2DsrkTGlSCsfHewbA9i6GVa0BV1YHdxDbtEi02ixahnhhXUdNyyHkC/wncX2Ddg73dQOaF
 4FMWf8HowncV10dTskM1GdwKDcproH8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-ez-8gUVUOuC2ImNDH1V6FQ-1; Mon,
 17 Nov 2025 13:52:18 -0500
X-MC-Unique: ez-8gUVUOuC2ImNDH1V6FQ-1
X-Mimecast-MFC-AGG-ID: ez-8gUVUOuC2ImNDH1V6FQ_1763405537
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 234A61800473; Mon, 17 Nov 2025 18:52:17 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.81.70])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B36CC180047F; Mon, 17 Nov 2025 18:52:14 +0000 (UTC)
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
Subject: [PATCH 14/22] mtest2make: add dependencies to the "speed-qualified"
 suite
Date: Mon, 17 Nov 2025 13:51:22 -0500
Message-ID: <20251117185131.953681-15-jsnow@redhat.com>
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

From: Paolo Bonzini <pbonzini@redhat.com>

Thorough tests may have more dependencies than faster ones.
Dependencies are now looked up based on the suites being
executed, not on the suites passed as goals to the makefile.
Therefore, it is possible to limit dependencies to the
speeds that need them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/mtest2make.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index af4ee56de54..d32eef2f7f4 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -59,13 +59,13 @@ def process_tests(test, targets, suites):
             s = s.split(':')[1]
             if s == 'slow' or s == 'thorough':
                 continue
+        suites[s].deps.update(deps)
         if s.endswith('-slow'):
             s = s[:-5]
             suites[s].speeds.append('slow')
         if s.endswith('-thorough'):
             s = s[:-9]
             suites[s].speeds.append('thorough')
-        suites[s].deps.update(deps)
 
 def emit_prolog(suites, prefix):
     all_targets = ' '.join((f'{prefix}-{k}' for k in suites.keys()))
-- 
2.51.1


