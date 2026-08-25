Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A085BC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyzBY-0006Af-Q5; Tue, 25 Aug 2026 18:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyzBW-0006A8-TW
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:59:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyzBV-0000Xa-IW
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787695197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A16i+Q089qOF+B9+OwHpvzilqiyRJD+CauoNwEsH7SU=;
 b=V3ytcZeMb2o7xpnT2M9gCsCSXHSLWySwJKsSx9JyC4W3oEoRaaTvVdlLNg8P0dXRM5tu8k
 WeccK/iWPWTq7Yso2WiFZIUdz0dO/RErr2ivQ39psEOPHwcnBiN5MBjaBTRt5LHUHNzXAm
 hpMWTgTBAloGhfvQkbqp+NLW/js8+mo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-2QcJgO2LPIGxJkaD9HQ9sw-1; Tue,
 25 Aug 2026 17:59:53 -0400
X-MC-Unique: 2QcJgO2LPIGxJkaD9HQ9sw-1
X-Mimecast-MFC-AGG-ID: 2QcJgO2LPIGxJkaD9HQ9sw_1787695190
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3A541955DE1; Tue, 25 Aug 2026 21:59:50 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.17])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5927619560AB; Tue, 25 Aug 2026 21:59:46 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Kyle Evans <kevans@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 12/16] python: remove distutils workarounds
Date: Tue, 25 Aug 2026 17:58:47 -0400
Message-ID: <20260825215851.1780608-13-jsnow@redhat.com>
In-Reply-To: <20260825215851.1780608-1-jsnow@redhat.com>
References: <20260825215851.1780608-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

These are no longer necessary now that we are using Python3.12+.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 python/tests/linters.py | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/python/tests/linters.py b/python/tests/linters.py
index 82b88aebb20..dd89fb00ba8 100644
--- a/python/tests/linters.py
+++ b/python/tests/linters.py
@@ -83,23 +83,13 @@ def test_mypy_iotests(self):
             cwd="../tests/qemu-iotests/",
         )
 
-    # Setuptools v60 introduced the SETUPTOOLS_USE_DISTUTILS=stdlib
-    # workaround; stdlib distutils was fully removed in Python
-    # 3.12+. Once we are on >=3.12+ exclusively, this workaround can be
-    # dropped safely. Until then, it is needed for some versions on
-    # Fedora/Debian distributions which relied upon distro-patched
-    # setuptools present in CPython, but not within setuptools itself.
-
     def test_pylint_pkg(self):
-        os.environ["SETUPTOOLS_USE_DISTUTILS"] = "stdlib"
         check_call([sys.executable, "-m", "pylint", "qemu/"])
 
     def test_pylint_scripts(self):
-        os.environ["SETUPTOOLS_USE_DISTUTILS"] = "stdlib"
         check_call([sys.executable, "-m", "pylint", "scripts/"])
 
     def test_pylint_qapi(self):
-        os.environ["SETUPTOOLS_USE_DISTUTILS"] = "stdlib"
         check_call(
             [
                 sys.executable,
@@ -113,7 +103,6 @@ def test_pylint_qapi(self):
         )
 
     def test_pylint_iotests(self):
-        os.environ["SETUPTOOLS_USE_DISTUTILS"] = "stdlib"
         check_call(
             [sys.executable, "-m", "linters", "--pylint"],
             cwd="../tests/qemu-iotests/",
-- 
2.55.0


