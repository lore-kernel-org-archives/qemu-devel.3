Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EACBCF45D1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 20:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfOiU-00078k-1E; Mon, 12 Jan 2026 15:40:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfOiS-00077q-U5
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 15:40:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfOiR-0000lF-FR
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 15:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768250442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vntM9tGb991FfbG3dFd4aFaD0bnLAsf5o3B1BjcLiks=;
 b=Nl6x9eEwMwgcdhzx6sLV8NLUgB1aMn7Pxb3MgQBloKjAJPScCQ3JP1o7nzEH8e7P72/ZPO
 Ocau27nt43BjWlA9V7X42sGr+ejKcwEuHvgAU0+kp658CVB6DIZwA6z9oDmLa58iTMRRoA
 hWnvo6XMEVj6FPImDT750FiUE5C1BxU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-pEdnKOU5PmOXKdwFAmBbng-1; Mon,
 12 Jan 2026 15:40:38 -0500
X-MC-Unique: pEdnKOU5PmOXKdwFAmBbng-1
X-Mimecast-MFC-AGG-ID: pEdnKOU5PmOXKdwFAmBbng_1768250437
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 542DC180035D; Mon, 12 Jan 2026 20:40:37 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.178])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 81DCA30001A2; Mon, 12 Jan 2026 20:40:34 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 02/13] tests: print reason when I/O test is skipped in TAP
 mode
Date: Mon, 12 Jan 2026 20:40:15 +0000
Message-ID: <20260112204026.710659-3-berrange@redhat.com>
In-Reply-To: <20260112204026.710659-1-berrange@redhat.com>
References: <20260112204026.710659-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The TAP output on a skipped test:

  ok raw 181 # SKIP

is not informative.

The test program included a reason, and that should be displayed
in TAP mode (it is already shown in non-TAP mode):

  ok raw 181 # SKIP Postcopy is not supported

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qemu-iotests/testrunner.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
index e2a3658994..dbe2dddc32 100644
--- a/tests/qemu-iotests/testrunner.py
+++ b/tests/qemu-iotests/testrunner.py
@@ -174,7 +174,7 @@ def test_print_one_line(self, test: str,
             elif status == 'fail':
                 print(f'not ok {self.env.imgfmt} {test}')
             elif status == 'not run':
-                print(f'ok {self.env.imgfmt} {test} # SKIP')
+                print(f'ok {self.env.imgfmt} {test} # SKIP {description}')
             return
 
         if lasttime:
-- 
2.52.0


