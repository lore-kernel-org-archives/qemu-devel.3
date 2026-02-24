Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FA0F4BB70
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 18:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuwwf-00039c-ES; Tue, 24 Feb 2026 13:15:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vuwwG-00032V-16
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:15:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vuwwC-00025S-2p
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:15:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771956911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Df1pl0Wn1M5kxPr1OtGI4dKTU/iu/ItSA4mTWFCjhG4=;
 b=ID93jn7OSL+sIv1ppXni9G/5zF+xHOX+/cG2truRiglbFcTm6ykb9m78w4X4S+b295sf/a
 cuqZlzt+pYFdXc4r7beqknJ/L8977oJTGhdrSajK3grFAGVt9RlviV0z5/g0Zo071ISSoG
 N1Ser03QJ8gP8YBP2dmWKptpmzi/0KA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-BbeebjONOGq8G1jCgUVrKw-1; Tue,
 24 Feb 2026 13:15:07 -0500
X-MC-Unique: BbeebjONOGq8G1jCgUVrKw-1
X-Mimecast-MFC-AGG-ID: BbeebjONOGq8G1jCgUVrKw_1771956904
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99A2E1956079; Tue, 24 Feb 2026 18:15:04 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.89.212])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 652501800666; Tue, 24 Feb 2026 18:15:00 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kyle Evans <kevans@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org,
 Li-Wen Hsu <lwhsu@freebsd.org>, Hanna Reitz <hreitz@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 03/19] python/mkvenv: add 'tooling' and 'functests'
 dependency groups
Date: Tue, 24 Feb 2026 13:14:22 -0500
Message-ID: <20260224181440.832943-4-jsnow@redhat.com>
In-Reply-To: <20260224181440.832943-1-jsnow@redhat.com>
References: <20260224181440.832943-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

'tooling' contains depedencies required to run various tools (like
qmp-shell) as well as dependencies required to run "make check", and as
such, we promise that these dependencies can be sourced from the user's
distribution repository or from vendored packages so that "make check"
can be executed offline in an isolated build environment.

In contrast, pygdbmi is only needed for functional tests and not tests
in general; we do not make the same offline/isolated guarantees for
functional tests, and this dependency group is allowed to fetch
dependencies from PyPI at runtime.

For the time being, amend the "check-venv" target to install both
dependency groups, to avoid a duplicate dependency between them. By the
end of this series, however, "check-venv" will be eliminated in favor of
always installing "tooling" at configure time and allowing "functests"
to be installed on-demand as needed by meson/ninja.

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260218213416.674483-5-jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 pythondeps.toml        | 10 +++++++++-
 tests/Makefile.include |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/pythondeps.toml b/pythondeps.toml
index 85220a36426..743e2a8848c 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -31,6 +31,14 @@ meson = { accepted = ">=1.10.0", installed = "1.10.0", canary = "meson" }
 sphinx = { accepted = ">=3.4.3", installed = "6.2.1", canary = "sphinx-build" }
 sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
 
-[testdeps]
+# This test group is for dependencies required to run various tooling
+# and tests that should always be installed at configure time. It should
+# only include dependencies that can be guaranteed via configure from
+# system packages, or python packages we vendor.
+[tooling]
 "qemu.qmp" = { accepted = ">=0.0.5", installed = "0.0.5" }
+
+# This test group is for functional tests, and can include dependencies
+# fetched from PyPI.
+[functests]
 pygdbmi = { accepted = ">=0.11.0.0", installed = "0.11.0.0" }
diff --git a/tests/Makefile.include b/tests/Makefile.include
index be3b78fdfb7..76d77545b71 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -108,7 +108,7 @@ quiet-venv-pip = $(quiet-@)$(call quiet-command-run, \
 
 $(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
 	$(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
-	$(MKVENV_ENSUREGROUP) $< testdeps
+	$(MKVENV_ENSUREGROUP) $< tooling functests
 	$(call quiet-command, touch $@)
 
 check-venv: $(TESTS_VENV_TOKEN)
-- 
2.53.0


