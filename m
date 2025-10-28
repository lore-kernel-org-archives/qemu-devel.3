Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9A1CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 22:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDrnZ-0005Ol-PR; Tue, 28 Oct 2025 18:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vDrnW-0005NH-DQ
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 18:04:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vDrnU-0000qs-Cz
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 18:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761689047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S9ONvg4FLEEWdF6/KMxrKY7PqcPckGgIhgyI2F1a6C8=;
 b=VRN/J3DAkCPqnYl0CrHkifBTamzUaCAD1g8bKKWNvJDYBrEebmDUlPmCV/W9BRj3LcDqzR
 UbbnN48PbvwMrchyjo85x38R9lPzfYMoTjWmR57RGoupqy5TBcZCswFYhGTYgHc5MjG+eE
 n2U64CBdzb1ittxT+TmpR+IDtlqRZaE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-MPRYe6tAPCe4HNZ5J1GTFg-1; Tue,
 28 Oct 2025 18:04:04 -0400
X-MC-Unique: MPRYe6tAPCe4HNZ5J1GTFg-1
X-Mimecast-MFC-AGG-ID: MPRYe6tAPCe4HNZ5J1GTFg_1761689043
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3EC3195608D; Tue, 28 Oct 2025 22:04:02 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.120])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D4A3130001A2; Tue, 28 Oct 2025 22:04:00 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH RFC 07/10] meson: create meson custom target for python test
 dependencies
Date: Tue, 28 Oct 2025 18:03:37 -0400
Message-ID: <20251028220342.1407883-8-jsnow@redhat.com>
In-Reply-To: <20251028220342.1407883-1-jsnow@redhat.com>
References: <20251028220342.1407883-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

RFC: I can't actually seem to make this depend on the group file as it
is stored in the pyvenv directory, so the output for this target doesn't
actually exist. Not ideal, but I want to send an RFC to the list before
spending too much time figuring this out.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/meson.build | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/meson.build b/tests/meson.build
index cbe79162411..e61efc21802 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -1,3 +1,18 @@
+pyvenv_test_deps = custom_target(
+    'pyvenv_test_deps',
+    output: 'tests.group',
+    input: files(
+        meson.source_root() + '/pythondeps.toml',
+        meson.source_root() + '/python/scripts/mkvenv.py'
+    ),
+
+    command: [ python, '@INPUT1@',
+               'ensuregroup',
+               '--dir', meson.source_root() + '/python/wheels',
+               '@INPUT0@',
+               'tests' ],
+)
+
 subdir('bench')
 subdir('qemu-iotests')
 
-- 
2.51.0


