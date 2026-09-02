Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD192C624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 19:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1qlz-0003T4-QH; Wed, 02 Sep 2026 15:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1qly-0003N3-9k
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 15:37:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1qlw-0004rR-J7
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 15:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788377844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EzLz8ZlEIVzf4Rpt7lLepb9FZzFO03GU8b6FyMgWSxk=;
 b=YSK2w8YNy1+gzTVd5t41lRFt9SqYTapIxe2kjSquPslIjtmRNsHQ4kPZ7lUWz5soUMh4Rg
 r7CEFSsM1AuDHnUbO7dUV2aIbEXQ3pACFOEvhXva24jOtODaZHr/ljaqs6lL3uiy2vt/Qm
 o+IDzxnY5UmY2OF6F/km5VuUPasnxaI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-mWg4dCFWO3GM791v4-wkBw-1; Wed,
 02 Sep 2026 15:37:19 -0400
X-MC-Unique: mWg4dCFWO3GM791v4-wkBw-1
X-Mimecast-MFC-AGG-ID: mWg4dCFWO3GM791v4-wkBw_1788377836
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A55041843AC0; Wed,  2 Sep 2026 19:37:16 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.24])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C742A1800261; Wed,  2 Sep 2026 19:37:11 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Hanna Reitz <hreitz@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Yonggang Luo <luoyonggang@gmail.com>, Warner Losh <imp@bsdimp.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 12/16] python: remove distutils workarounds
Date: Wed,  2 Sep 2026 15:35:47 -0400
Message-ID: <20260902193551.582660-13-jsnow@redhat.com>
In-Reply-To: <20260902193551.582660-1-jsnow@redhat.com>
References: <20260902193551.582660-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

These are no longer necessary now that we are using Python3.12+.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260825215851.1780608-13-jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
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


