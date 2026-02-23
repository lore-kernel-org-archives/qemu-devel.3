Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D938EC111F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 18:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuagm-0001rZ-7T; Mon, 23 Feb 2026 13:29:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vuage-0001nw-44
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 13:29:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vuagb-0001ds-1w
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 13:29:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771871376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Df1pl0Wn1M5kxPr1OtGI4dKTU/iu/ItSA4mTWFCjhG4=;
 b=dpx9majrr0PIGIUmcmCoRGXb3cjpsz7fqQiBPGhvG0LM3+8WpzC32XcmAhWhKvvvRi4bsN
 Q4/8CsXThiIqvcikkQHGQ0PUeTMRx/7TJqbRE3mpOBcuzz6GoxPYtn6Hn0kOtHfaj8sgM9
 FfELZw+pmAX+ssgUkeybthbhB0QSboc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-V7QftLwYM0OF5rJQ2dgwPw-1; Mon,
 23 Feb 2026 13:29:30 -0500
X-MC-Unique: V7QftLwYM0OF5rJQ2dgwPw-1
X-Mimecast-MFC-AGG-ID: V7QftLwYM0OF5rJQ2dgwPw_1771871368
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58A061956053; Mon, 23 Feb 2026 18:29:28 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.89.212])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 738141955D71; Mon, 23 Feb 2026 18:29:23 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Warner Losh <imp@bsdimp.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Michael Roth <michael.roth@amd.com>, Fabiano Rosas <farosas@suse.de>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 03/19] python/mkvenv: add 'tooling' and 'functests' dependency
 groups
Date: Mon, 23 Feb 2026 13:28:45 -0500
Message-ID: <20260223182902.739189-4-jsnow@redhat.com>
In-Reply-To: <20260223182902.739189-1-jsnow@redhat.com>
References: <20260223182902.739189-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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


