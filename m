Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6057FCEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 18:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL4M0-0003YU-AA; Mon, 17 Nov 2025 13:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vL4Kg-0002gn-DO
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 13:52:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vL4Kb-00086W-UP
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 13:52:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763405519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=73hB4rruLtlaA9oNfkLdpOJQcR8UJS/vwLyvnVl/N2Y=;
 b=Gxevbjwohk4F1HxZ8RHdR0yRXVdJjFs9Me7y1r/mfO8EUqwk5HiXfWNSlyqYjMMWbZxp6G
 vVSed6lyv7pkhHxAGJ9MdWBgGGvjOEI7QUHa+L4tPGpE0HxAhkQysCo2n1Ng4HkRFkIHDT
 uOsqn9cJH7iPxngEAr4bg9Ns6MTez6g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-WciM2jUKMSiU1gmxokYDyA-1; Mon,
 17 Nov 2025 13:51:55 -0500
X-MC-Unique: WciM2jUKMSiU1gmxokYDyA-1
X-Mimecast-MFC-AGG-ID: WciM2jUKMSiU1gmxokYDyA_1763405513
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73E03195609E; Mon, 17 Nov 2025 18:51:53 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.81.70])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D68EE180047F; Mon, 17 Nov 2025 18:51:50 +0000 (UTC)
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
Subject: [PATCH 06/22] python/mkvenv: rename 'testdeps' to 'functests'
Date: Mon, 17 Nov 2025 13:51:14 -0500
Message-ID: <20251117185131.953681-7-jsnow@redhat.com>
In-Reply-To: <20251117185131.953681-1-jsnow@redhat.com>
References: <20251117185131.953681-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

pygdbmi is only needed for functional tests and not tests in general; to
prepare for more universally required test dependencies, rename this
dependency group "functests" instead.

In other words: we promise that "make check" will run offline in an
isolated environment, but we do not make the same promises for
functional tests, which require an internet connection.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 pythondeps.toml        | 2 +-
 tests/Makefile.include | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/pythondeps.toml b/pythondeps.toml
index 1657953ff65..d814bb54d08 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -31,6 +31,6 @@ meson = { accepted = ">=1.9.0", installed = "1.9.0", canary = "meson" }
 sphinx = { accepted = ">=3.4.3", installed = "6.2.1", canary = "sphinx-build" }
 sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
 
-[testdeps]
+[functests]
 "qemu.qmp" = { accepted = ">=0.0.5", installed = "0.0.5" }
 pygdbmi = { accepted = ">=0.11.0.0", installed = "0.11.0.0" }
diff --git a/tests/Makefile.include b/tests/Makefile.include
index d4dfbf3716d..6f86eb283d3 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -98,7 +98,7 @@ quiet-venv-pip = $(quiet-@)$(call quiet-command-run, \
 
 $(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
 	$(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
-	$(MKVENV_ENSUREGROUP) $< testdeps
+	$(MKVENV_ENSUREGROUP) $< functests
 	$(call quiet-command, touch $@)
 
 check-venv: $(TESTS_VENV_TOKEN)
-- 
2.51.1


