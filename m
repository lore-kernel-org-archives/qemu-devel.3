Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C89CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3nx-00016r-Mx; Thu, 21 May 2026 09:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wQ3nt-00014V-AG
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:51:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wQ3nr-00058T-4u
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779371470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rC1gQ4KCww6UmwMM2Hg5rZTpCm9TVmnOV9UbYZ7eups=;
 b=dtN0+SC6ROcgoUslK0JfTvbhHdfb/7Ylf1dOfTSFWlGW1HH9iqWGRlKY5kxB/XvbSbhYzd
 C+CrdMiARN6ewpIfiq5+CnfQiRZvg8Pk0XcJpzM8w1fDUM8Kb5KUjCcYsG7NcnWqrfSEEH
 5I+Vw+xhYamOd+L+poQjwhxPBOHFh90=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-358-y3fFMxGTP1ec2sqUAgp2Gw-1; Thu,
 21 May 2026 09:51:07 -0400
X-MC-Unique: y3fFMxGTP1ec2sqUAgp2Gw-1
X-Mimecast-MFC-AGG-ID: y3fFMxGTP1ec2sqUAgp2Gw_1779371463
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8D2D19560BA; Thu, 21 May 2026 13:51:03 +0000 (UTC)
Received: from berrange.com (unknown [10.44.33.98])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 329751955F19; Thu, 21 May 2026 13:50:58 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 15/29] iotests: fix check for sudo access in LUKS I/O test
Date: Thu, 21 May 2026 14:49:29 +0100
Message-ID: <20260521134943.1714527-16-berrange@redhat.com>
In-Reply-To: <20260521134943.1714527-1-berrange@redhat.com>
References: <20260521134943.1714527-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

The test did not cope with the possibility that 'sudo' was not installed
at all, merely that it was not configured. This broke tests in any CI
env which lacks 'sudo'.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qemu-iotests/149 | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
index c13343d7ef..6dff39a28a 100755
--- a/tests/qemu-iotests/149
+++ b/tests/qemu-iotests/149
@@ -95,11 +95,14 @@ def verify_passwordless_sudo():
 
     args = ["sudo", "-n", "/bin/true"]
 
-    proc = subprocess.Popen(args,
-                            stdin=subprocess.PIPE,
-                            stdout=subprocess.PIPE,
-                            stderr=subprocess.STDOUT,
-                            universal_newlines=True)
+    try:
+        proc = subprocess.Popen(args,
+                                stdin=subprocess.PIPE,
+                                stdout=subprocess.PIPE,
+                                stderr=subprocess.STDOUT,
+                                universal_newlines=True)
+    except FileNotFoundError as e:
+        iotests.notrun('requires sudo binary: %s' % e)
 
     msg = proc.communicate()[0]
 
-- 
2.54.0


