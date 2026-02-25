Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B41A6FD45E5
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 19:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvKYc-000416-W0; Wed, 25 Feb 2026 14:28:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vvKYb-0003zZ-7d
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 14:28:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vvKYZ-0008GM-NC
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 14:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772047703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yrjiJzX7kawJQxlCPO9LFTAyHCqRMhp6v6QNvi9xh94=;
 b=WXDo6DTgsYPTNm0E2Q0ulE/fo3gullw6t7MOriL3FUplc2z+JRLEV6qlKw17gcsX4qbyIC
 prSYDR6CoMKuGpzDSHKMNpL1DALnY5tPZ6j2UO8uXJLBs1Q7Qex80fBDO9UgbDvhhD9EIq
 nFowx2xgbYQyek6zjiM1YnReysuRG40=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-mIsr6UqLO16406Fr1o1BcA-1; Wed,
 25 Feb 2026 14:28:21 -0500
X-MC-Unique: mIsr6UqLO16406Fr1o1BcA-1
X-Mimecast-MFC-AGG-ID: mIsr6UqLO16406Fr1o1BcA_1772047700
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38E881800348; Wed, 25 Feb 2026 19:28:20 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.89.212])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F24A1800666; Wed, 25 Feb 2026 19:28:18 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 4/4] python: add formal python3.14 support and testing
Date: Wed, 25 Feb 2026 14:28:08 -0500
Message-ID: <20260225192808.957477-5-jsnow@redhat.com>
In-Reply-To: <20260225192808.957477-1-jsnow@redhat.com>
References: <20260225192808.957477-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 configure        | 4 ++--
 python/setup.cfg | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index c4837eba2b1..d44e9e86148 100755
--- a/configure
+++ b/configure
@@ -527,8 +527,8 @@ first_python=
 if test -z "${PYTHON}"; then
     # A bare 'python' is traditionally python 2.x, but some distros
     # have it as python 3.x, so check in both places.
-    for binary in python3 python python3.13 python3.12 python3.11 \
-                          python3.10 python3.9 ; do
+    for binary in python3 python python 3.14 python3.13 python3.12 \
+                          python3.11 python3.10 python3.9 ; do
         if has "$binary"; then
             python=$(command -v "$binary")
             if check_py_version "$python"; then
diff --git a/python/setup.cfg b/python/setup.cfg
index e5bf498f0e1..80975933971 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -19,6 +19,7 @@ classifiers =
     Programming Language :: Python :: 3.11
     Programming Language :: Python :: 3.12
     Programming Language :: Python :: 3.13
+    Programming Language :: Python :: 3.14
     Typing :: Typed
 
 [options]
@@ -162,7 +163,7 @@ multi_line_output=3
 # of python available on your system to run this test.
 
 [tox:tox]
-envlist = py39, py310, py311, py312, py313
+envlist = py39, py310, py311, py312, py313, py314
 skip_missing_interpreters = true
 
 [testenv]
-- 
2.53.0


