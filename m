Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B892C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:07:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7sXp-0001ya-Os; Thu, 24 Apr 2025 05:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7sXn-0001xf-62
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:06:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7sXl-0006KV-LN
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745485612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mFzbTippRC7y+ySMoxPWhR+sIveo+jZVf5hQiCfrEMU=;
 b=chcNdIRUa/yWMBhXvTR/bjstpueZgUxORphps34sez5N+bKJsCOvhjOScKMmKooS8tWNhJ
 bPf6CZGZ0hItth9BlHlWAVZxAADlLjj4XsKOsE/3UpSjJsiIjZTR9/dFc87RLA9dIbNj9y
 C9VdRzS8DzWKvSWjEheZPv+IH97//mo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-gdMbtTw1MHmp0_K_Bc-mLw-1; Thu,
 24 Apr 2025 05:06:48 -0400
X-MC-Unique: gdMbtTw1MHmp0_K_Bc-mLw-1
X-Mimecast-MFC-AGG-ID: gdMbtTw1MHmp0_K_Bc-mLw_1745485606
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F57A19560BB; Thu, 24 Apr 2025 09:06:46 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.162])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D9AAF1956095; Thu, 24 Apr 2025 09:06:42 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, qemu-s390x@nongnu.org
Subject: [PATCH] tests/functional/test_s390x_tuxrun: Check whether the machine
 is available
Date: Thu, 24 Apr 2025 11:06:40 +0200
Message-ID: <20250424090640.664217-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The s390x tuxrun test lacks the call to self.set_machine(), so this
test is currently failing in case the 's390-ccw-virtio' machine has
not been compiled into the binary. Add the check now to fix it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_s390x_tuxrun.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/test_s390x_tuxrun.py b/tests/functional/test_s390x_tuxrun.py
index a7db4bfd841..8df3c6893b7 100755
--- a/tests/functional/test_s390x_tuxrun.py
+++ b/tests/functional/test_s390x_tuxrun.py
@@ -24,6 +24,7 @@ class TuxRunS390xTest(TuxRunBaselineTest):
         'bff7971fc2fef56372d98afe4557b82fd0a785a241e44c29b058e577ad1bbb44')
 
     def test_s390(self):
+        self.set_machine('s390-ccw-virtio')
         self.wait_for_shutdown=False
         self.common_tuxrun(kernel_asset=self.ASSET_S390X_KERNEL,
                            rootfs_asset=self.ASSET_S390X_ROOTFS,
-- 
2.49.0


