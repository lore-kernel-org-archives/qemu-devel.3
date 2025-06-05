Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7332C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 18:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNFCh-00005g-71; Thu, 05 Jun 2025 14:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uNFCe-000057-El
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 14:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uNFCc-0001Y8-Un
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 14:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749147633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uIEL7At1Y3NnbQwSCu1WOoIPRXsx3kEw5enGJ7P3vag=;
 b=A1mSATvEiBPZQ0snTAp3MlrXjytjEBIqsRrGvcokjEURD5CABHUDnMQBdVx8A6ZCvSVZZ5
 jM3oVI9VEnaECK1tP/jesrASFysPBon8grEvt7yknVS5t+APj7pNHtLSuE2S6GTetinK1+
 lYlzuAtvNFSKeucpQxX2CRfgH4mCmf0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-rvsHXGdUMiOhx1c7PNh2nQ-1; Thu,
 05 Jun 2025 14:20:32 -0400
X-MC-Unique: rvsHXGdUMiOhx1c7PNh2nQ-1
X-Mimecast-MFC-AGG-ID: rvsHXGdUMiOhx1c7PNh2nQ_1749147631
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4675318002BE; Thu,  5 Jun 2025 18:20:31 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.99])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C18321956050; Thu,  5 Jun 2025 18:20:29 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL v2 6/6] qapi: delete un-needed python static analysis configs
Date: Thu,  5 Jun 2025 14:20:14 -0400
Message-ID: <20250605182014.561172-7-jsnow@redhat.com>
In-Reply-To: <20250605182014.561172-1-jsnow@redhat.com>
References: <20250605182014.561172-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since the previous commit, python/setup.cfg applies to scripts/qapi/ as
well.  Configuration files in scripts/qapi/ override python/setup.cfg.

scripts/qapi/.flake8 and scripts/qapi/.isort.cfg actually match
python/setup.cfg exactly, and can go.

The differences between scripts/qapi/mypy.ini and python/setup.cfg are
harmless: namespace_packages being set to True is a requirement for the
PEP420 nested package structure of QEMU but not for scripts/qapi, but
has no effect on type checking the QAPI code. warn_unused_ignores is
used in python/ to be able to target a wide variety of mypy versions;
some of which that have added new ignore categories that are not present
in older versions.

Ultimately, scripts/qapi/mypy.ini can be removed without any real change
in behavior to how mypy enforces type safety there.

The pylint config is being left in place because the settings differ
enough from the python/ directory settings that we need a chit-chat on
how to merge them O:-)

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-id: 20250604200354.459501-7-jsnow@redhat.com
---
 scripts/qapi/.flake8    | 3 ---
 scripts/qapi/.isort.cfg | 7 -------
 scripts/qapi/mypy.ini   | 4 ----
 3 files changed, 14 deletions(-)
 delete mode 100644 scripts/qapi/.flake8
 delete mode 100644 scripts/qapi/.isort.cfg
 delete mode 100644 scripts/qapi/mypy.ini

diff --git a/scripts/qapi/.flake8 b/scripts/qapi/.flake8
deleted file mode 100644
index a873ff67309..00000000000
--- a/scripts/qapi/.flake8
+++ /dev/null
@@ -1,3 +0,0 @@
-[flake8]
-# Prefer pylint's bare-except checks to flake8's
-extend-ignore = E722
diff --git a/scripts/qapi/.isort.cfg b/scripts/qapi/.isort.cfg
deleted file mode 100644
index 643caa1fbd6..00000000000
--- a/scripts/qapi/.isort.cfg
+++ /dev/null
@@ -1,7 +0,0 @@
-[settings]
-force_grid_wrap=4
-force_sort_within_sections=True
-include_trailing_comma=True
-line_length=72
-lines_after_imports=2
-multi_line_output=3
diff --git a/scripts/qapi/mypy.ini b/scripts/qapi/mypy.ini
deleted file mode 100644
index c9dbcec2db0..00000000000
--- a/scripts/qapi/mypy.ini
+++ /dev/null
@@ -1,4 +0,0 @@
-[mypy]
-strict = True
-disallow_untyped_calls = False
-python_version = 3.9
-- 
2.48.1


