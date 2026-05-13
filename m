Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD65CD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 12:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN8HA-0007ot-26; Wed, 13 May 2026 08:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wN8Gy-0007nA-Dn
 for qemu-devel@nongnu.org; Wed, 13 May 2026 08:01:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wN8Gw-0005DM-Or
 for qemu-devel@nongnu.org; Wed, 13 May 2026 08:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778673665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2BIf89sZ662n1QRfxNQ3tBLRvWVXIBlb4ytM1l3YtWU=;
 b=MMkiKNdpQCGSzkmy3Kf2eqVdiWfAuMn/cwbB+CTccaZgLHoRXw/2dt3+3Q8FRlLPx8Ihjy
 K7jYxgYPB1YA8oezcwFrTOC8XUCp6/FZohPZWrf4ZOgUOYceQ8ziUxxSI8QZ0BZrf3OoL7
 GIvl40+jJ/8vvreiI9sxhNutiMQ4azI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-R7OxXG9hOw2oKEaMN6-v9g-1; Wed,
 13 May 2026 08:01:02 -0400
X-MC-Unique: R7OxXG9hOw2oKEaMN6-v9g-1
X-Mimecast-MFC-AGG-ID: R7OxXG9hOw2oKEaMN6-v9g_1778673660
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30D7C19560AF; Wed, 13 May 2026 12:01:00 +0000 (UTC)
Received: from berrange.com (unknown [10.44.32.213])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C61DF1800349; Wed, 13 May 2026 12:00:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v6 10/16] tests: add nbd and luks to the I/O test suites
Date: Wed, 13 May 2026 12:59:57 +0100
Message-ID: <20260513120003.226790-11-berrange@redhat.com>
In-Reply-To: <20260513120003.226790-1-berrange@redhat.com>
References: <20260513120003.226790-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
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
2.54.0


