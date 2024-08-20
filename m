Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E773EC52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 00:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgCfG-0007M6-UB; Mon, 19 Aug 2024 20:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sgCf7-0006RI-Nq
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sgCf6-0003vQ-49
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724113426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=djrLVOxNjhTkJaYMvjaJgjyI+LpTJmogtLtfxxjcqvM=;
 b=HiZw/MLuvKbiylymC74TbYFrxD1xpQBFW/C+pih6LxKvjT8nFlkPFgrhDF8v9D3b6thslt
 KdpZXDFBX+SoVZa8d/npoZohQd85p9l4FuvB2C19EPp8Wj2SrKiwfVWVxOztVEg9sy0XTN
 Ut7Omy6z5vTFAuiXtccGjouuQ8kl4Oo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-EGIJiM86MamjCYN6V2OjaQ-1; Mon,
 19 Aug 2024 20:23:43 -0400
X-MC-Unique: EGIJiM86MamjCYN6V2OjaQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB6A01955D54; Tue, 20 Aug 2024 00:23:42 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.8.20])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 880FA19560A3; Tue, 20 Aug 2024 00:23:40 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 8/8] python/qapi: remove redundant linter configuration
Date: Mon, 19 Aug 2024 20:23:17 -0400
Message-ID: <20240820002318.1380276-9-jsnow@redhat.com>
In-Reply-To: <20240820002318.1380276-1-jsnow@redhat.com>
References: <20240820002318.1380276-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Now that the qemu.qapi module is checked by the standard python tests,
we don't need separate configuration for it anymore.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/qapi/.flake8    |  3 --
 python/qemu/qapi/.isort.cfg |  7 -----
 python/qemu/qapi/mypy.ini   |  4 ---
 python/qemu/qapi/pylintrc   | 61 -------------------------------------
 4 files changed, 75 deletions(-)
 delete mode 100644 python/qemu/qapi/.flake8
 delete mode 100644 python/qemu/qapi/.isort.cfg
 delete mode 100644 python/qemu/qapi/mypy.ini
 delete mode 100644 python/qemu/qapi/pylintrc

diff --git a/python/qemu/qapi/.flake8 b/python/qemu/qapi/.flake8
deleted file mode 100644
index a873ff67309..00000000000
--- a/python/qemu/qapi/.flake8
+++ /dev/null
@@ -1,3 +0,0 @@
-[flake8]
-# Prefer pylint's bare-except checks to flake8's
-extend-ignore = E722
diff --git a/python/qemu/qapi/.isort.cfg b/python/qemu/qapi/.isort.cfg
deleted file mode 100644
index 643caa1fbd6..00000000000
--- a/python/qemu/qapi/.isort.cfg
+++ /dev/null
@@ -1,7 +0,0 @@
-[settings]
-force_grid_wrap=4
-force_sort_within_sections=True
-include_trailing_comma=True
-line_length=72
-lines_after_imports=2
-multi_line_output=3
diff --git a/python/qemu/qapi/mypy.ini b/python/qemu/qapi/mypy.ini
deleted file mode 100644
index 8109470a031..00000000000
--- a/python/qemu/qapi/mypy.ini
+++ /dev/null
@@ -1,4 +0,0 @@
-[mypy]
-strict = True
-disallow_untyped_calls = False
-python_version = 3.8
diff --git a/python/qemu/qapi/pylintrc b/python/qemu/qapi/pylintrc
deleted file mode 100644
index c028a1f9f51..00000000000
--- a/python/qemu/qapi/pylintrc
+++ /dev/null
@@ -1,61 +0,0 @@
-[MASTER]
-
-[MESSAGES CONTROL]
-
-# Disable the message, report, category or checker with the given id(s). You
-# can either give multiple identifiers separated by comma (,) or put this
-# option multiple times (only on the command line, not in the configuration
-# file where it should appear only once). You can also use "--disable=all" to
-# disable everything first and then reenable specific checks. For example, if
-# you want to run only the similarities checker, you can use "--disable=all
-# --enable=similarities". If you want to run only the classes checker, but have
-# no Warning level messages displayed, use "--disable=all --enable=classes
-# --disable=W".
-disable=consider-using-f-string,
-        fixme,
-        missing-docstring,
-        too-many-arguments,
-        too-many-branches,
-        too-many-instance-attributes,
-        too-many-statements,
-        useless-option-value,
-
-[REPORTS]
-
-[REFACTORING]
-
-[MISCELLANEOUS]
-
-[LOGGING]
-
-[BASIC]
-
-# Good variable names regexes, separated by a comma. If names match any regex,
-# they will always be accepted.
-#
-# Suppress complaints about short names.  PEP-8 is cool with them,
-# and so are we.
-good-names-rgxs=^[_a-z][_a-z0-9]?$
-
-[VARIABLES]
-
-[STRING]
-
-[SPELLING]
-
-[FORMAT]
-
-[SIMILARITIES]
-
-# Ignore import statements themselves when computing similarities.
-ignore-imports=yes
-
-[TYPECHECK]
-
-[CLASSES]
-
-[IMPORTS]
-
-[DESIGN]
-
-[EXCEPTIONS]
-- 
2.45.0


