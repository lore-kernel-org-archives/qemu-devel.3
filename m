Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AEFECD6C3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 16:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqCow-0007hr-EW; Wed, 11 Feb 2026 11:12:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vqCou-0007hH-JY
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 11:12:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vqCos-00084O-AR
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 11:12:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770826321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CO6XrO8Xx+79JbE2blr45ReeWQmcG/NdL5eMevDQGiY=;
 b=eMHKH99sI0OVEd+KO4XEwxKdPGTydo0sNC0eZ5Iq6IshNL3i/YFS7JvbcbueYsX/8mJEpJ
 WK/aBjv+goZxDLKhBoi1KpC9J0xtfIrx78hsBNK0W5pGhedyHnDkgJCRJbPLTRQlOiLSnM
 ctAMtI9C3mhHIdtQ5Ew82S4JhQdAA3Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-ncewh4PZPgyEJP1nqTzH3Q-1; Wed,
 11 Feb 2026 11:11:57 -0500
X-MC-Unique: ncewh4PZPgyEJP1nqTzH3Q-1
X-Mimecast-MFC-AGG-ID: ncewh4PZPgyEJP1nqTzH3Q_1770826316
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2132180025A; Wed, 11 Feb 2026 16:11:56 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AC2D11800464; Wed, 11 Feb 2026 16:11:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH] python/setup.py: Drop version checking via pkg_resources
Date: Wed, 11 Feb 2026 17:11:54 +0100
Message-ID: <20260211161154.740256-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

pkg_resources has been dropped from setuptools v82.0 and newer,
so our setup.py script is currently failing there, breaking our CI.
To fix it, switch to a direct version check instead.
While we're at it, also bump the minimum version of setuptools
to v44 now since that is the minimum that might still be in use
on the distros we care about according to:
 https://repology.org/project/python%3Asetuptools/versions

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 No clue whether that version check is fine with all versions of
 setuptools, thus I marked the patch as RFC. At least it survives
 the CI:
 https://gitlab.com/thuth/qemu/-/pipelines/2319359396

 python/setup.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/python/setup.py b/python/setup.py
index c5bc45919a4..ae242ac95ac 100755
--- a/python/setup.py
+++ b/python/setup.py
@@ -7,7 +7,6 @@
 import setuptools
 from setuptools.command import bdist_egg
 import sys
-import pkg_resources
 
 
 class bdist_egg_guard(bdist_egg.bdist_egg):
@@ -30,8 +29,8 @@ def main():
     QEMU tooling installer
     """
 
-    # https://medium.com/@daveshawley/safely-using-setup-cfg-for-metadata-1babbe54c108
-    pkg_resources.require('setuptools>=39.2')
+    if int(setuptools.__version__.split('.')[0]) < 44:
+        raise ModuleNotFoundError('version of setuptools is too old')
 
     setuptools.setup(cmdclass={'bdist_egg': bdist_egg_guard})
 
-- 
2.53.0


