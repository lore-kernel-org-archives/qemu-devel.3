Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B043ECD6E7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 19:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqGLs-0003UA-HE; Wed, 11 Feb 2026 14:58:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vqGLp-0003TP-Up
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 14:58:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vqGLo-00054X-AA
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 14:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770839895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MS/4p2aXhYbXAZ2P5wjXGZgEqN07QCUXCQHLkGGoX/k=;
 b=XyMHy4A/QBfssXEmQrymr46KA4PAD6VwlO//3T4Q5b6dQMdvAgIBV2qLmAq173Hs0Jp+Q/
 PmYJeMLt1b9jBPl2GNLedksUPjmfd3tCsA730M5Z1oAaT7zc2UC8BPtt4Hr8eetg4PSwx7
 BNtf5MX1aNGK1+zrHUzbvAzlZ/bvMS0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-zMogDC8MPgCnCnj_JwgDhQ-1; Wed,
 11 Feb 2026 14:58:12 -0500
X-MC-Unique: zMogDC8MPgCnCnj_JwgDhQ-1
X-Mimecast-MFC-AGG-ID: zMogDC8MPgCnCnj_JwgDhQ_1770839891
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 495F21955F05; Wed, 11 Feb 2026 19:58:11 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.82.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1939B19560A7; Wed, 11 Feb 2026 19:58:09 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 2/2] python: drop uses of pkg_resources
Date: Wed, 11 Feb 2026 14:58:04 -0500
Message-ID: <20260211195804.135144-3-jsnow@redhat.com>
In-Reply-To: <20260211195804.135144-1-jsnow@redhat.com>
References: <20260211195804.135144-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

pkg_resources has been fully dropped from modern pip/setuptools
distributions and we should phase out its use. This patch is enough to,
by itself, repair most GitLab CI tests upstream; with the exception of
tox tests which are still making use of avocado - which will be dropped
in a separate series to restore functionality there.

Signed-off-by: John Snow <jsnow@redhat.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
---
 python/setup.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/python/setup.py b/python/setup.py
index c5bc45919a4..789fa39b0ff 100755
--- a/python/setup.py
+++ b/python/setup.py
@@ -7,7 +7,6 @@
 import setuptools
 from setuptools.command import bdist_egg
 import sys
-import pkg_resources
 
 
 class bdist_egg_guard(bdist_egg.bdist_egg):
@@ -30,9 +29,6 @@ def main():
     QEMU tooling installer
     """
 
-    # https://medium.com/@daveshawley/safely-using-setup-cfg-for-metadata-1babbe54c108
-    pkg_resources.require('setuptools>=39.2')
-
     setuptools.setup(cmdclass={'bdist_egg': bdist_egg_guard})
 
 
-- 
2.53.0


