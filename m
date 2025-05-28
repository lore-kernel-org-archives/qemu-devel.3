Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A15DC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDgV-0005K6-MQ; Wed, 28 May 2025 06:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDg2-0004K1-61
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDfy-0007GE-B2
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748426781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pKqHGGEtL2ZC5OKb/YBObl5/3Ty09dzGQ/zzRLpA4Ns=;
 b=hyhOTHBlWjP+2vu56HQohM8HDongKDSm3S0bbNkKcNxkqU9hH75D2gC4nkU7DZoSPkQ0z1
 oUoOHfMfR2QHckfoev/DdkS9m6kBqcjBQdH8Ca83kvAqgFGxwL+SMqeH1gb65jmUHpO/2M
 ckiWjtUiMJMqCzA3CPd7BYN8kIukRgE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-Qg0-SfDFNFibQ4OdK7SZPg-1; Wed,
 28 May 2025 06:05:18 -0400
X-MC-Unique: Qg0-SfDFNFibQ4OdK7SZPg-1
X-Mimecast-MFC-AGG-ID: Qg0-SfDFNFibQ4OdK7SZPg_1748426717
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 740AF19560B1; Wed, 28 May 2025 10:05:17 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A397180049D; Wed, 28 May 2025 10:05:14 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/27] tests/functional/test_mips_malta: Re-enable the check
 for the PCI host bridge
Date: Wed, 28 May 2025 12:04:42 +0200
Message-ID: <20250528100507.313906-3-thuth@redhat.com>
In-Reply-To: <20250528100507.313906-1-thuth@redhat.com>
References: <20250528100507.313906-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The problem with the PCI bridge has been fixed in commit e5894fd6f411c1
("hw/pci-host/gt64120: Fix endianness handling"), so we can enable the
corresponding test again.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250522080208.205489-1-thuth@redhat.com>
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


