Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E7BC83F0A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 08:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZQGa-00054U-0o; Wed, 09 Jul 2025 04:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uZQGX-00050o-NQ
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 04:34:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uZQGU-0007k6-LT
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 04:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752050093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=wp6Ud/TTWndmij6/qTb0kj9z4GSmlCIolF5c4SCAJ0s=;
 b=gt2k1w7vzS/Ww6FKhtHBMrNUKeEyT/ouU/zSkifSh8rZs8mE0HKtmRpxLMLdQtW31TMni5
 /DTiAcWev6CuaGzcNIxt5VqIUXAY6y3IBB7igF9+2UwoY/gqDEiBAxDMM6A/1sH7UmH9mW
 PV7ONM5sR1DcMXDuLYsJDHXlBFhrfJQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-H2lwQX_EP4u_pv0lHCzwCw-1; Wed,
 09 Jul 2025 04:34:50 -0400
X-MC-Unique: H2lwQX_EP4u_pv0lHCzwCw-1
X-Mimecast-MFC-AGG-ID: H2lwQX_EP4u_pv0lHCzwCw_1752050088
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C06318089B7; Wed,  9 Jul 2025 08:34:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.92])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D6BB718003FC; Wed,  9 Jul 2025 08:34:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v2 0/5] pc-bios/s390-ccw: Add "loadparm" and menu for
 pxelinux.cfg network booting
Date: Wed,  9 Jul 2025 10:34:38 +0200
Message-ID: <20250709083443.41574-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Since we're linking the network booting code into the main s390-ccw.img
firmware binary nowadays, we can support the "loadparm" parameter now
quite easily for pxelinux.cfg config files that contain multiple entries,
and also add support for a simple boot menu here.

v2:
- Abort the boot process if loadparm points to an invalid entry instead
  of trying to continue with the default entry

Thomas Huth (5):
  pc-bios/s390-ccw: Allow to select a different pxelinux.cfg entry via
    loadparm
  pc-bios/s390-ccw: Allow up to 31 entries for pxelinux.cfg
  pc-bios/s390-ccw: Make get_boot_index() from menu.c global
  pc-bios/s390-ccw: Add a boot menu for booting via pxelinux.cfg
  tests/functional: Add a test for s390x pxelinux.cfg network booting

 MAINTAINERS                             |   1 +
 pc-bios/s390-ccw/s390-ccw.h             |   1 +
 pc-bios/s390-ccw/menu.c                 |   6 +-
 pc-bios/s390-ccw/netmain.c              |  66 ++++++++++---
 tests/functional/meson.build            |   1 +
 tests/functional/test_s390x_pxelinux.py | 119 ++++++++++++++++++++++++
 6 files changed, 178 insertions(+), 16 deletions(-)
 create mode 100755 tests/functional/test_s390x_pxelinux.py

-- 
2.50.0


