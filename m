Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9771C44527
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wllOb-0003jW-DS; Mon, 20 Jul 2026 06:38:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wllOW-0003jD-17
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wllOU-0008Fh-0D
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784543919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=g3Sw9l9BSxAk/udltAZf7E9K3+LweeIjLjiVXqWK4PI=;
 b=W7IliFd5WiQI5TcfDYOQtktZrGOTUOPwZpFQQvhtAdA6UjTl6KCZwyVirwjpDL24F1TB1m
 AIVhus/+yZLq2ZYgKnANqk6ZQ/I8Qs1yP+pTKmIyrZarOsAVy4XLPti/qZcUG9UCJHsA2W
 kAHCKL2EJqh6ExGwPP1JyVorQaSKGZw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-e4yxxxC_MOycd_-902OAYg-1; Mon,
 20 Jul 2026 06:38:37 -0400
X-MC-Unique: e4yxxxC_MOycd_-902OAYg-1
X-Mimecast-MFC-AGG-ID: e4yxxxC_MOycd_-902OAYg_1784543917
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D56CA195604C
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 10:38:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.82])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 779D81588; Mon, 20 Jul 2026 10:38:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/7] USB-related bug fixes
Date: Mon, 20 Jul 2026 12:38:26 +0200
Message-ID: <20260720103833.364506-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

 Hi Stefan!

The following changes since commit 5ef0ecc5942ee07bb581cc96a97bbfc0fdf4005c:

  Merge tag 'hw-misc-20260714' of https://github.com/philmd/qemu into staging (2026-07-17 10:01:52 +0100)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2026-07-20

for you to fetch changes up to cc479aa89743655a725ce29328bcd0585a65983a:

  hw/usb/hcd-xhci-sysbus: Fix OOB heap access in xhci_sysbus_intr_raise() (2026-07-20 11:27:52 +0200)

----------------------------------------------------------------
* Fixes for various USB-related bugs

----------------------------------------------------------------
Feifan Qian (1):
      hw/usb/xhci: clamp interval exponent to avoid UB shift in xhci_init_epctx()

Marc-André Lureau (2):
      usbredir: fix use-after-free on buffered bulk packet overflow
      usbredir: fix infinite loop and SIGFPE with zero max_packet_size

Thomas Huth (2):
      hw/usb/hcd-xhci: Fix guest-triggerable assert() in xhci_find_stream()
      hw/usb/hcd-xhci-sysbus: Fix OOB heap access in xhci_sysbus_intr_raise()

Xiangfeng Cai (2):
      hw/usb/hcd-xhci-pci: break host link cycle so device_finalize() runs on unplug
      tests/qtest: add xhci-pci unplug finalize regression test

 hw/usb/hcd-xhci-pci.c           | 12 ++++++++
 hw/usb/hcd-xhci-sysbus.c        |  1 +
 hw/usb/hcd-xhci.c               | 22 ++++++++++++--
 hw/usb/redirect.c               | 42 +++++++++++++++++++++++++-
 tests/qtest/usb-hcd-xhci-test.c | 67 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 141 insertions(+), 3 deletions(-)


