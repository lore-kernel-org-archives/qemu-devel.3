Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE93E77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:11:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNa0f-00057t-C0; Tue, 17 Dec 2024 11:01:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNa0G-0004Qx-LJ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:01:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNa0B-0002AC-Fz
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:00:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734451250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2mGODSMuPQz9KoSxfoSlSzJp+nFYF+zH6/PXo6OcUQA=;
 b=Rik4VOFfjMQCqVuC7VgX6eGT8HeKY5lt7k3MYeyXeupKK17S7YnfF1mhRDJVGsP055gqv3
 ovjZPIo5Zazum2+u1Lh8Tlqkau3OWvHbykE7bDNX2BmdCa0yJu3V7V4FvKnFFB6iJJu3pM
 CgH1TBN3U269iqE9KFB1b80O0HzgHNg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-vLSkMs52Ob6KEwrXK4FOmw-1; Tue,
 17 Dec 2024 11:00:46 -0500
X-MC-Unique: vLSkMs52Ob6KEwrXK4FOmw-1
X-Mimecast-MFC-AGG-ID: vLSkMs52Ob6KEwrXK4FOmw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72267195608B; Tue, 17 Dec 2024 16:00:45 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.136])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F162A30044C1; Tue, 17 Dec 2024 16:00:42 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 15/32] tests/functional: remove redundant 'rmtree' call
Date: Tue, 17 Dec 2024 15:59:36 +0000
Message-ID: <20241217155953.3950506-16-berrange@redhat.com>
In-Reply-To: <20241217155953.3950506-1-berrange@redhat.com>
References: <20241217155953.3950506-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

Everything in the scratch directory is automatically purged. Calling
'rmtree' again breaks the ability to optionally preserve the scratch
directory contents.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
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
2.46.0


