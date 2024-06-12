Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736F7C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNuZ-0008Fr-Ht; Wed, 12 Jun 2024 09:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHNuW-0008Ak-Ao
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:21:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sHNuU-0003ra-No
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:21:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718198465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9OrYmp1+PPajE5yz84/ZfnVk7je9DAqWkH2ebcMnK2s=;
 b=Un+14kIOHl3/rW5+Ab2HyyrkWJbpS/yk5YR6DD453jAuH+Lx+h6dat9DqlMMB4T6Mb5WZb
 sNQ36C+6UKEYya7bVL49S8JZx76Vn8DPO6Zv2BxuhoRSbp/A8d9zRWo3K5yts6Pr2oXCZJ
 QLoUmRN/9spHWWWeBDmUTAMpduqkmfY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-xzBYucCiP-StObfsEJMhIw-1; Wed,
 12 Jun 2024 09:21:04 -0400
X-MC-Unique: xzBYucCiP-StObfsEJMhIw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8AF81954194; Wed, 12 Jun 2024 13:21:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.236])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1CA101956087; Wed, 12 Jun 2024 13:20:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Song Gao <gaosong@loongson.cn>
Subject: [PULL 01/15] tests/avocado: Update LoongArch bios file
Date: Wed, 12 Jun 2024 15:20:41 +0200
Message-ID: <20240612132055.326889-2-thuth@redhat.com>
In-Reply-To: <20240612132055.326889-1-thuth@redhat.com>
References: <20240612132055.326889-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Song Gao <gaosong@loongson.cn>

The VM uses old bios to boot up only 1 cpu, causing the test case to fail.
Update the bios to solve this problem.

Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Message-ID: <20240604030058.2327145-1-gaosong@loongson.cn>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/machine_loongarch.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/avocado/machine_loongarch.py b/tests/avocado/machine_loongarch.py
index 7d8a3c1fa5..8de308f2d6 100644
--- a/tests/avocado/machine_loongarch.py
+++ b/tests/avocado/machine_loongarch.py
@@ -27,18 +27,18 @@ def test_loongarch64_devices(self):
         """
 
         kernel_url = ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
-                      'releases/download/binary-files/vmlinuz.efi')
+                      'releases/download/2024-05-30/vmlinuz.efi')
         kernel_hash = '951b485b16e3788b6db03a3e1793c067009e31a2'
         kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
 
         initrd_url = ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
-                      'releases/download/binary-files/ramdisk')
+                      'releases/download/2024-05-30/ramdisk')
         initrd_hash = 'c67658d9b2a447ce7db2f73ba3d373c9b2b90ab2'
         initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
 
         bios_url = ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
-                    'releases/download/binary-files/QEMU_EFI.fd')
-        bios_hash = ('dfc1bfba4853cd763b9d392d0031827e8addbca8')
+                    'releases/download/2024-05-30/QEMU_EFI.fd')
+        bios_hash = ('f4d0966b5117d4cd82327c050dd668741046be69')
         bios_path = self.fetch_asset(bios_url, asset_hash=bios_hash)
 
         self.vm.set_console()
-- 
2.45.2


