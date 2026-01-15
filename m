Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A99BD33A04
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 16:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgQWW-0007Im-7T; Thu, 15 Jan 2026 11:48:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vgQWS-0007FZ-Pt
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:48:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vgQWR-0003vA-4N
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 11:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768495714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mSqq1fW/DLK5nLvisDx5sBLgdT92CKVAKUFrZDNP1q8=;
 b=dFgmVNtUgd7JAu+c2RlB9PrrRUn9vlNkJFxHfCQ6+Pay0IULecNoRqw03kC9oZNPDifVOI
 4nNJdcr2lY/uAZiObcyEZ8fxh/qAmFRwaKzSxVY8OI2m9ZMoq9Obp0nKk9vqzCNfk7AtPQ
 xdP+tA/O6GH9bfr844m6Bm66qk88DwU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-aouzCRIjN6Cg_DthuHxbxA-1; Thu,
 15 Jan 2026 11:48:33 -0500
X-MC-Unique: aouzCRIjN6Cg_DthuHxbxA-1
X-Mimecast-MFC-AGG-ID: aouzCRIjN6Cg_DthuHxbxA_1768495712
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C18D195606C; Thu, 15 Jan 2026 16:48:32 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.98])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 58F201800665; Thu, 15 Jan 2026 16:48:29 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 09/14] tests: add nbd and luks to the I/O test suites
Date: Thu, 15 Jan 2026 16:47:51 +0000
Message-ID: <20260115164756.799402-10-berrange@redhat.com>
In-Reply-To: <20260115164756.799402-1-berrange@redhat.com>
References: <20260115164756.799402-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

This introduces new suites for running I/O tests on NBD and LUKS
drivers, giving new make targets

 * make check-block-luks
 * make check-block-nbd

as well as adding their tests to 'make check-block SPEED=thorough'

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/devel/testing/main.rst    | 4 ++--
 tests/qemu-iotests/meson.build | 4 +++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index dc4f7202a5..8067d0a3ed 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -233,8 +233,8 @@ to run. A slightly more comprehensive test plan can be run by defining
 ``SPEED=slow``, which enables all tests for the ``qcow2`` and ``raw``
 formats. The most comprehensive test plan can be run by defining
 ``SPEED=thorough``, which enables all available tests for the formats
-``parallels``, ``qcow2``, ``qed``, ``raw``, ``vdi``, ``vhdx``,
-``vmdk``, and ``vpc``.
+``luks``, ``nbd``, ``parallels``, ``qcow2``, ``qed``, ``raw``, ``vdi``,
+``vhdx``, ``vmdk``, and ``vpc``.
 
 Each of formats also has its own dedicated make target, named
 ``make check-block-$FORMAT`` which will run all available tests for
diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
index 66b09d6b97..744d0b6e88 100644
--- a/tests/qemu-iotests/meson.build
+++ b/tests/qemu-iotests/meson.build
@@ -15,12 +15,14 @@ qemu_iotests_env = {'PYTHON': python.full_path()}
 qemu_iotests_formats = {
   'qcow2': 'quick',
   'raw': 'slow',
+  'luks': 'thorough',
+  'nbd': 'thorough',
   'parallels': 'thorough',
   'qed': 'thorough',
   'vdi': 'thorough',
   'vhdx': 'thorough',
   'vmdk': 'thorough',
-  'vpc': 'thorough'
+  'vpc': 'thorough',
 }
 
 foreach k, v : emulators
-- 
2.52.0


