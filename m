Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5650C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 08:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfxxx-0003GX-65; Fri, 01 Mar 2024 03:10:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfxxw-0003GD-86
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 03:10:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfxxu-0006ig-IG
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 03:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709280597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=97I88J03X4Tn2mCOjR7jiHYni6H9/7bqaG4a9uhrtkw=;
 b=FaR2b3Xa2gq/unIWx3mLlJups7A+52HIcf1RNcNVpVt4C+P6NYHmRWyfy7cDn1eICOl9m0
 ISp+C1wN52HfZlvnCOKkDGOPSccnsnje46VoNOPTj1KRjwoMtwbCjLw7Cr73mDH4lb7ijS
 ebpLPloDlQ8E5edssz8lgnT1E0XaoLU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-3nCu1duiPjOYezGHn4sOtA-1; Fri, 01 Mar 2024 03:09:55 -0500
X-MC-Unique: 3nCu1duiPjOYezGHn4sOtA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC9DD106D0CD;
 Fri,  1 Mar 2024 08:09:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3AF3120229D6;
 Fri,  1 Mar 2024 08:09:54 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/6] Misc fixes (libqos vring, Kconfig, TLS io channels, ...)
Date: Fri,  1 Mar 2024 09:09:47 +0100
Message-ID: <20240301080953.66448-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

 Hi Peter!

The following changes since commit c0c6a0e3528b88aaad0b9d333e295707a195587b:

  Merge tag 'migration-next-pull-request' of https://gitlab.com/peterx/qemu into staging (2024-02-28 17:27:10 +0000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-03-01

for you to fetch changes up to 462945cd22d2bcd233401ed3aa167d83a8e35b05:

  chardev/char-socket: Fix TLS io channels sending too much data to the backend (2024-03-01 08:27:33 +0100)

----------------------------------------------------------------
* Fix some bugs in the vring setup of libqos
* Fix GIC settings when using --without-default-devices
* Fix USB PCAP streams on Windows
* Remove temporary files from test-util-sockets
* Fix TLS io channels sending too much data to the backend

----------------------------------------------------------------
Benjamin David Lunt (1):
      hw/usb/bus.c: PCAP adding 0xA in Windows version

Daniel Henrique Barboza (2):
      libqos/virtio.c: init all elems in qvring_indirect_desc_setup()
      libqos/virtio.c: fix 'avail_event' offset in qvring_init()

Thomas Huth (3):
      hw/intc/Kconfig: Fix GIC settings when using "--without-default-devices"
      tests/unit/test-util-sockets: Remove temporary file after test
      chardev/char-socket: Fix TLS io channels sending too much data to the backend

 chardev/char-socket.c          |  6 +++---
 hw/usb/bus.c                   |  5 +++--
 tests/qtest/libqos/virtio.c    | 27 ++++++++++++++++++++-------
 tests/unit/test-util-sockets.c |  1 +
 hw/intc/Kconfig                | 12 ++++++------
 5 files changed, 33 insertions(+), 18 deletions(-)


