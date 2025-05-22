Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7220C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 08:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI0sj-0004zv-5t; Thu, 22 May 2025 04:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uI0sg-0004z9-AM
 for qemu-devel@nongnu.org; Thu, 22 May 2025 04:02:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uI0se-0002FJ-20
 for qemu-devel@nongnu.org; Thu, 22 May 2025 04:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747900937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UEYdkAKctIAjeeQfitQeAQ0/9XxnYyt9cKf+u8drrzY=;
 b=YILQoANAmp8krNx9FJENvavSbvhtUENuyVxfOHXDlPyvc1dOPmAOf7gZvPr2CsK/OORoF7
 ikd82KFCfSbWN3jfxe4D0jd6RErNmMrDeqvBoYvNuQ0aBbAbvmv/BytQF2SkcbjMUBL7M8
 UDOwjmJyIMpod6pJNrXyVEicoEKtxPE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-DyMZaSGnPBiM4Jy2mHuKCA-1; Thu,
 22 May 2025 04:02:14 -0400
X-MC-Unique: DyMZaSGnPBiM4Jy2mHuKCA-1
X-Mimecast-MFC-AGG-ID: DyMZaSGnPBiM4Jy2mHuKCA_1747900933
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D803118002A5; Thu, 22 May 2025 08:02:12 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.12])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 872A81958014; Thu, 22 May 2025 08:02:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] tests/functional/test_mips_malta: Re-enable the check for the
 PCI host bridge
Date: Thu, 22 May 2025 10:02:08 +0200
Message-ID: <20250522080208.205489-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

The problem with the PCI bridge has been fixed in commit e5894fd6f411c1
("hw/pci-host/gt64120: Fix endianness handling"), so we can enable the
corresponding test again.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_mips_malta.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/functional/test_mips_malta.py b/tests/functional/test_mips_malta.py
index 89b9556f30d..30279f0ff21 100755
--- a/tests/functional/test_mips_malta.py
+++ b/tests/functional/test_mips_malta.py
@@ -80,10 +80,8 @@ def mips_check_wheezy(test, kernel_path, image_path, kernel_command_line,
     exec_command_and_wait_for_pattern(test, 'cat /proc/devices', 'usb')
     exec_command_and_wait_for_pattern(test, 'cat /proc/ioports',
                                       ' : piix4_smbus')
-    # lspci for the host bridge does not work on big endian targets:
-    # https://gitlab.com/qemu-project/qemu/-/issues/2826
-    # exec_command_and_wait_for_pattern(test, 'lspci -d 11ab:4620',
-    #                                   'GT-64120')
+    exec_command_and_wait_for_pattern(test, 'lspci -d 11ab:4620',
+                                      'GT-64120')
     exec_command_and_wait_for_pattern(test,
                                       'cat /sys/bus/i2c/devices/i2c-0/name',
                                       'SMBus PIIX4 adapter')
-- 
2.49.0


