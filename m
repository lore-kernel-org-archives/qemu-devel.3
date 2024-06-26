Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987B1C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 23:24:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMbyl-0000j4-Ix; Wed, 26 Jun 2024 19:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMbye-0000fZ-1N
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:23:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMbyc-0002qc-J1
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 19:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719444175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W+eDYLKObbqVZItP4vjcUn2O11vardm1aMAh3d5puPI=;
 b=GQybWYGzC2LTtUo00of2tM5uKObYw7rwHqT7oVbC8hz52lRuhteh1aXITrTzS2GRUWY839
 ZRRvmaZpzQXtoNUMssYIwhasx7DSLaB/o/FJ8sdshdsfwRjZ7O1DG1G0DFgGH6d0BKbJfX
 rgqLCAGe2S+GJv48h+XMMeJXLlsO+ok=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-cQft-yOSP8CfK-wBaYdxXw-1; Wed,
 26 Jun 2024 19:22:51 -0400
X-MC-Unique: cQft-yOSP8CfK-wBaYdxXw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 276431956094; Wed, 26 Jun 2024 23:22:50 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.16.58])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EDF4D1956087; Wed, 26 Jun 2024 23:22:47 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 4/4] python: enable testing for 3.13
Date: Wed, 26 Jun 2024 19:22:30 -0400
Message-ID: <20240626232230.408004-5-jsnow@redhat.com>
In-Reply-To: <20240626232230.408004-1-jsnow@redhat.com>
References: <20240626232230.408004-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Python 3.13 is in beta and Fedora 41 is preparing to make it the default
system interpreter; enable testing for it.

(In the event problems develop prior to release, it should only impact
the check-python-tox job, which is not run by default and is allowed to
fail.)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/setup.cfg                       | 3 ++-
 tests/docker/dockerfiles/python.docker | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/python/setup.cfg b/python/setup.cfg
index 8ebd345d7ed..3b4e2cc5501 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -19,6 +19,7 @@ classifiers =
     Programming Language :: Python :: 3.10
     Programming Language :: Python :: 3.11
     Programming Language :: Python :: 3.12
+    Programming Language :: Python :: 3.13
     Typing :: Typed
 
 [options]
@@ -184,7 +185,7 @@ multi_line_output=3
 # of python available on your system to run this test.
 
 [tox:tox]
-envlist = py38, py39, py310, py311, py312
+envlist = py38, py39, py310, py311, py312, py313
 skip_missing_interpreters = true
 
 [testenv]
diff --git a/tests/docker/dockerfiles/python.docker b/tests/docker/dockerfiles/python.docker
index a3c1321190c..8f0af9ef25f 100644
--- a/tests/docker/dockerfiles/python.docker
+++ b/tests/docker/dockerfiles/python.docker
@@ -14,6 +14,7 @@ ENV PACKAGES \
     python3.10 \
     python3.11 \
     python3.12 \
+    python3.13 \
     python3.8 \
     python3.9
 
-- 
2.45.0


