Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30782E7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrwz-0006Wk-PF; Wed, 18 Dec 2024 06:10:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrww-0006W7-Mn
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:10:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrwv-0005KY-9S
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:10:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734520239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aLFfGcN1TsG1nkxaZI89r0GsfPOs6fnrs8HBT44Miqo=;
 b=HJBOStGe99+XfSHhAMrpTG6WuLbQNch8wzpE7DSr1L6tSycISgQvZB+hKKXrP+Uqf2e0Pi
 mxH7DKPIKqMBQMTndKobbhVj5Gq2yTN40GZ8+LJc7hpVRtsf4TKkqo6VWYbt0+kvpzgxbD
 hrwdoEphAZMNTmI8EQHOrCwXIAqUv+w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-xF03mqtsMmaKa791hC73AA-1; Wed,
 18 Dec 2024 06:10:38 -0500
X-MC-Unique: xF03mqtsMmaKa791hC73AA-1
X-Mimecast-MFC-AGG-ID: xF03mqtsMmaKa791hC73AA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F7E41955F0B
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:10:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9FD7C19560AD; Wed, 18 Dec 2024 11:10:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 15/38] tests/functional: remove redundant 'rmtree' call
Date: Wed, 18 Dec 2024 12:09:35 +0100
Message-ID: <20241218110958.226932-16-thuth@redhat.com>
In-Reply-To: <20241218110958.226932-1-thuth@redhat.com>
References: <20241218110958.226932-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

Everything in the scratch directory is automatically purged. Calling
'rmtree' again breaks the ability to optionally preserve the scratch
directory contents.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20241217155953.3950506-16-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_sh4eb_r2d.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tests/functional/test_sh4eb_r2d.py b/tests/functional/test_sh4eb_r2d.py
index b8dadabf3c..c8954c93eb 100755
--- a/tests/functional/test_sh4eb_r2d.py
+++ b/tests/functional/test_sh4eb_r2d.py
@@ -4,8 +4,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import shutil
-
 from qemu_test import LinuxKernelTest, Asset
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test.utils import archive_extract
@@ -26,7 +24,6 @@ def test_sh4eb_r2d(self):
                                                     'initramfs.cpio.gz'),
                            console_index=1, wait_for='Type exit when done')
         exec_command_and_wait_for_pattern(self, 'exit', 'Restarting system')
-        shutil.rmtree(self.scratch_file('sh4eb'))
 
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.47.1


