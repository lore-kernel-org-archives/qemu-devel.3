Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 705C1C5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 15:21:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL1YC-0000OX-0c; Fri, 30 May 2025 11:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uL1Y0-0000Is-CA
 for qemu-devel@nongnu.org; Fri, 30 May 2025 11:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uL1Xy-0003q2-F2
 for qemu-devel@nongnu.org; Fri, 30 May 2025 11:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748618484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+TIOqHdGd37nij8UEFn2vMxGx9WmZiiwPGflV03O2D8=;
 b=CE+7PeW6MGdwSSmNvY63A6IjQ3X8CzB2saFn9jL33ptiNSGB3/S965pBPWyhvaivGplZDj
 bnU5K4JkvYOdT63uqpaCKg5evpN0jhaYnFzuxIVgzBB/rYQ0m5b2i8eKkL+R7ScEEQr2mp
 p6C8Wohagr+B98w7M6rNoqQ5asxoSP8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-Kq3qiwwJMJaQLlo9r6sn0Q-1; Fri,
 30 May 2025 11:21:22 -0400
X-MC-Unique: Kq3qiwwJMJaQLlo9r6sn0Q-1
X-Mimecast-MFC-AGG-ID: Kq3qiwwJMJaQLlo9r6sn0Q_1748618481
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 972F61955DAB; Fri, 30 May 2025 15:21:21 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.173])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ECA901954191; Fri, 30 May 2025 15:21:19 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cole Robinson <crobinso@redhat.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] pc-bios: ensure installed ROMs don't have execute permissions
Date: Fri, 30 May 2025 16:21:18 +0100
Message-ID: <20250530152118.65030-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

We have been inconsistent about whether ROMS stored in git have
execute permission set, and by default meson will preserve source
file permissions when installing files. This has caused periodic
problems in RPM packaging as executable binary files get analysed
by various tools/linters, which can trip up on the ROMs.

Tell meson explicitly that all the ROMs should be without execute
permission when installed.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 pc-bios/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 79bb2e1800..3c41620044 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -88,7 +88,7 @@ blobs = [
 ]
 
 if get_option('install_blobs')
-  install_data(blobs, install_dir: qemu_datadir)
+  install_data(blobs, install_dir: qemu_datadir, install_mode: 'rw-r--r--')
 endif
 
 subdir('descriptors')
-- 
2.49.0


