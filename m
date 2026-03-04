Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D36CEF8FEA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 14:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxn7H-00005s-Iq; Wed, 04 Mar 2026 09:22:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxn72-00084U-BG
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 09:22:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vxn70-0006BW-R8
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 09:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772634126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MndI2TDLfJqvtsbee96/8Sl0n8ieTPjrzvQ8vfGF7Jw=;
 b=fMxdGTJoasd6DvDwvFBuP40w6JFLF/7z+KwElZyWJyl8Mq9CMflXOmG5b04ZAG7fqCt+LH
 gTvH1kQ2l34q+/vnWgogDAtiTcSDYue02IA7I/IjKd0l/FgJkKLWmkp6uTNZNNSEKREkPC
 ZdXBew1CibfQTiCpNHy+QXNpeNho/FQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-5eIfAhJRNYa49tapWI84xA-1; Wed,
 04 Mar 2026 09:22:03 -0500
X-MC-Unique: 5eIfAhJRNYa49tapWI84xA-1
X-Mimecast-MFC-AGG-ID: 5eIfAhJRNYa49tapWI84xA_1772634122
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1759719560AE; Wed,  4 Mar 2026 14:22:02 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.44.34.75])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A9C31958DC2; Wed,  4 Mar 2026 14:21:57 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v5 08/15] docs/devel/testing: expand documentation for 'make
 check-block'
Date: Wed,  4 Mar 2026 14:21:13 +0000
Message-ID: <20260304142120.2635617-9-berrange@redhat.com>
In-Reply-To: <20260304142120.2635617-1-berrange@redhat.com>
References: <20260304142120.2635617-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 33
X-Spam_score: 3.3
X-Spam_bar: +++
X-Spam_report: (3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_PASS=-0.001,
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

Explain in greater detail what 'check-block' will run for each format,
and also document the new format specific targets.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/devel/testing/main.rst    | 25 ++++++++++++++++++++++---
 tests/qemu-iotests/meson.build |  2 ++
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
index 0662766b5c..dc4f7202a5 100644
--- a/docs/devel/testing/main.rst
+++ b/docs/devel/testing/main.rst
@@ -221,9 +221,28 @@ same commit that alters the generator code.
 check-block
 ~~~~~~~~~~~
 
-``make check-block`` runs a subset of the block layer iotests (the tests that
-are in the "auto" group).
-See the "QEMU iotests" section below for more information.
+There are a variety of ways to exercise the block layer I/O tests
+via make targets.
+
+A default ``make check`` or ``make check-block`` command will exercise
+the ``qcow2`` format, using the tests tagged into the ``auto`` group
+only.
+
+These targets accept the ``SPEED`` variable to augment the set of tests
+to run. A slightly more comprehensive test plan can be run by defining
+``SPEED=slow``, which enables all tests for the ``qcow2`` and ``raw``
+formats. The most comprehensive test plan can be run by defining
+``SPEED=thorough``, which enables all available tests for the formats
+``parallels``, ``qcow2``, ``qed``, ``raw``, ``vdi``, ``vhdx``,
+``vmdk``, and ``vpc``.
+
+Each of formats also has its own dedicated make target, named
+``make check-block-$FORMAT`` which will run all available tests for
+the designated format and does not require the ``SPEED`` variable
+to be set.
+
+See the "QEMU iotests" section below for more information on the
+block I/O test framework that is leveraged by these ``make`` targets.
 
 .. _qemu-iotests:
 
diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
index 16a5e39476..66b09d6b97 100644
--- a/tests/qemu-iotests/meson.build
+++ b/tests/qemu-iotests/meson.build
@@ -10,6 +10,8 @@ endif
 
 qemu_iotests_binaries = [qemu_img, qemu_io, qemu_nbd, qsd]
 qemu_iotests_env = {'PYTHON': python.full_path()}
+# If altering this definition, also update docs/devel/testing/main.rst
+# section on 'check-block' targets to reflect the changes
 qemu_iotests_formats = {
   'qcow2': 'quick',
   'raw': 'slow',
-- 
2.53.0


