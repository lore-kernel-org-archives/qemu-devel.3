Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10590C5AD5A
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 07:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wv8kt-0004FZ-Vu; Sat, 15 Aug 2026 03:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wv8ks-0003yg-1M
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 03:24:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wv8kq-0002mi-GN
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 03:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786778669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9xPDZtddGt+HqKV0ys0ckfdYxdfJ6sGP+LvoSKMYrmE=;
 b=YtcAg9+kqEgT35BGVPPHVSaN2G04sAwaNOHFEIf+BRnywO4lRe0yJrUlW4ayl/gM5Nrjbn
 RokM3rh7upvAl4s5dttx794Q2d4iKcrAegcjYFd3VOjFLH9TXSP2y2h2REABn3E7U2msz7
 RgkRpW9ZTMH/yT1coHyRQD7+rM9fhHo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-RQ7RHOCbO9-bOpvUtl0LZA-1; Sat,
 15 Aug 2026 03:24:26 -0400
X-MC-Unique: RQ7RHOCbO9-bOpvUtl0LZA-1
X-Mimecast-MFC-AGG-ID: RQ7RHOCbO9-bOpvUtl0LZA_1786778665
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B7B53195608D; Sat, 15 Aug 2026 07:24:24 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BC1C430001A2; Sat, 15 Aug 2026 07:24:23 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: th.huth+qemu@posteo.eu,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] tests/functional: fix pylint false positives for cv2 module
Date: Sat, 15 Aug 2026 11:24:21 +0400
Message-ID: <20260815072421.4117291-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.751,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Add generated-members=cv2.* to pylintrc so pylint skips member
checking on the cv2 C extension module, whose members are not
visible to static analysis.

Silence:
2026-08-15 10:42:08,710 - INFO: qemu-test.test_pylint Checking files in /home/elmarco/src/qemu.qom-qapi/tests/functional/arm with pylint
2026-08-15 10:42:10,941 - ERROR: qemu-test.test_pylint "/home/elmarco/src/qemu.qom-qapi/tests/functional/arm/test_integratorcp.py:83: E1101: Module 'cv2' has no 'imread' member (no-member)"

Note: I also tried with extension-pkg-allow-list, but that didn't work
for some reason.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/functional/pylintrc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/functional/pylintrc b/tests/functional/pylintrc
index 949bea611fe4..373aabd6ca3f 100644
--- a/tests/functional/pylintrc
+++ b/tests/functional/pylintrc
@@ -79,6 +79,12 @@ disable=bad-inline-option,
         useless-suppression,
 
 
+[TYPECHECK]
+
+# cv2 is a C extension module whose members are not visible to pylint
+generated-members=cv2.*
+
+
 [SIMILARITIES]
 
 # Minimum lines number of a similarity.
-- 
2.55.0.543.g5ebe2ebe4ea8


