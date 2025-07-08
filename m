Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08E0C83F0F
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 21:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFCl-0000Iu-Co; Tue, 08 Jul 2025 16:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uZDmB-0003Mi-Cy
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:14:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uZDm3-0006pG-0Y
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752002068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IMm72t6/8YQjf6t2RZM8tuAXHXlcNu8Vyeo7jEBZSYM=;
 b=VenKlZ21oPiCberu8fKfh38024CD1KNvPmUg+zJRJktprxRrGMIDucTFPYfHfdSTWpnFbw
 6SYIe7ZUgaMve/pw25muc/Mh9fHN1P3MHz8mkaY4MqlLnXL52XvP13x2yk2YH8LgpFoklg
 ESawL/D7bR/IucmKKoRxOn8oC2oS9+Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-ZtrVCfGdOTGoptAXC9C3OQ-1; Tue,
 08 Jul 2025 08:56:36 -0400
X-MC-Unique: ZtrVCfGdOTGoptAXC9C3OQ-1
X-Mimecast-MFC-AGG-ID: ZtrVCfGdOTGoptAXC9C3OQ_1751979394
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A98DE18011FB; Tue,  8 Jul 2025 12:56:34 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-196.str.redhat.com
 [10.33.192.196])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4FDC919560AB; Tue,  8 Jul 2025 12:56:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Jared Rossi <jrossi@linux.ibm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 0/5] pc-bios/s390-ccw: Add "loadparm" and menu for
 pxelinux.cfg network booting
Date: Tue,  8 Jul 2025 14:56:25 +0200
Message-ID: <20250708125630.58676-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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
 pc-bios/s390-ccw/netmain.c              |  67 ++++++++++---
 tests/functional/meson.build            |   1 +
 tests/functional/test_s390x_pxelinux.py | 119 ++++++++++++++++++++++++
 6 files changed, 179 insertions(+), 16 deletions(-)
 create mode 100755 tests/functional/test_s390x_pxelinux.py

-- 
2.50.0


